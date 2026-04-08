Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791D210F995A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E889841D5;
	Wed,  8 Apr 2026 18:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SP/qpGA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02568407E; Wed,  8 Apr 2026 18:26:22 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6BCA84120
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-471bf5157d7so15861b6e.3
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775665579; x=1776270379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nA8HIAHV4bdfivodGtyijBmGEnPTd/PU1fIgN0DtXOs=;
 b=SP/qpGA819Z+fRoAvXIgU+maXyF2Iy2Wy5g57KeUu7jQNAYLA0wrKCzz2HnDq+03Yp
 2K5mVIGu2wZZMNn9hMVBxOlzTIJL8fLIkUU+/ggUvvfszymh/FJ/X3IZdy0Js5bg5d8D
 qXrdpAit7kRdPaK/MAbaLpY1Da3DxJ9s5nrrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665579; x=1776270379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nA8HIAHV4bdfivodGtyijBmGEnPTd/PU1fIgN0DtXOs=;
 b=dWmWbVAmk3FJO7LkbIB0+8YI1vWrw8o+d1Sy66Pr0kgLBR6JPLDb4Wms+Y4ATBhMgY
 /gnnpOc9h1OHaJ2GiX4Y4a/9ZmtGnEzTcZmoA2xL8Wo3yzduBaJjkQa8drJ1l4VIqNZQ
 1Dz0Svb0OSTco6v73nAp/DEZnh9kzR7Wcj+/DYGS48/hFJgKZWmR6lhHlGGCF3oGobuw
 l+Wo1LUxhfeo0W4UFbrBWGmYd/980nYj+Avk1fSSWF5eNNsLfNXd3QxGa2aqIF9h65Ft
 g9HxdbbODWY+RQ8OQ/AZGSBXAeLs3U4YNbn9VPArHI7LbyNhiuqXfEfcCk01ka+4Uw60
 yDkw==
X-Gm-Message-State: AOJu0YyC55uyJzxYCQObFlj3XFPrg3fBRt/4t/lX792tXshgDwL1JR1x
 EwE+OeS+7vOHi6o01GounU7qxwHUwUX7ya+We1DrP1rTtxq1M54iF1zOIIKDfbWcy1g=
X-Gm-Gg: AeBDiesgzxbJEC0audWOVo/pFj8F2lKBgu+eW5BeJG4cGtw6VpUpLtKdUNC5T4RpP+b
 3Cm9Wwng8wZIPyrDZHnLUrxQ3Bd99+S2dZvKTB5oaV1vB3MpiSD/zmTcDiU+8aU4RDNHoS7Z5Rs
 FjdfaTR4BERQbphSzvrRWlctHsSVgYLtOnjgfz85ydoApQu+rZEIValtutkKTnXjmx3ETtXER9/
 OP7yyUagF8K94lLSACw3y3IPlMwQyiG8I1eM88sCRDUDiyhR6lOTyCjWom80cSIiZl9U2FscN1V
 Pgf5QJysx0F+KXmayDJ8UsUBVv0icc2hz1kpL52C1s2N0hOCrY8zMO7wBQhTI0kZmc0rssUcoTj
 JkaiNfSwaI3aqKyXQAZqM9QfK0aneEOFOasDukmp+QqFvyAonZv0Jq+0ApXu4nA/MrJk8hO574y
 /WHQ5bJ3lWt9IS6Yu3DWOPZV5OVSBOB3hOHaoc86tOzyeNJPAovjmqHgkhJbg3PeanKcrEFGLJu
 Q+KG5LxbEWB4VAQd7cKsOlW1Oxbjl2qDOqwpLg/NXZjhLzj
X-Received: by 2002:a05:6808:c1fb:b0:467:15ad:9df0 with SMTP id
 5614622812f47-46ef57f0137mr11276762b6e.7.1775665579344; 
 Wed, 08 Apr 2026 09:26:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47648f208c7sm1202335b6e.3.2026.04.08.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:26:18 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:26:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: Re: [PATCH 00/13] boot: Make fit_image_load() easier to maintain
Message-ID: <20260408162616.GI41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ImUaEIiUHoro/h17"
Content-Disposition: inline
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
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


--ImUaEIiUHoro/h17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:54:09AM -0600, Simon Glass wrote:

> Before fit_image_load() was created, the code to load kernels, ramdisks
> and devicetrees from a FIT was spread around many functions. By
> combining most of the code in one place, it became possible to add more
> features in a consistent way. The 'loadables' feature was much easier to
> plumb in, for example.
>=20
> While fit_image_load() was a substantial advance, it has never been a
> svelte function and the passing years have not been entirely kind. With
> a few new features on the horizon, this is a good time to improve the
> implementation.
>=20
> This series splits much of the code from fit_image_load() into a number
> of smaller functions. Most of the changes are fairly mechanical, with
> just a few renames and tweaks here and there.
>=20
> This should make the function much easier to maintain. It may also
> encourage someone to take a look at its callers, which could also use
> some attention.
>=20
> Code-size impact: about +8 bytes on aarch64 and +24-40 bytes on arm, due
> to the compiler's register allocation across the new helper functions.
>=20
>=20
> Simon Glass (13):
>   boot: Split out the first part of fit_image_load()
>   boot: Move call to fit_image_select() and rename it
>   boot: Tidy up setting of the OS arch on host builds
>   boot: Move type and OS checking into a new function
>   boot: Move handling of the load_op into a separate function
>   boot: Move obtaining data from a FIT image into a function
>   boot: Check the image is allowed before setting os.arch
>   boot: Move the architecture check into check_allowed()
>   boot: Move image-decompression into a separate function
>   boot: Move decomp_image() into handle_load_op()
>   boot: Move setting the OS arch into check_allowed()
>   boot: Drop unnecessary data variable
>   boot: Tidy local variables in fit_image_load()

I've reviewed through 5, and I assume 6-13 have similar issues as the
rest. Please think about that before submitting a v2, thanks.

--=20
Tom

--ImUaEIiUHoro/h17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaBqAAKCRAr4qD1Cr/k
CibEAP9xae4qnT3RNwfy289zQWGsZmdhovaa72gujinJo+P51wEA/IS2tN4hbjlU
/wLZJ5hl5cRx/KbsOiTboassqjFkkgM=
=Belm
-----END PGP SIGNATURE-----

--ImUaEIiUHoro/h17--
