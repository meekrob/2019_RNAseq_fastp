# Step 1: create a workspace
cd /scratch/summit/$USER
mkdir DSCI512_RNAseq_19_19_11
cd DSCI512_RNAseq_19_19_11

pwd

# make directories to use through processing
# skipping 01_input - we will make that with a link below
mkdir 02_output
mkdir 03_scripts
mkdir 04_logs

#link to the data directory (I have already downloaded everything)
ln -sv /scratch/summit/dcking@colostate.edu/DSCI512/2019/data 01_input

# Look at your directory structure.
ls -lh

# Step 3: load the module that works with containers
module load singularity
module list

# Step 4: Run fastp through the container without arguments- gives catalog of available flags
singularity exec /projects/dcking@colostate.edu/containers/Summit_RNAseq_container.sif fastp

# Make a shortcut for fastp
fastp='singularity exec /projects/dcking@colostate.edu/containers/Summit_RNAseq_container.sif fastp'

# Test the alias- same output.
$fastp

wc -l 01_input/SRR5832182_1.fastq 01_input/SRR5832182_2.fastq

$fastp -i 01_input/SRR5832199_1.fastq       -I 01_input/SRR5832199_2.fastq \
           -o 02_output/SRR5832199_trim_1.fastq -O 02_output/SRR5832199_trim_2.fastq \
           -h 02_output/SRR5832199_report.html  -j 02_output/SRR5832199_report.json\
           --thread 1 \
           -g -x -p 


SRRID=SRR5832198
$fastp -i 01_input/${SRRID}_1.fastq       -I 01_input/${SRRID}_2.fastq \
           -o 02_output/${SRRID}_trim_1.fastq -O 02_output/${SRRID}_trim_2.fastq \
           -h 02_output/${SRRID}_report.html  -j 02_output/${SRRID}_report.json\
           --thread 1 \
           -g -x -p 

