Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD7F46C5A
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6FC684150;
	Mon,  6 Apr 2026 18:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CoIz8Mv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF6F83936; Mon,  6 Apr 2026 16:21:19 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F8C8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-41576c5c01cso2343626fac.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775485276; x=1776090076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uvy2nKkcWHJOYzO8KVeo3wpgAOj2xNbtg8Jve24Uexg=;
 b=CoIz8Mv9hE++EmCDxAeg4Rh3sJ9rSgDZqec+d7SjzmV1AoYuvWYK+X6wCIowYAOiF1
 nFbmITX769nf9mpWeZvs/KsDw0LrKz88kd/5TP8fydouky7Msu3YHvG1qT5Gf/ELDhGs
 wApDgraXrhNbJ5NTRN4ngTSKFkYw7hreTY6+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485276; x=1776090076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uvy2nKkcWHJOYzO8KVeo3wpgAOj2xNbtg8Jve24Uexg=;
 b=on2SDGGUUvEKNFkbgbhMo1/BoNMjOi6JHjEagToTbnhYJLqFlc91sI19+Lq1Qv2HoZ
 4hcukbwRnIDW34MRDav5GubDRDRsUefAMI8LmOdqnpxzdeg6K4Kd7pfxxj4jK2ns18ke
 AfEYreHXOiNfNkPgO7bZb35TJRPahvvU/dpUZUVz9Mp5BzaiuNO+eyFyEjFkkd5i7QsV
 WULLmFn+gpAeW2co1E7pyjTvBV7qY3hBbC/0vTQjqtbmTT2OrnBUSFyfo5iY4Gut2fPe
 VUtW9l66WJp6fm+7xoTsbQHpGYY0rzyAIUYAwkQLDX9jTB3sgdyO9dTykYnkqSW7nh3S
 JCwQ==
X-Gm-Message-State: AOJu0YwdBSiwm2Zly+51rjEaCf9dvETAIC9ob/5I31pq+L+dvHfv5IvB
 3bEaDsFUYfAsN+MlySNg17a5y1SF6dOK/MAdzeZ9gvZJYzStQTodXsRMYllr3N5aIE4=
X-Gm-Gg: AeBDievAhYuK5xCiEenrrKibIHYSBY5Gy/IRs/iBgbIpMrhdxBdpbi2enqYhI9gSRie
 2hZhCfNMgtabfosrPiavqY/JEfv/MpVXlD5F4XRE6u5qTJh4L7Qyyzbi3X0j/NIGFVgEu5lVjzz
 8HIHi8HLXI3+oYye7aU3o6OO5M7/axguc5N2emNjq2R2uIheGEl7e1Qf0jc+SLEfoGK76Nurttu
 7ASOHe+bMnQ8B9Rvuoll0NK2NMNT1CnyT5HhKo9ocv1jz/8b8zxiLMc6ucfgFz2CReQUJUYq+c0
 ywr6Cir49PKIiL2/yI96+clhhtc+CsZAP2ergQt2jpHLNBVJH3pgHGk3JAiSIdU6GSGr9Uu6Zz6
 ydteamQrJBKUNuWK23W8+OrvAa1bp+GC9FojDwgDKl7YnLSX6YvfHuvYMtEIRoJ8pSEa+8J6sDx
 UVmQjSwpWi31zVBEdqtGUgDd6QeasKN9E2ubmUt3UESqR8v25VtKuJNZ6au9vgFH8O3C9+Mdsaw
 LZ47TtMdrABvmA70xIzVPtdxv+W0n/uV4gwjeuNATpcjEye
X-Received: by 2002:a05:6870:1718:b0:40a:4467:d5 with SMTP id
 586e51a60fabf-4230fd85329mr6948106fac.14.1775485275693; 
 Mon, 06 Apr 2026 07:21:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eaf94eccsm10196563fac.8.2026.04.06.07.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:21:14 -0700 (PDT)
Date: Mon, 6 Apr 2026 08:21:11 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 3/5] drivers: allow clk_stub and spmi in SPL
Message-ID: <20260406142111.GM41863@bill-the-cat>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-3-9e6c2ac66587@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OE9UgjIBAOC9t7fi"
Content-Disposition: inline
In-Reply-To: <20260404-qcom_spl-v1-3-9e6c2ac66587@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:36 +0200
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


--OE9UgjIBAOC9t7fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2026 at 01:18:18AM +0200, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Only Makefile and Kconfig changes necessary.
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
[snip]
> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> index ab4878ebae4..4c94f2e0ff4 100644
> --- a/drivers/spmi/Kconfig
> +++ b/drivers/spmi/Kconfig
> @@ -8,6 +8,12 @@ config SPMI
>  	  SPMI (System Power Management Interface) bus is used
>  	  to connect PMIC devices on various SoCs.
> =20
> +config SPL_SPMI
> +	bool "Enable SPMI bus support in SPL"
> +	depends on SPL_DM
> +	---help---
> +	  Select this to SPMI bus support in SPL
> +

We should avoid adding more "---help---" lines, just use "help" please.

--=20
Tom

--OE9UgjIBAOC9t7fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPBVwAKCRAr4qD1Cr/k
CtxSAP9XggAaJSPde/MEYg9Vb/tkRE8CCFAoZ+0dtkbqu9PY+wEA7AhhZc40I0TV
W3PxTXmVQ/jz1e7Xoqg6hmDqYToFMgU=
=/eof
-----END PGP SIGNATURE-----

--OE9UgjIBAOC9t7fi--
