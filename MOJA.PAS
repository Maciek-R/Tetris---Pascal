UNIT MOJA;

INTERFACE
Uses Crt, Graph;

Var
   i,j:integer;
   ster,tryb:integer;
   w:char;
   x1,x2,y1,y2:integer;
   Tab: array [-1..10, -4..20] of Integer;
   m,n:integer;
   k,l:integer;
   b,v:byte;
    Klocek:array [1..4, 1..4] of Byte;
    p,o:byte;
    S,D:integer;
    Q:Boolean;
    numer, R,U:byte;
    Ustal:byte;
    Predkosc,speed:integer;
    Los,Kos:byte;
    F:byte;
    Odpowiedz:char;
    punkt:longint;

    Procedure Obudowa;
    Procedure Czarny (x1,y1,x2,y2:integer;cos:byte);
    Procedure Ustalenie (numer,ustal:byte);
    Procedure Losowanie;
    Procedure Obracanie (R:byte);
    Procedure Figura (x1,y1,x2,y2:integer);
    Function Sprawdz:Boolean;
    Procedure Zaznacz;
    Procedure LewaPrawa (strona:byte);
    Procedure Usun (x1,y1,x2,y2:integer);
    Function Mozliwosc:Boolean;
    Procedure Sterowanie (w:char);
    Procedure Wypelnienie;
    Procedure Odswiez;
    Procedure Usun_Linie (poziom:byte);
    Procedure Spr_Linie;
    Procedure Koniec;
    Procedure Next;
    Procedure Pytanie;
    Procedure Punkty;
    Procedure Glowny_Program;

IMPLEMENTATION

                                             {Rysuje obudowe}
                Procedure Obudowa;
                     Var x1,x2,y1,y2,i,j:integer;

                       Begin
                     SetColor (2);
                     SetFillStyle (10,2);

                       x1:=220;
                       x2:=239;
                       y1:=0;
                       y2:=19;
                       for j:=-4 to 20 do
                       for i:=-1 to 10 do
                         if Tab [i,j]=-1 then
                       Bar (x1+i*20,y1+j*20,x2+i*20,y2+j*20);
                       end;

                                                             {Wymazuje slady poprzesunieciu}

                    Procedure Czarny (x1,y1,x2,y2:integer;cos:byte);
                                                                      (*1-praw¥ strone usuwa*)
                         Begin

                         SetColor(0);
                         SetFillStyle(1,0);

                            Case cos of
                              1:
                              begin                                      (*2-lew¥ strone usuwa*)
                              for S:=1 to 4 do
                              for D:=1 to 4 do
                                if Klocek [D,S]=2 then
                                  begin
                                    Bar (x1+D*20+20,y1+S*20-20,x2+D*20+20,y2+S*20-20);
                                  end;
                                end;
                               2:
                                begin
                                 for S:=1 to 4 do
                                 for D:=1 to 4 do
                                  if Klocek [D,S]=2 then
                                   begin
                                     Bar (x1+D*20-20,y1+S*20-20,x2+D*20-20,y2+S*20-20);
                                   end;

                                end;

                            end;
                         END;
                                                                {Ustala w 2D tablicy jak wygladaja figury}

                        Procedure Ustalenie (numer,ustal:byte);
                           Begin

                        for o:=1 to 4 do for p:=1 to 4 do
                        Klocek [p,o]:=3;

                      Case numer of
                      1:                         {Kwadrat}
                      begin
                        Case ustal of
                         1:
                         begin
                          Klocek [2,2]:=2;
                          Klocek [3,2]:=2;
                          Klocek [2,3]:=2;
                          Klocek [3,3]:=2;
                         end;
                         end;
                      end;

                      2:                         {Odwrocone T}
                      begin
                        {if Ustal=5 then ustal:=1;  }
                         Case Ustal of
                         1:
                         begin
                          Klocek [3,1]:=2;
                          Klocek [2,2]:=2;
                          Klocek [3,2]:=2;
                          Klocek [4,2]:=2;
                         end;

                          2:
                           begin
                            Klocek [3,1]:=2;
                            Klocek [2,2]:=2;
                            Klocek [3,2]:=2;
                            Klocek [3,3]:=2;
                           end;

                         3:
                         begin
                          Klocek [2,2]:=2;
                          Klocek [3,2]:=2;
                          Klocek [4,2]:=2;
                          Klocek [3,3]:=2;
                         end;

                         4:
                         begin
                          Klocek [3,1]:=2;
                          Klocek [3,2]:=2;
                          Klocek [3,3]:=2;
                          Klocek [4,2]:=2;
                         end;


                          end;
                      end;

                      3:                         {Patyk}
                      begin

                        Case Ustal of
                         1:
                         begin
                          Klocek [3,1]:=2;
                          Klocek [3,2]:=2;
                          Klocek [3,3]:=2;
                          Klocek [3,4]:=2;
                          end;
                         2:
                          begin
                           Klocek [1,2]:=2;
                           Klocek [2,2]:=2;
                           Klocek [3,2]:=2;
                           Klocek [4,2]:=2;
                          end;

                          end;
                      end;

                      4:                         {Odwrocone Z}
                      begin
                           Case Ustal of
                           1:
                           begin
                          Klocek [3,2]:=2;
                          Klocek [4,2]:=2;
                          Klocek [2,3]:=2;
                          Klocek [3,3]:=2;
                            end;

                          2:
                          begin
                           Klocek [3,1]:=2;
                           Klocek [3,2]:=2;
                           Klocek [4,2]:=2;
                           Klocek [4,3]:=2;
                          end;
                      End;
                      end;

                      5:
                      begin
                         Case Ustal of
                         1:
                         begin
                          Klocek [2,2]:=2;       {Z}
                          Klocek [3,2]:=2;
                          Klocek [3,3]:=2;
                          Klocek [4,3]:=2;
                         end;

                         2:
                          begin
                           Klocek [4,1]:=2;
                           Klocek [3,2]:=2;
                           Klocek [4,2]:=2;
                           Klocek [3,3]:=2;
                          end;
                       End;
                      End;

                      6:                         {L}
                      begin
                        Case Ustal of
                        1:
                        begin
                          Klocek [3,1]:=2;
                          Klocek [3,2]:=2;
                          Klocek [3,3]:=2;
                          Klocek [4,3]:=2;
                        end;

                        2:
                        begin
                          Klocek [4,1]:=2;
                          Klocek [2,2]:=2;
                          Klocek [3,2]:=2;
                          Klocek [4,2]:=2;
                        end;

                        3:
                        begin
                          Klocek [2,1]:=2;
                          Klocek [3,1]:=2;
                          Klocek [3,2]:=2;
                          Klocek [3,3]:=2;
                        end;
                        4:
                        begin
                          Klocek [2,2]:=2;
                          Klocek [3,2]:=2;
                          Klocek [4,2]:=2;
                          Klocek [2,3]:=2;

                        end;

                        End;
                      End;

                     7:                         (*Odwrocone L*)
                      begin
                       Case Ustal of
                          1:
                          begin
                           Klocek [3,1]:=2;
                           Klocek [3,2]:=2;
                           Klocek [3,3]:=2;
                           Klocek [2,3]:=2;
                          end;

                          2:
                          begin
                           Klocek [2,2]:=2;
                           Klocek [3,2]:=2;
                           Klocek [4,2]:=2;
                           Klocek [4,3]:=2;
                          end;

                          3:
                           begin
                            Klocek [3,1]:=2;
                            Klocek [3,2]:=2;
                            Klocek [3,3]:=2;
                            Klocek [4,1]:=2;
                           end;

                          4:
                           begin
                            Klocek [2,1]:=2;
                            klocek [2,2]:=2;
                            Klocek [3,2]:=2;
                            Klocek [4,2]:=2;
                           end;
                        End;
                      End;
                      End;
                      End;
                                        {Losuje Kolor i klocek}
                      Procedure Losowanie;
                         Begin
                         Randomize;

                           if F=0 then
                            begin
                            R:=random(7)+1;
                            U:=random(9)+1;
                            Los:=random(7)+1;
                            Kos:=random(9)+1;
                            end

                            else
                             begin
                              R:=Los;
                              U:=Kos;
                              Los:=random(7)+1;
                              Kos:=random(9)+1;
                             end;

                            F:=1;
                         End;
                                                        {Sˆu¾y do nieskoäczonego obracania}
                      Procedure Obracanie (R:byte);
                           Begin
                             Case R of
                               1: ustal:=1;
                               2: if ustal=5 then ustal:=1;
                               3: if ustal=3 then ustal:=1;
                               4: if ustal=3 then ustal:=1;
                               5: if ustal=3 then ustal:=1;
                               6: if ustal=5 then ustal:=1;
                               7: if ustal=5 then ustal:=1;
                             end;
                           End;


                                                         {Rysuje figure i jednoczesnie maluje na
                                                          czarno t¥ figure ktora jest za nia}
           Procedure Figura (x1,y1,x2,y2:integer);

                     Begin
                          SetColor(0);
                          SetFillStyle(1,0);
                             for o:=1 to 4 do
                             for p:=1 to 4 do
                             begin
                             if Klocek [p,o]=2 then
                          Bar (x1+p*20,y1+o*20-20,x2+p*20,y2+o*20-20);
                             end;

                          SetColor (15);
                          SetFillStyle(1,15);
                            for o:=1 to 4 do
                            for p:=1 to 4 do
                            begin
                            if Klocek [p,o]=2 then
                          Bar (x1+p*20,y1+o*20,x2+p*20,y2+o*20);
                            end;
                            delay (Predkosc);
                     End;
                                                  {sprawdza czy mo¾e si© ruszy† na d¢ˆ}
                         Function Sprawdz:Boolean;

                             Begin
                                  Sprawdz:=true;

                             for S:=1 to 4 do
                             for D:=1 to 4 do
                                begin
                                  if Klocek [D,S]=2 then
                                  begin
                                    if Tab[n+D,i+S]<>0 then begin Sprawdz:=false; end;
                                  end;
                                end;
                             End;
                                   {Zaznacza w tablicy figure, aby nic nie moglo na nia wejsc}
                         Procedure Zaznacz;
                             Begin
                             for S:=1 to 4 do
                             for D:=1 to 4 do
                              if Klocek [D,S]=2 then
                                Begin
                                Tab [n+D,i+S-1]:=U;
                                SetColor (U);
                                SetFillStyle (U,U);
                                Bar (x1+k+D*20,y1+(i-1)*20+S*20,x2+k+D*20,y2+(i-1)*20+S*20);
                                end;
                             End;
                                                  {Sprawdza czy mo¾e sie ruszyc w bok, ale to wlasnie cos nie dziala :(}
                             Procedure LewaPrawa (strona:byte);     {1-lewa}
                                  Begin
                                       Q:=true;                    {2-prawa}
                                     Case strona of
                                      1:
                                       begin
                                         for S:=1 to 4 do
                                         for D:=1 to 4 do
                                           if Klocek [D,S]=2 then
                                               begin
                                                 if Tab [n+D-1,i+S]<>0 then Q:=false;
                                               end;
                                       end;

                                       2:
                                        begin
                                            for S:=1 to 4 do
                                            for D:=1 to 4 do
                                              if Klocek [D,S]=2 then
                                               begin
                                                 if Tab [n+D+1,i+S]<>0 then Q:=false;
                                               end;
                                        end;

                                     end;
                                  End;

                             Procedure Usun (x1,y1,x2,y2:integer);    {Usuwa cienie po obrocie}
                                Begin
                                     SetColor (0);
                                     SetFillStyle (1,0);

                                      for S:=1 to 4 do
                                      for D:=1 to 4 do
                                       if Klocek [D,S]=2 then
                                       begin
                                         Bar (x1+D*20,y1+S*20-20,x2+D*20,y2+S*20-20);
                                       end;
                                End;

                                                 {Sprawdza czy mozna obrocic klocek}
                               Function Mozliwosc:Boolean;
                               Begin
                                Mozliwosc:=true;
                                   for S:=1 to 4 do
                                   for D:=1 to 4 do
                                    if Tab [n+D,i+S]<>0 then Mozliwosc:=false;
                                 End;
                                               {Ruchy na boki i obracanie}
                         Procedure Sterowanie (w:char);
                             Begin

                               Case w of
                           'w':
                           Begin
                            if Mozliwosc=true then
                               begin
                               Usun (x1+k,y1+i*20,x2+k,y2+i*20);

                                 Ustal:=Ustal+1;
                                 Obracanie (R);
                                 Ustalenie (R,Ustal);
                               end;
                           End;
                           'p':
                           begin
                               Repeat
                               w:=readkey;
                               Until w='p';
                           end;
                           's':
                               begin
                                  Predkosc:=50;
                               end;
                           'a':
                                 begin
                              LewaPrawa(1);

                                 if Q=true
                                 then

                                 begin
                                    n:=n-1;
                                    k:=n*20;
                                   Czarny (x1+k,y1+i*20,x2+k,y2+i*20,1);
                                 end;
                                 end;
                           'd':
                                 begin
                             LewaPrawa(2);

                                if Q=true
                                then
                                begin
                                  n:=n+1;
                                  k:=n*20;
                                 Czarny (x1+k,y1+i*20,x2+k,y2+i*20,2);
                                end;


                                 end;

                           End;
                             End;
                                                 {ustawia czarne pole}
                           Procedure Wypelnienie;
                           Var i,j:byte;
                             Begin
                               for j:=0 to 19 do
                               for i:=0 to 9 do
                               begin
                                   if Tab[i,j]=0 then
                                    begin
                                     SetColor(0);
                                     SetFillStyle(1,0);
                                     Bar (x1+i*20,y1+j*20,x2+i*20,y2+j*20)
                                    end;
                               end;

                             End;
                          Procedure Odswiez;
                           Var i,j:byte;
                             Begin
                                for j:=0 to 19 do
                                for i:=0 to 9 do
                                 begin
                                   if Tab[i,j]<>0 then
                                    begin
                                     SetColor (Tab[i,j]);
                                     SetFillStyle (Tab[i,j]+1,Tab[i,j]);
                                     Bar (x1+i*20,y1+j*20,x2+i*20,y2+j*20);
                                    end;
                                 end;

                             End;
                                                  {Usuwa linie oraz przesuwa o 1 w dol gorne klocki}
                       Procedure Usun_Linie (poziom:byte);
                       Var i,j:byte;


                         Begin
                           for i:=0 to 9 do
                           begin
                            Tab [i,poziom]:=0;
                           end;

                           for j:=poziom downto 0 do
                           for i:=0 to 9 do
                            if Tab[i,j]<>0 then begin Tab[i,j+1]:=Tab[i,j]; Tab[i,j]:=0; end;


                           Wypelnienie;

                        End;
                                                  {Sprawdza linie do usuniecia}
                   Procedure Spr_Linie;
                   Var z:byte;
                        Begin
                       for z:=1 to 4 do
                       Begin
                            Q:=true;

                             for j:=0 to 19 do
                               begin
                            Q:=true;
                             for i:=0 to 9 do
                               begin
                               IF TAB [i,j]=0 then Q:=false
                               end;
                             if Q=true then Usun_Linie (j);
                             end;
                         End;
                        END;

                       Procedure Koniec;
                        Begin
                             SetTextStyle (1,0,3);
                             OutTextXY (290,240,'GAME OVER');
                             OutTextXY (280,450,'Nacisnij ESC');
                               Repeat
                               w:=readkey;
                               Until w=chr(27);

                        End;

                       Procedure Next;
                       Var x1,y1,x2,y2:word;
                        Begin
                        x1:=491;
                        x2:=510;
                        y1:=100;
                        y2:=119;
                        SetColor(0);
                        SetFillStyle(1,0);
                        Bar (510,60,600,100);

                        SetColor (random(7)+1);
                        SetTextStyle (1,0,1);
                        OutTextXY (520,80, 'Nastepny:');

                         Ustalenie (Los,1);
                        SetColor(0);
                        SetFillStyle(1,0);
                       for S:=1 to 4 do
                       for D:=1 to 4 do
                         Bar (x1+D*20,y1+S*20,x2+D*20,y2+S*20);

                        SetColor(Kos);
                        SetFillStyle(Kos+1,Kos);
                        for S:=1 to 4 do
                        for D:=1 to 4 do
                         if Klocek[D,S]=2 then
                          Bar (x1+D*20,y1+S*20,x2+D*20,y2+S*20);
                        End;

                       Procedure Pytanie;
                             Begin
                               SetTextStyle(1,0,1);
                             OutTextXY(451,300, 'Jeszcze raz (T/N)?');
                              Repeat
                               Odpowiedz:=Upcase(readkey);
                              Until (Odpowiedz='T') or (Odpowiedz='N');
                             End;

                       Procedure Punkty;
                       Var s:string;
                        Begin
                        SetColor(0);
                        SetFillStyle(1,0);
                          Punkt:=punkt+1;
                          Str (punkt,S);
                        Bar (30,60,120,110);
                          SetColor(random(7)+1);
                          SetTextStyle(1,0,1);
                          OutTextXY (40,70, 'Punkty: ');
                          OutTextXY (40,90, S);

                        End;




Procedure Glowny_Program;

BEGIN
x1:=220;
x2:=239;
y1:=0;
y2:=19;

Repeat

        for m:=-4 to 20 do
        for n:=0 to 9 do             {Zaznacza na 0 przestrzen gdzie moze sie poruszac klocek}
            Tab [n,m]:=0;

        for n:=0 to 9 do Tab[n,20]:=-1;          {Podloga}

        for m:=-4 to 20 do Tab [-1,m]:=-1;       {Lewa sciana}

        for m:=-4 to 20 do Tab [10,m]:=-1;       {Prawa Sciana}


     DetectGraph (ster,tryb);
     Initgraph(ster, tryb, 'C:/Dos/TP/BGI');

     SetTextStyle(1,0,2);
     OutTextXY (40,140, 'A - w lewo');
     OutTextXY (40,170,'D - w prawo');
     OutTextXY (40,200,'W - obroc');
     OutTextXY (40,230,'S - upusc');
     OutTextXY (40,260,'P - pauza');
     OutTextXY (40,320,'ESC - Wyjdz');

     OutTextXY (580,370,'by');
     SetTextStyle(1,0,2);
     OutTextXY (470,400,'Maciej Ruszczyk');


     Obudowa;

     Delay(3000);
     F:=0;

     Predkosc:=1200;
     Speed:=predkosc;

     punkt:=0;

     Repeat
     Ustal:=1;
     Losowanie;

     Next;

     Ustalenie (R,Ustal);



     x1:=220;
     x2:=239;
     y1:=0;
     y2:=19;

i:=-4;
m:=0;
n:=2;
k:=n*20;


        if speed-1>=50 then
        begin
        speed:=speed-1;
        Predkosc:=speed;
        end;                          {Predkosc}

         Repeat

      k:=n*20;



       Repeat
    if (Sprawdz=true) then
    begin
      Figura (x1+k,y1+i*20,x2+k,y2+i*20);
    m:=m+1;
     i:=i+1;
    end;
       Until (keypressed) or (Sprawdz=false);




        for b:=0 to 9 do
          if Tab[b,-1]<>0 then begin break; end;


         if keypressed then
         begin
          w:=readkey;
          Sterowanie (w);
         end;

         if w=chr(27) then break;

         Until (Sprawdz=false);
         Zaznacz;
         Punkty;
         Spr_Linie;
         Odswiez;

         if Tab[b,-1]<>0 then begin Koniec; break; end;

      Until  (w=chr(27));
   Pytanie;
 Until Odpowiedz='N';

END;


BEGIN
END.

