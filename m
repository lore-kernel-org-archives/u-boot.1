Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDFFD7789C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 18:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A3583AEE;
	Fri, 23 Jan 2026 19:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A31/+v9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF8483A6A; Fri, 23 Jan 2026 19:20:10 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFA583AEE
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 19:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4041b3c1fa1so817140fac.3
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769192407; x=1769797207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YwVz4PHiuyotbgGPEv6+Sc/bVVpAAy/9zrsHq3g0SIQ=;
 b=A31/+v9s8KLOiMjf2zw+bst/V4wmm4DVfxZRZ7/I/bRT7ulcgecUAhkzD9tK9KNZeH
 +lFS6E+4QsSrA8FgU/H+ZVVO9NAMoROWkxvgnkuBrrDW66Y+01LsZK2e87PPPIU76fpW
 NxRzGIEwwEXaaFCPtxOpxgFHxCpKEP0NXWbtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769192407; x=1769797207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwVz4PHiuyotbgGPEv6+Sc/bVVpAAy/9zrsHq3g0SIQ=;
 b=kSwMdw+hDiAbkgpuUwIKyyKnUN6JUqs0/tKrQ4MiLXyRLtHLXNEehFZJxpDrMRhWbB
 cVloZxPumzF/2FwWawLSeSiP/ZuMYPwXEMLHaJjDth5oNYjP7Sd3ptcNGTWSEgFT0Z5C
 B+0vUVbYfIXWHAHqBlBJQqUACY8TTMNgjxhQVgGlyNCIyF+yyB0ZZbvpP5v9foP2Faad
 HIT1PQXFV03PP0KaJntomefdyRF+Jc71D1JAW8eUoEk8WkM92vRPFzXoUSu4qekHPfjz
 tqScJlOhPLPqxDQ8Ek5tEHtSxHRE59psE9JUw7sv2lg3ri7kihkDBHRnc/ybJws04MlF
 2Ifw==
X-Gm-Message-State: AOJu0YzXlo9hFqHouoqRMJSZFKAkodzny6SvJtYm8T72aU0vY8OrDuhI
 MaIUvUllcOD/vMqkK+3FjnZiSzDr9P7Rovj2fim+U1WehYWbG4qGkKbR2gsQLdAjypw=
X-Gm-Gg: AZuq6aJ42f/YQtoK954q4FKk1PhQHBvBtNtZGxQkpUlOH9vb7e7Wy+zGtAoXUz5+U+m
 ZgDAUmcuD9qEAK039XoSQoSnmi3Kd3QmYsj0lwgKPGpkTaC8bS/6GitnSJSEYGaAlrj32FzW96H
 8OskEJsVemiCkp12ZotYGukvTNIVuF9+oojJc9yxp7PoVayoniz9NHjr+TrMBxe1APjZj3sdCyQ
 DR1HZxnqlCCdEdQfwY1PGkqtaF4TlezLW0fgzp0PLiEzqG97ImYtKx0GJO5UC463mer0g5e1MIx
 LX+jsuJQKxt97SnTwV6GXu/61+icXw6HLf03Iu3Y+xyMibLpaO+bggnEOr5ifO0qrQPg7mEVjs1
 ydLXFtL3ICG82Ribj+2ArLGkPa6fbSNHVoZ2O5oQ3pHahsNmX8Z/bHiqKiN/sYnk88b9lLe17AY
 /hWWfZnc+clGvboQ5qXj2FkS+K1w0mvepjidNh6ENJCUmH06JRpaRyTZQr9Af1NeiJtWO5cCJ53
 UtKUjP90/iklngYbXo3ERqg5jhYgVJasnR4MGgGE1Zw/rRwuA==
X-Received: by 2002:a05:6870:390c:b0:3ec:9c0c:283a with SMTP id
 586e51a60fabf-408ab51ae8emr1669359fac.24.1769192406263; 
 Fri, 23 Jan 2026 10:20:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408afbacfcfsm1929980fac.10.2026.01.23.10.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 10:20:05 -0800 (PST)
Date: Fri, 23 Jan 2026 12:20:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] dts: add exynos arm64 vendor support for
 OF_UPSTREAM_BUILD_VENDOR
Message-ID: <20260123182003.GN3416603@bill-the-cat>
References: <20260123-dts-exynos-vendor-v1-1-479e72170257@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uWarxz5M7GfHqVhH"
Content-Disposition: inline
In-Reply-To: <20260123-dts-exynos-vendor-v1-1-479e72170257@disroot.org>
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


--uWarxz5M7GfHqVhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 11:41:41PM +0530, Kaustabh Chakraborty wrote:

> Set OF_UPSTREAM_BUILD_VENDOR to build all devicetrees in "exynos/" for
> Exynos-based 64-bit ARM platforms (32-bit ARM uses "samsung/").
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  dts/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 870f75ad3ec..e0f6f03a343 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -124,6 +124,7 @@ config OF_UPSTREAM_VENDOR
>  	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
>  	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
>  	default "nvidia" if ARCH_TEGRA
> +	default "exynos" if ARCH_EXYNOS && ARCH_ARM64
>  	help
>  	  Select the vendor to build all devicetree files for.

Two things. First, it's "ARM64" and not "ARCH_ARM64". Second, since we
know what the 32bit one is and it's not the same, we might as well do
both while we're here?

--=20
Tom

--uWarxz5M7GfHqVhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXO70AAKCRAr4qD1Cr/k
Cj0PAQD1V/wER02WEnIpdxCGnnOYzs9574ZPvKFL7XHEOnfgkwEA1x8J2fPGv9K6
Qw+lxpeQyYGTTQrjebl8MtAllAKSBQA=
=cgsm
-----END PGP SIGNATURE-----

--uWarxz5M7GfHqVhH--
