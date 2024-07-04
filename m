Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A4DC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9402688581;
	Thu,  4 Jul 2024 16:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C1upybqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E8C8867A; Thu,  4 Jul 2024 16:07:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF41884C5
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B1BD62644;
 Thu,  4 Jul 2024 14:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E07C3277B;
 Thu,  4 Jul 2024 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720102025;
 bh=7WU+MEy2VF2nOWvHTzxVUFTVUkC6VqYUFbqaEz1xDtY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C1upybqZFYko/QW5DtvrHBDhCbNbkiw0d5n3tN04Kuvfqa60Q5oO6zVDA0LfUKq2s
 AJ2rBo7KHLrdk7GdbzWS8b8PZ42ysNxnHWGO7bg+SK/cFSx+g5IlqMvVwZVaD4Uqh2
 /ROqAMozhMyO2PC+gAGWL4pWrgtH6MXHNm6UJYvFDJ2XrBame52rj8Hx9I+VPc8V2E
 2/Hf9aHR0/KO+g/15J1dzVho87387EVN3vnJP7y4o6hfzYJ3d3Orw1YyyVaZ8YHNNN
 aJWDdL0OJDTgaeK0tTxhg3pkPwSNw+3Sjcg7LhNEhlpYssjbTNbBx4DMvgvNUpBMD8
 wpl/2QA/FS4hA==
Message-ID: <13288500-d4b2-4cc0-9b5a-7d6db9d0a81b@kernel.org>
Date: Thu, 4 Jul 2024 17:06:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY
 driver
To: Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <20240704055014.55117-4-minda.chen@starfivetech.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240704055014.55117-4-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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



On 04/07/2024 08:50, Minda Chen wrote:
> Add Starfive JH7110 PCIe 2.0 PHY driver, which is generic
> PHY driver and can be used as USB 3.0 driver.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/phy/starfive/Kconfig           |   7 +
>  drivers/phy/starfive/Makefile          |   1 +
>  drivers/phy/starfive/phy-jh7110-pcie.c | 202 +++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
> 
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> index 11a819f8b2..5d49684bc7 100644
> --- a/drivers/phy/starfive/Kconfig
> +++ b/drivers/phy/starfive/Kconfig
> @@ -4,6 +4,13 @@
>  
>  menu "Starfive PHY driver"
>  
> +config PHY_STARFIVE_JH7110_PCIE
> +        bool "Starfive JH7110 PCIe 2.0 PHY driver"
> +        select PHY
> +        help
> +          Enable this to support the Starfive JH7110 PCIE 2.0/USB 3.0 PHY.
> +	  Generic PHY driver JH7110 USB 3.0/ PCIe 2.0.

Should be aligned to previous line.

> +
>  config PHY_STARFIVE_JH7110_USB2
>  	bool "Starfive JH7110 USB 2.0 PHY driver"
>  	select PHY
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> index a405a75e34..82f25aa21b 100644
> --- a/drivers/phy/starfive/Makefile
> +++ b/drivers/phy/starfive/Makefile
> @@ -3,4 +3,5 @@
>  # Copyright (C) 2023 Starfive
>  #
>  
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
> diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
> new file mode 100644
> index 0000000000..57d5d8bf53
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-pcie.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * StarFive JH7110 PCIe 2.0 PHY driver
> + *
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + * Author: Minda Chen <minda.chen@starfivetech.com>
> + */
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <generic-phy.h>
> +#include <regmap.h>
> +#include <soc.h>
> +#include <syscon.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +
> +#define PCIE_KVCO_LEVEL_OFF		0x28
> +#define PCIE_USB3_PHY_PLL_CTL_OFF	0x7c
> +#define PCIE_USB3_PHY_SS_MODE		BIT(4)

extra tab?

> +#define PCIE_KVCO_TUNE_SIGNAL_OFF	0x80
> +#define PHY_KVCO_FINE_TUNE_LEVEL	0x91
> +#define PHY_KVCO_FINE_TUNE_SIGNALS	0xc
> +
> +#define USB_PDRSTN_SPLIT		BIT(17)
> +
> +#define PCIE_USB3_PHY_MODE		BIT(20)
> +#define PCIE_PHY_MODE_MASK		GENMASK(21, 20)
> +#define PCIE_USB3_BUS_WIDTH_MASK	GENMASK(3, 2)
> +#define PCIE_BUS_WIDTH			BIT(3)
> +#define PCIE_USB3_RATE_MASK		GENMASK(6, 5)
> +#define PCIE_USB3_RX_STANDBY_MASK	BIT(7)
> +#define PCIE_USB3_PHY_ENABLE		BIT(4)

Why not use define and use regmap_fields? You are already using regmap.

> +
> +struct jh7110_pcie_phy {
> +	struct phy *phy;
> +	struct regmap *stg_syscon;
> +	struct regmap *sys_syscon;
> +	void __iomem *regs;
> +	u32 sys_phy_connect;
> +	u32 stg_pcie_mode;
> +	u32 stg_pcie_usb;
> +	enum phy_mode mode;
> +};
> +
> +static int phy_pcie_mode_set(struct jh7110_pcie_phy *data, bool usb_mode)
> +{
> +	unsigned int phy_mode, width, usb3_phy, ss_mode;
> +
> +	/* default is PCIe mode */
> +	if (!data->stg_syscon || !data->sys_syscon) {
> +		if (usb_mode) {
> +			dev_err(data->phy->dev, "doesn't support usb3 mode\n");
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	if (usb_mode) {
> +		phy_mode = PCIE_USB3_PHY_MODE;
> +		width = 0;
> +		usb3_phy = PCIE_USB3_PHY_ENABLE;
> +		ss_mode = PCIE_USB3_PHY_SS_MODE;
> +	} else {
> +		phy_mode = 0;
> +		width = PCIE_BUS_WIDTH;
> +		usb3_phy = 0;
> +		ss_mode = 0;
> +	}
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
> +			   PCIE_PHY_MODE_MASK, phy_mode);
> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
> +			   PCIE_USB3_BUS_WIDTH_MASK, width);
> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
> +			   PCIE_USB3_PHY_ENABLE, usb3_phy);
> +	clrsetbits_le32(data->regs + PCIE_USB3_PHY_PLL_CTL_OFF,
> +			PCIE_USB3_PHY_SS_MODE, ss_mode);
> +
> +	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
> +			   USB_PDRSTN_SPLIT, 0);
> +
> +	return 0;
> +}
> +
> +static void phy_kvco_gain_set(struct jh7110_pcie_phy *phy)
> +{
> +	/* PCIe Multi-PHY PLL KVCO Gain fine tune settings: */
> +	writel(PHY_KVCO_FINE_TUNE_LEVEL, phy->regs + PCIE_KVCO_LEVEL_OFF);
> +	writel(PHY_KVCO_FINE_TUNE_SIGNALS, phy->regs + PCIE_KVCO_TUNE_SIGNAL_OFF);
> +}
> +
> +static int jh7110_pcie_phy_set_mode(struct phy *_phy,
> +				    enum phy_mode mode, int submode)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
> +	int ret;
> +
> +	if (mode == phy->mode)
> +		return 0;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_DEVICE:
> +	case PHY_MODE_USB_OTG:
> +		ret = phy_pcie_mode_set(phy, 1);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PHY_MODE_PCIE:
> +		phy_pcie_mode_set(phy, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(_phy->dev, "Changing phy mode to %d\n", mode);
> +	phy->mode = mode;
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops jh7110_pcie_phy_ops = {
> +	.set_mode	= jh7110_pcie_phy_set_mode,
> +};
> +
> +static int starfive_pcie_phy_get_syscon(struct udevice *dev)
> +{
> +	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
> +	struct ofnode_phandle_args sys_phandle, stg_phandle;
> +	int ret;
> +
> +	/* get corresponding syscon phandle */
> +	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 1, 0,
> +					 &sys_phandle);
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Can't get sys cfg phandle: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dev_read_phandle_with_args(dev, "starfive,stg-syscon", NULL, 2, 0,
> +					 &stg_phandle);
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Can't get stg cfg phandle: %d\n", ret);
> +		return ret;
> +	}
> +
> +	phy->sys_syscon = syscon_node_to_regmap(sys_phandle.node);
> +	if (!IS_ERR_OR_NULL(phy->sys_syscon)) {
> +		/* get syscon register offset */
> +		phy->sys_phy_connect = sys_phandle.args[0];
> +	} else {
> +		phy->sys_syscon = NULL;

Why not error out if you could not get the sys_syscon regmap?

> +	}
> +
> +	phy->stg_syscon = syscon_node_to_regmap(stg_phandle.node);
> +	if (!IS_ERR_OR_NULL(phy->stg_syscon)) {
> +		phy->stg_pcie_mode = stg_phandle.args[0];
> +		phy->stg_pcie_usb = stg_phandle.args[1];
> +	} else {
> +		phy->stg_syscon = NULL;

same here?

> +	}
> +
> +	return 0;
> +}
> +
> +int jh7110_pcie_phy_probe(struct udevice *dev)
> +{
> +	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
> +	int rc;
> +
> +	phy->regs = dev_read_addr_ptr(dev);
> +	if (!phy->regs)
> +		return -EINVAL;
> +
> +	rc = starfive_pcie_phy_get_syscon(dev);
> +	if (rc)
> +		return rc;
> +
> +	phy_kvco_gain_set(phy);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id jh7110_pcie_phy[] = {
> +	{ .compatible = "starfive,jh7110-pcie-phy"},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(jh7110_pcie_phy) = {
> +	.name = "jh7110_pcie_phy",
> +	.id = UCLASS_PHY,
> +	.of_match = jh7110_pcie_phy,
> +	.probe = jh7110_pcie_phy_probe,
> +	.ops = &jh7110_pcie_phy_ops,
> +	.priv_auto	= sizeof(struct jh7110_pcie_phy),

need space instead of tab?

> +};
> +

-- 
cheers,
-roger
