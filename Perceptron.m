dataSet = xlsread('abseteism.xlsx'); %import the dataset
x = dataSet(:,1:4); %Train_datas 140x3
[rows,cols] = size(x); % 740 x 4
y = dataSet(:,5); %Label, target column 140x1
%asign eppoch and learning rate
eppoch = 10000; % eppoch value
lr = 0.1; % learning rate
sum = 0;
% weight initilaze randomly (-1 between 1)
down = -1;
up = +1;
weights = [];
for i=1:cols  
    weights(1,i)=(up-down).*rand(1,1) + down;
end



fprintf('Which activation function will use during training? \n  Press 0 for Sign function \n  Press 1 for Sigmoid function \n  Press 2 for Step function \n  Press 3 for Linear function \n');
act_func =input('Enter a number:'); %User must select activation function

for lp = 1:eppoch   %will iterate as amount of eppoch
for j = 1:rows     %travel all rows of train datas
for i = 1:cols     %get datas of rows and calculate SOP(sum of products)  
     a = x(j,i) * weights(:,i);
     sum = sum + a; %Sum of product 
end

% Decided to activation funcation according to users input
if(act_func == 0)
    output = sign(sum);
end
if(act_func == 1)
    output = sigmoid(sum);
end
if(act_func == 2)
    output = step(sum);
end
if(act_func == 3)
    output = linear(sum);
end

%weight updated
error = y(j) - output; %calculate error (desired - output)
delta = (lr * error) * x(j,:); %calculate delta 
weights = delta + weights; %new weight value
delta = 0;
sum = 0;
error = 0;
end
end
before_w = weights; %last weights here
fprintf('Updated weight: '); %Display updated weights
disp(before_w);


%TEST
sum = 0;
a = 0;
test = [8 0 1 2]; % Test datas
[rowst,colst] = size(test); % 1x4
for i = 1:colst
     a = test(1,i) * before_w(:,i);    
     sum = sum + a;
end


if(act_func == 0)
    output1 = sign(sum);
end
if(act_func == 1)
    output1 = sigmoid(sum);
end
if(act_func == 2)
    output1 = step(sum);
end
if(act_func == 3)
    output1 = linear(sum);
end


fprintf('Predicted label: ');
disp(output1);


%Activation Functions
%Sig function
function k = sign(sum) % Normally, sign function fire -1 and 1 but our labels 1 and 0 so I changed fire output (1 and 0)
if(sum >= 0)
    k = 1;    
end
if (sum < 0)
    k = 0;
end
end
%Sigmoid function
function k = sigmoid(sum) %Sigmoid function fire that values range is 0-1 so threshold is 0.5.
k=1/(1+exp(sum));
if (k>=0.5)
    k=1;
end
if (k<0.5)
    k=0;
end
end
%Step function
function k = step(sum) %Sign function implemantation
if(sum >= 0)
    k = 1;    
end
if (sum < 0)
    k = 0;
end
end
%Linear function
function k = linear(sum) %Our label range is (0-1) so I selected threshold is 0.5 median.
if(sum >= 0.5)
    k = 1;    
end
if (sum < 0.5)
    k = 0;
end
end

