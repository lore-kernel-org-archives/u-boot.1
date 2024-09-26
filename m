Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04E0CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B1888DE9;
	Thu, 26 Sep 2024 10:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DfF7nanS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C68F88D92; Thu, 26 Sep 2024 10:03:11 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88C782BA7
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53653682246so883017e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337786; x=1727942586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96H3w6HMmmfsUmrWiMXMksE1ylPCmIYRyhIyK7MqKhE=;
 b=DfF7nanSrKZveYy8ox2CZS5TAlJ3zGkLUU4mIZYH3U9n1bqWeSU2gsooZIye6g6Rl3
 gi33d2/BHl5CBvdTopKSHirI1RsgZBCkW/1o3JrtRahaPOQ/B4EMj+FLFuRNULh3J6AU
 FNQoCMd/fEaQnuxTI+Dz+t/ktmRdfLAaaqp9utUb8GBQURLxguzsXsHYuEIM+y5PNBXg
 HhkKCa8Yntei4thuMlepQN6QTVB2VZiYcccOl6qVmoT/QZUkPUbbIVZE3E0c1h6ifGs2
 kPJZDfVcHl82vjgdy9L9zCE3vsB0I8tLRV27xnnquY1EroE0uXNVs/8+JkewIZFub2eP
 9CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337786; x=1727942586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96H3w6HMmmfsUmrWiMXMksE1ylPCmIYRyhIyK7MqKhE=;
 b=Ou/pNxjTDXaREWtgUn/Ko0yiXZLabvk+CkSl51QQUzAx4D9s3LClihNWc4CihmuBZ7
 zyOCon+qrRm3dk0RBajiDZR9LJAyqzGOROCBm8FONLbyjKENzk6q75DXaNsLp7rliNee
 sAdSnZmR6uPyms4N3QLcDNFcpcu3oW7QzrNT1AfAkLFC+n609wyvYxbOq7imlQPsUKKE
 w4K4iD1ISl8GrB0ke+NG4B9wh39cu7pQcgYfgwoRyfKhoZVLb1EbQ4Ztxn8mkeJuimz1
 EViX7rLb3sY0gj5/tqftTlhFCJUtlFHpdYKn7YD28UX61Ofes5lz+cLJuqs2tnntltiM
 EDWw==
X-Gm-Message-State: AOJu0Ywc3XM/4UEIcIwgzYrlF0A6LcC7SZFwUuBgC6pQheU/wC77XQrB
 GRrrP6b0WCN72ICWv8qYzHOZ1B+UjUTBng/v3e59NKnrcw08x/+P22ytEsFAUD3w77+xsaTLgFE
 W
X-Google-Smtp-Source: AGHT+IElOjmZ0caqk1xodhY+yjTo8884O5S7ARaawfO3tgRUZ/YD6nwdmeE9/UrYw/wF4WQrJ3Om2w==
X-Received: by 2002:a05:6512:e93:b0:535:65ce:e901 with SMTP id
 2adb3069b0e04-53872bc09efmr3568693e87.4.1727337786007; 
 Thu, 26 Sep 2024 01:03:06 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:05 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 23/36] drivers/arm: Implement acpi_fill_madt
Date: Thu, 26 Sep 2024 09:59:11 +0200
Message-ID: <20240926080021.148031-24-patrick.rudolph@9elements.com>
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

Fill the MADT table in the GIC driver and armv8 CPU driver to
drop SoC specific code. While the GIC only needs devicetree
data, the CPU driver needs additional information stored in
the cpu_plat struct.

While on it update the only board making use of the existing
drivers and writing ACPI MADT in mainboard code.

TEST: Booted on QEMU sbsa-ref using GICV3 driver model generated MADT.
      Booted on QEMU raspb4 using GICV2 driver model generated MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v4:
- Read everything from the DT
- Export armv8_cpu_fill_madt() to use it in other CPU drivers
- Depend on IRQ

---
 arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
 drivers/cpu/Kconfig       |  1 +
 drivers/cpu/armv8_cpu.c   | 80 ++++++++++++++++++++++++++++++++++-
 drivers/cpu/armv8_cpu.h   | 10 +++++
 4 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 54dbff434c..f733ca36d3 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -7,6 +7,8 @@
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <asm/acpi_table.h>
+#include <dm/acpi.h>
 #include <irq.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
@@ -27,12 +29,14 @@ static u32 lpi_id_bits;
 struct gic_v3_its_priv {
 	ulong gicd_base;
 	ulong gicr_base;
+	ulong gicr_length;
 };
 
 static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 {
 	struct udevice *dev;
 	fdt_addr_t addr;
+	fdt_size_t size;
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_IRQ,
@@ -50,12 +54,13 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 	}
 	priv->gicd_base = addr;
 
-	addr = dev_read_addr_index(dev, 1);
+	addr = dev_read_addr_size_index(dev, 1, &size);
 	if (addr == FDT_ADDR_T_NONE) {
 		pr_err("%s: failed to get GICR address\n", __func__);
 		return -EINVAL;
 	}
 	priv->gicr_base = addr;
+	priv->gicr_length = size;
 
 	return 0;
 }
@@ -159,6 +164,42 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	return 0;
 }
 
+#ifdef CONFIG_ACPIGEN
+/**
+ * acpi_gicv3_fill_madt() - Fill out the body of the MADT
+ *
+ * Write GICD and GICR tables based on collected devicetree data.
+ *
+ * @dev: Device to write ACPI tables for
+ * @ctx: ACPI context to write MADT sub-tables to
+ * Return: 0 if OK
+ */
+static int acpi_gicv3_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicd *gicd;
+	struct acpi_madt_gicr *gicr;
+
+	struct gic_v3_its_priv priv;
+
+	if (gic_v3_its_get_gic_addr(&priv))
+		return -EINVAL;
+
+	gicd = ctx->current;
+	acpi_write_madt_gicd(gicd, dev_seq(dev), priv.gicd_base, 3);
+	acpi_inc(ctx, gicd->length);
+
+	gicr = ctx->current;
+	acpi_write_madt_gicr(gicr, priv.gicr_base, priv.gicr_length);
+	acpi_inc(ctx, gicr->length);
+
+	return 0;
+}
+
+struct acpi_ops gic_v3_acpi_ops = {
+	.fill_madt	= acpi_gicv3_fill_madt,
+};
+#endif
+
 static const struct udevice_id gic_v3_ids[] = {
 	{ .compatible = "arm,gic-v3" },
 	{}
@@ -188,4 +229,50 @@ U_BOOT_DRIVER(arm_gic_v3) = {
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
 	.ops		= &arm_gic_v3_ops,
+	ACPI_OPS_PTR(&gic_v3_acpi_ops)
+};
+
+#ifdef CONFIG_ACPIGEN
+/**
+ * acpi_gic_its_fill_madt() - Fill out the body of the MADT
+ *
+ * Write ITS tables based on collected devicetree data.
+ *
+ * @dev: Device to write ACPI tables for
+ * @ctx: ACPI context to write MADT sub-tables to
+ * Return: 0 if OK
+ */
+static int acpi_gic_its_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_its *its;
+	fdt_addr_t addr;
+
+	addr = dev_read_addr_index(dev, 0);
+	if (addr == FDT_ADDR_T_NONE) {
+		pr_err("%s: failed to get GIC ITS address\n", __func__);
+		return -EINVAL;
+	}
+
+	its = ctx->current;
+	acpi_write_madt_its(its, dev_seq(dev), addr);
+	acpi_inc(ctx, its->length);
+
+	return 0;
+}
+
+struct acpi_ops gic_v3_its_acpi_ops = {
+	.fill_madt	= acpi_gic_its_fill_madt,
+};
+#endif
+
+static const struct udevice_id gic_v3_its_ids[] = {
+	{ .compatible = "arm,gic-v3-its" },
+	{}
+};
+
+U_BOOT_DRIVER(arm_gic_v3_its) = {
+	.name		= "gic-v3-its",
+	.id		= UCLASS_IRQ,
+	.of_match	= gic_v3_its_ids,
+	ACPI_OPS_PTR(&gic_v3_its_acpi_ops)
 };
diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 9c0df331d7..4cc3679c00 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -29,6 +29,7 @@ config CPU_RISCV
 config CPU_ARMV8
 	bool "Enable generic ARMv8 CPU driver"
 	depends on CPU && ARM64
+	select IRQ
 	help
 	  Support CPU cores for armv8 architecture.
 
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
index 1572e087e0..9434e7948f 100644
--- a/drivers/cpu/armv8_cpu.c
+++ b/drivers/cpu/armv8_cpu.c
@@ -4,10 +4,11 @@
  */
 #include <acpi/acpigen.h>
 #include <asm/armv8/cpu.h>
+#include <asm/io.h>
 #include <cpu.h>
 #include <dm.h>
 #include <dm/acpi.h>
-#include <asm/io.h>
+#include <irq.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -47,8 +48,85 @@ int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
+int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicc *gicc;
+	struct cpu_plat *cpu_plat;
+	struct udevice *gic;
+	u64 gicc_gicv = 0;
+	u64 gicc_gich = 0;
+	u64 gicc_gicr_base = 0;
+	u64 gicc_phys_base = 0;
+	u32 gicc_perf_gsiv = 0;
+	u64 gicc_mpidr;
+	u32 gicc_vgic_maint_irq = 0;
+	int addr_index;
+	fdt_addr_t addr;
+	int ret;
+	struct irq req_irq;
+
+	cpu_plat = dev_get_parent_plat(dev);
+	if (!cpu_plat)
+		return 0;
+
+	ret = irq_get_interrupt_parent(dev, &gic);
+	if (ret) {
+		log_err("%s: Failed to find interrupt parent for %s\n",
+			__func__, dev->name);
+		return -ENODEV;
+	}
+
+	addr_index = 1;
+
+	if (device_is_compatible(gic, "arm,gic-v3")) {
+		addr = dev_read_addr_index(gic, addr_index++);
+		if (addr != FDT_ADDR_T_NONE)
+			gicc_gicr_base = addr;
+	}
+
+	addr = dev_read_addr_index(gic, addr_index++);
+	if (addr != FDT_ADDR_T_NONE)
+		gicc_phys_base = addr;
+
+	addr = dev_read_addr_index(gic, addr_index++);
+	if (addr != FDT_ADDR_T_NONE)
+		gicc_gich = addr;
+
+	addr = dev_read_addr_index(gic, addr_index++);
+	if (addr != FDT_ADDR_T_NONE)
+		gicc_gicv = addr;
+
+	ret = irq_get_by_index(gic, 0, &req_irq);
+	if (!ret)
+		gicc_vgic_maint_irq = req_irq.id;
+
+	gicc_mpidr = dev_read_u64_default(dev, "reg", 0);
+	if (!gicc_mpidr)
+		gicc_mpidr = dev_read_u32_default(dev, "reg", 0);
+
+	/*
+	 * gicc_vgic_maint_irq and gicc_gicv are the same for every CPU
+	 */
+	gicc = ctx->current;
+	acpi_write_madt_gicc(gicc,
+			     dev_seq(dev),
+			     gicc_perf_gsiv, /* FIXME: needs a PMU driver */
+			     gicc_phys_base,
+			     gicc_gicv,
+			     gicc_gich,
+			     gicc_vgic_maint_irq,
+			     gicc_gicr_base,
+			     gicc_mpidr,
+			     0); /* FIXME: Not defined in DT */
+
+	acpi_inc(ctx, gicc->length);
+
+	return 0;
+}
+
 struct acpi_ops armv8_cpu_acpi_ops = {
 	.fill_ssdt	= armv8_cpu_fill_ssdt,
+	.fill_madt	= armv8_cpu_fill_madt,
 };
 #endif
 
diff --git a/drivers/cpu/armv8_cpu.h b/drivers/cpu/armv8_cpu.h
index 2c4b0252cf..48c705e98d 100644
--- a/drivers/cpu/armv8_cpu.h
+++ b/drivers/cpu/armv8_cpu.h
@@ -18,4 +18,14 @@
  */
 int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx);
 
+/**
+ * armv8_cpu_fill_madt() - Fill the MADT
+ * Parses the FDT and writes the MADT subtables.
+ *
+ * @dev: cpu device to generate ACPI tables for
+ * @ctx: ACPI context pointer
+ * @return:	0 if OK, or a negative error code.
+ */
+int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx);
+
 #endif
\ No newline at end of file
-- 
2.46.0

