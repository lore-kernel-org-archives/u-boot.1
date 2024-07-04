Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7803FC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 13:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE09088581;
	Thu,  4 Jul 2024 15:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WP1MJ74G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD268867A; Thu,  4 Jul 2024 15:34:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8766F882E2
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 15:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 31D7B626DE;
 Thu,  4 Jul 2024 13:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65473C3277B;
 Thu,  4 Jul 2024 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720100068;
 bh=TRQR7XuabvhCrzqfB4cXWu6l+sJQXPwZOWYdlkPQL78=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WP1MJ74G4XVPWYC1zIEaE8P/s692flFnyVlpUnOlJiowr+vbhMfkkx7yuHXD5dwYN
 9auQU9K7B5ux0eTjUuVWlr20MX257e9XVVRPhijUzkpUe2+pHJYcx5E8G76iZoUq2p
 UfouIiaKj2TFjnbBm/fTIPKbr1p3NcT3n5xFLJFhCzNIr7HwabUpGQqzUg2Lwlc4TJ
 0geFrIO71bgwRnXF7CwSohh4dFLprCY3oGkJK3mwkv51VGvs0m70uHvpKfGpri57i2
 8Mu45+coipgfK2lgCsg4KvnuGvp+P84y+UvVR+LG2gJ9BDO/nd9vJeuKLyqrmw8uXO
 JJ+aZ6HCQQ6jg==
Message-ID: <2c2dd1ce-3942-464a-89d6-a32c406999f5@kernel.org>
Date: Thu, 4 Jul 2024 16:34:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] phy: starfive: Add Starfive JH7110 USB 2.0 PHY
 driver
To: Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <20240704055014.55117-3-minda.chen@starfivetech.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240704055014.55117-3-minda.chen@starfivetech.com>
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
> Add Starfive JH7110 USB 2.0 PHY driver, which is generic
> PHY driver.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/phy/Kconfig                    |   1 +
>  drivers/phy/Makefile                   |   1 +
>  drivers/phy/starfive/Kconfig           |  14 +++
>  drivers/phy/starfive/Makefile          |   6 ++
>  drivers/phy/starfive/phy-jh7110-usb2.c | 135 +++++++++++++++++++++++++
>  5 files changed, 157 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 8f767877e7..0c4d63a01f 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -307,5 +307,6 @@ source "drivers/phy/cadence/Kconfig"
>  source "drivers/phy/ti/Kconfig"
>  source "drivers/phy/qcom/Kconfig"
>  source "drivers/phy/renesas/Kconfig"
> +source "drivers/phy/starfive/Kconfig"
>  
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 7a2b764492..6ac867350c 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -44,3 +44,4 @@ obj-y += cadence/
>  obj-y += ti/
>  obj-y += qcom/
>  obj-y += renesas/
> +obj-y += starfive/
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> new file mode 100644
> index 0000000000..11a819f8b2
> --- /dev/null
> +++ b/drivers/phy/starfive/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# Phy drivers for Starfive platforms

PHY?

> +#
> +
> +menu "Starfive PHY driver"
> +
> +config PHY_STARFIVE_JH7110_USB2
> +	bool "Starfive JH7110 USB 2.0 PHY driver"
> +	select PHY
> +	help
> +	  Enable this to support the Starfive JH7110 USB 2.0 PHY.
> +	  Generic PHY driver JH7110 USB 2.0.
> +
> +endmenu
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> new file mode 100644
> index 0000000000..a405a75e34
> --- /dev/null
> +++ b/drivers/phy/starfive/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2023 Starfive
> +#
> +
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_USB2)	+= phy-jh7110-usb2.o
> diff --git a/drivers/phy/starfive/phy-jh7110-usb2.c b/drivers/phy/starfive/phy-jh7110-usb2.c
> new file mode 100644
> index 0000000000..d48c9f8a74
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-usb2.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * StarFive JH7110 USB 2.0 PHY driver
> + *
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + * Author: Minda Chen <minda.chen@starfivetech.com>
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <generic-phy.h>
> +#include <regmap.h>
> +#include <soc.h>
> +#include <syscon.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +
> +#define USB_LS_KEEPALIVE_OFF		0x4
> +#define USB_LS_KEEPALIVE_ENABLE		BIT(4)
> +#define USB_PHY_CLK_RATE		125000000
> +
> +struct jh7110_usb2_phy {
> +	struct phy *phy;
> +	void __iomem *regs;
> +	struct clk *usb_125m_clk;
> +	struct clk *app_125m;
> +	enum phy_mode mode;
> +};
> +
> +static void usb2_set_ls_keepalive(struct jh7110_usb2_phy *phy, bool set)
> +{
> +	/* Host mode enable the LS speed keep-alive signal */
> +	if (set)
> +		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
> +				USB_LS_KEEPALIVE_ENABLE,
> +				USB_LS_KEEPALIVE_ENABLE);
> +	else
> +		clrsetbits_le32(phy->regs + USB_LS_KEEPALIVE_OFF,
> +				USB_LS_KEEPALIVE_ENABLE, 0);
> +}
> +
> +static int usb2_phy_set_mode(struct phy *_phy,
> +			     enum phy_mode mode, int submode)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +
> +	if (mode == phy->mode)
> +		return 0;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_DEVICE:
> +	case PHY_MODE_USB_OTG:
> +		dev_dbg(dev, "Changing phy to %d\n", mode);
> +		phy->mode = mode;
> +		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int jh7110_usb2_phy_init(struct phy *_phy)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = clk_set_rate(phy->usb_125m_clk, USB_PHY_CLK_RATE);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set 125m clock\n");
> +		return ret;
> +	}
> +
> +	return clk_prepare_enable(phy->app_125m);
> +}
> +
> +static int jh7110_usb2_phy_exit(struct phy *_phy)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +
> +	clk_disable_unprepare(phy->app_125m);
> +
> +	return 0;
> +}
> +
> +struct phy_ops jh7110_usb2_phy_ops = {
> +	.init     = jh7110_usb2_phy_init,
> +	.exit     = jh7110_usb2_phy_exit,
> +	.set_mode = usb2_phy_set_mode,
> +};
> +
> +int jh7110_usb2_phy_probe(struct udevice *dev)
> +{
> +	struct jh7110_usb2_phy *phy = dev_get_priv(dev);
> +
> +	phy->regs = dev_read_addr_ptr(dev);
> +	if (!phy->regs)
> +		return -EINVAL;
> +
> +	phy->usb_125m_clk = devm_clk_get(dev, "125m");
> +	if (IS_ERR(phy->usb_125m_clk)) {
> +		dev_err(dev, "Failed to get 125m clock\n");
> +		return PTR_ERR(phy->usb_125m_clk);
> +	}
> +
> +	phy->app_125m = devm_clk_get(dev, "app_125m");
> +	if (IS_ERR(phy->app_125m)) {
> +		dev_err(dev, "Failed to get app 125m clock\n");
> +		return PTR_ERR(phy->app_125m);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id jh7110_usb2_phy[] = {
> +	{ .compatible = "starfive,jh7110-usb-phy"},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(jh7110_usb2_phy) = {
> +	.name = "jh7110_usb2_phy",
> +	.id = UCLASS_PHY,
> +	.of_match = jh7110_usb2_phy,
> +	.probe = jh7110_usb2_phy_probe,
> +	.ops = &jh7110_usb2_phy_ops,
> +	.priv_auto	= sizeof(struct jh7110_usb2_phy),

how about space instead of tab?

> +};

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger
