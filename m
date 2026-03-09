Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EBCF417E3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E26D83FC1;
	Mon,  9 Mar 2026 15:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OQ/mIY0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247DD83FC1; Mon,  9 Mar 2026 15:39:52 +0100 (CET)
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com
 [45.254.49.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2CB83FDC
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e8293;
 Mon, 9 Mar 2026 22:39:42 +0800 (GMT+08:00)
Message-ID: <d1007abf-bcb1-478d-9333-444add5b6bd4@rock-chips.com>
Date: Mon, 9 Mar 2026 22:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] net: dwc_eth_qos_rockchip: Add support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd30a21ac03afkunm77b647da16bc689
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSxlOVkNJGR1PS00YSU1IHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=OQ/mIY0HkKGvOcJmtijJxHRbWbMFxxLasXq7SSom1bFkV2e/b8PQfPo9lVTPFQDFgUKaV329JMYu2plv+5DUIpVmDWcpqqxeNrh1e/BXiUNyhIJ+77BTSgnHx/hnebMnM3IYll1J+S0d5h9Z5p+OKv+s4gpee9JsnQMWoMPn0HM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=e5TMuwJg6e/yr3GP3MB6NOIuyfa+8W1LyNFhs/Y6wzw=;
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


On 2026/2/1 07:38, Jonas Karlman wrote:
> Rockchip RK3506 has two Ethernet controllers based on Synopsys DWC
> Ethernet QoS IP.
>
> Add initial support for the RK3506 GMAC variant.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/net/dwc_eth_qos.c          |  4 ++
>   drivers/net/dwc_eth_qos_rockchip.c | 86 ++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 8a396d0b29ea..0f31d6468456 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1620,6 +1620,10 @@ static const struct udevice_id eqos_ids[] = {
>   	},
>   #endif
>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
> +	{
> +		.compatible = "rockchip,rk3506-gmac",
> +		.data = (ulong)&eqos_rockchip_config
> +	},
>   	{
>   		.compatible = "rockchip,rk3528-gmac",
>   		.data = (ulong)&eqos_rockchip_config
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index d646d3ebac87..4ccefda0ef5e 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -50,6 +50,80 @@ struct rockchip_platform_data {
>   	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
>   	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
>   
> +#define RK3506_GRF_SOC_CON8		0x0020
> +#define RK3506_GRF_SOC_CON11		0x002c
> +
> +#define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
> +
> +#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
> +#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
> +
> +#define RK3506_GMAC_CLK_SELECT_CRU	GRF_CLR_BIT(5)
> +#define RK3506_GMAC_CLK_SELECT_IO	GRF_BIT(5)
> +
> +#define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
> +#define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
> +
> +static int rk3506_set_to_rgmii(struct udevice *dev,
> +			       int tx_delay, int rx_delay)
> +{
> +	return -EINVAL;
> +}
> +
> +static int rk3506_set_to_rmii(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 reg;
> +
> +	reg = data->id == 1 ? RK3506_GRF_SOC_CON11 :
> +			      RK3506_GRF_SOC_CON8;
> +	regmap_write(data->grf, reg, RK3506_GMAC_RMII_MODE);
> +
> +	return 0;
> +}
> +
> +static int rk3506_set_gmac_speed(struct udevice *dev)
> +{
> +	struct eqos_priv *eqos = dev_get_priv(dev);
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 val, reg;
> +
> +	switch (eqos->phy->speed) {
> +	case SPEED_10:
> +		val = RK3506_GMAC_CLK_RMII_DIV20;
> +		break;
> +	case SPEED_100:
> +		val = RK3506_GMAC_CLK_RMII_DIV2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	reg = data->id == 1 ? RK3506_GRF_SOC_CON11 :
> +			      RK3506_GRF_SOC_CON8;
> +	regmap_write(data->grf, reg, val);
> +
> +	return 0;
> +}
> +
> +static void rk3506_set_clock_selection(struct udevice *dev, bool enable)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct rockchip_platform_data *data = pdata->priv_pdata;
> +	u32 val, reg;
> +
> +	val = data->clock_input ? RK3506_GMAC_CLK_SELECT_IO :
> +				  RK3506_GMAC_CLK_SELECT_CRU;
> +	val |= enable ? RK3506_GMAC_CLK_RMII_NOGATE :
> +			RK3506_GMAC_CLK_RMII_GATE;
> +
> +	reg = data->id == 1 ? RK3506_GRF_SOC_CON11 :
> +			      RK3506_GRF_SOC_CON8;
> +	regmap_write(data->grf, reg, val);
> +}
> +
>   #define RK3528_VO_GRF_GMAC_CON		0x0018
>   #define RK3528_VPU_GRF_GMAC_CON5	0x0018
>   #define RK3528_VPU_GRF_GMAC_CON6	0x001c
> @@ -534,6 +608,18 @@ static void rk3588_set_clock_selection(struct udevice *dev, bool enable)
>   }
>   
>   static const struct rk_gmac_ops rk_gmac_ops[] = {
> +	{
> +		.compatible = "rockchip,rk3506-gmac",
> +		.set_to_rgmii = rk3506_set_to_rgmii,
> +		.set_to_rmii = rk3506_set_to_rmii,
> +		.set_gmac_speed = rk3506_set_gmac_speed,
> +		.set_clock_selection = rk3506_set_clock_selection,
> +		.regs = {
> +			0xff4c8000, /* gmac0 */
> +			0xff4d0000, /* gmac1 */
> +			0x0, /* sentinel */
> +		},
> +	},
>   	{
>   		.compatible = "rockchip,rk3528-gmac",
>   		.set_to_rgmii = rk3528_set_to_rgmii,
