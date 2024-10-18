Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5AAD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4C689234;
	Fri, 18 Oct 2024 17:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L5qpg0lM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FF989169; Fri, 18 Oct 2024 17:01:22 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E30089234
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so18021316d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263670; x=1729868470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7rTso333YvMlqq03REfldGj8wSbD08xdDGwnkITrCtE=;
 b=L5qpg0lMOe/Rlqc07IDPRQBcC8qw8nBVdgS5mJfO6i6VA/H925uSeHNMIYGJ0EVie+
 YhLtQIoGMzpSPtRJ00/SKTRPrqBQ4GMr+Sf4F9XHto4GXdmM9IuIBDWGit+FPSbY40wA
 D1biMSS8NnO/6l6x7yip0PdBp8OY9z+/GmoRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263670; x=1729868470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7rTso333YvMlqq03REfldGj8wSbD08xdDGwnkITrCtE=;
 b=KEG6K/GnwzCLwjynv/vF8Dwtm9gQkvSa57GN+SIfmg8eJ69RqedvgxHCGLQmppUsrU
 6qizL0eF2kEWKw1h31ABPb0F0PuaGEVP7AcvEkYATw0J6YQ2LQ5sSWWo7RBWbnHqd04s
 Z7KMbAyutcClrykmcxi+RhnX02RzJxFLOK0XheDgtzEOW3b1k38wqy6t8nzCBNUQwKch
 tkj/FLC00TGYNz2B4Md4nNs3HJi9e2vxEo/Gqc3Nbc7OAyLeK2ehkqe5AsOJj3aBJVO0
 T8fdr7qiqcjS0CtOV2i6AuDx+uH+9gO5EUyawW/66zIdYgN1tbJvNSMIKo+3wOWPAQD3
 qwRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKe/cQUfT9+vKLfAAJ/JmKyr9hBRpdZt/k50xEO2AepjXeQbfPAyWj5dxZminvqiCTvva1EyQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy10Sog8sSyadjTwxso5HodIbbxiqViCsfc21yKTwnQZiTElKt
 y+eyMRlm9u3Vyje5rwxLQbHQfTMiSiP5oEz+tn+VOPHUrHEW2/szyA6H+2OGUeZxg2xqk4ksk2P
 WV6dmclWPtAiLMmsTtz1w4WQUPzA7VxNYZdbh
X-Google-Smtp-Source: AGHT+IGrtaXOGpbiDgxontGzQk8WeKrluxRyFnqNtsgZzNyQpEolRn+bLU2zbQgMLkVyibbOVJNTfKl26brF+6cZs1o=
X-Received: by 2002:a05:6214:1d25:b0:6cb:5ef6:93e9 with SMTP id
 6a1803df08f44-6cc37851786mr115821506d6.9.1729263670148; Fri, 18 Oct 2024
 08:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
In-Reply-To: <20241018043858.GV4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:00:49 -0600
Message-ID: <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:
>
> > In principle bootstd can work without block devices, even if it does
> > require driver model to be enabled in that case.
> >
> > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > is now defined, producing recursive errors through multiple different
> > paths, one of which is this (with Linksprite_pcDuino3 and
> > BOOTSTD_DEFAULTS enabled):
> >
> >   arch/arm/Kconfig:7:error: recursive dependency detected!
> >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
> >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> >      part of choice <choice>
> >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> >      ARCH_UNIPHIER_V8_MULTI
> >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> >      part of choice SPL
> >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
> >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> >      choice <choice>
> >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> >      ASPEED_AST2500
> >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> >      choice DM_RESET
> >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> >      by CLK_RCAR_GEN3
> >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> >      CLK_RENESAS
> >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
> >      POWER_DOMAIN
> >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> >      BCM6318_USBH_PHY
> >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> >   Kconfig:176: symbol XEN depends on ARM64
> >
> > We don't want to revert the change to BLK, which has been in place for
> > a year now. We don't want to select BLK in BOOTSTD since it should
> > support booting without block devices. The only realistic option is to
> > remove BOOTSTD's dependency on BLK.
> >
> > Disable standard boot on the one board which fails.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Drop wip (work-in-progress) comment in commit
> >
> > Changes in v2:
> > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> >
> >  boot/Kconfig                                   | 2 +-
> >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > Applied to u-boot-dm, thanks!
>
> No, this is wrong, it's pulling in BOOTSTD on a ton of platforms that
> didn't have it before.

This affects 103 boards and the size growth is considerable:

   aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data +710.9
rodata +1822.1 text +13137.8
       arc: (for 4/4 boards) all +15338.0 bss +4.0 data +526.0 rodata
+2096.0 text +12712.0
       arm: (for 26/26 boards) all +18882.8 data +619.2 rodata +1998.8
text +16264.8
      m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +1595.8
rodata +1722.8 text +20537.8
microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1248.0
rodata +2288.0 text +21265.0
      mips: (for 23/23 boards) all +21659.1 bss +39.5 data +746.6
rodata +2155.7 text +18717.4
     nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +704.0 text +24148.0
   powerpc: (for 13/13 boards) all +21746.6 data +836.3 rodata +807.2
text +20103.2

Added options are:

   + all: CONFIG_BOOTDEV_ETH=1 CONFIG_BOOTMETH_EXTLINUX=1
CONFIG_BOOTMETH_GLOBAL=1 CONFIG_BOOTMETH_VBE=1
CONFIG_BOOTMETH_VBE_REQUEST=1 CONFIG_BOOTMETH_VBE_SIMPLE=1
CONFIG_BOOTMETH_VBE_SIMPLE_OS=1 CONFIG_BOOTSTD=1
CONFIG_BOOTSTD_BOOTCOMMAND=1 CONFIG_CMD_BOOTFLOW=1 CONFIG_MENU=1
CONFIG_PXE_UTILS=1

Should I manually disable it on those platforms? I've reached the
point where bootstd needs to be available when BLK is not enabled, so
need some sort of solution.

Regards,
Simon
