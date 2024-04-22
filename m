Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3D7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9E6883D4;
	Mon, 22 Apr 2024 10:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FxRAzOgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D71883DA; Mon, 22 Apr 2024 10:53:49 +0200 (CEST)
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com
 [220.197.31.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B50D88374
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FxRAzOgcwAZ1rCti03hjs2AnJOaB4JnnOGt6EO7R47aCbP7SvulbNQqXcingdTgbBzK85OiEMlFx3wtmb+jqdUaqWuZMyp6G3Kt/9n6Da1Lpq4AQo5mEX9GK0m4W37nIl5Rx+8jEfan/MFkmRq13U1yq+MI5n/eZNZoKIsgCNyw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=GsJJ2r2LVL/M28mXnyw7rlwGROBU5G953Aag2hbBLZY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3C6D99002F4;
 Mon, 22 Apr 2024 16:53:13 +0800 (CST)
Message-ID: <90bda00d-4a3a-4bc5-943d-b9475994be4c@rock-chips.com>
Date: Mon, 22 Apr 2024 16:53:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] rockchip: rk3308: Move cru and grf include files
 to arch-rockchip
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-15-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlNSFZJSRlLGENPTEtPQkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f050263c403a9kunm3c6d99002f4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6Gjo4GDNLMjlDKjw*Fis#
 KB4wCwFVSlVKTEpITExOQkJPSEtDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTUhNNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> Move cru_rk3308.h and grf_rk3308.h to arch-rockchip to match path used
> for all other Rockchip SoCs.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   .../arm/include/asm/{arch-rk3308 => arch-rockchip}/cru_rk3308.h | 0
>   .../arm/include/asm/{arch-rk3308 => arch-rockchip}/grf_rk3308.h | 0
>   arch/arm/mach-rockchip/rk3308/clk_rk3308.c                      | 2 +-
>   arch/arm/mach-rockchip/rk3308/rk3308.c                          | 2 +-
>   board/firefly/firefly-rk3308/roc_cc_rk3308.c                    | 2 +-
>   drivers/clk/rockchip/clk_rk3308.c                               | 2 +-
>   drivers/net/gmac_rockchip.c                                     | 2 +-
>   drivers/ram/rockchip/sdram_rk3308.c                             | 2 +-
>   8 files changed, 6 insertions(+), 6 deletions(-)
>   rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/cru_rk3308.h (100%)
>   rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/grf_rk3308.h (100%)
>
> diff --git a/arch/arm/include/asm/arch-rk3308/cru_rk3308.h b/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
> similarity index 100%
> rename from arch/arm/include/asm/arch-rk3308/cru_rk3308.h
> rename to arch/arm/include/asm/arch-rockchip/cru_rk3308.h
> diff --git a/arch/arm/include/asm/arch-rk3308/grf_rk3308.h b/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
> similarity index 100%
> rename from arch/arm/include/asm/arch-rk3308/grf_rk3308.h
> rename to arch/arm/include/asm/arch-rockchip/grf_rk3308.h
> diff --git a/arch/arm/mach-rockchip/rk3308/clk_rk3308.c b/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
> index ccda53380c6f..201bf661f9bb 100644
> --- a/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
> +++ b/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
> @@ -7,7 +7,7 @@
>   #include <dm.h>
>   #include <syscon.h>
>   #include <asm/arch-rockchip/clock.h>
> -#include <asm/arch/cru_rk3308.h>
> +#include <asm/arch-rockchip/cru_rk3308.h>
>   #include <linux/err.h>
>   
>   int rockchip_get_clk(struct udevice **devp)
> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
> index b3ffabc5449a..a0915c72bfa0 100644
> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
> @@ -5,8 +5,8 @@
>   #include <common.h>
>   #include <init.h>
>   #include <malloc.h>
> -#include <asm/arch/grf_rk3308.h>
>   #include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/grf_rk3308.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <asm/gpio.h>
>   #include <debug_uart.h>
> diff --git a/board/firefly/firefly-rk3308/roc_cc_rk3308.c b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
> index 99a52a77116a..af00250e118d 100644
> --- a/board/firefly/firefly-rk3308/roc_cc_rk3308.c
> +++ b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
> @@ -5,7 +5,7 @@
>   
>   #include <common.h>
>   #include <adc.h>
> -#include <asm/arch/grf_rk3308.h>
> +#include <asm/arch-rockchip/grf_rk3308.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <linux/bitops.h>
>   
> diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
> index c46b58e31626..861648321d40 100644
> --- a/drivers/clk/rockchip/clk_rk3308.c
> +++ b/drivers/clk/rockchip/clk_rk3308.c
> @@ -12,8 +12,8 @@
>   #include <malloc.h>
>   #include <syscon.h>
>   #include <asm/global_data.h>
> -#include <asm/arch/cru_rk3308.h>
>   #include <asm/arch-rockchip/clock.h>
> +#include <asm/arch-rockchip/cru_rk3308.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 33fc36da5077..51f835adabc3 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -19,7 +19,7 @@
>   #include <asm/arch-rockchip/grf_px30.h>
>   #include <asm/arch-rockchip/grf_rk322x.h>
>   #include <asm/arch-rockchip/grf_rk3288.h>
> -#include <asm/arch-rk3308/grf_rk3308.h>
> +#include <asm/arch-rockchip/grf_rk3308.h>
>   #include <asm/arch-rockchip/grf_rk3328.h>
>   #include <asm/arch-rockchip/grf_rk3368.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
> diff --git a/drivers/ram/rockchip/sdram_rk3308.c b/drivers/ram/rockchip/sdram_rk3308.c
> index 10828e80822a..264366291cf8 100644
> --- a/drivers/ram/rockchip/sdram_rk3308.c
> +++ b/drivers/ram/rockchip/sdram_rk3308.c
> @@ -7,8 +7,8 @@
>   #include <dm.h>
>   #include <ram.h>
>   #include <syscon.h>
> -#include <asm/arch/grf_rk3308.h>
>   #include <asm/arch-rockchip/clock.h>
> +#include <asm/arch-rockchip/grf_rk3308.h>
>   #include <asm/arch-rockchip/sdram.h>
>   
>   struct dram_info {
