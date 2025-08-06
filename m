Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05268C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 17:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7617C83AC6;
	Wed,  6 Aug 2025 19:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE89D8438F; Wed,  6 Aug 2025 19:26:09 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEAD83AC5
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 19:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 553281F00050
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:26:04 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 8C611B0125B; Wed,  6 Aug 2025 17:18:20 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 2734DB01251;
 Wed,  6 Aug 2025 17:18:18 +0000 (UTC)
Date: Wed, 6 Aug 2025 19:18:16 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 07/11] sunxi: Add support for UART1 on PG pins for the
 V3/S3
Message-ID: <aJOOWHWb-VyWab5c@collins>
References: <20250805174827.3696191-1-paulk@sys-base.io>
 <20250805174827.3696191-8-paulk@sys-base.io>
 <20250806012121.27bdcfeb@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AmmwbfkrvLD0goOs"
Content-Disposition: inline
In-Reply-To: <20250806012121.27bdcfeb@minigeek.lan>
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


--AmmwbfkrvLD0goOs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thansk for the review!

Le Wed 06 Aug 25, 01:21, Andre Przywara a =C3=A9crit :
> On Tue,  5 Aug 2025 19:48:23 +0200
> Paul Kocialkowski <paulk@sys-base.io> wrote:
>=20
> Hi,
>=20
> > From: Paul Kocialkowski <contact@paulk.fr>
> >=20
> > The V3/S3 has extra pins for UART1 on PG pins, which are not present
> > on the V3s. Add support for them and make them the default UART1 pins
> > on the V3. Note that PE pins are also available for UART1 but almost
> > never used since they also provide the CSI I2C lines.
>=20
> So the patch itself looks alright, but what is this actually used for?
> This pinmux setting here is really just for the SPL to setup the debug
> UART. Is there any board where UART1 is the supposed debug UART?
> Because if not, we just don't need that here, and if yes, I'd love to
> see the respective defconfig file ;-)

This is the default on the V3 reference design, which uses UART1 on PG pins=
 for
debug and I've seen it in use in all V3/S3 devices I could see, including:
- Olimex S3-OLinuXino
- SL631 action camera
- iT-X3 action camera

The pinecube is the odd one out using UART2 instead. For V3s devices it's a=
 bit
messy and the reference design uses UART2 over PB pins, but the only device=
 we
support (Lichee Pi Zero) uses UART0 on PB pins instead (muxed with TWI1).

So you're right, it's not currently useful for devices in the tree, but I
assumed it could be useful in the future. I also just noticed that there is
already a fallback for sun8i which will direct UART1 to PG pins, on the same
pins that I'm using. So this patch is definitely not necessary then!

I have some work in progress to add support for the devices above, but never
sat down to finish them. I'll definitely submit them eventually!

All the best,

Paul

> Cheers,
> Andre
>=20
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  arch/arm/mach-sunxi/board.c | 4 ++++
> >  include/sunxi_gpio.h        | 1 +
> >  2 files changed, 5 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> > index a1a02b0fae50..d1b27b062d6d 100644
> > --- a/arch/arm/mach-sunxi/board.c
> > +++ b/arch/arm/mach-sunxi/board.c
> > @@ -169,6 +169,10 @@ static int gpio_init(void)
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
> >  	sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
> > +#elif CONFIG_CONS_INDEX =3D=3D 2 && defined(CONFIG_MACH_SUN8I_V3)
> > +	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), SUN8I_V3_GPG_UART1);
> > +	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), SUN8I_V3_GPG_UART1);
> > +	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
> >  #elif CONFIG_CONS_INDEX =3D=3D 3 && defined(CONFIG_MACH_SUN8I_H3)
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);
> > diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
> > index e166b9758f44..7d142f65ea8a 100644
> > --- a/include/sunxi_gpio.h
> > +++ b/include/sunxi_gpio.h
> > @@ -141,6 +141,7 @@ enum sunxi_gpio_number {
> >  #define SUN8I_GPG_SDC1		2
> >  #define SUN8I_GPG_UART1		2
> >  #define SUN5I_GPG_UART1		4
> > +#define SUN8I_V3_GPG_UART1	2
> > =20
> >  #define SUN6I_GPH_PWM		2
> >  #define SUN8I_GPH_PWM		2
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--AmmwbfkrvLD0goOs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmiTjlgACgkQhP3B6o/u
lQzaSw//TzPl4NnflmnkWNaRL2WAM13WCOMSOT9ng37C60nwvR/rwSB0Y7PACQNR
PNXWy+FK351+NxmmdhmkPrlXsGqaRxN9URxgD4eWAxF5gac/T76xGWUojmIe+Kpl
QBBw9oTN7tTLWHh9fYAYscoKXgdMDzlyTDt88GjUmgLfWNI9v6Q0NI98CkATyLO4
rneW/ufiIxG5Ie91OWCy8nAKyKc+qojmHcWmcSks953yWswIx1tGvcD4peBTtwtH
EjdRMlN4db7TxPK0Cm3ADqUDe14VNOeFEHCfjASJ90e6xlpdPRdtSGGJgXBNU7yC
yPIQx7KYYDcqaQ5FztUU2gh5D1xCLr0WLIGVTq82VVEWi2J+XYBfMfZELRm05fLL
JWiPNbNgwL97uJE0WdDpauKMltH7EQdvnEWLxM0lnlqPGnbu20N1TX7JY12gWAGH
5hgu66OTMTnrmX8asuLpgnJedw2GStIr6RhwYa+xRjCA5vwVXOHhTbJv4aCeJV1Y
OqaWWUUfweAEAatdk4jtGtwPPUniFNULwx8LPtVDNno6R5Y5wCbf+LIDdmTloCa0
rcHd5yQw/NIhUBhfzy676a7MNRw9PNXJTdKxTmSR7JlIL21sjgMRLavG4A/mNDz3
PsqVlU3SF6Xx5UcU+ywxwNLfze/qmYabdM9hCC/f3GJBbn6JeG4=
=/rjC
-----END PGP SIGNATURE-----

--AmmwbfkrvLD0goOs--
