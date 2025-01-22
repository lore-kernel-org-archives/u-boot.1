Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A86C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18158803B5;
	Wed, 22 Jan 2025 10:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tIn5BMfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513F280586; Wed, 22 Jan 2025 10:02:35 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE0480283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so3518534f8f.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 01:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737536552; x=1738141352;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pQq1+exsL0QSrKEq3NmrePMQ0o5wAO1KhXaH/Ripk+g=;
 b=tIn5BMfjeYU1l+IBS6Uil1sf9TexkGp6U8xDCcfx27vD8bTgQ/RrAs/qusIaPdgchB
 7aJnTEkzh7+efbM61QOAUSnxjyT5IEhJMDEc0A8bUE7KXMRpzqh4KKH90FnZVsTDqO4F
 /KTHD0Ju+UpC/Nms/LcPUCPaURXAfW+YkS9TVfnoO3vyjJEY/KR+mgBf1zktsPfRaN/N
 CPFPETI/Eat2xhZqN9RCALFNghzS1bAPlBLScfYI1PMlFfZRPRaT67hdSPBAAEhlnGYd
 C3k8QTZm9N2UmmKxf6olVCYkCOKK2WJv8Yir/giiEh68B6t8ObPHUzv2zTG96LAUSBHf
 4Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737536552; x=1738141352;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQq1+exsL0QSrKEq3NmrePMQ0o5wAO1KhXaH/Ripk+g=;
 b=cpbw4YytrI2UX4EFuWGmU8HjoMfp5WpuHnO56mmQxIrqPQLa5rMIRa4UQxZrshmtLS
 XXim6BUQKNdmQ8bXL89Dno6pb/tktrvdxTkTYnX88f6vJAu79rWRHjfFxXZSYC2kfRUM
 FejdLG6YlUqDEQ09JLIrYnLne9HXbcIvLa0VR9hZEePlaFUKyHTGG4Vb/GL1U4tntmyn
 jT0v9Dz7O64QqgZk0lFOcIvEjADCT0z14tfQIbo7gUvxpDYXIU0ddmmEgpAHCZuyFJVM
 ykoRc7FeFl5W9ckNq9plKZ3VZ+ak9Bid8ZhWqU4FCYAVIHZ0Q8nHcE85DRp9RYcSRc1l
 NXJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9rdX8t/80eqMVOXDTif+EyJSPkyfoavC+6UtFIvddZfb3YkFFlrtMCbd3OsWuJ6LGwnx/vfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwX4ZPh5REhBxaYPty+e6tZSrb9959o2W6YtqDxVpOZQn9uL2d5
 N01gioVBjghkCFcRPbP2jS2HWCEPVST9DoFKypHil37IKQAkhaQ1RlVmWnx1K/k=
X-Gm-Gg: ASbGncuH+rwI5mAEemlV6DGg7Eo9bK8U2TzvXFJs1WzqdBXYfc4E6Vk5lhZUiYBgeLn
 xppSnHV1zktwcycZunu4aMk4eidgtTkAVpMl22A4Cy7y7Bz4aLtFW1q9SuLcoQTRl7rz+UPHyaC
 aCOR2kPSefpXxcg/kQOu5PjMpOs2VfpivA0cZtR/5/1YLKboHQ+YjxbZhV3MS3//vdmHJKbaWpt
 4CYiS5S5r8HNzKgj3cJqRDRSkJImFparVsBSucEgQkFIua0cgTin1g8qee7hu9tHu+y59GNSbs4
 xaI=
X-Google-Smtp-Source: AGHT+IHsU15VnyOi+30uigh1aSt8FTfoj3oPVrVig3dg6hyc3uxfjFRE0jX2QPtJi7NWA4U4StPgow==
X-Received: by 2002:a5d:4303:0:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38bf566b62dmr15833681f8f.21.1737536552411; 
 Wed, 22 Jan 2025 01:02:32 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221baasm15846309f8f.35.2025.01.22.01.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 01:02:31 -0800 (PST)
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
Subject: Re: [PATCH v3 4/9] usb: dwc3-generic: Add STih407 support
In-Reply-To: <20250120080120.51657-5-patrice.chotard@foss.st.com>
References: <20250120080120.51657-1-patrice.chotard@foss.st.com>
 <20250120080120.51657-5-patrice.chotard@foss.st.com>
Date: Wed, 22 Jan 2025 10:02:31 +0100
Message-ID: <871pwvkyqg.fsf@baylibre.com>
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

On lun., janv. 20, 2025 at 09:01, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> Add STi glue logic to manage the DWC3 HC on STiH407
> SoC family. It configures the internal glue logic and
> syscfg registers.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
>
> ---
>
> Changes in v3:
>   - Replace debug() by dev_err()
>   - check return value of syscon_regmap_lookup_by_phandle()
>
> Changes in v2:
>   - add dwc3-sti.c DWC3 wrapper as done for dwc3-am62.c
>
>  MAINTAINERS                         |   1 +
>  drivers/usb/dwc3/Kconfig            |   6 ++
>  drivers/usb/dwc3/Makefile           |   1 +
>  drivers/usb/dwc3/dwc3-generic-sti.c | 132 ++++++++++++++++++++++++++++
>  4 files changed, 140 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-generic-sti.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c6c0c2a4bc..5d7e251e601 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -656,6 +656,7 @@ F:	drivers/mmc/sti_sdhci.c
>  F:	drivers/reset/sti-reset.c
>  F:	drivers/serial/serial_sti_asc.c
>  F:	drivers/sysreset/sysreset_sti.c
> +F:	drivers/usb/host/dwc3-sti.c
>  F:	drivers/timer/arm_global_timer.c
>  F:	drivers/usb/host/dwc3-sti-glue.c
>  F:	include/dwc3-sti-glue.h
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 0100723a68b..7d58ae65fb6 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -87,6 +87,12 @@ config USB_DWC3_LAYERSCAPE
>  	  Host and Peripheral operation modes are supported. OTG is not
>  	  supported.
>  
> +config USB_DWC3_STI
> +	bool "STi USB wrapper"
> +	depends on DM_USB && USB_DWC3_GENERIC && SYSCON
> +	help
> +	  Select this for STi Platforms.

The improvements done in v3 based on the comments from v2 look good to me.
However, checkpatch seems unhappy about this:

$ ./scripts/checkpatch.pl --git --u-boot --git master..HEAD

--------------------------------------------------------------
Commit 2a4d2432f669 ("usb: dwc3-generic: Add STih407 support")
--------------------------------------------------------------
WARNING: please write a paragraph that describes the config symbol fully
#42: FILE: drivers/usb/dwc3/Kconfig:90:
+config USB_DWC3_STI

Can't we reuse the help description from 'config USB_XHCI_STI' ?
I'm sorry I missed this before.

With that addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
> index 00000000000..2ff640cede4
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-generic-sti.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * STi specific glue layer for DWC3
> + *
> + * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
> + */
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
> +	.id = UCLASS_SIMPLE_BUS,
> +	.of_match = dwc3_sti_match,
> +	.bind = dwc3_glue_bind,
> +	.probe = dwc3_glue_probe,
> +	.remove = dwc3_glue_remove,
> +	.plat_auto = sizeof(struct dwc3_glue_data),
> +};
> -- 
> 2.25.1
