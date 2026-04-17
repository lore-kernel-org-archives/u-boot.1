Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DFDF43685
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 09:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB00841C2;
	Fri, 17 Apr 2026 11:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VAAnhswT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9631E84228; Fri, 17 Apr 2026 11:09:34 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02464841C2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 75D2643288;
 Fri, 17 Apr 2026 09:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8523C19425;
 Fri, 17 Apr 2026 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776416970;
 bh=mKc/+Sqq0v4c3a+6JduOpvCLo6DJTmSCvLLpEqBvIqk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VAAnhswTSk9BL7gbByNJs77f5FW8AkZdZWxDXhV/YTFe8DfrowvQihHdxgmRQDjzz
 qxD0lf6gihDVCSBFCrwigZGIp6PUQCTxBW6kOq4FVnXbkzMtDhnXyLqIbq+tT7JZwJ
 SLg2oycftJ0ybR+iNg/2N6qiUJrXvGOHN3t+LwqXmb2upGCdLgYsQCIwEqHaTfQYVh
 4MlMUu4tEt4qU/JuNQg1dJqOVSWwOGehImuKQaMxHZiXBt4g7koMyam/jXtoCBKasA
 opK6PH6t7+mMFotOIQuxt5PuslPRMnHi1jIKAcDAM+X25GZ1aC4B+Kws8rMTi/4I7g
 8hiVVEa6jURwA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Ariel D'Alessandro
 <ariel.dalessandro@collabora.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Dmitrii Merkurev <dimorinny@google.com>,
 Michael Walle <mwalle@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heiko Schocher <hs@nabladev.com>, Adrian
 Freihofer <adrian.freihofer@siemens.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] fastboot: block: Add GPT/MBR support and device
 selection syntax
In-Reply-To: <20260410-fb_block-v1-1-68f0c976fe0e@oss.qualcomm.com>
References: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
 <20260410-fb_block-v1-1-68f0c976fe0e@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 11:09:27 +0200
Message-ID: <87eckegdh4.fsf@kernel.org>
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

Hi Balaji,

Thank you for the patch.

On Fri, Apr 10, 2026 at 10:12, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> Implement device selection syntax allowing users to specify the
> target block device using "N:partition" format, where N is the
> device number. This enables operations like "fastboot flash 0:gpt"
> to write partition tables to specific devices. When no device is
> specified, the default from CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID
> is used.

This commit is doing 2 things: Adding device selection syntax and
GPT/MBR flashing support

Can we please split this in 2 distinct patches ? device selection in a
first patch , and the GPT/MBR partition table flashing support in a second patch ?

This makes things easier to review.

>
> Example usage for partition flashing:
>   fastboot flash 0:boot boot.img      # Flash to device 0
>   fastboot flash 1:system system.img  # Flash to device 1
>   fastboot flash boot boot.img        # Use default device
>
> Example usage for GPT/MBR operations:
>   fastboot flash 0:gpt gpt.img        # Write GPT to device 0
>   fastboot flash 1:mbr mbr.img        # Write MBR to device 1
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/fastboot/Kconfig    |   4 +-
>  drivers/fastboot/fb_block.c | 196 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 186 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 576c3ef8a45..43d83265df4 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -227,7 +227,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>  
>  config FASTBOOT_GPT_NAME
>  	string "Target name for updating GPT"
> -	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
> +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
>  	default "gpt"
>  	help
>  	  The fastboot "flash" command supports writing the downloaded
> @@ -240,7 +240,7 @@ config FASTBOOT_GPT_NAME
>  
>  config FASTBOOT_MBR_NAME
>  	string "Target name for updating MBR"
> -	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
> +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && DOS_PARTITION
>  	default "mbr"
>  	help
>  	  The fastboot "flash" command allows to write the downloaded image
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> index 51d1abb18c7..c2c3a285d77 100644
> --- a/drivers/fastboot/fb_block.c
> +++ b/drivers/fastboot/fb_block.c
> @@ -11,6 +11,7 @@
>  #include <image-sparse.h>
>  #include <malloc.h>
>  #include <part.h>
> +#include <vsprintf.h>
>  
>  /**
>   * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
> @@ -124,6 +125,79 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
>  	return blkcnt;
>  }
>  
> +/**
> + * parse_device_partition() - Parse device:partition format
> + * @part_name: Input string in format "N:partition" or "partition"
> + * @device: Output device number
> + * @partition_name: Output partition name pointer
> + *
> + * Parses the input string to extract device number and partition name.
> + * If no device is specified, uses the default from config.
> + */
> +static void parse_device_partition(const char *part_name, int *device,
> +				   const char **partition_name)
> +{
> +	const char *colon_pos;
> +
> +	/* Default: no device specified, use config default */
> +	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +	*partition_name = part_name;
> +
> +	/* Override if device:partition format detected */
> +	colon_pos = strchr(part_name, ':');
> +	if (colon_pos && colon_pos > part_name) {
> +		*device = simple_strtoul(part_name, NULL, 10);
> +		*partition_name = colon_pos + 1;
> +	}
> +}
> +
> +/**
> + * get_block_device() - Get block device descriptor
> + * @interface: Block interface name (e.g., "mmc", "scsi")
> + * @device: Device number
> + * @response: Fastboot response buffer
> + *
> + * Returns: Block device descriptor or NULL on error
> + */
> +static struct blk_desc *get_block_device(const char *interface, int device,
> +					 char *response)
> +{
> +	struct blk_desc *dev_desc;
> +
> +	if (!interface || !strcmp(interface, "")) {
> +		fastboot_fail("block interface isn't provided", response);
> +		return NULL;
> +	}
> +
> +	dev_desc = blk_get_dev(interface, device);
> +	if (!dev_desc)
> +		fastboot_fail("no such device", response);
> +
> +	return dev_desc;
> +}
> +
> +/**
> + * is_partition_table_name() - Check if name matches partition table target
> + * @part_name: Partition name to check
> + * @table_name: Config name for partition table (e.g., "gpt", "mbr")
> + *
> + * Returns: true if part_name matches table_name (with or without device prefix)
> + */
> +static bool is_partition_table_name(const char *part_name, const char *table_name)
> +{
> +	const char *colon_pos;
> +
> +	if (strcmp(part_name, table_name) == 0)
> +		return true;
> +
> +	colon_pos = strchr(part_name, ':');
> +	if (colon_pos && strcmp(colon_pos + 1, table_name) == 0)
> +		return true;

What happens if part_name is ":gpt" ?

In this case, is_partition_table_name returns true but ":gpt" is invalid
because we don't have a device prefix.

Could we use the same logic as in parse_device_partition() ?

> +
> +	return false;
> +}
> +
>  int fastboot_block_get_part_info(const char *part_name,
>  				 struct blk_desc **dev_desc,
>  				 struct disk_partition *part_info,
> @@ -133,25 +207,21 @@ int fastboot_block_get_part_info(const char *part_name,
>  	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>  						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>  						   NULL);
> -	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +	int device;
> +	const char *partition_name;
>  
>  	if (!part_name || !strcmp(part_name, "")) {
>  		fastboot_fail("partition not given", response);
>  		return -ENOENT;
>  	}
> -	if (!interface || !strcmp(interface, "")) {
> -		fastboot_fail("block interface isn't provided", response);
> -		return -EINVAL;
> -	}
>  
> -	*dev_desc = blk_get_dev(interface, device);
> -	if (!dev_desc) {
> -		fastboot_fail("no such device", response);
> +	parse_device_partition(part_name, &device, &partition_name);
> +
> +	*dev_desc = get_block_device(interface, device, response);
> +	if (!*dev_desc)
>  		return -ENODEV;
> -	}
>  
> -	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
> +	ret = part_get_info_by_name(*dev_desc, partition_name, part_info);
>  	if (ret < 0)
>  		fastboot_fail("failed to get partition info", response);
>  
> @@ -310,12 +380,114 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
>  		fastboot_okay(NULL, response);
>  }
>  
> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
> +/**
> + * flash_gpt_partition_table() - Flash GPT partition table
> + * @part_name: Partition name (format: "gpt" or "N:gpt")
> + * @download_buffer: Buffer containing GPT data
> + * @response: Fastboot response buffer
> + */
> +static void flash_gpt_partition_table(const char *part_name, void *download_buffer,
> +				      char *response)
> +{
> +	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> +						   NULL);
> +	struct blk_desc *dev_desc;
> +	int device;
> +	const char *partition_name;
> +
> +	parse_device_partition(part_name, &device, &partition_name);

partition_name is not used in this function. Could we maybe rework
parse_device_partition so that we don't always need partition_name ?

> +
> +	dev_desc = get_block_device(interface, device, response);
> +	if (!dev_desc)
> +		return;
> +
> +	printf("%s: updating MBR, Primary and Backup GPT(s) on %s device %d\n",
> +	       __func__, interface, dev_desc->devnum);
> +
> +	if (is_valid_gpt_buf(dev_desc, download_buffer)) {
> +		printf("%s: invalid GPT - refusing to write to flash\n", __func__);
> +		fastboot_fail("invalid GPT partition", response);
> +		return;
> +	}
> +
> +	if (write_mbr_and_gpt_partitions(dev_desc, download_buffer)) {
> +		printf("%s: writing GPT partitions failed\n", __func__);
> +		fastboot_fail("writing GPT partitions failed", response);
> +		return;
> +	}
> +
> +	part_init(dev_desc);
> +	printf("........ success\n");
> +	fastboot_okay(NULL, response);
> +}

This function is very similar to what we have in
fastboot_mmc_flash_write().

Can we please update fastboot_mmc_flash_write() to reuse this to avoid
code duplication?

> +#endif
> +
> +#if CONFIG_IS_ENABLED(DOS_PARTITION)
> +/**
> + * flash_mbr_partition_table() - Flash MBR partition table
> + * @part_name: Partition name (format: "mbr" or "N:mbr")
> + * @download_buffer: Buffer containing MBR data
> + * @response: Fastboot response buffer
> + */
> +static void flash_mbr_partition_table(const char *part_name, void *download_buffer,
> +				      char *response)
> +{
> +	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> +						   NULL);
> +	struct blk_desc *dev_desc;
> +	int device;
> +	const char *partition_name;
> +
> +	parse_device_partition(part_name, &device, &partition_name);
> +
> +	dev_desc = get_block_device(interface, device, response);
> +	if (!dev_desc)
> +		return;
> +
> +	printf("%s: updating MBR on %s device %d\n", __func__, interface,
> +	       dev_desc->devnum);
> +
> +	if (is_valid_dos_buf(download_buffer)) {
> +		printf("%s: invalid MBR - refusing to write to flash\n", __func__);
> +		fastboot_fail("invalid MBR partition", response);
> +		return;
> +	}
> +
> +	if (write_mbr_sector(dev_desc, download_buffer)) {
> +		printf("%s: writing MBR partition failed\n", __func__);
> +		fastboot_fail("writing MBR partition failed", response);
> +		return;
> +	}
> +
> +	part_init(dev_desc);
> +	printf("........ success\n");
> +	fastboot_okay(NULL, response);
> +}
> +#endif

Same here.

> +
>  void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>  				u32 download_bytes, char *response)
>  {
>  	struct blk_desc *dev_desc;
>  	struct disk_partition part_info;
>  
> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
> +	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
> +		flash_gpt_partition_table(part_name, download_buffer, response);
> +		return;
> +	}
> +#endif
> +
> +#if CONFIG_IS_ENABLED(DOS_PARTITION)
> +	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
> +		flash_mbr_partition_table(part_name, download_buffer, response);
> +		return;
> +	}
> +#endif
> +
>  	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
>  		return;
>  
> @@ -326,4 +498,4 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>  		fastboot_block_write_raw_image(dev_desc, &part_info, part_name,
>  					       download_buffer, download_bytes, response);
>  	}
> -}
> +}
> \ No newline at end of file

Nitpick: this change is not needed, please drop


>
> -- 
> 2.34.1
