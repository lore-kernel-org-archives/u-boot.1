Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12172C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5332283285;
	Tue,  8 Apr 2025 05:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Rc3pYQ6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FBB783290; Tue,  8 Apr 2025 05:22:54 +0200 (CEST)
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com
 [117.135.214.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2682082CEA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208a71;
 Tue, 8 Apr 2025 11:22:48 +0800 (GMT+08:00)
Message-ID: <5fac8f8f-3c01-4419-b671-0adbe72452e2@rock-chips.com>
Date: Tue, 8 Apr 2025 11:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/30] ram: rockchip: Add basic support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-16-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMfQ1ZKHx8eGUlIGU9MH0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136c05c903afkunm110208a71
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46KSo4GDJJSEI*Pw84T0Iq
 FQowCRZVSlVKTE9PS0NJTk1CTEtPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITEJMNwY+
DKIM-Signature: a=rsa-sha256;
 b=Rc3pYQ6ULdwWryVkpGykQ8qJ5d9XziHKYSt/EirKvPZVNhz4eUJThyDUzvH1mTcEMHMS1DUt9geauVmqww+tfueIE88v7GC7YuLJ18xk8u+eZXPOrRpTDg5vRpXrO/8jR9S/38hThcgWW+3yl0UxMD/AVpjSzq3PsHf4y+dG+sI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=UnUlT8xd4VwMdMtMGsIocnFwMD9Lke/d3QPvQEubbHo=;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> Add support for reading DRAM size information from PMUGRF os_reg18 reg.
>
> Compared to most Rockchip SoCs the RK3528 use os_reg18 for DRAM info,
> instead of os_reg2.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/sdram.c      |  3 ++-
>   drivers/ram/rockchip/Makefile       |  1 +
>   drivers/ram/rockchip/sdram_rk3528.c | 33 +++++++++++++++++++++++++++++
>   3 files changed, 36 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/ram/rockchip/sdram_rk3528.c
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 0bdda77a7926..91a6606d461f 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -110,7 +110,8 @@ static int rockchip_dram_init_banksize(void)
>   	u8 i, j;
>   
>   	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
> -	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
> +	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568) &&
> +	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3528))
>   		return -ENOTSUPP;
>   
>   	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
> diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
> index 36dc0500dab5..f222cc99f1e4 100644
> --- a/drivers/ram/rockchip/Makefile
> +++ b/drivers/ram/rockchip/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_ROCKCHIP_RK3288) = sdram_rk3288.o
>   obj-$(CONFIG_ROCKCHIP_RK3308) = sdram_rk3308.o
>   obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.o
>   obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
> +obj-$(CONFIG_ROCKCHIP_RK3528) += sdram_rk3528.o
>   obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
>   obj-$(CONFIG_ROCKCHIP_RK3588) += sdram_rk3588.o
>   obj-$(CONFIG_ROCKCHIP_RV1126) += sdram_rv1126.o sdram_pctl_px30.o
> diff --git a/drivers/ram/rockchip/sdram_rk3528.c b/drivers/ram/rockchip/sdram_rk3528.c
> new file mode 100644
> index 000000000000..89d325bea667
> --- /dev/null
> +++ b/drivers/ram/rockchip/sdram_rk3528.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright Contributors to the U-Boot project.
> +
> +#include <dm.h>
> +#include <ram.h>
> +#include <asm/arch-rockchip/sdram.h>
> +
> +#define PMUGRF_BASE			0xff370000
> +#define OS_REG18_REG			0x248
> +
> +static int rk3528_dmc_get_info(struct udevice *dev, struct ram_info *info)
> +{
> +	info->base = CFG_SYS_SDRAM_BASE;
> +	info->size = rockchip_sdram_size(PMUGRF_BASE + OS_REG18_REG);
> +
> +	return 0;
> +}
> +
> +static struct ram_ops rk3528_dmc_ops = {
> +	.get_info = rk3528_dmc_get_info,
> +};
> +
> +static const struct udevice_id rk3528_dmc_ids[] = {
> +	{ .compatible = "rockchip,rk3528-dmc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3528_dmc) = {
> +	.name = "rockchip_rk3528_dmc",
> +	.id = UCLASS_RAM,
> +	.of_match = rk3528_dmc_ids,
> +	.ops = &rk3528_dmc_ops,
> +};
