Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A5EF417E7
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868D583FAF;
	Mon,  9 Mar 2026 15:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="isD0cQDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756DE83FC0; Mon,  9 Mar 2026 15:39:23 +0100 (CET)
Received: from mail-m19731112.qiye.163.com (mail-m19731112.qiye.163.com
 [220.197.31.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA0083FC6
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e826b;
 Mon, 9 Mar 2026 22:39:14 +0800 (GMT+08:00)
Message-ID: <032ed1e3-d5d6-4f1f-b3e5-d90f2be4489c@rock-chips.com>
Date: Mon, 9 Mar 2026 22:39:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] pinctrl: rockchip: Add support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Ye Zhang <ye.zhang@rock-chips.com>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd309b30803afkunma7d39f9116bc572
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkpJVhpDTUtISx9OGRpIQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=isD0cQDYV/TQ56Cbh1T2KjMsTpoL1IHrcfXG3Bn7gny3y6gi8hdXN7aQ5yOPT14DCNlFtFUyuOU5lNC4dtJuV4SxX24LAo/QGgINYDVIApnkEPiDi1vc43wFxlbKSg6WB2gqfu3KziCHBF1SgUCn0NQtVseFcgJF9SL18JwzhJk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=k2r5wR1/tu4+UXZ2zDVZW/CC2ZJ7/TbgJ6F0vQZHN+M=;
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
> From: Ye Zhang <ye.zhang@rock-chips.com>
>
> Add pinctrl driver for RK3506.
>
> Imported from vendor U-Boot linux-6.1-stan-rkr6 tag with adjustments
> to use regmap_update_bits().
>
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect t-b tag
> ---
>   drivers/pinctrl/rockchip/Makefile             |   1 +
>   drivers/pinctrl/rockchip/pinctrl-rk3506.c     | 462 ++++++++++++++++++
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  |   9 +
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h   |   1 +
>   4 files changed, 473 insertions(+)
>   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3506.c
>
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index e17415e1ca68..0405df128dfa 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += pinctrl-rk3308.o
>   obj-$(CONFIG_ROCKCHIP_RK3328) += pinctrl-rk3328.o
>   obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
>   obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
> +obj-$(CONFIG_ROCKCHIP_RK3506) += pinctrl-rk3506.o
>   obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
>   obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
>   obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3506.c b/drivers/pinctrl/rockchip/pinctrl-rk3506.c
> new file mode 100644
> index 000000000000..969acb66f157
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3506.c
> @@ -0,0 +1,462 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
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
> +static int rk3506_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int iomux_num = (pin / 8);
> +	struct regmap *regmap;
> +	int reg, mask;
> +	u8 bit;
> +	u32 data, rmask;
> +
> +	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
> +		regmap = priv->regmap_pmu;
> +	else
> +		regmap = priv->regmap_base;
> +
> +	if (bank->bank_num == 1)
> +		regmap = priv->regmap_ioc1;
> +	else if (bank->bank_num == 4)
> +		return 0;
> +
> +	reg = bank->iomux[iomux_num].offset;
> +	if ((pin % 8) >= 4)
> +		reg += 0x4;
> +	bit = (pin % 4) * 4;
> +	mask = 0xf;
> +
> +	if (bank->recalced_mask & BIT(pin))
> +		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
> +
> +	data = (mask << (bit + 16));
> +	rmask = data | (data >> 16);
> +	data |= (mux & mask) << bit;
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3506_DRV_BITS_PER_PIN		8
> +#define RK3506_DRV_PINS_PER_REG		2
> +#define RK3506_DRV_GPIO0_A_OFFSET	0x100
> +#define RK3506_DRV_GPIO0_D_OFFSET	0x830
> +#define RK3506_DRV_GPIO1_OFFSET		0x140
> +#define RK3506_DRV_GPIO2_OFFSET		0x180
> +#define RK3506_DRV_GPIO3_OFFSET		0x1c0
> +#define RK3506_DRV_GPIO4_OFFSET		0x840
> +
> +static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int ret = 0;
> +
> +	switch (bank->bank_num) {
> +	case 0:
> +		*regmap = priv->regmap_pmu;
> +		if (pin_num > 24) {
> +			ret = -EINVAL;
> +		} else if (pin_num < 24) {
> +			*reg = RK3506_DRV_GPIO0_A_OFFSET;
> +		} else {
> +			*reg = RK3506_DRV_GPIO0_D_OFFSET;
> +			*bit = 3;
> +
> +			return 0;
> +		}
> +		break;
> +
> +	case 1:
> +		*regmap = priv->regmap_ioc1;
> +		if (pin_num < 28)
> +			*reg = RK3506_DRV_GPIO1_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 2:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 17)
> +			*reg = RK3506_DRV_GPIO2_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 3:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 15)
> +			*reg = RK3506_DRV_GPIO3_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 4:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 8 || pin_num > 11) {
> +			ret = -EINVAL;
> +		} else {
> +			*reg = RK3506_DRV_GPIO4_OFFSET;
> +			*bit = 10;
> +
> +			return 0;
> +		}
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret) {
> +		debug("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
> +		return ret;
> +	}
> +
> +	*reg += ((pin_num / RK3506_DRV_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3506_DRV_PINS_PER_REG;
> +	*bit *= RK3506_DRV_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rk3506_set_drive(struct rockchip_pin_bank *bank,
> +			    int pin_num, int strength)
> +{
> +	struct regmap *regmap;
> +	int reg, ret, i;
> +	u32 data, rmask;
> +	u8 bit;
> +	int rmask_bits = RK3506_DRV_BITS_PER_PIN;
> +
> +	ret = rk3506_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0, ret = 1; i < strength; i++)
> +		ret = (ret << 1) | 1;
> +
> +	if ((bank->bank_num == 0 && pin_num == 24) || bank->bank_num == 4) {
> +		rmask_bits = 2;
> +		ret = strength;
> +	}
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << rmask_bits) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (ret << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3506_PULL_BITS_PER_PIN	2
> +#define RK3506_PULL_PINS_PER_REG	8
> +#define RK3506_PULL_GPIO0_A_OFFSET	0x200
> +#define RK3506_PULL_GPIO0_D_OFFSET	0x830
> +#define RK3506_PULL_GPIO1_OFFSET	0x210
> +#define RK3506_PULL_GPIO2_OFFSET	0x220
> +#define RK3506_PULL_GPIO3_OFFSET	0x230
> +#define RK3506_PULL_GPIO4_OFFSET	0x840
> +
> +static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int ret = 0;
> +
> +	switch (bank->bank_num) {
> +	case 0:
> +		*regmap = priv->regmap_pmu;
> +		if (pin_num > 24) {
> +			ret = -EINVAL;
> +		} else if (pin_num < 24) {
> +			*reg = RK3506_PULL_GPIO0_A_OFFSET;
> +		} else {
> +			*reg = RK3506_PULL_GPIO0_D_OFFSET;
> +			*bit = 5;
> +
> +			return 0;
> +		}
> +		break;
> +
> +	case 1:
> +		*regmap = priv->regmap_ioc1;
> +		if (pin_num < 28)
> +			*reg = RK3506_PULL_GPIO1_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 2:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 17)
> +			*reg = RK3506_PULL_GPIO2_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 3:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 15)
> +			*reg = RK3506_PULL_GPIO3_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 4:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 8 || pin_num > 11) {
> +			ret = -EINVAL;
> +		} else {
> +			*reg = RK3506_PULL_GPIO4_OFFSET;
> +			*bit = 13;
> +
> +			return 0;
> +		}
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret) {
> +		debug("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
> +		return ret;
> +	}
> +
> +	*reg += ((pin_num / RK3506_PULL_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3506_PULL_PINS_PER_REG;
> +	*bit *= RK3506_PULL_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rk3506_set_pull(struct rockchip_pin_bank *bank,
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
> +	ret = rk3506_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
> +	type = bank->pull_type[pin_num / 8];
> +
> +	if ((bank->bank_num == 0 && pin_num == 24) || bank->bank_num == 4)
> +		type = 1;
> +
> +	ret = rockchip_translate_pull_value(type, pull);
> +	if (ret < 0) {
> +		debug("unsupported pull setting %d\n", pull);
> +		return ret;
> +	}
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3506_PULL_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (ret << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3506_SMT_BITS_PER_PIN		1
> +#define RK3506_SMT_PINS_PER_REG		8
> +#define RK3506_SMT_GPIO0_A_OFFSET	0x400
> +#define RK3506_SMT_GPIO0_D_OFFSET	0x830
> +#define RK3506_SMT_GPIO1_OFFSET		0x410
> +#define RK3506_SMT_GPIO2_OFFSET		0x420
> +#define RK3506_SMT_GPIO3_OFFSET		0x430
> +#define RK3506_SMT_GPIO4_OFFSET		0x840
> +
> +static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
> +					   int pin_num,
> +					   struct regmap **regmap,
> +					   int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int ret = 0;
> +
> +	switch (bank->bank_num) {
> +	case 0:
> +		*regmap = priv->regmap_pmu;
> +		if (pin_num > 24) {
> +			ret = -EINVAL;
> +		} else if (pin_num < 24) {
> +			*reg = RK3506_SMT_GPIO0_A_OFFSET;
> +		} else {
> +			*reg = RK3506_SMT_GPIO0_D_OFFSET;
> +			*bit = 9;
> +
> +			return 0;
> +		}
> +		break;
> +
> +	case 1:
> +		*regmap = priv->regmap_ioc1;
> +		if (pin_num < 28)
> +			*reg = RK3506_SMT_GPIO1_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 2:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 17)
> +			*reg = RK3506_SMT_GPIO2_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 3:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 15)
> +			*reg = RK3506_SMT_GPIO3_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 4:
> +		*regmap = priv->regmap_base;
> +		if (pin_num < 8 || pin_num > 11) {
> +			ret = -EINVAL;
> +		} else {
> +			*reg = RK3506_SMT_GPIO4_OFFSET;
> +			*bit = 8;
> +
> +			return 0;
> +		}
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret) {
> +		debug("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
> +		return ret;
> +	}
> +
> +	*reg += ((pin_num / RK3506_SMT_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3506_SMT_PINS_PER_REG;
> +	*bit *= RK3506_SMT_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rk3506_set_schmitt(struct rockchip_pin_bank *bank,
> +			      int pin_num, int enable)
> +{
> +	struct regmap *regmap;
> +	int reg, ret;
> +	u32 data, rmask;
> +	u8 bit;
> +
> +	ret = rk3506_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3506_SMT_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (enable << bit);
> +
> +	if ((bank->bank_num == 0 && pin_num == 24) || bank->bank_num == 4) {
> +		data = 0x3 << (bit + 16);
> +		rmask = data | (data >> 16);
> +		data |= ((enable ? 0x3 : 0) << bit);
> +	}
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +static struct rockchip_mux_recalced_data rk3506_mux_recalced_data[] = {
> +	{
> +		.num = 0,
> +		.pin = 24,
> +		.reg = 0x830,
> +		.bit = 0,
> +		.mask = 0x3
> +	},
> +};
> +
> +static struct rockchip_pin_bank rk3506_pin_banks[] = {
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
> +				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
> +				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
> +				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
> +				    IOMUX_8WIDTH_2BIT | IOMUX_SOURCE_PMU,
> +				    0x0, 0x8, 0x10, 0x830),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x20, 0x28, 0x30, 0x38),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x40, 0x48, 0x50, 0x58),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(3, 32, "gpio3",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x60, 0x68, 0x70, 0x78),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(4, 32, "gpio4",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x80, 0x88, 0x90, 0x98),
> +};
> +
> +static const struct rockchip_pin_ctrl rk3506_pin_ctrl = {
> +	.pin_banks		= rk3506_pin_banks,
> +	.nr_banks		= ARRAY_SIZE(rk3506_pin_banks),
> +	.iomux_recalced		= rk3506_mux_recalced_data,
> +	.niomux_recalced	= ARRAY_SIZE(rk3506_mux_recalced_data),
> +	.set_mux		= rk3506_set_mux,
> +	.set_pull		= rk3506_set_pull,
> +	.set_drive		= rk3506_set_drive,
> +	.set_schmitt		= rk3506_set_schmitt,
> +};
> +
> +static const struct udevice_id rk3506_pinctrl_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3506-pinctrl",
> +		.data = (ulong)&rk3506_pin_ctrl
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rockchip_rk3506_pinctrl) = {
> +	.name		= "rockchip_rk3506_pinctrl",
> +	.id		= UCLASS_PINCTRL,
> +	.of_match	= rk3506_pinctrl_ids,
> +	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
> +	.ops		= &rockchip_pinctrl_ops,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind		= dm_scan_fdt_dev,
> +#endif
> +	.probe		= rockchip_pinctrl_probe,
> +};
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index 273e356e7c02..957dcb520591 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -659,6 +659,15 @@ int rockchip_pinctrl_probe(struct udevice *dev)
>   		}
>   	}
>   
> +	if (dev_read_bool(dev, "rockchip,ioc1")) {
> +		priv->regmap_ioc1 =
> +			syscon_regmap_lookup_by_phandle(dev, "rockchip,ioc1");
> +		if (IS_ERR(priv->regmap_ioc1)) {
> +			debug("unable to find rockchip,ioc1 regmap\n");
> +			return PTR_ERR(priv->regmap_ioc1);
> +		}
> +	}
> +
>   	ctrl = rockchip_pinctrl_get_soc_data(dev);
>   	if (!ctrl) {
>   		debug("driver data not available\n");
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> index ba684baed24d..568e6024b78c 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> @@ -528,6 +528,7 @@ struct rockchip_pinctrl_priv {
>   	struct rockchip_pin_ctrl	*ctrl;
>   	struct regmap			*regmap_base;
>   	struct regmap			*regmap_pmu;
> +	struct regmap			*regmap_ioc1;
>   };
>   
>   extern const struct pinctrl_ops rockchip_pinctrl_ops;
