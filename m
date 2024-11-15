Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6ABD68BC2
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C87B89235;
	Fri, 15 Nov 2024 15:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X512Ch7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD738933F; Fri, 15 Nov 2024 15:37:26 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D408E891F5
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-460b04e4b1cso12114601cf.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731681443; x=1732286243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u9aUUKJtYq2bN3UaAR/33KJkrsHDqjzlpe7IjgxmiwM=;
 b=X512Ch7Yyf7hjCBk12/sfOiSgrIAS7wiFlw69MULm8XCB3zW+cQ8lPbqYfDt3SFAqf
 J9/M/SNEQutmfIINc5Jllkj+n1HvsaAmRL1LoHMQni90fdUwuLcVOw+1yX/EWPwLwSv9
 MB6eFrJRbFm6gi6+WR4MVjcsaV8gVD8i5UFnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731681443; x=1732286243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9aUUKJtYq2bN3UaAR/33KJkrsHDqjzlpe7IjgxmiwM=;
 b=ALT57jMJgT9EBtFUydkJmeGW4hwgbYy6N+w+zIq3yhU0tCjbat6Q81qjq4xEGFA855
 uOtWu6izILiezutqzZjwAv+6M2Dra4vNgaxAhIbH9aRzB+Bx3EDAKLUAZ041MiluGj54
 mpaoV4z7AJqzosSzEbKYtWvXkNLPp0hY6VtXHC2mNmn+VW8rNvLxFH9axDk92NVf9alm
 Yso2nviMUpERSnx1/FTpAuEE5qVSiWU+JWPlsI1kDSZWQuyj3o8cfmwZb6LZ5s+kAhZn
 I2VpSbd+m3kOFvuA17GBzGgPwfAzqReDH3NqMOQI0rtB1TQJBb43M8GU5qcixwxWe+Nj
 wS5Q==
X-Gm-Message-State: AOJu0YwZrJBhrk+x+deMXwOZ/MnHjJRQ3i3IXaY3Owd0cKbbseF8/FEK
 exES1ITvfITmoCEF4TTdqfNq3x9TAD006YJr9MYDRS3T3ejVmGbYyMNuHXopJkk=
X-Google-Smtp-Source: AGHT+IGEHMfzFPBgnWZ60n3f3nbimX0O8cI5NWut9yPh9mfCkXZx1iv6n2B273HGwQWnRgQGDqQU9Q==
X-Received: by 2002:ac8:5ac5:0:b0:461:2ebb:c9db with SMTP id
 d75a77b69052e-46363e182d3mr35332711cf.16.1731681442545; 
 Fri, 15 Nov 2024 06:37:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab250c0sm19472611cf.64.2024.11.15.06.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 06:37:21 -0800 (PST)
Date: Fri, 15 Nov 2024 08:37:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5 1/8] bootstd: Avoid depending on BLK
Message-ID: <20241115143718.GU3600562@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-2-sjg@chromium.org>
 <20241113174707.GR3600562@bill-the-cat>
 <CAFLszTjW2bGPRvUQC9pxvhKixpov8u2GxzzeUYeKo1FNFyuHug@mail.gmail.com>
 <20241114142221.GD3600562@bill-the-cat>
 <CAFLszTiJ2tQOddSFCjp+TKsRAgjgjtBFXakSJd+4VShio5OuCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0z1BCn6k/X+sG3z5"
Content-Disposition: inline
In-Reply-To: <CAFLszTiJ2tQOddSFCjp+TKsRAgjgjtBFXakSJd+4VShio5OuCQ@mail.gmail.com>
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


--0z1BCn6k/X+sG3z5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 07:27:19AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 14 Nov 2024 at 07:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 08:53:31PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 13 Nov 2024 at 10:47, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Nov 13, 2024 at 08:09:31AM -0700, Simon Glass wrote:
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
> > > > > (no changes since v3)
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
> > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > index 7dd30a030e3..b5433e88f10 100644
> > > > > --- a/boot/Kconfig
> > > > > +++ b/boot/Kconfig
> > > > > @@ -393,7 +393,7 @@ config BOOT_DEFAULTS
> > > > >  menuconfig BOOTSTD
> > > > >       bool "Standard boot"
> > > > >       default y
> > > > > -     depends on DM && OF_CONTROL && BLK
> > > > > +     depends on DM && OF_CONTROL
> > > > >       help
> > > > >         U-Boot supports a standard way of locating something to b=
oot,
> > > > >         typically an Operating System such as Linux, provided by =
a distro such
> > > >
> > > > This ends up being a massive size bloat on all of the boards which =
did
> > > > not use BOOTSTD before, and still can't (because there's no appropr=
iate
> > > > methods). You need to not just disable it on the one board that fai=
ls
> > > > but on everything not currently enabling it, which now does enable =
it.
> > >
> > > Looking through the list it is hard to know which boards can't use
> > > bootstd, nor what the missing methods are. See [1]. I could perhaps
> > > disable bootstd for all of the boards?
> >
> > Well, since you cannot have a block device without BLK at this point,
> > none of them can use bootstd since there's no methods for whatever flash
> > they use?
>=20
> We have SPI flash and FEL, for example. Also, sandbox's hostfs doesn't
> use BLK. Plus the network bootmeths are available without it.
>=20
> >
> > > > Or you need to better explain what's going on here, exactly and why
> > > > depending on BLK here is wrong, for what you're doing.
> > >
> > > I tried that already. We had quite a long thread about it.
> >
> > Yes, can you remind me please? I still don't see why this is required
> > for sunxi support. And I think this is another good example of where
> > your commit message explains your solution, but not the underlying
> > problem you're solving. None of the platforms in [1] are ARCH_SUNXI.
>=20
> Yes it is at [2]. If you look at BLK it says:
>=20
> config BLK
>    bool # "Support block devices"
>    depends on DM
>    def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
>    def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
>=20
> We also have, in the commit message:
>=20
> symbol BLK is selected by EFI_LOADER
>=20
> Having a 'select X' and 'depends on X' is known to cause problems. We
> really shouldn't do it. So I am removing 'depends on BLK'.

The challenge here is that when working with "default y" symbols, you
need to exercise a lot more care. I'm sending out later today a series
that also addresses the problems this patch exposed.

--=20
Tom

--0z1BCn6k/X+sG3z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3XJoACgkQFHw5/5Y0
tyzV1Av6Ao6R6yqEE26jYVNPN7th/YKTBwr/gzSKb2NKiNr3QHfZEZUH2tRtsSts
uSQhLfBB7AaNWCHNQO/cbdmeQBvP8fofU04qEtgMd1o0tfDZPmeC05C3ASkjV3H3
Pqudjx2iW4ARPYLLag5L6ouPdGWX6Fb7y5J5fs6r3+ncl3Y8+jGv9j89C/eSQ73O
V2B6/j9bAwTTy8TWnbeBtWKQK6E7nl+E6wuLipMPQp9bLGCnm+e++2rWI0jr5p/s
3yo6OZehHr0OwszjMaLJV78EhAyTCuVxl6b14IS58MFE1bVIsuDkN8436hmuTH7h
lPhn5k5dcXikW5FLiKyaPLF50qefWsIFOhHYojn3gDsjnaIzEwKpCl0wsxNaqEsg
K3OUmCK4MwQG7OKobqr18RXtbJgHgO0a3EAMlReadsVOB6YPg1HyPlazfCsmRqY9
dELIg46A3Ux2RYh93RI91i/vJtQoVTJzmSpdE8+FMz4UeRA9/uVrMZyTF5rOqmC5
/AlGmxXQ
=uzPn
-----END PGP SIGNATURE-----

--0z1BCn6k/X+sG3z5--
