#Explorer�ŕ\�������ۂɁA�����摜������ŕ\�������悤�ɃR���g���[������B

use File::Compare;

use strict;

my $type = 1;
$|=1;

print "�ƕ��bmp���o�b�N�A�b�v���܂������H";
print "�ƕ�̃t�@�C���Q��D:\\Kahou�ւƈړ�����̂Œ���!!";
<STDIN>;

# D:\kahou�f�B���N�g�����ߑł�
if (-e "D:\\kahou") {
	# 1000�܂�
	for($type=1; $type<1000; $type++) {
		my $targe = "";
		my $mtime = "";
		# bmp��ǂ�
		while (<*.bmp>) {
			# �t�@�C�����ƃt�@�C���̍X�V�������Ƃ��Ă���
			my $filename = $_;
			if ($targe eq "") {
				$targe = $filename;
				$mtime = (stat $filename)[9];
			}
			
			# �o�C�i������������(=�����摜���e")���A�����X�V�����ɂ���B(�������邱�Ƃ�Explorer�Ō����Ƃ��ɃO���[�v�����ꂽ���̂悤�Ɍ�����B
			if (-e $filename and -e $targe and ($filename ne $targe)) {
				if (compare($filename, $targe)==0) {
					utime $mtime, $mtime, $filename;

					 `move $filename D:\\kahou\\$filename`;
				}
			}
		}
		
		# �Ώۃt�@�C���̍X�V�������X�V�B
		utime $mtime, $mtime, $targe;
		`move $targe D:\\kahou\\$targe`;
	}
}