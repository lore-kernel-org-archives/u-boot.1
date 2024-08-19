Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A8C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 21:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B8188CA8;
	Mon, 19 Aug 2024 23:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEu4085X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F19788D0F; Mon, 19 Aug 2024 23:03:24 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C082188A82
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db1657c0fdso3002705b6e.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724101400; x=1724706200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bH9EomgQDbS2q9hwcrh8y3tRMAQcBNQayBjkVi9ylUM=;
 b=UEu4085Xb6W6Q060bGnQbt4m5fXZIolgke4zjmGotCgGG4mHqOE3onjGGhOqR2WYgu
 767co/Azq1gT5VDBK4ZgMZqC8mcnZoJVzUMnJ2YHwNwxrM7rZGTWyaXqsteZYhefpxxt
 nXd0yu+XqT16h5TVdemqSYCBY3iZFhw9VEQnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724101400; x=1724706200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bH9EomgQDbS2q9hwcrh8y3tRMAQcBNQayBjkVi9ylUM=;
 b=aNDHvD4r9lr4MZMtUTig4KqopQvbauMfy8GWF5PT4PUM+Sv6dXenBvo8/7UUBl8oty
 D4GOojEMnV+LCjmmsOnZJ2lEqCDZhjN1e2xWFKr7B0caJ2PpI1i10aqYzGgLfOAQsvqJ
 TiOWXXUVzbSQJSvaSDyKVylr1goFUtiILoDuUZGBF2SbZdVIEJ164B7KqrQn2soW3W+z
 1vPrJIiWfa4BnVc09eGwOTnAcrYWgL/LLfCqBtvAu93P6KkqzTEPJEOUymCZhj5FrYwX
 GWl76YS1GSt0i9UCPa6BqlGPXhH+fFVjqThdZT+4TUYLBOlCa4ur16vFhHZ9MIOvW4uD
 x0lQ==
X-Gm-Message-State: AOJu0YzBHcEpDueKN2bGhIzGUzDBsuaBRWMQd/IKwYkukNUe/99SoWxj
 Z8Hfab8zDi1kVPSsyjq6piZxkRjfyTKLZZ3/OIaox1iNTHXpJWkdaSECg4K0Q2A=
X-Google-Smtp-Source: AGHT+IEaMQSq0fJGH5or30wB270GtJCGemiGe0c8NVBbAu2IvaG6pk3llpRB/PV/thYoMK/0ic532w==
X-Received: by 2002:a05:6808:220a:b0:3da:a6ce:f040 with SMTP id
 5614622812f47-3dd3ad16804mr13318777b6e.9.1724101400243; 
 Mon, 19 Aug 2024 14:03:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33f09cb7sm2502220b6e.57.2024.08.19.14.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 14:03:19 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:03:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 08/28] mbedtls: Enable smaller implementation for
 SHA256/512
Message-ID: <20240819210315.GG1626301@bill-the-cat>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-9-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+9m7hSTKp6spk9AK"
Content-Disposition: inline
In-Reply-To: <20240816214436.1877263-9-raymond.mao@linaro.org>
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


--+9m7hSTKp6spk9AK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 02:43:57PM -0700, Raymond Mao wrote:

> Smaller implementation for SHA256 and SHA512 helps to reduce the
> ROM footprint though it has a certain impact on performance.
> As a trade-off, enable it as a default config when MbedTLS is
> enabled can reduce the target size significantly with acceptable
> performace loss.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v6
> - Initial patch
>=20
>  lib/mbedtls/Kconfig              | 24 ++++++++++++++++++++++++
>  lib/mbedtls/mbedtls_def_config.h |  6 ++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 12f8c965f5a..0e22edf1b6c 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -151,18 +151,42 @@ config SHA1_MBEDTLS
>  config SHA256_MBEDTLS
>  	bool "Enable SHA256 support with MbedTLS crypto library"
>  	depends on MBEDTLS_LIB_CRYPTO && SHA256
> +	select SHA256_SMALLER
>  	help
>  	  This option enables support of hashing using SHA256 algorithm
>  	  with MbedTLS crypto library.
> =20
> +if SHA256_MBEDTLS
> +
> +config SHA256_SMALLER
> +	bool "Enable SHA256 smaller implementation with MbedTLS crypto library"
> +	depends on SHA256_MBEDTLS
> +	help
> +	  This option enables support of hashing using SHA256 algorithm
> +	  smaller implementation with MbedTLS crypto library.
> +
> +endif

For each of these, they shouldn't be select'd, they just need to depends
on the right option (SHA256_MBEDTLS, etc) and be default y.

--=20
Tom

--+9m7hSTKp6spk9AK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbDswwACgkQFHw5/5Y0
tyw0swv+LhfifVN+3OlGJsgUF1/uEhy8idEp/hfES6LGoUOzgVOY4YZUJmUJatWb
ZE9VZW4HyvZRwp0UOhAN9w2mJq7lZeN7nqfSyzvpQzUvM0e101i/qPdEhd//NXNk
w69fLjmIScFvzvNIryXSrm8Cnj3S1haX/9kN68/OWJNddpXPkIflsXQgjJZwzw9o
Go+CNvj9VAeIAo/eHLVVIP15jGc5iRYw1qlKyDvggmVXuUC00/5GW67DGPxqL6Hs
XYlf02Rc1U0gvx3CFaztS7XNxmWUhzyOyeLqmy0/MjvzfnisOg5er2PDkh4woPXF
/HrF021g2PStYvfiOVeesKa0WQsrq2328bU5uphM5CrgGSGq7PQys73KEQL+PIux
fA0uwvSVnOk6EjWWxEOnkKXrniFY77kQjUlIvEKwJDvvky4vFIHDoxXHQ37TjVUZ
Y4xfhAvwjhbnk3WdF4FaofiPu2weltXdW3BwwwDSIotdNpo1gft4in9lHxQUJUUN
NHCGHiqD
=m/7j
-----END PGP SIGNATURE-----

--+9m7hSTKp6spk9AK--
