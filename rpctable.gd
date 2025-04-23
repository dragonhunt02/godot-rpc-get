class_name RpcClass extends Node2D

func _ready():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(1234)
	multiplayer.multiplayer_peer = peer

  # Both rpcs are called
	rpc_id(1, "test1")
	rpc_id(1, "test2")

  # Return dictionary is empty but rpc are annotated...
	var rpc_config_dicts = get_rpc_config()
	print("rpc configs")
	print(rpc_config_dicts)

  # however manual configuration makes one rpc show up in dictionary
	rpc_config("test1", {"call_local": true,"rpc_mode": MultiplayerAPI.RPC_MODE_ANY_PEER})
	var rpc_config_dicts_after = get_rpc_config()
	print("rpc configs after call")
	print(rpc_config_dicts_after)

@rpc("any_peer", "call_local")
func test1():
	print("test1")

@rpc("call_local")
func test2():
	print("test2")
