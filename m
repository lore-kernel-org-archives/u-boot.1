Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C7C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 18:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471D9882F9;
	Tue, 21 May 2024 20:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n2beqFhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F1388335; Tue, 21 May 2024 20:04:51 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD038828E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 20:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a0ffaa079dso780546d6.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716314688; x=1716919488; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YCyhoQI1ozWSA3KP4F4xzq7NugoV+yf4KZVYkP7HaYg=;
 b=n2beqFhQHcuepZLgqXwLyUV33IdAUHXgzGT9jzA+c9zw3dIJayOQyTvAxEKgTSwE0E
 pjYnakl+C7P2fClxYzmc9nH36yDu7obutpb7mcFQV/ZEHzv7vYpIusqTAmF11YRWLQmC
 0AEw2gJbDFZp73cEmptX0+w1VpQxoR5+yrvUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716314688; x=1716919488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCyhoQI1ozWSA3KP4F4xzq7NugoV+yf4KZVYkP7HaYg=;
 b=YHe/4YtHhrlHzZ+osxnpf+Rp/GPXDKA62pz5B5/p+ihC8g0pOYwXe6CXI2jlhAr4Je
 QbaBuUI9971WBYk6CIOIBzXyuR/xo2o2UE6O5m3HE3oT5ikBShEFIcqruDrarI671cRU
 dNKO6xlMqlDmYAPDItA7XdaacHkmC+UDCqLL8m1Cbsr+a4qRU1Jkh6H/tfBgV5Zvywqb
 xSU/PMp5X6hpbsMPXJQd0zZTaWmX84tY4/xciKCNC6IDyVTVUfF8zF9/3JFdEzMl7AAS
 BZX+6Nijrmkvm7oMIva8w9uCIctOd2eG3efQ+9kmJWQ+eDL2kx9FiXS+fKpAsxUysxq4
 gLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSspCSIQiD7qpLjMx+9hTYWr+bnVJ3a9CmPjxWq1GfjyXS3o/2HoppI1h4jcdTeR1ikmLVw9JrzBQaLiY67SpBSp1R3A==
X-Gm-Message-State: AOJu0YwB2IiACFnnb49nLbmysHSTIVMtqyR7nB+isBpMGmICYmEyiMJv
 sh7igGU5TWE10Dvosy64+Pm9cBSGpmbUFDjxfIIRtU/KjRBHcgDPdZNvgBKIkS59YvP1um8bzy3
 9js8=
X-Google-Smtp-Source: AGHT+IF2iR7ehLOfm92mD6hrUaoOEcJGF5WU4yscRp9FWj4TkQ0fwTC1kABlRpHPJ5enUETScYO9yg==
X-Received: by 2002:a05:6214:4a01:b0:6aa:5f44:9288 with SMTP id
 6a1803df08f44-6aa5f44939amr119152916d6.3.1716314687764; 
 Tue, 21 May 2024 11:04:47 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd35bsm125251736d6.87.2024.05.21.11.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 11:04:47 -0700 (PDT)
Date: Tue, 21 May 2024 12:04:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, jonas@kwiboo.se,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 00/10] rockchip: px30: migrate to common bss and stack
 addresses + UART fixes for evb-px30
Message-ID: <20240521180444.GC2568172@bill-the-cat>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f1eV95JMANQ4Z3er"
Content-Disposition: inline
In-Reply-To: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
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


--f1eV95JMANQ4Z3er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 07:39:53PM +0200, Quentin Schulz wrote:
> PX30 Ringneck ran out of memory in the allocation pool of U-Boot proper
> pre-reloc. Something needed to be done. Jonas did migrate a few SoCs
> already to this common bss+stack addresses so it made sense to follow
> the same route for one additional SoC: PX30.
>=20
> While at it, also fix a few issues related to UART on the PX30 Mini EVB
> I could test.
>=20
> Boot (to U-Boot CLI) tested on PX30 Ringneck and PX30 Mini-EVB.
>=20
> Thanks to Jonas for hinting where to look at.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (10):
>       rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30 Kconf=
ig level
>       rockchip: Use common bss and stack addresses on PX30
>       rockchip: ringneck_px30: Use common bss and stack addresses
>       rockchip: evb-px30: Use common bss and stack addresses
>       rockchip: firefly-px30: Use common bss and stack addresses
>       rockchip: odroid-go2: Use common bss and stack addresses
>       rockchip: px30-core-*: Use common bss and stack addresses
>       rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
>       rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
>       rockchip: evb-px30: make UART5 the debug UART
>=20
>  arch/arm/dts/px30-u-boot.dtsi                 | 16 ++++++++++++++++
>  arch/arm/mach-rockchip/px30/Kconfig           |  8 +++++++-
>  configs/evb-px30_defconfig                    | 23 +++++----------------=
--
>  configs/firefly-px30_defconfig                | 19 +++----------------
>  configs/odroid-go2_defconfig                  | 19 +++----------------
>  configs/px30-core-ctouch2-of10-px30_defconfig | 19 +++----------------
>  configs/px30-core-ctouch2-px30_defconfig      | 19 +++----------------
>  configs/px30-core-edimm2.2-px30_defconfig     | 19 +++----------------
>  configs/ringneck-px30_defconfig               | 19 +++----------------
>  9 files changed, 46 insertions(+), 115 deletions(-)
> ---
> base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
> change-id: 20240521-px30-2024-07-rc-7136f6241d29

As I assume we want to fix the platforms for v2024.07, is this the level
of config changes everyone is comfortable with on the platforms? Or
should we just go with the minimum for release and the rest to -next?

--=20
Tom

--f1eV95JMANQ4Z3er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZM4jgACgkQFHw5/5Y0
tyz2/gwAgbyaWy3B9NUCXSQ0Or+RuzK5OwCShw7irLCNZV8JwWxFIqizPSjtNe6w
O2F/am9CKAYShIO7lu2+MtVD7yG+K2tUmQ7sV8Eyq+BpO046OMN0xmqwH9ZJZx7S
uIfGWioUjZOjQx1mBHmFxvEAFqeXkNvKe7E/vss36vL9mHutTcLJT8f/FfefnpS2
end34+zzUEtwAri6o+3YkRPiOvdt3K/iYz++zKOPoG/jZRh/WzS1Bl1qTSzV6U1n
jaAVIPPCGYFvPkA8zIxu+XusALajTXX90n18cZ1gqNPWXOfIuQdnM2Jv69FCqXUQ
LeUuY1l9ho7t3Xkz+BiMqpMn1vmtSWmyj2Mx1J6dHKaueiekX5UyJ88tKLsHJ/bN
SD0Uh87XgTkB1UUuo+7e99Ro9lUtg4j5J9nIcE8UxljgE70fmGuoZQMkqOkfSKXn
1V+xQhxtNA+2VnCsRI+6Wcsd8+voHxQk5Kickjgd1ClYcAE/0LNQgiyHnlbnSq5G
9DgKQeb9
=U+Ka
-----END PGP SIGNATURE-----

--f1eV95JMANQ4Z3er--
