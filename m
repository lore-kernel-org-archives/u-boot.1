Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2193BC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 20:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5296680B9B;
	Tue,  1 Jul 2025 22:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WZwVpu5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B746A81E13; Tue,  1 Jul 2025 22:40:48 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F078006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 22:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6113e68da82so2413902eaf.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751402445; x=1752007245; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/4xaajV1Q98gRMbUTbhXmgzBm/0oNP5cdMdHy4ELm3Y=;
 b=WZwVpu5VNuQ195s1be/QtLUuUPIlyDg88yrC7fYwO7ZYisOhAuOXPpO/aqt6UNM+pI
 rVvRj6yDKtCFewRjh7bLMv2ffDg9YihgOq3XCqC722HxGcSWozlafwYGY13WLtzJgYmE
 eKx9Q1iP4OF+QUmtZD9pJwEEiCV+MyTZfieOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751402445; x=1752007245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4xaajV1Q98gRMbUTbhXmgzBm/0oNP5cdMdHy4ELm3Y=;
 b=WYptu+H2b2uWAZPhfAIWIY4T089ItQMjVd1Oaiig7SlS4/L0jOjDMaIRBUQHDGhcRU
 5U+Az1yrz5XHF70u2uzZ0UeBJhBz2JzCtfulRCWp0+lzEnskOuK4+diUEg/RUCZUzSa/
 XB2EuS78b35v+OpHUwoseMJuWAf8H+a47xOnRa+21i5XSxLx2nf/Mh2NHjKag+4Sqhxh
 vA1aqJ0Hzka9b0R+hRGzKn7CtIFOsurmORxiz026dTUJPC0gXFdKwTxA5WM9ktrwgrxD
 QTKJrT2P7EYzPs7EqLVQcBHWrkkO7OjrleGSZaBC+Xer17t58bG/VfYEEB67nsdCjPZl
 wQtg==
X-Gm-Message-State: AOJu0YzKDY/FwdVbUbwRtiY8OadFiTozQc+nKSR7DTjx0JVt4cHlPMRt
 LJb/D5mahaOwrvPDNm0XReMUrvrDJbQF5Up0TdKFoQbrpZPftCCa51TCuD0E+PY8UFtXkw1GPUk
 opcD7YkM=
X-Gm-Gg: ASbGncsAHKcURwSLexVqV87FxgEs+bH9g5bH+9GnS58vw3DSB/mvB6ok/hDKUWays/0
 RVAWTMrK1lhVYRLBuM2Y8mesWedDC6DnQOL6C2xrZj44tJx0nb1tMQEOK92DOhppWeOESm/z/+q
 XNocHLJsKRe7a4TFOpf+IO6zqg80gadr/DK+SyLJdOLPRejfOgcLfxplXGp/w0vh/Ejs1rPxyeZ
 vxlUSSQGRZ/NcSZ0zblLBx/wkE9eaeIO7e9u0hkOWY+tM0NX/12IcVLjk6+2L9D/OT04znFKDSQ
 mCwPBlTb/IS/+KqlEi+pOCP1bB1eGUAj1xcqAJJ2XGHeIDOIqwN66/yw/iWWSV6cEG5zChmgsgq
 1KZ2hvkPQfPvnXc6tIKeP0+o=
X-Google-Smtp-Source: AGHT+IFN4Qs1Robe77RLwWFZr9oBbeuHON0QPE2e++mOp6TNBVi72Th/1TRfQuOkVbll6PacCJw+xA==
X-Received: by 2002:a05:6820:198d:b0:611:e30a:fa1c with SMTP id
 006d021491bc7-61200f7034bmr169848eaf.1.1751402445147; 
 Tue, 01 Jul 2025 13:40:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b857b915sm1507260eaf.25.2025.07.01.13.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 13:40:44 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:40:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: menu: Do not dereference pointer if pointer is NULL
Message-ID: <20250701204042.GD523899@bill-the-cat>
References: <20250630-scene_menu_fix-v1-1-9ccb9a49c4d8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h212f1wGhSN2kfVw"
Content-Disposition: inline
In-Reply-To: <20250630-scene_menu_fix-v1-1-9ccb9a49c4d8@linaro.org>
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


--h212f1wGhSN2kfVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 05:06:07PM +0100, Andrew Goodbody wrote:

> scene_obj_find can return NULL but this is not checked for before
> the return is dereferenced. Add a NULL check.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  boot/scene_menu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/boot/scene_menu.c b/boot/scene_menu.c
> index 17150af145d..9a6e37d1c64 100644
> --- a/boot/scene_menu.c
> +++ b/boot/scene_menu.c
> @@ -508,7 +508,8 @@ int scene_menu_display(struct scene_obj_menu *menu)
>  		return 0;
> =20
>  	pointer =3D scene_obj_find(scn, menu->pointer_id, SCENEOBJT_TEXT);
> -	pstr =3D expo_get_str(scn->expo, pointer->str_id);
> +	if (pointer)
> +		pstr =3D expo_get_str(scn->expo, pointer->str_id);
> =20
>  	list_for_each_entry(item, &menu->item_head, sibling) {
>  		struct scene_obj_txt *key =3D NULL, *label =3D NULL;

This is in a slightly different place in -next, and I think the whole
function needs to be read and corrected for error handling. I think we
then will need to initialize pstr to NULL as well. Thanks.

--=20
Tom

--h212f1wGhSN2kfVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhkR8cACgkQFHw5/5Y0
tyzwswwAmXlPf7s47iGgCL18lVML1w4xluP03w+K6nY2g6dREBfpPggCOL1/6iwC
Fx/uzB9I/FOYSZbYnEEECMUJTYSIr8vnbBa1tPXvl+cYZXqyJeaxUeUjENKNUw68
Ml7awZkN+ljLvX4Dqoz/OB/eNLSxqzQRAaCvQtdUl7pKyqUowu8iah6J+NUFlzyv
R9KM01ZtR0f8jz3rFDt5MEPPNVirC4LDM50CcgzTl+RH/8zHi6I0Q/vpVdUY0QA0
0XQPRgjhUqXyZM9mXUygpGNbj1ivvEgIXg62HQnhSWud9V7S3CNTg066hT/jCb/h
DvUmn0EPPHixPximmmsWMhZ5nAJm1FVsw1xbbDdex1mLlMNI0FGwIiBJrPZFuJVf
eiMImrxnJw2IKeQOVaPJZL9rk7KxOKep9kxsAOeYK1jI83ZhpZ7kORXOX+urlDiH
kTbizR5f/SO5IouNERM9AiC/nc0ww9yA8I6stEIfp7vEaSeIcqcXROfxOsLWs9AJ
J3lo2RYk
=n/Qf
-----END PGP SIGNATURE-----

--h212f1wGhSN2kfVw--
