--
-- script\commands.lua
--

command_start = "02"
command_stop = "03"
serial_commands = {
	["ON"] = "PWD:1",
	["OFF"] = "PWD:0"

function process_commands( strCommand )
	local command = ""
	if serial_commands[strCommand] ~= nil then
		command = tohex(command_start) .. serial_commands[
			strCommand] .. tohex(command_stop)
		print("found command " .. command)
	end
	return command
end