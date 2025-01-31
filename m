Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88CFC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 07:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B722809D0;
	Fri, 31 Jan 2025 08:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GopMHYo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD5880C77; Fri, 31 Jan 2025 08:16:36 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2CD807A8
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 08:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so11540215e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738307794; x=1738912594;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W0hWIToZaEe3/cmeC2S7Nrx2q+LT/9E1XE5w0H6ZUng=;
 b=GopMHYo595ck69ydaDwzImVlFGcwhOM7nmuvcT6efL6xeZIuHvIQFFZQaoYX5poF6E
 EPRUl3joOPrx8DQOfEswUrDXvKlQrrN0GCLOxswEpaajpXweDVAKGV4K+6Hn2aIi4K0B
 EX+kImeMpFGMRiPveLe9l60W7DV0sI0ozI3C7DsQ0bCw1MLyj1laQOMqb6Iv61Oj9tC/
 1UKUTRXHJkRV1a1H4QWl3NYnMrOH0XyoI++ADkJT/l4pLFRp3oqKra0jqr91KmaUTjhV
 B9Z/q875mfcPMQ/KI/oEb27KmDzERXJruG8G2SM3nxS7oVROHSMQenasdC6i8LXTiffl
 iiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738307794; x=1738912594;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0hWIToZaEe3/cmeC2S7Nrx2q+LT/9E1XE5w0H6ZUng=;
 b=cHn9C7H1rongYpE2HlBbRryYhOrUhlbcF6EfDHrgxACGUyW1BsnVjiYWQX9h2DhIey
 KPhcpXvZjdXNGzVUfM4S2660Mp56QzEvQFJNdZHVeimyQXOCPqau5RJhJKOrrlQ1hrUx
 CEE8xwB3iC3yJiXVnJEpgIUAmInjHwQV6bfiBJS+Wri6KDiSJSTcSc0N4MfeCifNuD+d
 rRATiggtknu6hF3FyFlwthmTOZBbeedC/bXovjCcgSuj/ulbFAUa3XD47kaDl8WnVosV
 CMO7jfkM7PiYMiF9Li6ZVbDLCBdBtKfX1N0dgOouNjC/DcY+3ZQ6EntleHZK9oJ2VlT5
 1fgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZgsziS4Fai+xeezuoLJ/sK/tAfI6L0nBrVC1aZKDaznDpm2vzSgUVJC62uXjcexorhvpOa4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4P2unOP660sdJE5Hzo3OOPecrBXsHD6HN+HPdboR3aJ5azE1o
 XRAUIyq9nVv3X4rzFHWum47JF80KB0PvnpBwpGACfzaoMPGsu9/V9fbZK5+zREQ=
X-Gm-Gg: ASbGncsRAZOIe7XNWbXBliZZxrdEBQiliUmnKoqCoSamX+Gb0+Fi4abHH69tl/uOk7I
 Pf6AHvFJudIZuicadNPlJwpohEzZ7TqrCJBC3VHHqaOuE+/QWc0qrKbCFztI7Xe6YF1O7TwoAkc
 0nLJISsoC6sk21/+qBGJDkbCPkcPKjC773rhMH1f8nvjLtAEjyvT6wwRDUPK2jBfxzaiSrsCZn5
 jAU8q3qL10itLW63lnHCEwooCi7QVDuGt4RjMJTofoTMHzpxPyif+ueVc6/ZdhC+D98msTEn2DZ
 938QBWbzy1AiswAgQJjWDigf
X-Google-Smtp-Source: AGHT+IH0rS1rIP0gmyz/piA7EO6NOg7EhiaksCaDnBjXOnDxNsGPlVwFBtyFCxwepbhCSdP4z0XVTA==
X-Received: by 2002:a05:600c:1d07:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-438dc3fc344mr82641575e9.20.1738307793596; 
 Thu, 30 Jan 2025 23:16:33 -0800 (PST)
Received: from localhost ([2a01:cb1a:4074:4dd7:fefe:5ab4:19e5:2ed2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc12f28sm81153815e9.7.2025.01.30.23.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 23:16:33 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Sjoerd
 Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v5 5/9] usb: dwc3-generic: Add STih407 support
In-Reply-To: <20250130163547.512990-6-patrice.chotard@foss.st.com>
References: <20250130163547.512990-1-patrice.chotard@foss.st.com>
 <20250130163547.512990-6-patrice.chotard@foss.st.com>
Date: Fri, 31 Jan 2025 08:16:27 +0100
Message-ID: <874j1f8nck.fsf@baylibre.com>
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

Hi Patrice,

Thank you for the patch.

On jeu., janv. 30, 2025 at 17:35, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> Add STi glue logic to manage the DWC3 HC on STiH407
> SoC family. It configures the internal glue logic and
> syscfg registers.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
>
> Changes in v5:
>   - reorder files entry for ARM STI in MAINTAINERS file
>   - add #define LOG_CATEGORY UCLASS_NOP
>   - use UCLASS_NOP instead of UCLASS_SIMPLE_BUS
>
> Changes in v4:
>   - Update Kconfig description
>
> Changes in v3:
>   - Replace debug() by dev_err()
>   - check return value of syscon_regmap_lookup_by_phandle()
>
> Changes in v2:
>   - add dwc3-sti.c DWC3 wrapper as done for dwc3-am62.c
>
>  MAINTAINERS                         |   1 +
>  drivers/usb/dwc3/Kconfig            |   8 ++
>  drivers/usb/dwc3/Makefile           |   1 +
>  drivers/usb/dwc3/dwc3-generic-sti.c | 134 ++++++++++++++++++++++++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-generic-sti.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e93f88c2aa..38501775890 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -657,6 +657,7 @@ F:	drivers/reset/sti-reset.c
>  F:	drivers/serial/serial_sti_asc.c
>  F:	drivers/sysreset/sysreset_sti.c
>  F:	drivers/timer/arm_global_timer.c
> +F:	drivers/usb/host/dwc3-sti.c
>  F:	include/dt-bindings/clock/stih407-clks.h
>  F:	include/dt-bindings/clock/stih410-clks.h
>  F:	include/dt-bindings/reset/stih407-resets.h
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 0100723a68b..682a6910655 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -87,6 +87,14 @@ config USB_DWC3_LAYERSCAPE
>  	  Host and Peripheral operation modes are supported. OTG is not
>  	  supported.
>  
> +config USB_DWC3_STI
> +	bool "STi USB wrapper"
> +	depends on DM_USB && USB_DWC3_GENERIC && SYSCON
> +	help
> +	  Enables support for the on-chip xHCI controller on STMicroelectronics
> +	  STiH407 family SoCs. This is a driver for the dwc3 to provide the
> +	  glue logic to configure the controller.
> +
>  menu "PHY Subsystem"
>  
>  config USB_DWC3_PHY_OMAP
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index a085c9d4628..985206eafe4 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
>  obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
>  obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
>  obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
> +obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
> diff --git a/drivers/usb/dwc3/dwc3-generic-sti.c b/drivers/usb/dwc3/dwc3-generic-sti.c
> new file mode 100644
> index 00000000000..b34f5ceceac
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-generic-sti.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * STi specific glue layer for DWC3
> + *
> + * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
> + */
> +
> +#define LOG_CATEGORY UCLASS_NOP
> +
> +#include <reset.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/read.h>
> +#include <linux/usb/otg.h>
> +#include "dwc3-generic.h"
> +
> +/* glue registers */
> +#define CLKRST_CTRL		0x00
> +#define AUX_CLK_EN		BIT(0)
> +#define SW_PIPEW_RESET_N	BIT(4)
> +#define EXT_CFG_RESET_N		BIT(8)
> +
> +#define XHCI_REVISION		BIT(12)
> +
> +#define USB2_VBUS_MNGMNT_SEL1	0x2C
> +#define USB2_VBUS_UTMIOTG	0x1
> +
> +#define SEL_OVERRIDE_VBUSVALID(n)	((n) << 0)
> +#define SEL_OVERRIDE_POWERPRESENT(n)	((n) << 4)
> +#define SEL_OVERRIDE_BVALID(n)		((n) << 8)
> +
> +/* Static DRD configuration */
> +#define USB3_CONTROL_MASK		0xf77
> +
> +#define USB3_DEVICE_NOT_HOST		BIT(0)
> +#define USB3_FORCE_VBUSVALID		BIT(1)
> +#define USB3_DELAY_VBUSVALID		BIT(2)
> +#define USB3_SEL_FORCE_OPMODE		BIT(4)
> +#define USB3_FORCE_OPMODE(n)		((n) << 5)
> +#define USB3_SEL_FORCE_DPPULLDOWN2	BIT(8)
> +#define USB3_FORCE_DPPULLDOWN2		BIT(9)
> +#define USB3_SEL_FORCE_DMPULLDOWN2	BIT(10)
> +#define USB3_FORCE_DMPULLDOWN2		BIT(11)
> +
> +static void dwc3_stih407_glue_configure(struct udevice *dev, int index,
> +					enum usb_dr_mode mode)
> +{
> +	struct dwc3_glue_data *glue = dev_get_plat(dev);
> +	struct regmap *regmap;
> +	ulong syscfg_base;
> +	ulong syscfg_offset;
> +	ulong glue_base;
> +	int ret;
> +
> +	/* deassert both powerdown and softreset */
> +	ret = reset_deassert_bulk(&glue->resets);
> +	if (ret) {
> +		dev_err(dev, "reset_deassert_bulk error: %d\n", ret);
> +		return;
> +	}
> +
> +	regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscfg");
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "unable to get st,syscfg, dev %s\n", dev->name);
> +		return;
> +	}
> +
> +	syscfg_base = regmap->ranges[0].start;
> +	glue_base = dev_read_addr_index(dev, 0);
> +	syscfg_offset = dev_read_addr_index(dev, 1);
> +
> +	clrbits_le32(syscfg_base + syscfg_offset, USB3_CONTROL_MASK);
> +
> +	/* glue drd init */
> +	switch (mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		clrbits_le32(syscfg_base + syscfg_offset,
> +			     USB3_DELAY_VBUSVALID | USB3_SEL_FORCE_OPMODE |
> +			     USB3_FORCE_OPMODE(0x3) | USB3_SEL_FORCE_DPPULLDOWN2 |
> +			     USB3_FORCE_DPPULLDOWN2 | USB3_SEL_FORCE_DMPULLDOWN2 |
> +			     USB3_FORCE_DMPULLDOWN2);
> +
> +		setbits_le32(syscfg_base + syscfg_offset,
> +			     USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID);
> +		break;
> +
> +	case USB_DR_MODE_HOST:
> +		clrbits_le32(syscfg_base + syscfg_offset,
> +			     USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID |
> +			     USB3_SEL_FORCE_OPMODE | USB3_FORCE_OPMODE(0x3) |
> +			     USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2 |
> +			     USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
> +
> +		setbits_le32(syscfg_base + syscfg_offset, USB3_DELAY_VBUSVALID);
> +		break;
> +
> +	default:
> +		dev_err(dev, "Unsupported mode of operation %d\n", mode);
> +		return;
> +	}
> +
> +	/* glue init */
> +	setbits_le32(glue_base + CLKRST_CTRL, AUX_CLK_EN | EXT_CFG_RESET_N | XHCI_REVISION);
> +	clrbits_le32(glue_base + CLKRST_CTRL, SW_PIPEW_RESET_N);
> +
> +	/* configure mux for vbus, powerpresent and bvalid signals */
> +	setbits_le32(glue_base + USB2_VBUS_MNGMNT_SEL1,
> +		     SEL_OVERRIDE_VBUSVALID(USB2_VBUS_UTMIOTG) |
> +		     SEL_OVERRIDE_POWERPRESENT(USB2_VBUS_UTMIOTG) |
> +		     SEL_OVERRIDE_BVALID(USB2_VBUS_UTMIOTG));
> +	setbits_le32(glue_base + CLKRST_CTRL, SW_PIPEW_RESET_N);
> +};
> +
> +struct dwc3_glue_ops stih407_ops = {
> +	.glue_configure = dwc3_stih407_glue_configure,
> +};
> +
> +static const struct udevice_id dwc3_sti_match[] = {
> +	{ .compatible = "st,stih407-dwc3", .data = (ulong)&stih407_ops},
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(dwc3_sti_wrapper) = {
> +	.name = "dwc3-sti",
> +	.id = UCLASS_NOP,
> +	.of_match = dwc3_sti_match,
> +	.bind = dwc3_glue_bind,
> +	.probe = dwc3_glue_probe,
> +	.remove = dwc3_glue_remove,
> +	.plat_auto = sizeof(struct dwc3_glue_data),
> +};
> -- 
> 2.25.1
