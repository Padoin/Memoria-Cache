unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmPrincipal = class(TForm)
    EdtEndereco: TEdit;
    EdtInfo: TEdit;
    BtLer: TButton;
    BtEscrever: TButton;
    Label1: TLabel;
    Label2: TLabel;
    LblAcertos: TLabel;
    LblFaltas: TLabel;
    LblLeituras: TLabel;
    LblEscrita: TLabel;
    LblAcertoLeitura: TLabel;
    LblAcessos: TLabel;
    LblAcertoEscrita: TLabel;
    LblFaltaLeitura: TLabel;
    LblFaltaEscrita: TLabel;
    GridCache0: TStringGrid;
    GridMP: TStringGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GridCache1: TStringGrid;
    GridCache2: TStringGrid;
    GridCache3: TStringGrid;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtLerClick(Sender: TObject);
    procedure BtEscreverClick(Sender: TObject);
  private
    { Private declarations }
    function Dectobin(valor: integer): string;
    function Mapeamento(t : string) : string;
    procedure EscreverMPeCache(text:string);
    procedure AtualizaLabel();
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  acertos, faltas, escrita, leituras, fleitura, fescrita, acessos, aescrita, aleitura : integer;

implementation

{$R *.dfm}

procedure TFrmPrincipal.AtualizaLabel();
begin
  LblAcessos.Caption := 'N�. Acessos : ' + IntToStr(acessos);
  LblEscrita.Caption := 'N�. Escritas : ' + IntToStr(escrita);
  LblLeituras.Caption := 'N�. Leituras : ' + IntToStr(leituras);
  LblFaltas.Caption := 'N�. Faltas : ' + IntToStr(faltas);
  LblFaltaEscrita.Caption := 'N�. Faltas Escrita : ' + IntToStr(fescrita);
  LblFaltaLeitura.Caption := 'N�. Faltas Leitura :' + IntToStr(fleitura);
end;

procedure TFrmPrincipal.BtEscreverClick(Sender: TObject);
begin
  EscreverMPeCache(EdtEndereco.Text);
  acessos := acessos + 1;
  escrita := escrita + 1;
  AtualizaLabel();
end;

procedure TFrmPrincipal.BtLerClick(Sender: TObject);
var
  Valor : string;
begin
  Valor := Mapeamento(EdtEndereco.Text);
  EdtInfo.Text := Valor;
  acessos := acessos + 1;
  leituras := leituras + 1;
  AtualizaLabel();
end;

function TFrmPrincipal.Dectobin(valor: integer): string;
var
  res : string;
  I : integer;
  binario: array[1..10] of integer;
begin
  begin
    while valor >= 1  do
      begin
      for I := 1 to 10 do
        begin
          binario[I] := valor mod 2;
          valor := (valor div 2);
        end;
      end;
      for I := 10 downto 1 do
        begin
          res := res + IntToStr(binario[i]);
        end;
  result := res;
  end;
end;

procedure TFrmPrincipal.EscreverMPeCache(text: string);
var
  adress, rotulo, conDestino, deslocamento : string;
  I, bin11, bin22, bin33, bin44, binario, bitDeslocamento : integer;
begin
  adress := text;
  rotulo := Copy(adress, 1, 4);
  conDestino := Copy(adress, 5, 4);
  deslocamento := Copy(adress, 9, 2);

  bin11 := StrToInt(Copy(conDestino,1,1));
  bin22 := StrToInt(Copy(conDestino,2,1));
  bin33 := StrToInt(Copy(conDestino,3,1));
  bin44 := StrToInt(Copy(conDestino,4,1));

  bin44 := bin44 * 1;
  bin33 := bin33 * 2;
  bin22 := bin22 * 4;
  bin11 := bin11 * 8;
  binario := bin11 + bin22 + bin33 + bin44;

  bin11 := StrToInt(Copy(deslocamento,1,1));
  bin22 := StrToInt(Copy(deslocamento,2,1));

  bin22 := bin22 * 1;
  bin11 := bin11 * 2;
  bitDeslocamento := bin11 + bin22;

  for I := 0 to 1024 do
  begin
    if GridMP.Cells[0,I + 1] = adress then
    begin
      GridMP.Cells[2,I+1] := EdtInfo.Text;
    end;
  end;
  for I := 1 to 16 do
  begin
    if ((GridCache0.Cells[0, binario + 1] = rotulo) or (GridCache1.Cells[0, binario + 1] = rotulo) or
        (GridCache2.Cells[0, binario + 1] = rotulo) or (GridCache3.Cells[0, binario + 1] = rotulo))then
    begin
      if ((GridCache0.Cells[1, binario + 1] = conDestino) or (GridCache1.Cells[1, binario + 1] = conDestino) or
        (GridCache2.Cells[1, binario + 1] = conDestino) or (GridCache3.Cells[1, binario + 1] = conDestino))then
      begin
        if GridCache0.Cells[0, I] = rotulo then
        begin
          GridCache0.Cells[bitDeslocamento + 2, I] := EdtInfo.Text;
          fescrita := fescrita + 1;
          break;
        end
        else if GridCache1.Cells[0, I] = rotulo then
        begin
          GridCache1.Cells[bitDeslocamento + 2, I] := EdtInfo.Text;
          fescrita := fescrita + 1;
          break;
        end
        else if GridCache1.Cells[0, I] = rotulo then
        begin
          GridCache2.Cells[bitDeslocamento + 2, I] := EdtInfo.Text;
          fescrita := fescrita + 1;
          break;
        end
        else if GridCache1.Cells[0, I] = rotulo then
        begin
          GridCache3.Cells[bitDeslocamento + 2, I] := EdtInfo.Text;
          fescrita := fescrita + 1;
          break;
        end;
      end;
    end
    else
    begin
      Mapeamento(EdtEndereco.Text);
//      faltas := faltas + 1;
      fescrita := fescrita + 1;
      break;
    end;
  end;

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  I: Integer;
  J: Integer;
  X: Integer;
  Z: Integer;
  T: Integer;
  bin : array[1..10] of integer;
  binario, vbin: string;

begin
  acertos := 0;
  faltas := 0;
  escrita := 0;
  leituras := 0;
  fleitura := 0;
  fescrita := 0;
  acessos := 0;
  aescrita := 0;
  aleitura := 0;

  GridCache0.Cells[0,0] := 'R�t';
  GridCache0.Cells[1,0] := 'Ind';
  GridCache0.Cells[2,0] := 'D0';
  GridCache0.Cells[3,0] := 'D1';
  GridCache0.Cells[4,0] := 'D2';
  GridCache0.Cells[5,0] := 'D3';
  GridCache0.Cells[6,0] := 'V�lido';

  GridCache1.Cells[0,0] := 'R�t';
  GridCache1.Cells[1,0] := 'Ind';
  GridCache1.Cells[2,0] := 'D0';
  GridCache1.Cells[3,0] := 'D1';
  GridCache1.Cells[4,0] := 'D2';
  GridCache1.Cells[5,0] := 'D3';
  GridCache1.Cells[6,0] := 'V�lido';

  GridCache2.Cells[0,0] := 'R�t';
  GridCache2.Cells[1,0] := 'Ind';
  GridCache2.Cells[2,0] := 'D0';
  GridCache2.Cells[3,0] := 'D1';
  GridCache2.Cells[4,0] := 'D2';
  GridCache2.Cells[5,0] := 'D3';
  GridCache2.Cells[6,0] := 'V�lido';

  GridCache3.Cells[0,0] := 'R�t';
  GridCache3.Cells[1,0] := 'Ind';
  GridCache3.Cells[2,0] := 'D0';
  GridCache3.Cells[3,0] := 'D1';
  GridCache3.Cells[4,0] := 'D2';
  GridCache3.Cells[5,0] := 'D3';
  GridCache3.Cells[6,0] := 'V�lido';

  GridMP.Cells[0,0] := 'Endereco';
  GridMP.Cells[1,0] := 'Bloco';
  GridMP.Cells[2,0] := 'Info';
  GridMP.Cells[0,1] := '0000000000';

  for I := 1 to 16 do
  begin
    GridCache0.Cells[0,I] := 'xxxx';
    GridCache0.Cells[1,I] := 'xxxx';
    GridCache0.Cells[2,I] := 'x';
    GridCache0.Cells[3,I] := 'x';
    GridCache0.Cells[4,I] := 'x';
    GridCache0.Cells[5,I] := 'x';
    GridCache0.Cells[6,I] := '0';

    GridCache1.Cells[0,I] := 'xxxx';
    GridCache1.Cells[1,I] := 'xxxx';
    GridCache1.Cells[2,I] := 'x';
    GridCache1.Cells[3,I] := 'x';
    GridCache1.Cells[4,I] := 'x';
    GridCache1.Cells[5,I] := 'x';
    GridCache1.Cells[6,I] := '0';

    GridCache2.Cells[0,I] := 'xxxx';
    GridCache2.Cells[1,I] := 'xxxx';
    GridCache2.Cells[2,I] := 'x';
    GridCache2.Cells[3,I] := 'x';
    GridCache2.Cells[4,I] := 'x';
    GridCache2.Cells[5,I] := 'x';
    GridCache2.Cells[6,I] := '0';

    GridCache3.Cells[0,I] := 'xxxx';
    GridCache3.Cells[1,I] := 'xxxx';
    GridCache3.Cells[2,I] := 'x';
    GridCache3.Cells[3,I] := 'x';
    GridCache3.Cells[4,I] := 'x';
    GridCache3.Cells[5,I] := 'x';
    GridCache3.Cells[6,I] := '0';
  end;


  for I := 1 to 1024 do
  begin
    vbin := Dectobin(I);
    GridMP.Cells[0,I + 1] := vbin;
  end;

  Z := 1;
  X := 0;
  for I := 1 to 1024 do
  begin
    for J := 0 to 3 do
    begin
      GridMP.Cells[1,Z] := IntToStr(X);
      Z := Z + 1;
    end;
    X := X + 1;
  end;

  T := 1;
  while T < 1024 do
  begin
    GridMP.Cells[2,T] := 'V';
    GridMP.Cells[2,T + 1] := 'W';
    GridMP.Cells[2,T + 2] := 'Y';
    GridMP.Cells[2,T + 3] := 'Z';
    T := T + 4;
  end;
end;

function TFrmPrincipal.Mapeamento(t: string) : string;
var
  adress, rotulo, conDestino, deslocamento, valor, nBloco, vB1, vB2, vB3, vB4 : string;
  bin1, bin2, bin3, bin4, binario, bitdeslocamento, x, i, j, aux :integer;
begin
  adress := t;
  rotulo := Copy(adress, 1, 4);
  conDestino := Copy(adress, 5, 4);
  deslocamento := Copy(adress, 9, 2);

  bin1 := StrToInt(Copy(conDestino,1,1));
  bin2 := StrToInt(Copy(conDestino,2,1));
  bin3 := StrToInt(Copy(conDestino,3,1));
  bin4 := StrToInt(Copy(conDestino,4,1));

  bin4 := bin4 * 1;
  bin3 := bin3 * 2;
  bin2 := bin2 * 4;
  bin1 := bin1 * 8;
  binario := bin1 + bin2 + bin3 + bin4;

  for I := 0 to 1023 do
  begin
    if adress = GridMP.Cells[0,I+1] then
    begin
      valor := GridMP.Cells[2,I+1];
      nBloco := GridMP.Cells[1,I+1];
      for J := 0 to 1023 do
      begin
        if nBloco = GridMP.Cells[1,J+1] then
        begin
          vB1 := GridMP.Cells[2,J + 1];
          vB2 := GridMP.Cells[2,J + 2];
          vB3 := GridMP.Cells[2,J + 3];
          vB4 := GridMP.Cells[2,J + 4];
          Break;
        end;
      end;
    end;
  end;

  if ((GridCache0.Cells[0, binario + 1] <> rotulo) and (GridCache1.Cells[0, binario + 1] <> rotulo) and
      (GridCache2.Cells[0, binario + 1] <> rotulo) and (GridCache3.Cells[0, binario + 1] <> rotulo))then
  begin
    if (GridCache0.Cells[0,binario+1] = 'xxxx') and (GridCache0.Cells[0, binario + 1] <> rotulo) then
    begin
      GridCache0.Cells[0,binario + 1] := rotulo;
      GridCache0.Cells[1,binario + 1] := conDestino;
      GridCache0.Cells[2,binario + 1] := vB1;
      GridCache0.Cells[3,binario + 1] := vB2;
      GridCache0.Cells[4,binario + 1] := vB3;
      GridCache0.Cells[5,binario + 1] := vB4;
      GridCache0.Cells[6,binario + 1] := '1';
      faltas := faltas + 1;
      fleitura := fleitura + 1;
    end
    else if (GridCache1.Cells[0,binario+1] = 'xxxx') and (GridCache1.Cells[0, binario + 1] <> rotulo) then
    begin
      GridCache1.Cells[0,binario + 1] := rotulo;
      GridCache1.Cells[1,binario + 1] := conDestino;
      GridCache1.Cells[2,binario + 1] := vB1;
      GridCache1.Cells[3,binario + 1] := vB2;
      GridCache1.Cells[4,binario + 1] := vB3;
      GridCache1.Cells[5,binario + 1] := vB4;
      GridCache1.Cells[6,binario + 1] := '1';
      faltas := faltas + 1;
      fleitura := fleitura + 1;
    end
      else if (GridCache2.Cells[0,binario+1] = 'xxxx') and (GridCache2.Cells[0, binario + 1] <> rotulo) then
    begin
      GridCache2.Cells[0,binario + 1] := rotulo;
      GridCache2.Cells[1,binario + 1] := conDestino;
      GridCache2.Cells[2,binario + 1] := vB1;
      GridCache2.Cells[3,binario + 1] := vB2;
      GridCache2.Cells[4,binario + 1] := vB3;
      GridCache2.Cells[5,binario + 1] := vB4;
      GridCache2.Cells[6,binario + 1] := '1';
      faltas := faltas + 1;
      fleitura := fleitura + 1;
    end
    else if (GridCache3.Cells[0,binario+1] = 'xxxx') and (GridCache3.Cells[0, binario + 1] <> rotulo) then
    begin
      GridCache3.Cells[0,binario + 1] := rotulo;
      GridCache3.Cells[1,binario + 1] := conDestino;
      GridCache3.Cells[2,binario + 1] := vB1;
      GridCache3.Cells[3,binario + 1] := vB2;
      GridCache3.Cells[4,binario + 1] := vB3;
      GridCache3.Cells[5,binario + 1] := vB4;
      GridCache3.Cells[6,binario + 1] := '1';
      faltas := faltas + 1;
      fleitura := fleitura + 1;
    end
    else
    begin
      x := Random(4);
      if x = 0 then
      begin
        GridCache0.Cells[0,binario + 1] := rotulo;
        GridCache0.Cells[1,binario + 1] := conDestino;
        GridCache0.Cells[2,binario + 1] := vB1;
        GridCache0.Cells[3,binario + 1] := vB2;
        GridCache0.Cells[4,binario + 1] := vB3;
        GridCache0.Cells[5,binario + 1] := vB4;
        faltas := faltas + 1;
        fleitura := fleitura + 1;
      end
      else if x = 1 then
      begin
        GridCache1.Cells[0,binario + 1] := rotulo;
        GridCache1.Cells[1,binario + 1] := conDestino;
        GridCache1.Cells[2,binario + 1] := vB1;
        GridCache1.Cells[3,binario + 1] := vB2;
        GridCache1.Cells[4,binario + 1] := vB3;
        GridCache1.Cells[5,binario + 1] := vB4;
        faltas := faltas + 1;
        fleitura := fleitura + 1;
      end
      else if x = 2 then
      begin
        GridCache2.Cells[0,binario + 1] := rotulo;
        GridCache2.Cells[1,binario + 1] := conDestino;
        GridCache2.Cells[2,binario + 1] := vB1;
        GridCache2.Cells[3,binario + 1] := vB2;
        GridCache2.Cells[4,binario + 1] := vB3;
        GridCache2.Cells[5,binario + 1] := vB4;
        faltas := faltas + 1;
        fleitura := fleitura + 1;
      end
      else
      begin
        GridCache3.Cells[0,binario + 1] := rotulo;
        GridCache3.Cells[1,binario + 1] := conDestino;
        GridCache3.Cells[2,binario + 1] := vB1;
        GridCache3.Cells[3,binario + 1] := vB2;
        GridCache3.Cells[4,binario + 1] := vB3;
        GridCache3.Cells[5,binario + 1] := vB4;
        faltas := faltas + 1;
        fleitura := fleitura + 1;
      end;
    end;
  end;
  Result := valor;
end;

end.
