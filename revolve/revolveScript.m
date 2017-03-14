% examples for using revolveFunction
% with MATLAB contour data
% each contour contains a single line
% Nima Tofighi (2016)
clc
clear all
close all

% axisymmetric spherical cap bubble
ds=0.0001;
cax=0.0;
load('contour_cap.mat','-mat')
cx=c(1,2:end);
cy=c(2,2:end);

[kkt, xxt, yyt, zzt]=revolveFunction(cx,cy,cax,ds);

figure
trisurf(kkt,xxt,zzt,yyt,...
    'edgecolor','none','facealpha',0.5,'facecolor','blue',...
    'facelighting','gouraud','diffusestrength',0.9);
hold on
plot3(cx,cy*0,cy,'rx-')
view(3)
light('Position',[-1 0 1],'Style','local')
light('Position',[0 1 0],'Style','local')
axis equal
xlabel('x')
ylabel('z')
zlabel('y')
box on

% axisymmetric ring bubble
load('contour_cap.mat','-mat')
cx=c(1,2:end);
cy=c(2,2:end);

[kkt, xxt, yyt, zzt]=revolveFunction(cx,cy,cax,ds);

figure
trisurf(kkt,xxt,zzt,yyt,...
    'edgecolor','none','facealpha',0.5,'facecolor','blue',...
    'facelighting','gouraud','diffusestrength',0.9);
hold on
plot3(cx,cy*0,cy,'rx-')
view(3)
light('Position',[-1 0 1],'Style','local')
light('Position',[0 1 0],'Style','local')
axis equal
xlabel('x')
ylabel('z')
zlabel('y')
box on
