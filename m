Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9DDD58D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AE789A65;
	Mon, 25 Nov 2024 18:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bXpuRUOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196AF89A59; Mon, 25 Nov 2024 18:47:53 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E60689A5B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53dd0cb9ce3so4372939e87.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732556870; x=1733161670; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s9RXqcuHZyng3cHxl9uJDRE6FBe7n3O8USJVCgCjyaw=;
 b=bXpuRUOMPbAxm/e2PuWl3z+huZEbdwZwW0DDdanb69irtOEUJfuG9VMU83P8zXo5Bq
 qjuI7iSY1TALUStfFuX9okBUM/vHchzQaUkliutSarOvh4ppv9ueitoQNhiezzPNPHMv
 RiQW8z5mUVMmUFBj2myldzUv+H5lwG28YuSnJ56E20qrrnnzo8ZFa3ezW8t0F9d5mEmN
 7UTGx9CIv5LcZp5pELL5TaOF7dP56g3QeZOXPHDlEDOMu19VM/lh9rt95R60IexiDSxZ
 +ow0IsbtP4MIsQBO9QzfZIYz6ngrJxVVUuLYN2WHspAHhIV5PCm3PqqKUJHBQb7TYTiH
 aIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732556870; x=1733161670;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9RXqcuHZyng3cHxl9uJDRE6FBe7n3O8USJVCgCjyaw=;
 b=ivaXAQUKswhQjvl4WMKXEZtl5IZ+qvt79jNxEJXxwDQDUOPC4QNYBT9l9hcZwyWRTn
 bl3sQ/S88SY6Cxovaum7O0AK55JrYE3eyBZTOJftOhGLVRa8vpTWd6I9WG86iLWBQQvx
 g7mgGl1+qohAtVnV8TJm8nODabE9ccuqa/71qaLbfdI3AB8Gk9Rj+bC6ts+L/s6Ikndy
 Bxck79YwEykf9zDnfKycMKXkoQhHqMKnVii3qlwfLG1FE+axjmm6wNBGtt6LgbD5ixld
 xEPsq4JtgYWnqTLdwwI+ndchwOX5fK916dBX1uy3ZLwYlfPnibnQ1Hu3fNXdjjR1W1xF
 592A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxg37jt32wUQkc5iOYUXBp7izRDPPj0n+ueMTaN7uowK6u70Yu0DWiznilCMw5baqwWKCFK9I=@lists.denx.de
X-Gm-Message-State: AOJu0YxrLkShNt0YJYSEqlGuvH1Wh7TcjsSCQXBqRxTP65Tg3c1HXfdb
 N8RATqkLJ6k3g82m1rYHTcjoEiund8sXNNodJQVFowvHF9BN8segyWmi7Wur4kI=
X-Gm-Gg: ASbGncvlal2QkL3ttBwVUncRgmHarKI6GUhjt3hIKYkO0Hl+qe3s/PgVG/1xgZmFapt
 xQXQiu+cICgU9If8IgHdJ9muiYeXZxJ6UQjDALOj7rQpf4uECzEQV1/2vWJI1UNaMucoDIVZdNI
 FTqaaw2MhFwETfwTK9hTUe1noC03IhQHz8ZscdJzW9IFfry2d/nTGDqNnUOZExFCKfXzcEr6LVA
 Zyp2AhgZ/AP09P+NqrWUZ7/6v2vaG1bB9dpDKdNqt+nDty+tsnYVzQjO3SEkWJYHyrSfNiRLeHI
 144qRQ1qexBIg9vkAAKc8RztMsX1USYV
X-Google-Smtp-Source: AGHT+IEGLxA6sdW+mEX6MhZEE8IZyKdiFbSCdofU3oBXtYyl4itVDmpfIDou+0d/xXD7DWxYQa8Fmg==
X-Received: by 2002:ac2:5690:0:b0:53d:aec4:3440 with SMTP id
 2adb3069b0e04-53dd399276amr7526733e87.32.1732556869680; 
 Mon, 25 Nov 2024 09:47:49 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa53299ff77sm352940166b.73.2024.11.25.09.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 09:47:49 -0800 (PST)
Message-ID: <01c891bc-4fbb-4ef5-aa22-bd10a8ae0aff@linaro.org>
Date: Mon, 25 Nov 2024 18:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: fat: Handle 'FAT sector size mismatch'
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 christian.taedcke@weidmueller.com, ada@thorsis.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, u-boot@lists.denx.de
References: <20241125085213.460723-1-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241125085213.460723-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Varadarajan,

Thanks for re-spinning this.

On 25/11/2024 09:52, Varadarajan Narayanan wrote:
> Do FAT read and write based on the device sector size
> instead of the size recorded in the FAT meta data.
> 
> FAT code issues i/o in terms of the sector size. Convert that to
> device sector size before doing the actual i/o. Additionally,
> handle leading/trailing blocks when the meta data based block
> no and i/o size is not an exact multiple of the device sector
> size or vice versa.
> 
> Tested on UFS device with sector size 4096 and meta data recorded
> sector size 512.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

I'd appreciate it if you could just CC me in the v2, then you don't have
to reply to the v1 thread.

It would also be great if you could include a changelog so we can keep
track of things across versions. Just for future reference.

Kind regards,
> ---
>  fs/fat/fat.c       | 218 ++++++++++++++++++++++++++++++++++++++++++---
>  fs/fat/fat_write.c |  19 ----
>  2 files changed, 205 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index e2570e8167..efbf892c7a 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -44,24 +44,214 @@ static void downcase(char *str, size_t len)
>  
>  static struct blk_desc *cur_dev;
>  static struct disk_partition cur_part_info;
> +static int fat_sect_size;
>  
>  #define DOS_BOOT_MAGIC_OFFSET	0x1fe
>  #define DOS_FS_TYPE_OFFSET	0x36
>  #define DOS_FS32_TYPE_OFFSET	0x52
>  
> -static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
> +inline __u32 sect_to_block(__u32 sect, __u32 *off)
>  {
> -	ulong ret;
> +	*off = 0;
> +	if (fat_sect_size && fat_sect_size < cur_part_info.blksz) {
> +		int div = cur_part_info.blksz / fat_sect_size;
> +
> +		*off = sect % div;
> +		return sect / div;
> +	} else if (fat_sect_size && (fat_sect_size > cur_part_info.blksz)) {
> +		return sect * (fat_sect_size / cur_part_info.blksz);
> +	}
>  
> -	if (!cur_dev)
> -		return -1;
> +	return sect;
> +}
>  
> -	ret = blk_dread(cur_dev, cur_part_info.start + block, nr_blocks, buf);
> +inline __u32 size_to_blocks(__u32 size)
> +{
> +	return (size + (cur_part_info.blksz - 1)) / cur_part_info.blksz;
> +}
>  
> -	if (ret != nr_blocks)
> -		return -1;
> +static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
> +{
> +	int ret;
> +	__u8 *block = NULL;
> +	__u32 rem, size;
> +	__u32 s, n;
>  
> -	return ret;
> +	rem = nr_sect * fat_sect_size;
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
> +		block = malloc_cache_aligned(cur_dev->blksz);
> +		if (!block) {
> +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> +			return -1;
> +		}
> +
> +		s = sect_to_block(sect, &offset);
> +		offset = offset * fat_sect_size;
> +
> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret != 1) {
> +			ret = -1;
> +			goto exit;
> +		}
> +
> +		if (rem > (cur_part_info.blksz - offset))
> +			size = cur_part_info.blksz - offset;
> +		else
> +			size = rem;
> +
> +		memcpy(buf, block + offset, size);
> +		rem -= size;
> +		buf += size;
> +		s++;
> +	} else {
> +		/*
> +		 * fat_sect_size not being set implies, this is the first read
> +		 * to partition. The first sector is being read to get the
> +		 * FS meta data. The FAT sector size is got from this meta data.
> +		 */
> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
> +		if (ret != 1)
> +			return -1;
> +	}
> +
> +	/* Do part 2, read directly into the given buffer */
> +	if (rem > cur_part_info.blksz) {
> +		n = rem / cur_part_info.blksz;
> +		ret = blk_dread(cur_dev, cur_part_info.start + s, n, buf);
> +		if (ret != n) {
> +			ret = -1;
> +			goto exit;
> +		}
> +		buf += n * cur_part_info.blksz;
> +		rem = rem % cur_part_info.blksz;
> +		s += n;
> +	}
> +
> +	/* Do part 3, read a block and copy the trailing sectors */
> +	if (rem) {
> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret != 1) {
> +			ret = -1;
> +			goto exit;
> +		} else {
> +			memcpy(buf, block, rem);
> +		}
> +	}
> +exit:
> +	if (block)
> +		free(block);
> +
> +	return (ret == -1) ? -1 : nr_sect;
> +}
> +
> +int disk_write(__u32 sect, __u32 nr_sect, void *buf)
> +{
> +	int ret;
> +	__u8 *block = NULL;
> +	__u32 rem, size;
> +	__u32 s, n;
> +
> +	rem = nr_sect * fat_sect_size;
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
> +		block = malloc_cache_aligned(cur_dev->blksz);
> +		if (!block) {
> +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> +			return -1;
> +		}
> +
> +		s = sect_to_block(sect, &offset);
> +		offset = offset * fat_sect_size;
> +
> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret != 1) {
> +			ret = -1;
> +			goto exit;
> +		}
> +
> +		if (rem > (cur_part_info.blksz - offset))
> +			size = cur_part_info.blksz - offset;
> +		else
> +			size = rem;
> +
> +		memcpy(block + offset, buf, size);
> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret != 1) {
> +			ret = -1;
> +			goto exit;
> +		}
> +
> +		rem -= size;
> +		buf += size;
> +		s++;
> +	}
> +
> +	/* Do part 2, write directly from the given buffer */
> +	if (rem > cur_part_info.blksz) {
> +		n = rem / cur_part_info.blksz;
> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, n, buf);
> +		if (ret != n) {
> +			ret = -1;
> +			goto exit;
> +		}
> +		buf += n * cur_part_info.blksz;
> +		rem = rem % cur_part_info.blksz;
> +		s += n;
> +	}
> +
> +	/* Do part 3, read a block and copy the trailing sectors */
> +	if (rem) {
> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret != 1) {
> +			ret = -1;
> +			goto exit;
> +		} else {
> +			memcpy(block, buf, rem);
> +		}
> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> +		if (ret != 1) {
> +			ret = -1;
> +			goto exit;
> +		}
> +	}
> +exit:
> +	if (block)
> +		free(block);
> +
> +	return (ret == -1) ? -1 : nr_sect;
>  }
>  
>  int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
> @@ -575,6 +765,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
>  		return -1;
>  	}
>  
> +	fat_sect_size = 0;
> +
>  	if (disk_read(0, 1, block) < 0) {
>  		debug("Error: reading block\n");
>  		ret = -1;
> @@ -645,12 +837,12 @@ static int get_fs_info(fsdata *mydata)
>  	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
>  
>  	mydata->sect_size = get_unaligned_le16(bs.sector_size);
> +	fat_sect_size = mydata->sect_size;
>  	mydata->clust_size = bs.cluster_size;
> -	if (mydata->sect_size != cur_part_info.blksz) {
> -		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
> -			mydata->sect_size, cur_part_info.blksz);
> -		return -1;
> -	}
> +	if (mydata->sect_size != cur_part_info.blksz)
> +		log_info("FAT sector size mismatch (fs=%u, dev=%lu)\n",
> +			 mydata->sect_size, cur_part_info.blksz);
> +
>  	if (mydata->clust_size == 0) {
>  		log_err("FAT cluster size not set\n");
>  		return -1;
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index ea877ee917..f7a210d790 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -192,25 +192,6 @@ out:
>  }
>  
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
> -	ret = blk_dwrite(cur_dev, cur_part_info.start + block, nr_blocks, buf);
> -	if (nr_blocks && ret == 0)
> -		return -1;
> -
> -	return ret;
> -}
>  
>  /*
>   * Write fat buffer into block device

-- 
// Caleb (they/them)

