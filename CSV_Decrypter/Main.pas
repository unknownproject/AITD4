unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    OpenBtn: TButton;
    OpenDialog1: TOpenDialog;
    ProgressBar1: TProgressBar;
    SaveBtn: TButton;
    Label1: TLabel;
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  PData: TMemoryStream;
  DData: TMemoryStream;
implementation

{$R *.dfm}

procedure TMainForm.OpenBtnClick(Sender: TObject);
var
  i,num,Result:integer;
  Buf: byte;
begin
  OpenDialog1.Filter:='AITD4 CSV Files|*.csv';
  if OpenDialog1.Execute then
  begin
    PData:=TMemoryStream.Create;
    DData:=TMemoryStream.Create;
    PData.LoadFromFile(OpenDialog1.FileName);
    //We don't need to decrypt this plaintext file
    if Pos('Text.csv', OpenDialog1.Filename) <> 0 then
    begin
      ShowMessage('Nothing to decrypt');
      exit;
    end;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=Pdata.Size;
    Num:=0;
    Pdata.Seek(0,0);
    Ddata.Seek(0,0);
    for i := 0 to Pdata.Size-1 do
    begin
      Pdata.Read(Buf,1);
      Application.ProcessMessages;
      //////////////////////////////////////////////
      ///  This is our 3-step decryption algorithm.
      ///  Where 'buf' - current byte
      ///  and 'Num' - its index
      //////////////////////////////////////////////
      asm
        XOR ECX,ECX;
        MOV CL,Buf;
        MOV EDX,Num;
        AND EDX,$000000FF;
        XOR ECX,EDX;
        AND ECX,$0000003C; //1
        //////////
        XOR EDX,EDX; 
        MOV DL,Buf;
        MOV EAX,Num;
        AND EAX,$000000FF;
        XOR EDX,EAX;
        SHL EDX,$6;
        AND EDX,$000000C0;
        OR ECX,EDX; //2
        //////////
        XOR EAX,EAX;
        MOV AL,Buf;
        MOV EDX,Num;
        AND EDX,$000000FF;
        XOR EAX,EDX;
        SAR EAX,$6;
        AND EAX,$00000003;
        OR ECX,EAX; //3 - Final value
        MOV Result, ECX;
      end;
      Ddata.Write(Result,1);
      Label1.Caption:='['+IntToHex(Buf,2)+']';
      ProgressBar1.Position:=ProgressBar1.Position+1;
      inc(Num);
    end;
  end;
end;
procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
    DData.SaveToFile(ExtractFilePath(Application.Exename)+'/Dump/'+'test.csv');
    Pdata.Free;
    DData.Free;
end;

end.
