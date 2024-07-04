Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F43C3271E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D3A885EC;
	Thu,  4 Jul 2024 16:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YfMotqC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A5F2884C5; Thu,  4 Jul 2024 16:18:09 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C88D3886A6
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id F41EDCE354F;
 Thu,  4 Jul 2024 14:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4793FC3277B;
 Thu,  4 Jul 2024 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720102684;
 bh=DvpUXTpWxojDURTSaNMPySr2J2PlJKCLtG9s/RJB/+I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YfMotqC8vi31nIzpCJo3VVehv/hXwlaKDKNJ28e8A6wrH3ooDhS2TJtq2+5XmeiMU
 WRkOeffRBjxDKuNUi6s7OVQwO48AJQ5Jirpi79GEs3q2fczPQEm8xH+lGE5Xx20Pfh
 nzdtVfMH51EuOegcPy2an1WVwAQIuK9P/nVVN2KS6kBoPw0GCbq4nnryrd4s5gq9oe
 tXTJt6lwbf00B90xoo6QOk0tBzbcqvcGMfK3miuGim8KCwaODuk+QOTHx/wxCxLZV7
 cYCZHI5UFB99ufjoWLBGBmEsqQ3mU5w9n9Pwx185xyKYqwyz1oB9auuaJ714ngGJmF
 esWDP7qV9ojNQ==
Message-ID: <73f427b3-d5e1-4b97-aaec-2b94baf82714@kernel.org>
Date: Thu, 4 Jul 2024 17:17:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] usb: cdns: starfive: Add cdns USB driver
To: Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <20240704055014.55117-5-minda.chen@starfivetech.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240704055014.55117-5-minda.chen@starfivetech.com>
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



On 04/07/2024 08:50, Minda Chen wrote:
> Add cdns USB3 wrapper driver.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/usb/cdns3/Kconfig          |   7 ++
>  drivers/usb/cdns3/Makefile         |   2 +
>  drivers/usb/cdns3/cdns3-starfive.c | 183 +++++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> 
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index 35b61497d9..f8f363982b 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -55,4 +55,11 @@ config USB_CDNS3_TI
>  	help
>  	  Say 'Y' here if you are building for Texas Instruments
>  	  platforms that contain Cadence USB3 controller core. E.g.: J721e.
> +
> +config USB_CDNS3_STARFIVE
> +	tristate "Cadence USB3 support on Starfive platforms"
> +	default USB_CDNS3
> +	help
> +	  Say 'Y' here if you are building for Starfive platforms
> +	  that contain Cadence USB3 controller core. E.g.: JH7110.
>  endif
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 18d7190755..03d1eadb2f 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -9,3 +9,5 @@ cdns3-$(CONFIG_$(SPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
>  cdns3-$(CONFIG_$(SPL_)USB_CDNS3_HOST)	+= host.o
>  
>  obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
> +
> +obj-$(CONFIG_USB_CDNS3_STARFIVE)	+= cdns3-starfive.o
> diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
> new file mode 100644
> index 0000000000..660833fb5b
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-starfive.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
> + *
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + *
> + * Author:	Minda Chen <minda.chen@starfivetech.com>
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/usb/otg.h>
> +#include <reset.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <malloc.h>
> +
> +#include "core.h"
> +
> +#define USB_STRAP_HOST			BIT(17)
> +#define USB_STRAP_DEVICE		BIT(18)
> +#define USB_STRAP_MASK			GENMASK(18, 16)
> +
> +#define USB_SUSPENDM_HOST		BIT(19)
> +#define USB_SUSPENDM_MASK		BIT(19)
> +
> +#define USB_MISC_CFG_MASK		GENMASK(23, 20)
> +#define USB_SUSPENDM_BYPS		BIT(20)
> +#define USB_PLL_EN			BIT(22)
> +#define USB_REFCLK_MODE			BIT(23)
> +
> +struct cdns_starfive {
> +	struct udevice *dev;
> +	struct regmap *stg_syscon;
> +	struct reset_ctl_bulk resets;
> +	struct clk_bulk clks;
> +	u32 stg_usb_mode;
> +	enum usb_dr_mode mode;
> +};
> +
> +static void cdns_mode_init(struct cdns_starfive *data, enum usb_dr_mode mode)
> +{
> +	unsigned int strap, suspendm;
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_MISC_CFG_MASK,
> +			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
> +
> +	switch (mode) {
> +	case USB_DR_MODE_HOST:
> +		strap = USB_STRAP_HOST;
> +		suspendm = USB_SUSPENDM_HOST;
> +		break;
> +
> +	case USB_DR_MODE_PERIPHERAL:
> +		strap = USB_STRAP_DEVICE;
> +		suspendm = 0;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_STRAP_MASK, strap);
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_SUSPENDM_MASK, suspendm);
> +}
> +
> +static void cdns_clk_rst_deinit(struct cdns_starfive *data)
> +{
> +	reset_assert_bulk(&data->resets);
> +	clk_disable_bulk(&data->clks);
> +}
> +
> +static int cdns_clk_rst_init(struct cdns_starfive *data)
> +{
> +	int ret;
> +
> +	ret = clk_get_bulk(data->dev, &data->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_get_bulk(data->dev, &data->resets);
> +	if (ret)
> +		goto err_clk;
> +
> +	ret = clk_enable_bulk(&data->clks);
> +	if (ret)
> +		goto err_en_clk;
> +
> +	ret = reset_deassert_bulk(&data->resets);
> +	if (ret)
> +		goto err_reset;
> +
> +	return 0;
> +
> +err_reset:
> +	clk_disable_bulk(&data->clks);
> +err_en_clk:
> +	reset_release_bulk(&data->resets);
> +err_clk:
> +	clk_release_bulk(&data->clks);
> +
> +	return ret;
> +}
> +
> +static int cdns_starfive_get_syscon(struct cdns_starfive *data)
> +{
> +	struct ofnode_phandle_args phandle;
> +	int ret;
> +
> +	ret = dev_read_phandle_with_args(data->dev, "starfive,stg-syscon", NULL, 1, 0,
> +					 &phandle);
> +
unnecessary blank line

> +	if (ret < 0) {
> +		dev_err(data->dev, "Can't get stg cfg phandle: %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->stg_syscon = syscon_node_to_regmap(phandle.node);
> +	if (IS_ERR(data->stg_syscon)) {
> +		dev_err(data->dev, "fail to get regmap: %d\n", (int)PTR_ERR(data->stg_syscon));
> +		return PTR_ERR(data->stg_syscon);
> +	}

Need a new blank line?

> +	data->stg_usb_mode = phandle.args[0];
> +
> +	return 0;
> +}
> +
> +static int cdns_starfive_probe(struct udevice *dev)
> +{
> +	struct cdns_starfive *data = dev_get_plat(dev);
> +	enum usb_dr_mode dr_mode;
> +	ofnode node;
> +	int ret;
> +
> +	data->dev = dev;
> +
> +	ret = cdns_starfive_get_syscon(data);
> +
unnecessary blank new lines.

> +	if (ret)
> +		return ret;
> +
> +	node = ofnode_by_compatible(dev_ofnode(dev), "cdns,usb3");
> +	if (!ofnode_valid(node)) {
> +		dev_err(dev, "failed to get usb node\n");
> +		return -ENODEV;
> +	}
> +
> +	dr_mode = usb_get_dr_mode(node);
> +
> +	data->mode = dr_mode;
> +	cdns_mode_init(data, dr_mode);

Don't you need to release reset and enable clock before doing cdns_mode_init()?

> +
> +	return cdns_clk_rst_init(data);
> +}
> +
> +static int cdns_starfive_remove(struct udevice *dev)
> +{
> +	struct cdns_starfive *data = dev_get_plat(dev);
> +
> +	cdns_clk_rst_deinit(data);
> +	return 0;
> +}
> +
> +static const struct udevice_id cdns_starfive_of_match[] = {
> +	{ .compatible = "starfive,jh7110-usb", },
> +	{},
> +};
> +
> +U_BOOT_DRIVER(cdns_starfive) = {
> +	.name = "cdns-starfive",
> +	.id = UCLASS_NOP,
> +	.of_match = cdns_starfive_of_match,
> +	.bind = cdns3_bind,
> +	.probe = cdns_starfive_probe,
> +	.remove = cdns_starfive_remove,
> +	.plat_auto	= sizeof(struct cdns_starfive),
> +	.flags = DM_FLAG_OS_PREPARE,
> +};

-- 
cheers,
-roger
