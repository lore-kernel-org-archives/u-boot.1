Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B57C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992E581DCC;
	Sat, 29 Mar 2025 00:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KbomhGYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426AE81DCD; Sat, 29 Mar 2025 00:51:42 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0444E805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2b8e26063e4so1391669fac.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743205899; x=1743810699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5su5wU5fKs7r4pvUYmiAxuL9BKIXHqcCUyre9m4KsVc=;
 b=KbomhGYreZAi7X04Cw4V4kIzfmYAeNsELrbEjW+ObUX6p6NslifK3/YiZDvSgAey2N
 xNRXWRi907JzEazDWTg8wuqXS+41T0JdxqJc6+oTG4aTNsOkxgtLXKly2FUgbBPvbwbh
 +uSP4+9mQ8glRQfOiJdtsrmsalXVq26woW0H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205899; x=1743810699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5su5wU5fKs7r4pvUYmiAxuL9BKIXHqcCUyre9m4KsVc=;
 b=N6nqJ455td3IHN5IRaLzYMFg9VYdkET+RzBdRuo81e6pjI7NWMepdY60TyTHsE+djh
 DkmiIe5M2TzENHfBb0yYF8AhUCL/Eflhj7V2L1wrMcKPtjlbTTsdCW/Jeig5jTUSh5WP
 tTCNAq6vQOgWO8AaDJLUng4XV5QrUEqfDvrHwPAPTgGi0IXX2unGaIbzXvLHvd/S149H
 Hm+K53fP963U2dNqXtBZCxs7Q/R8lqOedI1aM66B36RrFsQaJRQl81Zamyut/gVZl6nP
 LiNdCWL4VWYRzRypqsBMTrYHTFMHMASXVyN5FfvXIl94BUOzNVJxVyc3/GeXlxwP5gZt
 k95Q==
X-Gm-Message-State: AOJu0Yy5jeYjvjLHTNcfGA55OCNNpcs6pB+wMMipObjIKb8XpsMLonRb
 Sthou5szZTSv5tEZr9qomzI0QW4nxi0ppVbE22oYqPi0nlGjOLbNsxZvida/pGc=
X-Gm-Gg: ASbGncsQPjuyGNDjABAJnL2Uts3Q2GRrP7hYy4PGEIISGLM2LFImHDtg4YUKUI5sz1Y
 paDWMNU1J2hG+ZbhN7rYymtqza5U88c5UOX0FtCilZRk1rrEZzfJ7S79ibgBQgKSEWoaZFLWPeP
 v78ooHIFJj5hjLG84lzRg54H1kaLMnO8LEusaaETAwDSXVGEqfBg/cDgYCebQKDr30JWwydq2DJ
 GqzqBYPWE1fG1KAw3Z9qLLW4NvrZ7Y7UP8nGFL6jSxIU407KuHZY+uEnGZ9qlSyDpSFhhL1KWvG
 c+9tqlxfBJK77A5m7awtG8Vy6pO/hheCRboOIRMoGXUoNHD2OfDFhhgoTByXhCy+fU8ODwy9YEW
 hhxKFuA==
X-Google-Smtp-Source: AGHT+IHNgvsWbCOLSYGDDZixrnZfpMZr0dQhWDgKSaUzMrzzKNsvG4adBNPWRWEonh6mv23Q0gjwYg==
X-Received: by 2002:a05:6870:a44b:b0:2c2:b838:3ef8 with SMTP id
 586e51a60fabf-2cbcf477b15mr635360fac.2.1743205898541; 
 Fri, 28 Mar 2025 16:51:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91391esm646645fac.46.2025.03.28.16.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 16:51:37 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:51:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
Message-ID: <20250328235135.GF93000@bill-the-cat>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fFBnaUJlYjAgaVQE"
Content-Disposition: inline
In-Reply-To: <20250327231318.2713201-2-raymond.mao@linaro.org>
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


--fFBnaUJlYjAgaVQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 04:13:17PM -0700, Raymond Mao wrote:

> Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> is a default address for bootefi, bootm and booti to look for the
> device tree when launching the kernel.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  env/common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/env/common.c b/env/common.c
> index a58955a4f42..a38e5d107a8 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -16,6 +16,7 @@
>  #include <asm/global_data.h>
>  #include <linux/printk.h>
>  #include <linux/stddef.h>
> +#include <mapmem.h>
>  #include <search.h>
>  #include <errno.h>
>  #include <malloc.h>
> @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf=
, unsigned int len)
>  	return env_get_from_linear(default_environment, name, buf, len);
>  }
> =20
> +static int env_update_fdt_addr_from_bloblist(void)
> +{
> +	/*
> +	 * fdt_addr is by default used by booti, bootm and bootefi,
> +	 * thus set it to point to the fdt embedded in a bloblist if it exists.
> +	 */
> +	if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src !=3D FDTSRC_BLOBLIST)
> +		return 0;
> +
> +	return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
> +}

This part is fine with me and makes enough sense, we can't do this
immediately so we need some check to know to do it later.

>  void env_set_default(const char *s, int flags)
>  {
>  	if (s) {
> @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
> =20
>  	gd->flags |=3D GD_FLG_ENV_READY;
>  	gd->flags |=3D GD_FLG_ENV_DEFAULT;
> +
> +	/* This has to be done after GD_FLG_ENV_READY is set */
> +	if (env_update_fdt_addr_from_bloblist())
> +		pr_err("Failed to set fdt_addr to point at DTB\n");
>  }

I don't know this is the right spot. This won't work when for example
the environment is valid but stored in a file on FAT (or whatever) will
it?

--=20
Tom

--fFBnaUJlYjAgaVQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnNf8ACgkQFHw5/5Y0
tyx1aAv9Fny2895DhqqdCGWfRuOoImx+pVx86qfmTUB99gCYHlQ9HmhKfHRby0ky
445Jo6pBjbMlJj2CTjj+TpJ8938fp0aSGQ5PjCfp0vl4khADB/Kc8hQL2yV9xF4r
GNynlPJPiPQzfFUZFmnd37BvMnXeZt2iyJf0UfrphxY6WL9d74LMEqg7BpMgLZk7
wSm1sJmixwCVn6p8x67JtFzspkeuoSBYTxLoIlsrs7HtAcTfo8ub7PHoQFTL3c+D
ALHao0+KeyyC3nW5TrTa0f8/UcZFITp9lq1u2JIj3/5+3gSxYlStxUlXyLDrCapB
JyzIN7Fp+GU+z3y055uqDVRw303GGUtieI496eimivFCCk9Vmawzf6F4lX/jBXeB
yXUY4xghLwKPMXuZEAaCxtQ6cbFYqLolO3pTrPBYMXBJSaAmVDWSfPmFMpzpYBPk
KKmRFw3IPLpFDqbyO/SC4GQhRiAukJuLMHQsFE2KIc86pnYwtgpGbsycCUgbzg6C
xERVY8Y8
=xX93
-----END PGP SIGNATURE-----

--fFBnaUJlYjAgaVQE--
