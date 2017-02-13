{File : TUGAS BESAR DAP}
{Desc : Aplikasi Penerimaan Mahasiswa Baru}
{Date : April-Mei 2016}
program tubes1301154374;
uses crt;
label
	index;
type

        camaba = record
		idPendaftaran, nilaiUN, idJurusan, idRuangan: integer;
		username, password : string;
        nama, alamat, sekolah : string;
		seks : char;
        end;
type
        administrator = record
        username, password, nama : string;
        end;
type
        ruangUjian = record
        idRuangan : integer;
		pengawas, tanggal : string;
        end;
type
		jurusann = record
		idJurusan : integer;
        namaJurusan : string;
        end;
type
		arrmaba = array [1..100] of camaba;
		arradmin = array [1..100] of administrator;
		arrruangan = array [1..100] of ruangUjian;
		arrjurusan = array [1..100] of jurusann;

const
	kuotaMax = 5;

var
        arsipCamaba : file of camaba;
        arsipAdmin : file of administrator;
        arsipRuangUjian : file of ruangUjian;
        arsipJurusan : file of jurusann;
        arsipcc : file of integer;
        arsipcj : file of integer;
        arsipcr : file of integer;
        arsipIDC : file of integer;
        arsipIDJ : file of integer;
        arsipIDR : file of integer;
        maba : arrmaba;
		admin : arradmin;
		ruangan: arrruangan;
		jurusan : arrjurusan;
		counter : integer;
		cj, cc, cr : integer;
		idJ, idC, idR : integer;
		sesiCamaba, n, i :integer;
		x : char;

procedure loginAdmin;forward;
procedure loginCamaba;forward;
procedure createUser;forward;
procedure updateCamaba(key:integer);forward;
procedure changePassword(key:integer);forward;
function cekUsernameCamaba(key:string):boolean;forward;
function cekPilihanJurusan(key:integer):boolean;forward;
function cekNamaJurusan(key:integer):string;forward;
procedure insertJurusan;forward;
procedure insertRuangan;forward;
procedure sortIdPendaftaran;forward;
procedure sortCamaba;forward;
procedure sortJurusan;forward;
procedure viewCamaba;forward;
procedure viewKartuUjian(key:integer);forward;
procedure viewJurusan;forward;
procedure viewRuangan;forward;
procedure editJurusan;forward;
procedure deleteCamaba;forward;
procedure deleteJurusan;forward;
procedure deleteRuangan;forward;
procedure menuAdmin;forward;
procedure menuCamaba;forward;
procedure copyright;forward;

procedure importData;
begin
	//IMPORT COUNTER
	assign(arsipcc,'cc.dat');
    {$i-} reset(arsipcc);
    {$i+} if (IOResult <> 0) then rewrite(arsipcc);
    while not EOF(arsipcc) do
    	begin
    		read(arsipcc,cc);
    	end;
    close(arsipcc);
    assign(arsipcj,'cj.dat');
    {$i-} reset(arsipcj);
    {$i+} if (IOResult <> 0) then rewrite(arsipcj);
    while not EOF(arsipcj) do
    	begin
    		read(arsipcj,cj);
    	end;
    close(arsipcj);
    assign(arsipcr,'cr.dat');
    {$i-} reset(arsipcr);
    {$i+} if (IOResult <> 0) then rewrite(arsipcr);
    while not EOF(arsipcr) do
    	begin
    		read(arsipcr,cr);
    	end;
    close(arsipcr);

    //IMPORT ID
    assign(arsipIDC,'idC.dat');
    {$i-} reset(arsipIDC);
    {$i+} if (IOResult <> 0) then rewrite(arsipIDC);
    while not EOF(arsipIDC) do
    	begin
    		read(arsipIDC,idC);
    	end;
    close(arsipIDC);
    assign(arsipIDJ,'idJ.dat');
    {$i-} reset(arsipIDJ);
    {$i+} if (IOResult <> 0) then rewrite(arsipIDJ);
    while not EOF(arsipIDJ) do
    	begin
    		read(arsipIDJ,idJ);
    	end;
    close(arsipIDJ);
    assign(arsipIDR,'idR.dat');
    {$i-} reset(arsipIDR);
    {$i+} if (IOResult <> 0) then rewrite(arsipIDR);
    while not EOF(arsipIDR) do
    	begin
    		read(arsipIDR,idR);
    	end;
    close(arsipIDR);

    //IMPORT DATA MABA, JURUSAN, RUANGAN
	assign(arsipCamaba,'camaba.dat');
    {$i-} reset(arsipCamaba);
    {$i+} if (IOResult <> 0) then rewrite(arsipCamaba);
    counter := 0;
    while not EOF(arsipCamaba) do
    	begin
    		inc(counter);
    		read(arsipCamaba,maba[counter]);
    	end;
    close(arsipCamaba);
    assign(arsipJurusan,'jurusan.dat');
    {$i-} reset(arsipJurusan);
    {$i+} if (IOResult <> 0) then rewrite(arsipJurusan);
    counter := 0;
    while not EOF(arsipJurusan) do
    	begin
    		inc(counter);
    		read(arsipJurusan,jurusan[counter]);
    	end;
    close(arsipJurusan);
    assign(arsipRuangUjian,'ruangan.dat');
    {$i-} reset(arsipRuangUjian);
    {$i+} if (IOResult <> 0) then rewrite(arsipRuangUjian);
    counter := 0;
    while not EOF(arsipRuangUjian) do
    	begin
    		inc(counter);
    		read(arsipRuangUjian,ruangan[counter]);
    	end;
    close(arsipRuangUjian);
end;

procedure exportData;
begin
	//EXPORT COUNTER
	assign(arsipcc,'cc.dat');
    rewrite(arsipcc);
  	write(arsipcc,cc);
    close(arsipcc);
    assign(arsipcj,'cj.dat');
    rewrite(arsipcj);
  	write(arsipcj,cj);
    close(arsipcj);
    assign(arsipcr,'cr.dat');
    rewrite(arsipcr);
  	write(arsipcr,cr);
    close(arsipcr);

    //EXPORT ID
	assign(arsipIDC,'idC.dat');
    rewrite(arsipIDC);
  	write(arsipIDC,idC);
    close(arsipIDC);
    assign(arsipIDJ,'idJ.dat');
    rewrite(arsipIDJ);
  	write(arsipIDJ,idJ);
    close(arsipIDJ);
    assign(arsipIDR,'idR.dat');
    rewrite(arsipIDR);
  	write(arsipIDR,idR);
    close(arsipIDR);

    //EXPORT DATA MABA, JURUSAN, RUANGAN
	assign(arsipCamaba,'camaba.dat');
    rewrite(arsipCamaba);
    counter := 0;
    while (counter <= cc) do
    	begin
    		inc(counter);
    		write(arsipCamaba,maba[counter]);
    	end;
    close(arsipCamaba);
    
    assign(arsipJurusan,'jurusan.dat');
    rewrite(arsipJurusan);
    counter := 0;
    while (counter <= cj) do
    	begin
    		inc(counter);
    		write(arsipJurusan,jurusan[counter]);
    	end;
    close(arsipJurusan);
    assign(arsipRuangUjian,'ruangan.dat');
    rewrite(arsipRuangUjian);
    counter := 0;
    while (counter <= cr) do
    	begin
    		inc(counter);
    		write(arsipRuangUjian,ruangan[counter]);
    	end;
	close(arsipRuangUjian);
end;

procedure loginAdmin;
begin
	gotoxy(10,5);writeln('============================');
	gotoxy(10,6);writeln('     ADMINISTRATOR AREA     ');
	gotoxy(10,7);writeln('============================');
	gotoxy(16,8);write('Username : ');
	readln(admin[1].username);
	gotoxy(16,9);write('Password : ');
	readln(admin[1].password);
	if (admin[1].username = 'admin') and (admin[1].password = 'admin') then
			menuAdmin
	else
		begin
		gotoxy(10,10);writeln('Invalid Username or Password');
		end;
end;

procedure loginCamaba;
var
	j : integer;
	key_user, key_pass : string;
	found : boolean;
begin
    j:=1;
    found := false;
    gotoxy(10,5);writeln('=============================');
	gotoxy(10,6);writeln('         CAMABA AREA         ');
	gotoxy(10,7);writeln('=============================');
	gotoxy(16,8);write('Username : ');
	readln(key_user);
	gotoxy(16,9);write('Password : ');
	readln(key_pass);	
	while (j<=cc) do
	begin
        if (maba[j].username = key_user) and (maba[j].password = key_pass) and (j<=cc) then
       	begin
        	found := true;
        	sesiCamaba := maba[j].idPendaftaran;
        	gotoxy(14,10);writeln('Login Sukses.....');
        	delay(1250);
        	menuCamaba;
            break;
        end;
        inc(j);
	end;
	if (found = false) then
		begin
		gotoxy(10,10);writeln('Invalid Username or Password');
		end;
end;

procedure createUser;
var
	key : string;
	tmpmaba : camaba;
begin
	inc(idC);
	inc(cc);
	writeln;
    writeln('=========================');
	writeln('     CREATE NEW USER     ');
	writeln('=========================');
	writeln('idPendaftaran : ', idC);
	repeat
		write('Username : ');readln(key);
	until (cekUsernameCamaba(key)=true);
	write('Password : ');readln(tmpmaba.password);
	maba[cc].idPendaftaran := idC;
	maba[cc].username := key;
	maba[cc].password := tmpmaba.password;
	writeln('Pendaftaran User Berhasil!');
	writeln('Silakan login untuk mengisi data.');
end;

procedure changePassword(key: integer);
label
	atas;
var
	pass_lama, pass_baru1, pass_baru2 : string;
	j : integer;
begin
	atas:
	clrscr;
	writeln('== GANTI PASSWORD ==');
	j := 1;
	while (j<=cc) do
	begin
        if (maba[j].idPendaftaran = key) then
       	begin
			write('Password lama : ');readln(pass_lama);
			if (pass_lama <> maba[j].password) then
			begin
				writeln('Password lama salah!');
				delay(800);
				goto atas;
			end;
			writeln;
			write('Password Baru : ');readln(pass_baru1);
			write('Password Baru (confirmation): ');readln(pass_baru2);
			writeln;
			if (pass_baru1 <> pass_baru2) then
			begin
				writeln('Password baru tidak sama!');
				delay(800);
				goto atas;
			end;
			maba[j].password := pass_baru2;
			break;
		end;
		inc(j);
	end;
	writeln('Password Anda Berhasil Diganti!');
end;

function cekUsernameCamaba(key:string) : boolean;
var
	j : integer;
	found : boolean;
begin
	j := 1;
	cekUsernameCamaba := true;
	while (j<=cc) do
	begin
        if (maba[j].username = key) then
       	begin
        	cekUsernameCamaba := false;
        	writeln('Username Sudah digunakan!');
        break;
        end;
        inc(j);
	end;
end;

function cekPilihanJurusan(key:integer) : boolean;
var
	j : integer;
	found : boolean;
begin
	j := 1;
	cekPilihanJurusan := false;
	while (j<=cj) do
	begin
        if (jurusan[j].idJurusan = key) then
       	begin
        	cekPilihanJurusan := true;
        break;
        end;
        inc(j);
	end;
	if (cekPilihanJurusan = false) then
	writeln('Jurusan Belum Tersedia!');
end;

function cekPilihanRuangan(key:integer) : boolean;
var
	j : integer;
	found : boolean;
begin
	j := 1;
	cekPilihanRuangan := false;
	while (j<=cr) do
	begin
        if (ruangan[j].idRuangan = key) then
       	begin
        	cekPilihanRuangan := true;
        break;
        end;
        inc(j);
	end;
	if (cekPilihanRuangan = false) then
	writeln('Ruangan Belum Tersedia!');
end;

function cekNamaJurusan(key:integer) : string;
var
	j : integer;
	found : boolean;
begin
	j := 1;
	while (j<=cj) do
	begin
        if (jurusan[j].idJurusan = key) then
       	begin
       		found := true;
        	cekNamaJurusan := jurusan[j].namaJurusan;
        	break;
        end;
        inc(j);
	end;
	if (found = false) then
	cekNamaJurusan := 'Error';
end;

function cekKuotaRuangan(key: integer) : boolean;
var
	i, j, t : integer;
	persen : real;
	found : boolean;
begin
	j := 1;
	i := 0;
	found := false;
	cekKuotaRuangan := false;
	while (j<=cc) do
	begin
        if (maba[j].idRuangan = key) then
       	begin
       		found := true;
       		inc(i);
        end;
        inc(j);
	end;
	if (found = true) then
		begin
			if (i < kuotaMax) then
				cekKuotaRuangan := true
		end;
	if (cekKuotaRuangan = false) then
	writeln('Kuota Habis!');
end;


procedure insertJurusan;
var
	confirm : char;
	namaJurusan : string;
begin
	repeat
	begin
	clrscr;
	inc(idJ);
	inc(cj);
	writeln;
	writeln('idJurusan : ', idJ);
	jurusan[cj].idJurusan := idJ;
	write('Nama Jurusan : ');readln(namaJurusan);
	jurusan[cj].namaJurusan := upcase(namaJurusan);
	writeln;
	write('Daftar Selanjutnya (y/n)? ');readln(confirm);
	end
	until (confirm<>'y')
end;

procedure insertRuangan;
var
	confirm : char;
begin
	repeat
	begin
	clrscr;
	inc(idR);
	inc(cr);
	writeln;
	writeln('idRuangan : ', idR);
	ruangan[cr].idRuangan := idR;
	write('Pengawas : ');readln(ruangan[cr].pengawas);
	writeln;
	write('Daftar Selanjutnya (y/n)? ');readln(confirm);
	end
	until (confirm<>'y')
end;

procedure sortIdPendaftaran; //bubblesort
var
	i, j : integer;
	tmp : camaba;
begin
	for i:= cc downto 2 do
	begin
		for j:= 2 to i do
			if(maba[j-1].idPendaftaran) > (maba[j].idPendaftaran) then //ini dari nilai terkecil
				begin
					tmp := maba[j-1];
					maba[j-1] := maba[j];
					maba[j] := tmp;
				end;
	end;
	writeln('Data berhasil diurutkan berdasarkan idPendaftaran!');
end;

procedure sortCamaba; //bubblesort
var
	i, j : integer;
	tmp : camaba;
begin
	writeln('======================================');
	writeln('  APLIKASI PENERIMAAN MAHASISWA BARU  ');
	writeln('======================================');
	writeln('1. Sort Nilai UN (Kecil -> Besar)');
	writeln('2. Sort Nilai UN (Besar -> Kecil)');
	writeln('3. Sort idPendaftaran (Kecil -> Besar)');
	writeln('4. Kembali ke menu');
	write('Pilih Menu : ');
	readln(n);
	case n of
	1 : begin
			clrscr;
			for i:= cc downto 2 do
			begin
				for j:= 2 to i do
					if(maba[j-1].nilaiUN) > (maba[j].nilaiUN) then //ini dari nilai terkecil
						begin
							tmp := maba[j-1];
							maba[j-1] := maba[j];
							maba[j] := tmp;
						end;
			end;
			writeln('Data berhasil diurutkan berdasarkan nilai UN!');
			writeln('              Kecil -> Besar                 ');
		end;
	2 : begin
			clrscr;
			for i:= cc downto 2 do
			begin
				for j:= 2 to i do
					if(maba[j-1].nilaiUN) < (maba[j].nilaiUN) then //ini dari nilai terbesar
						begin
							tmp := maba[j-1];
							maba[j-1] := maba[j];
							maba[j] := tmp;
						end;
			end;
			writeln('Data berhasil diurutkan berdasarkan nilai UN!');
			writeln('              Besar -> Kecil                 ');
		end;
	3 : begin
			clrscr;
			sortIdPendaftaran;
		end;
	else
		clrscr;
		//writeln;
		//writeln('Logout Berhasil!');
	end;
end;

procedure sortJurusan;
var
	i, j : integer;
	tmp : jurusann;
begin
	for i:= cj downto 2 do
	begin
		for j:= 2 to i do
			if(jurusan[j-1].idJurusan) > (jurusan[j].idJurusan) then //ini dari nilai terkecil
				begin
					tmp := jurusan[j-1];
					jurusan[j-1] := jurusan[j];
					jurusan[j] := tmp;
				end;
	end;
	writeln('Data berhasil diurutkan berdasarkan idJurusan!');
end;

procedure sortRuangan; //bubblesort
var
	i, j : integer;
	tmp : ruangUjian;
begin
	for i:= cr downto 2 do
	begin
		for j:= 2 to i do
			if(ruangan[j-1].idRuangan) > (ruangan[j].idRuangan) then //ini dari nilai terkecil
				begin
					tmp := ruangan[j-1];
					ruangan[j-1] := ruangan[j];
					ruangan[j] := tmp;
				end;
	end;
	writeln('Data berhasil diurutkan berdasarkan idRuangan!');
end;

procedure viewCamaba;
var
	jumlah : integer;
	rata : real;
begin
	writeln('=======================================================================');
	writeln('|                         DATA LENGKAP CAMABA                         |');
	writeln('=======================================================================');
	if (cc > 0) then
	begin
		writeln('| ID | Username | Nama Lengkap | L/P | Sekolah | Nilai UN | idJ | idR |');
		writeln('=======================================================================');
		for i:=1 to cc do
		begin
			gotoxy(1,5+i);write('| ');
			gotoxy(3,5+i);write(maba[i].idPendaftaran);
			gotoxy(6,5+i);write('| ');
			gotoxy(8,5+i);write(maba[i].username);
			gotoxy(17,5+i);write('| ');
			gotoxy(19,5+i);write(maba[i].nama);
			gotoxy(32,5+i);write('| ');
			gotoxy(34,5+i);write(maba[i].seks);
			gotoxy(38,5+i);write('| ');
			gotoxy(40,5+i);write(maba[i].sekolah);
			gotoxy(48,5+i);write('| ');
			gotoxy(50,5+i);write(maba[i].nilaiUN);
			gotoxy(59,5+i);write('| ');
			gotoxy(61,5+i);write(maba[i].idJurusan);
			gotoxy(65,5+i);write('| ');
			gotoxy(67,5+i);write(maba[i].idRuangan);
			gotoxy(71,5+i);write('| ');
			jumlah := jumlah + maba[i].nilaiUN;
		end;
		gotoxy(1,6+i);
		writeln('=======================================================================');
		rata := jumlah/cc;
		writeln('Rata-rata Nilai UN : ',rata:2:2);
		writeln('Total : ',cc,' Pendaftar');
		writeln;
	end
	else
		begin
		writeln('                      Data tidak Ditemukan                             ');
		writeln('=======================================================================');
		end;
end;

procedure viewKartuUjian(key : integer);
var
	i, j, t : integer;
	gender, confirm : char;
	found : boolean;
begin
	j := 1;
	t := 1;
	found := false;
	while (j<=cc) do
	begin
        if (maba[j].idPendaftaran = key) then
       	begin
        	clrscr;
        	if (maba[j].idRuangan = 0) then
        		begin
        			found := false;
        			break;
        		end;
        	if (t = 1) then
       			begin
       			writeln('======================================================');
				write('|           KARTU UJIAN CAMABA #',maba[j].idPendaftaran);gotoxy(54,2);writeln('|');
				writeln('======================================================');
				dec(t);
       			end;
        	found := true;
        	gotoxy(3,5);write('No Pendaftaran : ', maba[j].idPendaftaran);
			gotoxy(3,6);write('Username : ', maba[j].username);
        	gotoxy(3,8);write('Nama : ', upcase(maba[j].nama));
			gotoxy(3,9);write('Alamat : ', maba[j].alamat);
			gotoxy(3,10);write('Jenis Kelamin : ', maba[j].seks);
			gotoxy(3,12);write('Sekolah : ', maba[j].sekolah);
			gotoxy(3,13);write('Nilai UN : ', maba[j].nilaiUN);
			gotoxy(3,14);write('Pilihan Jurusan : ', cekNamaJurusan(maba[j].idJurusan));
			gotoxy(3,15);write('Ruang Ujian : ', maba[j].idRuangan);
			gotoxy(3,21);write('#SMB TELKOM PASCAL#');
			for i:=5 to 13 do
				begin
					gotoxy(38,i);write('|');
					gotoxy(48,i);write('|');
				end;
			for i:=38 to 48 do
				begin
					gotoxy(i,5);write('-');
					gotoxy(i,13);write('-');
				end;
			gotoxy(42,8);write('FOTO');
			gotoxy(42,10);write('3x4');
			gotoxy(38,15);write('Bandung,');
			gotoxy(38,16);write('   , April 2016');
			gotoxy(38,20);write(upcase(maba[j].nama));
			for i:=4 to 22 do
				begin
					gotoxy(1,i);writeln('|');
					gotoxy(54,i);writeln('|');
				end;
			gotoxy(1,22);writeln('======================================================');
			gotoxy(1,23);copyright;
			readln;
			break;
        end;
        inc(j);
	end;
	if (found = false) then
		writeln('Silakan Update Data Pendaftaran!');
end;

procedure viewCamabaJurusan;
var
	i, j, key, t : integer;
	persen : real;
	found : boolean;
begin
	found := false;
	viewJurusan;
	write('Data idJurusan : ');
	readln(key);
	clrscr;
	j := 1;
	t := 1;
	i := 0;
	while (j<=cc) do
	begin
        if (maba[j].idJurusan = key) then
       	begin
       		if (t = 1) then
       			begin
       			writeln('======================================================');
				write('|            DATA CAMABA ',jurusan[key].namaJurusan);gotoxy(54,2);writeln('|');
				writeln('======================================================');
				writeln('| ID | Nama Lengkap | L/P | Sekolah | Nilai UN | idR |');
				writeln('======================================================');
				dec(t);
       			end;
        	found := true;
        	inc(i);
        	gotoxy(1,5+i);write('| ');
			gotoxy(3,5+i);write(maba[j].idPendaftaran);
			gotoxy(6,5+i);write('| ');
			gotoxy(8,5+i);write(maba[j].nama);
			gotoxy(21,5+i);write('| ');
			gotoxy(23,5+i);write(maba[j].seks);
			gotoxy(27,5+i);write('| ');
			gotoxy(29,5+i);write(maba[j].sekolah);
			gotoxy(37,5+i);write('| ');
			gotoxy(39,5+i);write(maba[j].nilaiUN);
			gotoxy(48,5+i);write('| ');
			gotoxy(50,5+i);write(maba[j].idRuangan);
			gotoxy(54,5+i);write('| ');
        end;
        inc(j);
	end;
	if (found = true) then
		begin
			gotoxy(1,6+i);writeln('======================================================');
			persen := (i/cc)*100;
    		writeln('Pemilih Jurusan ',jurusan[key].namaJurusan,' : ',i,' dari ',cc,' Peserta (',persen:0:2,'%)');
    		writeln;
		end
		else
			writeln('Data tidak ditemukan');
end;

procedure viewCamabaRuangan;
var
	i, j, key, t : integer;
	persen : real;
	found : boolean;
begin
	found := false;
	viewRuangan;
	write('Data idRuangan : ');
	readln(key);
	clrscr;
	j := 1;
	t := 1;
	i := 0;
	while (j<=cc) do
	begin
        if (maba[j].idRuangan = key) then
       	begin
       		if (t = 1) then
       			begin
       			writeln('==================================================================');
				write('|                      DATA CAMABA RUANGAN #',ruangan[key].idRuangan);gotoxy(66,2);writeln('|');
				write('|                        PENGAWAS : ',upcase(ruangan[key].Pengawas));gotoxy(66,3);writeln('|');
				writeln('==================================================================');
				writeln('| ID | Nama Lengkap | L/P | Sekolah | Nilai UN | Pilihan Jurusan |');
				writeln('==================================================================');
				dec(t);
       			end;
        	found := true;
        	inc(i);
        	gotoxy(1,6+i);write('| ');
			gotoxy(3,6+i);write(maba[j].idPendaftaran);
			gotoxy(6,6+i);write('| ');
			gotoxy(8,6+i);write(maba[j].nama);
			gotoxy(21,6+i);write('| ');
			gotoxy(23,6+i);write(maba[j].seks);
			gotoxy(27,6+i);write('| ');
			gotoxy(29,6+i);write(maba[j].sekolah);
			gotoxy(37,6+i);write('| ');
			gotoxy(39,6+i);write(maba[j].nilaiUN);
			gotoxy(48,6+i);write('| ');
			gotoxy(50,6+i);write(cekNamaJurusan(maba[j].idJurusan));
			gotoxy(66,6+i);write('| ');
        end;
        inc(j);
	end;
	if (found = true) then
		begin
			gotoxy(1,7+i);writeln('==================================================================');
			persen := (i/cc)*100;
			writeln('Sisa Kuota Ruangan #',ruangan[key].idRuangan,' : ',i,' dari ',kuotaMax,' Peserta');
    		writeln('Pemilih Ruangan #',ruangan[key].idRuangan,' : ',i,' dari ',cc,' Peserta (',persen:0:2,'%)');
    		writeln;
		end
		else
			writeln('Data tidak ditemukan');
end;

procedure viewJurusan;
begin
	writeln('====================================');
	writeln('             Jurusan                ');
	writeln('====================================');
	if (cj > 0) then
	begin
		for i:=1 to cj do
		begin
			//gotoxy(5,3+i);
			writeln(jurusan[i].idJurusan,' | ',jurusan[i].namaJurusan);
		end;
	end
	else
		writeln('Data tidak Ditemukan');
	writeln('====================================');
end;

procedure viewRuangan;
begin
	writeln('====================================');
	writeln('             Ruangan                ');
	writeln('====================================');
	if (cr > 0) then
	begin
		for i:=1 to cr do
		begin
			//gotoxy(5,3+i);
			writeln(ruangan[i].idRuangan,' | ',ruangan[i].pengawas);
		end;
	end
	else
		writeln('Data tidak Ditemukan');
	writeln('====================================');
end;

procedure updateCamaba(key:integer);
label
	akhir;
var
	j, pilJ : integer;
	gender, confirm1, confirm : char;
	tmpmaba : camaba;
	update1, update2, found : boolean;
begin
	j := 1;
	found := false;
	update1 := false;
	update2 := false;
	while (j<=cc) do
	begin
        if (maba[j].idPendaftaran = key) then
       	begin
       		repeat
        	clrscr;
        	found := true;
			writeln('Username : ', maba[j].username);
			writeln('== DATA SEBELUMNYA ==');
        	writeln('Nama : ', maba[j].nama);
			writeln('Alamat : ', maba[j].alamat);
			writeln('Jenis Kelamin : ', maba[j].seks);
			writeln('Sekolah : ', maba[j].sekolah);
			writeln('Nilai UN : ', maba[j].nilaiUN);
			writeln('Pilihan Jurusan : ', maba[j].idJurusan);
			writeln('Pilihan Ruangan : ', maba[j].idRuangan);
			repeat
			write('Anda yakin meubah data ini (Y/N)?');readln(confirm1);
			if (upcase(confirm1)='N') then
				begin
					goto akhir;
				end;
			until (upcase(confirm1)='N') or (upcase(confirm1)='Y');
			writeln('== UPDATE ==');
			write('Nama : ');readln(tmpmaba.nama);
			write('Alamat : ');readln(tmpmaba.alamat);
			repeat
			write('Jenis Kelamin (L/P) : ');readln(gender);
			until (upcase(gender)='L') or (upcase(gender)='P');
			write('Sekolah : ');readln(tmpmaba.sekolah);
			repeat
				write('Nilai UN (0-100): ');readln(tmpmaba.nilaiUN);
			until (tmpmaba.nilaiUN >= 0) and (tmpmaba.nilaiUN <= 100);
			viewJurusan;
			if (cj>0) then
				begin
					repeat
						begin
						write('Pilihan Jurusan : ');readln(pilJ);
						update1 := true;
						end;
					until (cekPilihanJurusan(pilJ)=true);
				end
			else
				begin
					break;
				end;
			viewRuangan;
			if (cr>0) then
				begin
					repeat
						begin
						repeat
							begin
							write('Pilihan Ruangan : ');readln(tmpmaba.idRuangan);
							update2 := true;
							end;
						until(cekPilihanRuangan(tmpmaba.idRuangan)=true);
						end;
					until(cekKuotaRuangan(tmpmaba.idRuangan)=true);
				end
			else
				begin
					break;
				end;
			write('Apakah data sudah benar (y/n)? ');readln(confirm);
			until (upcase(confirm)='Y');
			if (update1 = true) and (update2= true) then
			begin
				maba[j].nama := tmpmaba.nama;
				maba[j].alamat := tmpmaba.alamat;
				maba[j].seks := upcase(gender);
				maba[j].sekolah := tmpmaba.sekolah;
				maba[j].nilaiUN := tmpmaba.nilaiUN;
				maba[j].idJurusan := pilJ;
				maba[j].idRuangan := tmpmaba.idRuangan;
				writeln('Data Camaba berhasil di Update!');
			end
			else
				begin
				writeln('Data Gagal di Update!');
				writeln('Pilihan Jurusan dan Ruang Ujian Belum Tersedia');
				break;
        		end
        end;
        inc(j);
	end;
	akhir:
	if (upcase(confirm1)='N') then
		writeln('Data Gagal di Update!');
	if (found = false) then
		writeln('Data tidak ditemukan');
end;

procedure editJurusan;
var
	j, key : integer;
	found : boolean;
	namaJurusan : string;
begin
	j := 1;
	found := false;
	viewJurusan;
	write('Data idJurusan : ');
	readln(key);
	while (j<=cj) do
	begin
        if (jurusan[j].idJurusan = key) then
       	begin
        	found := true;
			writeln('== DATA SEBELUMNYA ==');
        	writeln('Nama Jurusan : ', jurusan[j].namaJurusan);
			writeln('== UPDATE ==');
        	write('Nama Jurusan : ');readln(namaJurusan);
        	jurusan[j].namaJurusan := upcase(namaJurusan);
			writeln('Data Jurusan berhasil dirubah');
        break;
        end;
        inc(j);
	end;
	if (found = false) then
		writeln('Data tidak ditemukan');
end;

procedure editRuangan;
var
	j, key : integer;
	found : boolean;
begin
	j := 1;
	found := false;
	viewRuangan;
	write('Data idRuangan : ');
	readln(key);
	while (j<=cr) do
	begin
        if (ruangan[j].idRuangan = key) then
       	begin
        	found := true;
			writeln('== DATA SEBELUMNYA ==');
        	writeln('Pengawas : ', ruangan[j].pengawas);
			writeln('== UPDATE ==');
        	write('Pengawas : ');readln(ruangan[j].pengawas);
			writeln('Data Ruangan berhasil dirubah');
        break;
        end;
        inc(j);
	end;
	if (found = false) then
		writeln('Data tidak ditemukan');
end;


procedure deleteCamaba;
var
	j, key : integer;
	found : boolean;
begin
	j := 1;
	found := false;
	writeln('= HAPUS DATA CAMABA =');
	write('Data idPendaftaran : ');
	readln(key);
	while (j<=cc) do
	begin
        if (maba[j].idPendaftaran = key) then
       	begin
        	found := true;
        	maba[j] := maba[cc];
        	maba[cc] := maba[cc+1];
			writeln('Data Berhasil Diapus');
			dec(cc);
			sortIdPendaftaran;
        	break;
        end;
        inc(j);
	end;
	if (found = false) then
		writeln('Data tidak ditemukan');
end;

procedure deleteJurusan;
var
	j, key : integer;
	found : boolean;
begin
	j := 1;
	found := false;
	gotoxy(8,1);writeln('= HAPUS DATA JURUSAN =');
	viewJurusan;
	write('[HAPUS] Data idJurusan : ');
	readln(key);
	while (j<=cj) do
	begin
        if (jurusan[j].idJurusan = key) then
       	begin
        	found := true;
        	jurusan[j] := jurusan[cj];
        	jurusan[cj] := jurusan[cj+1];
			writeln('Data Berhasil Diapus');
			cj := cj-1;
			sortJurusan;
        break;
        end;
        inc(j);
	end;
	if (found = false) then
		writeln('Data tidak ditemukan');
end;

procedure deleteRuangan;
var
	j, key : integer;
	found : boolean;
begin
	j := 1;
	found := false;
	gotoxy(8,1);writeln('= HAPUS DATA RUANGAN =');
	viewRuangan;
	write('[HAPUS] Data idRuangan : ');
	readln(key);
	while (j<=cr) do
	begin
        if (ruangan[j].idRuangan = key) then
       	begin
        	found := true;
        	ruangan[j] := ruangan[cr];
        	ruangan[cr] := ruangan[cr+1];
			writeln('Data Berhasil Diapus');
			cr := cr-1;
			sortRuangan;
        break;
        end;
        inc(j);
	end;
	if (found = false) then
		writeln('Data tidak ditemukan');
end;

procedure menuAdmin;
label
	menu;
var
	key, n : integer;
begin
	menu:
	clrscr;
	writeln('==================================');
	writeln('APLIKASI PENERIMAAN MAHASISWA BARU');
	writeln('==================================');
	writeln('1. View Data CAMABA');
	writeln('2. Edit Data CAMABA');
	writeln('3. Delete Data CAMABA');
	writeln('4. Sort Data CAMABA');
	writeln('5. View Data CAMABA [Berdasarkan Jurusan]');
	writeln('6. View Data CAMABA [Berdasarkan Ruang Ujian]');
	writeln('--');
	//writeln('100. Input Data Admin');
	//writeln('--');
	writeln('11. Input Data Ruang Ujian');
	writeln('12. View Data Ruang Ujian');
	writeln('13. Edit Data Ruang Ujian');
	writeln('14. Delete Data Ruang Ujian');
	writeln('--');
	writeln('16. Input Data Jurusan');
	writeln('17. View Data Jurusan');
	writeln('18. Edit Data Jurusan');
	writeln('19. Delete Data Jurusan');
	writeln('--');
	writeln('0. Logout');
	writeln;
	write('Pilih Menu : ');
	readln(n);
	case n of
	1 : begin
			clrscr;
			viewCamaba;
			write('Ingin Kembali Ke Menu Awal ? [y/n] '); read(x);
			if (upcase(x) = 'Y') then
				goto menu;
		end;
	2 : begin
			clrscr;
			write('Data idPendaftaran : ');
			readln(key);
			updateCamaba(key);
			delay(1000);
			goto menu;
		end;
	3 : begin
			clrscr;
			deleteCamaba;
			delay(1000);
			goto menu;
		end;
	4 : begin
			clrscr;
			sortCamaba;
			delay(850);
			goto menu;
		end;
	5 : begin
			clrscr;
			viewCamabaJurusan;
			write('Ingin Kembali Ke Menu Awal ? [y/n] '); read(x);
			if (upcase(x) = 'Y') then
				goto menu;
		end;
	6 : begin
			clrscr;
			viewCamabaRuangan;
			write('Ingin Kembali Ke Menu Awal ? [y/n] '); read(x);
			if (upcase(x) = 'Y') then
				goto menu;
		end;
	11 : begin
			insertRuangan;
			delay(850);
			goto menu;
		end;
	12 : begin
			clrscr;
			viewRuangan;
			write('Ingin Kembali Ke Menu Awal ? [y/n] '); read(x);
			if (upcase(x) = 'Y') then
				goto menu;
		end;
	13 : begin
			clrscr;
			editRuangan;
			delay(1250);
			goto menu;
		end;
	14 : begin
			clrscr;
			deleteRuangan;
			delay(1250);
			goto menu;
		end;
	16 : begin
			insertJurusan;
			delay(850);
			goto menu;
		end;
	17 : begin
			clrscr;
			viewJurusan;
			write('Ingin Kembali Ke Menu Awal ? [y/n] '); read(x);
			if (upcase(x) = 'Y') then
				goto menu;
		end;
	18 : begin
			clrscr;
			editJurusan;
			delay(1250);
			goto menu;
		end;
	19 : begin
			clrscr;
			deleteJurusan;
			delay(1250);
			goto menu;
		end;
	else
		clrscr;
		writeln;
		writeln('Logout Berhasil!');
	end;
end;

procedure menuCamaba;
label
	menu;
var
	j, n : integer;
begin
	menu:
	clrscr;
	writeln('==================================');
	writeln('APLIKASI PENERIMAAN MAHASISWA BARU');
	writeln('==================================');
	writeln('idPendaftaran : ',sesiCamaba);
	writeln('1. Update Data CAMABA');
	writeln('2. View Kartu Ujian');
	writeln('3. Ganti Password');
	writeln('0. Logout');
	write('Pilih Menu : ');
	readln(n);
	case n of
	1 : begin
			clrscr;
			updateCamaba(sesiCamaba);
			delay(1000);
			goto menu;
		end;
	2 : begin
			clrscr;
			viewKartuUjian(sesiCamaba);
			{if (sesiKartu > 0) then
				viewKartuUjian(sesiKartu);
			else
				begin
					writeln('Anda Belum Update Data Peserta Ujian!');
					writeln('         -- Administrator --         ');
				end;}
			delay(1000);
			goto menu;
		end;
	3 : begin
			clrscr;
			changePassword(sesiCamaba);
			delay(1000);
			goto menu;
		end;
	else
		clrscr;
		writeln;
		writeln('Logout Berhasil!');
	end;
end;

procedure copyright;
begin
	writeln('Powered by Fzn.ID | Aplikasi Penerimaan Mahasiswa Baru');
	write  ('          Visit to my Site : http://fazan.id          ');
end;

begin //program UTAMA
	importData;
	index:
	clrscr;
	write(cc);
	gotoxy(10,4);writeln('==================================');
	gotoxy(10,5);writeln('        Selamat Datang di         ');
	gotoxy(10,6);writeln('APLIKASI PENERIMAAN MAHASISWA BARU');
	gotoxy(10,7);writeln('==================================');
	gotoxy(10,8);writeln('1. Buat User Baru');
	gotoxy(10,9);writeln('2. Login CAMABA');
	gotoxy(10,10);writeln('3. Login Admin');
	gotoxy(10,11);writeln('4. Keluar Program');
	gotoxy(10,12);write('Pilih Menu : ');
	readln(n);
	case n of
	1 : begin
			clrscr;
			createUser;
			delay(1250);
			goto index;
		end;
	2 : begin
			clrscr;
			loginCamaba;
			delay(1250);
			goto index;
		end;
	3 : begin
			clrscr;
			loginAdmin;
			delay(1250);
			goto index;
		end;
	else
		clrscr;
		writeln;
		gotoxy(10,4);writeln('Terimakasih Telah Menggunakan Aplikasi ini');
		gotoxy(5,5);copyright;
		readln;
	end;
	exportData;
end.
