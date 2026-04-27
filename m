Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EDDFF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3549083693;
	Mon, 27 Apr 2026 21:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rITeouxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA1583C14; Mon, 27 Apr 2026 21:55:33 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321CC805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-4645dde00a7so8177097b6e.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777319730; x=1777924530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QKZaosFsbDOZMc8NS46/Rh0fN8x0myX/mVSQPp8z05k=;
 b=rITeouxhC/EhHsKsZu50VZHpYMNqkkHo6kXCYvNx3mhai1fXCxMkuSYVqjuGiHe43h
 M+sxq5GhU9qmk++K71qe685+SDZ4YXohH66zfXQtHTKo63BXYsztUxAaFett8/Jt40Qk
 iCM03jZlFn5M+FoO/PKYHXHvij92BX91X3v20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777319730; x=1777924530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKZaosFsbDOZMc8NS46/Rh0fN8x0myX/mVSQPp8z05k=;
 b=cTmdmb+/OiqmRrxGzPHruiCbJti76DmuWatWrk5V6yjEIKJvVaw3hMh7Ei1iFPx47G
 e9U5UiYqA4QD4SCGC6D20NC8ij4sxjA+DtLGlAlUo3ZqGomakLQZVdWDT4BzyH7sz2fT
 kwBuqrFb3FEPM+7eLFdk+sGuZOA4eTVsuzAwepbPL4IqDqWzo8cVNcgrv4ZJkXjtjQQy
 C6ViU+uiArATdkVqZ14w0uqykBojQUHDhHkk5DCUPsQDFG6bMwxhMf8lgWOKNNi4DmUs
 9lJBzZJWMgbvgnhzZB5idGcBIUI0MB69iwyb7GqVx2h7AQIs2PDbb4geEx94ZCsbR0vx
 xzbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ShfW7Mk9XZlbAnEzMO1ZwuaJXzgpIrMyInmUB85LVTEfbQQAIDbLLc8mr72q4ZsWo3Br0o5k=@lists.denx.de
X-Gm-Message-State: AOJu0YwwRiYmDiw8apKnpWLnvVoHJB7W/H0S47NIgP1DAQFaxezRh8MF
 to3S6RuLIoOFiqikZPsXv4Edb79xYO3ihJg25PKmBRRyWejjeigAs8rc9KHg8mi5aG0=
X-Gm-Gg: AeBDies616ywWD/7xFMKuG2f1Lm8de8r9lkPklcwvBanQAWkTIJ5iIWmqel5dnZ9i7s
 vkxW7/t8r7pEeYwSjhuLrtUB5YQIdrUyGDYMAQf8gXfRBkoXl74DTRFfN4R6v5G28BMw6ahFlcW
 g9omsC/nUdyJXKKmGYTEE9COsQkVLiDvLSHLP0cvWWyQePV5/TNzzQn/lEN8vBx023mT/wuJJsy
 VZ/K6Xkyp5Kn9994UfK9QwvD6eCToOfn/HHBytO+P70Qv+TQlDMr8vfRXQMSw2KaKXziVFHTTRK
 9M8xzfaT6+lg8kbW1I23Gx/HkCdI7qxFpqUDW78p6ilZWEFeSxitdPaILQt6obrGXsFVj2PaIZn
 IO9scQSKjD+aoFnhatdlDuLN6FRGRI/H3Y5sqnfCYV5YZqCvWm/Mxpe+L1/tUBsVCQZGaRh7fVV
 qnUOHwABW8nLra54088Vaf1BaPE0tTtF8xGlCnRhs5un1Cc1zuXXlIsJ8gO2ZygVZrBnBBg71bL
 9LoKwBFVPMIXcZme3gRFfIKoxFjlWOn+WS7n5TGn4MK87NlVZFVtYQwmkG/Ww==
X-Received: by 2002:a05:6808:181c:b0:450:b249:71bb with SMTP id
 5614622812f47-47c28e4e7fdmr91000b6e.19.1777319729824; 
 Mon, 27 Apr 2026 12:55:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de9866c62fsm273552a34.13.2026.04.27.12.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:55:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:55:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>, Simon Glass <sjg@chromium.org>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 02/11] arm: mach-k3: Use FIT image data addr as
 fallback if 'load' prop is missing
Message-ID: <20260427195527.GM41863@bill-the-cat>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-3-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CBmuJaJeRzdwDwX5"
Content-Disposition: inline
In-Reply-To: <20260425033742.1519298-3-b-padhi@ti.com>
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


--CBmuJaJeRzdwDwX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 09:07:33AM +0530, Beleswar Padhi wrote:

> It is possible for FIT Images to skip mentioning the pre-defined 'load'
> address property. In those cases, SPL uses the actual address of the FIT
> Image data as the fallback load address. Use this FIT data address for
> referencing the image when the 'load' property is missing.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v4: Changelog:
> 1. None
>=20
> Link to v3:
> https://lore.kernel.org/all/20251231173621.1069988-3-b-padhi@ti.com/
>=20
> v3: Changelog:
> 1. None
>=20
> Link to v2:
> https://lore.kernel.org/all/20250506104202.16741-6-b-padhi@ti.com/
>=20
> v2: Changelog:
> 1. New patch. Fetch FDT Data addr for accessing image if 'load' prop is
> not present in node.
>=20
>  arch/arm/mach-k3/r5/common.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 484d96f9536..50c4231655e 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -328,12 +328,15 @@ void board_fit_image_post_process(const void *fit, =
int node, void **p_image,
>  				  size_t *p_size)
>  {
>  	int len;
> -	int i;
> +	int i, ret;
>  	const char *os;
> -	u32 addr;
> +	u32 addr, load_addr;
> +	const void *fit_image_loadaddr;
> +	size_t fit_image_size;
> =20
>  	os =3D fdt_getprop(fit, node, "os", &len);
>  	addr =3D fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
> +	load_addr =3D fdt_getprop_u32_default_node(fit, node, 0, "load", -1);
> =20
>  	debug("%s: processing image: addr=3D%x, size=3D%d, os=3D%s\n", __func__,
>  	      addr, *p_size, os);
> @@ -342,6 +345,22 @@ void board_fit_image_post_process(const void *fit, i=
nt node, void **p_image,
>  		if (!strcmp(os, image_os_match[i])) {
>  			fit_image_info[i].image_start =3D addr;
>  			fit_image_info[i].image_len =3D *p_size;
> +			/*
> +			 * If the 'load' property is missing in the FIT image,
> +			 * fall back to using the actual in-memory address of
> +			 * the FIT image data.
> +			 */
> +			if (load_addr =3D=3D -1) {
> +				ret =3D fit_image_get_data(fit, node,
> +							 &fit_image_loadaddr,
> +							 &fit_image_size);
> +				if (ret < 0)
> +					panic("Error accessing node os =3D %s in FIT (%d)\n",
> +					      os, ret);
> +				fit_image_info[i].load =3D (ulong)fit_image_loadaddr;
> +			} else {
> +				fit_image_info[i].load =3D load_addr;
> +			}
>  			debug("%s: matched image for ID %d\n", __func__, i);
>  			break;
>  		}

Does the spec allow this, or is this based on the previous patch?
Thanks.

--=20
Tom

--CBmuJaJeRzdwDwX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae+/LgAKCRAr4qD1Cr/k
CtSSAQCZgDilf5Kw8/7AH8OIbMQGEFw0cIylhQzlAKlTyw5GigD/X/fJW0JPBo/l
NgU2d8B9r/6hF/5HibiIZgGs48SXhgw=
=m48w
-----END PGP SIGNATURE-----

--CBmuJaJeRzdwDwX5--
