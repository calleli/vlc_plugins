function descriptor() --Info om pluginet
	return {
		title = "South Park intro skipper",
		version = "0.1",
		author = "carlT",
		description = [[
			*** SKIPS THE INTRO OF EVERY SOUTH PARK EPISODE WHEN CLICKING THE BUTTON
		]],
	}
end


function activate()
	Create_dialog()
	--get_name_of_file() --uncomment this line to execute instantly when starting the add-on
end

function Create_dialog()

	d = vlc.dialog(descriptor().title)

	--Upper row
	d:add_label(string.rep("&nbsp;",27),1,1,1,1)
	d:add_label(string.rep("&nbsp;",28),2,1,1,1)
  d:add_label(string.rep("&nbsp;",1),5,1,1,1)
	d:add_button("Skip intro!", get_name_of_file, 1,1,1,1)
	fname = d:add_text_input(aaa, 2,1,4,1)

	--Lower row
	d:add_label(string.rep("&nbsp;",27),1,2,1,1)
	skipped = d:add_text_input(aaa, 2,2,2,1)

end

function get_name_of_file()
	local input=vlc.input.item()
	local file_name = string.lower(input:name())
	local south = string.find(file_name, "south")
	local park = string.find(file_name, "park")

	if (south ~= nil) and (park ~= nil) then --file playing is southpark
		fname:set_text("It seems like South Park is playing, lets skip the intro shall we?")
		skip_intro()
	else --no file is playing
	 	fname:set_text("South Park is NOT playing...")
		skipped:set_text("Should not skip!")
 	end
end

function skip_intro()
	local input=vlc.object.input()
	local curr_time = vlc.var.get(input, "time")
	if(curr_time < 31) then -- only jump FORWARD to this time, not back!
		vlc.var.set(input,"time", 31)
		skipped:set_text("SP intro skipped!")
	end
end
