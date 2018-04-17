clear all;  clc;

w1=[33.7 62 3.4];
w2=[39 61.5 6.5];

LR=0.5;

name = 'HabermanData.txt';
M = dlmread(name, ',');
M=M(1:140,:);
y1=1;
y2=2;
x1=M(:,1);x2=M(:,2);x3=M(:,3);   % x1:ya� attribute, x2:y�l attribute, x3=nod�l say�s�
target=M(:,4);                                % target:hayatta kalma durumu attribute

iterasyon=0;

while iterasyon<70000                % optimal iterasyon say�s�
    for i=1:length(M)                       % veri say�s� kadar d�ng�ye girer
        d1=sqrt(((x1(i)-w1(1))^2+(x2(i)-w1(2))^2+(x3(i)-w1(3))^2));   % referans vekt�rlerinin (d1,d2) �klid mesafesi kullan�larak hesaplanmas�
        d2=sqrt(((x1(i)-w2(1))^2+(x2(i)-w2(2))^2+(x3(i)-w2(3))^2));    
        
        X=[x1(i),x2(i),x3(i)];    
                
        if d1<d2                % referans vekt�rlerinin kar��la�t�r�lmas�
            DW=LR*(X-w1);
            DW2=LR*(X-w2);
            
            if y1==target(i)    % do�ru s�n�f kontrol� 
                w1=w1+DW;       %d1'e ba�l� referans vekt�r�n�n yak�nla�t�r�lmas�               
                w2=w2-DW2;        %d2'e ba�l� referans vekt�r�n�n uzakla�t�r�lmas�
            else             
                w1=w1-DW;        % yanl�� ise d1'e ba�l� referans vekt�r�n�n uzakla�t�r�lmas�
                w2=w2+DW2;        % d2'e ba�l� referans vekt�r�n�n yak�nla�t�r�lmas�
            end        
            
        else             
            DW=LR*(X-w2);            
            DW1=LR*(X-w1);
            
            if y2==target(i)                
                w2=w2+DW;
                w1=w1-DW1;
            else
                w2=w2-DW;
                w1=w1+DW1;
            end
        end
    end  
  
    if iterasyon==50000 
        LR=LR-0.2;
    end   
    
    if LR<=0
        display('LR-----');
        break;
    end
   
   
iterasyon=iterasyon+1;  
disp(iterasyon);
end
