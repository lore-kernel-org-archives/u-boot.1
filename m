Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2025BEC01B6
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 10:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5015484114;
	Mon, 23 Mar 2026 11:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b1B5lUkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C6484118; Mon, 23 Mar 2026 11:00:58 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F19683DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 11:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D0896439F0;
 Mon, 23 Mar 2026 10:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAD3C4CEF7;
 Mon, 23 Mar 2026 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774260053;
 bh=Cyuxn0c2WKhEHJ55OylZwjAvUZIoxo0Q+kKW6uB6Kjg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=b1B5lUkAdTIPSy0MnIa4SWPO6CHOTV+pKpZiRl11CcNRZwg/Zmqhz5MySEuk0QaC3
 Vv6hVZ9tzJwpTdmZ21xJJoQpO79wN/0CKy3h2S0rRpsYQjG0kx7gRedv4N7edPFZCI
 J/qFnpxVd1JCZPN5QY5JZ2es0Lh1/48p/7tcuUVKBBJJZfhuYWptuDlO2tthM3f5JP
 UItOBLE7Cv7MlzeTDbK0RAoRKQHgLcjefDNvKauMMQy+AZb/c4YdEETh1jqCkpw0WP
 89xiGLAoPUqlIryIcAOWemJ3Af2aO6AtM6JWsUZgj6AsfNS7gJSz832nB2NgDEUbDS
 9pdDPqo3NEMhQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Ruitong Su
 <suruitong@lixiang.com>, u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, trini@konsulko.com
Subject: Re: [PATCH 1/2] fastboot: Add UFS flash backend
In-Reply-To: <d25dd1a8-282a-4c0b-84fc-85dc29a7edc8@linaro.org>
References: <20260303062926.3335004-1-suruitong@lixiang.com>
 <20260303062926.3335004-2-suruitong@lixiang.com>
 <d25dd1a8-282a-4c0b-84fc-85dc29a7edc8@linaro.org>
Date: Mon, 23 Mar 2026 11:00:50 +0100
Message-ID: <87cy0un9v1.fsf@kernel.org>
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


On Wed, Mar 04, 2026 at 17:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 3/3/26 07:29, Ruitong Su wrote:
>> Add a fastboot backend for UFS (Universal Flash Storage) devices.
>> UFS devices are accessed through the SCSI subsystem, with each UFS
>> LUN exposed as a separate SCSI block device.
>> 
>> The key feature is multi-LUN partition addressing using the syntax
>> "<scsi_dev>#<partition_name>" (e.g. "0#system", "1#boot_a").
>> Unqualified names fall back to the default SCSI device configured
>> via CONFIG_FASTBOOT_FLASH_UFS_DEV.
>
> I get this is a cool feature, but multi-LUN is exactly like multi-block,
> so could you try to extend the block to support multiple different block
> devices instead ? no need to limit this to UFS...

I agree with Neil here. Can you explain why this needs to be UFS
specific or re-spin a new version to extend block support?

>
> Thanks,
> Neil
>
>> 
>> The implementation reuses the existing fb_block helpers for raw
>> image, sparse image, and erase operations, adding only the
>> UFS-specific partition lookup and GPT handling logic on top.
>> 
>> Partition lookup uses a quiet iteration via part_get_info() instead
>> of the verbose part_get_info_by_name() / part_get_info_by_dev_and_
>> name_or_num(), which avoids noisy console output during fastboot
>> getvar probing (has-slot, partition-size queries).
>> 
>> Signed-off-by: Ruitong Su <suruitong@lixiang.com>
>> ---
>>   MAINTAINERS               |   1 +
>>   drivers/fastboot/Kconfig  |  30 ++++++-
>>   drivers/fastboot/Makefile |   1 +
>>   drivers/fastboot/fb_ufs.c | 164 ++++++++++++++++++++++++++++++++++++++
>>   include/fb_ufs.h          |  49 ++++++++++++
>>   5 files changed, 243 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/fastboot/fb_ufs.c
>>   create mode 100644 include/fb_ufs.h
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f8d4f6ee8b2..071102f47fd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1197,6 +1197,7 @@ F:	cmd/fastboot.c
>>   F:	doc/android/fastboot*.rst
>>   F:	include/fastboot.h
>>   F:	include/fastboot-internal.h
>> +F:	include/fb_ufs.h
>>   F:	include/net/fastboot_tcp.h
>>   F:	include/net/fastboot_udp.h
>>   F:	drivers/fastboot/
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 576c3ef8a45..8569bec5d9b 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -92,7 +92,7 @@ config FASTBOOT_FLASH
>>   	bool "Enable FASTBOOT FLASH command"
>>   	default y if ARCH_SUNXI && ( MMC || MTD_RAW_NAND )
>>   	default y if ARCH_ROCKCHIP && MMC
>> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK
>> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK || (UFS && SCSI)
>>   	select IMAGE_SPARSE
>>   	help
>>   	  The fastboot protocol includes a "flash" command for writing
>> @@ -124,12 +124,38 @@ config FASTBOOT_FLASH_SPI
>>   	bool "FASTBOOT on SPI flash"
>>   	depends on DM_SPI_FLASH
>>   
>> +config FASTBOOT_FLASH_UFS
>> +	bool "FASTBOOT on UFS"
>> +	depends on UFS && SCSI
>> +	help
>> +	  This enables support for the fastboot "flash" and "erase"
>> +	  commands on UFS (Universal Flash Storage) devices. UFS
>> +	  devices are accessed through the SCSI subsystem, with each
>> +	  UFS LUN exposed as a separate SCSI block device.
>> +
>> +	  Partitions are addressed using the syntax
>> +	  "<scsi_dev>#<partition_name>" (e.g. "0#system") to
>> +	  disambiguate across multiple UFS LUNs. Unqualified names
>> +	  fall back to the default SCSI device number.
>> +
>>   config FASTBOOT_FLASH_BLOCK
>>   	bool "FASTBOOT on block device"
>>   	depends on BLK
>>   
>>   endchoice
>>   
>> +config FASTBOOT_FLASH_UFS_DEV
>> +	int "Define FASTBOOT UFS default SCSI device number"
>> +	depends on FASTBOOT_FLASH_UFS
>> +	default 0
>> +	help
>> +	  The default SCSI device number for UFS fastboot operations.
>> +	  UFS LUNs are exposed as SCSI block devices by the UFS driver.
>> +	  Use "scsi scan" followed by "scsi info" to discover the
>> +	  mapping between SCSI device numbers and UFS LUNs. Typically
>> +	  device 0 corresponds to UFS LUN 0. When the partition name
>> +	  does not contain a "#" separator, this device is used.
>> +
>>   config FASTBOOT_FLASH_MMC_DEV
>>   	int "Define FASTBOOT MMC FLASH default device"
>>   	depends on FASTBOOT_FLASH_MMC
>> @@ -227,7 +253,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>   
>>   config FASTBOOT_GPT_NAME
>>   	string "Target name for updating GPT"
>> -	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
>> +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && EFI_PARTITION
>>   	default "gpt"
>>   	help
>>   	  The fastboot "flash" command supports writing the downloaded
>> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
>> index a341af076d1..93a5227b737 100644
>> --- a/drivers/fastboot/Makefile
>> +++ b/drivers/fastboot/Makefile
>> @@ -7,4 +7,5 @@ obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
>>   # MMC reuses block implementation
>>   obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
>>   obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
>> +obj-$(CONFIG_FASTBOOT_FLASH_UFS) += fb_block.o fb_ufs.o
>>   obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
>> diff --git a/drivers/fastboot/fb_ufs.c b/drivers/fastboot/fb_ufs.c
>> new file mode 100644
>> index 00000000000..1273c946491
>> --- /dev/null
>> +++ b/drivers/fastboot/fb_ufs.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2026 Li Auto Inc.
>> + *
>> + * UFS (Universal Flash Storage) backend for fastboot.
>> + *
>> + * UFS devices in U-Boot are accessed through the SCSI subsystem, with
>> + * each UFS LUN exposed as a separate SCSI block device.  This backend
>> + * provides UFS-aware partition lookup with multi-LUN addressing, layered
>> + * on top of the generic fb_block helpers for the actual I/O.
>> + *
>> + * Partition addressing uses the syntax "<scsi_dev>#<partition_name>"
>> + * (e.g. "0#system") to disambiguate across multiple UFS LUNs.
>> + * Unqualified names fall back to CONFIG_FASTBOOT_FLASH_UFS_DEV.
>> + */
>> +
>> +#include <blk.h>
>> +#include <fastboot.h>
>> +#include <fastboot-internal.h>
>> +#include <fb_block.h>
>> +#include <fb_ufs.h>
>> +#include <image-sparse.h>
>> +#include <part.h>
>> +#include <vsprintf.h>
>> +#include <linux/printk.h>
>> +
>> +static struct blk_desc *fastboot_ufs_get_dev(char *response, int dev_num)
>> +{
>> +	struct blk_desc *dev_desc;
>> +
>> +	dev_desc = blk_get_dev("scsi", dev_num);
>> +	if (!dev_desc || dev_desc->type == DEV_TYPE_UNKNOWN) {
>> +		pr_err("invalid UFS/SCSI device %d\n", dev_num);
>> +		fastboot_fail("invalid UFS device", response);
>> +		return NULL;
>> +	}
>> +
>> +	return dev_desc;
>> +}
>> +
>> +static int fb_ufs_find_part(struct blk_desc *dev_desc, const char *name,
>> +			    struct disk_partition *info)
>> +{
>> +	int i;
>> +	int ret;
>> +
>> +	for (i = 1; ; i++) {
>> +		ret = part_get_info(dev_desc, i, info);
>> +		if (ret)
>> +			return ret;
>> +		if (!strcmp(name, (char *)info->name))
>> +			return i;
>> +	}
>> +}
>> +
>> +int fastboot_ufs_get_part_info(const char *part_name,
>> +			       struct blk_desc **dev_desc,
>> +			       struct disk_partition *part_info,
>> +			       char *response)
>> +{
>> +	int dev_num = CONFIG_FASTBOOT_FLASH_UFS_DEV;
>> +	char name_buf[32];
>> +	const char *name = part_name;
>> +	int ret;
>> +
>> +	if (!part_name || !*part_name) {
>> +		fastboot_fail("partition not given", response);
>> +		return -ENOENT;
>> +	}
>> +
>> +	/* Parse "<dev>#<name>" syntax for multi-LUN addressing */
>> +	if (strchr(part_name, '#')) {
>> +		if (sscanf(part_name, "%d#%31s", &dev_num, name_buf) != 2) {
>> +			fastboot_fail("invalid partition spec", response);
>> +			return -EINVAL;
>> +		}
>> +		name = name_buf;
>> +	}
>> +
>> +	*dev_desc = blk_get_dev("scsi", dev_num);
>> +	if (!*dev_desc || (*dev_desc)->type == DEV_TYPE_UNKNOWN) {
>> +		fastboot_fail("no such device", response);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = fb_ufs_find_part(*dev_desc, name, part_info);
>> +	if (ret < 0) {
>> +		fastboot_fail("no such partition", response);
>> +		return -ENOENT;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +void fastboot_ufs_flash_write(const char *cmd, void *download_buffer,
>> +			      u32 download_bytes, char *response)
>> +{
>> +	struct blk_desc *dev_desc;
>> +	struct disk_partition info = {0};
>> +
>> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
>> +	{
>> +		int dev_num = CONFIG_FASTBOOT_FLASH_UFS_DEV;
>> +		char op_buf[16];
>> +		const char *op = cmd;
>> +
>> +		if (strchr(cmd, '#')) {
>> +			if (sscanf(cmd, "%d#%15s", &dev_num, op_buf) == 2)
>> +				op = op_buf;
>> +		}
>> +
>> +		if (!strcmp(op, CONFIG_FASTBOOT_GPT_NAME)) {
>> +			dev_desc = fastboot_ufs_get_dev(response, dev_num);
>> +			if (!dev_desc)
>> +				return;
>> +
>> +			printf("%s: updating GPT on scsi %d\n",
>> +			       __func__, dev_num);
>> +			if (is_valid_gpt_buf(dev_desc, download_buffer)) {
>> +				printf("%s: invalid GPT - refusing to write\n",
>> +				       __func__);
>> +				fastboot_fail("invalid GPT partition",
>> +					      response);
>> +				return;
>> +			}
>> +			if (write_mbr_and_gpt_partitions(dev_desc,
>> +							 download_buffer)) {
>> +				printf("%s: writing GPT partitions failed\n",
>> +				       __func__);
>> +				fastboot_fail("writing GPT partitions failed",
>> +					      response);
>> +				return;
>> +			}
>> +			part_init(dev_desc);
>> +			printf("........ success\n");
>> +			fastboot_okay(NULL, response);
>> +			return;
>> +		}
>> +	}
>> +#endif
>> +
>> +	if (fastboot_ufs_get_part_info(cmd, &dev_desc, &info, response) < 0)
>> +		return;
>> +
>> +	if (is_sparse_image(download_buffer)) {
>> +		fastboot_block_write_sparse_image(dev_desc, &info, cmd,
>> +						  download_buffer, response);
>> +	} else {
>> +		fastboot_block_write_raw_image(dev_desc, &info, cmd,
>> +					       download_buffer,
>> +					       download_bytes, response);
>> +	}
>> +}
>> +
>> +void fastboot_ufs_erase(const char *cmd, char *response)
>> +{
>> +	struct blk_desc *dev_desc;
>> +	struct disk_partition info;
>> +
>> +	if (fastboot_ufs_get_part_info(cmd, &dev_desc, &info, response) < 0)
>> +		return;
>> +
>> +	fastboot_block_raw_erase(dev_desc, &info, cmd, 0, response);
>> +}
>> diff --git a/include/fb_ufs.h b/include/fb_ufs.h
>> new file mode 100644
>> index 00000000000..d64d5aca81a
>> --- /dev/null
>> +++ b/include/fb_ufs.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2026 Li Auto Inc.
>> + */
>> +
>> +#ifndef _FB_UFS_H_
>> +#define _FB_UFS_H_
>> +
>> +struct blk_desc;
>> +struct disk_partition;
>> +
>> +/**
>> + * fastboot_ufs_get_part_info() - Look up partition on UFS device
>> + *
>> + * Supports two naming conventions:
>> + *   "<scsi_dev>#<partition_name>"  -- explicit LUN targeting (e.g. "0#system")
>> + *   "<partition_name>"             -- searches on default UFS SCSI device
>> + *
>> + * @part_name: Partition specifier (see above)
>> + * @dev_desc: Pointer to returned block device descriptor
>> + * @part_info: Pointer to returned partition info
>> + * @response: Pointer to fastboot response buffer
>> + * Return: Partition number on success, negative on error
>> + */
>> +int fastboot_ufs_get_part_info(const char *part_name,
>> +			       struct blk_desc **dev_desc,
>> +			       struct disk_partition *part_info,
>> +			       char *response);
>> +
>> +/**
>> + * fastboot_ufs_flash_write() - Write downloaded image to UFS partition
>> + *
>> + * @cmd: Partition specifier ("0#system", "0#gpt", etc.)
>> + * @download_buffer: Pointer to downloaded image data
>> + * @download_bytes: Size of downloaded image
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_ufs_flash_write(const char *cmd, void *download_buffer,
>> +			      u32 download_bytes, char *response);
>> +
>> +/**
>> + * fastboot_ufs_erase() - Erase a UFS partition
>> + *
>> + * @cmd: Partition specifier ("0#userdata", etc.)
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_ufs_erase(const char *cmd, char *response);
>> +
>> +#endif /* _FB_UFS_H_ */
