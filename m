Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5330FC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D988E80FA8;
	Tue, 22 Apr 2025 16:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ezwlnm27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6482810E8; Tue, 22 Apr 2025 16:51:27 +0200 (CEST)
Received: from mail-m32109.qiye.163.com (mail-m32109.qiye.163.com
 [220.197.32.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9C88070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf17604;
 Tue, 22 Apr 2025 22:51:18 +0800 (GMT+08:00)
Message-ID: <f2b0aab2-f097-454b-87ac-17a9612f6acc@rock-chips.com>
Date: Tue, 22 Apr 2025 22:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] pinctrl: rockchip: support rk3576 pinctrl
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-5-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx1DVkgfTR5NHhpKTB5OTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfb665403afkunm12bf17604
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6SQw6CzJOT0kQPww#DEpK
 GQMwCRlVSlVKTE9OSEhIT0NLSEhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUpJTU1ONwY+
DKIM-Signature: a=rsa-sha256;
 b=ezwlnm27NHxD3femEaNibZd/HP2RhDlkN81u26RYV9Zw8ls1MYmXUb/oU/7MCrJLtasHx4ltXCYHL9glAZfURWtF/843iAZKwSFf/zYnNiwXwnOuUcaU/8Xome1Ulpg+YCgfUIIEt6wQDnzN41p1k5pDx3D/ROgmXCKx6s6PHr0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=CvFpG82Blk4AfKC9F+EVE0lkIrQEDQmAgRIoG5nyHdE=;
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
> From: Steven Liu <steven.liu@rock-chips.com>
>
> Add support for the rk3576 variant of pinctrl.
>
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> [adapted to mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/Makefile           |   1 +
>   drivers/pinctrl/rockchip/pinctrl-rk3576.c   | 278 ++++++++++++++++++++
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h |   3 +
>   3 files changed, 282 insertions(+)
>   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
>
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index df6c97d6234..e17415e1ca6 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
>   obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
>   obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
>   obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
> +obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
>   obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
>   obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
>   obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3576.c b/drivers/pinctrl/rockchip/pinctrl-rk3576.c
> new file mode 100644
> index 00000000000..66e1142ac1f
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3576.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd
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
> +static int rk3576_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
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
> +	if (bank->bank_num == 0 && pin >= RK_PB4 && pin <= RK_PB7)
> +		reg += 0x1FF4; /* GPIO0_IOC_GPIO0B_IOMUX_SEL_H */
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3576_DRV_BITS_PER_PIN		4
> +#define RK3576_DRV_PINS_PER_REG		4
> +#define RK3576_DRV_GPIO0_AL_OFFSET	0x10
> +#define RK3576_DRV_GPIO0_BH_OFFSET	0x2014
> +#define RK3576_DRV_GPIO1_OFFSET		0x6020
> +#define RK3576_DRV_GPIO2_OFFSET		0x6040
> +#define RK3576_DRV_GPIO3_OFFSET		0x6060
> +#define RK3576_DRV_GPIO4_AL_OFFSET	0x6080
> +#define RK3576_DRV_GPIO4_CL_OFFSET	0xA090
> +#define RK3576_DRV_GPIO4_DL_OFFSET	0xB098
> +
> +static void rk3576_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +
> +	*regmap = priv->regmap_base;
> +	if (bank->bank_num == 0 && pin_num < 12) {
> +		*reg = RK3576_DRV_GPIO0_AL_OFFSET;
> +	} else if (bank->bank_num == 0) {
> +		*reg = RK3576_DRV_GPIO0_BH_OFFSET - 0xc;
> +	} else if (bank->bank_num == 1) {
> +		*reg = RK3576_DRV_GPIO1_OFFSET;
> +	} else if (bank->bank_num == 2) {
> +		*reg = RK3576_DRV_GPIO2_OFFSET;
> +	} else if (bank->bank_num == 3) {
> +		*reg = RK3576_DRV_GPIO3_OFFSET;
> +	} else if (bank->bank_num == 4 && pin_num < 16) {
> +		*reg = RK3576_DRV_GPIO4_AL_OFFSET;
> +	} else if (bank->bank_num == 4 && pin_num < 24) {
> +		*reg = RK3576_DRV_GPIO4_CL_OFFSET - 0x10;
> +	} else if (bank->bank_num == 4) {
> +		*reg = RK3576_DRV_GPIO4_DL_OFFSET - 0x18;
> +	} else {
> +		*reg = 0;
> +		debug("unsupported bank_num %d\n", bank->bank_num);
> +	}
> +
> +	*reg += ((pin_num / RK3576_DRV_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3576_DRV_PINS_PER_REG;
> +	*bit *= RK3576_DRV_BITS_PER_PIN;
> +}
> +
> +static int rk3576_set_drive(struct rockchip_pin_bank *bank,
> +			    int pin_num, int strength)
> +{
> +	struct regmap *regmap;
> +	int reg;
> +	u32 data, rmask;
> +	u8 bit;
> +	int drv = ((strength & BIT(2)) >> 2) | ((strength & BIT(0)) << 2) | (strength & BIT(1));
> +
> +	rk3576_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3576_DRV_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (drv << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3576_PULL_BITS_PER_PIN	2
> +#define RK3576_PULL_PINS_PER_REG	8
> +#define RK3576_PULL_GPIO0_AL_OFFSET	0x20
> +#define RK3576_PULL_GPIO0_BH_OFFSET	0x2028
> +#define RK3576_PULL_GPIO1_OFFSET	0x6110
> +#define RK3576_PULL_GPIO2_OFFSET	0x6120
> +#define RK3576_PULL_GPIO3_OFFSET	0x6130
> +#define RK3576_PULL_GPIO4_AL_OFFSET	0x6140
> +#define RK3576_PULL_GPIO4_CL_OFFSET	0xA148
> +#define RK3576_PULL_GPIO4_DL_OFFSET	0xB14C
> +
> +static void rk3576_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					 int pin_num, struct regmap **regmap,
> +					 int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +
> +	*regmap = priv->regmap_base;
> +	if (bank->bank_num == 0 && pin_num < 12) {
> +		*reg = RK3576_PULL_GPIO0_AL_OFFSET;
> +	} else if (bank->bank_num == 0) {
> +		*reg = RK3576_PULL_GPIO0_BH_OFFSET - 0x4;
> +	} else if (bank->bank_num == 1) {
> +		*reg = RK3576_PULL_GPIO1_OFFSET;
> +	} else if (bank->bank_num == 2) {
> +		*reg = RK3576_PULL_GPIO2_OFFSET;
> +	} else if (bank->bank_num == 3) {
> +		*reg = RK3576_PULL_GPIO3_OFFSET;
> +	} else if (bank->bank_num == 4 && pin_num < 16) {
> +		*reg = RK3576_PULL_GPIO4_AL_OFFSET;
> +	} else if (bank->bank_num == 4 && pin_num < 24) {
> +		*reg = RK3576_PULL_GPIO4_CL_OFFSET - 0x8;
> +	} else if (bank->bank_num == 4) {
> +		*reg = RK3576_PULL_GPIO4_DL_OFFSET - 0xc;
> +	} else {
> +		*reg = 0;
> +		debug("unsupported bank_num %d\n", bank->bank_num);
> +	}
> +
> +	*reg += ((pin_num / RK3576_PULL_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3576_PULL_PINS_PER_REG;
> +	*bit *= RK3576_PULL_BITS_PER_PIN;
> +}
> +
> +static int rk3576_set_pull(struct rockchip_pin_bank *bank,
> +			   int pin_num, int pull)
> +{
> +	struct regmap *regmap;
> +	int reg, ret;
> +	u8 bit, type;
> +	u32 data, rmask;
> +
> +	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
> +		return -ENOTSUPP;
> +
> +	rk3576_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +	type = 1; /* FIXME: was always set to 1 in vendor kernel */
> +	ret = rockchip_translate_pull_value(type, pull);
> +	if (ret < 0) {
> +		debug("unsupported pull setting %d\n", pull);
> +		return ret;
> +	}
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3576_PULL_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (ret << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +#define RK3576_SMT_BITS_PER_PIN		1
> +#define RK3576_SMT_PINS_PER_REG		8
> +#define RK3576_SMT_GPIO0_AL_OFFSET	0x30
> +#define RK3576_SMT_GPIO0_BH_OFFSET	0x2040
> +#define RK3576_SMT_GPIO1_OFFSET		0x6210
> +#define RK3576_SMT_GPIO2_OFFSET		0x6220
> +#define RK3576_SMT_GPIO3_OFFSET		0x6230
> +#define RK3576_SMT_GPIO4_AL_OFFSET	0x6240
> +#define RK3576_SMT_GPIO4_CL_OFFSET	0xA248
> +#define RK3576_SMT_GPIO4_DL_OFFSET	0xB24C
> +
> +static void rk3576_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
> +					    int pin_num,
> +					    struct regmap **regmap,
> +					    int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +
> +	*regmap = priv->regmap_base;
> +	if (bank->bank_num == 0 && pin_num < 12) {
> +		*reg = RK3576_SMT_GPIO0_AL_OFFSET;
> +	} else if (bank->bank_num == 0) {
> +		*reg = RK3576_SMT_GPIO0_BH_OFFSET - 0x4;
> +	} else if (bank->bank_num == 1) {
> +		*reg = RK3576_SMT_GPIO1_OFFSET;
> +	} else if (bank->bank_num == 2) {
> +		*reg = RK3576_SMT_GPIO2_OFFSET;
> +	} else if (bank->bank_num == 3) {
> +		*reg = RK3576_SMT_GPIO3_OFFSET;
> +	} else if (bank->bank_num == 4 && pin_num < 16) {
> +		*reg = RK3576_SMT_GPIO4_AL_OFFSET;
> +	} else if (bank->bank_num == 4 && pin_num < 24) {
> +		*reg = RK3576_SMT_GPIO4_CL_OFFSET - 0x8;
> +	} else if (bank->bank_num == 4) {
> +		*reg = RK3576_SMT_GPIO4_DL_OFFSET - 0xc;
> +	} else {
> +		*reg = 0;
> +		debug("unsupported bank_num %d\n", bank->bank_num);
> +	}
> +
> +	*reg += ((pin_num / RK3576_SMT_PINS_PER_REG) * 4);
> +	*bit = pin_num % RK3576_SMT_PINS_PER_REG;
> +	*bit *= RK3576_SMT_BITS_PER_PIN;
> +}
> +
> +static int rk3576_set_schmitt(struct rockchip_pin_bank *bank,
> +			      int pin_num, int enable)
> +{
> +	struct regmap *regmap;
> +	int reg;
> +	u32 data, rmask;
> +	u8 bit;
> +
> +	rk3576_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> +
> +	/* enable the write to the equivalent lower bits */
> +	data = ((1 << RK3576_SMT_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
> +	data |= (enable << bit);
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);
> +}
> +
> +static struct rockchip_pin_bank rk3576_pin_banks[] = {
> +	RK3576_PIN_BANK_FLAGS(0, 32, "gpio0", IOMUX_WIDTH_4BIT,
> +			      0, 0x8, 0x2004, 0x200C),
> +	RK3576_PIN_BANK_FLAGS(1, 32, "gpio1", IOMUX_WIDTH_4BIT,
> +			      0x4020, 0x4028, 0x4030, 0x4038),
> +	RK3576_PIN_BANK_FLAGS(2, 32, "gpio2", IOMUX_WIDTH_4BIT,
> +			      0x4040, 0x4048, 0x4050, 0x4058),
> +	RK3576_PIN_BANK_FLAGS(3, 32, "gpio3", IOMUX_WIDTH_4BIT,
> +			      0x4060, 0x4068, 0x4070, 0x4078),
> +	RK3576_PIN_BANK_FLAGS(4, 32, "gpio4", IOMUX_WIDTH_4BIT,
> +			      0x4080, 0x4088, 0xA390, 0xB398),
> +};
> +
> +static const struct rockchip_pin_ctrl rk3576_pin_ctrl = {
> +	.pin_banks		= rk3576_pin_banks,
> +	.nr_banks		= ARRAY_SIZE(rk3576_pin_banks),
> +	.grf_mux_offset		= 0x0,
> +	.set_mux		= rk3576_set_mux,
> +	.set_pull		= rk3576_set_pull,
> +	.set_drive		= rk3576_set_drive,
> +	.set_schmitt		= rk3576_set_schmitt,
> +};
> +
> +static const struct udevice_id rk3576_pinctrl_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3576-pinctrl",
> +		.data = (ulong)&rk3576_pin_ctrl
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_rk3576) = {
> +	.name		= "rockchip_rk3576_pinctrl",
> +	.id		= UCLASS_PINCTRL,
> +	.of_match	= rk3576_pinctrl_ids,
> +	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
> +	.ops		= &rockchip_pinctrl_ops,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind		= dm_scan_fdt_dev,
> +#endif
> +	.probe		= rockchip_pinctrl_probe,
> +};
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> index df7bc684d29..5e3c9c90760 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> @@ -458,6 +458,9 @@ struct rockchip_pin_bank {
>   #define MR_PMUGRF(ID, PIN, FUNC, REG, VAL)	\
>   	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROUTE_TYPE_PMUGRF)
>   
> +#define RK3576_PIN_BANK_FLAGS(ID, PIN, LABEL, M, O1, O2, O3, O4)	\
> +	PIN_BANK_IOMUX_FLAGS_OFFSET(ID, PIN, LABEL, M, M, M, M, O1, O2, O3, O4)
> +
>   #define RK3588_PIN_BANK_FLAGS(ID, PIN, LABEL, M, P)			\
>   	PIN_BANK_IOMUX_FLAGS_PULL_FLAGS(ID, PIN, LABEL, M, M, M, M, P, P, P, P)
>   
