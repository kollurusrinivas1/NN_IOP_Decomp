%% Deriving aph443 and adg443 from total absorption spectrum
%  a(lambda) at six light wavelengths

% load inputs and optimized neural network
load('a_aph_adg_decomp_dataset.mat'); %860 stations from Global bio-optical insitu dataset
% Input is a(lambda) at six wavelengths
% net_aph443 and net_adg443 are the neural networks with optimized weights
% and bias values
aph443p = net_aph443(orig_inp_a_aph_adg_decomp');
adg443p = net_adg443(orig_inp_a_aph_adg_decomp');
fprintf('Deriving aph443 and adg443 from total absorption spectrum completed\n')
% calculate statistics by comparing measured and neural network output of
% aph(443) and adg(443)
stats_aph443 = stats_calc(aph443_testOrig,aph443p');
stats_adg443 = stats_calc(adg443_testOrig,adg443p');

%% Deriving aph(443) and ad(443) from particulate absorption spectrum
%  a(lambda) at six light wavelengths  

load('ap_aph_decomp_dataset.mat');% 348 stations from CCRR dataset
% Input is a(lambda) at six wavelengths
% net_ap_aph_decomp and net_ap_ad_decomp are the neural networks with optimized weights
% and bias values
aph443_apdecomp = net_ap_aph_decomp(ap_orig_ccrr');
ad443_apdecomp = net_ap_ad_decomp(ap_orig_ccrr');

% calculate statistics by comparing measured and neural network output of
% aph(443) 
stats_aph443_apdecomp = stats_calc(aph443_orig_ccrr,aph443_apdecomp');
stats_ad443_apdecomp = stats_calc(ad443_orig_ccrr,ad443_apdecomp');
fprintf('Deriving aph443 and ad443 from particulate absorption spectrum completed\n')
