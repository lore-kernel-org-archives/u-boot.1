Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2FBC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF8D88122;
	Fri,  5 Apr 2024 10:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nl1Ziey8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F2A88432; Fri,  5 Apr 2024 10:05:08 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0BD87EBD
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-415523d9824so19224595e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712304305; x=1712909105;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=C6ov5uYJgD1UD1YYevfoPhMnvkDHqnItJx8IB88ap8o=;
 b=Nl1Ziey8RJ/MvicyB69a7IAU77l45Zagtyh/32oacdMeUEZgLGGJCEB9ZD60qsInSP
 q2d8jiMVHLFhYMl2zvOqLYevC5/MpB7ClfHTJO05CerloTNgzu0KyYdGrRLsRn3nE77q
 MZmyHtzm6MW2BOc0zhaPIxlRyXz3P6TH0BJYomtF36m10V4k0S5zwA4D6YW7pdgg2BUn
 Ozs/FMzUM2P5eCHjBQkmQudpjKhZsHDWO6zx7/RWzRO2K+4uoeAMwGr85Ksf21pSwAQ5
 LlYAMUJzk7QXoKtqMC7hAeIXw/EKipM71YdToDQXeZCiWYCwnjIDfk+zDMdHRhNktA+Z
 OLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712304305; x=1712909105;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C6ov5uYJgD1UD1YYevfoPhMnvkDHqnItJx8IB88ap8o=;
 b=M6xe7GyOt3mV2HDRrIIalfmzWf431+8fVh1ehHWXVjS2VZhxgRhVvWZVjcWnjGi5+9
 FKYCh8l8JdSwQWqK2LdIgclxQOxrG+Pf32yDRRRCq5U1EdgRl8dpR/HJZInZAFR65HUe
 pzPA9VP9QQ3RzQ6laCBfftjOcxkxkPLnv9FI7I1k4q4Z4cL07NLYM7vypPvFY/5QuoQ7
 YPSFya/ao3tG9zB09DjwgR0HTvx/C+F7+ebYYMir7QAKE0jKkMLNPQUr96LH98bSvI5g
 3WS40dEYBy9FT6oyU+eY58SYnxN+sXhoGnBLysuYmrik9LIV8DEfjmloEMsc2KqbLEJj
 Zy4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgkI1fQuqP9Yqv7x6tl4WBBUobk7CjdeXtEg9yMSrYkCq9UMNtqayB7i5ZxKVH0YiCFQapDsZK7YFRX25VOzLDFlLEhw==
X-Gm-Message-State: AOJu0YzU0XBZYVqc11yjL2nRFq/cE83v8W6xwwVjd3vuw0w4RsCoQ3ML
 IExmMWLLg0abgB6LACsdARsFER80tUBHWAeVnTaPpQWyNSZPXx+wDFgaOwuj8Ak=
X-Google-Smtp-Source: AGHT+IFIgnWyfmDvPN+KMDiDFBvcI57EPU6oAHpPxHppuSd15Sbd8cWfxucUrykwt12WyPWxFG/dnQ==
X-Received: by 2002:a05:600c:1d25:b0:413:f4d1:199e with SMTP id
 l37-20020a05600c1d2500b00413f4d1199emr714080wms.31.1712304305239; 
 Fri, 05 Apr 2024 01:05:05 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 hn3-20020a05600ca38300b004162b578d8bsm1982317wmb.1.2024.04.05.01.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:05:04 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Alex
 Kiernan <alex.kiernan@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Ying-Chun
 Liu <paul.liu@linaro.org>
Subject: Re: [PATCH 3/4] fastboot: blk: introduce fastboot block flashing
 support
In-Reply-To: <20240306185921.1854109-3-dimorinny@google.com>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-3-dimorinny@google.com>
Date: Fri, 05 Apr 2024 10:05:04 +0200
Message-ID: <87r0fkfd5b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitrii,

Thank you for the patch and sorry for the review delay.

On mer., mars 06, 2024 at 18:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Reuse common logic between existing mmc and new introduced
> block implementation
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Alex Kiernan <alex.kiernan@gmail.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>

This change (when applied along with 1/4 and 2/4) introduces a build for
sandbox:

$ make sandbox_defconfig
$ make

[...]

drivers/fastboot/fb_mmc.c: In function 'fastboot_mmc_erase':
drivers/fastboot/fb_mmc.c:596:16: warning: implicit declaration of function 'fb_block_write'; did you mean 'blk_write'? [-Wimplicit-function-declaration]
  596 |         blks = fb_block_write(dev_desc, blks_start, blks_size, NULL);
      |                ^~~~~~~~~~~~~~
      |                blk_write

[...]

LTO     u-boot
/usr/bin/ld: /tmp/cczd5cS1.ltrans18.ltrans.o: in function `erase.lto_priv.0':
/mnt/work/upstream/u-boot/drivers/fastboot/fb_mmc.c:596: undefined reference to `fb_block_write'
collect2: error: ld returned 1 exit status
make: *** [Makefile:1798: u-boot] Error 1


> ---
>  drivers/fastboot/Makefile   |   4 +-
>  drivers/fastboot/fb_block.c | 200 ++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_mmc.c   | 120 ++--------------------
>  include/fb_block.h          |  70 +++++++++++++
>  4 files changed, 281 insertions(+), 113 deletions(-)
>  create mode 100644 drivers/fastboot/fb_block.c
>  create mode 100644 include/fb_block.h
>
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index 048af5aa82..91e98763e8 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -3,5 +3,7 @@
>  obj-y += fb_common.o
>  obj-y += fb_getvar.o
>  obj-y += fb_command.o
> -obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
> +obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
> +# MMC reuses block implementation
> +obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
>  obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> new file mode 100644
> index 0000000000..908decd544
> --- /dev/null
> +++ b/drivers/fastboot/fb_block.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +/*
> + * Copyright (C) 2024 The Android Open Source Project
> + */
> +
> +#include <blk.h>
> +#include <div64.h>
> +#include <fastboot-internal.h>
> +#include <fastboot.h>
> +#include <fb_block.h>
> +#include <image-sparse.h>
> +#include <part.h>
> +
> +/**
> + * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
> + *
> + * in the ERASE case we can have much larger buffer size since
> + * we're not transferring an actual buffer
> + */
> +#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
> +/**
> + * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
> + */
> +#define FASTBOOT_MAX_BLOCKS_WRITE 65536
> +
> +struct fb_block_sparse {
> +	struct blk_desc	*dev_desc;
> +};
> +
> +static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t start,
> +			       lbaint_t blkcnt, const void *buffer)
> +{
> +	lbaint_t blk = start;
> +	lbaint_t blks_written = 0;
> +	lbaint_t cur_blkcnt = 0;
> +	lbaint_t blks = 0;
> +	int step = buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_ERASE;
> +	int i;
> +
> +	for (i = 0; i < blkcnt; i += step) {
> +		cur_blkcnt = min((int)blkcnt - i, step);
> +		if (buffer) {
> +			if (fastboot_progress_callback)
> +				fastboot_progress_callback("writing");
> +			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
> +						  buffer + (i * block_dev->blksz));
> +		} else {
> +			if (fastboot_progress_callback)
> +				fastboot_progress_callback("erasing");
> +			blks_written = blk_derase(block_dev, blk, cur_blkcnt);
> +		}
> +		blk += blks_written;
> +		blks += blks_written;
> +	}
> +	return blks;
> +}
> +
> +static lbaint_t fb_block_sparse_write(struct sparse_storage *info,
> +				      lbaint_t blk, lbaint_t blkcnt,
> +				      const void *buffer)
> +{
> +	struct fb_block_sparse *sparse = info->priv;
> +	struct blk_desc *dev_desc = sparse->dev_desc;
> +
> +	return fb_block_write(dev_desc, blk, blkcnt, buffer);
> +}
> +
> +static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
> +					lbaint_t blk, lbaint_t blkcnt)
> +{
> +	return blkcnt;
> +}
> +
> +int fastboot_block_get_part_info(const char *part_name,
> +				 struct blk_desc **dev_desc,
> +				 struct disk_partition *part_info,
> +				 char *response)
> +{
> +	int ret;
> +	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> +						   NULL);
> +	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +
> +	if (!part_name || !strcmp(part_name, "")) {
> +		fastboot_fail("partition not given", response);
> +		return -ENOENT;
> +	}
> +	if (!interface || !strcmp(interface, "")) {
> +		fastboot_fail("block interface isn't provided", response);
> +		return -EINVAL;
> +	}
> +
> +	*dev_desc = blk_get_dev(interface, device);
> +	if (!dev_desc) {
> +		fastboot_fail("no such device", response);
> +		return -ENODEV;
> +	}
> +
> +	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
> +	if (ret < 0)
> +		fastboot_fail("failed to get partition info", response);
> +
> +	return ret;
> +}
> +
> +void fastboot_block_erase(const char *part_name, char *response)
> +{
> +	struct blk_desc *dev_desc;
> +	struct disk_partition part_info;
> +	lbaint_t written;
> +
> +	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
> +		return;
> +
> +	written = fb_block_write(dev_desc, part_info.start, part_info.size, NULL);
> +	if (written != part_info.size) {
> +		fastboot_fail("failed to erase partition", response);
> +		return;
> +	}
> +
> +	fastboot_okay(NULL, response);
> +}
> +
> +void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
> +				    struct disk_partition *info, const char *part_name,
> +				    void *buffer, u32 download_bytes, char *response)
> +{
> +	lbaint_t blkcnt;
> +	lbaint_t blks;
> +
> +	/* determine number of blocks to write */
> +	blkcnt = ((download_bytes + (info->blksz - 1)) & ~(info->blksz - 1));
> +	blkcnt = lldiv(blkcnt, info->blksz);
> +
> +	if (blkcnt > info->size) {
> +		pr_err("too large for partition: '%s'\n", part_name);
> +		fastboot_fail("too large for partition", response);
> +		return;
> +	}
> +
> +	puts("Flashing Raw Image\n");
> +
> +	blks = fb_block_write(dev_desc, info->start, blkcnt, buffer);
> +
> +	if (blks != blkcnt) {
> +		pr_err("failed writing to device %d\n", dev_desc->devnum);
> +		fastboot_fail("failed writing to device", response);
> +		return;
> +	}
> +
> +	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * info->blksz,
> +	       part_name);
> +	fastboot_okay(NULL, response);
> +}
> +
> +void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
> +				       const char *part_name, void *buffer, char *response)
> +{
> +	struct fb_block_sparse sparse_priv;
> +	struct sparse_storage sparse;
> +	int err;
> +
> +	sparse_priv.dev_desc = dev_desc;
> +
> +	sparse.blksz = info->blksz;
> +	sparse.start = info->start;
> +	sparse.size = info->size;
> +	sparse.write = fb_block_sparse_write;
> +	sparse.reserve = fb_block_sparse_reserve;
> +	sparse.mssg = fastboot_fail;
> +
> +	printf("Flashing sparse image at offset " LBAFU "\n",
> +	       sparse.start);
> +
> +	sparse.priv = &sparse_priv;
> +	err = write_sparse_image(&sparse, part_name, buffer,
> +				 response);
> +	if (!err)
> +		fastboot_okay(NULL, response);
> +}
> +
> +void fastboot_block_flash_write(const char *part_name, void *download_buffer,
> +				u32 download_bytes, char *response)
> +{
> +	struct blk_desc *dev_desc;
> +	struct disk_partition part_info;
> +
> +	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
> +		return;
> +
> +	if (is_sparse_image(download_buffer)) {
> +		fastboot_block_write_sparse_image(dev_desc, &part_info, part_name,
> +						  download_buffer, response);
> +	} else {
> +		fastboot_block_write_raw_image(dev_desc, &part_info, part_name,
> +					       download_buffer, download_bytes, response);
> +	}
> +}
> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> index 060918e491..7894f01f63 100644
> --- a/drivers/fastboot/fb_mmc.c
> +++ b/drivers/fastboot/fb_mmc.c
> @@ -9,6 +9,7 @@
>  #include <env.h>
>  #include <fastboot.h>
>  #include <fastboot-internal.h>
> +#include <fb_block.h>
>  #include <fb_mmc.h>
>  #include <image-sparse.h>
>  #include <image.h>
> @@ -21,10 +22,6 @@
>  
>  #define BOOT_PARTITION_NAME "boot"
>  
> -struct fb_mmc_sparse {
> -	struct blk_desc	*dev_desc;
> -};
> -
>  static int raw_part_get_info_by_name(struct blk_desc *dev_desc,
>  				     const char *name,
>  				     struct disk_partition *info)
> @@ -115,88 +112,6 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
>  	return do_get_part_info(dev_desc, name, info);
>  }
>  
> -/**
> - * fb_mmc_blk_write() - Write/erase MMC in chunks of FASTBOOT_MAX_BLK_WRITE
> - *
> - * @block_dev: Pointer to block device
> - * @start: First block to write/erase
> - * @blkcnt: Count of blocks
> - * @buffer: Pointer to data buffer for write or NULL for erase
> - */
> -static lbaint_t fb_mmc_blk_write(struct blk_desc *block_dev, lbaint_t start,
> -				 lbaint_t blkcnt, const void *buffer)
> -{
> -	lbaint_t blk = start;
> -	lbaint_t blks_written;
> -	lbaint_t cur_blkcnt;
> -	lbaint_t blks = 0;
> -	int i;
> -
> -	for (i = 0; i < blkcnt; i += FASTBOOT_MAX_BLK_WRITE) {
> -		cur_blkcnt = min((int)blkcnt - i, FASTBOOT_MAX_BLK_WRITE);
> -		if (buffer) {
> -			if (fastboot_progress_callback)
> -				fastboot_progress_callback("writing");
> -			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
> -						  buffer + (i * block_dev->blksz));
> -		} else {
> -			if (fastboot_progress_callback)
> -				fastboot_progress_callback("erasing");
> -			blks_written = blk_derase(block_dev, blk, cur_blkcnt);
> -		}
> -		blk += blks_written;
> -		blks += blks_written;
> -	}
> -	return blks;
> -}
> -
> -static lbaint_t fb_mmc_sparse_write(struct sparse_storage *info,
> -		lbaint_t blk, lbaint_t blkcnt, const void *buffer)
> -{
> -	struct fb_mmc_sparse *sparse = info->priv;
> -	struct blk_desc *dev_desc = sparse->dev_desc;
> -
> -	return fb_mmc_blk_write(dev_desc, blk, blkcnt, buffer);
> -}
> -
> -static lbaint_t fb_mmc_sparse_reserve(struct sparse_storage *info,
> -		lbaint_t blk, lbaint_t blkcnt)
> -{
> -	return blkcnt;
> -}
> -
> -static void write_raw_image(struct blk_desc *dev_desc,
> -			    struct disk_partition *info, const char *part_name,
> -			    void *buffer, u32 download_bytes, char *response)
> -{
> -	lbaint_t blkcnt;
> -	lbaint_t blks;
> -
> -	/* determine number of blocks to write */
> -	blkcnt = ((download_bytes + (info->blksz - 1)) & ~(info->blksz - 1));
> -	blkcnt = lldiv(blkcnt, info->blksz);
> -
> -	if (blkcnt > info->size) {
> -		pr_err("too large for partition: '%s'\n", part_name);
> -		fastboot_fail("too large for partition", response);
> -		return;
> -	}
> -
> -	puts("Flashing Raw Image\n");
> -
> -	blks = fb_mmc_blk_write(dev_desc, info->start, blkcnt, buffer);
> -
> -	if (blks != blkcnt) {
> -		pr_err("failed writing to device %d\n", dev_desc->devnum);
> -		fastboot_fail("failed writing to device", response);
> -		return;
> -	}
> -
> -	printf("........ wrote " LBAFU " bytes to '%s'\n", blkcnt * info->blksz,
> -	       part_name);
> -	fastboot_okay(NULL, response);
> -}
> -
>  #if defined(CONFIG_FASTBOOT_MMC_BOOT_SUPPORT) || \
>  	defined(CONFIG_FASTBOOT_MMC_USER_SUPPORT)
>  static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
> @@ -205,7 +120,7 @@ static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
>  
>  	debug("Start Erasing mmc hwpart[%u]...\n", dev_desc->hwpart);
>  
> -	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL);
> +	blks = fb_block_write(dev_desc, 0, dev_desc->lba, NULL);
>  
>  	if (blks != dev_desc->lba) {
>  		pr_err("Failed to erase mmc hwpart[%u]\n", dev_desc->hwpart);
> @@ -249,7 +164,7 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
>  
>  		debug("Start Flashing Image to EMMC_BOOT%d...\n", hwpart);
>  
> -		blks = fb_mmc_blk_write(dev_desc, 0, blkcnt, buffer);
> +		blks = fb_block_write(dev_desc, 0, blkcnt, buffer);
>  
>  		if (blks != blkcnt) {
>  			pr_err("Failed to write EMMC_BOOT%d\n", hwpart);
> @@ -610,30 +525,11 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
>  		return;
>  
>  	if (is_sparse_image(download_buffer)) {
> -		struct fb_mmc_sparse sparse_priv;
> -		struct sparse_storage sparse;
> -		int err;
> -
> -		sparse_priv.dev_desc = dev_desc;
> -
> -		sparse.blksz = info.blksz;
> -		sparse.start = info.start;
> -		sparse.size = info.size;
> -		sparse.write = fb_mmc_sparse_write;
> -		sparse.reserve = fb_mmc_sparse_reserve;
> -		sparse.mssg = fastboot_fail;
> -
> -		printf("Flashing sparse image at offset " LBAFU "\n",
> -		       sparse.start);
> -
> -		sparse.priv = &sparse_priv;
> -		err = write_sparse_image(&sparse, cmd, download_buffer,
> -					 response);
> -		if (!err)
> -			fastboot_okay(NULL, response);
> +		fastboot_block_write_sparse_image(dev_desc, &info, cmd,
> +						  download_buffer, response);
>  	} else {
> -		write_raw_image(dev_desc, &info, cmd, download_buffer,
> -				download_bytes, response);
> +		fastboot_block_write_raw_image(dev_desc, &info, cmd, download_buffer,
> +					       download_bytes, response);
>  	}
>  }
>  
> @@ -697,7 +593,7 @@ void fastboot_mmc_erase(const char *cmd, char *response)
>  	printf("Erasing blocks " LBAFU " to " LBAFU " due to alignment\n",
>  	       blks_start, blks_start + blks_size);
>  
> -	blks = fb_mmc_blk_write(dev_desc, blks_start, blks_size, NULL);
> +	blks = fb_block_write(dev_desc, blks_start, blks_size, NULL);
>  
>  	if (blks != blks_size) {
>  		pr_err("failed erasing from device %d\n", dev_desc->devnum);
> diff --git a/include/fb_block.h b/include/fb_block.h
> new file mode 100644
> index 0000000000..90208e21a7
> --- /dev/null
> +++ b/include/fb_block.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * Copyright (C) 2024 The Android Open Source Project
> + */
> +
> +#ifndef _FB_BLOCK_H_
> +#define _FB_BLOCK_H_
> +
> +struct blk_desc;
> +struct disk_partition;
> +
> +/**
> + * fastboot_block_get_part_info() - Lookup block partition by name
> + *
> + * @part_name: Named partition to lookup
> + * @dev_desc: Pointer to returned blk_desc pointer
> + * @part_info: Pointer to returned struct disk_partition
> + * @response: Pointer to fastboot response buffer
> + */
> +int fastboot_block_get_part_info(const char *part_name,
> +				 struct blk_desc **dev_desc,
> +				 struct disk_partition *part_info,
> +				 char *response);
> +
> +/**
> + * fastboot_block_erase() - Erase partition on block device for fastboot
> + *
> + * @part_name: Named partition to erase
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_block_erase(const char *part_name, char *response);
> +
> +/**
> + * fastboot_block_write_raw_image() - Write raw image to block device
> + *
> + * @dev_desc: Block device we're going write to
> + * @info: Partition we're going write to
> + * @part_name: Name of partition we're going write to
> + * @buffer: Downloaded buffer pointer
> + * @download_bytes: Size of content on downloaded buffer pointer
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
> +				    struct disk_partition *info, const char *part_name,
> +				    void *buffer, u32 download_bytes, char *response);
> +
> +/**
> + * fastboot_block_write_sparse_image() - Write sparse image to block device
> + *
> + * @dev_desc: Block device we're going write to
> + * @info: Partition we're going write to
> + * @part_name: Name of partition we're going write to
> + * @buffer: Downloaded buffer pointer
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
> +				       const char *part_name, void *buffer, char *response);
> +
> +/**
> + * fastboot_block_flash_write() - Write image to block device for fastboot
> + *
> + * @part_name: Named partition to write image to
> + * @download_buffer: Pointer to image data
> + * @download_bytes: Size of image data
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_block_flash_write(const char *part_name, void *download_buffer,
> +				u32 download_bytes, char *response);
> +
> +#endif // _FB_BLOCK_H_
> -- 
> 2.44.0.278.ge034bb2e1d-goog
