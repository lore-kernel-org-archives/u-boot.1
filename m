Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E5BD3DEA2
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A144C88E02;
	Fri, 18 Oct 2024 19:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="azXJYhFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684B488D5B; Fri, 18 Oct 2024 19:20:54 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C14B88D5B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b1343e8042so216545185a.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729272051; x=1729876851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6oLA1RKPPzCWIAmmztwjgwAhpvQts0q2mpdgZrpw9cs=;
 b=azXJYhFTx4aXZ7JCsZRN7V5KDdN19NH5gjQsjRk/3GwBv5Qacve7DnQM2O+Gjzm9rg
 6VsTXwFbYnSfNoX76JEDN89spUVEsTG/kcPCpPn/Rv7RslHVGjyM4f6oBWBb3xFRkHPO
 DpQmEmZJ5fDYQZhv4xwWTfoHMJ3ddgLZaD2dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272051; x=1729876851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oLA1RKPPzCWIAmmztwjgwAhpvQts0q2mpdgZrpw9cs=;
 b=SHmbH/yYfYWRBFDGi5m1vAjrt0eLkx1a2DpLkUkBtdy3Z5Lzhz5W2bP350dK2tizKo
 jreXFGc7YYdi+l1UPMPdp3Y4gDJLX4bpG8dLUWwlXmVG7rqhNgCRI9hw1Nu8tEIcKMzw
 fbzhndNMn1e7r6M29yI0Ne4BQsazSLME3fl17VZdQ3mCJuwveR+Oa7qBymivXKGRBRen
 rl9IdBhbuV4r8QxayylVtaLMC4kusm+BrQh59o799PrEwNvJh03ljyP7JzoQ1YbWR6oX
 LgI6I+m0fr5SN5uTYFN+a3HNpuU7IYoGOYgcCIKR1PP7dB0+JWG+DCikyh1sR49Eznip
 52Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDAmGdyqO8lm4dzH4rAh7ixxYU19Cw9BDZ974oe66Rzq0KbAGFWAKH6iwLdJenvtKeD0Tt3RM=@lists.denx.de
X-Gm-Message-State: AOJu0YxXLwmfzpsQBtvWyJl5D+Xw25fvCLMdz3TjQe7lToXFNygWgySa
 YQqPV97LLqbGNoINas15Qm68b6s3HjvGFhd8X9jYOeXw3lipu3/hOX6WwEkMWq8/7cxJD4hpDbY
 5yMMEWJcln9xHG2Az812MivkS0mMHguRimpRPd4njZR2W5oI=
X-Google-Smtp-Source: AGHT+IGGVb5gOX6TyQFvpQO9ANX70d7Vwv7/eyuzwyzf5A6dI0yJ4iA1zBrPCmqLVeQNT7d05EN9hzfIQ7ERppygVis=
X-Received: by 2002:a05:6214:5b0d:b0:6cb:f654:55ac with SMTP id
 6a1803df08f44-6cde14c064cmr45068406d6.11.1729272050999; Fri, 18 Oct 2024
 10:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
In-Reply-To: <20241018151152.GX4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 11:20:40 -0600
Message-ID: <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:
> > >
> > > > In principle bootstd can work without block devices, even if it does
> > > > require driver model to be enabled in that case.
> > > >
> > > > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > > > is now defined, producing recursive errors through multiple different
> > > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > > BOOTSTD_DEFAULTS enabled):
> > > >
> > > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
> > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > > >      part of choice <choice>
> > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> > > >      ARCH_UNIPHIER_V8_MULTI
> > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > > >      part of choice SPL
> > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
> > > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> > > >      choice <choice>
> > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> > > >      ASPEED_AST2500
> > > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> > > >      choice DM_RESET
> > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> > > >      by CLK_RCAR_GEN3
> > > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> > > >      CLK_RENESAS
> > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> > > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> > > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
> > > >      POWER_DOMAIN
> > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> > > >      BCM6318_USBH_PHY
> > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> > > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> > > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > >   Kconfig:176: symbol XEN depends on ARM64
> > > >
> > > > We don't want to revert the change to BLK, which has been in place for
> > > > a year now. We don't want to select BLK in BOOTSTD since it should
> > > > support booting without block devices. The only realistic option is to
> > > > remove BOOTSTD's dependency on BLK.
> > > >
> > > > Disable standard boot on the one board which fails.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Drop wip (work-in-progress) comment in commit
> > > >
> > > > Changes in v2:
> > > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > > >
> > > >  boot/Kconfig                                   | 2 +-
> > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > Applied to u-boot-dm, thanks!
> > >
> > > No, this is wrong, it's pulling in BOOTSTD on a ton of platforms that
> > > didn't have it before.
> >
> > This affects 103 boards and the size growth is considerable:
> >
> >    aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data +710.9
> > rodata +1822.1 text +13137.8
> >        arc: (for 4/4 boards) all +15338.0 bss +4.0 data +526.0 rodata
> > +2096.0 text +12712.0
> >        arm: (for 26/26 boards) all +18882.8 data +619.2 rodata +1998.8
> > text +16264.8
> >       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +1595.8
> > rodata +1722.8 text +20537.8
> > microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1248.0
> > rodata +2288.0 text +21265.0
> >       mips: (for 23/23 boards) all +21659.1 bss +39.5 data +746.6
> > rodata +2155.7 text +18717.4
> >      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +704.0 text +24148.0
> >    powerpc: (for 13/13 boards) all +21746.6 data +836.3 rodata +807.2
> > text +20103.2
> >
> > Added options are:
> >
> >    + all: CONFIG_BOOTDEV_ETH=1 CONFIG_BOOTMETH_EXTLINUX=1
> > CONFIG_BOOTMETH_GLOBAL=1 CONFIG_BOOTMETH_VBE=1
> > CONFIG_BOOTMETH_VBE_REQUEST=1 CONFIG_BOOTMETH_VBE_SIMPLE=1
> > CONFIG_BOOTMETH_VBE_SIMPLE_OS=1 CONFIG_BOOTSTD=1
> > CONFIG_BOOTSTD_BOOTCOMMAND=1 CONFIG_CMD_BOOTFLOW=1 CONFIG_MENU=1
> > CONFIG_PXE_UTILS=1
> >
> > Should I manually disable it on those platforms? I've reached the
> > point where bootstd needs to be available when BLK is not enabled, so
> > need some sort of solution.
>
> What is the use case for needing all of this, without BLK being set? I'm
> not sure which platforms that grew here also need bootstd?

It is just that some XPL (I can say that now) platforms don't enable
BLK but do need to read from a device, e.g. MMC.

Regards,
Simon
