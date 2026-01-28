local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function()
	local numEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
    
	-- Only run if we're in the "bugged" state
    if numEntries <= numQuests then return end

    local unwatched = 0

    for i = 1, numEntries do
        local quest = C_QuestLog.GetInfo(i)
        if quest and quest.isHidden then
            C_QuestLog.RemoveQuestWatch(quest.questID)
            unwatched = unwatched + 1
			print("Unwatched hidden quest:", quest.title or "Unknown Quest")
        end
    end

	if unwatched > 0 then
        print(("UnwatchHiddenQuests: removed %d hidden quest watch(es)."):format(unwatched))
    end
end)
