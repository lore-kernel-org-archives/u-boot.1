Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C67BC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3E4833C8;
	Tue,  8 Apr 2025 05:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="N/LUXB0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31857833E1; Tue,  8 Apr 2025 05:24:56 +0200 (CEST)
Received: from mail-m49235.qiye.163.com (mail-m49235.qiye.163.com
 [45.254.49.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DDE283314
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 11022a865;
 Tue, 8 Apr 2025 11:24:49 +0800 (GMT+08:00)
Message-ID: <00518581-8f80-4b8e-bf1f-e07e3e1a349b@rock-chips.com>
Date: Tue, 8 Apr 2025 11:24:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/30] net: dwc_eth_qos_rockchip: Add support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-29-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-29-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUMYTVYYTBgaSktCGkgeTxlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136ddcb403afkunm11022a865
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6Exw6DjJCMUI5AU81Px0J
 PBcKFBdVSlVKTE9PS0NJTUJLTkxMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMT0xINwY+
DKIM-Signature: a=rsa-sha256;
 b=N/LUXB0/6xW/5FjU++mgWzBIIoJR7NG4gp4puTSjqqsjZ5dFrqLR8Cc31p5JWXEMTA5VQpmORfkKrlYbvQ0LtCDPkaeHAlWbp+ltOAk9o3VGEemF801T4v/Qe05NIFweNaLltRZZeHPHYEVznNVMNAt4HzlhOuN+/ag3YuvwRoQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=cxPsfnIw8/bT/TNslAP1/Dqt4gb7iW1tBMch9H8tp30=;
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


On 2025/4/8 06:47, Jonas Karlman wrote:
> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
> Ethernet QoS IP.
>
> Add initial support for the RK3528 GMAC variant.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   drivers/net/dwc_eth_qos.c          |   4 +
>   drivers/net/dwc_eth_qos_rockchip.c | 138 +++++++++++++++++++++++++++++
>   2 files changed, 142 insertions(+)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index b4ec3614696e..d4561784a6ec 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1611,6 +1611,10 @@ static const struct udevice_id eqos_ids[] = {
>   	},
>   #endif
>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
> +	{
> +		.compatible = "rockchip,rk3528-gmac",
> +		.data = (ulong)&eqos_rockchip_config
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-gmac",
>   		.data = (ulong)&eqos_rockchip_config
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index f3a0f63003ea..3a9c46a01ec3 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -50,6 +50,132 @@ struct rockchip_platform_data {
>   	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
>   	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
>   
> +#define RK3528_VO_GRF_GMAC_CON		0x0018
> +#define RK3528_VPU_GRF_GMAC_CON5	0x0018
> +#define RK3528_VPU_GRF_GMAC_CON6	0x001c
> +
> +#define RK3528_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(15)
> +#define RK3528_GMAC_RXCLK_DLY_DISABLE	GRF_CLR_BIT(15)
> +#define RK3528_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
> +#define RK3528_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(14)
> +
> +#define RK3528_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0xFF, 8)
> +#define RK3528_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0xFF, 0)
> +
> +#define RK3528_GMAC0_PHY_INTF_SEL_RMII	GRF_BIT(1)
> +#define RK3528_GMAC1_PHY_INTF_SEL_RGMII	GRF_CLR_BIT(8)
> +#define RK3528_GMAC1_PHY_INTF_SEL_RMII	GRF_BIT(8)
> +
> +#define RK3528_GMAC1_CLK_SELECT_CRU	GRF_CLR_BIT(12)
> +#define RK3528_GMAC1_CLK_SELECT_IO	GRF_BIT(12)
> +
> +#define RK3528_GMAC0_CLK_RMII_DIV2	GRF_BIT(3)
> +#define RK3528_GMAC0_CLK_RMII_DIV20	GRF_CLR_BIT(3)
> +#define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
> +#define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
> +
> +#define RK3528_GMAC1_CLK_RGMII_DIV1	(GRF_CLR_BIT(11) | GRF_CLR_BIT(10))
> +#define RK3528_GMAC1_CLK_RGMII_DIV5	(GRF_BIT(11) | GRF_BIT(10))
> +#define RK3528_GMAC1_CLK_RGMII_DIV50	(GRF_BIT(11) | GRF_CLR_BIT(10))
> +
> +#define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
> +#define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
> +#define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
> +#define RK3528_GMAC1_CLK_RMII_NOGATE	GRF_CLR_BIT(9)
> +
> +static int rk3528_set_to_rgmii(struct udevice *dev,
> +			       int tx_delay, int rx_delay)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5,
> +		     RK3528_GMAC1_PHY_INTF_SEL_RGMII);
> +
> +	regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5,
> +		     DELAY_ENABLE(RK3528, tx_delay, rx_delay));
> +
> +	regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON6,
> +		     RK3528_GMAC_CLK_RX_DL_CFG(rx_delay) |
> +		     RK3528_GMAC_CLK_TX_DL_CFG(tx_delay));
> +
> +	return 0;
> +}
> +
> +static int rk3528_set_to_rmii(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +
> +	if (data->id == 1)
> +		regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5,
> +			     RK3528_GMAC1_PHY_INTF_SEL_RMII);
> +	else
> +		regmap_write(data->grf, RK3528_VO_GRF_GMAC_CON,
> +			     RK3528_GMAC0_PHY_INTF_SEL_RMII |
> +			     RK3528_GMAC0_CLK_RMII_DIV2);
> +
> +	return 0;
> +}
> +
> +static int rk3528_set_gmac_speed(struct udevice *dev)
> +{
> +	struct eqos_priv *eqos = dev_get_priv(dev);
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 val, reg;
> +
> +	switch (eqos->phy->speed) {
> +	case SPEED_10:
> +		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
> +			val = data->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV20 :
> +					      RK3528_GMAC0_CLK_RMII_DIV20;
> +		else
> +			val = RK3528_GMAC1_CLK_RGMII_DIV50;
> +		break;
> +	case SPEED_100:
> +		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
> +			val = data->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV2 :
> +					      RK3528_GMAC0_CLK_RMII_DIV2;
> +		else
> +			val = RK3528_GMAC1_CLK_RGMII_DIV5;
> +		break;
> +	case SPEED_1000:
> +		if (pdata->phy_interface != PHY_INTERFACE_MODE_RMII)
> +			val = RK3528_GMAC1_CLK_RGMII_DIV1;
> +		else
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	reg = data->id == 1 ? RK3528_VPU_GRF_GMAC_CON5 :
> +			      RK3528_VO_GRF_GMAC_CON;
> +	regmap_write(data->grf, reg, val);
> +
> +	return 0;
> +}
> +
> +static void rk3528_set_clock_selection(struct udevice *dev, bool enable)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 val;
> +
> +	if (data->id == 1) {
> +		val = data->clock_input ? RK3528_GMAC1_CLK_SELECT_IO :
> +					  RK3528_GMAC1_CLK_SELECT_CRU;
> +		val |= enable ? RK3528_GMAC1_CLK_RMII_NOGATE :
> +				RK3528_GMAC1_CLK_RMII_GATE;
> +		regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5, val);
> +	} else {
> +		val = enable ? RK3528_GMAC0_CLK_RMII_NOGATE :
> +			       RK3528_GMAC0_CLK_RMII_GATE;
> +		regmap_write(data->grf, RK3528_VO_GRF_GMAC_CON, val);
> +	}
> +}
> +
>   #define RK3568_GRF_GMAC0_CON0		0x0380
>   #define RK3568_GRF_GMAC0_CON1		0x0384
>   #define RK3568_GRF_GMAC1_CON0		0x0388
> @@ -269,6 +395,18 @@ static void rk3588_set_clock_selection(struct udevice *dev, bool enable)
>   }
>   
>   static const struct rk_gmac_ops rk_gmac_ops[] = {
> +	{
> +		.compatible = "rockchip,rk3528-gmac",
> +		.set_to_rgmii = rk3528_set_to_rgmii,
> +		.set_to_rmii = rk3528_set_to_rmii,
> +		.set_gmac_speed = rk3528_set_gmac_speed,
> +		.set_clock_selection = rk3528_set_clock_selection,
> +		.regs = {
> +			0xffbd0000, /* gmac0 */
> +			0xffbe0000, /* gmac1 */
> +			0x0, /* sentinel */
> +		},
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-gmac",
>   		.set_to_rgmii = rk3568_set_to_rgmii,
