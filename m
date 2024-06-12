Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A16C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 12:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AB8887FE;
	Wed, 12 Jun 2024 14:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=bade.nz header.i=@bade.nz header.b="AdLbO2NS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184CC8859A; Wed, 12 Jun 2024 13:50:04 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9526883CF
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leith@leithalweapon.geek.nz
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-24542b8607fso1016851fac.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bade.nz; s=google; t=1718192998; x=1718797798; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mfBIB3ZqOQbrMxmgobDPFRfd3NdE8siDEkXPTj9pVNY=;
 b=AdLbO2NSijDhYhsDKvLPb1mglpe91WT/u9las/DZWEGzTvP9HVMac6bGYYkImLnGJ+
 Orsz9TIZ/X8M51012ntEO0hXxtRFrJiCN88Ygmrrf8/xhrLz2jjrH0i6bCj87F9I+qo3
 bedW03FkcTeT4Rf5xwbCWWzzp6bjQyemEEZYzUxhONHuSTj3uiGq1OlpPGtEi+4Y/WVs
 ZXVTXtX9f9sb5OQBgJdac51Lq74NBBWHDdprqg8tfWs0olroJBzNVOK8D3IBeQr5m6mB
 uac6GcP41w+Mk3xTrauZzPbImJ4SjpxjEPstTdM4KDsi6wQ2TgmEUeCxkiKh6TSEWhPE
 EWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718192998; x=1718797798;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mfBIB3ZqOQbrMxmgobDPFRfd3NdE8siDEkXPTj9pVNY=;
 b=bwulhPirMniSu28OGwhJVzZxFhBvbSed42vL3bc/DajT/OkGwjauUQVdnNQ2NggWxp
 SBkpXP34o3W1zlmlajIhDMKoxVno3/shj09xEgKCKv5qjGtQ0BOmNcuadEdad/VbSnL+
 fddQPRXHlpgwoov4789uAvlkoSdvwC6sGNVt+A5mfm4JUtSbwqWyFoI/Cmc9PjPljOuc
 CBDOCo9HqukZXKe05dLvPf9jUT+TEkrlwKMuTMEPr9BzJIdhQqBvP057ZIAZpS61PGBM
 EKcSh58fHkSOhclpNL7ISiq1+1XCO1LxU4or8/Yfqh5vv6OZlQsuuXsMvctBhP+/Eh73
 nLMw==
X-Gm-Message-State: AOJu0YwuCL2p4VJAagaySyC9f4xwTA4qJwKlX5BOFaNC0V6JgENEqeiM
 ZuUB1jVIDRKqoCLjPmBQo6CJ/RR9YGN8MTLzZQIkuOWcFd5YFShIP4EtPbuO5q6GnzjnjdEekTE
 18Uowe/ayAYWArppt3p5KeM1almwSMJhZasT+dYRqvVzklnYlLVTE
X-Google-Smtp-Source: AGHT+IHy/gcUu/dmqiK1gmCqswCMEpuhgWLc1d85RORtqJLXzKddsnzHYoQhZXygXS6tyiNSyEVcf1UOrdi+sE7Vjk8=
X-Received: by 2002:a05:6870:8a08:b0:24f:edb7:be5f with SMTP id
 586e51a60fabf-25514c702c1mr1657719fac.30.1718192997619; Wed, 12 Jun 2024
 04:49:57 -0700 (PDT)
MIME-Version: 1.0
From: Leith Bade <leith@bade.nz>
Date: Wed, 12 Jun 2024 21:49:45 +1000
Message-ID: <CAPDEroWuS5bJRXA5HAU60XRgi-5jxatUA2e3Zk+1Kq1QT2ZdVw@mail.gmail.com>
Subject: Where to put DTB file for UEFI support on ARM
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 12 Jun 2024 14:49:51 +0200
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

I have a BananaPi BPI-R3 board that I am setting up to boot Ubuntu or
Debian. After figuring out the required config options I have managed to
get Uboot to boot the Ubuntu USB installer, and also boot off an SD card
once I installed Ubuntu there.

I set up the bootmeth/bootdev/bootflow stuff so that the auto boot menu
works nicely with SD card. For USB I have to drop to console and do manual
"usb start" etc, but good enough for running the installer. It was a bit
difficult as there seems to be a lot of older documentation or Google
results related to using UEFI before the bootflow stuff was added. Also it
took me a while to figure out that a board/mediatek/mt7986.env file is now
needed as some of the config options set #define values that are not
included in /include/configs/mt7986.h board headers - due to .env files
replacing those #defines. It would be nice to have a default .env file for
this board that sets sensible defaults for the various memory loading
addresses as it took a bit of effort to come up with all the hex values.

However I am struggling to work out where to place the device tree DTB file
for the Linux kernel. For this board I need a different DTB for
U-boot (which is included in the u-boot.bin and fip.bin) and the kernel as
U-boot's drivers do not like the Linux upstream device tree.

I can see in the UEFI bootmeth code that it searches a location /dtb/ for a
file named in the $fdtfile environment variable. I tried putting the .dtb
file at /dtb/mt7986a-bananapi-bpi-r3.dtb on the SD card's FAT32 partition
that Ubuntu created, however it doesn't seem to load this and the U-boot
boots with the u-boot.bin DTB which means kernel doesn't start If I
manually load the correct .dtb file to $fdt_addr_r then the correct DTB is
used and the kernel starts.

What is the correct location for the .dtb file when using UEFI?

Is there a recommended way of putting the kernel DTB into the NAND or NOR
chip when using UEFI? That way if the SD card gets wiped U-boot can still
boot the USB drive. I don't fully understand how the MTD partitions, FIT
files, UBI files all fit into the picture to have U-boot load the kernel
DTB from flash.

Thanks,
Leith Bade
leith@bade.nz
