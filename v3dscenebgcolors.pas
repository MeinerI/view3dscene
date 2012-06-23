{
  Copyright 2002-2012 Michalis Kamburelis.

  This file is part of "view3dscene".

  "view3dscene" is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  "view3dscene" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with "view3dscene"; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

  ----------------------------------------------------------------------------
}

{ Simple management of glClearColor OpenGL property. }

unit V3DSceneBGColors;

interface

uses GL, GLU, VectorMath;

const
  DefaultBGColor: TVector3Single = (0, 0, 0);

var
  BGColor: TVector3Single;

{ Call always after changing BGColor, call also once at the GL context open.
  Sets glClearColor. }
procedure BGColorChanged;

implementation

uses CastleConfig;

procedure BGColorChanged;
begin
  { Alpha of this is irrelevant. }
  glClearColor(BGColor[0], BGColor[1], BGColor[2], 0);
end;

type
  TConfigOptions = class
    class procedure LoadFromConfig(const Config: TCastleConfig);
    class procedure SaveToConfig(const Config: TCastleConfig);
  end;

class procedure TConfigOptions.LoadFromConfig(const Config: TCastleConfig);
begin
  BGColor := Config.GetValue(
    'video_options/default_background_color', DefaultBGColor);
end;

class procedure TConfigOptions.SaveToConfig(const Config: TCastleConfig);
begin
  Config.SetDeleteValue('video_options/default_background_color',
    BGColor, DefaultBGColor);
end;

initialization
  Config.OnLoad.Add(@TConfigOptions(nil).LoadFromConfig);
  Config.OnSave.Add(@TConfigOptions(nil).SaveToConfig);
end.
