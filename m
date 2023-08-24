Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB3C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6147863EE;
	Thu, 24 Aug 2023 20:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jyWjviE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6668640E; Thu, 24 Aug 2023 20:24:37 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3128056D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d748d8cf074so1680919276.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692901473; x=1693506273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RfODuMdTIAfntmqFPdAUAOK4OSqVi+A+aKhPccTHq+Y=;
 b=jyWjviE5A/ilq+lviloSfhYByhnDGGXArPtFqIZ8bCDUB8/vJbMIYO3iRpG8rc7Coo
 GpWR6dyltNkhrbCyUqRnVdJhzBqPbQ8ug385Den88DkkVpH06KBvUJNUMtwiDimoM0kh
 zFmavRlZAxYWmuZ3N8fPRBilTMVz52hAlAVCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692901473; x=1693506273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfODuMdTIAfntmqFPdAUAOK4OSqVi+A+aKhPccTHq+Y=;
 b=MDkHCb1XvJhHC+ijWOQgMzPmwMMhDs5vYT+ngCztRyyV0zhTQQonycfWYW53w2eVSE
 faG2UGrvpAhavbgzMBfsdaRddnccp+/wEFd7Md3irsIQBhh9yHMXAtymZ9mwHv3ah3TR
 DKHFPXDVpSlYw5AfMbOjfeu/ZM+w5+XaaRNOFo/V8zzFXNY9d0tASQT+4PP6OEG8xZJd
 gWW3S6+MB5V1EwQamtQWRioJ25J/LG6oY2ZqOz6t6KRaBjCJqVg0Flp6vdVto0z83bzW
 n+hkXqGOGY8ZFkXFVTOImKPMo+3QJnoYRXtjVdLwwmJC7by0U2uQXu2jjH4OdM+5wrxT
 OIDQ==
X-Gm-Message-State: AOJu0YxBfy9uYo6L+GlvuRuvPoGH6u3C6unY/fyX2aI0F6ExMNkF22yA
 poMd4fGuZEcMJ+xAspvBEpDwQg==
X-Google-Smtp-Source: AGHT+IHWsK6OADc6X5gTtXGmBMZP1xSDGVsMO443G1IUvs+EemsIa45vDCVM28qrbH9G/zZoSeHoRA==
X-Received: by 2002:a25:50c5:0:b0:d78:20f8:9948 with SMTP id
 e188-20020a2550c5000000b00d7820f89948mr1115987ybb.0.1692901473437; 
 Thu, 24 Aug 2023 11:24:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a25d113000000b00d7745e2bb19sm1830769ybg.29.2023.08.24.11.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:24:33 -0700 (PDT)
Date: Thu, 24 Aug 2023 14:24:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>, nm@ti.com, joe.hershberger@ni.com,
 robertcnelson@gmail.com, jkridner@beagleboard.org,
 r-gunasekaran@ti.com, srk@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
Message-ID: <20230824182431.GE3953269@bill-the-cat>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s4sGcMaTOnAZvEcJ"
Content-Disposition: inline
In-Reply-To: <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
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


--s4sGcMaTOnAZvEcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 11:34:29PM +0530, Siddharth Vadapalli wrote:
> Hello Roger,
>=20
> On 22-08-2023 17:43, Roger Quadros wrote:
> > Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
> > PHY in the sense that it is non responsive over MDIO immediately
> > after power-up/reset.
> >=20
> > We need to either try multiple times or wait sufficiently long enough
> > (couple of 10s of ms?) before the PHY begins to respond correctly.
> >=20
> > One theory is that the PHY is configured to operate on MDIO address 0
> > which it treats as a special broadcast address.
> >=20
> > Datasheet states:
> > "PHYAD (config pins) sets the PHY address for the device.
> > The RTL8211F(I)/RTL8211FD(I) supports PHY addresses from 0x01 to 0x07.
> > Note 1: An MDIO command with PHY address=3D0 is a broadcast from the MA=
C;
> > each PHY device should respond."
> >=20
> > This issue is not seen with the other PHY (different make) on the board
> > which is configured for address 0x1.
> >=20
> > As a woraround we try to probe the PHY multiple times instead of giving
> > up on the first attempt.
> >=20
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  drivers/net/ti/am65-cpsw-nuss.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw=
-nuss.c
> > index 51a8167d14..4f8a2f9b93 100644
> > --- a/drivers/net/ti/am65-cpsw-nuss.c
> > +++ b/drivers/net/ti/am65-cpsw-nuss.c
> > @@ -27,6 +27,7 @@
> >  #include <syscon.h>
> >  #include <linux/bitops.h>
> >  #include <linux/soc/ti/ti-udma.h>
> > +#include <linux/delay.h>
> > =20
> >  #include "cpsw_mdio.h"
> > =20
> > @@ -678,14 +679,22 @@ static int am65_cpsw_phy_init(struct udevice *dev)
> >  	struct am65_cpsw_priv *priv =3D dev_get_priv(dev);
> >  	struct am65_cpsw_common *cpsw_common =3D priv->cpsw_common;
> >  	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > -	struct phy_device *phydev;
> >  	u32 supported =3D PHY_GBIT_FEATURES;
> > +	struct phy_device *phydev;
> > +	int tries;
> >  	int ret;
> > =20
> > -	phydev =3D phy_connect(cpsw_common->bus,
> > -			     priv->phy_addr,
> > -			     priv->dev,
> > -			     pdata->phy_interface);
> > +	/* Some boards (e.g. beagleplay) don't work on first go */
> > +	for (tries =3D 1; tries <=3D 5; tries++) {
> > +		phydev =3D phy_connect(cpsw_common->bus,
> > +				     priv->phy_addr,
> > +				     priv->dev,
> > +				     pdata->phy_interface);
> > +		if (phydev)
> > +			break;
> > +
> > +		mdelay(10);
> > +	}
>=20
> After rethinking about the above implementation and the second patch of
> this series, the second patch could be dropped altogether if the
> following implementation is acceptable:
>=20
> phydev =3D phy_connect(cpsw_common->bus,
> 		     priv->phy_addr,
> 		     priv->dev,
> 		     pdata->phy_interface);
>=20
> if (!phydev) {
> 	/* Some boards (e.g. beagleplay) don't work on first go */
> 	mdelay(50);
> 	phydev =3D phy_connect(cpsw_common->bus,
> 			     priv->phy_addr,
> 			     priv->dev,
> 			     pdata->phy_interface);
> }
>=20
> if (!phydev) {
> 	dev_err(dev, "phy_connect() failed\n");
> ...
>=20
> With this, there would be at most one "PHY not found" print, which
> should be fine. The mdelay value of 50 could be replaced with a
> sufficiently large value which guarantees success for Beagleplay.

Ramon, thoughts?

--=20
Tom

--s4sGcMaTOnAZvEcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnoFgACgkQFHw5/5Y0
tyxaiQwAgN4V+LZ/uHxwWL8whjTcvNoJ2+lLDeBmUDiBHXNK5RVrnnD5OJcKfInv
bc4LsyUVdF/uubTWxRG+UzTEQt6sIf0KJYj+Bkst2Mj1YUhMtXDjrMwP3ujm5QsF
YYEdzZjrHbAAgK9MeWxmGay7kTDgg2FuY48JvMWW4iIxUVouGFZ0c1XjKtKWG9ca
Hkp8glb48HlvFQG+updq7/MzF/wGt3hID8tnvRh+Buqs3XmxamzipcIEpk659Ywj
6fw28cJOdaexoRMbwZoL54N9r57iqNz9AExetjEtIT8Wpe0PrG/vKI5XIQP8/lQW
qIXqk7kQe7m4Kknl0Kt5DIbozy0i+Dm9B/lv1SHq8z9J26ALs1L4uYcdX/590sEh
LvqqT4dCqUHGDACzFQlEb5q4k1kfy/W+wZgeHROgMh8NCWkb6CPK6Kk2J9FVsL96
YBEsaW5vBNTKn7XZ9UoziUZTeZOhzaSfMI0vT6iWt89Mpr7+e9EycbGqNbT306M8
Vzr+vlJn
=mvVe
-----END PGP SIGNATURE-----

--s4sGcMaTOnAZvEcJ--
