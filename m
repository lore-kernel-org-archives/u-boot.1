Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A09FE7F154
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E5286DC7;
	Wed, 27 Sep 2023 05:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MX/dLo0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F8B86DA3; Wed, 27 Sep 2023 05:01:21 +0200 (CEST)
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com
 [101.71.155.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6C686DC7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MX/dLo0Znxt4JE03m1gXiUStfhUZhlIxSCogPc50RsdiLD+Md8lNETvWbKc4kELQOWaH+O8+RP9kIEbMFVyq8x2ArqCCNU5hXc8/00QtC0DGqX/uvtB2Z/40/OL8tdgDOAD9DQk/LAOz3lQuWXjtRu4Sx8PIcFjkBFOKFRzkyo4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=lQrGFiWLt8fZ5JH16VvRKEGDBqnqjiI3T+Ady5niAYs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 1A0A1400311;
 Wed, 27 Sep 2023 11:01:10 +0800 (CST)
Message-ID: <9d572c83-365b-23e7-2233-45eabfd8bf8c@rock-chips.com>
Date: Wed, 27 Sep 2023 11:01:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/7] net: dwc_eth_qos_rockchip: Add support for RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de,
 David Wu <david.wu@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-6-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230807000817.1701012-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwdS1ZNGUwZGEJPSkwdHk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad49556b62eb3kusn1a0a1400311
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6Nzo5PzwrLjYfMwNPLzcI
 EUsKCw1VSlVKTUJOTENITUxJS0xJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUtKSTcG
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


On 2023/8/7 08:08, Jonas Karlman wrote:
> Add rk_gmac_ops and other special handling that is needed for GMAC to
> work on RK3588.
>
> rk_gmac_ops was ported from linux commits:
> 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk3588")
> 88619e77b33d ("net: stmmac: rk3588: Allow multiple gmac controller")
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: David Wu <david.wu@rock-chips.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   drivers/net/dwc_eth_qos.c          |   4 +
>   drivers/net/dwc_eth_qos_rockchip.c | 182 ++++++++++++++++++++++++++++-
>   2 files changed, 182 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 9fb98a2c3c74..dc04416865dd 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1712,6 +1712,10 @@ static const struct udevice_id eqos_ids[] = {
>   		.compatible = "rockchip,rk3568-gmac",
>   		.data = (ulong)&eqos_rockchip_config
>   	},
> +	{
> +		.compatible = "rockchip,rk3588-gmac",
> +		.data = (ulong)&eqos_rockchip_config
> +	},
>   #endif
>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>   	{
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index c8abe351fc3e..34020496bde6 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -20,6 +20,7 @@ struct rk_gmac_ops {
>   			    int tx_delay, int rx_delay);
>   	int (*set_to_rmii)(struct udevice *dev);
>   	int (*set_gmac_speed)(struct udevice *dev);
> +	void (*set_clock_selection)(struct udevice *dev, bool enable);
>   	u32 regs[3];
>   };
>   
> @@ -27,7 +28,9 @@ struct rockchip_platform_data {
>   	struct reset_ctl_bulk resets;
>   	const struct rk_gmac_ops *ops;
>   	int id;
> +	bool clock_input;
>   	struct regmap *grf;
> +	struct regmap *php_grf;
>   };
>   
>   #define HIWORD_UPDATE(val, mask, shift) \
> @@ -121,6 +124,137 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
>   	return 0;
>   }
>   
> +/* sys_grf */
> +#define RK3588_GRF_GMAC_CON7			0x031c
> +#define RK3588_GRF_GMAC_CON8			0x0320
> +#define RK3588_GRF_GMAC_CON9			0x0324
> +
> +#define RK3588_GMAC_RXCLK_DLY_ENABLE(id)	GRF_BIT(2 * (id) + 3)
> +#define RK3588_GMAC_RXCLK_DLY_DISABLE(id)	GRF_CLR_BIT(2 * (id) + 3)
> +#define RK3588_GMAC_TXCLK_DLY_ENABLE(id)	GRF_BIT(2 * (id) + 2)
> +#define RK3588_GMAC_TXCLK_DLY_DISABLE(id)	GRF_CLR_BIT(2 * (id) + 2)
> +
> +#define RK3588_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 8)
> +#define RK3588_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 0)
> +
> +/* php_grf */
> +#define RK3588_GRF_GMAC_CON0			0x0008
> +#define RK3588_GRF_CLK_CON1			0x0070
> +
> +#define RK3588_GMAC_PHY_INTF_SEL_RGMII(id)	\
> +	(GRF_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_CLR_BIT(5 + (id) * 6))
> +#define RK3588_GMAC_PHY_INTF_SEL_RMII(id)	\
> +	(GRF_CLR_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_BIT(5 + (id) * 6))
> +
> +#define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
> +#define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
> +
> +#define RK3588_GMAC_CLK_SELET_CRU(id)		GRF_BIT(5 * (id) + 4)
> +#define RK3588_GMAC_CLK_SELET_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
> +
> +#define RK3588_GMAC_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
> +#define RK3588_GMAC_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
> +
> +#define RK3588_GMAC_CLK_RGMII_DIV1(id)		\
> +			(GRF_CLR_BIT(5 * (id) + 2) | GRF_CLR_BIT(5 * (id) + 3))
> +#define RK3588_GMAC_CLK_RGMII_DIV5(id)		\
> +			(GRF_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
> +#define RK3588_GMAC_CLK_RGMII_DIV50(id)		\
> +			(GRF_CLR_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
> +
> +#define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
> +#define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
> +
> +static int rk3588_set_to_rgmii(struct udevice *dev,
> +			       int tx_delay, int rx_delay)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 offset_con, id = data->id;
> +
> +	offset_con = data->id == 1 ? RK3588_GRF_GMAC_CON9 :
> +				     RK3588_GRF_GMAC_CON8;
> +
> +	regmap_write(data->php_grf, RK3588_GRF_GMAC_CON0,
> +		     RK3588_GMAC_PHY_INTF_SEL_RGMII(id));
> +
> +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1,
> +		     RK3588_GMAC_CLK_RGMII_MODE(id));
> +
> +	regmap_write(data->grf, RK3588_GRF_GMAC_CON7,
> +		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
> +		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
> +
> +	regmap_write(data->grf, offset_con,
> +		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
> +		     RK3588_GMAC_CLK_TX_DL_CFG(tx_delay));
> +
> +	return 0;
> +}
> +
> +static int rk3588_set_to_rmii(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	regmap_write(data->php_grf, RK3588_GRF_GMAC_CON0,
> +		     RK3588_GMAC_PHY_INTF_SEL_RMII(data->id));
> +
> +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1,
> +		     RK3588_GMAC_CLK_RMII_MODE(data->id));
> +
> +	return 0;
> +}
> +
> +static int rk3588_set_gmac_speed(struct udevice *dev)
> +{
> +	struct eqos_priv *eqos = dev_get_priv(dev);
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 val = 0, id = data->id;
> +
> +	switch (eqos->phy->speed) {
> +	case SPEED_10:
> +		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
> +			val = RK3588_GMAC_CLK_RMII_DIV20(id);
> +		else
> +			val = RK3588_GMAC_CLK_RGMII_DIV50(id);
> +		break;
> +	case SPEED_100:
> +		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
> +			val = RK3588_GMAC_CLK_RMII_DIV2(id);
> +		else
> +			val = RK3588_GMAC_CLK_RGMII_DIV5(id);
> +		break;
> +	case SPEED_1000:
> +		if (pdata->phy_interface != PHY_INTERFACE_MODE_RMII)
> +			val = RK3588_GMAC_CLK_RGMII_DIV1(id);
> +		else
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1, val);
> +
> +	return 0;
> +}
> +
> +static void rk3588_set_clock_selection(struct udevice *dev, bool enable)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	u32 val = data->clock_input ? RK3588_GMAC_CLK_SELET_IO(data->id) :
> +				      RK3588_GMAC_CLK_SELET_CRU(data->id);
> +
> +	val |= enable ? RK3588_GMAC_CLK_RMII_NOGATE(data->id) :
> +			RK3588_GMAC_CLK_RMII_GATE(data->id);
> +
> +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1, val);
> +}
> +
>   static const struct rk_gmac_ops rk_gmac_ops[] = {
>   	{
>   		.compatible = "rockchip,rk3568-gmac",
> @@ -133,6 +267,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] = {
>   			0x0, /* sentinel */
>   		},
>   	},
> +	{
> +		.compatible = "rockchip,rk3588-gmac",
> +		.set_to_rgmii = rk3588_set_to_rgmii,
> +		.set_to_rmii = rk3588_set_to_rmii,
> +		.set_gmac_speed = rk3588_set_gmac_speed,
> +		.set_clock_selection = rk3588_set_clock_selection,
> +		.regs = {
> +			0xfe1b0000, /* gmac0 */
> +			0xfe1c0000, /* gmac1 */
> +			0x0, /* sentinel */
> +		},
> +	},
>   	{ }
>   };
>   
> @@ -154,6 +300,7 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>   	struct eqos_priv *eqos = dev_get_priv(dev);
>   	struct eth_pdata *pdata = dev_get_plat(dev);
>   	struct rockchip_platform_data *data;
> +	const char *clock_in_out;
>   	int reset_flags = GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
>   	int ret;
>   
> @@ -191,6 +338,16 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>   		goto err_free;
>   	}
>   
> +	if (device_is_compatible(dev, "rockchip,rk3588-gmac")) {
> +		data->php_grf =
> +			syscon_regmap_lookup_by_phandle(dev, "rockchip,php-grf");
> +		if (IS_ERR(data->php_grf)) {
> +			dev_err(dev, "Missing rockchip,php-grf property\n");
> +			ret = -EINVAL;
> +			goto err_free;
> +		}
> +	}
> +
>   	ret = reset_get_bulk(dev, &data->resets);
>   	if (ret < 0)
>   		goto err_free;
> @@ -203,12 +360,20 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>   		goto err_release_resets;
>   	}
>   
> -	ret = clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
> -	if (ret) {
> -		dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d", ret);
> -		goto err_free_clk_master_bus;
> +	if (device_is_compatible(dev, "rockchip,rk3568-gmac")) {
> +		ret = clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
> +		if (ret) {
> +			dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d", ret);
> +			goto err_free_clk_master_bus;
> +		}
>   	}
>   
> +	clock_in_out = dev_read_string(dev, "clock_in_out");
> +	if (clock_in_out && !strcmp(clock_in_out, "input"))
> +		data->clock_input = true;
> +	else
> +		data->clock_input = false;
> +
>   	if (dev_read_bool(dev, "snps,reset-active-low"))
>   		reset_flags |= GPIOD_ACTIVE_LOW;
>   
> @@ -264,6 +429,12 @@ static int eqos_start_resets_rk(struct udevice *dev)
>   
>   static int eqos_stop_clks_rk(struct udevice *dev)
>   {
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	if (data->ops->set_clock_selection)
> +		data->ops->set_clock_selection(dev, false);
> +
>   	return 0;
>   }
>   
> @@ -284,6 +455,9 @@ static int eqos_start_clks_rk(struct udevice *dev)
>   		udelay(eqos->reset_delays[2]);
>   	}
>   
> +	if (data->ops->set_clock_selection)
> +		data->ops->set_clock_selection(dev, true);
> +
>   	tx_delay = dev_read_u32_default(dev, "tx_delay", 0x30);
>   	rx_delay = dev_read_u32_default(dev, "rx_delay", 0x10);
>   
