Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0D8C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD65387F36;
	Mon, 11 Mar 2024 10:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E3WDTHei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D8787F37; Mon, 11 Mar 2024 10:39:52 +0100 (CET)
Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com
 [117.135.214.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34D18709C
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=E3WDTHeif8dfHIA7ITBwHhVxVSG1CoeLkJtwR52/POrSdSukSGxyMMUKwEBrSMUR/EmAAnxmXSif2407Q5SpnHnlKx7Oliy0lyrqLt5txcf42sp9Ryzjj0qqTPn7qVk/AVce3TKJDJ6eU1y+iX4ulwanoPwGjYuINUspjTYkbos=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=97nSpiOiO1fRjneVWVDIVFu64eSGMY6V7fk7gUx/rHY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4EDAE900417;
 Mon, 11 Mar 2024 17:39:43 +0800 (CST)
Message-ID: <84984e8a-05fc-4b72-9e64-df01e5562274@rock-chips.com>
Date: Mon, 11 Mar 2024 17:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] rockchip: google: gru: Migrate to use IO-domain
 driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-12-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMYQ1ZLTUNPQkgeSEwdTRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2ce1de1c03a9kunm4edae900417
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Vjo4MjMUTzAhSjg6H04B
 CSIwCz5VSlVKTEpLSk9CQkNPS0NIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTU5INwY+
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
> This should be runtime tested by someone with a gru device. All DT props
> and driver seem to be enabled and I expect the io_vsel and soc_con0 to
> be configured with correct value.
> ---
>   board/google/gru/gru.c             | 35 ------------------------------
>   configs/chromebook_bob_defconfig   |  1 +
>   configs/chromebook_kevin_defconfig |  1 +
>   3 files changed, 2 insertions(+), 35 deletions(-)
>
> diff --git a/board/google/gru/gru.c b/board/google/gru/gru.c
> index 9cb3a5252047..e08cb42c27ed 100644
> --- a/board/google/gru/gru.c
> +++ b/board/google/gru/gru.c
> @@ -3,18 +3,9 @@
>    * Copyright 2018 Google
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <init.h>
> -#include <syscon.h>
>   #include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/grf_rk3399.h>
> -#include <asm/arch-rockchip/hardware.h>
> -
> -#define GRF_IO_VSEL_BT656_SHIFT 0
> -#define GRF_IO_VSEL_AUDIO_SHIFT 1
> -#define PMUGRF_CON0_VSEL_SHIFT 8
> -#define PMUGRF_CON0_VOL_SHIFT 9
>   
>   #ifdef CONFIG_SPL_BUILD
>   /* provided to defeat compiler optimisation in board_init_f() */
> @@ -63,29 +54,3 @@ int board_early_init_r(void)
>   	return 0;
>   }
>   #endif
> -
> -static void setup_iodomain(void)
> -{
> -	struct rk3399_grf_regs *grf =
> -	   syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> -	struct rk3399_pmugrf_regs *pmugrf =
> -	   syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> -
> -	/* BT656 and audio is in 1.8v domain */
> -	rk_setreg(&grf->io_vsel, (1 << GRF_IO_VSEL_BT656_SHIFT |
> -				  1 << GRF_IO_VSEL_AUDIO_SHIFT));
> -
> -	/*
> -	 * Set GPIO1 1.8v/3.0v source select to PMU1830_VOL
> -	 * and explicitly configure that PMU1830_VOL to be 1.8V
> -	 */
> -	rk_setreg(&pmugrf->soc_con0, (1 << PMUGRF_CON0_VSEL_SHIFT |
> -				      1 << PMUGRF_CON0_VOL_SHIFT));
> -}
> -
> -int rockchip_early_misc_init_r(void)
> -{
> -	setup_iodomain();
> -
> -	return 0;
> -}
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 28697b174a05..9e13b3544d05 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -66,6 +66,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_I2C_MUX=y
>   CONFIG_CROS_EC_KEYB=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_CROS_EC=y
>   CONFIG_CROS_EC_SPI=y
>   CONFIG_PWRSEQ=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index aab938014e38..e1e80447de3c 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -67,6 +67,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_I2C_MUX=y
>   CONFIG_CROS_EC_KEYB=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_CROS_EC=y
>   CONFIG_CROS_EC_SPI=y
>   CONFIG_PWRSEQ=y
