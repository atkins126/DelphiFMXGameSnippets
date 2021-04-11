unit Unit18;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  uSpriteCanard, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
{$SCOPEDENUMS ON}
  TVent = (VersLaGauche, Aucun, VersLaDroite);
{$SCOPEDENUMS OFF}

  TForm18 = class(TForm)
    ZIndex0: TLayout;
    ZIndex2: TLayout;
    ZIndex1: TLayout;
    Canard2: TSpriteCanard;
    Canard1: TSpriteCanard;
    animFlocons: TTimer;
    btnVentDeGauche: TButton;
    btnPasDeVent: TButton;
    btnVentDeDroite: TButton;
    zoneBoutons: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure animFloconsTimer(Sender: TObject);
    procedure btnVentDeGaucheClick(Sender: TObject);
    procedure btnPasDeVentClick(Sender: TObject);
    procedure btnVentDeDroiteClick(Sender: TObject);
  private
    { D�clarations priv�es }
    Vent: TVent;
    NbFlocons: integer;
  public
    { D�clarations publiques }
  end;

const
  CNbMaxFlocons = 100;

var
  Form18: TForm18;

implementation

{$R *.fmx}

procedure TForm18.animFloconsTimer(Sender: TObject);
var
  Flocon: TCircle;
  i: integer;
  x, y: single;
begin
  if (NbFlocons < CNbMaxFlocons) and (random(100) < 50) then
  begin
    Flocon := TCircle.Create(self);
    case random(3) of
      0:
        Flocon.parent := ZIndex0;
      1:
        Flocon.parent := ZIndex1;
    else
      Flocon.parent := ZIndex2;
    end;
    Flocon.Fill.Kind := TBrushKind.Solid;
    Flocon.Fill.Color := talphacolors.white;
    Flocon.Stroke.Kind := TBrushKind.None;
    Flocon.Width := random(10) + 3;
    Flocon.height := Flocon.Width;
    case Vent of
      TVent.VersLaGauche:
        if random(100) < 50 then
          Flocon.Position.Point := pointf(random(clientwidth), -Flocon.height)
        else
          Flocon.Position.Point := pointf(clientwidth, random(clientheight));
      TVent.VersLaDroite:
        if random(100) < 50 then
          Flocon.Position.Point := pointf(random(clientwidth), -Flocon.height)
        else
          Flocon.Position.Point := pointf(-Flocon.Width, random(clientheight));
    else
      Flocon.Position.Point := pointf(random(clientwidth), -Flocon.height);
    end;
    inc(NbFlocons);
  end;
  for i := ComponentCount - 1 downto 0 do
    if (components[i] is TCircle) then
    begin
      Flocon := (components[i] as TCircle);
      case Vent of
        TVent.VersLaGauche:
          x := Flocon.Position.x + random(4) - 3; // -3 � 0
        TVent.VersLaDroite:
          x := Flocon.Position.x + random(4); // 0 � 3
      else
        x := Flocon.Position.x + random(7) - 3; // -3 � 3
      end;
      y := Flocon.Position.y + random(5);
      Flocon.Position.Point := pointf(x, y);
      if Flocon.Position.y > clientheight then
      begin
        Flocon.free;
        dec(NbFlocons);
      end;
    end;
end;

procedure TForm18.btnVentDeGaucheClick(Sender: TObject);
begin
  Vent := TVent.VersLaDroite;
end;

procedure TForm18.btnPasDeVentClick(Sender: TObject);
begin
  Vent := TVent.Aucun;
end;

procedure TForm18.btnVentDeDroiteClick(Sender: TObject);
begin
  Vent := TVent.VersLaGauche;
end;

procedure TForm18.FormCreate(Sender: TObject);
begin
  Vent := TVent.Aucun;
  ZIndex0.BringToFront;
  ZIndex1.BringToFront;
  ZIndex2.BringToFront;
  zoneBoutons.BringToFront;
  Canard2.InitialiseZoneDeDeplacement;
  Canard2.BougeLeCanardDeGaucheADroite;
  Canard1.InitialiseZoneDeDeplacement;
  Canard1.BougeLeCanardDeDroiteAGauche;
end;

procedure TForm18.FormResize(Sender: TObject);
begin
  Canard2.InitialiseZoneDeDeplacement;
  Canard1.InitialiseZoneDeDeplacement;
end;

initialization

randomize;

end.
