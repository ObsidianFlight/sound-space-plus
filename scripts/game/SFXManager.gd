extends Node

const MAX_NODES = 48
var hitSounds = []

func clear_all_children():
	for i in self.get_children():
		i.queue_free()
	hitSounds.clear()

func setup():
	clear_all_children()
	if (Rhythia.sfx_2d):
		for i in MAX_NODES:
			var hitsound = AudioStreamPlayer.new()
			hitsound.set_stream(Rhythia.hit_snd)
			hitsound.set_bus("HitSound")
			hitSounds.append(hitsound)
			add_child(hitsound)
	elif (!Rhythia.sfx_2d):
		for i in MAX_NODES:
			var hitsound = AudioStreamPlayer3D.new()
			hitsound.set_stream(Rhythia.hit_snd)
			hitsound.set_bus("HitSound")
			hitsound.set_attenuation_model(AudioStreamPlayer3D.ATTENUATION_DISABLED)
			hitsound.attenuation_filter_cutoff_hz = 20500
			hitsound.attenuation_filter_db = 0
			hitsound.pause_mode = PAUSE_MODE_PROCESS
			hitSounds.append(hitsound)
			add_child(hitsound)

func play_hitsfx(transform):
	for sound in hitSounds:
		if (!sound.playing):
			if (!Rhythia.sfx_2d):
				sound.transform = transform
				sound.play()
			else:
				sound.play()
			break;