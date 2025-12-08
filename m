Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331F7D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 21:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A813083B4B;
	Mon,  8 Dec 2025 22:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ivJxpM6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30FB683B71; Mon,  8 Dec 2025 22:10:21 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C35183B32
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 22:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c7503c73b4so3202226a34.3
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765228216; x=1765833016; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MdeW0+OOuLs8PIaZJTCbbhKVZwRAG0X8zYIPbcPJiFY=;
 b=ivJxpM6nfyVnSMJroTVSZyLpclIh2RyAyHy9BP09FAoOPlbn6x6G3Kcd0lk/l76P1g
 LbU1i7NdjuuuhfZc4EJL21bQ2H4cG4u9WCZftpkOEU4N7BpzQeQTmgjULSLj0W3GMB0N
 07TbkgCAOTiSMSnhc1P4FeB26+kSVFrx5Fuds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765228216; x=1765833016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdeW0+OOuLs8PIaZJTCbbhKVZwRAG0X8zYIPbcPJiFY=;
 b=n2DuUIwFfU1ZZkXAju+UDcKFU3ljD+HYYup4eDQciQ9iLYl/WcoJdVURhlMLT5Z6SR
 e+KUBLeWd7oszblbG5poY9pJDYYfyXBaUy8cX9waoXr7x+lPBedBSfVPrgUWZZAxO8Db
 ZLHAbcKoa1B17HDcmNI/yjxmqhhFIrPVrFi09ABQSQZiCXieakB+J59Mu2/973J4B0Sg
 UqLWuzeXlSlGaOcsnGOr5/8HlidpBm+qcyONW9hC+j/2tR432DdSk+bBF71nWghmAeF2
 E2KBgcp1uqIvNcPmp5c9rk3cpS0SenXABzolICf1EeUvBFbge3XZ+oI1V3C0lfURywxd
 2rew==
X-Gm-Message-State: AOJu0YwlUqGDjXARWkvh2Gl64+xrNgHNYlGlxq2XTqOTOpQi4Bw4Ipna
 3leg89UKELWhS0LQwPTAGFeBBjsg+Y9AsDbOxb/HS07eC0ETBbC2uAYkcFKbwuWB6OtV0L7db8j
 p6JbWhMA=
X-Gm-Gg: ASbGncsb8HaZ8aB3wBk7+hEPwvqkkvs9SF4POGC0BHDBN+gp4FmUe62W95QgYJ5TTTO
 aabtQ/qoPYB6xizfLwQ7XQ6ubm8CuhAKIMUs+xZyXAwVOKLo9O6/MjeqvZA+y0uImMDaRLBRZUD
 an6O5no6LAqe4mk/Dqx4Vewv54QTiyI2Lrs0Nf9gj8iwcDzC7Bv3aUuL4Qu79tizkxDSMsTwjeu
 f3zZdLCjOFnlwTzoa82Cf4YUtPYGqtzGoPheJvkY6Pn6h0iEJVLlSiyfEYNmqk/Z6hT25vFCCde
 mz9mIbzDaj7pRpz8o8FxGSicsTAVIKfTwpXxfY7rCeCY9KjqeQdTKcVaidIOO24ixsofmpFS9so
 je/qhErA7ntrSxLRz50SOh+0EuiGQQ9sdBwv7VyWUsaCp6vzClK3UBq/NEmRxkgC2fw0Py8iXgk
 j+BuSFRK6C2kT4cRQRE569CY+grEf4YZK50QTjjMkZUhC0dWZjJw==
X-Google-Smtp-Source: AGHT+IGRmT0UdI3lHFf2sCfNAwcmsnzOYDL5r4sPTRq12J2EN6fXVQ8KirbEVrNuNKRiTGdfPBCTHg==
X-Received: by 2002:a05:6830:2b0d:b0:743:8af2:1af7 with SMTP id
 46e09a7af769-7c970827be2mr5953330a34.23.1765228215892; 
 Mon, 08 Dec 2025 13:10:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8f99basm10861636a34.6.2025.12.08.13.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 13:10:15 -0800 (PST)
Date: Mon, 8 Dec 2025 15:10:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] spi: designware: Allow disabling designware driver in SPL
Message-ID: <20251208211013.GU303283@bill-the-cat>
References: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p7/QMPVlTiu2Yi40"
Content-Disposition: inline
In-Reply-To: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
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


--p7/QMPVlTiu2Yi40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 03:47:06PM -0500, Ralph Siemsen wrote:
> To reduce SPL size, make it possible to exclude designware driver,
> while keeping it enabled in the main u-boot.
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  drivers/spi/Kconfig  | 8 ++++++++
>  drivers/spi/Makefile | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2afb15fff1e..94054ba39b0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -223,6 +223,14 @@ config DESIGNWARE_SPI
>  	  access the SPI NOR flash on platforms embedding this Designware
>  	  IP core.
> =20
> +config SPL_DESIGNWARE_SPI
> +	bool "Designware SPI driver in SPL"
> +	depends on SPL
> +	default y

Sorry I wasn't clear on IRC, this should be default y if DESIGNWARE_SPI
so that only platforms which already had been enabling it will continue
to enable it.

--=20
Tom

--p7/QMPVlTiu2Yi40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTc+tAAKCRAr4qD1Cr/k
CicQAP4zaT5MmACUKBilP8Oeq7vRorPikLp+vIHrqwmrgrFkUgEAkcGnkj5d6GZ7
8GGm5M0BU1O9A21ZhHbLLpIWlF0VKw0=
=l9nV
-----END PGP SIGNATURE-----

--p7/QMPVlTiu2Yi40--
