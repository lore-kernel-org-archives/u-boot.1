Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83DACE7A8B
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 00:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72D286BF8;
	Mon, 25 Sep 2023 02:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z8xJgaSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD1886BFE; Mon, 25 Sep 2023 02:40:09 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A9B86BA6
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 02:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d776e1f181bso6323776276.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695602402; x=1696207202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8wQ+6t9WPWetIKnMDYufhoxe5a9YF8UrLiXndd7MVKk=;
 b=Z8xJgaShI+GukeiDEigV447k6LeZoTag0kGNA1/Hnk7PB7il9pan5QEE4f4WLteYkm
 V1gnHeCywFpgWEP2FbwysuGim6ma+nB2owKLduo14v4mcSv0YqQsuC7zejCs6DNtFG4x
 EG3dEWz+4qQ9lZL9u2c0EmEdJU91iQiohB8Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695602402; x=1696207202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wQ+6t9WPWetIKnMDYufhoxe5a9YF8UrLiXndd7MVKk=;
 b=GRBMikLn/vNELwHRpc4to0JtMRT21wcg5S+eXfRcUtTzAA0Jg3wcLU2DphhPDAbRRD
 6ZhFU2NP0B/wak6PnA+nD9GKCafT3T77atAZk+zjLeaN5m4qtcyk5Iv13vEEJJUSpGCd
 /4/5yVcqy5JAnYTliy7KNAfr+8YDDoPXkXYv5D06vBhAYf51rlU8iQNGspe1O5bmLpDW
 0itCVmor83aaPxpBhdgyDRNZ1EOSGOWlFbwMfiQnA2q1x+3m1vzVN/UIqCyzSkGwBOGe
 XYzq7E4eqhK1mCJ17BGtODOiGuURUaC5k4JBeex2MVO83A1tgRDzbQPwArLSU471mz+Z
 +xSQ==
X-Gm-Message-State: AOJu0Yy7YCEiDHDkHoCJmmNQQSJtp/d7Es5ngpo4XJdAhPpxmmUjr64q
 txvocjv6nL55n4oLDhB781Spn7wGLvrbHBg5xyB9Mw==
X-Google-Smtp-Source: AGHT+IEBMwRATfSVC/qRpST4lw8Kenz1pAlwFiqHkZaq4IiQbMKGBScABIWYDqC8iCKG4QtzBcy4MQ==
X-Received: by 2002:a25:ccd1:0:b0:d7a:ee98:4f8 with SMTP id
 l200-20020a25ccd1000000b00d7aee9804f8mr4508139ybf.30.1695602401964; 
 Sun, 24 Sep 2023 17:40:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a5b0c44000000b00d81c86f121esm1886335ybr.11.2023.09.24.17.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 17:40:01 -0700 (PDT)
Date: Sun, 24 Sep 2023 20:39:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 03/25] autoboot: Correct dependencies on CMDLINE
Message-ID: <20230925003959.GO305624@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fczKkRZej3ARO7Ib"
Content-Disposition: inline
In-Reply-To: <20230924203953.1829820-4-sjg@chromium.org>
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


--fczKkRZej3ARO7Ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 02:39:21PM -0600, Simon Glass wrote:

> Make AUTOBOOT depend on CMDLINE since it is mostly meaningless without it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/Kconfig | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index f74ac7e9cc72..41ec2c34bf74 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1167,14 +1167,16 @@ menu "Autoboot options"
> =20
>  config AUTOBOOT
>  	bool "Autoboot"
> +	depends on CMDLINE
>  	default y
>  	help
>  	  This enables the autoboot.  See doc/README.autoboot for detail.

This is fine and correct.

> +if AUTOBOOT
> +
>  config BOOTDELAY
>  	int "delay in seconds before automatically booting"
>  	default 2
> -	depends on AUTOBOOT
[snip]
> @@ -1322,6 +1324,9 @@ config AUTOBOOT_STOP_STR_SHA256
>  	  includes a ":", the portion prior to the ":" will be treated
>  	  as a salt value.
> =20
> +endif  # AUTOBOOT_KEYED
> +endif  # AUTOBOOT

So it's ~200 lines, yes, hiding this under an if, or perhaps a menu
makes sense, however...

>  config AUTOBOOT_USE_MENUKEY
>  	bool "Allow a specify key to run a menu from the environment"
>  	depends on !AUTOBOOT_KEYED

It looks like there's more stuff to move under a menu/if here?

--=20
Tom

--fczKkRZej3ARO7Ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUQ1t8ACgkQFHw5/5Y0
tyy6WAv+NrKMcnZooI2ELatAzoVmi6XD9uWe+hhT0HemJgMND0iK/X9g0JtYYwlj
VB8LsxDb6vKFbFJq1QMlJWD6MxaLJ2os76bVubVSNwn4I41oUR4i7YHHul2nUkhR
ZbpXCd5asRpmAEdM5TdAlpZFuFWZvxUItxVAK51EKurM2PO6/gm9W2D2fRUEYD7K
AVoDHJQYWtBHwk3LXuvaCLFL/BKxVzmzXbj78Mt54giujqN53jeC05fz4cOkyNGY
w6Vp2tYsfLs6sdJJU+eNAdZb9gwysywMzEOsPm7AFCBGNHKGS7OO5HouqNYR7wPc
+PsPZ7VVcrwkcVW6rM51x+NuY5uuuzUuses4xjyOv6fRvyUhJ1z+vWxqQ5U4EtT3
hhk2jHo/33T8aV8Q8bxHIgaeoYkoW4Y15pmAohkxU26hR6xW/GsCjWYzUTjUAXJM
Ng9RzIcQwB0tevPha4oKsPT7nYTxWW2XBmVq3ceKGJYEm0ZmJ+B/hme7gTgBsdhb
DRhDFFrg
=LXD8
-----END PGP SIGNATURE-----

--fczKkRZej3ARO7Ib--
