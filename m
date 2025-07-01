Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E834C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6603682F33;
	Tue,  1 Jul 2025 08:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6402382B18; Tue,  1 Jul 2025 08:17:25 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121B281FEE
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 08:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4a8244e897fso14432791cf.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 23:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751350634; x=1751955434;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6SDTglPvNupuyYA1Ft5iGlIGgOSGnEXVLH8XwMCl2k=;
 b=TiVZP7TNLa0lbA/31QcNwIKp9GpTUOBNtzA6Y1cnpeclKS5CymQbmTji99L+M+hXPl
 rG6f+n3h3cQh3NLhMpEf26ocr1Yaozy+rCfmMEaA5JXe9isOrpHj4/NbVmG9wCA9k7JA
 XmeU4Ipxfcdwqp4bMjgTF38XMA1orRYUhudmkF40kw9rh0HCCdOIJHSMRgcXp5oVvbB8
 9nsLYFfvZS80MK9u/LwBBHcoZNDzsUp0xbto7sSTqQd0bHWcOSGvrf6pX8TtqHnihEUP
 DOaP22wU7TjvWoR/Dd00cyUnCw76WQbJMkkLvrk0VJz1AYGNVSYl2+xhF1h3b3sTmN/t
 W3/g==
X-Gm-Message-State: AOJu0YxYr+cCcHFWi+TQazmKEZi9M6aN6t+iXeN7SMUragTvT6P5F9qD
 X6IqAL3ClRUKwnFb0Uf/wBvORjjxYxiR8uMdmuNkorinx0Tzaow+PIFPqAKv32kL
X-Gm-Gg: ASbGncs7fEtZ4woy7B/ihg00iG9+xBvNFmxDtg9YTiqaAXTm6IElGvBc6TILKllAJjU
 wFJin5Ae8XD/yv49kAwvorCkjDyCJ8KHQtYOXPsAnhGpKlxB8OvtoKT0L3SuG5kgNXfh3zr6YhQ
 TMvP/H2IT7dbCXuJYqvVHh1h6EK1T6RcWbUTCzGqM+YZfBoEV0JgqzIQ24IbYAcqM6cwc9IBoG4
 G66VyY5nD7yHo4M93mywh8R3VFx7PPmQvXaBQ0KSZ7Z7Z6LvX1LPO/FW+2fwHigVXvjLce+ZOMe
 oJc1vcKIfeYXxxwdS2I5AlWGdY7ZMrY/BvUE3BznVxT0Qrp2YwwvWD65B8bT9J7begyEXTJDnb8
 5z043BXQYQHceYL9JGkIy/m0=
X-Google-Smtp-Source: AGHT+IHenhLdfPYPHCRVTW5Y9ZgoKTvgELXPaBdvTQCfXlCzpzZlBnl8//+xQu1G09mr2b84MqX3GA==
X-Received: by 2002:a05:622a:592:b0:4a6:d5ae:8901 with SMTP id
 d75a77b69052e-4a7fca2ffe0mr283935001cf.19.1751350633575; 
 Mon, 30 Jun 2025 23:17:13 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc5ad641sm71014951cf.77.2025.06.30.23.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 23:17:13 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, Magnus Damm <damm@opensource.se>,
 marek.vasut+renesas@mailbox.org
Date: Tue, 01 Jul 2025 08:17:10 +0200
Message-Id: <175135063036.63099.10267366987503829859.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH] pinctrl: renesas: Initial RZ/A2 R7S9210 support
X-Mailman-Approved-At: Tue, 01 Jul 2025 08:48:20 +0200
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

From: Magnus Damm <damm@opensource.se>

Add pinctrl support for RZ/A2 r7s9210. The actual configuration is
taken from DT and the current rather simple implementation is enough
to at least configure serial console and Ethernet.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 (Resending with updated email address to Marek)

 drivers/pinctrl/renesas/Kconfig        |    9 +-
 drivers/pinctrl/renesas/Makefile       |    1 
 drivers/pinctrl/renesas/pinctrl-rza2.c |  136 ++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 1 deletion(-)
 
diff -urN u-boot-v2025.07-rc3/drivers/pinctrl/renesas/Kconfig u-boot-v2025.07-rc3-grmango-v5/drivers/pinctrl/renesas/Kconfig
--- u-boot-v2025.07-rc3/drivers/pinctrl/renesas/Kconfig	2025-02-14 15:36:58.305816789 +0900
+++ u-boot-v2025.07-rc3-grmango-v5/drivers/pinctrl/renesas/Kconfig	2025-06-22 15:06:03.819573352 +0900
@@ -3,7 +3,7 @@
 config PINCTRL_PFC
 	bool "Renesas pin control drivers"
 	depends on DM && ARCH_RENESAS
-	default n if CPU_RZA1
+	default n if CPU_RZA1 || CPU_RZA2
 	help
 	  Support pin multiplexing control on Renesas SoCs.
 
@@ -155,6 +155,13 @@
 	help
 	  Support pin multiplexing control on Renesas RZ/A1 R7S72100 SoCs.
 
+config PINCTRL_RZA2
+	bool "Renesas RZ/A2 R7S9210 pin control driver"
+	depends on CPU_RZA2
+	default y if CPU_RZA2
+	help
+	  Support pin multiplexing control on Renesas RZ/A2 R7S9210 SoCs.
+
 config PINCTRL_RZG2L
 	bool "Renesas RZ/G2L family pin control driver"
 	depends on PINCTRL
diff -urN u-boot-v2025.07-rc3/drivers/pinctrl/renesas/Makefile u-boot-v2025.07-rc3-grmango-v5/drivers/pinctrl/renesas/Makefile
--- u-boot-v2025.07-rc3/drivers/pinctrl/renesas/Makefile	2024-05-18 16:38:53.196536115 +0900
+++ u-boot-v2025.07-rc3-grmango-v5/drivers/pinctrl/renesas/Makefile	2025-06-22 15:02:37.360416017 +0900
@@ -21,5 +21,6 @@
 obj-$(CONFIG_PINCTRL_PFC_R8A779G0) += pfc-r8a779g0.o
 obj-$(CONFIG_PINCTRL_PFC_R8A779H0) += pfc-r8a779h0.o
 obj-$(CONFIG_PINCTRL_RZA1) += pinctrl-rza1.o
+obj-$(CONFIG_PINCTRL_RZA2) += pinctrl-rza2.o
 obj-$(CONFIG_PINCTRL_RZN1) += pinctrl-rzn1.o
 obj-$(CONFIG_PINCTRL_RZG2L) += rzg2l-pfc.o
diff -urN u-boot-v2025.07-rc3/drivers/pinctrl/renesas/pinctrl-rza2.c u-boot-v2025.07-rc3-grmango-v5/drivers/pinctrl/renesas/pinctrl-rza2.c
--- u-boot-v2025.07-rc3/drivers/pinctrl/renesas/pinctrl-rza2.c	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc3-grmango-v5/drivers/pinctrl/renesas/pinctrl-rza2.c	2025-06-30 23:14:38.820084926 +0900
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/A2 pin controller support
+ *
+ * Based on R7S72100 pinctrl, Copyright (C) 2019 Marek Vasut
+ * Based on RZA2MEVB board code, Copyright (C) 2018 Chris Brandt
+ *
+ * Copyright (C) 2018 Renesas Electronics Corporation
+ */
+
+#include <dm.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
+#include <dm/pinctrl.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+#define PDR_BASE        0x0000     /* 16-bit, 2 bytes apart */
+#define PODR_BASE       0x0040     /* 8-bit, 1 byte apart */
+#define PIDR_BASE       0x0060     /* 8-bit, 1 byte apart */
+#define PMR_BASE        0x0080     /* 8-bit, 1 byte apart */
+#define DSCR_BASE       0x0140     /* 16-bit, 2 bytes apart */
+#define PFS_BASE        0x0200     /* 8-bit, 8 bytes apart */
+#define PWPR            0x02FF     /* 8-bit */
+#define PFENET          0x0820     /* 8-bit */
+#define PPOC            0x0900     /* 32-bit */
+#define PHMOMO          0x0980     /* 32-bit */
+#define PMODEPFS        0x09C0     /* 32-bit */
+#define PCKIO           0x09D0     /* 8-bit */
+
+#define RZA2_PINS_PER_PORT 8
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct r7s9210_pfc_plat {
+	void __iomem	*base;
+};
+
+static void r7s9210_pfc_set_function(struct udevice *dev, u8 port, u8 pin, u8 func)
+{
+	struct r7s9210_pfc_plat *plat = dev_get_plat(dev);
+	u16 reg16, mask16;
+
+	/* Set pin to 'Non-use (Hi-z input protection)' */
+	reg16 = readw(plat->base + PDR_BASE + (port * 2));
+	mask16 = 0x03 << (pin * 2);
+	reg16 &= ~mask16;
+	writew(reg16, plat->base + PDR_BASE + (port * 2));
+
+	/* Temporary switch to GPIO */
+	clrbits_8(plat->base + PMR_BASE + port, BIT(pin));
+
+	/* PFS Register Write Protect : OFF */
+	writeb(0x00, plat->base + PWPR); /* B0WI=0, PFSWE=0 */
+	writeb(0x40, plat->base + PWPR); /* B0WI=0, PFSWE=1 */
+
+	/* Set Pin function (interrupt disabled, ISEL=0) */
+	writeb(func, plat->base + PFS_BASE + (port * 8) + pin);
+
+	/* PFS Register Write Protect : ON */
+	writeb(0x00, plat->base + PWPR); /* B0WI=0, PFSWE=0 */
+	writeb(0x80, plat->base + PWPR); /* B0WI=1, PFSWE=0 */
+
+	/* Port Mode : Peripheral module pin functions */
+	setbits_8(plat->base + PMR_BASE + port, BIT(pin));
+}
+
+static int r7s9210_pfc_set_state(struct udevice *dev, struct udevice *config)
+{
+	const void *blob = gd->fdt_blob;
+	int node = dev_of_offset(config);
+	u32 cells[32];
+	u16 bank, line, func;
+	int i, count;
+
+	count = fdtdec_get_int_array_count(blob, node, "pinmux",
+					   cells, ARRAY_SIZE(cells));
+	if (count < 0) {
+		printf("%s: bad pinmux array %d\n", __func__, count);
+		return -EINVAL;
+	}
+
+	if (count > ARRAY_SIZE(cells)) {
+		printf("%s: unsupported pinmux array count %d\n",
+		       __func__, count);
+		return -EINVAL;
+	}
+
+	for (i = 0 ; i < count; i++) {
+		func = (cells[i] >> 16) & 0xf;
+		if (func == 0 || func > 8) {
+			printf("Invalid cell %i in node %s!\n",
+			       count, ofnode_get_name(dev_ofnode(config)));
+			continue;
+		}
+
+		bank = (cells[i] / RZA2_PINS_PER_PORT) & 0xff;
+		line = cells[i] % RZA2_PINS_PER_PORT;
+
+		r7s9210_pfc_set_function(dev, bank, line, func);
+	}
+
+	return 0;
+}
+
+const struct pinctrl_ops r7s9210_pfc_ops  = {
+	.set_state = r7s9210_pfc_set_state,
+};
+
+static int r7s9210_pfc_probe(struct udevice *dev)
+{
+	struct r7s9210_pfc_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr_base;
+
+	addr_base = dev_read_addr(dev);
+	if (addr_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	plat->base = (void __iomem *)addr_base;
+	return 0;
+}
+
+static const struct udevice_id r7s9210_pfc_match[] = {
+	{ .compatible = "renesas,r7s9210-pinctrl" },
+	{}
+};
+
+U_BOOT_DRIVER(r7s9210_pfc) = {
+	.name		= "r7s9210_pfc",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= r7s9210_pfc_match,
+	.probe		= r7s9210_pfc_probe,
+	.plat_auto	= sizeof(struct r7s9210_pfc_plat),
+	.ops		= &r7s9210_pfc_ops,
+};
