Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79EBE7E0C5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 10:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 053958341A;
	Mon,  9 Feb 2026 11:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sETEHnsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E269A83BE1; Mon,  9 Feb 2026 11:50:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625B2805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 11:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f4ed=AN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1770634235;
 bh=Z/EZ7zoHNbeE+55ovpUcHx7TN9DuFbooi7LniorTdds=;
 b=sETEHnscKLZSaHzy6GBoflhARtc/HJHF6s6BGjK6/k9aHv9QGoo3v+bHF2JqpO0FundmE7/mZ
 2o+zL+ESimFwMiKBXXFFxkt1E1vYrO9GHC1T/TVCTBYrDzZUXksAkiNOFB2agreDY4Tz6H5Lqe1
 5mU8udPWa9I63Et/JJEAu/Ybkz9RcSRatLg3BrTwAUVnPV+YBp/tHa9l00a781E+HhfiJzgn2Vd
 o0nZAPOZe4Gu/ht+7SV+itV30t0ix4XxJGmwZtdy/Hm5u9Qhg9BvCud5DP8TqdgFwowuk8gXGGE
 Q7iEjVUFLwgl1MLyh/a0VAEB/m0WQu2jD0iHPkiKs6rg==
X-Forward-Email-ID: 6989bbf9de8d5e1b8dcf7dd8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d249ef51-894c-4c9f-b081-7866875c24f4@kwiboo.se>
Date: Mon, 9 Feb 2026 11:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pinctrl: rockchip: Add RV1103B support
To: Fabio Estevam <festevam@gmail.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de,
 Ye Zhang <ye.zhang@rock-chips.com>, Fabio Estevam <festevam@nabladev.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
 <20260208212624.3413494-3-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260208212624.3413494-3-festevam@gmail.com>
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

On 2/8/2026 10:26 PM, Fabio Estevam wrote:
> From: Ye Zhang <ye.zhang@rock-chips.com>
> 
> Add pinctrl driver for RV1103.
> 
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Use the original author from Rockchip's vendor U-Boot tree.
> - Use regmap_update_bits()
> - Removed unneeded blank lines.
> - Removed unneeded logging functions.
> 
>  drivers/pinctrl/rockchip/Makefile          |   1 +
>  drivers/pinctrl/rockchip/pinctrl-rv1103b.c | 398 +++++++++++++++++++++
>  2 files changed, 399 insertions(+)
>  create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103b.c
> 
> diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
> index e17415e1ca68..2bbee66bd3ca 100644
> --- a/drivers/pinctrl/rockchip/Makefile
> +++ b/drivers/pinctrl/rockchip/Makefile
> @@ -18,5 +18,6 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
>  obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
>  obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
>  obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
> +obj-$(CONFIG_ROCKCHIP_RV1103B) += pinctrl-rv1103b.o
>  obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
>  obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1103b.c b/drivers/pinctrl/rockchip/pinctrl-rv1103b.c
> new file mode 100644
> index 000000000000..fb946b036661
> --- /dev/null
> +++ b/drivers/pinctrl/rockchip/pinctrl-rv1103b.c
> @@ -0,0 +1,398 @@
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
> +static int rv1103b_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
> +{
> +	struct rockchip_pinctrl_priv *priv = bank->priv;
> +	int iomux_num = (pin / 8);
> +	struct regmap *regmap;
> +	u32 data, rmask;
> +	int reg, mask;
> +	u8 bit;
> +
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
> +	rmask = data | (data >> 16);
> +	data |= (mux & mask) << bit;
> +
> +	return regmap_update_bits(regmap, reg, rmask, data);

This seem to have been updated to use regmap_update_bits(), thanks.

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
> +static int rv1103b_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
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
> +static int rv1103b_set_drive(struct rockchip_pin_bank *bank,
> +			    int pin_num, int strength)
> +{
> +	struct regmap *regmap;
> +	int reg, ret, i;
> +	u32 data;
> +	u8 bit;
> +	int rmask_bits = RV1103_DRV_BITS_PER_PIN;
> +
> +	ret = rv1103b_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
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
> +	/* Enable the write to the equivalent lower bits */
> +	data = ((1 << rmask_bits) - 1) << (bit + 16);
> +	data |= (ret << bit);
> +	return regmap_write(regmap, reg, data);

However, this and all remaining places still use regmap_write, please
change all instances of regmap_write to use regmap_update_bits.

This ensure the pins configuration in DT cannot overflow the fields,
that is something that has happened in the past and is why I ensure all
new rk pinctrl drivers matches Linux kernel and use regmap_update_bits
instead of regmap_write.

Regards,
Jonas

> +}

[snip]
