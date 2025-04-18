Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67C9C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B0B82A1C;
	Fri, 18 Apr 2025 15:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rM2BzvGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DAF82AA4; Fri, 18 Apr 2025 15:48:05 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CF5810EA
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c172f1de1so987584a34.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744984082; x=1745588882; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lQr2c88loCIC0OfwqTQpICxRfJ2SgUA8o2/CqV5GoFM=;
 b=rM2BzvGFRmsC50kTjUZN/59GB3UzZMOZXH5HhZzvAS7LJIdk039flkGz8q10u3V1kv
 Mx62LJtCfqJVlOEs8vAvqyKbF9E3wd0APpR0Mz+/+KqafsU9hx1YS6UCL7tcJQtB8Oqc
 lAUfzSZcEGJD/4/yCfbb2BIyTXhAwGO9UUOLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744984082; x=1745588882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQr2c88loCIC0OfwqTQpICxRfJ2SgUA8o2/CqV5GoFM=;
 b=ovwMqwtL7lI62lO3WDSp2qEz4Zi0Gw4CulDXIQSi8z7vZRRL4g3Pu23yLhTgvpsnMV
 Xr3Etl+EOP9lMC2reG0W7hdS6jg0Wow8etG3GdmdiQY1ihr4jQdTEfCnH3BRpwPaG0Mg
 PmjRjAXqVGxJu5jK8WzJ0+7fQIV1v3RZxZpNJymTy1W0+5VovmxIl4pQtVI/2Z/qS4hu
 d02cYxXy/twewKOb8FHbWfXJtNZWABcRKki8Ajozrcos/32ilTJiSmf2aguftCmsPATf
 Z0RX3nwqeKE2YvLF6ButLt/HJnE+TnhZWlhf85VtLaJ7q24bnfc0mRMOaPw5gUW8zpt1
 O51w==
X-Gm-Message-State: AOJu0YwljeyiMikDZYBvSjB4P7H3EoSqDNp391KoJ29wfvTV/LyLP4S4
 RkeWC9hHFVBNQycTy0RvBYuO6TT4+pA7Q5HC7cjTzAy9LYbbAZSMLzrZmyOi+Eoe2FvLD4vu7Eo
 d
X-Gm-Gg: ASbGnctSYWhniez+AZayI4SVpvk/0iG4m+afuESS8ldbiunvGe6m2QAyu6jep31nTQv
 BQau2shVYm6PQoqipn8tCkqzW2EpR9LVt6zMhC/KlDDoKkWTNB9HhH1mql/4j7VZ0hWo1sekesH
 0+cZSSFNPxiQp8wqrMbnqhQdlKVXp2iaQzzS5Ozq4AHK4vZip8xXfZp5R5eRgMPjXDKtgUd8DC0
 Y6mbZ4pU7c82E6cDN8qjucIlWTwmV3VWk4iYar1+2D+hRm8qG/MJuc+nhBAfPCbErK+HBCXbxXp
 0INk+y4BluQAGtaLJ7gXkQznwep5QDq3L/5kyA/cctrfTUB2xKiszJ26oGqJfeR1vzxjvRY1hAo
 JZaQAAG9xwDZ+
X-Google-Smtp-Source: AGHT+IHBH8v6l0KH9cDX7BcAB24XIEggLQ9xXDT8MxcLBZbTo2PVaG51tbESfLyjjDqCtP1hvyrv/Q==
X-Received: by 2002:a05:6830:700e:b0:72b:9fb2:2abd with SMTP id
 46e09a7af769-730062fbb4bmr1722563a34.20.1744984081852; 
 Fri, 18 Apr 2025 06:48:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047c8528sm343712a34.33.2025.04.18.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 06:48:01 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:47:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Uma Shankar <uma.shankar@samsung.com>,
 =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 3/3] ext4: Add a few overflow checks in the writing code
Message-ID: <20250418134759.GM5495@bill-the-cat>
References: <20250418105919.1645824-1-sjg@chromium.org>
 <20250418105919.1645824-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jUdiPOERGYet1BBx"
Content-Disposition: inline
In-Reply-To: <20250418105919.1645824-3-sjg@chromium.org>
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


--jUdiPOERGYet1BBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 04:59:15AM -0600, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Some memory allocations make use of data from the disk, so add some
> overflow checks.
>=20
> Adjust LOG2_BLOCK_SIZE() so it is easier to read.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
> Changes in v2:
> - Use Linux macros instead of gcc built-ins
>=20
>  fs/ext4/ext4_write.c | 25 +++++++++++++++++++++----
>  include/ext_common.h |  3 +--
>  2 files changed, 22 insertions(+), 6 deletions(-)

There's a lot going on here, which makes review harder.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> index d109ed6e90d..a9a53214dce 100644
> --- a/fs/ext4/ext4_write.c
> +++ b/fs/ext4/ext4_write.c
> @@ -25,6 +25,7 @@
>  #include <malloc.h>
>  #include <memalign.h>
>  #include <part.h>
> +#include <linux/overflow.h>
>  #include <linux/stat.h>
>  #include <div64.h>
>  #include "ext4_common.h"
> @@ -108,8 +109,15 @@ int ext4fs_get_bgdtable(void)
>  {
>  	int status;
>  	struct ext_filesystem *fs =3D get_fs();
> -	int gdsize_total =3D ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
> +	size_t alloc_size;
> +	int gdsize_total;
> +
> +	if (check_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc_size))
> +		return -1;
> +	gdsize_total =3D ROUND(alloc_size, fs->blksz);

This is equivalent, yes.

>  	fs->no_blk_pergdt =3D gdsize_total / fs->blksz;
> +	if (!fs->no_blk_pergdt)
> +		return -1;

I don't know if that can ever happen but it's not unreasonable given
thee class of vulnerabilities that are "make up a specially corrupt
image", so this is good.

>  	/* allocate memory for gdtable */
>  	fs->gdtable =3D zalloc(gdsize_total);
> @@ -117,7 +125,7 @@ int ext4fs_get_bgdtable(void)
>  		return -ENOMEM;
>  	/* read the group descriptor table */
>  	status =3D ext4fs_devread((lbaint_t)fs->gdtable_blkno * fs->sect_perblk,
> -				0, fs->blksz * fs->no_blk_pergdt, fs->gdtable);
> +				0, gdsize_total, fs->gdtable);

Is that equivalent?

>  	if (status =3D=3D 0)
>  		goto fail;
> =20
> @@ -599,10 +607,17 @@ int ext4fs_init(void)
>  	int i;
>  	uint32_t real_free_blocks =3D 0;
>  	struct ext_filesystem *fs =3D get_fs();
> +	size_t alloc_size;
> +
> +	/* check for a reasonable block size, no more than 64K */
> +	if (LOG2_BLOCK_SIZE(ext4fs_root) > 16)
> +		goto fail;

Reasonable for the same reason as above, but not related to overflow.

>  	/* populate fs */
>  	fs->blksz =3D EXT2_BLOCK_SIZE(ext4fs_root);
>  	fs->sect_perblk =3D fs->blksz >> fs->dev_desc->log2blksz;
> +	if (!fs->sect_perblk)
> +		goto fail;

Same.

> =20
>  	/* get the superblock */
>  	fs->sb =3D zalloc(SUPERBLOCK_SIZE);
> @@ -629,7 +644,9 @@ int ext4fs_init(void)
>  	}
> =20
>  	/* load all the available bitmap block of the partition */
> -	fs->blk_bmaps =3D zalloc(fs->no_blkgrp * sizeof(char *));
> +	if (check_mul_overflow(fs->no_blkgrp, sizeof(char *), &alloc_size))
> +		goto fail;
> +	fs->blk_bmaps =3D zalloc(alloc_size);

Equivalent.

>  	if (!fs->blk_bmaps)
>  		goto fail;
>  	for (i =3D 0; i < fs->no_blkgrp; i++) {
> @@ -649,7 +666,7 @@ int ext4fs_init(void)
>  	}
> =20
>  	/* load all the available inode bitmap of the partition */
> -	fs->inode_bmaps =3D zalloc(fs->no_blkgrp * sizeof(unsigned char *));
> +	fs->inode_bmaps =3D zalloc(alloc_size);

I'm going to assume that yes, really, there's no case where
sizeof(unsigned char *) !=3D sizeof(char *) so this is equivalent.

>  	if (!fs->inode_bmaps)
>  		goto fail;
>  	for (i =3D 0; i < fs->no_blkgrp; i++) {
> diff --git a/include/ext_common.h b/include/ext_common.h
> index 6e17fbd2771..35d3a1844eb 100644
> --- a/include/ext_common.h
> +++ b/include/ext_common.h
> @@ -67,8 +67,7 @@ struct cmd_tbl;
>  #define EXT2_BLOCK_SIZE(data)	   (1 << LOG2_BLOCK_SIZE(data))
> =20
>  /* Log2 size of ext2 block in bytes.  */
> -#define LOG2_BLOCK_SIZE(data)	   (le32_to_cpu		   \
> -				    (data->sblock.log2_block_size) \
> +#define LOG2_BLOCK_SIZE(data)	(le32_to_cpu((data)->sblock.log2_block_siz=
e) \
>  				    + EXT2_MIN_BLOCK_LOG_SIZE)
> =20
>  #define EXT2_FT_DIR	2

That is indeed an odd place to enforce 80 character width over
readability.

--=20
Tom

--jUdiPOERGYet1BBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCWA8ACgkQFHw5/5Y0
tywPAAwAhctR1twLWivRjYp92aXAKrr6rPM6+xY7uJ6GtYUQyxGBHCPS07TBblzp
B89y/fo2BwInQEKhPJgCKuNsQai3rC5nAuvAXZw3MYgUt/zStoJyRf17JpWXBLr1
ptB6GiPo8Go5Y5gy2ILtKiMPM3ckzCfLANwwyMqvnDfeZjG5xSOVH8VRSuMppqfa
zgmUB179u6fST9DnKhkv7FPD8Tnvj4fxKn+gAbD9jJiBfEse+XkeS9/WH72xkfm4
tci0F1dFQVqbjjZjlypvdzn7JCVhyBfxR8RTxjYIPPE49Nal9B8tlU5ETTL3X6+p
97jF68BZHSDcdpGoGERrW2vS+6i+liQcYOcAmSQFV+Gwvu7dUhCzqKhLjPXQgZOI
BsiR3tYPajxvgpp4VIqsFjxXsdO53b8LktwppgnyvWhutTlnFnGzwCAsyj6GIQuV
LT2GOBXfv/+skVBYx85y2JPXXs5N9Q5ifEShRsCaO44EqBL+WSf+zhc/fwqpf+Vi
SghzRHdc
=cRHP
-----END PGP SIGNATURE-----

--jUdiPOERGYet1BBx--
