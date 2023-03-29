% This script takes as input the next values of an artificial Wigley hull
% and processes them into a .csv file in order to implement it in
% Rhinoceros. Made as an academic practice excercise.
%
% pieq3, 29/03/2023
% v2

clc;
clear;

%_________excercise's data__________
T = 10; % draft
B = 10; % breadth
L = 40; % overall length
N = 20; % number of sections
fr = L/N; % length between frames (constant)
p = 20; % points per section (10 per side)
wl = T/p; % space between waterlines (constant)


%_________export preparation__________
A = zeros((N+1)*(p+1),3);
A(1:N+1,1) = -L/2;

    for i = 1 : max(N,p)
        if i <= N
            A(i+1,1) = A(i,1) + fr; %calculates the "x" values
        end

        if i <= p
            A(i+1,3) = A(i,3) - wl; %calculates the "z" values
        end
    end

Yser = [A(1:max(N,p)+1,1) , (-1) * flip(A(1:max(N,p)+1,3))]; %this matrix stores the x and (positive) z values for the carene diritte export




%_______________export Rhino________________

A(1:(N+1)*(p+1),1) = repelem(A(1:N+1,1) , p+1);         %this and the next line are "adjustaments" in order to evaluate
A(1:(N+1)*(p+1),3) = repmat(A(1:p+1,3) , (N+1) , 1);    %tidily every y considering a constant x and every waterplane, top-bottom
A(1:(N+1)*(p+1),2) = B/2*(1-(2*A(1:(N+1)*(p+1),1)/L).^2).*(1-(A(1:(N+1)*(p+1),3)/T).^2); %y

writematrix(A,'carenawigley.csv')




% ____________export carene diritte____________

%the next for loop is made to obtain the matrix form of the y values; each
%column is a transversal section, each line is the y values along the same
%waterplane
Y = zeros(N+1,p+1);
    for i = 1:N+1
        for j = 1:p+1
            Y(j,i) = B/2*(1-(2*Yser(i,1)/L)^2)*(1-(A(j,3)/T)^2);
        end
    end

writematrix(Yser(:,1),'carenawigley.xlsx', 'Sheet',1,'range','A1');
writematrix(Yser(:,2),'carenawigley.xlsx', 'Sheet',1,'range','B1'); 
writematrix(Y,'carenawigley.xlsx', 'Sheet',2);







