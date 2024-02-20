Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A90FC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FAD87FCC;
	Tue, 20 Feb 2024 16:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443166;
	bh=zRLIdEFmMIauOWBNRzcXRFaQF7pMeAhPvqM3YLZbWXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cBL7Q8e4xNw7e7ZQcsH19CaYzhZs64Llo3do5tzKTU76YrAD5q3kS1EP4frn+UORM
	 xxXxPXdGSThgZqNXFa742LdYyhuPUq4dqDJXCFS35y/gB6AAhxjV4y6+Nh4nOtK6V6
	 RoeM4uTQ5nOJ+DbZ0Ogvamy+3zpNcpDqtQDSk7wOsdSJRfN6ktYssIWZZKl6qTeYoB
	 uqyOMY9b71PubgUmPglMeqWaUSAi3Es8uvYfnR5ni3XO2Rx8q4T6FJLCQGYws0sNKp
	 SrmFUpBY3uWAMgfzbsF9996JDMJz3yRmFqpYaFhyoRX+xQxN3/h49tAhhar7l1OgGE
	 fKYTOfbQkcyww==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 26DD287FE3;
 Tue, 20 Feb 2024 16:32:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443163;
 bh=zRLIdEFmMIauOWBNRzcXRFaQF7pMeAhPvqM3YLZbWXg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pmR8YcH6nvWo55y1Og3iOP9CYwu4joxvAll1EBxAL6X7XA51CJ6tVqLLpvl9iaUM+
 SrXJxy6G3rBWBo3SGcBcjW4Csq7VxPeWSa8HGKp9yyAYeWG7E5u5ugxO5Aw4konDIk
 X3J+rVNiQlfx4zhT8mRIUVIx3OtGBKUjcZCVC+whYHYmGTRb6Do21Zw+BEEYANSGjy
 4LsRUdtXmY7SCy7GfCEKUX+C18S+uIQbBMpClR0gWufGpVSGMNac4uOZ1+FjV9bAGa
 i1FUQPkKUt0lzLHJMts0ueQpq+VDU4ZSspE5PJekgUAAD8qSrt8ioZ059uQufRDMYu
 IzM2FGIfMavmA==
Message-ID: <61361608-8b4f-4ebb-b7dd-260d08ac5e8b@denx.de>
Date: Tue, 20 Feb 2024 16:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] pci: Add DW PCIe controller support for iMX8MP SoC
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-7-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-7-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/20/24 14:10, Sumit Garg wrote:
> pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> tied to quite old port of pcie_designware driver from Linux which
> suffices only iMX6 specific needs.
> 
> But currently we have the common DWC specific bits which alligns pretty
> well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> add support for other iMX8 variants to this driver.
> 
> iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> can reuse the generic PHY infrastructure to power on PCIe PHY.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/pci/Kconfig        |   8 +
>   drivers/pci/Makefile       |   1 +
>   drivers/pci/pcie_dw_imx8.c | 348 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 357 insertions(+)
>   create mode 100644 drivers/pci/pcie_dw_imx8.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 463ec47eb92..b7c7922b091 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
>   	  Say Y here if you want to enable PLDA XpressRich PCIe controller
>   	  support on StarFive JH7110 SoC.
>   
> +config PCIE_DW_IMX8
> +	bool "i.MX8 PCIe support"
> +	depends on ARCH_IMX8M
> +	select PCIE_DW_COMMON
> +	help
> +	  Say Y here if you want to enable DW PCIe controller support on
> +	  iMX8 SoCs.
> +
>   endif
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 72ef8b4bc77..cddbb902095 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
>   obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
>   obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
>   obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
> +obj-$(CONFIG_PCIE_DW_IMX8) += pcie_dw_imx8.o
> diff --git a/drivers/pci/pcie_dw_imx8.c b/drivers/pci/pcie_dw_imx8.c
> new file mode 100644
> index 00000000000..b9921644765
> --- /dev/null
> +++ b/drivers/pci/pcie_dw_imx8.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Linaro Ltd.
> + *
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#include <asm/io.h>
> +#include <asm-generic/gpio.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <generic-phy.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <log.h>
> +#include <pci.h>
> +#include <regmap.h>
> +#include <reset.h>
> +#include <syscon.h>
> +#include <time.h>
> +
> +#include "pcie_dw_common.h"
> +
> +#define PCIE_LINK_CAPABILITY		0x7c
> +#define TARGET_LINK_SPEED_MASK		0xf
> +#define LINK_SPEED_GEN_1		0x1
> +#define LINK_SPEED_GEN_2		0x2
> +#define LINK_SPEED_GEN_3		0x3
> +
> +#define PCIE_MISC_CONTROL_1_OFF		0x8bc
> +#define PCIE_DBI_RO_WR_EN		BIT(0)
> +
> +#define PCIE_PORT_DEBUG0			0x728
> +#define PCIE_PORT_DEBUG1			0x72c
> +#define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
> +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
> +
> +#define PCIE_LINK_UP_TIMEOUT_MS		100
> +
> +#define IOMUXC_GPR14_OFFSET			0x38
> +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
> +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE		BIT(11)
> +
> +struct pcie_dw_imx8 {
> +	/* Must be first member of the struct */
> +	struct pcie_dw			dw;
> +	struct regmap			*iomuxc_gpr;
> +	struct clk			pcie;
> +	struct clk			pcie_bus;
> +	struct clk			pcie_aux;
> +	struct gpio_desc		reset_gpio;
> +	struct reset_ctl		apps_reset;
> +	struct phy			phy;
> +};
> +
> +static void pcie_dw_configure(struct pcie_dw_imx8 *priv, u32 cap_speed)
> +{
> +	u32 val;
> +
> +	dw_pcie_dbi_write_enable(&priv->dw, true);
> +
> +	val = readl(priv->dw.dbi_base + PCIE_LINK_CAPABILITY);
> +	val &= ~TARGET_LINK_SPEED_MASK;
> +	val |= cap_speed;
> +	writel(val, priv->dw.dbi_base + PCIE_LINK_CAPABILITY);

clrsetbits_le32()

> +
> +	dw_pcie_dbi_write_enable(&priv->dw, false);
> +}
> +
> +static void imx8_pcie_ltssm_enable(struct pcie_dw_imx8 *priv)
> +{
> +	reset_deassert(&priv->apps_reset);
> +}
> +
> +static void imx8_pcie_ltssm_disable(struct pcie_dw_imx8 *priv)
> +{
> +	reset_assert(&priv->apps_reset);
> +}
> +
> +static int is_link_up(struct pcie_dw_imx8 *priv)
> +{
> +	u32 val;
> +
> +	val = readl(priv->dw.dbi_base + PCIE_PORT_DEBUG1);
> +
> +	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
> +		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
> +}
> +
> +static int wait_link_up(struct pcie_dw_imx8 *priv)
> +{
> +	unsigned long timeout;
> +
> +	timeout = get_timer(0) + PCIE_LINK_UP_TIMEOUT_MS;

wait_for_bit() or read_poll_timeout()

> +	while (!is_link_up(priv)) {
> +		if (get_timer(0) > timeout)
> +			return 0;
> +		mdelay(10);
> +	};
> +
> +	return 1;

return -ETIMEDOUT ?

> +}
> +
> +static int pcie_link_up(struct pcie_dw_imx8 *priv, u32 cap_speed)
> +{
> +	if (is_link_up(priv)) {
> +		printf("PCI Link already up before configuration!\n");
> +		return 1;
> +	}
> +
> +	/* DW pre link configurations */
> +	pcie_dw_configure(priv, cap_speed);
> +
> +	/* Initiate link training */
> +	imx8_pcie_ltssm_enable(priv);
> +
> +	/* Check that link was established */
> +	if (!wait_link_up(priv)) {
> +		imx8_pcie_ltssm_disable(priv);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int imx8_pcie_assert_core_reset(struct pcie_dw_imx8 *priv)
> +{
> +	if (dm_gpio_is_valid(&priv->reset_gpio)) {
> +		dm_gpio_set_value(&priv->reset_gpio, 1);
> +		mdelay(20);
> +	}
> +
> +	return reset_assert(&priv->apps_reset);
> +}
> +
> +static int imx8_pcie_clk_enable(struct pcie_dw_imx8 *priv)
> +{
> +	int ret;
> +
> +	ret = clk_enable(&priv->pcie);

Can you use clk_bulk functions here ?

[...]

> +static int imx8_pcie_deassert_core_reset(struct pcie_dw_imx8 *priv)
> +{
> +	if (dm_gpio_is_valid(&priv->reset_gpio)) {

Invert the match here and return early to reduce indent.

> +		mdelay(100);
> +		dm_gpio_set_value(&priv->reset_gpio, 0);
> +		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +		mdelay(100);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pcie_dw_imx8_probe(struct udevice *dev)
> +{
> +	struct pcie_dw_imx8 *priv = dev_get_priv(dev);
> +	struct udevice *ctlr = pci_get_controller(dev);
> +	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
> +	int ret;
> +
> +	ret = imx8_pcie_assert_core_reset(priv);
> +	if (ret) {
> +		dev_err(dev, "failed to assert core reset\n");
> +		return ret;
> +	}
> +
> +	ret = imx8_pcie_clk_enable(priv);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks\n");

This needs a fail path, else reset remains released on failure here .

> +		return ret;
> +	}
> +
> +	generic_phy_init(&priv->phy);
> +	generic_phy_power_on(&priv->phy);
> +
> +	ret = imx8_pcie_deassert_core_reset(priv);
> +	if (ret) {
> +		dev_err(dev, "failed to assert core reset\n");
> +		return ret;
> +	}
> +
> +	priv->dw.first_busno = dev_seq(dev);
> +	priv->dw.dev = dev;
> +
> +	pcie_dw_setup_host(&priv->dw);
> +
> +	if (!pcie_link_up(priv, LINK_SPEED_GEN_1)) {
> +		printf("PCIE-%d: Link down\n", dev_seq(dev));
> +		return -ENODEV;
> +	}
> +
> +	printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
> +	       pcie_dw_get_link_speed(&priv->dw),
> +	       pcie_dw_get_link_width(&priv->dw),
> +	       hose->first_busno);
> +
> +	pcie_dw_prog_outbound_atu_unroll(&priv->dw, PCIE_ATU_REGION_INDEX0,
> +					 PCIE_ATU_TYPE_MEM,
> +					 priv->dw.mem.phys_start,
> +					 priv->dw.mem.bus_start, priv->dw.mem.size);
> +
> +	return 0;
> +}
> +
> +static int pcie_dw_imx8_remove(struct udevice *dev)
> +{
> +	struct pcie_dw_imx8 *priv = dev_get_priv(dev);
> +
> +	imx8_pcie_assert_core_reset(priv);
> +
> +	return 0;
> +}

[...]
