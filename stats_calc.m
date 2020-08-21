function restats=stats_calc(data,estimate)
% Function to various statistics from a data vector or matrix
% and the corresponding estimates.
% Usage: stats = stats_calc(data,estimate)
% Note: data and estimates have to be of same size
% Example: stats = stats_calc(randn(100,100),randn(100,100));

% delete records with NaNs in both datasets first
I = ~isnan(data) & ~isnan(estimate);
data = data(I); estimate = estimate(I);
N = max(size(estimate));
rmse=sqrt(sum((data(:)-estimate(:)).^2)/numel(data));
numerator=((sum(estimate(:)-data(:)))/numel(data));
stdev = sqrt(sum((data(:)-estimate(:)).^2)/(numel(data)-1));
for i=1:numel(data)
    numerator1(i)=abs(data(i)-estimate(i));
    num_mape(i)=abs((data(i)-estimate(i))/(data(i)));
end
numerator2=sum(numerator1)/numel(data);
deno=mean(data(:));
pre=100*(numerator/deno);
pmae=100*(numerator2/deno);
prmse=100*(rmse/deno);
mape=100*(1/numel(data))*sum(num_mape);
bias = numerator;
MAE = numerator2;


sigma_data = std(data);
sigma_estimate = std(estimate);
mean_data = mean(data);
mean_estimate = mean(estimate);

norm_bias = bias/sigma_data;
norm_rmse = rmse/sigma_data;
norm_std = sigma_estimate/sigma_data;
cc = corrcoef(estimate,data);
ccoef = cc(1,2);

norm_unbias_rmse = (norm_rmse^2 - norm_bias^2)^0.5;
[slope,yint,ccreg,stdev_slo,stdev_yint]=lsqfitma(data,estimate);

std_err_mean = std(estimate)/sqrt(N);
%CI95_temp = tinv([0.025 0.975], N-1);
% CI95 = bsxfun(@times,std_err_mean,CI95_temp(:));
CI95 = tinv(.975,N-1)*(std_err_mean);

% for calculation of 95% RMSE
rmse_tp = power((estimate - data).^2,0.5);
SEM_rmse = std(rmse_tp)/sqrt(N); % standard error of mean
% CI95_rmse = bsxfun(@times,SEM_rmse,CI95_temp(:));
CI95_rmse = tinv(.975,N-1)*(SEM_rmse);

% for calculation of 95% bias
bias_tp = estimate - data;
SEM_bias = std(bias_tp)/sqrt(N);
%CI95_bias = bsxfun(@times,SEM_bias,CI95_temp(:));
CI95_bias = tinv(.975,N-1)*(SEM_bias);

% for calculation of 95% cprmse - centre pattern root mean square error
cprmse_tp = power(((estimate - mean_estimate) - (data - mean_data)).^2,0.5);
SEM_cprmse = std(cprmse_tp)/sqrt(N);
% CI95_cprmse = bsxfun(@times,SEM_cprmse,CI95_temp(:));
CI95_cprmse = tinv(.975,N-1)*(SEM_cprmse); 


% to output
restats.pre=pre;
restats.pmae=pmae;
restats.prmse=prmse;
restats.N=size(estimate);
restats.rmse=rmse;
restats.mape=mape;
restats.std=stdev;
restats.bias = bias;
restats.MAE = MAE;
restats.bias_norm = norm_bias;
restats.rmse_norm = norm_rmse;
restats.corrcoef = ccoef;
restats.norm_std = norm_std;
restats.norm_unbias_rmse = norm_unbias_rmse;
restats.slope = slope;
restats.yint = yint;
restats.ccreg = ccreg;
restats.stdev_slo = stdev_slo;
restats.stdev_yint = stdev_yint;
restats.std_err_mean = std_err_mean;
restats.SEM_rmse = SEM_rmse;
restats.SEM_bias = SEM_bias;
restats.SEM_cprmse = SEM_cprmse;
restats.CI95 = CI95;
restats.CI95_rmse = CI95_rmse;
restats.CI95_bias = CI95_bias;
restats.CI95_cprmse = CI95_cprmse;