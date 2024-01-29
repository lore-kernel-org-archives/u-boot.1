Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B39C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 14:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC718792D;
	Mon, 29 Jan 2024 15:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=agner.ch header.i=@agner.ch header.b="wdu2LGka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FB087C20; Mon, 29 Jan 2024 15:45:34 +0100 (CET)
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DEA87776
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 15:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=stefan@agner.ch
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 087005C25AF;
 Mon, 29 Jan 2024 15:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1706539531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJJt+K0AgWdF15J+3UF9+YdVU1ubsIU3rPq/yPRnD0U=;
 b=wdu2LGkaGir2EOIm/e2SWsmmM4mDtT+Gm8YP5k44IVSjqCp1tZiuHdxWCXS8QCo8I5punQ
 CQM8w1ePDzH8WD77OAKaWusN71YkD43OKrr21UKqtMvC+XT1TSws4cJHUh1Oa9hvjBKeyK
 uBhP1FiycMGtxdSfFu575+0hN9qTsc8=
MIME-Version: 1.0
Date: Mon, 29 Jan 2024 15:45:30 +0100
From: Stefan Agner <stefan@agner.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, David Wu
 <david.wu@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, =?UTF-8?Q?Jan_=C4=8Cerm=C3=A1k?=
 <sairon@sairon.cz>
Subject: Re: [PATCH v2 5/7] net: dwc_eth_qos_rockchip: Add support for RK3588
In-Reply-To: <20231001191730.4167035-6-jonas@kwiboo.se>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-6-jonas@kwiboo.se>
Message-ID: <4d559f321ab71f240805cc0346fe59e2@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi Jonas,

On 2023-10-01 21:17, Jonas Karlman wrote:
> Add rk_gmac_ops and other special handling that is needed for GMAC to
> work on RK3588.
> 
> rk_gmac_ops was ported from linux commits:
> 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk3588")
> 88619e77b33d ("net: stmmac: rk3588: Allow multiple gmac controller")

I've updated from U-Boot 2023.07.2 to 2024.01, and noticed Ethernet
issue on Linux. On a ODROID-M1 with 8GB of RAM I had a packet drop rate
of ~20%:

107 packets transmitted, 87 received, 18.6916% packet loss, time
107390ms
rtt min/avg/max/mdev = 0.337/0.405/0.889/0.076 ms

SSH connections feel very sluggy, presumably due to packet losses.

Strangely, the same build works just fine on another ODROID-M1 with 4GB
of RAM. I swapped Ethernet cable and switches to rule this out. It
really seems to bee that particular unit which is problematic.

Disabling this driver fixes the Etherent issue on Linux.

Do you have an idea what this could be? I am happy to run commands or
test patches to debug this.

--
Stefan


> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> Cc: David Wu <david.wu@rock-chips.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> v2:
> - Collect r-b tag
> 
>  drivers/net/dwc_eth_qos.c          |   4 +
>  drivers/net/dwc_eth_qos_rockchip.c | 182 ++++++++++++++++++++++++++++-
>  2 files changed, 182 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 9fb98a2c3c74..dc04416865dd 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1712,6 +1712,10 @@ static const struct udevice_id eqos_ids[] = {
>  		.compatible = "rockchip,rk3568-gmac",
>  		.data = (ulong)&eqos_rockchip_config
>  	},
> +	{
> +		.compatible = "rockchip,rk3588-gmac",
> +		.data = (ulong)&eqos_rockchip_config
> +	},
>  #endif
>  #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>  	{
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c
> b/drivers/net/dwc_eth_qos_rockchip.c
> index 05edc098f50d..20fd3a25c3dd 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -28,6 +28,7 @@ struct rk_gmac_ops {
>  			    int tx_delay, int rx_delay);
>  	int (*set_to_rmii)(struct udevice *dev);
>  	int (*set_gmac_speed)(struct udevice *dev);
> +	void (*set_clock_selection)(struct udevice *dev, bool enable);
>  	u32 regs[3];
>  };
>  
> @@ -35,7 +36,9 @@ struct rockchip_platform_data {
>  	struct reset_ctl_bulk resets;
>  	const struct rk_gmac_ops *ops;
>  	int id;
> +	bool clock_input;
>  	struct regmap *grf;
> +	struct regmap *php_grf;
>  };
>  
>  #define HIWORD_UPDATE(val, mask, shift) \
> @@ -129,6 +132,137 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
>  	return 0;
>  }
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
> +	(GRF_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_CLR_BIT(5 +
> (id) * 6))
> +#define RK3588_GMAC_PHY_INTF_SEL_RMII(id)	\
> +	(GRF_CLR_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_BIT(5 +
> (id) * 6))
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
>  static const struct rk_gmac_ops rk_gmac_ops[] = {
>  	{
>  		.compatible = "rockchip,rk3568-gmac",
> @@ -141,6 +275,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] = {
>  			0x0, /* sentinel */
>  		},
>  	},
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
>  	{ }
>  };
>  
> @@ -162,6 +308,7 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>  	struct eqos_priv *eqos = dev_get_priv(dev);
>  	struct eth_pdata *pdata = dev_get_plat(dev);
>  	struct rockchip_platform_data *data;
> +	const char *clock_in_out;
>  	int reset_flags = GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
>  	int ret;
>  
> @@ -199,6 +346,16 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>  		goto err_free;
>  	}
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
>  	ret = reset_get_bulk(dev, &data->resets);
>  	if (ret < 0)
>  		goto err_free;
> @@ -211,12 +368,20 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>  		goto err_release_resets;
>  	}
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
>  	}
>  
> +	clock_in_out = dev_read_string(dev, "clock_in_out");
> +	if (clock_in_out && !strcmp(clock_in_out, "input"))
> +		data->clock_input = true;
> +	else
> +		data->clock_input = false;
> +
>  	/* snps,reset props are deprecated, do bare minimum to support them */
>  	if (dev_read_bool(dev, "snps,reset-active-low"))
>  		reset_flags |= GPIOD_ACTIVE_LOW;
> @@ -273,6 +438,12 @@ static int eqos_start_resets_rk(struct udevice *dev)
>  
>  static int eqos_stop_clks_rk(struct udevice *dev)
>  {
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	if (data->ops->set_clock_selection)
> +		data->ops->set_clock_selection(dev, false);
> +
>  	return 0;
>  }
>  
> @@ -293,6 +464,9 @@ static int eqos_start_clks_rk(struct udevice *dev)
>  		udelay(eqos->reset_delays[2]);
>  	}
>  
> +	if (data->ops->set_clock_selection)
> +		data->ops->set_clock_selection(dev, true);
> +
>  	tx_delay = dev_read_u32_default(dev, "tx_delay", 0x30);
>  	rx_delay = dev_read_u32_default(dev, "rx_delay", 0x10);
