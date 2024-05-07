Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0EC25B5C
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6BE8874B;
	Tue,  7 May 2024 05:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Dk2Zn77Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8437E8875B; Tue,  7 May 2024 05:34:52 +0200 (CEST)
Received: from mail-m92247.xmail.ntesmail.com (mail-m92247.xmail.ntesmail.com
 [103.126.92.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0C188743
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Dk2Zn77ZKHcAqbiQG7BM1plVc785mrXHlBAcTF+p5a9pa+Ebrkslxj5v8rx14nlgteNEO4kGJnjIVVI3VB3Skes/E9Xwx4KDri1j6PfPNkBprbtPJ+EbzSw3ZIRienCtnHAJX7+uCISAL3qNztiNGhXCbxBXY39J68YRDYUzaIk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=aV+lM5N7PE6wKu8k6aO2uEl9WueYWQo2qyvxM+4lxgA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 91ED5900260;
 Tue,  7 May 2024 11:34:40 +0800 (CST)
Message-ID: <6ba0307a-46d6-4054-bec2-1a0952959797@rock-chips.com>
Date: Tue, 7 May 2024 11:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] phy: rockchip: usbdp: Adopt driver to work with
 upstream DT
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-13-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240504194346.2462489-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktPH1ZLQh8fQ09PHUgeGB5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f511e23c303a9kunm91ed5900260
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46Lio4LzNJLhRCIjw*NRYy
 Fk5PCx9VSlVKTEpOS05JQ0NKSUxOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTkNDNwY+
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
> The upstream DT binding added in linux-phy next commit a75d8056e9fe
> ("dt-bindings: phy: add rockchip usbdp combo phy document") does not
> define subnodes for the type of PHY, instead it is expected that phandle
> args are used for setting the type of the PHY.
>
>    phys = <&usbdp_phy0 PHY_TYPE_USB3>
>
> Adopt the usbdp phy driver to work with upstream DT binding targeted for
> Linux kernel v6.10.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 63 ++++++-----------------
>   1 file changed, 17 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index bf0fb6d8288f..18e76402799b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -21,7 +21,7 @@
>   #include <reset.h>
>   #include <syscon.h>
>   #include <asm/arch-rockchip/clock.h>
> -
> +#include <dt-bindings/phy/phy.h>
>   #include <linux/usb/phy-rockchip-usbdp.h>
>   
>   #define BIT_WRITEABLE_SHIFT	16
> @@ -585,10 +585,21 @@ static int udphy_power_off(struct rockchip_udphy *udphy, u8 mode)
>   	return 0;
>   }
>   
> +static int rockchip_u3phy_of_xlate(struct phy *phy,
> +				   struct ofnode_phandle_args *args)
> +{
> +	if (args->args_count == 0)
> +		return -EINVAL;
> +
> +	if (args->args[0] != PHY_TYPE_USB3)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static int rockchip_u3phy_init(struct phy *phy)
>   {
> -	struct udevice *parent = phy->dev->parent;
> -	struct rockchip_udphy *udphy = dev_get_priv(parent);
> +	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
>   
>   	/* DP only or high-speed, disable U3 port */
>   	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs) {
> @@ -601,8 +612,7 @@ static int rockchip_u3phy_init(struct phy *phy)
>   
>   static int rockchip_u3phy_exit(struct phy *phy)
>   {
> -	struct udevice *parent = phy->dev->parent;
> -	struct rockchip_udphy *udphy = dev_get_priv(parent);
> +	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
>   
>   	/* DP only or high-speed */
>   	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs)
> @@ -612,6 +622,7 @@ static int rockchip_u3phy_exit(struct phy *phy)
>   }
>   
>   static const struct phy_ops rockchip_u3phy_ops = {
> +	.of_xlate	= rockchip_u3phy_of_xlate,
>   	.init		= rockchip_u3phy_init,
>   	.exit		= rockchip_u3phy_exit,
>   };
> @@ -671,40 +682,6 @@ static int rockchip_udphy_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static int rockchip_udphy_bind(struct udevice *parent)
> -{
> -	struct udevice *child;
> -	ofnode subnode;
> -	const char *node_name;
> -	int ret;
> -
> -	dev_for_each_subnode(subnode, parent) {
> -		if (!ofnode_valid(subnode)) {
> -			printf("%s: no subnode for %s", __func__, parent->name);
> -			return -ENXIO;
> -		}
> -
> -		node_name = ofnode_get_name(subnode);
> -		debug("%s: subnode %s\n", __func__, node_name);
> -
> -		/* if there is no match, continue */
> -		if (strcasecmp(node_name, "usb3-port"))
> -			continue;
> -
> -		/* node name is usb3-port */
> -		ret = device_bind_driver_to_node(parent,
> -						 "rockchip_udphy_u3_port",
> -						 node_name, subnode, &child);
> -		if (ret) {
> -			printf("%s: '%s' cannot bind its driver\n",
> -			       __func__, node_name);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   static int rk3588_udphy_refclk_set(struct rockchip_udphy *udphy)
>   {
>   	/* configure phy reference clock */
> @@ -869,17 +846,11 @@ static const struct udevice_id rockchip_udphy_dt_match[] = {
>   	{ /* sentinel */ }
>   };
>   
> -U_BOOT_DRIVER(rockchip_udphy_u3_port) = {
> -	.name		= "rockchip_udphy_u3_port",
> -	.id		= UCLASS_PHY,
> -	.ops		= &rockchip_u3phy_ops,
> -};
> -
>   U_BOOT_DRIVER(rockchip_udphy) = {
>   	.name		= "rockchip_udphy",
>   	.id		= UCLASS_PHY,
>   	.of_match	= rockchip_udphy_dt_match,
>   	.probe		= rockchip_udphy_probe,
> -	.bind		= rockchip_udphy_bind,
> +	.ops		= &rockchip_u3phy_ops,
>   	.priv_auto	= sizeof(struct rockchip_udphy),
>   };
