clear all;
clc;
slCharacterEncoding('UTF-8');

%%Importing Collected Data (1. Step of Design Cycle)
fid = fopen('sms_legitimate.txt');
tline = fgetl(fid);
legitimateDocs = [];
while ischar(tline)
    legitimateDocs = [legitimateDocs;string(tline)];
    tline = fgetl(fid);
end

fid = fopen('sms_spam.txt');
tline = fgetl(fid);
spamDocs = [];
while ischar(tline)
    spamDocs = [spamDocs;string(tline)];
    tline = fgetl(fid);
end

fid = fopen('stopwordsTR.txt');
tline = fgetl(fid);
stopwords = [];
while ischar(tline)
    stopwords = [stopwords;string(tline)];
    tline = fgetl(fid);
end
dataset = [legitimateDocs;spamDocs];

%%Splitting Dataset into Test and Training Set
[m,n] = size(dataset) ;
P = 0.70 ;
idx = randperm(m)  ;
Training = dataset(idx(1:round(P*m)),:) ; 
Testing = dataset(idx(round(P*m)+1:end),:) ;
%%Find each
allWords = [""];

for i = 1:length(Training)
    a = strsplit(Training(i));
    for j = 1:length(a)
        if ~any(contains(stopwords,a(j))) && ~any(contains(allWords,a(j)))
            allWords = [allWords;a(j)];
        end
    end
end
%%Term Selection(2. Step of Design Cycle)

