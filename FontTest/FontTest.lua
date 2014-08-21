-----------------------------------------------------------------------------------------------
-- Client Lua Script for FontTest
-- Copyright (c) NCsoft. All rights reserved
-----------------------------------------------------------------------------------------------
 
require "Window"
 
-----------------------------------------------------------------------------------------------
-- FontTest Module Definition
-----------------------------------------------------------------------------------------------
local FontTest = {} 
 
-----------------------------------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------------------------------
-- e.g. local kiExampleVariableMax = 999
 
-----------------------------------------------------------------------------------------------
-- Initialization
-----------------------------------------------------------------------------------------------
function FontTest:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here

    return o
end

function FontTest:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {
		-- "UnitOrPackageName",
	}
    Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end
 

-----------------------------------------------------------------------------------------------
-- FontTest OnLoad
-----------------------------------------------------------------------------------------------
function FontTest:OnLoad()
    -- load our form file
	self.xmlDoc = XmlDoc.CreateFromFile("FontTest.xml")
	self.xmlDoc:RegisterCallback("OnDocLoaded", self)
end

-----------------------------------------------------------------------------------------------
-- FontTest OnDocLoaded
-----------------------------------------------------------------------------------------------
function FontTest:OnDocLoaded()

	if self.xmlDoc ~= nil and self.xmlDoc:IsLoaded() then
	    self.wndMain = Apollo.LoadForm(self.xmlDoc, "FontTestForm", nil, self)
		if self.wndMain == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
	    self.wndMain:Show(false, true)

		-- if the xmlDoc is no longer needed, you should set it to nil
		-- self.xmlDoc = nil
		
		-- Register handlers for events, slash commands and timer, etc.
		-- e.g. Apollo.RegisterEventHandler("KeyDown", "OnKeyDown", self)
		Apollo.RegisterSlashCommand("fonttest", "OnFontTestOn", self)


		-- Do additional Addon initialization here
	end
end

-----------------------------------------------------------------------------------------------
-- FontTest Functions
-----------------------------------------------------------------------------------------------
-- Define general functions here

-- on SlashCommand "/fonttest"
function FontTest:OnFontTestOn()
	self.wndMain:Invoke() -- show the window
end


-----------------------------------------------------------------------------------------------
-- FontTestForm Functions
-----------------------------------------------------------------------------------------------
-- when the OK button is clicked
function FontTest:OnOK()
	self.wndMain:Close() -- hide the window
end

-- when the Cancel button is clicked
function FontTest:OnCancel()
	self.wndMain:Close() -- hide the window
end


-----------------------------------------------------------------------------------------------
-- FontTest Instance
-----------------------------------------------------------------------------------------------
local FontTestInst = FontTest:new()
FontTestInst:Init()
