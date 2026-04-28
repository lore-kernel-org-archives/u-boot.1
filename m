Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F50FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC7B58466E;
	Tue, 28 Apr 2026 22:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HiVLueII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B81384671; Tue, 28 Apr 2026 22:42:37 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78E48466D
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d55b97f358so7788814a34.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777408952; x=1778013752;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hT/o/JLJ0ZE5zyDZIzqyrYDKMnHWGDQ+ucv4oZZMN8U=;
 b=HiVLueII0w9e5XLyzSSCa0X/4LoiDnFnRdtGm1tKRwZTvHcencVCBR84uk+rTMQAcd
 dAPglh1vqS+gYmz0t41jM0M3HevZOoBRmOpS0qC8p1YsqH6qDkbUsGUX3qvXFnJhQsJu
 VcBIovZhAHoypKKV3X5HieL+WrOhsBGztY1wNl1k9gCrit//GfgepxOYGY4hlfatrKDP
 YtSb2HFtm4H0WelPodvPlx1gKb8tlgPBK1lUsvfUrWexfArAAjYhDmgU2x2Rrj09kCAu
 ufDaNKbAVTHCoDD0M0+f/C9a6K2fP4MdfO98yojKwGKtxdHeejSF4bH52QQ92eBbXCT6
 GNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777408952; x=1778013752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hT/o/JLJ0ZE5zyDZIzqyrYDKMnHWGDQ+ucv4oZZMN8U=;
 b=Kx1tndfQaLNi8RvijPQkzhPQnl0NF7EPEjavmDI8+8ZLQaw8qclkB9KHjh6TRxCfLi
 cMxo+OKDBsP9lXr27RTmm7JILpLpkvHj/A34jqXCbdR04ux7LLT9y/H7iXk+dpWQnC56
 Kc5xR6I4pMz08XLV1XD1tdGc4irCwXH8l+j4MI3qxDw4loz+UzBLeucdp6h2cK3XDVlP
 IrgE5vvJMMxCz1KNC+69jlTbNKScsXwTqB2NBvdmSBaYwnGb6Nrq9Vb6KOP9O3LFV0SM
 GiosZn9typtVCLB8OfTtkwPl5gdPHLOFXDVFZ4zvMKJkSotSebWWyEoC7xUBzoxI/6e1
 UbIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/okzZfOZMVoHnjJrqRw46Ib8tHwbVtS/49zAKNNF+VSEGGbmU8jy43Zwv1utE4fmMqPYtDMkQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwwbjQjZ9+0ct/kI0WCNDU3FCSnLQhK4l4h5DzzRuyYKdVsya3o
 bbEaPw+y+9jNZUQJxaRQ2TUuSzbC3znybMYtyuYyCQ+OpSFUWTb81fiS8OGl4SdGjgw=
X-Gm-Gg: AeBDievEdRboRVX/+XcrxlrorXxa51TTnNeh6JhP3TTsXGcr7ixL3xp//BHU402+lV8
 t5e6VLQGIWUbegkkrEIpK7fWBGdsOlJWqGPKRhqyWOLdORjJEXSr0lclGw1T/isbh8Zq2XlwBi7
 8BtxiMpi1gqEGDYzxu8TPQWfSVAgnoWA8KB924iCwoKO6ah/yBBZU24bj49DnS2s7WJxE4bwQ/s
 1YWoegqNNvUiBRwMSDjfto9bwzL38Z6/hywI7oRR0sj6qzRqqWXrWC+5T4D1asQPhwndZz4z3dC
 +PFompiIFBWg1kfV0HsRO5crHP/GzPbuQ53kvVxFxWiIGy9o2ZAJP66nLuSH/wh5yfxleAq1GM5
 +Z3/M/hfxZApcBClsEubqkHdr3mR694OBFvnqRQcOb9dNDhgMylT3km8aHmagPeakOwiI9ZkVQY
 jCV4I8Ufkdxo1wfVtRpFDXMomUzfSoqSkpJpOEgX245mn91Pg/RT8/owcsIDFvcM6YZdXnVWW3p
 +QhOXiaz5q3
X-Received: by 2002:a05:6830:4195:b0:7dc:db3c:1d82 with SMTP id
 46e09a7af769-7dea65a47f4mr847757a34.10.1777408952441; 
 Tue, 28 Apr 2026 13:42:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab242f01sm5618a34.24.2026.04.28.13.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 13:42:31 -0700 (PDT)
Message-ID: <5f524c23-d21f-49f6-8b26-778654c41a42@baylibre.com>
Date: Tue, 28 Apr 2026 15:42:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
 <20260428153448.980150-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-3-mikhail.kshevetskiy@iopsys.eu>
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

On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
> The driver based on official linux airoha pinctrl and gpio driver with
> Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
> The changes:
>  * Separate code for each SoC and keep some of the functions in
>    common between them,
>  * Add pinctrl driver for EN7523 SoC.

These comments above seem more approiate for the cover letter.
I can keep the cover letter in the git history when I pick this up if
we think that is important.

> 
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
> 
> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/pinctrl/Kconfig                 |    1 +
>  drivers/pinctrl/Makefile                |    1 +
>  drivers/pinctrl/airoha/Kconfig          |   16 +
>  drivers/pinctrl/airoha/Makefile         |    5 +
>  drivers/pinctrl/airoha/airoha-common.h  |  513 +++++++++++
>  drivers/pinctrl/airoha/pinctrl-airoha.c |  691 +++++++++++++++
>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1060 +++++++++++++++++++++++

Let's split out an7581 support into a separate patch too and have
this patch just be the core/shared code.

>  7 files changed, 2287 insertions(+)
>  create mode 100644 drivers/pinctrl/airoha/Kconfig
>  create mode 100644 drivers/pinctrl/airoha/Makefile
>  create mode 100644 drivers/pinctrl/airoha/airoha-common.h
>  create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 578edbf8168..46a95a1ab6b 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
>  
>  endif
>  
> +source "drivers/pinctrl/airoha/Kconfig"
>  source "drivers/pinctrl/broadcom/Kconfig"
>  source "drivers/pinctrl/exynos/Kconfig"
>  source "drivers/pinctrl/intel/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 29fb9b484d0..b03e838ab39 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
>  obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
>  obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
>  obj-$(CONFIG_PINCTRL_MESON)	+= meson/
> +obj-$(CONFIG_PINCTRL_AIROHA)	+= airoha/

Alphabetical order?

>  obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
>  obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
>  obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
> new file mode 100644
> index 00000000000..986d23c2e3d
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config PINCTRL_AIROHA
> +	depends on ARCH_AIROHA
> +	select PINCTRL_FULL
> +	select PINCTRL_GENERIC
> +	select PINMUX
> +	select PINCONF
> +	select REGMAP
> +	select SYSCON
> +	bool
> +
> +config PINCTRL_AIROHA_AN7581
> +	tristate "AN7581 pin controller and gpio driver"
> +	depends on TARGET_AN7581
> +	select PINCTRL_AIROHA
> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
> new file mode 100644
> index 00000000000..909bd9a04d9
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
> +
> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
> diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
> new file mode 100644
> index 00000000000..21bc9f50083
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/airoha-common.h
> @@ -0,0 +1,513 @@


...

> +#define AIROHA_PINCTRL_PHY_LED0(variant, gpio, mux_val, map_mask, map_val)	\

Might look nicer to just use space instead of tab before \ on this first line.

> +	{								\
> +		.name = (gpio),						\
> +		.regmap[0] = {						\
> +			AIROHA_FUNC_MUX,				\
> +			variant##_REG_GPIO_2ND_I2C_MODE,				\

Indent of \ seems off on this one.

> +			(mux_val),					\
> +			(mux_val),					\
> +		},							\
> +		.regmap[1] = {						\
> +			AIROHA_FUNC_MUX,				\
> +			REG_LAN_LED0_MAPPING,				\
> +			(map_mask),					\
> +			(map_val),					\
> +		},							\
> +		.regmap_size = 2,					\
> +	}
> +
> +#define AIROHA_PINCTRL_PHY_LED1(variant, gpio, mux_val, map_mask, map_val)	\
> +	{								\
> +		.name = (gpio),						\
> +		.regmap[0] = {						\
> +			AIROHA_FUNC_MUX,				\
> +			variant##_REG_GPIO_2ND_I2C_MODE,				\

Same as 2 comments above.

> +			(mux_val),					\
> +			(mux_val),					\
> +		},							\
> +		.regmap[1] = {						\
> +			AIROHA_FUNC_MUX,				\
> +			REG_LAN_LED1_MAPPING,				\
> +			(map_mask),					\
> +			(map_val),					\
> +		},							\
> +		.regmap_size = 2,					\
> +	}
> +

...

> +enum airoha_pinctrl_confs_type {
> +	AIROHA_PINCTRL_CONFS_PULLUP,
> +	AIROHA_PINCTRL_CONFS_PULLDOWN,
> +	AIROHA_PINCTRL_CONFS_DRIVE_E2,
> +	AIROHA_PINCTRL_CONFS_DRIVE_E4,
> +	AIROHA_PINCTRL_CONFS_PCIE_RST_OD,
> +
> +	AIROHA_PINCTRL_CONFS_MAX,

No comma on this one since it must always be last.

> +};
> +
> +struct airoha_pinctrl {
> +	struct udevice *dev;
> +	struct airoha_pinctrl_match_data *data;
> +
> +	struct regmap *chip_scu;
> +	struct regmap *regmap;
> +
> +	struct airoha_pinctrl_gpiochip gpiochip;
> +};
> +
> +struct airoha_pinctrl_match_data {
> +	const int gpio_offs;
> +	const int gpio_pin_cnt;
> +	const struct pinctrl_pin_desc *pins;
> +	const unsigned int num_pins;
> +	const struct pingroup *grps;
> +	const unsigned int num_grps;
> +	const struct airoha_pinctrl_func *funcs;
> +	const unsigned int num_funcs;
> +	const struct airoha_pinctrl_confs_info confs_info[AIROHA_PINCTRL_CONFS_MAX];
> +};
> +
> +extern const struct pinctrl_ops airoha_pinctrl_ops;
> +
> +int airoha_pinctrl_probe(struct udevice *dev);
> +int airoha_pinctrl_bind(struct udevice *dev);
> +
> +#endif
> diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
> new file mode 100644
> index 00000000000..c8a22792d51
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
> @@ -0,0 +1,691 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + * Author: Markus Gothe <markus.gothe@genexis.eu>
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <dm/ofnode.h>
> +#include <asm-generic/gpio.h>
> +#include <dt-bindings/pinctrl/mt65xx.h>
> +#include <regmap.h>
> +
> +#include <syscon.h>
> +#include <asm/arch/scu-regmap.h>
> +
> +#include "airoha-common.h"
> +
> +//#define PINCTRL_GET_STATE
> +

Drop commented/dead code. If there is a good reason to keep
airoha_pinctrl_get_conf(), the make a comment there, otherwise
drop it.


> +static int airoha_gpiochip_register(struct udevice *parent)
> +{
> +	struct airoha_pinctrl *pinctrl;
> +	struct uclass_driver *drv;
> +	struct udevice *dev;
> +	int ret;
> +	ofnode node;
> +
> +	drv = lists_uclass_lookup(UCLASS_GPIO);
> +	if (!drv)
> +		return -ENOENT;
> +
> +	/*
> +	 * Support upstream linux DTSI that define gpio-controller
> +	 * in the root node (instead of a dedicated subnode)
> +	 */
> +	if (dev_read_bool(parent, "gpio-controller")) {
> +		node = dev_ofnode(parent);
> +		goto bind;

Why do we need goto instead of moving the code below into the if
statement?

> +	}
> +
> +	ret = -ENOENT;
> +	dev_for_each_subnode(node, parent)
> +		if (ofnode_read_bool(node, "gpio-controller")) {
> +			ret = 0;
> +			break;
> +		}
> +
> +	if (ret)
> +		return ret;
> +
> +bind:
> +	ret = device_bind_with_driver_data(parent, &airoha_pinctrl_gpio_driver,
> +					   "airoha_pinctrl_gpio", 0, node,
> +					   &dev);
> +	if (ret)
> +		return ret;
> +
> +	pinctrl = dev_get_priv(parent);
> +	pinctrl->gpiochip.dev = dev;
> +
> +	return 0;
> +}
> +

...

> +#if defined(PINCTRL_GET_STATE)
> +static int airoha_pinctrl_get_conf(struct airoha_pinctrl *pinctrl,
> +				   enum airoha_pinctrl_confs_type conf_type,
> +				   int pin, u32 *val)
> +{
> +	const struct airoha_pinctrl_confs_info *confs_info;
> +	const struct airoha_pinctrl_reg *reg;
> +
> +	confs_info = &pinctrl->data->confs_info[conf_type];
> +
> +	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
> +					  confs_info->num_confs,
> +					  pin);
> +	if (!reg)
> +		return -EINVAL;
> +
> +	if (regmap_read(pinctrl->chip_scu, reg->offset, val))
> +		return -EINVAL;
> +
> +	*val = (*val & reg->mask) >> __ffs(reg->mask);

Linux recently got field_get() that is like FIELD_GET() but allows
non-constant mask. Maybe time to bring that to U-Boot?


> +
> +	return 0;
> +}
> +#endif
> +
> +static int airoha_pinctrl_set_conf(struct airoha_pinctrl *pinctrl,
> +				   enum airoha_pinctrl_confs_type conf_type,
> +				   int pin, u32 val)
> +{
> +	const struct airoha_pinctrl_confs_info *confs_info;
> +	const struct airoha_pinctrl_reg *reg = NULL;
> +
> +	confs_info = &pinctrl->data->confs_info[conf_type];
> +
> +	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
> +					  confs_info->num_confs,
> +					  pin);
> +	if (!reg)
> +		return -EINVAL;
> +
> +	if (regmap_update_bits(pinctrl->chip_scu, reg->offset, reg->mask,
> +			       val << __ffs(reg->mask)))

Similar here, field_prep().

There are already 2 other drivers that locally #define field_prep() that
could benifit.

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +



> +static int airoha_pinmux_group_set(struct udevice *dev, unsigned group_selector,
> +				   unsigned func_selector)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +
> +	dev_info(dev, "enabling %s function for pin group %s\n",

dev_info() seems a bit verbose for this. Should this (and all others) be
dev_dbg() instead?

> +		airoha_get_func_name(dev, func_selector),
> +		airoha_get_group_name(dev, group_selector));
> +
> +	return airoha_pinmux_set_mux(pinctrl, func_selector, group_selector);
> +}
> +
> +static int airoha_pinmux_set(struct udevice *dev, unsigned pin_selector,
> +			     unsigned func_selector)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +	const struct airoha_pinctrl_match_data *data = pinctrl->data;
> +	const char *pin_name;
> +	unsigned selector;
> +
> +	pin_name = data->pins[pin_selector].name;
> +
> +	/* find group matching the pin_name */
> +	for (selector = 0; selector < data->num_grps; selector++) {
> +		if (!strcmp(pin_name, data->grps[selector].name))
> +			return airoha_pinmux_group_set(dev, selector,
> +						       func_selector);
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static const struct pinconf_param airoha_pinconf_params[] = {
> +	{ "bias-disable",     PIN_CONFIG_BIAS_DISABLE,     0 },
> +	{ "bias-pull-up",     PIN_CONFIG_BIAS_PULL_UP,     1 },
> +	{ "bias-pull-down",   PIN_CONFIG_BIAS_PULL_DOWN,   1 },
> +	{ "drive-strength",   PIN_CONFIG_DRIVE_STRENGTH,   0 },
> +	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
> +	{ "output-enable",    PIN_CONFIG_OUTPUT_ENABLE,    1 },
> +	{ "input-enable",     PIN_CONFIG_INPUT_ENABLE,     1 },
> +};
> +
> +static int airoha_pinconf_set_handler(struct udevice *dev, unsigned pin_selector,
> +				      unsigned param, unsigned argument)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +	unsigned long configs[1] = { param };
> +	unsigned int pin = pinctrl->data->pins[pin_selector].number;

Can we be sure that pin_selector is not out of bounds?

> +
> +	dev_info(dev, "enabling %s=%d property for pin %s\n",
> +		airoha_pinconf_params[param].property, argument,
> +		airoha_get_pin_name(dev, pin_selector));

Is this supposed to do something with `argument`? Strange to print it
but not pass it to airoha_pinconf_set().

> +
> +	return airoha_pinconf_set(pinctrl, pin, configs, 1);

Better would be ARRAY_SIZE(configs) instead of 1.

Or change the type of `param` and pass &param instead.

> +}
> +
> +static int airoha_pinconf_group_set_handler(struct udevice *dev, unsigned group_selector,
> +					    unsigned param, unsigned argument)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +	unsigned long configs[1] = { param };
> +
> +	dev_info(dev, "enabling %s=%d property for pin group %s\n",
> +		airoha_pinconf_params[param].property, argument,
> +		airoha_get_group_name(dev, group_selector));
> +
> +	return airoha_pinconf_group_set(pinctrl, group_selector, configs, 1);
> +}
> +
> +const struct pinctrl_ops airoha_pinctrl_ops = {
> +	.get_pins_count		= airoha_get_pins_count,
> +	.get_pin_name		= airoha_get_pin_name,
> +	.get_groups_count	= airoha_get_groups_count,
> +	.get_group_name		= airoha_get_group_name,
> +	.get_functions_count	= airoha_get_funcs_count,
> +	.get_function_name	= airoha_get_func_name,
> +	.pinmux_set		= airoha_pinmux_set,
> +	.pinmux_group_set	= airoha_pinmux_group_set,
> +
> +	.pinconf_num_params	= ARRAY_SIZE(airoha_pinconf_params),
> +	.pinconf_params		= airoha_pinconf_params,
> +	.pinconf_set		= airoha_pinconf_set_handler,
> +	.pinconf_group_set	= airoha_pinconf_group_set_handler,
> +
> +	.set_state		= pinctrl_generic_set_state,
> +};
> +
> +int airoha_pinctrl_probe(struct udevice *dev)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +
> +	pinctrl->dev = dev;
> +	pinctrl->data = (struct airoha_pinctrl_match_data *)dev_get_driver_data(dev);

nit: casting isn't needed here (leaving it out makes it more readable)

> +
> +	pinctrl->regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
> +	if (IS_ERR(pinctrl->regmap))
> +		return PTR_ERR(pinctrl->regmap);
> +
> +	pinctrl->chip_scu = airoha_get_chip_scu_regmap();
> +	if (IS_ERR(pinctrl->chip_scu))
> +		return PTR_ERR(pinctrl->chip_scu);
> +
> +	pinctrl->gpiochip.data   = gpio_data_regs;
> +	pinctrl->gpiochip.dir    = gpio_dir_regs;
> +	pinctrl->gpiochip.out    = gpio_out_regs;
> +	pinctrl->gpiochip.status = irq_status_regs;
> +	pinctrl->gpiochip.level  = irq_level_regs;
> +	pinctrl->gpiochip.edge   = irq_edge_regs;
> +
> +	return 0;
> +}
> +
> +int airoha_pinctrl_bind(struct udevice *dev)
> +{
> +	/*
> +	 * Make sure that the pinctrl driver gets probed after binding
> +	 * as on EN7523/AN7581/AN7583 the pinctrl driver is the one that
> +	 * is also registering the GPIO one during probe, so if its not
> +	 * probed GPIO-s are not registered as well.

s/GPIO-s/GPIOs/

> +	 */
> +	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
> +	return airoha_gpiochip_register(dev);
> +}
> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
> new file mode 100644
> index 00000000000..c70952e9ba8
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
> @@ -0,0 +1,1060 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + * Author: Markus Gothe <markus.gothe@genexis.eu>
> + */
> +#include "airoha-common.h"
> +
> +static const int en7581_pon_pins[] = { 49, 50, 51, 52, 53, 54 };
> +static const int en7581_pon_tod_1pps_pins[] = { 46 };
> +static const int en7581_gsw_tod_1pps_pins[] = { 46 };
> +static const int en7581_sipo_pins[] = { 16, 17 };
> +static const int en7581_sipo_rclk_pins[] = { 16, 17, 43 };
> +static const int en7581_mdio_pins[] = { 14, 15 };
> +static const int en7581_uart2_pins[] = { 48, 55 };
> +static const int en7581_uart2_cts_rts_pins[] = { 46, 47 };
> +static const int en7581_hsuart_pins[] = { 28, 29 };
> +static const int en7581_hsuart_cts_rts_pins[] = { 26, 27 };
> +static const int en7581_uart4_pins[] = { 38, 39 };
> +static const int en7581_uart5_pins[] = { 18, 19 };
> +static const int en7581_i2c0_pins[] = { 2, 3 };
> +static const int en7581_i2c1_pins[] = { 14, 15 };
> +static const int en7581_jtag_udi_pins[] = { 16, 17, 18, 19, 20 };
> +static const int en7581_jtag_dfd_pins[] = { 16, 17, 18, 19, 20 };
> +static const int en7581_i2s_pins[] = { 26, 27, 28, 29 };
> +static const int en7581_pcm1_pins[] = { 22, 23, 24, 25 };
> +static const int en7581_pcm2_pins[] = { 18, 19, 20, 21 };
> +static const int en7581_spi_quad_pins[] = { 32, 33 };
> +static const int en7581_spi_pins[] = { 4, 5, 6, 7 };
> +static const int en7581_spi_cs1_pins[] = { 34 };
> +static const int en7581_pcm_spi_pins[] = { 18, 19, 20, 21, 22, 23, 24, 25 };
> +static const int en7581_pcm_spi_int_pins[] = { 14 };
> +static const int en7581_pcm_spi_rst_pins[] = { 15 };
> +static const int en7581_pcm_spi_cs1_pins[] = { 43 };
> +static const int en7581_pcm_spi_cs2_pins[] = { 40 };
> +static const int en7581_pcm_spi_cs2_p128_pins[] = { 40 };
> +static const int en7581_pcm_spi_cs2_p156_pins[] = { 40 };
> +static const int en7581_pcm_spi_cs3_pins[] = { 41 };
> +static const int en7581_pcm_spi_cs4_pins[] = { 42 };
> +static const int en7581_emmc_pins[] = {
> +	4, 5, 6, 30, 31, 32, 33, 34, 35, 36, 37
> +};
> +static const int en7581_pnand_pins[] = { 4,  5,	 6,  7,	 30, 31, 32, 33, 34,
> +					 35, 36, 37, 38, 39, 40, 41, 42 };
...

> +static const char *const pon_groups[] = { "pon" };
> +static const char *const tod_1pps_groups[] = { "pon_tod_1pps", "gsw_tod_1pps" };
> +static const char *const sipo_groups[] = { "sipo", "sipo_rclk" };
> +static const char *const mdio_groups[] = { "mdio" };
> +
> +static const char *const uart_groups[] = { "uart2",  "uart2_cts_rts",
> +					   "hsuart", "hsuart_cts_rts",
> +					   "uart4",  "uart5" };
> +static const char *const i2c_groups[] = { "i2c1" };
> +static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
> +static const char *const pcm_groups[] = { "pcm1", "pcm2" };
> +static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
> +static const char *const pcm_spi_groups[] = {
> +	"pcm_spi",	    "pcm_spi_int",	"pcm_spi_rst", "pcm_spi_cs1",
> +	"pcm_spi_cs2_p156", "pcm_spi_cs2_p128", "pcm_spi_cs3", "pcm_spi_cs4"
> +};
> +
> +static const char *const i2s_groups[] = { "i2s" };
> +static const char *const emmc_groups[] = { "emmc" };
> +static const char *const pnand_groups[] = { "pnand" };
> +static const char *const pcie_reset_groups[] = { "pcie_reset0", "pcie_reset1",
> +						 "pcie_reset2" };
> +
> +static const char *const pwm_groups[] = {
> +	"gpio0",  "gpio1",  "gpio2",  "gpio3",	"gpio4",  "gpio5",  "gpio6",
> +	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
> +	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
> +	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
> +	"gpio28", "gpio29", "gpio30", "gpio31", "gpio36", "gpio37", "gpio38",
> +	"gpio39", "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45",
> +	"gpio46", "gpio47"
> +};
> +static const char *const phy1_led0_groups[] = { "gpio33", "gpio34", "gpio35",
> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
> +static const char *const phy2_led0_groups[] = { "gpio33", "gpio34", "gpio35",
> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
> +static const char *const phy3_led0_groups[] = { "gpio33", "gpio34", "gpio35",
> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
> +static const char *const phy4_led0_groups[] = { "gpio33", "gpio34", "gpio35",
> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
> +static const char *const phy1_led1_groups[] = { "gpio43", "gpio44", "gpio45",
> +						"gpio46" };
> +static const char *const phy2_led1_groups[] = { "gpio43", "gpio44", "gpio45",
> +						"gpio46" };
> +static const char *const phy3_led1_groups[] = { "gpio43", "gpio44", "gpio45",
> +						"gpio46" };
> +static const char *const phy4_led1_groups[] = { "gpio43", "gpio44", "gpio45",
> +						"gpio46" };

I would wrap these like this to be more readable:

static const char *const phy4_led1_groups[] = {
	"gpio43", "gpio44", "gpio45", "gpio46"
};

Same applies to other stuff above like uart_groups.

> +
> +static const struct airoha_pinctrl_conf en7581_pinctrl_drive_e2_conf[] = {
> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E2, SPI_MISO_E2_MASK),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(0)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(1)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(2)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(3)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(4)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(5)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(6)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(7)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(8)),
> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(9)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(10)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(11)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(12)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(13)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(14)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_E2, BIT(15)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_E2, BIT(16)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_E2, BIT(17)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_E2, BIT(18)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_E2, BIT(20)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_E2, BIT(21)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_E2, BIT(22)),
> +	PINCTRL_CONF_DESC(36, REG_GPIO_L_E2, BIT(23)),
> +	PINCTRL_CONF_DESC(37, REG_GPIO_L_E2, BIT(24)),
> +	PINCTRL_CONF_DESC(38, REG_GPIO_L_E2, BIT(25)),
> +	PINCTRL_CONF_DESC(39, REG_GPIO_L_E2, BIT(26)),
> +	PINCTRL_CONF_DESC(40, REG_GPIO_L_E2, BIT(27)),
> +	PINCTRL_CONF_DESC(41, REG_GPIO_L_E2, BIT(28)),
> +	PINCTRL_CONF_DESC(42, REG_GPIO_L_E2, BIT(29)),
> +	PINCTRL_CONF_DESC(43, REG_GPIO_L_E2, BIT(30)),
> +	PINCTRL_CONF_DESC(44, REG_GPIO_L_E2, BIT(31)),
> +	PINCTRL_CONF_DESC(45, REG_GPIO_H_E2, BIT(0)),
> +	PINCTRL_CONF_DESC(46, REG_GPIO_H_E2, BIT(1)),
> +	PINCTRL_CONF_DESC(47, REG_GPIO_H_E2, BIT(2)),
> +	PINCTRL_CONF_DESC(48, REG_GPIO_H_E2, BIT(3)),
> +	PINCTRL_CONF_DESC(49, REG_GPIO_H_E2, BIT(4)),
> +	PINCTRL_CONF_DESC(50, REG_GPIO_H_E2, BIT(5)),
> +	PINCTRL_CONF_DESC(51, REG_GPIO_H_E2, BIT(6)),
> +	PINCTRL_CONF_DESC(52, REG_GPIO_H_E2, BIT(7)),
> +	PINCTRL_CONF_DESC(53, REG_GPIO_H_E2, BIT(8)),
> +	PINCTRL_CONF_DESC(54, REG_GPIO_H_E2, BIT(9)),
> +	PINCTRL_CONF_DESC(55, REG_GPIO_H_E2, BIT(10)),
> +	PINCTRL_CONF_DESC(56, REG_GPIO_H_E2, BIT(11)),
> +	PINCTRL_CONF_DESC(57, REG_GPIO_H_E2, BIT(12)),
> +	PINCTRL_CONF_DESC(58, REG_GPIO_H_E2, BIT(13)),
> +	PINCTRL_CONF_DESC(59, REG_GPIO_H_E2, BIT(14)),
> +	PINCTRL_CONF_DESC(61, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
> +	PINCTRL_CONF_DESC(62, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
> +	PINCTRL_CONF_DESC(63, REG_I2C_SDA_E2, PCIE2_RESET_E2_MASK),
> +};
> +
> +static const struct airoha_pinctrl_conf en7581_pinctrl_drive_e4_conf[] = {
> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E4, UART1_TXD_E4_MASK),
> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E4, UART1_RXD_E4_MASK),
> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E4, SPI_CS0_E4_MASK),
> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E4, SPI_CLK_E4_MASK),
> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E4, SPI_MOSI_E4_MASK),
> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E4, SPI_MISO_E4_MASK),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(0)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(1)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(2)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(3)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(4)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(5)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(6)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(7)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(8)),
> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(9)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(10)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(11)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(12)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_E4, BIT(13)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_E4, BIT(14)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_E4, BIT(15)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_E4, BIT(16)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_E4, BIT(17)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_E4, BIT(18)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_E4, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_E4, BIT(20)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_E4, BIT(21)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_E4, BIT(22)),
> +	PINCTRL_CONF_DESC(36, REG_GPIO_L_E4, BIT(23)),
> +	PINCTRL_CONF_DESC(37, REG_GPIO_L_E4, BIT(24)),
> +	PINCTRL_CONF_DESC(38, REG_GPIO_L_E4, BIT(25)),
> +	PINCTRL_CONF_DESC(39, REG_GPIO_L_E4, BIT(26)),
> +	PINCTRL_CONF_DESC(40, REG_GPIO_L_E4, BIT(27)),
> +	PINCTRL_CONF_DESC(41, REG_GPIO_L_E4, BIT(28)),
> +	PINCTRL_CONF_DESC(42, REG_GPIO_L_E4, BIT(29)),
> +	PINCTRL_CONF_DESC(43, REG_GPIO_L_E4, BIT(30)),
> +	PINCTRL_CONF_DESC(44, REG_GPIO_L_E4, BIT(31)),
> +	PINCTRL_CONF_DESC(45, REG_GPIO_H_E4, BIT(0)),
> +	PINCTRL_CONF_DESC(46, REG_GPIO_H_E4, BIT(1)),
> +	PINCTRL_CONF_DESC(47, REG_GPIO_H_E4, BIT(2)),
> +	PINCTRL_CONF_DESC(48, REG_GPIO_H_E4, BIT(3)),
> +	PINCTRL_CONF_DESC(49, REG_GPIO_H_E4, BIT(4)),
> +	PINCTRL_CONF_DESC(50, REG_GPIO_H_E4, BIT(5)),
> +	PINCTRL_CONF_DESC(51, REG_GPIO_H_E4, BIT(6)),
> +	PINCTRL_CONF_DESC(52, REG_GPIO_H_E4, BIT(7)),
> +	PINCTRL_CONF_DESC(53, REG_GPIO_H_E4, BIT(8)),
> +	PINCTRL_CONF_DESC(54, REG_GPIO_H_E4, BIT(9)),
> +	PINCTRL_CONF_DESC(55, REG_GPIO_H_E4, BIT(10)),
> +	PINCTRL_CONF_DESC(56, REG_GPIO_H_E4, BIT(11)),
> +	PINCTRL_CONF_DESC(57, REG_GPIO_H_E4, BIT(12)),
> +	PINCTRL_CONF_DESC(58, REG_GPIO_H_E4, BIT(13)),
> +	PINCTRL_CONF_DESC(59, REG_GPIO_H_E4, BIT(14)),
> +	PINCTRL_CONF_DESC(61, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
> +	PINCTRL_CONF_DESC(62, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
> +	PINCTRL_CONF_DESC(63, REG_I2C_SDA_E4, PCIE2_RESET_E4_MASK),
> +};
> +

...

> +static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio43", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
> +};

Should these be LANX_PHY_LED_MAP(3) instead of 2?

> +static const struct airoha_pinctrl_conf en7581_pinctrl_pullup_conf[] = {
> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PU, SPI_MISO_PU_MASK),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(0)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(1)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(2)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(3)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(4)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(5)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(6)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(7)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(8)),
> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(9)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(10)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(11)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(12)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(13)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(14)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_PU, BIT(15)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_PU, BIT(16)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_PU, BIT(17)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_PU, BIT(18)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_PU, BIT(20)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_PU, BIT(21)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_PU, BIT(22)),
> +	PINCTRL_CONF_DESC(36, REG_GPIO_L_PU, BIT(23)),
> +	PINCTRL_CONF_DESC(37, REG_GPIO_L_PU, BIT(24)),
> +	PINCTRL_CONF_DESC(38, REG_GPIO_L_PU, BIT(25)),
> +	PINCTRL_CONF_DESC(39, REG_GPIO_L_PU, BIT(26)),
> +	PINCTRL_CONF_DESC(40, REG_GPIO_L_PU, BIT(27)),
> +	PINCTRL_CONF_DESC(41, REG_GPIO_L_PU, BIT(28)),
> +	PINCTRL_CONF_DESC(42, REG_GPIO_L_PU, BIT(29)),
> +	PINCTRL_CONF_DESC(43, REG_GPIO_L_PU, BIT(30)),
> +	PINCTRL_CONF_DESC(44, REG_GPIO_L_PU, BIT(31)),
> +	PINCTRL_CONF_DESC(45, REG_GPIO_H_PU, BIT(0)),
> +	PINCTRL_CONF_DESC(46, REG_GPIO_H_PU, BIT(1)),
> +	PINCTRL_CONF_DESC(47, REG_GPIO_H_PU, BIT(2)),
> +	PINCTRL_CONF_DESC(48, REG_GPIO_H_PU, BIT(3)),
> +	PINCTRL_CONF_DESC(49, REG_GPIO_H_PU, BIT(4)),
> +	PINCTRL_CONF_DESC(50, REG_GPIO_H_PU, BIT(5)),
> +	PINCTRL_CONF_DESC(51, REG_GPIO_H_PU, BIT(6)),
> +	PINCTRL_CONF_DESC(52, REG_GPIO_H_PU, BIT(7)),
> +	PINCTRL_CONF_DESC(53, REG_GPIO_H_PU, BIT(8)),
> +	PINCTRL_CONF_DESC(54, REG_GPIO_H_PU, BIT(9)),
> +	PINCTRL_CONF_DESC(55, REG_GPIO_H_PU, BIT(10)),
> +	PINCTRL_CONF_DESC(56, REG_GPIO_H_PU, BIT(11)),
> +	PINCTRL_CONF_DESC(57, REG_GPIO_H_PU, BIT(12)),
> +	PINCTRL_CONF_DESC(58, REG_GPIO_H_PU, BIT(13)),
> +	PINCTRL_CONF_DESC(59, REG_GPIO_H_PU, BIT(14)),
> +	PINCTRL_CONF_DESC(61, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
> +	PINCTRL_CONF_DESC(62, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
> +	PINCTRL_CONF_DESC(63, REG_I2C_SDA_PU, PCIE2_RESET_PU_MASK),
> +};
> +
> +static const struct airoha_pinctrl_conf en7581_pinctrl_pulldown_conf[] = {
> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PD, SPI_MISO_PD_MASK),
> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(0)),
> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(1)),
> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(2)),
> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(3)),
> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(4)),
> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(5)),
> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(6)),
> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(7)),
> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(8)),
> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(9)),
> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(10)),
> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(11)),
> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(12)),
> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(13)),
> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(14)),
> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_PD, BIT(15)),
> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_PD, BIT(16)),
> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_PD, BIT(17)),
> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_PD, BIT(18)),
> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(18)),

Is this supposed to be BIT(19)?

> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_PD, BIT(20)),
> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_PD, BIT(21)),
> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_PD, BIT(22)),


...

> +U_BOOT_DRIVER(airoha_pinctrl) = {

We are aiming to be able to compile all drivers at the same time for static
analysis, so include an7581 in the driver identifier (airoha_an7581_pinctrl).

> +	.name = "airoha-an7581-pinctrl",
> +	.id = UCLASS_PINCTRL,
> +	.of_match = of_match_ptr(airoha_pinctrl_of_match),
> +	.probe = airoha_pinctrl_probe,
> +	.bind = airoha_pinctrl_bind,
> +	.priv_auto = sizeof(struct airoha_pinctrl),
> +	.ops = &airoha_pinctrl_ops,
> +};

