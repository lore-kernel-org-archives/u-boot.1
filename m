Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC9ED3DEA3
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A724588BEF;
	Fri, 18 Oct 2024 19:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sLk2t0xf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40FFA88C3E; Fri, 18 Oct 2024 19:53:02 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06A5F885C5
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4609d8874b1so15519671cf.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729273979; x=1729878779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1jqwpv6c8fykskz3t00uhcrT4Rbf1nOP8njwKCw31KM=;
 b=sLk2t0xfiXXDVNve5SVvjC9I9+3gmt/f7NEJnSH15UvRf18KQPIxWJg6qPhBsfJiGF
 7mZs9bd6J5bp7Qykp7hkUKcb9FJNSI23oIJKCrUxsDyewVy3X1s0OT+oYlQubfIycGKU
 kiUElpCpakMfMXt22KKURswccvMu5dAc4nD5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729273979; x=1729878779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jqwpv6c8fykskz3t00uhcrT4Rbf1nOP8njwKCw31KM=;
 b=UEt1vsfyMFb7ydEQhccNcCOW54tLC5t/zr1xjFShJnuJFtSOn3pSOa8RND7P55AUb2
 8mODylv59qGwVqCCHpJzv0M7L88igvhvDRNn3WsViHwqbf3F9oN2SD2hmxwSk/UZ7auH
 McKRidzF8uamYCasKS0kZkZ1nyOYJqqr9JE5XdE8+RSCVLO6yJXnCMo+tDXxWXIkVWsp
 40vZWaviSNwC+bBDGXcIo4NWJMFz/ZhDGmge2dLoYE6nimb51hDvw0SWDGk9bwV4a1P7
 idnRNH7+OZllk7io4ITIE+BX6tijXqr45ChynjdzCH7ROqhCfLpX2fTbmZNlyv8P1YzB
 AZPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBN2fWq6LzyEModcbDT7+wU1H98keN52uzI53IvIv4zBcMZjGFWuLhpOs6rfV9GXrDCtfAvCM=@lists.denx.de
X-Gm-Message-State: AOJu0YzmhP8ERjC+tQJiietkCniXQojnyxWbz//Sj3piqR2nDHiIJZvX
 nQhmEvLuQsS6O/GQWuEt1BBdLyeMDBWyCmB9cCl/R5ea9BYNOIPHdoS6S3h99i8=
X-Google-Smtp-Source: AGHT+IFW7wmj5N3gdy515XWo0PM2XYUC/goPpy/elvKprq9s8/LaNC3iMilvVLbTyvso6tgIa5L9Jw==
X-Received: by 2002:a05:622a:299a:b0:460:9b2b:5440 with SMTP id
 d75a77b69052e-460aecd06c0mr38145501cf.5.1729273978749; 
 Fri, 18 Oct 2024 10:52:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae949003sm9378711cf.1.2024.10.18.10.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 10:52:57 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:52:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Message-ID: <20241018175254.GB4959@bill-the-cat>
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
 <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mlZ7sKZZrJbSIKg2"
Content-Disposition: inline
In-Reply-To: <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--mlZ7sKZZrJbSIKg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:20:40AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:
> > > >
> > > > > In principle bootstd can work without block devices, even if it d=
oes
> > > > > require driver model to be enabled in that case.
> > > > >
> > > > > The use of a 'depends on BLK' for BOOTSTD conflicts with the way =
'BLK'
> > > > > is now defined, producing recursive errors through multiple diffe=
rent
> > > > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > > > BOOTSTD_DEFAULTS enabled):
> > > > >
> > > > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V=
8_MULTI
> > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULT=
I is
> > > > >      part of choice <choice>
> > > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symb=
ol
> > > > >      ARCH_UNIPHIER_V8_MULTI
> > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULT=
I is
> > > > >      part of choice SPL
> > > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_=
SPL
> > > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_=
AST2600
> > > > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part =
of
> > > > >      choice <choice>
> > > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> > > > >      ASPEED_AST2500
> > > > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part =
of
> > > > >      choice DM_RESET
> > > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is sel=
ected
> > > > >      by CLK_RCAR_GEN3
> > > > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> > > > >      CLK_RENESAS
> > > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> > > > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DO=
MAIN
> > > > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depe=
nds on
> > > > >      POWER_DOMAIN
> > > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected=
 by
> > > > >      BCM6318_USBH_PHY
> > > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> > > > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> > > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> > > > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAUL=
TS
> > > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > > >   Kconfig:176: symbol XEN depends on ARM64
> > > > >
> > > > > We don't want to revert the change to BLK, which has been in plac=
e for
> > > > > a year now. We don't want to select BLK in BOOTSTD since it should
> > > > > support booting without block devices. The only realistic option =
is to
> > > > > remove BOOTSTD's dependency on BLK.
> > > > >
> > > > > Disable standard boot on the one board which fails.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > - Drop wip (work-in-progress) comment in commit
> > > > >
> > > > > Changes in v2:
> > > > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > > > >
> > > > >  boot/Kconfig                                   | 2 +-
> > > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > Applied to u-boot-dm, thanks!
> > > >
> > > > No, this is wrong, it's pulling in BOOTSTD on a ton of platforms th=
at
> > > > didn't have it before.
> > >
> > > This affects 103 boards and the size growth is considerable:
> > >
> > >    aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data +710.9
> > > rodata +1822.1 text +13137.8
> > >        arc: (for 4/4 boards) all +15338.0 bss +4.0 data +526.0 rodata
> > > +2096.0 text +12712.0
> > >        arm: (for 26/26 boards) all +18882.8 data +619.2 rodata +1998.8
> > > text +16264.8
> > >       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +1595.8
> > > rodata +1722.8 text +20537.8
> > > microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1248.0
> > > rodata +2288.0 text +21265.0
> > >       mips: (for 23/23 boards) all +21659.1 bss +39.5 data +746.6
> > > rodata +2155.7 text +18717.4
> > >      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +704.0 text +=
24148.0
> > >    powerpc: (for 13/13 boards) all +21746.6 data +836.3 rodata +807.2
> > > text +20103.2
> > >
> > > Added options are:
> > >
> > >    + all: CONFIG_BOOTDEV_ETH=3D1 CONFIG_BOOTMETH_EXTLINUX=3D1
> > > CONFIG_BOOTMETH_GLOBAL=3D1 CONFIG_BOOTMETH_VBE=3D1
> > > CONFIG_BOOTMETH_VBE_REQUEST=3D1 CONFIG_BOOTMETH_VBE_SIMPLE=3D1
> > > CONFIG_BOOTMETH_VBE_SIMPLE_OS=3D1 CONFIG_BOOTSTD=3D1
> > > CONFIG_BOOTSTD_BOOTCOMMAND=3D1 CONFIG_CMD_BOOTFLOW=3D1 CONFIG_MENU=3D1
> > > CONFIG_PXE_UTILS=3D1
> > >
> > > Should I manually disable it on those platforms? I've reached the
> > > point where bootstd needs to be available when BLK is not enabled, so
> > > need some sort of solution.
> >
> > What is the use case for needing all of this, without BLK being set? I'm
> > not sure which platforms that grew here also need bootstd?
>=20
> It is just that some XPL (I can say that now) platforms don't enable
> BLK but do need to read from a device, e.g. MMC.

Er, how is that an issue for any of the XPL phases? We have
{SPL,TPL,VPL}_BLK symbols. And BLK itself is def_bool'd on DM and MMC,
etc. And all boards enable DM now.

--=20
Tom

--mlZ7sKZZrJbSIKg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSoHIACgkQFHw5/5Y0
tywnxwv+L0mzLKO3+KS0pEJYb5MXTlGVI+cgwkgRORi5yoKVnYIOlGmhCB/n1sty
h7rj0IKH+ozJVNJBq3XR4rhZWb+vApon422pUUqaHpuQo1pVy0roE+yFiaQ+slRV
wt34kq3wnk6l+mLSzbiGoJFd6qvTJq8sE2rSJSny2DNrzaxGSQ7VurY1vnzCbdZF
K+qvu2FoHl1ms4tjNpbWGNUELaHufmHQJzDkp6H4rg3yIv+vnowF1GcLFAqCWSiD
LxAgPPhd46vr/a4kiGC2Avo7/cnBaArRnwu6RdPd2F1UONSQ6ithtmJvtCsHWnK1
AJUHMxjNlzp7xs6LN+ZaAlWpKZeleTA0Pp92CxjZZlUXbumITZhOvGTtHYo7crPU
pKv2s62eammQuDxlvs4CJxj8EJgRXX1NoL+3Je8rkCUtHZP6nHvavcdBG1PlDRBj
f2KgbodgCtTZXMZkW03c91XRk6heDPZDe6KdEyy2AK7Rr0XsHjuYKzmJYiQeK2+m
5tAVfyX0
=1sAB
-----END PGP SIGNATURE-----

--mlZ7sKZZrJbSIKg2--
