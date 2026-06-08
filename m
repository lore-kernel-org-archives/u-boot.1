Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5E9CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711268466E;
	Mon,  8 Jun 2026 16:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AELkCM/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ABB7846B1; Mon,  8 Jun 2026 16:28:48 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AEF4841C2
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4865e953031so4641723b6e.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780928925; x=1781533725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CTxXWmUBHN1GQEzSDF7bp9W7TWssFj+UnNEcJSp/+Co=;
 b=AELkCM/wyOeYIivtMe5nByXOIFrdgxNMCIRfp7f3XnocaD4DrCZXXDotJl5YxNIo5E
 idDsKmAmM5n3xC6TcoTv9gqhAbS8hI5stIJ/kFkBiRdTTWK+9yMy5a15YPcnjWOs5JCb
 +qT3rJN0bTJwfqL5Mh5hMVD4gWZemBfiud+IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928925; x=1781533725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTxXWmUBHN1GQEzSDF7bp9W7TWssFj+UnNEcJSp/+Co=;
 b=Oe9DU4XvLeqO9LndUxrRYBYGs7qopzsrI5HufOz/PdZEQb2r82HSnxte6NS8p+zss0
 SMYDMMoUDoVYpXIr1EzpiD5THxE5M6HBcXRwBq8nBRsdboBs0XlwCHNWntO4Xp+Yg2Ot
 opY3SU0OE1aN4aVQMPrq3mOPkZ767dxC8wdtpVGQXW8RUzNiUMLoA41nD1GhyJdYxuXW
 xMTE6bC2IBdifyM/QYDTrQo9klBkRN1lhQyEaLIgnmvcFVK9blJl2JMMO/yoxEkZiUvz
 fdCkNNq6CwykunqMtpOjuFDfFr24fEUGkn3wQYGnqTIPZX+tRMortAHE9lMr9SSFTj+3
 HnFw==
X-Gm-Message-State: AOJu0YwhEY4I8J/FbySJDxjdFv7Yc5bb4Cf/yUd2KMLZh9vTZ/xY+Rih
 WzCYc6Gj5qYc4j6tGBGfhGgeHumurk1psmOEl8HWSkyjO4U4HsHMJEqwg1YhMg1StMLpv4FFcNN
 G4eThNzE=
X-Gm-Gg: Acq92OH3QztMcqklIXaADz4fhBOB3lPCeKi9Fx6i11B+32zWhiXqZp0GRsxLzNLPM9H
 bsvqrgDo8LaIEdVvTITayEKwwxSZ/xzw5kkOQugcYWCB9+xAFJlyQmBGSUO19o5gNhINFq8/N4b
 iXc0sd1zwEbfYj8Da4j74w1i8d2wMV/a9tALEFVCHeI+ih5rKTOx4fCpGIkDitHrAT+QcleHKQj
 e7RHMBTxfLCDYFTiijsgUKNqlCM5qcap3pT9JCQKbqar4BwvMkKQCc41HxIQNfZlxzrNVGV1v82
 y+gMzYazbEzh+o8POwyTkwD22JWToVQy4UjBKXBklp2SzxaOPMYXyxhAivUwLPQUae7Df1E5ONo
 j8rEQupTquFsQe/3muyMuPsAj7K9BP/lfuE8/adzWRsX7AdHUoB5LfML8x6qhfjeBxVP7CUhlii
 GvhTGmH00D0P31/tTjs363+nsh6TIEYfkDlA5Yzlz1XI/Sz2VSoKzIUB3o6Tkeech3FbENfeaY3
 npH5a1yPwfrVFYDdpNXujEhRIrjMdjvDvpPzGlkYiSHMFnGvREz0oiZIM0mYQ==
X-Received: by 2002:a05:6808:4f14:b0:486:2dec:f60e with SMTP id
 5614622812f47-48692d75511mr7342481b6e.14.1780928924725; 
 Mon, 08 Jun 2026 07:28:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91eaffsm13558291b6e.11.2026.06.08.07.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:28:43 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:28:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v7 5/6] mach-snapdragon: add kconfig infra for building
 MBN files
Message-ID: <20260608142841.GB3502663@bill-the-cat>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
 <20260511-b4-qcom-tooling-improvements-v7-5-0c06346e79a9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r7k5hzP+rhHKIbND"
Content-Disposition: inline
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-5-0c06346e79a9@linaro.org>
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


--r7k5hzP+rhHKIbND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 03:57:47PM +0200, Casey Connolly wrote:

> Add a qualcomm specific Makefile fragment to make u-boot.mbn a build
> target and introduce a kconfig option to build it by default on relevant
> platforms via CONFIG_BUILD_TARGET.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  Kconfig                          |  1 +
>  arch/arm/mach-snapdragon/Kconfig | 11 +++++++++++
>  board/qualcomm/config.mk         | 14 ++++++++++++++
>  3 files changed, 26 insertions(+)
>=20
> diff --git a/Kconfig b/Kconfig
> index 8428d039a1c0..183c8096030d 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -557,8 +557,9 @@ config BUILD_TARGET
>  	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_GEN5
>  	default "u-boot.itb" if !BINMAN && SPL_LOAD_FIT && (ARCH_ROCKCHIP || \
>  				RISCV || ARCH_ZYNQMP)
>  	default "u-boot.kwb" if (ARCH_KIRKWOOD || ARMADA_32BIT) && !SPL
> +	default "u-boot.mbn" if ARCH_SNAPDRAGON && QCOM_GENERATE_MBN
>  	help
>  	  Some SoCs need special image types (e.g. U-Boot binary
>  	  with a special header) as build targets. By defining
>  	  CONFIG_BUILD_TARGET in the SoC / board header, this
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index d3de8693b5a8..6329cbb9215e 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -41,5 +41,16 @@ config SYS_CONFIG_NAME
>  	  This option contains information about board configuration name.
>  	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>  	  will be used for board configuration.
> =20
> +config QCOM_GENERATE_MBN
> +	bool "Generate an MBN-compatible ELF binary"
> +	default n

The default is always "n" so we only need default n if ... statements
when we would otherwise default y. There's other examples to clean up,
so only fix this if there's a v8. Thanks.

--=20
Tom

--r7k5hzP+rhHKIbND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibRmQAKCRAr4qD1Cr/k
CoogAQCGnEwIwEnMDl5dTec9U3t23Mw8C53moyrTojLq9rRWHQD+LUYDOEz/GM+V
8YfivmMMxzQouIASZPxui1UeFPSGfgQ=
=xY51
-----END PGP SIGNATURE-----

--r7k5hzP+rhHKIbND--
