Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EDBCF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9103289367;
	Wed, 23 Oct 2024 15:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="KnDtqbG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5E789325; Wed, 23 Oct 2024 15:29:24 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7CA89308
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so38619425e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690148; x=1730294948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nPrbYTf5tFiESeIP8Z9IY0iYfLZzZpE37pNSgvoK7g=;
 b=KnDtqbG6WKQJwyuWVe2GF3pWNLHVneaS5ql+Ws2BvIPlwehJt3M3LijlX/9RUllQxr
 omc7fBhtDeoVBIglp5lu1uUsmK1ULkLhY3MBh9WZBDjqIH6ByV0eBgJmwW9E+eTAKsiO
 qICDe4Ui4bJaK5wDrvO4/u/2rLVEH7UjcZ4GsSHamsJD9X4r6QomoD7L0vKGoHwPTBo7
 wN3mozYOtcZrqpfObonUr8FjjBCuonUu/X6eyZQ4I6nqdfQlzsX5g0C9rFJwSnOPNeSS
 9qxlFRuTtZPYvbozXlNF1JvDRFRdni12Z+VFj7SFGoGMsfpyC3tPZfhoPdCqu0HG3Hus
 cSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690148; x=1730294948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nPrbYTf5tFiESeIP8Z9IY0iYfLZzZpE37pNSgvoK7g=;
 b=tLmbR1vr9OpXoFnnmSdbusRZXp4RNobH1PxiaXOVjSKQmnRhs30bNo0Tdc54wzcnhd
 O3ib28bprp8Mm3upz1AYmrjm1pI/hbIBhq2PN90Y5bixuQz7TeH9TFjpO8I8N34WlVlO
 w9sm+/tSrQ+zlRYr2dTbUPqGwLuGy5WxD4/hvJ+usnI23hS2kQ3hNjenRgDAGJ2mqR4k
 W6FNmm7LbyGK/LVJlQ7e7JsPl22qO8kXTgR4ZSwBBstQJGQzpwfJRzpJ4ulVm85ZxSIL
 yozlcQje3K+Xug38pYwyqZ96hJrzge3RyUaU6ICYavXxzIXyuqBC7lkdtJWPJOWzFRD6
 tPpQ==
X-Gm-Message-State: AOJu0YzwPMKx16ST2oPFntSriLK5kzBkAJW+I8QsNRx2xqUb6Wmy87xy
 4eHtMZihYeioPUfC3B83V8+kLTWKRWWN52/4Zl0bjqCVaQkTwK9hcuplxEKQ6xTqAvPsg2/4eyl
 R
X-Google-Smtp-Source: AGHT+IGnfIKomAVio2EXXt4EQrvDoI0LG2f2bF/QuA+xU4s+KfOUwACrFWVUcsh0BRYrCP02FBgGPQ==
X-Received: by 2002:a5d:47c6:0:b0:37e:d965:4e04 with SMTP id
 ffacd0b85a97d-37efcf84a3amr1993121f8f.36.1729690148305; 
 Wed, 23 Oct 2024 06:29:08 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:08 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 21/37] arm: lib: Add GICV2 driver
Date: Wed, 23 Oct 2024 15:20:04 +0200
Message-ID: <20241023132116.970117-22-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Add a generic GICV2 driver that:
- parses the DT and generates the ACPI MADT subtables
- implement of_xlate() and allows irq_get_by_index() to return the
  correct interrupt mappings

Map DT interrupts to ARM GIC interrupts	as follows:

- Interrupt numbers ID32-ID1019 are used for SPIs
- ID0-ID15 are used for SGIs
- ID16-ID31 are used for PPIs

TEST: Booted on QEMU raspb4 using GICV2 driver model generated MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changelog v6:
- Update header order
Changelog v9:
- Map SPI interrupts to ID32+
- Map PPI interrupts to ID16+
---
 arch/arm/Kconfig      |  7 ++++
 arch/arm/lib/Makefile |  1 +
 arch/arm/lib/gic-v2.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 arch/arm/lib/gic-v2.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 060636e9e2..263f85b0d0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -113,6 +113,13 @@ config GICV2
 config GICV3
 	bool
 
+config DRIVER_GICV2
+	bool "ARM GICV2 driver"
+	select IRQ
+	help
+	  ARM GICV2 driver.
+	  Basic support for parsing the GICV2 node and generate ACPI tables.
+
 config GIC_V3_ITS
 	bool "ARM GICV3 ITS"
 	select IRQ
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index a7efed6771..cf76051450 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_FSL_LAYERSCAPE) += ccn504.o
 ifneq ($(CONFIG_GICV2)$(CONFIG_GICV3),)
 obj-y	+= gic_64.o
 endif
+obj-$(CONFIG_DRIVER_GICV2)	+= gic-v2.o
 obj-$(CONFIG_GIC_V3_ITS)	+= gic-v3-its.o
 obj-y	+= interrupts_64.o
 else
diff --git a/arch/arm/lib/gic-v2.c b/arch/arm/lib/gic-v2.c
new file mode 100644
index 0000000000..b70434a45d
--- /dev/null
+++ b/arch/arm/lib/gic-v2.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 Broadcom.
+ */
+#include <dm.h>
+#include <irq.h>
+#include <asm/gic.h>
+#include <asm/acpi_table.h>
+#include <cpu_func.h>
+#include <dm/acpi.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#ifdef CONFIG_ACPIGEN
+/**
+ * acpi_gicv2_fill_madt() - Fill out the body of the MADT
+ *
+ * Write GICD and GICR tables based on collected devicetree data.
+ *
+ * @dev: Device to write ACPI tables for
+ * @ctx: ACPI context to write MADT sub-tables to
+ * Return: 0 if OK
+ */
+static int acpi_gicv2_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicd *gicd;
+	fdt_addr_t addr;
+
+	addr = dev_read_addr_index(dev, 0);
+	if (addr == FDT_ADDR_T_NONE) {
+		pr_err("%s: failed to get GICD address\n", __func__);
+		return -EINVAL;
+	}
+
+	gicd = ctx->current;
+	acpi_write_madt_gicd(gicd, dev_seq(dev), addr, 2);
+	acpi_inc(ctx, gicd->length);
+
+	return 0;
+}
+
+static struct acpi_ops gic_v2_acpi_ops = {
+	.fill_madt	= acpi_gicv2_fill_madt,
+};
+#endif
+
+static const struct udevice_id gic_v2_ids[] = {
+	{ .compatible = "arm,arm11mp-gic" },
+	{ .compatible = "arm,cortex-a15-gic" },
+	{ .compatible = "arm,cortex-a7-gic" },
+	{ .compatible = "arm,cortex-a5-gic" },
+	{ .compatible = "arm,cortex-a9-gic" },
+	{ .compatible = "arm,eb11mp-gic" },
+	{ .compatible = "arm,gic-400" },
+	{ .compatible = "arm,pl390" },
+	{ .compatible = "arm,tc11mp-gic" },
+	{ .compatible = "qcom,msm-8660-qgic" },
+	{ .compatible = "qcom,msm-qgic2" },
+	{}
+};
+
+static int arm_gic_v2_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 3) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	/* ARM Generic Interrupt Controller v1 and v2 */
+	if (args->args[0] == GIC_SPI)
+		irq->id = args->args[1] + 32;
+	else
+		irq->id = args->args[1] + 16;
+
+	irq->flags = args->args[2];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v2_ops = {
+	.of_xlate		=  arm_gic_v2_of_xlate,
+};
+
+U_BOOT_DRIVER(arm_gic_v2) = {
+	.name		= "gic-v2",
+	.id		= UCLASS_IRQ,
+	.of_match	= gic_v2_ids,
+	.ops		= &arm_gic_v2_ops,
+	ACPI_OPS_PTR(&gic_v2_acpi_ops)
+};
-- 
2.46.2

