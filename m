Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33CCC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 14:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD3A80F9C;
	Thu, 13 Mar 2025 15:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qgnxrf7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA78580FF7; Thu, 13 Mar 2025 15:51:59 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5157B80540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-476775df2f0so20850971cf.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741877515; x=1742482315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HY7Rmur+GyI90XqhiiF66E1b2K/FSWhwZFQGnH9EaxI=;
 b=qgnxrf7P36fIrYyRvDJ0LD8uiwhufWnPukuSTHcFCAca6AtZiQqEhGPDDBwluzDnae
 e0kak6VAlNE51qYf8X8OPpXHAye98ADVIhYya3eWwKMpiIxuwKahs84xTMjTzKMVrvnM
 0YZWDF6VZ08Ddh563ZZ5TwnMenIfMLm6rTPLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741877515; x=1742482315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY7Rmur+GyI90XqhiiF66E1b2K/FSWhwZFQGnH9EaxI=;
 b=i6mxG25RpC9227InHiDzbkgDpdTT5tK7tG3q0AZb65twQPJtPCT2WYNT17fGp5jajH
 oKo65bqgeUmOi9os5LWiuA3Ca4cc4BWgXuSMGRroPukvsjzDQxIfsZbIAQPb4TkYjcjo
 Q91X3zON0FkZcUoFbj4dZqYF5CGWyQ+6OsCMnlNdFH+pQK8LsdtV3Adc4pEUkBVDUeTN
 ivMoYkckokoIFFOayxwJIehrmpgScoLKODaZXeJylC40q4K6rKC0VANCQ4Rd+qHmYNAs
 vBASwyZ71TIli/Fd1j64BQEQsJgyNAncIifllybINdt2oFEx088Tt+hviQQvkQsBXUD6
 uYIQ==
X-Gm-Message-State: AOJu0Yws29wrIIZ6NhDZaEy/hYEGRL0MPx3xh25ZwEIfEQYo6CJpMQ7g
 lqSIJK1t7kUFNm4FWwfZ9sLIWJbQqlrQ7L38DnC6NkQ/d3pHtByg363YDqCPYSU=
X-Gm-Gg: ASbGnctxQOxkzzf3tg/c1pgJWR/WeI5T7HSB2G//Us4adpe/B59rlei3tu75w6ej4GI
 527wJ4cLYvVr7UdCw4Hng+9plzCtMkJDJibjDcfrbzELslRZqB6TyeCX+tlanwMb4RXXh0WGqJA
 UZdmbbEvJq2G3MOSvtzoaR7plMWq86rhc8+o3PY3TAWvbuu4JYvGmoCEfY0MyETo0v5jlH2suvl
 OMX5gXfRPTjJzCg1tjSpkW5TLipRxBqwIuXj+0t/217ucx8z3wSiE4QhQp2zS+JCYM5CBPpSuSE
 A+vwMlmVRXrkfwo0Iu2vPkjGKGmPzKeTYFkbYBVMJZtO3w==
X-Google-Smtp-Source: AGHT+IG3Q0QUyPpUHf+lhB3rHFf7mSGuVccoF9TYNcQkttvdu48EVKWKg1Ix0v2LjPXm6OVIPxogBA==
X-Received: by 2002:a05:622a:1895:b0:471:825d:aa52 with SMTP id
 d75a77b69052e-476ba94762bmr42625341cf.20.1741877515465; 
 Thu, 13 Mar 2025 07:51:55 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb6735d0sm10155531cf.44.2025.03.13.07.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 07:51:54 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:51:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v4] spl: remove usage of CMD_BOOT[IZ] from image parsing
Message-ID: <20250313145152.GZ2640854@bill-the-cat>
References: <20250313032842.1189977-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6mhzNDd3zurTsaEn"
Content-Disposition: inline
In-Reply-To: <20250313032842.1189977-1-anshuld@ti.com>
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


--6mhzNDd3zurTsaEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 08:58:42AM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> SPL_HAS_BOOT[IZ].
>=20
> An imply clause has been added for CMD_BOOTZ to avoid breaking configs
> that rely on CMD_BOOTZ in falcon boot. There is no such need for
> CMD_BOOTI since it's already enabled by default for the platforms that
> support the image format.
>=20
> More info:
> https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
[snip]
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a04fcaa0e08..9f2ba4d02f8 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -352,6 +352,7 @@ config BOOTM_ELF
> =20
>  config CMD_BOOTZ
>  	bool "bootz"
> +	imply SPL_HAS_BOOTZ
>  	help
>  	  Boot the Linux zImage
> =20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 21a5cefee7a..49eb513f923 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1153,6 +1153,19 @@ config SPL_OS_BOOT
>  	  Enable booting directly to an OS from SPL.
>  	  for more info read doc/README.falcon
> =20
> +config SPL_HAS_BOOTZ
> +	bool "Allow booting a zImage style Linux kernel from SPL"
> +	depends on SPL_OS_BOOT
> +	help
> +	  Boot a linux zimage from memory in falcon boot.

I was going to say this to v3 but you posted v4 already. The solution to
existing platforms is "default y if ARM && !ARM64" here.

--=20
Tom

--6mhzNDd3zurTsaEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfS8PwACgkQFHw5/5Y0
tyxE3gv+KBWT5poZ0c7lcpN/FzgBTF+2lcA8Ctld953KF63yDVCTI9zchtqVDILs
MrbY6RE+/mV2jDS5rE/hGNSBOUj9/UlT4Lv2zvPNqlBinZPmdiD9l5vqEWNFVIq6
MBMPxkMzH0Re6ZArQaBAK/b/GLes0l9Br08Hg/fe5pJAbl1/kfx6FHOe74yWneUJ
HhGrjm/L98cLT60WH4gRBhbst/Kwuif6xXVXQ3oG5MHlc/RMNd0vWLbjbyFrDrYj
FhxDp+qArlKTsP9Py7RtMydX9BKZGsFETHTa+gJPlW5pagoL4Mgtd/TdHm72xpLc
ufkgZ6gWClBuM9rm9jvm8awI0KdsYTpqDXhbmKE3ylt2dlT5vM4Rfi/8vKqArZwM
p5/dfBKLGajSqvPqeh/qiP7CVp3OuwQE8jkImPhR5oSrsyld+Pxh/xLEzXqB40BB
qHQLt9fbltSNt/BfBVo6pbZWuEqUqzBx0qPWA5mOksSaE4y7h2/4qKAK+3L/5NqZ
VZMYfiui
=jpGn
-----END PGP SIGNATURE-----

--6mhzNDd3zurTsaEn--
