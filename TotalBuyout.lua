
function TotalBuyout_OnLoad(self)
    print("Total Buyout Loaded.");
    self:RegisterEvent("AUCTION_HOUSE_SHOW");
    self:RegisterEvent("AUCTION_HOUSE_CLOSED");
    self:RegisterEvent("AUCTION_OWNED_LIST_UPDATE");
end

function TotalBuyout_EventHandler(self, event, ...) 
    if (event == "AUCTION_HOUSE_SHOW") then TotalBuyout_OnAuctionHouseShow(); end;
    if (event == "AUCTION_HOUSE_CLOSED") then TotalBuyout_OnAuctionHouseClose(); end;
    if(event == "AUCTION_OWNED_LIST_UPDATE") then TotalBuyout_OnAuctionHouseUpdate(); end;
end

function TotalBuyout_OnAuctionHouseShow()
    local i = 1;
    local totalBuyoutAmount = 0;
    while (true) do
        local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, 
        highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("owner", i);

        if (name == nil) then
        break;
      end
      totalBuyoutAmount = totalBuyoutAmount + buyoutPrice;
      -- print("|cff00FF00" .. name .. ":|r  " .. buyoutPrice .. "|cff00FF00Total Buyout:|r  " .. totalBuyoutAmount);
      i = i + 1;
    end
    TotalBuyout_Frame:Show();
    MoneyFrame_Update(TotalBuyout_Frame, totalBuyoutAmount);
end

function TotalBuyout_OnAuctionHouseUpdate()
    GetOwnerAuctionItems();
    TotalBuyout_OnAuctionHouseShow();
end

function TotalBuyout_OnAuctionHouseClose()
    TotalBuyout_Frame:Hide();
end