Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D072CF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6FF88E8A;
	Mon, 14 Oct 2024 08:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a0Ie8W6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A1D88E8A; Mon, 14 Oct 2024 08:53:11 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C0A88F46
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43111cff9d3so29065155e9.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888784; x=1729493584; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mfqvTgswiAYXMjsemMH41K50Fz7gCdykEyFV7Mf/9ho=;
 b=a0Ie8W6DuQomgCwV6IrQFyofJx83SdbyaFloyn6onhnpVxKS5udOAAXiZb+Q137zzg
 Av+MNndwKlRPlcRorGCFWjQcL0j+2UrSkSHARTTMVKwVqAcjOxI4jTKMu3AVmZOSrsSc
 XCoJT5mh0784erJ5ab8Mln2EdJtqnHwzxytP0mBTE3nJp2muhjEdMVVyYSS1M39yIqPG
 Jh93l5u3LOW3TL4TNeTbDkC1rNgkskZm7TpstAxgkJ05I9eGQfYvJyWC3kUcazSBRIpR
 W/gRZlIjYi0+bMm+Fhs6+zAiyScp8ibGDWdu/0xfa2JkOF7yMfeB+UI0npJOouLVR85j
 g3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888784; x=1729493584;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mfqvTgswiAYXMjsemMH41K50Fz7gCdykEyFV7Mf/9ho=;
 b=G328Fqd1JpX8jTMLR5U11rmJE/p+MxP/j9W8A/0aMvDsITYSf7ZwAzsKa9tmMTe4FL
 dWlwqsOI1VhYCAvxzRskzovCyL/5X8ztDmtXnvC4wpOri5m0D5pfGBT2HCjXDwVm5SSd
 gtH/nB4HUruo3Za4xehMreo/wMszr51YUV4CmsIEuc7R/6olokqvF7fSnmLcB8WAkqbM
 M0LZonVneEhYy64MvG2bFNw1voRQIklk8pRu/CSIznw8yOzfhtH0BNT0LlAzWkbSTOjl
 8CraUEhooB7BHMma8szD0xXSHS3DzZQlmJXgO3uMGFBW0BwEdJtvMY7/sDXHGsLvUyJC
 PgJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtfLM3S4oGlb6WKhsTqrJ/GyjJn3EWnXdnwr/IE8NB6AanmxP+2FPBiEspd35fUvjFb4zJceY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/ZfGu9nUeZclMXA3D5myIkr3+NJ9Y7UdDsrGeH1Or+A7Huivy
 B+2RBiK4MF32S/qlzI4fMHBji/8/JJIcTLkvy/D2YuPFffMbVKcMVZzlFUpSXAimza8BbCwEHKJ
 yCCs=
X-Google-Smtp-Source: AGHT+IGpcnea6gvdKS34eJPhgtHRIWwGVNRQc2u17JW6NHc5cUQEUC1dEr0wsPl5iCib5z6KQk5Amg==
X-Received: by 2002:a05:600c:350b:b0:42f:4f6:f8f3 with SMTP id
 5b1f17b1804b1-4311debbcf6mr85610015e9.7.1728888784220; 
 Sun, 13 Oct 2024 23:53:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f?
 ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b41bfsm143360865e9.29.2024.10.13.23.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 23:53:03 -0700 (PDT)
Message-ID: <9ae0711b-8ea1-46e9-8868-87ea272de6b9@linaro.org>
Date: Mon, 14 Oct 2024 08:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/4] mach-snapdragon: implement capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
 <20241012-b4-qcom-capsule-updates-v4-3-abd05f15255f@linaro.org>
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
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-3-abd05f15255f@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/10/2024 15:57, Caleb Connolly wrote:
> Qualcomm boards flash U-Boot a variety of partitions, implement support
> for determining which slot U-Boot is running from, finding the correct
> partition for that slot and configuring the appropriate DFU string.
> 
> Initially, we only support the RB3 Gen 2 where U-Boot is flashed to the
> UEFI partition, and ignore handling of slots. In the future we will
> additionally support booting U-Boot from other partitions (e.g. boot)
> and correct handling for A/B.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Kconfig          |   3 +
>   arch/arm/mach-snapdragon/Makefile         |   1 +
>   arch/arm/mach-snapdragon/board.c          |   3 +
>   arch/arm/mach-snapdragon/capsule_update.c | 153 ++++++++++++++++++++++++++++++
>   arch/arm/mach-snapdragon/qcom-priv.h      |   6 ++
>   include/configs/qcom.h                    |   5 +
>   6 files changed, 171 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 536960b83c3b..f82cd0d32915 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -19,8 +19,11 @@ config SPL_SYS_MALLOC_F
>   
>   config SPL_SYS_MALLOC_F_LEN
>   	default 0x2000
>   
> +config SYS_MALLOC_LEN
> +	default 0x800000
> +
>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   	default 0x80000000
>   
>   config SYS_BOARD
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 7a4495c8108f..343e825c6fdd 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,5 +2,6 @@
>   #
>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   
>   obj-y += board.o
> +obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>   obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ab2ceb51389..fbb6cf7c6599 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -447,8 +447,11 @@ int board_late_init(void)
>   
>   	configure_env();
>   	qcom_late_init();
>   
> +	/* Configure the dfu_string for capsule updates */
> +	qcom_configure_capsule_updates();
> +
>   	return 0;
>   }
>   
>   static void build_mem_map(void)
> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
> new file mode 100644
> index 000000000000..bf75a9a1b24c
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Capsule update support for Qualcomm boards.
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + * Author: Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#define pr_fmt(fmt) "QCOM-FMP: " fmt
> +
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <efi.h>
> +#include <efi_loader.h>
> +#include <malloc.h>
> +#include <scsi.h>
> +#include <part.h>
> +#include <linux/err.h>
> +
> +#include "qcom-priv.h"
> +
> +/*
> + * NOTE: for now this implementation only supports the rb3gen2. Supporting other
> + * boards that boot in different ways (e.g. chainloaded from ABL) will require
> + * additional complexity to properly create the dfu string and fw_images array.
> + */
> +
> +/*
> + * To handle different variants like chainloaded U-Boot here we'll need to
> + * build the fw_images array dynamically at runtime. It looks like
> + * mach-rockchip is a good example for how to do this.
> + * Detecting which image types a board uses is TBD, hence for now we only
> + * support the one new board that runs U-Boot as its primary bootloader.
> + */
> +struct efi_fw_image fw_images[] = {
> +	{
> +		/* U-Boot flashed to the uefi_X partition (e.g. rb3gen2) */
> +		.fw_name = u"UBOOT_UEFI_PARTITION",
> +		.image_index = 1,
> +	},
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	/* Filled in by configure_dfu_string() */
> +	.dfu_string = NULL,
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};
> +
> +/* LSB first */
> +struct part_slot_status {
> +	u16: 2;
> +	u16 active : 1;
> +	u16: 3;
> +	u16 successful : 1;
> +	u16 unbootable : 1;
> +	u16 tries_remaining : 4;
> +};
> +
> +static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, char *name)
> +{
> +	int ret;
> +	int partnum;
> +	struct disk_partition info;
> +	struct part_slot_status *slot_status;
> +
> +	for (partnum = 1;; partnum++) {
> +		ret = part_get_info(blk_dev, partnum, &info);
> +		if (ret)
> +			return ret;
> +
> +		slot_status = (struct part_slot_status *)&info.type_flags;
> +		log_io("%16s: Active: %1d, Successful: %1d, Unbootable: %1d, Tries left: %1d\n",
> +		       info.name, slot_status->active,
> +		       slot_status->successful, slot_status->unbootable,
> +		       slot_status->tries_remaining);
> +		/*
> +		 * FIXME: eventually we'll want to find the active/inactive variant of the partition
> +		 * but on the rb3gen2 these values might all be 0
> +		 */
> +		if (!strncmp(info.name, partname, strlen(partname))) {
> +			log_debug("Found active %s partition: '%s'!\n", partname, info.name);
> +			strlcpy(name, info.name, sizeof(info.name));
> +			return partnum;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +/**
> + * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
> + *
> + * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
> + * are two boot partitions, boot_a and boot_b. As we don't currently support doing
> + * full A/B updates, we only support updating the currently active boot partition.
> + *
> + * So we need to find the current slot suffix and the associated boot partition.
> + * We do this by looking for the boot partition that has the 'active' flag set
> + * in the GPT partition vendor attribute bits.
> + */
> +void qcom_configure_capsule_updates(void)
> +{
> +	struct blk_desc *desc;
> +	int ret = 0, partnum = -1, devnum;
> +	static char dfu_string[32] = { 0 };
> +	char name[32]; /* GPT partition name */
> +	char *partname = "uefi_a";

NIT

Could this be moved to a CONFIG option ? Only the new non-mobile platforms have this partition,
we could switch it to boot_a for the mobile platforms with the right config option.

No need to resend for that

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


> +	struct udevice *dev = NULL;
> +
> +	if (IS_ENABLED(CONFIG_SCSI)) {
> +		/* Scan for SCSI devices */
> +		ret = scsi_scan(false);
> +		if (ret) {
> +			debug("Failed to scan SCSI devices: %d\n", ret);
> +			return;
> +		}
> +	}
> +
> +	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +		if (device_get_uclass_id(dev) != UCLASS_BLK)
> +			continue;
> +
> +		desc = dev_get_uclass_plat(dev);
> +		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
> +			continue;
> +		devnum = desc->devnum;
> +		partnum = find_boot_partition(partname, desc,
> +					      name);
> +		if (partnum >= 0)
> +			break;
> +	}
> +
> +	if (partnum < 0) {
> +		log_err("Failed to find boot partition\n");
> +		return;
> +	}
> +
> +	switch (desc->uclass_id) {
> +	case UCLASS_SCSI:
> +		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
> +		break;
> +	case UCLASS_MMC:
> +		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
> +		break;
> +	default:
> +		debug("Unsupported storage uclass: %d\n", desc->uclass_id);
> +		return;
> +	}
> +	log_debug("boot partition is %s, DFU string: '%s'\n", name, dfu_string);
> +
> +	update_info.dfu_string = dfu_string;
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 0a7ed5eff8b8..74d39197b89f 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -2,8 +2,14 @@
>   
>   #ifndef __QCOM_PRIV_H__
>   #define __QCOM_PRIV_H__
>   
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> +void qcom_configure_capsule_updates(void);
> +#else
> +void qcom_configure_capsule_updates(void) {}
> +#endif /* EFI_HAVE_CAPSULE_SUPPORT */
> +
>   #if CONFIG_IS_ENABLED(OF_LIVE)
>   /**
>    * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
>    *
> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> index 5b5ebbd844df..9b41ab9e982b 100644
> --- a/include/configs/qcom.h
> +++ b/include/configs/qcom.h
> @@ -10,5 +10,10 @@
>   #define __CONFIGS_SNAPDRAGON_H
>   
>   #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
>   
> +// 2a5aa852-b856-4d97-baa9-5c5f4421551f
> +#define QUALCOMM_UBOOT_BOOT_IMAGE_GUID \
> +	EFI_GUID(0x2a5aa852, 0xb856, 0x4d97, 0xba, 0xa9, \
> +		0x5c, 0x5f, 0x44, 0x21, 0x55, 0x1f)
> +
>   #endif
> 

