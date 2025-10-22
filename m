Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F9CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 16:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A438323A;
	Wed, 22 Oct 2025 18:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iLlZt/Gj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA05C8334F; Wed, 22 Oct 2025 18:20:04 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F26980422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 18:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso2393198fac.3
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761150001; x=1761754801; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7ftn70O/TCtTd1z7W0CY6a8miLy7FE0sneYWETutoDg=;
 b=iLlZt/GjGJyMDA+q/stYNF4xZrnpsX1tM5AA/y+tR9ImqCj/4pvAUWcabE7Uqq6g13
 KewLYfM2HTuh+6zPDFDLy/3t7mBoH5790zEBJRupuqHSV9IvscsB7VRR84QuXyZkbjBc
 RHyas7nphrQvKYVeoaH0GgXuRkgS17qAYh0g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150001; x=1761754801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ftn70O/TCtTd1z7W0CY6a8miLy7FE0sneYWETutoDg=;
 b=AIwWEJ+N2qhJy02rjJvxo12z30wVmvj9+b+EMxi6aQGHMVQA30BqWrXRguS1wbnRMf
 RPWgEcJoLeeDHBjsdyczVRq5OPk20yoM06M0cDHe8b6LLstlFTKfQIFb6BvAJf1zxq3p
 X5cHPslhCj1wMb+DL+gmd4hlMU5CV83iyAUsm6yOeeVu3QqxzLcO/2yiwXzeJ6+Lyhoe
 TZaZvHQaXzqklntJOBoaa4L0f3JVIVwaPEGrONI74kBs4XTn7bIukgkHTvS/L+Pd87sO
 LJjfexl2JOt4hWqyjuuT5lq6uigMNcp8Wrvevkgo+jSCCocoCnlQbEpYcMF4qjNyEWBP
 zItA==
X-Gm-Message-State: AOJu0YxONSOUpSok/3195MA13oa4GVfa7eT6lAtvy/+NAA7JdOGWSbMr
 bL7s/FJpepo64HIBdjjwyVHWzrdb+31HqULMwPUyhGV1CChmEhOCAFiQDvkb75+xXB0=
X-Gm-Gg: ASbGncvwNwgC5Sn6osWxOP7BGHCIagIERTBhwIAvkxyuDVa9RAfwJAVcQT9uGL1Us4o
 daRv3H36Jg/uuGVzyG3pItGfWHAiurw2S1NBB5wFo3Nawq4sz7Yt++Cvld9ZrKoww3rQwoD58GN
 waRyCWs4yedH1d1TOBzvvv6nDv08K9scjrAIpQeujRxAc5gADvUyLBvcot4UoAmFv7KmwLGlQk1
 tNPAV5ndCsShpqrXSH+Ae3txagr8xDGZAvwH+PGfS15Z1gAZamApkqtV/Aph6e5IGPEVC6Nzkqk
 /eDfGAVFVxbf9O0BS/83lAKkwOB2iqW4Gnf3w9Tk5wx7llgQ0SJ745C2lHa2GmRUp+HAPJ+oyXi
 a6tqBAa+RmDdb8CVBa9Co1+VaD73+ZKBjrb8fJ81ZqP0BOw0WHeyAPHo92eudYc6AYVHLiaDWCj
 O9le/6QbWb22Uu+7S3ju1QhAa29ZuitmjKrx9UgRU=
X-Google-Smtp-Source: AGHT+IERurPr38sUvFRydPLAKGRiWj/QSAaNCQiXaawhMP+ziWkZpcL1rLvg9l7v8OoNbv6nxXZxRg==
X-Received: by 2002:a05:6871:3a27:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-3c98d0fd198mr8688897fac.25.1761150000818; 
 Wed, 22 Oct 2025 09:20:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af31c1f3sm4072478fac.15.2025.10.22.09.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:20:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:19:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Bajjuri Praneeth <praneeth@ti.com>,
 thomas.petazzoni@bootlin.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] test: py: Add pyelftools dependency for test_event_dump
Message-ID: <20251022161958.GL6688@bill-the-cat>
References: <20251022161301.893395-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="52dgxpgKT2/MNnxE"
Content-Disposition: inline
In-Reply-To: <20251022161301.893395-1-kory.maincent@bootlin.com>
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


--52dgxpgKT2/MNnxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 06:13:00PM +0200, Kory Maincent wrote:

> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>=20
> The test_event_dump test requires pyelftools to run.
> Add this missing dependency to requirements.txt to ensure the test can run
> successfully.
>=20
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  test/py/requirements.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/test/py/requirements.txt b/test/py/requirements.txt
> index 804a427b351..6d7909cb919 100644
> --- a/test/py/requirements.txt
> +++ b/test/py/requirements.txt
> @@ -3,3 +3,4 @@ pycryptodomex=3D=3D3.21.0
>  pytest=3D=3D6.2.5
>  pytest-xdist=3D=3D2.5.0
>  FATtools=3D=3D1.0.42
> +pyelftools=3D=3D0.32

So with commit 859621b47f9e ("python: Recreate test/py and
tools/buildman requirements.txt files") I re-created this
file and pyelftools was removed. I think what's wrong is that it's not
documented that you need tools/binman/requirements.txt installed because
test_event_dump uses scripts/event_dump.py and that imports elf from
binman and that in turn needs pyelftools.

--=20
Tom

--52dgxpgKT2/MNnxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPkEKgAKCRAr4qD1Cr/k
CjdNAP0UprCev2BJYEb91RKWr06t3OB15N6OEfUcl2ta3s/aIgEAtpyC9pijuOI2
PkUz7KTcb36jSKXm787EWUl9wmrGtwM=
=HfKo
-----END PGP SIGNATURE-----

--52dgxpgKT2/MNnxE--
