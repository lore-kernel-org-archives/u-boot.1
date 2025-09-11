Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E36CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BD8833C0;
	Thu, 11 Sep 2025 19:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G6jmM7ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20669833D1; Thu, 11 Sep 2025 19:34:11 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E6C833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-31d6aa3e73fso690103fac.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757612048; x=1758216848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X1NI+HEtppX9pNh3pZas9h6mrzzkzLGg0p0RunRi3bc=;
 b=G6jmM7ssebuBT4DnMn9NPyCY0onLdrLXDsGsLwqbZNp3WKPay08f5aNKYtGtZ4pYqD
 /xkBVal1WG00flrSBPEr5LQ5u2iqnWFQ0HK2jxLR+NgyN/ldlN2lhYKZnozD9nzCuTpO
 zt9T7ePUC4+D5M/aH1pKJw16amUbsznsTVQiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757612048; x=1758216848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1NI+HEtppX9pNh3pZas9h6mrzzkzLGg0p0RunRi3bc=;
 b=qTmWeWWsd8xiY2ha2HE56PSjR4XaKXifPQMvS2OwcjAzK7cQ/vf7TL5I9kW9etAVKR
 NGZyRCCD60W55H5Ok+n62iMO9WeAgX+U4ChIYQ8blwoTkFlvphOVCibye7vAFUL/ypjS
 DCRPhsGBzVO/Wzsq0t+PsaTatx4JV0rInNMzQB6yo2VmLma9lOX7KR3bMcCvzpwY8JnY
 KxkVnxKB4whEuDum/SR0PqjvWwcuoULjFGXibnoND4KhJ66C+Y1l4rCS48B6Zp6PiPQK
 AjgwORPyzicLwkq+UNee76BfYjQ6XNSvt5x45TAvis2O+Y4EVFk3x2uRz/sRfbfnJIno
 gkwg==
X-Gm-Message-State: AOJu0YyeTqfQ4S+M6eX6CK+4P/I4U7JV9mLSWbg3DIhxMRVAzR6kibza
 AjkLW4bOTkQjfF0xczho9vH2Q0z0++lxMppsq2N9oGrYDDPsbwr0nudc1PGLO3lPPxs=
X-Gm-Gg: ASbGncs1F+ANTuQkT8FDkIgJPwg5ne6VOOWwCtT+HpNEk1db81XYuVxSVsUOyLUofwV
 /szEHWD2IaUNnd+5zKObiPZ4hjpUmEwCJYgMAwfQrL1RcpZU4bVTjyALFutSuiRpezOpSHLO2nk
 2jLaWk6tBOxwCkUM3Er5l7FVfa8WkovngCFxPQnrJYwqUn54tvcWHVcsQ/LW/PqjY8kc8cwxMGv
 +OE5xVHn2DAEbXWqjPWTQnYN2ggQB6cZQUfsOiKENcDOhcIW3CLf0hyOnIC6yvLCRiX2iaw1RC3
 BZNSmfDUdqxUjpzWI6jibR3eUUwBmn3aYIpMl2VcKFot7gK9j2tHy7st8jYOhY3u49aElXB67ul
 Mh9xRUtPWYPMlgctkpcp8LcY6/pNMyMRXZltxmSKciIjw0Kf+y/CQpy4fkveb+tDzXI8=
X-Google-Smtp-Source: AGHT+IGmsobMXy1a8A9PeV6zTKPGSxqKZR5mqGWyOQc9MVqmAbs87IBhfgOIHRRKDnq8yc2nBtXqig==
X-Received: by 2002:a05:6870:f606:b0:31d:7467:e381 with SMTP id
 586e51a60fabf-32e4ce950acmr106362fac.17.1757612046890; 
 Thu, 11 Sep 2025 10:34:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d35edf450sm549054fac.32.2025.09.11.10.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:34:06 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:34:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 17/17] arm: spl: use fdt addr if arg is unset in
 falcon mode
Message-ID: <20250911173403.GA124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-18-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5UPwEEThE4uuIwnY"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-18-anshuld@ti.com>
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


--5UPwEEThE4uuIwnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:13PM +0530, Anshul Dalal wrote:

> spl_image->arg is passed to the kernel as an argument in the x0
> register. However in cases when the kernel is loaded from a FIT
> container along with a DT, the arg remains unset which leads to boot
> failure.
>=20
> Therefore, this patch sets the arg to fdt address if it's null.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/lib/spl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
> index c43a63f1819..2e7613a6f2e 100644
> --- a/arch/arm/lib/spl.c
> +++ b/arch/arm/lib/spl.c
> @@ -53,6 +53,8 @@ void __weak board_init_f(ulong dummy)
>  #ifdef CONFIG_ARM64
>  void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
>  {
> +	if (!spl_image->arg)
> +		spl_image->arg =3D spl_image_fdt_addr(spl_image);
>  	debug("Entering kernel arg pointer: 0x%p\n", spl_image->arg);
>  	cleanup_before_linux();
>  	armv8_switch_to_el2((u64)spl_image->arg, 0, 0, 0,

This sounds like a standalone bugfix, that also needs to be more fully
explained to make sure we're consistent about what we're doing. It might
also be the case (I'm not sure without digging more!) that the caller in
this case is in the wrong for having not set spl_image->arg already.

--=20
Tom

--5UPwEEThE4uuIwnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMICwAKCRAr4qD1Cr/k
CuuEAP44rxNpof+q2coZs03hXcP83odVW0QB2wbUm9kyyHjKEAD/ZnFy5E7jOIKt
stR/06IDjaoJrz9zozwwGbBGceqxGQQ=
=9w5X
-----END PGP SIGNATURE-----

--5UPwEEThE4uuIwnY--
