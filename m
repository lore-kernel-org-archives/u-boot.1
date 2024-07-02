Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA5CC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 22:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D99AA88356;
	Wed,  3 Jul 2024 00:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dDkSTcqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCDE87FA7; Wed,  3 Jul 2024 00:48:33 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02FE6886A4
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 00:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70224a923fcso553098a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719960509; x=1720565309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RIYyxlJvNDOv99xs+UN2Sl1OcpulbVl1kLHyiyiarhA=;
 b=dDkSTcqVfj9daBLOrUi6AMBP3jQ1LqrZ3n49Ix8Es2gqwMD3tRE1ADa3iHy0XHLMoy
 IAhBjqZd90VkoOvsSld+XDklbdQf+v0qxPPwtt2RVSikIjQpSSqFAA0+lRZo0c5z03+0
 AcNroZThUbHpSm4uoPvCP8ceLqWeVvEbS7G5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719960509; x=1720565309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIYyxlJvNDOv99xs+UN2Sl1OcpulbVl1kLHyiyiarhA=;
 b=T8jvKeVfLE3jItfKwxjH+lCWlfrDgJyp/jPFTMRvVQir261Bk/4zKIwcno/O4tSGNq
 u2d5xrV0VSFNFFYBaKNDR9iFdj8osEUGeNDS2WuEYJkwqKk2Yg5JHiJ/vgGzS6CT4KBp
 I3F5vPC+6MjqS7qMnSu76hgYC8TWJAAZuohWeXKG5XkH1oL67Q4Qu3zXx0TrLI+WxprA
 C74dUBt3jucuJtdMxvUmimMj7jFLmozfYWXFxD0sMZUNKH2yhKVx5suqNnOOdCstPsNS
 hbVVFIJsfjP6v8/ejhX+Aaw4wM6rVfqJtkzaSFrSGoxENWR7EUjI92qE0u64MN9bIKQo
 lJcw==
X-Gm-Message-State: AOJu0Ywm3tZfIyQI1fx6vVPhiVJUphyWj1P+mP4USFj1r0ehQbmDvHUN
 4dAiOdIsujO8aGQbRenml3f4eoX6Ahx0swtUurGty8Elbx3A4BWspiH+9ZfOliI=
X-Google-Smtp-Source: AGHT+IHroY7p68abGCsEJwAkUc/2Cf5JjqsgHDUZMX18VP5rNlnpkB/KmW7kyPJzvAC06+gXYyFj+w==
X-Received: by 2002:a05:6870:d1cb:b0:254:c777:6334 with SMTP id
 586e51a60fabf-25db358ea21mr8944028fac.42.1719960509551; 
 Tue, 02 Jul 2024 15:48:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25dfef434d8sm327085fac.7.2024.07.02.15.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 15:48:28 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:48:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v4 04/29] lib: Adapt digest header files to MbedTLS
Message-ID: <20240702224825.GT38804@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-5-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iqqAmZ1mrxCxbK0o"
Content-Disposition: inline
In-Reply-To: <20240702182325.2904421-5-raymond.mao@linaro.org>
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


--iqqAmZ1mrxCxbK0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:22:40AM -0700, Raymond Mao wrote:

> Adapt digest header files to support both original libs and MbedTLS
> by switching on/off MBEDTLS_LIB_CRYPTO.
> Introduce <alg>_LEGACY kconfig for legacy hash implementations.
[snip]
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 3e9057f1acf..6662a9d20f1 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -21,9 +21,105 @@ if LEGACY_CRYPTO
> =20
>  config LEGACY_CRYPTO_BASIC
>  	bool "legacy basic crypto libraries"
> +	select MD5_LEGACY if MD5
> +	select SHA1_LEGACY if SHA1
> +	select SHA256_LEGACY if SHA256
> +	select SHA512_LEGACY if SHA512
> +	select SHA384_LEGACY if SHA384
> +	select SPL_MD5_LEGACY if MD5 && SPL
> +	select SPL_SHA1_LEGACY if SHA1 && SPL
> +	select SPL_SHA256_LEGACY if SHA256 && SPL
> +	select SPL_SHA512_LEGACY if SHA512 && SPL
> +	select SPL_SHA384_LEGACY if SHA384 && SPL
>  	help
>  	  Enable legacy basic crypto libraries.
> =20
> +if LEGACY_CRYPTO_BASIC
> +
> +config SHA1_LEGACY
> +	bool "Enable SHA1 support with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SHA1
> +	help
> +	  This option enables support of hashing using SHA1 algorithm
> +	  with legacy crypto library.
> +
> +config SHA256_LEGACY
> +	bool "Enable SHA256 support with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SHA256
> +	help
> +	  This option enables support of hashing using SHA256 algorithm
> +	  with legacy crypto library.
> +
> +config SHA512_LEGACY
> +	bool "Enable SHA512 support with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SHA512
> +	default y if TI_SECURE_DEVICE && FIT_SIGNATURE
> +	help
> +	  This option enables support of hashing using SHA512 algorithm
> +	  with legacy crypto library.
> +
> +config SHA384_LEGACY
> +	bool "Enable SHA384 support with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SHA384
> +	select SHA512_LEGACY
> +	help
> +	  This option enables support of hashing using SHA384 algorithm
> +	  with legacy crypto library.
> +
> +config MD5_LEGACY
> +	bool "Enable MD5 support with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && MD5
> +	help
> +	  This option enables support of hashing using MD5 algorithm
> +	  with legacy crypto library.
> +
> +if SPL
> +
> +config SPL_SHA1_LEGACY
> +	bool "Enable SHA1 support in SPL with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
> +	default y if SHA1 && LEGACY_CRYPTO_BASIC
> +	help
> +	  This option enables support of hashing using SHA1 algorithm
> +	  with legacy crypto library.
> +
> +config SPL_SHA256_LEGACY
> +	bool "Enable SHA256 support in SPL with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
> +	default y if SHA256 && LEGACY_CRYPTO_BASIC
> +	help
> +	  This option enables support of hashing using SHA256 algorithm
> +	  with legacy crypto library.
> +
> +config SPL_SHA512_LEGACY
> +	bool "Enable SHA512 support in SPL with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
> +	default y if SHA512 && LEGACY_CRYPTO_BASIC
> +	help
> +	  This option enables support of hashing using SHA512 algorithm
> +	  with legacy crypto library.
> +
> +config SPL_SHA384_LEGACY
> +	bool "Enable SHA384 support in SPL with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
> +	default y if SHA384 && LEGACY_CRYPTO_BASIC
> +	select SPL_SHA512
> +	help
> +	  This option enables support of hashing using SHA384 algorithm
> +	  with legacy crypto library.
> +
> +config SPL_MD5_LEGACY
> +	bool "Enable MD5 support in SPL with legacy crypto library"
> +	depends on LEGACY_CRYPTO_BASIC && SPL_MD5
> +	default y if MD5 && LEGACY_CRYPTO_BASIC
> +	help
> +	  This option enables support of hashing using MD5 algorithm
> +	  with legacy crypto library.
> +
> +endif # SPL
> +
> +endif # LEGACY_CRYPTO_BASIC
> +
>  config LEGACY_CRYPTO_CERT
>  	bool "legacy certificate libraries"
>  	help

This is all certainly moving in the right direction, but there's
dependency issues:
   aarch64:  w+   xilinx_zynqmp_kria
+(xilinx_zynqmp_kria)
+(xilinx_zynqmp_kria) WARNING: unmet direct dependencies detected for SPL_M=
D5_LEGACY
+(xilinx_zynqmp_kria)   Depends on [n]: LEGACY_CRYPTO [=3Dy] && SPL [=3Dy] =
&& LEGACY_CRYPTO_BASIC [=3Dy] && SPL_MD5 [=3Dn]
+(xilinx_zynqmp_kria)   Selected by [y]:
+(xilinx_zynqmp_kria)   - LEGACY_CRYPTO_BASIC [=3Dy] && LEGACY_CRYPTO [=3Dy=
] && MD5 [=3Dy] && SPL [=3Dy]

Annoyingly I was not able to previously figure out how to make such
problems a fatal error, but if you look at the output from each of the
world build CI steps you'll see a lot of hits for "WARNING: unmet direct
dependencies" and that'll help you track down which are where and what
to do about it.

--=20
Tom

--iqqAmZ1mrxCxbK0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEg7UACgkQFHw5/5Y0
tywSHAv/QGpNncfYLrjy/NXvrCCrgQuSlrcjimpNSs2fxAiHc5GmYqVVjxyI8UQj
bi/YoZGVxM9F8MLU7Z1lzA4sYI21fYuPMU4LmU+Hxq86TUk2BzItphfCTPlMRTFo
eM0V6/9WA93AlR3jIkrZz9g3pew5iyYI99KKo5GusKxRBlC5sGLxNLJyFGuFFfVg
x5PbEClKCHDC6XhKYvA8mDpizTCu/ttYgCdEtRuIb2bF5Woyl/whTNCG07nopytH
lPJCMskVRPKsr35qOylTQM9cBI6Z/5BF+3A5ZNkL4pCKqekDdxFulGTkU0KjsnLD
6jeH2sF5SVYcnwKqPv4ExSbsgP3HZolMB+9QFIoAge0wzJyA9GLH+VWhGaQ0ufC7
ETd4aaXKsuP9vMSueXEHEOdoE5bieXpbSnWwwSso2hi0tXe2c2+M7asKy9E2KxN8
0UfZkBPwLMUGY40m6E6zUWTLOwsTbZHv5piUNeMi+50TiUrntzflTYIG9ooUmkdc
9odDpFQi
=4pzn
-----END PGP SIGNATURE-----

--iqqAmZ1mrxCxbK0o--
