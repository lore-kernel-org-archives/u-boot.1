Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E7DC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342E487F22;
	Mon, 11 Mar 2024 10:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="M2a6gJKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E836D87572; Mon, 11 Mar 2024 10:35:43 +0100 (CET)
Received: from mail-m49250.qiye.163.com (mail-m49250.qiye.163.com
 [45.254.49.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E51187F24
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=M2a6gJKdvxoRMybNn9YaM1r/k2afDDh2MwPTXfOoV2yRPb9BLO4EsS9SKzIIvTIYV/cRGe9+jO84+rVwJIodQxftoGEzUGSrr/XHHml3gwosM7T+0VHDFV+9jUdD2f6RVuNgVbC1ryUEcTMtyV7C2jb2Bu8FEBxFBJEL2WpRgws=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=NjvAJwQMWSgDru0ayP6ZYUlqVDI0mpYhE+oiZuaF80U=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id B6A9D900371;
 Mon, 11 Mar 2024 17:35:31 +0800 (CST)
Message-ID: <a29e52b9-99e8-4efd-9470-bf854908114e@rock-chips.com>
Date: Mon, 11 Mar 2024 17:35:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] rockchip: pine64: pinebook-pro: Migrate to use
 IO-domain driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-8-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJNTVYdTENLGksYTxkdSUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cde071c03a9kunmb6a9d900371
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6PDo5NzMQHjA6PEsyPCgo
 TwgKCkpVSlVKTEpLSk9CTEhJTkxMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSE9PNwY+
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
>   board/pine64/pinebook-pro-rk3399/Makefile     |  1 -
>   .../pinebook-pro-rk3399/pinebook-pro-rk3399.c | 39 -------------------
>   configs/pinebook-pro-rk3399_defconfig         |  1 +
>   3 files changed, 1 insertion(+), 40 deletions(-)
>   delete mode 100644 board/pine64/pinebook-pro-rk3399/Makefile
>   delete mode 100644 board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
>
> diff --git a/board/pine64/pinebook-pro-rk3399/Makefile b/board/pine64/pinebook-pro-rk3399/Makefile
> deleted file mode 100644
> index 2f692a12a673..000000000000
> --- a/board/pine64/pinebook-pro-rk3399/Makefile
> +++ /dev/null
> @@ -1 +0,0 @@
> -obj-y	+= pinebook-pro-rk3399.o
> diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> deleted file mode 100644
> index 0001022c62a6..000000000000
> --- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> - * (C) Copyright 2020 Peter Robinson <pbrobinson at gmail.com>
> - */
> -
> -#include <common.h>
> -#include <dm.h>
> -#include <syscon.h>
> -#include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/grf_rk3399.h>
> -#include <asm/arch-rockchip/hardware.h>
> -#include <linux/printk.h>
> -
> -#define GRF_IO_VSEL_BT565_SHIFT 0
> -#define PMUGRF_CON0_VSEL_SHIFT 8
> -
> -#ifdef CONFIG_MISC_INIT_R
> -static void setup_iodomain(void)
> -{
> -	struct rk3399_grf_regs *grf =
> -	   syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> -	struct rk3399_pmugrf_regs *pmugrf =
> -	   syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
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
> -#endif
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index d70db2bab749..9e0dbd209be3 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -59,6 +59,7 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
>   CONFIG_MMC_UHS_SUPPORT=y
