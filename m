Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759AFCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6004588DF1;
	Thu, 26 Sep 2024 10:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="e4OAQFxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC0388D75; Thu, 26 Sep 2024 10:03:20 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9ED688D7D
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c4146c7d5dso621921a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337782; x=1727942582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFuWfnkmIdWwmd2uegsjQr/D9bZQnKbP0CQzDYCAbW4=;
 b=e4OAQFxEoBCZeGi47DzbjGcL8iLTQRVHgBnOKyPsUQLbDsb3QmI6lfGXYb0xMibs5M
 Suinz8u4NE8ywI/ldjbplwy34YytaIzjKs6bsrkWfr2WEyoNBxfm16zt/HsjqqjEm/eH
 tDQ5Wokr2SQoutYEA6004rF0M1potZsFQ4mHV61EmFFpbnb72riRkjdjLx/eSwIImLVY
 nlx6Vv88fQ+AGA/+T9iT1vHx/z87HNqEb11qebJEoNr/5ZNaAlMuo6BL8l1QeD2YHzaq
 96dn1J1WgXcj9WqMi/Oz9fkLqkItzcLd8t1qC2F1M5WzOnfqe9c6JVqpEN+vc5WBwTsd
 V/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337782; x=1727942582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFuWfnkmIdWwmd2uegsjQr/D9bZQnKbP0CQzDYCAbW4=;
 b=ZWlGtLWkExb4U5U06nQ3skVJyxJWYPrncralkQq5fky8yHk1uFCEJbYU57opShf2fS
 38HQC+6suHC3bbfnHzbtu8+3JBft5LO2NzWh21P0ZGXLLx0Rhcs2AOftsFk07U7/hLQx
 /DnJV+uhoILx0zLMXDC2UXFwkvO7SHdwPSe73+mDx15yURxXlJpT3BIh4wXtMhNYV5Wo
 Buj4EOHaxCVOPJXex2CrSpthgSSH3sUxPXTz6lRd7HrVbvrChE65CrPX2NzKVdq7e44g
 JKDdxjBS4MoltAj/7bAVISMCREdu/04RNpKg3Fd/yV9/ZyKd5SCQPwPxb7mdolhUAFj5
 8PkQ==
X-Gm-Message-State: AOJu0Yx48IF0JpEbNxz+iOLpmHA4KeGga6n8N2Xi7oKvm3bfUVdm0G8S
 vwGZOxnHIaJn+MuBQb9kektx2Cw189oQHDDpOuK9pDx1RPVHmCW3uNsK2ABwmYXrQ6IUarRZBNj
 5
X-Google-Smtp-Source: AGHT+IHpOm4GxEX1ZHi5AcrlF6/4bFF7K8JS8Z3FkemIRAwRKIz4pInLCT6MWGgAxUaPdo3IWax8eg==
X-Received: by 2002:a05:6402:2750:b0:5c7:2209:e937 with SMTP id
 4fb4d7f45d1cf-5c72209eaabmr2722613a12.12.1727337782037; 
 Thu, 26 Sep 2024 01:03:02 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:01 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 21/36] arm: lib: Add GICV2 driver
Date: Thu, 26 Sep 2024 09:59:09 +0200
Message-ID: <20240926080021.148031-22-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

TEST: Booted on QEMU raspb4 using GICV2 driver model generated MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/Kconfig      |  7 ++++
 arch/arm/lib/Makefile |  1 +
 arch/arm/lib/gic-v2.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 arch/arm/lib/gic-v2.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba0359fed5..50327f5349 100644
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
index 0000000000..c9f9f441eb
--- /dev/null
+++ b/arch/arm/lib/gic-v2.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 Broadcom.
+ */
+#include <asm/gic.h>
+#include <asm/acpi_table.h>
+#include <cpu_func.h>
+#include <dm/acpi.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dm.h>
+#include <irq.h>
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
+	if (args->args[0] == GIC_PPI)
+		irq->id = args->args[1] + 16;
+	else
+		irq->id = args->args[1];
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
2.46.0

