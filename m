Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9F6F417E3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94A183F9A;
	Mon,  9 Mar 2026 15:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q03Efy1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 062EE83F14; Mon,  9 Mar 2026 15:38:35 +0100 (CET)
Received: from mail-m1973183.qiye.163.com (mail-m1973183.qiye.163.com
 [220.197.31.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F002283F6E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e821b;
 Mon, 9 Mar 2026 22:38:25 +0800 (GMT+08:00)
Message-ID: <d33a2982-0536-40ed-b9fb-74fc63820231@rock-chips.com>
Date: Mon, 9 Mar 2026 22:38:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] ram: rockchip: Add basic support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd308f4f503afkunm68f7194516bc3ae
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSkkaVkxMQ0MaTB5LSE9LGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Q03Efy1cIVWlsrjxoTQYgsNZNLsPFNOQ9EPVAK5U7+XSjmC5fNnFom2ZUFEZSF1hIDS+s7QY4tcxuGrULNv/S8OjDHSsK/soqXUdzNBTk/zsWSq/8vPG2Tpoxcv7j9LpqjJpmnPyMnnyo7DlbDSb430D/xyu2DqD/nysT48ZBgA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=+zN4O4feCgcoFi2qbA5xLpq+i0bt4gKKL2I6Vpdpo9E=;
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


On 2026/2/1 07:38, Jonas Karlman wrote:
> Add support for reading DRAM size information from PMUGRF os_reg2 reg.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect t-b tag
> ---
>   drivers/ram/rockchip/Makefile       |  1 +
>   drivers/ram/rockchip/sdram_rk3506.c | 33 +++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
>   create mode 100644 drivers/ram/rockchip/sdram_rk3506.c
>
> diff --git a/drivers/ram/rockchip/Makefile b/drivers/ram/rockchip/Makefile
> index fd94aad0cd49..27921ae4921a 100644
> --- a/drivers/ram/rockchip/Makefile
> +++ b/drivers/ram/rockchip/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_ROCKCHIP_RK3288) = sdram_rk3288.o
>   obj-$(CONFIG_ROCKCHIP_RK3308) = sdram_rk3308.o
>   obj-$(CONFIG_ROCKCHIP_RK3328) = sdram_rk3328.o sdram_pctl_px30.o sdram_phy_px30.o
>   obj-$(CONFIG_ROCKCHIP_RK3399) += sdram_rk3399.o
> +obj-$(CONFIG_ROCKCHIP_RK3506) += sdram_rk3506.o
>   obj-$(CONFIG_ROCKCHIP_RK3528) += sdram_rk3528.o
>   obj-$(CONFIG_ROCKCHIP_RK3568) += sdram_rk3568.o
>   obj-$(CONFIG_ROCKCHIP_RK3576) += sdram_rk3576.o
> diff --git a/drivers/ram/rockchip/sdram_rk3506.c b/drivers/ram/rockchip/sdram_rk3506.c
> new file mode 100644
> index 000000000000..a8396ea88883
> --- /dev/null
> +++ b/drivers/ram/rockchip/sdram_rk3506.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright Contributors to the U-Boot project.
> +
> +#include <dm.h>
> +#include <ram.h>
> +#include <asm/arch-rockchip/sdram.h>
> +
> +#define PMUGRF_BASE			0xff910000
> +#define OS_REG2_REG			0x208
> +
> +static int rk3506_dmc_get_info(struct udevice *dev, struct ram_info *info)
> +{
> +	info->base = CFG_SYS_SDRAM_BASE;
> +	info->size = rockchip_sdram_size(PMUGRF_BASE + OS_REG2_REG);
> +
> +	return 0;
> +}
> +
> +static struct ram_ops rk3506_dmc_ops = {
> +	.get_info = rk3506_dmc_get_info,
> +};
> +
> +static const struct udevice_id rk3506_dmc_ids[] = {
> +	{ .compatible = "rockchip,rk3506-dmc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3506_dmc) = {
> +	.name = "rockchip_rk3506_dmc",
> +	.id = UCLASS_RAM,
> +	.of_match = rk3506_dmc_ids,
> +	.ops = &rk3506_dmc_ops,
> +};
