Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EACC0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D48807FE;
	Sun,  9 Feb 2025 19:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nOfHYnsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A92680821; Sun,  9 Feb 2025 19:06:00 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EAC80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so2882375276.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739124357; x=1739729157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jEUAuK//npBGC05hVwtgCx0uIhRy3ptlcbFYDfJRwoE=;
 b=nOfHYnsFTPM7TMenHDGgSiUJOXEJ7k+8YAibgrF9OcRdmuldiq6rMVkObgXOKdRNSv
 XK8U5dYzwrqaG60by9t6UNZNyWB7Djhu/0DjfwnukMux3nkcC3WjsEM1N5a0owGxlDLH
 WYoH+V1EEYq4LrAb0taxVcCM4+NC9IAliXzFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124357; x=1739729157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEUAuK//npBGC05hVwtgCx0uIhRy3ptlcbFYDfJRwoE=;
 b=DsP0yJAMo2hWfikINYoIr0OBLZrXrby1FA6fIeqz0h1uMdHrJ5yY8cc7JN1mzVr/qF
 jFqwHxgj1BLifiEcTnG5iZy56HlNsMPON2tOXHCfjkxb7MWgZIzCFF/NYdA2PKM9shGw
 NIlNCM8HDkVRYaN+5F4+fNBYtRyFaCg5sLffTjszcQMC6U7ll9lTxkHhvKHpocD+z4a1
 x0b6egKzj3GNIw2+MGT6WQcuUaT/sRgR4twb1O4km4+6bl3RJ5JZhgmBk0Km4mE5A8zL
 76/mhJkFcOn91CvBrYuCLo4D1GlbenHJ+6ybbyLgx4Zm3YuUa9Y3Xk2Yoo3tmBFj01yS
 5DTA==
X-Gm-Message-State: AOJu0YwWUl0zNvu4hXGPGJXb7DJ7F2NGTWnALchj3hw5RE+usYcxH69L
 ecrbYRWD3ooMux20lNu59xwd7omRQpvWXWlmmpN2zqQn+kiAuonHFvcseA3Wubg=
X-Gm-Gg: ASbGncsHeVyHykHiYrfOBm5f13zxzovzVXQHrhaIIUMoeS+fIVXHaZWShMRzQtUh+II
 EA+ndaQs5xEM2FRtvCo4X6bcdui9t1B1Nx4MGsqUjbmEed04H0yMqj7HzKLpL4Yjf33TGoaJV8m
 YrJT/vOM0uxa2sYMjeUfP6hxCrEizFvsP0UlwrzjkMmoAwVLAxJcpLqIM/dsUAJSM/giL5+952V
 wtFz45UFADorLd7PEW7mSo7ac5Fs2kWr5TTFCbh/cBrUYdpTZ3sU71bUH+DxXFjRfRCshP8fsOZ
 /pDbdd4jwMTsCqc=
X-Google-Smtp-Source: AGHT+IGIRS1FhIF9Ju6TjMUQEUi8qHAUPanH7hv5LEIiKzZB0kHleOg7XiwnqpQlLBOXqGFn8hfiUw==
X-Received: by 2002:a05:690c:4986:b0:6ef:a4ec:f698 with SMTP id
 00721157ae682-6f9b280fac4mr100764307b3.3.1739124356698; 
 Sun, 09 Feb 2025 10:05:56 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1bb65sm13151257b3.29.2025.02.09.10.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 10:05:56 -0800 (PST)
Date: Sun, 9 Feb 2025 12:05:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 19/29] efi: arm: Drop exception-level code when
 running as EFI app
Message-ID: <20250209180553.GT1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-20-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XmYQr4JUW/u5g3CA"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-20-sjg@chromium.org>
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


--XmYQr4JUW/u5g3CA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:18PM -0700, Simon Glass wrote:

> The switch_to_non_secure_mode() function cannot be used since EFI is in
> charge of managing exception-levels.
>=20
> Build just the exceptions.S file.
>=20
> Modify the existing SPL rule to cater to the EFI app too.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v3:
> - Rewrite the commit message
>=20
>  arch/arm/cpu/armv8/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index 2e71ff2dc97..7bd6cf21b19 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -13,7 +13,7 @@ ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
>  obj-y	+=3D cache_v8.o
>  obj-y	+=3D cache.o
>  endif
> -ifdef CONFIG_XPL_BUILD
> +ifneq ($(CONFIG_XPL_BUILD)$(CONFIG_EFI_APP),)
>  obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) +=3D exceptions.o
>  else
>  obj-y	+=3D exceptions.o

Yes, this is still confusing and needs to be tidied up, please just file
an issue and I'll pick it up.

--=20
Tom

--XmYQr4JUW/u5g3CA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo7oEACgkQFHw5/5Y0
tyypFgv7BSs0s/0gbOkgn0JOYbfFNL/w2X7G9NHZlgAuT7fbvkldJ0YunPBPzpn4
MB4QhD0/PaO6zcpWqqyR/AmteyRNi12mTsJ5kJw46ta8Um2cxeOoNh+P5H5ETUm7
MqOIwYnLzMMoSV/AUyir1mgShVA+vIU7xJhW+kbsPjFP+sw5X2hPDRvmL8VtboB8
Kaosf1CCgV+BuWZmmHLac8qHrN3BjO8dCDRZuG638+uAmbbNIm7e7dB3fCQfWyXj
Fda+raPsrwpXXNKk/f4z3cHmu2SUeW8sg/5mKvXlJLWq9TA0hrtHymrPSnwCCm2X
YQKwnqb92dy4mR79BcKpPcKWnSnDkAalBC3XiQwHysz/E2uKPenh3dDZH74pov5v
czCSOySSir5hQJhI52Vj4b3DPfJEws6MPNFwe3xRQ7omivcq4HKeiFqfH7HOfKr1
Gl13AvybZBoGzoF5SFaDvB95MeP+vlDGVD8mpkZFtDj9JLg5LbUh8CEtlsOeQduX
SQFBvjjd
=lMXr
-----END PGP SIGNATURE-----

--XmYQr4JUW/u5g3CA--
