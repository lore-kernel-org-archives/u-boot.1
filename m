Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A69CCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 15:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6DF4848A7;
	Wed, 29 Apr 2026 17:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VL/BYDsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4920848A9; Wed, 29 Apr 2026 17:29:06 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C231F848A6
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 17:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcd89701acso7282356a34.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777476543; x=1778081343; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=39ysPnXEzbFfILa4BwQI/MjlYpfRlWkeufC072zU/xE=;
 b=VL/BYDsNZUQiI1d0hOFcKhxmybLdqO+XpRHg+5UW5qxdS8NnSL/9bj8+pvF7DPRpt/
 rJC/WN2rgTnAYZKtEX7TtQvMv96BG73rtZyvqZLOF9wvTzbDHARcr3ZY23ka0nrKfd9F
 ZZl4Wpfsa0qxyzeeETpgpkNM7yesaOSoeBMjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476543; x=1778081343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39ysPnXEzbFfILa4BwQI/MjlYpfRlWkeufC072zU/xE=;
 b=Qf28IMYQb82q4L+9nsYbADYYvRCZtK2+2d13McRe5hcZQT+6l5ct0FHc1tIISfgfFu
 z+bJk5AjuXpXHjcSEtCddA4i5yPvxQyQZxBJymk9QORWtMf3YBs869VcLczvoxLs+Pv4
 wKTda5/TvdD9Mz/Qx9+NUkMXTdP+ge+uQw+ig8ASubiFfCue5fmbVdb+Du3kY3Sfc4tk
 z/cJkLD9DJbEuZDa1GLJdNY6qajJM7hS8mm7D7QwEG8nZhtN8xY7qRDfazYgUaAHbHv0
 hSuhSylOEVtfCM9BNU0/WA07ZAhbD8ZV/zwH2cvLIHxP7Vf4QPoiDrOykVOa3Qd6Nwva
 DH2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g2crje6HObqflOSKvjK2XHyXHaKkjpsqBqQzbPDt7JBoyn9oNG/Nj09ypWqZXZj2adJ90isA=@lists.denx.de
X-Gm-Message-State: AOJu0YyqRo2PIzfRJVi2v5H5NDt2Irp4r5O6NoH5tV2Fm7U4oeRufR1j
 11kFpMvthC1S5I4v/4DG0LBTBCGCJlzUn6MLah2K7x/JcbN51eH5pJvAU/9WgGFNdc4=
X-Gm-Gg: AeBDievDx9oiJJxCHY1jna8a+KR4Rpi0W0k2P/u7E2RUi7gis6bGE79EyA4N7GqjP0h
 02DtbgiIeM2stphS4A2+3kB8EFiMznD8oJipjNhIKZz0g5jW6iPuCGO2qPE00//eRDmBjIepZXY
 dG3EbRFvau0PckZZ2HrGSKJ5WtWh9SbGdHAc0ETkjhw21lrIu4wM17sYDDKBFx/361UbwdbJVAn
 XkvgvHP3tq1sda31Qeucb8V5RBnVivtdDd/64SBqt9f19LIN4iPa46JHZDspKTDa2Ftwcou2Uga
 dVFwkeP0pRwcVO+LhnpSKUk0aXXKDPWJ5Sn1gkwIMS+YmSgpyDHf0ixoJFF6wSf5c3gD+FjZXi1
 eKG4uG6xBwqwOeduxMJ4pcrrSKqqL4BHvLRw8tACCcgwn/3lWi+hXHqXYbhRnhZNbg0iPUv77eu
 QWFc5WWH6ZuNnrm21SbkQTd8u87QNfhOkwo/7gSXq7Ya27JjVhGhl9SpBtlUi2NQg/4DeieJx5x
 1Mo77LsrdbZtW8Nf0QyFjCRxfMOW61h+EArLaXlWmjVQDW90yK1UNrileEDsw==
X-Received: by 2002:a05:6830:2403:b0:7dc:cefa:1c20 with SMTP id
 46e09a7af769-7dea6227849mr2753086a34.0.1777476542762; 
 Wed, 29 Apr 2026 08:29:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab7ce1a1sm1511643a34.4.2026.04.29.08.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:29:01 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:28:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Pramod Kumar <pramod.kumar_1@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
 Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 09/10] p2041rdb: update README and fix typos
Message-ID: <20260429152859.GW41863@bill-the-cat>
References: <20260429121816.1026326-1-mwalle@kernel.org>
 <20260429121816.1026326-10-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O72d2beOsFU8loGq"
Content-Disposition: inline
In-Reply-To: <20260429121816.1026326-10-mwalle@kernel.org>
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


--O72d2beOsFU8loGq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 02:17:23PM +0200, Michael Walle wrote:

> Nowadays, u-boot can build the pbl image itself. Refer to that image in
> the documentation. Also fix some typos.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  board/nxp/p2041rdb/README | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Thanks for getting this all working again. Would you mind doing a
follow-up to convert this to rST?

--=20
Tom

--O72d2beOsFU8loGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafIjtwAKCRAr4qD1Cr/k
CmyGAQD8ita+PwcW+MoQQFC8KA1F1jCTyEE3/uKViirPfFBsrwEAkBjK9EjycHza
tE/VbjmeSX2zwK6AuwZqWZRZ0EdBKgQ=
=vw/6
-----END PGP SIGNATURE-----

--O72d2beOsFU8loGq--
