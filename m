Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A3C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9BB88755;
	Tue,  7 May 2024 05:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xod0q4sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F27888757; Tue,  7 May 2024 05:34:34 +0200 (CEST)
Received: from mail-m104.netease.com (mail-m104.netease.com [154.81.10.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA2788754
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Xod0q4sneBuVDqgmQuq4Z1mz1vscYkFPWruOxtdnDuAQVmNIxYBl0cNA+0kYD5QPgrK7mo5Zpim0f+dWzT/ZKlB0KG9ep+EAlQfQwXpVXw8VVy8UnTu+/aQHAWKoCd6/cPP6HPHiVLAu3Kt7Ol+9xMFU5JzLnqSYfsg/AhzWvE0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=orfwiHXAJA69HtXiGp1cjZK3JsBp6nhkoHuIvbG7o0Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A65EE900102;
 Tue,  7 May 2024 11:34:21 +0800 (CST)
Message-ID: <5cecc023-15c4-4c8c-bf64-d4408b2e66b3@rock-chips.com>
Date: Tue, 7 May 2024 11:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] phy: rockchip: usbdp: Find phy-id from the io
 address
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlCHlZOQhkeQk5IGBlIS0lVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f511dda1903a9kunma65ee900102
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6Dxw*PTNDFBQIM00UCRcp
 KDgaCihVSlVKTEpOS05JQ01JSEhNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSUJLNwY+
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


On 2024/5/5 03:43, Jonas Karlman wrote:
> The upstream Linux kernel driver find the phy-id from the io address.
>
> Change to use a similar method as the U-Boot inno-usb2 phy driver and
> the Linux kernel driver to set correct phy-id.
>
> This is based on the linux-phy next commit 2f70bbddeb45 ("phy: rockchip:
> add usbdp combo phy driver").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 39 ++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index baf92529348c..8e5821069757 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -74,6 +74,8 @@ struct udphy_grf_cfg {
>   struct rockchip_udphy;
>   
>   struct rockchip_udphy_cfg {
> +	unsigned int num_phys;
> +	unsigned int phy_ids[2];
>   	/* resets to be requested */
>   	const char * const *rst_list;
>   	int num_rsts;
> @@ -640,17 +642,25 @@ int rockchip_u3phy_uboot_init(void)
>   
>   static int rockchip_udphy_probe(struct udevice *dev)
>   {
> -	const struct device_node *np = ofnode_to_np(dev_ofnode(dev));
>   	struct rockchip_udphy *udphy = dev_get_priv(dev);
>   	const struct rockchip_udphy_cfg *phy_cfgs;
> +	unsigned int reg;
>   	int id, ret;
>   
>   	udphy->dev = dev;
>   
> -	id = of_alias_get_id(np, "usbdp");
> -	if (id < 0)
> -		id = 0;
> -	udphy->id = id;
> +	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &reg);
> +	if (ret) {
> +		dev_err(dev, "failed to read reg[0] property\n");
> +		return ret;
> +	}
> +	if (reg == 0 && dev_read_addr_cells(dev) == 2) {
> +		ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 1, &reg);
> +		if (ret) {
> +			dev_err(dev, "failed to read reg[1] property\n");
> +			return ret;
> +		}
> +	}
>   
>   	phy_cfgs = (const struct rockchip_udphy_cfg *)dev_get_driver_data(dev);
>   	if (!phy_cfgs) {
> @@ -659,6 +669,20 @@ static int rockchip_udphy_probe(struct udevice *dev)
>   	}
>   	udphy->cfgs = phy_cfgs;
>   
> +	/* find the phy-id from the io address */
> +	udphy->id = -ENODEV;
> +	for (id = 0; id < udphy->cfgs->num_phys; id++) {
> +		if (reg == udphy->cfgs->phy_ids[id]) {
> +			udphy->id = id;
> +			break;
> +		}
> +	}
> +
> +	if (udphy->id < 0) {
> +		dev_err(dev, "no matching device found\n");
> +		return -ENODEV;
> +	}
> +
>   	ret = regmap_init_mem(dev_ofnode(dev), &udphy->pma_regmap);
>   	if (ret)
>   		return ret;
> @@ -838,6 +862,11 @@ static const char * const rk3588_udphy_rst_l[] = {
>   };
>   
>   static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
> +	.num_phys = 2,
> +	.phy_ids = {
> +		0xfed80000,
> +		0xfed90000,
> +	},
>   	.num_rsts = ARRAY_SIZE(rk3588_udphy_rst_l),
>   	.rst_list = rk3588_udphy_rst_l,
>   	.grfcfg	= {
