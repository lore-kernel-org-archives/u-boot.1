Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE56C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C282580E9A;
	Sat,  7 Jun 2025 16:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="edOYD5gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A1182A0A; Sat,  7 Jun 2025 16:20:00 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28C3807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2d4f8c42f49so2537852fac.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749305996; x=1749910796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ks4LgYhG51/HvQunIYK/q4U9x7FLbJGc7HfYeMb3K+M=;
 b=edOYD5gx/0Std736Jb6We0edNjHBBlX1BnVDo9jQNXE28sKRQwDZos1ongdxwB/Zz2
 +j0s+euhRoZj1xc0rcwlO4RMxUOINb2ZnccFRmNNosz8sBqh1aXpIe/PWoyuYwEJKZCj
 7f4y3CJngSRbeuji7Vs5caBF5X+71EpLm99y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749305996; x=1749910796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ks4LgYhG51/HvQunIYK/q4U9x7FLbJGc7HfYeMb3K+M=;
 b=t8EM7rRLdGj/qWf1n1AimoQg9eQ/0J8xlU+jz/wxTHrkkwyFgxDQ0kpBYC24OcqfnQ
 CrSeBT2hO4+VXSZy07u50loP25aQE9klw307CXKzvAcbMXPn4NxHxcxFkw8RCSp1RQpp
 unMhPLlOw64P8ZsXGyMGyube+6bRwrSVrsw/4eXTjWbr4mwWZRiC1gPkJWcSwBfj2p9f
 CaerkjeqTPZkmxTS7Euy+KwdTh4yuu89G18nIRUTtW+hwvUjITAwiPvQoMvb1BDbSZ9l
 kvSuDPf5047RAwxIzbxsatnuCx+9MGNtGpT4DPJpiiBKx7qXOpXwCKzN7Z+wk9CwrqOk
 GXeQ==
X-Gm-Message-State: AOJu0YyowDFh4ugVOLI2xWGHccEZCAYq2FKW77gtA1UoO+uunPUsOw3V
 M7HqVd1WfS9bPJHNl40Da7y2Uhzg674T1xyMZSgv065GuE+V8pPr5vRm5cIk+obeLGkLWDQ+Z8h
 1fbCX4hA=
X-Gm-Gg: ASbGncv1yhuPaLuwXtoUmW00ITuGtp0++EmmCWQaGpp45De++Et6GVxAYZKtjWsZlj+
 p7kyIIkUTa067Sddnjg099w0a4SS3pjADsTQuPqndbxaUOHMaX3Ct0R8mmLrHmPGA2wA2kzuecg
 8+v/7AYqMxffGqa6nrgXpKJQE3v53Q3L9CIZ7P1nFLF6KRq3DAYL/VxRTGzFjUms1SbgV17PvLX
 qKCCgncM6+D8J0T0c3htM4uKiwPbVv72/qivs8Xy9nTmVF+aQ47oFLCkcDcVgSfK2MHzI0McN4A
 To69lLFpj8/0L5i0S/MaXiDxshD1w41QTOv8P6hElFg8BGfFROo0QnfhhfigZ7scy/K21RRS/4u
 fWhv+XOsGH2FQtsyAF0ZQZwI=
X-Google-Smtp-Source: AGHT+IGTU3+LvZindSRKvmxCoDqT2qVvg6fAXFGfWQb+/jGG6WGNwZ9KfLRQTvvGlBrHBlOIsTgMhw==
X-Received: by 2002:a05:6871:228b:b0:2d4:e101:13f1 with SMTP id
 586e51a60fabf-2ea04431a73mr4466939fac.13.1749305996187; 
 Sat, 07 Jun 2025 07:19:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073406c7sm956862fac.36.2025.06.07.07.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:19:55 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:19:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] pylibfdt: correct license information
Message-ID: <20250607141953.GH1382132@bill-the-cat>
References: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g6Txj+z1MaBlU7vU"
Content-Disposition: inline
In-Reply-To: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
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


--g6Txj+z1MaBlU7vU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 01:32:17PM +0200, Heinrich Schuchardt wrote:

> Setuptools 78.1.1 shows warnings:
>=20
> * Pattern 'GPL' did not match any files.
> * Pattern 'BSD-2-Clause' did not match any files.
> * SetuptoolsDeprecationWarning: License classifiers are deprecated.
>=20
> Cf. https://packaging.python.org/en/latest/guides/writing-pyproject-toml/=
#license
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--g6Txj+z1MaBlU7vU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhESoUACgkQFHw5/5Y0
tyyFUQwAuT3b8pBzCOFgtROKdBGPzZcX7VEGsGXNcLKdvKuii66CrIq9WKzAYn2/
n6+8vIEsxxuKyKd3Ig16O7qZJ1HuTShah2YbhkC9tXrG4yrRsf1l8lCAqzRaW6VG
oPtF0JsSRMVcsQHbTK5igaqjJFyhjUipQ0NkSiib8dp/LBmSvGbF5RqZVAWREjY9
ZuV8yL+GRob36SXdXRzmzZkJwPMCSJUv2+QrGzhpmaUwEO0Fg7FawVjmkpfKwdaQ
bRHa3R7SVxxzQpnGjz8kFEvpq65lruYFffopZH4FpRw/F1ksrzGoOwoSzU1I/FYW
7jznxeLO4ePqkeUtwXBJnv+Qye01OZ8z6UAZ9AlMP42Jy6nxwfUztLQNGVyLIL2v
S08glDYYw+2SQkXeuLFVQxalWu3vzedIh2QVpesReQcAe81NuH751O4uVcuhdhKe
xbGCahhgzFo2Q15tSa1mOedLDHZm4BNG/90OK/DnSeb8NZbULt82lxRsqkSDvCZ8
Yj6JQ5pN
=bexZ
-----END PGP SIGNATURE-----

--g6Txj+z1MaBlU7vU--
