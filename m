Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A8CC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D31887EF5;
	Mon, 11 Mar 2024 10:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="f/L8mQjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2C387F24; Mon, 11 Mar 2024 10:39:36 +0100 (CET)
Received: from mail-m254100.xmail.ntesmail.com
 (mail-m254100.xmail.ntesmail.com [103.129.254.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A46218709C
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=f/L8mQjsYdh9zFnrPiPgjJ4Ed6iihmXub4IdnbC7JNQSYLz5uEGbS98/dGyee2L5dh7yolKBGPNolG9rhC3ddd7RHqmC9c/Nc5/8K3dwBaZhLiv6coPncdnPvmHacphHXkPkCnS7K7YRdEBEOVMkbTmONUiAnlNfUX2grBk2Ijw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=SKfWp8XhPh4MEWEpmgqfQu8eiYzl7K4IzLtLh4RDbxY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D907990032F;
 Mon, 11 Mar 2024 17:39:18 +0800 (CST)
Message-ID: <e8eae77f-53cb-4e24-84fe-41cfcc2bc00e@rock-chips.com>
Date: Mon, 11 Mar 2024 17:39:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] rockchip: vamrs: rock960: Migrate to use IO-domain
 driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-10-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpMTFZNQ01LShlJQ0tCGUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2ce17e4903a9kunmd907990032f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6URw*GDMTPDASMz9NHw0w
 AQ8KCTZVSlVKTEpLSk9CQk5CTUlMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTk5MNwY+
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


On 2024/2/18 02:35, Jonas Karlman wrote:
> Switch to use the IO-domain driver to configure IO-domain based on
> device tree instead of a setup_iodomain() function.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/vamrs/rock960_rk3399/Makefile         |  6 -----
>   board/vamrs/rock960_rk3399/rock960-rk3399.c | 27 ---------------------
>   configs/ficus-rk3399_defconfig              |  1 +
>   configs/rock960-rk3399_defconfig            |  1 +
>   4 files changed, 2 insertions(+), 33 deletions(-)
>   delete mode 100644 board/vamrs/rock960_rk3399/Makefile
>   delete mode 100644 board/vamrs/rock960_rk3399/rock960-rk3399.c
>
> diff --git a/board/vamrs/rock960_rk3399/Makefile b/board/vamrs/rock960_rk3399/Makefile
> deleted file mode 100644
> index 6c3e475b3a85..000000000000
> --- a/board/vamrs/rock960_rk3399/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> -#
> -
> -obj-y	+= rock960-rk3399.o
> diff --git a/board/vamrs/rock960_rk3399/rock960-rk3399.c b/board/vamrs/rock960_rk3399/rock960-rk3399.c
> deleted file mode 100644
> index 876be8ed9e10..000000000000
> --- a/board/vamrs/rock960_rk3399/rock960-rk3399.c
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> - */
> -
> -#include <common.h>
> -#include <syscon.h>
> -#include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/grf_rk3399.h>
> -#include <asm/arch-rockchip/hardware.h>
> -#include <linux/bitops.h>
> -
> -#ifdef CONFIG_MISC_INIT_R
> -int misc_init_r(void)
> -{
> -	struct rk3399_grf_regs *grf =
> -	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> -
> -	/**
> -	 * Some SSD's to work on rock960 would require explicit
> -	 * domain voltage change, so BT565 is in 1.8v domain
> -	 */
> -	rk_setreg(&grf->io_vsel, BIT(0));
> -
> -	return 0;
> -}
> -#endif
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
> index 3ff894f1207b..5f6cdeb99d50 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -42,6 +42,7 @@ CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index 6e22b83ec910..1685fe3c19e7 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -49,6 +49,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
