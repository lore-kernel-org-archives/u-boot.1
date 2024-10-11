Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF26CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044C389329;
	Fri, 11 Oct 2024 12:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="fmCM83jP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9D8892FB; Fri, 11 Oct 2024 12:35:08 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD6389352
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fad100dd9fso29285531fa.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642905; x=1729247705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngD/pkmkE8rsT9tFNAt6RJlTHzD8IIvaTXccCycw8i4=;
 b=fmCM83jPBAz94undQ0KpLXz+YzceWaZ/FfwJCOFtM+m36gCOUua5peIVH/tqHDAMb8
 ERvEBnn7YXn0b9PBa6b1SlLuve9eohLINFpfSBizAfEy/K6Gnzp+ZUavgVvvDNwf82EZ
 Dlr6Pcc+b2GFV3J0ddrfeXKfXfeMDwtjZtdc15ijWcabskg1Tk598JbaWu3iMXgUa8Pu
 V6hyXjMgmfdT0JPtbjA4KsFlieIhD/n11K7uXFUCVCAJNdU5v0i1MQpLLFw9CXTXW8X+
 tqqPFOeJdksbQQ5bxF33jMSpFpOnifj13L1MHEudowoT50SAH4jrT6hfC1HM+gDr2s0f
 tHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642905; x=1729247705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngD/pkmkE8rsT9tFNAt6RJlTHzD8IIvaTXccCycw8i4=;
 b=dLzkiBGLAyvJ6kXh+CdUj4ltNCgMQMQ8W6WzblUhHi03dwkvuMcTTMSrMJi4fydWFG
 EctPqI5SjGeQYnCtlkMGrL8OBTdLONe+jJ/fwlFyuTLGaF++lm8x9V/XYpWtIeoUXmCy
 MVXTZ/U/g6+yA8r9uyzGjmHeme48HkHogRVjw14+kQweT9Bn2XeJqvSYZz/8neSbF89+
 FgqggJFoTnYPjZx1w16Z7XTPJCboTkJIECzdRT0VH5dN/v9lqXbSr8oQsDa6n2y4b6qh
 1/ERv8r0+EU9b6yFh8AfTpYygcopyWVSZUs4uUvQuf+qVcKoHWHPxJfzshqinHTydNWq
 pkIg==
X-Gm-Message-State: AOJu0YwPmhXm+7YSe2LMILi3q8FfcPgCyZkjzKsTRbcgoHeHlSL0ibvY
 v/U9ywkA/jnuSE0tw8HEzYgm5cWbufS4UnATb2c1b0Us5+avkjHqujOnXchZBiD0WBFCKTibceO
 iUfg=
X-Google-Smtp-Source: AGHT+IE84xBFsRPej3C7SOjl2iQx0aPwoDkkmQco/HVyzRecY9iquJADdz+fTUEire/DJvhsVWNsvA==
X-Received: by 2002:a2e:a990:0:b0:2f6:6198:1cfa with SMTP id
 38308e7fff4ca-2fb329ebb6bmr14834271fa.41.1728642905223; 
 Fri, 11 Oct 2024 03:35:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 21/37] arm: lib: Add GICV2 driver
Date: Fri, 11 Oct 2024 12:23:02 +0200
Message-ID: <20241011102419.12523-22-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

