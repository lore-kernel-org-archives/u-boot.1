Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF3BD462CF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A21A989269;
	Wed, 13 Nov 2024 17:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A5+M18gW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303FC88EFB; Wed, 13 Nov 2024 17:03:48 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32B988DFA
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed0ec0e92so940625266b.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731513825; x=1732118625; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9anmjVbpnnB01Ow5l7vyzWvuz+g1Us6dXi5wYZU45Yw=;
 b=A5+M18gWW1TXqn9u6AP/4Pj/Sa/oar5+05NNm1CdJCYdsnn6fTCrwQXKexjm4VMfLr
 d1n/4UBhNwNJiIJ26PQ/R2u+y0hGszyg7OGeRRPEyB6N62pXPMxHLTXGlpC4/zpq/Cwm
 DPzmmHKHR3FxsoKtm7ZJnoaZ4hLfAvJqthDHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731513825; x=1732118625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9anmjVbpnnB01Ow5l7vyzWvuz+g1Us6dXi5wYZU45Yw=;
 b=jQGA11060qbm8glQqjANWyfV2vgY1wQTG60pj/Hr/mJ5dySatAVHkvtX3E+ThNsLF+
 pMUxs9C3aHqXPNcOL+sK/lWSyINLBQeeuYiDZoTIAKbrwiDMtKoSzel6o6gfSUVVPPqn
 VJAbVRpUcjqjjulrGkEXut7vkEzlNUiHGpWQdGyjeRvHe3CiYJndMfxpFU9O0msfDw2Q
 x0YRFLMKjuQQWpAnHnGp63zMawzKkipcmqKv9WLfSp/MHhHVRw+7RifQXDtzctUunHwf
 PRHgHHOrrqj4cNtVry/SYwUbCmiMfrlMLv5QJSkD0dEbym+GODlq3I9Mz5lJ5b8z8ace
 P/Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9kahABgzrVxNe1Dpz35rpMk6rtEpIi8Xv/Jo3KPClMk6syy+Ltfy1HY457FAo69mO35j0ME=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx7bz4YanJO9Ms1O3XGjzegSsccbLET8PWRbWMW8u8E40cD1Rw
 KzaJCVogLIGtAkyGIzTPi2xUT4H2TxglP7M9UVjaEYsWX2aWH5iY2QaztFSuvMrJCjEDIVREhSe
 ItfrnfTbeMv10QMnnmE40v1uubgSCjhdr4gyD
X-Google-Smtp-Source: AGHT+IEhauXxSORZuhj6W1qwx+hI3/uVbT2u7foDw8Z59EtvESNu3PoEr9qRwzqHirQOfXoNYyo7I/3vYyGXtQROG+k=
X-Received: by 2002:a17:907:970a:b0:a9a:3da9:6a02 with SMTP id
 a640c23a62f3a-a9ef001e0dfmr1790622766b.60.1731513824762; Wed, 13 Nov 2024
 08:03:44 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
 <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
 <20241018175254.GB4959@bill-the-cat>
 <CAFLszTiQHArgoS5zK6aKpi1kiTBcAT4wEkbFaVSt5FjVQ8vmpQ@mail.gmail.com>
 <20241018182937.GE4959@bill-the-cat>
 <CAFLszTjKs0NocoePYyCZMufYg5ahKEHNcux_EwJkT6N1=1T+cQ@mail.gmail.com>
 <CAFLszTj8MK4QmxrQqALXi01EuXHrT2zXwbhR9qmC=txE1nqgLw@mail.gmail.com>
 <20241113152423.GP3600562@bill-the-cat>
In-Reply-To: <20241113152423.GP3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 09:03:22 -0700
Message-ID: <CAFLszTjbHKtukCQVp+hkhtFV6_E5k6az+VnBR_sUVfSQxu8vrA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 13 Nov 2024 at 08:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 07:39:53AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Oct 2024 at 12:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Fri, 18 Oct 2024 at 12:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 18, 2024 at 12:06:46PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 18 Oct 2024 at 11:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 18, 2024 at 11:20:40AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 18 Oct 2024 at 09:11, Tom Rini <trini@konsulko.com>
wrote:
> > > > > > > >
> > > > > > > > On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com>
wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass
wrote:
> > > > > > > > > >
> > > > > > > > > > > In principle bootstd can work without block devices,
even if it does
> > > > > > > > > > > require driver model to be enabled in that case.
> > > > > > > > > > >
> > > > > > > > > > > The use of a 'depends on BLK' for BOOTSTD conflicts
with the way 'BLK'
> > > > > > > > > > > is now defined, producing recursive errors through
multiple different
> > > > > > > > > > > paths, one of which is this (with Linksprite_pcDuino3
and
> > > > > > > > > > > BOOTSTD_DEFAULTS enabled):
> > > > > > > > > > >
> > > > > > > > > > >   arch/arm/Kconfig:7:error: recursive dependency
detected!
> > > > > > > > > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by
ARCH_UNIPHIER_V8_MULTI
> > > > > > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol
ARCH_UNIPHIER_V8_MULTI is
> > > > > > > > > > >      part of choice <choice>
> > > > > > > > > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice>
contains symbol
> > > > > > > > > > >      ARCH_UNIPHIER_V8_MULTI
> > > > > > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol
ARCH_UNIPHIER_V8_MULTI is
> > > > > > > > > > >      part of choice SPL
> > > > > > > > > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends
on SUPPORT_SPL
> > > > > > > > > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is
selected by ASPEED_AST2600
> > > > > > > > > > >   arch/arm/mach-aspeed/Kconfig:26: symbol
ASPEED_AST2600 is part of
> > > > > > > > > > >      choice <choice>
> > > > > > > > > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice>
contains symbol
> > > > > > > > > > >      ASPEED_AST2500
> > > > > > > > > > >   arch/arm/mach-aspeed/Kconfig:17: symbol
ASPEED_AST2500 is part of
> > > > > > > > > > >      choice DM_RESET
> > > > > > > > > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol
DM_RESET is selected
> > > > > > > > > > >      by CLK_RCAR_GEN3
> > > > > > > > > > >   drivers/clk/renesas/Kconfig:53: symbol
CLK_RCAR_GEN3 depends on
> > > > > > > > > > >      CLK_RENESAS
> > > > > > > > > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS
depends on CLK
> > > > > > > > > > >   drivers/clk/Kconfig:3: symbol CLK is selected by
IMX8M_POWER_DOMAIN
> > > > > > > > > > >   drivers/power/domain/Kconfig:35: symbol
IMX8M_POWER_DOMAIN depends on
> > > > > > > > > > >      POWER_DOMAIN
> > > > > > > > > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN
is selected by
> > > > > > > > > > >      BCM6318_USBH_PHY
> > > > > > > > > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY
depends on PHY
> > > > > > > > > > >   drivers/phy/Kconfig:4: symbol PHY is selected by
USB_EHCI_MX7
> > > > > > > > > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7
depends on USB
> > > > > > > > > > >   drivers/usb/Kconfig:1: symbol USB is selected by
BOOTSTD_DEFAULTS
> > > > > > > > > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends
on BOOTSTD
> > > > > > > > > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > > > > > > > > >   drivers/block/Kconfig:1: symbol BLK is selected by
PVBLOCK
> > > > > > > > > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > > > > > > > > >   Kconfig:176: symbol XEN depends on ARM64
> > > > > > > > > > >
> > > > > > > > > > > We don't want to revert the change to BLK, which has
been in place for
> > > > > > > > > > > a year now. We don't want to select BLK in BOOTSTD
since it should
> > > > > > > > > > > support booting without block devices. The only
realistic option is to
> > > > > > > > > > > remove BOOTSTD's dependency on BLK.
> > > > > > > > > > >
> > > > > > > > > > > Disable standard boot on the one board which fails.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - Drop wip (work-in-progress) comment in commit
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Add new patch to resolve BOOTSTD->BLK recursion
with Kconfig
> > > > > > > > > > >
> > > > > > > > > > >  boot/Kconfig                                   | 2 +-
> > > > > > > > > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > > > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > Applied to u-boot-dm, thanks!
> > > > > > > > > >
> > > > > > > > > > No, this is wrong, it's pulling in BOOTSTD on a ton of
platforms that
> > > > > > > > > > didn't have it before.
> > > > > > > > >
> > > > > > > > > This affects 103 boards and the size growth is
considerable:
> > > > > > > > >
> > > > > > > > >    aarch64: (for 22/22 boards) all +15697.0 bss +26.2
data +710.9
> > > > > > > > > rodata +1822.1 text +13137.8
> > > > > > > > >        arc: (for 4/4 boards) all +15338.0 bss +4.0 data
+526.0 rodata
> > > > > > > > > +2096.0 text +12712.0
> > > > > > > > >        arm: (for 26/26 boards) all +18882.8 data +619.2
rodata +1998.8
> > > > > > > > > text +16264.8
> > > > > > > > >       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data
+1595.8
> > > > > > > > > rodata +1722.8 text +20537.8
> > > > > > > > > microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data
+1248.0
> > > > > > > > > rodata +2288.0 text +21265.0
> > > > > > > > >       mips: (for 23/23 boards) all +21659.1 bss +39.5
data +746.6
> > > > > > > > > rodata +2155.7 text +18717.4
> > > > > > > > >      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data
+704.0 text +24148.0
> > > > > > > > >    powerpc: (for 13/13 boards) all +21746.6 data +836.3
rodata +807.2
> > > > > > > > > text +20103.2
> > > > > > > > >
> > > > > > > > > Added options are:
> > > > > > > > >
> > > > > > > > >    + all: CONFIG_BOOTDEV_ETH=1 CONFIG_BOOTMETH_EXTLINUX=1
> > > > > > > > > CONFIG_BOOTMETH_GLOBAL=1 CONFIG_BOOTMETH_VBE=1
> > > > > > > > > CONFIG_BOOTMETH_VBE_REQUEST=1 CONFIG_BOOTMETH_VBE_SIMPLE=1
> > > > > > > > > CONFIG_BOOTMETH_VBE_SIMPLE_OS=1 CONFIG_BOOTSTD=1
> > > > > > > > > CONFIG_BOOTSTD_BOOTCOMMAND=1 CONFIG_CMD_BOOTFLOW=1
CONFIG_MENU=1
> > > > > > > > > CONFIG_PXE_UTILS=1
> > > > > > > > >
> > > > > > > > > Should I manually disable it on those platforms? I've
reached the
> > > > > > > > > point where bootstd needs to be available when BLK is not
enabled, so
> > > > > > > > > need some sort of solution.
> > > > > > > >
> > > > > > > > What is the use case for needing all of this, without BLK
being set? I'm
> > > > > > > > not sure which platforms that grew here also need bootstd?
> > > > > > >
> > > > > > > It is just that some XPL (I can say that now) platforms don't
enable
> > > > > > > BLK but do need to read from a device, e.g. MMC.
> > > > > >
> > > > > > Er, how is that an issue for any of the XPL phases? We have
> > > > > > {SPL,TPL,VPL}_BLK symbols. And BLK itself is def_bool'd on DM
and MMC,
> > > > > > etc. And all boards enable DM now.
> > > > >
> > > > > I was using MMC_TINY... I still have one more series for
rk3399...so
> > > > > if things build OK I can perhaps just drop this patch and figure
this
> > > > > out later?
> > > >
> > > > Yeah, please drop this for now and re-visit things. MMC_TINY is
only for
> > > > SPL (but tested as CONFIG_IS_ENABLED(MMC_TINY) because maybe it
makes
> > > > sense in the TPL sense? But it's distinctly not BLK and DM, iirc).
> > >
> > > Yes, I meant XPL_BLK, not BLK, oops.
> >
> > This objection is one of a few things blocking the sunxi bootstd
> > conversion. If you want to see the problem for yourself, try building
> > Linksprite_pcDuino3 with this series applied sans this patch.
> >
> > The other thing blocking it is bootmgr, which we either need to
> > disable for sunxi, or revert a patch which the author doesn't want
> > reverted.
> >
> > So for now I'll just send a v4 with patches for those two things and
> > we can discuss it again.
>
> We're not going to get the sunxi series in for v2025.01, so we have time
> to think about this still and try and get the code to match up with the
> use cases.

That's quite unfortunate. This series was first sent 3 months ago.

Regards,
Simon
