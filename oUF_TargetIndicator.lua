--[[
	# Element: Target Indicator

	Highlight the unit frame when thet unit is targeted by the player.

	## Widget

	TargetIndicator - A Frame to listen to "PLAYER_TARGET_CHANGE" event.

	## Options

	.PostUpdate - Opacity when the unit is out of range. Defaults to 0.55 (number)[0-1].

	## Examples

		-- Register with oUF
		self.TargetIndicator = CreateFrame("Frame", nil, self)
		self.TargetIndicator.PostUpdate = function(self, parent, isTarget)
			local element = self
			element:Show()

			if isTarget then
				if (parent.Backdrop) then
					parent.Backdrop:SetBackdropBorderColor(0.84, 0.75, 0.65)
				end
			else
				if (parent.Backdrop) then
					parent.Backdrop:SetBackdropBorderColor(0, 0, 0)
				end
			end
		end
--]]

local _, ns = ...
local oUF = ns.oUF

-- Blizzard
local UnitIsUnit = _G.UnitIsUnit

local function Update(self, event)
	local element = self.TargetIndicator

	--[[ Callback: TargetIndicator:PreUpdate()
	Called before the element has been updated.

	* self - the TargetIndicator element
	--]]
	if (element.PreUpdate) then
		element:PreUpdate()
	end

	local isTarget = UnitIsUnit("target", self.unit)
	if (isTarget) then
		element:Show()
	else
		element:Hide()
	end

	--[[ Callback: TargetIndicator:PostUpdate(isTarget)
	Called after the element has been updated.

	* self      - the TargetIndicator element
	* object    - the parent object
	* isTarget	- indicates if the unit is targeted by the player (boolean)
	--]]
	if (element.PostUpdate) then
		return element:PostUpdate(self, isTarget)
	end
end

local function Path(self, ...)
	--[[ Override: TargetIndicator.Override(self, event)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	--]]
	return (self.TargetIndicator.Override or Update) (self, ...)
end

local function Enable(self)
	local unit = self.unit
	local element = self.TargetIndicator
	if (element) then
		element.__owner = self
		element.UpdateColor = element.UpdateColor or UpdateColor

		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path, true)

		-- if unit:match("^nameplate%d") then
		-- 	self:RegisterEvent("NAME_PLATE_UNIT_ADDED", Path, true)
		-- 	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED", Path, true)
		-- end

		return true
	end
end

local function Disable(self)
	local element = self.TargetIndicator
	if (element) then
		element:Hide()

		self:UnregisterEvent("PLAYER_TARGET_CHANGED", Path)

		-- if unit:match("^nameplate%d") then
		-- 	self:UnregisterEvent("NAME_PLATE_UNIT_ADDED", Path)
		-- 	self:UnregisterEvent("NAME_PLATE_UNIT_REMOVED", Path)
		-- end
	end
end

oUF:AddElement("TargetIndicator", nil, Enable, Disable)
