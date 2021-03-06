function varargout=sml_targetfile_final(what,varargin)
% make target files

%%%%%% groups %%%%%%
% G1, G2
% both training with the right hand

%%%%%% stimuli %%%%%%%
% chunks - triplets
% 6 sequences of 9 presses

%%%%% seqType %%%%%%%
% 1 training 
% 2 untrained (other group)
% 3 finger mapping
% 4 random
% 5 other hand - intrinsic
% 6 other hand - extrinsic

%%%%% seqNumb %%%%%%
% 1-6 trained
% 7-12 other group (untrained)
% 13-18 finger mapping
% 19-> random

%%%%%% scan sessions %%%%%%%
% 8 functional runs with train seq (6) and untrain seq (6)
% 2 localisers (finger mapping)
% NOTE - always change ScanSess variable - which scanning session
% 3 scanning sessions with metronome, one without (ScanGo)


%%%%% blockType %%%%%%%
% which type of the task is done
% 1 - BeforeLearn
% 2 - BeforeLearnMet
% 3 - Scan
% 4 - ScanLoc
% 5 - ChunkLearn
% 6 - SeqLearn
% 7 - PreScanMet
% 8 - PreScanGo
% 9 - ScanGo
% 10 - OtherHand
% 11 - SeqTest
% 12 - SeqTestUntrained


switch what
    case 'targetfile'
        basedir = '/Users/eberlot/Documents/MATLAB/Projects/SuperMotorLearning/targetFiles'; 
        %basedir = 'C:\Nicola\SequenceHierarchical\data\sh4\analysis';
        cd(basedir);
        
        rng('shuffle');
        
        Seq1 = [1 2 3 1 3 2 3 5 2; ...
            1 3 2 4 3 1 5 1 2; ...
            3 5 1 3 2 4 5 4 3; ...
            3 5 2 3 5 1 5 1 2; ...
            5 4 3 1 5 2 3 2 4; ...
            5 2 1 4 5 1 3 2 4];
        
        Seq2 = [1 2 4 3 2 1 2 4 1; ...
            1 2 5 3 2 5 1 2 4; ...
            3 1 4 1 2 5 3 2 1; ...
            3 4 1 2 4 5 3 2 1; ...
            5 2 3 2 4 1 4 1 5; ...
            5 1 4 5 2 3 2 4 5];
        
        
        ChunkAmount = 1:11;
        ChunkNumb = [101 102 103 104 105 106 107 108 109 110 111];
         
        Chunks1 = [1 2 3; 1 3 2; 1 5 2; 3 2 4; 3 5 1; 3 5 2; 4 3 1; 4 5 1; 5 1 2; 5 2 1; 5 4 3];
        Chunks2 = [1 2 4; 1 2 5; 2 4 1; 2 4 5; 3 1 4; 3 2 1; 3 2 5; 3 4 1; 4 1 5; 5 1 4; 5 2 3];

        SeqChunks1 = [1,2,6; ...
            2,7,9; ...
            5,4,11; ...
            6,5,9; ...
            11,3,4; ...
            10,8,4];
        
        SeqChunks2 = [1,6,3; ...
            2,7,1; ...
            5,2,6; ...
            8,4,6; ...
            11,3,9; ...
            10,11,4];
        
        FingMap = [ 1 1 1 1 1 1 1 1 1; ...
            2 2 2 2 2 2 2 2 2; ...
            3 3 3 3 3 3 3 3 3; ...
            4 4 4 4 4 4 4 4 4; ...
            5 5 5 5 5 5 5 5 5];
        
        % change - how many are needed?
        RandomSeq = [1 3 4 3 1 5 4 2 1; ...
            1 2 5 3 2 1 5 4 2; ...
            3 5 2 4 1 2 5 4 1; ...
            3 1 5 1 3 4 5 4 1; ...
            5 1 2 3 1 5 3 5 2; ...
            5 2 3 4 2 1 5 1 2; ...
            1 2 4 5 1 2 5 3 2; ...
            1 4 5 4 3 2 1 5 4; ...
            3 4 1 5 4 3 5 1 2; ...
            3 1 5 4 5 3 1 2 4; ...
            5 4 3 5 1 3 4 5 3; ...
            5 1 2 1 4 5 1 5 4];
        
        
        C1 = {'�'; '�';'�';'�';'�';'�'};
        C2 = {'�'; '�'; '�';'�'; '�';'�';'�';'�';'�';'�';'�'};
        C3 = {'***'};
        C3Seq = {'*********'};
        
        SequenceNumb = 1:6; 
        SequenceNumbUntrain = 7:12;
        SequenceNumbFingMap = 13:17;
        SequenceRandNumb = (1:length(RandomSeq))+17;
        SequenceNumbOtherHand = 30:41;
        OrderFields = {'startTime','blockType','seqNumb','seqType','press1','press2','press3','press4','press5','press6','press7','press8','press9','hand','cueS','cueC','cueP','iti','sounds','isScan','isMetronome','lastTrial','FoSEX','announceTime','feedbackTime','ScanSess'};
        
        Group = 1;      
        
        switch Group
            case 1
                SeqG1 = Seq1;
                SeqG2 = Seq2;
                SeqChunksG1 = SeqChunks1;
                SeqChunksG2 = SeqChunks2;
                ChunksG1 = Chunks1;
                ChunksG2 = Chunks2;
        end
        
        %% Chunk Learning Block
        
        % 110 trials per block 
        % each chunk repeated twice in a row, 2nd time *** (recall)
        
        Trials = 1:110;
        
        runs = 42;
        
        for e = 1:runs % CHANGE
            ChunkLearn_G1.cueS = cellstr(repmat('�',length(Trials),1));
            ChunkLearn_G2.cueS = cellstr(repmat('�',length(Trials),1));
            
            ChunkLearn_G1.iti(1:length(Trials),:) = 500;
            ChunkLearn_G2.iti(1:length(Trials),:) = 500;
            ChunkLearn_G1.blockType(1:length(Trials),:) = 5;
            ChunkLearn_G2.blockType(1:length(Trials),:) = 5;
            ChunkLearn_G1.hand(1:length(Trials),:) = 2; % both groups right hand
            ChunkLearn_G2.hand(1:length(Trials),:) = 2;
            
            ChunkLearn_G1.announceTime(1:length(Trials),:) = 0;
            ChunkLearn_G2.announceTime(1:length(Trials),:) = 0;
            ChunkLearn_G1.feedbackTime(1:length(Trials),:) = 400;
            ChunkLearn_G2.feedbackTime(1:length(Trials),:) = 400;
            
            ChunkLearn_G1.sounds(1:length(Trials),:) = 1;
            ChunkLearn_G2.sounds(1:length(Trials),:) = 1;
            
            %randomly choose order
            X = sample_wor(ChunkAmount,length(ChunkAmount));
            p = 1;
            l = 1;
            for i = 1:(length(Trials)/2)
                
                % press cue
                ChunkLearn_G1.cueP(p,:) = regexprep(cellstr(num2str(ChunksG1(X(l),:))),'\s','');
                ChunkLearn_G1.cueP(p+1,:) = C3; % stars every second trial

                ChunkLearn_G2.cueP(p,:) = regexprep(cellstr(num2str(ChunksG2(X(l),:))),'\s','');
                ChunkLearn_G2.cueP(p+1,:) = C3;
                      
                ChunkLearn_G1.press1(p:p+1,:) = ChunksG1(X(l),1);
                ChunkLearn_G1.press2(p:p+1,:) = ChunksG1(X(l),2);
                ChunkLearn_G1.press3(p:p+1,:) = ChunksG1(X(l),3);
                
                ChunkLearn_G2.press1(p:p+1,:) = ChunksG2(X(l),1);
                ChunkLearn_G2.press2(p:p+1,:) = ChunksG2(X(l),2);
                ChunkLearn_G2.press3(p:p+1,:) = ChunksG2(X(l),3);
                
                ChunkLearn_G1.seqNumb(p:p+1,:) = ChunkNumb(X(l));
                ChunkLearn_G2.seqNumb(p:p+1,:) = ChunkNumb(X(l));
                
                
                %chunk cue
                ChunkLearn_G1.cueC(p:p+1,:) = C2(X(l),:) ;
                ChunkLearn_G2.cueC(p:p+1,:) = C2(X(l),:) ;
                
                p = p+2;
                l = l+1;
                if l == 12;
                    l = 1;
                    X = sample_wor(ChunkAmount,length(ChunkAmount));
                end
            end
            ChunkLearn_G1.press4 = zeros(length(Trials),1);
            ChunkLearn_G1.press5 = zeros(length(Trials),1);
            ChunkLearn_G1.press6 = zeros(length(Trials),1);
            ChunkLearn_G1.press7 = zeros(length(Trials),1);
            ChunkLearn_G1.press8 = zeros(length(Trials),1);
            ChunkLearn_G1.press9 = zeros(length(Trials),1);
             
            ChunkLearn_G2.press4 = zeros(length(Trials),1);
            ChunkLearn_G2.press5 = zeros(length(Trials),1);
            ChunkLearn_G2.press6 = zeros(length(Trials),1);
            ChunkLearn_G2.press7 = zeros(length(Trials),1);
            ChunkLearn_G2.press8 = zeros(length(Trials),1);
            ChunkLearn_G2.press9 = zeros(length(Trials),1);
      
            ChunkLearn_G1.seqType = zeros(length(Trials),1);
            ChunkLearn_G2.seqType = zeros(length(Trials),1);     
            
            ChunkLearn_G1.isScan = zeros(length(Trials),1);
            ChunkLearn_G2.isScan = zeros(length(Trials),1);
            
            ChunkLearn_G1.ScanSess = zeros(length(Trials),1);
            ChunkLearn_G2.ScanSess = zeros(length(Trials),1);
            
            ChunkLearn_G1.seqType = zeros(length(Trials),1);
            ChunkLearn_G2.seqType = zeros(length(Trials),1);
            
            ChunkLearn_G1.FoSEX = repmat([1:2]',length(Trials)/2,1);
            ChunkLearn_G2.FoSEX = repmat([1:2]',length(Trials)/2,1);
            
            ChunkLearn_G1.isMetronome = zeros(length(Trials),1);
            ChunkLearn_G2.isMetronome = zeros(length(Trials),1);
            
            ChunkLearn_G1.lastTrial(1:length(Trials),1) = 0;
            ChunkLearn_G1.lastTrial(length(Trials),:) = 1;
            ChunkLearn_G2.lastTrial(1:length(Trials),1) = 0;
            ChunkLearn_G2.lastTrial(length(Trials),:) = 1;
            
            ChunkLearn_G1.startTime = zeros(length(Trials),1);
            ChunkLearn_G2.startTime = zeros(length(Trials),1);
            
            
            switch Group
                
                case 1
                    
                    dsave(fullfile(basedir,['ChunkLearn/','sml_CLB_G1_B', num2str(e), '.tgt']),orderfields(ChunkLearn_G1,OrderFields));
                    dsave(fullfile(basedir,['ChunkLearn/','sml_CLB_G2_B', num2str(e), '.tgt']),orderfields(ChunkLearn_G2,OrderFields));
                    
            end
            clear X
            clear ChunkLearn_G1
            clear ChunkLearn_G2
        end
        
        
        %% Sequence Learning Block
        
        % every sequence repeated twice, 2nd time ********* (recall)
        
        Trials = 1:24;       % 2 pairs of repetition per sequence per block (FoSEx - 4 in total)
        
        runs = 92;
        
        for e = 1:runs % CHANGE
            
            SequenceLearn_G2.cueC = cellstr(repmat('�',length(Trials),1));
            SequenceLearn_G1.cueC = cellstr(repmat('�',length(Trials),1));
            
            SequenceLearn_G1.iti(1:length(Trials),:) = 500;
            SequenceLearn_G2.iti(1:length(Trials),:) = 500;
            
            SequenceLearn_G1.hand(1:length(Trials),:) = 2;
            SequenceLearn_G2.hand(1:length(Trials),:) = 2;
            
            SequenceLearn_G1.blockType(1:length(Trials),:) = 6;
            SequenceLearn_G2.blockType(1:length(Trials),:) = 6;
            
            SequenceLearn_G1.announceTime(1:length(Trials),:) = 0;
            SequenceLearn_G2.announceTime(1:length(Trials),:) = 0;
            SequenceLearn_G1.feedbackTime(1:length(Trials),:) = 400;
            SequenceLearn_G2.feedbackTime(1:length(Trials),:) = 400;
            
            SequenceLearn_G1.sounds(1:length(Trials),:) = 1;
            SequenceLearn_G2.sounds(1:length(Trials),:) = 1;
            
            X = sample_wor(SequenceNumb,length(SequenceNumb));
            p = 1;
            l = 1;
            for i = 1:(length(Trials)/2)
                
                SequenceLearn_G1.cueP(p,:) = regexprep(cellstr(num2str(SeqG1(X(l),:))),'\s','');
                SequenceLearn_G1.cueP(p+1,:) = C3Seq;   % stars for every second trial
                SequenceLearn_G2.cueP(p,:) = regexprep(cellstr(num2str(SeqG2(X(l),:))),'\s','');
                SequenceLearn_G2.cueP(p+1,:) = C3Seq;
                SequenceLearn_G1.cueS(p:p+1,:) = C1(X(l));  % �
                SequenceLearn_G2.cueS(p:p+1,:) = C1(X(l));
                SequenceLearn_G1.cueC(p:p+1,:) = regexprep(cellstr(strjoin(C2(SeqChunksG1(X(l),:))')),'\s',''); % �
                SequenceLearn_G2.cueC(p:p+1,:) = regexprep(cellstr(strjoin(C2(SeqChunksG2(X(l),:))')),'\s','');
                      
                SequenceLearn_G1.press1(p:p+1,:) = SeqG1(X(l),1);
                SequenceLearn_G1.press2(p:p+1,:) = SeqG1(X(l),2);
                SequenceLearn_G1.press3(p:p+1,:) = SeqG1(X(l),3);
                SequenceLearn_G1.press4(p:p+1,:) = SeqG1(X(l),4);
                SequenceLearn_G1.press5(p:p+1,:) = SeqG1(X(l),5);
                SequenceLearn_G1.press6(p:p+1,:) = SeqG1(X(l),6);
                SequenceLearn_G1.press7(p:p+1,:) = SeqG1(X(l),7);
                SequenceLearn_G1.press8(p:p+1,:) = SeqG1(X(l),8);
                SequenceLearn_G1.press9(p:p+1,:) = SeqG1(X(l),9);
                
                SequenceLearn_G2.press1(p:p+1,:) = SeqG2(X(l),1);
                SequenceLearn_G2.press2(p:p+1,:) = SeqG2(X(l),2);
                SequenceLearn_G2.press3(p:p+1,:) = SeqG2(X(l),3);
                SequenceLearn_G2.press4(p:p+1,:) = SeqG2(X(l),4);
                SequenceLearn_G2.press5(p:p+1,:) = SeqG2(X(l),5);
                SequenceLearn_G2.press6(p:p+1,:) = SeqG2(X(l),6);
                SequenceLearn_G2.press7(p:p+1,:) = SeqG2(X(l),7);
                SequenceLearn_G2.press8(p:p+1,:) = SeqG2(X(l),8);
                SequenceLearn_G2.press9(p:p+1,:) = SeqG2(X(l),9);
                
                SequenceLearn_G1.seqNumb(p:p+1,:) = SequenceNumb(X(l));
                SequenceLearn_G2.seqNumb(p:p+1,:) = SequenceNumb(X(l));
                
                SequenceLearn_G1.isScan = zeros(length(Trials),1);
                SequenceLearn_G2.isScan = zeros(length(Trials),1);
                
                SequenceLearn_G1.ScanSess = zeros(length(Trials),1);
                SequenceLearn_G2.ScanSess = zeros(length(Trials),1);
                
                % one for trained sequence
                SequenceLearn_G1.seqType = ones(length(Trials),1);
                SequenceLearn_G2.seqType = ones(length(Trials),1);
                
                SequenceLearn_G1.FoSEX = repmat([1:2]',length(Trials)/2,1);
                SequenceLearn_G2.FoSEX = repmat([1:2]',length(Trials)/2,1);
                
                SequenceLearn_G1.isMetronome = zeros(length(Trials),1);
                SequenceLearn_G2.isMetronome = zeros(length(Trials),1);
                
                SequenceLearn_G1.lastTrial(1:length(Trials),1) = 0;
                SequenceLearn_G1.lastTrial(length(Trials),:) = 1;
                SequenceLearn_G2.lastTrial(1:length(Trials),1) = 0;
                SequenceLearn_G2.lastTrial(length(Trials),:) = 1;    
                
                SequenceLearn_G1.startTime = zeros(length(Trials),1);
                SequenceLearn_G2.startTime = zeros(length(Trials),1);
                   
                p = p+2;
                l = l+1;
                if l == length(SequenceNumb)+1;
                    l = 1;
                    X = sample_wor(SequenceNumb,length(SequenceNumb));
                end
            end
            switch Group
                case 1
                    dsave(fullfile(basedir,['SeqLearn/','sml_SLB_G1_B' ,num2str(e), '.tgt']),orderfields(SequenceLearn_G1,OrderFields));
                    dsave(fullfile(basedir,['SeqLearn/','sml_SLB_G2_B' ,num2str(e), '.tgt']),orderfields(SequenceLearn_G2,OrderFields));
   
            end
            
            clear x
            clear SequenceLearn_G1
            clear SequenceLearn_G2
        end
        

        %% Before Learning - First session
        
        % first session - to get familiar with the keyboard/task
        % random sequences - 12 (2 sets of 6)
        % 2 sequences in a row - 24 per block
        
        runs = 5;
        trial_run = 24;
        
        Trials = 1:(runs*trial_run);  % 5 blocks of 24     
         
        SeqG1 = [RandomSeq]; % make longer, so there are different sequences instead of repetitions
        SeqG2 = [RandomSeq];
        
            X = [sample_wor(1:size(SeqG1,1),size(SeqG1,1));sample_wor(1:size(SeqG1,1),size(SeqG1,1));sample_wor(1:size(SeqG1,1),size(SeqG1,1));sample_wor(1:size(SeqG1,1),size(SeqG1,1));];

            %Y = [sample_wor(1:size(X2,1),size(X2,1))];
        
            SequenceBeforeLearn_G1.cueC = cellstr(repmat('�',length(Trials),1));
            SequenceBeforeLearn_G2.cueC = cellstr(repmat('�',length(Trials),1));
            
            SequenceBeforeLearn_G1.iti(1:length(Trials),:) = 500;
            SequenceBeforeLearn_G2.iti(1:length(Trials),:) = 500;
            
            SequenceBeforeLearn_G1.hand(1:length(Trials),:) = 2;
            SequenceBeforeLearn_G2.hand(1:length(Trials),:) = 2;
            
            SequenceBeforeLearn_G1.blockType(1:length(Trials),:) = 1;
            SequenceBeforeLearn_G2.blockType(1:length(Trials),:) = 1;
            
            SequenceBeforeLearn_G1.announceTime(1:length(Trials),:) = 0;
            SequenceBeforeLearn_G2.announceTime(1:length(Trials),:) = 0;
            SequenceBeforeLearn_G1.feedbackTime(1:length(Trials),:) = 400;
            SequenceBeforeLearn_G2.feedbackTime(1:length(Trials),:) = 400;
            
            SequenceBeforeLearn_G1.sounds(1:length(Trials),:) = 1;
            SequenceBeforeLearn_G2.sounds(1:length(Trials),:) = 1;
            
            SequenceBeforeLearn_G1.isScan(1:length(Trials),:) = 0;
            SequenceBeforeLearn_G2.isScan(1:length(Trials),:) = 0;
            
            SequenceBeforeLearn_G1.ScanSess(1:length(Trials),:) = 0;
            SequenceBeforeLearn_G2.ScanSess(1:length(Trials),:) = 0;
            
            SequenceBeforeLearn_G1.isMetronome(1:length(Trials),:) = 0;
            SequenceBeforeLearn_G2.isMetronome(1:length(Trials),:) = 0;
            
            p = 1;
            l = 1;
            
            for i = 1:(length(Trials)/2)
                
                SequenceBeforeLearn_G1.cueP(p:p+1,:) = regexprep(cellstr(num2str(SeqG1(X(l),:))),'\s','');
                SequenceBeforeLearn_G2.cueP(p:p+1,:) = regexprep(cellstr(num2str(SeqG2(X(l),:))),'\s','');
                SequenceBeforeLearn_G1.cueS(p:p+1,:) = C1(1);  %�
                SequenceBeforeLearn_G2.cueS(p:p+1,:) = C1(1);
                
                SequenceBeforeLearn_G1.press1(p:p+1,:) = SeqG1(X(l),1);
                SequenceBeforeLearn_G1.press2(p:p+1,:) = SeqG1(X(l),2);
                SequenceBeforeLearn_G1.press3(p:p+1,:) = SeqG1(X(l),3);
                SequenceBeforeLearn_G1.press4(p:p+1,:) = SeqG1(X(l),4);
                SequenceBeforeLearn_G1.press5(p:p+1,:) = SeqG1(X(l),5);
                SequenceBeforeLearn_G1.press6(p:p+1,:) = SeqG1(X(l),6);
                SequenceBeforeLearn_G1.press7(p:p+1,:) = SeqG1(X(l),7);
                SequenceBeforeLearn_G1.press8(p:p+1,:) = SeqG1(X(l),8);
                SequenceBeforeLearn_G1.press9(p:p+1,:) = SeqG1(X(l),9);
                
                SequenceBeforeLearn_G2.press1(p:p+1,:) = SeqG2(X(l),1);
                SequenceBeforeLearn_G2.press2(p:p+1,:) = SeqG2(X(l),2);
                SequenceBeforeLearn_G2.press3(p:p+1,:) = SeqG2(X(l),3);
                SequenceBeforeLearn_G2.press4(p:p+1,:) = SeqG2(X(l),4);
                SequenceBeforeLearn_G2.press5(p:p+1,:) = SeqG2(X(l),5);
                SequenceBeforeLearn_G2.press6(p:p+1,:) = SeqG2(X(l),6);
                SequenceBeforeLearn_G2.press7(p:p+1,:) = SeqG2(X(l),7);
                SequenceBeforeLearn_G2.press8(p:p+1,:) = SeqG2(X(l),8);
                SequenceBeforeLearn_G2.press9(p:p+1,:) = SeqG2(X(l),9);
                
                SequenceBeforeLearn_G1.seqNumb(p:p+1,:) = SequenceRandNumb(X(l));
                SequenceBeforeLearn_G2.seqNumb(p:p+1,:) = SequenceRandNumb(X(l));
                
                   
                p = p+2;
                l = l+1;
                
            end
            
        
            SequenceBeforeLearn_G1.isScan = zeros(length(Trials),1);
            SequenceBeforeLearn_G2.isScan = zeros(length(Trials),1);
            
            SequenceBeforeLearn_G1.seqType = ones(length(Trials),1)*4;  %4 - random
            SequenceBeforeLearn_G2.seqType = ones(length(Trials),1)*4;  %4 - random
            
            SequenceBeforeLearn_G1.FoSEX = repmat([1:2]',length(Trials)/2,1);
            SequenceBeforeLearn_G2.FoSEX = repmat([1:2]',length(Trials)/2,1);
            
            SequenceBeforeLearn_G1.isMetronome = zeros(length(Trials),1);
            SequenceBeforeLearn_G2.isMetronome = zeros(length(Trials),1);
            
            SequenceBeforeLearn_G1.lastTrial(1:length(Trials),1) = 0;
            SequenceBeforeLearn_G1.lastTrial([24,48,72,96],:) = 1;      % every 24th trial - last trial in a block
            SequenceBeforeLearn_G2.lastTrial(1:length(Trials),1) = 0;
            SequenceBeforeLearn_G2.lastTrial([24,48,72,96],:) = 1;
            
            SequenceBeforeLearn_G1.startTime = zeros(length(Trials),1);
            SequenceBeforeLearn_G2.startTime = zeros(length(Trials),1);
            
            B1 = 1;
            B2 = trial_run;
        
        for i = 1:runs 
            switch Group
                case 1        
                    dsave(fullfile(basedir,['BeforeLearn/','sml_BL_G1_B', num2str(i), '.tgt']),orderfields(getrow(SequenceBeforeLearn_G1,B1:B2),OrderFields));
                    dsave(fullfile(basedir,['BeforeLearn/','sml_BL_G2_B', num2str(i), '.tgt']),orderfields(getrow(SequenceBeforeLearn_G2,B1:B2),OrderFields));
                    B1 = B1+trial_run;
                    B2 = B2+trial_run;
            end
        end
        
        %% Before Learning Scan/Metronome
        
         % to get familiar with the metronome, fmri setup (bed)
         % random sequences - 12 (2 sets of 6)
         % 2 sequences in a row - 36 per block (3 repetitions)
         
        Trials = 1:72;  % 4 blocks of 24     
        runs = 5; 
        
        SeqG1 = [RandomSeq]; % make longer, so there are different sequences instead of repetitions
        SeqG2 = [RandomSeq];
        
        for e = 1:runs
            X = [sample_wor(1:size(SeqG1,1),size(SeqG1,1));sample_wor(1:size(SeqG1,1),size(SeqG1,1));sample_wor(1:size(SeqG1,1),size(SeqG1,1))];
            %Y = [sample_wor(1:size(X2,1),size(X2,1))];
        
            BLM_G1.cueC = cellstr(repmat('�',length(Trials),1));
            BLM_G2.cueC = cellstr(repmat('�',length(Trials),1));
            
            BLM_G1.iti(1:length(Trials),:) = 0;
            BLM_G2.iti(1:length(Trials),:) = 0;
            
            BLM_G1.hand(1:length(Trials),:) = 2;
            BLM_G2.hand(1:length(Trials),:) = 2;
            
            BLM_G1.blockType(1:length(Trials),:) = 2;
            BLM_G2.blockType(1:length(Trials),:) = 2;
            
            BLM_G1.announceTime(1:length(Trials),:) = 1000;
            BLM_G2.announceTime(1:length(Trials),:) = 1000;
            BLM_G1.feedbackTime(1:length(Trials),:) = 400;
            BLM_G2.feedbackTime(1:length(Trials),:) = 400;
            
            BLM_G1.sounds(1:length(Trials),:) = 1;
            BLM_G2.sounds(1:length(Trials),:) = 1;
            
            BLM_G1.isScan(1:length(Trials),:) = 0;
            BLM_G2.isScan(1:length(Trials),:) = 0;
            
            BLM_G1.ScanSess(1:length(Trials),:) = 0;
            BLM_G2.ScanSess(1:length(Trials),:) = 0;
            
            BLM_G1.isMetronome(1:length(Trials),:) = 1;
            BLM_G2.isMetronome(1:length(Trials),:) = 1;
            
            p = 1;
            l = 1;
            
            for i = 1:(length(Trials)/2)
                
                BLM_G1.cueP(p:p+1,:) = regexprep(cellstr(num2str(SeqG1(X(l),:))),'\s','');
                BLM_G2.cueP(p:p+1,:) = regexprep(cellstr(num2str(SeqG2(X(l),:))),'\s','');
                BLM_G1.cueS(p:p+1,:) = C1(1);  %�
                BLM_G2.cueS(p:p+1,:) = C1(1);
                
                BLM_G1.press1(p:p+1,:) = SeqG1(X(l),1);
                BLM_G1.press2(p:p+1,:) = SeqG1(X(l),2);
                BLM_G1.press3(p:p+1,:) = SeqG1(X(l),3);
                BLM_G1.press4(p:p+1,:) = SeqG1(X(l),4);
                BLM_G1.press5(p:p+1,:) = SeqG1(X(l),5);
                BLM_G1.press6(p:p+1,:) = SeqG1(X(l),6);
                BLM_G1.press7(p:p+1,:) = SeqG1(X(l),7);
                BLM_G1.press8(p:p+1,:) = SeqG1(X(l),8);
                BLM_G1.press9(p:p+1,:) = SeqG1(X(l),9);
                
                BLM_G2.press1(p:p+1,:) = SeqG2(X(l),1);
                BLM_G2.press2(p:p+1,:) = SeqG2(X(l),2);
                BLM_G2.press3(p:p+1,:) = SeqG2(X(l),3);
                BLM_G2.press4(p:p+1,:) = SeqG2(X(l),4);
                BLM_G2.press5(p:p+1,:) = SeqG2(X(l),5);
                BLM_G2.press6(p:p+1,:) = SeqG2(X(l),6);
                BLM_G2.press7(p:p+1,:) = SeqG2(X(l),7);
                BLM_G2.press8(p:p+1,:) = SeqG2(X(l),8);
                BLM_G2.press9(p:p+1,:) = SeqG2(X(l),9);
                
                BLM_G1.seqNumb(p:p+1,:) = SequenceRandNumb(X(l));
                BLM_G2.seqNumb(p:p+1,:) = SequenceRandNumb(X(l));
          
                p = p+2;
                l = l+1;    
            end
            
        
            BLM_G1.seqType = ones(length(Trials),1)*4;  %4 - random
            BLM_G2.seqType = ones(length(Trials),1)*4;  %4 - random
            
            BLM_G1.FoSEX = repmat([1:2]',length(Trials)/2,1);
            BLM_G2.FoSEX = repmat([1:2]',length(Trials)/2,1);
            
            BLM_G1.lastTrial(1:length(Trials),1) = 0;
            BLM_G1.lastTrial(length(Trials),:) = 1;      
            BLM_G2.lastTrial(1:length(Trials),1) = 0;
            BLM_G2.lastTrial(length(Trials),:) = 1;
            
            BLM_G1.startTime = zeros(length(Trials),1);
            BLM_G2.startTime = zeros(length(Trials),1);

        
            switch Group
                case 1        
                    dsave(fullfile(basedir,['BeforeLearnMetronome/','sml_BLM_G1_B', num2str(e), '.tgt']),orderfields(BLM_G1,OrderFields));
                    dsave(fullfile(basedir,['BeforeLearnMetronome/','sml_BLM_G2_B', num2str(e), '.tgt']),orderfields(BLM_G2,OrderFields));

            end
  
        end
   
        %% pre scan met
        
        % trained and random sequences with metronome 
        
        sequencesG1 = [SeqG1;RandomSeq(1:6,:)]; % always change?
        sequencesG2 = [SeqG2;RandomSeq(1:6,:)];
        
        runs=7;
        
        seqforRandG1 = [sequencesG1;sequencesG1;sequencesG1];
        seqforRandG2 = [sequencesG2;sequencesG2;sequencesG2];
        
        seqG1 = kron(seqforRandG1,ones(2,1));
        seqG2 = kron(seqforRandG2,ones(2,1));
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG1(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG2(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        % Group 1
        PreScanMetG1.cueC = cellstr(repmat('�',length(seqG1),1));
        PreScanMetG1.cueS = cellstr(repmat('�',length(seqG1),1));
        
        PreScanMetG1.hand(1:length(seqG1),:) = 2;
        
        PreScanMetG1.iti(1:length(seqG1),:) = 0;
        PreScanMetG1.sounds(1:length(seqG1),:) = 1;
        
        PreScanMetG1.blockType(1:length(seqG1),:) = 7;
        
        PreScanMetG1.isScan(1:length(seqG1),:) = 0;
        PreScanMetG1.ScanSess(1:length(seqG2),:) = 0;
        PreScanMetG1.isMetronome(1:length(seqG1),:) = 1;
        
        PreScanMetG1.FoSEX(1:2:length(seqG1),:) = 1;
        PreScanMetG1.FoSEX(2:2:length(seqG1),:) = 2;
        
        PreScanMetG1.lastTrial(1:length(seqG1),:) = 0;
        PreScanMetG1.lastTrial(length(seqG1),:) = 1;
        
        PreScanMetG1.announceTime(1:length(seqG1),:) = 1000;
        PreScanMetG1.feedbackTime(1:length(seqG1),:) = 400;
        
        % Group 2
        PreScanMetG2.cueC = cellstr(repmat('�',length(seqG2),1));
        PreScanMetG2.cueS = cellstr(repmat('�',length(seqG2),1));
        
        PreScanMetG2.hand(1:length(seqG2),:) = 2;
        
        PreScanMetG2.iti(1:length(seqG2),:) = 0;
        PreScanMetG2.sounds(1:length(seqG2),:) = 1;
        
        PreScanMetG2.blockType(1:length(seqG2),:) = 7;
        
        PreScanMetG2.isScan(1:length(seqG2),:) = 0;
        PreScanMetG2.ScanSess(1:length(seqG2),:) = 0;
        PreScanMetG2.isMetronome(1:length(seqG2),:) = 1;
        
        PreScanMetG2.FoSEX(1:2:length(seqG2),:) = 1;
        PreScanMetG2.FoSEX(2:2:length(seqG2),:) = 2;
        
        PreScanMetG2.lastTrial(1:length(seqG2),:) = 0;
        PreScanMetG2.lastTrial(length(seqG2),:) = 1;
        
        PreScanMetG2.announceTime(1:length(seqG2),:) = 1000;
        PreScanMetG2.feedbackTime(1:length(seqG2),:) = 400;
        
        for e = 1:runs
            
            X1 = [sample_wor(1:size(randomnumbG1,1),size(randomnumbG1,1))];
            X2 = kron(X1,ones(2,1));    % for all trials - with repetitions
            
            trialLength = 5000;
            startRun = 5000;
            
            RandBreaks = sort(sample_wor(1:length(X2),5));
            while (sum(find(RandBreaks == 1)) || sum(rem(RandBreaks,2))<5) % breaks cannot be on first trial, between two consecutive repetitions (only odd trials)
                RandBreaks = sort(sample_wor(1:length(X2),5));
            end
            
            
            for i = 1:length(X2)
                
                if any(ismember(RandBreaks,i))
                    startRun = startRun+8000;   % pause of 8000 - for baseline
                end
                PreScanMetG1.startTime(i,:) = startRun;
                PreScanMetG2.startTime(i,:) = startRun;
                
                startRun = startRun+trialLength;
            end
            
            p = 1;
            l = 1;
            
            for i = 1:length(X2)
                PreScanMetG1.press1(p,:) = sequencesG1(randomnumbG1(X2(l),2),1);
                PreScanMetG1.press2(p,:) = sequencesG1(randomnumbG1(X2(l),2),2);
                PreScanMetG1.press3(p,:) = sequencesG1(randomnumbG1(X2(l),2),3);
                PreScanMetG1.press4(p,:) = sequencesG1(randomnumbG1(X2(l),2),4);
                PreScanMetG1.press5(p,:) = sequencesG1(randomnumbG1(X2(l),2),5);
                PreScanMetG1.press6(p,:) = sequencesG1(randomnumbG1(X2(l),2),6);
                PreScanMetG1.press7(p,:) = sequencesG1(randomnumbG1(X2(l),2),7);
                PreScanMetG1.press8(p,:) = sequencesG1(randomnumbG1(X2(l),2),8);
                PreScanMetG1.press9(p,:) = sequencesG1(randomnumbG1(X2(l),2),9);
                
                if randomnumbG1(X2(l),2) <7
                    PreScanMetG1.seqNumb(p,:) = SequenceNumb(randomnumbG1(X2(l),2));
                    PreScanMetG1.seqType(p,:) = 1;  % trained
                else
                    PreScanMetG1.seqNumb(p,:) = SequenceRandNumb(randomnumbG1(X2(l)-6,2));
                    PreScanMetG1.seqType(p,:) = 4; % random
                end
                
                z(l) = regexprep(cellstr(num2str(sequencesG1(randomnumbG1(X2(l),2),:))),'\s','');
                PreScanMetG1.cueP(p,:) = repmat(z(l),1,1);
                
                PreScanMetG2.press1(p,:) = sequencesG2(randomnumbG2(X2(l),2),1);
                PreScanMetG2.press2(p,:) = sequencesG2(randomnumbG2(X2(l),2),2);
                PreScanMetG2.press3(p,:) = sequencesG2(randomnumbG2(X2(l),2),3);
                PreScanMetG2.press4(p,:) = sequencesG2(randomnumbG2(X2(l),2),4);
                PreScanMetG2.press5(p,:) = sequencesG2(randomnumbG2(X2(l),2),5);
                PreScanMetG2.press6(p,:) = sequencesG2(randomnumbG2(X2(l),2),6);
                PreScanMetG2.press7(p,:) = sequencesG2(randomnumbG2(X2(l),2),7);
                PreScanMetG2.press8(p,:) = sequencesG2(randomnumbG2(X2(l),2),8);
                PreScanMetG2.press9(p,:) = sequencesG2(randomnumbG2(X2(l),2),9);
                
                PreScanMetG2.hand(p,:) = 1;
                
                if randomnumbG2(X2(l),2) <7
                    %if trained sequencesG2
                    PreScanMetG2.seqNumb(p,:) = SequenceNumb(randomnumbG2(X2(l),2));
                    PreScanMetG2.seqType(p,:) = 1;
                else
                    %random
                    PreScanMetG2.seqNumb(p,:) = SequenceRandNumb(randomnumbG2(X2(l)-6,2));
                    PreScanMetG2.seqType(p,:) = 4;
                end
                
                z(l) = regexprep(cellstr(num2str(sequencesG2(randomnumbG2(X2(l),2),:))),'\s','');
                PreScanMetG2.cueP(p,:) = repmat(z(l),1,1);
         
                p = p+1;
                l = l+1;
                
            end
            
            switch Group
                case 1
                    dsave(fullfile(basedir,['PreScanMetronome/','sml_PSM_G1_B', num2str(e), '.tgt']),orderfields(PreScanMetG1,OrderFields));
                    dsave(fullfile(basedir,['PreScanMetronome/','sml_PSM_G2_B', num2str(e), '.tgt']),orderfields(PreScanMetG2,OrderFields));
            end
        end
        
        %% Scan Days - Sequences
        
        % 8 functional runs
        % 12 seq - 6 trained, 6 untrained
        % each sequence repeated twice - FoSEx
        % 3 trial pairs of each seq (6 in total) per run 
        % 12 x 6 - 72 trials per run
        % 6.67 min per run - 54 minutes of scanning 
        
        runs = 8;

        sequencesG1 = [SeqG1;SeqG2];
        sequencesG2 = [SeqG2;SeqG1];
        
        seqforRandG1 = [SeqG1;SeqG1;SeqG1;SeqG2;SeqG2;SeqG2];
        seqforRandG2 = [SeqG2;SeqG2;SeqG2;SeqG1;SeqG1;SeqG1];
        
        seqG1 = kron(seqforRandG1,ones(2,1));
        seqG2 = kron(seqforRandG2,ones(2,1));
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG1(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG2(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        % Group 1
        ScanG1.cueC = cellstr(repmat('�',length(seqG1),1));       
        ScanG1.cueS = cellstr(repmat('�',length(seqG1),1));
        
        ScanG1.iti(1:length(seqG1),:) = 0;        
        ScanG1.sounds(1:length(seqG1),:) = 1;
        
        ScanG1.blockType(1:length(seqG1),:) = 3;
        
        ScanG1.isScan(1:length(seqG1),:) = 1;
        ScanG1.isMetronome(1:length(seqG1),:) = 1;
        
        ScanG1.FoSEX(1:2:length(seqG1),:) = 1;
        ScanG1.FoSEX(2:2:length(seqG1),:) = 2;
        
        ScanG1.lastTrial(1:length(seqG1),:) = 0;       
        ScanG1.lastTrial(length(seqG1),:) = 1;
        
        ScanG1.announceTime(1:length(seqG1),:) = 1000;
        ScanG1.feedbackTime(1:length(seqG1),:) = 400;

        ScanG1.ScanSess(1:length(seqG1),:) = 1;        % CHANGE!   
        
        % Group 2
        ScanG2.cueC = cellstr(repmat('�',length(seqG2),1));    
        ScanG2.cueS = cellstr(repmat('�',length(seqG2),1));
        
        ScanG2.iti(1:length(seqG2),:) = 0; 
        ScanG2.sounds(1:length(seqG2),:) = 1;
        
        ScanG2.blockType(1:length(seqG2),:) = 3;
        
        ScanG2.isScan(1:length(seqG2),:) = 1;
        ScanG2.isMetronome(1:length(seqG2),:) = 1;
        
        ScanG2.FoSEX(1:2:length(seqG2),:) = 1;
        ScanG2.FoSEX(2:2:length(seqG2),:) = 2;
        
        ScanG2.lastTrial(1:length(seqG2),:) = 0;
        ScanG2.lastTrial(length(seqG2),:) = 1;
        
        ScanG2.announceTime(1:length(seqG2),:) = 1000; 
        ScanG2.feedbackTime(1:length(seqG2),:) = 400; 
        
        ScanG2.ScanSess(1:length(seqG2),:) = 1;        % CHANGE!  
        
        for e = 1:runs
                 
            X1 = [sample_wor(1:size(randomnumbG1,1),size(randomnumbG1,1))];  
            X2 = kron(X1,ones(2,1));
            
            trialLength = 5000;
            startRun = 5000;
            
            RandBreaks = sort(sample_wor(1:length(X2),5));
            while (sum(find(RandBreaks == 1)) || sum(rem(RandBreaks,2))<5) % breaks cannot be on first trial, between two consecutive repetitions (only odd trials)
                RandBreaks = sort(sample_wor(1:length(X2),5));
            end
            
            for i = 1:length(X2)
                
                if any(ismember(RandBreaks,i))
                    startRun = startRun+8000;   % pause of 8000 - for baseline
                end
                ScanG1.startTime(i,:) = startRun;
                ScanG2.startTime(i,:) = startRun;
                
                startRun = startRun+trialLength;
            end
               
            p = 1;
            l = 1;
            
            for i = 1:size(X2,1)
                
                % Group1
                ScanG1.press1(p,:) = sequencesG1(randomnumbG1(X2(l),2),1);
                ScanG1.press2(p,:) = sequencesG1(randomnumbG1(X2(l),2),2);
                ScanG1.press3(p,:) = sequencesG1(randomnumbG1(X2(l),2),3);
                ScanG1.press4(p,:) = sequencesG1(randomnumbG1(X2(l),2),4);
                ScanG1.press5(p,:) = sequencesG1(randomnumbG1(X2(l),2),5);
                ScanG1.press6(p,:) = sequencesG1(randomnumbG1(X2(l),2),6);
                ScanG1.press7(p,:) = sequencesG1(randomnumbG1(X2(l),2),7);
                ScanG1.press8(p,:) = sequencesG1(randomnumbG1(X2(l),2),8);
                ScanG1.press9(p,:) = sequencesG1(randomnumbG1(X2(l),2),9);
                
                ScanG1.seqNumb(p,:) = randomnumbG1(X2(l),2);
                ScanG1.hand(p,:) = 2;
                
                if ScanG1.seqNumb(p,:) <7
                    %if trained sequencesG1
                    ScanG1.seqType(p,:) = 1;                  
                elseif ScanG1.seqNumb(p,:) >6 
                    %untrained sequences (seqG2)
                    ScanG1.seqType(p,:) = 2;    
                end
                                  
                z(l) = regexprep(cellstr(num2str(sequencesG1(randomnumbG1(X2(l),2),:))),'\s','');
                ScanG1.cueP(p,:) = repmat(z(l),1,1);
                
                % Group 2
                ScanG2.press1(p,:) = sequencesG2(randomnumbG2(X2(l),2),1);
                ScanG2.press2(p,:) = sequencesG2(randomnumbG2(X2(l),2),2);
                ScanG2.press3(p,:) = sequencesG2(randomnumbG2(X2(l),2),3);
                ScanG2.press4(p,:) = sequencesG2(randomnumbG2(X2(l),2),4);
                ScanG2.press5(p,:) = sequencesG2(randomnumbG2(X2(l),2),5);
                ScanG2.press6(p,:) = sequencesG2(randomnumbG2(X2(l),2),6);
                ScanG2.press7(p,:) = sequencesG2(randomnumbG2(X2(l),2),7);
                ScanG2.press8(p,:) = sequencesG2(randomnumbG2(X2(l),2),8);
                ScanG2.press9(p,:) = sequencesG2(randomnumbG2(X2(l),2),9);
                
                ScanG2.seqNumb(p,:) = randomnumbG2(X2(l),2);
                ScanG2.hand(p,:) = 2;
                
                if ScanG2.seqNumb(p,:) <7
                    %if trained sequencesG2
                    ScanG2.seqType(p,:) = 1;
                elseif ScanG2.seqNumb(p,:) >6 
                    %untrained sequences (seqG1)
                    ScanG2.seqType(p,:) = 2;  
                end
      
                z(l) = regexprep(cellstr(num2str(sequencesG2(randomnumbG2(X2(l),2),:))),'\s','');
                ScanG2.cueP(p,:) = repmat(z(l),1,1);
                   
                p = p+1;
                l = l+1;
                
            end
            
            switch Group
                case 1
                    dsave(fullfile(basedir,['Scan/','sml_Scan_G1_B', num2str(e), '.tgt']),orderfields(ScanG1,OrderFields));
                    dsave(fullfile(basedir,['Scan/','sml_Scan_G2_B', num2str(e), '.tgt']),orderfields(ScanG2,OrderFields));

            end
        end
        
        %% Scan localiser
        
        % finger mapping localiser
        % 2 functional runs
        % 2.23 min per run - 4.5 in total
        
        seq = repmat(FingMap,4,1);
        runs = 2;   % 2 localisers
        
        randomnumb(:,1) = [1:20]';
        randomnumb(:,2) = repmat([1:5]',4,1);
        
        Scan.cueC = cellstr(repmat('�',length(seq),1));       
        Scan.cueS = cellstr(repmat('�',length(seq),1));
        
        Scan.iti(1:length(seq),:) = 0;        
        Scan.sounds(1:length(seq),:) = 1;
        
        Scan.blockType(1:length(seq),:) = 4;
        
        Scan.isScan(1:length(seq),:) = 1;
        Scan.isMetronome(1:length(seq),:) = 1;
        
        Scan.FoSEX(1:length(seq),:) = 1;
        
        Scan.lastTrial(1:length(seq),:) = 0;       
        Scan.lastTrial(length(seq),:) = 1;
        
        Scan.announceTime(1:length(seq),:) = 1000;
        Scan.feedbackTime(1:length(seq),:) = 400;
        
        Scan.ScanSess(1:length(seq),:) = 1;        % CHANGE! 
        
        for e = 1:runs
        
        X2 = [sample_wor(1:size(FingMap,1),size(FingMap,1));...
             sample_wor(1:size(FingMap,1),size(FingMap,1));...
             sample_wor(1:size(FingMap,1),size(FingMap,1));...
             sample_wor(1:size(FingMap,1),size(FingMap,1))];
       
        trialLength = 5000;  
        startRun = 5000;
        
        RandBreaks = sort(sample_wor(1:length(X2),5));
        while (find(RandBreaks == 1)) % breaks cannot be on the first trial
            RandBreaks = sort(sample_wor(1:length(X2),5));
        end
        
        for i = 1:length(X2)
            
            if any(ismember(RandBreaks,i))
                startRun = startRun+8000;   % pause of 8000 - for estimating baseline
            end
            Scan.startTime(i,:) = startRun;
            
            startRun = startRun+trialLength;
        end
        
        p = 1;
        l = 1;
        
        for i = 1:size(X2,1)
            
            
            Scan.press1(p,:) = seq(randomnumb(X2(l),2),1);
            Scan.press2(p,:) = seq(randomnumb(X2(l),2),2);
            Scan.press3(p,:) = seq(randomnumb(X2(l),2),3);
            Scan.press4(p,:) = seq(randomnumb(X2(l),2),4);
            Scan.press5(p,:) = seq(randomnumb(X2(l),2),5);
            Scan.press6(p,:) = seq(randomnumb(X2(l),2),6);
            Scan.press7(p,:) = seq(randomnumb(X2(l),2),7);
            Scan.press8(p,:) = seq(randomnumb(X2(l),2),8);
            Scan.press9(p,:) = seq(randomnumb(X2(l),2),9);
            
            Scan.seqNumb(p,:) = randomnumb(X2(l),2)+12; % 13-18
            Scan.hand(p,:) = 2;
            Scan.seqType(p,:) = 3;  % finger mapping
            
            z(l) = regexprep(cellstr(num2str(seq(randomnumb(X2(l),2),:))),'\s','');
            
            Scan.cueP(p,:) = repmat(z(l),1,1);
            
            p = p+1;
            l = l+1;
            
        end
        dsave(fullfile(basedir,['Scan/','sml_Scan_FingMap', num2str(e),'.tgt']),orderfields(Scan,OrderFields));
        
        end
 
        %% PreScan Go
        
        % No metronome, only GO signal - seq performed as fast as possible
        
        sequencesG1 = [SeqG1;RandomSeq(1:6,:)]; 
        sequencesG2 = [SeqG2;RandomSeq(1:6,:)];
        
        runs=3;
        
        seqforRandG1 = [sequencesG1;sequencesG1;sequencesG1];
        seqforRandG2 = [sequencesG2;sequencesG2;sequencesG2];
        
        seqG1 = kron(seqforRandG1,ones(2,1));
        seqG2 = kron(seqforRandG2,ones(2,1));
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG1(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG2(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        % Group 1
        PreScanGoG1.cueC = cellstr(repmat('�',length(seqG1),1));
        PreScanGoG1.cueS = cellstr(repmat('�',length(seqG1),1));
        
        PreScanGoG1.hand(1:length(seqG1),:) = 2;
        
        PreScanGoG1.iti(1:length(seqG1),:) = 0;
        PreScanGoG1.sounds(1:length(seqG1),:) = 1;
        
        PreScanGoG1.blockType(1:length(seqG1),:) = 8;
        
        PreScanGoG1.isScan(1:length(seqG1),:) = 0;
        PreScanGoG1.ScanSess(1:length(seqG2),:) = 0;
        PreScanGoG1.isMetronome(1:length(seqG1),:) = 2;
        
        PreScanGoG1.FoSEX(1:2:length(seqG1),:) = 1;
        PreScanGoG1.FoSEX(2:2:length(seqG1),:) = 2;
        
        PreScanGoG1.lastTrial(1:length(seqG1),:) = 0;
        PreScanGoG1.lastTrial(length(seqG1),:) = 1;
        
        PreScanGoG1.announceTime(1:length(seqG1),:) = 1000;
        PreScanGoG1.feedbackTime(1:length(seqG1),:) = 400;
        
        % Group 2
        PreScanGoG2.cueC = cellstr(repmat('�',length(seqG2),1));
        PreScanGoG2.cueS = cellstr(repmat('�',length(seqG2),1));
        
        PreScanGoG2.hand(1:length(seqG2),:) = 2;
        
        PreScanGoG2.iti(1:length(seqG2),:) = 0;
        PreScanGoG2.sounds(1:length(seqG2),:) = 1;
        
        PreScanGoG2.blockType(1:length(seqG2),:) = 8;
        
        PreScanGoG2.isScan(1:length(seqG2),:) = 0;
        PreScanGoG2.ScanSess(1:length(seqG2),:) = 0;
        PreScanGoG2.isMetronome(1:length(seqG2),:) = 2;
        
        PreScanGoG2.FoSEX(1:2:length(seqG2),:) = 1;
        PreScanGoG2.FoSEX(2:2:length(seqG2),:) = 2;
        
        PreScanGoG2.lastTrial(1:length(seqG2),:) = 0;
        PreScanGoG2.lastTrial(length(seqG2),:) = 1;
        
        PreScanGoG2.announceTime(1:length(seqG2),:) = 1000;
        PreScanGoG2.feedbackTime(1:length(seqG2),:) = 400;
        
        for e = 1:runs
            
            X1 = [sample_wor(1:size(randomnumbG1,1),size(randomnumbG1,1))];
            X2 = kron(X1,ones(2,1));    % for all trials - with repetitions
            
            trialLength = 5000;
            startRun = 5000;
            
            RandBreaks = sort(sample_wor(1:length(X2),5));
            while (sum(find(RandBreaks == 1)) || sum(rem(RandBreaks,2))<5) % breaks cannot be on first trial, between two consecutive repetitions (only odd trials)
                RandBreaks = sort(sample_wor(1:length(X2),5));
            end
            
            
            for i = 1:length(X2)
                
                if any(ismember(RandBreaks,i))
                    startRun = startRun+8000;   % pause of 8000 - for baseline
                end
                PreScanGoG1.startTime(i,:) = startRun;
                PreScanGoG2.startTime(i,:) = startRun;
                
                startRun = startRun+trialLength;
            end
            
            p = 1;
            l = 1;
            
            for i = 1:length(X2)
                PreScanGoG1.press1(p,:) = sequencesG1(randomnumbG1(X2(l),2),1);
                PreScanGoG1.press2(p,:) = sequencesG1(randomnumbG1(X2(l),2),2);
                PreScanGoG1.press3(p,:) = sequencesG1(randomnumbG1(X2(l),2),3);
                PreScanGoG1.press4(p,:) = sequencesG1(randomnumbG1(X2(l),2),4);
                PreScanGoG1.press5(p,:) = sequencesG1(randomnumbG1(X2(l),2),5);
                PreScanGoG1.press6(p,:) = sequencesG1(randomnumbG1(X2(l),2),6);
                PreScanGoG1.press7(p,:) = sequencesG1(randomnumbG1(X2(l),2),7);
                PreScanGoG1.press8(p,:) = sequencesG1(randomnumbG1(X2(l),2),8);
                PreScanGoG1.press9(p,:) = sequencesG1(randomnumbG1(X2(l),2),9);
                
                if randomnumbG1(X2(l),2) <7
                    PreScanGoG1.seqNumb(p,:) = SequenceNumb(randomnumbG1(X2(l),2));
                    PreScanGoG1.seqType(p,:) = 1;  % trained
                else
                    PreScanGoG1.seqNumb(p,:) = SequenceRandNumb(randomnumbG1(X2(l)-6,2));
                    PreScanGoG1.seqType(p,:) = 4; % random
                end
                
                z(l) = regexprep(cellstr(num2str(sequencesG1(randomnumbG1(X2(l),2),:))),'\s','');
                PreScanGoG1.cueP(p,:) = repmat(z(l),1,1);
                
                PreScanGoG2.press1(p,:) = sequencesG2(randomnumbG2(X2(l),2),1);
                PreScanGoG2.press2(p,:) = sequencesG2(randomnumbG2(X2(l),2),2);
                PreScanGoG2.press3(p,:) = sequencesG2(randomnumbG2(X2(l),2),3);
                PreScanGoG2.press4(p,:) = sequencesG2(randomnumbG2(X2(l),2),4);
                PreScanGoG2.press5(p,:) = sequencesG2(randomnumbG2(X2(l),2),5);
                PreScanGoG2.press6(p,:) = sequencesG2(randomnumbG2(X2(l),2),6);
                PreScanGoG2.press7(p,:) = sequencesG2(randomnumbG2(X2(l),2),7);
                PreScanGoG2.press8(p,:) = sequencesG2(randomnumbG2(X2(l),2),8);
                PreScanGoG2.press9(p,:) = sequencesG2(randomnumbG2(X2(l),2),9);
                
                PreScanGoG2.hand(p,:) = 1;
                
                if randomnumbG2(X2(l),2) <7
                    %if trained sequencesG2
                    PreScanGoG2.seqNumb(p,:) = SequenceNumb(randomnumbG2(X2(l),2));
                    PreScanGoG2.seqType(p,:) = 1;
                else
                    %random
                    PreScanGoG2.seqNumb(p,:) = SequenceRandNumb(randomnumbG2(X2(l)-6,2));
                    PreScanGoG2.seqType(p,:) = 4;
                end
                
                z(l) = regexprep(cellstr(num2str(sequencesG2(randomnumbG2(X2(l),2),:))),'\s','');
                PreScanGoG2.cueP(p,:) = repmat(z(l),1,1);
         
                p = p+1;
                l = l+1;
                
            end
            
            switch Group
                case 1
                    dsave(fullfile(basedir,['PreScanGo/','sml_PSGo_G1_B', num2str(e), '.tgt']),orderfields(PreScanGoG1,OrderFields));
                    dsave(fullfile(basedir,['PreScanGo/','sml_PSGo_G2_B', num2str(e), '.tgt']),orderfields(PreScanGoG2,OrderFields));
            end
        end
        
        
        %% Scan Go last scan session
        
        % NO METRONOME - perform as fast as possible
        % 8 functional runs
        % 12 seq - 6 trained, 6 untrained
        % each sequence repeated twice - FoSEx
        % 3 trial pairs of each seq (6 in total) per run 
        % 12 x 6 - 72 trials per run
        % 6.67 min per run - 54 minutes of scanning 
        
        runs = 8;

        sequencesG1 = [SeqG1;SeqG2];
        sequencesG2 = [SeqG2;SeqG1];
        
        seqforRandG1 = [SeqG1;SeqG1;SeqG1;SeqG2;SeqG2;SeqG2];
        seqforRandG2 = [SeqG2;SeqG2;SeqG2;SeqG1;SeqG1;SeqG1];
        
        seqG1 = kron(seqforRandG1,ones(2,1));
        seqG2 = kron(seqforRandG2,ones(2,1));
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG1(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        randomnumbG1(:,1) = [1:36]';
        randomnumbG2(:,2) = [1:6,1:6,1:6,7:12,7:12,7:12]';
        
        % Group 1
        ScanGoG1.cueC = cellstr(repmat('�',length(seqG1),1));       
        ScanGoG1.cueS = cellstr(repmat('�',length(seqG1),1));
        
        ScanGoG1.iti(1:length(seqG1),:) = 0;        
        ScanGoG1.sounds(1:length(seqG1),:) = 1;
        
        ScanGoG1.blockType(1:length(seqG1),:) = 9;
        
        ScanGoG1.isScan(1:length(seqG1),:) = 1;
        ScanGoG1.isMetronome(1:length(seqG1),:) = 2;
        
        ScanGoG1.FoSEX(1:2:length(seqG1),:) = 1;
        ScanGoG1.FoSEX(2:2:length(seqG1),:) = 2;
        
        ScanGoG1.lastTrial(1:length(seqG1),:) = 0;       
        ScanGoG1.lastTrial(length(seqG1),:) = 1;
        
        ScanGoG1.announceTime(1:length(seqG1),:) = 1000;
        ScanGoG1.feedbackTime(1:length(seqG1),:) = 400;

        ScanGoG1.ScanSess(1:length(seqG1),:) = 4;      
        
        % Group 2
        ScanGoG2.cueC = cellstr(repmat('�',length(seqG2),1));    
        ScanGoG2.cueS = cellstr(repmat('�',length(seqG2),1));
        
        ScanGoG2.iti(1:length(seqG2),:) = 0; 
        ScanGoG2.sounds(1:length(seqG2),:) = 1;
        
        ScanGoG2.blockType(1:length(seqG2),:) = 9;
        
        ScanGoG2.isScan(1:length(seqG2),:) = 1;
        ScanGoG2.isMetronome(1:length(seqG2),:) = 2;
        
        ScanGoG2.FoSEX(1:2:length(seqG2),:) = 1;
        ScanGoG2.FoSEX(2:2:length(seqG2),:) = 2;
        
        ScanGoG2.lastTrial(1:length(seqG2),:) = 0;
        ScanGoG2.lastTrial(length(seqG2),:) = 1;
        
        ScanGoG2.announceTime(1:length(seqG2),:) = 1000; 
        ScanGoG2.feedbackTime(1:length(seqG2),:) = 400; 
        
        ScanGoG2.ScanSess(1:length(seqG2),:) = 4;      
        
        for e = 1:runs
                 
            X1 = [sample_wor(1:size(randomnumbG1,1),size(randomnumbG1,1))];  
            X2 = kron(X1,ones(2,1));
            
            trialLength = 5000;
            startRun = 5000;
            
            RandBreaks = sort(sample_wor(1:length(X2),5));
            while (sum(find(RandBreaks == 1)) || sum(rem(RandBreaks,2))<5) % breaks cannot be on first trial, between two consecutive repetitions (only odd trials)
                RandBreaks = sort(sample_wor(1:length(X2),5));
            end
            
            for i = 1:length(X2)
                
                if any(ismember(RandBreaks,i))
                    startRun = startRun+8000;   % pause of 8000 - for baseline
                end
                ScanGoG1.startTime(i,:) = startRun;
                ScanGoG2.startTime(i,:) = startRun;
                
                startRun = startRun+trialLength;
            end
               
            p = 1;
            l = 1;
            
            for i = 1:size(X2,1)
                
                % Group1
                ScanGoG1.press1(p,:) = sequencesG1(randomnumbG1(X2(l),2),1);
                ScanGoG1.press2(p,:) = sequencesG1(randomnumbG1(X2(l),2),2);
                ScanGoG1.press3(p,:) = sequencesG1(randomnumbG1(X2(l),2),3);
                ScanGoG1.press4(p,:) = sequencesG1(randomnumbG1(X2(l),2),4);
                ScanGoG1.press5(p,:) = sequencesG1(randomnumbG1(X2(l),2),5);
                ScanGoG1.press6(p,:) = sequencesG1(randomnumbG1(X2(l),2),6);
                ScanGoG1.press7(p,:) = sequencesG1(randomnumbG1(X2(l),2),7);
                ScanGoG1.press8(p,:) = sequencesG1(randomnumbG1(X2(l),2),8);
                ScanGoG1.press9(p,:) = sequencesG1(randomnumbG1(X2(l),2),9);
                
                ScanGoG1.seqNumb(p,:) = randomnumbG1(X2(l),2);
                ScanGoG1.hand(p,:) = 2;
                
                if ScanGoG1.seqNumb(p,:) <7
                    %if trained sequencesG1
                    ScanGoG1.seqType(p,:) = 1;                  
                elseif ScanGoG1.seqNumb(p,:) >6 
                    %untrained sequences (seqG2)
                    ScanGoG1.seqType(p,:) = 2;    
                end
                                  
                z(l) = regexprep(cellstr(num2str(sequencesG1(randomnumbG1(X2(l),2),:))),'\s','');
                ScanGoG1.cueP(p,:) = repmat(z(l),1,1);
                
                % Group 2
                ScanGoG2.press1(p,:) = sequencesG2(randomnumbG2(X2(l),2),1);
                ScanGoG2.press2(p,:) = sequencesG2(randomnumbG2(X2(l),2),2);
                ScanGoG2.press3(p,:) = sequencesG2(randomnumbG2(X2(l),2),3);
                ScanGoG2.press4(p,:) = sequencesG2(randomnumbG2(X2(l),2),4);
                ScanGoG2.press5(p,:) = sequencesG2(randomnumbG2(X2(l),2),5);
                ScanGoG2.press6(p,:) = sequencesG2(randomnumbG2(X2(l),2),6);
                ScanGoG2.press7(p,:) = sequencesG2(randomnumbG2(X2(l),2),7);
                ScanGoG2.press8(p,:) = sequencesG2(randomnumbG2(X2(l),2),8);
                ScanGoG2.press9(p,:) = sequencesG2(randomnumbG2(X2(l),2),9);
                
                ScanGoG2.seqNumb(p,:) = randomnumbG2(X2(l),2);
                ScanGoG2.hand(p,:) = 2;
                
                if ScanGoG2.seqNumb(p,:) <7
                    %if trained sequencesG2
                    ScanGoG2.seqType(p,:) = 1;
                elseif ScanGoG2.seqNumb(p,:) >6 
                    %untrained sequences (seqG1)
                    ScanGoG2.seqType(p,:) = 2;  
                end
      
                z(l) = regexprep(cellstr(num2str(sequencesG2(randomnumbG2(X2(l),2),:))),'\s','');
                ScanGoG2.cueP(p,:) = repmat(z(l),1,1);
                   
                p = p+1;
                l = l+1;
                
            end
            
            switch Group
                case 1
                    dsave(fullfile(basedir,['Scan/','sml_ScanGo_G1_B', num2str(e), '.tgt']),orderfields(ScanGoG1,OrderFields));
                    dsave(fullfile(basedir,['Scan/','sml_ScanGo_G2_B', num2str(e), '.tgt']),orderfields(ScanGoG2,OrderFields));

            end
        end
        

        %% Other hand test
        
        % Test for the transfer to the other hand
        % Intrinsic and extrinsic versions of trained sequences
        % No repetition, only one sequence at a time
        
        Trials = 1:24;       % 2 extrinsic, 2 intrinsic sequences per block (6x4)
        
        runs = 12;  
        
        for e = 1:runs
            
            OtherHand_G2.cueC = cellstr(repmat('�',length(Trials),1));
            OtherHand_G1.cueC = cellstr(repmat('�',length(Trials),1));
            
            OtherHand_G1.iti(1:length(Trials),:) = 500;
            OtherHand_G2.iti(1:length(Trials),:) = 500;
            
            OtherHand_G1.hand(1:length(Trials),:) = 1;
            OtherHand_G2.hand(1:length(Trials),:) = 1;
            
            OtherHand_G1.blockType(1:length(Trials),:) = 10;
            OtherHand_G2.blockType(1:length(Trials),:) = 10;
            
            OtherHand_G1.announceTime(1:length(Trials),:) = 0;
            OtherHand_G2.announceTime(1:length(Trials),:) = 0;
            OtherHand_G1.feedbackTime(1:length(Trials),:) = 400;
            OtherHand_G2.feedbackTime(1:length(Trials),:) = 400;
            
            OtherHand_G1.sounds(1:length(Trials),:) = 1;
            OtherHand_G2.sounds(1:length(Trials),:) = 1;
            
            OtherHand_G1.cueS = cellstr(repmat('�',length(Trials),1));  % �
            OtherHand_G2.cueS = cellstr(repmat('�',length(Trials),1));
            OtherHand_G1.cueC = cellstr(repmat('�',length(Trials),1)); % �
            OtherHand_G2.cueC = cellstr(repmat('�',length(Trials),1));
            
            OtherHand_G1.isScan = zeros(length(Trials),1);
            OtherHand_G2.isScan = zeros(length(Trials),1);
            
            OtherHand_G1.ScanSess = zeros(length(Trials),1);
            OtherHand_G2.ScanSess = zeros(length(Trials),1);
            
            OtherHand_G1.FoSEX = ones(length(Trials),1);
            OtherHand_G2.FoSEX = ones(length(Trials),1);
            
            OtherHand_G1.isMetronome = zeros(length(Trials),1);
            OtherHand_G2.isMetronome = zeros(length(Trials),1);
            
            OtherHand_G1.lastTrial(1:length(Trials),1) = 0;
            OtherHand_G1.lastTrial(length(Trials),:) = 1;
            OtherHand_G2.lastTrial(1:length(Trials),1) = 0;
            OtherHand_G1.lastTrial(length(Trials),:) = 1;
            
            OtherHand_G1.startTime = zeros(length(Trials),1);
            OtherHand_G2.startTime = zeros(length(Trials),1);
            
            SeqG1 = [Seq1;6-Seq1]; % intrinsic(1:6), extrinsic(7:12)
            SeqG2 = [Seq2;6-Seq2];
            
            X = [sample_wor(1:12,12);sample_wor(1:12,12)];
            
            p = 1;
            l = 1;
            for i = 1:length(Trials)
                
                OtherHand_G1.cueP(p,:) = regexprep(cellstr(num2str(6-SeqG1(X(l),:))),'\s','');  % 6 - Seq - left hand
                OtherHand_G2.cueP(p,:) = regexprep(cellstr(num2str(6-SeqG2(X(l),:))),'\s','');
                      
                OtherHand_G1.press1(p,:) = SeqG1(X(l),1);
                OtherHand_G1.press2(p,:) = SeqG1(X(l),2);
                OtherHand_G1.press3(p,:) = SeqG1(X(l),3);
                OtherHand_G1.press4(p,:) = SeqG1(X(l),4);
                OtherHand_G1.press5(p,:) = SeqG1(X(l),5);
                OtherHand_G1.press6(p,:) = SeqG1(X(l),6);
                OtherHand_G1.press7(p,:) = SeqG1(X(l),7);
                OtherHand_G1.press8(p,:) = SeqG1(X(l),8);
                OtherHand_G1.press9(p,:) = SeqG1(X(l),9);
                
                OtherHand_G2.press1(p,:) = SeqG2(X(l),1);
                OtherHand_G2.press2(p,:) = SeqG2(X(l),2);
                OtherHand_G2.press3(p,:) = SeqG2(X(l),3);
                OtherHand_G2.press4(p,:) = SeqG2(X(l),4);
                OtherHand_G2.press5(p,:) = SeqG2(X(l),5);
                OtherHand_G2.press6(p,:) = SeqG2(X(l),6);
                OtherHand_G2.press7(p,:) = SeqG2(X(l),7);
                OtherHand_G2.press8(p,:) = SeqG2(X(l),8);
                OtherHand_G2.press9(p,:) = SeqG2(X(l),9);
                 
                if X(l) <7  % intrinsic
                    OtherHand_G1.seqNumb(p,:) = SequenceNumbOtherHand(X(l));
                    OtherHand_G1.seqType(p,:) = 5; 
                    OtherHand_G2.seqNumb(p,:) = SequenceNumbOtherHand(X(l));
                    OtherHand_G2.seqType(p,:) = 5;  
                else        % extrinsic
                    OtherHand_G1.seqNumb(p,:) = SequenceNumbOtherHand(X(l));
                    OtherHand_G1.seqType(p,:) = 6; 
                    OtherHand_G2.seqNumb(p,:) = SequenceNumbOtherHand(X(l));
                    OtherHand_G2.seqType(p,:) = 6;  
                end
                            
                p = p+1;
                l = l+1;
                
            end
            
            switch Group
                case 1
                    dsave(fullfile(basedir,['OtherHand/','sml_OH_G1_B' ,num2str(e), '.tgt']),orderfields(OtherHand_G1,OrderFields));
                    dsave(fullfile(basedir,['OtherHand/','sml_OH_G2_B' ,num2str(e), '.tgt']),orderfields(OtherHand_G2,OrderFields));
   
            end
            
            clear x
            clear OtherHand_G1
            clear OtherHand_G2
        end
        
        %% Sequence Test Block
        
        % No repetition, only one sequence at a time
        % 4 repetitions of sequence per run
        
        % Note: 1/2 of blocks for OtherHand needed here 
        % Only 6 (trained) seq here, 12 for OtherHand
        % OtherHand: 2 seq rep/run, ST: 4 seq rep/run
        
        Trials = 1:24;       % 4 in total)
        
        runs = 2;
        
        for e = 1:runs 
            
            SequenceTest_G2.cueC = cellstr(repmat('�',length(Trials),1));
            SequenceTest_G1.cueC = cellstr(repmat('�',length(Trials),1));
            
            SequenceTest_G1.iti(1:length(Trials),:) = 500;
            SequenceTest_G2.iti(1:length(Trials),:) = 500;
            
            SequenceTest_G1.hand(1:length(Trials),:) = 2;
            SequenceTest_G2.hand(1:length(Trials),:) = 2;
            
            SequenceTest_G1.blockType(1:length(Trials),:) = 11;
            SequenceTest_G2.blockType(1:length(Trials),:) = 11;
            
            SequenceTest_G1.announceTime(1:length(Trials),:) = 0;
            SequenceTest_G2.announceTime(1:length(Trials),:) = 0;
            SequenceTest_G1.feedbackTime(1:length(Trials),:) = 400;
            SequenceTest_G2.feedbackTime(1:length(Trials),:) = 400;
            
            SequenceTest_G1.sounds(1:length(Trials),:) = 1;
            SequenceTest_G2.sounds(1:length(Trials),:) = 1;
            
            X = sample_wor(SequenceNumb,length(SequenceNumb));
            p = 1;
            l = 1;
            for i = 1:length(Trials)
                
                SequenceTest_G1.cueP(p,:) = regexprep(cellstr(num2str(SeqG1(X(l),:))),'\s','');
                SequenceTest_G2.cueP(p,:) = regexprep(cellstr(num2str(SeqG2(X(l),:))),'\s','');
                SequenceTest_G1.cueS(p,:) = C1(X(l));  % �
                SequenceTest_G2.cueS(p,:) = C1(X(l));
                SequenceTest_G1.cueC(p,:) = regexprep(cellstr(strjoin(C2(SeqChunksG1(X(l),:))')),'\s',''); % �
                SequenceTest_G2.cueC(p,:) = regexprep(cellstr(strjoin(C2(SeqChunksG2(X(l),:))')),'\s','');
                      
                SequenceTest_G1.press1(p,:) = SeqG1(X(l),1);
                SequenceTest_G1.press2(p,:) = SeqG1(X(l),2);
                SequenceTest_G1.press3(p,:) = SeqG1(X(l),3);
                SequenceTest_G1.press4(p,:) = SeqG1(X(l),4);
                SequenceTest_G1.press5(p,:) = SeqG1(X(l),5);
                SequenceTest_G1.press6(p,:) = SeqG1(X(l),6);
                SequenceTest_G1.press7(p,:) = SeqG1(X(l),7);
                SequenceTest_G1.press8(p,:) = SeqG1(X(l),8);
                SequenceTest_G1.press9(p,:) = SeqG1(X(l),9);
                
                SequenceTest_G2.press1(p,:) = SeqG2(X(l),1);
                SequenceTest_G2.press2(p,:) = SeqG2(X(l),2);
                SequenceTest_G2.press3(p,:) = SeqG2(X(l),3);
                SequenceTest_G2.press4(p,:) = SeqG2(X(l),4);
                SequenceTest_G2.press5(p,:) = SeqG2(X(l),5);
                SequenceTest_G2.press6(p,:) = SeqG2(X(l),6);
                SequenceTest_G2.press7(p,:) = SeqG2(X(l),7);
                SequenceTest_G2.press8(p,:) = SeqG2(X(l),8);
                SequenceTest_G2.press9(p,:) = SeqG2(X(l),9);
                
                SequenceTest_G1.seqNumb(p,:) = SequenceNumb(X(l));
                SequenceTest_G2.seqNumb(p,:) = SequenceNumb(X(l));
                
                SequenceTest_G1.isScan = zeros(length(Trials),1);
                SequenceTest_G2.isScan = zeros(length(Trials),1);
                
                SequenceTest_G1.ScanSess = zeros(length(Trials),1);
                SequenceTest_G2.ScanSess = zeros(length(Trials),1);
                
                % one for trained sequence
                SequenceTest_G1.seqType = ones(length(Trials),1);
                SequenceTest_G2.seqType = ones(length(Trials),1);
                
                SequenceTest_G1.FoSEX = ones(length(Trials),1);
                SequenceTest_G2.FoSEX = ones(length(Trials),1);
                
                SequenceTest_G1.isMetronome = zeros(length(Trials),1);
                SequenceTest_G2.isMetronome = zeros(length(Trials),1);
                
                SequenceTest_G1.lastTrial(1:length(Trials),1) = 0;
                SequenceTest_G1.lastTrial(length(Trials),:) = 1;
                SequenceTest_G2.lastTrial(1:length(Trials),1) = 0;
                SequenceTest_G2.lastTrial(length(Trials),:) = 1;    
                
                SequenceTest_G1.startTime = zeros(length(Trials),1);
                SequenceTest_G2.startTime = zeros(length(Trials),1);
                   
                p = p+1;
                l = l+1;
                if l == length(SequenceNumb)+1;
                    l = 1;
                    X = sample_wor(SequenceNumb,length(SequenceNumb));
                end
            end
            switch Group
                case 1
                    dsave(fullfile(basedir,['SeqTest/','sml_STB_G1_B' ,num2str(e), '.tgt']),orderfields(SequenceTest_G1,OrderFields));
                    dsave(fullfile(basedir,['SeqTest/','sml_STB_G2_B' ,num2str(e), '.tgt']),orderfields(SequenceTest_G2,OrderFields));
   
            end
            
            clear x
            clear SequenceTest_G1
            clear SequenceTest_G2
        end
        
        %% Sequence Test Untrained Block
        
        % No repetition, only one sequence at a time
        % 2 repetitions of sequence per run  
        % 6 trained, 6 untrained sequences
        
        Trials = 1:24;       % 4 in total)
        
        runs = 8;     
        
        for e = 1:runs 
            
            SequenceTestUntrain_G2.cueC = cellstr(repmat('�',length(Trials),1));
            SequenceTestUntrain_G1.cueC = cellstr(repmat('�',length(Trials),1));
            
            SequenceTestUntrain_G1.iti(1:length(Trials),:) = 500;
            SequenceTestUntrain_G2.iti(1:length(Trials),:) = 500;
            
            SequenceTestUntrain_G1.hand(1:length(Trials),:) = 2;
            SequenceTestUntrain_G2.hand(1:length(Trials),:) = 2;
            
            SequenceTestUntrain_G1.blockType(1:length(Trials),:) = 12;
            SequenceTestUntrain_G2.blockType(1:length(Trials),:) = 12;
            
            SequenceTestUntrain_G1.announceTime(1:length(Trials),:) = 0;
            SequenceTestUntrain_G2.announceTime(1:length(Trials),:) = 0;
            SequenceTestUntrain_G1.feedbackTime(1:length(Trials),:) = 400;
            SequenceTestUntrain_G2.feedbackTime(1:length(Trials),:) = 400;
            
            SequenceTestUntrain_G1.sounds(1:length(Trials),:) = 1;
            SequenceTestUntrain_G2.sounds(1:length(Trials),:) = 1;
            
            SeqG1 = [Seq1;Seq2]; % trained, untrained
            SeqG2 = [Seq2;Seq1];
            
            X = [sample_wor(1:12,12);sample_wor(1:12,12)];
            
            p = 1;
            l = 1;
            for i = 1:length(Trials)
                
                SequenceTestUntrain_G1.cueP(p,:) = regexprep(cellstr(num2str(SeqG1(X(1),:))),'\s','');
                SequenceTestUntrain_G2.cueP(p,:) = regexprep(cellstr(num2str(SeqG2(X(l),:))),'\s','');
                SequenceTestUntrain_G1.cueS(p,:) = C1(1);  % �
                SequenceTestUntrain_G2.cueS(p,:) = C1(1);
                SequenceTestUntrain_G1.cueC(p,:) = C1(1); % �
                SequenceTestUntrain_G2.cueC(p,:) = C1(1);
                      
                SequenceTestUntrain_G1.press1(p,:) = SeqG1(X(l),1);
                SequenceTestUntrain_G1.press2(p,:) = SeqG1(X(l),2);
                SequenceTestUntrain_G1.press3(p,:) = SeqG1(X(l),3);
                SequenceTestUntrain_G1.press4(p,:) = SeqG1(X(l),4);
                SequenceTestUntrain_G1.press5(p,:) = SeqG1(X(l),5);
                SequenceTestUntrain_G1.press6(p,:) = SeqG1(X(l),6);
                SequenceTestUntrain_G1.press7(p,:) = SeqG1(X(l),7);
                SequenceTestUntrain_G1.press8(p,:) = SeqG1(X(l),8);
                SequenceTestUntrain_G1.press9(p,:) = SeqG1(X(l),9);
                
                SequenceTestUntrain_G2.press1(p,:) = SeqG2(X(l),1);
                SequenceTestUntrain_G2.press2(p,:) = SeqG2(X(l),2);
                SequenceTestUntrain_G2.press3(p,:) = SeqG2(X(l),3);
                SequenceTestUntrain_G2.press4(p,:) = SeqG2(X(l),4);
                SequenceTestUntrain_G2.press5(p,:) = SeqG2(X(l),5);
                SequenceTestUntrain_G2.press6(p,:) = SeqG2(X(l),6);
                SequenceTestUntrain_G2.press7(p,:) = SeqG2(X(l),7);
                SequenceTestUntrain_G2.press8(p,:) = SeqG2(X(l),8);
                SequenceTestUntrain_G2.press9(p,:) = SeqG2(X(l),9);
                
                
                SequenceTestUntrain_G1.isScan = zeros(length(Trials),1);
                SequenceTestUntrain_G2.isScan = zeros(length(Trials),1);
                
                SequenceTestUntrain_G1.ScanSess = zeros(length(Trials),1);
                SequenceTestUntrain_G2.ScanSess = zeros(length(Trials),1);
                
                if X(l) <7  % trained seq
                    SequenceTestUntrain_G1.seqNumb(p,:) = SequenceNumb(X(l));
                    SequenceTestUntrain_G1.seqType(p,:) = 1; 
                    SequenceTestUntrain_G2.seqNumb(p,:) = SequenceNumb(X(l));
                    SequenceTestUntrain_G2.seqType(p,:) = 1;  
                else        % untrained seq
                    SequenceTestUntrain_G1.seqNumb(p,:) = SequenceNumbUntrain(X(l)-6);
                    SequenceTestUntrain_G1.seqType(p,:) = 2; 
                    SequenceTestUntrain_G2.seqNumb(p,:) = SequenceNumbUntrain(X(l)-6);
                    SequenceTestUntrain_G2.seqType(p,:) = 2;  
                end
                
                SequenceTestUntrain_G1.FoSEX = ones(length(Trials),1);
                SequenceTestUntrain_G2.FoSEX = ones(length(Trials),1);
                
                SequenceTestUntrain_G1.isMetronome = zeros(length(Trials),1);
                SequenceTestUntrain_G2.isMetronome = zeros(length(Trials),1);
                
                SequenceTestUntrain_G1.lastTrial(1:length(Trials),1) = 0;
                SequenceTestUntrain_G1.lastTrial(length(Trials),:) = 1;
                SequenceTestUntrain_G2.lastTrial(1:length(Trials),1) = 0;
                SequenceTestUntrain_G2.lastTrial(length(Trials),:) = 1;    
                
                SequenceTestUntrain_G1.startTime = zeros(length(Trials),1);
                SequenceTestUntrain_G2.startTime = zeros(length(Trials),1);
                   
                p = p+1;  
                l = l+1;

            end
            
            switch Group
                case 1
                    dsave(fullfile(basedir,['SeqTestUntrain/','sml_STU_G1_B' ,num2str(e), '.tgt']),orderfields(SequenceTestUntrain_G1,OrderFields));
                    dsave(fullfile(basedir,['SeqTestUntrain/','sml_STU_G2_B' ,num2str(e), '.tgt']),orderfields(SequenceTestUntrain_G2,OrderFields));
   
            end
            
            clear x
            clear SequenceTestUntrain_G1
            clear SequenceTestUntrain_G2
        end
end

end





