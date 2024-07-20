Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBD6C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651C1887F6;
	Sat, 20 Jul 2024 17:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VgKxDTcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50FB88814; Sat, 20 Jul 2024 17:58:45 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D44C88578
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-79f178e62d1so171413385a.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721491122; x=1722095922; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7pY9qByisOAa0FTWY/2NFGiXqgyEdTrNNXKdUkYE7zY=;
 b=VgKxDTcHekLHsMSQx60KUDinpGSNpI1V9+YbmLvmzd0mcKKnj1gcXGfwgtHXuO2H3k
 PhVDMkgEnwUyKZH1Z5GyZZfVielU7xPeRmkwxnW/KPC3KKkdXwOpL6B/LUqzL1n993UE
 reVHkS0gI1JDvAPgHv8ReDV5ZEU+W+X5Q57Ku0Z7b1zykwzH6kRV+RI+ga7ziP3QMTqA
 L1VpBckKXrLhH09Tt4Kb2tvHYbVBWYeVltQoM5w7jUb23YTKDNNl3AsGY3eIS3Ek/jW7
 +wizZkF/4xja4I8YmgAtTZ5d69dbQsqKQPDO8nPWu1E22sdi4kZU87TPTsUjYyUvkAdi
 +y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721491122; x=1722095922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7pY9qByisOAa0FTWY/2NFGiXqgyEdTrNNXKdUkYE7zY=;
 b=pssKBanfoZHrxUQ72YX9OGdjSiB03VYnPBbLlQlWyyuSlHR6aq2I78BzIXl4gbtZP7
 xRX04wid+CFVNh9kUVspfLlkw6Azk8w2RPe/UGhdMUfm+fNIoSpMxn0wNnYDCKfBmJoH
 7V1rzGzMKbcH1gEh0DVTjO8uv0/WsxG6/A3tu7FMSpzAushkV3OAwUm2rlpyjP2poQBN
 1JUaPGeYklnSYJurYXqBIsFFaVG0YyUq6FCy2u3KIR/6BbGemcETPgV3/gWX4+p2WKqB
 TbAu72JdY2OsILgui1Z9yihXYgnhBXdxjDR83DwGTy3EzYAPHDNOUF5IqyqschYu7P+4
 yXCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4mPtWBo4mXpKY47pCFfD1dxFNXBfUfEVOGRHO4VWgpGx9CefEAEZnNXBBqBwOgGuMSrAO4MgRirfh8LdFjk3PDQwkdg==
X-Gm-Message-State: AOJu0Yyw4bjClxUF80qfcu9DI4ru26VmH9fZIZpDKDdZU/CvYOGfX6Bu
 jSUmy4v9W4ML5P287yd088WaGf/Idsq5H0ePZMP0PhS7YtdpPwh4/5QipQ==
X-Google-Smtp-Source: AGHT+IHrrsCDBrbb+7HWJ11FQOAQLuNe2AMLGJ4oqGG6EWdgyTpkDIKyX78QxHioKaz5ao8u2p0JGw==
X-Received: by 2002:a05:620a:2a0e:b0:79f:753:b7c9 with SMTP id
 af79cd13be357-7a1a130b1abmr473562785a.13.1721491122151; 
 Sat, 20 Jul 2024 08:58:42 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fab076sm196686685a.22.2024.07.20.08.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:58:41 -0700 (PDT)
Message-ID: <b6bd4451-9893-77e1-e293-f6aad2cf1295@gmail.com>
Date: Sat, 20 Jul 2024 11:58:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/14] spl: mmc: Handle error codes consistently
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-10-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-10-sjg@chromium.org>
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

On 7/20/24 02:17, Simon Glass wrote:
> Use 'ret' as the return code, since it may not be an error and this is
> the common name in U-Boot. Make sure to return the error code when
> given, rather than transforming it into -1 (-EPERM).

Does this transformation affect code size?

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/spl/spl_mmc.c | 129 ++++++++++++++++++++++---------------------
>   1 file changed, 65 insertions(+), 64 deletions(-)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index ddc85aaeda7..70e376c0ed8 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -52,7 +52,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>   	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>   	if (ret) {
>   		puts("mmc_load_image_raw_sector: mmc block read error\n");
> -		return -1;
> +		return ret;
>   	}
>   
>   	return 0;
> @@ -75,27 +75,27 @@ static int spl_mmc_get_device_index(u32 boot_device)
>   
>   static int spl_mmc_find_device(struct mmc **mmcp, u32 boot_device)
>   {
> -	int err, mmc_dev;
> +	int ret, mmc_dev;
>   
>   	mmc_dev = spl_mmc_get_device_index(boot_device);
>   	if (mmc_dev < 0)
>   		return mmc_dev;
>   
>   #if CONFIG_IS_ENABLED(DM_MMC)
> -	err = mmc_init_device(mmc_dev);
> +	ret = mmc_init_device(mmc_dev);
>   #else
> -	err = mmc_initialize(NULL);
> +	ret = mmc_initialize(NULL);
>   #endif /* DM_MMC */
> -	if (err) {
> -		printf("spl: could not initialize mmc. error: %d\n", err);
> -		return err;
> +	if (ret) {
> +		printf("spl: could not initialize mmc. error: %d\n", ret);
> +		return ret;
>   	}
>   	*mmcp = find_mmc_device(mmc_dev);
> -	err = *mmcp ? 0 : -ENODEV;
> -	if (err) {
> +	ret = *mmcp ? 0 : -ENODEV;
> +	if (ret) {
>   		printf("spl: could not find mmc device %d. error: %d\n",
> -		       mmc_dev, err);
> -		return err;
> +		       mmc_dev, ret);
> +		return ret;
>   	}
>   
>   	return 0;
> @@ -108,14 +108,14 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>   					unsigned long sector)
>   {
>   	struct disk_partition info;
> -	int err;
> +	int ret;
>   
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>   	int type_part;
>   	/* Only support MBR so DOS_ENTRY_NUMBERS */
>   	for (type_part = 1; type_part <= DOS_ENTRY_NUMBERS; type_part++) {
> -		err = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
> -		if (err)
> +		ret = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
> +		if (ret)
>   			continue;
>   		if (info.sys_ind ==
>   			CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE) {
> @@ -125,10 +125,10 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>   	}
>   #endif
>   
> -	err = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
> -	if (err) {
> +	ret = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
> +	if (ret) {
>   		puts("spl: partition error\n");
> -		return -err;
> +		return ret;
>   	}
>   
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> @@ -155,7 +155,7 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
>   		(void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
>   	if (count != CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS) {
>   		puts("mmc_load_image_raw_os: mmc block read error\n");
> -		return -1;
> +		return -EIO;
>   	}
>   #endif	/* CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR */
>   
> @@ -193,7 +193,7 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
>   			      struct mmc *mmc,
>   			      const char *filename)
>   {
> -	int err = -ENOSYS;
> +	int ret = -ENOSYS;
>   
>   	__maybe_unused int partition = CONFIG_SYS_MMCSD_FS_BOOT_PARTITION;
>   
> @@ -202,8 +202,8 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
>   		struct disk_partition info;
>   		debug("Checking for the first MBR bootable partition\n");
>   		for (int type_part = 1; type_part <= DOS_ENTRY_NUMBERS; type_part++) {
> -			err = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
> -			if (err)
> +			ret = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
> +			if (ret)
>   				continue;
>   			debug("Partition %d is of type %d and bootable=%d\n", type_part, info.sys_ind, info.bootable);
>   			if (info.bootable != 0) {
> @@ -221,40 +221,40 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
>   
>   #ifdef CONFIG_SPL_FS_FAT
>   	if (!spl_start_uboot()) {
> -		err = spl_load_image_fat_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
> -			partition);
> -		if (!err)
> -			return err;
> +		ret = spl_load_image_fat_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
> +					    partition);
> +		if (!ret)
> +			return ret;

Should be return 0 for clarity. And the same for the other instances of this pattern.

>   	}
>   #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> -	err = spl_load_image_fat(spl_image, bootdev, mmc_get_blk_desc(mmc),
> +	ret = spl_load_image_fat(spl_image, bootdev, mmc_get_blk_desc(mmc),
>   				 partition,
>   				 filename);
> -	if (!err)
> -		return err;
> +	if (!ret)
> +		return ret;
>   #endif
>   #endif
>   #ifdef CONFIG_SPL_FS_EXT4
>   	if (!spl_start_uboot()) {
> -		err = spl_load_image_ext_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
> -			partition);
> -		if (!err)
> -			return err;
> +		ret = spl_load_image_ext_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
> +					    partition);
> +		if (!ret)
> +			return ret;
>   	}
>   #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> -	err = spl_load_image_ext(spl_image, bootdev, mmc_get_blk_desc(mmc),
> +	ret = spl_load_image_ext(spl_image, bootdev, mmc_get_blk_desc(mmc),
>   				 partition,
>   				 filename);
> -	if (!err)
> -		return err;
> +	if (!ret)
> +		return ret;
>   #endif
>   #endif
>   
>   #if defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
> -	err = -ENOENT;
> +	ret = -ENOENT;
>   #endif
>   
> -	return err;
> +	return ret;
>   }
>   #endif
>   
> @@ -342,73 +342,74 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   		 unsigned long raw_sect)
>   {
>   	u32 boot_mode;
> -	int err = 0;
> +	int ret = 0;
>   	__maybe_unused int part = 0;
>   	int mmc_dev;
>   
>   	/* Perform peripheral init only once for an mmc device */
>   	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
>   	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
> -		err = spl_mmc_find_device(&mmc, bootdev->boot_device);
> -		if (err)
> -			return err;
> +		ret = spl_mmc_find_device(&mmc, bootdev->boot_device);
> +		if (ret)
> +			return ret;
>   
> -		err = mmc_init(mmc);
> -		if (err) {
> +		ret = mmc_init(mmc);
> +		if (ret) {
>   			mmc = NULL;
> -			printf("spl: mmc init failed with error: %d\n", err);
> -			return err;
> +			printf("spl: mmc init failed with error: %d\n", ret);
> +			return ret;
>   		}
>   	}
>   
>   	boot_mode = spl_mmc_boot_mode(mmc, bootdev->boot_device);
> -	err = -EINVAL;
> +	ret = -EINVAL;
>   	switch (boot_mode) {
>   	case MMCSD_MODE_EMMCBOOT:
>   		part = spl_mmc_emmc_boot_partition(mmc);
>   
>   		if (CONFIG_IS_ENABLED(MMC_TINY))
> -			err = mmc_switch_part(mmc, part);
> +			ret = mmc_switch_part(mmc, part);
>   		else
> -			err = blk_dselect_hwpart(mmc_get_blk_desc(mmc), part);
> +			ret = blk_dselect_hwpart(mmc_get_blk_desc(mmc), part);
>   
> -		if (err) {
> +		if (ret) {
>   			puts("spl: mmc partition switch failed\n");
> -			return err;
> +			return ret;
>   		}
>   		/* Fall through */
>   	case MMCSD_MODE_RAW:
>   		debug("spl: mmc boot mode: raw\n");
>   
>   		if (!spl_start_uboot()) {
> -			err = mmc_load_image_raw_os(spl_image, bootdev, mmc);
> -			if (!err)
> -				return err;
> +			ret = mmc_load_image_raw_os(spl_image, bootdev, mmc);
> +			if (!ret)
> +				return ret;
>   		}
>   
>   		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>   
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> -		err = mmc_load_image_raw_partition(spl_image, bootdev,
> +		ret = mmc_load_image_raw_partition(spl_image, bootdev,
>   						   mmc, raw_part,
>   						   raw_sect);
> -		if (!err)
> -			return err;
> +		if (!ret)
> +			return ret;
>   #endif
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> -		err = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
> -				raw_sect + spl_mmc_raw_uboot_offset(part));
> -		if (!err)
> -			return err;
> +		ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
> +						raw_sect +
> +						spl_mmc_raw_uboot_offset(part));
> +		if (!ret)
> +			return ret;
>   #endif
>   		/* If RAW mode fails, try FS mode. */
>   #ifdef CONFIG_SYS_MMCSD_FS_BOOT
>   	case MMCSD_MODE_FS:
>   		debug("spl: mmc boot mode: fs\n");
>   
> -		err = spl_mmc_do_fs_boot(spl_image, bootdev, mmc, filename);
> -		if (!err)
> -			return err;
> +		ret = spl_mmc_do_fs_boot(spl_image, bootdev, mmc, filename);
> +		if (!ret)
> +			return ret;
>   
>   		break;
>   #endif
> @@ -416,7 +417,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   		puts("spl: mmc: wrong boot mode\n");
>   	}
>   
> -	return err;
> +	return ret;
>   }
>   
>   int spl_mmc_load_image(struct spl_image_info *spl_image,

