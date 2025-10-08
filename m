Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A9CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9F783A2A;
	Wed,  8 Oct 2025 18:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JyVqMcq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D7283A5C; Wed,  8 Oct 2025 18:38:28 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D320B839DE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c0e8367d4eso17784a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759941504; x=1760546304; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2w81F8iiZLJDdZCLMDW5ECX6DEu69p9sPzaWDgCS8A4=;
 b=JyVqMcq/IOZfojANCOYbJAdR8nuXoQ2lyeCnuyFvRaKfSXXYVs2EU8nLL3Hkvzs/LJ
 NXqf7T68YSL7JPKYjiuwYKjj7wzkOWJcFC3aOqGdjLqkOcuO+Iz+HjHlU2JgoEuKczeU
 ikJcEzZSsEbX0rPmAW/swkK0rdcw7UtjhMQhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759941504; x=1760546304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2w81F8iiZLJDdZCLMDW5ECX6DEu69p9sPzaWDgCS8A4=;
 b=cdMKimCIY5RUu0YtoLp0LBlJgy4eQ2zdk16oQGNiDw9d9kdLS0ir8V2oNkv68k6hfp
 5/TfxglDtTjhA3uQ6S3lHT2vnwvreXuq18SBldxOTHduWDjDpRmoxa9yA3dqPJGJi/lq
 odokZBUrbfz/5ejd1u+GVHEwELV/0c2pPELre9tsG+uFwg3eDY42BKRPeoofDH1A1r+S
 uNd4N/mFSqYdzAIK27Pmm6ZY8g05pYDpA4t24z3s4h4S2V9tz/Ab3MEXzdl/3JSpk+rP
 gh2nikO22MxvKrdmTWATgwLlYSUL0e7R78iUFNabNugjk1JsrxJMcDaJOjdpwMI4hHFD
 dIZA==
X-Gm-Message-State: AOJu0Yw+O4u9JdrPPc+C6yYUjELUICai+hiTOEjNCu1V1bGMRR7xr4Y9
 aAtbeTp9u0iraSjKMlT9GXF/cp8D/GqvDLA467M8tPPnaVyghpVIoqYNiiLYXphND4Y=
X-Gm-Gg: ASbGnctNN00KSZt9ixkLPtnzs5krNiOgzhVfB5dFkZnO5aiJr+4o8eJq1QZBTT+5wbL
 k+WPZymaelDhOL23D4i4JJSc068YZJKsmj60hUvKjZ6GA9E7AFTzrLWIMB8762+2vtSUvd5iwj9
 enrlsBYYqE6vG0lSMo/ge3V3waHRqjfsbSzWZmFhTtavqM4V/atSWcgVF4NV7kaGFTDrPGLmdeT
 e3ygJ18fKgy/IzoX9pVaug0ABaj5Zutc3G6OqJGFKFoh0vPMezbpH+CWJAbAhrvpPBSunjp1zOv
 FSOX+tgJDo0Ly2sWbE6c8Grk82LDKhS8VecrO9d0DEmM95Bp6r2mqqJoCelbssjyv0kTan3hmh0
 mxyI5z56GgPdB/dRXqJwf329foauAO2ykISXzq8t9OYxeIAp/C0GG7/Yrl15PpKTMYrWNT//kXr
 xBCnPgKuJulbZHbc4OXUNQ
X-Google-Smtp-Source: AGHT+IH/6mmcLYk2Lw3rVCgBUXj9HuEhS75c/2xOTvlTH63laOc95AjFNhWy73p90bZft1KogIScZA==
X-Received: by 2002:a05:6830:6613:b0:7bc:164c:58b2 with SMTP id
 46e09a7af769-7c0df77f1e4mr2981666a34.12.1759941504555; 
 Wed, 08 Oct 2025 09:38:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f610041sm5878927a34.3.2025.10.08.09.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 09:38:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:38:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com,
 kever.yang@rock-chips.com, hl@rock-chips.com, tim@feathertop.org,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v1 1/2] spl: make args file optional in falcon mode
Message-ID: <20251008163820.GC298503@bill-the-cat>
References: <20251008113605.1055826-1-anshuld@ti.com>
 <20251008113605.1055826-2-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9Dk9DMgKSqulCmyl"
Content-Disposition: inline
In-Reply-To: <20251008113605.1055826-2-anshuld@ti.com>
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


--9Dk9DMgKSqulCmyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 05:06:03PM +0530, Anshul Dalal wrote:
> Falcon mode loads a kernel file and an args file which is the
> device-tree. However in the case of kernel file being a FIT that
> contains the device-tree within it, loading the args file is not
> required.
>=20
> Therefore, this patch introduces a new SPL_OS_BOOT_ARGS config options
> that allows us to enable or disable loading of the args file in falcon
> mode.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
[snip]
> @@ -1266,7 +1273,8 @@ config SYS_MMCSD_RAW_MODE_ARGS_SECTOR
> =20
>  config SYS_MMCSD_RAW_MODE_ARGS_SECTORS
>  	hex "Falcon mode: Number of sectors to load for 'args' from MMC"
> -	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR !=3D=
 0x0
> +	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR !=3D=
 0x0 \
> +		&& SPL_OS_BOOT_ARGS

In this case now that SYS_MMCSD_RAW_MODE_ARGS_SECTOR would only be set
when "args" is being used (the 0x0 value was the workaround for "Using
FIT, this doesn't exist"), we can just depend on 'SPL_FALCON_BOOT_MMCSD
&& SPL_OS_BOOT_ARGS' here.

> diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
> index 93ef2d1c02c..f1cdbb6dbc4 100644
> --- a/common/spl/spl_nand.c
> +++ b/common/spl/spl_nand.c
> @@ -79,7 +79,7 @@ static int spl_nand_load_element(struct spl_image_info =
*spl_image,
>  static int spl_nand_load_image_os(struct spl_image_info *spl_image,
>  				  struct spl_boot_device *bootdev)
>  {
> -	int *src, *dst, err;
> +	__maybe_unused int *src, *dst, err;
>  	struct legacy_img_hdr *header =3D spl_get_load_buffer(0, sizeof(*header=
));
> =20
>  	/* load linux */
> @@ -101,6 +101,7 @@ static int spl_nand_load_image_os(struct spl_image_in=
fo *spl_image,
>  	if (err)
>  		return err;
> =20
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
>  	/*
>  	 * load parameter image load to temp position since nand_spl_load_image
>  	 * reads a whole block which is typically larger than
> @@ -116,6 +117,7 @@ static int spl_nand_load_image_os(struct spl_image_in=
fo *spl_image,
>  	     src++, dst++) {
>  		writel(readl(src), dst);
>  	}
> +#endif
> =20
>  	return 0;
>  }

I think we could rework this to:
	if (IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)) {
		/*
		 * load ...
		 */
		int *src, *dst;
		...
	}

Instead. Especially since err will be used but src/dst not, in the
no-args case. Or no, we can't because CONFIG_SPL_PAYLOAD_ARGS_ADDR will
be undefined and fail to build? If so, we should still split the
__maybe_unused line.

> diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
> index 6f9ff91bef7..77c77ce6809 100644
> --- a/common/spl/spl_nor.c
> +++ b/common/spl/spl_nor.c
> @@ -69,7 +69,7 @@ static int spl_nor_load_image_os(struct spl_image_info =
*spl_image,
>  	       (void *)(CONFIG_SYS_OS_BASE + sizeof(struct legacy_img_hdr)),
>  	       spl_image->size);
> =20
> -#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
>  	spl_image->arg =3D (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
>  #endif

We can drop this hunk I think.

--=20
Tom

--9Dk9DMgKSqulCmyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOaTeAAKCRAr4qD1Cr/k
ClWbAQCD6IR+jWRncafRB1ehayHftg/9vMmEYWfSSvQ4GIcwBQD/djAdK+jErE/9
RrsH+UWAYQL65TZ6HUpEPE+RJBepRQI=
=OEpq
-----END PGP SIGNATURE-----

--9Dk9DMgKSqulCmyl--
