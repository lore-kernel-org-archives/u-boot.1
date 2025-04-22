Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DA2C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F25628059D;
	Tue, 22 Apr 2025 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P1bSitl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99E1805D7; Tue, 22 Apr 2025 16:52:42 +0200 (CEST)
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com
 [45.254.49.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1978059A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b44d;
 Tue, 22 Apr 2025 22:52:35 +0800 (GMT+08:00)
Message-ID: <2e2ac513-4849-4602-b3c4-75ecab41a133@rock-chips.com>
Date: Tue, 22 Apr 2025 22:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] net: dwc_eth_qos_rockchip: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-12-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-12-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUgYVktMSk0eSkgfQklIT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfc912503afkunm12bf5b44d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6MAw4ODIDQ0kIAQE1AzwT
 PzcaCxdVSlVKTE9OSEhITk5MTUpNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUNLSUo3Bg++
DKIM-Signature: a=rsa-sha256;
 b=P1bSitl2H7fKwdQmFGZ2epxIHzbFchH8XNYVc61VfsQP+W8kgnTNSG+moZNmkGie1pdA+c1ulWWSFLMl15Jx1Z6jfHNh5a34L37ZZOKpq8WnuypQu0dmZB0nbvAL0BWZLBz+UwIocIu1x/T13lfe0wqu5k7Thze+IltmnojEawk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=LxLf3geh4aDGZEh+KRGQrHaPnrPbWrfqNLehVxUr4cw=;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> Add rk_gmac_ops and other special handling that is needed for GMAC to
> work on RK3576.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/dwc_eth_qos.c          |   4 +
>   drivers/net/dwc_eth_qos_rockchip.c | 154 ++++++++++++++++++++++++++++-
>   2 files changed, 157 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index d4561784a6e..b1bc422f791 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1619,6 +1619,10 @@ static const struct udevice_id eqos_ids[] = {
>   		.compatible = "rockchip,rk3568-gmac",
>   		.data = (ulong)&eqos_rockchip_config
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-gmac",
> +		.data = (ulong)&eqos_rockchip_config
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-gmac",
>   		.data = (ulong)&eqos_rockchip_config
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index 3a9c46a01ec..d646d3ebac8 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -260,6 +260,145 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
>   	return 0;
>   }
>   
> +/* VCCIO0_1_3_IOC */
> +#define RK3576_VCCIO0_1_3_IOC_CON2		0x6408
> +#define RK3576_VCCIO0_1_3_IOC_CON3		0x640c
> +#define RK3576_VCCIO0_1_3_IOC_CON4		0x6410
> +#define RK3576_VCCIO0_1_3_IOC_CON5		0x6414
> +
> +#define RK3576_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(15)
> +#define RK3576_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(15)
> +#define RK3576_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(7)
> +#define RK3576_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(7)
> +
> +#define RK3576_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 8)
> +#define RK3576_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 0)
> +
> +/* SDGMAC_GRF */
> +#define RK3576_GRF_GMAC_CON0			0x0020
> +#define RK3576_GRF_GMAC_CON1			0x0024
> +
> +#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
> +#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
> +
> +#define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
> +#define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
> +
> +#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
> +#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
> +
> +#define RK3576_GMAC_CLK_RGMII_DIV1		\
> +			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
> +#define RK3576_GMAC_CLK_RGMII_DIV5		\
> +			(GRF_BIT(6) | GRF_BIT(5))
> +#define RK3576_GMAC_CLK_RGMII_DIV50		\
> +			(GRF_BIT(6) | GRF_CLR_BIT(5))
> +
> +#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
> +#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
> +
> +static int rk3576_set_to_rgmii(struct udevice *dev,
> +			       int tx_delay, int rx_delay)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 offset_con;
> +
> +	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +				     RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(data->grf, offset_con, RK3576_GMAC_RGMII_MODE);
> +
> +	offset_con = data->id == 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
> +				     RK3576_VCCIO0_1_3_IOC_CON2;
> +
> +	/* m0 && m1 delay enabled */
> +	regmap_write(data->php_grf, offset_con,
> +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> +	regmap_write(data->php_grf, offset_con + 0x4,
> +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> +
> +	/* m0 && m1 delay value */
> +	regmap_write(data->php_grf, offset_con,
> +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> +	regmap_write(data->php_grf, offset_con + 0x4,
> +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> +
> +	return 0;
> +}
> +
> +static int rk3576_set_to_rmii(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 offset_con;
> +
> +	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +				     RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(data->grf, offset_con, RK3576_GMAC_RMII_MODE);
> +
> +	return 0;
> +}
> +
> +static int rk3576_set_gmac_speed(struct udevice *dev)
> +{
> +	struct eqos_priv *eqos = dev_get_priv(dev);
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 val = 0, offset_con;
> +
> +	switch (eqos->phy->speed) {
> +	case SPEED_10:
> +		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
> +			val = RK3576_GMAC_CLK_RMII_DIV20;
> +		else
> +			val = RK3576_GMAC_CLK_RGMII_DIV50;
> +		break;
> +	case SPEED_100:
> +		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
> +			val = RK3576_GMAC_CLK_RMII_DIV2;
> +		else
> +			val = RK3576_GMAC_CLK_RGMII_DIV5;
> +		break;
> +	case SPEED_1000:
> +		if (pdata->phy_interface != PHY_INTERFACE_MODE_RMII)
> +			val = RK3576_GMAC_CLK_RGMII_DIV1;
> +		else
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +				     RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(data->grf, offset_con, val);
> +
> +	return 0;
> +}
> +
> +static void rk3576_set_clock_selection(struct udevice *dev, bool enable)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	u32 val = data->clock_input ? RK3576_GMAC_CLK_SELECT_IO :
> +				      RK3576_GMAC_CLK_SELECT_CRU;
> +	u32 offset_con;
> +
> +	val |= enable ? RK3576_GMAC_CLK_RMII_NOGATE :
> +			RK3576_GMAC_CLK_RMII_GATE;
> +
> +	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +				     RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(data->grf, offset_con, val);
> +}
> +
>   #define RK3588_DELAY_ENABLE(id, tx, rx) \
>   	(((tx) ? RK3588_GMAC_TXCLK_DLY_ENABLE(id) : RK3588_GMAC_TXCLK_DLY_DISABLE(id)) | \
>   	 ((rx) ? RK3588_GMAC_RXCLK_DLY_ENABLE(id) : RK3588_GMAC_RXCLK_DLY_DISABLE(id)))
> @@ -418,6 +557,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] = {
>   			0x0, /* sentinel */
>   		},
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-gmac",
> +		.set_to_rgmii = rk3576_set_to_rgmii,
> +		.set_to_rmii = rk3576_set_to_rmii,
> +		.set_gmac_speed = rk3576_set_gmac_speed,
> +		.set_clock_selection = rk3576_set_clock_selection,
> +		.regs = {
> +			0x2a220000, /* gmac0 */
> +			0x2a230000, /* gmac1 */
> +			0x0, /* sentinel */
> +		},
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-gmac",
>   		.set_to_rgmii = rk3588_set_to_rgmii,
> @@ -495,7 +646,8 @@ static int eqos_probe_resources_rk(struct udevice *dev)
>   		goto err_free;
>   	}
>   
> -	if (device_is_compatible(dev, "rockchip,rk3588-gmac")) {
> +	if (device_is_compatible(dev, "rockchip,rk3588-gmac") ||
> +	    device_is_compatible(dev, "rockchip,rk3576-gmac")) {
>   		data->php_grf =
>   			syscon_regmap_lookup_by_phandle(dev, "rockchip,php-grf");
>   		if (IS_ERR(data->php_grf)) {
