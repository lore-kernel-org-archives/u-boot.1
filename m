Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5D5D3DEA6
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7015288B23;
	Fri, 18 Oct 2024 20:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QfFMaW12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61C688BEF; Fri, 18 Oct 2024 20:29:45 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58120889EB
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso13675486d6.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729276182; x=1729880982; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N5hNy+EFVhDEb4NwX91c2o+ApplP/hQl4HVawyNLBaw=;
 b=QfFMaW12XXGrXYAXScEd5ppVlYjr6ZIyCBkeeItnXqr2pCYz5/uyn/ZM687OJn2CCG
 oP2MF9jshuMj/Achl/EIsjbpxHLMle1N/fxHNU4twlT2KSyrOX9Fq+1n9o05UkOEW4xF
 dIL9gnIuq21pG749dtRExoP9ZufczDVmzwpto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276182; x=1729880982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5hNy+EFVhDEb4NwX91c2o+ApplP/hQl4HVawyNLBaw=;
 b=cP3ZyCgr9H5dybLKEfk3xS15J+hAVmUUsbtxBYSzkI4vM7mk5c89A0JuFSeksX4jGK
 0QuuNI+ynqQ9p3dr6HbQUVrM2FCGASiGSU1+RhGh8DnnmXPCdrOtOrhaWGFBLMmMHgFc
 ipHVpR6qyhF+bGYIZi/efbUodMqFP8BTYt0EKqUajctS6Sf14dE1O7EXLdAy6WQojJwM
 B9o+7Nz25LDewEetlAnqWIrkD0entfKWVKalDiIz/+pqV4CStOrXJzYi0xUBVTdEEUGw
 Ytr33N4qChhqZyG+lNQtIw+PcXbF19nFU8OyGv5xJdsUWBTI1sF+70J4S5QbEzPtJjBi
 61xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWISSOhlW3j6sLEeMOVHSf1nQmbsbdpqSbpNGFLrhGXW/ttHGpyS2Y/W2ceC9RLrU0vBXE55n0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp5I+dn4/c+ZYPEg3B4UGVjQ26S6x0RVQmo8mY/rP9VQDNeuTl
 JumXfpdYrA2hhvvG69Bux4P2dLLq+HGkSsG7fKh1ufM6/zMBa9IpH6gjESpKsUs=
X-Google-Smtp-Source: AGHT+IEnlLVHoBRLQNhL5V2Vzj/nyhNIsF6w49nHFZmAHTG6QkJn0VyzxI7oFCJcpp1RHyjzwg4LIA==
X-Received: by 2002:a05:6214:5990:b0:6cb:f8b1:8ad6 with SMTP id
 6a1803df08f44-6cde150c303mr49383896d6.16.1729276180634; 
 Fri, 18 Oct 2024 11:29:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde122fc9dsm9288436d6.80.2024.10.18.11.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:29:39 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:29:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Message-ID: <20241018182937.GE4959@bill-the-cat>
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
 <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
 <20241018175254.GB4959@bill-the-cat>
 <CAFLszTiQHArgoS5zK6aKpi1kiTBcAT4wEkbFaVSt5FjVQ8vmpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IiVCaPXifmfUqIHj"
Content-Disposition: inline
In-Reply-To: <CAFLszTiQHArgoS5zK6aKpi1kiTBcAT4wEkbFaVSt5FjVQ8vmpQ@mail.gmail.com>
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


--IiVCaPXifmfUqIHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:06:46PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 11:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 11:20:40AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Oct 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > In principle bootstd can work without block devices, even if =
it does
> > > > > > > require driver model to be enabled in that case.
> > > > > > >
> > > > > > > The use of a 'depends on BLK' for BOOTSTD conflicts with the =
way 'BLK'
> > > > > > > is now defined, producing recursive errors through multiple d=
ifferent
> > > > > > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > > > > > BOOTSTD_DEFAULTS enabled):
> > > > > > >
> > > > > > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > > > > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHI=
ER_V8_MULTI
> > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_=
MULTI is
> > > > > > >      part of choice <choice>
> > > > > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains =
symbol
> > > > > > >      ARCH_UNIPHIER_V8_MULTI
> > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_=
MULTI is
> > > > > > >      part of choice SPL
> > > > > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPP=
ORT_SPL
> > > > > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASP=
EED_AST2600
> > > > > > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is p=
art of
> > > > > > >      choice <choice>
> > > > > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains s=
ymbol
> > > > > > >      ASPEED_AST2500
> > > > > > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is p=
art of
> > > > > > >      choice DM_RESET
> > > > > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is=
 selected
> > > > > > >      by CLK_RCAR_GEN3
> > > > > > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depend=
s on
> > > > > > >      CLK_RENESAS
> > > > > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends o=
n CLK
> > > > > > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWE=
R_DOMAIN
> > > > > > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN =
depends on
> > > > > > >      POWER_DOMAIN
> > > > > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is sele=
cted by
> > > > > > >      BCM6318_USBH_PHY
> > > > > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on =
PHY
> > > > > > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_M=
X7
> > > > > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends o=
n USB
> > > > > > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DE=
FAULTS
> > > > > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > > > > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > > > > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > > > > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > > > > >   Kconfig:176: symbol XEN depends on ARM64
> > > > > > >
> > > > > > > We don't want to revert the change to BLK, which has been in =
place for
> > > > > > > a year now. We don't want to select BLK in BOOTSTD since it s=
hould
> > > > > > > support booting without block devices. The only realistic opt=
ion is to
> > > > > > > remove BOOTSTD's dependency on BLK.
> > > > > > >
> > > > > > > Disable standard boot on the one board which fails.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Drop wip (work-in-progress) comment in commit
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > > > > > >
> > > > > > >  boot/Kconfig                                   | 2 +-
> > > > > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > Applied to u-boot-dm, thanks!
> > > > > >
> > > > > > No, this is wrong, it's pulling in BOOTSTD on a ton of platform=
s that
> > > > > > didn't have it before.
> > > > >
> > > > > This affects 103 boards and the size growth is considerable:
> > > > >
> > > > >    aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data +710.9
> > > > > rodata +1822.1 text +13137.8
> > > > >        arc: (for 4/4 boards) all +15338.0 bss +4.0 data +526.0 ro=
data
> > > > > +2096.0 text +12712.0
> > > > >        arm: (for 26/26 boards) all +18882.8 data +619.2 rodata +1=
998.8
> > > > > text +16264.8
> > > > >       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +1595.8
> > > > > rodata +1722.8 text +20537.8
> > > > > microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1248.0
> > > > > rodata +2288.0 text +21265.0
> > > > >       mips: (for 23/23 boards) all +21659.1 bss +39.5 data +746.6
> > > > > rodata +2155.7 text +18717.4
> > > > >      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +704.0 te=
xt +24148.0
> > > > >    powerpc: (for 13/13 boards) all +21746.6 data +836.3 rodata +8=
07.2
> > > > > text +20103.2
> > > > >
> > > > > Added options are:
> > > > >
> > > > >    + all: CONFIG_BOOTDEV_ETH=3D1 CONFIG_BOOTMETH_EXTLINUX=3D1
> > > > > CONFIG_BOOTMETH_GLOBAL=3D1 CONFIG_BOOTMETH_VBE=3D1
> > > > > CONFIG_BOOTMETH_VBE_REQUEST=3D1 CONFIG_BOOTMETH_VBE_SIMPLE=3D1
> > > > > CONFIG_BOOTMETH_VBE_SIMPLE_OS=3D1 CONFIG_BOOTSTD=3D1
> > > > > CONFIG_BOOTSTD_BOOTCOMMAND=3D1 CONFIG_CMD_BOOTFLOW=3D1 CONFIG_MEN=
U=3D1
> > > > > CONFIG_PXE_UTILS=3D1
> > > > >
> > > > > Should I manually disable it on those platforms? I've reached the
> > > > > point where bootstd needs to be available when BLK is not enabled=
, so
> > > > > need some sort of solution.
> > > >
> > > > What is the use case for needing all of this, without BLK being set=
? I'm
> > > > not sure which platforms that grew here also need bootstd?
> > >
> > > It is just that some XPL (I can say that now) platforms don't enable
> > > BLK but do need to read from a device, e.g. MMC.
> >
> > Er, how is that an issue for any of the XPL phases? We have
> > {SPL,TPL,VPL}_BLK symbols. And BLK itself is def_bool'd on DM and MMC,
> > etc. And all boards enable DM now.
>=20
> I was using MMC_TINY... I still have one more series for rk3399...so
> if things build OK I can perhaps just drop this patch and figure this
> out later?

Yeah, please drop this for now and re-visit things. MMC_TINY is only for
SPL (but tested as CONFIG_IS_ENABLED(MMC_TINY) because maybe it makes
sense in the TPL sense? But it's distinctly not BLK and DM, iirc).

--=20
Tom

--IiVCaPXifmfUqIHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSqQ0ACgkQFHw5/5Y0
tywbOAv+N4o6Mmrnil9t1linyuwCvGV2YkNOkdkxMA9suN1MsykOiawOH7xuSgLc
1gfH9RVplEyvdEVRtKK7QSi1ygI9dYmqyf7piAuiJbxuHLMlPUQE82yF00pC4Q2V
8OZV8UR9Zr3CQMIxtag1mVF2I7aCDkczbQfMhQT4+pivnai8ExlRTvvQqsDf7wo/
gDKzS+tggRHemHlCn/nn37J2eZ9lPjy9cgCu36xzqLD3POm4oFhrQiH95twTafP+
nxUBYWhfeC86tf7/RSagXPOgh4d2dPcf4dw/yTh/omQ4j6IdGE6ZjXZFTJgBvTIU
+sC4C5w7uENmurSXTXCqc+Ue9k/cZrKnhK7TbKVxsG/Iq/2I6e0o+y525ZGTecGN
c4qlYVi5khj9xGhauKIcZuEQ9MVn8zSBobnfa0h/F5QT9T0WV6q0DczQ8uZIH7VJ
Q1zJ9BJNPRSH6z3nv6SN8dpRaKW/NLu7TCfVHjilMkgGEEWCiOyGxXfJBVKXStu2
ps7ATPyN
=bMmR
-----END PGP SIGNATURE-----

--IiVCaPXifmfUqIHj--
