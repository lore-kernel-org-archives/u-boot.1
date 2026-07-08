Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217EAC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E6384A1F;
	Wed,  8 Jul 2026 20:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pXAqkee2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A67184A29; Wed,  8 Jul 2026 20:09:20 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D8C849D2
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4513435cdd2so8999fac.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783534157; x=1784138957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C8qrR0fxjq5WpqpomR69xSa55+92S/IG6xAzOUPrwWY=;
 b=pXAqkee267ShYGDuVsF1PuqLNfpNcO4LNtbbKKhx8S2mBz2gLxW0vTHd5hVOcFb0fg
 mLJRP0jAz8eg6ncP18v6hRMWE9KdtZQGZtPFd2giUHV9PIaCEZTybwN0NRjiJmzyKUMg
 2gGO07nPNmvhcm2AQGSHd9ZJM7lMyulpiXvSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534157; x=1784138957;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C8qrR0fxjq5WpqpomR69xSa55+92S/IG6xAzOUPrwWY=;
 b=A84ZSky9UJrK6dJY1+gsoDvxUtpIVuuFdJiM+yAa++0X4r89N/ffPPed8ZF5UL8RKT
 keCD/gAoL1dNuczsuoRyLuODkYIwIypKKqvSyOKGDZmyUxMRyzvD55efr/tklILFWztd
 MhtNlkNuXN0RkjeAIlpRls9p4xtwIDpbwEaw7e44iOMVbXE0h5PZY+Utq/YsrYTzd4r5
 VcKZhV5oJUztORpq/ZAsMl3kdg9U74OfQ5Df2xnzLmzD5mBIt8GJPCXRaCRIfJCl1O04
 7I2BLxHhPxigLI5GU/qVqM95qbhygkQoMFsyO/Bp7TXZI1Py0z3ixoJ40I/J4B8NVv2X
 a/yg==
X-Gm-Message-State: AOJu0YykVyHizHXeET1HEKkIzddPpL2rzqhUc8oXVTsS7TzELDwmK1UH
 BKkHiVPqYGLo1lQcdBQwvDd4i4GuLkaFvP5rA6OyrLCIKstCQtaQCrK0czDCpPCyu9w=
X-Gm-Gg: AfdE7cmyuyuAdjSBIpRofMhbT+/g00VeL9WpES22oofK0SWAa/YqysqwKv1MV/dyNxJ
 D7vKcoo9O8kvKLO/VtLDLQfU5CM0v2C7G0AHWsOnUOLavPtXU414l3s/+mLyJzLPUGP7GTEaUBZ
 VbyRonkYV1OmoH4binHbzZlNzUG1o1k7z5/ms0B8jo8+viwI48pbKUbucU7I5ouGGObBI7B4xkQ
 a2Mp7G6qOofyNsB4UXvBamnVOZIHRmjmnnr1pXnn1P8qIincga0qlqyWzahwkoGhTE4hf1gedZz
 RRczp4mYmIB4Vm/wt6VXWDZmqwe/vy3HacDwPiEZ13OmFfdz4E0Fg063f/RCXwhOEBgL/IaGyAx
 C3ax/9v2ZIWMs8/5d9PJ/Tx3NkRXoN4CQjzYovuYLDIp6wDCMvhPSWgOJUK34pRX71PSJRgn+Kh
 42vqJv5lK9J/gc1Iblqs8jXMQXp3z92P+EpD5r468bLqgfI67K5EVhvTd5ynlfSP8Kob3PxlxvC
 Z5AKSXP6MJxYdH5pBeceTrtROmNSNylDjCf/3DgtDqMprDA
X-Received: by 2002:a05:6871:2e9b:b0:41c:de1:b21e with SMTP id
 586e51a60fabf-451637d2defmr2259605fac.11.1783534156767; 
 Wed, 08 Jul 2026 11:09:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb559559sm17525622fac.9.2026.07.08.11.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 11:09:16 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:09:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/3] doc: CONTRIBUTE: hint at different kinds of
 contribution
Message-ID: <20260708180914.GD749385@bill-the-cat>
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zVpj5vlPNTtJlUkc"
Content-Disposition: inline
In-Reply-To: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
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


--zVpj5vlPNTtJlUkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 07:21:12PM +0200, Quentin Schulz wrote:

> We could benefit from having more reviewers, as well as more tests and
> documentation, so let's make that explicit.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

A good idea, thanks for doing this.

--=20
Tom

--zVpj5vlPNTtJlUkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6SSQAKCRAr4qD1Cr/k
ClDqAP9XpX6stOM3WfLnjP5Nc186dIx6CmPykX1bY+/QZwQCqwD+MEmN+RPs9Lh7
a9VCBadqieC1Hn31HA/LqdIZcovpIQQ=
=Sh9w
-----END PGP SIGNATURE-----

--zVpj5vlPNTtJlUkc--
