Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AC4D216B7
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C43088113;
	Tue, 15 Oct 2024 16:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UYAk4vRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFD587BF4; Tue, 15 Oct 2024 16:37:43 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD34588009
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460407b421bso42464631cf.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729003055; x=1729607855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A2nkksTCF23z+Tkf2UdL3Vhhfp+D+IChjple/dIk3Nw=;
 b=UYAk4vRwDumUmX72BoYcc6/J9UoD5fBxto2mfMfBqY6IxwdhzUthkct9pg+nFOh59G
 BEPMfF1v97EpBw18KqTxxN5hCOdmBBCTKPI5YVmDcZSpBw2V3bw08vo3Q+4RxZfkxB+P
 OgFn8LAX75wMp0KiTGynmOdqNbjbEv94noJ+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003055; x=1729607855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2nkksTCF23z+Tkf2UdL3Vhhfp+D+IChjple/dIk3Nw=;
 b=I1FNPeHO8cT7s1BLlYw6Iy0y/7adiBcXJMy9YKbRS7aNVikbBNNH+LfOmq77rnFf1e
 GHqmaFJuYL+XaKDgDutcVD3sNuUuPNlNH9m65aLNnhhgnWoem15gXuRsXmHIuFJ51bjX
 C8VnenTm8QjKiTPHzPMD85Rsp8rrvdrkHeNeolVBCwtAZX9Oy23UgthNX1QfhDWBMYse
 01xh9hY/y/SfgLh7GeQ0/SvnHBQre8AA+JlF4/A5QQXDyt+JIjl8l7k/IuiJtgtlfg5o
 kOboapNO54qeGk4B4QtgnIf04TQ79m4h1TX1eeTQJI7pKVccEuaUtdKcaxkFpieQ9PlM
 n/qg==
X-Gm-Message-State: AOJu0YyMAEIYO8mrsOD82aBvQdIh5THNLhMsJZEOAm5X0XQmgafXLLv2
 uN4f3/+TqEGbJfhzoVWQTikA200rfAerBH0mKJvMoxfgXWpkFrW5RjYeEFcf6r9gixsF86wjfuF
 I4QM=
X-Google-Smtp-Source: AGHT+IEAwDMmAWWjnp9Erhp7QRs6MOFbm6HGxugkj+1s6ycSdfRTpgwWs16TFxOULv3/qeUjw7ZZVw==
X-Received: by 2002:ac8:7d46:0:b0:45d:5d31:89f0 with SMTP id
 d75a77b69052e-4604bb94e6emr212114691cf.3.1729003055276; 
 Tue, 15 Oct 2024 07:37:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b38d034sm7023311cf.88.2024.10.15.07.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:37:34 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:37:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 3/7] am65x: Use map_to_sysmem() to convert from pointer
Message-ID: <20241015143730.GN53053@bill-the-cat>
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mICfb9MMnOkkhjC0"
Content-Disposition: inline
In-Reply-To: <20241015133304.2874735-4-sjg@chromium.org>
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


--mICfb9MMnOkkhjC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 07:33:00AM -0600, Simon Glass wrote:

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

This covers half of what we talked about in v2. But map_to_sysmem() is a
sandbox thing that should not be called outside of (a) arch/sandbox or
(b) common code that runs on sandbox. And honestly, we should work to
hide that abstraction as much as we can, not start introducing it more.

--=20
Tom

--mICfb9MMnOkkhjC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOfioACgkQFHw5/5Y0
tyyukwwApJHIm/V7nBqeS06YZPAXK7oiUU48/PtM/5S9J2ktALpsf28uZzvnY+1y
cjyaBnBrPMgUR4nQmQiBZbrUfv/Wit0E9yBzIIzyK5UXR5Sri5gUOp49S8/3mXOh
+SdQdvh4OVvP4plvkTlqFAwVyT7rrMEzvRcoisdy3LZZ0IDagR6y1qAcnYLIeuT7
/wPV2tUUEVkU3FqCrR38rrXi58l2JWnlrDYGelMdzWfKMWr4TsoxhoNivT0W1BXS
JEkQJk0i/GCudQrQaUfHpvHCX6KZDio1m2OSWp8UpUGNa0p+fPVTqdIoVi49IDZ7
27ouVuLXzHV+hFODCA4G8VS8VNikpRdipiUb2OAThSNwzZjZ6efpefbDbPLeQcn3
g8JEENN6KWO3KUt8Ah+CJtO5VdgwIbdjeJsnpahgvaVQPQsISuZJhiQDHNLPxv/i
rEOCtwGtx+p0AOzZU9fgoeJOyIZNFy5NIK47ywPKzg5d6PMLxlxCuznSHbPFxuu/
lflFiDDL
=L4gs
-----END PGP SIGNATURE-----

--mICfb9MMnOkkhjC0--
