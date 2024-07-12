Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9659DC3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C58887CB;
	Fri, 12 Jul 2024 18:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BNOuCYtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BCB887CF; Fri, 12 Jul 2024 18:48:11 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51520887C7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c667b28c82so1013179eaf.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720802888; x=1721407688; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=52EnsTVCA11AMo9m1dF9eoOwDDncq0d9DOHNG9fZTTQ=;
 b=BNOuCYtYfWgLaEerCfQHq5XNXLeIp12sWZv9G7g07KfaeOM4hprp2W2l4MmSmUTObm
 N90DfRWGM6QxHyGvcJnuynarSEmy045NzZnDVunN5WDN9BAdGPaUe15aWYUVnA+8IUiK
 ZHde3J/3o/OVgR0YbnaN9OkoKaKVbM1Gaf42o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802888; x=1721407688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52EnsTVCA11AMo9m1dF9eoOwDDncq0d9DOHNG9fZTTQ=;
 b=jXc1CAsecAJRf4jvG/FWyf7joTUfgJLUQNiJA9/xiaJo6CRgySl/FKyaVNOScA1lMV
 iMimWoovsKZPP2cZyMyoTB4p3b7RPSASq+ShFGL9X2M3U/0b23ejFw8FHvWuY2UP9aPK
 FKB9Lkx3+WOmcUYlQUevO3024381+sgGhaJE5is2HG8xv56EA2ZS+pMGlOjdGxlhCpfp
 mZYgAkuFT+OpYYoS0XxZeSiVA00fwak+i+2ET78WTxID+/GVxiGDQ6bJgG+vp3M+B1H2
 lqbdvyQkXF8PIfjnmnWEOa3MsGPH+9A7oXqnFcCElmt3wboNEoePwbF4I8MiVnd9BctM
 VklA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSEFeff/7X7NUmKNGA7QgckNMo/O/JFYFVXoZIwRbdoEi/sKuk6/X+IHxF6N97UOqIfg4dnmb9qckKsrJSu7T/yJWG3g==
X-Gm-Message-State: AOJu0Yw4oFsNcox8VeIf/aJ1KSH/sRwvwzLZ/iJkmYWTljxXk3i3yO+J
 kmt3CPaKVPh/dYv+ZvIAJ31MybsDggRgyGYEiriiVKMg6GT8vxPrbGhJlJnpjDY=
X-Google-Smtp-Source: AGHT+IFZA9C1V/QJEk/t/NiAsFduy8CvfM72Pl56qHJDW9qqBJyVep+llzpWQpFBeZOJPHu34kgUsg==
X-Received: by 2002:a05:6820:2226:b0:5c6:6162:6869 with SMTP id
 006d021491bc7-5cc9426b601mr1909994eaf.0.1720802887929; 
 Fri, 12 Jul 2024 09:48:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c68cdfcec8sm1206769eaf.43.2024.07.12.09.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:48:07 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:48:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 3/3] arm64: unwind stack on exception
Message-ID: <20240712164805.GU38804@bill-the-cat>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
 <20240710-arm64-backtrace-v1-3-5a2ba50485dd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QAE4hyqDN6erCiy/"
Content-Disposition: inline
In-Reply-To: <20240710-arm64-backtrace-v1-3-5a2ba50485dd@linaro.org>
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


--QAE4hyqDN6erCiy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 06:26:20PM +0200, Caleb Connolly wrote:

> We already build arm64 images with frame pointers. Let's finally make
> use of them in tandem with the new symbol lookup support by unwinding
> the stack when an exception occurs, producing a backtrace similar to
> those emitted by Linux.
>=20
> In addition, introduce a dedicated unwind_stack() function which can be
> called from anywhere to print a backtrace.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/include/asm/ptrace.h |  4 +++
>  arch/arm/lib/interrupts_64.c  | 76 +++++++++++++++++++++++++++++++++++++=
++++++
>  lib/Kconfig                   |  6 ++--
>  3 files changed, 84 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index a836f6cc60db..f42cfb33e918 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -22,8 +22,12 @@
> =20
>  #ifdef __KERNEL__
>  extern void show_regs(struct pt_regs *);
> =20
> +#if CONFIG_IS_ENABLED(SYMBOL_LOOKUP)
> +void unwind_stack(void);
> +#endif

No guarding prototypes.

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 06a78f83b7d6..092b780aeeb8 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -979,11 +979,13 @@ config VPL_OF_LIBFDT_ASSUME_MASK
>  	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
> =20
>  config SYMBOL_LOOKUP
>  	bool "Enable symbol lookup"
> +	default n

This is already the default.

>  	help
> -	  This enables support for looking up symbol names from addresses. The
> -	  primary usecase for this is improved debugging support.
> +	  This enables support for looking up symbol names from addresses. When
> +	  enabled U-Boot will print stack traces with function names when an
> +	  exception occurs.

Please just word this as you want in the previous patch.

--=20
Tom

--QAE4hyqDN6erCiy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRXkUACgkQFHw5/5Y0
tyy4awwAkJzS0bfMQ3y8caOos3D8CnyxmLvP7K9GD+rWY3gpMwhf443+MNsu/b1e
lFzAcMaPbVa7Y5iglo+41buoueGcCl99sbaTQoHONy2Se3egoWbCSSavU1SI/X1k
oJuHLL2W9AMIN3bZpE9rEKIZ7mCp+uCQpzt4bzAdq+ITwMh2Iu27IqNTR9Q5XNQt
bBgZGPqHYJt83Kf+RIQFRGcK0nDpzFErzMbfT0FuV4UKDgW94Ebr/mnDfP5aWmeW
TC3X3RU27GncJFCauOMxuJZT9vY/rbRBgV9ELNdGlpc444AnTdn6bBWw5XHqOTte
sxF58H6mwJqQqYD3RopgCUkQXqHUZvrzxJ2xWTOMquPkjHr2RFASOtvc+c3OiaTr
wq8QBg2Zuj0lhnhy+APdTyGTLJuQ2TOzGT44aJ5z4fo08jfoBB1UKzEOKmlK4X5Y
QdqvtPRlfmLGGGpNGd0l0ntENZ5Dpcaa6UZcW/0WE/Tw8uQ9P+aOBjLRX5g3JxxS
X85oWTTR
=bCC8
-----END PGP SIGNATURE-----

--QAE4hyqDN6erCiy/--
