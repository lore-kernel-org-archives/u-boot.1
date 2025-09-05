Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61445CA1010
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 14:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDFC8385B;
	Fri,  5 Sep 2025 16:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H6JOVFSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C889D8389A; Fri,  5 Sep 2025 16:20:06 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D6F83826
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 16:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-315bb486e6dso1836170fac.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757082003; x=1757686803; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R9p3q4MpiIc7fOwnjiAbaPYVFMcsRQz/5IB5Pb28/z8=;
 b=H6JOVFSdurmpwguTIyPIPZLBNLnxk1YHYrGzLdIOCfK48F8uQ4sJi36+Q3I3VypFlg
 HFBBGt3w03srUE4AKqOBHQKW9JLO2zKovN8i/zZpr3/O+3n3Plbl/iwGlyRGtX6/MAeD
 4AAxtg1x5dqle9fonxFCPecEwiIx3eX02bYq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757082003; x=1757686803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9p3q4MpiIc7fOwnjiAbaPYVFMcsRQz/5IB5Pb28/z8=;
 b=lvNtWhOJ9FtRMBQkVbwGwKYcwHLi920ck4i0y0DvcgZQaHdlC9fgv6D3zWd9yi/iHw
 p5zjTIFvuaaM15CXP9xv7SVRrLYKsWQX2iL8stX/jNSlt2WQKGTS6OCVfpWsuoCEbhEN
 nHh2Xib2Ccz7jtML7+cei87NI4oP5NpvLsGf7Fo43fMGKkLs7MC3VJVzFkR8Yp0rr3Gk
 cbXzVUpowCTwl2bM8ax0sG3OnP9Nn8D8FAfWqvM4mYUquv7v7XNkp/s8dag3XR5f719u
 oEH06K1rzuDd1sD+4GCB/H+kqprPf3srUVVp3cvDTg4bwbGol3o7JdiHzfVz0JXg7TZM
 t86g==
X-Gm-Message-State: AOJu0YwW/Fq4PZ/raCpQqFogEoA3ZRh74JcVEyqralBHumWJh6xllwMD
 CdJhdgOWBBppHHudrpN+oZJTV/XhHBssgPLAgLqqC3Lc7trzi0vTwh3N7oDvu3GhPMw=
X-Gm-Gg: ASbGnct3Bh4CHeoNtL1TAT4qcmPX86jbCSeqjBL/tuT4di9csVHdUqiNBIDDPFncR75
 lZJQwpdH6RGTwu7ARasgnrM2Ro4kZoJRc/bbMwqaJjZ2kKxtHB3fPjOoB2zWLi+GuGd2/z8JniX
 WsRz/w/0VmaCh6db2QoqED5yhkJQnTnGxE+QiVBFW9pubXw4G9Pkzy0qMWKAfpQcnjYAiKEEHjK
 xleUjfHiuPNaXzW5283ZvPMGF90bAYjSl7+20lLMaONOQibkGVInf1AFBXlmwoHSNWyuRXF6AMD
 VobfZX4Vhu6B4Qb0JAh2WLuKsZzG+d3FTW9bXDSao9gVDv48O3KzXNenKB+9/d7yZRXfZvvu2Eq
 lVHdfXuB82l/hlGfwn95SpZ7uh0W5Xqp61XZIayUFwMckTmv4Hm9d3IojYhgzaghoXc4=
X-Google-Smtp-Source: AGHT+IHUhtqNa/fnYBhvxUdF4f/1xhtRA6i01TsKryT6SsieFLLhREEmch5+h71TxD8/lvCBuI5IKw==
X-Received: by 2002:a05:687c:5b:10b0:319:c278:4a6 with SMTP id
 586e51a60fabf-319c2780dbamr6021215fac.44.1757082002926; 
 Fri, 05 Sep 2025 07:20:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7459a657c0csm2380080a34.5.2025.09.05.07.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 07:20:02 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:19:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <20250905141959.GJ124814@bill-the-cat>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TNDXwH942SSlXqWT"
Content-Disposition: inline
In-Reply-To: <20250903105653.335417-3-pro@denx.de>
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


--TNDXwH942SSlXqWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 12:56:50PM +0200, Philip Oberfichtner wrote:

> Use a consistent logic for image size checks. No functional change.
>=20
> Before this commit, there were two concurrent approaches of how image
> size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
> dedicated Kconfig symbol to achieve this, all the other size checks were
> disabled by assigning them a limit of zero bytes.
>=20
> By this commit we achieve a consistent logic for size limiting, by
> introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
> have it yet.
>=20
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
[snip]
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..d4d46100736 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -22,8 +22,11 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
>  	bool "Allow non-FIT VAB signed images"
>  	depends on SOCFPGA_SECURE_VAB_AUTH
> =20
> +config HAS_SPL_SIZE_LIMIT
> +	default y if TARGET_SOCFPGA_GEN5
> +
>  config SPL_SIZE_LIMIT
> -	default 0x10000 if TARGET_SOCFPGA_GEN5
> +	default 0x10000 if TARGET_SOCFPGA_GEN5 && HAS_SPL_SIZE_LIMIT
> =20
>  config SPL_SIZE_LIMIT_PROVIDE_STACK
>  	default 0x200 if TARGET_SOCFPGA_GEN5
> diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
> index 3fcd0b8465b..d2a1652954c 100644
> --- a/arch/mips/mach-mtmips/Kconfig
> +++ b/arch/mips/mach-mtmips/Kconfig
> @@ -36,8 +36,11 @@ config SPL_TEXT_BASE
>  	default 0x9c000000 if !SOC_MT7621
>  	default 0x80100000 if SOC_MT7621
> =20
> +config HAS_SPL_SIZE_LIMIT
> +	default y if SOC_MT7621
> +
>  config SPL_SIZE_LIMIT
> -	default 0x30000 if SOC_MT7621
> +	default 0x30000 if SOC_MT7621 && HAS_SPL_SIZE_LIMIT
> =20
>  config TPL_TEXT_BASE
>  	default 0xbfc00000 if SOC_MT7621
> diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kc=
onfig
> index 5dd866ffcfe..d70e8def36f 100644
> --- a/arch/x86/cpu/apollolake/Kconfig
> +++ b/arch/x86/cpu/apollolake/Kconfig
> @@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
>  	hex
>  	default 0xe0000000
> =20
> +config HAS_TPL_SIZE_LIMIT
> +	default y
> +
>  config TPL_SIZE_LIMIT
> -	default 0x7800
> +	default 0x7800 if HAS_TPL_SIZE_LIMIT
> =20
>  config CPU_ADDR_BITS
>  	default 39

These should be "default y if .." in the main Kconfig entry for the
option.

> diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defc=
onfig

The reset of these, to Marek's point, show that we need to also add
"default y if .." for a number of other platforms too. At least the ones
where today we have default limits provided in Kconfig today.

--=20
Tom

--TNDXwH942SSlXqWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLrxiwAKCRAr4qD1Cr/k
CjgTAP0Sg/74PALyhdBNbLbjVM5QDxY3PbU+ElQI6QsUOKkB2AEAjhNa6mNGy30J
MwORgVeQ83f360QDzh6qETSPNI/dsgs=
=+K0i
-----END PGP SIGNATURE-----

--TNDXwH942SSlXqWT--
