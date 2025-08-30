Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4579DCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A049F83887;
	Sat, 30 Aug 2025 18:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aES02sJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5118388C; Sat, 30 Aug 2025 18:46:24 +0200 (CEST)
Received: from mail-m2434.xmail.ntesmail.com (mail-m2434.xmail.ntesmail.com
 [45.195.24.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4E48380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a6259;
 Sun, 31 Aug 2025 00:46:18 +0800 (GMT+08:00)
Message-ID: <449dcff9-dda0-42dc-b6c0-e01f647c9efc@rock-chips.com>
Date: Sun, 31 Aug 2025 00:46:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] phy: rockchip: naneng-combphy: Simplify init ops
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbdf665603afkunm9ae9dcfc42ce1f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUlJVkseT00eH04fGR8ZTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=aES02sJeAtoBE3gs405iRwPUcr8q66PxkJBMRmDHhZN54sEbC3RJoTfrd9GhkhSZg/HAU10GS+l4jS8lOST7p8blGUt3FC+zwjGY8Zzn+NXUIwUfF+Zx052R71wh6CIuD9fZK3ZUO76cf6YRuIDw0YVBp+UjSBWP7sxftameETs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=/pq85ErMhYo1PVtZG1afUZd5CC1IYzkOhg3WC98KwCc=;
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


On 2025/7/22 06:07, Jonas Karlman wrote:
> The init ops for Rockchip COMBPHY driver is more complex than it needs
> to be, e.g. declaring multiple init functions that only differ in the
> error message.
>
> Simplify the init ops based on code from the Linux mainline driver.
>
> This change also ensure that errors returned from combphy_cfg() and
> reset_deassert_bulk() is propertly propagated to the caller. No other
> runtime change is expected with this simplication.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../rockchip/phy-rockchip-naneng-combphy.c    | 101 ++++--------------
>   1 file changed, 19 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index a3038d067d3a..f246c8db2d6c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -98,104 +98,41 @@ static int param_write(struct regmap *base,
>   	return regmap_write(base, reg->offset, val);
>   }
>   
> -static int rockchip_combphy_pcie_init(struct rockchip_combphy_priv *priv)
> -{
> -	int ret = 0;
> -
> -	if (priv->cfg->combphy_cfg) {
> -		ret = priv->cfg->combphy_cfg(priv);
> -		if (ret) {
> -			dev_err(priv->dev, "failed to init phy for pcie\n");
> -			return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static int rockchip_combphy_usb3_init(struct rockchip_combphy_priv *priv)
> -{
> -	int ret = 0;
> -
> -	if (priv->cfg->combphy_cfg) {
> -		ret = priv->cfg->combphy_cfg(priv);
> -		if (ret) {
> -			dev_err(priv->dev, "failed to init phy for usb3\n");
> -			return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static int rockchip_combphy_sata_init(struct rockchip_combphy_priv *priv)
> -{
> -	int ret = 0;
> -
> -	if (priv->cfg->combphy_cfg) {
> -		ret = priv->cfg->combphy_cfg(priv);
> -		if (ret) {
> -			dev_err(priv->dev, "failed to init phy for sata\n");
> -			return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static int rockchip_combphy_sgmii_init(struct rockchip_combphy_priv *priv)
> +static int rockchip_combphy_init(struct phy *phy)
>   {
> -	int ret = 0;
> -
> -	if (priv->cfg->combphy_cfg) {
> -		ret = priv->cfg->combphy_cfg(priv);
> -		if (ret) {
> -			dev_err(priv->dev, "failed to init phy for sgmii\n");
> -			return ret;
> -		}
> -	}
> +	struct rockchip_combphy_priv *priv = dev_get_priv(phy->dev);
> +	int ret;
>   
> -	return ret;
> -}
> +	ret = clk_enable(&priv->ref_clk);
> +	if (ret < 0 && ret != -ENOSYS)
> +		return ret;
>   
> -static int rockchip_combphy_set_mode(struct rockchip_combphy_priv *priv)
> -{
>   	switch (priv->mode) {
>   	case PHY_TYPE_PCIE:
> -		rockchip_combphy_pcie_init(priv);
> -		break;
>   	case PHY_TYPE_USB3:
> -		rockchip_combphy_usb3_init(priv);
> -		break;
>   	case PHY_TYPE_SATA:
> -		rockchip_combphy_sata_init(priv);
> -		break;
>   	case PHY_TYPE_SGMII:
>   	case PHY_TYPE_QSGMII:
> -		return rockchip_combphy_sgmii_init(priv);
> +		if (priv->cfg->combphy_cfg)
> +			ret = priv->cfg->combphy_cfg(priv);
> +		else
> +			ret = 0;
> +		break;
>   	default:
>   		dev_err(priv->dev, "incompatible PHY type\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		break;
>   	}
>   
> -	return 0;
> -}
> -
> -static int rockchip_combphy_init(struct phy *phy)
> -{
> -	struct rockchip_combphy_priv *priv = dev_get_priv(phy->dev);
> -	int ret;
> -
> -	ret = clk_enable(&priv->ref_clk);
> -	if (ret < 0 && ret != -ENOSYS)
> -		return ret;
> +	if (ret) {
> +		dev_err(priv->dev, "failed to init phy for phy type %x\n", priv->mode);
> +		goto err_clk;
> +	}
>   
> -	ret = rockchip_combphy_set_mode(priv);
> +	ret = reset_deassert_bulk(&priv->phy_rsts);
>   	if (ret)
>   		goto err_clk;
>   
> -	reset_deassert_bulk(&priv->phy_rsts);
> -
>   	return 0;
>   
>   err_clk:
> @@ -305,7 +242,7 @@ static int rockchip_combphy_probe(struct udevice *udev)
>   	}
>   
>   	priv->dev = udev;
> -	priv->mode = PHY_TYPE_SATA;
> +	priv->mode = PHY_NONE;
>   	priv->cfg = phy_cfg;
>   
>   	return rockchip_combphy_parse_dt(udev, priv);
