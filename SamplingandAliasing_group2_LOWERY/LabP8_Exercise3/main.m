%% Sampling and Aliasing: Lab P-8 Digital Images: A/D and D/A. 3 Lab Exercise (authors: Matthew Lowery, Timothy Felt)

% make plot fonts pretty
set(groot, 'defaultTextInterpreter', 'latex'); 
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultAxesFontName', 'Times');
set(groot, 'defaultTextFontName', 'Times');
set(groot, 'defaultAxesFontSize', 25); 

% import spfirst
addpath(genpath('../spfirst'))
spfirst;

load('lighthouse') % load lighthouse image

%% 3.1a) Compare the original to the downsampled image. Which parts of the image show the aliasing effects most dramatically?

% Plot the lighthouse image
show_img(xx)
title('Lighthouse Image');
xlabel('m'); ylabel('n')
h = gcf; h.Position = [100 100 600 450];
ax = gca;
ax.TightInset;
ax.Position = [0.18 0.20 0.72 0.60]; % lbwh

% Plot the downsampled lighthouse image
xx_downsampled_2 = xx(1:2:end, 1:2:end);
show_img(xx_downsampled_2)
title('Lighthouse Image Downsampled by 2', 'Units','normalized', 'Position',[0.5 1.08 0]);

xlabel('m'); ylabel('n')
h = gcf; h.Position = [100 100 600 450];
ax = gca;
ax.TightInset;
ax.Position = [0.18 0.20 0.72 0.60]; % lbwh
% exportgraphics(gcf, 'lhd2.png', 'BackgroundColor','none');

% Visually, the downsampled image appears very blurry and distorted where there are local changes or features in the original image. For example, while the textures on the surface of almost all of the structures (the shed on the left, the brick house and the brick lighthouse) are somewhat coherent in the original image, they are incoherent in the downsampled image. This is also the case in the edges of any of the objects, such as the edge between the lighthouse and the sky. On the other hand, the original image is less affected by downsampling for the regions of uniformity, such as the blue sky above the platform or more large scale objects like the structures themselves. 

%% 3.1b) Explain why the aliasing happens in the lighthouse image by using a “frequency domain” explanation

% If the original image (xx) has a sampling frequency of Fs = 1 sample per pixel, the sampling theorem details that the maximum possible frequency which can be represented by this sampling rate without aliasing is: 
% F_nyquist = 0.5 * Fs 
%           = 0.5 cycles per pixel.
% Thus, we can say that the highest possible articulated frequency in the original image (without aliasing) is 0.5 cycles per sample.

% For the downsampled image, xx_downsampled_2, 
% Fs_down = Fs // 2 
%         = 0.5 samples per pixel.
% F_nyquist_down = 0.5 * Fs_down 
%                = 0.5 * 0.5
%                = 0.25 cycles per pixel
% Thus we can say the highest possible articulated frequency in this downsampled image (without aliasing) is at most 0.25 cycles per pixel.  

% All this to say that if there are frequencies in the original image greater than 0.25 cycles/pixel, they will be aliased in the downsampled image. Thus if we get an estimation of the frequencies around a region where we visually detect aliasing, we now can mathematically confirm the aliasing (if they're higher than 0.25 cycles/pixel). We can estimate the frequencies in the fencepost region relatively easily as its clear high-oscillating patterns will let us deduce a 'period' between fenceposts. That is, if we zoom in between x(300, 210) in the original image, where they are oscillating the fastest, we can try to measure their frequencies by counting the number of dark (fencehole) pixels between two light (fence) pixels. Around that location, there is merely 1 dark pixel for between two light pixels, thus T_fence = 2 pixels / cycle and F_fence = 1/2 = 0.5 cycles / pixel. Clearly, this is greater than the maximum frequency the downsampled image can represent (0.25 cycles/pixel), thereby confirming aliasing. 


% Plot where we are going to zoom in in the original image via a red rectangle.
show_img(xx)
title('Lighthouse Image');
xlabel('m'); ylabel('n')
h = gcf; h.Position = [100 100 600 450];
n1 = 292; n2 = 304;
m1 = 204; m2 = 213;
x = n1; y = m1; w = n2 - n1; h = m2 - m1; hold on; 
rectangle('Position', [x, y, w, h], 'EdgeColor', 'r', 'LineWidth', 2);
hold off;
ax = gca;
ax.TightInset;
ax.Position = [0.18 0.20 0.72 0.60]; % lbwh
% exportgraphics(gcf, 'lh.png', 'BackgroundColor','none');

% Plot original image zoomed in to the region above
show_img(xx)
xlim([292 304]);
ylim([204 213]);
title('LH in a High-frequency Fencepost region m=292-304, n=204-213');
xlabel('m'); ylabel('n')
xlabel('m'); ylabel('n')
h = gcf; h.Position = [100 100 600 450];
ax = gca;
ax.TightInset;
ax.Position = [0.18 0.20 0.72 0.60]; % lbwh
% exportgraphics(gcf, 'lhnoal.png', 'BackgroundColor','none');


% Plot the same region in the downsampled image
show_img(xx_downsampled_2)
title('Downsampled LH Image in the same Fencepost region');
xlim([floor(292/2) floor(304/2)]);
ylim([floor((204)/2) floor(213)/2]);
xlabel('m'); ylabel('n')
xlabel('m'); ylabel('n')
h = gcf; h.Position = [100 100 600 450];
ax = gca;
ax.TightInset;
ax.Position = [0.18 0.20 0.72 0.60]; % lbwh
% exportgraphics(gcf, 'lhal.png', 'BackgroundColor','none');


% Summary: Lab P-8: 3.1 involved detecting aliasing in the setting of a digital image of a Lighthouse, versus the 1D problems usually discussed in class. Here aliasing and signal disruption is quite intuitive, as the lighthouse basically looks more blurry when aliasing occurs because we are trained to see objects in the world, whereas a time series might just look like squiggley line and thus its aliasing is something that we might not be able to recognize. This is why DSP matters: even when it is not intuitive to visually notice aliasing, we can detect it mathematically. For this specific problem, the lighthouse image was downsampled by a factor of two, and it was articulated from both of these perspectives that aliasing had occured. From a frequency-space standpoint using the sampling theorem that aliasing had occurred. To argue the latter, we estimated the frequency of a highly-oscillatory fencepost region of the original image, and showed that it was higher than the Nyquist frequency of the downsampled image.


%% 3.2a)
clear;

data = load('lighthouse.mat', 'xx'); % Load in Lighthouse.mat
xx = data.xx;
xx3 = xx(1:3:end,1:3:end); %downsample by 3. Aliasing will occur.
M = 3; %upsampling factor.

xr1 = (-2).^(0:6);
L = length(xr1);
nn = ceil((0.999:1:4*L)/4);
xr1hold = xr1(nn);

% for the above code, the interpolation factor is 4 because we are
% copying each point 4 times to stretch out the array.
% the values contained in nn is the original array but 4x the size with
% every number copied 4 times.

%% 3.2b)

[xRL, xCL] = size(xx3); %perform linear interpolation.
nC = ceil((0.999:1:M*xCL)/M);
nR = ceil((0.999:1:M*xRL)/M);

xholdRows = xx3(:, nC); %upsample the rows.

figure;
subplot(1, 2, 1); imshow(xx3, []); title('Downsampled Image (xx3)');
subplot(1, 2, 2); imshow(xholdRows, []); title('Rows Interpolated (xholdrows)');

% Compare sizes
disp(['Size of xx3: ', num2str(size(xx3))]);
disp(['Size of xholdrows: ', num2str(size(xholdRows))]);
%% 3.2c)
xhold = xholdRows(nR, :); %finish upsampling

figure;
subplot(1, 2, 1); imshow(xx, []); title('Original Lighthouse (xx)');
subplot(1, 2, 2); imshow(xhold, []); title('Final Upsampled Image (xhold)');

% Compare sizes
disp(['Size of xx: ', num2str(size(xx))]);
disp(['Size of xhold: ', num2str(size(xhold))]);

%% 3.2d)

n1 = 0:6;
xr1 = (-2).^n1;
tti = 0:0.1:6; %-- locations between the n1 indices
xr1linear = interp1(n1,xr1,tti); %-- function is INTERP-ONE
stem(tti,xr1linear);

% the interpolation factor is 10. This is because for the original vector
% the spacing is 1. 0:6 Has a spacing of 1. When we convert it and use
% 0:0.1:6, we are adding 10 additional spaces between the integers giving
% it an interpolation factor of 10.

%% 3.2e)

[xRL, xCL] = size(xx3); 
xR = (1:xRL);
xC = (1:xCL);
ttR = linspace(1, xRL, xRL * M);
ttC = linspace(1, xCL, xCL * M);

xx3_double = double(xx3);
for r = 1:xRL
    % Interpolate the current row of xx3 horizontally
    % Arguments: Known Coordinates (xC), Known Values (xx3(r, :)), Query Coordinates (ttC)
    xhold_C(r, :) = interp1(xC, xx3_double(r, :), ttC, 'linear');
end

% --- 3. Stage 2: Interpolate Rows (Vertical Expansion) ---
% Final image, named xxlinear, has (xRL*M) rows and (xCL*M) columns.
xxlinear = zeros(xRL * M, xCL * M);

for c = 1:(xCL * M)
    % Interpolate the current column of the intermediate result (xhold_C) vertically
    % Arguments: Known Coordinates (xR), Known Values (xhold_C(:, c)), Query Coordinates (ttR)
    xxlinear(:, c) = interp1(xR, xhold_C(:, c), ttR, 'linear');
end

%% 3.2f)
figure;
subplot(1, 2, 1); imshow(xx, []); title('Original Image (xx)');
subplot(1, 2, 2); imshow(xxlinear, []); title('Bilinear Interpolated (xxlinear)');

%the images are the same size and look relatively the same in shape and
%color. However, the difference is that there are more edges on the
%reconstructed image, and the edges themselves are fuzzy.
%The zooming process cannot remove aliasing because zooming it in removes
%a lot of the points to make it smaller and causes aliasing.

%% 3.2g)
figure;
subplot(1, 2, 1); imshow(xhold, []); title('ZeroHold (xhold)');
subplot(1, 2, 2); imshow(xxlinear, []); title('Bilinear Interpolated (xxlinear)');

%the edges on the linear interpolated seem a little softer and more fuzzy
%vs the edges on the zero hold that seem sharper and have higher contrast.
