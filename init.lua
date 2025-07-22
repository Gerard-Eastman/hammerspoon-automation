
--turbo clicking
local turboClicking = false
local clickInterval = 0.05 -- Adjust for faster/slower clicking

function toggleTurboClick()
    turboClicking = not turboClicking
    if turboClicking then
        turboClickTimer = hs.timer.doWhile(
            function() return turboClicking end,
            function() hs.eventtap.leftClick(hs.mouse.absolutePosition(), 0) end,
            clickInterval
        )
    else
        if turboClickTimer then turboClickTimer:stop() end
    end
end

  
hs.hotkey.bind({"ctrl", "cmd", "shift"}, "y", toggleTurboClick)


--repeated/timed consecutive clicks
local clickTimer = nil
local stopClicking = false

function twoTimedClick(numSequences) 
    
    local firstClick = {x = 350, y = 297}
    local secondClick  = {x = 560, y = 297}
    stopClicking = false
    local oddTime = true
    local currentClicks = 0

    clickTimer = hs.timer.doEvery(1.5,function()
        if currentClicks > numSequences or stopClicking then
            clickTimer:stop()
            clickTimer = nil
            hs.alert.show("Finished clicking")
            return
        end

        if oddTime then
            hs.eventtap.leftClick(firstClick)

        else 
            hs.eventtap.leftClick(secondClick)
        end

        oddTime = not oddTime
        currentClicks = currentClicks + 1
    end)


end

hs.hotkey.bind({"ctrl","cmd","shift"},"right", function() 
    twoTimedClick(1000)
end)

hs.hotkey.bind({"ctrl", "cmd", "shift"}, "left", function()
    stopClicking = true
end)
 

