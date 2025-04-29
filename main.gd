extends Control

var waiting_for_tap = false
var start_time = 0.0

func _ready():

	$StartButton.pressed.connect(start_game)
	$MessageLabel.text = "Welcome! Tap Start."
	randomize()

func start_game():
	$StartButton.disabled = true
	$MessageLabel.text = "Get Ready..."
	
	$WaitTimer.wait_time = randf_range(0.5, 2.0)
	$WaitTimer.start()

func _on_wait_timer_timeout():
	$MessageLabel.text = "TAP NOW!"
	start_time = Time.get_ticks_msec() / 1000.0
	waiting_for_tap = true

func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			if waiting_for_tap:
				var tap_time = Time.get_ticks_msec() / 1000.0
				var reaction_time = tap_time - start_time
				$MessageLabel.text = "Reaction Time: " + str(round(reaction_time * 1000)) + " ms"
				waiting_for_tap = false
				$StartButton.disabled = false
			else:
				$MessageLabel.text = "Too Early! Try Again."
				$StartButton.disabled = false
				$WaitTimer.stop()
