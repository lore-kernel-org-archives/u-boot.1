Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030BFC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA1F80A09;
	Wed, 22 Jan 2025 18:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otRV2l6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F8880A30; Wed, 22 Jan 2025 18:24:29 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A32809D4
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dfbc45355bso583696d6.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737566666; x=1738171466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XRSoLHyfChgSr7T3EawB+PVXQUevll0w4ttfDu+okwI=;
 b=otRV2l6nYDn0HWE6nNPYcEVIl4tHca5akkCrg7ZCBihsT3ryHskwRR6vR9igiJsQ0u
 2ZF1w4loq6tf1VuDZtLSLo+mAmTHi1e1Fy2wp7RAymnF+LWbYgmrqu+ROtZqyQomQEO7
 uVCDHz5/5mhTKkYtR+IxJaLb0cPM17zKktBSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566666; x=1738171466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRSoLHyfChgSr7T3EawB+PVXQUevll0w4ttfDu+okwI=;
 b=kgXuea1kZZoVkVXl3ZOO4wt0YioWFBjKebeo2nst5/s3EXOUOEZjX1ZyosueNqrNZg
 dha2isnWpNd8yym9XRjvYOSUC90/Q6HK8szom3S7BaDREntS80wj/BXqVm4uqK7ttnIP
 jtuDVpMsG7Wf259HOZNf1hukvqDW8LEaP+mqgAp3aFHNx5tOj0Lx9DLtVALF5BoPswHS
 tGxuPf2GUWU+h2xIUu02Z2SlZTpqmXq1Q/HGhH/BMcYXg+dOP7JTtfzqinOReoyIwNL9
 N1P+Yen+Zde1Zro5Ej4EatcV1G9V+7nnoFbGIQpWgyqXKrXHic3w/x6tD+dROmAyGNrG
 JWQQ==
X-Gm-Message-State: AOJu0YwuH7Q1lwNOubFf6/3rOyBAMxSdP0uLH25utmJZ6mfrMRH6Uzy0
 iGZOWIzOKXuktf5MXbopNI6YTPo1LNv/UA60cQ9OTk4BPA35LMbs8+My7YVWrtCvGmzoJVV3M5T
 Z
X-Gm-Gg: ASbGncsX0Q5X+0oVM5rftE72QprEdB6K1l9wIu/WOLCiDl+uUuO6rOfZ32Z0Bq0hkZ8
 LUuVsJ39UbX9uwJWOcnxYJ2ak5QLbiGquz6O+nyU58klzz0RMC9deZkcLLNUsn0qZHzSzz0EyPu
 roaBu3RSNa846WOwtZ4GfJobGMTZ2iwHLyzq9XdQKmAhlUb8ObPgVoHbU4SXYm7Mrt1ve+2bcuu
 fOMlP5Q06VN2DZsigZfcnLMLTnPx6yGmPv8itMrAYHhbOSQK0WtiV1l6tGGc6t8kk8=
X-Google-Smtp-Source: AGHT+IGZeM8dKXjc39T+enywzI8TgbXoFLxxYuZzj7aCJMZb9s74RRHGrGlbUaSRC0bKwi86Y5VCNA==
X-Received: by 2002:a05:6214:3a8a:b0:6d8:9a85:5b4d with SMTP id
 6a1803df08f44-6e1b2168d5emr380963926d6.5.1737566665812; 
 Wed, 22 Jan 2025 09:24:25 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf37f7sm62996846d6.16.2025.01.22.09.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:25 -0800 (PST)
Date: Wed, 22 Jan 2025 11:24:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 00/44] test: Improvements to ut command and test-suite
 running
Message-ID: <20250122172420.GO3476@bill-the-cat>
References: <20250120212613.516664-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fvwOctzS6fNnTANF"
Content-Disposition: inline
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
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


--fvwOctzS6fNnTANF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 02:25:22PM -0700, Simon Glass wrote:

> The current method of running unit tests relies on subcommands of the
> ut command. Only the code in each subcommand knows how to find the tests
> related to that subcomand.
>=20
> This is not ideal and we now have quite a few subcommands which do
> nothing but locate the relevant tests in a linker list, then call a
> common function to run them.
>=20
> This series adds a list of test suites, so that these subcommands can be
> removed.
>=20
> An issue with 'ut all' is that it doesn't record how many tests failed
> overall, so it is necessary to examine copious amounts of output to look
> for failures. This series adds a new 'total' feature allow recording the
> total number of failed tests.
>=20
> To help with 'ut all' a new pytest is created which runs it (as well as
> 'ut info') and makes sure that all is well. Due to the 'ut all' failures
> this does not pass, so the test is disabled for now. It is here because
> it provides security against misnaming a test suite and causing it not
> to run.

This is a size reduction when the tests are enabled (and so seen on a
few in-tree configs), nice work.

--=20
Tom

--fvwOctzS6fNnTANF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeRKcQACgkQFHw5/5Y0
tyz3mQv/Zocc82mkVvr2DTS46/QME8HX1Xh2zQ6JWef+kzNInkdNFOSWcTdbhMzj
o5UiCBVFfKKst0JEV+olkmlm799DCWNMFCzaoaEba5U32Fo0G51cvJebToFOnOdF
EHlgBmCLMMWN+PK7faApH9Vwcn/XpqPGVqtBZej65HwiLSRDW5iiY5cO38DHeuo5
4ArWxeI3vV5DzMFa8YGUWx/PXnmHwA7dXWZcVQ6WyeTkCPCRIHSMDd0j1yZ/w3qv
eK1njXc8BQ8zesr/2N02mNh004UFPRj9hQtgpcA1451MBzkZnJvi50nYWizLisMH
WdHtw1Cz4axyxM1RwpTsoM5fkjIshPIxUehNV6X2P6+E5RXt7ae9558QvgjNu7W9
GRzRoOQC6nrKBduU2qzzDugbf2NHGEZMYTcX1l0PVwZQmJswVG8tzr71RMvZuYhu
bxgrJ75SbO4/k5p/ybvHsGIS4PZjHKMMHYcWxma8+aeUjGxTWNmjIDXyvlMg/0++
4+cux5U1
=GFuc
-----END PGP SIGNATURE-----

--fvwOctzS6fNnTANF--
