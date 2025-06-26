Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC616C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 23:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45FD82D21;
	Fri, 27 Jun 2025 01:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HJyZTBhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451E782D21; Fri, 27 Jun 2025 01:47:41 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E77380E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-408d7e2ad03so1116396b6e.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750981656; x=1751586456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ufeUPcZsFnrfjRQggtNxGnCBDoXgdByXY8rOF1vhYBU=;
 b=HJyZTBhPHK60BTkqr13rceXoC9W++41NIFn2HzKyVIzIxPEj6Ny/0m/6Vx6OoxkdZe
 jdUw/jBxvSXD+z3Qpa79g2ZSZgyM6JlR/X1x7ov/nBpnfg1cF34P6ZW8zLsgtbEJRAaO
 Smq3pTiqQMOTthC/mlnQRzXUk09sZ048ueaC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750981656; x=1751586456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufeUPcZsFnrfjRQggtNxGnCBDoXgdByXY8rOF1vhYBU=;
 b=ny5q6yuUFeAaZfHAw4vNZzgQbBIJqN2e0/lhzvWKVaJeonmSRJqV1tAy5tae+KIOoh
 PBGVQE1PA+Zq8i0BQTV0lFkJeCTgiIHUFaGsMx7I2D4A0ipTzuReZy7+1wz6H4uRH8Pp
 kdgynWA/i9XgiVsY1OEL8fN9ucAMfIAU6jVRIWsEIjp7AzbKj89lnKPIqr9l5oaqvvhZ
 /zyO3vY5/++RWGcdLsooDpm/InCU3efnFfrKPBLB/uj2UtafwYnuccY+ex82QsuuUclC
 Og+rpVzQhnqL/+XNSIbwFut4riR81wgTHeIINgoG5LMvgLW9KWhMSIdOFw/CkzBdpjqv
 DCww==
X-Gm-Message-State: AOJu0YyZDA6t9v2I2ff/DNhX/LBOw5A3Zmdl72oP3xcx3LpFgmj9Hu9j
 siWgCkBMFywolhJReYbZgTzC2PO89IMYxLqeB1dmRPIpt8ATGFxjllQTgiadv2cmgJ0=
X-Gm-Gg: ASbGnct3ZoUiNNybH0a2hO1NvVeJR9AOZuoQYgXfRZzxEVLXx9097hD/MC3ArWu0bat
 +xXMu/AXIGjsiBY0zgvdZJhgFVWNUVTecQm7c0KszfN4SVah85f9kcYzgN15vK7+syHDABQ2UBE
 KJsYPn1hq/zlMajBIgjIIE63c49oUWTL069EylrIBKgJIG/YchtgO1S657DnHn6T3W1JUdHyp3T
 nDzMZ5f82UgS04WwdHLc2N4jT6bKbEBePJiGoXKdYEwgoJzea05oHUWGEIwyEDRsjsYkOCVrx+4
 9FalEtli/s4L7Eg+E+ot0nXI9gz1SOwMf4k3H46FvjfF7Pbja9dPUOdFr632JizUEn0ylL4DpB+
 Pd0JIBt83GGMuHrnDa6kgNxE=
X-Google-Smtp-Source: AGHT+IGevt3vXfS0/X+BJvG9Z0f27SCUdFrZdUVrqcBOW23HLXX6dcR49HykPDqztVqtUDrOwQJWEg==
X-Received: by 2002:a05:6808:23c3:b0:408:fb4c:859e with SMTP id
 5614622812f47-40b33c47117mr981576b6e.6.1750981656101; 
 Thu, 26 Jun 2025 16:47:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324054a2sm157227b6e.31.2025.06.26.16.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 16:47:35 -0700 (PDT)
Date: Thu, 26 Jun 2025 17:47:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [RFC PATCH v1 3/4] spl: Kconfig: disallow loading args in falcon
 mode
Message-ID: <20250626234733.GA4003484@bill-the-cat>
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-4-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nODtXoA+2bXof5o7"
Content-Disposition: inline
In-Reply-To: <20250626120443.1405409-4-anshuld@ti.com>
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


--nODtXoA+2bXof5o7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 05:34:41PM +0530, Anshul Dalal wrote:

> The current falcon boot requires loading of an args file (usually the
> DTB) and a kernel image file to boot. But with secure boot, the dtb is
> expected to be packaged inside the fitImage that kernel image (path set
> by SPL_FS_LOAD_KERNEL_NAME) points to making loading the args file
> unnecessary.
>=20
> Secondly the args file causes security issues since it can not be
> authenticated unlike a fitImage.
>=20
> Furthermore current falcon boot flow provides added flexibility that
> might not be desired in the interest of security, in the current flow
> SPL first looks for files pointed to by the environment variables
> 'falcon_args_file' and 'falcon_image_file'. This could be compromised by
> modifying the env data.
>=20
> Therefore this patch introduces a new boolean config symbol
> SPL_FALCON_LOAD_ARGS that simplifies the boot flow to only load the
> kernel image file set by SPL_FS_LOAD_KERNEL_NAME if disabled.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/Kconfig   | 10 ++++++++++
>  common/spl/spl_ext.c |  5 +++++
>  common/spl/spl_fat.c |  5 +++++
>  3 files changed, 20 insertions(+)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index d5d3a41ce61..b2dbe2eea65 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1213,6 +1213,16 @@ config SPL_FALCON_ALLOW_FALLBACK
>  	  When enabled, u-boot will to load SPL_FS_LOAD_PAYLOAD_NAME from MMC
>  	  if loading SPL_FS_LOAD_KERNEL_NAME fails.
> =20
> +config SPL_FALCON_LOAD_ARGS

I'm not sure we need this, exactly. We might need some hidden symbols
but with SPL_OS_BOOT && SPL_OS_BOOT_SECURE we just need to not allow
SPL*_ARGS options to be enabled. The tricky part will be either more
hidden symbols or some updates to various parts of the code so that we
can still compile.

--=20
Tom

--nODtXoA+2bXof5o7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhd3BUACgkQFHw5/5Y0
tyxC6gv9HnLMf2Gd15vgWfKwOLyHFTP5zA05I+KLCLRwhIvlHpj0bbYHy8jtlpCX
Eyjo047MWfXn+CVf4YgIvf4Ba2mho16UQiDnA/TRiaNfqg8A2kC1PFS+bjrinprN
8j7p6MIH6Q2lLHV0q1ls2rrolAuUniezJOkU8CIKiMvvEHXOUQ3fojksbzugfT9P
ZED+ZSG/YD75wSTsCJIcBjJoVsmiiXDeHoNtmvX4Ds0n/Wji5IzM0g+guRjXiPJj
8lTbyveglBbmbvbKlXGplizlysK4rSKCCp9OYNitQjYBGc/SEbomgTMFUn8WqcYu
s8N2RrInWMFa4G9pO9AmR6tXr0q8RdJM1BNNvaPEIzJ+eYIUNmYZdDt7a5TVT8lZ
7pCOG4xNtXHlAF+prJcgAIWEdReeNmiNC57xqzryOMwZ7R7/3ffvZQHvAyTofBie
SKKeRujK7Km/Jyd26h2KUYWNxGiokjPJ3tD5Yxf0IqWxDEqzSZzviKgMmt7vzVKl
MF27bX2w
=t+aW
-----END PGP SIGNATURE-----

--nODtXoA+2bXof5o7--
