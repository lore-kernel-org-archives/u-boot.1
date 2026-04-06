Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC8F46C51
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 15:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4418352B;
	Mon,  6 Apr 2026 17:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o/guoFd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC2C83936; Mon,  6 Apr 2026 17:30:08 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D9E8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-471618e202bso221353b6e.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775489404; x=1776094204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gkJt9JcaW8Na1c+/MerdznScDjpkH5ie30OCO7y11SE=;
 b=o/guoFd5MY8OUJMOx6uKJSye44EaG/ot/jETiXwiMjD51raiWftkGdubKitTp8XIuW
 aFff8mx6K5kLi1/LjcG8z9OlQ70EAoPbRNMJqpo4N41FgRQvG78Y1wHx3NqyRmNT1EcI
 v8WEwhd+PdKmDinHqAucx/BcjWT70uYLe++Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775489404; x=1776094204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkJt9JcaW8Na1c+/MerdznScDjpkH5ie30OCO7y11SE=;
 b=aZ68Ovx6Ip8u4u8GSlQQpYxQ3zjGFE/VGFhq6kb1FQoLfFCX/LFuPlZTIMb3QPlz+h
 iGb2ayPaHlJIweMagNAQu4Vu8yRS5C/QtADFqXCXROLoxYFY4ValeTwdtNVh70ctlQvJ
 QS4tLZejZTZkXhQv4JyQ9PSCg6ViPToe6dq6Djz3+C7ScNZ5M4fnTs7o8WROYfFhvmCK
 uuMMadPAGmuPD7LrwkNsZCi6xHzuIaHsGcLad/K8MLNIfy/L9EpDl0peejziigHvdMLq
 V0Xih/hMf1UMpx3RnrOzXzXnUaiCkiQAnmg6TByIOsJFEbsXE7tFeAiSLf458S9+Wc1L
 G/6w==
X-Gm-Message-State: AOJu0YzRl1erpVGqXaZ54nkS4uTGqlJM4Clm7GQhAGf4pGlrZ6XiVyLc
 CzlUmYA0CkA28F6QJbSOZ3w60L8BEr3ES7DxENHA3WOmzrSGISQY7nmNJ5EPu0sQ1C8=
X-Gm-Gg: AeBDieu2G5MTp2L4D8Yf0avzEyEMh8zpH5MQahai12wM3UqQJw0OYoC4/NRePJw46i/
 FzCAixmphV85RN+QzCivcQHHOcMGsmMkFIQEF3JAmdn0u+DdJZjNa1Gexw/BZJFq53oiGvFP0QO
 1z9pIWu3eNRyJx11fwFyRELtSkPWel3cNEe7ALxd3euZ15a37e1qnotfb1nkR7OBdsNoiCXDtY+
 OuWolUl7e8P/oEKgtEtRqP0XIw41Q3rf6mKZBmDFvAa7MAGQRdln1+SHYE83W7HhmZrabAJCghf
 RimAMNQHyb88BeL5K7tCRLJOI7aGAFkSEc2buBle1Y7WlrokqDjwG4P9esobIFbHS8O3obd1pwA
 1/Cr8mgubJpNNB9huSYcqLdhz2K5k/i4Vdb+0aYGmIEU9zexw6jvV+kv8imy3L+g6WoeHFpmSKp
 4LCXRhrEKvOiPqrzKzdUzNAwuO9gfy9I2mFl60rnm+uFtsr+gtbw7Dqy+2+vsNrcc1TsMt2J0gk
 G0Wj9vW8DEru+16njoOKTryNCYQQJmplF1cpxhN0Msb1V86
X-Received: by 2002:a05:6808:1929:b0:467:16e4:d276 with SMTP id
 5614622812f47-46ef4f06856mr6255552b6e.3.1775489404145; 
 Mon, 06 Apr 2026 08:30:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d92a5354dsm8472624b6e.12.2026.04.06.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:30:03 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:30:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
Message-ID: <20260406153000.GP41863@bill-the-cat>
References: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
 <20260405-ui-cosmetics-v1-1-bffec3cac741@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YSK2fhroHlqKgcMb"
Content-Disposition: inline
In-Reply-To: <20260405-ui-cosmetics-v1-1-bffec3cac741@postmarketos.org>
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


--YSK2fhroHlqKgcMb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2026 at 10:49:04AM +0000, Ferass El Hafidi wrote:

> The autoboot prompt used to only be customizable in Kconfig when
> AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
> autoboot prompt alongside a splash screen, there is no reason for
> AUTOBOOT_KEYED to be required for this.
>=20
> Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
> print_boot_delay() instead of a hardcoded string.
>=20
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>  boot/Kconfig      | 31 ++++++++++++++++---------------
>  common/autoboot.c |  4 +++-
>  2 files changed, 19 insertions(+), 16 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index bfed452d77e..6c8ec356996 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1560,6 +1560,22 @@ config AUTOBOOT
>  	help
>  	  This enables the autoboot.  See doc/README.autoboot for detail.
> =20
> +config AUTOBOOT_PROMPT
> +	string "Autoboot stop prompt"
> +	default "Autoboot in %d seconds\\n" if AUTOBOOT_KEYED
> +	default "\\rHit any key to stop autoboot: %d"
> +	help
> +	  This string is displayed before the boot delay selected by
> +	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
> +	  output indicating that autoboot is in progress.
> +
> +	  Note that this define is used as the (only) argument to a
> +	  printf() call, so it may contain '%' format specifications,
> +	  provided that it also includes, separated by commas exactly
> +	  like in a printf statement, the required arguments. It is
> +	  the responsibility of the user to select only such arguments
> +	  that are valid in the given context.
> +
>  if AUTOBOOT
> =20
>  config BOOTDELAY
> @@ -1597,21 +1613,6 @@ config AUTOBOOT_FLUSH_STDIN
>  	  This can't be enabled for the sandbox as flushing stdin would
>  	  break the autoboot unit tests.
> =20
> -config AUTOBOOT_PROMPT
> -	string "Autoboot stop prompt"
> -	default "Autoboot in %d seconds\\n"
> -	help
> -	  This string is displayed before the boot delay selected by
> -	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
> -	  output indicating that autoboot is in progress.
> -
> -	  Note that this define is used as the (only) argument to a
> -	  printf() call, so it may contain '%' format specifications,
> -	  provided that it also includes, separated by commas exactly
> -	  like in a printf statement, the required arguments. It is
> -	  the responsibility of the user to select only such arguments
> -	  that are valid in the given context.
> -
>  config AUTOBOOT_ENCRYPTION
>  	bool "Enable encryption in autoboot stopping"
>  	help
> diff --git a/common/autoboot.c b/common/autoboot.c
> index 1783ef92c94..d12d618fea3 100644
> --- a/common/autoboot.c
> +++ b/common/autoboot.c
> @@ -379,7 +379,9 @@ static int abortboot_key_sequence(int bootdelay)
> =20
>  static void print_boot_delay(int bootdelay)
>  {
> -	printf(ANSI_CLEAR_LINE "\rHit any key to stop autoboot: %d", bootdelay);
> +#ifdef CONFIG_AUTOBOOT_PROMPT
> +	printf(ANSI_CLEAR_LINE CONFIG_AUTOBOOT_PROMPT, bootdelay);
> +#endif
>  }
> =20
>  static int abortboot_single_key(int bootdelay)

We shouldn't need to guard this, as it's always prompted for now during
configuration, yes?

--=20
Tom

--YSK2fhroHlqKgcMb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPRdQAKCRAr4qD1Cr/k
CsQWAP9A5i+8n9k8RNH2THMB7z4OnKVN+LewvQs9H4hmEk+BSwEA2Qz2Ocxr3EVV
kh1s6Rtxp/apMJAXF7Bd9nru2B2kZw4=
=rQs0
-----END PGP SIGNATURE-----

--YSK2fhroHlqKgcMb--
