%%Setting up strain
t=0:0.001:2.01;
strain=10*sin(2*pi*10*t);
%%Defining Intesnity
i=1;
for t=0:0.001:2.01
    In(i)=cos(strain(i));
    i=i+1;
end
%%Changing phase of intensity by 90
i=1;
for t=0:0.001:2.01
    In_90(i)=cos(strain(i)+pi/2);
    i=i+1;
end
%%plotting strain,Intensity and phase moudlated intensity vs time
t=0:0.001:2.01;
figure(1);
plot(t,strain);
set(gca,'FontSize',25);
title('Original Strain','FontSize',30);
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
figure(2);plot(t,In,'-rd');
set(gca,'FontSize',25);
title('Original Intensity','FontSize',30);
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
figure(3);plot(t,In_90);
set(gca,'FontSize',25);
title('Phase modulated Intensity','FontSize',30);
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
%Defining the derivative terms
Diff1=[];
Diff2=[];
i=2;
Diff1(1)=0;
Diff2(1)=0;
for t=0.001:0.001:2.01
    Diff1(i)=In_90(i)*(In(i)-In(i-1));
    Diff2(i)=In(i)*(In_90(i)-In_90(i-1));
    i=i+1;
end
%The difference between crossmultiplied and integral terms, that is the
%term being integrated
I=[];
i=1;
for t=0:0.001:2.01
    I(i)=Diff1(i)-Diff2(i);
    i=i+1;
end
%%Integrating the Integrand by using trapezoid function
i=1;
demod=zeros(size(strain));
for t=0:0.001:2.01
    sum=[];
    for j=i:-1:1
        sum=[sum I(j)];
    end
    demodgg(i)=trapz(sum);
    i=i+1;
end   
%%Plotting strain and demodulated strain
t=0:0.001:2.01;
figure(4);
subplot(2,1,1);
plot(t,strain,'-rd');
set(gca,'FontSize',25);
title('Original Strain','FontSize',30);
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
subplot(2,1,2);
plot(t,demodgg,'-bd');
set(gca,'FontSize',25);
title('Demodulated Strain','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);


