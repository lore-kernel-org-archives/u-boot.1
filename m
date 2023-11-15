Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC1C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 06:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC5286FDD;
	Wed, 15 Nov 2023 07:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sSxoontm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13538703A; Wed, 15 Nov 2023 07:01:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9DD86FC6
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF61LMn031330;
 Wed, 15 Nov 2023 00:01:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700028081;
 bh=xZ9L94S/gjy4yJXYojzKFjFKwboWnHHQRvt3KDHY+Wk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sSxoontmtBQJ9hcaZHOgyUf8iAR0Yc2WrV3ZyzAZNVabUwNfjIDVXX9d5VLj7jH+3
 c+XXQvwnACr9an2jHlBq/L2QUUvrPvJRZ8MBWsLDtj0jyDE9YtZuOucSHO78sHN0WU
 lVCAXtrdQbvBDgktvOdzcRhyj8mGdnq9YwRvGRbM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF61LGl010731
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Nov 2023 00:01:21 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 00:01:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 00:01:20 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF61Ime007128;
 Wed, 15 Nov 2023 00:01:19 -0600
Message-ID: <0e2c30f7-715c-4de5-b2b8-6c331a634c83@ti.com>
Date: Wed, 15 Nov 2023 11:31:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: mach-k3: Move R5 specific code into new r5/
 directory
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>
CC: <u-boot@lists.denx.de>
References: <20231114155950.296644-1-afd@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231114155950.296644-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Andrew

On 14/11/23 21:29, Andrew Davis wrote:
> This makes it clear these are only to be used by the R5 builds of SPL.
> And this will be used to later more cleanly split the two builds.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm/mach-k3/Makefile                         |  6 +-----
>   arch/arm/mach-k3/r5/Makefile                      | 13 +++++++++++++
>   arch/arm/mach-k3/{ => r5}/am62ax/Makefile         |  0
>   arch/arm/mach-k3/{ => r5}/am62ax/am62a_qos_data.c |  0
>   arch/arm/mach-k3/{ => r5}/am62ax/clk-data.c       |  0
>   arch/arm/mach-k3/{ => r5}/am62ax/dev-data.c       |  0
>   arch/arm/mach-k3/{ => r5}/am62x/Makefile          |  0
>   arch/arm/mach-k3/{ => r5}/am62x/clk-data.c        |  0
>   arch/arm/mach-k3/{ => r5}/am62x/dev-data.c        |  0
>   arch/arm/mach-k3/{ => r5}/j7200/Makefile          |  0
>   arch/arm/mach-k3/{ => r5}/j7200/clk-data.c        |  0
>   arch/arm/mach-k3/{ => r5}/j7200/dev-data.c        |  0
>   arch/arm/mach-k3/{ => r5}/j721e/Makefile          |  0
>   arch/arm/mach-k3/{ => r5}/j721e/clk-data.c        |  0
>   arch/arm/mach-k3/{ => r5}/j721e/dev-data.c        |  0
>   arch/arm/mach-k3/{ => r5}/j721s2/Makefile         |  0
>   arch/arm/mach-k3/{ => r5}/j721s2/clk-data.c       |  0
>   arch/arm/mach-k3/{ => r5}/j721s2/dev-data.c       |  0
>   arch/arm/mach-k3/{ => r5}/lowlevel_init.S         |  0
>   arch/arm/mach-k3/{ => r5}/r5_mpu.c                |  2 +-
>   20 files changed, 15 insertions(+), 6 deletions(-)
>   create mode 100644 arch/arm/mach-k3/r5/Makefile
>   rename arch/arm/mach-k3/{ => r5}/am62ax/Makefile (100%)
>   rename arch/arm/mach-k3/{ => r5}/am62ax/am62a_qos_data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/am62ax/clk-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/am62ax/dev-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/am62x/Makefile (100%)
>   rename arch/arm/mach-k3/{ => r5}/am62x/clk-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/am62x/dev-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/j7200/Makefile (100%)
>   rename arch/arm/mach-k3/{ => r5}/j7200/clk-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/j7200/dev-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/j721e/Makefile (100%)
>   rename arch/arm/mach-k3/{ => r5}/j721e/clk-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/j721e/dev-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/j721s2/Makefile (100%)
>   rename arch/arm/mach-k3/{ => r5}/j721s2/clk-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/j721s2/dev-data.c (100%)
>   rename arch/arm/mach-k3/{ => r5}/lowlevel_init.S (100%)
>   rename arch/arm/mach-k3/{ => r5}/r5_mpu.c (98%)
> 
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index c7ca0fdce56..215c755c5dc 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -3,12 +3,8 @@
>   # Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
>   #	Lokesh Vutla <lokeshvutla@ti.com>
>   
> -obj-$(CONFIG_SOC_K3_J721E) += j721e/ j7200/
> -obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
> -obj-$(CONFIG_SOC_K3_AM625) += am62x/
> -obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
> +obj-$(CONFIG_CPU_V7R) += r5/
>   obj-$(CONFIG_ARM64) += arm64-mmu.o
> -obj-$(CONFIG_CPU_V7R) += r5_mpu.o lowlevel_init.o
>   obj-$(CONFIG_ARM64) += cache.o
>   obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
>   ifeq ($(CONFIG_OF_LIBFDT)$(CONFIG_OF_SYSTEM_SETUP),yy)
> diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
> new file mode 100644
> index 00000000000..8a6af73a44e
> --- /dev/null
> +++ b/arch/arm/mach-k3/r5/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> +#	Andrew Davis <afd@ti.com>
> +
> +obj-$(CONFIG_SOC_K3_J721E) += j721e/
> +obj-$(CONFIG_SOC_K3_J721E) += j7200/
> +obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
> +obj-$(CONFIG_SOC_K3_AM625) += am62x/
> +obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
> +
> +obj-y += lowlevel_init.o
> +obj-y += r5_mpu.o
> diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/r5/am62ax/Makefile
> similarity index 100%
> rename from arch/arm/mach-k3/am62ax/Makefile
> rename to arch/arm/mach-k3/r5/am62ax/Makefile
> diff --git a/arch/arm/mach-k3/am62ax/am62a_qos_data.c b/arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
> similarity index 100%
> rename from arch/arm/mach-k3/am62ax/am62a_qos_data.c
> rename to arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
> diff --git a/arch/arm/mach-k3/am62ax/clk-data.c b/arch/arm/mach-k3/r5/am62ax/clk-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/am62ax/clk-data.c
> rename to arch/arm/mach-k3/r5/am62ax/clk-data.c
> diff --git a/arch/arm/mach-k3/am62ax/dev-data.c b/arch/arm/mach-k3/r5/am62ax/dev-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/am62ax/dev-data.c
> rename to arch/arm/mach-k3/r5/am62ax/dev-data.c
> diff --git a/arch/arm/mach-k3/am62x/Makefile b/arch/arm/mach-k3/r5/am62x/Makefile
> similarity index 100%
> rename from arch/arm/mach-k3/am62x/Makefile
> rename to arch/arm/mach-k3/r5/am62x/Makefile
> diff --git a/arch/arm/mach-k3/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/am62x/clk-data.c
> rename to arch/arm/mach-k3/r5/am62x/clk-data.c
> diff --git a/arch/arm/mach-k3/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/am62x/dev-data.c
> rename to arch/arm/mach-k3/r5/am62x/dev-data.c
> diff --git a/arch/arm/mach-k3/j7200/Makefile b/arch/arm/mach-k3/r5/j7200/Makefile
> similarity index 100%
> rename from arch/arm/mach-k3/j7200/Makefile
> rename to arch/arm/mach-k3/r5/j7200/Makefile
> diff --git a/arch/arm/mach-k3/j7200/clk-data.c b/arch/arm/mach-k3/r5/j7200/clk-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/j7200/clk-data.c
> rename to arch/arm/mach-k3/r5/j7200/clk-data.c
> diff --git a/arch/arm/mach-k3/j7200/dev-data.c b/arch/arm/mach-k3/r5/j7200/dev-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/j7200/dev-data.c
> rename to arch/arm/mach-k3/r5/j7200/dev-data.c
> diff --git a/arch/arm/mach-k3/j721e/Makefile b/arch/arm/mach-k3/r5/j721e/Makefile
> similarity index 100%
> rename from arch/arm/mach-k3/j721e/Makefile
> rename to arch/arm/mach-k3/r5/j721e/Makefile
> diff --git a/arch/arm/mach-k3/j721e/clk-data.c b/arch/arm/mach-k3/r5/j721e/clk-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/j721e/clk-data.c
> rename to arch/arm/mach-k3/r5/j721e/clk-data.c
> diff --git a/arch/arm/mach-k3/j721e/dev-data.c b/arch/arm/mach-k3/r5/j721e/dev-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/j721e/dev-data.c
> rename to arch/arm/mach-k3/r5/j721e/dev-data.c
> diff --git a/arch/arm/mach-k3/j721s2/Makefile b/arch/arm/mach-k3/r5/j721s2/Makefile
> similarity index 100%
> rename from arch/arm/mach-k3/j721s2/Makefile
> rename to arch/arm/mach-k3/r5/j721s2/Makefile
> diff --git a/arch/arm/mach-k3/j721s2/clk-data.c b/arch/arm/mach-k3/r5/j721s2/clk-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/j721s2/clk-data.c
> rename to arch/arm/mach-k3/r5/j721s2/clk-data.c
> diff --git a/arch/arm/mach-k3/j721s2/dev-data.c b/arch/arm/mach-k3/r5/j721s2/dev-data.c
> similarity index 100%
> rename from arch/arm/mach-k3/j721s2/dev-data.c
> rename to arch/arm/mach-k3/r5/j721s2/dev-data.c
> diff --git a/arch/arm/mach-k3/lowlevel_init.S b/arch/arm/mach-k3/r5/lowlevel_init.S
> similarity index 100%
> rename from arch/arm/mach-k3/lowlevel_init.S
> rename to arch/arm/mach-k3/r5/lowlevel_init.S
> diff --git a/arch/arm/mach-k3/r5_mpu.c b/arch/arm/mach-k3/r5/r5_mpu.c
> similarity index 98%
> rename from arch/arm/mach-k3/r5_mpu.c
> rename to arch/arm/mach-k3/r5/r5_mpu.c
> index 605f7931518..e409fdcfea8 100644
> --- a/arch/arm/mach-k3/r5_mpu.c
> +++ b/arch/arm/mach-k3/r5/r5_mpu.c
> @@ -9,7 +9,7 @@
>   #include <common.h>
>   #include <asm/io.h>
>   #include <linux/kernel.h>
> -#include "common.h"
> +#include <asm/armv7_mpu.h>
>   
>   struct mpu_region_config k3_mpu_regions[16] = {
>   	/*

I think a cover-letter with the motivation behind the series could have helped 
me understand quicker (plus if in case there were any discussion links earlier 
about doing this)

-- 
Thanking You
Neha Malcom Francis
