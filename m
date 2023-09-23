Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE6FCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 00:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476C98652B;
	Sat, 23 Sep 2023 02:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WdHuG9h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D65486538; Sat, 23 Sep 2023 02:57:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BD38641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 02:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695430634; x=1696035434; i=xypron.glpk@gmx.de;
 bh=IZeEXZMvEFlu2lGmI9pM4ZICQfwGUQCGDh6/WTHrphc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WdHuG9h3x09T6j6eTqSGOCgZsRgXsF9nuTszRSGwglUEvjM9n0p9fnH7yceFT81m2b3D2lc5Pe2
 Y5eetmPfWvOtjZhpGA4+9TxZfVZ1sT7WRTocm8od5twB/c94we1LlrVKPBsdXi0ppzWMi9dnIpZ4E
 fdkiKRC0HsqUAhr6EBIECdDBObw+2FuyQcx9MRu2xGTCWzd3qKvnxLi/at9Kt4daehYdRhiaYh35l
 NfOs3ptwGu5qLN3K+5SWVhvn4apaJlFNyC2F0M+a7+YxOVvWOcevcL1aCfd+4b4veCcgPk8TrYkHm
 0c0OJG9BNa5k78ytehx48CZkYxM5tNlyjY+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1qllZK45LH-007Xj7; Sat, 23
 Sep 2023 02:57:14 +0200
Message-ID: <536f587d-4a84-401a-8235-c3e9dff6756b@gmx.de>
Date: Sat, 23 Sep 2023 02:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reading from ISO9660 in U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gcgntcsY0IuJDnJPeoMgNGdNMsRzZm64KTHIXQ4vY3/UrKmQeGg
 sWfVDzDEqgUZFq/WZhisg0HA6bDStGzLPwVd0up5F+r+gcJCALxXsE0hGrFV1HtNAFblnh6
 3VmFEqMabstWJXz2dlUMy9uX7ZZXB0BZm/Ofk2KbcR5rPs345jx9boASJBDmekO0dEXoX2C
 inLx1hq7A6/WpE2vWJ8vw==
UI-OutboundReport: notjunk:1;M01:P0:/TKEBkwJCCY=;/P1rFtIGji7S/pjLmgVbsLiYSig
 MWgtfRAu1QIs3mKvkJSLUOY6R8RxRkH6uQlgKrRushqz3IfohTQjqfRdGHYOO/VEgKEvpPYXr
 GNYGUtLIblg/iij0ufoju8Bu+Lyvb6n+UmENEnt3j/FbD/1SF1hesahyGew5gWHcd1ajYgEfn
 JdPJnJXzPy8vdL6sKvoFeXPTbvM/CxLtqKxuhXfRlfopJ76eaDzd+UDBSc/yhEtCYy8Cm4MBI
 g39pYwONkISipYAxdUlKdO0xLdLbk184ek2kSnvqDBbLQJDgd1yFWAmIkQC2JvnVaaw/ab4EX
 ZniuoLhZveJRHori0kFs6mTLSfeS2j3BziY4t5LfU+X0pJ1zVDqnQpEoZ7u7793ZpLkMx+uSk
 7vr+A6Np32UrrdrE/f0lTeJrBMlAtgZz7eRfAOu5Td6mnyS5OX8mAFy+Bixoj+vynen3SlEND
 dEOZWFF5FsDHZSry4XtWTABHL7z69HRyAG8BIIP4UIb95sX2iM63hgRjEV80HlMlnqu6bTAM/
 C66JkebCkwVvbEtoLlLfu89PgxAd6T8AiF9QwyZKiPQaekDeI27U/cTrNb/3m5hyMKPaO+yJZ
 I/sXSlFZfuE5G+P3f+woFGho3uL/ng56ZZBdbIB+kwxJbbpiZUUWr7N3a9a/HOoa1gpni0oHn
 rElpTJAfF8VzVC1p8PqVhobvbuWyh8sufUNZQKXlw559byFPv7YXs/TYIf7JeegIn8rZXjDxq
 O7AEmyE9oCgi5IdbpyqWR9rV6Zuc+IAhI+R0neKb+1O53FApFdkQEmAIpIbsSSHO8cFBNdWSk
 Q263695tSwP1PdXavUT2CCh4GEDFCtbTbO+AfaWc5xPjS5Q9gH5EJs557KVOngCMy3iQ/4cih
 iyf0RMDoAI4ciU+Qqz4SEU48oZXv1LJVln53SotSkSCuynpnca5OGcQiy59LsIs5i77Uw1Nnf
 E9xd3A==
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

On 9/23/23 00:13, Simon Glass wrote:
> Hi Heinrick & Bin,
>
> I'd like to be able to figure out in U-Boot what OS is on a USB stick.
> For example, with the Ubuntu installer, I can boot it (through grub),
> but I cannot see how to read anything useful from the USB stick that
> would indicate that it is Ubuntu, what version it is, etc.
>
> Does U-Boot need an ISO9660-filesystem driver for that? Is there any oth=
er way?
>
> With Debian I can see the actual files (linux and initrd) , so it is a
> bit easier.
>
> Regards,
> SImon

The format of the Ubuntu images depends on the architecture. Let's
assume that you relate to amd64
(https://cdimage.ubuntu.com/daily-live/current/mantic-desktop-amd64.iso).

This is a hybrid image, which can be either read as ISO 9660 or as a GPT
partitioned image. This is the gdisk output:

Number  Start (sector)    End (sector)  Size       Code  Name
    1              64        10049451   4.8 GiB     0700  ISO9660
    2        10049452        10059487   4.9 MiB     EF00  Appended2
    3        10059488        10060087   300.0 KiB   0700  Gap1

You can mount partition 2 as FAT file system in Linux:

$ sudo kpartx mantic-desktop-amd64.iso -a -v
[sudo] password for zfsdt:
add map loop1p1 (252:4): 0 10049388 linear 7:1 64
add map loop1p2 (252:5): 0 10036 linear 7:1 10049452
add map loop1p3 (252:6): 0 600 linear 7:1 10059488

$ sudo mount /dev/mapper/loop1p2 /mnt

$ mount
/dev/mapper/loop1p2 on /mnt type vfat
(rw,relatime,fmask=3D0022,dmask=3D0022,codepage=3D437,iocharset=3Diso8859-=
1,shortname=3Dmixed,errors=3Dremount-ro)

The problem is upstream U-Boot is that the partition drivers are scanned
alphabetically: a_efi, dos, iso

If we change this to a_iso, b_efi, dos, we can read the ISO image:

=3D> host bind 0 /tmp/mantic-desktop-amd64.iso
=3D> part list host 0

Partition Map for HOST device 0  --   Partition Type: ISO

Part   Start     Sect x Size Type
   1     3684        4    512 U-Boot
   2 10049452    10036    512 U-Boot

=3D> ls host 0:2
             EFI/

=3D> load host 0:2 $kernel_addr_r EFI/boot/bootx64.efi
960472 bytes read in 0 ms

Unfortunately the sandbox crashes when executing the EFI binary.

So let't try qemu-x86_64_defconfig:

qemu-system-x86_64 -m 3G -nographic -bios u-boot.rom \
-drive if=3Dnone,file=3D/tmp/mantic-desktop-amd64.iso,format=3Draw,id=3DVI=
RTIO1 \
-device virtio-blk,drive=3DVIRTIO1

And voil=C3=A1 your are in GRUB.

As it does not find the /boot directory let's go to the GRUB console:

grub> root=3D(cd0,gpt1)
grub> linux /casper/vmlinuz root=3D/dev/vda1 efi=3Ddebug console=3D/dev/tt=
yS0
grub> initrd /casper/initrd
grub> boot
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path

I have no clue why it stops here.

Best regards

Heinrich






