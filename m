Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C3CC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56D381417;
	Mon, 10 Mar 2025 15:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gj5Kyo65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C783A8141D; Mon, 10 Mar 2025 15:24:37 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9A6807B1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso7134437a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741616672; x=1742221472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4sx8Pn5vJpB1cCUljvwGZ+gsq/pM7BtmbKJPdOX+mMo=;
 b=gj5Kyo65qpYroKyjRhALVa6CchKMmrzQ/pPlO5LvpWRvchDPNrR4RwA+TN2EWzi/Or
 wpkEn0IKNY+rD47aEsmHPZaGZO/jZrTl64hggR8PLoIe+1fHu+jPXvHaa5y6OqpZLD5e
 xP2MVQDxT2NYvNI1548HePJOM/gxe9ZXi63hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741616672; x=1742221472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4sx8Pn5vJpB1cCUljvwGZ+gsq/pM7BtmbKJPdOX+mMo=;
 b=nZMM0O6kP1q8VinTP7acsKb2bR6eps8f2rgFGxHlYDG3gwlhOY6/OmM/q/Y3z6yCdj
 EH+yyhkItT0krjdRFPYue+7oBSn+ba1esHiNjjXOFSdMeuMOOS/YViALNyN2n9wdxqYH
 9Tu1nLYw4FC+wxwg+57Y+8tGvawlkUtAvqn89QSrb69TlCRLU7DwUwLSPUfi1+vjy+68
 RgOp3j126UzY5VfUsBTmLp9JiGwQB9RUQ5hwybLTIaSQo/QOrea3zgXJvVG8Fcou4YGL
 bNVZFELowha5Onuv3sXOcXAFvCDa0AM/gSTdMXgYwD+B4dANd9kSThKGMA1EvYqEJaLx
 wYBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzRjTaW9eKd2nUsFqZnEIb2hpJrKRJWanKh9ARvG+Ic9Mpb/lUSX8hlxSoA/mwSeQPnHgTt2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxbjsOjwfIT8jsVVwCjiWtJrjTJFxTzgyrjjHKgx3Hfubw706lT
 NSEvhowf+8OktcAC1jZiRBwbY9Z/DhA7ittOK03hmM2pRk+2BIK8A8SZF5CGsNk=
X-Gm-Gg: ASbGncuqT2jTOx4wZLL/ZscyMD8ieqr/7ATyK60C8Rj5A25JCKb3w6wP00mFVEa86dR
 zycZrsKwivevImUeKCJUeUueYqbOC42upLXujFwTxff8a4gIgN+WUvxZqB0251TcbLQ1V6exccX
 M5MqE5pqO3I60CmjcFRH70XCfcN0ISIroO7UYKZWYID8SIeGH7hn4bT2svwkK93OG2VW1rbsKPO
 8zj0BZWB1DbKUodKJSJsBtK6KJvMrJt9swhlam6qTozAl1XwMF6etFqRYjrGqX9BMbRF2lQYaPu
 4Xql1MOfVGcQqf74OEONhFeIFjkK3MyCPAxPrMCYV23DLg==
X-Google-Smtp-Source: AGHT+IG2hY/tofUzj1B+0nbSVsjmKFnRYrmVnrrx6A0113jsRMCjabMWcnnciclhJULinpiz9g2iQw==
X-Received: by 2002:a17:90b:5292:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2ffbc1c825emr15875317a91.11.1741616672442; 
 Mon, 10 Mar 2025 07:24:32 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693e75ccsm7988882a91.32.2025.03.10.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:24:31 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:24:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] airoha: Add initial support for Airoha AN7581 SoC
Message-ID: <20250310142428.GZ2640854@bill-the-cat>
References: <20250309140652.23543-1-ansuelsmth@gmail.com>
 <20250309140652.23543-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A7H5tIH5xmlDDvZ8"
Content-Disposition: inline
In-Reply-To: <20250309140652.23543-2-ansuelsmth@gmail.com>
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


--A7H5tIH5xmlDDvZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2025 at 03:06:43PM +0100, Christian Marangi wrote:
> Add initial support for Airoha AN7581 SoC. This adds the initial Kconfig
> and Makefile entry for the SoC, an initial RFB DTS and initial config
> for it. Also add the initial code for cpu and RAM initialization.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
[snip]
> diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
> new file mode 100644
> index 00000000000..0470a01034f
> --- /dev/null
> +++ b/arch/arm/mach-airoha/Kconfig
> @@ -0,0 +1,44 @@
> +if ARCH_AIROHA
> +
> +config SYS_SOC
> +	default "airoha"
> +
> +config SYS_VENDOR
> +	default "airoha"
> +
> +choice
> +	prompt "Airoha board select"
> +
> +config TARGET_AN7581
> +	bool "Airoha AN7581 SoC"
> +	select ARM64
> +	help
> +	  The Airoha EN7581 is a ARM-based SoC with a quad-core Cortex-A7
> +	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
> +	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
> +	  video interfaces supporting HDMI and MIPI, and video codec support.
> +	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
> +	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
> +
> +endchoice
> +
> +config SYS_BOARD
> +	string "Board name"
> +	default "an7581" if TARGET_AN7581
> +	default ""
> +	help
> +	  This option contains information about board name.
> +	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
> +	  be used.
> +
> +config SYS_CONFIG_NAME
> +	string "Board configuration name"
> +	default "an7581" if TARGET_AN7581
> +	default ""
> +	help
> +	  This option contains information about board configuration name.
> +	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
> +	  will be used for board configuration.

We shouldn't prompt for SYS_BOARD / SYS_CONFIG_NAME and instead just
provide the values here.

[snip]
> diff --git a/board/airoha/an7581/MAINTAINERS b/board/airoha/an7581/MAINTA=
INERS
> new file mode 100644
> index 00000000000..480b89a73aa
> --- /dev/null
> +++ b/board/airoha/an7581/MAINTAINERS
> @@ -0,0 +1,6 @@
> +AN7581
> +M:	Christian Marangi <ansuelsmth@gmail.com>
> +S:	Maintained
> +F:	board/airoha/an7581
> +F:	include/configs/an7581.h
> +F:	configs/an7581_rfb_defconfig

You should probably use the "N:" syntax here and say "N: an7581" to
catch all the files later on too. Perhaps also "N: airoha" to catch the
drivers you add later.

> diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
> new file mode 100644
> index 00000000000..b37511c026e
> --- /dev/null
> +++ b/configs/an7581_evb_defconfig

This doesn't appear to be the output of "make savedefconfig" so please
re-sync it with that.

> diff --git a/include/configs/an7581.h b/include/configs/an7581.h
> new file mode 100644
> index 00000000000..901d99b3456
> --- /dev/null
> +++ b/include/configs/an7581.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Configuration for Airoha AN7581
> + */
> +
> +#ifndef __AN7581_H
> +#define __AN7581_H
> +
> +#include <linux/sizes.h>
> +
> +#define CONFIG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
> +
> +#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
> +#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
> +
> +/* DRAM */
> +#define CONFIG_SYS_SDRAM_BASE		0x80000000

You cannot set CONFIG symbols in this file anymore.

--=20
Tom

--A7H5tIH5xmlDDvZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO9hUACgkQFHw5/5Y0
tyyRbAv/fL6uMI+iZP/RXZVBCRRaqnXTjh6vKbCodut8tneoG4hQ8wX03UVO5u9u
+/918RDYpXCzD8z21l82kYvgDIzwAZtfhtzv8F2NZ9s80vzlyYWwd6eEF1a7Cl/s
pwEfKaOV96YywUKBl0nyINJqC/iFj44cPAm8xXt6sApmOS+vpFMQFEKZU2p10+4k
4rcUAU66f9Ck2Bz72sFHaumsJlLDgr5DgJdLoudHlX0zQH1nMPfOuelZritBj6Hn
E0MakNC0CuP9F0S8iVHu0T+UEVBIncjW9OhG1u8qGkc4zqTO9vpXbn3TLv7Pg4yi
C191BiZIWi5cKNPa7H6ck9WSkZcHm/feFWz0Fq8jShPwytbZxty3Qu9QcWcB48c4
8C+kgOOOY7AU7ZSwaKaYlrZyX+EcxH29Mq470eyjMwIl6aMVSmpNtVj9UZi4way9
0DN8KnLv6viZ+s3urOZHXtOaHgf7iKKMsB7AAJTGCpd9vdReIYD7yVtQMdfu1lq5
woh08PXg
=7Xka
-----END PGP SIGNATURE-----

--A7H5tIH5xmlDDvZ8--
