Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FD6C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C5083371;
	Thu, 17 Jul 2025 08:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jm0ZzmWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B2483381; Thu, 17 Jul 2025 08:58:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D258334A
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 604F85C0662;
 Thu, 17 Jul 2025 06:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F9CC4CEE3;
 Thu, 17 Jul 2025 06:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752735523;
 bh=mh1uBAVa0mhvq1fzrmKaf3mt65BIQbYkU/9X5EB8vlk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jm0ZzmWJUuHR7HtdTzFNlVUrS1T6k/kmtJ03XYeeTjGJJtTg73a+GEFNVtadYZOCx
 +LjhGla/BwM+EBNOPZwS1jfEZIzvrP8OGgt+IGpOIFZDi6DEfQ1Lry6qWYaFVRoc4h
 Z3gCfGGg7EvY8QI0krnT3VtoU8oJonjTvxdc/XNrCdO6P3zMIdMHPZPhivpZExvgqV
 BafKD1pfMT05xlnEHMsIVsSQi6MAh3YioxZyWPBSXaEymALYaExNmcTPLNdnHAQ9uC
 uumbSMpzjSdZMbCfn1v0ilsvfWUDRP8YuJzvewxYzTG0IawzHvxG/uND9hRQrUw6Z7
 1pWMsBdUc1uIA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Minkyu Kang
 <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>, Oliver
 Gaskell <Oliver.Gaskell@analog.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Greg Malysa <malysagreg@gmail.com>, Nathan
 Barrett-Morrison <nathan.morrison@timesys.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Roger Quadros <rogerq@kernel.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
In-Reply-To: <20250709222926.24671-2-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
Date: Thu, 17 Jul 2025 08:58:40 +0200
Message-ID: <87tt3b2ti7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sam,

Thank you for the patch.

On Wed, Jul 09, 2025 at 17:29, Sam Protsenko <semen.protsenko@linaro.org> wrote:

> Add DM driver for Exynos USB PHY controllers. For now it only supports
> Exynos850 SoC. Only UTMI+ (USB 2.0) PHY interface is implemented, as
> Exynos850 doesn't support USB 3.0. Only two clocks are used for this
> controller:
>   - phy: bus clock, used for PHY registers access
>   - ref: PHY reference clock (OSCCLK)
>
> Ported from Linux kernel: drivers/phy/samsung/phy-exynos5-usbdrd.c
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/phy/Kconfig             |   9 +
>  drivers/phy/Makefile            |   1 +
>  drivers/phy/phy-exynos-usbdrd.c | 386 ++++++++++++++++++++++++++++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 drivers/phy/phy-exynos-usbdrd.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5264c8f5df6..fda0811d1500 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -602,6 +602,7 @@ ARM SAMSUNG EXYNOS850 SOC
>  M:	Sam Protsenko <semen.protsenko@linaro.org>
>  S:	Maintained
>  F:	drivers/clk/exynos/clk-exynos850.c
> +F:	drivers/phy/phy-exynos-usbdrd.c
>  F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
>  
>  ARM SAMSUNG SOC DRIVERS
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index d3fe90d939e8..c297fa03ea7f 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -259,6 +259,15 @@ config MT76X8_USB_PHY
>  
>  	  This PHY is found on MT76x8 devices supporting USB.
>  
> +config PHY_EXYNOS_USBDRD
> +	bool "Exynos SoC series USB DRD PHY driver"
> +	depends on PHY && CLK
> +	depends on ARCH_EXYNOS
> +	select REGMAP
> +	select SYSCON
> +	help
> +	  Enable USB DRD PHY support for Exynos SoC series.
> +
>  config PHY_MTK_TPHY
>  	bool "MediaTek T-PHY Driver"
>  	depends on PHY
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index b4d01fc700da..98c1ef8683b7 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_KEYSTONE_USB_PHY) += keystone-usb-phy.o
>  obj-$(CONFIG_MT7620_USB_PHY) += mt7620-usb-phy.o
>  obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
>  obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
> +obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
>  obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
>  obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
>  obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
> diff --git a/drivers/phy/phy-exynos-usbdrd.c b/drivers/phy/phy-exynos-usbdrd.c
> new file mode 100644
> index 000000000000..db5815ed1840
> --- /dev/null
> +++ b/drivers/phy/phy-exynos-usbdrd.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Linaro Ltd.
> + * Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Samsung Exynos SoC series USB DRD PHY driver.
> + * Based on Linux kernel PHY driver: drivers/phy/samsung/phy-exynos5-usbdrd.c
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <generic-phy.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +
> +/* Offset of PMU register controlling USB PHY output isolation */
> +#define EXYNOS_USBDRD_PHY_CONTROL		0x0704
> +#define EXYNOS_PHY_ENABLE			BIT(0)
> +
> +/* Exynos USB PHY registers */
> +#define EXYNOS5_FSEL_9MHZ6			0x0
> +#define EXYNOS5_FSEL_10MHZ			0x1
> +#define EXYNOS5_FSEL_12MHZ			0x2
> +#define EXYNOS5_FSEL_19MHZ2			0x3
> +#define EXYNOS5_FSEL_20MHZ			0x4
> +#define EXYNOS5_FSEL_24MHZ			0x5
> +#define EXYNOS5_FSEL_26MHZ			0x6
> +#define EXYNOS5_FSEL_50MHZ			0x7
> +
> +/* Exynos850: USB DRD PHY registers */
> +#define EXYNOS850_DRD_LINKCTRL			0x04
> +#define LINKCTRL_FORCE_QACT			BIT(8)
> +#define LINKCTRL_BUS_FILTER_BYPASS		GENMASK(7, 4)
> +
> +#define EXYNOS850_DRD_CLKRST			0x20
> +#define CLKRST_LINK_SW_RST			BIT(0)
> +#define CLKRST_PORT_RST				BIT(1)
> +#define CLKRST_PHY_SW_RST			BIT(3)
> +
> +#define EXYNOS850_DRD_SSPPLLCTL			0x30
> +#define SSPPLLCTL_FSEL				GENMASK(2, 0)
> +
> +#define EXYNOS850_DRD_UTMI			0x50
> +#define UTMI_FORCE_SLEEP			BIT(0)
> +#define UTMI_FORCE_SUSPEND			BIT(1)
> +#define UTMI_DM_PULLDOWN			BIT(2)
> +#define UTMI_DP_PULLDOWN			BIT(3)
> +#define UTMI_FORCE_BVALID			BIT(4)
> +#define UTMI_FORCE_VBUSVALID			BIT(5)

Comparing with the linux driver using
commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm controller")

I notice that the defines are in reverse order (from 0 to 5 and linux
has from 5 to 0).

Is there any particular reason for this?
I don't mind it too much but it makes diffing between linux and U-Boot a
bit harder.

Anyway, I've compared this with the linux driver and it looks good to
me!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> +
> +#define EXYNOS850_DRD_HSP			0x54
> +#define HSP_COMMONONN				BIT(8)
> +#define HSP_EN_UTMISUSPEND			BIT(9)
> +#define HSP_VBUSVLDEXT				BIT(12)
> +#define HSP_VBUSVLDEXTSEL			BIT(13)
> +#define HSP_FSV_OUT_EN				BIT(24)
> +
> +#define EXYNOS850_DRD_HSP_TEST			0x5c
> +#define HSP_TEST_SIDDQ				BIT(24)
> +
> +#define KHZ					1000
> +#define MHZ					(KHZ * KHZ)
> +
> +/**
> + * struct exynos_usbdrd_phy - driver data for Exynos USB PHY
> + * @reg_phy: USB PHY controller register memory base
> + * @clk: clock for register access
> + * @core_clk: core clock for phy (ref clock)
> + * @reg_pmu: regmap for PMU block
> + * @extrefclk: frequency select settings when using 'separate reference clocks'
> + */
> +struct exynos_usbdrd_phy {
> +	void __iomem *reg_phy;
> +	struct clk *clk;
> +	struct clk *core_clk;
> +	struct regmap *reg_pmu;
> +	u32 extrefclk;
> +};
> +
> +static void exynos_usbdrd_phy_isol(struct regmap *reg_pmu, bool isolate)
> +{
> +	unsigned int val;
> +
> +	if (!reg_pmu)
> +		return;
> +
> +	val = isolate ? 0 : EXYNOS_PHY_ENABLE;
> +	regmap_update_bits(reg_pmu, EXYNOS_USBDRD_PHY_CONTROL,
> +			   EXYNOS_PHY_ENABLE, val);
> +}
> +
> +/*
> + * Convert the supplied clock rate to the value that can be written to the PHY
> + * register.
> + */
> +static unsigned int exynos_rate_to_clk(unsigned long rate, u32 *reg)
> +{
> +	switch (rate) {
> +	case 9600 * KHZ:
> +		*reg = EXYNOS5_FSEL_9MHZ6;
> +		break;
> +	case 10 * MHZ:
> +		*reg = EXYNOS5_FSEL_10MHZ;
> +		break;
> +	case 12 * MHZ:
> +		*reg = EXYNOS5_FSEL_12MHZ;
> +		break;
> +	case 19200 * KHZ:
> +		*reg = EXYNOS5_FSEL_19MHZ2;
> +		break;
> +	case 20 * MHZ:
> +		*reg = EXYNOS5_FSEL_20MHZ;
> +		break;
> +	case 24 * MHZ:
> +		*reg = EXYNOS5_FSEL_24MHZ;
> +		break;
> +	case 26 * MHZ:
> +		*reg = EXYNOS5_FSEL_26MHZ;
> +		break;
> +	case 50 * MHZ:
> +		*reg = EXYNOS5_FSEL_50MHZ;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void exynos850_usbdrd_utmi_init(struct phy *phy)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
> +	void __iomem *regs_base = phy_drd->reg_phy;
> +	u32 reg;
> +
> +	/*
> +	 * Disable HWACG (hardware auto clock gating control). This will force
> +	 * QACTIVE signal in Q-Channel interface to HIGH level, to make sure
> +	 * the PHY clock is not gated by the hardware.
> +	 */
> +	reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
> +	reg |= LINKCTRL_FORCE_QACT;
> +	writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
> +
> +	/* Start PHY Reset (POR=high) */
> +	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
> +	reg |= CLKRST_PHY_SW_RST;
> +	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
> +
> +	/* Enable UTMI+ */
> +	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
> +	reg &= ~(UTMI_FORCE_SUSPEND | UTMI_FORCE_SLEEP | UTMI_DP_PULLDOWN |
> +		 UTMI_DM_PULLDOWN);
> +	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
> +
> +	/* Set PHY clock and control HS PHY */
> +	reg = readl(regs_base + EXYNOS850_DRD_HSP);
> +	reg |= HSP_EN_UTMISUSPEND | HSP_COMMONONN;
> +	writel(reg, regs_base + EXYNOS850_DRD_HSP);
> +
> +	/* Set VBUS Valid and D+ pull-up control by VBUS pad usage */
> +	reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
> +	reg |= FIELD_PREP(LINKCTRL_BUS_FILTER_BYPASS, 0xf);
> +	writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
> +
> +	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
> +	reg |= UTMI_FORCE_BVALID | UTMI_FORCE_VBUSVALID;
> +	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
> +
> +	reg = readl(regs_base + EXYNOS850_DRD_HSP);
> +	reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
> +	writel(reg, regs_base + EXYNOS850_DRD_HSP);
> +
> +	reg = readl(regs_base + EXYNOS850_DRD_SSPPLLCTL);
> +	reg &= ~SSPPLLCTL_FSEL;
> +	switch (phy_drd->extrefclk) {
> +	case EXYNOS5_FSEL_50MHZ:
> +		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 7);
> +		break;
> +	case EXYNOS5_FSEL_26MHZ:
> +		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 6);
> +		break;
> +	case EXYNOS5_FSEL_24MHZ:
> +		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 2);
> +		break;
> +	case EXYNOS5_FSEL_20MHZ:
> +		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 1);
> +		break;
> +	case EXYNOS5_FSEL_19MHZ2:
> +		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 0);
> +		break;
> +	default:
> +		dev_warn(phy->dev, "unsupported ref clk: %#.2x\n",
> +			 phy_drd->extrefclk);
> +		break;
> +	}
> +	writel(reg, regs_base + EXYNOS850_DRD_SSPPLLCTL);
> +
> +	/* Power up PHY analog blocks */
> +	reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
> +	reg &= ~HSP_TEST_SIDDQ;
> +	writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
> +
> +	/* Finish PHY reset (POR=low) */
> +	udelay(10); /* required before doing POR=low */
> +	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
> +	reg &= ~(CLKRST_PHY_SW_RST | CLKRST_PORT_RST);
> +	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
> +	udelay(75); /* required after POR=low for guaranteed PHY clock */
> +
> +	/* Disable single ended signal out */
> +	reg = readl(regs_base + EXYNOS850_DRD_HSP);
> +	reg &= ~HSP_FSV_OUT_EN;
> +	writel(reg, regs_base + EXYNOS850_DRD_HSP);
> +}
> +
> +static void exynos850_usbdrd_utmi_exit(struct phy *phy)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
> +	void __iomem *regs_base = phy_drd->reg_phy;
> +	u32 reg;
> +
> +	/* Set PHY clock and control HS PHY */
> +	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
> +	reg &= ~(UTMI_DP_PULLDOWN | UTMI_DM_PULLDOWN);
> +	reg |= UTMI_FORCE_SUSPEND | UTMI_FORCE_SLEEP;
> +	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
> +
> +	/* Power down PHY analog blocks */
> +	reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
> +	reg |= HSP_TEST_SIDDQ;
> +	writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
> +
> +	/* Link reset */
> +	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
> +	reg |= CLKRST_LINK_SW_RST;
> +	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
> +	udelay(10); /* required before doing POR=low */
> +	reg &= ~CLKRST_LINK_SW_RST;
> +	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
> +}
> +
> +static int exynos_usbdrd_phy_init(struct phy *phy)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(phy_drd->clk);
> +	if (ret)
> +		return ret;
> +
> +	exynos850_usbdrd_utmi_init(phy);
> +
> +	clk_disable_unprepare(phy_drd->clk);
> +
> +	return 0;
> +}
> +
> +static int exynos_usbdrd_phy_exit(struct phy *phy)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(phy_drd->clk);
> +	if (ret)
> +		return ret;
> +
> +	exynos850_usbdrd_utmi_exit(phy);
> +
> +	clk_disable_unprepare(phy_drd->clk);
> +
> +	return 0;
> +}
> +
> +static int exynos_usbdrd_phy_power_on(struct phy *phy)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	dev_dbg(phy->dev, "Request to power_on usbdrd_phy phy\n");
> +
> +	ret = clk_prepare_enable(phy_drd->core_clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Power-on PHY */
> +	exynos_usbdrd_phy_isol(phy_drd->reg_pmu, false);
> +
> +	return 0;
> +}
> +
> +static int exynos_usbdrd_phy_power_off(struct phy *phy)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(phy->dev);
> +
> +	dev_dbg(phy->dev, "Request to power_off usbdrd_phy phy\n");
> +
> +	/* Power-off the PHY */
> +	exynos_usbdrd_phy_isol(phy_drd->reg_pmu, true);
> +
> +	clk_disable_unprepare(phy_drd->core_clk);
> +
> +	return 0;
> +}
> +
> +static int exynos_usbdrd_phy_init_clk(struct udevice *dev)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(dev);
> +	unsigned long ref_rate;
> +	int err;
> +
> +	phy_drd->clk = devm_clk_get(dev, "phy");
> +	if (IS_ERR(phy_drd->clk)) {
> +		err = PTR_ERR(phy_drd->clk);
> +		dev_err(dev, "Failed to get phy clock (err=%d)\n", err);
> +		return err;
> +	}
> +
> +	phy_drd->core_clk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(phy_drd->core_clk)) {
> +		err = PTR_ERR(phy_drd->core_clk);
> +		dev_err(dev, "Failed to get ref clock (err=%d)\n", err);
> +		return err;
> +	}
> +
> +	ref_rate = clk_get_rate(phy_drd->core_clk);
> +	err = exynos_rate_to_clk(ref_rate, &phy_drd->extrefclk);
> +	if (err) {
> +		dev_err(dev, "Clock rate %lu not supported\n", ref_rate);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int exynos_usbdrd_phy_probe(struct udevice *dev)
> +{
> +	struct exynos_usbdrd_phy *phy_drd = dev_get_priv(dev);
> +	int err;
> +
> +	phy_drd->reg_phy = dev_read_addr_ptr(dev);
> +	if (!phy_drd->reg_phy)
> +		return -EINVAL;
> +
> +	err = exynos_usbdrd_phy_init_clk(dev);
> +	if (err)
> +		return err;
> +
> +	phy_drd->reg_pmu = syscon_regmap_lookup_by_phandle(dev,
> +							  "samsung,pmu-syscon");
> +	if (IS_ERR(phy_drd->reg_pmu)) {
> +		err = PTR_ERR(phy_drd->reg_pmu);
> +		dev_err(dev, "Failed to lookup PMU regmap\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops exynos_usbdrd_phy_ops = {
> +	.init		= exynos_usbdrd_phy_init,
> +	.exit		= exynos_usbdrd_phy_exit,
> +	.power_on	= exynos_usbdrd_phy_power_on,
> +	.power_off	= exynos_usbdrd_phy_power_off,
> +};
> +
> +static const struct udevice_id exynos_usbdrd_phy_of_match[] = {
> +	{
> +		.compatible = "samsung,exynos850-usbdrd-phy",
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(exynos_usbdrd_phy) = {
> +	.name		= "exynos-usbdrd-phy",
> +	.id		= UCLASS_PHY,
> +	.of_match	= exynos_usbdrd_phy_of_match,
> +	.probe		= exynos_usbdrd_phy_probe,
> +	.ops		= &exynos_usbdrd_phy_ops,
> +	.priv_auto	= sizeof(struct exynos_usbdrd_phy),
> +};
> -- 
> 2.39.5
