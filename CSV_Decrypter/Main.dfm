object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'AITD4_DeCrypto_v.1.0'
  ClientHeight = 52
  ClientWidth = 204
  Color = 10412768
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 11
  object Label1: TLabel
    Left = 90
    Top = 11
    Width = 22
    Height = 11
    Caption = '[??]'
  end
  object OpenBtn: TButton
    Left = 8
    Top = 8
    Width = 73
    Height = 18
    Caption = 'Open'
    TabOrder = 0
    OnClick = OpenBtnClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 32
    Width = 187
    Height = 17
    TabOrder = 1
  end
  object SaveBtn: TButton
    Left = 120
    Top = 8
    Width = 75
    Height = 18
    Caption = 'Save'
    TabOrder = 2
    OnClick = SaveBtnClick
  end
  object OpenDialog1: TOpenDialog
    Left = 88
    Top = 8
  end
end
