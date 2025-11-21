Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D62CFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA01283959;
	Fri, 21 Nov 2025 15:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mReFB1FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0552983966; Fri, 21 Nov 2025 15:39:10 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDC08394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450b5338459so857201b6e.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735946; x=1764340746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HWk7rDEOoChvReBOLBvcBQinutKMzlJ8TCpGXrkV5bA=;
 b=mReFB1FWlrzHn0cISBMIkJluFAFE3RE/3dbpS1bVIUi974d0goQ+Xk1dEnB4/5vv47
 N2We6xKTqUj7bVb9nEtjBMoqWYTqzOC2QcushbFatrnxXbUSjTXqYiWRgAPzjTy5ud1b
 hPVNtz7FA/Uz7zHS8s1he1IdNXvzz0semL1TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735946; x=1764340746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWk7rDEOoChvReBOLBvcBQinutKMzlJ8TCpGXrkV5bA=;
 b=HV0GYWHLH242FclsNpkQy5zMBUBgKm0B6c5r0BPehkWpFCtx+VZ0fPMMdzFXO1e9ae
 7713HBt2b6OW+/sviysblbm22En4nPT4sj+HddczFZ03JQwCo3qPSK7n9lLSsdhSRtUR
 /f21pUiC3lHwjLxI0MAEkkJ8Wf+JMx2qUDMYd16m2pMx2zFNa/B274XV5KYqUIhSMotr
 Y0X4KHjI7lYG/OhwqgPU9wawyPYmuQQ5sqao1kJq4e2czUq04GfJkeCJ0pM59+ub/yYh
 2ciYaYR4R+DC2CQzcGVxbkK/1hu03Oa+t1O83MRH4UlN3K4Hh0n4aqMO5cIL2njSSvcb
 WhbA==
X-Gm-Message-State: AOJu0YxC0SzteEZbEs9XknZ72PYjh7kPGsIaNUtNHop+NpdMT4eixWGb
 /KEyu0yJtOuWsMTgL/yfTTUJIRLj5md949+j8LwTEdPdDdpY0aqjlRRuV4uzaWSoh1c=
X-Gm-Gg: ASbGncv9a2xPH9AuP4n+QTo+Hxz20qCZq78KWbaINKP7OvAZ0NYN1CBN0dTuYLr1KLm
 Q7MlrzTbO7W60GOhIn1tRd0iDKO4Rq4GNrYgH2Lzaf/O5f3N1Uqx3Sc3k4pmVyOe6F/6Hwzrw+A
 XMkKvqVFfFTQCnG9Z7hEMQjYb6TpI9ETG68MsMG9uPqLtUEAKqjiguJuV/LUjk5ae3H8bdKoXwD
 DJeEkonkiwaZS9czs6gtfRb5mUiGSEG4rX57UcfW8FuSZ26mekRzVTttBMIeootrM9Huklztq7G
 xm2ttUWSA5M0RW/VWrz9RgZKL2ZXjYJ+Y7ZRUmIStNzT7nkxLPp6Ofuxvaz/fB+76gFYC+KsRBd
 6fXB1hdA3/q3m0U0LqbKrOX/9xD5dZ0qNYWLmVy+cRHbB0x00cvAOUNlYuRvSp0zetdgPpl/QFI
 oYuMX2fGp1b/MI5IuZTgN3tYJYKkh6mZdk9RtZNZ2rCj0PZelFXA==
X-Google-Smtp-Source: AGHT+IH0O7hqgGtFoB31hIXMggrgqWZrjh7qmhYGJAMaTY3y6Pj+mq/ANT9RuTAQzMXu1TIOw2sF2Q==
X-Received: by 2002:a05:6808:1a26:b0:438:2629:2fcc with SMTP id
 5614622812f47-451128e6465mr1140358b6e.17.1763735946507; 
 Fri, 21 Nov 2025 06:39:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c2cf16asm2738649fac.5.2025.11.21.06.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:39:06 -0800 (PST)
Date: Fri, 21 Nov 2025 08:39:03 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/2] test/py/requirements.txt: add setuptools
Message-ID: <20251121143903.GY2125796@bill-the-cat>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-1-bacb4148fb0d@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fkQ1BuK1VspfJVwK"
Content-Disposition: inline
In-Reply-To: <20251121-a-few-test-py-improvements-v1-1-bacb4148fb0d@baylibre.com>
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


--fkQ1BuK1VspfJVwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 08:36:14AM -0600, David Lechner wrote:
> Add setuptools to test/py/requirements.txt. Otherwise, attempting to run
> tests can fail as follows:
>=20
>     $ ./test/py/test.py --bd sandbox --build
>     +make O=3Du-boot/build-sandbox -s sandbox_defconfig
>     +make O=3Du-boot/build-sandbox -s -j32
>     Traceback (most recent call last):
>       File "u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line =
23, in <module>
>         from setuptools import setup, Extension
>     ModuleNotFoundError: No module named 'setuptools'
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  test/py/requirements.txt | 1 +
>  1 file changed, 1 insertion(+)

NAK. It's the build of U-Boot that requires setuptools (specifically
scripts/dtc/pylibfdt), not pytest. It was dropped as part of cleaning up
the test/py/requirements.txt file before. A top-level project
requirements.txt file would help avoid these problems, but we don't yet
have agreement on that.

--=20
Tom

--fkQ1BuK1VspfJVwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB5hwAKCRAr4qD1Cr/k
CsNIAQDbQILkl1nC4xl85vr+XBfX0R6yfBRVA5N8qwo3xgBmnQEAtIfaqFwLbCNp
R2Hb0bzRDexTz8FHWpFJxv9TV2uIjws=
=AC+J
-----END PGP SIGNATURE-----

--fkQ1BuK1VspfJVwK--
