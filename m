Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3D9F5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71A4843D1;
	Mon, 20 Apr 2026 21:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wxBYndP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48154843D1; Mon, 20 Apr 2026 21:54:29 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE87843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4779b2497b4so2051271b6e.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776714865; x=1777319665;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7r5WOeRAyQvorcxqTHtGfwthmVIA5cwJmgJdbvK8MkA=;
 b=wxBYndP0tXT1OAUjz9/F6/B+s0sOfngpv7W2Nu+r1y+gt524xW8wcEhOKKdpMYA99b
 3kWYrW7kqMZeOprrjATnhjdPcd7DWLVe2w7lVme/DuTHFEMGv11sZWYSXEuS7RCcm6N0
 5sZU/jtzyN5bd5LzJ+aB7nxzSNOrqRI5pDWGGrcJa7Z1IuVYA8cIpDXp2bJvPjCyP0Pk
 4rIihrQSOT0KMRd5zAvduaWYcEhgyyihEaI5UGP8I5XWLRSrRv/IC932NFvU0ohvlHsz
 UkjdMoJR+G5ZhsCXLPnTQEkhM/pKWBfGChH4B53Qja8PGLEivSH5GZ2RVtVPBtX9f3kJ
 jbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714865; x=1777319665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7r5WOeRAyQvorcxqTHtGfwthmVIA5cwJmgJdbvK8MkA=;
 b=HuXEmmSvgP3OftfqRVXbF35XQvO0wgMifGtzryL4KzmQxncOiJQb5GIti5kN/PHyda
 VjCTlXL+rRZ/UBOjr7d+7dJ4pGIcD8UqKdTqQ+Y0jqXeIsQTf4JGhOuEGw3llxFsHi7G
 1iC6p/7hERGcXr8LS2gcFvA/FaScR2XWiw5ZqjITtAnMW/kx9SC0j4l6OVAH7/BZ09bX
 SCfY4NbZ1FhU4IceR70chDVBFQ+blpndG0VVExXkzjoYPru6kchIRVKForvqstrR8nj5
 5Fgp5rfk9JlsC2wEb/1ZJsUoXbENLSA5iASQmWYXBVEnfvXco1so00lsgJIM79c7qBN8
 na6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yAjJKit8MxkJ4C5/R9/UoyFE6xigGW3CJ2h60K+aV7JlohCCkrp6TUmGGPmwVGyn9Ev+X5vs=@lists.denx.de
X-Gm-Message-State: AOJu0YyCr7gfDWztSPrLqmkY695Yfh2bRPw0QgQ6JiRoQ6mAx13Lou/6
 Jwn60+eRbYUe6U7GCFBJcPGD+LRcRG36+N2hdgXnUXTCamNVlQ+V7AuCBajvwdqKs7U=
X-Gm-Gg: AeBDiesOnoS3FfoPBFkuhoxJ0XM8AuIy59I+FFlBxXCqG4JwHBbfPeULCLXOHn1elG1
 cDLLZYKSecPOYoUeT4rQiDRJJ8o6Get+2AibzQIsPtODzVtAAqIq+Kr1Haz2JGJrXU1TwLWTK87
 iFazbLpaoaQLlyrWwFwYNE++p/pG7j1BS1LhrPN7poX+VLNTXWjxx85fuOq2Ku9W+vDtO5pz6ZS
 a26rG2eYLXPiSr9qtvc5ND0IVQDIzxnYGboHN1wZHyeyrrAFPTwZN2T7qFumjMhj470B9jmtgnX
 EjHb8FmziUA+TKGyyG5RQ5Lf51HaxEkWUjrR6T7OpcJGFCMK+LCx3sfSqHwOBZpLXTq8JqaXQSJ
 h+C9Du49qOdkE3gzfJkMUOXsHy4fO7ciWpHKyXhPQCERfyMJMkj426+0W4iIKFTaupOtVLTpx2f
 3Qeq6iOXLUULGPsu92A3Oe6nF5HTjwB5Hm24436TL8GPvJPW2HsElssknWp3a54spNMCDo4NLkE
 gKgKXONxdGn
X-Received: by 2002:a05:6808:f06:b0:467:1462:a9a0 with SMTP id
 5614622812f47-4799c8f26e1mr9843061b6e.15.1776714865107; 
 Mon, 20 Apr 2026 12:54:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:49fb:b337:a968:94e7?
 ([2600:8803:e7e4:500:49fb:b337:a968:94e7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-479a016b7f7sm7635181b6e.10.2026.04.20.12.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 12:54:23 -0700 (PDT)
Message-ID: <1f8ca89f-0740-4ac6-bd18-4cb376518ddd@baylibre.com>
Date: Mon, 20 Apr 2026 14:54:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: mediatek: add airoha an7581/an7583 pinctrl driver
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>
References: <20260420172158.838063-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260420172158.838063-1-mikhail.kshevetskiy@iopsys.eu>
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

On 4/20/26 12:21 PM, Mikhail Kshevetskiy wrote:
> The patch adds pinctrl and gpio drivers for an7581/an7583 SoCs.
> The code is based on linux airoha pinctrl driver.
> 
> There are several '#if 0' .. '#endif' in the code. This was done

IMHO, `#if 0` is just noise and we should delete it.

> to make it easier to compare Linux and U-Boot pinctrl drivers.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/pinctrl/mediatek/Kconfig          |   22 +-
>  drivers/pinctrl/mediatek/Makefile         |    3 +
>  drivers/pinctrl/mediatek/pinctrl-airoha.c | 3297 +++++++++++++++++++++

Wowsers! This is a lot of code for one file, let alone one patch. hopefully
we can split it up. For example, move the SoC-specific tables to separate
files.

>  drivers/pinctrl/mediatek/pinctrl-airoha.h |   84 +
>  4 files changed, 3405 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-airoha.c
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-airoha.h
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 8a588d17c4b..1ee44ff16d7 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -1,4 +1,4 @@
> -if ARCH_MEDIATEK
> +if ARCH_MEDIATEK || ARCH_AIROHA

Why does this need to be mixed in with MediaTek? It doesn't look like
they actually share any code here.

>  
>  config PINCTRL_MTK
>  	depends on PINCTRL_GENERIC
> @@ -6,6 +6,26 @@ config PINCTRL_MTK
>  	select SYSCON
>  	bool
>  
> +endif
> +
> +if ARCH_AIROHA
> +
> +config PINCTRL_AIROHA
> +	bool "Airoha an7581/an7583 SoC pinctrl driver"

As above, to keep binary size down, it would be better to have each platform
individually enabled.

> +	select PINCTRL_MTK
> +	select PINCTRL_FULL
> +	select PINMUX
> +	select PINCONF
> +	help
> +	  Say yes here to support pin control on the Airoha SoC.
> +	  This also provides an interface to the GPIO pins not used by other
> +	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
> +	  and interrupts on input changes.
> +
> +endif
> +
> +if ARCH_MEDIATEK
> +
>  config PINCTRL_MT7622
>  	bool "MT7622 SoC pinctrl driver"
>  	select PINCTRL_MTK
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
> index b9116c073ea..e3f245bb9d1 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -1,8 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Core
> +ifneq (CONFIG_ARCH_MEDIATEK,)

As above, I don't think this needs to be in the mediatek folder.
If it really does though, I don't think we need the ifneq here
since obj-$(CONFIG_PINCTRL_MTK) should already do the right thing.

>  obj-$(CONFIG_PINCTRL_MTK) += pinctrl-mtk-common.o
> +endif
>  
>  # SoC Drivers
> +obj-$(CONFIG_PINCTRL_AIROHA) += pinctrl-airoha.o
>  obj-$(CONFIG_PINCTRL_MT7622) += pinctrl-mt7622.o
>  obj-$(CONFIG_PINCTRL_MT7623) += pinctrl-mt7623.o
>  obj-$(CONFIG_PINCTRL_MT7629) += pinctrl-mt7629.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-airoha.c b/drivers/pinctrl/mediatek/pinctrl-airoha.c
> new file mode 100644
> index 00000000000..0bce5bf97dc
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-airoha.c
> @@ -0,0 +1,3297 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + * Author: Markus Gothe <markus.gothe@genexis.eu>
> + *
> + * Adapted for U-Boot by Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <config.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/devres.h>
> +#include <dm/lists.h>
> +#include <dm/pinctrl.h>
> +#include <dm/root.h>
> +#include <errno.h>
> +#include <asm/io.h>
> +#include <asm-generic/gpio.h>
> +
> +#include <dt-bindings/pinctrl/mt65xx.h>
> +#include <linux/bitfield.h>
> +#include <syscon.h>
> +#include <regmap.h>
> +#include <asm/arch/scu-regmap.h>
> +
> +#include "pinctrl-airoha.h"
> +
> +#define PINCTRL_GET_STATE

It seems like all of these names that start with PINCTRL_ would have a high
chance of conflicting with generic pinctrl stuff in the future. I suggest
to add AIROHA_ or airoha_ prefix to all identifiers to avoid this. 

> +
> +#define PINCTRL_PIN_GROUP(id, table)					\
> +	PINCTRL_PINGROUP(id, table##_pins, ARRAY_SIZE(table##_pins))
> +
> +#define PINCTRL_FUNC_DESC(id, table)					\
> +	{								\
> +		.desc = PINCTRL_PINFUNCTION(id, table##_groups,		\
> +					    ARRAY_SIZE(table##_groups)),\
> +		.groups = table##_func_group,				\
> +		.group_size = ARRAY_SIZE(table##_func_group),		\
> +	}
> +
> +#define PINCTRL_CONF_DESC(p, offset, mask)				\
> +	{								\
> +		.pin = p,						\
> +		.reg = { offset, mask },				\
> +	}
> +

...

> diff --git a/drivers/pinctrl/mediatek/pinctrl-airoha.h b/drivers/pinctrl/mediatek/pinctrl-airoha.h
> new file mode 100644
> index 00000000000..972a4fb171e
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-airoha.h
> @@ -0,0 +1,84 @@

If we split this up and things defined in this file are used in multiple files,
then keeping this header is fine. If there is anything that is used in just one
file though, I would move it to that .c file.

> +/**
> + * struct pinfunction - Description about a function
> + * @name: Name of the function
> + * @groups: An array of groups for this function
> + * @ngroups: Number of groups in @groups
> + * @flags: Additional pin function flags
> + */
> +struct pinfunction {
> +	const char *name;
> +	const char * const *groups;
> +	size_t ngroups;
> +};

As above, everything in this file should have a airoha_ or AIROHA_
namespace prefix.

> +
> +/* Convenience macro to define a single named pinfunction */
> +#define PINCTRL_PINFUNCTION(_name, _groups, _ngroups)	\
> +(struct pinfunction) {					\
> +		.name = (_name),			\
> +		.groups = (_groups),			\
> +		.ngroups = (_ngroups),			\
> +	}
> +
> +/**
> + * struct pingroup - provides information on pingroup
> + * @name: a name for pingroup
> + * @pins: an array of pins in the pingroup
> + * @npins: number of pins in the pingroup
> + */
> +struct pingroup {
> +	const char *name;
> +	const unsigned int *pins;
> +	size_t npins;
> +};
> +
> +/* Convenience macro to define a single named or anonymous pingroup */
> +#define PINCTRL_PINGROUP(_name, _pins, _npins)	\
> +(struct pingroup) {				\
> +	.name = _name,				\
> +	.pins = _pins,				\
> +	.npins = _npins,			\
> +}
> +
> +/**
> + * struct pinctrl_pin_desc - boards/machines provide information on their
> + * pins, pads or other muxable units in this struct
> + * @number: unique pin number from the global pin number space
> + * @name: a name for this pin
> + * @drv_data: driver-defined per-pin data. pinctrl core does not touch this
> + */
> +struct pinctrl_pin_desc {
> +	unsigned int number;
> +	const char *name;
> +	void *drv_data;
> +};
> +
> +/* Convenience macro to define a single named or anonymous pin descriptor */
> +#define PINCTRL_PIN(a, b) { .number = a, .name = b }
> +
> +/*
> + * Helpful configuration macro to be used in tables etc.
> + */
> +#define PIN_CONF_PACKED(p, a) ((a << 8) | ((unsigned long) p & 0xffUL))
> +
> +/*
> + * The following inlines stuffs a configuration parameter and data value
> + * into and out of an unsigned long argument, as used by the generic pin config
> + * system. We put the parameter in the lower 8 bits and the argument in the
> + * upper 24 bits.
> + */
> +
> +static inline enum pin_config_param pinconf_to_config_param(unsigned long config)
> +{
> +	return (enum pin_config_param) (config & 0xffUL);
> +}
> +
> +static inline u32 pinconf_to_config_argument(unsigned long config)
> +{
> +	return (u32) ((config >> 8) & 0xffffffUL);
> +}
> +
> +static inline unsigned long pinconf_to_config_packed(enum pin_config_param param,
> +			     u32 argument)
> +{
> +	return PIN_CONF_PACKED(param, argument);
> +}

If some of these are meant to be generic functions or macros used by any driver,
then they should be moved to a more generic header file.


