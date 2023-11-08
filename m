Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A671C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 07:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582FA87588;
	Wed,  8 Nov 2023 08:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hbWrpZIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A92E876DF; Wed,  8 Nov 2023 08:27:07 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6330087588
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 08:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A87QxXH008812;
 Wed, 8 Nov 2023 01:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699428419;
 bh=9APDCWlhQ8e6Fe+6SB1TeUBZi4kcigu2sn7NXEOdTF8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hbWrpZIU7AN1qwvGWaPIKd3GBLKTa4t9qfOJssecauTI0H7bYKAAkdY3GlD0MwRt8
 3WGPG7vrZxF1sak2onO7kuDaW+MVWnihT8ku/uiPjV8sPqMQXTRk29K2amGNnMgqV1
 YPaJxlpsLOQMJAZ3Eu3HwFctXfJtwf9GDJTqgcqM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A87QxX2022741
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Nov 2023 01:26:59 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 01:26:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 01:26:57 -0600
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A87Quu0078920;
 Wed, 8 Nov 2023 01:26:57 -0600
Message-ID: <b138a10f-03a5-4393-bcfd-5f0acebff1a9@ti.com>
Date: Wed, 8 Nov 2023 12:56:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] board: ti: common: add rtc setup to common folder
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Christian
 Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>
References: <20231107232139.2839534-5-bb@ti.com>
 <20231107232139.2839534-6-bb@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231107232139.2839534-6-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 08/11/23 04:51, Bryan Brattlof wrote:
> All of the starter kit boards for the am62xxx extended family utilize
> the same 32k crystal oscillator for a more accurate clock for the RTC
> instance. Add the setup the clock mux and debounce configuration to the
> common board directory so the entire am62xxx extended family can utilize
> it.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  board/ti/common/Kconfig |  8 +++++++
>  board/ti/common/rtc.c   | 47 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 board/ti/common/rtc.c
> 
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index 49edd98014ab7..56a65c0a402bb 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -1,3 +1,11 @@
> +config BOARD_HAS_32K_RTC_CRYSTAL
> +	bool "Enable the 32k crystial for RTC"
> +	help
> +	   Some of Texas Instrument's Starter-Kit boards have
> +	   an onboard 32k crystal. Select this option if you wish Uboot
> +	   to enable this crystal for Linux
> +	default n
> +
>  config TI_I2C_BOARD_DETECT
>  	bool "Support for Board detection for TI platforms"
>  	help
> diff --git a/board/ti/common/rtc.c b/board/ti/common/rtc.c
> new file mode 100644
> index 0000000000000..e117a927765c5
> --- /dev/null
> +++ b/board/ti/common/rtc.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RTC setup for TI Platforms
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
> +#include <log.h>
> +
> +#define WKUP_CTRLMMR_DBOUNCE_CFG1 0x04504084
> +#define WKUP_CTRLMMR_DBOUNCE_CFG2 0x04504088
> +#define WKUP_CTRLMMR_DBOUNCE_CFG3 0x0450408c
> +#define WKUP_CTRLMMR_DBOUNCE_CFG4 0x04504090
> +#define WKUP_CTRLMMR_DBOUNCE_CFG5 0x04504094
> +#define WKUP_CTRLMMR_DBOUNCE_CFG6 0x04504098
> +
> +void board_rtc_init(void)
> +{
> +	u32 val;
> +
> +	/* We have 32k crystal, so lets enable it */
> +	val = readl(MCU_CTRL_LFXOSC_CTRL);
> +	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
> +	writel(val, MCU_CTRL_LFXOSC_CTRL);
> +
> +	/* Add any TRIM needed for the crystal here.. */
> +	/* Make sure to mux up to take the SoC 32k from the crystal */
> +	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
> +	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
> +
> +	/* Setup debounce conf registers - arbitrary values.
> +	 * Times are approx
> +	 */
> +	/* 1.9ms debounce @ 32k */
> +	writel(WKUP_CTRLMMR_DBOUNCE_CFG1, 0x1);
> +	/* 5ms debounce @ 32k */
> +	writel(WKUP_CTRLMMR_DBOUNCE_CFG2, 0x5);
> +	/* 20ms debounce @ 32k */
> +	writel(WKUP_CTRLMMR_DBOUNCE_CFG3, 0x14);
> +	/* 46ms debounce @ 32k */
> +	writel(WKUP_CTRLMMR_DBOUNCE_CFG4, 0x18);
> +	/* 100ms debounce @ 32k */
> +	writel(WKUP_CTRLMMR_DBOUNCE_CFG5, 0x1c);
> +	/* 156ms debounce @ 32k */
> +	writel(WKUP_CTRLMMR_DBOUNCE_CFG6, 0x1f);
> +}


Pad Debounce settings has nothing to do with RTC. This doesn't belong to
board_rtc_init()

-- 
Regards
Vignesh
