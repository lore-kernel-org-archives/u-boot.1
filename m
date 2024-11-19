Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDE6D44176
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 15:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73522894F9;
	Tue, 19 Nov 2024 16:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jmld6zP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A013689500; Tue, 19 Nov 2024 16:44:45 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8AC894C5
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 16:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b155cca097so435343885a.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 07:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732031081; x=1732635881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aVdXn06KbhcelbGP6jVK+m6J50XSywHesE/uTYN1/bQ=;
 b=Jmld6zP8TmuBSCuMxyiGCXgm4o35JZHBq0QuFFNhA4VI8Em+vZO9HoanHqxchWM3x7
 Dhca+hbdxDBs8IKXqwO0VcWYfFogJO+TjqrDLkVeH4LBqrnQp0sB7oFd0BGSHUYxsCqI
 CQqaxJrHIfGfR/47LAUyIbCf5S/LTcrjTmjNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732031081; x=1732635881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVdXn06KbhcelbGP6jVK+m6J50XSywHesE/uTYN1/bQ=;
 b=IK2T7pGmR0jTpZRUhC+iO8L31CdmkFcC5Yc6GGJdneZGNosy2edtAg1nulWxG06ll5
 JhgEbwj2qn9QMzTv9N5J8fDQT88OU7jzYvH3zb2/jgPkweqy16J52ALmBblgkzr3CbxR
 tjAPXaRsPELnJgmDIPxU8mMSuSbz6yrp3V7Xd0EuSCrBuJFDjHXB8l1j125lMNsFiVBq
 23dkfHzJZviEyEUwFp5FEWLqpBYsSxTBG8qil9Hn56u1PlWMIqU05dFyj87gyaLfccIJ
 tqhaArllHy4eLLgLO7N5KVjmMw/blG42is+bBiNYA3glXTvDcrInxp0D5lEXarwLA5T3
 mI6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU7Ft6Uudmf/tM0R0SR5g4fGovcBn5+k/v0wy9uJQszkK7av+eWQmCH2lxI3Bwp+VPl8VYiPA=@lists.denx.de
X-Gm-Message-State: AOJu0YyzVHz15Pn6YC8gTI6IlSyquI9mJuVgwDpsIuBj060PVvUe8hJk
 YWAVbliznal3h2alTmkmoSx4Bfl9HPAMLAKZbIwNeH/+QC2atEZ3gbk1zAWM0/g=
X-Google-Smtp-Source: AGHT+IEYYstPu02TiKF/tptSUqavBrh5n1bwyrYAaFzCuqdfaa7g0QysjfSH4HbCweEYfuUItjLhJA==
X-Received: by 2002:a05:620a:414d:b0:7b1:21c9:d1ad with SMTP id
 af79cd13be357-7b37aac019fmr584514685a.23.1732031081553; 
 Tue, 19 Nov 2024 07:44:41 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd1ff40sm49507896d6.80.2024.11.19.07.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 07:44:40 -0800 (PST)
Date: Tue, 19 Nov 2024 09:44:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: christian.taedcke@weidmueller.com, ada@thorsis.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, u-boot@lists.denx.de
Subject: Re: [PATCH] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <20241119154436.GW3600562@bill-the-cat>
References: <20241119073048.3469260-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DdNKymcOdN0ME5ag"
Content-Disposition: inline
In-Reply-To: <20241119073048.3469260-1-quic_varada@quicinc.com>
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


--DdNKymcOdN0ME5ag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 01:00:48PM +0530, Varadarajan Narayanan wrote:

> Do FAT read and write based on the device sector size
> instead of the size recorded in the FAT meta data. This
> helps to overcome the 'FAT sector size mismatch' error
> and enables U-Boot to read/write those partitions.
>=20
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  fs/fat/fat.c       | 227 ++++++++++++++++++++++++++++++++++++++++++---
>  fs/fat/fat_write.c |  19 ----
>  2 files changed, 214 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index e2570e8167..f4bad99335 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -44,24 +44,223 @@ static void downcase(char *str, size_t len)
> =20
>  static struct blk_desc *cur_dev;
>  static struct disk_partition cur_part_info;
> +int fat_sect_size;
> =20
>  #define DOS_BOOT_MAGIC_OFFSET	0x1fe
>  #define DOS_FS_TYPE_OFFSET	0x36
>  #define DOS_FS32_TYPE_OFFSET	0x52
> =20
> -static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
> +inline __u32 sect_to_block(__u32 sect, __u32 *off)
>  {
> -	ulong ret;
> +	*off =3D 0;
> +	if (fat_sect_size && fat_sect_size < cur_part_info.blksz) {
> +		int div =3D cur_part_info.blksz / fat_sect_size;
> +
> +		*off =3D sect % div;
> +		return sect / div;
> +	} else if (fat_sect_size && (fat_sect_size > cur_part_info.blksz)) {
> +		return sect * (fat_sect_size / cur_part_info.blksz);
> +	}
> =20
> -	if (!cur_dev)
> -		return -1;
> +	return sect;
> +}
> =20
> -	ret =3D blk_dread(cur_dev, cur_part_info.start + block, nr_blocks, buf);
> +inline __u32 size_to_blocks(__u32 size)
> +{
> +	return (size + (cur_part_info.blksz - 1)) / cur_part_info.blksz;
> +}
> =20
> -	if (ret !=3D nr_blocks)
> -		return -1;
> +static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
> +{
> +	int ret;
> +	__u8 *block =3D NULL;
> +	__u32 rem, size;
> +	__u32 s, n;
> =20
> -	return ret;
> +	rem =3D nr_sect * fat_sect_size;
> +	/*
> +	 *           block N       block N + 1      block N + 2
> +	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
> +	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +	 * . . . |               |               |               | . . .
> +	 * ------+---------------+---------------+---------------+------
> +	 *            |<--- FAT reads in sectors          --->|
> +	 *
> +	 *            |  part 1  |   part 2      |  part 3    |
> +	 *
> +	 */
> +
> +	/* Do part 1 */
> +	if (fat_sect_size) {
> +		__u32 offset;
> +
> +		/* Read one block and copy out the leading sectors */
> +		block =3D malloc_cache_aligned(cur_dev->blksz);
> +		if (!block) {
> +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> +			return -1;
> +		}
> +
> +		s =3D sect_to_block(sect, &offset);
> +		offset =3D offset * fat_sect_size;
> +
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret !=3D 1) {
> +			ret =3D -1;
> +			goto exit;
> +		}
> +
> +		if (rem > (cur_part_info.blksz - offset))
> +			size =3D cur_part_info.blksz - offset;
> +		else
> +			size =3D rem;
> +
> +		memcpy(buf, block + offset, size);
> +		rem -=3D size;
> +		buf +=3D size;
> +		s++;
> +	} else {
> +		/*
> +		 * fat_sect_size not being set implies, this is the first read
> +		 * to partition. The first sector is being read to get the
> +		 * FS meta data. The FAT sector size is got from this meta data.
> +		 */
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
> +		if (ret !=3D 1)
> +			return -1;
> +	}
> +
> +	/* Do part 2, read directly into the given buffer */
> +	if (rem > cur_part_info.blksz) {
> +		n =3D rem / cur_part_info.blksz;
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, n, buf);
> +		if (ret !=3D n) {
> +			ret =3D -1;
> +			goto exit;
> +		}
> +		buf +=3D n * cur_part_info.blksz;
> +		rem =3D rem % cur_part_info.blksz;
> +		s +=3D n;
> +	}
> +
> +	/* Do part 3, read a block and copy the trailing sectors */
> +	if (rem) {
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret !=3D 1) {
> +			ret =3D -1;
> +			goto exit;
> +		} else {
> +			memcpy(buf, block, rem);
> +		}
> +	}
> +exit:
> +	if (block)
> +		free(block);
> +
> +	return (ret =3D=3D -1) ? -1 : nr_sect;
> +}
> +
> +int disk_write(__u32 sect, __u32 nr_sect, void *buf)
> +{
> +	int ret;
> +	__u8 *block =3D NULL;
> +	__u32 rem, size;
> +	__u32 s, n;
> +
> +	rem =3D nr_sect * fat_sect_size;
> +	/*
> +	 *           block N       block N + 1      block N + 2
> +	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
> +	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +	 * . . . |               |               |               | . . .
> +	 * ------+---------------+---------------+---------------+------
> +	 *            |<--- FAT reads in sectors          --->|
> +	 *
> +	 *            |  part 1  |   part 2      |  part 3    |
> +	 *
> +	 */
> +
> +	/* Do part 1 */
> +	if (fat_sect_size) {
> +		__u32 offset;
> +
> +		/* Read one block and overwrite the leading sectors */
> +		block =3D malloc_cache_aligned(cur_dev->blksz);
> +		if (!block) {
> +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> +			return -1;
> +		}
> +
> +		s =3D sect_to_block(sect, &offset);
> +		offset =3D offset * fat_sect_size;
> +
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret !=3D 1) {
> +			ret =3D -1;
> +			goto exit;
> +		}
> +
> +		if (rem > (cur_part_info.blksz - offset))
> +			size =3D cur_part_info.blksz - offset;
> +		else
> +			size =3D rem;
> +
> +		memcpy(block + offset, buf, size);
> +		ret =3D blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret !=3D 1) {
> +			ret =3D -1;
> +			goto exit;
> +		}
> +
> +		rem -=3D size;
> +		buf +=3D size;
> +		s++;
> +	} else {
> +		/*
> +		 * fat_sect_size not being set implies, this is the first read
> +		 * to partition. The first sector is being read to get the
> +		 * FS meta data. The FAT sector size is got from this meta data.
> +		 */
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
> +		if (ret !=3D 1)
> +			return -1;
> +	}
> +
> +	/* Do part 2, write directly from the given buffer */
> +	if (rem > cur_part_info.blksz) {
> +		n =3D rem / cur_part_info.blksz;
> +		ret =3D blk_dwrite(cur_dev, cur_part_info.start + s, n, buf);
> +		if (ret !=3D n) {
> +			ret =3D -1;
> +			goto exit;
> +		}
> +		buf +=3D n * cur_part_info.blksz;
> +		rem =3D rem % cur_part_info.blksz;
> +		s +=3D n;
> +	}
> +
> +	/* Do part 3, read a block and copy the trailing sectors */
> +	if (rem) {
> +		ret =3D blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret !=3D 1) {
> +			ret =3D -1;
> +			goto exit;
> +		} else {
> +			memcpy(block, buf, rem);
> +		}
> +		ret =3D blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret !=3D 1) {
> +			ret =3D -1;
> +			goto exit;
> +		}
> +	}
> +exit:
> +	if (block)
> +		free(block);
> +
> +	return (ret =3D=3D -1) ? -1 : nr_sect;
>  }
> =20
>  int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *in=
fo)
> @@ -575,6 +774,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *voli=
nfo, int *fatsize)
>  		return -1;
>  	}
> =20
> +	fat_sect_size =3D 0;
> +
>  	if (disk_read(0, 1, block) < 0) {
>  		debug("Error: reading block\n");
>  		ret =3D -1;
> @@ -645,12 +846,12 @@ static int get_fs_info(fsdata *mydata)
>  	mydata->rootdir_sect =3D mydata->fat_sect + mydata->fatlength * bs.fats;
> =20
>  	mydata->sect_size =3D get_unaligned_le16(bs.sector_size);
> +	fat_sect_size =3D mydata->sect_size;
>  	mydata->clust_size =3D bs.cluster_size;
> -	if (mydata->sect_size !=3D cur_part_info.blksz) {
> -		log_err("FAT sector size mismatch (fs=3D%u, dev=3D%lu)\n",
> -			mydata->sect_size, cur_part_info.blksz);
> -		return -1;
> -	}
> +	if (mydata->sect_size !=3D cur_part_info.blksz)
> +		log_info("FAT sector size mismatch (fs=3D%u, dev=3D%lu)\n",
> +			 mydata->sect_size, cur_part_info.blksz);
> +
>  	if (mydata->clust_size =3D=3D 0) {
>  		log_err("FAT cluster size not set\n");
>  		return -1;
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index ea877ee917..f7a210d790 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -192,25 +192,6 @@ out:
>  }
> =20
>  static int total_sector;
> -static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
> -{
> -	ulong ret;
> -
> -	if (!cur_dev)
> -		return -1;
> -
> -	if (cur_part_info.start + block + nr_blocks >
> -		cur_part_info.start + total_sector) {
> -		printf("error: overflow occurs\n");
> -		return -1;
> -	}
> -
> -	ret =3D blk_dwrite(cur_dev, cur_part_info.start + block, nr_blocks, buf=
);
> -	if (nr_blocks && ret =3D=3D 0)
> -		return -1;
> -
> -	return ret;
> -}
> =20
>  /*
>   * Write fat buffer into block device

With this patch, we now have
https://patchwork.ozlabs.org/project/uboot/patch/20241113044956.1836896-1-c=
aleb.connolly@linaro.org/
and
https://patchwork.ozlabs.org/project/uboot/patch/20230730111516.v2.1.Ia1384=
6500fab3d5a1d5573db11a040d233994fa6@changeid/
for seemingly the same issue. Can you please try these other two
patches and report which ones do / don't handle your use case as well?
Thanks!

--=20
Tom

--DdNKymcOdN0ME5ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc8smEACgkQFHw5/5Y0
tyxnngwAsxyeUb3JNWdhKCDoVIp47cPUHNPUzjes+x/9hzgMuKdyq/Jy+vnJ78jk
wgENS0tdC1fVzXkTOt/CnFkGNPaOxdX1zq/EGuz4fkgVM32qzKqkUTFlJO9j/wsc
Vr99RcQfENEl21cXSWLR8ICE2IA21zN/mMxexlsuIXLizA+WGMIooDICWnZaJgri
PmkawYuj7+/nLI2m1dgCDqXKCIzzZlWMRcA3semEjmEOeUiZtfGf1PagOGhEggPK
viPXVT/5Age+wtx0b7u6EqKTtMI8xLc3gcXacI6cHtJytzzR2adbgn+NxyanodgR
mhMs5ZJ0Od4ADsq4WXT0ui+QXD4TMyxgsWV0/nkKlsImqCOzrXBM5+YyHT3xW65w
tm2SPnownEOc58wOD/kfemsv37mwetHDYmI5ft4eweZfR79o701MG/JBL7M4R725
ORjhw7qY331CMTJQKrc0dDQ9LmvFIy2m5I0k0vC8k1LInLelm8jf45xisN6i75mv
s7eNcLiV
=PRRa
-----END PGP SIGNATURE-----

--DdNKymcOdN0ME5ag--
