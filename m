Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6757FCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE328388C;
	Sat, 30 Aug 2025 18:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SKxzOh5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03F583893; Sat, 30 Aug 2025 18:45:51 +0200 (CEST)
Received: from mail-m25494.xmail.ntesmail.com (mail-m25494.xmail.ntesmail.com
 [103.129.254.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54DDD83881
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a624c;
 Sun, 31 Aug 2025 00:45:45 +0800 (GMT+08:00)
Message-ID: <e905d1a9-f58d-4f0e-a624-ec60e79d3f81@rock-chips.com>
Date: Sun, 31 Aug 2025 00:45:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] phy: rockchip: usbdp: Simplify init ops
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbdee5d803afkunm4e0df6e642cc49
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0sZVkMeTEJMQkJNGRhPSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=SKxzOh5fKSywP6SOX3IP9XtA1lh47cOuOWZTrvDsDBolL9bIEQ3oa30d3D6uz3vpRpESSDTQrK1dhaw1ZIXuCF27IsMbtth3ZJZaeD6eHMFSO+YU3lE5BBBnTWsuXsdh+iHGF3UnkQOxcjdHX/dQgsNcMEmjlWUFPu6BKuZaS5M=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=n6da4ZaPMw0svoK2t1CfE1ZMkTiabM8EKoQR0SeIDis=;
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
> With working shared reference counting for Generic PHY ops there is no
> need for the Rockchip USBDP PHY driver to keep its own status (reference
> counting) handling.
>
> Simplify the init ops now that shared reference counting is working.
> This also removes the unused mode_change handling as part of the
> simplication.
>
> No runtime change is expected with this simplication.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 71 +++--------------------
>   1 file changed, 8 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 56963c87183e..6cfbef02b4ac 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -96,9 +96,7 @@ struct rockchip_udphy {
>   
>   	/* PHY status management */
>   	bool flip;
> -	bool mode_change;
>   	u8 mode;
> -	u8 status;
>   
>   	/* utilized for USB */
>   	bool hs; /* flag for high-speed */
> @@ -525,65 +523,6 @@ static int udphy_parse_dt(struct rockchip_udphy *udphy, struct udevice *dev)
>   	return 0;
>   }
>   
> -static int udphy_power_on(struct rockchip_udphy *udphy, u8 mode)
> -{
> -	int ret;
> -
> -	if (!(udphy->mode & mode)) {
> -		dev_info(udphy->dev, "mode 0x%02x is not support\n", mode);
> -		return 0;
> -	}
> -
> -	if (udphy->status == UDPHY_MODE_NONE) {
> -		udphy->mode_change = false;
> -		ret = udphy_setup(udphy);
> -		if (ret)
> -			return ret;
> -
> -		if (udphy->mode & UDPHY_MODE_USB)
> -			udphy_u3_port_disable(udphy, false);
> -	} else if (udphy->mode_change) {
> -		udphy->mode_change = false;
> -		udphy->status = UDPHY_MODE_NONE;
> -		if (udphy->mode == UDPHY_MODE_DP)
> -			udphy_u3_port_disable(udphy, true);
> -
> -		ret = udphy_disable(udphy);
> -		if (ret)
> -			return ret;
> -		ret = udphy_setup(udphy);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	udphy->status |= mode;
> -
> -	return 0;
> -}
> -
> -static int udphy_power_off(struct rockchip_udphy *udphy, u8 mode)
> -{
> -	int ret;
> -
> -	if (!(udphy->mode & mode)) {
> -		dev_info(udphy->dev, "mode 0x%02x is not supported\n", mode);
> -		return 0;
> -	}
> -
> -	if (!udphy->status)
> -		return 0;
> -
> -	udphy->status &= ~mode;
> -
> -	if (udphy->status == UDPHY_MODE_NONE) {
> -		ret = udphy_disable(udphy);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static int rockchip_u3phy_of_xlate(struct phy *phy,
>   				   struct ofnode_phandle_args *args)
>   {
> @@ -603,6 +542,7 @@ static int rockchip_u3phy_of_xlate(struct phy *phy,
>   static int rockchip_u3phy_init(struct phy *phy)
>   {
>   	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
> +	int ret;
>   
>   	/* DP only or high-speed, disable U3 port */
>   	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs) {
> @@ -610,7 +550,12 @@ static int rockchip_u3phy_init(struct phy *phy)
>   		return 0;
>   	}
>   
> -	return udphy_power_on(udphy, UDPHY_MODE_USB);
> +	ret = udphy_setup(udphy);
> +	if (ret)
> +		return ret;
> +
> +	udphy_u3_port_disable(udphy, false);
> +	return 0;
>   }
>   
>   static int rockchip_u3phy_exit(struct phy *phy)
> @@ -621,7 +566,7 @@ static int rockchip_u3phy_exit(struct phy *phy)
>   	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs)
>   		return 0;
>   
> -	return udphy_power_off(udphy, UDPHY_MODE_USB);
> +	return udphy_disable(udphy);
>   }
>   
>   static const struct phy_ops rockchip_u3phy_ops = {
