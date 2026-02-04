Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86884E9D407
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 16:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149AF83015;
	Wed,  4 Feb 2026 17:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y7OlyWHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6769838FA; Wed,  4 Feb 2026 17:13:52 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAE880086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 17:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40974bf7781so634817fac.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770221628; x=1770826428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2bh2vU6tUqcwQc4Dy/nFvr1WyoNQyzDwWCbCigIxfGw=;
 b=Y7OlyWHevPBsMJThuySjBAxPbSUJKt5bRSWaC1s385cMLBMZLW2DmzGrF8yvYkJ9d7
 Cyts0bVeZwQi4Dpj7h6Fdgg1Yj9lBfhzY+zYA+fDy6vV3sdUQtPqDgowjdRUoH4q11gZ
 Fc+SIaRTnv+T1YE11q+ny/we4MdbOGd/wavLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221628; x=1770826428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2bh2vU6tUqcwQc4Dy/nFvr1WyoNQyzDwWCbCigIxfGw=;
 b=a0WP0/G7PMD8PASkyg6gY3Psa7+Up4r9UtTsAexjjTYei2a5No3er+aGIzfef6q/Ay
 Do0R5SRlhJVGykGDjeWfHiq54CyAiAA3gK4cXGU+Q2ZK0fhB/PH2NuPH/ukcCrMR8uRC
 ArHknxyMVIYeLvIzW8qg+ya8+b+fnSZoBXtkWQxFRrpX/QIOECP2XDXSNM9gEn3NCl2b
 RB78Us1uFmpnWY7Pt9f938ZP3vhS7XUD5A1UsU6mj5dkSvOTgNTHpFg++6OzARNCg/Jb
 yuz5Q6A/gj7x686JP5ysVyEV5cGAkI8WxnkkbukVIcL0DTnp00YyYORgi4qvuofUf1Sr
 1SUw==
X-Gm-Message-State: AOJu0Yw1y5VORzKTvjGMTibWetMPasyN3+appcmwAaLAOYZgD+mw/JYM
 M7C0HaQS5PqmaglstsMHpEht18zYjqY3qdy8kEB0NqIg49s8u+kzXhVtLMenAlUtfG4=
X-Gm-Gg: AZuq6aJ5wHRrEWfbqEj6aKGYO6AwUTQl/7Du2APKX8FT5O6kZC4KBomjT6fDjwvaO1J
 M55cjTJ1VYGZw8wJkrVWv729G08bTvVmXDi0MNCzUQzDDh06WaUdrpU6oesD+4VUBSxzZICQj76
 CDR83Wstr2+BJ1DauQvg+Llf3dS6wy9s1osolvwfyOP+xjFxSAhGaPy3L2yPmWYxGld5zJCxIKV
 pvCCFqYWw9SV3Y0fQTmFm/6wc6xY6KPpUbP4XOMtqIt1x3hTfD14Rv5oPvKp6z3wOJwUSPOTrEM
 dYYOleBqpvsNiruBc6U0zyx+IBMB7ITTH+8kckDsiLfMiaPfGOs0O1gliNcz+aIiUXj1yTyholQ
 cEt459Sr7ls3R7EX67V/fcmeQN6VWlrBj27JgLHcBhi1KJLaG9eHtVd/Adi6P10qYb26/9jkdHY
 V5TDLRr10W+L9ihC8nzf7CpF30PS2nAJ6jHLt7Pysa5xDnOGLDk+c6sEQuAtgQVYZRF5F0i9l3O
 bmUGbePqBAQ75UNDsq2TrnMKEP5PPA8S+O3hVA=
X-Received: by 2002:a05:6820:290c:b0:663:1400:1894 with SMTP id
 006d021491bc7-66a3308db80mr1429370eaf.11.1770221628011; 
 Wed, 04 Feb 2026 08:13:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35d7b8ddsm1543791eaf.15.2026.02.04.08.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:13:47 -0800 (PST)
Date: Wed, 4 Feb 2026 10:13:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
Message-ID: <20260204161345.GY2603314@bill-the-cat>
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e/X9lIsy7ZzFMH3Y"
Content-Disposition: inline
In-Reply-To: <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
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


--e/X9lIsy7ZzFMH3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:

> Hi,
>=20
> Anyone have a chance to review this patch set? It is the last piece of
> work to support all required SMBIOS types in U-Boot.

I've been waiting for Ilias or Heinrich to have time to look at this.

--=20
Tom

--e/X9lIsy7ZzFMH3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYNwMQAKCRAr4qD1Cr/k
CuEKAQCdb87cRd0HsQv8EOhKvF+FBNU4+nxZZSMVoPTp+3TsmAD/d6uT47halwrO
YyemAci7IqoZEt8pegQBBFm2qgCy5Qw=
=pK6x
-----END PGP SIGNATURE-----

--e/X9lIsy7ZzFMH3Y--
