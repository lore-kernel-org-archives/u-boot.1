Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5486CC4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 10:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42F286FB0;
	Tue, 16 Jan 2024 11:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lb9mnZCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA00A87716; Tue, 16 Jan 2024 11:22:45 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B644086FB0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 11:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e760e5b49so20549025e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705400563; x=1706005363;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YR1BxCWrBiZpXH//iGfuVCqYt979CoT5/OA3Hwg6cW0=;
 b=lb9mnZCp65vWv4tIMZ1jpfvySb8yJ9ZmirRCnWqBbDElMZKhSyWBwaR6sMLLDLt9ZG
 1/qov9F4SDIjBCXE/HkInn+pH44Gs7w/sSNKo8Auc1LlsA1OZbmInx3PsvEel5ICJSWS
 tZhOfPwZ1/eHRWe0NP3pqe9p2V71BQU+uKpo+6stSasZ2ZuhIymxm5GkZboqiTB8YuJ4
 /pSjdVkP6G2Wk51nPadAkqxyrfpB59nMpnQI1hcJro2RTBJd4qgKNphUAjSR8KZXFWHC
 49ZDVO6SSNd+stePBb8ikscHAOiPKBVICS4IIcM9eeayTKPBi8MGo38AAqH33qVgIV+H
 U2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705400563; x=1706005363;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YR1BxCWrBiZpXH//iGfuVCqYt979CoT5/OA3Hwg6cW0=;
 b=tkBhuxvNiEVBQ9W7AFV1R+C4Y+RUwvAtRrnU+3IuWuQioCh+wDyc8guLag30hIZXPo
 I5rzVNLEpr5IwYwwCJiQrkvVUcdIO/UUDYTl0RKahLCjWY2emAZK0GH12/cMPPjjLCsq
 5y99BFMTBJUWsnWjiZeXbU2dySKaq0n9z27wTqfw70WjxgLi1F77q1NPK8VloOOICdEw
 oQOmhFUn0XB/wBN198qWIqYI7O0eCpQJ/h+2wGNtA9yF9aAb0iagOWlKQjcFO4N1G+4i
 ieJw5EKsn365sIWVKcHwSZZwzk49PLpfmu6R2jq4LP08E6MhAf7PaAZn/eKAnrYLLqbN
 7Baw==
X-Gm-Message-State: AOJu0YwZnBCPMwXAh45HrzazsjNF0ENvzgj7sWgun2E+WFouvpvumzte
 zOhBMpScAJqvJsNVwaXoudaL+2ChVbR/Gw==
X-Google-Smtp-Source: AGHT+IHXemzempC8nbnN3YZ9CbybVdKaUd5+G/emfNJsZWiVLrlnRy+LRIY8i9ynKPt5DGblSww8eQ==
X-Received: by 2002:a05:600c:228d:b0:40e:44bb:504f with SMTP id
 13-20020a05600c228d00b0040e44bb504fmr2725397wmf.214.1705400563044; 
 Tue, 16 Jan 2024 02:22:43 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 r16-20020a056000015000b003376af392e5sm14056828wrx.38.2024.01.16.02.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:22:42 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 1/7] usb: dwc3: Add dwc3 glue driver for am62
In-Reply-To: <20240112085317.1866449-2-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-2-sjoerd@collabora.com>
Date: Tue, 16 Jan 2024 11:22:41 +0100
Message-ID: <87ply14lxq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sjoerd,

Thank you for the patch.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> Add glue code for TI AM62 to the dwc3 driver; Most code adopted from
> TI vendor u-boot code.
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>
> ---
>
> Changes in v4:
> - Add config dependency on SYSCON
> - Move defines and constants outside out of function scope
>
> Changes in v2:
> - Switch dwc3 glue to a seperate driver rather then in dwc-generic
>
>  drivers/usb/dwc3/Kconfig     |  14 ++++
>  drivers/usb/dwc3/Makefile    |   1 +
>  drivers/usb/dwc3/dwc3-am62.c | 125 +++++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-am62.c
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index c0c8c16fd9c..0100723a68b 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -37,6 +37,20 @@ config SPL_USB_DWC3_GENERIC
>  	  Select this for Xilinx ZynqMP and similar Platforms.
>  	  This wrapper supports Host and Peripheral operation modes.
>  
> +config SPL_USB_DWC3_AM62
> +	bool "TI AM62 USB wrapper"
> +	depends on SPL_DM_USB && SPL_USB_DWC3_GENERIC && SPL_SYSCON
> +	help
> +	  Select this for TI AM62 Platforms.
> +	  This wrapper supports Host and Peripheral operation modes.
> +
> +config USB_DWC3_AM62
> +	bool "TI AM62 USB wrapper"
> +	depends on DM_USB && USB_DWC3_GENERIC && SYSCON
> +	help
> +	  Select this for TI AM62 Platforms.
> +	  This wrapper supports Host and Peripheral operation modes.
> +
>  config USB_DWC3_MESON_G12A
>  	bool "Amlogic Meson G12A USB wrapper"
>  	depends on DM_USB && USB_DWC3 && ARCH_MESON
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 97b4f7191ca..a46b6824ab7 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -6,6 +6,7 @@ dwc3-y					:= core.o
>  
>  obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
>  
> +obj-$(CONFIG_$(SPL_)USB_DWC3_AM62)	+= dwc3-am62.o
>  obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
>  obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
>  obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> new file mode 100644
> index 00000000000..99519602eb2
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI AM62 specific glue layer for DWC3
> + */
> +
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +
> +#include "dwc3-generic.h"
> +
> +#define USBSS_MODE_CONTROL		0x1c
> +#define USBSS_PHY_CONFIG		0x8
> +#define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
> +#define USBSS_PHY_VBUS_SEL_SHIFT	1
> +#define USBSS_MODE_VALID	BIT(0)
> +#define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
> +static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
> +	9600,
> +	10000,
> +	12000,
> +	19200,
> +	20000,
> +	24000,
> +	25000,
> +	26000,
> +	38400,
> +	40000,
> +	58000,
> +	50000,
> +	52000,
> +};
> +
> +static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
> +					enum usb_dr_mode mode)
> +{
> +	struct clk usb2_refclk;
> +	int rate_code, i, ret;
> +	unsigned long rate;
> +	u32 reg;
> +	void *usbss;
> +	bool vbus_divider;
> +	struct regmap *syscon;
> +	struct ofnode_phandle_args args;
> +
> +	usbss = dev_remap_addr_index(dev, 0);
> +	if (IS_ERR(usbss)) {
> +		dev_err(dev, "can't map IOMEM resource\n");
> +		return;
> +	}
> +
> +	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
> +	if (ret) {
> +		dev_err(dev, "can't get usb2_refclk\n");
> +		return;
> +	}
> +
> +	/* Calculate the rate code */
> +	rate = clk_get_rate(&usb2_refclk);
> +	rate /= 1000;	/* To KHz */
> +	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
> +		if (dwc3_ti_am62_rate_table[i] == rate)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
> +		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
> +		return;
> +	}
> +
> +	rate_code = i;
> +
> +	/* Read the syscon property */
> +	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
> +	if (IS_ERR(syscon)) {
> +		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
> +		return;
> +	}
> +
> +	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
> +					     0, &args);
> +	if (ret)
> +		return;
> +
> +	/* Program PHY PLL refclk by reading syscon property */
> +	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
> +	if (ret) {

The doc of ofnode_parse_phandle_with_args() states that:

 * Caller is responsible to call of_node_put() on the returned out_args->np
 * pointer.

Should we call of_node_put(args->np); before returning here?

Should the cleanup be done in case of success as well?

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> +		dev_err(dev, "failed to set phy pll reference clock rate\n");
> +		return;
> +	}
> +
> +	/* VBUS divider select */
> +	reg = readl(usbss + USBSS_PHY_CONFIG);
> +	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
> +	if (vbus_divider)
> +		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
> +
> +	writel(reg, usbss + USBSS_PHY_CONFIG);
> +
> +	/* Set mode valid */
> +	reg = readl(usbss + USBSS_MODE_CONTROL);
> +	reg |= USBSS_MODE_VALID;
> +	writel(reg, usbss + USBSS_MODE_CONTROL);
> +}
> +
> +struct dwc3_glue_ops ti_am62_ops = {
> +	.glue_configure = dwc3_ti_am62_glue_configure,
> +};
> +
> +static const struct udevice_id dwc3_am62_match[] = {
> +	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(dwc3_am62_wrapper) = {
> +	.name	= "dwc3-am62",
> +	.id	= UCLASS_SIMPLE_BUS,
> +	.of_match = dwc3_am62_match,
> +	.bind = dwc3_glue_bind,
> +	.probe = dwc3_glue_probe,
> +	.remove = dwc3_glue_remove,
> +	.plat_auto	= sizeof(struct dwc3_glue_data),
> +};
> -- 
> 2.43.0
