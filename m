Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60DAEC875E
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 01:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EE58648D;
	Fri,  8 Sep 2023 03:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUQ3B4Yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CACB86682; Fri,  8 Sep 2023 03:33:27 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95598645F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 03:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-64a5bc53646so9020906d6.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694136803; x=1694741603; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWFOCqAfCXuz02WoQUvtEl78epMDWU+SOEZpnmb3gos=;
 b=OUQ3B4YnrVT6oYMBu5TiUhFbP23KsSRBkufsI8ib9kFXjNCODveauZzN1TxjqjBZFw
 KcyeXdKbZZIgCNmF3kHu+gjG2BsLZciSL+0IlcXd+RIRWaddsjDSyygGq8vJnL/J1RSy
 2rY56GxqUlPoAjXfmV7M6SGpgGc1WcFjUHku+BvqkNukDzC20RrHqOmKWcCGwAJIJl7P
 bC8KUlXMIKlFgQ7jVyUC/ff69GHJO67P8/mDtp4MZFiU0cGO5tQLY6ekN47JkB7n/Lb6
 TtiBbefIQZRLJici9W1tcZ8uD/UIhLVCTuPMERmrPu4itqQHtCZUlw5cBr0MwDsHaW1K
 f3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694136803; x=1694741603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWFOCqAfCXuz02WoQUvtEl78epMDWU+SOEZpnmb3gos=;
 b=F8szMWN3Wz65MUViivZoI5q3eYlbpgOsgxaOoBDO7C8Qt0S7JlSGBE7WxGKsLH9paj
 nLKCiKP8vS1HdHpZXe3U4UfeQPBcFD/injrLxlY2lBh6vCwaEiY4c3PLnoVYlBRUpmBg
 GkI4SbLBt8mb3mQXkfDBcfftr+qK5LIhjYg41iGA807nysmVkJYSUjA+S0IShXVLo0eR
 QMrgBSkzAUPIqycKSSzlB5cWs/d7CoUTQEAxtz+qD7P5uItEcZjngQiuzgtm9bzsPwwl
 Lxd5fB6G5nIMpZwp2v+DhVOWOnN2FsZWUzU8+ZpTJyN0vRHp/zvQwfob7c7BPQJuxZcw
 swfg==
X-Gm-Message-State: AOJu0YzCQKtO7GhLdoHCNFdeyUIrJT4OqvA8n2x25LFc5i28SVRaQwgC
 KjXAaYFOWORKCYpjgoGj67s=
X-Google-Smtp-Source: AGHT+IEGifaKCOksQ/pn/Hhqkeg+tq9Fwxl/Wrnp9QPUN4QKYJOQVIv4A1hDmzmasixF8de5Gt+mUQ==
X-Received: by 2002:a0c:dc06:0:b0:64f:77d3:779e with SMTP id
 s6-20020a0cdc06000000b0064f77d3779emr1061303qvk.3.1694136803392; 
 Thu, 07 Sep 2023 18:33:23 -0700 (PDT)
Received: from [192.168.1.201] (pool-173-73-95-180.washdc.fios.verizon.net.
 [173.73.95.180]) by smtp.gmail.com with ESMTPSA id
 u18-20020a0cf1d2000000b0064f725828f3sm267575qvl.35.2023.09.07.18.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 18:33:23 -0700 (PDT)
Message-ID: <40808cb6-6feb-3127-dbab-6102cde14d11@gmail.com>
Date: Thu, 7 Sep 2023 21:33:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: Add GPIO-controlled clock gate driver
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
References: <20230813235127.591432-1-marek.vasut+renesas@mailbox.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230813235127.591432-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/13/23 19:51, Marek Vasut wrote:
> Add driver which implements GPIO-controlled clock. The GPIO is used
> as a gate to enable/disable the clock. This matches linux clk-gpio.c
> driver, however this does not implement the GPIO mux part, which in
> U-Boot DM would be better fit in separate driver.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>   drivers/clk/Kconfig    | 13 +++++++++
>   drivers/clk/Makefile   |  1 +
>   drivers/clk/clk-gpio.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 80 insertions(+)
>   create mode 100644 drivers/clk/clk-gpio.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 29859cdfa15..bfd23a99046 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -83,6 +83,19 @@ config CLK_COMPOSITE_CCF
>   	  Enable this option if you want to (re-)use the Linux kernel's Common
>   	  Clock Framework [CCF] composite code in U-Boot's clock driver.
>   
> +config CLK_GPIO
> +	bool "GPIO-controlled clock gate driver"
> +	depends on CLK
> +	help
> +	  Enable this option to add GPIO-controlled clock gate driver.
> +
> +config SPL_CLK_GPIO
> +	bool "GPIO-controlled clock gate driver in SPL"
> +	depends on SPL_CLK
> +	help
> +	  Enable this option to add GPIO-controlled clock gate driver
> +	  in U-Boot SPL.
> +
>   config CLK_BCM6345
>   	bool "Clock controller driver for BCM6345"
>   	depends on CLK && ARCH_BMIPS
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e22c8cf291f..26bf429acbc 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_factor.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-fixed-factor.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_COMPOSITE_CCF) += clk-composite.o
> +obj-$(CONFIG_$(SPL_TPL_)CLK_GPIO) += clk-gpio.o
>   
>   obj-y += analogbits/
>   obj-y += imx/
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> new file mode 100644
> index 00000000000..26d795b9783
> --- /dev/null
> +++ b/drivers/clk/clk-gpio.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
> + */
> +
> +#include <asm/gpio.h>
> +#include <common.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +
> +struct clk_gpio_priv {
> +	struct gpio_desc	enable;
> +};
> +
> +static int clk_gpio_enable(struct clk *clk)
> +{
> +	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
> +
> +	dm_gpio_set_value(&priv->enable, 1);
> +
> +	return 0;
> +}
> +
> +static int clk_gpio_disable(struct clk *clk)
> +{
> +	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
> +
> +	dm_gpio_set_value(&priv->enable, 0);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops clk_gpio_ops = {
> +	.enable		= clk_gpio_enable,
> +	.disable	= clk_gpio_disable,
> +};
> +
> +static int clk_gpio_probe(struct udevice *dev)
> +{
> +	struct clk_gpio_priv *priv = dev_get_priv(dev);
> +
> +	return gpio_request_by_name(dev, "enable-gpios", 0,
> +				    &priv->enable, GPIOD_IS_OUT);
> +}
> +
> +/*
> + * When implementing clk-mux-clock, use gpio_request_list_by_name
> + * and implement get_rate/set_rate/set_parent ops. This should be
> + * in a separate driver and with separate Kconfig option to enable
> + * that driver, since unlike Linux implementation, the U-Boot DM
> + * integration would be orthogonal to this driver.
> + */
> +static const struct udevice_id clk_gpio_match[] = {
> +	{ .compatible = "gpio-gate-clock" },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(gpio_gate_clock) = {
> +	.name		= "gpio_clock",
> +	.id		= UCLASS_CLK,
> +	.of_match	= clk_gpio_match,
> +	.probe		= clk_gpio_probe,
> +	.priv_auto	= sizeof(struct clk_gpio_priv),
> +	.ops		= &clk_gpio_ops,
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};

Reviewed-by: Sean Anderson <seanga2@gmail.com>
