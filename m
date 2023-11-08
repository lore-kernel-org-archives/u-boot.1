Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40039C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 18:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E618710F;
	Wed,  8 Nov 2023 19:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Br91y/So";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D4D87108; Wed,  8 Nov 2023 19:57:34 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992BB8714A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 19:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a86b6391e9so594647b3.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 10:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699469850; x=1700074650; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnYU2zC3dEJin3gVw0RZAn11YpV90RCvxp+J8FJfxiM=;
 b=Br91y/SoWwyr5vKQhy0pPjUuG+cbzvPnLzdXyQ4Da321fdp8ROALNu7fC1oWiGgOU7
 MjVU1giIEUjcpNkfkMUMJSb5AOTcPta9htdyBzUJNmzdG6yy84Kc0GOEm+yrz9kNdjWk
 DB2TpwjU9HavYn5BSg3JbXL+ZqclEXSNARa5vNHYJh7rAepl0p5zUdAci2tD9BrGu7uo
 yeHbeFOxuIMxOeuLMGylDDY5kIUFSWW0xsu0UqsDU9qUIO7vjxA8DcmGfBFnGTcfLYOp
 y/jxjCu9zxqYbEX8xclQAxc1A3QB/hH8B276Dia9RR1OAsN5BcXbSQZ+MCSZsDq34Jmd
 1XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699469850; x=1700074650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnYU2zC3dEJin3gVw0RZAn11YpV90RCvxp+J8FJfxiM=;
 b=iGWBhyUG/wM8vnf2KYNtQF0C+yYyrF1h/sTrLGe2j6DW+l8gqsWIUrvkOs2NwLwyKT
 aXlZmjJA1Q3K8uEVX5zRJUVeeQ5EYj4FsU7GqWu/Sm0nQiPD7gbDi3ucyvanj7eqJ7d5
 2jbR5ODeRlGnlWfa0bwpjIB29ldNiMb7EG7pSdf1F6Gzyvqo1PXrSA20mdOdnoC+eguR
 OMP6yKo3P+6x/Dea4/hg6Pm3d+fbaqyYxR1QOzTtEOQf7EtuUZjbvnz7WdkmhjDrCYmA
 vjuaZp4/P1PKTKQwkBoOd+MVq1cG97Knn7ubeML+faW1omGPkwTyBPKrfPlx43+JSrXJ
 Oc5g==
X-Gm-Message-State: AOJu0YywHpyWbfxzKzXRk3bLIL7tlFT3vWAtHl67LNO9wWP+w5yQJfKj
 NTtetmfDSX0ts2omFti3LuA=
X-Google-Smtp-Source: AGHT+IGw0UnnduvNtNP7kQ59czkjTLhf50CLYUDXTtHe7xDfgHfhzCtC+5V84ONggVfg/Yd0zsQ/2w==
X-Received: by 2002:a0d:f1c5:0:b0:583:741c:5fe6 with SMTP id
 a188-20020a0df1c5000000b00583741c5fe6mr2081495ywf.52.1699469850149; 
 Wed, 08 Nov 2023 10:57:30 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 q3-20020a056214018300b0065b260eafd9sm1351721qvr.87.2023.11.08.10.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 10:57:29 -0800 (PST)
Message-ID: <a3781a24-2f1f-ca7b-9c7a-d2c4bd071a6a@gmail.com>
Date: Wed, 8 Nov 2023 13:57:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] fs: fat: calculate FAT type based on cluster count
Content-Language: en-US
To: christian.taedcke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
 <20231108121239.26737-3-christian.taedcke-oss@weidmueller.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231108121239.26737-3-christian.taedcke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/8/23 07:12, christian.taedcke-oss@weidmueller.com wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> This fixes an issue where the FAT type (FAT12, FAT16) is not
> correctly detected, e.g. when the BPB field BS_FilSysType contains the
> valid value "FAT     ".
> 
> According to the FAT spec the field BS_FilSysType has only
> informational character and does not determine the FAT type.
> 
> The logic of this code is based on the linux kernel implementation
> from the file fs/fat/inode.c function fat_fill_super().
> 
> For details about FAT see http://elm-chan.org/docs/fat_e.html
> 
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>

Have you run bloat-o-meter on this? FAT is used in SPL a lot.

Would it be possible to write a test for this, especially for a FAT12 filesystem with
4084 data sectors and a FAT16 filesystem with 4085?

> ---
> 
>   fs/fat/fat.c             | 58 +++++++++++++++++++++++-----------------
>   include/fat.h            |  6 -----
>   test/image/spl_load_fs.c |  2 +-
>   3 files changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 8a0f4e4e6c..9179257ff2 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -27,6 +27,9 @@
>   
>   #define FATU8ARRAY2CPU16(x) (((x)[1] << 8) + (x)[0])
>   
> +/* maximum number of clusters for FAT12 */
> +#define MAX_FAT12	0xFF4
> +
>   /*
>    * Convert a string to lowercase.  Converts at most 'len' characters,
>    * 'len' may be larger than the length of 'str' if 'str' is NULL
> @@ -485,6 +488,32 @@ static __u8 mkcksum(struct nameext *nameext)
>   	return ret;
>   }
>   
> +/*
> + * Determine the FAT type
> + *
> + * Based on fat_fill_super() from the Linux kernel's fs/fat/inode.c
> + */
> +static int
> +determine_fat_bits(const boot_sector *bs)
> +{
> +	if (!bs->fat_length && bs->fat32_length) {
> +		return 32;
> +	} else {
> +		u16 fat_start = bs->reserved;
> +		u32 dir_start = fat_start + bs->fats * bs->fat_length;
> +		u32 rootdir_sectors = FATU8ARRAY2CPU16(bs->dir_entries) *
> +				      sizeof(dir_entry) /
> +				      FATU8ARRAY2CPU16(bs->sector_size);

Note that technically we are supposed to round up.

> +		u32 data_start = dir_start + rootdir_sectors;
> +		u16 sectors = FATU8ARRAY2CPU16(bs->sectors);
> +		u32 total_sectors = sectors ? sectors : bs->total_sect;
> +		u32 total_clusters = (total_sectors - data_start) /
> +				     bs->cluster_size;
> +
> +		return (total_clusters > MAX_FAT12) ? 16 : 12;
> +	}
> +}
> +

This should be merged with...

>   /*
>    * Read boot sector and volume info from a FAT filesystem
>    */
> @@ -493,7 +522,6 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
>   {
>   	__u8 *block;
>   	volume_info *vistart;
> -	int ret = 0;
>   
>   	if (cur_dev == NULL) {
>   		debug("Error: no device selected\n");
> @@ -508,7 +536,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
>   
>   	if (disk_read(0, 1, block) < 0) {
>   		debug("Error: reading block\n");
> -		goto fail;
> +		free(block);
> +		return -1;
>   	}
>   
>   	memcpy(bs, block, sizeof(boot_sector));
> @@ -527,33 +556,15 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
>   		bs->info_sector = FAT2CPU16(bs->info_sector);
>   		bs->backup_boot = FAT2CPU16(bs->backup_boot);
>   		vistart = (volume_info *)(block + sizeof(boot_sector));
> -		*fatsize = 32;
>   	} else {
>   		vistart = (volume_info *)&(bs->fat32_length);
> -		*fatsize = 0;
>   	}

... these if statements (above)

>   	memcpy(volinfo, vistart, sizeof(volume_info));
>   
> -	if (*fatsize == 32) {
> -		if (strncmp(FAT32_SIGN, vistart->fs_type, SIGNLEN) == 0)
> -			goto exit;
> -	} else {
> -		if (strncmp(FAT12_SIGN, vistart->fs_type, SIGNLEN) == 0) {
> -			*fatsize = 12;
> -			goto exit;
> -		}
> -		if (strncmp(FAT16_SIGN, vistart->fs_type, SIGNLEN) == 0) {
> -			*fatsize = 16;
> -			goto exit;
> -		}
> -	}

I think we should still verify these as long as vistart->ext_boot_sign is 0x29.

--Sean

> +	*fatsize = determine_fat_bits(bs);
>   
> -	debug("Error: broken fs_type sign\n");
> -fail:
> -	ret = -1;
> -exit:
>   	free(block);
> -	return ret;
> +	return 0;
>   }
>   
>   static int get_fs_info(fsdata *mydata)
> @@ -1158,9 +1169,8 @@ int file_fat_detectfs(void)
>   
>   	memcpy(vol_label, volinfo.volume_label, 11);
>   	vol_label[11] = '\0';
> -	volinfo.fs_type[5] = '\0';
>   
> -	printf("Filesystem: %s \"%s\"\n", volinfo.fs_type, vol_label);
> +	printf("Filesystem: FAT%d \"%s\"\n", fatsize, vol_label);
>   
>   	return 0;
>   }
> diff --git a/include/fat.h b/include/fat.h
> index a9756fb4cd..3dce99a23c 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -34,12 +34,6 @@ struct disk_partition;
>   /* Maximum number of entry for long file name according to spec */
>   #define MAX_LFN_SLOT	20
>   
> -/* Filesystem identifiers */
> -#define FAT12_SIGN	"FAT12   "
> -#define FAT16_SIGN	"FAT16   "
> -#define FAT32_SIGN	"FAT32   "
> -#define SIGNLEN		8
> -
>   /* File attributes */
>   #define ATTR_RO	1
>   #define ATTR_HIDDEN	2
> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
> index 297ab08a82..90e640b5de 100644
> --- a/test/image/spl_load_fs.c
> +++ b/test/image/spl_load_fs.c
> @@ -220,7 +220,7 @@ static size_t create_fat(void *dst, size_t size, const char *filename,
>   	bs->root_cluster = cpu_to_le32(root_sector);
>   
>   	vi->ext_boot_sign = 0x29;
> -	memcpy(vi->fs_type, FAT32_SIGN, sizeof(vi->fs_type));
> +	memcpy(vi->fs_type, "FAT32   ", sizeof(vi->fs_type));
>   
>   	memcpy(dst + 0x1fe, "\x55\xAA", 2);
>   

--Sean
