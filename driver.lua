--
-- driver.lua
-- Copyright CompleteAV 2019
--

command_start = "02"
command_stop = "03"
serial_commands = {
    ["ON"] = "PWD:1",
    ["OFF"] = "PWD:0",
    ["UP"] = "KEY:25",
    ["DOWN"] = "KEY:26",
    ["LEFT"] = "KEY:24",
    ["RIGHT"] = "KEY:23",
    ["MENU"] = "KEY:21",
    ["ENTER"] = "KEY:36",
    ["CANCEL"] = "KEY:110",
    ["TV_VIDEO"] = "KEY:38",
    ["NUMBER_1"] = "KEY:1",
    ["NUMBER_2"] = "KEY:2",
    ["NUMBER_3"] = "KEY:3",
    ["NUMBER_4"] = "KEY:4",
    ["NUMBER_5"] = "KEY:5",
    ["NUMBER_6"] = "KEY:6",
    ["NUMBER_7"] = "KEY:7",
    ["NUMBER_8"] = "KEY:8",
    ["NUMBER_9"] = "KEY:9",
    ["NUMBER_0"] = "KEY:0",
    ["1002"] = "INP:1",	-- HDMI1
    ["1000"] = "INP:6",	-- HDMI2
    ["1001"] = "INP:9"	-- HDMI3
}

function process_commands( strCommand, tParams )
	local command = ""
	local returnCommand = ""
	if tParams ~= nil then
	   command = serial_commands[tParams["INPUT"]]
	   --command = tParams["INPUT"]
     elseif serial_commands[strCommand] ~= nil then
	   command = serial_commands[strCommand]
	end
	
    returnCommand = tohex(command_start) .. command .. tohex(command_stop)
	return returnCommand
end

function ReceivedFromProxy( idBinding, strCommand, tParams )
    local command = process_commands(strCommand, tParams)
    C4:SendToSerial(1, command)
    print ("received command " .. strCommand)
    print ("processed command " .. command)
end

function ReceivedFromSerial(idBinding, strData)
    print("response " .. strData)
end

function OnBindingChanged ( idBinding, strClass, bIsBound )
	print(strClass)
end
