local SKIN = {}

-- These are used in the settings panel
SKIN.PrintName = "VGUISwitcher"
SKIN.Author = "TTT2 Devs"
SKIN.DermaVersion = 1

-- internal thing
SKIN.lastHUD = nil

-- optimization
local surface = surface

local defaultVGUIColor = Color(49, 71, 94, 255)
local shadow_border = surface.GetTextureID("vgui/ttt/dynamic/hud_components/shadow_border")

---
-- An example function of any used var of a SKIN table
-- used to reset the SKIN if there is no registered function
-- @local
function SKIN:UpdateColor(col)
	self.colOutline = col

	self.colPropertySheet = col
	self.colTab = self.colPropertySheet
	self.colTabText = col
	self.colTabInactive = col
	self.colTabShadow = col
	self.fontButton = "Default"
	self.fontTab = "Default"
	self.bg_color = col
	self.bg_color_sleep = col
	self.bg_color_dark = col
	self.bg_color_bright = col
	self.listview_hover = col
	self.listview_selected = col
	self.control_color = col
	self.control_color_highlight = col
	self.control_color_active = col
	self.control_color_bright = col
	self.control_color_dark = col
	self.text_bright = col
	self.text_normal = col
	self.text_dark = col
	self.text_highlight = col
	self.colCategoryText = col
	self.colCategoryTextInactive = col
	self.fontCategoryHeader = "TabLarge"
	self.colTextEntryTextHighlight = col
	self.colTextEntryTextHighlight = col
	self.colCategoryText = Color(255, 255, 255, 255)
	self.colCategoryTextInactive = Color(200, 200, 200, 255)
	self.fontCategoryHeader = "TabLarge"
	self.tooltip = Color(255, 127, 0, 255)
end

---
-- Initialize the VGUI with the default fallback data
SKIN:UpdateColor(defaultVGUIColor)

---
-- Just a fallback function that draws the box if there is no registered function
-- @local
function SKIN:DrawSquaredBox(x, y, w, h, color)
	surface.SetDrawColor(color)
	surface.DrawRect(x, y, w, h)

	local corner_size = 7
	local shadow_size = 4
	local edge_size = 3

	surface.SetDrawColor(255, 255, 255, a)
	surface.SetTexture(shadow_border)

	surface.DrawTexturedRectUV(x - shadow_size, y + h - edge_size, corner_size, corner_size, 3.5/63, 52.5/63,  10.5/63, 59.5/63)
	surface.DrawTexturedRectUV(x + w - edge_size, y + h - edge_size, corner_size, corner_size, 52.5/63, 52.5/63,  59.5/63, 59.5/63)
	surface.DrawTexturedRectUV(x - shadow_size, y - shadow_size, corner_size, corner_size, 3.5/63, 3.5/63,  10.5/63, 10.5/63)
	surface.DrawTexturedRectUV(x  + w - edge_size, y - shadow_size, corner_size, corner_size, 52.5/63, 3.5/63,  59.5/63, 10.4/63)
	surface.DrawTexturedRectUV(x + edge_size, y + h - edge_size, w - 2 * edge_size, corner_size, 31.5/63, 52.5/63,  32.5/63, 59.5/63)
	surface.DrawTexturedRectUV(x - shadow_size, y + edge_size, corner_size, h - 2 * edge_size, 3.5/63, 31.5/63,  10.5/63, 32.5/63)
	surface.DrawTexturedRectUV(x + w - edge_size, y + edge_size, corner_size, h - 2 * edge_size, 52.5/63, 31.5/63,  59.5/63, 32.5/63)
	surface.DrawTexturedRectUV(x + edge_size, y - shadow_size, w - 2 * edge_size, corner_size, 31.5/63, 3.5/63,  32.5/63, 10.5/63)
end

---
-- This is getting called if the HUD changes (and will call HUD:VGUIUpdateData(SKIN, panel))
-- @local
function SKIN:UpdateData(hud, panel)
	if isfunction(hud.VGUIUpdateData) then
		hud:VGUIUpdateData(self, panel)
	else
		self:UpdateColor(defaultVGUIColor)
	end
end

---
-- Drawing the frame (VGUI box)
-- @local
function SKIN:PaintFrame(panel)
	local hudName = HUDManager.GetHUD()
	local hud = huds.GetStored(hudName)

	if hud and isfunction(hud.VGUIPaintFrame) then
		if self.lastHUD ~= hudName then
			self:UpdateData(hud, panel)

			self.lastHUD = hudName
		end

		hud:VGUIPaintFrame(self, panel)
	else
		self:DrawSquaredBox(0, 0, panel:GetWide(), panel:GetTall(), self.bg_color)

		surface.SetDrawColor(0, 0, 0, 75)
		surface.DrawRect(0, 0, panel:GetWide(), 21)

		surface.SetDrawColor(self.colOutline)
		surface.DrawRect(0, 21, panel:GetWide(), 1)
	end
end

-- registering the derma (skin)
derma.DefineSkin("ttt2VGUISwitcher", "The TTT2 VGUI Switching Foundation", SKIN)
