Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76555C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAA287C35;
	Wed, 24 Jan 2024 11:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PrB1Po0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D0587C39; Wed, 24 Jan 2024 11:46:34 +0100 (CET)
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com
 [115.236.118.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D231087C30
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=PrB1Po0sPafVTds0gxqOZt345kZo7AboZe40NP4i+c7N2hjJAbrkMVHMAiUlVgsasyh8nMipoVHVHDad+miysUM4LPlW6qkVLPFHe2K+LRVS0AXXwuHHeg8ps4RQZ8B0RPIs3OIXyZIdZ964EXv8ijQlc9L0RhiRzqeiUOdbRek=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=FwKoN5LioYRgdetpiMEKy4Yk7OGJOuoJ7gta4H4j8Og=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id BA0094003A2;
 Wed, 24 Jan 2024 18:46:20 +0800 (CST)
Message-ID: <b0720d07-764d-4da6-aef4-c6c5a10fb0cf@rock-chips.com>
Date: Wed, 24 Jan 2024 18:46:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] rockchip: migrate hardware.h inclusion into
 appropriate files
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-15-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-15-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxPGFYfSB5PHkpJGR1CS01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d3b13f94d2eb3kusnba0094003a2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBA6Dzo6LzweSQFITQI5IyIe
 LDdPChNVSlVKTEtNS0JISkNKQ0lDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDQ01LNwY+
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

Hi Quentin,

On 2024/1/23 22:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Nothing of the hardware.h is used in include/configs, therefore, let's
> move that include to the files that actually require this include.

hardware.h is one of common header for soc level, it's reasonable in the 
soc_common.h.

Thanks,

- Kever

>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   arch/arm/mach-rockchip/rk3066/rk3066.c | 1 +
>   drivers/ram/rockchip/dmc-rk3368.c      | 1 +
>   drivers/ram/rockchip/sdram_rk3188.c    | 1 +
>   drivers/ram/rockchip/sdram_rk3288.c    | 1 +
>   include/configs/rk3036_common.h        | 1 -
>   include/configs/rk3066_common.h        | 1 -
>   include/configs/rk3188_common.h        | 1 -
>   include/configs/rk322x_common.h        | 1 -
>   include/configs/rk3288_common.h        | 1 -
>   include/configs/rk3368_common.h        | 1 -
>   include/configs/rv1108_common.h        | 1 -
>   11 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3066/rk3066.c b/arch/arm/mach-rockchip/rk3066/rk3066.c
> index 78c7d894f90..6661b788295 100644
> --- a/arch/arm/mach-rockchip/rk3066/rk3066.c
> +++ b/arch/arm/mach-rockchip/rk3066/rk3066.c
> @@ -7,6 +7,7 @@
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/grf_rk3066.h>
> +#include <asm/arch-rockchip/hardware.h>
>   
>   #define GRF_BASE	0x20008000
>   
> diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
> index f36be941a38..74d8aed571c 100644
> --- a/drivers/ram/rockchip/dmc-rk3368.c
> +++ b/drivers/ram/rockchip/dmc-rk3368.c
> @@ -20,6 +20,7 @@
>   #include <asm/arch-rockchip/ddr_rk3368.h>
>   #include <asm/arch-rockchip/sdram.h>
>   #include <asm/arch-rockchip/sdram_rk3288.h>
> +#include <asm/arch-rockchip/hardware.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
> index ad9f936df55..16a68885f1f 100644
> --- a/drivers/ram/rockchip/sdram_rk3188.c
> +++ b/drivers/ram/rockchip/sdram_rk3188.c
> @@ -25,6 +25,7 @@
>   #include <asm/arch-rockchip/pmu_rk3188.h>
>   #include <asm/arch-rockchip/sdram.h>
>   #include <asm/arch-rockchip/sdram_rk3288.h>
> +#include <asm/arch-rockchip/hardware.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   
> diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
> index c99118fd612..ec6bdcb2015 100644
> --- a/drivers/ram/rockchip/sdram_rk3288.c
> +++ b/drivers/ram/rockchip/sdram_rk3288.c
> @@ -25,6 +25,7 @@
>   #include <asm/arch-rockchip/pmu_rk3288.h>
>   #include <asm/arch-rockchip/sdram.h>
>   #include <asm/arch-rockchip/sdram_rk3288.h>
> +#include <asm/arch-rockchip/hardware.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <power/regulator.h>
> diff --git a/include/configs/rk3036_common.h b/include/configs/rk3036_common.h
> index c2abd14e114..0bf9e8b9a2e 100644
> --- a/include/configs/rk3036_common.h
> +++ b/include/configs/rk3036_common.h
> @@ -5,7 +5,6 @@
>   #ifndef __CONFIG_RK3036_COMMON_H
>   #define __CONFIG_RK3036_COMMON_H
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include "rockchip-common.h"
>   
>   #define CFG_SYS_HZ_CLOCK		24000000
> diff --git a/include/configs/rk3066_common.h b/include/configs/rk3066_common.h
> index d70c8f77d48..6a3b6900463 100644
> --- a/include/configs/rk3066_common.h
> +++ b/include/configs/rk3066_common.h
> @@ -6,7 +6,6 @@
>   #ifndef __CONFIG_RK3066_COMMON_H
>   #define __CONFIG_RK3066_COMMON_H
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include "rockchip-common.h"
>   
>   #define CFG_IRAM_BASE		0x10080000
> diff --git a/include/configs/rk3188_common.h b/include/configs/rk3188_common.h
> index a8cee1e44d4..98f2c25f3cf 100644
> --- a/include/configs/rk3188_common.h
> +++ b/include/configs/rk3188_common.h
> @@ -6,7 +6,6 @@
>   #ifndef __CONFIG_RK3188_COMMON_H
>   #define __CONFIG_RK3188_COMMON_H
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include "rockchip-common.h"
>   
>   #define CFG_IRAM_BASE	0x10080000
> diff --git a/include/configs/rk322x_common.h b/include/configs/rk322x_common.h
> index 15f77df3e17..bab4ca015f7 100644
> --- a/include/configs/rk322x_common.h
> +++ b/include/configs/rk322x_common.h
> @@ -5,7 +5,6 @@
>   #ifndef __CONFIG_RK322X_COMMON_H
>   #define __CONFIG_RK322X_COMMON_H
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include "rockchip-common.h"
>   
>   #define CFG_SYS_HZ_CLOCK		24000000
> diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
> index 3063076a97a..0c449e31099 100644
> --- a/include/configs/rk3288_common.h
> +++ b/include/configs/rk3288_common.h
> @@ -6,7 +6,6 @@
>   #ifndef __CONFIG_RK3288_COMMON_H
>   #define __CONFIG_RK3288_COMMON_H
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include "rockchip-common.h"
>   
>   #define CFG_SYS_HZ_CLOCK		24000000
> diff --git a/include/configs/rk3368_common.h b/include/configs/rk3368_common.h
> index ccb5369b901..d488f8d477a 100644
> --- a/include/configs/rk3368_common.h
> +++ b/include/configs/rk3368_common.h
> @@ -8,7 +8,6 @@
>   
>   #include "rockchip-common.h"
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include <linux/sizes.h>
>   
>   #define CFG_SYS_SDRAM_BASE		0
> diff --git a/include/configs/rv1108_common.h b/include/configs/rv1108_common.h
> index 3bf70a0e0ae..ff28236a21d 100644
> --- a/include/configs/rv1108_common.h
> +++ b/include/configs/rv1108_common.h
> @@ -5,7 +5,6 @@
>   #ifndef __CONFIG_RV1108_COMMON_H
>   #define __CONFIG_RV1108_COMMON_H
>   
> -#include <asm/arch-rockchip/hardware.h>
>   #include "rockchip-common.h"
>   
>   #define CFG_IRAM_BASE		0x10080000
>
