Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4800C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA8383082;
	Sat, 24 May 2025 16:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlAFiTaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDBF83327; Sat, 24 May 2025 16:24:40 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FC482AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so445662a34.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096677; x=1748701477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=81SXhhvVEsdV7M7VWx9z47FuYNeO9uv5NqShRGK/NnI=;
 b=AlAFiTaRnK1tdIvVwJMn0Q64xOmwxhWF6tlkQ0o23Dyj3l3XLy6cuh06W6PWc9MneP
 LMXQWFa40Jvm9L0kuDbE1Vi3iP0f77/VZp1vc9OA5Pw/0ABPu4jB6y27qY/MR7bF14Lk
 mOVXYiKH8JVO/i8wsLQl1BO32zLBnzbDYwVvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096677; x=1748701477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81SXhhvVEsdV7M7VWx9z47FuYNeO9uv5NqShRGK/NnI=;
 b=qryMvbHkANJNJ0us8OrPf27voMxd9XlVV5lEAjQpphKZ0Lrg+yhgN4R8fuX5lH89pr
 Eqxp/ywQttPDEeI2vPqt8LPg0O8RbUPBua8kYm90cXfjc9Gf7RVcQrUCMn85SDE/6uhd
 lsp2LU2bZzdMktnHsQZkNTq+xBxgFHJX+Yj2m0zfHebg0lwKX3O80EDXaRmO8q9QOp0s
 9mKhNTB6330GLR2FK2xqIiDWlhAhbIEGVK83ui5Knnd+hh6LEYSB3I6Fy2I9a/MMb9ur
 FeB/bj9on5gEmeSMf4WxB/UZNvSklka7FOVevdICEaR8s0y4YszErn8Vl1297kSfG0Jr
 HXbQ==
X-Gm-Message-State: AOJu0Yw9wDhSOAyoV4juLBohZ5yHa/USVe9ce3UcNyfcPq75hpQYW6zS
 NvLoOrR3O4ATAg6MRjxfYqTJr7tBnC8rNkK/0i0i9UhdAHU6+cyrpJmFxgbiyLl02MI=
X-Gm-Gg: ASbGnctMg5nv2wcLKyd+Qms1USwl1TxGh+v48Awm4p3EhxF8Y+VIL9TuqwDERepBa33
 1ycN8OKtDsjU7JiTChmapCbE0RUQht9gigNhd/7EOLv//JkefOtiVAtgK5eQJWEY5AzNNCqbElQ
 GsfS8OlIkav7kUXO7aD1fFOJjEkYStm+MYF+A2GyaXptXtYzFN9fpuV23Zsz+b6tVIqk69RRaAV
 ldsoYuyPMPatvmVWIOjgE+X7gQPS67NqcZWp30X/XVmXs7210Cs9fBEphtQUsl8CHycMgqmHfH8
 yP4uQchcslh6nnGjimU99UGA86mtnw9mUfnlkU4gUsNLbKQofjbiDafe4d7J0cqlhmHpxEvgX4q
 C35qeEaqfcHTc
X-Google-Smtp-Source: AGHT+IGNd81DBkPS7pM/K2IMAq8sjYg2ttZgyMEgGksg1wYwmXVgBzSg5qbCQ1BAcFVpD7hSKCTHbA==
X-Received: by 2002:a9d:73cd:0:b0:734:e177:b402 with SMTP id
 46e09a7af769-7354ca95188mr3774323a34.13.1748096676804; 
 Sat, 24 May 2025 07:24:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3ab44sm3316068a34.43.2025.05.24.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:24:36 -0700 (PDT)
Date: Sat, 24 May 2025 08:24:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/2] bootstd: Add a function to find an image by type
Message-ID: <20250524142433.GF100073@bill-the-cat>
References: <20250524134356.939898-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dA005nSjRCga7dMW"
Content-Disposition: inline
In-Reply-To: <20250524134356.939898-1-sjg@chromium.org>
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


--dA005nSjRCga7dMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 07:43:46AM -0600, Simon Glass wrote:

> Provide a way to locate an image in a bootflow based on its type.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/bootflow.c        | 13 +++++++++++++
>  boot/bootmeth-uclass.c |  2 +-
>  include/bootflow.h     | 11 +++++++++++
>  test/boot/bootflow.c   | 16 ++++++++++++++++
>  4 files changed, 41 insertions(+), 1 deletion(-)
[snip]
> --=20
> 2.43.0
>=20
> base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
> branch: boo

Once again please stop wasting the communities time with things not
based on mainline.

--=20
Tom

--dA005nSjRCga7dMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1qEACgkQFHw5/5Y0
tyw5/Qv/exJ2+hEdWcNzTPvLdqSMzB+u5OYWUogn5BYgQc99yyFe+78R8tYSK4qK
XF8sOhK4F6JfLrjdFjWl7uQjV2R9yhelwy7AW3H++4SHeB6PDqk58BXTDQV29rpL
bCSpWhbVHokRsEHRLYNtcp4iuvJvj2dXJCqU+LxrMA1NI59ak61hPgRg/zHVNu+f
nH65+zl6y3/+b9bOHBJa76CB8mJ3IdINEByiTZiJJz7wzmiVzCMdNlr/CNLB6qIQ
hv8jOPvuHpYMEUvLqGNly5n5AyYzcuGfEX8dFI/xpOwrJhdc481nYMGMqxKwgQPd
k7UxEYnq9Ox2HaIPqeoft8aGEL/qIsRySq70f8NLIMbL7V8zkOI1jOjrZTpOXfiG
4VBpo7LyhF5XWQ/HTk+UZxqeHKuvGpTLwVaBHnZqAqztuv4/Tr69DWLiVdHKURXI
0YpDm6Lqpa3FHLqStukpU5tIxRDfnIzGrAMD423q9t3NW3z6kIcvxNi1ATeUT+FE
5RkC0dgN
=MMq4
-----END PGP SIGNATURE-----

--dA005nSjRCga7dMW--
