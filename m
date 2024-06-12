Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFC1C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 15:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92E88880B;
	Wed, 12 Jun 2024 17:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mZrx/zeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669F68881B; Wed, 12 Jun 2024 17:12:31 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1205288805
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 17:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eae5b2ddd8so9335711fa.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718205148; x=1718809948; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEXVmAtRzZgtzSIFXU+WLIg6ennvJZa8SPs9UIr+frc=;
 b=mZrx/zeAf2U7ArWXcP/eXjEvluZyaCEmjKW3IU4rGPe6RkBFkQAGbb2KeC6a1BbPEg
 bchi2MkF1hu05xGumqurQZpqrlubFhFgTB5YbBqYgCVaCp/EzGdvhtJRxaT7dT4BNmoT
 3wwyLfnvehXSkrX4dP3xzCkAhfblF+zBWxb5dFTWykZZyXHD7seCGYuHkkZRtlEtBrDr
 WCokkWiUVnHzKqFm+1n+1JFWW9lzz+gnpX3CQ7wh9OL9HWegFqF6vJasYg5IMLlthG8P
 /Alhx3tGLNoyhpTyTuqs+Pp7SHz1sa3FOo/GzC5Dw9VbIOxGYFLofcXLPdvolzluL8ZA
 KBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718205148; x=1718809948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEXVmAtRzZgtzSIFXU+WLIg6ennvJZa8SPs9UIr+frc=;
 b=Q6/pN81sCh2v+t7zGmTDirWCqnjZZC2fWvHZHWu3erIv5SooZ8WkiPep+POs/OYMny
 0YPRmtQSlN4cJBQGcjJKQaZ1shTyD+CqaC909bkQghXJRCdeqUtbip2ySNYE6kowjw9B
 ThGvEJLOzSRmz2eLonWnSssRjeNxkco6H5lWqn2r60871fr+cZmjfOVLxzgLei78D+6s
 pgi3fdvnn3xgvMu+ZgobUpFSB4/yRP0P5WyoXsL0PmQgXfesqx4DZ8/iH9Wc2TgLBxrJ
 z4Fn6zkKrBOYEYa4vIocE/yOQrynuP7+ul8D4iHctxhwdvBV8RmAnkB+E/vL1A1xEkv/
 QRDQ==
X-Gm-Message-State: AOJu0YxBkQ1hfCKHXY7q2tRHzc1uTdNRSg3G37DHRVvozH2wvnis5A03
 6k/D1UJr6S/6odPEte46oClm6bqXn6601tGo3+JErOB7iJFgf7cUFWm9ZLliG7WWPuadaEZxC3C
 2NQi7HrZzp2JCXG9q1BCPYJqZWa1jbg==
X-Google-Smtp-Source: AGHT+IEdOJ5IqoPdn8Ns0XCWpxhx5Bdl4cP62pNtD6qqNJV0DsSMrmddYiS+vqnI3gMsVSh/0jUrdtTIE8pYM11pupY=
X-Received: by 2002:a2e:b0d4:0:b0:2eb:eced:accd with SMTP id
 38308e7fff4ca-2ebfc0eac1emr7459751fa.13.1718205147948; Wed, 12 Jun 2024
 08:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDEroWuS5bJRXA5HAU60XRgi-5jxatUA2e3Zk+1Kq1QT2ZdVw@mail.gmail.com>
In-Reply-To: <CAPDEroWuS5bJRXA5HAU60XRgi-5jxatUA2e3Zk+1Kq1QT2ZdVw@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 12 Jun 2024 08:12:16 -0700
Message-ID: <CANV2PTNP+4jCmvb47ZGBRUNw7CCAX77vHSe6JZ0S3Mknqddq6Q@mail.gmail.com>
Subject: Re: Where to put DTB file for UEFI support on ARM
To: Leith Bade <leith@bade.nz>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Leith,

On Wed, Jun 12, 2024 at 5:50=E2=80=AFAM Leith Bade <leith@bade.nz> wrote:
>
> Hi all,
>
> I have a BananaPi BPI-R3 board that I am setting up to boot Ubuntu or
> Debian. After figuring out the required config options I have managed to
> get Uboot to boot the Ubuntu USB installer, and also boot off an SD card
> once I installed Ubuntu there.
>
> I set up the bootmeth/bootdev/bootflow stuff so that the auto boot menu
> works nicely with SD card. For USB I have to drop to console and do manua=
l
> "usb start" etc, but good enough for running the installer. It was a bit
> difficult as there seems to be a lot of older documentation or Google
> results related to using UEFI before the bootflow stuff was added. Also i=
t
> took me a while to figure out that a board/mediatek/mt7986.env file is no=
w
> needed as some of the config options set #define values that are not
> included in /include/configs/mt7986.h board headers - due to .env files
> replacing those #defines. It would be nice to have a default .env file fo=
r
> this board that sets sensible defaults for the various memory loading
> addresses as it took a bit of effort to come up with all the hex values.
>
> However I am struggling to work out where to place the device tree DTB fi=
le
> for the Linux kernel. For this board I need a different DTB for
> U-boot (which is included in the u-boot.bin and fip.bin) and the kernel a=
s
> U-boot's drivers do not like the Linux upstream device tree.
>
> I can see in the UEFI bootmeth code that it searches a location /dtb/ for=
 a
> file named in the $fdtfile environment variable. I tried putting the .dtb
> file at /dtb/mt7986a-bananapi-bpi-r3.dtb on the SD card's FAT32 partition
> that Ubuntu created, however it doesn't seem to load this and the U-boot
> boots with the u-boot.bin DTB which means kernel doesn't start If I
> manually load the correct .dtb file to $fdt_addr_r then the correct DTB i=
s
> used and the kernel starts.

Correct, this is a limitation and the fix is not yet released with
U-Boot;  It is now queued up for U-Boot -next, but only for EFI
bootmanager (not the global EFI boot).

>
> What is the correct location for the .dtb file when using UEFI?

In theory you could just load it from the target Linux OS root
filesystem at /usr/lib/linux-image-... but when I try this there's no
support to read that filesystem within EFI bootmanager;  the files
referenced by EFI bootmanager are however accessible if on the EFI
System Partition. Perhaps I am missing some option to support loading
from partitions other than the EFI System Partition but I don't know
how.

>
> Is there a recommended way of putting the kernel DTB into the NAND or NOR
> chip when using UEFI? That way if the SD card gets wiped U-boot can still
> boot the USB drive. I don't fully understand how the MTD partitions, FIT
> files, UBI files all fit into the picture to have U-boot load the kernel
> DTB from flash.

U-Boot has its own internal FDT (firmware devicetree) which you note
may or may not work well enough to boot Linux kernel and have a
working OS userspace. It is ambiguous if a Linux OS kernel dtb of a
specific board hardware target belongs in any of NAND or NOR flash
since they tend to be tied to specific versions of the Linux kernel,
as things are today. There's no consensus that I've read anywhere on
how this should be done - again not specific to U-Boot.

I can just say from experience that if it would be able to be loaded
from the same rootfs that the Linux kernel resides then there is still
the trouble of not knowing which exact Linux kernel version that the
user will decide to load that boot cycle.

>
> Thanks,
> Leith Bade
> leith@bade.nz

-E Shattow
