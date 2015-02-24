MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide() -- hide the gryphons


--[[
local f = CreateFrame("Frame")
f:SetFrameStrata("BACKGROUND")
f:SetWidth(40) -- Set these to whatever height/width is needed 
f:SetHeight(40) -- for your Texture

local t = f:CreateTexture(nil,"BACKGROUND")
t:SetTexture(nil)
t:SetAllPoints(f)
f.texture = t

f:SetPoint("CENTER",100,0)
f:Show()
f:RegisterEvent("UNIT_AURA")
f:SetScript("OnEvent",function()

local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId 
 = UnitAura("target", 1, "PLAYER|HARMFUL") 


local t = f:CreateTexture(nil,"BACKGROUND")
t:SetTexture(icon)
t:SetAllPoints(f)
f.texture = t
end)

--]]

local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")

g:SetScript("OnEvent", function()  
        local bag, slot
        for bag = 0, 4 do
                for slot = 0, GetContainerNumSlots(bag) do
                        local link = GetContainerItemLink(bag, slot)
			if link then
				local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(link)
				if (iRarity==2 or iRarity==3) and (iLevel>1 and iLevel<500) and (sType=="Armor" or sType=="Weapon")then
					print(sLink)
					UseContainerItem(bag, slot)				
				end
				

				if iRarity==0 then
                        	        UseContainerItem(bag, slot)
        	                end
			end
                end
        end

        if(CanMerchantRepair()) then
                local cost = GetRepairAllCost()
                if cost > 0 then
                        local money = GetMoney()
                        if IsInGuild() then
                                local guildMoney = GetGuildBankWithdrawMoney()
                                if guildMoney > GetGuildBankMoney() then
                                        guildMoney = GetGuildBankMoney()
                                end
                                if guildMoney > cost and CanGuildBankRepair() then
                                        RepairAllItems(1)
                                        print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
                                        return
                                end
                        end
                        if money > cost then
                                RepairAllItems()
                                print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
                        else
                                print("Not enough gold to cover the repair cost.")
                        end
                end
        end
end)

MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true)
Minimap:SetScript('onmousewheel', function(self, delta)
        if delta > 0 then
                Minimap_ZoomIn()
        else
                Minimap_ZoomOut()
        end
end)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPRIGHT", -26, 7)