Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24917E69EBD
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 22:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72FFA893DB;
	Tue,  3 Dec 2024 23:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LkFWv3Z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28826895BD; Tue,  3 Dec 2024 23:01:13 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E58A48931C
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 23:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d87f00f786so56038356d6.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 14:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733263270; x=1733868070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fS48inAF5tjGCr0eel7f2UK/q5lKk4SJKeDh29LBnes=;
 b=LkFWv3Z4Yoq0EJyC0c+1uvn/JZ0tk2E/CyMqBpDRpdgjVbfNpHnrX2U8aWbRCBGTyH
 dzGjEbYz2m2sJXWzRT4+SYfXryQjsUeCiHKjjbq1q3I3QwP7TPzfS3j9lZmdhLeWMLZY
 fGg36TNqBwrH7AaT8Q3qF7pq1KNvPYWl54ev0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733263270; x=1733868070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fS48inAF5tjGCr0eel7f2UK/q5lKk4SJKeDh29LBnes=;
 b=OtKt6x3GHPeUHelUSb1LJSapQ8AUkUWahkKjtUdnOuRAYW+Wv6nUYzIhpM4G7t9P1K
 20DkOxslJcd8D2IELS0dTfFD3aSICVKeZgvJej1kK0xCQgLcVzb2dBh3BExd5h/Zsu3J
 v7qAFT0KblAhScoCOWRqqEgbCifk60pVWid8QZysKH2pCEO58KpsI+f5DF6N4qVlqmqw
 DgMpTOu4gGCT5e95GzwPNKLG3qCy2A6d5GHgo2mFKDd8hP8XWPeSrn7+exQ8YcjAX9oc
 wVUX7xrCh+HU2pW4z77pZcjb3fwZTFmYkHC9YYL5PAUMCKQE149GjuVHdM5rTVW6CTAf
 Eb0g==
X-Gm-Message-State: AOJu0YwidwFPzdFg36jEz8JR+0z8nDqViskdVHYLFkglT+jcife0E40I
 mNZHoHfNlnaTo4LWc8C6Rxr8Tqj+ZAqK1UPgbcWAB1x/G8oAV4sdST7QoznsZfg=
X-Gm-Gg: ASbGncusY/cRIEbxM+krwyR8cQGZbArj8qgJRMu5CuLtudqfhyfnxS+lHLjLcSMBtDV
 MXqNopvBtkgz0ZEQ3kYSevXf8WzK9bRErQTD0SQBtu6turZxxg0BopojQu4LMtF2Wr0RKaE1dI8
 gukYAAUMIwRK9KEWEqOgk3XksZd735tojpUxbjMl+JPXDiZZWr1t3zWjwMTIu9/R5cqWwclE0sI
 YxIWT6WhWHwH+ZEPXPpVjyYCPsFQF6hdnJspBrr5376UeTNGQ==
X-Google-Smtp-Source: AGHT+IEpQrzIdqIBgkOE7wo9wEd6e+KB7wvBupTt4GajrwajDERxZP/WDn4gM4HeGMYLq9iTRehY5w==
X-Received: by 2002:a05:6214:c82:b0:6cb:d4e6:2507 with SMTP id
 6a1803df08f44-6d8b738ae51mr65766696d6.22.1733263269154; 
 Tue, 03 Dec 2024 14:01:09 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849b7215sm549606785a.106.2024.12.03.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 14:01:08 -0800 (PST)
Date: Tue, 3 Dec 2024 16:01:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Rufus Segar <rufus.segar@carallon.com>
Cc: u-boot@lists.denx.de, Mario Six <mario.six@gdsys.cc>,
 Phil Edworthy <PHIL.EDWORTHY@renesas.com>
Subject: Re: [PATCH] Revert "net: phy: marvell 88e151x: Fix handling of bare
 RGMII interface type"
Message-ID: <20241203220105.GB2457179@bill-the-cat>
References: <7b204be7-53e8-401d-bed3-f47a3e23bd1d@carallon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="51qnjqyBejZjLNAe"
Content-Disposition: inline
In-Reply-To: <7b204be7-53e8-401d-bed3-f47a3e23bd1d@carallon.com>
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


--51qnjqyBejZjLNAe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 02:45:36PM +0000, Rufus Segar wrote:

> From 2f97d889cecfa2ba06652469765f31c70a68e867 Mon Sep 17 00:00:00 2001
> From: Rufus Segar <rufuss@carallon.com>
> Date: Tue, 3 Dec 2024 14:35:10 +0000
> Subject: [PATCH] Revert "net: phy: marvell 88e151x: Fix handling of bare =
RGMII interface type"
>=20
> This reverts commit 431be621c6cbc72efd1d45fa36686a682cbb470a.
>=20
> This change is erroneous, the RX/TX delay should only be added when in
> RGMII-ID mode. RGMII mode should have no RX/TX delay.
> ---
>  drivers/net/phy/marvell.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index b0a0b7fcb3..08608a99b9 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -461,9 +461,7 @@ static int m88e151x_config(struct phy_device *phydev)
> =20
>  		reg =3D phy_read(phydev, MDIO_DEVAD_NONE, MIIM_88E151x_PHY_MSCR);
>  		reg &=3D ~MIIM_88E151x_RGMII_RXTX_DELAY;
> -		if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII ||
> -		    phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID)
> +		if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID)
>  			reg |=3D MIIM_88E151x_RGMII_RXTX_DELAY;
>  		else if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_RXID)
>  			reg |=3D MIIM_88E151x_RGMII_RX_DELAY;

Please provide more details and ideally links to relevant documentation
as to why a 6 year old commit that itself says it's fixing a use case is
wrong, thanks.

--=20
Tom

--51qnjqyBejZjLNAe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPf5YACgkQFHw5/5Y0
tyztrwwAprP9D0ltJrpUGQ7016gypMytGTaaH0r9ehjRqNp5Jj1ELyO6X/a3uLfv
UF8WnlPWWsSpPvdXQFX3EVwXLxwMoEISseKmxk9Tye4Gh/xYMUjOtMZtzVo9dlUn
C8+bXter1+bq+eiSyF9oDveHrnZsAHgzmcrYdZrn51Q4OqlaFG3zjJWv3rPnNXAX
VPqmYLtDD9mMXhz2QKXUnUxlsBIDnhKBfB5Zki28zIXA3y0N8+DivVpAnS6oVeYx
qwFvQSrzkMSbrIlL+mwOIPR8VreL1D36EnK78+lwevw3YzHWIm68bNBU+gagXyyj
0xnf1Yn/8MwsEz5Y/APQgJAOJVXZhYznFjCnosBGDswq7Ia0fAfOtlvuF/BEqRSQ
UkJ3A5ORGLjBHQi/Ep72IdSyViuMrxN22OqQiR82fbzATa2m9lo+Airm+JROHqqB
a7xkyyLmVTBMqaxJ9Euh3kLNhgwhyyLJ1hrTJdm3oNZjWdOTOrdk78bzXrTqNDjT
4aqSpmwh
=yF6B
-----END PGP SIGNATURE-----

--51qnjqyBejZjLNAe--
