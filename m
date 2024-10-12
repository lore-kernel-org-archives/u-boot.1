Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAAFD0EE1C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5255088B6C;
	Sat, 12 Oct 2024 03:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hotNTpWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB73B88C63; Sat, 12 Oct 2024 03:37:19 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F5388B64
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7afcf0625a9so255991785a.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728697037; x=1729301837; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xQCI0EkCrF8C7b1wvRrn33h5pBPm+TJGFSGQAvn/JGM=;
 b=hotNTpWvXRHwm3HrEtu6YweaoZZdwBv6fjx7OwWKjTR5p/G31nJgpGXNVgTHBALpsK
 72vWcozQFQdTDY3pecMCcKm87hjc+GByvDgXOk0tJB+yrHVRIpzbKOmQ49RukNQEyOOc
 kYTqrrli6JVUwt6i8zrtC2eWzzUqP6T52b+bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728697037; x=1729301837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQCI0EkCrF8C7b1wvRrn33h5pBPm+TJGFSGQAvn/JGM=;
 b=eqgwTLmX/Ft519tsdmN7h5ehsWV6hYqXiWm9OrQMnhTEmjo4WToQhQk6F7AHWkF3+u
 XpyKQ+c+yXO+vC1Gs8z2olucd6iuuijDnEP4g8siKsbrgYCmPxrk42m2wavs3YgXBeJg
 U48NplU5Umt+0jEQSzQ4MGJVq1uqXBslqrS0cTOgK0WGkEC2z9ltiMHyrqZYt179cGro
 9sLepsKwAQL5aqajCxYJtyWjbBo2M8Si69Ie2nz0r4d32tIO8kBMZA30f9M+pAOG3U5V
 NhzT+lRuLSyoBIupMBuyyWucQ6VOTQKmSqVx2J5HXNXMH4DST4klgxCCRzJVL+f571Dm
 D87Q==
X-Gm-Message-State: AOJu0Yy+yotnEuapc2/fQjJUSEitwbQ7diiR46g+LgAWii0iLAljD0Md
 +hUBGCNvVQtH57qIPCxfTO5izLdpmg1vGIerz56/3xmpFkktmgLv2W4xS48O1XW295LxyWeZ0WK
 cn69BZw==
X-Google-Smtp-Source: AGHT+IHAeOI0GGV2cZbwhEqOyl4y7gG5Ht41DrTWs6VUUnxmjUD9gcasfxbq524EFp1QgRB/Jz7VZw==
X-Received: by 2002:a05:620a:29d1:b0:7a9:afef:33e6 with SMTP id
 af79cd13be357-7b120fc41c8mr246134685a.34.1728697036679; 
 Fri, 11 Oct 2024 18:37:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11498bbbfsm187319385a.128.2024.10.11.18.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:37:15 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:37:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 3/7] am65x: Use map_to_sysmem() to convert from pointer
Message-ID: <20241012013713.GH14210@bill-the-cat>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LvVzXt1hdP616WUS"
Content-Disposition: inline
In-Reply-To: <20241011214032.760072-4-sjg@chromium.org>
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


--LvVzXt1hdP616WUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 03:40:27PM -0600, Simon Glass wrote:

> The board_init_f() function for am65x is a bit confusing, since it uses
> the variable name 'pool_addr' to hold a pointer. It then casts it to an
> address to pass to mem_alloc_init()
>=20
> Rename the variable and use mapmem to convert to an address.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  arch/arm/mach-k3/am65x/am654_init.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-k3/am65x/am654_init.c b/arch/arm/mach-k3/am65x=
/am654_init.c
> index a4f038029d7..ddcc1355210 100644
> --- a/arch/arm/mach-k3/am65x/am654_init.c
> +++ b/arch/arm/mach-k3/am65x/am654_init.c
> @@ -8,6 +8,7 @@
> =20
>  #include <fdt_support.h>
>  #include <init.h>
> +#include <mapmem.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <spl.h>
> @@ -165,7 +166,7 @@ void board_init_f(ulong dummy)
>  #if defined(CONFIG_K3_LOAD_SYSFW) || defined(CONFIG_K3_AM654_DDRSS)
>  	struct udevice *dev;
>  	size_t pool_size;
> -	void *pool_addr;
> +	void *pool;
>  	int ret;
>  #endif
>  	/*
> @@ -204,14 +205,14 @@ void board_init_f(ulong dummy)
>  	 * malloc pool of which we use all that's left.
>  	 */
>  	pool_size =3D CONFIG_VAL(SYS_MALLOC_F_LEN) - gd->malloc_ptr;
> -	pool_addr =3D malloc(pool_size);
> -	if (!pool_addr)
> +	pool =3D malloc(pool_size);
> +	if (!pool)
>  		panic("ERROR: Can't allocate full malloc pool!\n");
> =20
> -	mem_malloc_init((ulong)pool_addr, (ulong)pool_size);
> +	mem_malloc_init(map_to_sysmem(pool), (ulong)pool_size);
>  	gd->flags |=3D GD_FLG_FULL_MALLOC_INIT;
>  	debug("%s: initialized an early full malloc pool at 0x%08lx of 0x%lx by=
tes\n",
> -	      __func__, (unsigned long)pool_addr, (unsigned long)pool_size);
> +	      __func__, (unsigned long)pool, (unsigned long)pool_size);
>  	/*
>  	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>  	 * regardless of the result of pinctrl. Do this without probing the

I'm confused since I thought patch 2 removed the need for doing
map_to_sysmem() games more widely. You also forgot to CC anyone from TI
that might have comments on if they find "pool" rather than "pool_addr"
more or less confusing and given the recent patch from them about what's
printed out about memory size, I would think their feedback would
be important.

--=20
Tom

--LvVzXt1hdP616WUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJ0skACgkQFHw5/5Y0
tywzxwv/YFaIMNIy2CFB15E3gu7zuPDNr5NIn1jgSs1cdBDi9CV+jEmLTSbzbcWd
zWXi3+h7UGhl8gL0w2h5mX/Q6ARn7R5MlJH6l+wvhfCEjJYDQa4zXePrDZJiKhpX
rHGW3nhubDBqcj29cacXjdnXWOt9VNjLq1PngjMe8x8uwDcQsFPfcCiuKAfFgIW9
WAMWlIJtsIJRnoj7/Dwx+M2OxjRKtb1OSxeXD+KeAzYz5ZG+bzibm5+vQzRyQvrE
4A0+vJVwzGgq3RFRRNQqBS1Rojqk1pl34+aaSmSCbGo+og4DtodzCKq1co6tNjD6
U8gjfpkyHw4sMWfNPRMGFbr5+OvSehrQjzsyGnvGEicApr5JumV7JvIvRfXk65Jw
ASe/sMmZldPJjfZ18bEGbCIGq8wKQl7mAMpjsS6knnze/Aw2wdzEhxV4Dk2Infj2
f+OiRLBFpZwVtfObo2/UkcoHQg8MxFsOAk5ZJ4OVowl5zB7ZryR+hIZZlgecLmj0
YZuGt8ea
=J+XU
-----END PGP SIGNATURE-----

--LvVzXt1hdP616WUS--
