Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEAD6A223
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE158907B;
	Fri, 15 Nov 2024 15:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cbQm3q7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD3889348; Fri, 15 Nov 2024 15:19:08 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DE888D29
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b148919e82so48796685a.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731680344; x=1732285144; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ykC8tnH2lrue+87nmwK57W7vHwVYU9dCwo+jtCdzXA=;
 b=cbQm3q7CH3xrPrxNJfIOzO64GTwq9LOzdOzq0uYYhbXEjd9vBLhqXEFpCFIjVbZosJ
 lJs0toaaVzdi8A+eAACX52zqQFruMCBACEdid2MHlwUkW0/aHMPMJCEM0kginZe/Bad0
 XVNDJwIfOvfQ43efw/ps4J+fKQsXeWI4IQN54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680344; x=1732285144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ykC8tnH2lrue+87nmwK57W7vHwVYU9dCwo+jtCdzXA=;
 b=FqEMx8Ia+GiIICIVqDLgBInnZAdszKMkUFbRfoiOkaYETQuH1go96s6TW0UDYtTRCF
 1gnqVf5EmskIkS1MVTRosqJeNZeEGauk1Xj1MaAW1/bh/5I4ORrVyJwDiffj6oT4lObh
 ffiLdOiM+KOITHXEbqibjSQcrofHpZeVg6sAdXMPmIo0LLCGVgX2KfPdhv4G1RYcsdJ+
 mpqMPGrpOkc8REOeJqq+CkBfHBJg6ffEwrTCbXZiJHjNTBbzMvACYPqw8lPZAi+tOpIU
 kb3xm3WKQGvbYazL6FfBAiEO7jAujhIyH5h1E+TLepACDUrjGH36vvA/3i7vG18SiN9O
 aJDQ==
X-Gm-Message-State: AOJu0YzJDpt/nB9QwZ7az1948e4IP7EXG0qlJUOmgNZpVynGLEMcSCdF
 RTTGtHKkru69pXa5mpnSdqeEil9+B/epIj8W+7OQLt7ZKupwW5BsLMnHcN4j0aI=
X-Google-Smtp-Source: AGHT+IGY8gcPehjXxq2YVcA77MRhwIs7/lFgRIwG/A+bYqSdQ0MZsBsQX6ovMO5zzm4+xFfzmMNBFw==
X-Received: by 2002:a05:620a:4446:b0:7ac:a077:6a3d with SMTP id
 af79cd13be357-7b3622a56e3mr359843185a.10.1731680344493; 
 Fri, 15 Nov 2024 06:19:04 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca3059asm161901285a.84.2024.11.15.06.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 06:19:03 -0800 (PST)
Date: Fri, 15 Nov 2024 08:19:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] xilinx: Introduce MINI configuration
Message-ID: <20241115141900.GT3600562@bill-the-cat>
References: <81d086ccf96f9d601eb4b56a2a88d8bb2dacd48e.1731677784.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a8uOadeXaFlC7gOK"
Content-Disposition: inline
In-Reply-To: <81d086ccf96f9d601eb4b56a2a88d8bb2dacd48e.1731677784.git.michal.simek@amd.com>
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


--a8uOadeXaFlC7gOK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 02:36:32PM +0100, Michal Simek wrote:

> There is no common symbol which mini configurations are using and recent
> get_mem_top() changes adding 1.3kB without having a way to remove it.
> That's why introduce new symbol which can be used for removing features
> which are not requested by these configurations.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> Based on:
> https://lore.kernel.org/r/20241025172724.195093-3-sughosh.ganu@linaro.org
> ---
>  board/xilinx/Kconfig                             | 9 +++++++++
>  board/xilinx/common/board.c                      | 4 ++++
>  configs/amd_versal2_mini_defconfig               | 1 +
>  configs/amd_versal2_mini_emmc_defconfig          | 1 +
>  configs/amd_versal2_mini_ospi_defconfig          | 1 +
>  configs/amd_versal2_mini_qspi_defconfig          | 1 +
>  configs/xilinx_versal_mini_defconfig             | 1 +
>  configs/xilinx_versal_mini_emmc0_defconfig       | 1 +
>  configs/xilinx_versal_mini_emmc1_defconfig       | 1 +
>  configs/xilinx_versal_mini_ospi_defconfig        | 1 +
>  configs/xilinx_versal_mini_qspi_defconfig        | 1 +
>  configs/xilinx_versal_net_mini_defconfig         | 1 +
>  configs/xilinx_versal_net_mini_emmc_defconfig    | 1 +
>  configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
>  configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
>  configs/xilinx_zynqmp_mini_defconfig             | 1 +
>  configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
>  configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
>  configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
>  configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
>  configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
>  21 files changed, 32 insertions(+)
>=20
> diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
> index 0ff8440e6e06..a7da97dbae8c 100644
> --- a/board/xilinx/Kconfig
> +++ b/board/xilinx/Kconfig
> @@ -40,6 +40,15 @@ config XILINX_PS_INIT_FILE
> =20
>  endif
> =20
> +config MINI
> +	bool "Mini configuration"
> +	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
> +	help
> +	  This option disables features which are not needed for Mini U-Boot
> +	  configurations. Mini U-Boot is running in EL3 mostly on size contrain=
ed
> +	  systems. It's purpose is to program non volatile memories or running
> +	  initial memory tests.

This is too generic of a symbol name. Please use XILINX_MINI or similar
here, thanks.

--=20
Tom

--a8uOadeXaFlC7gOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3WFQACgkQFHw5/5Y0
tyy67Av7B/n6V3azw9SUAXQI4AlEjZm9Ic1ekBi/ahikXP8BcY8uXYX4PUbfsm3+
Aih8aOujxuYFohPm49N3yyA30fjIId7lpt2DY2x2UMq9Rg6Se0sQ/C/6yb6qHzoc
kFhNZJsjuKaGW2NQwZZtgW5SEvdPdjF9vGekZA81hTY7Djg2T8OYB89pq8goPvMn
Bux23oRAjJQ6lkGG2hyhDp9muhuZulLWPPboLZObFDDl5IVtxCYHRZb4DNtrD1yu
kMxMGrYb4tMsqO2SfYcPN335SEDiF19iIpySqhNvm/6rCgUCN+tLNGE/Jea2bG2D
uZgJYOZloLH7bVRh5PEJwrOOk0PgUcdg4QrKaTe/qN3NeYUU7HHjT3AtONw5n0Y5
232bWaWY5F5mXq2dXvtqzjepnTl7uFuo3c1HvqDT4e7s7FkJcEo0InA9s4ZSfalp
rgzb6DQT9HBAvNr9U+qG7/bgRVNC4m1wM9zZbns1YqWAP5zcUtNItnmf6NftIKom
dejpGwjk
=nNzM
-----END PGP SIGNATURE-----

--a8uOadeXaFlC7gOK--
