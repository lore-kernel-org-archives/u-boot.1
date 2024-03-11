Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C694C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0853387F10;
	Mon, 11 Mar 2024 10:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OaSlS4gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32D187F1C; Mon, 11 Mar 2024 10:32:48 +0100 (CET)
Received: from mail-m121152.qiye.163.com (mail-m121152.qiye.163.com
 [115.236.121.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DC187F0F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OaSlS4gkXDcozQX6RzwjJ3nAC4Py4S23G7+OdVOmCVNBqMrHQqnayzVQBcm9Z4ClDpWZv4679I+zkoKzIvLoFaAxaHPMkdFBISd8dpV50+0/aYYGHlSVEQ1Lye8Or9pCISimvMDnpETBqTDIrRc8Q3i8KKG4/vg2VEkmUgt+LNM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Izlv6AFpqnlge5hRHnllKnIHgYBxzw0M2QvFdzsyULc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EE3DD9003DA;
 Mon, 11 Mar 2024 17:32:32 +0800 (CST)
Message-ID: <afc32024-459f-4654-88a1-365f12a273eb@rock-chips.com>
Date: Mon, 11 Mar 2024 17:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] rockchip: pine64: rockpro64: Migrate to use
 IO-domain driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-7-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktMHlYfTEwaHUxKS0JLGhlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cdb4caa03a9kunmee3dd9003da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6DRw*CTMKNDAXFhwXSElJ
 LA4KCglVSlVKTEpLSk9CTk5ITExMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSEhLNwY+
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
>   board/pine64/rockpro64_rk3399/Makefile        |  7 ----
>   .../rockpro64_rk3399/rockpro64-rk3399.c       | 39 -------------------
>   configs/rockpro64-rk3399_defconfig            |  1 +
>   3 files changed, 1 insertion(+), 46 deletions(-)
>   delete mode 100644 board/pine64/rockpro64_rk3399/Makefile
>   delete mode 100644 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>
> diff --git a/board/pine64/rockpro64_rk3399/Makefile b/board/pine64/rockpro64_rk3399/Makefile
> deleted file mode 100644
> index b015c47e6fa6..000000000000
> --- a/board/pine64/rockpro64_rk3399/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#
> -# (C) Copyright 2019 Vasily Khoruzhick
> -#
> -# SPDX-License-Identifier:     GPL-2.0+
> -#
> -
> -obj-y	+= rockpro64-rk3399.o
> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> deleted file mode 100644
> index fd78ad60d14b..000000000000
> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2019 Vasily Khoruzhick <anarsoul@gmail.com>
> - */
> -
> -#include <common.h>
> -#include <dm.h>
> -#include <init.h>
> -#include <syscon.h>
> -#include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/grf_rk3399.h>
> -#include <asm/arch-rockchip/hardware.h>
> -
> -#define GRF_IO_VSEL_BT565_SHIFT 0
> -#define PMUGRF_CON0_VSEL_SHIFT 8
> -
> -#ifdef CONFIG_MISC_INIT_R
> -static void setup_iodomain(void)
> -{
> -	struct rk3399_grf_regs *grf =
> -	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> -	struct rk3399_pmugrf_regs *pmugrf =
> -	    syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> -
> -	/* BT565 is in 1.8v domain */
> -	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_BT565_SHIFT);
> -
> -	/* Set GPIO1 1.8v/3.0v source select to PMU1830_VOL */
> -	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
> -}
> -
> -int rockchip_early_misc_init_r(void)
> -{
> -	setup_iodomain();
> -
> -	return 0;
> -}
> -
> -#endif
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 29f91e2ef67e..2e7325bad8cf 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -62,6 +62,7 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
