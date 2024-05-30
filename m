Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4553CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 12:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858EF886E8;
	Thu, 30 May 2024 14:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="t+MJsYSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F26B886EE; Thu, 30 May 2024 14:18:36 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97E7886AE
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 14:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1717071513; x=1719663513;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EhGbi+XpgHpIhv2r8rScMYY8oEIT5/2mBCXcvZEJo2U=;
 b=t+MJsYSEpphjbHGkg4ubEKownBqgdzEvSvNdD5EG660VnZzs0JqVm+KcirL1A3Pp
 hntiJfyN1z1XU5ItCw+LJkV1i5OiIYEA7PPIg4lePNdU9nFyVoLmfLlneeR89h4m
 Bov1//1xbKm4iM+SsmD+78k+X9+R/i9+bnCJFZCQxZw=;
X-AuditID: ac14000a-03e52700000021bc-04-66586e99feef
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8A.62.08636.99E68566;
 Thu, 30 May 2024 14:18:33 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 30 May
 2024 14:18:32 +0200
Message-ID: <89aba782-fbc2-463e-ae93-f38dca3da534@phytec.de>
Date: Thu, 30 May 2024 14:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] board: ti: Pull redundant DDR functions to a
 common location and Fixup DDR size when ECC is enabled
To: Santhosh Kumar K <s-k6@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>
References: <20240523050430.455201-1-s-k6@ti.com>
 <20240523050430.455201-8-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240523050430.455201-8-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWyRpKBR3dmXkSawfl/LBZz3xxgtbj0INXi
 5I1Wdos3P84yWax/sonNYuqkzewWb/d2sltM2zuD2eL/2Q/sDpwerw6sYvc4e2cHo8fxG9uZ
 ApijuGxSUnMyy1KL9O0SuDJWnvvCWtDuUNG6tKaBcZFxFyMnh4SAicSBeTeZQWwhgSVMEht3
 c3cxcgHZdxklJk+6D5bgFbCReDn7DCOIzSKgKvFrz3QWiLigxMmZT8BsUQF5ifu3ZrCDNAsL
 NDJKPH3cCeaICPQzSnScbWUFqWIW0JNYcuQeK8S6SIn3k86zQ8TFJW49mc8EYrMJqEvc2fAN
 qIaDg1PASGLWYk6IEguJxW8OQpXLS2x/OwfqanmJF5eWs0B8Iy8x7dxrZgg7VOLIptVMExiF
 ZyG5dRaSbbOQjJ2FZOwCRpZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEHxI8LAtYOxb47HIUYm
 DsZDjBIczEoivL/SI9KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2C
 yTJxcEo1MPYKhS+fayy6sFRchWtS3EZZhYZdIRNjMrqeXTis7rA81vAhz78H4Z0R7U//ndhT
 ODFrVvSd0ukBXmribhtSDVLdOSfdv3PvSoFX6X7xRWK+fOHf9XKm1ni6RyVkMy0OWlvsYWhk
 nZTy6n716ewDF2rXbzt5XO/Y243L56n03v5r2iIx6cWSbiWW4oxEQy3mouJEAJQux52NAgAA
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

Hi Santhosh,

thanks for this series!

Am 23.05.24 um 07:04 schrieb Santhosh Kumar K:
> As there are few redundant functions in board/ti/*/evm.c files, pull
> them to a common location of access to reuse and include the common file
> to access the functions.
> 
> Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
> device tree and resize the available amount of DDR, if ECC is enabled.
> Otherwise, fixup the device tree using the regular
> fdt_fixup_memory_banks().
> 
> Also call dram_init_banksize() after every call to
> fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
> correctly.
> 
> Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
> controllers present.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
[...]
> +++ b/board/ti/common/k3-ddr-init.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023, Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <fdt_support.h>
> +#include <dm/uclass.h>
> +#include <k3-ddrss.h>
> +#include <spl.h>
> +
> +#include "k3-ddr-init.h"
> +
> +int dram_init(void)
> +{
> +	s32 ret;
> +
> +	ret = fdtdec_setup_mem_size_base_lowest();
> +	if (ret)
> +		printf("Error setting up mem size and base. %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	s32 ret;
> +
> +	ret = fdtdec_setup_memory_banksize();
> +	if (ret)
> +		printf("Error setting up memory banksize. %d\n", ret);
> +
> +	return ret;
> +}

I'm wondering if we can generalize more.

What do you say if we keep dram_init() & dram_init_banksize() in the 
board code and move fixup_ddr_driver_for_ecc() & fixup_memory_node() to 
mach-k3 and make them available for all K3 based boards?

It looks like I will reuse the code for our boards and I assume other 
vendors too.

Regards,
Wadim

> +
> +#if defined(CONFIG_SPL_BUILD)
> +
> +void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
> +{
> +	struct udevice *dev;
> +	int ret, ctr = 1;
> +
> +	dram_init_banksize();
> +
> +	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +	if (ret)
> +		panic("Cannnot get RAM device for ddr size fixup: %d\n", ret);
> +
> +	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
> +	if (ret)
> +		printf("Error fixing up ddr node for ECC use! %d\n", ret);
> +
> +	dram_init_banksize();
> +
> +	ret = uclass_next_device_err(&dev);
> +
> +	while (!ret) {
> +		ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
> +		if (ret)
> +			printf("Error fixing up ddr node %d for ECC use! %d\n", ctr, ret);
> +
> +		dram_init_banksize();
> +		ret = uclass_next_device_err(&dev);
> +		ctr++;
> +	}
> +}
> +
> +void fixup_memory_node(struct spl_image_info *spl_image)
> +{
> +	u64 start[CONFIG_NR_DRAM_BANKS];
> +	u64 size[CONFIG_NR_DRAM_BANKS];
> +	int bank;
> +	int ret;
> +
> +	dram_init();
> +	dram_init_banksize();
> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		start[bank] = gd->bd->bi_dram[bank].start;
> +		size[bank] = gd->bd->bi_dram[bank].size;
> +	}
> +
> +	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
> +				     CONFIG_NR_DRAM_BANKS);
> +
> +	if (ret)
> +		printf("Error fixing up memory node! %d\n", ret);
> +}
> +
> +#endif
> diff --git a/board/ti/common/k3-ddr-init.h b/board/ti/common/k3-ddr-init.h
> new file mode 100644
> index 000000000000..9d1826815dfd
> --- /dev/null
> +++ b/board/ti/common/k3-ddr-init.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2023, Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef __K3_DDR_INIT_H
> +#define __K3_DDR_INIT_H
> +
> +int dram_init(void);
> +int dram_init_banksize(void);
> +
> +void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
> +void fixup_memory_node(struct spl_image_info *spl_image);
> +
> +#endif /* __K3_DDR_INIT_H */
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 539eaf47186a..e0cd8529bc2b 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -17,6 +17,7 @@
>   
>   #include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
> +#include "../common/k3-ddr-init.h"
>   
>   #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
>   				 board_ti_k3_is("J721EX-PM2-SOM"))
> @@ -37,17 +38,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -#ifdef CONFIG_PHYS_64BIT
> -	gd->ram_size = 0x100000000;
> -#else
> -	gd->ram_size = 0x80000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   {
>   #ifdef CONFIG_PHYS_64BIT
> @@ -59,23 +49,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return gd->ram_top;
>   }
>   
> -int dram_init_banksize(void)
> -{
> -	/* Bank 0 declares the memory available in the DDR low region */
> -	gd->bd->bi_dram[0].start = 0x80000000;
> -	gd->bd->bi_dram[0].size = 0x80000000;
> -	gd->ram_size = 0x80000000;
> -
> -#ifdef CONFIG_PHYS_64BIT
> -	/* Bank 1 declares the memory available in the DDR high region */
> -	gd->bd->bi_dram[1].start = 0x880000000;
> -	gd->bd->bi_dram[1].size = 0x80000000;
> -	gd->ram_size = 0x100000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   #ifdef CONFIG_SPL_LOAD_FIT
>   int board_fit_config_name_match(const char *name)
>   {
> diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
> index 5a0281d6b483..fca30107cddb 100644
> --- a/board/ti/j721s2/evm.c
> +++ b/board/ti/j721s2/evm.c
> @@ -24,6 +24,7 @@
>   
>   #include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
> +#include "../common/k3-ddr-init.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -32,17 +33,6 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> -{
> -#ifdef CONFIG_PHYS_64BIT
> -	gd->ram_size = 0x100000000;
> -#else
> -	gd->ram_size = 0x80000000;
> -#endif
> -
> -	return 0;
> -}
> -
>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   {
>   #ifdef CONFIG_PHYS_64BIT
> @@ -54,22 +44,17 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return gd->ram_top;
>   }
>   
> -int dram_init_banksize(void)
> +#if defined(CONFIG_SPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -	/* Bank 0 declares the memory available in the DDR low region */
> -	gd->bd->bi_dram[0].start = 0x80000000;
> -	gd->bd->bi_dram[0].size = 0x7fffffff;
> -	gd->ram_size = 0x80000000;
> -
> -#ifdef CONFIG_PHYS_64BIT
> -	/* Bank 1 declares the memory available in the DDR high region */
> -	gd->bd->bi_dram[1].start = 0x880000000;
> -	gd->bd->bi_dram[1].size = 0x37fffffff;
> -	gd->ram_size = 0x400000000;
> -#endif
> -
> -	return 0;
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
> +#endif
>   
>   #ifdef CONFIG_TI_I2C_BOARD_DETECT
>   /*
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index aed0ea5b9495..73056a16dd5f 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -10,6 +10,7 @@
>   #include <init.h>
>   #include <spl.h>
>   #include "../common/fdt_ops.h"
> +#include "../common/k3-ddr-init.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -18,15 +19,17 @@ int board_init(void)
>   	return 0;
>   }
>   
> -int dram_init(void)
> +#if defined(CONFIG_SPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
>   {
> -	return fdtdec_setup_mem_size_base();
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	return fdtdec_setup_memory_banksize();
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
>   }
> +#endif
>   
>   #ifdef CONFIG_BOARD_LATE_INIT
>   int board_late_init(void)
