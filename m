Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B561C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2088333D;
	Tue,  8 Apr 2025 05:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Do6RepEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 017CF83349; Tue,  8 Apr 2025 05:23:22 +0200 (CEST)
Received: from mail-m19731108.qiye.163.com (mail-m19731108.qiye.163.com
 [220.197.31.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4072882CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208ade;
 Tue, 8 Apr 2025 11:23:15 +0800 (GMT+08:00)
Message-ID: <3bf6c6b5-6450-4a50-8c5a-938b786886d7@rock-chips.com>
Date: Tue, 8 Apr 2025 11:23:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] pinctrl: rockchip: Add support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-18-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-18-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01KS1ZMTE5NSEIeTkoeHUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136c6f8b03afkunm110208ade
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Lxw6EDJDLUI5AQ0rTjUo
 ER0KCyxVSlVKTE9PS0NJTkJNTUxCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0NNQzcG
DKIM-Signature: a=rsa-sha256;
 b=Do6RepEI/00Y57m3YY8pJx7sO9QKng9kskqD43YFQ9C4MKq2VAaRXG9MXo+8w3/9FgUU744xuBZqr9VrpY5m5yiA/EbkZ6bFH05Au8RaHLCHsE9T7/bywiKG4pLMbsdkwuCh7aXCQBgc7gnD6PGv7xlIzFSLI+2haAg/WGo4F7c=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=q2BkLr+2QvGMQYberw+I4GLZZW1r2DGlRENKzkCyHsg=;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> From: Steven Liu <steven.liu@rock-chips.com>
>
> Add pinctrl driver for RK3528.
>
> Imported from vendor U-Boot linux-6.1-stan-rkr5 tag with adjustments
> to use regmap_update_bits().
>
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Change to use if/else if instead of switch to match mainline Linux
> ---
>   drivers/pinctrl/rockchip/Makefile         |   1 +
>   drivers/pinctrl/rockchip/pinctrl-rk3528.c | 273 ++++++++++++++++++++++
>   2 files changed, 274 insertions(+)
>   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3528.c
>
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index c91f650b0434..df6c97d6234b 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += pinctrl-rk3308.o
>   obj-$(CONFIG_ROCKCHIP_RK3328) += pinctrl-rk3328.o
>   obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
>   obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
> +obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
>   obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
>   obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
>   obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3528.c b/drivers/pinctrl/rockchip/pinctrl-rk3528.c
> new file mode 100644
> index 000000000000..a3e1f0b2c9d5
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3528.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <dm.h>
> +#include <dm/pinctrl.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +
> +#include "pinctrl-rockchip.h"
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +static int rk3528_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int iomux_num = (pin / 8);
> +	struct regmap *regmap;
> +	int reg, mask;
> +	u8 bit;
> +	u32 data, rmask;
> +
> +	regmap = priv->regmap_base;
> +	reg = bank->iomux[iomux_num].offset;
> +	if ((pin % 8) >= 4)
> +		reg += 0x4;
> +	bit = (pin % 4) * 4;
> +	mask = 0xf;
> +
> +	data = (mask << (bit + 16));
> +	rmask = data | (data >> 16);
> +	data |= (mux & mask) << bit;
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3528_DRV_BITS_PER_PIN		8
> +#define RK3528_DRV_PINS_PER_REG		2
> +#define RK3528_DRV_GPIO0_OFFSET		0x100
> +#define RK3528_DRV_GPIO1_OFFSET		0x20120
> +#define RK3528_DRV_GPIO2_OFFSET		0x30160
> +#define RK3528_DRV_GPIO3_OFFSET		0x20190
> +#define RK3528_DRV_GPIO4_OFFSET		0x101C0
> +
> +static void rk3528_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +
> +	*regmap = priv->regmap_base;
> +
> +	if (bank->bank_num == 0) {
> +		*reg = RK3528_DRV_GPIO0_OFFSET;
> +	} else if (bank->bank_num == 1) {
> +		*reg = RK3528_DRV_GPIO1_OFFSET;
> +	} else if (bank->bank_num == 2) {
> +		*reg = RK3528_DRV_GPIO2_OFFSET;
> +	} else if (bank->bank_num == 3) {
> +		*reg = RK3528_DRV_GPIO3_OFFSET;
> +	} else if (bank->bank_num == 4) {
> +		*reg = RK3528_DRV_GPIO4_OFFSET;
> +	} else {
> +		*reg = 0;
> +		debug("unsupported bank_num %d\n", bank->bank_num);
> +	}
> +
> +	*reg += ((pin_num / RK3528_DRV_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3528_DRV_PINS_PER_REG;
> +	*bit *= RK3528_DRV_BITS_PER_PIN;
> +}
> +
> +static int rk3528_set_drive(struct rockchip_pin_bank *bank,
> +			    int pin_num, int strength)
> +{
> +	struct regmap *regmap;
> +	int reg;
> +	u32 data, rmask;
> +	u8 bit;
> +	int drv = (1 << (strength + 1)) - 1;
> +
> +	rk3528_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3528_DRV_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (drv << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3528_PULL_BITS_PER_PIN		2
> +#define RK3528_PULL_PINS_PER_REG		8
> +#define RK3528_PULL_GPIO0_OFFSET		0x200
> +#define RK3528_PULL_GPIO1_OFFSET		0x20210
> +#define RK3528_PULL_GPIO2_OFFSET		0x30220
> +#define RK3528_PULL_GPIO3_OFFSET		0x20230
> +#define RK3528_PULL_GPIO4_OFFSET		0x10240
> +
> +static void rk3528_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					 int pin_num, struct regmap **regmap,
> +					 int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +
> +	*regmap = priv->regmap_base;
> +
> +	if (bank->bank_num == 0) {
> +		*reg = RK3528_PULL_GPIO0_OFFSET;
> +	} else if (bank->bank_num == 1) {
> +		*reg = RK3528_PULL_GPIO1_OFFSET;
> +	} else if (bank->bank_num == 2) {
> +		*reg = RK3528_PULL_GPIO2_OFFSET;
> +	} else if (bank->bank_num == 3) {
> +		*reg = RK3528_PULL_GPIO3_OFFSET;
> +	} else if (bank->bank_num == 4) {
> +		*reg = RK3528_PULL_GPIO4_OFFSET;
> +	} else {
> +		*reg = 0;
> +		debug("unsupported bank_num %d\n", bank->bank_num);
> +	}
> +
> +	*reg += ((pin_num / RK3528_PULL_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3528_PULL_PINS_PER_REG;
> +	*bit *= RK3528_PULL_BITS_PER_PIN;
> +}
> +
> +static int rk3528_set_pull(struct rockchip_pin_bank *bank,
> +			   int pin_num, int pull)
> +{
> +	struct regmap *regmap;
> +	int reg, ret;
> +	u8 bit, type;
> +	u32 data, rmask;
> +
> +	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
> +		return -EOPNOTSUPP;
> +
> +	rk3528_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	type = bank->pull_type[pin_num / 8];
> +	ret = rockchip_translate_pull_value(type, pull);
> +	if (ret < 0) {
> +		debug("unsupported pull setting %d\n", pull);
> +		return ret;
> +	}
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3528_PULL_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (ret << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3528_SMT_BITS_PER_PIN		1
> +#define RK3528_SMT_PINS_PER_REG		8
> +#define RK3528_SMT_GPIO0_OFFSET		0x400
> +#define RK3528_SMT_GPIO1_OFFSET		0x20410
> +#define RK3528_SMT_GPIO2_OFFSET		0x30420
> +#define RK3528_SMT_GPIO3_OFFSET		0x20430
> +#define RK3528_SMT_GPIO4_OFFSET		0x10440
> +
> +static int rk3528_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
> +					   int pin_num,
> +					   struct regmap **regmap,
> +					   int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +
> +	*regmap = priv->regmap_base;
> +
> +	if (bank->bank_num == 0) {
> +		*reg = RK3528_SMT_GPIO0_OFFSET;
> +	} else if (bank->bank_num == 1) {
> +		*reg = RK3528_SMT_GPIO1_OFFSET;
> +	} else if (bank->bank_num == 2) {
> +		*reg = RK3528_SMT_GPIO2_OFFSET;
> +	} else if (bank->bank_num == 3) {
> +		*reg = RK3528_SMT_GPIO3_OFFSET;
> +	} else if (bank->bank_num == 4) {
> +		*reg = RK3528_SMT_GPIO4_OFFSET;
> +	} else {
> +		*reg = 0;
> +		debug("unsupported bank_num %d\n", bank->bank_num);
> +	}
> +
> +	*reg += ((pin_num / RK3528_SMT_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3528_SMT_PINS_PER_REG;
> +	*bit *= RK3528_SMT_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rk3528_set_schmitt(struct rockchip_pin_bank *bank,
> +			      int pin_num, int enable)
> +{
> +	struct regmap *regmap;
> +	int reg;
> +	u32 data, rmask;
> +	u8 bit;
> +
> +	rk3528_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3528_SMT_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (enable << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +static struct rockchip_pin_bank rk3528_pin_banks[] = {
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0, 0, 0, 0),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x20020, 0x20028, 0x20030, 0x20038),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x30040, 0, 0, 0),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(3, 32, "gpio3",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x20060, 0x20068, 0x20070, 0),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(4, 32, "gpio4",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x10080, 0x10088, 0x10090, 0x10098),
> +};
> +
> +static const struct rockchip_pin_ctrl rk3528_pin_ctrl = {
> +	.pin_banks		= rk3528_pin_banks,
> +	.nr_banks		= ARRAY_SIZE(rk3528_pin_banks),
> +	.grf_mux_offset		= 0x0,
> +	.set_mux		= rk3528_set_mux,
> +	.set_pull		= rk3528_set_pull,
> +	.set_drive		= rk3528_set_drive,
> +	.set_schmitt		= rk3528_set_schmitt,
> +};
> +
> +static const struct udevice_id rk3528_pinctrl_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3528-pinctrl",
> +		.data = (ulong)&rk3528_pin_ctrl
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3528_pinctrl) = {
> +	.name		= "rockchip_rk3528_pinctrl",
> +	.id		= UCLASS_PINCTRL,
> +	.of_match	= rk3528_pinctrl_ids,
> +	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
> +	.ops		= &rockchip_pinctrl_ops,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind		= dm_scan_fdt_dev,
> +#endif
> +	.probe		= rockchip_pinctrl_probe,
> +};
