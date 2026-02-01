Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89B2E7C6FA
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 01:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D12883B85;
	Sun,  1 Feb 2026 02:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PHYZO9sS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A683083B5E; Sun,  1 Feb 2026 02:28:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B488A83B5E
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 02:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769909309;
 bh=3oWGuVgPTa2rNvGkxnrYcmPZuZtmT3AqJ+PC0xjnNTk=;
 b=PHYZO9sSKuSxfa23p6KCVhdRWlaCITQkUphhLTBfLlQ+BimJhCyOoCqtaJvNCczBx78HBNgyM
 IYcTQ855c4/rIE48T6a+3KAeUbm3qAbE6QjqmnQ4klLyaLyS3+k8aSDZ2kIb9Sl4mwNPZr4on0+
 GPy30YMNlMHe8UDbvAoTadni3qGIsP/z07zrwE/3nNxb1qI2QFFPX3I6DiQb9W4YW6RzW0vb+cG
 30hMY0zWL53NmQ+nIod1POltETP/bOtgGd+Rd/G1unAyUZlIg01GgytDG+b2EBfd0aasSqMDAEv
 iEzP3crCiq6HHoZkivq0rUbOmk+7XclL6F3tqkjxfG4w==
X-Forward-Email-ID: 697eac3a8af2baab38e57edf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fc2fba9c-9029-4c24-9b11-3bbee77fe688@kwiboo.se>
Date: Sun, 1 Feb 2026 02:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pinctrl: rockchip: Add support for RV1103
To: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@nabladev.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de
References: <20260201004456.763107-1-festevam@gmail.com>
 <20260201004456.763107-2-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260201004456.763107-2-festevam@gmail.com>
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

Hi Fabio,

On 2/1/2026 1:44 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Add pinctrl driver for RV1103.

See prior note about rv1103b vs rv1106/rv1103 compatibility and naming.

> Imported from Rockchip U-Boot 2017.09 next-dev branch.

This driver looks very close to vendor version [1], maybe this patch
should be From/Signed-off-by the original author? That is the practice
we typically follow for Rockchip platform.

[1] https://github.com/rockchip-linux/u-boot/commit/b73745f4bfe57b0a3ff47ae0bd8eea687a26f456

> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
>  drivers/pinctrl/Kconfig                   |  10 +
>  drivers/pinctrl/rockchip/Makefile         |   1 +
>  drivers/pinctrl/rockchip/pinctrl-rv1103.c | 411 ++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103.c
> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index ea90713ec6ca..e204d9880d83 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -254,6 +254,16 @@ config PINCTRL_QE
>  	  This option is to enable the QE pinctrl driver for QE based io
>  	  controller.
>  
> +config PINCTRL_ROCKCHIP_RV1103
> +	bool "Rockchip rv1103 pin control driver"
> +	depends on DM
> +	help
> +	  Support pin multiplexing control on Rockchip rv1103 SoC.
> +
> +	  The driver is controlled by a device tree node which contains
> +	  both the GPIO definitions and pin control functions for each
> +	  available multiplex function.

This Kconfig is not use for anything, please drop.

>  config PINCTRL_ROCKCHIP_RV1108
>  	bool "Rockchip rv1108 pin control driver"
>  	depends on DM
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index e17415e1ca68..f0ffd2b5fe86 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -18,5 +18,6 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
>  obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
>  obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
>  obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
> +obj-$(CONFIG_ROCKCHIP_RV1103) += pinctrl-rv1103.o
>  obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
>  obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1103.c b/drivers/pinctrl/rockchip/pinctrl-rv1103.c
> new file mode 100644
> index 000000000000..362c520212ee
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rv1103.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <dm/pinctrl.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <linux/bitops.h>
> +
> +#include "pinctrl-rockchip.h"
> +
> +static int rv1103_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int iomux_num = (pin / 8);
> +	struct regmap *regmap;
> +	int reg, ret, mask;
> +	u8 bit;
> +	u32 data;
> +
> +	debug("setting mux of GPIO%d-%d to %d\n", bank->bank_num, pin, mux);

This is already logged in pinctrl-rockchip-core, please drop.

> +	if (bank->bank_num == 2 && pin >= 12)
> +		return 0;
> +
> +	regmap = priv->regmap_base;
> +	reg = bank->iomux[iomux_num].offset;
> +	if ((pin % 8) >= 4)
> +		reg += 0x4;
> +	bit = (pin % 4) * 4;
> +	mask = 0xf;
> +
> +	if (bank->recalced_mask & BIT(pin))
> +		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
> +	data = (mask << (bit + 16));
> +	data |= (mux & mask) << bit;
> +
> +	debug("iomux write reg = %x data = %x\n", reg, data);

Please be consistent, log for all reg write or none.

> +
> +	ret = regmap_write(regmap, reg, data);

Please update this driver to use regmap_update_bits instead of
regmap_write, see e.g. pinctrl for rk3528 or pending rk3506.

> +
> +	return ret;
> +}
> +
> +#define RV1103_DRV_BITS_PER_PIN		8
> +#define RV1103_DRV_PINS_PER_REG		2
> +#define RV1103_DRV_GPIO0_A_OFFSET		0x40100
> +#define RV1103_DRV_GPIO0_B_OFFSET		0x50110
> +#define RV1103_DRV_GPIO1_A01_OFFSET		0x140
> +#define RV1103_DRV_GPIO1_A67_OFFSET		0x1014C
> +#define RV1103_DRV_GPIO2_OFFSET		0x30180
> +#define RV1103_DRV_GPIO2_SARADC_OFFSET		0x3080C
> +
> +static int rv1103_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int ret = 0;
> +
> +	*regmap = priv->regmap_base;
> +	switch (bank->bank_num) {
> +	case 0:
> +		if (pin_num < 7)
> +			*reg = RV1103_DRV_GPIO0_A_OFFSET;
> +		else if (pin_num > 7 && pin_num < 14)
> +			*reg = RV1103_DRV_GPIO0_B_OFFSET - 0x10;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 1:
> +		if (pin_num < 6)
> +			*reg = RV1103_DRV_GPIO1_A01_OFFSET;
> +		else if (pin_num >= 6 && pin_num < 23)
> +			*reg = RV1103_DRV_GPIO1_A67_OFFSET - 0xc;
> +		else if (pin_num >= 24 && pin_num < 30)
> +			*reg = RV1103_DRV_GPIO1_A67_OFFSET - 0xc;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 2:
> +		if (pin_num < 12) {
> +			*reg = RV1103_DRV_GPIO2_OFFSET;
> +		} else if (pin_num >= 16) {
> +			ret = -EINVAL;
> +		} else {
> +			*reg = RV1103_DRV_GPIO2_SARADC_OFFSET;
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
> +		printf("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
> +

Please drop unnecessary blank lines in this file.

> +		return ret;
> +	}
> +
> +	*reg += ((pin_num / RV1103_DRV_PINS_PER_REG) * 4);
> +	*bit = pin_num % RV1103_DRV_PINS_PER_REG;
> +	*bit *= RV1103_DRV_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rv1103_set_drive(struct rockchip_pin_bank *bank,
> +			    int pin_num, int strength)
> +{
> +	struct regmap *regmap;
> +	int reg, ret, i;
> +	u32 data;
> +	u8 bit;
> +	int rmask_bits = RV1103_DRV_BITS_PER_PIN;
> +
> +	ret = rv1103_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0, ret = 1; i < strength; i++)
> +		ret = (ret << 1) | 1;
> +
> +	if (bank->bank_num == 2 && pin_num >= 12) {
> +		rmask_bits = 2;
> +		ret = strength;
> +	}
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << rmask_bits) - 1) << (bit + 16);
> +	data |= (ret << bit);
> +	ret = regmap_write(regmap, reg, data);
> +
> +	return ret;
> +}
> +
> +#define RV1103_PULL_BITS_PER_PIN		2
> +#define RV1103_PULL_PINS_PER_REG		8
> +#define RV1103_PULL_GPIO0_A_OFFSET		0x40200
> +#define RV1103_PULL_GPIO0_B_OFFSET		0x50204
> +#define RV1103_PULL_GPIO1_A01_OFFSET		0x210
> +#define RV1103_PULL_GPIO1_A67_OFFSET		0x10210
> +#define RV1103_PULL_GPIO2_OFFSET		0x30220
> +#define RV1103_PULL_GPIO2_SARADC_OFFSET	0x3080C
> +
> +static int rv1103_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int ret = 0;
> +
> +	*regmap = priv->regmap_base;
> +	switch (bank->bank_num) {
> +	case 0:
> +		if (pin_num < 7)
> +			*reg = RV1103_PULL_GPIO0_A_OFFSET;
> +		else if (pin_num > 7 && pin_num < 14)
> +			*reg = RV1103_PULL_GPIO0_B_OFFSET - 0x4;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 1:
> +		if (pin_num < 6)
> +			*reg = RV1103_PULL_GPIO1_A01_OFFSET;
> +		else if (pin_num >= 6 && pin_num < 23)
> +			*reg = RV1103_PULL_GPIO1_A67_OFFSET;
> +		else if (pin_num >= 24 && pin_num < 30)
> +			*reg = RV1103_PULL_GPIO1_A67_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 2:
> +		if (pin_num < 12) {
> +			*reg = RV1103_PULL_GPIO2_OFFSET;
> +		} else if (pin_num >= 16) {
> +			ret = -EINVAL;
> +		} else {
> +			*reg = RV1103_PULL_GPIO2_SARADC_OFFSET;
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
> +		printf("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
> +
> +		return ret;
> +	}
> +
> +	*reg += ((pin_num / RV1103_PULL_PINS_PER_REG) * 4);
> +	*bit = pin_num % RV1103_PULL_PINS_PER_REG;
> +	*bit *= RV1103_PULL_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rv1103_set_pull(struct rockchip_pin_bank *bank,
> +			   int pin_num, int pull)
> +{
> +	struct regmap *regmap;
> +	int reg, ret;
> +	u8 bit, type;
> +	u32 data;
> +
> +	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
> +		return -EINVAL;
> +
> +	ret = rv1103_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
> +	type = bank->pull_type[pin_num / 8];
> +
> +	if (bank->bank_num == 2 && pin_num >= 12)
> +		type = 1;
> +
> +	ret = rockchip_translate_pull_value(type, pull);
> +	if (ret < 0) {
> +		debug("unsupported pull setting %d\n", pull);
> +
> +		return ret;
> +	}
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RV1103_PULL_BITS_PER_PIN) - 1) << (bit + 16);
> +
> +	data |= (ret << bit);
> +	ret = regmap_write(regmap, reg, data);
> +
> +	return ret;
> +}
> +
> +#define RV1103_SMT_BITS_PER_PIN		1
> +#define RV1103_SMT_PINS_PER_REG		8
> +#define RV1103_SMT_GPIO0_A_OFFSET		0x40400
> +#define RV1103_SMT_GPIO0_B_OFFSET		0x50404
> +#define RV1103_SMT_GPIO1_A01_OFFSET		0x410
> +#define RV1103_SMT_GPIO1_A67_OFFSET		0x10410
> +#define RV1103_SMT_GPIO2_OFFSET		0x30420
> +#define RV1103_SMT_GPIO2_SARADC_OFFSET		0x3080C
> +
> +static int rv1103_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
> +					   int pin_num,
> +					   struct regmap **regmap,
> +					   int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int ret = 0;
> +
> +	*regmap = priv->regmap_base;
> +	switch (bank->bank_num) {
> +	case 0:
> +		if (pin_num < 7)
> +			*reg = RV1103_SMT_GPIO0_A_OFFSET;
> +		else if (pin_num > 7 && pin_num < 14)
> +			*reg = RV1103_SMT_GPIO0_B_OFFSET - 0x4;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 1:
> +		if (pin_num < 6)
> +			*reg = RV1103_SMT_GPIO1_A01_OFFSET;
> +		else if (pin_num >= 6 && pin_num < 23)
> +			*reg = RV1103_SMT_GPIO1_A67_OFFSET;
> +		else if (pin_num >= 24 && pin_num < 30)
> +			*reg = RV1103_SMT_GPIO1_A67_OFFSET;
> +		else
> +			ret = -EINVAL;
> +		break;
> +
> +	case 2:
> +		if (pin_num < 12) {
> +			*reg = RV1103_SMT_GPIO2_OFFSET;
> +		} else if (pin_num >= 16) {
> +			ret = -EINVAL;
> +		} else {
> +			*reg = RV1103_SMT_GPIO2_SARADC_OFFSET;
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
> +		printf("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
> +
> +		return ret;
> +	}
> +
> +	*reg += ((pin_num / RV1103_SMT_PINS_PER_REG) * 4);
> +	*bit = pin_num % RV1103_SMT_PINS_PER_REG;
> +	*bit *= RV1103_SMT_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +static int rv1103_set_schmitt(struct rockchip_pin_bank *bank,
> +			      int pin_num, int enable)
> +{
> +	struct regmap *regmap;
> +	int reg, ret;
> +	u32 data;
> +	u8 bit;
> +
> +	ret = rv1103_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RV1103_SMT_BITS_PER_PIN) - 1) << (bit + 16);
> +	data |= (enable << bit);
> +
> +	if (bank->bank_num == 2 && pin_num >= 12) {
> +		data = 0x3 << (bit + 16);
> +		data |= ((enable ? 0x3 : 0) << bit);
> +	}
> +	ret = regmap_write(regmap, reg, data);
> +
> +	return ret;
> +}
> +
> +static struct rockchip_mux_recalced_data rv1103_mux_recalced_data[] = {
> +	{
> +		.num = 1,
> +		.pin = 6,
> +		.reg = 0x10024,
> +		.bit = 8,
> +		.mask = 0xf
> +	}, {
> +		.num = 1,
> +		.pin = 7,
> +		.reg = 0x10024,
> +		.bit = 12,
> +		.mask = 0xf
> +	},
> +};
> +
> +static struct rockchip_pin_bank rv1103_pin_banks[] = {
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x40000, 0x50008, 0x50010, 0x50018),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x20, 0x10028, 0x10030, 0x10038),
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    IOMUX_WIDTH_4BIT,
> +				    0x30040, 0x30048, 0x30050, 0x30058),
> +};
> +
> +static const struct rockchip_pin_ctrl rv1103_pin_ctrl = {
> +	.pin_banks		= rv1103_pin_banks,
> +	.nr_banks		= ARRAY_SIZE(rv1103_pin_banks),
> +	.iomux_recalced		= rv1103_mux_recalced_data,
> +	.niomux_recalced	= ARRAY_SIZE(rv1103_mux_recalced_data),
> +	.set_mux		= rv1103_set_mux,
> +	.set_pull		= rv1103_set_pull,
> +	.set_drive		= rv1103_set_drive,
> +	.set_schmitt		= rv1103_set_schmitt,
> +};
> +
> +static const struct udevice_id rv1103_pinctrl_ids[] = {
> +	{
> +		.compatible = "rockchip,rv1103-pinctrl",

As already mentioned, please send out and get this complatible acked in
Linux, especially with the rv1103b vs rv1106/rv1103 confusion.

Regards,
Jonas

> +		.data = (ulong)&rv1103_pin_ctrl
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_rv1103) = {
> +	.name		= "rockchip_rv1103_pinctrl",
> +	.id		= UCLASS_PINCTRL,
> +	.of_match	= rv1103_pinctrl_ids,
> +	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
> +	.ops		= &rockchip_pinctrl_ops,
> +#if !CONFIG_IS_ENABLED(OF_PLATDATA)
> +	.bind		= dm_scan_fdt_dev,
> +#endif
> +	.probe		= rockchip_pinctrl_probe,
> +};

