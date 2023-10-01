Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F26E78482
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7468556F;
	Sun,  1 Oct 2023 21:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0EViWewK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4897D870D0; Sun,  1 Oct 2023 21:04:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9858801B6
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696187076;
 bh=YQ/4EZEzE9bBkjcl59AJL/aMS+tgYx3kQhvnGJH7HEo=;
 b=0EViWewKmoVidvKSUTM4w4FVUnRnLq8Dcd5tRlJl2/3h/2KJ3OcwGWT7pcBnD/aBgEaofWmQe
 cgw0LY+v4wWVE9cynO95a8A87vaJpXvUK8Ey/0/MC10xBvd4wviLZfyE/s8jgprqqHEirxqfuS8
 +vGuMOgxPYNITGUN3Crd7ZTZw1sHcwdPIsJcrHS7U4iWdup1u0VZh7IxSwOer6LKfr934Iz9nE9
 SQKfejvLRTdd4b66weiWFhu+QujO8CM3bRZzLtgCFetvAc0i0SaT7Ym7JodzSGx3RXdMQE1iJPf
 0de+HjjxCyUUzDTP9X+XfsDhkrB3EC3Cm2BTsZ1vGiZQ==
Message-ID: <fbb9ee2f-7c5b-631e-fee4-296f11e3db9a@kwiboo.se>
Date: Sun, 1 Oct 2023 21:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/7] net: dwc_eth_qos: Add glue driver for GMAC on
 Rockchip RK3568
To: David Wu <david.wu@rock-chips.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Frank Wunderlich
 <frank-w@public-files.de>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, Ezequiel Garcia
 <ezequiel@collabora.com>
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-5-jonas@kwiboo.se>
 <6f2bd59d-bd06-1b70-2b9a-be3c1e8bb199@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6f2bd59d-bd06-1b70-2b9a-be3c1e8bb199@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6519c2c4b09c5e14c6e43085
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

Hi David,

On 2023-08-15 15:12, David Wu wrote:
> Hi Jonas,
> 
> Thank you for your help.
> 
> 在 2023/8/7 08:08, Jonas Karlman 写道:
>> Add a new glue driver for Rockchip SoCs, i.e RK3568, with a GMAC based
>> on Synopsys DWC Ethernet QoS IP.
>>
>> rk_gmac_ops was ported from linux commit:
>> 3bb3d6b1c195 ("net: stmmac: Add RK3566/RK3568 SoC support")
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Cc: David Wu <david.wu@rock-chips.com>
>> Cc: Ezequiel Garcia <ezequiel@collabora.com>
>> ---
>>   drivers/net/Kconfig                |   8 +
>>   drivers/net/Makefile               |   1 +
>>   drivers/net/dwc_eth_qos.c          |   8 +-
>>   drivers/net/dwc_eth_qos.h          |   2 +
>>   drivers/net/dwc_eth_qos_rockchip.c | 348 +++++++++++++++++++++++++++++
>>   5 files changed, 365 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/net/dwc_eth_qos_rockchip.c
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 0ed39a61e4de..29304fd77759 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -225,6 +225,14 @@ config DWC_ETH_QOS_IMX
>>   	  The Synopsys Designware Ethernet QOS IP block with the specific
>>   	  configuration used in IMX soc.
>>   
>> +config DWC_ETH_QOS_ROCKCHIP
>> +	bool "Synopsys DWC Ethernet QOS device support for Rockchip SoCs"
>> +	depends on DWC_ETH_QOS
>> +	select DM_ETH_PHY
>> +	help
>> +	  The Synopsys Designware Ethernet QOS IP block with specific
>> +	  configuration used in Rockchip SoCs.
>> +
>>   config DWC_ETH_QOS_STM32
>>   	bool "Synopsys DWC Ethernet QOS device support for STM32"
>>   	depends on DWC_ETH_QOS
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>> index d4af253b6f28..1d444f5b4a69 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_DRIVER_DM9000) += dm9000x.o
>>   obj-$(CONFIG_DSA_SANDBOX) += dsa_sandbox.o
>>   obj-$(CONFIG_DWC_ETH_QOS) += dwc_eth_qos.o
>>   obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
>> +obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
>>   obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
>>   obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
>>   obj-$(CONFIG_E1000) += e1000.o
>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
>> index 24fb3fac1f12..9fb98a2c3c74 100644
>> --- a/drivers/net/dwc_eth_qos.c
>> +++ b/drivers/net/dwc_eth_qos.c
>> @@ -1707,7 +1707,12 @@ static const struct udevice_id eqos_ids[] = {
>>   		.data = (ulong)&eqos_imx_config
>>   	},
>>   #endif
>> -
>> +#if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
>> +	{
>> +		.compatible = "rockchip,rk3568-gmac",
>> +		.data = (ulong)&eqos_rockchip_config
>> +	},
>> +#endif
> 
> If this compatible could move to dwc_eth_qos_rockchip.c, it is better,
> we have other SoCs  that also use this driver in the feature,  and it 
> must increase
> this array all the time for new SoCs later, it will be better only change
> dwc_eth_qos_rockchip.c, we don't need to change the current file.

Agree that this could be improved, not sure how we should/could do it,
and is something that can be done in a follow-up series.

Will leave as-is for v2.

Regards,
Jonas

> 
>>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>>   	{
>>   		.compatible = "qcom,qcs404-ethqos",
>> @@ -1720,7 +1725,6 @@ static const struct udevice_id eqos_ids[] = {
>>   		.data = (ulong)&eqos_jh7110_config
>>   	},
>>   #endif
>> -
>>   	{ }
>>   };
>>   
>> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
>> index 06a082da72ef..e3222e1e17e5 100644
>> --- a/drivers/net/dwc_eth_qos.h
>> +++ b/drivers/net/dwc_eth_qos.h
>> @@ -82,6 +82,7 @@ struct eqos_mac_regs {
>>   #define EQOS_MAC_MDIO_ADDRESS_PA_SHIFT			21
>>   #define EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT			16
>>   #define EQOS_MAC_MDIO_ADDRESS_CR_SHIFT			8
>> +#define EQOS_MAC_MDIO_ADDRESS_CR_100_150		1
>>   #define EQOS_MAC_MDIO_ADDRESS_CR_20_35			2
>>   #define EQOS_MAC_MDIO_ADDRESS_CR_250_300		5
>>   #define EQOS_MAC_MDIO_ADDRESS_SKAP			BIT(4)
>> @@ -287,5 +288,6 @@ void eqos_flush_buffer_generic(void *buf, size_t size);
>>   int eqos_null_ops(struct udevice *dev);
>>   
>>   extern struct eqos_config eqos_imx_config;
>> +extern struct eqos_config eqos_rockchip_config;
>>   extern struct eqos_config eqos_qcom_config;
>>   extern struct eqos_config eqos_jh7110_config;
>> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
>> new file mode 100644
>> index 000000000000..c8abe351fc3e
>> --- /dev/null
>> +++ b/drivers/net/dwc_eth_qos_rockchip.c
>> @@ -0,0 +1,348 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include <common.h>
>> +#include <clk.h>
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <net.h>
>> +#include <phy.h>
>> +#include <regmap.h>
>> +#include <reset.h>
>> +#include <syscon.h>
>> +#include <asm/gpio.h>
>> +#include <linux/delay.h>
>> +
>> +#include "dwc_eth_qos.h"
>> +
>> +struct rk_gmac_ops {
>> +	const char *compatible;
>> +	int (*set_to_rgmii)(struct udevice *dev,
>> +			    int tx_delay, int rx_delay);
>> +	int (*set_to_rmii)(struct udevice *dev);
>> +	int (*set_gmac_speed)(struct udevice *dev);
>> +	u32 regs[3];
>> +};
>> +
>> +struct rockchip_platform_data {
>> +	struct reset_ctl_bulk resets;
>> +	const struct rk_gmac_ops *ops;
>> +	int id;
>> +	struct regmap *grf;
>> +};
>> +
>> +#define HIWORD_UPDATE(val, mask, shift) \
>> +		((val) << (shift) | (mask) << ((shift) + 16))
>> +
>> +#define GRF_BIT(nr)	(BIT(nr) | BIT((nr) + 16))
>> +#define GRF_CLR_BIT(nr)	(BIT((nr) + 16))
>> +
>> +#define RK3568_GRF_GMAC0_CON0		0x0380
>> +#define RK3568_GRF_GMAC0_CON1		0x0384
>> +#define RK3568_GRF_GMAC1_CON0		0x0388
>> +#define RK3568_GRF_GMAC1_CON1		0x038c
>> +
>> +/* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
>> +#define RK3568_GMAC_PHY_INTF_SEL_RGMII	\
>> +		(GRF_BIT(4) | GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
>> +#define RK3568_GMAC_PHY_INTF_SEL_RMII	\
>> +		(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | GRF_BIT(6))
>> +#define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
>> +#define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
>> +#define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
>> +#define RK3568_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(1)
>> +#define RK3568_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(0)
>> +#define RK3568_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(0)
>> +
>> +/* RK3568_GRF_GMAC0_CON0 && RK3568_GRF_GMAC1_CON0 */
>> +#define RK3568_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 8)
>> +#define RK3568_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0x7F, 0)
>> +
>> +static int rk3568_set_to_rgmii(struct udevice *dev,
>> +			       int tx_delay, int rx_delay)
>> +{
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +	u32 con0, con1;
>> +
>> +	con0 = (data->id == 1) ? RK3568_GRF_GMAC1_CON0 :
>> +				 RK3568_GRF_GMAC0_CON0;
>> +	con1 = (data->id == 1) ? RK3568_GRF_GMAC1_CON1 :
>> +				 RK3568_GRF_GMAC0_CON1;
>> +
>> +	regmap_write(data->grf, con0,
>> +		     RK3568_GMAC_CLK_RX_DL_CFG(rx_delay) |
>> +		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
>> +
>> +	regmap_write(data->grf, con1,
>> +		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
>> +		     RK3568_GMAC_RXCLK_DLY_ENABLE |
>> +		     RK3568_GMAC_TXCLK_DLY_ENABLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk3568_set_to_rmii(struct udevice *dev)
>> +{
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +	u32 con1;
>> +
>> +	con1 = (data->id == 1) ? RK3568_GRF_GMAC1_CON1 :
>> +				 RK3568_GRF_GMAC0_CON1;
>> +	regmap_write(data->grf, con1, RK3568_GMAC_PHY_INTF_SEL_RMII);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk3568_set_gmac_speed(struct udevice *dev)
>> +{
>> +	struct eqos_priv *eqos = dev_get_priv(dev);
>> +	ulong rate;
>> +	int ret;
>> +
>> +	switch (eqos->phy->speed) {
>> +	case SPEED_10:
>> +		rate = 2500000;
>> +		break;
>> +	case SPEED_100:
>> +		rate = 25000000;
>> +		break;
>> +	case SPEED_1000:
>> +		rate = 125000000;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = clk_set_rate(&eqos->clk_tx, rate);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct rk_gmac_ops rk_gmac_ops[] = {
>> +	{
>> +		.compatible = "rockchip,rk3568-gmac",
>> +		.set_to_rgmii = rk3568_set_to_rgmii,
>> +		.set_to_rmii = rk3568_set_to_rmii,
>> +		.set_gmac_speed = rk3568_set_gmac_speed,
>> +		.regs = {
>> +			0xfe2a0000, /* gmac0 */
>> +			0xfe010000, /* gmac1 */
>> +			0x0, /* sentinel */
>> +		},
>> +	},
>> +	{ }
>> +};
>> +
>> +static const struct rk_gmac_ops *get_rk_gmac_ops(struct udevice *dev)
>> +{
>> +	const struct rk_gmac_ops *ops = rk_gmac_ops;
>> +
>> +	while (ops->compatible) {
>> +		if (device_is_compatible(dev, ops->compatible))
>> +			return ops;
>> +		ops++;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int eqos_probe_resources_rk(struct udevice *dev)
>> +{
>> +	struct eqos_priv *eqos = dev_get_priv(dev);
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data;
>> +	int reset_flags = GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
>> +	int ret;
>> +
>> +	data = calloc(1, sizeof(struct rockchip_platform_data));
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->ops = get_rk_gmac_ops(dev);
>> +	if (!data->ops) {
>> +		ret = -EINVAL;
>> +		goto err_free;
>> +	}
>> +
>> +	for (int i = 0; data->ops->regs[i]; i++) {
>> +		if (data->ops->regs[i] == (u32)eqos->regs) {
>> +			data->id = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	pdata->priv_pdata = data;
>> +	pdata->phy_interface = eqos->config->interface(dev);
>> +	pdata->max_speed = eqos->max_speed;
>> +
>> +	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
>> +		pr_err("Invalid PHY interface\n");
>> +		ret = -EINVAL;
>> +		goto err_free;
>> +	}
>> +
>> +	data->grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,grf");
>> +	if (IS_ERR(data->grf)) {
>> +		dev_err(dev, "Missing rockchip,grf property\n");
>> +		ret = -EINVAL;
>> +		goto err_free;
>> +	}
>> +
>> +	ret = reset_get_bulk(dev, &data->resets);
>> +	if (ret < 0)
>> +		goto err_free;
>> +
>> +	reset_assert_bulk(&data->resets);
>> +
>> +	ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
>> +	if (ret) {
>> +		dev_dbg(dev, "clk_get_by_name(stmmaceth) failed: %d", ret);
>> +		goto err_release_resets;
>> +	}
>> +
>> +	ret = clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
>> +	if (ret) {
>> +		dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d", ret);
>> +		goto err_free_clk_master_bus;
>> +	}
>> +
>> +	if (dev_read_bool(dev, "snps,reset-active-low"))
>> +		reset_flags |= GPIOD_ACTIVE_LOW;
>> +
>> +	dev_read_u32_array(dev, "snps,reset-delays-us", eqos->reset_delays, 3);
>> +
>> +	gpio_request_by_name(dev, "snps,reset-gpio", 0,
>> +			     &eqos->phy_reset_gpio, reset_flags);
>> +
>> +	return 0;
>> +
>> +err_free_clk_master_bus:
>> +	clk_free(&eqos->clk_master_bus);
>> +err_release_resets:
>> +	reset_release_bulk(&data->resets);
>> +err_free:
>> +	free(data);
>> +
>> +	return ret;
>> +}
>> +
>> +static int eqos_remove_resources_rk(struct udevice *dev)
>> +{
>> +	struct eqos_priv *eqos = dev_get_priv(dev);
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +
>> +	if (dm_gpio_is_valid(&eqos->phy_reset_gpio))
>> +		dm_gpio_free(dev, &eqos->phy_reset_gpio);
>> +
>> +	clk_free(&eqos->clk_tx);
>> +	clk_free(&eqos->clk_master_bus);
>> +	reset_release_bulk(&data->resets);
>> +	free(data);
>> +
>> +	return 0;
>> +}
>> +
>> +static int eqos_stop_resets_rk(struct udevice *dev)
>> +{
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +
>> +	return reset_assert_bulk(&data->resets);
>> +}
>> +
>> +static int eqos_start_resets_rk(struct udevice *dev)
>> +{
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +
>> +	return reset_deassert_bulk(&data->resets);
>> +}
>> +
>> +static int eqos_stop_clks_rk(struct udevice *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int eqos_start_clks_rk(struct udevice *dev)
>> +{
>> +	struct eqos_priv *eqos = dev_get_priv(dev);
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +	int tx_delay, rx_delay, ret;
>> +
>> +	if (dm_gpio_is_valid(&eqos->phy_reset_gpio)) {
>> +		udelay(eqos->reset_delays[1]);
>> +
>> +		ret = dm_gpio_set_value(&eqos->phy_reset_gpio, 0);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		udelay(eqos->reset_delays[2]);
>> +	}
>> +
>> +	tx_delay = dev_read_u32_default(dev, "tx_delay", 0x30);
>> +	rx_delay = dev_read_u32_default(dev, "rx_delay", 0x10);
>> +
>> +	switch (pdata->phy_interface) {
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +		return data->ops->set_to_rgmii(dev, tx_delay, rx_delay);
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +		return data->ops->set_to_rgmii(dev, 0, 0);
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +		return data->ops->set_to_rgmii(dev, tx_delay, 0);
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		return data->ops->set_to_rgmii(dev, 0, rx_delay);
>> +	case PHY_INTERFACE_MODE_RMII:
>> +		return data->ops->set_to_rmii(dev);
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int eqos_set_tx_clk_speed_rk(struct udevice *dev)
>> +{
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct rockchip_platform_data *data = pdata->priv_pdata;
>> +
>> +	return data->ops->set_gmac_speed(dev);
>> +}
>> +
>> +static ulong eqos_get_tick_clk_rate_rk(struct udevice *dev)
>> +{
>> +	struct eqos_priv *eqos = dev_get_priv(dev);
>> +
>> +	return clk_get_rate(&eqos->clk_master_bus);
>> +}
>> +
>> +static struct eqos_ops eqos_rockchip_ops = {
>> +	.eqos_inval_desc = eqos_inval_desc_generic,
>> +	.eqos_flush_desc = eqos_flush_desc_generic,
>> +	.eqos_inval_buffer = eqos_inval_buffer_generic,
>> +	.eqos_flush_buffer = eqos_flush_buffer_generic,
>> +	.eqos_probe_resources = eqos_probe_resources_rk,
>> +	.eqos_remove_resources = eqos_remove_resources_rk,
>> +	.eqos_stop_resets = eqos_stop_resets_rk,
>> +	.eqos_start_resets = eqos_start_resets_rk,
>> +	.eqos_stop_clks = eqos_stop_clks_rk,
>> +	.eqos_start_clks = eqos_start_clks_rk,
>> +	.eqos_calibrate_pads = eqos_null_ops,
>> +	.eqos_disable_calibration = eqos_null_ops,
>> +	.eqos_set_tx_clk_speed = eqos_set_tx_clk_speed_rk,
>> +	.eqos_get_enetaddr = eqos_null_ops,
>> +	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_rk,
>> +};
>> +
>> +struct eqos_config eqos_rockchip_config = {
>> +	.reg_access_always_ok = false,
>> +	.mdio_wait = 10,
>> +	.swr_wait = 50,
>> +	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
>> +	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_100_150,
>> +	.axi_bus_width = EQOS_AXI_WIDTH_64,
>> +	.interface = dev_read_phy_mode,
>> +	.ops = &eqos_rockchip_ops,
>> +};

