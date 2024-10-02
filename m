Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DECF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7070188F65;
	Wed,  2 Oct 2024 11:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="cY6In4HZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69E488F1F; Wed,  2 Oct 2024 11:52:11 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB57488009
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37cd5016d98so3343994f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862728; x=1728467528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSw/+UvxareXuiM+EM6A7VjgIoG3h6S3ddH37ocs4Nw=;
 b=cY6In4HZ4s6ZKMf29jinPewlRfrkt3FA2GlLcwmiWH+6nvFWg2rH6DX0NpH08e1zUE
 50hRew4Q7R9Fi+3yj9bl2hLCRzIGtRAA/6a10SiwFM6C4GfYHUdjIX61jJ2CEjU4J1E2
 eOm5OVrNRjOwuhnhbY8B7fhS8XidKeM3glcx+BSnaOVnGqQEr8igt0PxNExXrVQlcKfp
 IYWEDEpiFD4dz4YoZ0hW14PpKXfdiv/DDK9IWGqqzUiIHI21/WsNCWFU3GOhqZ9BR24M
 7sCNhzXRDX5cz6cIfE/LcoVDT8MLryhqftOX082H6l1CU1cOHeSYdbdCNJ0Td4kDytUR
 +K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862728; x=1728467528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSw/+UvxareXuiM+EM6A7VjgIoG3h6S3ddH37ocs4Nw=;
 b=AFVcrt4FIMub0q88eLB/prlUMkmJZltSCZYubY97y7zwB3/pJWTBbewKULFHhYZryI
 ADyQAD+Oe+RH/IMZv4i/70TxgLzQSv/nkDkAjDH9Wx036FB4DA/omZZ8Nr+SIS4Boluv
 Tp0QUR46K3dcWXcupklxwUVSAgWyG8C29Az/QoUwApRU0P8OJr5vq1KiAWfQGQ88HA/e
 qqKgrVe276W+kS5GSODDWUk8N4oGZ+FaTbv0qpgB6wwLQNPKiX8LYpQLkMtb3vqli/M5
 ehMs1JJLnpyWDESLE2rCvvI+/baKFAVgU0O9tU2xrRj82AL3Vk18SsdGu3KKBpnKCgHS
 Vuxw==
X-Gm-Message-State: AOJu0YyUKzotP7aAjcpfn5B8P8y4EneiOYBT2l65cFy1Lqt901jbA6b7
 tMgHVqE3w2gDlVXsP9s7M8fBOK5fo0xftx0r+1gXCFL+8KcPvov5QirYpngZfUghocLWuzAcIxv
 q
X-Google-Smtp-Source: AGHT+IGCR5hURcENhLEeztM4hIbKQ7FexNMcf5wsTN9vMe2uWDyoByBgCRY6S5UtgQOlNgI3uSCJhA==
X-Received: by 2002:adf:a15d:0:b0:37c:ce58:5a1a with SMTP id
 ffacd0b85a97d-37cfba13729mr1497552f8f.54.1727862728278; 
 Wed, 02 Oct 2024 02:52:08 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:07 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 16/37] drivers: usb: Add generic XHCI
Date: Wed,  2 Oct 2024 11:47:07 +0200
Message-ID: <20241002094832.24933-17-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---
Changelog v3:
- Drop weak board_xhci_enable()
Changelog v4:
- Use dev_dbg() instead of debug()
Changelog v6:
- Update header order

---
 drivers/usb/host/Kconfig        |  8 ++++
 drivers/usb/host/Makefile       |  1 +
 drivers/usb/host/xhci-generic.c | 75 +++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
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
index 0000000000..355d488317
--- /dev/null
+++ b/drivers/usb/host/xhci-generic.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 9elements GmbH
+ *
+ * GENERIC USB HOST xHCI Controller
+ */
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <usb.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
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
+		dev_dbg(dev, "Can't get the XHCI register base address\n");
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
2.46.2

