Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB79C369D7
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A698205A;
	Tue, 22 Apr 2025 16:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Uj92aqj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3423180FA8; Tue, 22 Apr 2025 16:52:00 +0200 (CEST)
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com
 [45.254.49.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FC18070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b420;
 Tue, 22 Apr 2025 22:51:53 +0800 (GMT+08:00)
Message-ID: <6c68df4f-084e-4e48-b762-540738092581@rock-chips.com>
Date: Tue, 22 Apr 2025 22:51:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] ram: rockchip: Add rk3576 ddr driver support
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-8-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-8-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE0dVk5OQklLQ0IaSBgYGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfbeb8e03afkunm12bf5b420
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6MBw6QjJLLEk2EQwvAzg6
 NRpPFBdVSlVKTE9OSEhITkpPTktIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUhJS083Bg++
DKIM-Signature: a=rsa-sha256;
 b=Uj92aqj7H80pIkCSN5CCRb3SmE+JHD8SDdPmRRGCr3kn3K/4UESR4VkwBEz7x/8bVdKM5AJG7plRgUhDXlYOzCAtUT3+Bh8ihh6/KGrSnsgZk2hpTmjIHxnN0oOkYXcXx7REtndn5n4zh3DdUN4UCwuI48YpPa6uIar/y5h8dww=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=idyzmW97HfCC9aku30TTHv40t5mI1rIY5xYAKjqkCU4=;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> Add ddr driver for rk3576 to get the ram capacity.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/ram/rockchip/Makefile       |  1 +
>   drivers/ram/rockchip/sdram_rk3576.c | 35 +++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100644 drivers/ram/rockchip/sdram_rk3576.c
>
> diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
> index f222cc99f1e..fd94aad0cd4 100644
> --- a/drivers/ram/rockchip/Makefile
> +++ b/drivers/ram/rockchip/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.
>   obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
>   obj-$(CONFIG_ROCKCHIP_RK3528) += sdram_rk3528.o
>   obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
> +obj-$(CONFIG_ROCKCHIP_RK3576) += sdram_rk3576.o
>   obj-$(CONFIG_ROCKCHIP_RK3588) += sdram_rk3588.o
>   obj-$(CONFIG_ROCKCHIP_RV1126) += sdram_rv1126.o sdram_pctl_px30.o
>   obj-$(CONFIG_ROCKCHIP_SDRAM_COMMON) += sdram_common.o
> diff --git a/drivers/ram/rockchip/sdram_rk3576.c b/drivers/ram/rockchip/sdram_rk3576.c
> new file mode 100644
> index 00000000000..5a66032ef8f
> --- /dev/null
> +++ b/drivers/ram/rockchip/sdram_rk3576.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <dm.h>
> +#include <ram.h>
> +#include <asm/arch-rockchip/sdram.h>
> +
> +#define PMU1GRF_BASE			0x26026000
> +#define OS_REG2_REG			0x208
> +
> +static int rk3576_dmc_get_info(struct udevice *dev, struct ram_info *info)
> +{
> +	info->base = CFG_SYS_SDRAM_BASE;
> +	info->size = rockchip_sdram_size(PMU1GRF_BASE + OS_REG2_REG);
> +
> +	return 0;
> +}
> +
> +static struct ram_ops rk3576_dmc_ops = {
> +	.get_info = rk3576_dmc_get_info,
> +};
> +
> +static const struct udevice_id rk3576_dmc_ids[] = {
> +	{ .compatible = "rockchip,rk3576-dmc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3576_dmc) = {
> +	.name = "rockchip_rk3576_dmc",
> +	.id = UCLASS_RAM,
> +	.of_match = rk3576_dmc_ids,
> +	.ops = &rk3576_dmc_ops,
> +};
