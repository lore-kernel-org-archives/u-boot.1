Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C94E87834
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED8C842E1;
	Tue,  3 Feb 2026 15:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZnsB6D2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE8648453A; Tue,  3 Feb 2026 15:58:04 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4E88405A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45e934bb51dso2157739b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 06:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770130681; x=1770735481; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OvoLL4w5kNiV6He/PHrxATAf9/PrvH1asHVTqarZR1E=;
 b=ZnsB6D2uZ9ZRICviIJ2CpmlGhWx2lUX6YWEJg3kPCYSoJBGM5QATOFAm68iNyTuB2i
 nVe0Jp9w3MkRB+NQ06FBdGsCgAZnWbVJV86s9te8HI4nf/ydzJvSFrjTtqGG2unzzYjz
 4UdE2VPen4kh/AnAIPxOLvK1gcsGcpD9aNu4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770130681; x=1770735481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvoLL4w5kNiV6He/PHrxATAf9/PrvH1asHVTqarZR1E=;
 b=naw1U3prksD2AvMqzBfyThzhvKMgRm2FSn40R93Por5sWEE3PH1IG5WkbNUf1l5WU7
 hwtg4fFYl0osOFtYgG8sOYyMluEDUQpsXRBvip6Hv+UrWkVj53WMZT1Ys/Arh+RdabSH
 0stFP/MI01kh23JGNji2aO68m9tXMoxGpWdYzffDygKnJUZ7h/C64qZJZWqCO3XV0bKK
 BHggrpjx3O57Rz3PktLhTE+Ul37wgnr6dtjjRuqnupeWkIqqMarj0YzUiU+FE0LIy7oq
 DHhq8ZQ521009FAa46eNb1xEEvFHNgDMkhTjb0kp/csKllODrj+EVRlcKMSN1hnfqPKF
 OaBw==
X-Gm-Message-State: AOJu0YyfMC9dnChF8c0CNqD1krftT3VxEiAv11JlY5/iwkH1K+HOB8bY
 /z2yHxgd0V8LaHXjZAXIXmEnXG/AonQwJAji7FYC5f3AbNTPgEaUIN9WEs94o5+iaHg=
X-Gm-Gg: AZuq6aJAVWohZPakD2dyVThgplvI7Yd8m4jTfihZADszMySPZSSHSbIFZrqkckDswBs
 UcHUqyll9MAk9F6v0qWw8n1ClXS12Ejrv66uwQQGRQ2XanCZo5jIlFXK8UG5CW2mUFfvIF1CI5E
 CZXaiehIgpzG9XKC1r8MVSE+FSAsEpM5Xf658G9hBugG56OZLcDFWUBBhkADtFL1AyCUxBp1zTW
 MzzbCimI5IupXOJo4OsEY1K0Vf7WTBw1qKhxZ+rZJrcG98ROrC0aCpt1zDowezRlZao3J6sN34Z
 kY34AUjBj+2nGaOxAQ/ownUkPWOARgDBlocZoJoBVllhsko6CKPeWkMytScG3ZLmLZNJeKPkYG8
 DGxt27ZcB9ZdoYdXHRkmvkYyzYcmjPKhqjO2U5UfyA53SpX2KMqWhQVoGN6thT5KPKNHgJgbJsd
 cgk8c2JAOWPLrkIKYZz5vn8IiG++ItLMsb31/l435vN93U7KRkXdUK+M+TvsMZFjRjcsHMMamTZ
 pF7a7A5MS4jjTySEUpUANJ33ZaGPJaufrIPXzrP0sdHb7AHYw==
X-Received: by 2002:a05:6808:150d:b0:45c:7b2c:10bb with SMTP id
 5614622812f47-45f34d8b8d6mr6296230b6e.60.1770130681274; 
 Tue, 03 Feb 2026 06:58:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08ddf70csm11213518b6e.6.2026.02.03.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:58:00 -0800 (PST)
Date: Tue, 3 Feb 2026 08:57:58 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH v2 3/5] mtd: nand: wire SPL NAND MTD loader into SPL build
Message-ID: <20260203145758.GJ2603314@bill-the-cat>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-4-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y8fP/KS3OFfsYmbe"
Content-Disposition: inline
In-Reply-To: <20260203074721.25520-4-dinesh.maniyam@altera.com>
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


--Y8fP/KS3OFfsYmbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 03:47:19PM +0800, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Wire the generic SPL NAND MTD loader into the NAND SPL build when
> SPL_NAND_USE_NAND_FRAMEWORK is enabled.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/mtd/nand/raw/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 76546a6287b..51a3b9a2aee 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -12,6 +12,7 @@ endif
>  obj-$(CONFIG_SPL_NAND_AM33XX_BCH) +=3D am335x_spl_bch.o
>  obj-$(CONFIG_SPL_NAND_CADENCE) +=3D cadence_spl.o
>  obj-$(CONFIG_SPL_NAND_DENALI) +=3D denali_spl.o
> +obj-$(CONFIG_SPL_NAND_USE_NAND_FRAMEWORK) +=3D spl_nand_mtd.o
>  obj-$(CONFIG_SPL_NAND_SIMPLE) +=3D nand_spl_simple.o
>  obj-$(CONFIG_SPL_NAND_LOAD) +=3D nand_spl_load.o
>  obj-$(CONFIG_SPL_NAND_ECC) +=3D nand_ecc.o

This should be in the previous patch.

--=20
Tom

--Y8fP/KS3OFfsYmbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIM9gAKCRAr4qD1Cr/k
CmftAQCocHcmADVT73HmwgC918TBBokFmCTA7a70P6uY1O0AcgEAg7VN2tIiLNZn
jGv0Pl7Wg9iLEwZdKYaS4ASX0y0JZwk=
=/251
-----END PGP SIGNATURE-----

--Y8fP/KS3OFfsYmbe--
