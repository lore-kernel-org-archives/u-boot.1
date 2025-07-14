Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD06C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 16:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052B382E37;
	Mon, 14 Jul 2025 18:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i1Xk7H/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA0082F14; Mon, 14 Jul 2025 18:29:58 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD7082CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 18:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-61591b6d59aso80701eaf.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752510595; x=1753115395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n//Y5JXGO2IDXVlFqo+yd2VItikqvoqZrDL1MWKD99Y=;
 b=i1Xk7H/MSjWtxezQvL+UIuqTb7z8p2wcwUMeO8fN8G9bOyrd0uYmRW/NItsMnZpcgC
 p/y8dOtIwyEypQBXfHog5+Ss4FRAfCg7M7OoXqaS+1ZL3/8ZOtLNohQez/ZS0yYdI7Hv
 sON/5UbYzPCPwr3gRSU/U8a7Wn/FB/4Q5LJzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752510595; x=1753115395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n//Y5JXGO2IDXVlFqo+yd2VItikqvoqZrDL1MWKD99Y=;
 b=juhKaKcCEfar47m0pAWTskCzklto4WXzQhgpD608eWS8WBl9cy3KCu3bTO09D0JSiw
 QKv2E5b560VYbJ3YoFPhjnLo7qq7aMHo0KVBmFSDjcI4gZfFI0SjaEGRq8GRL5FwIXoW
 dwhF8yKQwHsQVJcQWnrLWVsjbRMLqmKPpYgE8iS0/zN/e0daIV5dqjJDNXa57X65nrU2
 ZTxCBZeJmRIl5baTQdUsW1KeBVAOnCEi7GeKTta5udpnsZV1q0XHSd/zEc7FdG8qjuYJ
 L3LB4+higfoeu6vniMNTOaW/8p48WjP+nRmvvOY3hGjr3h7uw2AopbPmRnFoQwmD8gIT
 laJA==
X-Gm-Message-State: AOJu0YyI2r7ZsFgrIDwq9sB06l4ztYrBnHOFbtdnL+/Vlv9OJ0O4xXsl
 Cbw+VBVzm7VrXj1JQCEh4Wzj1kE7fXujWTykScarurPMt4BLqbE/8YsJiRZiOT4IpH0=
X-Gm-Gg: ASbGncvL1SyC6ysgS7cFQxZrrP2q5Jn+x+A3gWPAyKnsga0gHmO9/rIc7C1fpFmB3v5
 tftvBS50JF3VKPtTEMOR0loDcYx/IBJ1pWxqrU4YhLRZn8hZeXDzhiReUgD2OecsssZJ9QMxUe7
 fVEO35WahIY9fsHvXP3WDUYOrZxQjoDiaQpblYBP1H1QkhfEYJwnFgcTRbD5ACfYQgD7L+w4eHe
 dDLYuxwpWqTnpfwEdKm7Z5ALzdNE32+JM9GbaW9SmdsArch0vGTKin+RwD47nEClDuOUjuTlg4Q
 5Q7k6E7I/OakndGd+5PjiMUdeWKpOqyQUXZm43r8mMADWmlgw6tYHOmDpX/yQw+Vt875nw1XsaN
 Wvh5bxZ8JK6Y0FqF5nlcmJ3g8lVAJMlc4RDsZHMV8+TdwZAngBQVE/hgx
X-Google-Smtp-Source: AGHT+IEsmQDT4m0CAuKaB5hYk0x3XShvKx9ijF531yKJ/VVsZDnJa83rjMVIzLPu8PZFboVng+7mKA==
X-Received: by 2002:a05:6808:1646:b0:406:6c33:805e with SMTP id
 5614622812f47-4150f9a5b8emr9254366b6e.27.1752510594474; 
 Mon, 14 Jul 2025 09:29:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613d9d820e8sm1180016eaf.10.2025.07.14.09.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:29:53 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:29:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] block: Remove unreachable code
Message-ID: <20250714162951.GI13084@bill-the-cat>
References: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rDRtpJMSRGWOuv+z"
Content-Disposition: inline
In-Reply-To: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
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


--rDRtpJMSRGWOuv+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 04:38:53PM +0100, Andrew Goodbody wrote:
> The two functions blk_find_first and blk_find_next use a for loop with
> the content being a 'return 0' which means that the 'increment' code is
> unreachable so remove it and also remove the variable ret which is
> assigned to but its value is never used.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/block/blk-uclass.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index f3ac8db9464..b38c21ffbe2 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, enum=
 blk_flag_t req_flags)
> =20
>  int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
>  {
> -	int ret;
> -
> -	for (ret =3D uclass_find_first_device(UCLASS_BLK, devp);
> -	     *devp && !blk_flags_check(*devp, flags);
> -	     ret =3D uclass_find_next_device(devp))
> +	for (uclass_find_first_device(UCLASS_BLK, devp);
> +	     *devp && !blk_flags_check(*devp, flags);)
>  		return 0;
> =20
>  	return -ENODEV;
> @@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct ude=
vice **devp)
> =20
>  int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
>  {
> -	int ret;
> -
> -	for (ret =3D uclass_find_next_device(devp);
> -	     *devp && !blk_flags_check(*devp, flags);
> -	     ret =3D uclass_find_next_device(devp))
> +	for (uclass_find_next_device(devp);
> +	     *devp && !blk_flags_check(*devp, flags);)
>  		return 0;
> =20
>  	return -ENODEV;

Should we clean up uclass_find_next_device(...) to not return int? The
function comments don't quite make sense (include/dm/uclass-internal.h)
and it always returns 0.

--=20
Tom

--rDRtpJMSRGWOuv+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1MHsACgkQFHw5/5Y0
tyzdMQwAgJvz8/0+8ftMx1M2gz4rIMUE/sdRPlEdpm2Wi6tgAV/gYlNWUf8S0Jk7
KHQMBAx9w0h6Wx77Q9fdc+BoJUBm9gBuZ89Nnlzt97sx+ZbuSdFYLkNt6Nlnd+dm
KSPawFzsm3FACrB7BbwoLnIhCp+Q8QAvgJ9X1oDMhbOCymqh2UvN9ST28VUgc5zb
Wy7oKguHBNkcZ37+yW1QihdhiiP/etOJeOp67ZYULqquOWb/bBL8P68wAzaI0YpS
fR+S9rAqu5XDiXKGW2CHaB9Ql6oDPBtlDTuER8p6odA9cxw/CK36pLwOKGuQBJtS
B5aN+WmnalHpkiuIjxES5ffwg9V+5S9R5zW5IiSwVdxOWj1fNHPnYSYVupQiX5+5
78vcGAwscPcAfXYe6kKIwEvBjpkXcrOe2bxw1cSeL1SrfbxSC0aRZBHoL4g5+5oI
x+4qXbz2oEGx00nqFxp3LktgEfqqpA5m9P+JgTLK9OYH2NWyWsqZSQ99I5h+xXcw
5BWtCQwM
=UuAX
-----END PGP SIGNATURE-----

--rDRtpJMSRGWOuv+z--
