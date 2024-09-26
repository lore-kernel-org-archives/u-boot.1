Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE87CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48F688E41;
	Thu, 26 Sep 2024 23:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G2TmbOe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F0A88E5F; Thu, 26 Sep 2024 23:29:11 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233CA88E7E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb2aaf4a73so10846376d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386148; x=1727990948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OMw+5pi7chUN5hb/RkjldWbw8ccRdloUZ6iZKwS2Oqc=;
 b=G2TmbOe2K9HdRDWHpCrbXeacXC4bDfwhXmSBTH5+HwQP8nM39wnBS2ATH8bPQ68OEq
 wueeqpa/DCMXyUHVZ3t7hljTmJppxTCfRJd122qI9psm2XjWwTQPH7EJ0F1OM2c6gOk0
 l9+JWy5HNMO0e89DFXpfLthlpxJgLPMgMRYH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386148; x=1727990948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OMw+5pi7chUN5hb/RkjldWbw8ccRdloUZ6iZKwS2Oqc=;
 b=DIbNltoN6JkWpqPoZAc7+6amq/Ojj6/UFAOyEBKPjWHCXh9EulldalIw8m3tx8Ui2/
 sh8Gnl8KwcAuBRcPd/c7CgWQEPUz/LA6+iSf3MTrd/QSKuosd/uKG5O9Ze4t1m4eTLGp
 loVUBBsEztUa4v85hWehjyLNEhnWDaeCS8BhxtyGVqta6i5fzeZgffR+uNIx7rii1C2+
 oc0Tzu3RDXyFsldaNlGvS+cUWrt0n+2AH+SRl9ACBFsmwld4rrfifZWos5VvjLekZY7N
 q+iG/68M6YHTKIIjeBdQtnVFHBjJHD35NnEgrQ4DDEbQCJPVnrjit3+1NXgHvQFdB5oX
 LZgQ==
X-Gm-Message-State: AOJu0YyHNZWwEbohsOfomQS6igGi33mxuxVDWuPb1fpNGi/eFDvnyc3w
 ojxHId1GpmxhBrnn/qykgN/9JnT/sAotLd5ktT3RCjenRWNoKtUw75PoOSKWTaaJiuOuXWaXWXg
 I0NxAxXNv6HYxntDAQzt20qKuZe5EyiSXZbAP
X-Google-Smtp-Source: AGHT+IGMeAQxZEj4CzcY5xERMcsLPWtTT/3zxCnFbNCtXPYgyJhwa5dTAPcVo9sHUD/FRcbtuzBvStq4jdUF1zikq7M=
X-Received: by 2002:a05:6214:5c04:b0:6cb:375d:fd16 with SMTP id
 6a1803df08f44-6cb3b5e4ea1mr10707686d6.5.1727386147991; Thu, 26 Sep 2024
 14:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-17-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-17-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:28:54 +0200
Message-ID: <CAFLszThhaf4HuD4sso8TdD2sS=L26KZ4bEJ7cpPeMKwiHkx5CA@mail.gmail.com>
Subject: Re: [PATCH v5 16/36] drivers: usb: Add generic XHCI
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Patrick,

On Thu, 26 Sept 2024 at 10:06, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add support for the generic XHCI driver that contains no SoC
> specific code. It can be used on platforms that simply work out

SoC-specific

> of the box, like on emulated platforms.

out-of-the-box

>
> TEST: Booted on QEMU sbsa machine using the generic xhci driver.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> Changelog v3:
> - Drop weak board_xhci_enable()
> Changelog v4:
> - Use dev_dbg() instead of debug()
>
> ---
>  drivers/usb/host/Kconfig        |  8 ++++
>  drivers/usb/host/Makefile       |  1 +
>  drivers/usb/host/xhci-generic.c | 77 +++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-generic.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>



> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 6e10b629a3..bb5893d56d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -68,6 +68,14 @@ config USB_XHCI_MVEBU
>           SoCs, which includes Armada8K, Armada3700 and other Armada
>           family SoCs.
>
> +config USB_XHCI_GENERIC
> +       bool "Generic SoC USB 3.0 support"
> +       depends on OF_CONTROL
> +       default n
> +       help
> +         Choose this option to add support for USB 3.0 driver for SoCs
> +         that do not need platform specific code, like on emulated targets.
> +
>  config USB_XHCI_OCTEON
>         bool "Support for Marvell Octeon family on-chip xHCI USB controller"
>         depends on ARCH_OCTEON
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 8dad36f936..9e880195ec 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_USB_XHCI_EXYNOS) += xhci-exynos5.o
>  obj-$(CONFIG_USB_XHCI_FSL) += xhci-fsl.o
>  obj-$(CONFIG_USB_XHCI_MTK) += xhci-mtk.o
>  obj-$(CONFIG_USB_XHCI_MVEBU) += xhci-mvebu.o
> +obj-$(CONFIG_USB_XHCI_GENERIC) += xhci-generic.o
>  obj-$(CONFIG_USB_XHCI_OMAP) += xhci-omap.o
>  obj-$(CONFIG_USB_XHCI_PCI) += xhci-pci.o
>  obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
> diff --git a/drivers/usb/host/xhci-generic.c b/drivers/usb/host/xhci-generic.c
> new file mode 100644
> index 0000000000..5131f37991
> --- /dev/null
> +++ b/drivers/usb/host/xhci-generic.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 9elements GmbH
> + *
> + * GENERIC USB HOST xHCI Controller
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <fdtdec.h>
> +#include <log.h>
> +#include <usb.h>
> +
> +#include <usb/xhci.h>
> +
> +struct generic_xhci_plat {
> +       fdt_addr_t hcd_base;
> +};
> +
> +/**
> + * Contains pointers to register base addresses
> + * for the usb controller.
> + */
> +struct generic_xhci {
> +       struct xhci_ctrl ctrl;  /* Needs to come first in this struct! */
> +       struct usb_plat usb_plat;
> +       struct xhci_hccr *hcd;
> +};
> +
> +static int xhci_usb_probe(struct udevice *dev)
> +{
> +       struct generic_xhci_plat *plat = dev_get_plat(dev);
> +       struct generic_xhci *ctx = dev_get_priv(dev);
> +       struct xhci_hcor *hcor;
> +       int len;
> +
> +       ctx->hcd = (struct xhci_hccr *)phys_to_virt(plat->hcd_base);
> +       len = HC_LENGTH(xhci_readl(&ctx->hcd->cr_capbase));
> +       hcor = (struct xhci_hcor *)((uintptr_t)ctx->hcd + len);
> +
> +       return xhci_register(dev, ctx->hcd, hcor);
> +}
> +
> +static int xhci_usb_of_to_plat(struct udevice *dev)
> +{
> +       struct generic_xhci_plat *plat = dev_get_plat(dev);
> +
> +       /*
> +        * Get the base address for XHCI controller from the device node
> +        */
> +       plat->hcd_base = dev_read_addr(dev);
> +       if (plat->hcd_base == FDT_ADDR_T_NONE) {
> +               dev_dbg(dev, "Can't get the XHCI register base address\n");
> +               return -ENXIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id xhci_usb_ids[] = {
> +       { .compatible = "generic-xhci" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(usb_xhci) = {
> +       .name   = "xhci_generic",
> +       .id     = UCLASS_USB,
> +       .of_match = xhci_usb_ids,
> +       .of_to_plat = xhci_usb_of_to_plat,
> +       .probe = xhci_usb_probe,
> +       .remove = xhci_deregister,
> +       .ops    = &xhci_usb_ops,
> +       .plat_auto      = sizeof(struct generic_xhci_plat),
> +       .priv_auto      = sizeof(struct generic_xhci),
> +       .flags  = DM_FLAG_ALLOC_PRIV_DMA,
> +};
> --
> 2.46.0
>
