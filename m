Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB6FC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 17:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55EAF801BE;
	Wed,  4 Jun 2025 19:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EPlyfx5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC258006D; Wed,  4 Jun 2025 19:57:48 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9F48006D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 19:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-408d7e2b040so110327b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749059864; x=1749664664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VlFpcr87Qil3V9MqydMz+kuPvo98xfCO7s5HjUEOjz0=;
 b=EPlyfx5SY5cklQql0QpGgYxxOqqmkPqLvcYLoT47QALY4is/7dz76lvQtFYLi/oh/+
 MAD9CYQdDxirD9ZByY5KIsLdktQEUetUFgk1H4VQHTL97IDrOqGnTjDidh6fOqGgs8g3
 FITqcDwCctD+yb9w+VEPXpYaumZ9KU3mpd80E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749059864; x=1749664664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlFpcr87Qil3V9MqydMz+kuPvo98xfCO7s5HjUEOjz0=;
 b=GFpBOVaXFj+y3ASQnquhROZ8KSf1GU5RkJ0iGJVUpFUCkjcO6HTjHpL/gF39WCtX5z
 ErPQjcoAHGoXLgCZYtaJIVOrcx7efJXc/Cf4gOq0GJ8XEHMZvYcqoJ5Gr0ZcfESvkKg6
 PWN+oBClpQ1Dm+8p9y0jkDe5dka3D1gitJZI0U2edFiFZnrGVyWO0PAbRQe+8YAvmImX
 RSzM0MKOlLkUfUiQrDWi2vwz1FW8JkJoXSXLq8QLQ++zj2j8jEyHPwXxWOgF1yUlz2sq
 h3YjjuquC4Qv/DjbYK95Xl5bT909Ymapm0+IPNqi7Oemc0x+CMjNmAy4nWyllRLEvxya
 txKw==
X-Gm-Message-State: AOJu0YynumEqP48CqJvnEHPAdwrOlIhu73qjQuWtXKV88BwE9dTArAAb
 qLQWBKCIz+XMEDwS12rST2G1pUdZyU9nhl4x7itRnP7qmcoS/Daa0/gmMDXJJUMmpCs=
X-Gm-Gg: ASbGncsCNFpkbFsb1EZtAHzs39LynoIoivyRH9VEbNUOFAYvxMvHemqSAEeE8/IkwwF
 MH5agmmmUuYQgznQVtqKQgMykUvQeDQCNK8hfj8lPdt+Vhv5IGcROVm72gb50ULJ8NnHIUsxkLP
 O7Yw7lsGW+YTwLUdzr+zCCUEaUATU2vXQcsMqRTksLOLe54KZlg8GVENCl55abeB3EDicviGIrH
 AxaU52WYF/+P0P2usJhz2HEQPLkoAaSHPvkY17HAO3h2cn3b1JU67Wd519Xu0w+ICEZU+nvljuI
 rRQfMilmgwr++b0GZ9d/vnPM6hA2lZ0NK1g7LF+zrSqd+8N9fQtbLqlrhPOCafeByHoST27H0BG
 8NIMlZdj4wvoA
X-Google-Smtp-Source: AGHT+IFvUMoYDWKF7oWfaDcrCxoetclG/VXilaxVjPeRGKUh5s44vijW3pttbE0i/m7SUQvJnZFIHQ==
X-Received: by 2002:a05:6808:4493:b0:403:31f8:44c6 with SMTP id
 5614622812f47-408f0f915e6mr3287163b6e.26.1749059864394; 
 Wed, 04 Jun 2025 10:57:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678d038c0sm2273230b6e.46.2025.06.04.10.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:57:43 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:57:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] ti: k3: abstract common fdt api for reserved mem fixups
Message-ID: <20250604175741.GA1940110@bill-the-cat>
References: <20250522150941.563959-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="psW0rYvKJJoYEc7W"
Content-Disposition: inline
In-Reply-To: <20250522150941.563959-1-anshuld@ti.com>
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


--psW0rYvKJJoYEc7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 08:39:40PM +0530, Anshul Dalal wrote:

> The usage of fdt_fixup_reserved is repeated for ATF and OP-TEE for
> multiple platforms, this patch creates a single fdt API for fixing up
> the reserved-memory node with added error handling.
>=20
> All k3 platforms already share a common tispl template which ensures
> binaries are loaded as per the respective CONFIG_*_LOAD_ADDR. And the
> provided new_size for the fixup is overridden by the size from fdt node
> anyways. This allows for safe abstraction of the reserved memory fixups
> for all current platforms.
>=20
> fdt_fixup_reserved now abstracts the ATF and OP-TEE fixups by calling
> the renamed static fdt_fixup_reserved_memory function with the required
> parameters.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
[snip]

I think this shows the start of fixing up some problems, but that we
need to do more.

> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62=
ax/am62a7_fdt.c
> index 7f764ab36b5..9a4599432ff 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> @@ -10,8 +10,5 @@
> =20
>  int ft_system_setup(void *blob, struct bd_info *bd)
>  {
> -	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
> -	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
> -
> -	return 0;
> +	return fdt_fixup_reserved(blob);
>  }

This is good.

> diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62=
px/am62p5_fdt.c
> index 2c40fa5a594..9f4b1663864 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
> @@ -92,8 +92,5 @@ int ft_system_setup(void *blob, struct bd_info *bd)
>  	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
>  	fdt_fixup_thermal_zone_nodes_am62p(blob, k3_get_max_temp());
>  	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());

Is it really OK for any of the above fixups to fail to happen and be
silently ignored? fdt_fixup_thermal_zone_nodes_am62p() for example looks
like it throws away error conditions from functions it calls. And other
boards are doing similar things.

[sniip]
> +int fdt_fixup_reserved(void *blob)
> +{
> +	int ret;
> +
> +	ret =3D fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
> +					0x80000);
> +	if (ret)
> +		return ret;

Good.

> +	ret =3D fdt_fixup_reserved_memory(blob, "optee",
> +					CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

But we can just return fdt_fixup_reserved_memory(...) here.

--=20
Tom

--psW0rYvKJJoYEc7W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAiRIACgkQFHw5/5Y0
tyydqwwAo4RmvSBNtfaS0ESnUnPFYyUGEqtYvXx2TR+arTmv3aFkkg22C6bX/fEe
qFciFCLacVqupfRvOSQi6OywC4RF7TbWspLRSkXdBW3ycOzYCWz06xpmFQizpdwt
3GZ9lvgMPXHnwwrICYOCUahMVJmeidzMgMxDGMmzscRsf66ab35QPOqN8HOeAo7X
vixxbKuQ+DG1FUpRNPQ+DuqpUSLUr4vw6AShpYbxQMvrSFdk/M4vp8cBLG+B7z26
qE1gg9w/ffUqcfQkHM9vwW+kMZ50/fTzcyL+6/LhQcpKBPA77RHSozDjYqjd294d
8VvqybMWDI0zWEsSAnqNH2aQQcHK7Ta9rKvYJWtHGfTKj3exr7X/okWAeI8bdGT0
5rAQzGzBVS2fmD3dZf+y60v4KeZFia62imyw5ZbOLbrso+dOFcmR3dk3LvVvNRZd
S3dMuStnghfU8vIWIqmil/0jQj4na8r1LWeV2QC0yrmk0yy6ZBunkEFYos/0Ku1s
Ef4AbEIx
=3ldM
-----END PGP SIGNATURE-----

--psW0rYvKJJoYEc7W--
