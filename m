Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C97C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 23:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5C1888AD;
	Thu, 13 Jun 2024 01:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=bade.nz header.i=@bade.nz header.b="dYvifg+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239EA8886E; Thu, 13 Jun 2024 00:05:27 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B45A885A4
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 00:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leith@leithalweapon.geek.nz
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5babfde1c04so180234eaf.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bade.nz; s=google; t=1718229920; x=1718834720; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n7vxhgvSEfHFXUFUTBxxD3SufcSYN9bqmwkK7ZEXZYE=;
 b=dYvifg+M62Y8J9rhWhpD/aMeohQhFRlIrRYs3xF0dKqlXvoO9WjgPGkeGP9Le/ZgOI
 Zxi7WGNEDqe3Ln8Ajvgnz34qCYkutn/DGuKMpgsTR6TsajAUKA+JOqJjh5SCGGmKkElh
 QPOpEp521C2rJs7SIsEaN0xhzYrQc7YB4LFhR9s1B1kRW9xs+R1m39lki/4kXn26raQk
 U6MlrYIWYHxlC+ooRI9W6j1ojzbgErdUNdMxf47pWcwq3f5j08ZLeZYvLmoGKFVkm1jD
 Tpdekl1bmZzXl6Onz+k0Kdz5/ao6913y5wrTKlzKuD1f/he3pREUB/919nufMLN6Fj3/
 cGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718229920; x=1718834720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7vxhgvSEfHFXUFUTBxxD3SufcSYN9bqmwkK7ZEXZYE=;
 b=CE6UCE1v/2zfT3+yNPe0EGNs6sQDGu5Ay1schfESuBrTpGlThwN0qe7m7Df2CyVKIa
 U9VL45f7hxKTmMFVXOnj+qT+pPWvmIXpYAQfPDBUjCrmc9t6FHHRhAFSDmd5sp0r1zC6
 Cw8+DHlbJML+2f6CAyz3P/ArMZIAAoejehrGnYUQWAC/Txc5dQ10/pqNcgDR1OH+dDJh
 zVAuzqdFob6E0iOoo0akO+y29zdEzQZShZxYwZSpT8wYAP5k8kVU8jxbCDS2/kX983xp
 ocPLTaB9vSgU4r2nSzpg1TMlnRqyTC/PZN6cb+ljH0hg1aW0t2+Y2ic+Xd9AODGbST9y
 yVZQ==
X-Gm-Message-State: AOJu0Yymeb4RPJr436dME4j5uPqi6GhmXog8KLU3wj66g0ESrFllq9g3
 lCY9SrtDYJjaD6WaYxhpYLAaDGYHy2AG+Ml0RgUS7UOkoYphD+89ZewuHXrVu7OvcnQFiMZ+C/r
 RzzP5eXKnxIatLTeL/ihIXCRNnBmmdtWj/+Md
X-Google-Smtp-Source: AGHT+IGbpiT5HI2zHRgdBKayw68BZPFR4O53PHw99lUSuEddMRlYRSJ7aHN9utZmnjZooVN9PMGoC0gvdhvPDqB2SFc=
X-Received: by 2002:a05:6820:618:b0:5ba:71ce:f82c with SMTP id
 006d021491bc7-5bb3b95421bmr3230880eaf.3.1718229920512; Wed, 12 Jun 2024
 15:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDEroWuS5bJRXA5HAU60XRgi-5jxatUA2e3Zk+1Kq1QT2ZdVw@mail.gmail.com>
 <CANV2PTNP+4jCmvb47ZGBRUNw7CCAX77vHSe6JZ0S3Mknqddq6Q@mail.gmail.com>
In-Reply-To: <CANV2PTNP+4jCmvb47ZGBRUNw7CCAX77vHSe6JZ0S3Mknqddq6Q@mail.gmail.com>
From: Leith Bade <leith@bade.nz>
Date: Thu, 13 Jun 2024 08:05:09 +1000
Message-ID: <CAPDEroXQfMLHhhnq6aJZy0Fb-05-weZ5mq7RTiVkt0S_Owz8WQ@mail.gmail.com>
Subject: Re: Where to put DTB file for UEFI support on ARM
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 13 Jun 2024 01:41:34 +0200
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

Hi E Shattow,

Thanks for the quick response.

On Thu, 13 Jun 2024 at 01:12, E Shattow <lucent@gmail.com> wrote:

>
> Correct, this is a limitation and the fix is not yet released with
> U-Boot;  It is now queued up for U-Boot -next, but only for EFI
> bootmanager (not the global EFI boot).
>

Do you have a link to the relevant commit/patches for me to try?


>
> >
> > What is the correct location for the .dtb file when using UEFI?
>
> In theory you could just load it from the target Linux OS root
> filesystem at /usr/lib/linux-image-... but when I try this there's no
> support to read that filesystem within EFI bootmanager;  the files
> referenced by EFI bootmanager are however accessible if on the EFI
> System Partition. Perhaps I am missing some option to support loading
> from partitions other than the EFI System Partition but I don't know
> how.
>

That is actually a useful suggestion. With the Ubuntu I have booting the
ESP is mounted at /boot/efi so it should be possible to get it to place the
DTB files on the FAT partition. However I don't think this will work with
the "off the shelf" USB Ubuntu/Debian installer images as I think the DTBs
are only in the rootfs not the ESP.


>
> >
> > Is there a recommended way of putting the kernel DTB into the NAND or N=
OR
> > chip when using UEFI? That way if the SD card gets wiped U-boot can sti=
ll
> > boot the USB drive. I don't fully understand how the MTD partitions, FI=
T
> > files, UBI files all fit into the picture to have U-boot load the kerne=
l
> > DTB from flash.
>
> U-Boot has its own internal FDT (firmware devicetree) which you note
> may or may not work well enough to boot Linux kernel and have a
> working OS userspace. It is ambiguous if a Linux OS kernel dtb of a
> specific board hardware target belongs in any of NAND or NOR flash
> since they tend to be tied to specific versions of the Linux kernel,
> as things are today. There's no consensus that I've read anywhere on
> how this should be done - again not specific to U-Boot.
>
> I can just say from experience that if it would be able to be loaded
> from the same rootfs that the Linux kernel resides then there is still
> the trouble of not knowing which exact Linux kernel version that the
> user will decide to load that boot cycle.
>

This does seem like a sensible idea as the DTS files do seem to be very
specific to the kernels/drivers they are built against, which is noticeable
when comparing the DTS files from the Mediatek SDK or OpenWRT to the
in-tree Linux file. I guess in the x86 world with ACPI things are far more
standardised.

The reason I had thought about bundling the DTS with the boot loader was
due to my familiarity of that x86 way of thinking where one firmware image
can boot multiple OS no problem.

I did some more reading up on FIT files and realised that it provides a way
to tell U-boot where to load the files. I wonder if it can be used for just
loading the device tree (and potentially any overlays) to the right place
for the EFI boot manager to find it.

So it seems like these are my potential options:
- put DTB file on EFS FAT partition - needs U-boot next patches and might
not work with USB installer stick, but should work once OS is installed.
However I am not sure if the partition should be pre-provisioned or if the
Ubuntu/Debian installers will reformat the partition or leave it alone.
- get U-boot EFI manager to read DTB file from rootfs or add script to do
that - might work with USB installer stick if this board's DTB is included
- put DTB file somewhere else and possibly use FIT to auto-load it. It
could be placed in NOR/NAND chip if that is used to boot, or maybe even one
of the eMMC boot partitions so that it is safe from installer reformatting

Thanks, Leith

On Thu, 13 Jun 2024 at 01:12, E Shattow <lucent@gmail.com> wrote:

> Hi Leith,
>
> On Wed, Jun 12, 2024 at 5:50=E2=80=AFAM Leith Bade <leith@bade.nz> wrote:
> >
> > Hi all,
> >
> > I have a BananaPi BPI-R3 board that I am setting up to boot Ubuntu or
> > Debian. After figuring out the required config options I have managed t=
o
> > get Uboot to boot the Ubuntu USB installer, and also boot off an SD car=
d
> > once I installed Ubuntu there.
> >
> > I set up the bootmeth/bootdev/bootflow stuff so that the auto boot menu
> > works nicely with SD card. For USB I have to drop to console and do
> manual
> > "usb start" etc, but good enough for running the installer. It was a bi=
t
> > difficult as there seems to be a lot of older documentation or Google
> > results related to using UEFI before the bootflow stuff was added. Also
> it
> > took me a while to figure out that a board/mediatek/mt7986.env file is
> now
> > needed as some of the config options set #define values that are not
> > included in /include/configs/mt7986.h board headers - due to .env files
> > replacing those #defines. It would be nice to have a default .env file
> for
> > this board that sets sensible defaults for the various memory loading
> > addresses as it took a bit of effort to come up with all the hex values=
.
> >
> > However I am struggling to work out where to place the device tree DTB
> file
> > for the Linux kernel. For this board I need a different DTB for
> > U-boot (which is included in the u-boot.bin and fip.bin) and the kernel
> as
> > U-boot's drivers do not like the Linux upstream device tree.
> >
> > I can see in the UEFI bootmeth code that it searches a location /dtb/
> for a
> > file named in the $fdtfile environment variable. I tried putting the .d=
tb
> > file at /dtb/mt7986a-bananapi-bpi-r3.dtb on the SD card's FAT32 partiti=
on
> > that Ubuntu created, however it doesn't seem to load this and the U-boo=
t
> > boots with the u-boot.bin DTB which means kernel doesn't start If I
> > manually load the correct .dtb file to $fdt_addr_r then the correct DTB
> is
> > used and the kernel starts.
>
> Correct, this is a limitation and the fix is not yet released with
> U-Boot;  It is now queued up for U-Boot -next, but only for EFI
> bootmanager (not the global EFI boot).
>
> >
> > What is the correct location for the .dtb file when using UEFI?
>
> In theory you could just load it from the target Linux OS root
> filesystem at /usr/lib/linux-image-... but when I try this there's no
> support to read that filesystem within EFI bootmanager;  the files
> referenced by EFI bootmanager are however accessible if on the EFI
> System Partition. Perhaps I am missing some option to support loading
> from partitions other than the EFI System Partition but I don't know
> how.
>
> >
> > Is there a recommended way of putting the kernel DTB into the NAND or N=
OR
> > chip when using UEFI? That way if the SD card gets wiped U-boot can sti=
ll
> > boot the USB drive. I don't fully understand how the MTD partitions, FI=
T
> > files, UBI files all fit into the picture to have U-boot load the kerne=
l
> > DTB from flash.
>
> U-Boot has its own internal FDT (firmware devicetree) which you note
> may or may not work well enough to boot Linux kernel and have a
> working OS userspace. It is ambiguous if a Linux OS kernel dtb of a
> specific board hardware target belongs in any of NAND or NOR flash
> since they tend to be tied to specific versions of the Linux kernel,
> as things are today. There's no consensus that I've read anywhere on
> how this should be done - again not specific to U-Boot.
>
> I can just say from experience that if it would be able to be loaded
> from the same rootfs that the Linux kernel resides then there is still
> the trouble of not knowing which exact Linux kernel version that the
> user will decide to load that boot cycle.
>
> >
> > Thanks,
> > Leith Bade
> > leith@bade.nz
>
> -E Shattow
>
