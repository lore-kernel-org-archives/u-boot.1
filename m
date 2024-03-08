Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F414C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 08:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC13987C9A;
	Fri,  8 Mar 2024 09:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QdK3KezC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E7A8801E; Fri,  8 Mar 2024 09:45:45 +0100 (CET)
Received: from mail-m127222.xmail.ntesmail.com
 (mail-m127222.xmail.ntesmail.com [115.236.127.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796BC80EED
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 09:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QdK3KezCfL6pAiHCbo9CQs1URH1k5NGk10cNpsH9OSpBDd3mkxgtMcFK+mHX/KW0Z64B0lWNVylWohCQkMBoEJ+nz5AgCnoV15z99LwU80V0ERXzG4jo70cWKKtfDYf9mYffMpdPY6HtUO/jdn1vmk8IlvZWviL3wKyVZ/j16TY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jkGcERsSnoysFmyNZMnr6TiQEujxpFY3CwlnzMwWIOg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EBCE0900316;
 Fri,  8 Mar 2024 16:45:24 +0800 (CST)
Message-ID: <68f189e5-9744-4eea-9075-01f0f3e245d5@rock-chips.com>
Date: Fri, 8 Mar 2024 16:45:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: rockchip-inno-usb2: Write to correct GRF
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: u-boot@lists.denx.de
References: <20240225221024.1974853-1-jonas@kwiboo.se>
 <20240225221024.1974853-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240225221024.1974853-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRkdH1ZCHkIeSEoeTxkdTE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d3d125303a9kunmebce0900316
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6Shw6PzMKFj4wSSg0CCwu
 TzkaFCpVSlVKTEtCQ0NMTklOQkpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTUpKNwY+
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


On 2024/2/26 06:10, Jonas Karlman wrote:
> On RK3399 the USB2PHY regs are located in the common GRF, remaining SoCs
> that is supported by this driver have the USB2PHY regs in a different
> GRF.
>
> When support for RK356x, RK3588 and RK3328 was added this driver was
> never updated to use correct GRF and have instead incorrectly written
> to wrong GRF for these SoCs.
>
> The default reset values for the USB2PHY have made USB mostly working
> even when wrong GRF was used, however, following have been observed:
>
>    scanning bus usb@fd840000 for devices...
>    ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
>    not provide a handshake (OUT) (5)
>    ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
>    not provide a handshake (OUT) (5)
>    unable to get device descriptor (error=-1)
>
> Fix this by using a regmap from rockchip,usbgrf prop and fall back to
> getting a regmap for parent udevice instead of always getting the
> common GRF.
>
> Also protect against accidental clear of bit 0 in a reg with offset 0,
> only bind driver to enabled otg/host-ports and remove unused headers.
>
> Fixes: 3da15f0b49a2 ("phy: rockchip-inno-usb2: Add USB2 PHY for rk3568")
> Fixes: cdf9010f6e17 ("phy: rockchip-inno-usb2: add initial support for rk3588 PHY")
> Fixes: 9aa93d84038b ("phy: rockchip-inno-usb2: Add USB2 PHY for RK3328")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 41 ++++++++++---------
>   1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 70e61eccb79a..7317128d135e 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -6,23 +6,16 @@
>    * Copyright (C) 2020 Amarula Solutions(India)
>    */
>   
> -#include <common.h>
>   #include <clk-uclass.h>
>   #include <dm.h>
> -#include <asm/global_data.h>
>   #include <dm/device_compat.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
>   #include <generic-phy.h>
> -#include <reset.h>
> +#include <regmap.h>
>   #include <syscon.h>
> -#include <asm/gpio.h>
> -#include <asm/io.h>
> -#include <linux/iopoll.h>
>   #include <asm/arch-rockchip/clock.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #define usleep_range(a, b) udelay((b))
>   #define BIT_WRITEABLE_SHIFT	16
>   
> @@ -61,30 +54,39 @@ struct rockchip_usb2phy_cfg {
>   };
>   
>   struct rockchip_usb2phy {
> -	void *reg_base;
> +	struct regmap *reg_base;
>   	struct clk phyclk;
>   	const struct rockchip_usb2phy_cfg *phy_cfg;
>   };
>   
> -static inline int property_enable(void *reg_base,
> +static inline int property_enable(struct regmap *base,
>   				  const struct usb2phy_reg *reg, bool en)
>   {
>   	unsigned int val, mask, tmp;
>   
> +	if (!reg->offset && !reg->enable && !reg->disable)
> +		return 0;
> +
>   	tmp = en ? reg->enable : reg->disable;
>   	mask = GENMASK(reg->bitend, reg->bitstart);
>   	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
>   
> -	return writel(val, reg_base + reg->offset);
> +	return regmap_write(base, reg->offset, val);
>   }
>   
> -static inline bool property_enabled(void *reg_base,
> +static inline bool property_enabled(struct regmap *base,
>   				    const struct usb2phy_reg *reg)
>   {
> +	int ret;
>   	unsigned int tmp, orig;
>   	unsigned int mask = GENMASK(reg->bitend, reg->bitstart);
>   
> -	orig = readl(reg_base + reg->offset);
> +	if (!reg->offset && !reg->enable && !reg->disable)
> +		return false;
> +
> +	ret = regmap_read(base, reg->offset, &orig);
> +	if (ret)
> +		return false;
>   
>   	tmp = (orig & mask) >> reg->bitstart;
>   	return tmp != reg->disable;
> @@ -248,7 +250,11 @@ static int rockchip_usb2phy_probe(struct udevice *dev)
>   	unsigned int reg;
>   	int index, ret;
>   
> -	priv->reg_base = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> +	if (dev_read_bool(dev, "rockchip,usbgrf"))
> +		priv->reg_base =
> +			syscon_regmap_lookup_by_phandle(dev, "rockchip,usbgrf");
> +	else
> +		priv->reg_base = syscon_get_regmap(dev_get_parent(dev));
>   	if (IS_ERR(priv->reg_base))
>   		return PTR_ERR(priv->reg_base);
>   
> @@ -305,11 +311,8 @@ static int rockchip_usb2phy_bind(struct udevice *dev)
>   	int ret = 0;
>   
>   	dev_for_each_subnode(node, dev) {
> -		if (!ofnode_valid(node)) {
> -			dev_info(dev, "subnode %s not found\n", dev->name);
> -			ret = -ENXIO;
> -			goto bind_fail;
> -		}
> +		if (!ofnode_is_enabled(node))
> +			continue;
>   
>   		name = ofnode_get_name(node);
>   		dev_dbg(dev, "subnode %s\n", name);
