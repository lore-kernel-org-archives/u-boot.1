Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51575CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 18:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6F18383A;
	Sat, 30 Aug 2025 20:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JxAfKlVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98F48383A; Sat, 30 Aug 2025 20:45:44 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F6B836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 20:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-435de801abeso1108786b6e.3
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756579541; x=1757184341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmKKmzgiPx7CS1YVtsXNtFueCd7wVZuU+heeDg1+AIc=;
 b=JxAfKlVfkUQcjXa3dBq4je25MA4z/C6BjFsAWA+WpCNt0Sz/VerFDhFbtn0g5wW/13
 OI62C0YKpaZCWrXLywAlaZnzdnFQZly2awbQvqkJpQRuWkFvulY84PC5MXJnTqIi5VI4
 TyjvTZlMIQ3wuJOE4ATwWbXuDRpHTz2XCZ1n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756579541; x=1757184341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmKKmzgiPx7CS1YVtsXNtFueCd7wVZuU+heeDg1+AIc=;
 b=XIUM0vdKhGvCuenkHRZtiyoIf8zXyMRGnC36mknhaAtn3TpWL91Jk4m0vZJtNsKcyI
 iqYhkPdu0I5tycy5v/glZ+fr0dy+GQQ6KilB4z+oNi37wOfWFdq3v1tI/ltrviQQD8xO
 u1SzMVAgmbGdKPjNm+JW9sQnCkIoY3dkXAfn5MLKeyrrlLG5fNum9rLhleT764gawiHt
 kEIdIrsvXJIsTlmMNZPqMmaLkkDLOgOZ9U6iYroB+xSrYxSWzxAQqYZ5hktcGGVcuPGn
 Ba29dje0k3dwmQek1yrXwf6g5wyP+pA9pfSbSK7Lbeg0i4XW0pRASo44pM6JwbAUsBy2
 aB1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPbRzt3OF/gS18NYrt6LS2isC66SR7zIb2+WoDiPho31ToicOq8RKAnl5BPfF63anAXB9m5u4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8HLMrUSevQO2YINpKBx2DiEhPgYPjD7Mf0UHJroq7LnLwmjs9
 sVTOeqmkvLXfZDeLYXf1Gykkf8scEHVqnqre+dY8OopUpFwCJEUwk8CU/hmikmLnfs8=
X-Gm-Gg: ASbGnctBKUwHdJjcF3NX6+Zmi5kP2RegIgPbwqi29PrGrQ+cIdp6VzotrXtfbNM4W1B
 v8pjFmJ2usohkTelWGGLgz45d5gXhRTYyX38Xk5E+SRgcUTlbdMvbBe1E+2SahUliO4zbrdx4sb
 7NYs1W/DPx7VGDCVoAVxDshlgOgGhQNNQLtroVKj69JP7/S/NyeT5NujFK1ZD8o2RPzdkUZ82HM
 TdnU3EDX9vmMdGM9P0F/QH8BSkYdbniUw0uy1F94+NeOTynXW8ra4EoGKmE4XTZU3PzKvxGdLnV
 oNgJrIBh+9Npm1OLoAFzaLegkJack8xoXa9qwYNHcZaZAzdr9puA3gUSZ7xXjHQk0vp4KAV5Tqh
 bBLWApWu+jMX4zWCrnzGPNzw/qedPMHFwvvQsmeSbfZCo/7pT2I1coe18DsPxX2MrJyE=
X-Google-Smtp-Source: AGHT+IGwQLwvawVqTssHNCjsitYBuv325Xg9ZbLg0UmSbs3R4WJViADbOg/A5TkU1d7lH5zwW+QPKw==
X-Received: by 2002:a05:6808:4f10:b0:437:e6f3:35e1 with SMTP id
 5614622812f47-437f7de53ebmr1247167b6e.50.1756579540920; 
 Sat, 30 Aug 2025 11:45:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43800022f45sm19044b6e.18.2025.08.30.11.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Aug 2025 11:45:39 -0700 (PDT)
Date: Sat, 30 Aug 2025 12:45:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] power: regulator: Fix incorrect use of binary and
Message-ID: <20250830184537.GA2585979@bill-the-cat>
References: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pf+jr/EsuXvYPAEq"
Content-Disposition: inline
In-Reply-To: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
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


--Pf+jr/EsuXvYPAEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 12:53:42PM +0100, Andrew Goodbody wrote:

> In regulator_list_autoset there is a test for ret being non-zero and
> error being zero but it uses the binary '&' instead of the logical '&&'
> which could well lead to unexpected results. Correct this to use the
> logical '&&' instead.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/power/regulator/regulator-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
> index 09567eb9dbb..fbd1f69ac72 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -389,7 +389,7 @@ int regulator_list_autoset(const char *list_platname[=
],
>  		ret =3D regulator_autoset_by_name(list_platname[i], &dev);
>  		if (ret !=3D -EMEDIUMTYPE && verbose)
>  			regulator_show(dev, ret);
> -		if (ret & !error)
> +		if (ret && !error)
>  			error =3D ret;
> =20
>  		if (list_devp)
>=20

This leads to the testcase failing:
https://source.denx.de/u-boot/u-boot/-/jobs/1234999#L272
which should be fixed in the same commit.

--=20
Tom

--Pf+jr/EsuXvYPAEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLNGzQAKCRAr4qD1Cr/k
CoLGAQCeylDHyLYyhow6/xISNzuC0DvkIP1WX+B10JhzqaxjVgD/dHDwxSB6JsOD
xfpeuWJmAnZJzJ8VnPHUKoc/cBnfGQ8=
=3BBS
-----END PGP SIGNATURE-----

--Pf+jr/EsuXvYPAEq--
