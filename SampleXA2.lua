--table to insert in XAddonMngr list and popup menu, you can only write gui or popup
local add={
	gui={{--two "{" need, because it enabled multi tables
		name = "SampleXA2",
		children = true,--if you have sub page please add "children=true,"
		version = "0.6",--you can also delete the line
		window = "SampleXA2GUI",--your GUI frame's name, can't be nil, use "XBarCfg_Info" if you want a empty page
	},{--<<<add this if you have more pages>>>
		name = "Item",--text of your addon on XAddonMngr button
		title = "SampleXA2 - Item",--the page title on XAddonMngr, if same as ['name'] you don't need to write
		--version = "0.6",--you don't need to write again
		type = "SubMenu",--the level of your page, normal is "TopMenu", level: "TopMenu" -> "SubMenu" -> "ItemBtn", if type="TopMenu" you don't need to write
		window = "SampleXA2GUISub",
	}},
	popup={{
		icon = "Interface/MainMenuFrame/Mainpopupbutton-Icon-Title",--you can delete the line
		GetText = function() return "SampleXA2"; end,--can't be nil
		GetTooltip = function() return "/sxa2, /samplexa2\n\nAuthor"; end,--you can delete the line
		--[[GetTooltip = function()--or
			GameTooltip:SetOwner(XBar_PopupMenu,"ANCHOR_RIGHT",0,0);
			GameTooltip:SetText("/sxa2, /samplexa2");
			GameTooltip:AddLine("Author");
			end,]]
		--XAddon_ShowPage("SampleXA2GUI") be used to open XAddonMngr
		OnClick = function(this, key) XAddon_ShowPage("SampleXA2GUI"); end,--enabled L/R-Click
		--ex. if the click function include toggle addon,
		--    you can change GetText or GetTooltip to show addon status
}}};

function SampleXA2_OnEvent(event)
	if event=="VARIABLES_LOADED" then
		--check version of XBar
		if XBARVERSION and XBARVERSION>=1.51 then
			--regist all gui and popup.
			XAddon_Register(add);
		end
	end
end

function SampleXA2_OnShow(this)
	if XBARVERSION and XBARVERSION>=1.51 then
		--set your GUI anchor to XAddonMngr if found
		XAddon_Page(this);
		--hide backdrop if you use UICommonFrameTemplate
		--XAddon_HideBack1(this);
		--hide backdrop if you use Backdrop in XML
		XAddon_HideBack2(this);
		--<<<add this if you have more pages, you can also other way>>>
		SampleXA2Tab:Hide();
	else
		--<<<add this if you have more pages, you can also other way>>>
		SampleXA2Tab:Show();
	end
end

--<<<add this if you have more pages, you can also other way>>>
local pre;
function SampleXA2_Pre(this)
	--define the page when each time you show it
	pre = this;
end

--close function to hide your GUI and XAddonMngr
function SampleXA2_Close()
	if XBARVERSION and XBARVERSION>=1.51 then
		XAddonMngr:Hide();
	end
	SampleXA2_OnHide();
end

function SampleXA2_OnHide()
	SampleXA2GUI:Hide();
	--<<<add this if you have more pages, you can also other way>>>
	SampleXA2GUISub:Hide();
	SampleXA2Tab:Hide();
end

--<<<add this if you have more pages, you can also other way>>>
--tab click function for your original GUI
function SampleXA2_Page(v)
	--close previous show page
	if pre then pre:Hide(); end
	v:Show();
	pre = v;
end

--<<<add this if you have more pages, you can also other way>>>
--set all pages in the same offset and use the same anchor (XBarCfg or UIParent)
function SampleXA2_Pos(this, v)
	local point, relativeP, relativeTo, x, y = this:GetAnchor();
	v:ClearAllAnchors();
	v:SetAnchor(point, relativeP, relativeTo, x, y);
end