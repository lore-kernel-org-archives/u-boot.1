Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E16BC61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 18:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4CB86FA7;
	Wed, 22 Nov 2023 19:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/d2Wi1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D071586FB2; Wed, 22 Nov 2023 19:54:26 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCCF86DD1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 19:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso149013a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700679263; x=1701284063; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l+m1i8S+I3uwYUji1999YGKC7+eMRXd5iYgvfUz0alo=;
 b=e/d2Wi1z/X3ZRsy9MiaGQq/Ein8HLwGVjVbyFMRqcO2kTtrmRnplfzoYe381woMgCz
 TQ9G71bz625qjG9CAitF4+Op5h7W2M6mO0ksz/Km2m/oz1PemnGA3EC4FMMgfBKW2qkM
 2AYoHawSrYlGJ7AfWas4182uGxzL/bgMS4bdGTqn4nh8CVLvXIkt3uvTf82ION04Z7mj
 DzQjDMh1GcjanYzjSFVKQyoDLy/QNZQZx2MxB/Cx7lbKP/7Yttc3n8TkswnG9bfixq5e
 aj62BIOulvjwfMOmpyStm77xhpePvj+nlJWPBa65kphz3ZhEzqmj/lT4vPlnLEDj4MPk
 YHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700679263; x=1701284063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+m1i8S+I3uwYUji1999YGKC7+eMRXd5iYgvfUz0alo=;
 b=Ats8VcjSnvYez68NSwsxPtAccn0BtGtaReIvirY03z1qQnJ4SSsBHdzqkFIX1tQFaD
 fUJn4ZNmbF0NdNT58vZne3gFYBI60t8hWz/0DIt780Zr/RyZVwUGQdZjBsONla/pH8K9
 ItVhcahEfNp7+3oR3wAGFQcukr0889NDgI8TM2NETFcVC8jds9HBfOPT62297kji+dhQ
 h2J774/bFUeCaZIw9A2Hvvb3h8h/iQIf0vEEHW5CIOF14qwqLNkXSXd7qbmhibGBDZyU
 j83rrv5+1jxg0vfl96/kVbwLTDCq6xEJh25DGHg+3nJ4xt1NvI5Z3ydT0Au0fWhiU3wW
 WMSQ==
X-Gm-Message-State: AOJu0YyDNO87OiyJCibg7ao5tfEAqu4G6mEI+XKLcMZvmkIlGMI+jYJD
 YolFlQteB4UgIxtoxT7xAfnelHKMLG2JCteY14o=
X-Google-Smtp-Source: AGHT+IE/gjOs2oQVfNjBZMxV4ZFeiA4iAGjttpoYPDiWNNtmgSolnbSTw+kjqon+DEtXszNuyR67JfMmStnSMczyrQM=
X-Received: by 2002:aa7:cd74:0:b0:543:5f7a:9e27 with SMTP id
 ca20-20020aa7cd74000000b005435f7a9e27mr2508713edb.12.1700679262921; Wed, 22
 Nov 2023 10:54:22 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <20231122135209.GR2513409@bill-the-cat>
In-Reply-To: <20231122135209.GR2513409@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 18:54:11 +0000
Message-ID: <CALeDE9NoDskjivzwWcHV10g5-bVP-5MkY7Vcp8PrXUoQ1oj_-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rpi5: initial support
To: Tom Rini <trini@konsulko.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>, u-boot@lists.denx.de,
 mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
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

> > These patches bring initial boot support for RPI5. Without it the
> > latest master fails with the message:
> > > DRAM:  mbox: Timeout waiting for response
> > > bcm2835: Could not query ARM memory size
> >
> > With those patches and rpi_arm64_defconfig (with disabled
> > CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
> > serial). FDT comes from firmware (EEPROM).
> >
> > > U-Boot 2024.01-rc3-00003
> > >
> > > DRAM:  1016 MiB (effective 8 GiB)
> > > mbox: Header response code invalid
> > > bcm2835: Could not query board revision
> > > FDT model : Raspberry Pi 5 Model B Rev 1.0
> > > Core:  14 devices, 7 uclasses, devicetree: board
> > > MMC:
> > > Loading Environment from FAT... ** Bad device specification mmc 0 **
> > > In:    serial,usbkbd
> > > Out:   serial,vidconsole
> > > Err:   serial,vidconsole
> > > Net:   No ethernet found.
> > > starting USB...
> > > No working controllers found
> > > Hit any key to stop autoboot:  0
> > > No working controllers found
> > > No ethernet found.
> > > No ethernet found.
> > > U-Boot>
> >
> > These patches are based on v2024.01-rc3 and tested with RPI5 8GB.
> >
> > Known issues:
> > * CONFIG_VIDEO_BCM2835 doesn't work.
> > * MBOX get board revision (0x10002) doesn't work (the response status
> > is 0x8000_0001). Looks like a number of tags doesn't work anymore
> > (board/serial/MAC) but could be fetched from FW FDT.
>
> Nice. I think it's the MMC controller that we should be able to support
> with just a little more work as it's shared with rockchip, and we just
> need to match the compatible, and mirror whatever tweak is also in the
> rpi kernel tree for it.

Is it? According to the RPi DT the sdio1 interface is used to drive
the mSD card (it's SD Express capable which I think is essentially
PCIe/NVME) which has a "brcm,bcm2712-sdhci" compatible [2] which is
added to the sdhci-brcmstb.c driver[3]. We do have a driver for this
but it's not the rockchip driver, I think you may be confused with the
sdhci interface in the RP1 chip which is a designware sdhci IP called
dwcmshc [4].

For the brcmstb sdhci driver we currently have I suspect it'll need at
least a few patches to get the basics working, in the short term I'm
not sure we need the extra bits to drive the SD Express side of things
as I'm sure it can fall back to old modes, looking at the patch it
maybe just enough to add the compatible for what we need, that's what
I was going to start with as it looks like it's similar to other IP
[5].

Peter

[1] https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/bcm2712-rpi-5-b.dts#L354
[2] https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/bcm2712.dtsi#L1164
[3] https://github.com/raspberrypi/linux/commit/b627647c4500d39cb026924b608841fdf4d4d7e9
[4] https://github.com/raspberrypi/linux/commit/80dd8795ca631ac692fd3079487aea6d934a829c
[5] https://github.com/raspberrypi/linux/commit/b627647c4500d39cb026924b608841fdf4d4d7e9#diff-8c952b8cbbb6b3d89e1a401d558b4bd0ecbdf1679cbc5004a31039bc5235c020R172
