Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD0C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A35800B3;
	Tue,  4 Feb 2025 18:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BHPf0Wg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F4E801BE; Tue,  4 Feb 2025 18:56:20 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EC280040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f4c111991bso18563eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738691777; x=1739296577; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GMfIn14A6S8PJIVo7yGB5pWnWKxY6DGr3xm/SeLpFs4=;
 b=BHPf0Wg1dHzNPuPXegm48/3GD2PgpC/khOnJKwdYMKLSBV891EzqGWx12Z0WiFgHW3
 oav/Zncj59GzHQyr315FoD3YI5JQvGUliAWisrr+R2/vJkBlPvYA1KqJ2XhfXgp9U8M4
 Olyk9F8zzU/OocTjsQwEAKDYoJvBMG2J3ZWws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691777; x=1739296577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMfIn14A6S8PJIVo7yGB5pWnWKxY6DGr3xm/SeLpFs4=;
 b=D+SF08cz+eOqUdxp7aaxHi/4FazzsDHB5Dm+uNDd6HE1i3cjTlJ81osXlLXEYkrAV3
 SyjhQnE0SlVf73bdQQCEYHXpg1oLral1X6OUc2vgop+dY+fXd+ggLrV+tLbmVClisU7b
 JuHc58DpAUxfVBa8rkEIMmoBIiPTo+cIP3IphnidrXjfTBTd3uQLGB9azh+k49nx5HHO
 n3i2cJM7L1ilJXrv75vhC/vRU9J9QKRTguscah8PA7BpZisC1x7RRWLkaKvcThAF2Sz+
 AzQh2eZJ7Jbe+efkgOlHW3k95NipOD5WC6qqHm8VaBA4lqefURPAdGaDXwDT4qBv2PV1
 XeBg==
X-Gm-Message-State: AOJu0YyHzCB2dqbztr4IbBx9tb8pX5QEMzMH+Al1d1Pyv4J9BoNBLinj
 3B0Kr2lY0USeyYrh1OiuiPwyixAS57NnwRKOsWItv+qAGVO78VUM0Emh09liOsI=
X-Gm-Gg: ASbGnctSPf2+sRuwJWiygcR8tgnFD/1reRAsVbQEjnXG5MaR64FiUotvsvm6YQShNdk
 XcNKQGKpl1foGd17Z76ILN6Qb4p//T3xiYHcCObPsXtiIOTdo59e00+i7RoDoFT/jPOOZn9lVZ0
 vtTHTJfgqCoGZRs6HNNrMVE6fx9czCxr8xH269HU4jRqqEt1y7EDyW8uwHIviEtfCCdPeV2oPb9
 uW7Ibmz6nz14Us6t2uMiUg3jygN3zTuXgzR85jQSshOb+fQUXVx/YPX57ifArWu2iqA7hi8cZRi
 zWIuc6asKt7UA7M=
X-Google-Smtp-Source: AGHT+IFeIzMtFUbyctf3xmqib2+3ytklYryHcPzc23CEs8CV5vkT7n7e0NF6s35YCjec6h97sQQ0Rw==
X-Received: by 2002:a05:6820:4c08:b0:5f6:a2c6:fea with SMTP id
 006d021491bc7-5fc3be0c104mr2683542eaf.0.1738691777033; 
 Tue, 04 Feb 2025 09:56:17 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104b31aesm3231847eaf.5.2025.02.04.09.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:56:16 -0800 (PST)
Date: Tue, 4 Feb 2025 11:56:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, n-francis@ti.com,
 nmorrisson@phytec.com, d.schultz@phytec.de, d-gole@ti.com, sjg@chromium.org
Subject: Re: [PATCH 3/3] configs: phycore_am64x_r5_defconfig: Enable
 PHYTEC_SOM_DETECTION
Message-ID: <20250204175614.GA569207@bill-the-cat>
References: <20250127041612.985929-1-w.egorov@phytec.de>
 <20250127041612.985929-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PFw58Y7+Z09saJgq"
Content-Disposition: inline
In-Reply-To: <20250127041612.985929-3-w.egorov@phytec.de>
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


--PFw58Y7+Z09saJgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 05:16:12AM +0100, Wadim Egorov wrote:

> Enable configs required for detecting and fixing up for different RAM var=
iants.
> Also resync after savedefconfig.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  configs/phycore_am64x_r5_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This introduces a failure to build in CI:
board/phytec/common/k3/board.c: In function 'fdt_apply_overlay_from_fit':
board/phytec/common/k3/board.c:203:47: error: cast to pointer from integer =
of different size [-Werror=3Dint-to-pointer-cast]
  203 |         return fdt_overlay_apply_verbose(fdt, (void *)loadaddr);
      |                                               ^
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:257: board/phytec/common/k3/board.o] E=
rror 1
make[2]: *** [scripts/Makefile.build:398: board/phytec/common/k3] Error 2
make[1]: *** [Makefile:1918: board/phytec/common] Error 2
make: *** [Makefile:177: sub-make] Error 2

--=20
Tom

--PFw58Y7+Z09saJgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeiVLcACgkQFHw5/5Y0
tywMxQv/ZV7UrtmFqO3IAFbPKCZz1qWNEO39+hm7FEQKaLk68MOCnlj9hbUaMqBR
MPKRj1i43vFjNmOArrMQf+ko4DTKqSyxKgtwzOfznI8pOQakTdg8hVhyaOi43Qe1
LtvkhjYEeeftSpkfZwPczSK6SL507PPC/Gq0yof6ZuGaQqg59tINqJMR4zFCPPIq
W04PlbNBnLxUHntlZ5Eht/o3nKxvuL96C+jPeWEWXjwELOfSD3DgyjCw8hN3JVCW
ejIDQbvSUdH+P3Ra3eyblEuEIxNRzIVHuSu2d26L4HZ/u3q49whT1VLZWwqT1oJ+
BFD8bii3PqAtJF9woLI3bnE06dtxG8U1RsNP3xJFT4fKRMzd1XMRNu4H8xTyvBag
3WeJO+0V8eaG9j8g6EJY1uiLfz0hENWFdyRdVGHg0Ghc373GmX/jqCWvASkm6YIf
PyFtfEntP/68GYNv4nR0K+7a5HM8nfMiuUuQ/5xJGlGDnciGdCl3YQO78jfB93K+
oYsiOqgL
=5Zj1
-----END PGP SIGNATURE-----

--PFw58Y7+Z09saJgq--
