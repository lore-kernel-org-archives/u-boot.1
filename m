Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0DBEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECC1864A1;
	Wed, 23 Aug 2023 13:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oadiYaAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7984864AD; Wed, 23 Aug 2023 13:17:41 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB058649B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so7028302a12.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692789459; x=1693394259;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCKpBSKK/74xCSjS1wdvVGFqxD67ZcQ1T1Zm71rslPY=;
 b=oadiYaAClXZFsi+LJ09EZy0b4+K1AQavvCbVtDGkLWfvIJiyfRog+zLzq4W22of2DN
 I7MMSWdkQEeOP7HxoHcw715lyx3f96J8O6Rtyv2u2AIhQCTOXtmLSJ2pN/cMWizhHZA9
 Kv+O/amkTtdCaFBcg/SIuz6Wcbc/8EkEy8behzhI5E8TEZHrLiIzuIvQVF5RgRqICGLX
 7VFe6WR29sCtEoYurpMC4OTdVrjRzrLNZ5dLgpr24hzksmz4vViXIt/tH3laXGPaMh9/
 +XbDssMo1tdddhv7BO60CxIQCwl6g2L+EXQh2yCN79CQK8aBVtseM15zphYe+RmwvJt2
 ncbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692789459; x=1693394259;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCKpBSKK/74xCSjS1wdvVGFqxD67ZcQ1T1Zm71rslPY=;
 b=fptcQ9p0Bb5RbB3T+nqPRoS4mWA/Lsq53W575/Zr8SXsmF98CeIGQV+JBK2PLsPbsy
 xKLPGGW/29JveOi9ScE1tPSq4WLJp/eFeNehOInihwQ9dSWNlSZpM0sLS+DhNTD/CCYf
 uRFstwY1PqduHX8D/Hnj4nMq9QZiuidzpY1nSU8LF/HKUD+T6Ycc4SNcJ70j5LN8I3c1
 Ju4uwavANx/WxmMdCrc/OlqzVZ3iXbPk3lw2dQB1PFN6cbciuorHvbDdnBpLmggHGdKF
 Cq0D1CX5zSsFWLCIt8LKcSsxpfv2m9BKld50AK3uldMzuRAAdClo2D0WH6pB9RNdFLu/
 4llw==
X-Gm-Message-State: AOJu0YyZWEiQ4CCQ1k5jNI51rDuG2UZ9NjOWmiDTExEeqEO9FWQ17/ac
 hQ5F3rdvOajCLRGbSstsB7E=
X-Google-Smtp-Source: AGHT+IGyWy9+wEOHMHEIEwBGous4kEONxoO6QJ+r1EmFPmnRL2AHYga5Q1hRrVS9lxQc3F88V5Ch9w==
X-Received: by 2002:aa7:da18:0:b0:523:1901:d19c with SMTP id
 r24-20020aa7da18000000b005231901d19cmr10213898eds.24.1692789459206; 
 Wed, 23 Aug 2023 04:17:39 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 q6-20020aa7d446000000b0052718577668sm9060336edr.11.2023.08.23.04.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 04:17:38 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:17:37 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 17/19] ARM: tegra: dt-setup: convert TrustZone remove
 into config
Message-ID: <ZOXq0SrF9h0Z9uHw@orome>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-18-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6ibW5cLNf5RRlzkr"
Content-Disposition: inline
In-Reply-To: <20230822112217.4646-18-clamor95@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--6ibW5cLNf5RRlzkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 02:22:15PM +0300, Svyatoslav Ryhel wrote:
> Remove of TrustZone nodes is required by many product devices
> which require repetable calls of same function from device board.
> To simplify this, TZ remove is converted into Kconfig option.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/mach-tegra/Kconfig    | 14 ++++++++++++++
>  arch/arm/mach-tegra/dt-setup.c |  7 +++++++
>  2 files changed, 21 insertions(+)

I kind of preferred the original because it's very explicit. There's
also no big advantage in consolidating this because the code is unlikely
to ever require changing (the libfdt API is quite stable and these nodes
are all hard-coded anyway). This new variant put non-generic code (it
requires a Kconfig option after all) into a generic place, so it seems a
bit backwards.

Thierry

--6ibW5cLNf5RRlzkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTl6tEACgkQ3SOs138+
s6GVTA//d1UR1duTkctKHgcemhmR6zSX6JfdDHIjEW7vNHUHg69Oqgp679/Soxah
5Gfl78HkW29sL9j3MCnW7/Hy4uAoY6zT9UVZOJ4UMXj7V9PGBTUPORo1yUVdv1Q7
GsL8TJOiLL8MdBO198ZSGemChVaAphQSsgd+fZsEPF4z96ORG11wOa3K4TochTwl
R0BQYgX0mqvjNHvA+wgqbFFSjwBefpjcBj7voFrqRxkO91je1qRZIHprG7yNMbzh
L9U5XKobMLI7iS/DeWVYlrqw3nUAC73ENNtj62c979ykzGL/j1frYSu8kHBdeASg
t11t38HSi5jNUax6ANinov9xGmFeOeilVwVj5ATZuXph1zn27VtoQhWP5krsD106
W8MwmP2SWWVqa4BRFmCD281HD1lhVfXBx48A5ybvshSCYnG/CY6CsR05U99mZuw9
VCbzXYXwWCaf9FV7dWtPIbnIlJkTJlxSngyrQrjiWEOZ5qnYSkBaE+AXSOdP2Fnl
BJg2dk3LbdroK+gFLYFlX87a5ZHp638EQ3japk2zOU4Cb/gDYca56xexAv6RheDB
IT6hM11f9jZEIfxD2RvHCC+dxDgKNelg1E+SXOvVgteEFN/T8WImHRHuZGAE4zYY
USgjsHX0VTbgiZ+YW6XeDm+6AHi2UhWO3wsThVuWNe1X5sooJUg=
=s5q5
-----END PGP SIGNATURE-----

--6ibW5cLNf5RRlzkr--
