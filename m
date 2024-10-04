Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1EBCF8853
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326E988CC1;
	Fri,  4 Oct 2024 19:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mx+65VSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D13889DA; Fri,  4 Oct 2024 19:14:38 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A823788C98
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7ae3fcec5feso224108785a.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062075; x=1728666875; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uD/uMPA+cRo81oQs06iKcGcTNb4l4MYljlBt7zP64LM=;
 b=Mx+65VSqFi9KPaPgBzK++V/+rqWRcKlzmJ6HFA+zjCy1SFkFYIksvwa6YBu3b/bMJG
 w5ZcQHvUNuLQ3LYrE/6jLD0G3B8AsgSFrJY17YxAL51GtBkppEjcYHdDoFt/iR5xZaU6
 lQSdT7DJ/StBonSeBQf49/lROtrXn6TwrfYEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062075; x=1728666875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uD/uMPA+cRo81oQs06iKcGcTNb4l4MYljlBt7zP64LM=;
 b=rZrMQU143jozYmJi7eXasNhIWfNbM/80iT9g6S2tN77D062W8tbnFIyzN+FXXyfI0s
 lAeaNfo/2fuZtmzsVgXCYrq703UKj465L5S9Kgf9w57jR83q3iP9HzQFbA0StRkJXA4g
 FqZpewRT8BvHdPrXmuTsOFzqW/OTeXZOLs7+PK0B70q/lpo5GHOngRzMKXKGtuiyTcaC
 l9qRYP4+b9EkgY3OXKbu3UkYnhWytw4V12zfohVSeQoujtWmEy/TOuhVuFLEK4g5lExx
 PC5u7LtOWp6ev3np/n07LBge6hBU0Q+81eyrSTG/0crrzlf4bpN9kW/E2ukXnNm7DM6h
 4Y1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/1NFv/l+F1HwyRt+NoAuz0nGYASH543Tn6VTFllfVV5vMRehEg7elEkbjdfVqreBAd+5FIsU=@lists.denx.de
X-Gm-Message-State: AOJu0YyzpYCBtQhU1B5WyHu+k3ioRevH6ZtRuncGuqjTDuX9TbPyYb/y
 /9aFaJXLR+5LV5VQ5sGuh8KrJaGPcp2yQI5hWu8An6umPmOmEzuDdQwgwVxfmnU=
X-Google-Smtp-Source: AGHT+IELB08uihQDLV/ZZkQEWA25YvfmYwNTiHty64U8JJy3ISbChj8qSE3xINU3Acinb2fcBE12mg==
X-Received: by 2002:a05:620a:400d:b0:7a9:acd5:1b21 with SMTP id
 af79cd13be357-7ae6f486943mr637890085a.50.1728062075398; 
 Fri, 04 Oct 2024 10:14:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cd4fsm2806885a.50.2024.10.04.10.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:14:34 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:14:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] cli_hush: run bootmenu on retry
Message-ID: <20241004171431.GB4737@bill-the-cat>
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
 <20241004-qcom-phones-v2-2-c7ab67ac3043@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q3/qoJeGw+cBXVJh"
Content-Disposition: inline
In-Reply-To: <20241004-qcom-phones-v2-2-c7ab67ac3043@linaro.org>
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


--Q3/qoJeGw+cBXVJh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 02:46:51PM +0200, Caleb Connolly wrote:
> When CONFIG_BOOT_RETRY is enabled, make hush shell always run the
> bootcmd. This is an improvement over failing to build.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/cli_hush.c          | 2 +-
>  common/cli_hush_upstream.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/common/cli_hush.c b/common/cli_hush.c
> index a6a8edce1f43..3c6fd6f00a1d 100644
> --- a/common/cli_hush.c
> +++ b/common/cli_hush.c
> @@ -1028,9 +1028,9 @@ static void get_user_input(struct in_str *i)
>  	  puts("\nTimeout waiting for command\n");
>  #  ifdef CONFIG_RESET_TO_RETRY
>  	  do_reset(NULL, 0, 0, NULL);
>  #  else
> -#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
> +	strcpy(console_buffer, "run bootcmd\n");
>  #  endif
>  	}
>  #endif
>  	if (n =3D=3D -1 ) {
> diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
> index ab5aa5f9b36a..93eb0d85a95a 100644
> --- a/common/cli_hush_upstream.c
> +++ b/common/cli_hush_upstream.c
> @@ -2907,9 +2907,9 @@ static void get_user_input(struct in_str *i)
>  		puts("\nTimeout waiting for command\n");
>  #  ifdef CONFIG_RESET_TO_RETRY
>  		do_reset(NULL, 0, 0, NULL);
>  #  else
> -#	error "This currently only works with CONFIG_RESET_TO_RETRY enabled"
> +	strcpy(console_buffer, "run bootcmd\n");
>  #  endif
>  	}
>  # endif
>  	if (n =3D=3D -1 ) {

Lets add RETRY_BOOTCMD or something instead, I feel like there's some
locked-down systems that rely on this behavior.

--=20
Tom

--Q3/qoJeGw+cBXVJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAInAACgkQFHw5/5Y0
tyxVbwv+NYFmxnKLvR9pxM/t5k+JwVp9hVVImo5O9uI78W5Owmh68nOOX1SWPRJH
L4RAMTYD6iHsePzmfosNBD3wkl9Si9E+DIEzFOa1veS41EBPIbEmp8EPvjI9RsMn
gw5YzzG+YBhzDKsjSSvJgjya4fSOEL13dWH7Q0gWFkpsdTWBRkweh8+oNsq5tXnp
MsrlQY3Iy9+cgu0LKYW8es8GsLJEhDOr6BbhRqRybj0moQlh+xEEcUUl/J8hb8IE
5bS/fMwYLur5UawNh2tJpq2Y698GPrZjA5VlUWvZqhMWPCtn1HsdAMUBVCFh3C91
TjciLuQVwlD2S95kuZgPGuwry4Rzx7Tud5wKVFfbtaZXFAcV18d8Eru9Ks8HDVL2
+BGOnWU1UrPrAyMw6Rh0uLCf9FHm8NgQw1i5cqr23PYAuJbJLLB9C/RhgeKeT7UL
9/4lpg8gn5csaBlO4CA7B/lxArjfnu5b/Ti3Dt05qWnfTHXBfiRegDo1XgBwKsW4
a+u5OquD
=auj2
-----END PGP SIGNATURE-----

--Q3/qoJeGw+cBXVJh--
