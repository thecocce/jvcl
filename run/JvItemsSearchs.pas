{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvItemsSearchs.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse@buypin.com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck@bigfoot.com].

Last Modified: 2003-11-11

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}

{$I JVCL.INC}

unit JvItemsSearchs;

interface

uses
  SysUtils, Classes;

type
  TJvItemsSearchs = class(TObject)
  public
    function SearchExactString(Items: TStrings; Value: string; CaseSensitive: Boolean = True;
      StartIndex: Integer = -1): Integer;
    function SearchPrefix(Items: TStrings; Value: string; CaseSensitive: Boolean = True;
      StartIndex: Integer = -1): Integer;
    function SearchSubString(Items: TStrings; Value: string; CaseSensitive: Boolean = True;
      StartIndex: Integer = -1): Integer;
    function DeleteExactString(Items: TStrings; Value: string; All: Boolean;
      CaseSensitive: Boolean = True): Integer;
  end;

implementation

function TJvItemsSearchs.DeleteExactString(Items: TStrings; Value: string;
  All, CaseSensitive: Boolean): Integer;
var
  I: Integer;
begin
  Result := 0;
  I := SearchExactString(Items, Value, CaseSensitive);
  while I <> -1 do
  begin
    Inc(Result);
    Items.Delete(I);
    if All then
      I := SearchExactString(Items, Value, CaseSensitive)
    else
      Exit;
  end;
end;

function TJvItemsSearchs.SearchExactString(Items: TStrings; Value: string;
  CaseSensitive: Boolean; StartIndex: Integer): Integer;
var
  I: Integer;
  HasLooped: Boolean;
begin
  Result := -1;
  I := StartIndex + 1;
  HasLooped := False;
  if CaseSensitive then
  begin
    while not HasLooped or (I <= StartIndex) do
    begin
      if AnsiCompareStr(Value, Items[I]) = 0 then
      begin
        Result := I;
        Exit;
      end;
      Inc(I);
      if I >= Items.Count then
      begin
        I := 0;
        HasLooped := True;
      end;
    end;
  end
  else
  begin
    while not HasLooped or (I <= StartIndex) do
    begin
      if AnsiCompareText(Value, Items[I]) = 0 then
      begin
        Result := I;
        Exit;
      end;
      Inc(I);
      if I >= Items.Count then
      begin
        I := 0;
        HasLooped := True;
      end;
    end;
  end;
end;

function TJvItemsSearchs.SearchPrefix(Items: TStrings; Value: string;
  CaseSensitive: Boolean; StartIndex: Integer): Integer;
var
  I: Integer;
  HasLooped: Boolean;
begin
  Result := -1;
  I := StartIndex + 1;
  HasLooped := False;
  if CaseSensitive then
  begin
    while not HasLooped or (I <= StartIndex) do
    begin
      if Pos(Value, Items[I]) = 1 then
      begin
        Result := I;
        Exit;
      end;
      Inc(I);
      if I >= Items.Count then
      begin
        I := 0;
        HasLooped := True;
      end;
    end;
  end
  else
  begin
    Value := AnsiUpperCase(Value);
    while not HasLooped or (I <= StartIndex) do
    begin
      if Pos(Value, AnsiUpperCase(Items[I])) = 1 then
      begin
        Result := I;
        Exit;
      end;
      Inc(I);
      if I >= Items.Count then
      begin
        I := 0;
        HasLooped := True;
      end;
    end;
  end;
end;

function TJvItemsSearchs.SearchSubString(Items: TStrings; Value: string;
  CaseSensitive: Boolean; StartIndex: Integer): Integer;
var
  I: Integer;
  HasLooped: Boolean;
begin
  Result := 0;
  I := 0;
  HasLooped := False;
  if CaseSensitive then
  begin
    while not HasLooped or (I <= StartIndex) do
    begin
      if Pos(Value, Items[I]) <> 0 then
      begin
        Result := I;
        Exit;
      end;
      Inc(I);
      if I >= Items.Count then
      begin
        I := 0;
        HasLooped := True;
      end;
    end;
  end
  else
  begin
    Value := AnsiUpperCase(Value);
    while not HasLooped or (I <= StartIndex) do
    begin
      if Pos(Value, AnsiUpperCase(Items[I])) <> 0 then
      begin
        Result := I;
        Exit;
      end;
      Inc(I);
      if I >= Items.Count then
      begin
        I := 0;
        HasLooped := True;
      end;
    end;
  end;
end;

end.

