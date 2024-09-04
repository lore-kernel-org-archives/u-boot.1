Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093FACD4F30
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 21:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341198871E;
	Wed,  4 Sep 2024 23:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ixbpnpm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E0A88B6A; Wed,  4 Sep 2024 23:22:42 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403EF88381
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 23:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-498d7c37921so7139137.2
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725484959; x=1726089759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p3vXU9Mmjty5eGyY0FRqup4+dG1FtwIl6m9I1U9m0Tk=;
 b=Ixbpnpm+vmuyHRZxw22+6XsD6MBq1GztnXAt0tOeTDDciecWA6cANAdXv5l+zsxDXK
 I0TRDujbWbkYvWd0q35flKSAhV/f9PRR0F0wCVXAT/G1QQPIPG/WOblx34Or/ALCrqn+
 0lZXQGtP3b7sO52zrGCo37M6kAc08Pp0J5P5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725484959; x=1726089759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3vXU9Mmjty5eGyY0FRqup4+dG1FtwIl6m9I1U9m0Tk=;
 b=GvveazD/bQiyzVBnU2Kp+9If3ObVlXps8mHrfYKIdCD9MtQbYSW8koZdCVhwqkUUEs
 LWPNno6Z2R4FKIxdLWI0SEoRVUm2mfZ+KrQpIQvfjHAcJ4YfeoRPon4FmcXzTZ2CaoM9
 MAR1JKpit5QZfZoC3GAB/1lqJVCI9I6igEDho+pK8wUPdUoMYg4N3o/yFhGjegEtmNWr
 +5hfcsB1oGj/wJEVYRNvifpxaIRm8a/I3meocNgKJ9ZmDIqwKgZxsoyyWRCGPWvKSrQi
 RZzX+NDXDEg7KhrU9CBLb/C1qoCZvJJXXELOc7B3um6l7iajUDV2tF0oox0uNYqgVM3/
 Op+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkDjU0w5GP9l/y5Pq0akvEO/gRBcg//cBwoHF+gJPM9rM2++3nX72qLdWD870xU5czWbpRlkE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/CREnCAj/tje13PESVkk2eRavGtFVXcBzBHR6E68kyYWyqVxb
 olbipYunHMLxp+ZEqS3WWPdLMP0YYkJhs7/ftH7MFZSxh15UxSPE1/VJt4IMNUk=
X-Google-Smtp-Source: AGHT+IErldHut2yUARuISa0nKqoIbKpcJJXTj+7jI6o4WeJmZ9IUBhRyJCs0jYiyAdw4e34wyCX5/A==
X-Received: by 2002:a05:6102:b05:b0:497:6bb5:3991 with SMTP id
 ada2fe7eead31-49bad06e53fmr8635901137.0.1725484958876; 
 Wed, 04 Sep 2024 14:22:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef1cb64sm20539585a.25.2024.09.04.14.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:22:38 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:22:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Oliver Gaskell <Oliver.Gaskell@analog.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 u-boot@lists.denx.de, adsp-linux@analog.com
Subject: Re: [PATCH 12/20] arm: mach-sc5xx: clean up Kconfig
Message-ID: <20240904212234.GX2479150@bill-the-cat>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
 <20240828-sc5xx-upstreaming-patches-v1-12-44d9adfdf327@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F4cb62GgKJLg0mkn"
Content-Disposition: inline
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-12-44d9adfdf327@analog.com>
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


--F4cb62GgKJLg0mkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:02:20AM +0100, Oliver Gaskell wrote:
> Moves common options between all SC5xx series boards to the ARCH_SC5XX
> option instead of duplicating them.
>=20
> Also, it was possible to select multiple of the SoC support options.
> Given a U-Boot binary can only support a single platform, this moves
> the SoC selection to a `choice`, making them mutually exclusive.
>=20
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
> ---
>  arch/arm/Kconfig            |  8 ++++++++
>  arch/arm/mach-sc5xx/Kconfig | 31 +++++++++++--------------------
>  2 files changed, 19 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ba0359fed5..69decaa591 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1868,6 +1868,14 @@ config TARGET_LS1046AFRWY
> =20
>  config ARCH_SC5XX
>  	bool "Analog Devices SC5XX-processor family"
> +	select SPL
> +	select SUPPORT_SPL
> +	select PANIC_HANG
> +	select DM
> +	select SPL_DM
> +	select DM_SERIAL
> +	select TIMER
> +	select ADI_SC5XX_TIMER

This should be sorted. It's not required but it makes adding more things
later easier. And yes, there's many unsorted examples. This applies
throughout the series.

--=20
Tom

--F4cb62GgKJLg0mkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYz5cACgkQFHw5/5Y0
tyw3Jgv+Kh3updrFijLjBh9kqRZguKuIU37L18WPB2uV/C8xx7gk1LrbAa0HENpn
9pSZsI2tgXWl35KPP5MWAgV5VHgUi4SUn6+tmw1VqeHEdrv6EKEigBcdTSS91k54
Q2MIOm6bDMi7TDW+dvDUzVHdModwRt/CN3u8y96FgQHmUbZfvIqTGA5oY5L758Ut
a5gYC3HoSk0q/FgK4eMF8Z9QABSmYGqQt23NKLBa0XHlRtAJHi+Lgdke+f33brQo
lq7EvZOV2JjxDSgkSuu3mjYndV7vBn6AF6AwTCAJuRovlAvbM5syjMz6ZdpjdZwF
INv7BNLpuYduc2r/CfViyQg3CShhA+sPL9tOV/x2gOa7HWdJDHk1qSj6VQeSODPI
96+sFUD0lFvw4yjZmkofSu8YjnCiu+O016o6TAKk7f5XSz6Zm6Yccx3sIBQ/OY36
2ruwnkECPfcJvcHY0vEUN4u/eEB7/iesP1PHJ0ks/f0jmc8Asi7J31GvDRaWG9r9
5dYjvxuD
=qy9M
-----END PGP SIGNATURE-----

--F4cb62GgKJLg0mkn--
