Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00502C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E9683118;
	Fri, 18 Apr 2025 15:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YJdUBJbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6419183121; Fri, 18 Apr 2025 15:39:49 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3320D8304C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c14138668so434746a34.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744983586; x=1745588386; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eVn3r4CjzeYMi9PJ6daGhUWfoy3FhbRogVLOkwn1zY8=;
 b=YJdUBJbNYZyxHPoDLgMEDCehBFjth8bQICCauAbNDWrHxVxwKy8HquYhQH9SkcIAb2
 zlu/wA8kKt6Xsm0pb7HipJ7b28d+Xwdx2oqwfrJAu2lqCh1MTxeVdLsKtv4iDOoFGQsC
 7HcMGPWDjKRlhKxiI9u4WbiNurnLmmgq9SMkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744983586; x=1745588386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVn3r4CjzeYMi9PJ6daGhUWfoy3FhbRogVLOkwn1zY8=;
 b=LyNQSnBxlTvEeGGnc0sknyiSa8DIY7IOdNro/ss9D4h29z0RanevUWEEjBlzow1uWk
 ZYe4PiJvMaaT7LjPthmnr6xXrUdYctZjPcEMBI9PF3vEEx/SSfOuUpwUIAXmMe+LfkJ2
 bddRBOt9QdKwS64rkLOHsoe4YeYhqpL1mu8Y1xdOU3wnYNLnc/DM7jHZX3BNUAALyEGH
 1aijYAOWeOF2a4ZB4gtHv9MYvii4rVAg0Et7/K3qy3urDAg1+WYBR80oPFENyFwV1lCc
 Gh9a5x1uWD39JSf8OrkQxrrpXwss/LA+Yo2hsFgQA2WjECZaJeD9EZUgj04SyhSvuMbV
 2u+A==
X-Gm-Message-State: AOJu0Yzod4rz5le/Ta3eP+3d40FH9K7grSTPzVhlmBRkiOtQk5UNCkO6
 QFZbW5COcbgrQu9HyUz1aU/vMt53RsTmWUYpSKgVLTMRyEM1AGSSV/gsxhVGHVM=
X-Gm-Gg: ASbGncvistkIaqwDS+XmBRXXZ2dWt+jPqR9Njw8hS4eR9UyLq4I9+KlW1mY6lT5xo3L
 jQcpOMjWpvSGIWvB7E41pnO7ia/iXKmRO193KD02/QDsZvOwukjNSGkxxfrQxW/kj9YLiXRIjtr
 bHYV9JzzAKsA2vUarXr13OxYCzGOHit/ZI5IvYC6wNSkOtMKZg5GnMkjrIqnM9bmiWo3Xe1mUeP
 AHSCqKRgnfBHsz8JoOjUyCn1JvEphx49cBPJdeF027Srfb94SlY3zJN8S2ExcxYYW9nV8jDexVI
 WWR9Pdov8cCEMrxH/o3GV6fjTnnpmrWuR5jGfe3qK3AbXTN08ZoBWwfjHVZBDSnQlM+CWQ8sy/n
 ftw==
X-Google-Smtp-Source: AGHT+IFCmVG/i3/ofjM3wKDpI3UxVsEtHmvzw8banm++JtZ3z4LQtBoEQpuFzQ+uGSgGRuk+pn3+YA==
X-Received: by 2002:a05:6870:2f12:b0:2c2:2e8e:2030 with SMTP id
 586e51a60fabf-2d526b8d784mr1214809fac.23.1744983585836; 
 Fri, 18 Apr 2025 06:39:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047b22e9sm340306a34.27.2025.04.18.06.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 06:39:45 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:39:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 1/3] Bring in linux/limits.h
Message-ID: <20250418133943.GK5495@bill-the-cat>
References: <20250418105919.1645824-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qi7NhRa2adYr6E7M"
Content-Disposition: inline
In-Reply-To: <20250418105919.1645824-1-sjg@chromium.org>
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


--qi7NhRa2adYr6E7M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 04:59:13AM -0600, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Add part of this file from Linux v6.14 so we can include it from the
> linux/overflow.h file. Drop the relevant section from kernel.h
>=20
> The top of the file is omitted since it defines things used in mbedos
> and we get an error on SIZE_MAX.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> Error is:
>=20
>   In file included from include/limits.h:6,
>                  from lib/mbedtls/external/mbedtls/library/constant_time.=
c:14:
>   include/linux/limits.h:7:35: error: missing binary operator before toke=
n "0"
>     7 | #define SIZE_MAX        (~(size_t)0)
>       |                                   ^
>   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:65:6: not=
e: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
>    65 | #if (SIZE_MAX > 0xffffffffffffffffULL)
>       |      ^~~~~~~~
>   include/linux/limits.h:7:35: error: missing binary operator before toke=
n "0"
>     7 | #define SIZE_MAX        (~(size_t)0)
>       |                                   ^
>   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:71:8: not=
e: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
>    71 | #elif (SIZE_MAX > 0xffffffff) || defined(MBEDTLS_HAVE_INT64)
>       |        ^~~~~~~~
>   make[3]: *** [scripts/Makefile.build:256: lib/mbedtls/external/mbedtls/=
library/constant_time.o] Error 1
>   make[2]: *** [scripts/Makefile.build:398: lib/mbedtls] Error 2
>=20
> Changes in v2:
> - Add new patch to bring in linux/limits.h
>=20
>  include/limits.h       |  2 ++
>  include/linux/kernel.h | 12 ------------
>  include/linux/limits.h | 21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/limits.h

Ugh. I think we need to:
- Fix lib/string.c (and Fixes commit 7c7361b98d6e ("lib: implement
  strnstr()")) to not bring in <limits.h> as that should be limited to
  mbedtls usage.
- Not bring <linux/limits.h> to <limits.h> to start with at least (we
  can worry about handling wrappers around overflow protection there
  separately).

--=20
Tom

--qi7NhRa2adYr6E7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCVh8ACgkQFHw5/5Y0
tyxV/AwAlrrr2NPlMZ9GF2rXqWxNH7X+KsbEE5w+oNpovou7YUJBpKJJ4OMWlVU5
pumz++smhSlH4RD5/WHgeX/wfaEJ81JfPoEp23lWXAQlaLKg4dDEGe16iDyRv3R6
eCKSP+lvijtDoTuVdRo1Vc2zU0loEO27dBFxOi1LpI+pu7sAcJUrPncAwqgKZrrX
u7qIzuLj6s+51MNPXZ7GGCtPsJDcjrcH0byVn4u4cuVTBC6x29UNQMvr1dudpM4Q
UHoN0ELHnzhlUGzCvM8gyduKC1HRc1+HYDCcV3g1tqWGdVpEIKKOchTC80HrfDhj
2BC8G7CfnF3Idp38q/XTUTI/+A9WS0mCNPfCQYdyDAe6UkF7I7H3OojT60z7qb7F
bDjrb1BM0vd4M8gb/SveR4uw/NF5GGQ5z3p5jwDJwYJT0MGnSSGf7SwoLVIoi3K0
JnUQuEZpFQ5wuVx5Mp3QbvNZE4KOvu8OlgHDTFcYb4vm/zo9pkXS03v7lO8qR8Sm
3Apg7qid
=oOgx
-----END PGP SIGNATURE-----

--qi7NhRa2adYr6E7M--
