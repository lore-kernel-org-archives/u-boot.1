Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6645C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 19:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294E1875B5;
	Wed, 22 Nov 2023 20:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1t+KPk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DA4875AA; Wed, 22 Nov 2023 20:51:50 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F4E875D6
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 20:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so206041a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700682707; x=1701287507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivL12Vy/hzN9lr8ZJP48YwOT66uOr8MHU6DxOuI2OEE=;
 b=Y1t+KPk1GjRSNUYov+863pBWbgEXeOlkltmONzhUzLtUZtL7XRGxdWx9KAo2aS9tCi
 mJNsplqfC0aFxGbUWD2nd1n47bGwvUXsgcfq2D8cNCSEQlC2nDy+roNFQT1TEKHPcvtI
 XX859AKCy1EniE7c0SsfTcrDBExsTxuzpWRSKZAe8U/+lEioK9G84xUDNuMDHlNTbfHv
 AmR5puFfpQs1sk9I/M/BfYPtsALUBAiEow5Zq7auClBD8hp5dfdzK6lJfgV4P19HtVHn
 iH1eLmB6oCea4U2K+snIIKLylb76Cjzf1ys8PLufi5pei776Wq65qAvukmvXLT56T1x4
 MHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700682707; x=1701287507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivL12Vy/hzN9lr8ZJP48YwOT66uOr8MHU6DxOuI2OEE=;
 b=jycn3ToGxqYisOndTD16WWcj/2x4gOFfZMEm6PJ97x3gqNH9+gT6/Q2adPLjosGPBs
 6G6gbnmv9gBUoXk/hXDs20px1X8+IG7TTZaFe9cIR+Tb5Q5uwOR7nARzL8cWu2iSyv0x
 DjKIVutyQ38t3Waqel2HoMAqW7aJxKqIweEpZvtsp5dErIWmKqg7mvihQSWF24oL2g4n
 MeoTJ2/B/l5fwu+592BhMOKJPBpfGPcZsg0L1pY0i04pK73Y2doYOWiPadUD9x9qL0O7
 en5P8CMsLNCWden9WjHEPdYz3EhNFn19OnGQdbi5ArI4LIhj0wTb79bO3BqDreagMW9i
 V50A==
X-Gm-Message-State: AOJu0Yy68j+Fg+WX7w6phur8N3KSfsHQZVmTWA1mMf5r5Dl6nW69whx6
 04yRFu0QxN8KINlN16IFtLsTzk47Xzp468VOd4c=
X-Google-Smtp-Source: AGHT+IH0Z/LQ8TEWjx7ja75P9NiwWhCyS5AF87EcMdNKC6z4XuTMVo6MDLkrF9NTVREmshJ+vBf61eP9/u0m/2aKjgo=
X-Received: by 2002:aa7:cd4c:0:b0:548:587f:45a5 with SMTP id
 v12-20020aa7cd4c000000b00548587f45a5mr2888922edw.24.1700682707550; Wed, 22
 Nov 2023 11:51:47 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
In-Reply-To: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 19:51:36 +0000
Message-ID: <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rpi5: initial support
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
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

Hi Dmitry,

> These patches bring initial boot support for RPI5. Without it the

I've given these a cursory look over, I have a system to test and will
give them a whirl in the next few days, I was planning to start
playing over the weekend so you've provided a great start :)

> latest master fails with the message:
> > DRAM:  mbox: Timeout waiting for response
> > bcm2835: Could not query ARM memory size
>
> With those patches and rpi_arm64_defconfig (with disabled
> CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
> serial). FDT comes from firmware (EEPROM).
>
> > U-Boot 2024.01-rc3-00003
> >
> > DRAM:  1016 MiB (effective 8 GiB)
> > mbox: Header response code invalid
> > bcm2835: Could not query board revision
> > FDT model : Raspberry Pi 5 Model B Rev 1.0
> > Core:  14 devices, 7 uclasses, devicetree: board
> > MMC:
> > Loading Environment from FAT... ** Bad device specification mmc 0 **
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Net:   No ethernet found.
> > starting USB...
> > No working controllers found
> > Hit any key to stop autoboot:  0
> > No working controllers found
> > No ethernet found.
> > No ethernet found.
> > U-Boot>
>
> These patches are based on v2024.01-rc3 and tested with RPI5 8GB.
>
> Known issues:
> * CONFIG_VIDEO_BCM2835 doesn't work.

When you say it doesn't work, does it just not output display or does
the device lock up and you need to disable it?

For the rpi4 it was as simple as adding a new compatible [1] for the
rev6 of the IP block as for the bits that we use in U-Boot nothing
changed, but the kernel changes for the rev7 that's in the RPi5 needed
updating registers [2] so I'm not sure if we're going to need to do
more for this or not.

> * MBOX get board revision (0x10002) doesn't work (the response status
> is 0x8000_0001). Looks like a number of tags doesn't work anymore
> (board/serial/MAC) but could be fetched from FW FDT.

Might be worth looking to see if there's changes in the kernel for
this. In an initial look I didn't see any changes to their kernel
here.

We probably need a patch to the identifier too similar to the following:
https://source.denx.de/u-boot/u-boot/-/commit/5e7e6619c85c090f6b62685a9d90f748f1729d12

Also probably worth adding a note about reviewing support in bcmstb_sdhci.c

Regards,
Peter

> v2:
>   explicitly set .data section for rpi_bcm283x_mbox_addr due to relocation issue
>   update memory map with VPU range
>   add a patch to get human readable model from FW FDT
>
> Dmitry Malkin (3):
>   rpi5: add initial memory map for bcm2712
>   rpi5: add alternative way to get MBOX address via FDT node
>   rpi5: get_board is no longer works. Print model name from FW FDT
>
>  arch/arm/mach-bcm283x/include/mach/base.h |  1 +
>  arch/arm/mach-bcm283x/include/mach/mbox.h |  4 +--
>  arch/arm/mach-bcm283x/init.c              | 40 ++++++++++++++++++++++-
>  board/raspberrypi/rpi/rpi.c               |  6 ++++
>  4 files changed, 48 insertions(+), 3 deletions(-)

[1] https://source.denx.de/u-boot/u-boot/-/commit/0059ef0be903a1f0a9afe5259fb2e0874f78a8ac
[2] https://lists.freedesktop.org/archives/dri-devel/2023-October/428453.html
