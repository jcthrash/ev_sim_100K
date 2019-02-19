%% MATLAB script to estimate expectation outcomes for cultivation experiments
%% across numerous isolate cultivation probabilities and values
%% Code written by Naomi M. Levine and modified by J. Cameron Thrash,
%% Department of Biological Sciences, University of Southern California
%% CC BY-NC 4.0  

%% Define you # 
ExperimentC=-100000;
Cp90a=[5 10 50 100 200 250 300 350 400 450 500 600 650 700 800];
Cp90b=[5 10 50 100 200 250 300 350 400 450 500 600 650 700 800];
Cp50=[5 10 20 50 100 150 200 250 300 350 400 450 500 600];
Cp25=[5 10 20 30 40 50 60 70 80 90 100 120 140 150 200];
Cp10=[1 5 10 15 25 50 70 90];
Cp05=[1 5 10 15 25 50 70 90];
Cp01a=[1 2 5 10 15 20];
Cp01b=[1 2 3 4 5 7 10];
Cp001=[1 2 3 4 5 7 10];


Cp=[.9 .9 .5 .25 .1 .05 .01 .01 .001];
ii=[500 1000 2000 50000 200000 200000 500000 1000000 10000000];
HighThreshold=.5;  %Cp values of this # and higher will be included as High, everything else -> low


Np=1-Cp;
iHigh=find(Cp>=HighThreshold);
iLow=find(Cp<HighThreshold);
qq=1;

for h=1:length(Cp90a)
    for i=1:length(Cp90b)
        for j=1:length(Cp50)
            for k=1:length(Cp25)
                for l=1:length(Cp10)
                    for m=1:length(Cp05)
                        for n=1:length(Cp01a)
                            for o=1:length(Cp01b)
                                for p=1:length(Cp001)

                                    %Define # vector
                                    NumVect=[Cp90a(h) Cp90b(i) Cp50(j) Cp25(k) Cp10(l) Cp05(m) Cp01a(n) Cp01b(o) Cp001(p)];
                                    SumIsolates(qq)=sum(NumVect);
                                    Cpi= ExperimentC./SumIsolates(qq);
                                    Ex=NumVect.*Cpi;

                                    EV=(Np.*Ex)+(Cp.*ii);
                                    EVsum=EV.*NumVect;
                                    sumEvsum(qq)=sum(EVsum);
                                    RatioLow(qq)=sum(NumVect(iHigh))./sum(NumVect(iLow));
                                    qq=qq+1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

[I]=find(sumEvsum>0);
[J]=find(sumEvsum<0);

figure(1)
h1=plot(SumIsolates(J), RatioLow(J), 'o');
hold on
h2=plot(SumIsolates(I), RatioLow(I), '*');
legend([h1 h2], 'EV=neg', 'EV=pos')
xlim([0 1500])
ylim([0 7])
xlabel('Isolates')
ylabel('Low:High value isolates')
print('-f1', '-dpdf', '-r0', '100K_large2rr')
                           
                                
                                
                                
                                
