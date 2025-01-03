Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A61E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA2480196;
	Fri,  3 Jan 2025 07:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PXZdeXgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F062801A0; Fri,  3 Jan 2025 07:39:26 +0100 (CET)
Received: from mail-m12774.qiye.163.com (mail-m12774.qiye.163.com
 [115.236.127.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC32800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79758683;
 Fri, 3 Jan 2025 14:39:18 +0800 (GMT+08:00)
Message-ID: <2c62fe5e-fc0b-48bb-8fbc-d8db2aa9e03e@rock-chips.com>
Date: Fri, 3 Jan 2025 14:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] rockchip: rk3288-firefly: Drop unused SPL_LED
 related code
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5PGlZCTEtLGUxNS0ofHh1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae3c6dc03afkunm79758683
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06Nww*GDITNSwtOjYYSDYp
 KDoKFDNVSlVKTEhOQ0NNSE5CSE5KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUhKNwY+
DKIM-Signature: a=rsa-sha256;
 b=PXZdeXgYAvd4uOhaSQL7fkyLMi1hVeqUCPlt+zmjqujJpU2GvGSdlZ55nlXzhICF7USg46RRRJ6d08mXcvLJUZEnppRlJ9YKtfkjvRJSU78BA/PmpyuzoYE2YgrytI3oGUx7P1GTINZmRJD78L6ZC3GSwfd+6wdrLaoML0y2aXg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wQ+rJTQFZHWiBq+bZNt6fHRaAoKqnRAGFf3EVmnltNM=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/12/13 06:09, Jonas Karlman wrote:
> The firefly-rk3288_defconfig build target does not enable the SPL_LED
> Kconfig option.
>
> Drop the unused SPL_LED related code and replace it with a default-state
> prop to ensure the LED driver enable the LED at U-Boot proper phase.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-firefly-u-boot.dtsi       | 17 +------
>   arch/arm/mach-rockchip/rk3288/Kconfig         |  1 -
>   board/firefly/firefly-rk3288/Makefile         |  7 ---
>   board/firefly/firefly-rk3288/firefly-rk3288.c | 46 -------------------
>   4 files changed, 1 insertion(+), 70 deletions(-)
>   delete mode 100644 board/firefly/firefly-rk3288/Makefile
>   delete mode 100644 board/firefly/firefly-rk3288/firefly-rk3288.c
>
> diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> index 644198a4a2fb..30b471900b30 100644
> --- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> @@ -6,20 +6,9 @@
>   #include "rk3288-u-boot.dtsi"
>   
>   / {
> -	config {
> -		bootph-all;
> -		u-boot,boot-led = "firefly:green:power";
> -	};
> -
>   	leds {
> -		bootph-all;
> -
> -		work {
> -			bootph-all;
> -		};
> -
>   		power {
> -			bootph-all;
> +			default-state = "on";
>   		};
>   	};
>   };
> @@ -56,10 +45,6 @@
>   	bootph-all;
>   };
>   
> -&gpio8 {
> -	bootph-all;
> -};
> -
>   &pcfg_pull_up_drv_12ma {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
> index ff16d258b4f5..9cc97bacc41d 100644
> --- a/arch/arm/mach-rockchip/rk3288/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3288/Kconfig
> @@ -75,7 +75,6 @@ config TARGET_FENNEC_RK3288
>   config TARGET_FIREFLY_RK3288
>   	bool "Firefly-RK3288"
>   	select BOARD_LATE_INIT
> -	select SPL_BOARD_INIT if SPL
>   	select TPL
>   	help
>   	  Firefly is a RK3288-based development board with 2 USB ports,
> diff --git a/board/firefly/firefly-rk3288/Makefile b/board/firefly/firefly-rk3288/Makefile
> deleted file mode 100644
> index 671684597d23..000000000000
> --- a/board/firefly/firefly-rk3288/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#
> -# (C) Copyright 2015 Google, Inc
> -#
> -# SPDX-License-Identifier:     GPL-2.0+
> -#
> -
> -obj-y	+= firefly-rk3288.o
> diff --git a/board/firefly/firefly-rk3288/firefly-rk3288.c b/board/firefly/firefly-rk3288/firefly-rk3288.c
> deleted file mode 100644
> index c65ce5890e52..000000000000
> --- a/board/firefly/firefly-rk3288/firefly-rk3288.c
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2015 Google, Inc
> - */
> -
> -#include <hang.h>
> -#include <led.h>
> -#include <log.h>
> -#include <asm/global_data.h>
> -#include <dm/ofnode.h>
> -
> -#ifdef CONFIG_XPL_BUILD
> -static int setup_led(void)
> -{
> -#ifdef CONFIG_SPL_LED
> -	struct udevice *dev;
> -	char *led_name;
> -	int ret;
> -
> -	led_name = ofnode_conf_read_str("u-boot,boot-led");
> -	if (!led_name)
> -		return 0;
> -	ret = led_get_by_label(led_name, &dev);
> -	if (ret) {
> -		debug("%s: get=%d\n", __func__, ret);
> -		return ret;
> -	}
> -	ret = led_set_state(dev, LEDST_ON);
> -	if (ret)
> -		return ret;
> -#endif
> -
> -	return 0;
> -}
> -
> -void spl_board_init(void)
> -{
> -	int ret;
> -
> -	ret = setup_led();
> -	if (ret) {
> -		debug("LED ret=%d\n", ret);
> -		hang();
> -	}
> -}
> -#endif
