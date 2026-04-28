Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02558FF8877
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 17:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32611845C8;
	Tue, 28 Apr 2026 19:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C862845E3; Tue, 28 Apr 2026 19:39:57 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4228432A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 19:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 992D41F8005A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:39:52 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 2FBDDB40475; Tue, 28 Apr 2026 17:39:51 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 37EAFB40471;
 Tue, 28 Apr 2026 17:39:50 +0000 (UTC)
Date: Tue, 28 Apr 2026 19:39:48 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Philippe Simons <simons.philippe@gmail.com>, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: Re: [PATCH v3 2/2] sunxi: H616: dram: drop default TPR6 Kconfig value
Message-ID: <afDw5Mar9Cemsa9s@collins>
References: <20260427135819.2577234-1-andre.przywara@arm.com>
 <20260427135819.2577234-3-andre.przywara@arm.com>
 <afCCmxMrYHnC9An9@collins>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JVSmNFh8U316prLP"
Content-Disposition: inline
In-Reply-To: <afCCmxMrYHnC9An9@collins>
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


--JVSmNFh8U316prLP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

Le Tue 28 Apr 26, 11:49, Paul Kocialkowski a =C3=A9crit :
> Hi Andre,
>=20
> Le Mon 27 Apr 26, 15:58, Andre Przywara a =C3=A9crit :
> > CONFIG_DRAM_SUNXI_TPR6 is the only DRAM config parameter that has a
> > non-zero default value. Since we need to provide a value for all the
> > other parameters anyway, avoiding TPR6 makes no real difference.
> > To make matters worse, TPR6 is a compound value covering multiple DRAM
> > types, but also spans over three SoCs, which makes it hard to find one
> > good default value.
> >=20
> > Drop the default from Kconfig, and put some explicit values in the
> > defconfigs for the few boards that were relying on the default so far.
> > The value is taken from one BSP, only the lower byte matters anyway for
> > those boards, all using DDR3 DRAM.
>=20
> It looks like this change is missing some boards that we support (e.g.
> liontron-h-a133l). Is this intentional?
>=20
> The TPR6 value is still used for all DRAM types, so I think we need to
> define it for all the boards we currently support.

Nevermind this, these other boards already have TPR6 in their config,
lost sight of that. Then this is:

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

Thanks for picking this up!

All the best,

Paul

> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/mach-sunxi/Kconfig         | 1 -
> >  configs/orangepi_zero2_defconfig    | 1 +
> >  configs/transpeed-8k618-t_defconfig | 1 +
> >  configs/x96_mate_defconfig          | 1 +
> >  configs/x96q_defconfig              | 1 +
> >  5 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index 284458ad9a5..18123e685dc 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -151,7 +151,6 @@ config DRAM_SUNXI_TPR3
> > =20
> >  config DRAM_SUNXI_TPR6
> >  	hex "DRAM TPR6 parameter"
> > -	default 0x3300c080
> >  	help
> >  	  TPR6 value from vendor DRAM settings.
> > =20
> > diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_=
defconfig
> > index b387b4795ad..afd1535052d 100644
> > --- a/configs/orangepi_zero2_defconfig
> > +++ b/configs/orangepi_zero2_defconfig
> > @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
> >  CONFIG_DRAM_SUNXI_DX_ODT=3D0x08080808
> >  CONFIG_DRAM_SUNXI_DX_DRI=3D0x0e0e0e0e
> >  CONFIG_DRAM_SUNXI_CA_DRI=3D0x0e0e
> > +CONFIG_DRAM_SUNXI_TPR6=3D0x33808080
> >  CONFIG_DRAM_SUNXI_TPR10=3D0xf83438
> >  CONFIG_MACH_SUN50I_H616=3Dy
> >  CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy
> > diff --git a/configs/transpeed-8k618-t_defconfig b/configs/transpeed-8k=
618-t_defconfig
> > index e4bf5e8efd3..e672d8f8df9 100644
> > --- a/configs/transpeed-8k618-t_defconfig
> > +++ b/configs/transpeed-8k618-t_defconfig
> > @@ -7,6 +7,7 @@ CONFIG_DRAM_SUNXI_DX_ODT=3D0x03030303
> >  CONFIG_DRAM_SUNXI_DX_DRI=3D0x0e0e0e0e
> >  CONFIG_DRAM_SUNXI_CA_DRI=3D0x1f12
> >  CONFIG_DRAM_SUNXI_TPR0=3D0xc0001002
> > +CONFIG_DRAM_SUNXI_TPR6=3D0x33808080
> >  CONFIG_DRAM_SUNXI_TPR10=3D0x2f1107
> >  CONFIG_DRAM_SUNXI_TPR11=3D0xddddcccc
> >  CONFIG_DRAM_SUNXI_TPR12=3D0xeddc7665
> > diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
> > index c0628370df9..1b7d9338c02 100644
> > --- a/configs/x96_mate_defconfig
> > +++ b/configs/x96_mate_defconfig
> > @@ -6,6 +6,7 @@ CONFIG_DRAM_SUNXI_DX_ODT=3D0x03030303
> >  CONFIG_DRAM_SUNXI_DX_DRI=3D0x0e0e0e0e
> >  CONFIG_DRAM_SUNXI_CA_DRI=3D0x1c12
> >  CONFIG_DRAM_SUNXI_TPR0=3D0xc0000c05
> > +CONFIG_DRAM_SUNXI_TPR6=3D0x33808080
> >  CONFIG_DRAM_SUNXI_TPR10=3D0x2f0007
> >  CONFIG_DRAM_SUNXI_TPR11=3D0xffffdddd
> >  CONFIG_DRAM_SUNXI_TPR12=3D0xfedf7557
> > diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
> > index 59f01aae4eb..068aee3fd1e 100644
> > --- a/configs/x96q_defconfig
> > +++ b/configs/x96q_defconfig
> > @@ -8,6 +8,7 @@ CONFIG_DRAM_SUNXI_DX_DRI=3D0x0e0e0e0e
> >  CONFIG_DRAM_SUNXI_CA_DRI=3D0x1f12
> >  CONFIG_DRAM_SUNXI_TPR0=3D0xc0001002
> >  CONFIG_DRAM_SUNXI_TPR2=3D0x00000100
> > +CONFIG_DRAM_SUNXI_TPR6=3D0x33808080
> >  CONFIG_DRAM_SUNXI_TPR10=3D0x002f0107
> >  CONFIG_DRAM_SUNXI_TPR11=3D0xddddcccc
> >  CONFIG_DRAM_SUNXI_TPR12=3D0xeddc7665
> > --=20
> > 2.43.0
> >=20
>=20
> --=20
> Paul Kocialkowski,
>=20
> Independent contractor - sys-base - https://www.sys-base.io/
> Free software developer - https://www.paulk.fr/
>=20
> Expert in multimedia, graphics and embedded hardware support with Linux.



--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--JVSmNFh8U316prLP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnw8OQACgkQhP3B6o/u
lQxKPA/9Ffp2RSL8ZYGC7nijyJQkxuYJxT4YSK89Z9i5UYEHXKYSOO764rYhqznZ
dAp8Us0bcg6EiJUWrBz0bFyaCHU0TqOAWgNrFwujVVuogo8FlWc3kKXDwnOkpBKs
Vyo8/7nhRaIKbprxwTjqpkiZKwVgPBwn9Y9u/e9BfG/phrK+Vaz/Lns8CHm7eGu/
84+YjgAlqflyVOR4RI39WkLg6NLStTxte3GOsAum8/TG33fldPLOW91x8ZDwY8Vv
ugzcsIyYR7TtCJe54zfvskWKmuY9MhuBnP9SE4Vqf4pymBIqOKFPg05nCquPyqZU
zzU75bqnzf7q4Y04y33zT4rKQijaUgyyAU3xwqW0eA8+SKBAKKI713Vg1wiofzSJ
EVZVdB7XNEQuuXGGcUqzr5b12qnvpZPo0k7j8/6oPEhbfU2FNiONw20PyItdxo/t
gSf1WbGZNdVnKDnIaCRNbOsRN47WlCGkcyO7iBEAM2NrsLBIi+Mnr7LThi9l/329
46hPKgbGxB5DJv+nYM3Lh3Rr6j75rvmVE3cOPz3y6HU/Uo3Eca2BbIU+gXxP3cgS
d9udBoxDUZXHFLxzoflwAur6KWC/i0mBk51Zi6vY5FtmWTnVmx2IIQEeRnO4BRcy
BJ/zlRGHK7+5YUUAellYQ8QuCSAgrS37jMSgk0WWj8nePGMY5Ns=
=DXIm
-----END PGP SIGNATURE-----

--JVSmNFh8U316prLP--
