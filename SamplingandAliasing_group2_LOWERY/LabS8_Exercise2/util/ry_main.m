%% 2.1.1 PART (a): Parameters
% This section simply defines the parameters and function we will
% be using for the spectogram.

fs    = 10000;               % sampling rate
T     = 10e-3;               % 10 ms period
tStop = 3;                   % total signal duration
Amp = 2 / T;                 % gives triangle peak of 0.5

% Triangle Wave
tt=0:(1/fs):tStop;qq=rem(tt,T);xx=Amp*(abs(qq-(0.5*T))-0.25*T);

%% 2.1.1 PART (b): plot first 5 periods
% With our parameters from the previous part, we will now graph the
% triangular waveform function with 3 to 5 full periods, I chose 5
% periods.
fivePeriods = 5*T*fs;        % Create 5 periods of time
figure;
plot(tt(1:fivePeriods), xx(1:fivePeriods));
xlabel("Time (s)"); ylabel("Amplitude");
title("Triangle Wave - First 5 Periods (T = 10 ms)");
grid on;

%% 2.1.1 PART (c): Spectrogram
% In this section, we calculate TSECT and LSECT.
% TSECT is set to the five periods of the Triangle wave.
% LSECT is the TSECT multiplied by the Sampling rate.
% Using these values and the plotspec() function I plot the spectogram.

TSECT = 5*T;                 % 0.05 seconds
LSECT = TSECT*fs;            % 500 samples

fprintf("TSECT = %.4f s, LSECT = %d samples\n", TSECT, LSECT);

% Extract first 5 periods
xsect = xx(1:LSECT);
% Plot Spectogram
figure;
plotspec(xsect, fs, LSECT);   % magnitude spectrum
title('Harmonic Frequencies of the 5-Period Triangle Wave');
% enable for current figure
dcm = datacursormode(gcf);
dcm.Enable = "on";

%% 2.1.1 PART (d): Harmonic Frequency List
% Looking at the graph, harmonic frequencies can be seen every 100Hz, but
% only on the odd harmonics. 
% Harmonic frequencies seen: 100Hz, 300Hz, 500Hz, 700Hz, 900Hz, 1100Hz,
% 1300Hz, and 1500Hz. 
% The strength of these harmonics lessens as the frequency increases, it
% goes from a solid black bar at 100Hz, to a barely visible band of grey at
% 1500Hz.

%% 2.1.1 PART (e): Fundamental Frequency of the Harmonics
% We calculate the fundamental frequency of the harmonics.
f0 = 1/T;
fprintf("Fundamental Frequency f0 = %.1f Hz\n", f0);


%% 2.1.1 PART (d): Ratio of A1 vs. A3
% Using Matlab's data cursor, mark the 1st and 3rd harmonics in the graph
% and get their respective light index values.
% I Record the Light Index values of the first and third harmonics.
% Take those values and find the ratio of the values A1/A3.
 A1 = 50.7774
 A3 = 5.655
 fprintf("Light Index value of A1 = %.4f \n", A1);
 fprintf("Light Index Value of A3 = %.3f \n", A3);
 Ratio = round(A1/A3);
 fprintf("Ratio of A1/A3 = %d \n", Ratio);

