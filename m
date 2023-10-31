Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D2BC4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4454B87AAE;
	Tue, 31 Oct 2023 14:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="njqOZZyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6204787ACE; Tue, 31 Oct 2023 14:55:21 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1948748F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ce353df504so3608009a34.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698760517; x=1699365317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fnzZeLc5sLPNoCpk9oYmGDQBGQ9zDncOvWQRvu1hwjY=;
 b=njqOZZyBOfh6iGLp5j0M1MIgcjkv9I3jc5bYuOR7jzRPXrRxulKQpVit5GneYJ+Ink
 DR4LbSsvGVs714LqxPyd5MD5oYJWyniRC8wMx6121Az5X2SWNPj2Ks+vSUdgTMhHQhWq
 NsH0UG+tCoYQDQDlYONb6zpxq78jUFNqBbGbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760517; x=1699365317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnzZeLc5sLPNoCpk9oYmGDQBGQ9zDncOvWQRvu1hwjY=;
 b=h0comDqf2c26NsYzYR2U7iL3DDvMKUBDpV93X5P1qMalDgxFGccRmlmEl2ScZiK8Ny
 3kxXtWjKQoA+0VhBzWvy2SR0CH1a0Gh35L0MN4TZyHNdh52NABtKcB3XZELfmR+TlzI7
 rNFlVDsvvYwS+tJ68Ui8qTcduo7iEygQVsEj+ZAHDHL4jzbvxru4bfsFUKExS1lq/hSJ
 5RzLt3mqaRx8epicmpFLfEX79k1fH9b+2YDzvSTORMxpG/cLYatgCo/xOS9L7VF+Arn/
 Ytx1OP/U4Xbc0mNSSk7QpE2pA1R6xVhPUN23RZGmyPi+n1Delk3Lwgh1cWjxRAM7dQik
 JmeA==
X-Gm-Message-State: AOJu0YxYTacOQoecTtzNvfpZqkyOkx8RU5LOi5mCAZBwvqRat9dnpUeM
 U5XrO4O/yPqfSWenJHbzX4TWZQ==
X-Google-Smtp-Source: AGHT+IGpaTygO9sfsFjQwYRBpuUuww+hddrYs1HWdYR2sIR3zjqFr00uIyb+4Kdhkmmjk6HUD7u/Eg==
X-Received: by 2002:a05:6808:155:b0:3ae:55e5:43b6 with SMTP id
 h21-20020a056808015500b003ae55e543b6mr12941352oie.48.1698760517501; 
 Tue, 31 Oct 2023 06:55:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c5-20020a05620a134500b0076f1d8b1c2dsm524923qkl.12.2023.10.31.06.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:55:17 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:55:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Nitin Yadav <n-yadav@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/6] board: ti: am62x: Avoid overwriting reserve mem for
 AM62 SIP
Message-ID: <20231031135515.GK496310@bill-the-cat>
References: <20231031132809.1524341-1-n-yadav@ti.com>
 <20231031132809.1524341-4-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p4HQkpgCyms1DmLE"
Content-Disposition: inline
In-Reply-To: <20231031132809.1524341-4-n-yadav@ti.com>
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


--p4HQkpgCyms1DmLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 06:58:06PM +0530, Nitin Yadav wrote:
> AM62 SIP has 512MB RAM. But the top of the RAM is reserved for
> TF-A and OPTEE. U-Boot relocating there would cause overwriting
> of these reserved regions. Fix this by limit U-Boot to first
> 64MB of RAM for all boards with 512MB.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  board/ti/am62x/evm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index ad93908840..ad3e415592 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -18,6 +18,7 @@
>  #include <asm/io.h>
>  #include <asm/arch/hardware.h>
>  #include <dm/uclass.h>
> +#include <linux/sizes.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -59,6 +60,16 @@ int dram_init_banksize(void)
>  	return fdtdec_setup_memory_banksize();
>  }
> =20
> +phys_size_t get_effective_memsize(void)
> +{
> +	/*
> +	* Just below 512MB are TF-A and OPTEE reserve regions, thus
> +	* SPL/U-Boot RAM has to start below that. Leave 64MB space for
> +	* all reserved memories.
> +	*/
> +	return gd->ram_size =3D=3D SZ_512M ? SZ_512M - SZ_64M : gd->ram_size;
> +}

Where are TF-A and OPTEE in other cases? Are we not able to read the
reserved memory nodes and handle this through that?

--=20
Tom

--p4HQkpgCyms1DmLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBB0AACgkQFHw5/5Y0
tyyD2Qv/ffITg8JPCniuhwD2kqPEWeHXwnTjDzv/S0M34XuREyZH0DGcWAS/crAd
QWho/IEzit5+K96E+uLd3r0l6sIK9M+SBlMBq9evOhZVwgYD5cil6dXJ30Vk6hT8
KJ+V0MxOYqQ/QRHP/TfV2oPQwweTzC93QXUR5Jrw8fZeZRyFXgFJ+lpKfC9sZOli
MEhb/RcmAvCTmDjWnA9Oo1w9/gIxr14sKkHDpowLcYivlVX4RbJc4hWvH+ldyb3r
XoxBZObaumsghl1orsvY6NBAZkGjFMg2PXwbK/GyQjCI+7hpHdultqXHmOU8sZ6S
LikqNmBBl37iN3qFHlIcltq60ObId578y9y1gtRAFNuscOT+ylCSSbB2BtOLkmgm
Y2NV3A7YRqeKbJdKtWGN3rrupIBdSF4ciK2KIcPbF8pr23k0j6DVmznFpDr9fU5s
6bpobi9rN+B7/MVJyKUhfohE1el0EdLuRjAHbeEq5WoKCLTaVHGArJgja7aOD4NC
EHZsgIh5
=CiZS
-----END PGP SIGNATURE-----

--p4HQkpgCyms1DmLE--
