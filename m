Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A084C19776
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 02:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECD4808A2;
	Thu, 27 Feb 2025 03:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSvPlplF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43BE80FDD; Thu, 27 Feb 2025 03:23:39 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2E680FD8
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46c8474d8daso4156971cf.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740623015; x=1741227815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h4hxIMMVyH7njqW67UfhDeh0ELQ4qvr/ENt+j/m9+QA=;
 b=sSvPlplFKhkK5fxD87z0CT1/Q1mPon/eg4UP+DtbEKIBJtocLknNbaak4cQc0ZCSyO
 OUYUhdkrI/kSeUL56u5h24EFcQ62EvRWN34CUR0/m9kiiZJ1MdgYsC6kX0lnSHDlLhor
 RrpIeukAySmCeQDnHFAAl2yCINoOOE0IAuNc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740623015; x=1741227815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4hxIMMVyH7njqW67UfhDeh0ELQ4qvr/ENt+j/m9+QA=;
 b=GEMyNtPzb6ZVe2V3quabE5lHR+1N+Qx3oa1RESrH/DBitz/DyDM+H2JtVBc/MCwELo
 vsRjpqVIdpqfHlEaizQMvDQBqn2BQVeSEmzG4SC/MnG09X60QI5zOq71bHSNDrsjYKyB
 VHGpgcbZKgRvWNPEgWkAV2lBQEshQ3owKTYfO8reiUC5IsG4HN9s6CfvqhGKQE+8jm8S
 1weJ/gmoEhQHibvvwsBetl7RtC/BulCOAT/SIBApq6QvyWwb2ylJpABLZ4unUfwaLgCf
 KA/VrEqclxWeiwTobJn8N/wfM7TWFxjnLqdoXDoIVJoLh1CyZ1SttjFMuMB4B+vSGc1j
 2mFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhF4P5YlBY5cD03+KGpL4To/3GiyDvicyZMlo5186kqw74np/PXl5mF+EZEWb4qO802zAdrAU=@lists.denx.de
X-Gm-Message-State: AOJu0YxjLXm4a4VVfEtjHzHtowNtD9OHHUlCTjDdKCIbMYyWBN/uFyIH
 fVTdH9UOPun3lqE1PFDVV6yoambV749jX6NGAibN0T4scWzEIWf9ck3Ut7LXJh8=
X-Gm-Gg: ASbGncupcCJHuqAs43ieiZ0BjlgRUQCcJCex/f1DMLP0/kXqhKKBbj9s1iPvZKa5J1K
 S7auRy78Ehm2kuVbXQTs2DIBkvfipNl+Efrh99UGWskrXoZjNQ0dNWNlTQyVZ35ELVhXy9pnDw0
 AGfGzMRxjKEgV4MlK6fPVbUqS2XztazubhFLH6tf6K/tOWmorQsPXMrJ6CL7q7ZA6Vz77LH8Whg
 ehTMYlgsmLCVWlfFJK4J/I427z8TX2PQ46vSBRVqF4hO+QNlBwK8UNP1ODEg2wBp4RA9QM1Hjkn
 aI5I2k35iFj4epxITSVcPMho
X-Google-Smtp-Source: AGHT+IFYTDlnWfvgkPEqt0V5pXELaBFCzehucmg/qPcrcsg5EQhDodP0d92KxbcdyzK5Tx7mC3qgiA==
X-Received: by 2002:a05:622a:1387:b0:472:ebe:a77b with SMTP id
 d75a77b69052e-4722491ec9dmr379964451cf.44.1740623015242; 
 Wed, 26 Feb 2025 18:23:35 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-474617b452asm5023441cf.0.2025.02.26.18.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 18:23:33 -0800 (PST)
Date: Wed, 26 Feb 2025 20:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Kuba =?utf-8?Q?Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Message-ID: <20250227022330.GR2640854@bill-the-cat>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
 <20250226113712.1257061-2-andre.przywara@arm.com>
 <PAXPR04MB8459D3EB1E61A160A2C2D78188CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oh20ZoUFyzEQFChj"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459D3EB1E61A160A2C2D78188CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--Oh20ZoUFyzEQFChj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:31:59AM +0000, Peng Fan wrote:
> Hi Andre,
>=20
> > Subject: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
> >=20
> > On the Allwinner D1/R528/T113-s3 SoCs the MMC clock source
> > selected by mux value 1 is PLL_PERIPH0(1x), not (2x), as in the other
> > SoCs.
> > But we have still the hidden divisor of 2 in the MMC mod clock, so
> > need to explicitly compensate for that on those SoCs.
> >=20
> > This leads to the actually programmed clock rate to be double
> > compared to before, which increases the MMC performance on those
> > SoCs.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Reported-by: Kuba Szczodrzy=C5=84ski <kuba@szczodrzynski.pl>
> > ---
> >  drivers/mmc/sunxi_mmc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> > index 0b56d1405be..8f72d758e46 100644
> > --- a/drivers/mmc/sunxi_mmc.c
> > +++ b/drivers/mmc/sunxi_mmc.c
> > @@ -92,6 +92,13 @@ static int mmc_set_mod_clk(struct
> > sunxi_mmc_priv *priv, unsigned int hz)
> >  		pll =3D CCM_MMC_CTRL_PLL6;
> >  		pll_hz =3D clock_get_pll6();
> >  #endif
> > +		/*
> > +		 * On the D1/R528/T113 mux source 1 refers to
> > PLL_PERIPH0(1x),
> > +		 * like for the older SoCs. However we still have the
> > hidden
> > +		 * divider of 2x, so compensate for that here.
> > +		 */
> > +		if (IS_ENABLED(CONFIG_MACH_SUN8I_R528))
>=20
> Use CONFIG_IS_ENABLED(MACH_SUN8I_R528)?

No, either is fine, IS_ENABLED(CONFIG_FOO) is less confusing for the
case where there's never a CONFIG_xPL_FOO.

--=20
Tom

--Oh20ZoUFyzEQFChj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/zJ4ACgkQFHw5/5Y0
tywKQgv9ElW6dk+H6FdAVcjJyrirV6NHkiIV84sGm+IFlhB+DF1ff0Jw4T9aFNNP
ZkpS8NyZeKmE96c4i+i4301DW58+IOAXqrr3zgt5rh8+2HoVJQdsM1axa/3QkqDV
+bEqTignm+YKnEWXn+BExlEQLM/DJzAh6NYz9jgpCTwFjEyz1umosUsKLWXJBVVS
iLtRWqkcX7U1D4wfYBDLRHZiC9P6gl2dXpNwyGgjQKFLjSNFyzETGKQ83NkB+E4V
6oZzXcpSRTqT0vmOj8JGE3LDr8IEk9CxF6b0/859ebtQJngaRg+0u01y6vOXL5Ac
jpgY3ngpyym6gQ7YBWE/u3QklrsCvuD0dNJDbsYFgAf1rdXBfnl+pXFE9lRsgpHp
+NdqAMficv9kv0kdMaJe90TJZelCS+cRA9rZLciNm14aXESY4g83qdsqIw+qv9HC
wVHcIgWwIP8Zlq9Q+M35YbHi0vgcLqN1NhtmO/9iNGSP75cWlqjbY4nbOsBnyI5n
uucIbKfS
=UTtW
-----END PGP SIGNATURE-----

--Oh20ZoUFyzEQFChj--
