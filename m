Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9802C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 13:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A8B87C69;
	Thu,  9 May 2024 15:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAjzjcR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547B4880D2; Thu,  9 May 2024 14:52:50 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A6687FCC
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 14:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoni.s.jankowski@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43de92e234dso8761421cf.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715259166; x=1715863966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cd4EMS8JEjXIQ9FWa9p3ofw2roaoBntblTg9cIZLuCE=;
 b=SAjzjcR/Bp4HkwdjsdS036laTt84uPtCr2QjXd2PsmK4v/t+L5hlWW93RG0DF4r7W4
 R3/gn7l0IlP+Fc8aHcf/W+b32K5DyDIpuONjZlmrF/3PrBJ2I5Un2geEyxb+/c5mGsAs
 ldD6+MdWJ5opBfsLyt7UmBCfrm1ns83JzP+eljeIAPugxn5W37tTOn7/8G93NnkNhh8d
 Mc8Chp/4ZgoVjxcupXK+MpMaLW2JPwc16IC6ry+mBKBuRrH/EomsSL7LEPdg7XRKKxu7
 YgUOnZhKJEdepxK2KGxS1iMLOfhl+gGQLEWuSSvvbN8QPSeVRFnPSl8ialPjF3k5lH1v
 PGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715259166; x=1715863966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cd4EMS8JEjXIQ9FWa9p3ofw2roaoBntblTg9cIZLuCE=;
 b=aCOEpl8KVbHjfgmUsfo/vXTt26QrFYkgMxLxno+CovAOmWEEXZPiZFSpOzu6dsWzDG
 QBk74ncOlnTcdtlqJ6GQsnov9RVIDiqRrBtxV2ZvF35RlLuU35vNcFnt01/AcXfAg0iq
 cAs1xBQfdlJVI73hSzHNRSPevF9W4mr0UC+X8u+3jHypCJ61wKSCylSEBetyQxLvOtb/
 axeVoCrjJmCnbhQeWxr/DGdoAOWix9k5cyma0Guw1B1J8H/GJ9hJxXXO0uxFDVnvAdY4
 O/LZLM+LnUBFG60E17ntw0iFbFL1F5vClq4DJrgOIQlGNdRqpTCaO5tlv4A9QLaO7eB8
 DZFw==
X-Gm-Message-State: AOJu0YwS5A0GVX3tEDvBU52yMJ4GFAkyQICAfe57zgR5AXZ+47WN/3Am
 ySRvjAGmdcJJG9a7gDLzmAA1JE6ItzaKGnLcftex2MecbtK41xBl0pv9H9p1ljnVhj9ynyQTfxH
 Y/mxeRQVKumwdNMBWUUZgd6HnSm8=
X-Google-Smtp-Source: AGHT+IGs214hjq+AEIb+q+xJ8vn15NZv4TN1Jplj7HRDmppga2mYTlh0+1S3B+IyUHuJCv3LTkJ8QApm71UjrsNepq4=
X-Received: by 2002:a05:622a:3cd:b0:437:9c7e:ab1f with SMTP id
 d75a77b69052e-43dec39d338mr41769861cf.33.1715259166491; Thu, 09 May 2024
 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAM4sPk_N9e_q4BJ6zaiMyjcunz9gWXwZppdHJ-543coQZdF7ZA@mail.gmail.com>
 <2078483561.3986406.1714678928052@mail.yahoo.com>
 <CAM4sPk9j9sRJdbbOAUFd=vZnqp3b2pmhtjtjZ=WrdF0_aZZd0Q@mail.gmail.com>
In-Reply-To: <CAM4sPk9j9sRJdbbOAUFd=vZnqp3b2pmhtjtjZ=WrdF0_aZZd0Q@mail.gmail.com>
From: Antoni Jankowski <antoni.s.jankowski@gmail.com>
Date: Thu, 9 May 2024 15:52:35 +0300
Message-ID: <CAM4sPk9a7r2AVszB3SMCCHmzEaxAZ2eD_wOKaZXBtBg-G_HOTA@mail.gmail.com>
Subject: Re: U-boot script for RPI with boot partition of ext4 type
To: Jojan <jjvazha@yahoo.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 09 May 2024 15:37:37 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I realised that it's not a good idea to go with an ext4 boot partition with
a RPI, apparently it requires the boot partition to be fat.

Following that I managed to prepare an update and flash it onto the mmc,
however the struggle at the moment is instructing u-boot to use the updated
boot partition - my RPI always boots to the first vfat partition on the
image.
The `boot.scr` script on my boot partitions is as below, moreover the
u-boot environment gets updated adequately, meaning that the BOOT_DEV
variable does change to "mmc 0:2" after an update. This seems to be
completely ignored by u-boot, even when BOOT_DEV was fixed to "mmc 0:2" RPI
booted into the first vfat partition on the image.

boot.scr:

fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
>
> test -n "${BOOT_ORDER}" || setenv BOOT_ORDER "A B"
> test -n "${BOOT_A_LEFT}" || setenv BOOT_A_LEFT 3
> test -n "${BOOT_B_LEFT}" || setenv BOOT_B_LEFT 3
> test -n "${BOOT_DEV}" || setenv BOOT_DEV "mmc 0:1"
>
> setenv bootpart
> setenv raucslot
>
> for BOOT_SLOT in "${BOOT_ORDER}"; do
>   if test "x${bootpart}" !=3D "x"; then
>     # skip remaining slots
>   elif test "x${BOOT_SLOT}" =3D "xA"; then
>     if itest ${BOOT_A_LEFT} -gt 0; then
>       setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1
>       echo "Found valid RAUC slot A"
>       setenv bootpart "/dev/mmcblk0p3"
>       setenv raucslot "A"
>       setenv BOOT_DEV "mmc 0:1"
>     fi
>   elif test "x${BOOT_SLOT}" =3D "xB"; then
>     if itest ${BOOT_B_LEFT} -gt 0; then
>       setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1
>       echo "Found valid RAUC slot B"
>       setenv bootpart "/dev/mmcblk0p4"
>       setenv raucslot "B"
>       setenv BOOT_DEV "mmc 0:2"
>     fi
>   fi
> done
>
> if test -n "${bootpart}"; then
>   setenv bootargs "${bootargs} root=3D${bootpart} rauc.slot=3D${raucslot}=
"
>   saveenv
> else
>   echo "No valid RAUC slot found. Resetting tries to 3"
>   setenv BOOT_A_LEFT 3
>   setenv BOOT_B_LEFT 3
>   saveenv
>   reset
> fi
>
> fatload ${BOOT_DEV} ${kernel_addr_r} @@KERNEL_IMAGETYPE@@
> if test ! -e ${BOOT_DEV} uboot.env; then saveenv; fi;
> @@KERNEL_BOOTCMD@@ ${kernel_addr_r} - ${fdt_addr}
>

Thanks for all the advice,
Antoni



On Mon, May 6, 2024 at 4:29=E2=80=AFPM Antoni Jankowski <
antoni.s.jankowski@gmail.com> wrote:

> Hi Jojan,
>
> I did check the u-boot config, CONFIG_CMD_EXT4 was enabled, CONFIG_CMD_EX=
T4_WRITE
> disabled. I made sure to enable both, replace `fatload` with `ext4laod` a=
nd
> recompiled u-boot.
> Sadly the effect is that the board still does not boot. I've ditched one
> of the boot partitions to make things a bit easier to set up, first
> focusing on the boot partition getting recognized by the system.
>
> I've noticed that the ext4 boot partition contains many more files than
> its vfat equivalent. Below I send the *wic ls* output of the /boot
> partition in set to ext4:
>
> debugfs 1.47.0 (5-Feb-2023)
>>       2   40755 (2)      0      0    1024  6-May-2024 16:03 .
>>       2   40755 (2)      0      0    1024  6-May-2024 16:03 ..
>>      11   40700 (2)      0      0   12288  6-May-2024 16:03 lost+found
>>      12  100644 (1)   1000   1000   22387200  6-May-2024 16:03 Image
>>      13  100644 (1)   1000   1000   52424  6-May-2024 16:03
>> bcm2711-rpi-4-b.dtb
>>      14  100644 (1)   1000   1000   52556  6-May-2024 16:03
>> bcm2711-rpi-400.dtb
>>      15  100644 (1)   1000   1000   53165  6-May-2024 16:03
>> bcm2711-rpi-cm4.dtb
>>      16  100644 (1)   1000   1000     386  6-May-2024 16:03 boot.scr
>>      17  100644 (1)   1000   1000   52460  6-May-2024 16:03 bootcode.bin
>>      18  100644 (1)   1000   1000     197  6-May-2024 16:03 cmdline.txt
>>      19  100644 (1)   1000   1000    2214  6-May-2024 16:03 config.txt
>>      20  100644 (1)   1000   1000    7262  6-May-2024 16:03 fixup.dat
>>      21  100644 (1)   1000   1000    5399  6-May-2024 16:03 fixup4.dat
>>      22  100644 (1)   1000   1000    3170  6-May-2024 16:03 fixup4cd.dat
>>      23  100644 (1)   1000   1000    8379  6-May-2024 16:03 fixup4db.dat
>>      24  100644 (1)   1000   1000    8379  6-May-2024 16:03 fixup4x.dat
>>      25  100644 (1)   1000   1000    3170  6-May-2024 16:03 fixup_cd.dat
>>      26  100644 (1)   1000   1000   10228  6-May-2024 16:03 fixup_db.dat
>>      27  100644 (1)   1000   1000   10226  6-May-2024 16:03 fixup_x.dat
>>      28  100644 (1)   1000   1000   589368  6-May-2024 16:03 kernel8.img
>>      29   40755 (2)   1000   1000    3072  6-May-2024 16:03 overlays
>>      73  100644 (1)   1000   1000       0  6-May-2024 16:03
>> rpi-bootfiles-20220830.stamp
>>      74  100644 (1)   1000   1000   2973536  6-May-2024 16:03 start.elf
>>      75  100644 (1)   1000   1000   2249280  6-May-2024 16:03 start4.elf
>>      76  100644 (1)   1000   1000   803964  6-May-2024 16:03 start4cd.el=
f
>>      77  100644 (1)   1000   1000   3744808  6-May-2024 16:03 start4db.e=
lf
>>      78  100644 (1)   1000   1000   2996680  6-May-2024 16:03 start4x.el=
f
>>      79  100644 (1)   1000   1000   803964  6-May-2024 16:03 start_cd.el=
f
>>      80  100644 (1)   1000   1000   4816712  6-May-2024 16:03 start_db.e=
lf
>>      81  100644 (1)   1000   1000   3720360  6-May-2024 16:03 start_x.el=
f
>>
>
> Meanwhile, the same partition in a vfat form looks completely different, =
I
> suppose the additional files are related to u-boot, but I am not sure why
> that is happening.
>
> Volume in drive : is boot
>>  Volume Serial Number is 2C31-E8B4
>> Directory for ::/
>> IMAGE         22387200 2011-04-05  23:00  Image
>> BCM271~1 DTB     52424 2011-04-05  23:00  bcm2711-rpi-4-b.dtb
>> BCM271~2 DTB     52556 2011-04-05  23:00  bcm2711-rpi-400.dtb
>> BCM271~3 DTB     53165 2011-04-05  23:00  bcm2711-rpi-cm4.dtb
>> boot     scr       385 2011-04-05  23:00
>> bootcode bin     52460 2011-04-05  23:00
>> cmdline  txt       197 2011-04-05  23:00
>> config   txt      2214 2011-04-05  23:00
>> fixup    dat      7262 2011-04-05  23:00
>> fixup4   dat      5399 2011-04-05  23:00
>> fixup4cd dat      3170 2011-04-05  23:00
>> fixup4db dat      8379 2011-04-05  23:00
>> fixup4x  dat      8379 2011-04-05  23:00
>> fixup_cd dat      3170 2011-04-05  23:00
>> fixup_db dat     10228 2011-04-05  23:00
>> fixup_x  dat     10226 2011-04-05  23:00
>> kernel8  img    589368 2011-04-05  23:00
>> overlays     <DIR>     2011-04-05  23:00
>> RPI-BO~1 STA         0 2011-04-05  23:00  rpi-bootfiles-20220830.stamp
>> start    elf   2973536 2011-04-05  23:00
>> start4   elf   2249280 2011-04-05  23:00
>> start4cd elf    803964 2011-04-05  23:00
>> start4db elf   3744808 2011-04-05  23:00
>> start4x  elf   2996680 2011-04-05  23:00
>> start_cd elf    803964 2011-04-05  23:00
>> start_db elf   4816712 2011-04-05  23:00
>> start_x  elf   3720360 2011-04-05  23:00
>>        27 files          45 355 486 bytes
>>                          90 558 464 bytes free
>
>
> There is also a difference in the vfat being known as a boot drive with
> more information available, agin not sure why.
> Anyway, thanks for the tips, if you have more of them, please let me know
> :)
>
> Best regards,
> Antoni
>
> On Thu, May 2, 2024 at 10:42=E2=80=AFPM Jojan <jjvazha@yahoo.com> wrote:
>
>> You have to use ext4load mmc 0:1 ${kernel_addr}  ${image}
>>
>> Can you check CONFIG_CMD_EXT4  or CONFIG_CMD_EXT4_WRITE is enabled ?
>>
>>
>>
>> On Thursday, May 2, 2024 at 06:19:11 AM PDT, Antoni Jankowski <
>> antoni.s.jankowski@gmail.com> wrote:
>>
>>
>> Hi,
>>
>> I'm working with a Raspberry Pi Compute Module 4 and RAUC update tool fo=
r
>> embedded linux.
>> The problem I'm struggling with is to update both the rootfs and the boo=
t
>> partition. The approach I'm trying to apply is based on an architecture =
of
>> two boot partitions and two rootfs partitions.
>> The boot and rootfs partitions are supposed to get updated in pairs.
>>
>> boot_A (/dev/mmcblk0p1)
>> boot_B (/dev/mmcblk0p2)
>> rootfs_A (/dev/mmcblk0p3)
>> rootfs_B (/dev/mmcblk0p4)
>>
>> For RAUC to be able to write an update to a boot partition it has to be =
of
>> *ext4* type and this is the real problem. What should be the u-boot
>> *boot.scr* script to handle this?
>> I've read that *fatload* should be replaced with *ext4load* instruction,
>> however such a simple swap does not work well, the board does not boot a=
t
>> all.
>> Are there any other steps I should take to make the board bootable with =
an
>> ext4 boot partition?
>>
>> Below is the source of my original *boot.scr* script:
>>
>> fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
>> >
>> > setenv bootpart "/dev/mmcblk0p3"
>> > setenv raucslot "A"
>> > setenv bootargs "${bootargs} root=3D${bootpart} rauc.slot=3D${raucslot=
}"
>> > fatload mmc 0:1 ${kernel_addr_r} @@KERNEL_IMAGETYPE@@
>> > if test ! -e mmc 0:1 uboot.env; then saveenv; fi;
>> > @@KERNEL_BOOTCMD@@ ${kernel_addr_r} - ${fdt_addr}
>> >
>>
>> Best regards,
>> Antoni
>>
>
