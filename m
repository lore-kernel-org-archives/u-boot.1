Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F76C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 18:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFFD82A46;
	Tue,  3 Jun 2025 20:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66F182C87; Tue,  3 Jun 2025 19:40:22 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CAC82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 210DB1F0004D
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:40:18 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 2322EAC3549; Tue,  3 Jun 2025 17:40:17 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 30826AC3544;
 Tue,  3 Jun 2025 17:40:16 +0000 (UTC)
Date: Tue, 3 Jun 2025 19:40:13 +0200
From: Paul Kocialkowski <contact@paulk.fr>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Icenowy Zheng <icenowy@aosc.xyz>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/6] net: sun8i-emac: Add support for active-low leds
 with internal PHY
Message-ID: <aD8zfRmfZP1K3ZFk@collins>
References: <20250601153943.2690123-1-contact@paulk.fr>
 <20250601153943.2690123-7-contact@paulk.fr>
 <20250602014043.42c96b4f@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TIScoYkSaWaRw0xm"
Content-Disposition: inline
In-Reply-To: <20250602014043.42c96b4f@minigeek.lan>
X-Mailman-Approved-At: Tue, 03 Jun 2025 20:38:26 +0200
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


--TIScoYkSaWaRw0xm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Mon 02 Jun 25, 01:40, Andre Przywara a =C3=A9crit :
> On Sun,  1 Jun 2025 17:39:43 +0200
> Paul Kocialkowski <contact@paulk.fr> wrote:
>=20
> Hi,
>=20
> > A device-tree property is already defined to indicate that the internal
> > PHY should be used with active-low leds, which corresponds to a
> > specific bit in the dedicated syscon register.
> >=20
> > Add support for setting this bit when the property is present.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/net/sun8i_emac.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> > index 8433e7db2654..990a184e4b1f 100644
> > --- a/drivers/net/sun8i_emac.c
> > +++ b/drivers/net/sun8i_emac.c
> > @@ -176,6 +176,7 @@ struct sun8i_eth_pdata {
> >  	u32 reset_delays[3];
> >  	int tx_delay_ps;
> >  	int rx_delay_ps;
> > +	bool leds_active_low;
> >  };
> > =20
> >  static int sun8i_mdio_read(struct mii_dev *bus, int addr, int devad, i=
nt reg)
> > @@ -287,7 +288,8 @@ static void sun8i_adjust_link(struct emac_eth_dev *=
priv,
> >  	writel(v, priv->mac_reg + EMAC_CTL0);
> >  }
> > =20
> > -static u32 sun8i_emac_set_syscon_ephy(struct emac_eth_dev *priv, u32 r=
eg)
> > +static u32 sun8i_emac_set_syscon_ephy(struct sun8i_eth_pdata *pdata,
> > +				      struct emac_eth_dev *priv, u32 reg)
> >  {
> >  	if (priv->use_internal_phy) {
> >  		/* H3 based SoC's that has an Internal 100MBit PHY
> > @@ -295,6 +297,10 @@ static u32 sun8i_emac_set_syscon_ephy(struct emac_=
eth_dev *priv, u32 reg)
> >  		*/
> >  		reg &=3D ~H3_EPHY_DEFAULT_MASK;
> >  		reg |=3D  H3_EPHY_DEFAULT_VALUE;
> > +
> > +		if (pdata->leds_active_low)
> > +			reg |=3D H3_EPHY_LED_POL;
>=20
> That might be nitpicking, since it worked before, but I wonder if we
> should either explicitly clear the bit in an else branch, or follow the
> recent Linux change to build the register up from scratch:
> https://lore.kernel.org/linux-sunxi/20250423095222.1517507-1-andre.przywa=
ra@arm.com/

Yeah I found it pretty odd that the implementation insists on read+write in=
stead
of just normally building up the register. I'll do that in the next version.

And indeed with this version there would be a corner case where the bit is =
not
cleared. Even if it's unlikely, it's not good programming.

All the best,

Paul

> Cheers,
> Andre
>=20
> > +
> >  		reg |=3D priv->phyaddr << H3_EPHY_ADDR_SHIFT;
> >  		reg &=3D ~H3_EPHY_SHUTDOWN;
> >  		return reg | H3_EPHY_SELECT;
> > @@ -314,7 +320,7 @@ static int sun8i_emac_set_syscon(struct sun8i_eth_p=
data *pdata,
> > =20
> >  	reg =3D readl(priv->sysctl_reg);
> > =20
> > -	reg =3D sun8i_emac_set_syscon_ephy(priv, reg);
> > +	reg =3D sun8i_emac_set_syscon_ephy(pdata, priv, reg);
> > =20
> >  	reg &=3D ~(SC_ETCS_MASK | SC_EPIT);
> >  	if (priv->variant->support_rmii)
> > @@ -859,6 +865,10 @@ static int sun8i_emac_eth_of_to_plat(struct udevic=
e *dev)
> >  		printf("%s: Invalid RX delay value %d\n", __func__,
> >  		       sun8i_pdata->rx_delay_ps);
> > =20
> > +	sun8i_pdata->leds_active_low =3D
> > +		fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
> > +				"allwinner,leds-active-low");
> > +
> >  	if (fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
> >  			    "snps,reset-active-low"))
> >  		reset_flags |=3D GPIOD_ACTIVE_LOW;
>=20

--=20
Paul Kocialkowski,

Free software developer - https://www.paulk.fr/
Independent contractor - sys-base - https://www.sys-base.io/

Contributor to fully free software support for selected hardware.

--TIScoYkSaWaRw0xm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmg/M30ACgkQhP3B6o/u
lQzTqw//et09IA+lc8TlZInrf6g4ZND5tluG5Xe2YP76avNAbEPwFH8amwlDhtt3
mX/ci3CAusdjBQXmnvgL+UwKyVO0Y2CNtNDEYQlTgH9qpMDnU3lHJmdnwGVLF/Xc
v97tqFAIiYdHebcpeHpZkc135lGHhGikeSwNnKIciaxqaa2av6HCvhSJ3SiMPRyd
dcVOx0FIi8K4gRbCZDXiU3/BmQ3mU0ndqMfnMpGaV7KvUQXGe4BUURnwuT7sI1QS
cwkUrtVeGNFZXAxKMWeMTwd5swr8CA83EKY1QQifkF06TzzazRrqZkrebKWjSa8+
CQh8dBLkhcfz2AOJVqPXleP04ZI0YT2Xi5rnEnwe/k57MIrScUceze4LzxmN3J3l
p/8fcoW5d+VR4ervmZTcRyOd/sifUxhw8O06DJhkU6jmrBEcIUUJwLit8w/kugAr
OZa2spqj+bQzujyz3bQl8ps0AocKCinvXti0gT2DTJrnpiA8hDInP8HENLCYssz7
w+Q08kszMxV9/TSl4cKAB2r7uoDUIN8c6RZFsi2sQg0uEgh3pZcH6WAhDYegQ1G6
Wzx1d34opn3VDtzzZNXV8WS3The9TqJ0gNvE9ztRPuzZRPfrX3si1PgPQfo6wX3g
lB8VJ7WRkD8fGcvvUnmEGGEwqaLIgoJ0czaGTnSZMrZD9z6mGAo=
=G5K7
-----END PGP SIGNATURE-----

--TIScoYkSaWaRw0xm--
