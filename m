Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70464EF8FFC
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 16:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B940C838BB;
	Wed,  4 Mar 2026 17:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="umMvn4gR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B80083642; Wed,  4 Mar 2026 17:23:50 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A8F83F86
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 17:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48372efa020so62629635e9.2
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772641427; x=1773246227; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=dMekguA8jdl5ZFuyXD/NcG3LhwOMmuMycntzWBlcvgU=;
 b=umMvn4gRGviDv6lFtV0yu9fDt8YpViC3nkxBfoNGRQB517HkKMAbs1Gj5k4EzDfdFj
 5VYgSwKM9RTpbntdrAIUwXlKOG6RtQ67uTnsbL+krL4IegjVVxqshIR3vfAxQ5xSYww1
 aoxVfTe5jp7Ch9ITv8ES1hcx1dUFAvLmSWkpgOVRRvscizfTAytp1f6A0qOyHPoYiRqq
 RZ7XvhwcVfiSpp56HdTzcKYIFQTj2Le07ab9SvyqjuFTiM8NswlqQEwX38ImgeTGMLlB
 4SZY6URhlrQO8KM7SDh5vIbdaoYGLw+Jmpbawlf+qWl/QMVLqxz9yu/0kl4Fwdh1MDK9
 gGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641427; x=1773246227;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMekguA8jdl5ZFuyXD/NcG3LhwOMmuMycntzWBlcvgU=;
 b=nAAnhVVgbe4Ooo05aqWTNX+a6x3ppzlGuxvsyCsGNRxqJ/H3+PeCb+PaILz/WINgu/
 MuUtGDF96xURb90GxBjcKues5dNQEwyqtL7Tx0ibbminJDQOy7ynhvPqryXVYS/GXLwu
 MYB2X9nqlV92oE7D5LzFgY9Hq2/o/PpkxNFUr+8pRNhytm/yQHV531dnP2VvYEZQGZlu
 H4janrMzWTKnh9r8OUxnVzj1uo2G3ARtIXJ645sF09XfXgjZsdQGL95AjtCqYvPXsfpo
 Z5VebdyOiLCS2o9neGha5rilaRG2MJVRemJ0GTaNyDDE7FEBZNw58C8WnqBwRDsKiuqJ
 UXGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6v+IVnwxL8VeAURioA4l8IivwUf75CBzAFWw6vbEd1vimzbGKbeiWK1rrstl+yzg1+NaF3A8=@lists.denx.de
X-Gm-Message-State: AOJu0YzjAA9T6usmBhLEAlgrX8Fy6FxfjcO7xa8VVJ86i+NdVq4RTtOz
 uMHbpoKOPo+G7tyLrhni4KMdimkW9beIeW2R/ZtRmYoKBXwL4W9Ad6DhinyVlBEVf14=
X-Gm-Gg: ATEYQzxCEies/qzay39IJP/Bro1cpw8D87ynnKBOCQqTxR2xYubTH6ui0KUikxw1z0O
 sh6ycEUiGCo9YELG4I9n6PloJuzehWdwzuzbuiQmK+rb61SJQtqNWexk3CPHY5982kfJrsxhSZW
 8R6trT+otIR5B0r6JeYyxStsnbOwJl81zwBkSx9BJuZNqe1KkKHPR+favUtxS2NqqJfIY7AOM79
 u2jpAHzolSDs+EvMr+a+adk6vrAQtqGJNG3wgbDQlWCGUnMJojtHdBD+FruPAyNqPsa0ZnYm5ni
 lNkdey0Ghr16Dj6/gyMBqJP6C/zsRJk30qgmbA/M9fhGW3puG7RGLP5TxADJleLDt/j4NZ+YCkf
 lMgF6A1A+PwekxZ6Ga6fFItXr81TGOy4f8+CNGQTVZ7MARPeY3MBeJ3q8VJWljGKgTASUSMW7E8
 3NI21N9XX8iDcctj5HwoIxuVyQkAQ7GXhG8BfkZGCRKbaZyGT3EAw9bu4rYUFawn/AaoapkqZJU
 XDI
X-Received: by 2002:a05:600c:3ba2:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-4851984bc7dmr45180575e9.12.1772641426530; 
 Wed, 04 Mar 2026 08:23:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:da6:dde3:e477:94d2?
 ([2a01:e0a:106d:1080:da6:dde3:e477:94d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503425asm26636633f8f.25.2026.03.04.08.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 08:23:46 -0800 (PST)
Message-ID: <d25dd1a8-282a-4c0b-84fc-85dc29a7edc8@linaro.org>
Date: Wed, 4 Mar 2026 17:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fastboot: Add UFS flash backend
To: Ruitong Su <suruitong@lixiang.com>, u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, trini@konsulko.com
References: <20260303062926.3335004-1-suruitong@lixiang.com>
 <20260303062926.3335004-2-suruitong@lixiang.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260303062926.3335004-2-suruitong@lixiang.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 3/3/26 07:29, Ruitong Su wrote:
> Add a fastboot backend for UFS (Universal Flash Storage) devices.
> UFS devices are accessed through the SCSI subsystem, with each UFS
> LUN exposed as a separate SCSI block device.
> 
> The key feature is multi-LUN partition addressing using the syntax
> "<scsi_dev>#<partition_name>" (e.g. "0#system", "1#boot_a").
> Unqualified names fall back to the default SCSI device configured
> via CONFIG_FASTBOOT_FLASH_UFS_DEV.

I get this is a cool feature, but multi-LUN is exactly like multi-block,
so could you try to extend the block to support multiple different block
devices instead ? no need to limit this to UFS...

Thanks,
Neil

> 
> The implementation reuses the existing fb_block helpers for raw
> image, sparse image, and erase operations, adding only the
> UFS-specific partition lookup and GPT handling logic on top.
> 
> Partition lookup uses a quiet iteration via part_get_info() instead
> of the verbose part_get_info_by_name() / part_get_info_by_dev_and_
> name_or_num(), which avoids noisy console output during fastboot
> getvar probing (has-slot, partition-size queries).
> 
> Signed-off-by: Ruitong Su <suruitong@lixiang.com>
> ---
>   MAINTAINERS               |   1 +
>   drivers/fastboot/Kconfig  |  30 ++++++-
>   drivers/fastboot/Makefile |   1 +
>   drivers/fastboot/fb_ufs.c | 164 ++++++++++++++++++++++++++++++++++++++
>   include/fb_ufs.h          |  49 ++++++++++++
>   5 files changed, 243 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/fastboot/fb_ufs.c
>   create mode 100644 include/fb_ufs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8d4f6ee8b2..071102f47fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1197,6 +1197,7 @@ F:	cmd/fastboot.c
>   F:	doc/android/fastboot*.rst
>   F:	include/fastboot.h
>   F:	include/fastboot-internal.h
> +F:	include/fb_ufs.h
>   F:	include/net/fastboot_tcp.h
>   F:	include/net/fastboot_udp.h
>   F:	drivers/fastboot/
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 576c3ef8a45..8569bec5d9b 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -92,7 +92,7 @@ config FASTBOOT_FLASH
>   	bool "Enable FASTBOOT FLASH command"
>   	default y if ARCH_SUNXI && ( MMC || MTD_RAW_NAND )
>   	default y if ARCH_ROCKCHIP && MMC
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK
> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK || (UFS && SCSI)
>   	select IMAGE_SPARSE
>   	help
>   	  The fastboot protocol includes a "flash" command for writing
> @@ -124,12 +124,38 @@ config FASTBOOT_FLASH_SPI
>   	bool "FASTBOOT on SPI flash"
>   	depends on DM_SPI_FLASH
>   
> +config FASTBOOT_FLASH_UFS
> +	bool "FASTBOOT on UFS"
> +	depends on UFS && SCSI
> +	help
> +	  This enables support for the fastboot "flash" and "erase"
> +	  commands on UFS (Universal Flash Storage) devices. UFS
> +	  devices are accessed through the SCSI subsystem, with each
> +	  UFS LUN exposed as a separate SCSI block device.
> +
> +	  Partitions are addressed using the syntax
> +	  "<scsi_dev>#<partition_name>" (e.g. "0#system") to
> +	  disambiguate across multiple UFS LUNs. Unqualified names
> +	  fall back to the default SCSI device number.
> +
>   config FASTBOOT_FLASH_BLOCK
>   	bool "FASTBOOT on block device"
>   	depends on BLK
>   
>   endchoice
>   
> +config FASTBOOT_FLASH_UFS_DEV
> +	int "Define FASTBOOT UFS default SCSI device number"
> +	depends on FASTBOOT_FLASH_UFS
> +	default 0
> +	help
> +	  The default SCSI device number for UFS fastboot operations.
> +	  UFS LUNs are exposed as SCSI block devices by the UFS driver.
> +	  Use "scsi scan" followed by "scsi info" to discover the
> +	  mapping between SCSI device numbers and UFS LUNs. Typically
> +	  device 0 corresponds to UFS LUN 0. When the partition name
> +	  does not contain a "#" separator, this device is used.
> +
>   config FASTBOOT_FLASH_MMC_DEV
>   	int "Define FASTBOOT MMC FLASH default device"
>   	depends on FASTBOOT_FLASH_MMC
> @@ -227,7 +253,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>   
>   config FASTBOOT_GPT_NAME
>   	string "Target name for updating GPT"
> -	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
> +	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && EFI_PARTITION
>   	default "gpt"
>   	help
>   	  The fastboot "flash" command supports writing the downloaded
> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
> index a341af076d1..93a5227b737 100644
> --- a/drivers/fastboot/Makefile
> +++ b/drivers/fastboot/Makefile
> @@ -7,4 +7,5 @@ obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
>   # MMC reuses block implementation
>   obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
>   obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
> +obj-$(CONFIG_FASTBOOT_FLASH_UFS) += fb_block.o fb_ufs.o
>   obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
> diff --git a/drivers/fastboot/fb_ufs.c b/drivers/fastboot/fb_ufs.c
> new file mode 100644
> index 00000000000..1273c946491
> --- /dev/null
> +++ b/drivers/fastboot/fb_ufs.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Li Auto Inc.
> + *
> + * UFS (Universal Flash Storage) backend for fastboot.
> + *
> + * UFS devices in U-Boot are accessed through the SCSI subsystem, with
> + * each UFS LUN exposed as a separate SCSI block device.  This backend
> + * provides UFS-aware partition lookup with multi-LUN addressing, layered
> + * on top of the generic fb_block helpers for the actual I/O.
> + *
> + * Partition addressing uses the syntax "<scsi_dev>#<partition_name>"
> + * (e.g. "0#system") to disambiguate across multiple UFS LUNs.
> + * Unqualified names fall back to CONFIG_FASTBOOT_FLASH_UFS_DEV.
> + */
> +
> +#include <blk.h>
> +#include <fastboot.h>
> +#include <fastboot-internal.h>
> +#include <fb_block.h>
> +#include <fb_ufs.h>
> +#include <image-sparse.h>
> +#include <part.h>
> +#include <vsprintf.h>
> +#include <linux/printk.h>
> +
> +static struct blk_desc *fastboot_ufs_get_dev(char *response, int dev_num)
> +{
> +	struct blk_desc *dev_desc;
> +
> +	dev_desc = blk_get_dev("scsi", dev_num);
> +	if (!dev_desc || dev_desc->type == DEV_TYPE_UNKNOWN) {
> +		pr_err("invalid UFS/SCSI device %d\n", dev_num);
> +		fastboot_fail("invalid UFS device", response);
> +		return NULL;
> +	}
> +
> +	return dev_desc;
> +}
> +
> +static int fb_ufs_find_part(struct blk_desc *dev_desc, const char *name,
> +			    struct disk_partition *info)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 1; ; i++) {
> +		ret = part_get_info(dev_desc, i, info);
> +		if (ret)
> +			return ret;
> +		if (!strcmp(name, (char *)info->name))
> +			return i;
> +	}
> +}
> +
> +int fastboot_ufs_get_part_info(const char *part_name,
> +			       struct blk_desc **dev_desc,
> +			       struct disk_partition *part_info,
> +			       char *response)
> +{
> +	int dev_num = CONFIG_FASTBOOT_FLASH_UFS_DEV;
> +	char name_buf[32];
> +	const char *name = part_name;
> +	int ret;
> +
> +	if (!part_name || !*part_name) {
> +		fastboot_fail("partition not given", response);
> +		return -ENOENT;
> +	}
> +
> +	/* Parse "<dev>#<name>" syntax for multi-LUN addressing */
> +	if (strchr(part_name, '#')) {
> +		if (sscanf(part_name, "%d#%31s", &dev_num, name_buf) != 2) {
> +			fastboot_fail("invalid partition spec", response);
> +			return -EINVAL;
> +		}
> +		name = name_buf;
> +	}
> +
> +	*dev_desc = blk_get_dev("scsi", dev_num);
> +	if (!*dev_desc || (*dev_desc)->type == DEV_TYPE_UNKNOWN) {
> +		fastboot_fail("no such device", response);
> +		return -ENODEV;
> +	}
> +
> +	ret = fb_ufs_find_part(*dev_desc, name, part_info);
> +	if (ret < 0) {
> +		fastboot_fail("no such partition", response);
> +		return -ENOENT;
> +	}
> +
> +	return ret;
> +}
> +
> +void fastboot_ufs_flash_write(const char *cmd, void *download_buffer,
> +			      u32 download_bytes, char *response)
> +{
> +	struct blk_desc *dev_desc;
> +	struct disk_partition info = {0};
> +
> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
> +	{
> +		int dev_num = CONFIG_FASTBOOT_FLASH_UFS_DEV;
> +		char op_buf[16];
> +		const char *op = cmd;
> +
> +		if (strchr(cmd, '#')) {
> +			if (sscanf(cmd, "%d#%15s", &dev_num, op_buf) == 2)
> +				op = op_buf;
> +		}
> +
> +		if (!strcmp(op, CONFIG_FASTBOOT_GPT_NAME)) {
> +			dev_desc = fastboot_ufs_get_dev(response, dev_num);
> +			if (!dev_desc)
> +				return;
> +
> +			printf("%s: updating GPT on scsi %d\n",
> +			       __func__, dev_num);
> +			if (is_valid_gpt_buf(dev_desc, download_buffer)) {
> +				printf("%s: invalid GPT - refusing to write\n",
> +				       __func__);
> +				fastboot_fail("invalid GPT partition",
> +					      response);
> +				return;
> +			}
> +			if (write_mbr_and_gpt_partitions(dev_desc,
> +							 download_buffer)) {
> +				printf("%s: writing GPT partitions failed\n",
> +				       __func__);
> +				fastboot_fail("writing GPT partitions failed",
> +					      response);
> +				return;
> +			}
> +			part_init(dev_desc);
> +			printf("........ success\n");
> +			fastboot_okay(NULL, response);
> +			return;
> +		}
> +	}
> +#endif
> +
> +	if (fastboot_ufs_get_part_info(cmd, &dev_desc, &info, response) < 0)
> +		return;
> +
> +	if (is_sparse_image(download_buffer)) {
> +		fastboot_block_write_sparse_image(dev_desc, &info, cmd,
> +						  download_buffer, response);
> +	} else {
> +		fastboot_block_write_raw_image(dev_desc, &info, cmd,
> +					       download_buffer,
> +					       download_bytes, response);
> +	}
> +}
> +
> +void fastboot_ufs_erase(const char *cmd, char *response)
> +{
> +	struct blk_desc *dev_desc;
> +	struct disk_partition info;
> +
> +	if (fastboot_ufs_get_part_info(cmd, &dev_desc, &info, response) < 0)
> +		return;
> +
> +	fastboot_block_raw_erase(dev_desc, &info, cmd, 0, response);
> +}
> diff --git a/include/fb_ufs.h b/include/fb_ufs.h
> new file mode 100644
> index 00000000000..d64d5aca81a
> --- /dev/null
> +++ b/include/fb_ufs.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2026 Li Auto Inc.
> + */
> +
> +#ifndef _FB_UFS_H_
> +#define _FB_UFS_H_
> +
> +struct blk_desc;
> +struct disk_partition;
> +
> +/**
> + * fastboot_ufs_get_part_info() - Look up partition on UFS device
> + *
> + * Supports two naming conventions:
> + *   "<scsi_dev>#<partition_name>"  -- explicit LUN targeting (e.g. "0#system")
> + *   "<partition_name>"             -- searches on default UFS SCSI device
> + *
> + * @part_name: Partition specifier (see above)
> + * @dev_desc: Pointer to returned block device descriptor
> + * @part_info: Pointer to returned partition info
> + * @response: Pointer to fastboot response buffer
> + * Return: Partition number on success, negative on error
> + */
> +int fastboot_ufs_get_part_info(const char *part_name,
> +			       struct blk_desc **dev_desc,
> +			       struct disk_partition *part_info,
> +			       char *response);
> +
> +/**
> + * fastboot_ufs_flash_write() - Write downloaded image to UFS partition
> + *
> + * @cmd: Partition specifier ("0#system", "0#gpt", etc.)
> + * @download_buffer: Pointer to downloaded image data
> + * @download_bytes: Size of downloaded image
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_ufs_flash_write(const char *cmd, void *download_buffer,
> +			      u32 download_bytes, char *response);
> +
> +/**
> + * fastboot_ufs_erase() - Erase a UFS partition
> + *
> + * @cmd: Partition specifier ("0#userdata", etc.)
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_ufs_erase(const char *cmd, char *response);
> +
> +#endif /* _FB_UFS_H_ */

