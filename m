Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853FBEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9B9891B1;
	Wed, 11 Sep 2024 08:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="J6zjFVRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34B3891AC; Wed, 11 Sep 2024 08:25:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77E2891B1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso98647266b.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035955; x=1726640755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O82NXY4OOxMCW+IffUo9t7GkjADLqx3XbLoFYIl9DJE=;
 b=J6zjFVRajGOKOJIgxJtwFA4t1aVJ6tWQCa1fj3QAhiczfxnnlTLtISDm8Or79UJZd2
 tUwkJp9qqmKV6SoSoLnZAe78UOPOmjA99gByby8KS3rpSn/3uQ5g0o8tcAlAWEz0EJNN
 yT+ORkYtPD/+X+w3xm76IWZOWaOG6d+6fX+ZT06u402SJw/WxEpEL8eN/xwtb14qbzA9
 rnNb07FvjQFetZEIp6or2iJSDusUDS47QjfoJi7YXFxRSPqo14B3YoIPPX43hjaTrU6a
 i3rU8Pvi9BS/Dqi0qYh5OVszrTTdRf3NDDz2kcde3m7YO/4FPIpvC9FhRAEQnfluf0Mc
 w8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035955; x=1726640755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O82NXY4OOxMCW+IffUo9t7GkjADLqx3XbLoFYIl9DJE=;
 b=QSdI/6VtDAAlWkfeTXcG+E/xvkcR8X60wyBLgnL3Ubl5IZaFf+goUOfsLqVtRg/vKf
 9ZnwAYG633AxV3zOU8U4IE6fUfyxtmH0kBaEZalUwQABUjFydAMkuw0vNq9ppm0g8z0E
 1JCWHiAZHuREAMj2NDTRsaAha17QCSone9BshFAwlv64B6KDoHJSt6q+lCsBfVdL6Yst
 0uoHFm/K/8MR3E/1y9KudAmZE4TmDzV+vpDYNkZs/P1YY0PsViW3DR1IYeUbvnvrsCiE
 E5RTrKZgY8zASbqsJFCYc3UYiMwo8R9R+mdSxDXbKMX8FHWmLqeyBF9nJNPd0ejV+hWX
 bSBg==
X-Gm-Message-State: AOJu0YzO7y7NoRfZwiy9BfCNUrnF4pD+eOaIREjGuH6QZAFBaftPQZ1A
 wl3trUs1Eft4VBbPCkPhhYYQkbzwKUoXM7sixaKjfgBEQQjG7NgM+7TulCkuPB4Kn7KXPkx0ubc
 H
X-Google-Smtp-Source: AGHT+IF9wvhZaq400lmvXyRwGUvCfcTqv4LQ6N9nOAuIRi2LNj5VjQzsN2+WPwcoTqltb9zLaDf2QQ==
X-Received: by 2002:a17:906:dc92:b0:a7a:3928:3529 with SMTP id
 a640c23a62f3a-a8ffaaa54d0mr286666966b.13.1726035955028; 
 Tue, 10 Sep 2024 23:25:55 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:54 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
Date: Wed, 11 Sep 2024 08:24:10 +0200
Message-ID: <20240911062511.494855-21-patrick.rudolph@9elements.com>
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

Fill the MADT table in the GIC driver and armv8 CPU driver to
drop SoC specific code. While the GIC only needs devicetree
data, the CPU driver needs additional information stored in
the cpu_plat struct.

While on it update the only board making use of the existing
drivers and writing ACPI MADT in mainboard code.

TEST: Booted on QEMU sbsa using driver model generated MADT.
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/acpi_table.c |  1 +
 arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
 drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
 include/cpu.h             | 27 +++++++++++-
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
index 8c17e9eb36..75a0bc5b6e 100644
--- a/arch/arm/lib/acpi_table.c
+++ b/arch/arm/lib/acpi_table.c
@@ -10,6 +10,7 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
+#include <dm/acpi.h>
 #include <string.h>
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..23769c46b5 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -7,6 +7,8 @@
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <asm/acpi_table.h>
+#include <dm/acpi.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -26,12 +28,14 @@ static u32 lpi_id_bits;
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
@@ -49,12 +53,13 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
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
@@ -158,6 +163,42 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
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
@@ -167,4 +208,50 @@ U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
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
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
index 08b8d45f6f..6dcfc14751 100644
--- a/drivers/cpu/armv8_cpu.c
+++ b/drivers/cpu/armv8_cpu.c
@@ -64,8 +64,35 @@ static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
+static int acpi_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicc *gicc;
+	struct cpu_plat *cpu_plat;
+
+	cpu_plat = dev_get_parent_plat(dev);
+	if (!cpu_plat)
+		return 0;
+
+	gicc = ctx->current;
+	acpi_write_madt_gicc(gicc,
+			     cpu_plat->gicc_cpu_if_num,
+			     cpu_plat->gicc_perf_gsiv,
+			     cpu_plat->gicc_phys_base,
+			     cpu_plat->gicc_gicv,
+			     cpu_plat->gicc_gich,
+			     cpu_plat->gicc_vgic_maint_irq,
+			     cpu_plat->gicc_gicr_base,
+			     cpu_plat->gicc_mpidr,
+			     cpu_plat->gicc_efficiency);
+
+	acpi_inc(ctx, gicc->length);
+
+	return 0;
+}
+
 struct acpi_ops armv8_cpu_acpi_ops = {
 	.fill_ssdt	= acpi_cpu_fill_ssdt,
+	.fill_madt	= acpi_cpu_fill_madt,
 };
 #endif
 
diff --git a/include/cpu.h b/include/cpu.h
index 0018910d61..c2a4ca08fe 100644
--- a/include/cpu.h
+++ b/include/cpu.h
@@ -13,17 +13,29 @@ struct udevice;
 
 /**
  * struct cpu_plat - platform data for a CPU
- * @cpu_id:	   Platform-specific way of identifying the CPU.
+ * @cpu_id:        Platform-specific way of identifying the CPU.
  * @ucode_version: Microcode version, if CPU_FEAT_UCODE is set
  * @device_id:     Driver-defined device identifier
  * @family:        DMTF CPU Family identifier
  * @id:            DMTF CPU Processor identifier
  * @timebase_freq: the current frequency at which the cpu timer timebase
- *		   registers are updated (in Hz)
+ *                 registers are updated (in Hz)
+ * @gicc_cpu_if_num:     GIC's CPU Interface Number
+ * @gicc_perf_gsiv:      The GSIV used for Performance Monitoring Interrupts
+ * @gicc_phys_base:      Address at which the processor can access this
+ *                       GIC CPU Interface
+ * @gicc_gicv:           Address of the GIC virtual CPU interface registers
+ * @gicc_gich:           Address of the GIC virtual interface control block
+ *                       registers
+ * @gicc_vgic_maint_irq: GSIV for Virtual GIC maintenance interrupt
+ * @gicc_gicr_base:      Physical address of the associated Redistributor
+ * @gicc_mpidr:          MPIDR as defined by ARM architecture
+ * @gicc_efficiency:     Describes the relative power efficiency
  *
  * This can be accessed with dev_get_parent_plat() for any UCLASS_CPU
  * device.
  */
+
 struct cpu_plat {
 	int cpu_id;
 	int ucode_version;
@@ -31,6 +43,17 @@ struct cpu_plat {
 	u16 family;
 	u32 id[2];
 	u32 timebase_freq;
+#if defined(CONFIG_GENERATE_ACPI_TABLE)
+	u32 gicc_cpu_if_num;
+	u32 gicc_perf_gsiv;
+	u64 gicc_phys_base;
+	u64 gicc_gicv;
+	u64 gicc_gich;
+	u32 gicc_vgic_maint_irq;
+	u64 gicc_gicr_base;
+	u64 gicc_mpidr;
+	u8  gicc_efficiency;
+#endif
 };
 
 /* CPU features - mostly just a placeholder for now */
-- 
2.46.0

