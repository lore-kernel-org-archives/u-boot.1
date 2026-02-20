Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0E8C531FE
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 03:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15DD083946;
	Fri, 20 Feb 2026 04:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KOSBFY/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84B683AA9; Fri, 20 Feb 2026 04:52:25 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7859D8366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 04:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-5069c08cd32so2590991cf.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771559542; x=1772164342; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y4iXbxKOGpPdeD5ylCcKoE6GoN68H6tGlqHlwRsXsXA=;
 b=KOSBFY/hCZZvDhPR70UdSg47FU7wbfWMFhtiuBniiDL03EJDqLHaSeuWMGdVlLKhri
 Xf8T5qXwDfD8X6JhvVYwuakjFErUtLhpgjeGG7Puyo0q5nVvM+75DnqZnWlDarDmypU/
 HVTjARQNjcQFrUz7xj3LELDtssezwDt/cr5xn+5WeQDxW6FPcYx/SBUUhEc3dn520kWU
 saeDW4iiWq9h7tFL5DsksALtX9+wcUL7MEakqImugF2lr4tYcJticUGydzAEmlX5fvTJ
 +EUiDxqRz98BfUzwwioThwxR7M2RFvQ1xpBAHuSszvfgyKxDTg27BU4t+7bPlIC41okq
 GMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771559542; x=1772164342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4iXbxKOGpPdeD5ylCcKoE6GoN68H6tGlqHlwRsXsXA=;
 b=cg1h19w6WDSwH5zwCfbR9wJsyLA9+lqf9OG5ZBeqxq57eCfcyH3Fc/mbZjtYJzMZY5
 mSAJjxt6Bp1Q+kUnqtZDSjMJcdlZEQsqVF7kBj9B9OynsC4DoOdtoC6Ni+AeZA9t232e
 zaY8AjQ3rPeviG3iLKqIxDS5CbKW01vKCHl25EkgISOxBKpWin8NzFp9/XIeneNVj/UN
 FOcsX7w2BgPZjiETJjuZHR1o5KGDluZSi2ObfH1zqaAUupuAJ29fc8xW4NqdVXiAJaYp
 ADiGy2ICthIpfwQCiYlLBN0Q76IocXqi2GT8OkTpCkgGrQugujOvqdlLb0c+6fKzLb4+
 lomg==
X-Gm-Message-State: AOJu0YyeW2SiY9OC7D7m4eTIi0OrWn1NiSqGjHTb3HvRnBeE0zN73IMn
 RSSZDhFxe04MhdtTIN1BWM81uuqRJJ84XdCDbhlfnLxUnsPHMkROG4J9
X-Gm-Gg: AZuq6aKwkqzZyI3yxnWIPLpulHYezpYAfEZguwmmNyOq/RIa1zIBB13koj705lDiAZz
 FWO7MZCfkRnw1w9WSl9csT2PSPzzVs0zzX1MTDNasA0W5LgD6i7leP+/Tf08S1eGuKTRYzCmFpQ
 Br2QwUJlUrCpyhJXLu6bJJtoRo+LFC2JzfX2+vS7tIQM2Bn4kBClh8TM3DB990q9xfy9/0xal0p
 SB/G7ZhzmQgay96VDlVHIs58pzxLUPP5lZ8Ij8GBWPpc4EfV1s+iBg2YtFJfSyvHQURGi8WDjuK
 C7erwE464eN60v4i88CTlX51Kr/BHsjnVCZZDl82TjOi6VIWY3bgWIBefD4xUjHEYsBWyA1en1D
 glagJ82nPiL3i3TuCbW/cgIyl+XE/OkNZXpiZ2OyJFdmv3sMhUQhg0XXUFB4CT1jI7x/3hOZgCT
 sr9BNqhXOS7SpOBWAZPFo5zmNgny+GALk9NlRuH7FrnsbKYc7CNyrSgY04n0AyvuN4Y4wkU6J7Z
 vUlHw==
X-Received: by 2002:a05:620a:400a:b0:8cb:3df5:4b70 with SMTP id
 af79cd13be357-8cb4081fc2fmr2236509385a.2.1771559542088; 
 Thu, 19 Feb 2026 19:52:22 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b004eecsm2169751385a.0.2026.02.19.19.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 19:52:21 -0800 (PST)
Message-ID: <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
Date: Thu, 19 Feb 2026 22:52:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, michael@amarulasolutions.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, dinesh.maniyam@altera.com,
 a-dutta@ti.com, a-nandan@ti.com, jonas@kwiboo.se,
 Fabio Estevam <festevam@nabladev.com>
References: <20260220031232.1254728-1-festevam@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260220031232.1254728-1-festevam@gmail.com>
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

On 2/19/26 22:12, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Add support for loading the next stage from an MTD device in SPL.
> 
> Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
> implementation that uses the MTD subsystem to read the U-Boot payload.
> 
> The loader works with any MTD-backed storage, including raw NAND and
> SPI NAND, without being tied to a specific NAND type.
> 
> The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
> overridden via the device tree property:
> 
>      u-boot,spl-payload-offset
> 
> To support both raw NAND and SPI NAND boot flows, the loader is
> registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
> to operate correctly on platforms where the ROM reports either NAND
> or SPI as the boot source while using the same MTD-based loading
> infrastructure.
> 
> The required NAND core and SPI NAND drivers are built for SPL when
> CONFIG_SPL_MTD_LOAD is enabled.
> 
> This provides reusable infrastructure for boards that boot from MTD
> devices without relying on SPI-specific or NAND-specific SPL loaders.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Use uclass_get_device_by_seq().
> - Use puts() instead of debug() for error.
> - Include the new loader to include/spl_load.h.
> - Introduce SPL_MTD_SPI_NAND.
> 
>   common/spl/Kconfig        | 30 ++++++++++++++
>   common/spl/Makefile       |  1 +
>   common/spl/spl_mtd.c      | 83 +++++++++++++++++++++++++++++++++++++++
>   drivers/mtd/Makefile      |  1 +
>   drivers/mtd/nand/Makefile |  4 +-
>   include/spl_load.h        |  1 +
>   6 files changed, 119 insertions(+), 1 deletion(-)
>   create mode 100644 common/spl/spl_mtd.c
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 2998b7acb75f..16dbc5b54324 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -933,6 +933,12 @@ config SYS_MMCSD_FS_BOOT_PARTITION
>   	  used in fs mode.
>   	  Use -1 as a special value to use the first bootable partition.
>   
> +config SYS_SPL_MTD_SEQ
> +	int "MTD device number for the SPL load"
> +	default 0
> +	help
> +	  MTD device number used for the SPL load.
> +
>   config SPL_MMC_TINY
>   	bool "Tiny MMC framework in SPL"
>   	depends on SPL_MMC
> @@ -1578,6 +1584,30 @@ config SPL_SPI_LOAD
>   
>   endif # SPL_SPI_FLASH_SUPPORT
>   
> +config SPL_MTD_LOAD
> +	bool "Support loading from a generic MTD device"
> +	depends on SPL
> +	depends on MTD && DM_MTD
> +	help
> +	  Enable support for loading the next stage from an MTD device
> +	  using the MTD subsystem in SPL.
> +
> +	  This supports raw NAND and SPI NAND devices.
> +
> +config SPL_MTD_SPI_NAND
> +	bool "Enable SPI NAND support in SPL"
> +	depends on SPL_MTD_LOAD
> +	select MTD_SPI_NAND
> +	help
> +	 Build SPI NAND support for SPL.
> +
> +config SYS_MTD_U_BOOT_OFFS
> +	hex "address of U-boot payload in the MTD device"
> +	default 0x0
> +	help
> +	 Address within the MTD device where the U-boot payload is fetched
> +	 from.
> +

Maybe default to SYS_SPI_U_BOOT_OFFS? or CONFIG_SYS_NAND_U_BOOT_OFFS?

>   config SYS_SPI_U_BOOT_OFFS
>   	hex "address of u-boot payload in SPI flash"
>   	default 0x8000 if ARCH_SUNXI
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..67fc1cd1b396 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
>   obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
> +obj-$(CONFIG_SPL_MTD_LOAD) += spl_mtd.o

Does this need a $(PHASE_)? (I don't know, but the others have it)

>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
>   endif
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> new file mode 100644
> index 000000000000..904f1fbad834
> --- /dev/null
> +++ b/common/spl/spl_mtd.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Generic SPL loader for MTD devices.
> + *
> + * Based on spl_spi.c, which is:
> + *
> + * Copyright (C) 2011 OMICRON electronics GmbH
> + *
> + * based on drivers/mtd/nand/raw/nand_spl_load.c
> + *
> + * Copyright (C) 2011
> + * Heiko Schocher, DENX Software Engineering, hs@denx.de.
> + */
> +
> +#include <config.h>
> +#include <errno.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <spl_load.h>
> +
> +#include <dm.h>
> +#include <dm/ofnode.h>
> +#include <dm/uclass.h>
> +#include <mtd.h>
> +
> +static struct mtd_info *spl_mtd_get_device(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device_by_seq(UCLASS_MTD, CONFIG_SYS_SPL_MTD_SEQ, &dev);
> +	if (ret)
> +		return NULL;
> +
> +	return dev_get_uclass_priv(dev);
> +}
> +
> +static ulong spl_mtd_read(struct spl_load_info *load,
> +			  ulong offs, ulong size, void *buf)
> +{
> +	struct mtd_info *mtd = load->priv;
> +	size_t retlen;
> +	int ret;
> +
> +	ret = mtd_read(mtd, offs, size, &retlen, buf);
> +	if (ret && !mtd_is_bitflip(ret))
> +		return 0;
> +
> +	if (retlen != size)
> +		return 0;

You can just return retlen here. We check it against size in spl_load.

> +
> +	return retlen;
> +}
> +
> +static int spl_mtd_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	struct spl_load_info load;
> +	struct mtd_info *mtd;
> +	ulong offset;
> +
> +	mtd = spl_mtd_get_device();
> +	if (!mtd) {
> +		puts("SPL: No MTD device found\n");
> +		return -ENODEV;
> +	}
> +
> +	spl_load_init(&load, spl_mtd_read, mtd, mtd->writesize);
> +
> +	offset = CONFIG_SYS_MTD_U_BOOT_OFFS;
> +
> +	if (CONFIG_IS_ENABLED(OF_REAL))
> +		offset = ofnode_conf_read_int("u-boot,spl-payload-offset",
> +					      offset);
> +
> +	return spl_load(spl_image, bootdev, &load, 0, offset);
> +}
> +
> +/* Priority 1 so boards may override */
> +SPL_LOAD_IMAGE_METHOD("MTD-NAND", 1, BOOT_DEVICE_NAND, spl_mtd_load_image);
> +SPL_LOAD_IMAGE_METHOD("MTD-SPI-NAND", 1, BOOT_DEVICE_SPI, spl_mtd_load_image);

Should these be a different priority than the "native" loaders? Does it make sense
to have both enabled or should we disable native loaders in Kconfig so we don't have
to consider this?

Actually, if CONFIG_SPL_NAND_SUPPORT is enabled then the native nand loader is compiled.
Maybe we should add a separate Kconfig for it (CONFIG_SPL_NAND_LOAD) defaulting to
SPL_NAND_SUPPORT. Then users can disable the "native" load method if they want to use MTD.

> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index ce05e206073d..0856a8f68732 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -34,6 +34,7 @@ else
>   ifneq ($(mtd-y),)
>   obj-$(CONFIG_SPL_MTD) += mtd.o
>   endif
> +obj-$(CONFIG_SPL_MTD_LOAD) += nand/

Is this necessary? Shouldn't the user just enable CONFIG_SPL_NAND_SUPPORT?

>   obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
>   obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
>   obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index c8169cf73902..4bc11054ad74 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -1,10 +1,12 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
> -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>   nandcore-objs := core.o bbt.o
> +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>   obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>   obj-$(CONFIG_MTD_RAW_NAND) += raw/
>   obj-$(CONFIG_MTD_SPI_NAND) += spi/
>   else
> +obj-$(CONFIG_SPL_MTD_LOAD) += nandcore.o

Shouldn't this be CONFIG_SPL_MTD_SPI_NAND too?

> +obj-$(CONFIG_SPL_MTD_SPI_NAND) += spi/
>   obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
>   endif
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 525e0c9e86c6..5b06fa419dbf 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -113,6 +113,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
>   	IS_ENABLED(CONFIG_SPL_SEMIHOSTING) + \
>   	IS_ENABLED(CONFIG_SPL_SPI_LOAD) + \
> +	IS_ENABLED(CONFIG_SPL_MTD_LOAD) + \

Please keep this alphabetical.

And still needs tests, but hopefully those should be simple to implement based
on my reply to v1.

--Sean

>   	0
>   
>   #if SPL_LOAD_USERS > 1

