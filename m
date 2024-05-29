Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7A5C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22F388633;
	Wed, 29 May 2024 18:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="brLSK/X7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C6788637; Wed, 29 May 2024 18:58:24 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492A2885E1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c9b94951d5so1009170b6e.3
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717001901; x=1717606701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=shJT1P8C7c+Qt7etA69tDGneXCGhLKncXtw/wAHDKIw=;
 b=brLSK/X7gkVTXiKa8Gl43qYR99Xm29cRa/mqU81ptQrD5q2rXLp23qV3769Z+tMkum
 37d+17Ug9ipZh37LEfl2Jp0fCsNbh8sHJ16ybQHu4SnkRL/etr30YKSDiCIOSYHTvxaQ
 WhNVpVyan/52eNatP/Dm/jLvdFaTmgKz0fAm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717001901; x=1717606701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shJT1P8C7c+Qt7etA69tDGneXCGhLKncXtw/wAHDKIw=;
 b=uor6uTZWuDpBvy/8XRTwMJhBVl3D3E/I/zbB9PworjKXRL7TTS+qhgpuT7Z7DdVaxh
 COxp08ZQb+kaS4xj1fghsPeiK1WpdCZtVvScOCjge2Jf6qOQVQfmaYfQuAft601d30+N
 6PaAVWe39Q8N+u2DERgx/czX7bBrJkw5FfxOmkLUdNCJRysnhuw8cB2IYp6sSouJz/Du
 JWtRAHcddKVb7WONtxfEgzBXHSgBKOGsgVMS1ZrD+kccfEZAI+myjNIcXDtx4yQB+xNy
 BB/yRWNnFMrCRWFktvnHWB8mgktfQeaRYH7owFFsr/BESguu/Zk++ZX5y2VCeixZmWA/
 drPQ==
X-Gm-Message-State: AOJu0YyremDcxUMRIJP07lRRBin/mlnMztBxzSitz6xeMfm+t98dR9jG
 2JSzVCGxClUlGgd8BJVrG5/GaPTH4LRoP4dZYXuj1zgYtvarhGDXjEk8+Wz+VcM=
X-Google-Smtp-Source: AGHT+IFrmM7Y9ijCstPVsgQLb3/0+D1iQp/N/gPk6uKGVhjOYY44iz+tgqDvEfQOjBiPCA+6fhU9ZQ==
X-Received: by 2002:a05:6808:b03:b0:3c9:6894:bcfa with SMTP id
 5614622812f47-3d1a909bb52mr13937258b6e.53.1717001899619; 
 Wed, 29 May 2024 09:58:19 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad82416b56sm30202286d6.31.2024.05.29.09.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:58:19 -0700 (PDT)
Date: Wed, 29 May 2024 10:58:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
Message-ID: <20240529165814.GQ2568172@bill-the-cat>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z7EJfXSokcxWCdDX"
Content-Disposition: inline
In-Reply-To: <20240528140955.1960172-4-raymond.mao@linaro.org>
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


--z7EJfXSokcxWCdDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:

> Port mbedtls with dummy libc header files.
> Add mbedtls default config header file.
> Optimize mbedtls default config by disabling unused features to
> reduce the target size.
> Add mbedtls kbuild makefile.
> Add Kconfig and mbedtls config submenu.
[snip]
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> new file mode 100644
> index 00000000000..d6e77d56871
> --- /dev/null
> +++ b/lib/mbedtls/Kconfig
> @@ -0,0 +1,25 @@
> +menuconfig MBEDTLS_LIB
> +	bool "Use mbedtls libraries"
> +	select MBEDTLS_LIB_CRYPTO
> +	select MBEDTLS_LIB_X509
> +	help
> +	  Enable mbedtls libraries
> +
> +if MBEDTLS_LIB
> +
> +config MBEDTLS_LIB_CRYPTO
> +	bool "Crypto library"
> +	help
> +	  Enable mbedtls crypto library
> +
> +config MBEDTLS_LIB_X509
> +	bool "X509 library"
> +	help
> +	  Enable mbedtls X509 library
> +
> +config MBEDTLS_LIB_TLS
> +	bool "TLS library"
> +	help
> +	  Enable mbedtls TLS library
> +
> +endif # MBEDTLS_LIB

We need much more granularity here, and to re-think some existing
symbols too perhaps. What we should be able to do is pick mbedTLS or
"legacy SW implementation" or "HW implementation" for the various
algorithms, and that in turn can have some higher level grouping to it.
This should then negate a bunch of the Makefile work you're doing as we
won't have CONFIG_SHA256 enabled as we'll have CONFIG_MBEDTLS_LIB_SHA256
or whatever enabled.

This will then, I hope, make it easier to see and adjust the almost 58kB
size growth on qemu_arm64 with this series. Thanks.

--=20
Tom

--z7EJfXSokcxWCdDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZXXp0ACgkQFHw5/5Y0
tyzx5Av/dzojkejj9a/K6UNatMkBgnHKPCm8hajAmoE2LViQlZIcj/S+y7TIaq8E
DUfI11jt+QD+mrBRPbGFvpQqEnn7B07xbJ7thraM+1QRKBc4l09JGOAyKR/5vJUz
aDSwmNPZFbEsX+h8DBSjFgn8hWFIpT1domVglC/LWeUSfzztQznE91mfrJUqqo8Z
n2ezONv1CuiCaFR+JKXPyII0JezLo37GRIXn+P+hS5sNz+vOzMszYj3hnzjv6unI
DCL2GRifFe1XEZdcdDdX0gzFkuGJ0JP9oIZMT3/DR3zqF+Cbkz/00EbbdmRXuvVU
kwZvYZj4aenWMPH7GANBuYtmsEghq3hxsRUFZRoTPwoBgE4G9i/TrOEZR9ePA5jQ
K2do8RQqP+XE11p8EBsHxrtymlNk7SV95hEsMbywejuobVMWltxNGO+/cwNG2qnF
T3snI/hT3QetHYFbhlT885MjoMmdi76/DJG3Jxyr5BEytXr5emNXpHWEUxkemZxQ
qCT2pBq2
=bLUr
-----END PGP SIGNATURE-----

--z7EJfXSokcxWCdDX--
