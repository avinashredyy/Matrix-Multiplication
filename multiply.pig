matrixm = LOAD 'M-matrix-large.txt' using PigStorage(',') AS (row,col,value);
matrixn = LOAD 'N-matrix-large.txt' using PigStorage(',') AS (row,col,value);
J = JOIN matrixm BY col FULL OUTER, matrixn BY row;
M = FOREACH J GENERATE matrixm::row AS mmr,matrixn::col AS mnc,(matrixm::value)*(matrixn::value) AS value;
A = GROUP M BY (mmr,mnc);
resultant = FOREACH A GENERATE group.$0 AS row,group.$1 AS col,SUM(M.value) AS value;
STORE resultant INTO 'output' using PigStorage(',');

