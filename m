Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417F0C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965EA80A52;
	Wed, 22 Jan 2025 14:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aX47FkX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F0E80763; Wed, 22 Jan 2025 11:16:55 +0100 (CET)
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com
 [220.197.32.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A168D80586
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 11:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chaoyi.chen@rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes
 [58.22.7.114]) by smtp.qiye.163.com (Hmail) with ESMTP id 96834d46;
 Wed, 22 Jan 2025 18:16:44 +0800 (GMT+08:00)
Message-ID: <a7316a05-fec5-4769-82eb-ec27748c26c8@rock-chips.com>
Date: Wed, 22 Jan 2025 18:16:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] video: rockchip: Add HDMI support for RK3568
To: Dang Huynh <danct12@riseup.net>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
 <20250116-vop2-pt2-v1-9-c9d646b53930@riseup.net>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20250116-vop2-pt2-v1-9-c9d646b53930@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0waH1ZPH04fGBkZSExKS0tWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a948d83ad5603abkunm96834d46
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6FBw*KDIXQy9MCyoKKB8V
 SksaFB5VSlVKTEhMTk9KS0tMTk1JVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
 WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSElMSjcG
DKIM-Signature: a=rsa-sha256;
 b=aX47FkX1LmwHoe4iSApBRW+gCpKrGfc7rIhQd0vFS7aE/VqoppTnlz46yvoRfzajf5nIOQ/SwD1dVPZo/KuIxjdbXsym5fnJYxAToXw9nYvPS2HSC+Ah4Sb48YgvC7wTb7LbFpyB3w68aShiF1f3MX9EcaTkH7SAixPYOAP2RGM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=LgY57W8UIqFLk1pqvWXgeVkuIYi8nYRlKAa4AU10KMU=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

Hi Dang,

On 2025/1/16 17:15, Dang Huynh wrote:
> HDMI on RK3568 is mostly simplified, all this does is enabling
> DDC for display timings and HPD.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>   drivers/video/rockchip/Makefile      |  1 +
>   drivers/video/rockchip/rk3568_hdmi.c | 63 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 64 insertions(+)
>
> diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
> index 2f89a979a2848733be5a6d05817ad76ce3ad3a34..b751c969b46f1933e91a6c0434f31227a709d8e5 100644
> --- a/drivers/video/rockchip/Makefile
> +++ b/drivers/video/rockchip/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
>   obj-hdmi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_hdmi.o
>   obj-hdmi-$(CONFIG_ROCKCHIP_RK3328) += rk3328_hdmi.o
>   obj-hdmi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_hdmi.o
> +obj-hdmi-$(CONFIG_ROCKCHIP_RK3568) += rk3568_hdmi.o
>   obj-$(CONFIG_DISPLAY_ROCKCHIP_HDMI) += rk_hdmi.o $(obj-hdmi-y)
>   obj-mipi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_mipi.o
>   obj-mipi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_mipi.o
> diff --git a/drivers/video/rockchip/rk3568_hdmi.c b/drivers/video/rockchip/rk3568_hdmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e0dae919c89d685c145373c8520c52c760f60864
> --- /dev/null
> +++ b/drivers/video/rockchip/rk3568_hdmi.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Dang Huynh <danct12@riseup.net>
> + */
> +
> +#include <display.h>
> +#include <dm.h>
> +#include <dw_hdmi.h>
> +#include <edid.h>
> +#include <asm/arch-rockchip/hardware.h>
> +#include <asm/arch-rockchip/grf_rk3568.h>
> +#include "rk_hdmi.h"
> +
> +#define RK3568_IO_DDC_IN_MSK             ((3 << 14) | (3 << (14 + 16)))
> +
> +static int rk3568_hdmi_enable(struct udevice *dev, int panel_bpp,
> +			      const struct display_timing *edid)
> +{
> +	struct rk_hdmi_priv *priv = dev_get_priv(dev);
> +
> +	return dw_hdmi_enable(&priv->hdmi, edid);
> +}
> +
> +static int rk3568_hdmi_of_to_plat(struct udevice *dev)
> +{
> +	struct rk_hdmi_priv *priv = dev_get_priv(dev);
> +	struct dw_hdmi *hdmi = &priv->hdmi;
> +
> +	hdmi->i2c_clk_high = 0x71;
> +	hdmi->i2c_clk_low = 0x76;
> +
> +	return rk_hdmi_of_to_plat(dev);
> +}
> +
> +static int rk3568_hdmi_probe(struct udevice *dev)
> +{
> +	struct rk_hdmi_priv *priv = dev_get_priv(dev);
> +	struct rk3568_grf *grf = priv->grf;
> +
> +	writel(RK3568_IO_DDC_IN_MSK, &grf->vo_con1);
> +
> +	return rk_hdmi_probe(dev);
> +}
> +
> +static const struct dm_display_ops rk3568_hdmi_ops = {
> +	.read_edid = rk_hdmi_read_edid,
> +	.enable = rk3568_hdmi_enable,
> +};
> +
> +static const struct udevice_id rk3568_hdmi_ids[] = {
> +	{ .compatible = "rockchip,rk3568-dw-hdmi" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rk3568_hdmi_rockchip) = {
> +	.name = "rk3568_hdmi_rockchip",
> +	.id = UCLASS_DISPLAY,
> +	.of_match = rk3568_hdmi_ids,
> +	.ops = &rk3568_hdmi_ops,
> +	.of_to_plat = rk3568_hdmi_of_to_plat,
> +	.probe = rk3568_hdmi_probe,
> +	.priv_auto	= sizeof(struct rk_hdmi_priv),
> +};
Enable the "avdd-0v9" and "avdd-1v8" regulators as we did in the Kernel 
is a good idea.
