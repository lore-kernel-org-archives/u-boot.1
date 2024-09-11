Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A137BEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CA4891B6;
	Wed, 11 Sep 2024 08:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Il5gkhN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093C08918D; Wed, 11 Sep 2024 08:25:49 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA33891AB
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so848841a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035946; x=1726640746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aps42h8KTIJIOFGrjuAkS81ST6I90gCfMBVShcMVwlQ=;
 b=Il5gkhN2Y3yeMKnS9DblcnpJbpRQZLg2xF4vxAjmW6+1kbSNOxhtH7Uu0F3xAouFEC
 Fciruw83k/K9qkBEYZH2rMBjIVv3rRMN4954k0iNq32TjzIWxrm6WH2TYDJGEPylhNkS
 fELtEdxYShh4+R10vMqbJ3CSENYgh/a8EsTEmekBl0EG2k4pvGlZvc+B3zqF2Y7sYksa
 TEbm/FviP9pHA0/C5uhFZu8br/1S+No2NTeABLpnZkq/rRhBt/WFdDgzEdzzf61l+qNw
 APFvgBqaPQ+NmujDEM3DMw6oTIw03/QrSA8TOaGlfeaMMq7T/68I5G/w2jKC1xFBKZux
 0NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035946; x=1726640746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aps42h8KTIJIOFGrjuAkS81ST6I90gCfMBVShcMVwlQ=;
 b=qUACb+X0GZqv/QVf8VBsCGDQ3JAV0lc+VfYg0nBRPD+gezQHDlisBVIbD+NMgj6wpI
 dJ+E2IZG9ichdOcn38jPSvt5IiGngAUPyIimzA/je9eAgfPbnnChd8WQa/j1spmL/7hE
 exHM8kIC59yCK6f3PO3JxFi9aaxUPsYiYtJjHEEZqtvJVnBdLClYCmFgDGzSPwrjvNMV
 BQjyeHvj817VUOLPXy1a7mvkopVrM6DtHJJm5Y204kjHnXpl0ForFO9dgYpr/Qn9vJfk
 FTt38DW8E42YqtDFOl837daxMvJdwdOjlvhLZuxCej+5/bz+Pjj5OokkMyCndmx8YPJy
 cyow==
X-Gm-Message-State: AOJu0Yzr8SaWm/tKVxoSOvYz4txA0qqGIN7oTflQIQDi3mkLmLYKsg46
 h3A3MsjoVwfTTbfJ++ik7v+5HCBi6iULEKXv50wizjwBx+3S3u3T6hiqc0Dh8mSJ4IEfdzTqEcS
 c
X-Google-Smtp-Source: AGHT+IHInVaSvOa+7YwbsdqR08cOZepvqSmU/gAmPN1+n1pr7in9An1gt46RfMHZ1gZSaHSv2o9Qkw==
X-Received: by 2002:a17:906:bc24:b0:a8d:43c5:9a16 with SMTP id
 a640c23a62f3a-a8ffb1c213dmr347020566b.6.1726035946463; 
 Tue, 10 Sep 2024 23:25:46 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:46 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 16/30] drivers: usb: Add generic XHCI
Date: Wed, 11 Sep 2024 08:24:06 +0200
Message-ID: <20240911062511.494855-17-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for the generic XHCI driver that contains no SoC
specific code. It can be used on platforms that simply work out
of the box, like on emulated platforms.

TEST: Booted on QEMU sbsa machine using the generic xhci driver.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---
Changelog v3:
- Drop weak board_xhci_enable()

---
 drivers/usb/host/Kconfig        |  8 ++++
 drivers/usb/host/Makefile       |  1 +
 drivers/usb/host/xhci-generic.c | 76 +++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 drivers/usb/host/xhci-generic.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6e10b629a3..bb5893d56d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -68,6 +68,14 @@ config USB_XHCI_MVEBU
 	  SoCs, which includes Armada8K, Armada3700 and other Armada
 	  family SoCs.
 
+config USB_XHCI_GENERIC
+	bool "Generic SoC USB 3.0 support"
+	depends on OF_CONTROL
+	default n
+	help
+	  Choose this option to add support for USB 3.0 driver for SoCs
+	  that do not need platform specific code, like on emulated targets.
+
 config USB_XHCI_OCTEON
 	bool "Support for Marvell Octeon family on-chip xHCI USB controller"
 	depends on ARCH_OCTEON
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 8dad36f936..9e880195ec 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_USB_XHCI_EXYNOS) += xhci-exynos5.o
 obj-$(CONFIG_USB_XHCI_FSL) += xhci-fsl.o
 obj-$(CONFIG_USB_XHCI_MTK) += xhci-mtk.o
 obj-$(CONFIG_USB_XHCI_MVEBU) += xhci-mvebu.o
+obj-$(CONFIG_USB_XHCI_GENERIC) += xhci-generic.o
 obj-$(CONFIG_USB_XHCI_OMAP) += xhci-omap.o
 obj-$(CONFIG_USB_XHCI_PCI) += xhci-pci.o
 obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
diff --git a/drivers/usb/host/xhci-generic.c b/drivers/usb/host/xhci-generic.c
new file mode 100644
index 0000000000..9bde69d2e1
--- /dev/null
+++ b/drivers/usb/host/xhci-generic.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 9elements GmbH
+ *
+ * GENERIC USB HOST xHCI Controller
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <usb.h>
+
+#include <usb/xhci.h>
+
+struct generic_xhci_plat {
+	fdt_addr_t hcd_base;
+};
+
+/**
+ * Contains pointers to register base addresses
+ * for the usb controller.
+ */
+struct generic_xhci {
+	struct xhci_ctrl ctrl;	/* Needs to come first in this struct! */
+	struct usb_plat usb_plat;
+	struct xhci_hccr *hcd;
+};
+
+static int xhci_usb_probe(struct udevice *dev)
+{
+	struct generic_xhci_plat *plat = dev_get_plat(dev);
+	struct generic_xhci *ctx = dev_get_priv(dev);
+	struct xhci_hcor *hcor;
+	int len;
+
+	ctx->hcd = (struct xhci_hccr *)phys_to_virt(plat->hcd_base);
+	len = HC_LENGTH(xhci_readl(&ctx->hcd->cr_capbase));
+	hcor = (struct xhci_hcor *)((uintptr_t)ctx->hcd + len);
+
+	return xhci_register(dev, ctx->hcd, hcor);
+}
+
+static int xhci_usb_of_to_plat(struct udevice *dev)
+{
+	struct generic_xhci_plat *plat = dev_get_plat(dev);
+
+	/*
+	 * Get the base address for XHCI controller from the device node
+	 */
+	plat->hcd_base = dev_read_addr(dev);
+	if (plat->hcd_base == FDT_ADDR_T_NONE) {
+		debug("Can't get the XHCI register base address\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id xhci_usb_ids[] = {
+	{ .compatible = "generic-xhci" },
+	{ }
+};
+
+U_BOOT_DRIVER(usb_xhci) = {
+	.name	= "xhci_generic",
+	.id	= UCLASS_USB,
+	.of_match = xhci_usb_ids,
+	.of_to_plat = xhci_usb_of_to_plat,
+	.probe = xhci_usb_probe,
+	.remove = xhci_deregister,
+	.ops	= &xhci_usb_ops,
+	.plat_auto	= sizeof(struct generic_xhci_plat),
+	.priv_auto	= sizeof(struct generic_xhci),
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+};
-- 
2.46.0

