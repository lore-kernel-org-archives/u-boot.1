Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D958C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 15:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FA286FBD;
	Wed, 22 Nov 2023 16:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700667529;
	bh=dKd4FqO3Vz2C6v3Iw1VrVQHo/jrw6JNV8wCl2j3XbwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q/l+Y0hTbuYrD8iBz9a/ZHAs5DzhAQJvpMOo0+f+zWlSxTaKX8ZawLKjjASFd1wOw
	 M4f2i+I9U8VtoJXP+xu55SBn7ZQIlJAXMp7NHIIgxCCp9SrMMhwsoSPIQBCw4buGJd
	 k0JAHql+apvt95hUNWhfznxbQYLgjZZEbWlUr4lfPgrUEaJSY3YT7QrGCnOyXWC3eD
	 RII+8jdXul1bR/IC4rUzvqFeawIsRSB5B3kZ60m7syBFLXgzIRVf+E4OaZxUoRuJZJ
	 P4lKDAy7eSeOr7S3DK5l/uqUT5xDmMfD2wzVsbA1+hpc2f/5/7U0cA8NLUAZaOGV8C
	 Hq08OKx2iHSfA==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AC60386C15;
 Wed, 22 Nov 2023 16:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700667527;
 bh=dKd4FqO3Vz2C6v3Iw1VrVQHo/jrw6JNV8wCl2j3XbwU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EHVWYu5QkzJEnwRCMJODgPuojRpRZgV/f7iL3LcjI7avgVOd4THuaL3WctemnUPvw
 0Q0lOZueBSJaz1K125m21w7fltXtin317teRI9IaUKTMahmri7Lcj557DNuzi+b1Ov
 334yQ7fUsnv6rZ/rzG/8y4q40Cpqhno/9dPfWrXqqSB7w0d7EIRuSjba3Wbovmdutr
 UPBiraLINQaOT+3KLFx4QSZny1jER6vdbBvpmQaZPySUxUTYH4/HzxXV3G/ZDePEzC
 Tkhn/y0Nq8MmExvBoMx9O/j8+enLNJyhimtg3HM2ge8cR2phHsa0d9Bwt0vh9cmZQ+
 z8nRsYyn+IeLg==
Date: Wed, 22 Nov 2023 16:38:41 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Marek =?UTF-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 tharvey@gateworks.com, marek.behun@nic.cz
Subject: Re: [PATCH] net: mv88e6xxx: add missing SMI address init
Message-ID: <20231122163841.09d1c6e8@wsk>
In-Reply-To: <4t2ccomf4epfozf2o5uzkp7c5lzzqhgkfpcfofojomssmzh5kw@76ljhmdjzla4>
References: <4t2ccomf4epfozf2o5uzkp7c5lzzqhgkfpcfofojomssmzh5kw@76ljhmdjzla4>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6tfvD2EdK_0iMMF8i+KG=O=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/6tfvD2EdK_0iMMF8i+KG=O=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marek,

> Driver does not currently initialize the smi_addr field, but instead
> keeps the default value. This leads to issues on systems with
> different hardware configuration. We can fix this problem by reading
> the SMI address from device tree.
>=20
> Signed-off-by: Marek Moj=C3=ADk <marek.mojik@nic.cz>
> ---
>  drivers/net/mv88e6xxx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> index c073f81e72..4636dbf156 100644
> --- a/drivers/net/mv88e6xxx.c
> +++ b/drivers/net/mv88e6xxx.c
> @@ -753,6 +753,12 @@ static int mv88e6xxx_probe(struct udevice *dev)
>  		return -ENODEV;
>  	}
> =20
> +	priv->smi_addr =3D dev_read_addr(dev);
> +	if (priv->smi_addr =3D=3D FDT_ADDR_T_NONE) {
> +		dev_err(dev, "Invalid or missing SMI address\n");
> +		return -EINVAL;
> +	}
> +
>  	/* probe internal mdio bus */
>  	ret =3D mv88e6xxx_probe_mdio(dev);
>  	if (ret)

I've posted some time ago patches for this driver:

https://patchwork.ozlabs.org/project/uboot/cover/20230601100005.2216345-1-l=
ukma@denx.de/

Unfortunately, those were not pulled...

Maybe you would find fix for your issue, or prepare new version of it?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6tfvD2EdK_0iMMF8i+KG=O=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmVeIIEACgkQAR8vZIA0
zr1BRAgAzNLArem/TYa1flfwrcoBw21dUgVkH9AC0M28GJx9miWWdu4Ajw3pw1KY
k8gBdju6oRiTl3/OpdjnM5w0GdebaHRBsfWH/fFXe1lUK1uI6K1kQbXWoAKLg9Qi
9otlHij2RLjRc+qTvYG9zLZGbBs4toU6mA3WSOafdSQcrZ3Y6X3Bm2r95dymhtXM
iQUbX7xD0orqYd4CmaH4/D6FF+p1WTDzL0D7E0R3R12/RtgA1VKeo8rdanuizIy8
H8QkrqUuoWonGIfb5/OCrG4rDRn5YIS3ykmabrpAoeAtBC/PW0YZ7WdYOifeFilQ
bOzgnAFBf6GgBM1gw1tP1izpLZn2hg==
=+nxO
-----END PGP SIGNATURE-----

--Sig_/6tfvD2EdK_0iMMF8i+KG=O=--
