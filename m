Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A17C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 03:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C9B8272A;
	Thu,  8 May 2025 05:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EDWzeRDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45CD82991; Thu,  8 May 2025 05:12:53 +0200 (CEST)
Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com
 [220.197.31.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A4782958
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 05:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14523fb68;
 Thu, 8 May 2025 11:12:45 +0800 (GMT+08:00)
Message-ID: <319959fd-319a-4c34-8abf-a57398ef1dac@rock-chips.com>
Date: Thu, 8 May 2025 11:12:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: gmac_rockchip: Add RMII support for rk3288
To: chf.fritz@googlemail.com, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Fabio Estevam <festevam@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 RamonFried <rfried.dev@gmail.com>, u-boot <u-boot@lists.denx.de>
References: <13931598d2714780f91ce96d054664f304de7c1f.camel@googlemail.com>
 <b8247c8953823fc1b61ec7447b37b9844d6c3db3.camel@googlemail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <b8247c8953823fc1b61ec7447b37b9844d6c3db3.camel@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU4eVk1KQ0IYGkJMQ0ofS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96ade1984703afkunm14523fb68
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6Nyo4MTIBFQhOCh9KSBoe
 EUtPCixVSlVKTE9NTUxIQk1NT0tOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9OQ0M3Bg++
DKIM-Signature: a=rsa-sha256;
 b=EDWzeRDJG1dRaTELOuf2onpzbAD4Q0PboAUaAsb1vhDGciMVBy10PReqmxCfviNC9euUw+T3F0ozuLQtLCI2i8zcpD888SOq51GCIOx25gN/0j1H81yJAodM8qqeKUpC5wL1bLsOH3jiRDA63kviXhq9j8rj84xzHE1cvQ7Hi3Q=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=BnUzhgH/dKiRtJIbF46Xa92N3YUN68/PbtTSEabZEoM=;
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


On 2025/4/16 19:45, Christoph Fritz wrote:
> Add RMII-specific handling to rk3288_gmac_fix_mac_speed() so that it
> properly sets the RMII clock (2.5 MHz vs. 25 MHz) and speed bits
> (10 Mbps vs. 100 Mbps). Also define a new rk3288_gmac_set_to_rmii()
> function to set the PHY interface field and RMII_MODE bit.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/gmac_rockchip.c | 69 ++++++++++++++++++++++++++++---------
>   1 file changed, 53 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 8cfeeffe95b..c8cfe7448d4 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -151,26 +151,51 @@ static int rk3228_gmac_fix_mac_speed(struct dw_eth_dev *priv)
>   
>   static int rk3288_gmac_fix_mac_speed(struct dw_eth_dev *priv)
>   {
> +	struct dw_eth_pdata *dw_pdata = dev_get_plat(priv->dev);
> +	struct eth_pdata *eth_pdata = &dw_pdata->eth_pdata;
>   	struct rk3288_grf *grf;
> +	grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>   	int clk;
>   
> -	switch (priv->phydev->speed) {
> -	case 10:
> -		clk = RK3288_GMAC_CLK_SEL_2_5M;
> -		break;
> -	case 100:
> -		clk = RK3288_GMAC_CLK_SEL_25M;
> -		break;
> -	case 1000:
> -		clk = RK3288_GMAC_CLK_SEL_125M;
> -		break;
> -	default:
> -		debug("Unknown phy speed: %d\n", priv->phydev->speed);
> -		return -EINVAL;
> -	}
> +	if (eth_pdata->phy_interface == PHY_INTERFACE_MODE_RMII) {
> +		switch (priv->phydev->speed) {
> +		case 10:
> +			rk_clrsetreg(&grf->soc_con1,
> +				     RK3288_RMII_CLK_SEL_MASK |
> +				     RK3288_GMAC_SPEED_MASK,
> +				     RK3288_RMII_CLK_SEL_2_5M |
> +				     RK3288_GMAC_SPEED_10M);
> +			break;
> +		case 100:
> +			rk_clrsetreg(&grf->soc_con1,
> +				     RK3288_RMII_CLK_SEL_MASK |
> +				     RK3288_GMAC_SPEED_MASK,
> +				     RK3288_RMII_CLK_SEL_25M |
> +				     RK3288_GMAC_SPEED_100M);
> +			break;
> +		default:
> +			debug("Unknown phy speed: %d\n", priv->phydev->speed);
> +			return -EINVAL;
> +		}
> +	} else {
> +		switch (priv->phydev->speed) {
> +		case 10:
> +			clk = RK3288_GMAC_CLK_SEL_2_5M;
> +			break;
> +		case 100:
> +			clk = RK3288_GMAC_CLK_SEL_25M;
> +			break;
> +		case 1000:
> +			clk = RK3288_GMAC_CLK_SEL_125M;
> +			break;
> +
> +		default:
> +			debug("Unknown phy speed: %d\n", priv->phydev->speed);
> +			return -EINVAL;
> +		}
>   
> -	grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> -	rk_clrsetreg(&grf->soc_con1, RK3288_GMAC_CLK_SEL_MASK, clk);
> +		rk_clrsetreg(&grf->soc_con1, RK3288_GMAC_CLK_SEL_MASK, clk);
> +	}
>   
>   	return 0;
>   }
> @@ -401,6 +426,17 @@ static void rk3228_gmac_set_to_rgmii(struct gmac_rockchip_plat *pdata)
>   		     pdata->tx_delay << RK3228_CLK_TX_DL_CFG_GMAC_SHIFT);
>   }
>   
> +static void rk3288_gmac_set_to_rmii(struct gmac_rockchip_plat *pdata)
> +{
> +	struct rk3288_grf *grf;
> +
> +	grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> +
> +	rk_clrsetreg(&grf->soc_con1,
> +		     RK3288_GMAC_PHY_INTF_SEL_MASK | RK3288_RMII_MODE_MASK,
> +		     RK3288_GMAC_PHY_INTF_SEL_RMII | RK3288_RMII_MODE);
> +}
> +
>   static void rk3288_gmac_set_to_rgmii(struct gmac_rockchip_plat *pdata)
>   {
>   	struct rk3288_grf *grf;
> @@ -703,6 +739,7 @@ const struct rk_gmac_ops rk3228_gmac_ops = {
>   const struct rk_gmac_ops rk3288_gmac_ops = {
>   	.fix_mac_speed = rk3288_gmac_fix_mac_speed,
>   	.set_to_rgmii = rk3288_gmac_set_to_rgmii,
> +	.set_to_rmii = rk3288_gmac_set_to_rmii,
>   };
>   
>   const struct rk_gmac_ops rk3308_gmac_ops = {
