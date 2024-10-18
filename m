Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1366BD3DEAB
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3218B88D9F;
	Fri, 18 Oct 2024 20:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pd4zo1Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD5188BBE; Fri, 18 Oct 2024 20:48:50 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0BF88D9C
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e3e5c4a01cso1376388b6e.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729277326; x=1729882126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=or7y/hU8Fsxv5A7B5KEc5h5v0NmpXZvi7GQgQVrZypU=;
 b=Pd4zo1Qm3gX94RZNZRSyd6VFPdu38anVGLFx16qtzTSPAx3WCopaMU5o9th5Atl13d
 bW0DT7TZCfF+R3bNQOUOO4xPU1/B2dpwWPKiqI1nXTG3mNxjCbyvGTj8DeyWIWuIt+AO
 4X3aHA0S1ch3uufLcgQgDRqUa3RLrk6WT2dgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729277326; x=1729882126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=or7y/hU8Fsxv5A7B5KEc5h5v0NmpXZvi7GQgQVrZypU=;
 b=cqok0Kn64SQaWMj3f1uH4dpLQ9dudfZJRs4H18f8S1xvadq87Frk0lalSpM7AsNS+m
 2LJVIW7RjXz8PcqnqO9xi9OxSw9lmL6C4mCCuzTtM6ccuHVAFwpmSnsGAi8923UxEgDf
 BSP4OF8a64LFEYO1rW8v604QQMRnEI+0KZEdD+teaz8kJzONDI0saVtKvvp6dZQJWSBi
 fWAwtqz36PrnLnDawvm4KLKF68CRHEFAk/HtYCdCXw72JFWsbBNJlBZcugLWzjtw++DN
 MIETikExOH16ttkAzQouc2ndzSrZzwoSh+tMqSIfmnfJuYAA9LZBfMQTezpvhWs4dfCM
 kCKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv1fXNKVEvyT9IOF2epnWHfBAd1G0fqWK9brH8QFxQvXzbraoOGqxXNee5AKNxXxTDIIrgCv8=@lists.denx.de
X-Gm-Message-State: AOJu0YyCAshitI62gR42ZM+7qF0UGg9AdlLnmjPE9bCl3wMXbwPmTezR
 kZVewRtGDiNXFt+IbpQPanCc2SKtvD7x2VTWo8TCl975RqXnWNCiI3oySTBJuBwxW5pOfwB+Zqr
 g2h7r+Y8OJUvrYVpxQ+HnlNOENxxqGuUubXbV
X-Google-Smtp-Source: AGHT+IG+zp+XbdWWKSZHl/V4SdNDZs7aYm31r6GxLqVhC2pisKxb0YyxMVeEqrT0m7dLjr5QHZQqZ6neY0QgLlW7Rho=
X-Received: by 2002:a05:6808:1295:b0:3e6:22f:ea53 with SMTP id
 5614622812f47-3e602c6049dmr2867701b6e.3.1729277326361; Fri, 18 Oct 2024
 11:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
 <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
 <20241018175254.GB4959@bill-the-cat>
 <CAFLszTiQHArgoS5zK6aKpi1kiTBcAT4wEkbFaVSt5FjVQ8vmpQ@mail.gmail.com>
 <20241018182937.GE4959@bill-the-cat>
In-Reply-To: <20241018182937.GE4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 12:48:35 -0600
Message-ID: <CAFLszTjKs0NocoePYyCZMufYg5ahKEHNcux_EwJkT6N1=1T+cQ@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 12:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 12:06:46PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Oct 2024 at 11:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 11:20:40AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 18 Oct 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > In principle bootstd can work without block devices, even if it does
> > > > > > > > require driver model to be enabled in that case.
> > > > > > > >
> > > > > > > > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > > > > > > > is now defined, producing recursive errors through multiple different
> > > > > > > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > > > > > > BOOTSTD_DEFAULTS enabled):
> > > > > > > >
> > > > > > > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > > > > > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
> > > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > > > > > > >      part of choice <choice>
> > > > > > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> > > > > > > >      ARCH_UNIPHIER_V8_MULTI
> > > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > > > > > > >      part of choice SPL
> > > > > > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> > > > > > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
> > > > > > > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> > > > > > > >      choice <choice>
> > > > > > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> > > > > > > >      ASPEED_AST2500
> > > > > > > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> > > > > > > >      choice DM_RESET
> > > > > > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> > > > > > > >      by CLK_RCAR_GEN3
> > > > > > > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> > > > > > > >      CLK_RENESAS
> > > > > > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> > > > > > > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> > > > > > > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
> > > > > > > >      POWER_DOMAIN
> > > > > > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> > > > > > > >      BCM6318_USBH_PHY
> > > > > > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> > > > > > > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> > > > > > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> > > > > > > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> > > > > > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > > > > > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > > > > > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > > > > > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > > > > > >   Kconfig:176: symbol XEN depends on ARM64
> > > > > > > >
> > > > > > > > We don't want to revert the change to BLK, which has been in place for
> > > > > > > > a year now. We don't want to select BLK in BOOTSTD since it should
> > > > > > > > support booting without block devices. The only realistic option is to
> > > > > > > > remove BOOTSTD's dependency on BLK.
> > > > > > > >
> > > > > > > > Disable standard boot on the one board which fails.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Drop wip (work-in-progress) comment in commit
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > > > > > > >
> > > > > > > >  boot/Kconfig                                   | 2 +-
> > > > > > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > Applied to u-boot-dm, thanks!
> > > > > > >
> > > > > > > No, this is wrong, it's pulling in BOOTSTD on a ton of platforms that
> > > > > > > didn't have it before.
> > > > > >
> > > > > > This affects 103 boards and the size growth is considerable:
> > > > > >
> > > > > >    aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data +710.9
> > > > > > rodata +1822.1 text +13137.8
> > > > > >        arc: (for 4/4 boards) all +15338.0 bss +4.0 data +526.0 rodata
> > > > > > +2096.0 text +12712.0
> > > > > >        arm: (for 26/26 boards) all +18882.8 data +619.2 rodata +1998.8
> > > > > > text +16264.8
> > > > > >       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +1595.8
> > > > > > rodata +1722.8 text +20537.8
> > > > > > microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1248.0
> > > > > > rodata +2288.0 text +21265.0
> > > > > >       mips: (for 23/23 boards) all +21659.1 bss +39.5 data +746.6
> > > > > > rodata +2155.7 text +18717.4
> > > > > >      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +704.0 text +24148.0
> > > > > >    powerpc: (for 13/13 boards) all +21746.6 data +836.3 rodata +807.2
> > > > > > text +20103.2
> > > > > >
> > > > > > Added options are:
> > > > > >
> > > > > >    + all: CONFIG_BOOTDEV_ETH=1 CONFIG_BOOTMETH_EXTLINUX=1
> > > > > > CONFIG_BOOTMETH_GLOBAL=1 CONFIG_BOOTMETH_VBE=1
> > > > > > CONFIG_BOOTMETH_VBE_REQUEST=1 CONFIG_BOOTMETH_VBE_SIMPLE=1
> > > > > > CONFIG_BOOTMETH_VBE_SIMPLE_OS=1 CONFIG_BOOTSTD=1
> > > > > > CONFIG_BOOTSTD_BOOTCOMMAND=1 CONFIG_CMD_BOOTFLOW=1 CONFIG_MENU=1
> > > > > > CONFIG_PXE_UTILS=1
> > > > > >
> > > > > > Should I manually disable it on those platforms? I've reached the
> > > > > > point where bootstd needs to be available when BLK is not enabled, so
> > > > > > need some sort of solution.
> > > > >
> > > > > What is the use case for needing all of this, without BLK being set? I'm
> > > > > not sure which platforms that grew here also need bootstd?
> > > >
> > > > It is just that some XPL (I can say that now) platforms don't enable
> > > > BLK but do need to read from a device, e.g. MMC.
> > >
> > > Er, how is that an issue for any of the XPL phases? We have
> > > {SPL,TPL,VPL}_BLK symbols. And BLK itself is def_bool'd on DM and MMC,
> > > etc. And all boards enable DM now.
> >
> > I was using MMC_TINY... I still have one more series for rk3399...so
> > if things build OK I can perhaps just drop this patch and figure this
> > out later?
>
> Yeah, please drop this for now and re-visit things. MMC_TINY is only for
> SPL (but tested as CONFIG_IS_ENABLED(MMC_TINY) because maybe it makes
> sense in the TPL sense? But it's distinctly not BLK and DM, iirc).

Yes, I meant XPL_BLK, not BLK, oops.

Regards,
Simon
