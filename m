Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F1C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F4780BA9;
	Mon, 10 Feb 2025 16:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N44xRhpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C9480BA9; Mon, 10 Feb 2025 16:53:00 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4C380548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f47ed1f40dso34478617b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739202775; x=1739807575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TNUBtkA0SV4XskpjMInS7Upc5yBq5OzZ1wafX67DWwA=;
 b=N44xRhpHjvP0rePwBrHnBqStfvTlU4cQPFm4eqiy9pGA51IHRt90GBH+UT4VfRJKYN
 6EQc6ZeRJRjDyMjJE3KNFNP7QvvBYPgIdBFFTwbIHt4rfN2EsZ2De7oQOHNOyOTasph1
 TH1BktEjO9YWq+QTp+1wI84gaka/dQjELHdzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202775; x=1739807575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNUBtkA0SV4XskpjMInS7Upc5yBq5OzZ1wafX67DWwA=;
 b=tlkkQ8f/6uq34YH7l5wHjyeI1auQKfBYle6zhriPC4oSp+DaxlS3bgSA1/9fh2SFRN
 FyT6hRIojxDzu0j0aPZBgZDgSux9vhaVJQlXm9vRHCV6zMPZGsOo60MvYOcJsB0lj8Ki
 3nnvSnT7oIS/h1AVFf2Jcs8Poy5G8Egkn/8FQp0bsFuAlkcIO5GRM3xUIyYkuG+S0aSI
 CBOU+WVk2kOPxKwWiXO3L7Lp5NxtnZQUxHXaM0THjQIWPZY/DXUJOvJIfUtjop++DALJ
 2kvPA2XsWo0pVHbSgOQyEz8Sj3GtWxHvtNQojsbtJ2GcL7NoisfqOzOD7sF6dAd36UgW
 pr9A==
X-Gm-Message-State: AOJu0YwnwUT6LfboPr5Td9X5/U/PJ81h4GCr+Ivzhej0bSkf09ErOaVF
 kQTOc7PWwbRrfYSh/TYWUZHA/A3oAaxhhj1oJqAhqjinhASziSAJ50pUqGg5RBU=
X-Gm-Gg: ASbGncsYTAyQosxyWfqX5CdBPkM3NhQeziKm2grl6k/DkbED0/aoUmAl0HGB7ZNBREU
 yerg4X0rcnbyDr9rJGlIaN9YgNf4xyqipO4BD+Ucu6LfmL7PR4H/co1k1+Az/kLnYNKRPtNq3i2
 oAvOJin38hgzdqH6qh6kP7DUeCrNpQUTcMxMef7S5askvD56Wtj6QvlodRWxoHM6pJKuHGiLD6v
 lv4TwG+i/1UKgALxLvaerAHA9phK/d3FzvcVa7eckcdW2T5akgUC01tj0tqNeB401jgA54UyYeb
 B8d9JIAkJPBVinY=
X-Google-Smtp-Source: AGHT+IG6qolnkLT7GeP1qwIAJjq+uLcYGRwlGoWcGKcKSryybC+T47OveayI+xZ1Co9wuzYKSdAeFQ==
X-Received: by 2002:a05:690c:6911:b0:6f6:c924:befa with SMTP id
 00721157ae682-6f9b284bc78mr121106777b3.14.1739202775183; 
 Mon, 10 Feb 2025 07:52:55 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fcefe5bsm17076817b3.21.2025.02.10.07.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:52:54 -0800 (PST)
Date: Mon, 10 Feb 2025 09:52:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 5/6] test/py: Show info about module-loading
Message-ID: <20250210155252.GL1233568@bill-the-cat>
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oj0YcxJnk93LjWdg"
Content-Disposition: inline
In-Reply-To: <20250209160725.1054845-6-sjg@chromium.org>
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


--Oj0YcxJnk93LjWdg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 09:07:18AM -0700, Simon Glass wrote:

> It is sometimes tricky to figure out what modules test.py is loading
> when it starts up. The result can be a silent failure with no clue as to
> what when wrong.
>=20
> Add a section which lists the modules loaded as well as those not
> found.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  test/py/conftest.py | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>=20
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 8d0e786ee5c..e59897c1f78 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -289,19 +289,26 @@ def pytest_configure(config):
>      ubconfig =3D ArbitraryAttributeContainer()
>      ubconfig.brd =3D dict()
>      ubconfig.env =3D dict()
> -
> -    modules =3D [
> -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> -            board_identity_filename),
> -    ]
> -    for (dict_to_fill, module_name) in modules:
> -        try:
> -            module =3D __import__(module_name)
> -        except ImportError:
> -            continue
> -        dict_to_fill.update(module.__dict__)
> +    not_found =3D []
> +
> +    with log.section('Loading lab modules', 'load_modules'):
> +        modules =3D [
> +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_=
' +
> +                board_identity_filename),
> +        ]
> +        for (dict_to_fill, module_name) in modules:
> +            try:
> +                module =3D __import__(module_name)
> +            except ImportError:
> +                not_found.append(module_name)
> +                continue
> +            dict_to_fill.update(module.__dict__)
> +            log.info(f"Loaded {module}")
> +
> +        if not_found:
> +            log.warning(f"Failed to find modules: {' '.join(not_found)}")

Since no platform contains all of those files this is too verbose.

--=20
Tom

--Oj0YcxJnk93LjWdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqINQACgkQFHw5/5Y0
tyzKxAv9FvkzvfUTDAkWxzgnnRapB1lQkRwP9rc/d7GZPfySczkw74kOWCd6rT95
x4DIRb+rBw8sh/tQ8lvEVt2ICgkNSSCUTTsL11X4FTV1HNIU1Fb7AWzlbyUBjcpZ
iLC0yoChvG7uPoDYW1GmTDGeXHm92/4JNz9BcEyU7bEeHDpGVA6OJmaHEqTfHAn7
yn95AM7VZ6PXPuijwTLRi7rQcTDeLNPJhA6uocsiQ5u3C76J6qH150LxkIEj1maR
vjkFd1qCFEXa3Cuj7sTW8oXiJuBUFSCNCWy8tJLB6X1LensYk3/aY2UddOI8dpVC
3zvhc29qnp5tsI1LSAQFSZGioIvzuE6EhARt89Pr1h36LDj4/NemUUDC/CF/g8Hl
xEiPoCc02GGOGZjpsDcwjHfGogiEUwQs+saYaL+B3iXVRfi8N6BPzoWiovyg/G+R
+mvBudWIi00j2rK9ly4mbDaioq2WtUjUTFD/PKQEqCrP/ItROxFmkDvkNB7m727i
koJHUtDM
=86nW
-----END PGP SIGNATURE-----

--Oj0YcxJnk93LjWdg--
