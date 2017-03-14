function [kkt, xxt, yyt, zzt]=revolveFunction(cx,cy,cax,ds)

% Help for revolveFunction: Revolves a single closed or open curve in x-y
% plane around an axis parallel to the y-axis to create a three dimensional
% surface.
% use: [kkt, xxt, yyt, zzt]=revolveFunction(cx,cy,cax,ds);
% input:
%   cx:  curve - vector of x coordinate
%   cy:  curve - vector of y coordinate
%   cax: revolution axis paralle to y - x coordinate
%   ds:  resolution
% output:
%   kkt: triangulation connectivity list
%   xxt: revolved points - vector of x coordinate
%   yyt: revolved points - vector of y coordinate
%   zzt: revolved points - vector of z coordinate
% plot:  
%   trisurf, trimesh, patch or any other compatible plotting function
%
% example:
%   cx=[1 2 3 2 1];
%   cy=[1 2 1 0 1];
%   cax=0;
%   ds=0.1;
%   [kkt, xxt, yyt, zzt]=revolveFunction(cx,cy,cax,ds);
%   trisurf(kkt,xxt,zzt,yyt)
%
% Nima Tofighi (2016)

lt=1;
xxt=[];yyt=[];zzt=[];kkt=[];
for i=1:length(cx)
    xxn=[];yyn=[];zzn=[];
    ln(i)=1;
    xxn(ln(i),1)=cx(i);
    yyn(ln(i),1)=cy(i);
    zzn(ln(i),1)=0;
    rr=abs(cx(i)-cax);
    pr=2*pi*rr;
    if rr>0
        np=max(3,round(pr/ds));
        for j=1:np-1
            ln(i)=ln(i)+1;
            xxn(ln(i),1)=cax+rr*cos(2*pi*j/np);
            yyn(ln(i),1)=cy(i);
            zzn(ln(i),1)=rr*sin(2*pi*j/np);
        end
    end
    if i>1
        xxd=[xxo; xxn];
        yyd=[yyo; yyn];
        zzd=[zzo; zzn];
        dt=delaunayTriangulation(xxd,yyd,zzd);
        [kk,~]=convexHull(dt);
        ld=0;
        ct=0;
        for j=1:size(kk,1)
            pt=unique(yyd(kk(j,:)));
            if length(pt)>1
                ld=ld+1;
                ct(ld)=j;
            end
        end
        kkd=kk(ct,:);
        if i==2
            kkt=[kkt;kkd];
        elseif i==3
            kkt=[kkt;kkd+ln(i-2)];
        else
            kkt=[kkt;kkd+sum(ln(1:i-2))];
        end
    end
    xxo=xxn;
    yyo=yyn;
    zzo=zzn;
    xxt=[xxt; xxn];
    yyt=[yyt; yyn];
    zzt=[zzt; zzn];
end