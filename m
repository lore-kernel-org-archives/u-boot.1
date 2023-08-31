Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED27C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8917A86561;
	Thu, 31 Aug 2023 16:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EOu/xlyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFC0865A3; Thu, 31 Aug 2023 16:18:48 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F3E855CE
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5922b96c5fcso10520947b3.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693491524; x=1694096324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6RwTBpJ9a6sUqljaFhj787PPBvMlvdkv3v4p/H6N5wo=;
 b=EOu/xlylN4jYLDARtsEAnO5OgZC8BXWttcwmZvTqsQqfivEhseGK7Ww9QPeud/cI6s
 dcPS2bmB3bT/brbwl7nW4EVrFDuOctA9p/w3Dscai19XC+N6Ef7wc52UBynN22CNC8w0
 u0vvHCtVkZrpWbgymoa3dCDthzFn+GWM5H6sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491524; x=1694096324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RwTBpJ9a6sUqljaFhj787PPBvMlvdkv3v4p/H6N5wo=;
 b=Tev9e7XrTSNWKfKkl1JKz4gi+xtGFuVtdr1jUU0CUSMwaq6GbGE7DdQwCGHH339mPM
 L+XvbgT1JdzqiBBwiSmCIPgB/A2He1W+Jm3z8tELJBxX3VwR00cPjdZxbrrxZ8HUgX3U
 WeRVnJvzF8VcGpT9lkz3hFtOgB0fHkQhlmz6AKX6CohcmKCl12U9wyvkirXtXeU0WLXS
 nGkCjIf7H4fcUe83tXx4NiK+9zv7BrmJkI2U+LeaEAfjanTwIIdEtnMsdYvmPLdd24+P
 vI011gCj61+rw8AkhhkpD2+F0yAr9wOBerXsbCCigqIVlKKMQTyZFdpCew8F7EvQ4Vcr
 RR2w==
X-Gm-Message-State: AOJu0YxZ1GCh4tJ87LxhmyBJtV8esIH6gKuBV5BoQVSJnoS+spynLPs9
 oSv48piB/+tvb9hBNI0whSeEdQ==
X-Google-Smtp-Source: AGHT+IFlI5lP8YYz2bPP/7SvS01NUnSjFkPvKWs0H7JC3QHGyDXQcLT6XAkuAdcQqJwtIslkvks91w==
X-Received: by 2002:a05:690c:ed5:b0:57a:9b2c:51f1 with SMTP id
 cs21-20020a05690c0ed500b0057a9b2c51f1mr7674006ywb.1.1693491524523; 
 Thu, 31 Aug 2023 07:18:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a0de703000000b005925c896bc3sm440240ywe.53.2023.08.31.07.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:18:44 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:18:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 17/19] Mark DISTRO_DEFAULTS as deprecated
Message-ID: <20230831141842.GX3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ed63+8TWQV3ix891"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-18-sjg@chromium.org>
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


--Ed63+8TWQV3ix891
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:53:11PM -0600, Simon Glass wrote:
> Standard boot has been in place for a while now. Quite a few problems
> have been found and fixed. It seems like a good time to mark the
> script-based approach as deprecated and encourage people to use standard
> boot.
>=20
> Update the DISTRO_DEFAULTS Kconfig to encourage people to move to
> standard boot, which is able to boot Linux distributions automatically.
>=20
> Add a short migration guide to make this easier.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Mention in the DISTRO_DEFAULTS option that it is script-based
> - Expand and rewrite the commit message
> - Use the word 'Mark' instead of 'Make' to improve the English
>=20
>  boot/Kconfig            |  7 ++++++-
>  doc/develop/bootstd.rst | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 458512a4ade2..a7dea0a0623b 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -784,7 +784,7 @@ config SYS_BOOT_RAMDISK_HIGH
>  endmenu		# Boot images
> =20
>  config DISTRO_DEFAULTS
> -	bool "Select defaults suitable for booting general purpose Linux distri=
butions"
> +	bool "(deprecated) 'Script-based booting of Linux distributions"

Extra ' ?

>  	select BOOT_DEFAULTS
>  	select AUTO_COMPLETE
>  	select CMDLINE_EDITING
> @@ -792,6 +792,11 @@ config DISTRO_DEFAULTS
>  	select HUSH_PARSER
>  	select SYS_LONGHELP
>  	help
> +	  Note: These scripts have been replaced by Standard Boot. Do not use
> +	  them on new boards. See 'Migrating from distro_boot' at
> +	  doc/develop/bootstd.rst
> +
> +

Extra newline.

--=20
Tom

--Ed63+8TWQV3ix891
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwoUIACgkQFHw5/5Y0
tyzZSgv6A71SrsTHvHMUbvf/+7vlnGWOjJCOT4yphy3hh5zGtcVKoMHtZQW75NTJ
/GrJ/49AUcLyvtX9pmOo6mLh8rle39L+EBpiU3ZVpbUCOczkmU6Qk+ntJifMfUV7
bfLUuAib0SZwM9NOwUg5oBtqNjJOxt6aBTGPtvhsSlFmm+wQiV6b/SXx9S/sNtUC
BeeZhn9ty7NjahwpSg0pL6x2hXqgzPWbwFaYTOxW/3sLMYCyrV5LNYk8SwhAlvi3
tqNCiXWwrekeUiSlCVHW+AlrIZMProstgudHr3gKK+eM+c3HrGlQm9u6VDwiHhPG
imra1z4D1oJ3XlufL6936q6l9rw3yRdWEniFH/RgLDK1ij7OglnCR1FcJRzTH1NS
LJ3xgIF+8S0t6cw+WcSGcNCfHwpKr1fwI8O7mZ1YNM7Ilm8vMWegBav/6/i1iwmE
xR0u1ujfD+x0Alj5GFyKbfG0SwMmfDMLxmR2CkSwYUxVDUr0Ic0p7dL2hOdyUibw
6pjSUy3g
=P+mE
-----END PGP SIGNATURE-----

--Ed63+8TWQV3ix891--
