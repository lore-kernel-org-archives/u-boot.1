Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA57C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F43E88081;
	Mon,  6 May 2024 12:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eQTVmq0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704E18813F; Mon,  6 May 2024 12:32:29 +0200 (CEST)
Received: from mail-m2417.xmail.ntesmail.com (mail-m2417.xmail.ntesmail.com
 [45.195.24.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DFE88013
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eQTVmq0xp46wBd2ZEMZeIlHZ4shF14f/yFTaDdFrNCZe5nJVeaoe/RRas4s6jgwFPKrEoOrYHZlBb9+7vuc+STpTZRq1wYQcQuZPxbZGtrzlc6nLTxFZJjXUtyupRq4pNk18Vo0loA6DYlaEJ0pH9pVvkID8q5jWaHXQXJsA16E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=7ld5hxFMb4mwZ/bFuUhVEeFtc4ewu663ZrtxB9e/EcI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 059EA900227;
 Mon,  6 May 2024 18:32:10 +0800 (CST)
Message-ID: <a1c2bfdd-79c1-499d-9261-527fbeca8558@rock-chips.com>
Date: Mon, 6 May 2024 18:32:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] clk: rockchip: rk3399: Improve support for
 SCLK_PCIEPHY_REF clock
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240501162308.875193-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgdQ1YaQkgfTk4aGUgYQk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d76064d03a9kunm059ea900227
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6FSo*KzMCFBZLIkodKQI3
 ESMaCQFVSlVKTEpPQkJKTkhKQkNCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNT0tINwY+
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


On 2024/5/2 00:22, Jonas Karlman wrote:
> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
> SCLK_PCIEPHY_REF clock.
>
> The existing enable/disable ops for SCLK_PCIEPHY_REF currently force
> use of 24 MHz parent and rate.
>
> Add improved support for setting parent and rate of the pciephy refclk
> to driver to better support assign-clock props for pciephy refclk in DT.
>
> This limited implementation only support setting 24 or 100 MHz rate,
> and expect npll and clk_pciephy_ref100m divider to use default values.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Implement partial instead of dummy support for SCLK_PCIEPHY_REF
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 59 +++++++++++++++++++++++++++++--
>   1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 5934771b4096..0b3223611a32 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -926,6 +926,26 @@ static ulong rk3399_saradc_set_clk(struct rockchip_cru *cru, uint hz)
>   	return rk3399_saradc_get_clk(cru);
>   }
>   
> +static ulong rk3399_pciephy_get_clk(struct rockchip_cru *cru)
> +{
> +	if (readl(&cru->clksel_con[18]) & BIT(10))
> +		return 100 * MHz;
> +	else
> +		return OSC_HZ;
> +}
> +
> +static ulong rk3399_pciephy_set_clk(struct rockchip_cru *cru, uint hz)
> +{
> +	if (hz == 100 * MHz)
> +		rk_setreg(&cru->clksel_con[18], BIT(10));
> +	else if (hz == OSC_HZ)
> +		rk_clrreg(&cru->clksel_con[18], BIT(10));
> +	else
> +		return -EINVAL;
> +
> +	return rk3399_pciephy_get_clk(cru);
> +}
> +
>   static ulong rk3399_clk_get_rate(struct clk *clk)
>   {
>   	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -967,6 +987,9 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
>   	case SCLK_SARADC:
>   		rate = rk3399_saradc_get_clk(priv->cru);
>   		break;
> +	case SCLK_PCIEPHY_REF:
> +		rate = rk3399_pciephy_get_clk(priv->cru);
> +		break;
>   	case ACLK_VIO:
>   	case ACLK_HDCP:
>   	case ACLK_GIC_PRE:
> @@ -1058,6 +1081,9 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
>   	case SCLK_SARADC:
>   		ret = rk3399_saradc_set_clk(priv->cru, rate);
>   		break;
> +	case SCLK_PCIEPHY_REF:
> +		ret = rk3399_pciephy_set_clk(priv->cru, rate);
> +		break;
>   	case ACLK_VIO:
>   	case ACLK_HDCP:
>   	case ACLK_GIC_PRE:
> @@ -1108,12 +1134,39 @@ static int __maybe_unused rk3399_gmac_set_parent(struct clk *clk,
>   	return -EINVAL;
>   }
>   
> +static int __maybe_unused rk3399_pciephy_set_parent(struct clk *clk,
> +						    struct clk *parent)
> +{
> +	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
> +	const char *clock_output_name;
> +	int ret;
> +
> +	if (parent->dev == clk->dev && parent->id == SCLK_PCIEPHY_REF100M) {
> +		rk_setreg(&priv->cru->clksel_con[18], BIT(10));
> +		return 0;
> +	}
> +
> +	ret = dev_read_string_index(parent->dev, "clock-output-names",
> +				    parent->id, &clock_output_name);
> +	if (ret < 0)
> +		return -ENODATA;
> +
> +	if (!strcmp(clock_output_name, "xin24m")) {
> +		rk_clrreg(&priv->cru->clksel_con[18], BIT(10));
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   static int __maybe_unused rk3399_clk_set_parent(struct clk *clk,
>   						struct clk *parent)
>   {
>   	switch (clk->id) {
>   	case SCLK_RMII_SRC:
>   		return rk3399_gmac_set_parent(clk, parent);
> +	case SCLK_PCIEPHY_REF:
> +		return rk3399_pciephy_set_parent(clk, parent);
>   	}
>   
>   	debug("%s: unsupported clk %ld\n", __func__, clk->id);
> @@ -1204,7 +1257,8 @@ static int rk3399_clk_enable(struct clk *clk)
>   		rk_clrreg(&priv->cru->clkgate_con[13], BIT(7));
>   		break;
>   	case SCLK_PCIEPHY_REF:
> -		rk_clrreg(&priv->cru->clksel_con[18], BIT(10));
> +		if (readl(&priv->cru->clksel_con[18]) & BIT(10))
> +			rk_clrreg(&priv->cru->clkgate_con[12], BIT(6));
>   		break;
>   	default:
>   		debug("%s: unsupported clk %ld\n", __func__, clk->id);
> @@ -1298,7 +1352,8 @@ static int rk3399_clk_disable(struct clk *clk)
>   		rk_setreg(&priv->cru->clkgate_con[13], BIT(7));
>   		break;
>   	case SCLK_PCIEPHY_REF:
> -		rk_clrreg(&priv->cru->clksel_con[18], BIT(10));
> +		if (readl(&priv->cru->clksel_con[18]) & BIT(10))
> +			rk_setreg(&priv->cru->clkgate_con[12], BIT(6));
>   		break;
>   	default:
>   		debug("%s: unsupported clk %ld\n", __func__, clk->id);
