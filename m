Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D933E7E636
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF0D86D6C;
	Tue, 26 Sep 2023 15:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X5mOET37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCAD86D76; Tue, 26 Sep 2023 15:48:13 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B19086D3B
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59f1dff5298so97828627b3.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695736090; x=1696340890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PDelsOiAsJWOH/K+meXQM1SKR7yiAb6r3/70gPBPJXo=;
 b=X5mOET370sewzTlPaD9bRmr4iG5kcw/pyCPOYg1GQWGdWsBnUfEcUX7XPlghKL9meA
 qIQ4dwsFUgEfcwWD52u8p9cKdX7GTUFl2oHb80DuOCHByig69VmvPUzNKqN5QC2pM13y
 W2w5mSh0YF1At/VtOkbphW6RIiPhypTJEw1/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695736090; x=1696340890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDelsOiAsJWOH/K+meXQM1SKR7yiAb6r3/70gPBPJXo=;
 b=eMPwfsXVIj+ZU7XCbEJSm7zV+B0WSUpAyoc+YLGY/OCLVCebl5QFiudx5Hvc8Zqu0K
 +mV1DgHkQAw7FP4l9i2bBpmzR+bpPJGwIrNbR7dPQV8uHdHllV0a0OlgnaWZ1vTwlx78
 HoqO1Asp0yDTQVhAU1suM7Ylwq0GXAD6ZjEocMMAc+93/ibegv0GtUdpD7oe0HnqR4D+
 4WiLT8CS9uBW272WqFlbbxmjTdm1uWTIngEVZT7pvhQ7aiylNihmkR6C8DCYJVEOHzdB
 EtjR8uvZX5yg5s1pWY3Xp2xZMmh9/f73FLGqjhVm6SGLyxtxfq/AC8nSX43WEsyzjkV3
 E7FA==
X-Gm-Message-State: AOJu0YwgCikRhNXyYIINPRpRgZeuWJVfQXnYYqYA7rig555wCihsRibf
 8aydHwmt4IzqT9fXPn8P8lKxaWYa5IF862WTbb2JZg==
X-Google-Smtp-Source: AGHT+IF7I5aIuf2aTLi3Y50aHElL4KtGRaorCFZidfS/ieZS3Rw6GXPcCEh0MYuNNGU4oyHcbmM7Tw==
X-Received: by 2002:a0d:dec6:0:b0:59b:a2a:2131 with SMTP id
 h189-20020a0ddec6000000b0059b0a2a2131mr8220082ywe.31.1695736090127; 
 Tue, 26 Sep 2023 06:48:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a0dc606000000b0058427045833sm2997800ywd.133.2023.09.26.06.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 06:48:09 -0700 (PDT)
Date: Tue, 26 Sep 2023 09:48:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
Message-ID: <20230926134807.GT305624@bill-the-cat>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KJ/LieyOCjXc7Yy7"
Content-Disposition: inline
In-Reply-To: <20230926085651.395069-4-JJLIU0@nuvoton.com>
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


--KJ/LieyOCjXc7Yy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:

> do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
>  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach-npcm/npcm=
8xx/Kconfig
> index 5f4a0506dc..163e7e7d48 100644
> --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> @@ -6,6 +6,10 @@ config SYS_CPU
>  config SYS_SOC
>  	default "npcm8xx"
> =20
> +config SYS_NPCM_DCACHE_OFF
> +	bool "Do not enable dcache"
> +	default n
> +
>  config TARGET_ARBEL_EVB
>  	bool "Arbel Evaluation Board"
>  	help

Why do we need a new Kconfig option here on top of the existing generic
ones to control cache?

--=20
Tom

--KJ/LieyOCjXc7Yy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUS4RcACgkQFHw5/5Y0
tyypCQwAgBi8p6XO9zBplcPlL5zC2prjXFYQINjnzwR+0Cad9ckdVNyF/z9kDzqx
sqOhrGd235rWxO+hAU3O72tjUp9c7BqcbhK+vlkPktiAKMLtyDOfd+NUXM+VwZO8
tyvKAk/EYBREbpdBE14zHI0AAeLsy+DUMgjjWWvyk76l+1ApnNkoxQBQzpL8oa8h
AP8gv8Rc5LC3KuUuw2Uxy1ZiNUHbXRwdwlxSHJcu8uyccWGJQwItoVJQPBqD7HNl
o8P5hs8VxNqmopG0SXFClFsHQUj6NgdtaqNpWz+SiLOwSr7fgAIUakIw3LcQyR+c
kw1er+qBtDgBGdJiO8ixQhfZLvFCd5UiqusQGPXxumB2edJosawGZgQNEthgBPix
bGcs8ti2HjM8f3JXxFuaaPt7M/IcsiyIy1qTIbKWsyWF8aSQEJwKrQy3rk6ZjLKL
RkURAVWHjNSzzE06+AxicLouZFnr6MAOpIfuq5YwfskL2Pj6YYL6+yZzYsPwqTmP
H+mwMul1
=wd54
-----END PGP SIGNATURE-----

--KJ/LieyOCjXc7Yy7--
