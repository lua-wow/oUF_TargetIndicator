# oUF_TargetIndicator

Target indicator support for oUF layouts

## Element: Target Indicator

Highlight the unit frame when thet unit is targeted by the player.

### Widget

`TargetIndicator` - A Frame to listen to "PLAYER_TARGET_CHANGE" event.

### Options

`.PostUpdate` - Opacity when the unit is out of range. Defaults to 0.55 (number)[0-1].

### Examples

```lua
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
```

## License

Please, see [LICENSE](./LICENSE) file.
