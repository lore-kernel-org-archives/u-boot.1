Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F0ED16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E438915D;
	Mon, 14 Oct 2024 15:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Yx/uNDAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C5C8916E; Mon, 14 Oct 2024 15:12:46 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D083F8915C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so1943663f8f.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911563; x=1729516363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngD/pkmkE8rsT9tFNAt6RJlTHzD8IIvaTXccCycw8i4=;
 b=Yx/uNDAxSHTph9U8Wak5yooQy7bnN14sF1G0JIthbbvLK+dxLpzPzPjD8PZ4Dl+47C
 38yjMoQW2BRyRFuI0kzGJQirTuwDSUa+ENvYPpSOUNizwf9Wgkdy/MRP07RCDNrj8O5T
 26dCPGnPYn3egpi6UfHcMKcmFedEhW8LkhbVhUYWu//fG2WYVWPG28fqrl79WBtXdg2c
 gWj4Ec8/uo5G9kOrAv37+Y/PmzRtZbN+otm46whfQhq7H7ZDANjC8dQFJlEGBBvIcB5H
 c6L5OvcM7ddyQgQSUQL+189OtgZvaC7ikNflnQJc4jYscxUz0sl7nD77ROC2aOqYsmyQ
 XiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911563; x=1729516363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngD/pkmkE8rsT9tFNAt6RJlTHzD8IIvaTXccCycw8i4=;
 b=w+SBseXIjcnBMnwhK31c0enDj30fdqOIeBS1oFnCCXZek402j4tgqHPwnhMiheyxxm
 LB2GgAn0/i4AQgpRP3x9pRNye8gL8NlCHpC1vOr33k+j44BghJxPwv9m3QN6B8PaEuZT
 glLUwmQ8KieR6PBffim2ci1UNPHZwcZFJo3nZb7PBC9RjC3fW3gK99vzTjs3I7hEzKJk
 XcvHj/2Q+Taw0Hbfyrd/lXXD8hSbrlRQzFyKquXjBnappn6HOhGhS/RA0StPUTSew0o9
 zc75dkBW8Fo7drFzWERct8R7y2K8wZRT/pmT8ZiEl0g2FePGtzFti/7ZN0d4TU5FJRRm
 05AQ==
X-Gm-Message-State: AOJu0YwWRX3UUPdSOdWOkMkhKfSTFLUsZMOb6YesnJk+EJ2Trgy9G5Tb
 9ahrmrFtUSObNjsLEvLTJH9S2l7IRBK2rZzDcoY+T700KI+MuGGOxQbkigtPz/xug93YzAnYNCO
 U
X-Google-Smtp-Source: AGHT+IFKgXmWf5uVFq0PDexYRsxxd+vgekcUvx8nGeaNsmAoWbXJWnwadhBsK6FezjL7pM5SjgU6ZA==
X-Received: by 2002:a5d:5683:0:b0:37d:4517:acdb with SMTP id
 ffacd0b85a97d-37d551d5689mr8351021f8f.20.1728911563097; 
 Mon, 14 Oct 2024 06:12:43 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 21/37] arm: lib: Add GICV2 driver
Date: Mon, 14 Oct 2024 15:10:37 +0200
Message-ID: <20241014131152.267405-22-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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
Changelog v6:
- Update header order

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
index 0000000000..daefd2bfcc
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
2.46.2

