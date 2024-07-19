Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98CDC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 19:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BFC88BFD;
	Fri, 19 Jul 2024 21:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oZ3gnbbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC1688C00; Fri, 19 Jul 2024 21:14:59 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308B988BC7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 21:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d93147ac6bso1260928b6e.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721416496; x=1722021296; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WlHU22krZ/nSmhnZ6Ryb36e1MoSMuaFgXkn44sGhb/w=;
 b=oZ3gnbbb95mVO6gxL2dYttdysQ24JlWp6fKADgaDTErnICi682Efcu/A/9TmieVyHK
 XWD/xOM0KFnQqj5kEBqqDwLCMpOmsbk0nwo846oN/VZleSRG7s0HTPPWHave2KZLK355
 FStsbTc7pHkhbQYZ5VXbxsf+8tfXNFofIkhTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721416496; x=1722021296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlHU22krZ/nSmhnZ6Ryb36e1MoSMuaFgXkn44sGhb/w=;
 b=OYkytFkQRwC+UeJXBY9imOwgvmdhJAyR97HveCMRtJ4f41vzrNMg1x6cxjStZ9nYBg
 r3T6+OKL6RtE9slaTX1Fg7Gcs4Kl72q4sw9Mp9vPZG4/lBtaHKiXjvx9A7ZbdGw6BJEw
 rSogyqE5Guwh+doWZ4E4S86V0dK18ZX/LO2WsA7iQEKWqZCrJv+UtYVTVDzrS5+C0uGf
 Q0P3EmIg6ro/MxPD558IsDW+EtVtgWIbwDuRcBVsBAa0p1iPt+mOtuyASxO6v4KyWc1p
 cIgBIioy4JPk53jLz0QHytNuzR2B/Z5gzV9UI7EY+azkXQRqmsRjmzEJFug0FvZuhWYd
 OAVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYlhbJ4PhsAJ9AhjZG2zA1FLpL5pSzzGX834/7bJiIrIi1TfCUMtjyG0iEZLby69TknU4WKWeitFtCD9fd/pc7/Bxo2g==
X-Gm-Message-State: AOJu0Yz40bOytii2aJ/X5KtzLNIeumEC1qY8IrVSK20PYxQU7RUVewVM
 s7odKQe48tNWqX/wJHlHsQ6Jy7X+TaeSjFoN/G4ZaxU7D1uviGI7OnrQjxefSTA=
X-Google-Smtp-Source: AGHT+IEvhN5CJ/GxkHE/WDhBwNEpifHMtnrrQbrLeruEd8r9L5axtncdpmjqMLRbXxVgCR+29ep+6A==
X-Received: by 2002:a05:6808:1892:b0:3d9:3337:d38a with SMTP id
 5614622812f47-3dad1f1235dmr10083457b6e.3.1721416495807; 
 Fri, 19 Jul 2024 12:14:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae097887esm397971b6e.14.2024.07.19.12.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 12:14:55 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:14:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] env: mmc: Fix env loading with CONFIG_SYS_MMC_ENV_PART
Message-ID: <20240719191452.GD561963@bill-the-cat>
References: <20240719-fix-mmc-env-boot1-v1-1-e32b2037d4d8@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oQ3Xx466RwJPsOcz"
Content-Disposition: inline
In-Reply-To: <20240719-fix-mmc-env-boot1-v1-1-e32b2037d4d8@baylibre.com>
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


--oQ3Xx466RwJPsOcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 05:38:54PM +0200, Mattijs Korpershoek wrote:

> When CONFIG_SYS_MMC_ENV_PART=3D2, the environment is loaded from
> the USER partition (hwpart=3D0) instead of from the
> BOOT1 partition (hwpart=3D2).
>=20
> IS_ENABLED() cannot be used for non-boolean KConfig options.
> Its documentation states:
>=20
> > * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y',
> > * 0 otherwise.
>=20
> So in our case, IS_ENABLED(CONFIG_SYS_MMC_ENV_PART) evaluates to 0.
>=20
> Because of this, the hwpart variable is never assigned and mmc_offset()
> ends up switching back to the USER hwpart (0) instead of BOOT1 (2).
>=20
> Fix it by using #define instead.
>=20
> Tested with:
>=20
>   # have CONFIG_SYS_MMC_ENV_PART=3D2 in defconfig
>   # 1. Erase mmc0boot1
>   =3D> mmc dev 0 2
>   =3D> mmc erase 0 400
>   =3D> mmc read ${loadaddr} 0 400
>   =3D> md ${loadaddr} 4
>   82000000: 00000000 00000000 00000000 00000000  ................
>=20
>   # 2. Restore default environment and save to MMC
>   =3D> env default -a -f
>   =3D> saveenv
>=20
>   # 3. Read back mmc0boot1 and confirm the env is present
>   =3D> mmc read ${loadaddr} 0 400
>   =3D> md ${loadaddr} 4
>   82000000: 13e0632e 72646461 7469665f 3978303d  .c..addr_fit=3D0x9
>=20
> Fixes: 5b4acb0ff79d ("env: mmc: Apply GPT only on eMMC user HW partition")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  env/mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/env/mmc.c b/env/mmc.c
> index 776df0786be5..0338aa6c56ad 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -110,8 +110,9 @@ static inline s64 mmc_offset(struct mmc *mmc, int cop=
y)
>  	int hwpart =3D 0;
>  	int err;
> =20
> -	if (IS_ENABLED(CONFIG_SYS_MMC_ENV_PART))

> -		hwpart =3D mmc_get_env_part(mmc);
> +#if defined(CONFIG_SYS_MMC_ENV_PART)
> +	hwpart =3D mmc_get_env_part(mmc);
> +#endif
> =20
>  #if defined(CONFIG_ENV_MMC_PARTITION)
>  	str =3D CONFIG_ENV_MMC_PARTITION;
>=20

Nice catch. I did a little poking around with:
rg -g Kconfig -U '^config ([A-Z0-9_]+)\n[[:blank:]]+(int|hex)' -o -r \
  '$1' -NI | sort -u > syms

And then
for SYM in `cat syms`;do rg "IS_ENABLED\(CONFIG_${SYM}\)";done

The only other place we use IS_ENABLED like this is a debug print where
a value of zero on the symbol would be invalid usage.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oQ3Xx466RwJPsOcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaauykACgkQFHw5/5Y0
tyxmnwv+KAto3a367PeJJvm4dlvyvJE+kxZyppaGoMEvrfohpBTo1z/86OBe3Fu8
rOxUQjMuewOpI9kSpHPyMmwa8y11uOSwo/vK/DiN8/11w/dIGeM3C5L1YG0Gm6Ja
sPwkCLV1wpKedJIT0S0bhPTbRJE/UDSw4o/DvoJ5uDcmNjpoQdRgw8DOTDiSIQva
qW7Ug1t9sXWnD32ZZYxYtYetMkz+mLhQ0x3kCK98GQZJ8LxhiY9aXPjQVj1WkXh1
K4AGCYl5CCYxEqiGBSszteQ7FrrLGPJp/F+eTxIT23kAV38Mt+NmpUSVt2km5Cq9
J5k4qhI985GjSul8Vq2uoAwdAaTDryi9pJCgwMdj7TadtzpQ1JQLWFa56gCu0h4H
KxgyIsKEF3w+evqB7ti2D+5Smk7Opq+wlZv/gsjbYamdnpFSYxua3i37/6C2XDzw
QuZIVZjZ0nw5jaYBOMNoQ4U0qfCKi9tkclR3OrBWXcfrg5dRhKzHNTitsiHX73oo
pSeeqJNU
=TUNx
-----END PGP SIGNATURE-----

--oQ3Xx466RwJPsOcz--
