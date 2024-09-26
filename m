Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E8CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E20388E31;
	Thu, 26 Sep 2024 22:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED34E88E26; Thu, 26 Sep 2024 22:51:19 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BFC88DFD
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 16D961F0004F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 20:51:11 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id A32C3A60178; Thu, 26 Sep 2024 20:51:08 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id C6372A60172;
 Thu, 26 Sep 2024 20:51:06 +0000 (UTC)
Date: Thu, 26 Sep 2024 22:51:04 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/4] rockchip: Disable DRAM debug by default
Message-ID: <ZvXJOJb0rKDYnTeQ@collins>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-4-paulk@sys-base.io>
 <21bf0494f4dd9052801c2bacfe014651@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zCBVXV9jo6dmi0sL"
Content-Disposition: inline
In-Reply-To: <21bf0494f4dd9052801c2bacfe014651@manjaro.org>
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


--zCBVXV9jo6dmi0sL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Thu 26 Sep 24, 22:17, Dragan Simic a =C3=A9crit :
> On 2024-09-26 20:31, Paul Kocialkowski wrote:
> > From: Paul Kocialkowski <contact@paulk.fr>
> >=20
> > Printing debug details about DRAM is not useful in regular use and
> > adds visual pollution to the log. Disable it by default.
>=20
> With all the respect, I disagree with disabling this by default.
> This prints just a couple of lines that can actually be very helpful
> when figuring out what's going on in case of some DRAM-related issues
> on random devices in the field.

Well this rationale could apply to lots of things and we generally don't
print debug info about anything else by default.

Maybe DRAM is more likely to be a source of issues than other hardware aspe=
cts
that are maybe more stable, but I don't see what would prevent rebuilding a
u-boot binary with debug enabled. If the DRAM config needs tweaking it will=
 be
necessary to rebuild a binary anyway.

Cheers,

Paul

> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
> >  configs/neu2-io-rv1126_defconfig          | 1 -
> >  configs/roc-pc-mezzanine-rk3399_defconfig | 1 -
> >  configs/roc-pc-rk3399_defconfig           | 1 -
> >  configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
> >  configs/rock-pi-n8-rk3288_defconfig       | 1 -
> >  configs/sonoff-ihost-rv1126_defconfig     | 1 -
> >  drivers/ram/rockchip/Kconfig              | 1 -
> >  8 files changed, 8 deletions(-)
> >=20
> > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig
> > b/configs/anbernic-rgxx3-rk3566_defconfig
> > index a03509bf4671..5c074cffeb44 100644
> > --- a/configs/anbernic-rgxx3-rk3566_defconfig
> > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> > @@ -67,7 +67,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> >  CONFIG_REGULATOR_RK8XX=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> >  CONFIG_SPL_RAM=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  # CONFIG_RNG_SMCCC_TRNG is not set
> >  CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> > diff --git a/configs/neu2-io-rv1126_defconfig
> > b/configs/neu2-io-rv1126_defconfig
> > index 2a4c9b45a04f..84e4465f2c5f 100644
> > --- a/configs/neu2-io-rv1126_defconfig
> > +++ b/configs/neu2-io-rv1126_defconfig
> > @@ -45,7 +45,6 @@ CONFIG_MMC_DW=3Dy
> >  CONFIG_MMC_DW_ROCKCHIP=3Dy
> >  CONFIG_REGULATOR_PWM=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> >  CONFIG_SYSRESET=3Dy
> > diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig
> > b/configs/roc-pc-mezzanine-rk3399_defconfig
> > index a57899bfdfa0..b4041902b381 100644
> > --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> > +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> > @@ -65,7 +65,6 @@ CONFIG_REGULATOR_PWM=3Dy
> >  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> >  CONFIG_REGULATOR_RK8XX=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> >  CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> > diff --git a/configs/roc-pc-rk3399_defconfig
> > b/configs/roc-pc-rk3399_defconfig
> > index b45f0e0a8994..922f67320c20 100644
> > --- a/configs/roc-pc-rk3399_defconfig
> > +++ b/configs/roc-pc-rk3399_defconfig
> > @@ -62,7 +62,6 @@ CONFIG_REGULATOR_PWM=3Dy
> >  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> >  CONFIG_REGULATOR_RK8XX=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> >  CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> > diff --git a/configs/rock-pi-n10-rk3399pro_defconfig
> > b/configs/rock-pi-n10-rk3399pro_defconfig
> > index ec995a54a0ee..17fe939ec989 100644
> > --- a/configs/rock-pi-n10-rk3399pro_defconfig
> > +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> > @@ -51,7 +51,6 @@ CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
> >  CONFIG_PMIC_RK8XX=3Dy
> >  CONFIG_REGULATOR_RK8XX=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> >  CONFIG_SYS_NS16550_MEM32=3Dy
> > diff --git a/configs/rock-pi-n8-rk3288_defconfig
> > b/configs/rock-pi-n8-rk3288_defconfig
> > index 4c09b9137ef8..af0fa8879421 100644
> > --- a/configs/rock-pi-n8-rk3288_defconfig
> > +++ b/configs/rock-pi-n8-rk3288_defconfig
> > @@ -73,7 +73,6 @@ CONFIG_REGULATOR_RK8XX=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> >  CONFIG_RAM=3Dy
> >  CONFIG_SPL_RAM=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> >  CONFIG_SYS_NS16550_MEM32=3Dy
> >  CONFIG_SYSRESET=3Dy
> > diff --git a/configs/sonoff-ihost-rv1126_defconfig
> > b/configs/sonoff-ihost-rv1126_defconfig
> > index 4890644c7e6f..739adb49ce93 100644
> > --- a/configs/sonoff-ihost-rv1126_defconfig
> > +++ b/configs/sonoff-ihost-rv1126_defconfig
> > @@ -46,7 +46,6 @@ CONFIG_MMC_DW=3Dy
> >  CONFIG_MMC_DW_ROCKCHIP=3Dy
> >  CONFIG_REGULATOR_PWM=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> >  CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> >  CONFIG_SYSRESET=3Dy
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> > index 67c63ecba047..e030c982eccb 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -15,7 +15,6 @@ if RAM_ROCKCHIP
> >=20
> >  config RAM_ROCKCHIP_DEBUG
> >  	bool "Rockchip ram drivers debugging"
> > -	default y
> >  	help
> >  	  This enables debugging ram driver API's for the platforms
> >  	  based on Rockchip SoCs.

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expertise in multimedia, graphics and embedded hardware support with Linux.

--zCBVXV9jo6dmi0sL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmb1yTgACgkQhP3B6o/u
lQwcdw//dR0VdNlyFH0wxYcSHjdUFz3x0wXhm9ud55S7mebHXt4xO5Hq7urcdzBY
SaK6dhGtt9/kTJb7tfe/tReeaxPPlmpRCesuctoCMDasaYwqvGtkB+UdwOoHshWX
acGJov4xhdsXszpskyXgDW+as8zFGkAZpfgyKh/khH6Ql3M+fWy/PUuOBQzE2PX1
KCQjmzyLsToSqckca35Z/PLIYhlMUUhoXYPnX0lY88fHhVtj3ddzDdaAmb0dlCIt
QoYmO6Q5GBGnjOnJ6eUGTBPYyVTHEKbWj7ywoTGga9n/R1Ys4IYsLYizMhtHJqnt
VyJXQCiGThZ9q9kUPaGoQl6NDTxX35+JtFPK2WbVgK+Gts1W/JTbPLYXjVKTWUah
pqqZeggZPBiLtDF+jiVrdloox/vpyhKY4pQqsWbMoRmQW1m/hzIi/G11tWgrSdGN
R/UlJci0w4pFhQhL6KM7jdln368ExDe0DWMw+2AqBtHJVuIR/D6Vo8Zu7ZXbSsQG
i3I9FOkMKfRZKDsfdx6BrzfHvo+v948ZoaDxtNGlUwUBFl8QIu8UDuo05jZ79lfd
OdCTw0riuw4R3uB7aOq1fx9yLGEceRh5OLkykgq/bu5QDkOSjp5jLqBJP9kO1j+a
/8E0VoNDtuOHTwH0sH6sDEMq9jiD6qS5MBy6l7oTGwsPIUQrwRI=
=uR6G
-----END PGP SIGNATURE-----

--zCBVXV9jo6dmi0sL--
