Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA65D132CC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CBE88DCE;
	Mon,  4 Nov 2024 14:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xgoov6Vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDA688936; Mon,  4 Nov 2024 14:56:06 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A39B88EC4
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbd005d0f9so31095386d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728561; x=1731333361; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ID+JSmDhQLpP79vYgq4eP3cwz6Tk8mbNVZPHUz1Xthw=;
 b=Xgoov6ViIHBIJBhdmpC4Q33oR/Y4xS1rHSBenUWT16RqICkvaQ2VC1B48+nmfOrm4W
 pCDf25MPg85nD0bsNK6ORKH+lyfkxcTsaV81YbaPzODFzF/m+8PV167AHW5kb1fwDNF1
 WDfRfwem12gfwvK4VQllo9moT5z39bI6v59QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728561; x=1731333361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ID+JSmDhQLpP79vYgq4eP3cwz6Tk8mbNVZPHUz1Xthw=;
 b=ejbDTRY3fN++vjy0FfNjBCS8hKsuksjfdjDmYubSrrgT8vFH8Q8rQE85Qlg/22+Cgo
 kY1eETVDspjVxyrL5PbYuuDGktGY/+CBrwl/HAgVGwCqYjR0/J3hjr5NLtQoNh0LukN8
 goaevN8Ch8efjlXRdK7sz+Vr+Bmdu8UmQBqUikSXVg6IHYgk/PzMmNYGWaLM1zQGVH5F
 ENWJNqC77+pY3XSNFnrURVLECSuaa7TAbd2xlnwJB15nSPJ9I/wuzE40fgPA9vWjMihG
 ak8lbO1unDQShi6sZyuLQIYgR7vpGiAI86UwD9sbCtdOkLrMILpXAp3Re6JLCpFdph9A
 VHcA==
X-Gm-Message-State: AOJu0YwRPRtlYrJOexWzeUvf4iewqnBFKHor8ftv7ejz1JHJyTWO8nn8
 0/bhVYMjh93Rj9UMaetiIICWUbVZvBlTKYbs4TJKmPIm3bQCAbR54iCZ87/H0c5zZZUJ4nYK8u0
 OJFA=
X-Google-Smtp-Source: AGHT+IFvC1wqcH2wiNJ8VsjzSE+9jl6knyNi+56AmcnWd6QyV57jD+RRpzNdqVrkmxMaaeoJabUcrA==
X-Received: by 2002:a05:6214:5401:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6d35c132068mr227503076d6.20.1730728561134; 
 Mon, 04 Nov 2024 05:56:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fc4f7bsm48332676d6.34.2024.11.04.05.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:00 -0800 (PST)
Date: Mon, 4 Nov 2024 07:55:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/9] docker: Support building for multiple architectures
Message-ID: <20241104135557.GI3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zj1CKu2ir08X3Th4"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-4-sjg@chromium.org>
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


--zj1CKu2ir08X3Th4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:47AM -0700, Simon Glass wrote:

> Add instructions on how to build the file for multiple architectures.
> Add a message indicating what is happening.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/docker/Dockerfile | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 967ac89fbde..c9d794082c8 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -2,6 +2,9 @@
>  # This Dockerfile is used to build an image containing basic stuff to be=
 used
>  # to build U-Boot and run our test suites.
> =20
> +# Build with (for example):
> +# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20/=
u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 .
> +
>  FROM ubuntu:jammy-20240808
>  LABEL org.opencontainers.image.authors=3D"Tom Rini <trini@konsulko.com>"
>  LABEL org.opencontainers.image.description=3D" This image is for buildin=
g U-Boot inside a container"
> @@ -9,6 +12,10 @@ LABEL org.opencontainers.image.description=3D" This ima=
ge is for building U-Boot i
>  # Make sure apt is happy
>  ENV DEBIAN_FRONTEND=3Dnoninteractive
> =20
> +ARG TARGETPLATFORM
> +ARG BUILDPLATFORM
> +RUN echo "Building $BUILDPLATFORM, for target $TARGETPLATFORM"
> +
>  # Add LLVM repository
>  RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf =
/var/lib/apt/lists/*
>  RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

Please update doc/build/docker.rst as well with this change, thanks.

--=20
Tom

--zj1CKu2ir08X3Th4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0m0ACgkQFHw5/5Y0
tyyuwQv+KnHCL7zq8x4fWVAVZthDcC99F0s1DqzUk/jpATBDLGcEbN0g5XVLJeXg
8Xggrjo038A2t77Z+MDXufbWSqT8JC4sBd6fW+V/xfXq2WTTM/d6pzzKtiH53LON
0nLotBisv51OrCMX6bwFB/NN0RjumoBHrSe5iLgh7JE6mKa+Z7eUbGImEGQjN7T5
K8x0MgdFiRt+BTAcNnSujMx4x5q7n2V9sNZK/J1ouCgpMs94xqrjeDojUz2r4Q0n
fL2QY/KKfirnk1bbJ/wSbjrOuL9Zfl++zraLPgnVSOWpVLf73kDW/PERC9w/gWgT
fE3QCsRAuPD1vTx9EhAurnPrY6VAKBjgEHrQDF/6PwYGJBPTWab4tOnDqY8iHyby
AviSF+l1oLweTMlFGA5dJnpLepqEwXRW0MzVXdr1ugMxq3L7rrIHZvXaBgtRT9tR
WcEDc+DDZ/vIGadjzumxH4rThTxqQs23AgDqnmJ7cjnbzAKlnF62duRwcV9f6759
mcX8x3Cs
=aRYy
-----END PGP SIGNATURE-----

--zj1CKu2ir08X3Th4--
