Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76C3C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F602833E8;
	Tue,  8 Apr 2025 05:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GZJR99af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788DC83346; Tue,  8 Apr 2025 05:24:29 +0200 (CEST)
Received: from mail-m93232.xmail.ntesmail.com (mail-m93232.xmail.ntesmail.com
 [103.126.93.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6285682CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208c94;
 Tue, 8 Apr 2025 11:24:21 +0800 (GMT+08:00)
Message-ID: <b39375ca-9511-499c-b4ee-41ea627af357@rock-chips.com>
Date: Tue, 8 Apr 2025 11:24:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/30] phy: rockchip-inno-usb2: Add support for
 clkout_ctl_phy
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-27-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-27-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxOGlYeGUJJHkJNGEsaGUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136d70aa03afkunm110208c94
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6Tjo*CjICLUIuL04QPytJ
 NDAwCxhVSlVKTE9PS0NJTU1JTUlPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTEtINwY+
DKIM-Signature: a=rsa-sha256;
 b=GZJR99af2pQ91dmE/8bLjLQSItA/MqLfp6bDdU0IpyNYO5/U69sRF7kwmbaACvXXV2o8/ikAvwMzgmjKl/xstccLIh7yyoTlL+Pk25BiuM/Ez2LhP1e4lEGPh2571Ott8ejEhSk/hTKufKlWhPN0mhHIYROS2R1IwSv2kCA8IQI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=GlwZHV0xKNNXt6kMlUuq46zWlsxA95ykuuakGaNiCyc=;
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
> The 480m clk is controlled using regs in the PHY address space and not
> in the USB GRF address space on e.g. RK3528 and RK3506.
>
> Add a clkout_ctl_phy usb2phy_reg to handle enable/disable of the 480m
> clk on these SoCs.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 43 ++++++++++++++-----
>   1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 43f6e020a6a0..f40a86bc9dae 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -40,11 +40,13 @@ struct rockchip_usb2phy_port_cfg {
>   struct rockchip_usb2phy_cfg {
>   	unsigned int reg;
>   	struct usb2phy_reg	clkout_ctl;
> +	struct usb2phy_reg	clkout_ctl_phy;
>   	const struct rockchip_usb2phy_port_cfg port_cfgs[USB2PHY_NUM_PORTS];
>   };
>   
>   struct rockchip_usb2phy {
>   	struct regmap *reg_base;
> +	struct regmap *phy_base;
>   	struct clk phyclk;
>   	const struct rockchip_usb2phy_cfg *phy_cfg;
>   };
> @@ -165,6 +167,22 @@ static struct phy_ops rockchip_usb2phy_ops = {
>   	.of_xlate = rockchip_usb2phy_of_xlate,
>   };
>   
> +static void rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
> +					const struct usb2phy_reg **clkout_ctl)
> +{
> +	struct udevice *parent = dev_get_parent(clk->dev);
> +	struct rockchip_usb2phy *priv = dev_get_priv(parent);
> +	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
> +
> +	if (priv->phy_cfg->clkout_ctl_phy.enable) {
> +		*base = priv->phy_base;
> +		*clkout_ctl = &phy_cfg->clkout_ctl_phy;
> +	} else {
> +		*base = priv->reg_base;
> +		*clkout_ctl = &phy_cfg->clkout_ctl;
> +	}
> +}
> +
>   /**
>    * round_rate() - Adjust a rate to the exact rate a clock can provide.
>    * @clk:	The clock to manipulate.
> @@ -185,13 +203,14 @@ ulong rockchip_usb2phy_clk_round_rate(struct clk *clk, ulong rate)
>    */
>   int rockchip_usb2phy_clk_enable(struct clk *clk)
>   {
> -	struct udevice *parent = dev_get_parent(clk->dev);
> -	struct rockchip_usb2phy *priv = dev_get_priv(parent);
> -	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
> +	const struct usb2phy_reg *clkout_ctl;
> +	struct regmap *base;
> +
> +	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
>   
>   	/* turn on 480m clk output if it is off */
> -	if (!property_enabled(priv->reg_base, &phy_cfg->clkout_ctl)) {
> -		property_enable(priv->reg_base, &phy_cfg->clkout_ctl, true);
> +	if (!property_enabled(base, clkout_ctl)) {
> +		property_enable(base, clkout_ctl, true);
>   
>   		/* waiting for the clk become stable */
>   		usleep_range(1200, 1300);
> @@ -208,12 +227,13 @@ int rockchip_usb2phy_clk_enable(struct clk *clk)
>    */
>   int rockchip_usb2phy_clk_disable(struct clk *clk)
>   {
> -	struct udevice *parent = dev_get_parent(clk->dev);
> -	struct rockchip_usb2phy *priv = dev_get_priv(parent);
> -	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
> +	const struct usb2phy_reg *clkout_ctl;
> +	struct regmap *base;
> +
> +	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
>   
>   	/* turn off 480m clk output */
> -	property_enable(priv->reg_base, &phy_cfg->clkout_ctl, false);
> +	property_enable(base, clkout_ctl, false);
>   
>   	return 0;
>   }
> @@ -281,7 +301,10 @@ static int rockchip_usb2phy_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	return 0;
> +	if (priv->phy_cfg->clkout_ctl_phy.enable)
> +		ret = regmap_init_mem_index(dev_ofnode(dev), &priv->phy_base, 0);
> +
> +	return ret;
>   }
>   
>   static int rockchip_usb2phy_bind(struct udevice *dev)
