% Final program of team 8: Transfusion Statistics

    % Load all data from transfusion file
   
data = readtable('transfusion.txt', 'PreserveVariableNames', true);

    % Find any missing data in columns

emptyV = {'Recency (months)', 'Frequency (times)', 'Monetary (c.c. blood)', 'Time (months)'};

    % Using loop to find missing data

for i = 1:length(emptyV)
   variableN = emptyV{i};
   columnV = find(strcmp(data.Properties.VariableNames, variableN));
   meanV = mean(data.(variableN), 'omitnan');
   data.(variableN)(isnan(data.(variableN))) = meanV;
end

    % Convert table to array matrix

dataMatrix = table2array(data);

    % Selecting 500 rows as random sample

rng('default'); 
totalD = size(dataMatrix, 1);
randAddress = randperm(totalD);
trainAddress = randAddress(1:500);
trainingSet = dataMatrix(trainAddress, :);
testingAddress = randAddress(501:end);
testingSet = dataMatrix(testingAddress, :);

    % Calculating mean, min, max, and std

stats = [min(dataMatrix); max(dataMatrix); mean(dataMatrix); std(dataMatrix)];
   
    % Dsiplaying all values
    % Making a table for design to display variables
    % All values with scientific notation

disp('Variable               | Min         | Max        | Mean       | Std');

disp('-----------------------|-------------|------------|------------|------------');

    % Convert all values and display them

disp(['Recency                | ' num2str(stats(1, 1), '%-12.2f') '        |    '      num2str(stats(2, 1), '%-12.2f') '   | ' num2str(stats(3, 1), '%-12.2f') '       | ' num2str(stats(4, 1), '%-12.2f')]);
disp(['Frequency              | ' num2str(stats(1, 2), '%-12.2f') '        |    '      num2str(stats(2, 2), '%-12.2f') '   | ' num2str(stats(3, 2), '%-12.2f') '       | ' num2str(stats(4, 2), '%-12.2f')]);
disp(['Monetary               | ' num2str(stats(1, 3), '%-12.2f') '      |    '      num2str(stats(2, 3), '%-12.2f') '| ' num2str(stats(3, 3), '%-12.2f') '    | ' num2str(stats(4, 3), '%-12.2f')]);
disp(['Time                   | ' num2str(stats(1, 4), '%-12.2f') '        |    '      num2str(stats(2, 4), '%-12.2f') '   | ' num2str(stats(3, 4), '%-12.2f') '      | ' num2str(stats(4, 4), '%-12.2f')]);
disp(' ');
disp(' ');
    
    % Calculate percentage of donations

colomOut = dataMatrix(:, end); 

    % Get values from needed columns
    % Assuming 1 is Yes 0 is No

dispStats = [sum(colomOut == 0), sum(colomOut == 1)];

    % Formula for needed percentage 

finalPerc = dispStats / totalD * 100;

    % Output results with two decimals

disp(' ');
disp('Percentage of blood donors in March 2007:');
disp('Value (0/1) | Amount | Percentage');
disp([0, dispStats(1), finalPerc(1)]);
disp([1, dispStats(2), finalPerc(2)]);
disp(' ');

    % Calculate variance

variance = var(dataMatrix);

    % Calculate covariance

covariance = cov(dataMatrix);

    % Calculate mod

modeValues = mode(dataMatrix);

    % Creating table for outputting Variance

disp(' ');
disp('Variance for each variable:');
disp('Variable               | Variance');
disp('-----------------------|------------');
disp(['Recency                | ' num2str(variance(1))]);
disp(['Frequency              | ' num2str(variance(2))]);
disp(['Monetary               | ' num2str(variance(3))]);
disp(['Time                   | ' num2str(variance(4))]);
disp(' ');
    
    % Creating table for outputting Covariance matrix

disp(' ');
disp('Covariance matrix:');

disp(covariance);
    
disp('Mode for each variable:');
disp('Variable               | Mode');
disp('-----------------------|------------');
disp(['Recency                | ' num2str(modeValues(1), '%.2f')]);
disp(['Frequency              | ' num2str(modeValues(2), '%.2f')]);
disp(['Monetary               | ' num2str(modeValues(3), '%.2f')]);
disp(['Time                   | ' num2str(modeValues(4), '%.2f')]);
disp(' ');
 
   % Plotting histograms
   % All graphs are made for visual purposes
   % Using figure function

figure;

    % First histogram Recency

subplot(2, 2, 1);
histogram(dataMatrix(:, 1), 'BinEdges', 0:10:100);
title('Recency');
xlabel('Months Since Last Donation');
ylabel('Frequency');

    % Second histogram Frequency

subplot(2, 2, 2);
histogram(dataMatrix(:, 2), 'BinEdges', 0:5:50);
title('Frequency of Donations');
xlabel('Times Donated');
ylabel('Frequency');

    % Third histogram Monetary Blood

subplot(2, 2, 3);
histogram(dataMatrix(:, 3), 'BinEdges', 0:1000:12500);
title('Monetary');
xlabel('Blood (cc)');
ylabel('Frequency');

    % Fourth histogram Time

subplot(2, 2, 4);
histogram(dataMatrix(:, 4), 'BinEdges', 0:10:100);
title('Time');
xlabel('Months Since First Donation');
ylabel('Frequency');

    % Scatter plots

figure;

    % Frequency vs Monetary

subplot(2,3,1)    
scatter(dataMatrix(:,2),dataMatrix(:,3));
title("Frequency vs Monetary");
xlabel("Total Donations");
ylabel("Blood (cc)");


    % Time vs Frequency

subplot(2,3,2)
scatter(dataMatrix(:,4),dataMatrix(:,2));
title("Time vs Frequency");
xlabel("Time Since First Donation (Months)");
ylabel("Total Donations");

    %Time vs Monetary

subplot(2,3,3) 
scatter(dataMatrix(:,4),dataMatrix(:,3));
title("Time vs Monetary");
xlabel("Time Since First Donation (Months)");
ylabel("Blood (cc)");

    %Boxplots

figure;

subplot(2, 2, 1);
boxplot(dataMatrix(:, 1), dataMatrix(:, end), 'Labels', {'No Donation', 'Donation'});
title('Recency vs Donation');
xlabel('Donation (March 2007)');
ylabel('Recency');

subplot(2, 2, 2);
boxplot(dataMatrix(:, 2), dataMatrix(:, end), 'Labels', {'No Donation', 'Donation'});
title('Frequency vs Donation');
xlabel('Donation (March 2007)');
ylabel('Frequency');

subplot(2, 2, 3);
boxplot(dataMatrix(:, 3), dataMatrix(:, end), 'Labels', {'No Donation', 'Donation'});
title('Monetary vs Donation');
xlabel('Donation (March 2007)');
ylabel('Monetary');

subplot(2, 2, 4);
boxplot(dataMatrix(:, 4), dataMatrix(:, end), 'Labels', {'No Donation', 'Donation'});
title('Time vs Donation');
xlabel('Donation (March 2007)');
ylabel('Time');

    % Bar graphs

figure;

bar(dispStats);
title('Donated March 2007');
xlabel('Donated (Yes or No)');
ylabel('Donors');

    % Pie chart

figure;

pie(dispStats, {'Did Not Donate', 'Did Donate'});
title('Donation Distribution (March 2007)');
