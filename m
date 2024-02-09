Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCCCC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 14:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E92E87E6B;
	Fri,  9 Feb 2024 15:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.com header.i=@yandex.com header.b="AgtA/1Po";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6A4287E37; Fri,  9 Feb 2024 14:07:55 +0100 (CET)
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net
 [178.154.239.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C9887E62
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 14:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@yandex.com
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3999:0:640:6a33:0])
 by forward502b.mail.yandex.net (Yandex) with ESMTPS id 604AE5E913;
 Fri,  9 Feb 2024 16:07:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id k7jIeMhTjuQ0-61bvHnss; 
 Fri, 09 Feb 2024 16:07:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1707484069; bh=QERlqA6sJUaggHOkRs0kWwexhcDE2yVZrRZdtaJ2L18=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=AgtA/1PotSmvWubO0kvCjL7oxC1GAUcNHMcU8xj69dzJ22c+5NOvkJiwrxX8g4KaA
 psR4gVYjzUCzw71uDRaQmI9NM6VjgiNoEHshE6V5FU4UEce85CHB9chTvbgI/tHbe5
 Y3fsAuQhdQtPGT1LFlh+oZUprfop/vLf8nvkFzQk=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex.com
Message-ID: <715e6edd-4b5c-46bb-a245-3427175423c9@yandex.com>
Date: Fri, 9 Feb 2024 14:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] rockchip: migrate hardware.h inclusion into
 appropriate files
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
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
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-13-6c9ffe09b924@theobroma-systems.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <20240209-jaguar-v2-13-6c9ffe09b924@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 Feb 2024 15:15:51 +0100
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



On 2/9/24 10:50, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> hardware.h is only defining macros which are "wrappers" around writel().
> 
> writel() is however not available in hardware.h, <asm/io.h> needs to be
> included. This means in order to use the wrappers in hardware.h, one
> also needs to include the <asm/io.h> header.
> 
> However, this cannot be done currently because hardware.h is included in
> include/configs files, which are implicitly included by every code file
> by default, which makes the compilation of arch/arm/cpu/armv8/u-boot.lds
> fail because ALIGN (the ARM assembly directive) got redefined by some
> of the include files coming from <asm.io.h>.
> 
> Because nothing in the include/configs file actually use hardware.h,
> let's remove the inclusion of hardware.h from the include/configs files
> and explicitly add it wherever it is required.
> 
> This prepares for the next commit where <asm/io.h> will be included in
> hardware.h.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/mach-rockchip/rk3066/rk3066.c | 1 +
>  drivers/ram/rockchip/dmc-rk3368.c      | 1 +
>  drivers/ram/rockchip/sdram_rk3188.c    | 1 +
>  drivers/ram/rockchip/sdram_rk3288.c    | 1 +
>  include/configs/rk3036_common.h        | 1 -
>  include/configs/rk3066_common.h        | 1 -
>  include/configs/rk3188_common.h        | 1 -
>  include/configs/rk322x_common.h        | 1 -
>  include/configs/rk3288_common.h        | 1 -
>  include/configs/rk3368_common.h        | 1 -
>  include/configs/rv1108_common.h        | 1 -
>  11 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3066/rk3066.c b/arch/arm/mach-rockchip/rk3066/rk3066.c
> index 78c7d894f90..6661b788295 100644
> --- a/arch/arm/mach-rockchip/rk3066/rk3066.c
> +++ b/arch/arm/mach-rockchip/rk3066/rk3066.c
> @@ -7,6 +7,7 @@
>  #include <asm/io.h>
>  #include <asm/arch-rockchip/bootrom.h>
>  #include <asm/arch-rockchip/grf_rk3066.h>
> +#include <asm/arch-rockchip/hardware.h>
>  
>  #define GRF_BASE	0x20008000
>  
> diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
> index f36be941a38..74d8aed571c 100644
> --- a/drivers/ram/rockchip/dmc-rk3368.c
> +++ b/drivers/ram/rockchip/dmc-rk3368.c
> @@ -20,6 +20,7 @@

>  #include <asm/arch-rockchip/ddr_rk3368.h>
>  #include <asm/arch-rockchip/sdram.h>
>  #include <asm/arch-rockchip/sdram_rk3288.h>
> +#include <asm/arch-rockchip/hardware.h>

From codingstyle.rst:

You should follow this ordering in U-Boot. 
The common.h header (which is going away at some point) should always be first, 
followed by other headers in order, then headers with directories, then local files.
Within that order, sort your includes.

>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
> index ad9f936df55..16a68885f1f 100644
> --- a/drivers/ram/rockchip/sdram_rk3188.c
> +++ b/drivers/ram/rockchip/sdram_rk3188.c
> @@ -25,6 +25,7 @@

>  #include <asm/arch-rockchip/pmu_rk3188.h>
>  #include <asm/arch-rockchip/sdram.h>
>  #include <asm/arch-rockchip/sdram_rk3288.h>
> +#include <asm/arch-rockchip/hardware.h>

dito

>  #include <linux/delay.h>
>  #include <linux/err.h>
>  
> diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
> index c99118fd612..ec6bdcb2015 100644
> --- a/drivers/ram/rockchip/sdram_rk3288.c
> +++ b/drivers/ram/rockchip/sdram_rk3288.c
> @@ -25,6 +25,7 @@

>  #include <asm/arch-rockchip/pmu_rk3288.h>
>  #include <asm/arch-rockchip/sdram.h>
>  #include <asm/arch-rockchip/sdram_rk3288.h>
> +#include <asm/arch-rockchip/hardware.h>

dito

>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <power/regulator.h>
> diff --git a/include/configs/rk3036_common.h b/include/configs/rk3036_common.h
> index c2abd14e114..0bf9e8b9a2e 100644
> --- a/include/configs/rk3036_common.h
> +++ b/include/configs/rk3036_common.h
> @@ -5,7 +5,6 @@
>  #ifndef __CONFIG_RK3036_COMMON_H
>  #define __CONFIG_RK3036_COMMON_H
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include "rockchip-common.h"
>  
>  #define CFG_SYS_HZ_CLOCK		24000000
> diff --git a/include/configs/rk3066_common.h b/include/configs/rk3066_common.h
> index d70c8f77d48..6a3b6900463 100644
> --- a/include/configs/rk3066_common.h
> +++ b/include/configs/rk3066_common.h
> @@ -6,7 +6,6 @@
>  #ifndef __CONFIG_RK3066_COMMON_H
>  #define __CONFIG_RK3066_COMMON_H
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include "rockchip-common.h"
>  
>  #define CFG_IRAM_BASE		0x10080000
> diff --git a/include/configs/rk3188_common.h b/include/configs/rk3188_common.h
> index a8cee1e44d4..98f2c25f3cf 100644
> --- a/include/configs/rk3188_common.h
> +++ b/include/configs/rk3188_common.h
> @@ -6,7 +6,6 @@
>  #ifndef __CONFIG_RK3188_COMMON_H
>  #define __CONFIG_RK3188_COMMON_H
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include "rockchip-common.h"
>  
>  #define CFG_IRAM_BASE	0x10080000
> diff --git a/include/configs/rk322x_common.h b/include/configs/rk322x_common.h
> index 15f77df3e17..bab4ca015f7 100644
> --- a/include/configs/rk322x_common.h
> +++ b/include/configs/rk322x_common.h
> @@ -5,7 +5,6 @@
>  #ifndef __CONFIG_RK322X_COMMON_H
>  #define __CONFIG_RK322X_COMMON_H
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include "rockchip-common.h"
>  
>  #define CFG_SYS_HZ_CLOCK		24000000
> diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
> index 3063076a97a..0c449e31099 100644
> --- a/include/configs/rk3288_common.h
> +++ b/include/configs/rk3288_common.h
> @@ -6,7 +6,6 @@
>  #ifndef __CONFIG_RK3288_COMMON_H
>  #define __CONFIG_RK3288_COMMON_H
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include "rockchip-common.h"
>  
>  #define CFG_SYS_HZ_CLOCK		24000000
> diff --git a/include/configs/rk3368_common.h b/include/configs/rk3368_common.h
> index ccb5369b901..d488f8d477a 100644
> --- a/include/configs/rk3368_common.h
> +++ b/include/configs/rk3368_common.h
> @@ -8,7 +8,6 @@
>  
>  #include "rockchip-common.h"
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include <linux/sizes.h>
>  
>  #define CFG_SYS_SDRAM_BASE		0
> diff --git a/include/configs/rv1108_common.h b/include/configs/rv1108_common.h
> index 3bf70a0e0ae..ff28236a21d 100644
> --- a/include/configs/rv1108_common.h
> +++ b/include/configs/rv1108_common.h
> @@ -5,7 +5,6 @@
>  #ifndef __CONFIG_RV1108_COMMON_H
>  #define __CONFIG_RV1108_COMMON_H
>  
> -#include <asm/arch-rockchip/hardware.h>
>  #include "rockchip-common.h"
>  
>  #define CFG_IRAM_BASE		0x10080000
> 
