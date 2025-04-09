Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EAFC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6358384C;
	Wed,  9 Apr 2025 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gxqaZQPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE6F8384B; Wed,  9 Apr 2025 16:30:17 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA4A83855
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4003b22c2f4so4363301b6e.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744209012; x=1744813812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U5286chN3DIAwIUx4LI72h6J2pBZOkaUmvy5HlVv4AU=;
 b=gxqaZQPJLQ7r/mDT1v+CiSi2tfCnuDZqj/uuTJEkqB0tO87IdaVuunEY4jMjKF+ngj
 YpF7DZCFgEkHfmF5HzQCE37o6Rb2UVTsr4bRn/9chnqij1Ow9UTJVdTPYq4nRKQe1PKJ
 feuIaaYzAKP/IELHnI1o6H5ao8U+2SphZ5lRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744209012; x=1744813812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5286chN3DIAwIUx4LI72h6J2pBZOkaUmvy5HlVv4AU=;
 b=F46c+No4WyfydMzO3EFXpYs7XqJV7/kXkfeEFN9yXU4R0UNSUZTx0Qy/SJlFdVj+hc
 es9bi0NEWhTOAomSThMXRpvvwnISGqNwVQ3daSQxhA0Bqxl3SBbFzT1e870aAbMC0pfe
 ZZPdOJo+IItRWWJfB99W5n9HNq3/nXOp3GztbtswZ9tu1NAzCyTx0HF69t8hKHlMn/DS
 nsKCSi1PH5X4/5PGFha2HmV1PNi9qXKaSojOxKrKcazdHM/x27h77q7QOOmyxPXutsGH
 0vlWHkHlnJlGv+b3FTck8B3pzHxe7qmj84jups7BDGKcD7t2J5nszCJBOoLX4jtQyrwT
 svPA==
X-Gm-Message-State: AOJu0Yxok90Oifp1jIEumvW7/yqjTUxi233pRiGeJlSoQ9BMxLPSsuxj
 Rgrg2zVap9KijhSoELWQuStYNA/bq0tv3O12gEJdEq3ftB/L4kd+YY1GpN4rzH4=
X-Gm-Gg: ASbGnctIWh+yhvqmbmfsot5Z2ZEeVYEMQUUGjJG+j1HgF8uNrqj68lF5mDV6AOz+8cA
 SlzASYc0tTWjHw7TcCmbfu07tO0F7qUPWtyp5CXnwdrCIzEstiikS5GFqboEA6Sd446mLnsXMT+
 ZbgIEVv7nM05EgHgs7fes/yPzrwhQXHpRs+IyBvzVcNs5A2m+Y+FdqF2mWXPmjLcC+tXByaNvwL
 YHsXmOO6wL7Z/D0bd5eUcKKa9GsgOy9L7l79mzZOX2suQsDlqyS/D1T/nF6znTVJ4VCALrglSDd
 eGSAi0HX0TgIxzL1euyXC5arD70i10s7k3YjC+BJ2ikPnIkaw28+q7Xi3UpNVZ2Vpp1awOUOx14
 8RZ3B9Ra5dNll
X-Google-Smtp-Source: AGHT+IFnCZNOb64n00Bqx9viP4A1X57Ivf1S8CRxojfKG5gR76FW6Qv2eqhmJHm4TJypI2FUCtnWsw==
X-Received: by 2002:a05:6808:3a05:b0:3f8:9b41:6ce0 with SMTP id
 5614622812f47-400736b00d1mr1816515b6e.7.1744209011659; 
 Wed, 09 Apr 2025 07:30:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762d564csm175031b6e.27.2025.04.09.07.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 07:30:11 -0700 (PDT)
Date: Wed, 9 Apr 2025 08:30:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] configs: set SPL_TEXT_BASE by default for k3 platforms
Message-ID: <20250409143009.GD5495@bill-the-cat>
References: <20250409124739.3843126-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7+hyraK5Um3oWZjB"
Content-Disposition: inline
In-Reply-To: <20250409124739.3843126-1-anshuld@ti.com>
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


--7+hyraK5Um3oWZjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 06:17:37PM +0530, Anshul Dalal wrote:

> SPL_TEXT_BASE is used as the load address for the main domain SPL on k3
> platforms.
>=20
> Since the config value is the same for every board, this patch sets the
> value 0x80080000 as default for all ARCH_K3 and deletes the instances of
> SPL_TEXT_BASE in individual defconfigs.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
[snip]
> ---
>  common/spl/Kconfig                         | 1 +
>  configs/am62ax_evm_a53_defconfig           | 1 -
>  configs/am62px_evm_a53_defconfig           | 1 -
>  configs/am62x_beagleplay_a53_defconfig     | 1 -
>  configs/am62x_evm_a53_defconfig            | 1 -
>  configs/am64x_evm_a53_defconfig            | 1 -
>  configs/am65x_evm_a53_defconfig            | 1 -
>  configs/iot2050_defconfig                  | 1 -
>  configs/j7200_evm_a72_defconfig            | 1 -
>  configs/j721e_beagleboneai64_a72_defconfig | 1 -
>  configs/j721e_evm_a72_defconfig            | 1 -
>  configs/j721s2_evm_a72_defconfig           | 1 -
>  configs/j722s_evm_a53_defconfig            | 1 -
>  configs/j784s4_evm_a72_defconfig           | 1 -
>  configs/phycore_am62ax_a53_defconfig       | 1 -
>  configs/phycore_am62x_a53_defconfig        | 1 -
>  configs/phycore_am64x_a53_defconfig        | 1 -
>  configs/verdin-am62_a53_defconfig          | 1 -
>  18 files changed, 1 insertion(+), 17 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 94e118f8465..a84b96ebce4 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -271,6 +271,7 @@ config SPL_TEXT_BASE
>  	default 0x40200000 if OMAP34XX
>  	default 0x402F4000 if AM43XX
>  	default 0x402F0400 if AM33XX
> +	default 0x80080000 if ARCH_K3
>  	default 0x00908000 if ARCH_MX6
>  	default 0x00912000 if ARCH_MX7
>  	default 0x40301350 if OMAP54XX

This should probably be ARCH_K3 && ARM64, and then also different line
for the R5 side?

--=20
Tom

--7+hyraK5Um3oWZjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf2hGkACgkQFHw5/5Y0
tyzVLgv/QbpxrA016KClH8MJRWiD/JKQVG+2FLZqoSF8IPVpF4uUwU2rDXlb3VAT
Euj9k8Dn4gFpYfgJq3wphO6H9BNlZiAgH0Ct2okzUnJXq7hFAl960Jf7YuLORBpU
LIydBf4Kt+jMrAma4qhoSL6M6eT1EvGWdMJppQVBktHe2t/7HyTwpkIyNaLxLVO2
w27AV5sjtvyPpvikFrcgWq7mMlLurHdsGcRtxSRgUSGwUdIh/d6UObeyfMS1YUGj
2Qi4VXVGtwvL7+1g03MXml0HdAqB3OjVz/G91IG73K5K2FWP7Sly6d8bqf2Bgocw
WldzDzx83pX6PpcaS/iN5PZXzVlXClNxYDMMoBRHcAoHO4bP9JyBcc8AJFvGw2s7
/aXII4e8SJyK5E7IZCCmuORcEJQ72n4gEZIR0pDmQNqLxOTq38FXE6TatI9XOhBp
9NZCvzyCrex4DR892W0SyIJ1oo66kgWhWO4yYXXhT4b43xs+dSuEO0degGrq/GI+
b/p+C3IL
=oybl
-----END PGP SIGNATURE-----

--7+hyraK5Um3oWZjB--
