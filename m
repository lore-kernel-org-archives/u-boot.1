Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DFCCE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAD088D88;
	Fri,  6 Sep 2024 09:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="XDb+4/2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFE188D02; Fri,  6 Sep 2024 09:22:55 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85CC88D34
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so130658566b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607370; x=1726212170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PVaW9TYKYbxaSu/FJXT3Oz9Ins0dQsL518FDwivdEU=;
 b=XDb+4/2gzGPGqTYBidt+FSx84e2oXPJE+kyGQk21H7GlPLCNpLfCN4Ltwpn+Ga0/c0
 MJBeGylmpUv8i8xqWE5zrvyfXkPoHnprrgGIMSJIQa3yGz6L62gkwdXmhnN6CTEIgXtm
 5SxyLL9G0qQxCFiL1sWcLznY8Td8uZ+BzE3RSVQtWjMyh3nPNlHW6G2TAHq8rN6FaXyJ
 iOZXxBIOp8u711tDUD/C0Co7sC6ADWXCsHvIRIdzsrXMGAgfRBr2+aoZWUsLPVaFpkFq
 BGFNHHQo+IPrM7hD4KHz+sCBW793xgii4JFT8QbQCEbm5s5i6I8naxntVM4zNJP46Fko
 7XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607370; x=1726212170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PVaW9TYKYbxaSu/FJXT3Oz9Ins0dQsL518FDwivdEU=;
 b=gX92KGEflazgNbtB1mq3B4NG+01D3quPB3nnllN+J170bMAzTk+xz0nBGcSXHseyNK
 Zzbse8IX656vv+h2HNvzbM/RyeO4m1Ygh7ct3nMAxkTQvSnB2bUn9GNPlr85B78tdJPI
 QHcbIE8xv69b7P9tCN2rrNEsQpY0TXaKy2d/+pwKa1HVkIGjtqsgocZZgRYlOaHqIk4Z
 BoQbqHkafpusrcXQcE6sfv4c44acx44qhhQHJOFf4AF434RYybhlKrdAEWXufY2Z3p3V
 bvXf0/0wB5FOs2MUQrLCx3p4ORcQOXMsEotFAmjQK6427vNzLXrTJHQQbmvi3UNRRBs0
 onIg==
X-Gm-Message-State: AOJu0YyB2Geuy4vwkRloqtnl+dyuEIBC5YfGDV7EVHNzckmlqo65ImYJ
 sdRNHrHCTWS+3ynekrZp3KXYX8uWR7Cc/NLmpcrGOhyUzNYCb+i7nTZe92L8C9jSdL/z2yJ8S8D
 x
X-Google-Smtp-Source: AGHT+IE6KtvilAchWh+rbxoJiaD0V+JanglddIxx2xCXdH7m0joN3T3edpGFagVzhkMYLUwtZbWHTg==
X-Received: by 2002:a17:907:94cd:b0:a7a:aa35:408a with SMTP id
 a640c23a62f3a-a8a885f9602mr112728366b.25.1725607370144; 
 Fri, 06 Sep 2024 00:22:50 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:49 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 16/28] drivers: usb: Add generic XHCI
Date: Fri,  6 Sep 2024 09:22:18 +0200
Message-ID: <20240906072231.2531491-17-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
---
 drivers/usb/host/Kconfig        |  8 +++
 drivers/usb/host/Makefile       |  1 +
 drivers/usb/host/xhci-generic.c | 88 +++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
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
index 0000000000..8c0341d0c4
--- /dev/null
+++ b/drivers/usb/host/xhci-generic.c
@@ -0,0 +1,88 @@
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
+/*
+ * Dummy implementation that can be overwritten by a board
+ * specific function
+ */
+__weak int board_xhci_enable(fdt_addr_t base)
+{
+	return 0;
+}
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
+	/* Enable USB xHCI in board specific code */
+	board_xhci_enable(devfdt_get_addr_index(dev, 1));
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
2.45.2

