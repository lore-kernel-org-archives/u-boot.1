Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDFAC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71AA987EF5;
	Mon, 11 Mar 2024 10:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="auG9miUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD2187F0F; Mon, 11 Mar 2024 10:38:53 +0100 (CET)
Received: from mail-m12761.qiye.163.com (mail-m12761.qiye.163.com
 [115.236.127.61])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF2F8709C
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=auG9miUG85Lfh/Gz9yPWneDGkD3vqMheluBiq7LrpQRxzwERbmuWgwPvlZ4j+5cbofmc4pi5Ovlt9XSzZ2z269xsGG+qyr/GlvjkrdvBhyb7j41geq0xlaf4xO8bCHHm5KLYng82vUqKvdo8vX+2naGr1gE3Lrxg+S6U6dOMomE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=AeNOFw54SDj/K7hwbpBDxNix/HN9XWb/T8BOKwsnotg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7C076900127;
 Mon, 11 Mar 2024 17:38:42 +0800 (CST)
Message-ID: <73ef5842-2e4e-499a-96de-9b7ef19ec5ca@rock-chips.com>
Date: Mon, 11 Mar 2024 17:38:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] rockchip: pine64: pinephone-pro: Migrate to use
 IO-domain driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-9-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwfQlYdHxpJTkpKH09LSh5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2ce0f02303a9kunm7c076900127
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6CSo*HTMWEjATFTo*HyhW
 PQIaCwlVSlVKTEpLSk9CQklIT0xCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUpKNwY+
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
> This should be runtime tested by someone with a pinephone-pro device.
> All DT props and driver seem to be enabled and I expect the io_vsel to
> be configured with correct value.
> ---
>   board/pine64/pinephone-pro-rk3399/Makefile    |  1 -
>   .../pinephone-pro-rk3399.c                    | 42 -------------------
>   configs/pinephone-pro-rk3399_defconfig        |  1 +
>   3 files changed, 1 insertion(+), 43 deletions(-)
>   delete mode 100644 board/pine64/pinephone-pro-rk3399/Makefile
>   delete mode 100644 board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
>
> diff --git a/board/pine64/pinephone-pro-rk3399/Makefile b/board/pine64/pinephone-pro-rk3399/Makefile
> deleted file mode 100644
> index 8d9203053e57..000000000000
> --- a/board/pine64/pinephone-pro-rk3399/Makefile
> +++ /dev/null
> @@ -1 +0,0 @@
> -obj-y	+= pinephone-pro-rk3399.o
> diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> deleted file mode 100644
> index 06dc512c57d8..000000000000
> --- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> - * (C) Copyright 2022 Peter Robinson <pbrobinson at gmail.com>
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
> -#define GRF_IO_VSEL_BT565_GPIO2AB 1
> -#define GRF_IO_VSEL_AUDIO_GPIO3D4A 2
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
> -	rk_setreg(&grf->io_vsel,
> -		  GRF_IO_VSEL_BT565_GPIO2AB | GRF_IO_VSEL_AUDIO_GPIO3D4A);
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
> -
> -}
> -#endif
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 04551df1da9b..47124196d626 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -58,6 +58,7 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
