Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A88C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 10:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84448801B0;
	Thu, 16 Jan 2025 11:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oOzTHjg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686B88033D; Thu, 16 Jan 2025 11:25:46 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D39880040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so4203035e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737023143; x=1737627943;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NuwCu/3aIG6grhGSnleMsjpem909xlseleNvKNzOZr0=;
 b=oOzTHjg2AfqbhEDhyV65PvLlabgaDWmjfPozv1Y0QipekxE5jfPKYG75VCzukpzrsl
 3Vaqjtme4Rdr7rVGzKvtAKR5sw17vA0sysfs+2pRpBuh/BW42NGt49zGM9UIxdZqFo9+
 neQBR0WxUWhESluqwUcMC4EFfvTVGxsH5BbFFIADoW/gN44rc0YXt7rEFEtySlkpbers
 VXp/9SkfnsFwE/nmBA9tPYJMsI3LMj2bcFaHj5AE8hJcPclgXWT6Qhgghq8JeoHmFHoX
 hBxeAsS841C2UlluasKT0bn1p8EbAlrom+YbOtl8g+X8U2JMy585ezU5Pxdk/QR3RFuy
 L6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737023143; x=1737627943;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NuwCu/3aIG6grhGSnleMsjpem909xlseleNvKNzOZr0=;
 b=jBlI0bLFF8aWfU6MoNkR7bnuv0QmLNDid74ancakwjOYrDEG/j6HdLruL4OfTg7Nun
 lO9WI6J5ZCshDgi7IT4PpPaUv7VGkt9Bg496QP3e/FCqmbDFDqnxXOTtGxFY5BczsRtk
 6k1q0BEtNxJJ3ng/HUJ0lFEtbo7D0QuNVfNQnWDBOPV2Xr632kJN+N7cXSXEGrRkrFBb
 Y0pKQuIes2Je5yx5Vycdpx1G/mjTNuMVNxPXvgQiHPOa71ZFblqPmMpDiC8iVdX9kdvz
 A92IRiSPccmKfCKuwNzmZXrQQ7pHTmPCOLy+WHtRce7L3YBIBlrZcy1Xp6krzEmG+g3y
 LwQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjgzby/xxrveuEdQTj4XqeXTkdd3ltzW/lTYCPiZiQCbLGF6mW4YlKD81mhTFV6s+WqUYzrB8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyo4i0gRoMBVkyQOmxt6dvVlxQQ0f5pIXUitgu6dv15f1Kc1vdg
 ++vA2RvO+9kAvTPuThKPcyHi5pjdtkhe2tbnqTXJK9Mqz6VgoN4YlF0V3WcibHM=
X-Gm-Gg: ASbGncstpuohaswRGi5yG4G0O3Ib4sYN3khpgJ60LWh4ncARdiHaX1IDKyyZ3Ry3XYC
 9leahpxrVHKoX0O7L/wWySnhxGPqNW5QfDwwi7dK8hBwRNpkTblwZpPsNtyBdrbJ7ljvm4hYM3k
 8LQ2577h9F5teVF8hnQYY1TMmSXERcUcTeZK3PVzAs1ULMxOcJInaXKMLlO7bD/bjmRu9OHz3sb
 0UJpO/WdDCaoC7FpXq2bdhI2AVpiv6PdNSjznxjiL3v/1Vtpx02iCpW6TFmT03bGA==
X-Google-Smtp-Source: AGHT+IF+sQQ3PH99WRiXLDv49R+ywTEiPTrdTc8dgD+KrZbTblgspry/zQfb44UaCje1Gl1YQAnWGg==
X-Received: by 2002:a05:600c:468f:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-436e26ebe46mr311387315e9.31.1737023143448; 
 Thu, 16 Jan 2025 02:25:43 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38be455ef3fsm5825886f8f.24.2025.01.16.02.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:25:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam
 <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Mathieu Othacehe <othacehe@gnu.org>, Nathan
 Barrett-Morrison <nathan.morrison@timesys.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 6/9] usb: dwc3: Remove dwc3 glue driver support for STi
In-Reply-To: <20250116081738.2511223-7-patrice.chotard@foss.st.com>
References: <20250116081738.2511223-1-patrice.chotard@foss.st.com>
 <20250116081738.2511223-7-patrice.chotard@foss.st.com>
Date: Thu, 16 Jan 2025 11:25:42 +0100
Message-ID: <87y0zb6ont.fsf@baylibre.com>
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

On jeu., janv. 16, 2025 at 09:17, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> STi is now using the dwc3-generic driver, dwc3-sti-glue driver
> can be removed.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  MAINTAINERS                      |   2 -
>  board/st/stih410-b2260/board.c   |   1 -
>  drivers/usb/host/Kconfig         |   9 --
>  drivers/usb/host/Makefile        |   1 -
>  drivers/usb/host/dwc3-sti-glue.c | 253 -------------------------------
>  include/dwc3-sti-glue.h          |  41 -----
>  6 files changed, 307 deletions(-)
>  delete mode 100644 drivers/usb/host/dwc3-sti-glue.c
>  delete mode 100644 include/dwc3-sti-glue.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d7e251e601..0982dfa3fe0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -658,8 +658,6 @@ F:	drivers/serial/serial_sti_asc.c
>  F:	drivers/sysreset/sysreset_sti.c
>  F:	drivers/usb/host/dwc3-sti.c
>  F:	drivers/timer/arm_global_timer.c
> -F:	drivers/usb/host/dwc3-sti-glue.c
> -F:	include/dwc3-sti-glue.h
>  F:	include/dt-bindings/clock/stih407-clks.h
>  F:	include/dt-bindings/clock/stih410-clks.h
>  F:	include/dt-bindings/reset/stih407-resets.h
> diff --git a/board/st/stih410-b2260/board.c b/board/st/stih410-b2260/board.c
> index a912712c9dd..3a495eb5089 100644
> --- a/board/st/stih410-b2260/board.c
> +++ b/board/st/stih410-b2260/board.c
> @@ -9,7 +9,6 @@
>  #include <asm/cache.h>
>  #include <asm/global_data.h>
>  #include <linux/usb/otg.h>
> -#include <dwc3-sti-glue.h>
>  #include <dwc3-uboot.h>
>  #include <usb.h>
>  
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 24786a2bc91..cd1c03f10d7 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -110,15 +110,6 @@ config USB_XHCI_RCAR
>  	  Choose this option to add support for USB 3.0 driver on Renesas
>  	  R-Car Gen3 SoCs.
>  
> -config USB_XHCI_STI
> -	bool "Support for STMicroelectronics STiH407 family on-chip xHCI USB controller"
> -	depends on ARCH_STI
> -	default y
> -	help
> -	  Enables support for the on-chip xHCI controller on STMicroelectronics
> -	  STiH407 family SoCs. This is a driver for the dwc3 to provide the glue logic
> -	  to configure the controller.
> -
>  config USB_XHCI_DRA7XX_INDEX
>  	int "DRA7XX xHCI USB index"
>  	range 0 1
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 301bb9fdee1..902d68d0378 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -54,7 +54,6 @@ obj-$(CONFIG_USB_XHCI_GENERIC) += xhci-generic.o
>  obj-$(CONFIG_USB_XHCI_OMAP) += xhci-omap.o
>  obj-$(CONFIG_USB_XHCI_PCI) += xhci-pci.o
>  obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
> -obj-$(CONFIG_USB_XHCI_STI) += dwc3-sti-glue.o
>  obj-$(CONFIG_USB_XHCI_OCTEON) += dwc3-octeon-glue.o
>  
>  # designware
> diff --git a/drivers/usb/host/dwc3-sti-glue.c b/drivers/usb/host/dwc3-sti-glue.c
> deleted file mode 100644
> index 3e6834e38e3..00000000000
> --- a/drivers/usb/host/dwc3-sti-glue.c
> +++ /dev/null
> @@ -1,253 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * STiH407 family DWC3 specific Glue layer
> - *
> - * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> - * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
> - */
> -
> -#include <log.h>
> -#include <asm/global_data.h>
> -#include <asm/io.h>
> -#include <dm.h>
> -#include <errno.h>
> -#include <dm/lists.h>
> -#include <regmap.h>
> -#include <reset-uclass.h>
> -#include <syscon.h>
> -#include <usb.h>
> -#include <linux/printk.h>
> -
> -#include <linux/usb/dwc3.h>
> -#include <linux/usb/otg.h>
> -#include <dwc3-sti-glue.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -/*
> - * struct sti_dwc3_glue_plat - dwc3 STi glue driver private structure
> - * @syscfg_base:	addr for the glue syscfg
> - * @glue_base:		addr for the glue registers
> - * @syscfg_offset:	usb syscfg control offset
> - * @powerdown_ctl:	rest controller for powerdown signal
> - * @softreset_ctl:	reset controller for softreset signal
> - * @mode:		drd static host/device config
> - */
> -struct sti_dwc3_glue_plat {
> -	phys_addr_t syscfg_base;
> -	phys_addr_t glue_base;
> -	phys_addr_t syscfg_offset;
> -	struct reset_ctl powerdown_ctl;
> -	struct reset_ctl softreset_ctl;
> -	enum usb_dr_mode mode;
> -};
> -
> -static int sti_dwc3_glue_drd_init(struct sti_dwc3_glue_plat *plat)
> -{
> -	unsigned long val;
> -
> -	val = readl(plat->syscfg_base + plat->syscfg_offset);
> -
> -	val &= USB3_CONTROL_MASK;
> -
> -	switch (plat->mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -		val &= ~(USB3_DELAY_VBUSVALID
> -			| USB3_SEL_FORCE_OPMODE | USB3_FORCE_OPMODE(0x3)
> -			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
> -			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
> -
> -		val |= USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID;
> -		break;
> -
> -	case USB_DR_MODE_HOST:
> -		val &= ~(USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID
> -			| USB3_SEL_FORCE_OPMODE	| USB3_FORCE_OPMODE(0x3)
> -			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
> -			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
> -
> -		val |= USB3_DELAY_VBUSVALID;
> -		break;
> -
> -	default:
> -		pr_err("Unsupported mode of operation %d\n", plat->mode);
> -		return -EINVAL;
> -	}
> -	writel(val, plat->syscfg_base + plat->syscfg_offset);
> -
> -	return 0;
> -}
> -
> -static void sti_dwc3_glue_init(struct sti_dwc3_glue_plat *plat)
> -{
> -	unsigned long reg;
> -
> -	reg = readl(plat->glue_base + CLKRST_CTRL);
> -
> -	reg |= AUX_CLK_EN | EXT_CFG_RESET_N | XHCI_REVISION;
> -	reg &= ~SW_PIPEW_RESET_N;
> -
> -	writel(reg, plat->glue_base + CLKRST_CTRL);
> -
> -	/* configure mux for vbus, powerpresent and bvalid signals */
> -	reg = readl(plat->glue_base + USB2_VBUS_MNGMNT_SEL1);
> -
> -	reg |= SEL_OVERRIDE_VBUSVALID(USB2_VBUS_UTMIOTG) |
> -	       SEL_OVERRIDE_POWERPRESENT(USB2_VBUS_UTMIOTG) |
> -	       SEL_OVERRIDE_BVALID(USB2_VBUS_UTMIOTG);
> -
> -	writel(reg, plat->glue_base + USB2_VBUS_MNGMNT_SEL1);
> -
> -	setbits_le32(plat->glue_base + CLKRST_CTRL, SW_PIPEW_RESET_N);
> -}
> -
> -static int sti_dwc3_glue_of_to_plat(struct udevice *dev)
> -{
> -	struct sti_dwc3_glue_plat *plat = dev_get_plat(dev);
> -	struct udevice *syscon;
> -	struct regmap *regmap;
> -	int ret;
> -	u32 reg[4];
> -
> -	ret = ofnode_read_u32_array(dev_ofnode(dev), "reg", reg,
> -				    ARRAY_SIZE(reg));
> -	if (ret) {
> -		pr_err("unable to find st,stih407-dwc3 reg property(%d)\n", ret);
> -		return ret;
> -	}
> -
> -	plat->glue_base = reg[0];
> -	plat->syscfg_offset = reg[2];
> -
> -	/* get corresponding syscon phandle */
> -	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "st,syscfg",
> -					   &syscon);
> -	if (ret) {
> -		pr_err("unable to find syscon device (%d)\n", ret);
> -		return ret;
> -	}
> -
> -	/* get syscfg-reg base address */
> -	regmap = syscon_get_regmap(syscon);
> -	if (!regmap) {
> -		pr_err("unable to find regmap\n");
> -		return -ENODEV;
> -	}
> -	plat->syscfg_base = regmap->ranges[0].start;
> -
> -	/* get powerdown reset */
> -	ret = reset_get_by_name(dev, "powerdown", &plat->powerdown_ctl);
> -	if (ret) {
> -		pr_err("can't get powerdown reset for %s (%d)", dev->name, ret);
> -		return ret;
> -	}
> -
> -	/* get softreset reset */
> -	ret = reset_get_by_name(dev, "softreset", &plat->softreset_ctl);
> -	if (ret)
> -		pr_err("can't get soft reset for %s (%d)", dev->name, ret);
> -
> -	return ret;
> -};
> -
> -static int sti_dwc3_glue_bind(struct udevice *dev)
> -{
> -	struct sti_dwc3_glue_plat *plat = dev_get_plat(dev);
> -	ofnode node, dwc3_node;
> -
> -	/* Find snps,dwc3 node from subnode */
> -	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
> -		if (ofnode_device_is_compatible(node, "snps,dwc3"))
> -			dwc3_node = node;
> -	}
> -
> -	if (!ofnode_valid(dwc3_node)) {
> -		pr_err("Can't find dwc3 subnode for %s\n", dev->name);
> -		return -ENODEV;
> -	}
> -
> -	/* retrieve the DWC3 dual role mode */
> -	plat->mode = usb_get_dr_mode(dwc3_node);
> -	if (plat->mode == USB_DR_MODE_UNKNOWN)
> -		/* by default set dual role mode to HOST */
> -		plat->mode = USB_DR_MODE_HOST;
> -
> -	return dm_scan_fdt_dev(dev);
> -}
> -
> -static int sti_dwc3_glue_probe(struct udevice *dev)
> -{
> -	struct sti_dwc3_glue_plat *plat = dev_get_plat(dev);
> -	int ret;
> -
> -	/* deassert both powerdown and softreset */
> -	ret = reset_deassert(&plat->powerdown_ctl);
> -	if (ret < 0) {
> -		pr_err("DWC3 powerdown reset deassert failed: %d", ret);
> -		return ret;
> -	}
> -
> -	ret = reset_deassert(&plat->softreset_ctl);
> -	if (ret < 0) {
> -		pr_err("DWC3 soft reset deassert failed: %d", ret);
> -		goto softreset_err;
> -	}
> -
> -	ret = sti_dwc3_glue_drd_init(plat);
> -	if (ret)
> -		goto init_err;
> -
> -	sti_dwc3_glue_init(plat);
> -
> -	return 0;
> -
> -init_err:
> -	ret = reset_assert(&plat->softreset_ctl);
> -	if (ret < 0) {
> -		pr_err("DWC3 soft reset deassert failed: %d", ret);
> -		return ret;
> -	}
> -
> -softreset_err:
> -	ret = reset_assert(&plat->powerdown_ctl);
> -	if (ret < 0)
> -		pr_err("DWC3 powerdown reset deassert failed: %d", ret);
> -
> -	return ret;
> -}
> -
> -static int sti_dwc3_glue_remove(struct udevice *dev)
> -{
> -	struct sti_dwc3_glue_plat *plat = dev_get_plat(dev);
> -	int ret;
> -
> -	/* assert both powerdown and softreset */
> -	ret = reset_assert(&plat->powerdown_ctl);
> -	if (ret < 0) {
> -		pr_err("DWC3 powerdown reset deassert failed: %d", ret);
> -		return ret;
> -	}
> -
> -	ret = reset_assert(&plat->softreset_ctl);
> -	if (ret < 0)
> -		pr_err("DWC3 soft reset deassert failed: %d", ret);
> -
> -	return ret;
> -}
> -
> -static const struct udevice_id sti_dwc3_glue_ids[] = {
> -	{ .compatible = "st,stih407-dwc3" },
> -	{ }
> -};
> -
> -U_BOOT_DRIVER(dwc3_sti_glue) = {
> -	.name = "dwc3_sti_glue",
> -	.id = UCLASS_NOP,
> -	.of_match = sti_dwc3_glue_ids,
> -	.of_to_plat = sti_dwc3_glue_of_to_plat,
> -	.probe = sti_dwc3_glue_probe,
> -	.remove = sti_dwc3_glue_remove,
> -	.bind = sti_dwc3_glue_bind,
> -	.plat_auto	= sizeof(struct sti_dwc3_glue_plat),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> -};
> diff --git a/include/dwc3-sti-glue.h b/include/dwc3-sti-glue.h
> deleted file mode 100644
> index 546ffbaf7b4..00000000000
> --- a/include/dwc3-sti-glue.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> - * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
> - */
> -
> -#ifndef __DWC3_STI_UBOOT_H_
> -#define __DWC3_STI_UBOOT_H_
> -
> -/* glue registers */
> -#include <linux/bitops.h>
> -#define CLKRST_CTRL		0x00
> -#define AUX_CLK_EN		BIT(0)
> -#define SW_PIPEW_RESET_N	BIT(4)
> -#define EXT_CFG_RESET_N		BIT(8)
> -
> -#define XHCI_REVISION		BIT(12)
> -
> -#define USB2_VBUS_MNGMNT_SEL1	0x2C
> -#define USB2_VBUS_UTMIOTG	0x1
> -
> -#define SEL_OVERRIDE_VBUSVALID(n)	((n) << 0)
> -#define SEL_OVERRIDE_POWERPRESENT(n)	((n) << 4)
> -#define SEL_OVERRIDE_BVALID(n)		((n) << 8)
> -
> -/* Static DRD configuration */
> -#define USB3_CONTROL_MASK		0xf77
> -
> -#define USB3_DEVICE_NOT_HOST		BIT(0)
> -#define USB3_FORCE_VBUSVALID		BIT(1)
> -#define USB3_DELAY_VBUSVALID		BIT(2)
> -#define USB3_SEL_FORCE_OPMODE		BIT(4)
> -#define USB3_FORCE_OPMODE(n)		((n) << 5)
> -#define USB3_SEL_FORCE_DPPULLDOWN2	BIT(8)
> -#define USB3_FORCE_DPPULLDOWN2		BIT(9)
> -#define USB3_SEL_FORCE_DMPULLDOWN2	BIT(10)
> -#define USB3_FORCE_DMPULLDOWN2		BIT(11)
> -
> -int sti_dwc3_init(enum usb_dr_mode mode);
> -
> -#endif /* __DWC3_STI_UBOOT_H_ */
> -- 
> 2.25.1
