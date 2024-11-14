Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67F1D637DB
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C22E895B7;
	Thu, 14 Nov 2024 04:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pvR7RnMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D458895B0; Thu, 14 Nov 2024 04:22:50 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5577489584
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29538198f2fso93835fac.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731554567; x=1732159367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ExMZvc7UuW3tOwkwiM/WN+bIUquBI/aqIqAla+hODic=;
 b=pvR7RnMOdaGOg2hLoUW67xDZhZigURoCaHCGu9wjmIHYF/TBx7sb8L+5Dkv+WHU6dD
 g5jSdfUscQdSiXpGMfdcnUdCtt0e7EYbI1oSeEd6Ogr19VIf6Kkgk+Pt5lcxr3KfI603
 pn4wfY4JVO7oOGfJLk0KGS+1VJ6id634ujuD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731554567; x=1732159367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExMZvc7UuW3tOwkwiM/WN+bIUquBI/aqIqAla+hODic=;
 b=xJKim8uXk2YakuOVivM+p8nbcWQvEYeywUreLsKWjnGnNlYqOcN2ojnpfWlkVvmYex
 uTOVuTRqmpHyavR0aOnvqGR7cKerpMvkYBtKCpsBCaIlf4UrnV6Axu/ifM/bFvbnM4+F
 n5o9yDp7Uy+QWr1v0peP7UvbLme8OWMtqSjFtMSFrNnRjib7rhgpuBlD7dSEm+klwnyA
 o6KPB0LsKEzt13ZK35vGyKJIK8ukIX50rU8mCFSkL1GaBNYxcFnRThOjdnMq4K+WWkMZ
 Rzd1PrsBH0HH0uRCry8JwK3xNtUkpZD6a1LWkUj7Q2jmMbXFyPPHGjZzfF9bYfc2u9rM
 3j0A==
X-Gm-Message-State: AOJu0YzJyQWPHp92Yrp23L9WEc5QGx3E+iXUfJqyPvf6gVCa253lEsC+
 yEd3hmeR3wI2Wc+E7qRkkyaeDvxKubkRLazUPGsRDSAAa4qyYLGA1JGEfKKh9rA=
X-Google-Smtp-Source: AGHT+IEshvfQOEPe0MrFy7zvfQw5AXLWp/V5kLA5LMRr5yXtU9H0NSuyN1NqvqHDVaL4NO6AjmT+Aw==
X-Received: by 2002:a05:6870:4607:b0:261:22a4:9235 with SMTP id
 586e51a60fabf-296107c42aamr569408fac.32.1731554566944; 
 Wed, 13 Nov 2024 19:22:46 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a6eaeea60sm134203a34.43.2024.11.13.19.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 19:22:44 -0800 (PST)
Date: Wed, 13 Nov 2024 21:22:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 3/9] docker: Support building for multiple architectures
Message-ID: <20241114032241.GB3600562@bill-the-cat>
References: <20241113185340.1661198-1-sjg@chromium.org>
 <20241113185340.1661198-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nZulv3KnTNg9ozF5"
Content-Disposition: inline
In-Reply-To: <20241113185340.1661198-4-sjg@chromium.org>
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


--nZulv3KnTNg9ozF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:53:34AM -0700, Simon Glass wrote:

> Add instructions on how to build the file for multiple architectures.
> Add a message indicating what is happening.
>=20
> Update the documentation as well.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
>  Or to use an existing container
> =20
>  .. code-block:: bash
> =20
> -    sudo docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2=
024
> +    docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024

You inadvertently dropped sudo here.

> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 967ac89fbde..7f4b17ab0a4 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -2,13 +2,25 @@
>  # This Dockerfile is used to build an image containing basic stuff to be=
 used
>  # to build U-Boot and run our test suites.
> =20
> +# Build with (for example):
> +# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20/=
u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 .
> +

The documentation is the example, please drop.

With those fixed:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--nZulv3KnTNg9ozF5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1bP0ACgkQFHw5/5Y0
tyw4ngv/bK7w3264sHlFls9dGkjEgpvRCSe8bXEvQ7GjvZO3WA3tj5dNSCmplWVs
KqWezUzeYvst5LSPu8jHt+oBiUV9fSxKo3DzbRuw1cJj75nGNGrApomCY06aI0rM
sL02+4uAmqchESI6TudVZMspKEq1NhoXyqsJ3izXmxSpnfsyUhFjwSipR291lD2A
NBiLTVZwPDMrOBIHw+UEm1KZO56qgNxldqWgOVJDw5UrUT0hn60zmHHf9iq//Wz3
YbqST6rYUIhwKJ1FG/zYcmQwPBnqgpw9dNrrw2JRCnv8o0O3Z3Wq4+wF8egDFtgu
tPGeS74/f6FXwvSAE9RaFYTWdhOF4AKZfaaXd8U/7n7vsBIXIt7+YFPwI8fZFKqd
3FVE0E+5Eh7usyi+oZbSTQGHVUM8bB1Xs2ZoELvP2VWmNRD+b1YeI/yKg5tum+cu
E3bDPJn6GfXO7rGHOTf1RP6BPBDSP4jJq/d04vZVdo9UeGEZ4ihiAgKAMxDnvjHK
xzwTUvza
=c28B
-----END PGP SIGNATURE-----

--nZulv3KnTNg9ozF5--
