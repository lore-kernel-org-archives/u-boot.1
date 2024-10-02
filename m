Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF370CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B561892F2;
	Wed,  2 Oct 2024 11:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="X0dux5QJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6538909E; Wed,  2 Oct 2024 11:53:03 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB73892F3
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cdac05af9so4101564f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862779; x=1728467579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JncLcNqriZE75+wHB8ZOXznoILes/Oe2M4sLv2kyUuQ=;
 b=X0dux5QJ98S/n0CDaPDkYLZc25rJQ2oWfCAG8+N+I2B11h5AqLtG3pdVKB/ICHETwj
 SzUnH+e7ZZcjPpw8thl72bJ70LUcCynRD+rXqZz8Xr6C8rU37phPUDwzoHnuFWrV+04y
 gU6y3Fhp/HQdllUg+8bj40nkSLFTasQTGkSLwdrmirtSd7S0xi0TLVoH4B1rScgA7wiZ
 HTBwsepzrUlCiwcEBij6vQgLsEXdvI+7Rf0EGhu7cp3k0ak1e5eEcqCw79Xjbtlmo2Ro
 xzKPL3Faj1LQz0MDHonfZ9jPvVAaan7wUTicuiN9R7Vd6ucm0WBhZPygFwxQc7JRmK3j
 qXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862779; x=1728467579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JncLcNqriZE75+wHB8ZOXznoILes/Oe2M4sLv2kyUuQ=;
 b=FLo6Mi3O4OTNVDSEA3+rCgoAD9z4JDyowFDrw8ibGWnMGXY9wQwMn34we6GCO/V8R/
 6SYQPA+kGccfNudKT5P3F/1Z9xC6Q3enhG1OWNTMJicFj7o7kt2+Bkk0W2SbRfQaXw0W
 +81IG0X16xGv8WfLXm2jA0Ox7dy9/8+BHS6z1KKUzQEelNNTQ6qVHCHiWYwBg2PAxibD
 Vn2wNf6sLN5G9cU8Y1tD6LpVx4uJ8z7mEhaXd2FIq9GjhE6o30hDdwbEBnDRp+ki74jA
 kk3ve0tITTx19LSBbhU7YUe9rUtxMHRb/n3xtaSvWpaW5/A+oHMX7OxJeOJh+AHfF4Lq
 Sx6Q==
X-Gm-Message-State: AOJu0YxCBMahiQIjnTY6bV9SYyLDEDGdYQ2zPx3lVj/Wpd8zc1fYUwsv
 kmeXId1Ofbq6RNSy+0IqTYxPo7HsecUsgC/h3k8xNzvQ6h4xOUrlEigliRf4a5QVbNHbMwVeSJD
 i
X-Google-Smtp-Source: AGHT+IH0tziHpQYQjFgnj7thhuk/17G3zI9JwkP/me1f1GSPlp/D0SUnt4yH8r1vPUqiKe+CHHSU1w==
X-Received: by 2002:adf:f04e:0:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-37cfba19c49mr2535922f8f.53.1727862778733; 
 Wed, 02 Oct 2024 02:52:58 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:58 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v6 33/37] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
Date: Wed,  2 Oct 2024 11:47:24 +0200
Message-ID: <20241002094832.24933-34-patrick.rudolph@9elements.com>
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

When ACPI is enabled over FDT the APs cannot be brought out of reset
by the OS using the "FDT spin-table" mechanism, as no FDT is provided
to the OS. The APs must be released out of reset in u-boot and then
brought up in an ACPI compliant fashion.

When ARMV8_MULTIENTRY is specified, the APs are released from reset
and will enter U-Boot after it has been relocated as well.

By default ARMV8_MULTIENTRY is not selected, keeping existing behaviour.

TEST: All APs enter U-Boot when run on qemu-system-aarch64 and on
      real hardware.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v2:
- Drop CPU code from board
- Add CPU driver to release APs from reset
Changelog v4:
- Use the generic armv8 CPU driver
- Probe all CPUs
- Release secondary CPUs in the probe function
- Use of_to_plat() to parse DT
- Drop udelay()
- Select the GICv2 driver
Changelog v5:
- Cosmetic fixes
- Drop arch_early_init_r()
Changelog v6:
- Update header order
- Drop ifdef
---
 arch/arm/Kconfig              |   1 +
 arch/arm/mach-bcm283x/Kconfig |   5 +-
 drivers/cpu/Makefile          |   2 +-
 drivers/cpu/bcm283x_cpu.c     | 214 ++++++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cpu/bcm283x_cpu.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 985dd8f3da..94ab271370 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -651,6 +651,7 @@ config ARCH_ORION5X
 
 config ARCH_BCM283X
 	bool "Broadcom BCM283X family"
+	select CPU
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index b3287ce8bc..0ef8156c64 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -24,7 +24,9 @@ config BCM2837_64B
 	bool "Broadcom BCM2837 SoC 64-bit support"
 	depends on ARCH_BCM283X
 	select BCM2837
+	select DRIVER_GICV2
 	select ARM64
+	select CPU_ARMV8
 
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
@@ -42,11 +44,12 @@ config BCM2711_64B
 	bool "Broadcom BCM2711 SoC 64-bit support"
 	depends on ARCH_BCM283X
 	select BCM2711
+	select DRIVER_GICV2
 	select ARM64
+	select CPU_ARMV8
 
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
-
 choice
 	prompt "Broadcom BCM283X board select"
 	optional
diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
index 773395693a..eaf494706e 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -6,7 +6,7 @@
 
 obj-$(CONFIG_CPU) += cpu-uclass.o
 
-
+obj-$(CONFIG_ARCH_BCM283X) += bcm283x_cpu.o
 obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
 obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
 obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
new file mode 100644
index 0000000000..59a7b142c9
--- /dev/null
+++ b/drivers/cpu/bcm283x_cpu.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+
+#include <cpu.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <fdt_support.h>
+#include <acpi/acpigen.h>
+#include <asm/armv8/cpu.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <asm-generic/sections.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include "armv8_cpu.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct bcm_plat {
+	u64 release_addr;
+};
+
+static int cpu_bcm_get_desc(const struct udevice *dev, char *buf, int size)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+	const char *name;
+
+	if (size < 32)
+		return -ENOSPC;
+
+	if (device_is_compatible(dev, "arm,cortex-a53"))
+		name = "A53";
+	else if (device_is_compatible(dev, "arm,cortex-a72"))
+		name = "A72";
+	else
+		name = "?";
+
+	snprintf(buf, size, "Broadcom Cortex-%s at %u MHz\n",
+		 name, plat->timebase_freq);
+
+	return 0;
+}
+
+static int cpu_bcm_get_info(const struct udevice *dev, struct cpu_info *info)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	info->cpu_freq = plat->timebase_freq * 1000;
+	info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
+
+	return 0;
+}
+
+static int cpu_bcm_get_count(const struct udevice *dev)
+{
+	return uclass_id_count(UCLASS_CPU);
+}
+
+static int cpu_bcm_get_vendor(const struct udevice *dev,  char *buf, int size)
+{
+	snprintf(buf, size, "Broadcom");
+
+	return 0;
+}
+
+static int cpu_bcm_is_current(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	if (plat->cpu_id == (read_mpidr() & 0xffff))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * bcm_cpu_on - Releases the secondary CPU from it's spintable
+ *
+ * Write the CPU's spintable mailbox and let the CPU enter U-Boot.
+ *
+ * @dev: Device to start
+ * @return: zero on success or error code on failure.
+ */
+static int bcm_cpu_on(struct udevice *dev)
+{
+	struct bcm_plat *plat = dev_get_plat(dev);
+	ulong *start_address;
+
+	if (plat->release_addr == ~0ULL)
+		return -ENODATA;
+
+	start_address = map_physmem(plat->release_addr, sizeof(uintptr_t), MAP_NOCACHE);
+
+	/* Point secondary CPU to U-Boot entry */
+	*start_address = (uintptr_t)_start;
+
+	/* Make sure the other CPUs see the written start address */
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		flush_dcache_all();
+
+	/* Send an event to wake up the secondary CPU. */
+	asm("dsb	ishst\n"
+	    "sev");
+
+	unmap_physmem(start_address, MAP_NOCACHE);
+
+	return 0;
+}
+
+static const struct cpu_ops cpu_bcm_ops = {
+	.get_desc	= cpu_bcm_get_desc,
+	.get_info	= cpu_bcm_get_info,
+	.get_count	= cpu_bcm_get_count,
+	.get_vendor	= cpu_bcm_get_vendor,
+	.is_current	= cpu_bcm_is_current,
+};
+
+static const struct udevice_id cpu_bcm_ids[] = {
+	{ .compatible = "arm,cortex-a53" },	/* RPi 3 */
+	{ .compatible = "arm,cortex-a72" },	/* RPi 4 */
+	{ }
+};
+
+static int bcm_cpu_bind(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	plat->cpu_id = dev_read_addr(dev);
+
+	return 0;
+}
+
+/**
+ * bcm_cpu_of_to_plat - Gather spin-table release address
+ *
+ * Read the spin-table release address to allow all seconary CPUs to enter
+ * U-Boot when necessary.
+ *
+ * @dev: Device to start
+ */
+static int bcm_cpu_of_to_plat(struct udevice *dev)
+{
+	struct bcm_plat *plat = dev_get_plat(dev);
+	const char *prop;
+
+	if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
+		plat->release_addr = ~0ULL;
+
+		prop = dev_read_string(dev, "enable-method");
+		if (!prop || strcmp(prop, "spin-table"))
+			return -ENODEV;
+
+		plat->release_addr = dev_read_u64_default(dev, "cpu-release-addr", ~0ULL);
+
+		if (plat->release_addr == ~0ULL)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int bcm_cpu_probe(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+	struct clk clk;
+	int ret;
+
+	/* Get a clock if it exists */
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (!ret) {
+		ret = clk_enable(&clk);
+		if (ret && (ret != -ENOSYS || ret != -EOPNOTSUPP))
+			return ret;
+		ret = clk_get_rate(&clk);
+		if (IS_ERR_VALUE(ret))
+			return ret;
+		plat->timebase_freq = ret;
+	}
+
+	/*
+	 * The armstub holds the secondary CPUs in a spinloop. When
+	 * ARMV8_MULTIENTRY is enabled release the secondary CPUs and
+	 * let them enter U-Boot as well.
+	 */
+	if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
+		ret = bcm_cpu_on(dev);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+struct acpi_ops bcm283x_cpu_acpi_ops = {
+	.fill_ssdt	= armv8_cpu_fill_ssdt,
+	.fill_madt	= armv8_cpu_fill_madt,
+};
+
+U_BOOT_DRIVER(cpu_bcm_drv) = {
+	.name		= "bcm283x_cpu",
+	.id		= UCLASS_CPU,
+	.of_match	= cpu_bcm_ids,
+	.ops		= &cpu_bcm_ops,
+	.probe		= bcm_cpu_probe,
+	.bind		= bcm_cpu_bind,
+	.of_to_plat	= bcm_cpu_of_to_plat,
+	.plat_auto	= sizeof(struct bcm_plat),
+	ACPI_OPS_PTR(&bcm283x_cpu_acpi_ops)
+};
-- 
2.46.2

