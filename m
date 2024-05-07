Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AC7C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 16:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B52088784;
	Tue,  7 May 2024 18:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TSdqC8rQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A895C8879A; Tue,  7 May 2024 18:09:25 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F1188662
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 18:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1715098162; x=1717690162;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=snRBsGoQhJoM2ERl/k4402TX0WBEvMgw66zbiWi+qDY=;
 b=TSdqC8rQA33H+0xC7eMe23D30UfeNvJ6NpzcApaLV1ZsvxDRbxQ9Rf64yLD69Lwr
 E8206kO46uPEZPQMDHwnaNKyudNny7016yfh+rOxth8hmws5KFQVnb05u8UV37lK
 RKOGC0cGdRUKTR9vnCQt5zafwjNc179VEfIU/uigr50=;
X-AuditID: ac14000a-fbefe7000000290d-a2-663a5232f2e5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 41.89.10509.2325A366;
 Tue,  7 May 2024 18:09:22 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 7 May 2024
 18:09:13 +0200
Message-ID: <0753993f-8e5a-416c-920f-725854b8795f@phytec.de>
Date: Tue, 7 May 2024 18:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] board: phytec: am62x: Add support for 1 & 4 GB RAM
 variants
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <nm@ti.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <t.remmet@phytec.de>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <joao.goncalves@toradex.com>, <n-jain1@ti.com>,
 <michael@amarulasolutions.com>, <d-gole@ti.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <jma@phytec.com>
References: <20240507151757.1202825-1-w.egorov@phytec.de>
 <20240507151757.1202825-6-w.egorov@phytec.de>
Content-Language: de-DE
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240507151757.1202825-6-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWyRpKBR9coyCrNYNk9TYv3pyayW8x9c4DV
 4kB/L6NFy1oPi4dX/S2edTYxW1y+f5PV4tKDVItTja0sFi+OzWW36P//nMnizY+zTBbftmxj
 tJg6aTO7xdu9newW3e/UHQQ81n68z+rx/kYru8fshossHjtn3WX3eHVgFbvH2Ts7GD36u1tY
 Pf5cfMfqcfzGdiaPTa88AriiuGxSUnMyy1KL9O0SuDImrFnLVrChsOLXsUMsDYxfIrsYOTgk
 BEwkrt0J6mLk4hASWMIkseVRByOEc5NR4vq3Z2xdjJwcvAI2Egt+HWAHsVkEVCSW/VsDFReU
 ODnzCQuILSogL3H/1gywGmGBMIl1Kz+BxUUEoiXuvu9jAhnKLHCdSeL3hm1gCSGBTIlnTZuZ
 QGxmAXGJTc++s4LYbAJaEne2zGUGsTkFrCQuf+hmg6ixkFj85iA7hC0vsf3tHGaIOQoSs7dN
 ZgSxJYDi0869ZoawQyW2ftnONIFReBaSW2chWTcLydhZSMYuYGRZxSiUm5mcnVqUma1XkFFZ
 kpqsl5K6iREUxSIMXDsY++Z4HGJk4mA8xCjBwawkwnu03TxNiDclsbIqtSg/vqg0J7X4EKM0
 B4uSOO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUA2OmnM/x1UudZ/Z+Nvc4pjrx9sJJ7EJPtNod
 vznfapA0Ek7Rnf+L47p+7Y8OyXw9Tr0mN4+JVkZsZ4NnZH6aPGFfCG8tz8cDTUbJyaek/50/
 93NNgMpjk4PfZ803cvHQa/q6vtXvvVC3gcGhc3kMN9YcdvMuPHPcIEtS6ceMTk+LWYeNjnx5
 VKvEUpyRaKjFXFScCAAlteog0AIAAA==
X-Mailman-Approved-At: Tue, 07 May 2024 18:13:17 +0200
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

Hey Wadim,

On 07.05.24 17:17, Wadim Egorov wrote:
> Use content of EEPROM to detect the actual RAM size and adjust
> DDR timings, size and banks accordingly.
> Also enable the SoM detection per default in the defconfigs.
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   board/phytec/common/am6_som_detection.h       |   8 +
>   board/phytec/phycore_am62x/phycore-am62x.c    | 152 ++++++++++++-
>   board/phytec/phycore_am62x/phycore-ddr-data.h | 206 ++++++++++++++++++
>   configs/phycore_am62x_a53_defconfig           |   4 +
>   configs/phycore_am62x_r5_defconfig            |   4 +
>   5 files changed, 372 insertions(+), 2 deletions(-)
>   create mode 100644 board/phytec/phycore_am62x/phycore-ddr-data.h
>
> diff --git a/board/phytec/common/am6_som_detection.h b/board/phytec/common/am6_som_detection.h
> index 032f9da3aab..c5c6e179da6 100644
> --- a/board/phytec/common/am6_som_detection.h
> +++ b/board/phytec/common/am6_som_detection.h
> @@ -9,11 +9,19 @@
>   
>   #include "phytec_som_detection.h"
>   
> +#define EEPROM_ADDR				0x50
>   #define PHYTEC_AM62X_SOM			71
>   #define PHYTEC_AM64X_SOM			72
>   #define PHYTEC_EEPROM_VALUE_X			0x21
>   #define PHYTEC_EEPROM_NOR_FLASH_64MB_QSPI	0xC
>   
> +enum {
> +	EEPROM_RAM_SIZE_512MB = 0,
> +	EEPROM_RAM_SIZE_1GB = 1,
> +	EEPROM_RAM_SIZE_2GB = 2,
> +	EEPROM_RAM_SIZE_4GB = 4
> +};
> +
>   int __maybe_unused phytec_am6_detect(struct phytec_eeprom_data *data);
>   u8 __maybe_unused phytec_get_am6_ddr_size(struct phytec_eeprom_data *data);
>   u8 __maybe_unused phytec_get_am6_spi(struct phytec_eeprom_data *data);
> diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
> index a082b886bda..4a76f1343d7 100644
> --- a/board/phytec/phycore_am62x/phycore-am62x.c
> +++ b/board/phytec/phycore_am62x/phycore-am62x.c
> @@ -8,6 +8,13 @@
>   #include <spl.h>
>   #include <fdt_support.h>
>   
> +#include "phycore-ddr-data.h"
> +#include "../common/k3/k3_ddrss_patch.h"
> +#include "../common/am6_som_detection.h"
> +
> +#define AM64_DDRSS_SS_BASE	0x0F300000
> +#define DDRSS_V2A_CTL_REG	0x0020
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   int board_init(void)
> @@ -15,16 +22,157 @@ int board_init(void)
>   	return 0;
>   }
>   
> +static u8 phytec_get_am62_ddr_size_default(void)
> +{
> +	int ret;
> +	struct phytec_eeprom_data data;
> +
> +	if (IS_ENABLED(CONFIG_PHYCORE_AM62X_RAM_SIZE_FIX)) {
> +		if (IS_ENABLED(CONFIG_PHYCORE_AM62X_RAM_SIZE_1GB))
> +			return EEPROM_RAM_SIZE_1GB;
> +		else if (IS_ENABLED(CONFIG_PHYCORE_AM62X_RAM_SIZE_2GB))
> +			return EEPROM_RAM_SIZE_2GB;
> +		else if (IS_ENABLED(CONFIG_PHYCORE_AM62X_RAM_SIZE_4GB))
> +			return EEPROM_RAM_SIZE_4GB;
> +	}

Please define these configs in board/phytec/phycore_am62x/Kconfig.

- Daniel

> +
> +	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
> +	if (!ret && data.valid)
> +		return phytec_get_am6_ddr_size(&data);
> +
> +	/* Default DDR size is 2GB */
> +	return EEPROM_RAM_SIZE_2GB;
> +}
> +
>   int dram_init(void)
>   {
> -	return fdtdec_setup_mem_size_base();
> +	u8 ram_size = phytec_get_am62_ddr_size_default();
> +
> +	/*
> +	 * HACK: ddrss driver support 2GB RAM by default
> +	 * V2A_CTL_REG should be updated to support other RAM size
> +	 */
> +	if (IS_ENABLED(CONFIG_K3_AM64_DDRSS))
> +		if (ram_size == EEPROM_RAM_SIZE_4GB)
> +			writel(0x00000210, AM64_DDRSS_SS_BASE + DDRSS_V2A_CTL_REG);
> +
> +	switch (ram_size) {
> +	case EEPROM_RAM_SIZE_1GB:
> +		gd->ram_size = 0x40000000;
> +		break;
> +	case EEPROM_RAM_SIZE_2GB:
> +		gd->ram_size = 0x80000000;
> +		break;
> +	case EEPROM_RAM_SIZE_4GB:
> +#ifdef CONFIG_PHYS_64BIT
> +		gd->ram_size = 0x100000000;
> +#else
> +		gd->ram_size = 0x80000000;
> +#endif
> +		break;
> +	default:
> +		gd->ram_size = 0x80000000;
> +	}
> +
> +	return 0;
> +}
> +
> +phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +#ifdef CONFIG_PHYS_64BIT
> +	/* Limit RAM used by U-Boot to the DDR low region */
> +	if (gd->ram_top > 0x100000000)
> +		return 0x100000000;
> +#endif
> +	return gd->ram_top;
>   }
>   
>   int dram_init_banksize(void)
>   {
> -	return fdtdec_setup_memory_banksize();
> +	u8 ram_size;
> +
> +	ram_size = phytec_get_am62_ddr_size_default();
> +	switch (ram_size) {
> +	case EEPROM_RAM_SIZE_1GB:
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x40000000;
> +		gd->ram_size = 0x40000000;
> +		break;
> +
> +	case EEPROM_RAM_SIZE_2GB:
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x80000000;
> +		gd->ram_size = 0x80000000;
> +		break;
> +
> +	case EEPROM_RAM_SIZE_4GB:
> +		/* Bank 0 declares the memory available in the DDR low region */
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x80000000;
> +		gd->ram_size = 0x80000000;
> +
> +#ifdef CONFIG_PHYS_64BIT
> +		/* Bank 1 declares the memory available in the DDR upper region */
> +		gd->bd->bi_dram[1].start = 0x880000000;
> +		gd->bd->bi_dram[1].size = 0x80000000;
> +		gd->ram_size = 0x100000000;
> +#endif
> +		break;
> +	default:
> +		/* Continue with default 2GB setup */
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x80000000;
> +		gd->ram_size = 0x80000000;
> +		printf("DDR size %d is not supported\n", ram_size);
> +	}
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_K3_DDRSS)
> +int update_ddrss_timings(void)
> +{
> +	int ret;
> +	u8 ram_size;
> +	struct ddrss *ddr_patch = NULL;
> +	void *fdt = (void *)gd->fdt_blob;
> +
> +	ram_size = phytec_get_am62_ddr_size_default();
> +	switch (ram_size) {
> +	case EEPROM_RAM_SIZE_1GB:
> +		ddr_patch = &phycore_ddrss_data[PHYCORE_1GB];
> +		break;
> +	case EEPROM_RAM_SIZE_2GB:
> +		ddr_patch = NULL;
> +		break;
> +	case EEPROM_RAM_SIZE_4GB:
> +		ddr_patch = &phycore_ddrss_data[PHYCORE_4GB];
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* Nothing to patch */
> +	if (!ddr_patch)
> +		return 0;
> +
> +	debug("Applying DDRSS timings patch for ram_size %d\n", ram_size);
> +
> +	ret = fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
> +	if (ret < 0) {
> +		printf("Failed to apply ddrs timings patch %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
> +int do_board_detect(void)
> +{
> +	return update_ddrss_timings();
> +}
> +#endif
> +
>   #define CTRLMMR_USB0_PHY_CTRL   0x43004008
>   #define CTRLMMR_USB1_PHY_CTRL   0x43004018
>   #define CORE_VOLTAGE            0x80000000
> diff --git a/board/phytec/phycore_am62x/phycore-ddr-data.h b/board/phytec/phycore_am62x/phycore-ddr-data.h
> new file mode 100644
> index 00000000000..fe6eccd959e
> --- /dev/null
> +++ b/board/phytec/phycore_am62x/phycore-ddr-data.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#ifndef PHYCORE_DDR_DATA
> +#define PHYCORE_DDR_DATA
> +
> +#include "../common/k3/k3_ddrss_patch.h"
> +
> +/* 1 GB variant delta */
> +struct ddr_reg ddr_1gb_ctl_regs[] = {
> +	{ 55, 0x0400DB60 },
> +	{ 58, 0x0400DB60 },
> +	{ 61, 0x0400DB60 },
> +	{ 73, 0x00001860 },
> +	{ 75, 0x00001860 },
> +	{ 77, 0x00001860 },
> +	{ 119, 0x00061800 },
> +	{ 120, 0x00061800 },
> +	{ 121, 0x00061800 },
> +	{ 122, 0x00061800 },
> +	{ 123, 0x00061800 },
> +	{ 125, 0x0000AAA0 },
> +	{ 126, 0x00061800 },
> +	{ 127, 0x00061800 },
> +	{ 128, 0x00061800 },
> +	{ 129, 0x00061800 },
> +	{ 130, 0x00061800 },
> +	{ 132, 0x0000AAA0 },
> +	{ 133, 0x00061800 },
> +	{ 134, 0x00061800 },
> +	{ 135, 0x00061800 },
> +	{ 136, 0x00061800 },
> +	{ 137, 0x00061800 },
> +	{ 139, 0x0000AAA0 },
> +	{ 206, 0x00000000 },
> +	{ 209, 0x00000000 },
> +	{ 212, 0x00000000 },
> +	{ 215, 0x00000000 },
> +	{ 218, 0x00000000 },
> +	{ 221, 0x00000000 },
> +	{ 230, 0x00000000 },
> +	{ 231, 0x00000000 },
> +	{ 232, 0x00000000 },
> +	{ 233, 0x00000000 },
> +	{ 234, 0x00000000 },
> +	{ 235, 0x00000000 },
> +	{ 316, 0x01010000 },
> +	{ 318, 0x3FFF0000 },
> +	{ 327, 0x00000C01 },
> +	{ 328, 0x00000000 },
> +	{ 385, 0x000030C0 },
> +	{ 390, 0x0000DB60 },
> +	{ 391, 0x0001E780 },
> +	{ 394, 0x000030C0 },
> +	{ 399, 0x0000DB60 },
> +	{ 400, 0x0001E780 },
> +	{ 403, 0x000030C0 },
> +	{ 408, 0x0000DB60 },
> +	{ 409, 0x0001E780 }
> +};
> +
> +struct ddr_reg ddr_1gb_pi_regs[] = {
> +	{ 77, 0x04000100 },
> +	{ 176, 0x00001860 },
> +	{ 178, 0x00001860 },
> +	{ 180, 0x04001860 },
> +	{ 233, 0x0000C570 },
> +	{ 238, 0x0000C570 },
> +	{ 243, 0x0000C570 },
> +	{ 247, 0x000030C0 },
> +	{ 248, 0x0001E780 },
> +	{ 249, 0x000030C0 },
> +	{ 250, 0x0001E780 },
> +	{ 251, 0x000030C0 },
> +	{ 252, 0x0001E780 },
> +	{ 299, 0x00000000 },
> +	{ 301, 0x00000000 },
> +	{ 307, 0x00000000 },
> +	{ 309, 0x00000000 },
> +	{ 315, 0x00000000 },
> +	{ 317, 0x00000000 },
> +	{ 323, 0x00000000 },
> +	{ 325, 0x00000000 },
> +	{ 331, 0x00000000 },
> +	{ 333, 0x00000000 },
> +	{ 339, 0x00000000 },
> +	{ 341, 0x00000000 }
> +};
> +
> +struct ddr_reg ddr_1gb_phy_regs[] = {
> +	{ 1371, 0x0001F7C2 },
> +};
> +
> +/* 4 GB variant delta */
> +struct ddr_reg ddr_4gb_ctl_regs[] = {
> +	{ 55, 0x0400DB60 },
> +	{ 58, 0x0400DB60 },
> +	{ 61, 0x0400DB60 },
> +	{ 73, 0x00001860 },
> +	{ 75, 0x00001860 },
> +	{ 77, 0x00001860 },
> +	{ 119, 0x00061800 },
> +	{ 120, 0x00061800 },
> +	{ 121, 0x00061800 },
> +	{ 122, 0x00061800 },
> +	{ 123, 0x00061800 },
> +	{ 125, 0x0000AAA0 },
> +	{ 126, 0x00061800 },
> +	{ 127, 0x00061800 },
> +	{ 128, 0x00061800 },
> +	{ 129, 0x00061800 },
> +	{ 130, 0x00061800 },
> +	{ 132, 0x0000AAA0 },
> +	{ 133, 0x00061800 },
> +	{ 134, 0x00061800 },
> +	{ 135, 0x00061800 },
> +	{ 136, 0x00061800 },
> +	{ 137, 0x00061800 },
> +	{ 139, 0x0000AAA0 },
> +	{ 206, 0x00000000 },
> +	{ 209, 0x00000000 },
> +	{ 212, 0x00000000 },
> +	{ 215, 0x00000000 },
> +	{ 218, 0x00000000 },
> +	{ 221, 0x00000000 },
> +	{ 230, 0x00000000 },
> +	{ 231, 0x00000000 },
> +	{ 232, 0x00000000 },
> +	{ 233, 0x00000000 },
> +	{ 234, 0x00000000 },
> +	{ 235, 0x00000000 },
> +	{ 316, 0x00000000 },
> +	{ 318, 0x7FFF0000 },
> +	{ 327, 0x01000C01 },
> +	{ 328, 0x00000001 },
> +	{ 385, 0x000030C0 },
> +	{ 390, 0x0000DB60 },
> +	{ 391, 0x0001E780 },
> +	{ 394, 0x000030C0 },
> +	{ 399, 0x0000DB60 },
> +	{ 400, 0x0001E780 },
> +	{ 403, 0x000030C0 },
> +	{ 408, 0x0000DB60 },
> +	{ 409, 0x0001E780 }
> +};
> +
> +struct ddr_reg ddr_4gb_pi_regs[] = {
> +	{ 77, 0x04000000 },
> +	{ 176, 0x00001860 },
> +	{ 178, 0x00001860 },
> +	{ 180, 0x04001860 },
> +	{ 233, 0x0000C570 },
> +	{ 238, 0x0000C570 },
> +	{ 243, 0x0000C570 },
> +	{ 247, 0x000030C0 },
> +	{ 248, 0x0001E780 },
> +	{ 249, 0x000030C0 },
> +	{ 250, 0x0001E780 },
> +	{ 251, 0x000030C0 },
> +	{ 252, 0x0001E780 },
> +	{ 299, 0x00000000 },
> +	{ 301, 0x00000000 },
> +	{ 307, 0x00000000 },
> +	{ 309, 0x00000000 },
> +	{ 315, 0x00000000 },
> +	{ 317, 0x00000000 },
> +	{ 323, 0x00000000 },
> +	{ 325, 0x00000000 },
> +	{ 331, 0x00000000 },
> +	{ 333, 0x00000000 },
> +	{ 339, 0x00000000 },
> +	{ 341, 0x00000000 }
> +};
> +
> +struct ddr_reg ddr_4gb_phy_regs[] = {
> +	{ 1371, 0x0001F7C2 },
> +};
> +
> +enum {
> +	PHYCORE_1GB,
> +	PHYCORE_4GB,
> +};
> +
> +struct ddrss phycore_ddrss_data[] = {
> +	[PHYCORE_1GB] = {
> +		.ctl_regs = &ddr_1gb_ctl_regs[0],
> +		.ctl_regs_num = ARRAY_SIZE(ddr_1gb_ctl_regs),
> +		.pi_regs = &ddr_1gb_pi_regs[0],
> +		.pi_regs_num = ARRAY_SIZE(ddr_1gb_pi_regs),
> +		.phy_regs = &ddr_1gb_phy_regs[0],
> +		.phy_regs_num = ARRAY_SIZE(ddr_1gb_phy_regs),
> +	},
> +	[PHYCORE_4GB] = {
> +		.ctl_regs = &ddr_4gb_ctl_regs[0],
> +		.ctl_regs_num = ARRAY_SIZE(ddr_4gb_ctl_regs),
> +		.pi_regs = &ddr_4gb_pi_regs[0],
> +		.pi_regs_num = ARRAY_SIZE(ddr_4gb_pi_regs),
> +		.phy_regs = &ddr_4gb_phy_regs[0],
> +		.phy_regs_num = ARRAY_SIZE(ddr_4gb_phy_regs),
> +	},
> +};
> +
> +#endif /* PHYCORE_DDR_DATA */
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index fd36edc29dd..145887c0286 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SOC_K3_AM625=y
> +CONFIG_PHYTEC_SOM_DETECTION=y
>   CONFIG_TARGET_PHYCORE_AM62X_A53=y
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
> @@ -45,6 +46,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
>   CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> +CONFIG_SPL_I2C=y
>   CONFIG_SPL_DM_MAILBOX=y
>   CONFIG_SPL_DM_SPI_FLASH=y
>   CONFIG_SPL_POWER_DOMAIN=y
> @@ -73,6 +75,8 @@ CONFIG_CLK_TI_SCI=y
>   CONFIG_DMA_CHANNELS=y
>   CONFIG_TI_K3_NAVSS_UDMA=y
>   CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_OMAP24XX=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
> diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
> index 389672d5227..0062a4e3569 100644
> --- a/configs/phycore_am62x_r5_defconfig
> +++ b/configs/phycore_am62x_r5_defconfig
> @@ -6,6 +6,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
>   CONFIG_SOC_K3_AM625=y
> +CONFIG_PHYTEC_SOM_DETECTION=y
>   CONFIG_TARGET_PHYCORE_AM62X_R5=y
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
> @@ -50,6 +51,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
>   CONFIG_SPL_EARLY_BSS=y
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
> +CONFIG_SPL_I2C=y
>   CONFIG_SPL_DM_MAILBOX=y
>   CONFIG_SPL_DM_SPI_FLASH=y
>   CONFIG_SPL_DM_RESET=y
> @@ -88,6 +90,7 @@ CONFIG_SPL_CLK_K3_PLL=y
>   CONFIG_SPL_CLK_K3=y
>   CONFIG_TI_SCI_PROTOCOL=y
>   CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_I2C=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_SPL_MISC=y
> @@ -129,3 +132,4 @@ CONFIG_SPL_TIMER=y
>   CONFIG_OMAP_TIMER=y
>   CONFIG_LIB_RATIONAL=y
>   CONFIG_SPL_LIB_RATIONAL=y
> +CONFIG_SYS_I2C_OMAP24XX=y
