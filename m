Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E5D2A539
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 17:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD70888D97;
	Wed, 16 Oct 2024 19:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lHANnwmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 486AB8899C; Wed, 16 Oct 2024 19:45:08 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E0E8899C
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 19:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4608f054f83so891931cf.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729100705; x=1729705505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8DRgIVhD46RFwv5PVTX27D7qQjHcXibgaQUOhcUw7uw=;
 b=lHANnwmYQsiqvRiLZLMuHO5YRwdTY9nyFEsdPUbWttT7Req/9V7Fd3FHEC0dh88OME
 8frOzqCVRH7PLny4Dy5RjiSmSNbrTGi/0kKOWaM32FvrWaaT0+tk0XaDV2bYyMN+agbE
 hJHAGaGI7LF6I6W0k7X3qoLjBhnh+9todJb7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729100705; x=1729705505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DRgIVhD46RFwv5PVTX27D7qQjHcXibgaQUOhcUw7uw=;
 b=OYLS3rxzYo4vCFvh80enDXsXEtaSXiuN5UnG49j0qbs5CWNFWpEERL4BxTMGrvcsgU
 iMX/zxtCnWqiu2jCVXP9Ca5SYWCPz4H+oa2QSY4fiKhMVjbXGpUfb1sPVtuY4wNGVANK
 z/01uOW/lgXmTt21SCAtxbXueevEjpuXiSx5vOh5uIWAdWszDXQ4ft8neghkOgDvUvW+
 J24AsvCLQxlAs66GUHLbl/1jSfIX/OYajwDE8/RJZyClgDTrbhFeOtqtV+FuB1c6N3SL
 xJkB8AxOIOZTGlCMgbsHkhK42q8ejDr3vLpMfibr2Toxw/ckvWs735MykUh9JCNn889X
 k0kQ==
X-Gm-Message-State: AOJu0YyHpBJsyPesvi5fH1i6c9ut4Ww5FeO8TETgvAfrqR18dHNH6sqi
 jKnQhTyXFnvJ7DN9x5XK10umBD+ZF8gCjORhgaIyE8g5nKdpLqg3yfoOf/CdTt4=
X-Google-Smtp-Source: AGHT+IHJUOrEZOmTIQRJkCw8VkYoIToDMYjDDK7oCoUBNiIFo1PlV+8DcsxIwl6VM9DjfFPTt99AIg==
X-Received: by 2002:a05:622a:1f91:b0:460:3a7e:a8be with SMTP id
 d75a77b69052e-4605846c4acmr293659531cf.26.1729100704687; 
 Wed, 16 Oct 2024 10:45:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b0e2cadsm19452341cf.21.2024.10.16.10.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 10:45:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:44:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: provide noncached_set_region prototype to fix
 build
Message-ID: <20241016174459.GA4959@bill-the-cat>
References: <20241016112455.35700-1-jelonek.jonas@gmail.com>
 <20241016112455.35700-2-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="efsWWrWlMuzHe4+D"
Content-Disposition: inline
In-Reply-To: <20241016112455.35700-2-jelonek.jonas@gmail.com>
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


--efsWWrWlMuzHe4+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 01:24:55PM +0200, Jonas Jelonek wrote:

> Due to the removal of weak functions in 7d6cee2cd0 ("cmd: cache: Remove
> weak function"), uboot fails to compile after updating to v2024.10 for

Should be "U-Boot" but I can fix that on applying.

> mediatek target in OpenWrt with GCC-14 with error:
> cmd/cache.c: In function 'do_dcache':
> cmd/cache.c:57:25: error: implicit declaration of function
> 	'noncached_set_region' [-Wimplicit-function-declaration]
>=20
> Thus, provide a prototype in arm's include/asm/system.h to fix a build
> error in cmd/cache.c, since related prototypes are also located there.
> Also add an include of asm/system.h in cmd/cache.c to have the function
> available there.
>=20
> The issue occured after the update of uboot-mediatek in OpenWrt to
> v2024.10, in combination with GCC-14 toolchain. It was reported and
> discussed in https://github.com/openwrt/openwrt/issues/16697, and
> temporarily fixed with
> https://github.com/openwrt/openwrt/commit/92ca322dd1f48158b8829fec59319a1=
2e4ae4295.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>

Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>
Link: https://github.com/openwrt/openwrt/issues/16697
Link: https://github.com/openwrt/openwrt/commit/92ca322dd1f48158b8829fec593=
19a12e4ae4295
Fixes: 7d6cee2cd0 ("cmd: cache: Remove weak function")

--=20
Tom

--efsWWrWlMuzHe4+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcP+5MACgkQFHw5/5Y0
tywF0wv+JEn/E0vqDOYuxH6QvTwXWyHtHhsZ698ElqltDCtNZtzUm3lLg0V1IC20
pXrZl7h7kmOm/oGpYfOx+A7Gvid+nN8Zx1KJ8M9G2FTLSC5RjjqCnJBVhSxjOySc
zdJvbyrcoOLYfoTGtvoJzd8WnlPDWYNNDBkmLgF8/znX757mq3Xaj8Anz4Oa2VUw
v9xJRlk7sb9jJMkCLHV9TLdAAP0vytIyADaf4xBxljpJejzc1U1b4pqWZYuBTj/N
7N0J+A0qkUIWrnwCzriISj7FZzUTDq5eLmlDrUzI+xRQPrNfU3AdWHTcjJKY46f6
DAWYvfkbmz0YiNfi8RyfAF8/IN5zVZIQubN0X8q3pMVGW/8ZdYXByWXJkHMftTHO
cPWZ91EV0tFeZkh69SPICsfdLdjlEsHxNDzIf5JSl81yw17yMDK4s3kHF5W31VbY
a2kHsWF4SK8AvkU6ZtEhct0azqeYDQUMm5c1SefNuMHAsJnB6M4MkuTt0znbExry
ECIGYs3/
=2Xdq
-----END PGP SIGNATURE-----

--efsWWrWlMuzHe4+D--
