Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02177D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600558920A;
	Fri, 18 Oct 2024 17:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XrGW9Qux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FA58920A; Fri, 18 Oct 2024 17:12:04 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0240F891D6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so174014985a.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729264316; x=1729869116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BYML8W2QRnJ8QuerSxAPJ+YyNAcIfvNPI3tPLcvsh1g=;
 b=XrGW9QuxLkk+IrXdpNrnOlh8NHNiFAS00Zc5VCpZjImTrMg3LOQFFpf3WvrdMzJOlm
 w7RdPxwTD3Y//dB0TFTtUXPyJN4gXyW0ivYj9cz6Wb5dhkLGBOO21rHLvY3CGGG7adBt
 7BHJRvkYGLYhxceD0bDqisgH3c4vBbZNL/xTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729264316; x=1729869116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYML8W2QRnJ8QuerSxAPJ+YyNAcIfvNPI3tPLcvsh1g=;
 b=VA6lO1AiyAb0IVfs4HRrOkdqqvoAw0iOwT8kDIBgFgV1gTOsNN6DBn7OJoZ2ip7lRG
 i8gGeWxhYxLL/FZ6T8eoZHHXG1H4WhXD5Vxw9rBTecWDQdB5htorlfDOO4HlYyCUD/dP
 o5TMr9bXqPk4qlPDEBitV70QSrEvPfjEdS2h5s5eOSP3NH+K+M2uAqNukqlLYdLSFlJd
 mGFmqr66KGo9XsllWxYBQXfOdDj7UFy+bRaMDcgT/zDOg5p2e0WwjLcFqmAIY58kOVAP
 pn8wV6gR55VOtDe75W0CLCMh7JlkR/hm7J4XQt+rbGayjPgMSaKIQjhbNtyrMW0RqR07
 LQIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEIN9x4v4x59+FBUHZNJsOrHKIsarrJQoXvPNz1vraL/xq0bGPnQJt7zB729EIftXptDJLg+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3SMQT9iSJw9ue8eHrKoHhCUj0kzQUm6Ut0L/LMSsaJytx63Wu
 ee2wPpjsq7C4LXnXIGXPD8HqDfi7NzwE3+y+7iHeghGX6vM0LCEyzbxC8m/00MkdlgcLwl+OXkr
 sNXo=
X-Google-Smtp-Source: AGHT+IGC3+smH08KP90cuuUMHhzEUSs21RKOmbHsuus1wo9Ylj1O6MuXV+7qqFpSAp7saskVnMsKvA==
X-Received: by 2002:a05:620a:4725:b0:7af:c632:dac0 with SMTP id
 af79cd13be357-7b157bdebadmr327890385a.50.1729264315768; 
 Fri, 18 Oct 2024 08:11:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156fe59dfsm77100385a.74.2024.10.18.08.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 08:11:55 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:11:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Message-ID: <20241018151152.GX4959@bill-the-cat>
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PIxWhWRuLhiwEJ1U"
Content-Disposition: inline
In-Reply-To: <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
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


--PIxWhWRuLhiwEJ1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:
> >
> > > In principle bootstd can work without block devices, even if it does
> > > require driver model to be enabled in that case.
> > >
> > > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > > is now defined, producing recursive errors through multiple different
> > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > BOOTSTD_DEFAULTS enabled):
> > >
> > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MU=
LTI
> > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > >      part of choice <choice>
> > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> > >      ARCH_UNIPHIER_V8_MULTI
> > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > >      part of choice SPL
> > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2=
600
> > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> > >      choice <choice>
> > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> > >      ASPEED_AST2500
> > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> > >      choice DM_RESET
> > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> > >      by CLK_RCAR_GEN3
> > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> > >      CLK_RENESAS
> > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends =
on
> > >      POWER_DOMAIN
> > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> > >      BCM6318_USBH_PHY
> > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > >   Kconfig:176: symbol XEN depends on ARM64
> > >
> > > We don't want to revert the change to BLK, which has been in place for
> > > a year now. We don't want to select BLK in BOOTSTD since it should
> > > support booting without block devices. The only realistic option is to
> > > remove BOOTSTD's dependency on BLK.
> > >
> > > Disable standard boot on the one board which fails.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Drop wip (work-in-progress) comment in commit
> > >
> > > Changes in v2:
> > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > >
> > >  boot/Kconfig                                   | 2 +-
> > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > Applied to u-boot-dm, thanks!
> >
> > No, this is wrong, it's pulling in BOOTSTD on a ton of platforms that
> > didn't have it before.
>=20
> This affects 103 boards and the size growth is considerable:
>=20
>    aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data +710.9
> rodata +1822.1 text +13137.8
>        arc: (for 4/4 boards) all +15338.0 bss +4.0 data +526.0 rodata
> +2096.0 text +12712.0
>        arm: (for 26/26 boards) all +18882.8 data +619.2 rodata +1998.8
> text +16264.8
>       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +1595.8
> rodata +1722.8 text +20537.8
> microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1248.0
> rodata +2288.0 text +21265.0
>       mips: (for 23/23 boards) all +21659.1 bss +39.5 data +746.6
> rodata +2155.7 text +18717.4
>      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +704.0 text +2414=
8.0
>    powerpc: (for 13/13 boards) all +21746.6 data +836.3 rodata +807.2
> text +20103.2
>=20
> Added options are:
>=20
>    + all: CONFIG_BOOTDEV_ETH=3D1 CONFIG_BOOTMETH_EXTLINUX=3D1
> CONFIG_BOOTMETH_GLOBAL=3D1 CONFIG_BOOTMETH_VBE=3D1
> CONFIG_BOOTMETH_VBE_REQUEST=3D1 CONFIG_BOOTMETH_VBE_SIMPLE=3D1
> CONFIG_BOOTMETH_VBE_SIMPLE_OS=3D1 CONFIG_BOOTSTD=3D1
> CONFIG_BOOTSTD_BOOTCOMMAND=3D1 CONFIG_CMD_BOOTFLOW=3D1 CONFIG_MENU=3D1
> CONFIG_PXE_UTILS=3D1
>=20
> Should I manually disable it on those platforms? I've reached the
> point where bootstd needs to be available when BLK is not enabled, so
> need some sort of solution.

What is the use case for needing all of this, without BLK being set? I'm
not sure which platforms that grew here also need bootstd?

--=20
Tom

--PIxWhWRuLhiwEJ1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSerQACgkQFHw5/5Y0
tywHRwv/QfM35MaYRgv7IiZ7aLpRtiRVZT0rs9U6020orwicSmIPdBy7g39eX8QQ
w5XMlZmRTnOM3/7bFK2qCvgLGT6XZp3wH/83bF6A3jhCM24kHlKwNUA5ljdBQO0O
KvX7Z1bpzpTVp79J96NfL12JQclasHvjm+l4XqYHbddTBK6S8K4QBWV48naYLX/6
zYZis92iK1T7dB6tyxlCV5AImzaGDF/PTEyQCFKxSG4sdvHMbxvFniAWLYrDxa4B
6wGDZjn7MGOfx4WGOpobfNA0wO9vEcB9OxvcMoshQe+oJnTvL+u4q7Q7xm+Nu/0t
Vs7m0KW982XMSogBVAkpJ0Xnf71/KBvvOmWwUIQ0XWq0+Mi/KXxMyb941YSXN1hW
Qr5vjs6lscno/6CcO5tDn5hp1AH52araQsIz3aOOb+3FwuHRNuTLz6D8iYMu5NQO
WiaMliDs4lL2SSdfyNgf4exSqhwl33C6FEd6AVo2GIN8SJSEDIc+rgwNOJJcT8bq
by1xT8M4
=Ci98
-----END PGP SIGNATURE-----

--PIxWhWRuLhiwEJ1U--
