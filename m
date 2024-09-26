Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D2CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AB188EE4;
	Thu, 26 Sep 2024 23:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E1D88EA8; Thu, 26 Sep 2024 23:39:55 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7ADF88E5F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 502CC1F0004F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 21:39:50 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 1D074A601D3; Thu, 26 Sep 2024 21:39:49 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 717E2A601CD;
 Thu, 26 Sep 2024 21:39:47 +0000 (UTC)
Date: Thu, 26 Sep 2024 23:39:45 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/4] rockchip: Disable DRAM debug by default
Message-ID: <ZvXUoaqT8BLIMRTT@shepard>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-4-paulk@sys-base.io>
 <21bf0494f4dd9052801c2bacfe014651@manjaro.org>
 <ZvXJOJb0rKDYnTeQ@collins>
 <72b29cc73709076229b3aa6ae9d0f5da@manjaro.org>
 <ZvXPHya0NdGRdCiq@collins>
 <acc079de0eb93a32df523f26836339a7@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZgszJ8jbfBZIk8hk"
Content-Disposition: inline
In-Reply-To: <acc079de0eb93a32df523f26836339a7@manjaro.org>
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


--ZgszJ8jbfBZIk8hk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 26 Sep 24, 23:24, Dragan Simic wrote:
> On 2024-09-26 23:16, Paul Kocialkowski wrote:
> > Le Thu 26 Sep 24, 23:04, Dragan Simic a =C3=A9crit :
> > > On 2024-09-26 22:51, Paul Kocialkowski wrote:
> > > > Le Thu 26 Sep 24, 22:17, Dragan Simic a =C3=A9crit :
> > > > > On 2024-09-26 20:31, Paul Kocialkowski wrote:
> > > > > > From: Paul Kocialkowski <contact@paulk.fr>
> > > > > >
> > > > > > Printing debug details about DRAM is not useful in regular use =
and
> > > > > > adds visual pollution to the log. Disable it by default.
> > > > >
> > > > > With all the respect, I disagree with disabling this by default.
> > > > > This prints just a couple of lines that can actually be very help=
ful
> > > > > when figuring out what's going on in case of some DRAM-related is=
sues
> > > > > on random devices in the field.
> > > >
> > > > Well this rationale could apply to lots of things and we generally =
don't
> > > > print debug info about anything else by default.
> > >=20
> > > I'd rather see these messages as some kind of additional verbosity,
> > > rather than some true debugging messages for the DRAM init.  It's just
> > > a couple of additional lines printed on the console, in the end.
> >=20
> > It's mostly the fact that it's platform-specific and makes about no
> > sense
> > to a non-developer user that makes me think it's not welcome by default.
> > It's really printing internal variables, not providing user-readable
> > information
> > that can be useful outside of the scope of development.
>=20
> Well, each and every U-Boot build is platform- and device-specific, so
> I see no problems with some of the messages produced by default being
> platform- or device-specific.

I like the idea that U-Boot behaves more or less the same regardless of the
platform and that there is some consistency in what is shown on the console.
At least that's how I understand the "universal" aspect of it.

> In practice, anything that U-Boot prints on the console has little to no
> meaning to the vast majority of people who actually happen to see and
> register those messages.  As a result, those messages are mostly useful
> to the developers only.

I disagree. Most of what is shown is understandable for technical users and
provides informative value. I'm obviously not talking about users that are =
not
interested in understand how their technology works here, for whom nothing =
shown
on the console will have any value.

There is a fundamental difference between printing status information and
printing debug information. I think this clearly falls under debug informat=
ion
(and the name of the config option agrees).

> > > > Maybe DRAM is more likely to be a source of issues than other hardw=
are
> > > > aspects
> > > > that are maybe more stable, but I don't see what would prevent
> > > > rebuilding a
> > > > u-boot binary with debug enabled. If the DRAM config needs tweaking=
 it
> > > > will be
> > > > necessary to rebuild a binary anyway.
> > >=20
> > > In theory, rebuilding a U-Boot image and reinstalling it is rather
> > > easy.
> > > In practice, it's hardly doable on random devices in the field, and
> > > it's
> > > sometimes virtually impossible.  It's simply that not every end user
> > > is
> > > willing or capable of doing things like that.
> >=20
> > Well that is more or less what makes me think this is not welcome by
> > default:
> > a non-developer user would not be able to do anything useful with this
> > information, since they won't be able to rebuild a binary to change the
> > DRAM
> > config and solve any DRAM-related issue.
>=20
> A non-developer may be able to forward the messages to a developer, who
> in turn may be able to use them to roughly figure out what's going on.

I don't see how it is useful to have a deeper understanding of some DRAM-re=
lated
issue if nothing can be done about it.

> > Just knowing this information "on the field" won't help solve any issue
> > if
> > there is no possibility to undergo development and build a binary with a
> > modified DRAM config.
> >=20
> > In what scenario exactly do you think this would be valuable information
> > to
> > a non-developer?
>=20
> I'm actually speaking from experience.  Those messages have already
> proven to be useful in a few cases that I happened to witness.

I'd be curious to see cases where this information helped resolve any actual
issue. Honestly I'm not very convinced and haven't changed my mind.

Of course it will be up to maintainers to decide whether this change is good
or not. I can still live with the debug info on by default, I've just been
annoyed by it for a while and thought most people would better like it gone.

Thanks for sharing your thoughts!

Cheers,

Paul

> > > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > > > ---
> > > > > >  configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
> > > > > >  configs/neu2-io-rv1126_defconfig          | 1 -
> > > > > >  configs/roc-pc-mezzanine-rk3399_defconfig | 1 -
> > > > > >  configs/roc-pc-rk3399_defconfig           | 1 -
> > > > > >  configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
> > > > > >  configs/rock-pi-n8-rk3288_defconfig       | 1 -
> > > > > >  configs/sonoff-ihost-rv1126_defconfig     | 1 -
> > > > > >  drivers/ram/rockchip/Kconfig              | 1 -
> > > > > >  8 files changed, 8 deletions(-)
> > > > > >
> > > > > > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > b/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > index a03509bf4671..5c074cffeb44 100644
> > > > > > --- a/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > @@ -67,7 +67,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> > > > > >  CONFIG_REGULATOR_RK8XX=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > >  CONFIG_SPL_RAM=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  # CONFIG_RNG_SMCCC_TRNG is not set
> > > > > >  CONFIG_BAUDRATE=3D1500000
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > > diff --git a/configs/neu2-io-rv1126_defconfig
> > > > > > b/configs/neu2-io-rv1126_defconfig
> > > > > > index 2a4c9b45a04f..84e4465f2c5f 100644
> > > > > > --- a/configs/neu2-io-rv1126_defconfig
> > > > > > +++ b/configs/neu2-io-rv1126_defconfig
> > > > > > @@ -45,7 +45,6 @@ CONFIG_MMC_DW=3Dy
> > > > > >  CONFIG_MMC_DW_ROCKCHIP=3Dy
> > > > > >  CONFIG_REGULATOR_PWM=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  CONFIG_BAUDRATE=3D1500000
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > >  CONFIG_SYSRESET=3Dy
> > > > > > diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig
> > > > > > b/configs/roc-pc-mezzanine-rk3399_defconfig
> > > > > > index a57899bfdfa0..b4041902b381 100644
> > > > > > --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> > > > > > +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> > > > > > @@ -65,7 +65,6 @@ CONFIG_REGULATOR_PWM=3Dy
> > > > > >  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> > > > > >  CONFIG_REGULATOR_RK8XX=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> > > > > >  CONFIG_BAUDRATE=3D1500000
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > > diff --git a/configs/roc-pc-rk3399_defconfig
> > > > > > b/configs/roc-pc-rk3399_defconfig
> > > > > > index b45f0e0a8994..922f67320c20 100644
> > > > > > --- a/configs/roc-pc-rk3399_defconfig
> > > > > > +++ b/configs/roc-pc-rk3399_defconfig
> > > > > > @@ -62,7 +62,6 @@ CONFIG_REGULATOR_PWM=3Dy
> > > > > >  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> > > > > >  CONFIG_REGULATOR_RK8XX=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> > > > > >  CONFIG_BAUDRATE=3D1500000
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > > diff --git a/configs/rock-pi-n10-rk3399pro_defconfig
> > > > > > b/configs/rock-pi-n10-rk3399pro_defconfig
> > > > > > index ec995a54a0ee..17fe939ec989 100644
> > > > > > --- a/configs/rock-pi-n10-rk3399pro_defconfig
> > > > > > +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> > > > > > @@ -51,7 +51,6 @@ CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
> > > > > >  CONFIG_PMIC_RK8XX=3Dy
> > > > > >  CONFIG_REGULATOR_RK8XX=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  CONFIG_BAUDRATE=3D1500000
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > >  CONFIG_SYS_NS16550_MEM32=3Dy
> > > > > > diff --git a/configs/rock-pi-n8-rk3288_defconfig
> > > > > > b/configs/rock-pi-n8-rk3288_defconfig
> > > > > > index 4c09b9137ef8..af0fa8879421 100644
> > > > > > --- a/configs/rock-pi-n8-rk3288_defconfig
> > > > > > +++ b/configs/rock-pi-n8-rk3288_defconfig
> > > > > > @@ -73,7 +73,6 @@ CONFIG_REGULATOR_RK8XX=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > >  CONFIG_RAM=3Dy
> > > > > >  CONFIG_SPL_RAM=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > >  CONFIG_SYS_NS16550_MEM32=3Dy
> > > > > >  CONFIG_SYSRESET=3Dy
> > > > > > diff --git a/configs/sonoff-ihost-rv1126_defconfig
> > > > > > b/configs/sonoff-ihost-rv1126_defconfig
> > > > > > index 4890644c7e6f..739adb49ce93 100644
> > > > > > --- a/configs/sonoff-ihost-rv1126_defconfig
> > > > > > +++ b/configs/sonoff-ihost-rv1126_defconfig
> > > > > > @@ -46,7 +46,6 @@ CONFIG_MMC_DW=3Dy
> > > > > >  CONFIG_MMC_DW_ROCKCHIP=3Dy
> > > > > >  CONFIG_REGULATOR_PWM=3Dy
> > > > > >  CONFIG_PWM_ROCKCHIP=3Dy
> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > > > > >  CONFIG_BAUDRATE=3D1500000
> > > > > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > > > > >  CONFIG_SYSRESET=3Dy
> > > > > > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchi=
p/Kconfig
> > > > > > index 67c63ecba047..e030c982eccb 100644
> > > > > > --- a/drivers/ram/rockchip/Kconfig
> > > > > > +++ b/drivers/ram/rockchip/Kconfig
> > > > > > @@ -15,7 +15,6 @@ if RAM_ROCKCHIP
> > > > > >
> > > > > >  config RAM_ROCKCHIP_DEBUG
> > > > > >  	bool "Rockchip ram drivers debugging"
> > > > > > -	default y
> > > > > >  	help
> > > > > >  	  This enables debugging ram driver API's for the platforms
> > > > > >  	  based on Rockchip SoCs.

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--ZgszJ8jbfBZIk8hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmb11KEACgkQhP3B6o/u
lQz33Q//cjbF6+sxLskX/xwDzqygifCeXaRlMj26uAIJo1b3TrY8iJoqV7XopY2q
xPBGxM292b9A7I395EqJ6dig7UlmWhl0MUoKAW+hGfRnvlfMjeEo3hCXyV7ZUlHY
+EQjsQl+4DUJUzZHRWUQhP5d9kvGRVtg6FfUCk5cWfcQWwvjJEspjd+OckGQgi+V
brBh9wTO9dIWjNCry7XcR51PcSiQXlAgs8/8WoV4w+2nkBCBqot65Muhb2H6UqvV
2iIqkQDXcLZeiTVBARuXMynWZPY9VwT0xZSfsDT1XdPeKCL/59H+WDSOki0jKc3y
V2bfT/qxMnOex23ybUcpMTAxO2Llk1K9Wcgx9wDkgyKXEDSbsCaSCKgphwk78FSW
IZHJ5Lo9PN9iTMqiYPBu/bAo3iC+U5MXfeG9tIoeXI4NudP21LUTF4UsTsCHt2Ue
qyPHznilwOZlIZT1wO0mwrN5UJA3HXzRy4HClbtk0bpuiYsVVA2dnsydp+apaV/d
pLxC3xgSKt/lElVTadz+f4cccZ5wmcUski89wf/CdAXR4VtskCy4qY1mZzu/j1/L
7/wVCpFJg7cuHnnkcpMPJIYLy9jBi4Z+WTyV32Ci03bByUjSRGwmm9Uw0cbO/mfF
8H6zecIQQQXUpjI2diZoTV6C1RH9y5Sxmu+dLOYVLlzR9YGqUEw=
=ym87
-----END PGP SIGNATURE-----

--ZgszJ8jbfBZIk8hk--
