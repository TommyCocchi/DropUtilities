util.require_natives(1651208000)
util.require_no_lag('natives-1640181023')

util.keep_running()

util.toast("DropUtility V0.1 loaded successfully!")

local response = false
local localVer = 0.1
async_http.init("raw.githubusercontent.com", "/TommyCocchi/DropUtilites/main/version", function(output)
    currentVer = tonumber(output)
    response = true
    if localVer ~= currentVer then
        util.toast("A new DropUtilites release is available, update now to access the newest features.")
        menu.action(menu.my_root(), "Update Lua", {}, "", function()
            async_http.init('raw.githubusercontent.com','/TommyCocchi/DropUtilities/main/DropUtility.lua',function(a)
                local err = select(2,load(a))
                if err then
                    util.toast("Script failed to download. Please try again later. If this continues to happen then manually update via github.")
                return end
                local f = io.open(filesystem.scripts_dir()..SCRIPT_RELPATH, "wb")
                f:write(a)
                f:close()
                util.toast("Successfully updated DropUtility, please reload the script.")
                util.stop_script()
            end)
            async_http.dispatch()
        end)
    end
end, function() response = true end)
async_http.dispatch()
repeat 
    util.yield()
until response

chat.on_message(function (sender, reserved, text, team_chat)
    cmd1, cmd2 = string.partition(text, ' ')
    starts = string.startswith(text, "!cash")
    ends = string.endswith(text, "299") 
    ratenumber = tonumber(cmd2) 
    playername = players.get_name(sender)
    if ratenumber <	300 then
        util.toast("Kicked ".. playername .." for having a rate lower than 300.")
        chat.send_message("Kicked ".. playername .." for having a rate lower than 300.", false, true, true)
        NETWORK.NETWORK_SESSION_KICK_PLAYER(sender)
        NETWORK.NETWORK_SESSION_KICK_PLAYER(playername)
    end
end)