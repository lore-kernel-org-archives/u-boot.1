Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDDFC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA2187F0F;
	Mon, 11 Mar 2024 10:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E3icqYiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B8187F3B; Mon, 11 Mar 2024 10:39:56 +0100 (CET)
Received: from mail-m3299.qiye.163.com (mail-m3299.qiye.163.com
 [220.197.32.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417C98709C
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=E3icqYiyuc/kRTc2gbCh3pWHKrN4spbziSwxXAvqiCWf7k9rVxlTthdcKws/ahzoTv3FTRi8JQWkpGYqlXhxVd7QHwxitKBGwCt3nxTlIwFf2ciDFp0tV9YxyqMlBu5OJQbbb3oS7TEuNb21VYsbhobnn4TeigzG0Mwq7sGgTQE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Ejkzecbc9Y7BByGwOpqk9XA8F0J7RFJihwoG2hz6qV8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 33B4590036B;
 Mon, 11 Mar 2024 17:39:34 +0800 (CST)
Message-ID: <2a8d80ea-6c85-4c6e-ba94-f26262b988c7@rock-chips.com>
Date: Mon, 11 Mar 2024 17:39:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] rockchip: theobroma-systems: puma: Migrate to use
 IO-domain driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-11-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpOSVZKHk5LGU4aQ0kfHUxVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2ce1bac703a9kunm33b4590036b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6FTo5KTMSHjAuFTpJHwIZ
 PjowCzlVSlVKTEpLSk9CQkxOS05IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ09PNwY+
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
> This should be runtime tested by someone with a puma device. All DT
> props and driver seem to be enabled and I expect the io_vsel to be
> configured with correct value.
> ---
>   .../puma_rk3399/puma-rk3399.c                 | 21 -------------------
>   configs/puma-rk3399_defconfig                 |  1 +
>   2 files changed, 1 insertion(+), 21 deletions(-)
>
> diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> index 8b998ef45565..eeb8a99231e4 100644
> --- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> +++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> @@ -3,31 +3,10 @@
>    * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <dm.h>
> -#include <syscon.h>
> -#include <dm/pinctrl.h>
> -#include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/grf_rk3399.h>
>   #include "../common/common.h"
>   
> -static void setup_iodomain(void)
> -{
> -	const u32 GRF_IO_VSEL_GPIO4CD_SHIFT = 3;
> -	struct rk3399_grf_regs *grf =
> -	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> -
> -	/*
> -	 * Set bit 3 in GRF_IO_VSEL so PCIE_RST# works (pin GPIO4_C6).
> -	 * Linux assumes that PCIE_RST# works out of the box as it probes
> -	 * PCIe before loading the iodomain driver.
> -	 */
> -	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_GPIO4CD_SHIFT);
> -}
> -
>   int rockchip_early_misc_init_r(void)
>   {
> -	setup_iodomain();
>   	setup_boottargets();
>   
>   	return 0;
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 818bfdf9aa9b..e30305abfafd 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -66,6 +66,7 @@ CONFIG_GPIO_HOG=y
>   CONFIG_SPL_GPIO_HOG=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
