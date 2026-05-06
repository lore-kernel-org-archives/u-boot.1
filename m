Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDBBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 22:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7308F849C9;
	Thu,  7 May 2026 00:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="nguQ+593";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BB3849DF; Thu,  7 May 2026 00:31:09 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F6784970
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 00:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-409de4132b5so83435fac.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778106665; x=1778711465;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c+pUI2gBc51X92kibaebYCiMDaSRGA5FaqnhtEfGlbA=;
 b=nguQ+593/4Byumxc+HwNGAd0foEl0bmM1efH7/UTyq4+2yb3Nh41gsiEJ1W/T5zYD0
 hL2YLMiE2cd9WSEt8jv7UF+mv4EWVSo1ky7AxL4UP3eBosgkl7fG+9pVC4zpoLYU51FQ
 w4qrRO+dDoYrPqwDDiV4r1xWif5y1AY6eI9741g73FGfV5qWeTPRC6a5lrMJAwY78BsQ
 7nIZ2YhlmOiyk1phtghTMMvBMzE9td9xgPu8uORwlpTQDN1r31lxoxnFn4E/DNSq72Ai
 TShk9KHV1126zIcy1ADx74HibEr2xNAeYblBvv0yw85jNdSzZVP/wPBPvKRpFc/CT2XJ
 Rdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778106665; x=1778711465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c+pUI2gBc51X92kibaebYCiMDaSRGA5FaqnhtEfGlbA=;
 b=Dd1gOnUyyLONshbMKC1Gyi+5J5izzm9qLg39JGqH51jgbFOOzubZXhqmT4g7lUtqWl
 WbwPYJGO3uhQ9G15PigRkqQL4I/aNjFkygnvsc6JaA/N8fn98SYcbpIPntUKuwgvYT/q
 2hnDsW5qGdLbM0vpKFbx7ixNzKsaAUZhwSAyxnZ3YeslpIo8Re6n0oCIuMRMJMNVJXYY
 4el22CdAKwuwYf9L75kYhowEKY1wyDjK8ndem4NF67QoFzhSYTfZe6ioa1HsecXk3N+W
 +ikFbgXeKYfiQ+hEj3H1MF3fmZxmiHPHL6Z5b2DWCrg4Gl1M7miQY1mCgU/J2R/96R0s
 u4oQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GNrII669tRmpyqK5bhA/qlB5ioCNxQWhHtYbxicfhcMQ/pUPbapyvP40zDqpEQbaCHwkEp/U=@lists.denx.de
X-Gm-Message-State: AOJu0YzYimZdxZHKGEqhrVNIryUY6+S3nFVPwDmtah81HR6iuGUMzx1l
 hrjtbz7iUQCvEIWakOqSXMtuQzC76b40CzZRXnxuJDhQ7y1D1m/Y+oY+CbW5LWsu658=
X-Gm-Gg: AeBDieudsxAaNqrDaWC8B11uulov/tfoGjgWIs+0oqnrQeOMg29jgZltsrodAnEM9gf
 PyTFQH6wEIGJGFKBbBC5AmemV62lP1MMaGoB48iMwCky7MGTsEWjg7MEGAqyArOhYFYTOG7ruNo
 Q59vw/mZPATpCco1QSljSQeq8R9iIei1IhU+RSoeYMYNdlpBYe4OmFOKT+emNRU7Tow/X103AMa
 XwV+Z2SNjOFBYRFZTTic2WEbb4XCN/GEvNRL7JRrbHgiBfnUZVrGSRrmKvJ1p+HTknLulrw6iMu
 zB3k+rZqHrK0zpSZWyKtm2tMrUVX8tF1FmEoniV0tAH4CwvcqQMY7+sQA1BCAjNSaYuCtHWlKis
 pf4f7nGn32H0mKayfWj6b8Jeo5uIr4yqqLAvU5UH5e1803nhTzY3slMp21AOmjZVZKnzQWzBP1z
 HlUzv5hJvpIWMZp406SK73l8p1d++HKaDx1a3ubbONCTH7Vd9YJp1raS3ko2TMhQ7OoNWhMyF6z
 2f59Ot42wxG
X-Received: by 2002:a05:6870:9d10:b0:42c:1d80:2ca2 with SMTP id
 586e51a60fabf-434f663cf8dmr3600193fac.38.1778106665118; 
 Wed, 06 May 2026 15:31:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7374:f02e:e8be:88a5?
 ([2600:8803:e7e4:500:7374:f02e:e8be:88a5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbbbd7sm16754043fac.10.2026.05.06.15.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 15:31:04 -0700 (PDT)
Message-ID: <a12b78a1-fc6f-4306-bd7b-40d6f8e6c55b@baylibre.com>
Date: Wed, 6 May 2026 17:31:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pinctrl: airoha: add shared pinctrl code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Sean Anderson <sean.anderson@linux.dev>,
 Yao Zi <me@ziyao.cc>, Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
 <20260504130306.2764862-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260504130306.2764862-4-mikhail.kshevetskiy@iopsys.eu>
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

On 5/4/26 8:03 AM, Mikhail Kshevetskiy wrote:
> This patch introduce shared Airoha pinctrl code.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/pinctrl/Kconfig                 |   1 +
>  drivers/pinctrl/Makefile                |   1 +
>  drivers/pinctrl/airoha/Kconfig          |  11 +
>  drivers/pinctrl/airoha/Makefile         |   3 +
>  drivers/pinctrl/airoha/airoha-common.h  | 512 ++++++++++++++
>  drivers/pinctrl/airoha/pinctrl-airoha.c | 843 ++++++++++++++++++++++++
>  6 files changed, 1371 insertions(+)
>  create mode 100644 drivers/pinctrl/airoha/Kconfig
>  create mode 100644 drivers/pinctrl/airoha/Makefile
>  create mode 100644 drivers/pinctrl/airoha/airoha-common.h
>  create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c

I don't remember if I asked before...

Should we add a MAINTAINERS entry for this new directory?

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

I still think this could be better placed. It looks like there is
at leaset some attempt to put these in alphabetical order.

>  obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
>  obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
>  obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
> new file mode 100644
> index 00000000000..eb87afbb374
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/Kconfig
> @@ -0,0 +1,11 @@
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
> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
> new file mode 100644
> index 00000000000..a25b744dd7a
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
> diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
> new file mode 100644
> index 00000000000..af4964bf25d
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/airoha-common.h
> @@ -0,0 +1,512 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __AIROHA_COMMON_HEADER__
> +#define __AIROHA_COMMON_HEADER__
> +

...

> +static const u32 gpio_data_regs[] = {
> +	REG_GPIO_DATA,
> +	REG_GPIO_DATA1
> +};
> +
> +static const u32 gpio_out_regs[] = {
> +	REG_GPIO_OE,
> +	REG_GPIO_OE1
> +};
> +
> +static const u32 gpio_dir_regs[] = {
> +	REG_GPIO_CTRL,
> +	REG_GPIO_CTRL1,
> +	REG_GPIO_CTRL2,
> +	REG_GPIO_CTRL3
> +};
> +
> +static const u32 irq_status_regs[] = {
> +	REG_GPIO_INT,
> +	REG_GPIO_INT1
> +};
> +
> +static const u32 irq_level_regs[] = {
> +	REG_GPIO_INT_LEVEL,
> +	REG_GPIO_INT_LEVEL1,
> +	REG_GPIO_INT_LEVEL2,
> +	REG_GPIO_INT_LEVEL3
> +};
> +
> +static const u32 irq_edge_regs[] = {
> +	REG_GPIO_INT_EDGE,
> +	REG_GPIO_INT_EDGE1,
> +	REG_GPIO_INT_EDGE2,
> +	REG_GPIO_INT_EDGE3
> +};

Putting these arrays in the header isn't a good idea. Each compile
unit (C file) that includes this header will have them repeated. It
looks like they are only used in pinctrl-arioha.c anyway, so they
should should just be moved there.

> diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
> new file mode 100644
> index 00000000000..11830c44612
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
> @@ -0,0 +1,843 @@
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

Not sure I understand the organization of the includes
above. Why the blank line between regmap and syscon? Why
not everything in alphabetical order?

> +
> +#include "airoha-common.h"
> +
> +
> +static int pin_in_group(unsigned int pin, const struct pingroup *grp)
> +{
> +	for (int i = 0; i < grp->npins; i++) {
> +		if (grp->pins[i] == pin)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pin_to_gpio(struct airoha_pinctrl *pinctrl, unsigned int pin)
> +{
> +	struct airoha_pinctrl_match_data *data = pinctrl->data;
> +
> +	if ((pin < data->gpio_offs) ||
> +	    (pin > data->gpio_offs + data->gpio_pin_cnt))

Should this be >= for the upper bound check?

Also has unnecessary ().

> +		return -EINVAL;
> +
> +	return pin - data->gpio_offs;
> +}
> +



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

field_get()?

> +
> +	return 0;
> +}
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

field_prep()?

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int airoha_pinconf_get_direction(struct airoha_pinctrl *pinctrl, u32 p)
> +{
> +	int gpio;
> +
> +	gpio = pin_to_gpio(pinctrl, p);
> +	if (gpio < 0)
> +		return gpio;
> +
> +	return airoha_gpio_get_direction(pinctrl, gpio);
> +}
> +
> +static int airoha_pinconf_get(struct airoha_pinctrl *pinctrl,
> +			      unsigned int pin, unsigned long *config)
> +{
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	u32 arg;
> +
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +	case PIN_CONFIG_BIAS_DISABLE:
> +	case PIN_CONFIG_BIAS_PULL_UP: {
> +		u32 pull_up, pull_down;
> +
> +		if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_up) ||
> +		    airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pull_down))
> +			return -EINVAL;
> +
> +		if (param == PIN_CONFIG_BIAS_PULL_UP &&
> +		    !(pull_up && !pull_down))
> +			return -EINVAL;
> +		else if (param == PIN_CONFIG_BIAS_PULL_DOWN &&
> +			 !(pull_down && !pull_up))
> +			return -EINVAL;
> +		else if (pull_up || pull_down)
> +			return -EINVAL;
> +
> +		arg = 1;
> +		break;
> +	}
> +	case PIN_CONFIG_DRIVE_STRENGTH: {
> +		u32 e2, e4;
> +
> +		if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2) ||
> +		    airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
> +			return -EINVAL;
> +
> +		arg = e4 << 1 | e2;
> +		break;
> +	}
> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +		if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &arg))
> +			return -EINVAL;
> +		break;
> +	case PIN_CONFIG_OUTPUT_ENABLE:
> +	case PIN_CONFIG_INPUT_ENABLE:
> +		arg = airoha_pinconf_get_direction(pinctrl, pin);
> +		if (arg != param)

How does this work? It looks like airoha_pinconf_get_direction()
returns enum gpio_func_t or negative error code.

Should we check for error first before comparing?

Do we need some kind of conversion between enum gpio_func_t and
enum pin_config_param in airoha_pinconf_get_direction()?

> +			return -EINVAL;
> +
> +		arg = 1;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	*config = pinconf_to_config_packed(param, arg);
> +
> +	return 0;
> +}
> +
> +static int airoha_pinconf_set_pin_value(struct airoha_pinctrl *pinctrl,
> +					unsigned int p, bool value)
> +{
> +	int gpio;
> +
> +	gpio = pin_to_gpio(pinctrl, p);
> +	if (gpio < 0)
> +		return gpio;
> +
> +	return airoha_gpio_set(pinctrl, gpio, value);
> +}
> +
> +static int airoha_pinconf_set(struct airoha_pinctrl *pinctrl,
> +			      unsigned int pin, unsigned long *configs,
> +			      unsigned int num_configs)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		u32 param = pinconf_to_config_param(configs[i]);
> +		u32 arg = pinconf_to_config_argument(configs[i]);
> +

In all of the cases below, I would expect that we should be checking
the return value for error. Or add a comment on why it is safe to ignore
the return value if that is the case.

> +		switch (param) {
> +		case PIN_CONFIG_BIAS_DISABLE:
> +			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
> +			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
> +			break;
> +		case PIN_CONFIG_BIAS_PULL_UP:
> +			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
> +			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
> +			break;
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 1);
> +			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
> +			break;
> +		case PIN_CONFIG_DRIVE_STRENGTH: {
> +			u32 e2 = 0, e4 = 0;
> +
> +			switch (arg) {
> +			case MTK_DRIVE_2mA:
> +				break;
> +			case MTK_DRIVE_4mA:
> +				e2 = 1;
> +				break;
> +			case MTK_DRIVE_6mA:
> +				e4 = 1;
> +				break;
> +			case MTK_DRIVE_8mA:
> +				e2 = 1;
> +				e4 = 1;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, e2);
> +			airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, e4);
> +			break;
> +		}
> +		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +			airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, !!arg);
> +			break;
> +		case PIN_CONFIG_OUTPUT_ENABLE:
> +		case PIN_CONFIG_INPUT_ENABLE:
> +		case PIN_CONFIG_OUTPUT: {
> +			bool input = param == PIN_CONFIG_INPUT_ENABLE;
> +			int err;
> +
> +			err = airoha_pinmux_set_direction(pinctrl, pin, input);
> +			if (err)
> +				return err;
> +
> +			if (param == PIN_CONFIG_OUTPUT) {
> +				err = airoha_pinconf_set_pin_value(pinctrl,
> +								   pin, !!arg);
> +				if (err)
> +					return err;
> +			}
> +
> +			break;
> +		}
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +


> +/**************************
> + * pinctrl driver interface
> + **************************/
> +static int airoha_get_pins_count(struct udevice *dev)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +
> +	return pinctrl->data->num_pins;
> +}
> +
> +static const char *airoha_get_pin_name(struct udevice *dev, unsigned selector)

Inconsitent use of unsigned. Preferred is unsigned int. 

> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +
> +	return pinctrl->data->pins[selector].name;
> +}
> +


> +static int airoha_pinconf_set_handler(struct udevice *dev, unsigned pin_selector,
> +				      unsigned param, unsigned argument)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
> +	unsigned int pin = pinctrl->data->pins[pin_selector].number;
> +
> +	dev_dbg(dev, "enabling %s=%d property for pin %s\n",
> +		airoha_pinconf_params[param].property, argument,

This will result in out of bounds access. param is not the index but rather
a field in the struct in the array.

Easiset would be to just print numeric value of param, otherwise we need a
lookup function.

> +		airoha_get_pin_name(dev, pin_selector));
> +
> +	return airoha_pinconf_set(pinctrl, pin, configs,
> +				  ARRAY_SIZE(configs));
> +}
> +
> +static int airoha_pinconf_group_set_handler(struct udevice *dev, unsigned group_selector,
> +					    unsigned param, unsigned argument)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
> +
> +	dev_dbg(dev, "enabling %s=%d property for pin group %s\n",
> +		airoha_pinconf_params[param].property, argument,

ditto

> +		airoha_get_group_name(dev, group_selector));
> +
> +	return airoha_pinconf_group_set(pinctrl, group_selector,
> +					configs, ARRAY_SIZE(configs));
> +}
> +
> +static int airoha_get_pin_muxing(struct udevice *dev, unsigned int selector,
> +				 char *buf, int size)
> +{
> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
> +	struct airoha_pinctrl_match_data *data = pinctrl->data;
> +	const char *name, *type;
> +	int ret, gpio, found = 0;
> +	unsigned long config;
> +	unsigned int param, pin;
> +	u32 val;
> +
> +	pin = data->pins[selector].number;
> +	for (int i = 0; i < data->num_grps; i++) {
> +		if (!pin_in_group(pin, &data->grps[i]))
> +			continue;
> +
> +		name = data->grps[i].name;
> +		for (int j = 0; j < data->num_funcs; j++) {
> +			if (!func_grp_active(pinctrl, &data->funcs[j], name))
> +				continue;
> +
> +			ret = snprintf(buf, size, "%s(%s)",
> +				       data->funcs[j].desc.name, name);

Should use scnprintf(). snprintf() returns the number that would have been
written, which can be larger than number actually written.

Same applies elsewhere in this patch.

