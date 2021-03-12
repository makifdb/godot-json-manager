extends Node

onready var jsonFile = "res://Data/gamedata.json"
onready var defaultFile = "res://Data/defaultdata.json"
onready var header = get_node("VBoxContainer/Label")
onready var textLabel = get_node("VBoxContainer/TextEdit")
onready var background = get_node("ColorRect")

var gameData = {}

func _ready():
	loadGameData()
	refresh()

func refresh():
	textLabel.text = JSON.print(gameData, "  ", true)
	background.color = Color(gameData["player"]["options"]["background-color"])
	header.text = (gameData["player"]["name"] + "'s Data")

func loadGameData():
	var file = File.new()
	file.open(jsonFile, file.READ)
	var json = JSON.parse(file.get_as_text())
	gameData = json.result
	file.close()
	
func saveGameData():
	var file = File.new()
	file.open(jsonFile, file.WRITE)
	file.store_string(JSON.print(gameData, "  ", true))
	file.close()
	
func resetGameData():
	var file = File.new()
	file.open(defaultFile, file.READ)
	var text = file.get_as_text()
	var defaultData = {}
	defaultData = parse_json(text)
	gameData = defaultData
	file.close()
	saveGameData()

func _on_SaveButton_pressed():
	gameData = JSON.parse(textLabel.text).result
	saveGameData()
	refresh()

func _on_LoadButton_pressed():
	loadGameData()
	refresh()

func _on_ResetButton_pressed():
	resetGameData()
	refresh()
