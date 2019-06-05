%Setting up strain function
%The strain function is defined here and you can change the function into any other type of equation and the code will still function.
%For example you could use a linearly varying strain function like strain = 0.2*t and try it out. The code can still extract the 
%the information from the input intensity.
Fm=10;
Fs=100;
i=1;
undemodf=[];
Fc=50;
phase0=pi;
t=0:0.001:2.01;
strain=10*sin(2*pi*10*t);
%plotting strain function with time
figure(1);title('Original Strain');plot(t,strain,'-bd');
set(gca,'FontSize',15);
xlabel('Time(s)','FontSize',20);
ylabel('Strain','FontSize',20);
%Setting up intensity
In=zeros(size(strain));
for t=0:0.001:2.01
    In(i)=cos(strain(i));
    i=i+1;
end
%Setting up intensity function and plotting intensity
t=0:0.001:2.01;
figure(2);title('Original Intensity');
plot(t,In,'-rd'); 
set(gca,'FontSize',25);
xlabel('Time(s)','FontSize',30);
ylabel('Intensity','FontSize',30);
xlim([0 0.2]);%%zooming along x-axis
%Setting up the white noise
NoiseIn=awgn(In,5,'measured');%%5 dB SNR
%Implementing low pass filter
FilterIn=lowpass(NoiseIn,0.5);
%Comparing noise and noise free intensity signals
t=0:0.001:2.01;
figure(3);
subplot(2,1,1)
plot(t,In,'-rd');
set(gca,'FontSize',25);
title('Intensity-no noise');
ylabel('Intensity','FontSize',30);
xlabel('time(s)','FontSize',30);
xlim([0 0.2]);
subplot(2,1,2)
plot(t,FilterIn,'-bd');
title('Intensity-White noise');
set(gca,'FontSize',20);
ylabel('Intensity','FontSize',30);
xlabel('time(s)','FontSize',30);
xlim([0 0.2]);
%adding 90 phase and demodulating
In_90=zeros(size(strain));
demod=zeros(size(strain));
kk=1;
for t=0:0.001:2.01
    In_90(kk)=cos(strain(kk)+pi/2);
    demod(kk)=-atan2(In_90(kk), In(kk));
    kk=kk+1;
end
%plotting intensity where phase is changed by 90
t=0:0.001:2.01;
figure(4);title('Intensity phase modulated by 90');
plot(t,In_90,'-rd');
xlim([0 0.2]);
set(gca,'FontSize',25);
xlabel('Time(s)','FontSize',30);
ylabel('Intensity','FontSize',30);
%setting up unwrapping and plotting unwrapped graph
undemod=unwrap(demod);
%Plotting filtered demodulated strain and Original strain-Sin Noise
t=0:0.001:2.01;
figure(5);title('Original strain and Demodualted filtered sin noise strain vs time');
plot(t,[undemod;strain]);
set(gca,'FontSize',25);
legend('Filtered Demodulated Strain-sin noise','Original Strain');
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
xlim([0 0.2]);
t=0:0.001:2.01;
%Plotting demodualted strain
figure(6);
subplot(2,1,1);
plot(t,strain,'--d');
set(gca,'FontSize',25);
title('Original Strain','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
subplot(2,1,2);
plot(t,undemod,':rd');
set(gca,'FontSize',25);
title('Demodulated Strain','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
%adding 90 phase and demodulating for filtered data
demodf=zeros(size(strain));
kk=1;
for t=0:0.001:2.01
    demodf(kk)=-atan2(In_90(kk), FilterIn(kk));
    kk=kk+1;
end
undemodf=unwrap(demodf);
%Plotting filtered demodulated strain and Original strain-White Noise
t=0:0.001:2.01;
figure(7);title('Filtered white noise strain and Original strain');plot(t,[undemodf;strain]);
set(gca,'FontSize',25);
legend('Filtered Demodulated Strain-white noise','Original Strain');
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
xlim([0 0.2]);
%Creating sin noise of function
i=1;
sinnoise=[];
for t=0:0.001:2.01
    sinnoise(i)=0.9*sin(2*pi*100*t)+In(i);
    i=i+1;
end
%Passing Intensity with sin noise through a low pass filter
FilterInSin=lowpass(sinnoise,0.1);
%Comparing noise and noise free intensity signals
t=0:0.001:2.01;
figure(8);
subplot(2,1,1)
plot(t,In,'-rd');
set(gca,'FontSize',25);
title('Intensity-no noise');
ylabel('Intensity','FontSize',30);
xlabel('time(s)','FontSize',30);
xlim([0 0.2]);
subplot(2,1,2)
plot(t,FilterInSin,'-bd');
title('Intensity-Sine noise');
set(gca,'FontSize',20);
ylabel('Intensity','FontSize',30);
xlabel('time(s)','FontSize',30);
xlim([0 0.2]);
t=0:0.001:2.01;
%adding 90 phase and demodulating-sin wave
In_90=zeros(size(strain));
demods=zeros(size(strain));
kk=1;
for t=0:0.001:2.01
    In_90(kk)=cos(strain(kk)+pi/2);
    demods(kk)=-atan2(In_90(kk), FilterInSin(kk));
    kk=kk+1;
end
%setting up unwrapping and plotting unwrapped graph-sin noise
undemods=unwrap(demods);
%Plotting demodualted strain of sinnoise
t=0:0.001:2.01;
figure(9);
subplot(2,1,1);
plot(t,strain,'--d');
set(gca,'FontSize',25);
title('Original Strain','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
subplot(2,1,2);
plot(t,undemods,':rd');
set(gca,'FontSize',25);
title('Demodulated Strain-sin noise','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
%Plotting demodualted strain of white noise
t=0:0.001:2.01;
figure(10);
subplot(2,1,1);
plot(t,strain,'--d');
set(gca,'FontSize',25);
title('Original Strain','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);
subplot(2,1,2);
plot(t,undemodf,':rd');
set(gca,'FontSize',25);
title('Demodulated Strain-White noise','FontSize',30)
ylabel('Strain','FontSize',30);
xlabel('time(s)','FontSize',30);



