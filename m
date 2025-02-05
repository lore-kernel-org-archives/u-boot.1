Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC404C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4187380711;
	Wed,  5 Feb 2025 14:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uulzrEIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E6680780; Wed,  5 Feb 2025 14:58:26 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D4E8070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9c3ec68c7so2827964a91.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738763901; x=1739368701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kaia27W8T+ihM4I3HORt/IFhzRr0h8pcRm43DzXBBZ4=;
 b=uulzrEIbQidrG23W1H2Ng4h2LQXiHzQrX2lFfpGgAJhfX/SdvHccPww0DmU8APHK6V
 HCxkmDXpF4zrYc/bfgm2LPI208vGYSy9e712XbzDdvGnvl0niYVwGVIdSWZZqdVYnlQy
 ktOaNbaoIcxT+aQhijXs6ruZX5wzO7sNUxAlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738763901; x=1739368701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kaia27W8T+ihM4I3HORt/IFhzRr0h8pcRm43DzXBBZ4=;
 b=XqsP0MaKA5gSwh26u6FVj4XJMEbuUdN8tzQfiMqyhfRRGpZj3sR3ZJFRD2/LzAB/lV
 zmOL2I3j07iNrxLeSmeeZoi0Blnq/EVdWTds+Ii7mFHTpKq2BNci8/HiuFW/UBW5wbrp
 jZrnE3jdrJ0zbLP3D5UQEaSFPZTzti54Yu2XPhTxGO9JBpZBM6VkTl/DDibROIJ1mAS3
 u31YZqIIKRFKWvmZigjQYIVeIE4OvYvsnvVJ2nOYCeF3bVrajHY8IwxHyc/rAlPkBX0u
 Kfr1HeNKmE9lCNva0VS9+dx1yETl8kfF/1N1M+bRSd3goYIxcnOaTzOCE5P+ELFOG7Ml
 wmvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvgtjjqMkoEhGXUuT9w7SZAVUZ4SKwHu1Z/fFNqKXgYOPjtbV+Et+fX1Dz6tB6/HZCJilfQdw=@lists.denx.de
X-Gm-Message-State: AOJu0YwGcj1fEz8ANAwKncxisgoieMec9bXPfi4JAHYgYdaZ0wXL97ZW
 omCarN1cS7W17o1hQSsJdJZlwDUaA3v9SmPNVYZkTleXiD9M+tiG9DW33H9hrlQvhFyGxO+9Tq1
 H
X-Gm-Gg: ASbGnctYKnT7E5FFZzDdTXyDStk0HXny/pJ5DuHs/H1U3ef10Y8Ot7h2QAOk7+pw8nV
 IjrI2MA5fp1sVdw8sSKJug9MVl2EfPcrD7kOkfdiRPYk8PjwAMSWPp+FOUlymMvt04ltHWEJ/1s
 tPO57eFXkgZ32+7RmVVd7Y9tg/FXDdapMk0LRFAoMnU7tnYujQj3o1eR8CVFR5pnKKXjn1tTwF2
 O/4XWzkqJ8BotPLaFxiPSjwt9wwwimJv8GrlhtUtlvi+/Jx7KeQ75cNpUIStK+WAF/eWZdGOqoc
 jNYpqrbxV7M/ftA=
X-Google-Smtp-Source: AGHT+IGq8IHFXkOsWT5lUB5HbiUctaU4LnXYB4hFwXAZkwKwWZOpHKIMmZD1lqDYFDjAHN/4spxkrw==
X-Received: by 2002:a05:6a00:2c88:b0:72f:c513:a5fc with SMTP id
 d2e1a72fcca58-730351ec138mr4939908b3a.23.1738763901593; 
 Wed, 05 Feb 2025 05:58:21 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba2f6sm12507820b3a.113.2025.02.05.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 05:58:20 -0800 (PST)
Date: Wed, 5 Feb 2025 07:58:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] board: starfive: Update the maintainer file for
 VisionFive 2 board
Message-ID: <20250205135818.GQ1233568@bill-the-cat>
References: <20250205025652.5171-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZGcytsvadGrsXL7z"
Content-Disposition: inline
In-Reply-To: <20250205025652.5171-1-hal.feng@starfivetech.com>
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


--ZGcytsvadGrsXL7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 10:56:52AM +0800, Hal Feng wrote:

> Update the maintainer file and mark jh7110 related files with N: pattern.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>=20
> Changes since v1:
> - Mark jh7110 related files with N: pattern.
>=20
> History:
> v1: https://lore.kernel.org/all/20250127083814.67839-1-hal.feng@starfivet=
ech.com/
>=20
> ---
>  board/starfive/visionfive2/MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visi=
onfive2/MAINTAINERS
> index d7f638f9b41..87589553150 100644
> --- a/board/starfive/visionfive2/MAINTAINERS
> +++ b/board/starfive/visionfive2/MAINTAINERS
> @@ -1,8 +1,10 @@
>  STARFIVE JH7110 VISIONFIVE2 BOARD
>  M:	Minda Chen <minda.chen@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
>  S:	Maintained
> -F:	arch/riscv/include/asm/arch-jh7110/
>  F:	board/starfive/visionfive2/
> +F:	doc/board/starfive/visionfive2.rst
>  F:	include/configs/starfive-visionfive2.h
>  F:	configs/starfive_visionfive2_defconfig
> -F:	drivers/pci/pcie_starfive_jh7110.c
> +F:	drivers/ram/starfive/
> +N:	jh7110

Might as well use N for visionfive2 as well (and maybe add an entry for
general starfive files and N that too). Thanks!

--=20
Tom

--ZGcytsvadGrsXL7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejbnoACgkQFHw5/5Y0
tywHYwwAsZYI4aDjeK6zZzCtXL4kWXFuAT+I2I9EB8HRT6fkxCmDsyDCz8bp/nU4
dcfkotd+14syulMSPEHMsh/7kJuXeI/aPq6SZ8tyO6zMfwymtU+LIPlSrNM9iPu8
0lX/1mlb5qG1IJMBvE20TclUyQ30d6hvNIcSWaMbKhq3q9gx7AAzDbtjVqZTq0Z+
Rp8riIOyE0B09psLGP2Pkikg8Nm0sd1c+QZSYxZaDMemNBd3SCxYWYwMQXpBzmG4
JfnI4/YrtkEfleZ70bOuzZRgOK9nUXo6pMmQynZ/WcAgHrV9gTl+TFdPsHKay7mz
Y7j4/+Wm51pdl68zwH9Z8HWpSCKAMo1J+bclfsq6idfiKMBzAFDTPgVsXT64o/Fj
X+ZMSDCVj9X+PRo650JQUoG3mtrtgeyHk6SicYizFV9eeA4qiCf2wIWql46vgM04
eWqx8FCiEwKM491mijBw7zy9mUxZSrgKFJAffHemUjyQBNf3YAd1mbvsz38T6aPd
nUA4X4LB
=2q90
-----END PGP SIGNATURE-----

--ZGcytsvadGrsXL7z--
