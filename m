Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F95CE909C0
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 15:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5427983C32;
	Tue, 17 Feb 2026 16:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aX/uxdGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3897183C72; Tue, 17 Feb 2026 16:11:28 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52A183AC5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 16:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-5069fd561a8so8403711cf.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771341085; x=1771945885; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5b8rdpe1HHALjjN6sV/4V8uIITDZwJjJwijt65UUrcc=;
 b=aX/uxdGOXdjewQ1HNMpIgJqffvhypfqSornZYsySGZdIYjLB/UPQrrSjJTwxbeA2Kx
 LOjIsyrDJzeS0/37FIy2UpUCu/eKJewxcI4aDxOkn/5PUI1CKLtJxyknj7lEw46sDEno
 9UG30/wViOJdvETQ3gCnmrmSox6nvqwKGb1yxQBW9bBDDZOvusjXTO/e2E7k6N4nLRE9
 z6TjP13v0OvXPmSJjvrzqQtYN89rAIfGOe1QSgwE18v7qEGp8vB/YuNIJKqt2R5jeI94
 BXykw5N+ZM99Q2yamD2A0WDqf18jZkZmrGQN0SdVAw6B/pc78mm6a/YulHR3uFPhjsLr
 gNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771341085; x=1771945885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5b8rdpe1HHALjjN6sV/4V8uIITDZwJjJwijt65UUrcc=;
 b=s5EYUAbQ34ndukryF8W3WcVlY+vI6ELM7yNUUdAfy1+9ORobpOrgs6tCG/5lIGNDJz
 RAq27FnI6ZmU9vHCuMHqurkTriCVZemb8dPpRiSLAlLwOcMFGQl4JU7AxKSfkDLsB03E
 bCqeXPWBVhQ8Lk3DCvwMDcR7u9PvEJ9w1EgNkcXdKfdL8rNdXARiX2W9dX9QTuu1u6KB
 d0XDqajzvoBUvjpuXZTKAeCnoi8uAA3Pk+QVzcnNN5MqHneZ/AIdlMYCgl8QwEfRBJCF
 uvZf1W8McDb6ZsTMXghcs8BWyH6HEEzoQl5D9hKs/JDP8Bb5mDjMfEb3Z4QxrTJ6PlIp
 adxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXSsRPAT8dHEVGGrVUFYv2A2rkgtiQPhe4k0wFPcanI3pdLJvSZq0/X+5VNORst9L8LZhqdoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz47NujrRO5EPkjN54vxxx1ZZwbcUDIDIzFDK1ATKS3cG5diH/o
 jpSqNhItpnR34Lc0EqyjUEBaCsj04MGuJlOPzXEYsPoYrVoRCJRKrYTj
X-Gm-Gg: AZuq6aIRY94aLQVh4rNO3lD1NPNRqY95jAdZI9TyhQrKXnL9qxwsCIqOWMSFORx252l
 XWruSV1Zx9hO9BWpt/Kigwhf9r0YSMwpxxw1ujIfFzrfDklEhRfN8cqu4y8+WSEGq0mTNH+16r/
 q6icq6ofohSmZDNxpGU+fFwG7vuvYu4Df0aOrq4Aiw9R30MOwPvf990Md75VOnMUyVsZubyAtzF
 noN4snXt2j7qVq2YIz/Ej9YrlCIBPEV+/E2n4A+glT265K5MVUXtM64iJYSkZcn8YTpcZHZuARJ
 1IMczgKGgF5OciEqCDP8U3M5vms56C4Zbaocnh5wqR62Iz4xrM/fz09lqjg8YHsqbWbzCnUQQHM
 nTZ7gGqhgxXhBOw4gnwso7+iKNQYVkMOi3j0Mz0ZzLY/cWCTZLOFUmhLQnoUzUmps8m2k7CnkNF
 nGuqhOmiqgj5eZVWXl2qOXq2JKB4k0I16SRam/U+7WQRnGyO08kyfrGAIvRYON5cvbbP8=
X-Received: by 2002:a05:620a:1925:b0:8c6:f7ad:49b with SMTP id
 af79cd13be357-8cb408839bcmr1435937685a.5.1771341084533; 
 Tue, 17 Feb 2026 07:11:24 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b1c8505sm1506166785a.25.2026.02.17.07.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 07:11:24 -0800 (PST)
Message-ID: <2b5ebaa9-76f1-e2b0-4e8c-fc8b6c197136@gmail.com>
Date: Tue, 17 Feb 2026 10:11:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: Add generic SPL MTD loader support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, michael@amarulasolutions.com
Cc: dinesh.maniyam@altera.com, jonas@kwiboo.se, trini@konsulko.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@nabladev.com>
References: <20260211222550.739727-1-festevam@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260211222550.739727-1-festevam@gmail.com>
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

On 2/11/26 17:25, Fabio Estevam wrote:
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

Thanks for putting this together. For platforms that have the space this
is definitely the way to go.

> ---
> Dinesh,
> 
> Could you please test this approach on your boards?
> 
> Thanks
> 
>   common/spl/Kconfig        | 15 +++++++
>   common/spl/Makefile       |  1 +
>   common/spl/spl_mtd.c      | 88 +++++++++++++++++++++++++++++++++++++++
>   drivers/mtd/Makefile      |  1 +
>   drivers/mtd/nand/Makefile | 12 +++++-
>   5 files changed, 116 insertions(+), 1 deletion(-)
>   create mode 100644 common/spl/spl_mtd.c
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 2998b7acb75f..2aba6da73c10 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1576,8 +1576,23 @@ config SPL_SPI_LOAD
>   	  Enable support for loading next stage, U-Boot or otherwise, from
>   	  SPI NOR in U-Boot SPL.
>   
> +config SPL_MTD_LOAD
> +	bool "Support loading from a generic MTD device"
> +	depends on SPL
> +	depends on MTD && DM_MTD
> +	help
> +	  Enable support for loading next stage, U-Boot or otherwise, from
> +	  a generic MTD device (raw NAND, SPI NAND) in U-Boot SPL.
> +
>   endif # SPL_SPI_FLASH_SUPPORT
>   
> +config SYS_MTD_U_BOOT_OFFS
> +	hex "address of u-boot payload in the MTD device"
> +	default 0x0
> +	help
> +	 Address within the MTD device where the u-boot payload is fetched
> +	 from.
> +
>   config SYS_SPI_U_BOOT_OFFS
>   	hex "address of u-boot payload in SPI flash"
>   	default 0x8000 if ARCH_SUNXI
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..9f5ddcad17af 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
>   obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
> +obj-$(CONFIG_$(PHASE_)MTD_LOAD) += spl_mtd.o
>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
>   endif
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> new file mode 100644
> index 000000000000..8c6c94e592d0
> --- /dev/null
> +++ b/common/spl/spl_mtd.c
> @@ -0,0 +1,88 @@
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
> +	for (ret = uclass_first_device_err(UCLASS_MTD, &dev);
> +	     dev;
> +	     ret = uclass_next_device_err(&dev)) {
> +		if (ret)
> +			continue;
> +
> +		return dev_get_uclass_priv(dev);
> +	}

I think this should be uclass_get_device_by_seq(UCLASS_MTD,
CONFIG_SYS_MTD_SEQ) or use the above method if e.g.
CONFIG_SYS_MTD_U_BOOT_OFFS is -1.

> +
> +	return NULL;
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
> +		debug("No MTD device found\n");

This should be a puts, as otherwise there will be no error printed at all.

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
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index ce05e206073d..0856a8f68732 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -34,6 +34,7 @@ else
>   ifneq ($(mtd-y),)
>   obj-$(CONFIG_SPL_MTD) += mtd.o
>   endif
> +obj-$(CONFIG_SPL_MTD_LOAD) += nand/

You should add this to the list in include/spl_load.h.

>   obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
>   obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
>   obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index c8169cf73902..cd6eaa87739c 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -1,10 +1,20 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
> -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>   nandcore-objs := core.o bbt.o
> +
> +ifeq ($(CONFIG_XPL_BUILD),)
> +
> +# U-Boot proper
>   obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>   obj-$(CONFIG_MTD_RAW_NAND) += raw/
>   obj-$(CONFIG_MTD_SPI_NAND) += spi/
> +
>   else
> +
> +# XPL
> +obj-$(CONFIG_SPL_MTD_LOAD) += nandcore.o
> +obj-$(CONFIG_SPL_MTD_LOAD) += spi/

This should be done in Kconfig. Some platforms may want to load from different
MTD combinations, e.g. SPI nand and SPI nor.

> +
> +# raw NAND still follows the normal SPL rule
>   obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
>   endif

Please add a test for this. You should be able to extend test/image/spl_load_spi.c
and test/image/spl_load_nand.c

--Sean
