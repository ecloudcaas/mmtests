# ExtractSyscall.pm
package MMTests::ExtractSyscall;
use MMTests::SummariseVariabletime;
use VMR::Report;
our @ISA = qw(MMTests::SummariseVariabletime);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "ExtractSyscall",
		_DataType    => DataTypes::DATA_TIME_CYCLES,
		_ResultData  => [],
	};
	bless $self, $class;
	return $self;
}

sub extractReport() {
	my ($self, $reportDir, $reportName, $profile) = @_;

	my $file = "$reportDir/$profile/syscall.log";
	open(INPUT, $file) || die("Failed to open $file\n");
	my $iteration = 0;
	while (<INPUT>) {
		my @elements = split(/\s/);
		push @{$self->{_ResultData}}, ["Time", ++$iteration, $elements[3]];
	}

	$self->{_Operations} = [ "Time" ];
	close INPUT;
}
1;
