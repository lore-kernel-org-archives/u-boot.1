Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03728EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A718891DF;
	Wed, 11 Sep 2024 08:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="GbQlDH+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A8A891E3; Wed, 11 Sep 2024 08:26:15 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4292C891E6
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so635649066b.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035973; x=1726640773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGJ674XBY16NFxTHQxhdbhsW3wCIH54za21E2TcG5/o=;
 b=GbQlDH+Z6zQHRN+68tK6BGQsyqyU6U287xOTQqAIB7jEDTeX1qsW+PfD3mp4MJ4BYG
 xUTNv2k6iSgBoUDVI41IOAHpC6WT+q+DZ8a21RCHUrdsaTun/CW9fydFY5Djpc4/Xb1J
 Sp5srnXVlGECJ0VCGtLXjl7Kg1FX8aclH+4LeVJ8+FZ6ZIlk/q6l5IHV/l4ar4sq0Pn8
 S1W+mO5cpTgTK2eg5B9sK0ortCyia4CofttS3O0t4zBIPHbFm1C3NDkwaeH+ERgt+UdV
 eaXo24rT1syfjcdYG2shTmgRjD5o6MnHDIipr5PgDyPEbmTPJVF6P02PTuXqIlNA6pz6
 72eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035973; x=1726640773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGJ674XBY16NFxTHQxhdbhsW3wCIH54za21E2TcG5/o=;
 b=ZuLhU6AyhgDHyQDXpwd4VrI5tw82QpJhiOhSCPqi3bzplui/2VjBspWxRWv6lvCFPl
 qSux2YahDN2+9wwaeTSqng/k3Z6rya7f951kLo4eABwe3y48deu9m061qeBmjoLAf4fo
 O+nNirY7iAnBy65kpE629MdrgJC7daQRBhRpzYYZZVQBv9mKEADuFQGKfbnxb5wAUKKQ
 zoVDjR2e6NwsT+2NLidnVi4w+okpDGUF4eqWvYBJaNKE1T/nCg7mxbpl3vg+hNRGmVQ2
 zjwhuuOkzRPnXXYREh0WY60ij4oZIuLy3QvYSHNU9p2hmLhgPuwmNTgNOgm43wKHmbdo
 xT2g==
X-Gm-Message-State: AOJu0YylXoBZdXBOKIsUfQOuOk0Fwg/ZCy2DARP0aBPyivgCUyZ1+hZ/
 OKF+HpUKTEEwywmy0iUjwTUv7YDPnC2pmvKI88hi1rVXLdgC8n/O/iXS+2OE0JJY1UGvlf9gqCl
 xW7c=
X-Google-Smtp-Source: AGHT+IHfNl+pdRaUaqki5lc9tUyHX9TrAslW8GJfk4Yh8PPWwGOERmMGtDo1kJMOpYiVkJnacTjlJw==
X-Received: by 2002:a17:906:f581:b0:a8d:5351:bb22 with SMTP id
 a640c23a62f3a-a8ffae15c25mr284209466b.65.1726035972708; 
 Tue, 10 Sep 2024 23:26:12 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:26:12 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 28/30] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
Date: Wed, 11 Sep 2024 08:24:18 +0200
Message-ID: <20240911062511.494855-29-patrick.rudolph@9elements.com>
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

When ACPI is enabled over FDT the APs cannot be brought out of reset
by the OS using the "FDT spin-table" mechanism, as no FDT is provided
to the OS. The APs must be released out of reset in u-boot and then
brought up in an ACPI compliant fashion.

When ARMV8_MULTIENTRY is specified the APs are released from reset
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

---
 arch/arm/Kconfig              |   1 +
 arch/arm/mach-bcm283x/Kconfig |   2 +
 arch/arm/mach-bcm283x/init.c  |   8 ++
 drivers/cpu/Makefile          |   1 +
 drivers/cpu/bcm283x_cpu.c     | 194 ++++++++++++++++++++++++++++++++++
 5 files changed, 206 insertions(+)
 create mode 100644 drivers/cpu/bcm283x_cpu.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 588e293bf2..17cd3d44b6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -644,6 +644,7 @@ config ARCH_ORION5X
 
 config ARCH_BCM283X
 	bool "Broadcom BCM283X family"
+	select CPU
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index b3287ce8bc..de783aa8f5 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -12,6 +12,7 @@ config BCM2836
 config BCM2837
 	bool "Broadcom BCM2837 SoC support"
 	depends on ARCH_BCM283X
+	select ARCH_EARLY_INIT_R
 
 config BCM2837_32B
 	bool "Broadcom BCM2837 SoC 32-bit support"
@@ -29,6 +30,7 @@ config BCM2837_64B
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
 	depends on ARCH_BCM283X
+	select ARCH_EARLY_INIT_R
 
 config BCM2711_32B
 	bool "Broadcom BCM2711 SoC 32-bit support"
diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7a1de22e0a..e6946c6e94 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -9,6 +9,7 @@
 #include <cpu_func.h>
 #include <init.h>
 #include <dm/device.h>
+#include <dm/uclass.h>
 #include <fdt_support.h>
 #include <asm/global_data.h>
 
@@ -199,7 +200,14 @@ int mach_cpu_init(void)
 					       "brcm,bcm2712-pm");
 	if (offset > soc)
 		rpi_wdog_base = fdt_get_base_address(gd->fdt_blob, offset);
+	return 0;
+}
+
+int arch_early_init_r(void)
+{
+	struct udevice *dev;
 
+	uclass_first_device(UCLASS_CPU, &dev);
 	return 0;
 }
 
diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
index 773395693a..5230408cc0 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_CPU) += cpu-uclass.o
 
 
+obj-$(CONFIG_ARCH_BCM283X) += bcm283x_cpu.o
 obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
 obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
 obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
new file mode 100644
index 0000000000..11dd3008cc
--- /dev/null
+++ b/drivers/cpu/bcm283x_cpu.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <asm/armv8/cpu.h>
+#include <asm-generic/sections.h>
+#include <cpu.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <fdt_support.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int cpu_bcm_get_desc(const struct udevice *dev, char *buf, int size)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+	const char *name;
+	int ret;
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
+	ret = snprintf(buf, size, "Broadcom Cortex-%s at %u MHz",
+		       name, plat->timebase_freq);
+
+	snprintf(buf + ret, size - ret, "\n");
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
+	return 0;
+}
+
+static int cpu_bcm_get_count(const struct udevice *dev)
+{
+	ofnode node;
+	int num = 0;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
+		const char *device_type;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		device_type = ofnode_read_string(node, "device_type");
+		if (!device_type)
+			continue;
+
+		if (!strcmp(device_type, "cpu"))
+			num++;
+	}
+
+	return num;
+}
+
+static int cpu_bcm_get_vendor(const struct udevice *dev,  char *buf, int size)
+{
+	snprintf(buf, size, "Broadcom");
+	return 0;
+}
+
+#ifdef CONFIG_ARM64
+static int cpu_bcm_is_current(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	if (plat->cpu_id == (read_mpidr() & 0xffff))
+		return 1;
+
+	return 0;
+}
+#endif
+
+static int bcm_cpu_on(struct udevice *dev)
+{
+	ofnode node = dev_ofnode(dev);
+	uintptr_t *start_address;
+	u64 release_addr64;
+	const char *prop;
+
+	if (!ofnode_is_enabled(node))
+		return 0;
+
+	prop = ofnode_read_string(node, "enable-method");
+	if (!prop || strcmp(prop, "spin-table"))
+		return 1;
+
+	release_addr64 = ofnode_read_u64_default(node, "cpu-release-addr", ~0ULL);
+	if (release_addr64 == ~0ULL)
+		return 1;
+
+	start_address = map_physmem(release_addr64, sizeof(uintptr_t), MAP_NOCACHE);
+
+	/* Point to U-Boot start */
+	*start_address = (uintptr_t)_start;
+	flush_dcache_all();
+
+	/* Send an event to wake up the secondary CPU. */
+	asm("dsb	ishst\n"
+	    "sev");
+	udelay(10000);
+
+	unmap_physmem(start_address, MAP_NOCACHE);
+	return 0;
+}
+
+static int bcm_init(struct udevice *dev)
+{
+	int ret = 0;
+
+	/* The armstub holds the secondary CPUs in a spinloop. When
+	 * ARMV8_MULTIENTRY is enabled release the secondary CPUs and
+	 * let them enter U-Boot as well.
+	 */
+	if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY))
+		ret = bcm_cpu_on(dev);
+	return ret;
+}
+
+static const struct cpu_ops cpu_bcm_ops = {
+	.get_desc	= cpu_bcm_get_desc,
+	.get_info	= cpu_bcm_get_info,
+	.get_count	= cpu_bcm_get_count,
+	.get_vendor	= cpu_bcm_get_vendor,
+#ifdef CONFIG_ARM64
+	.is_current	= cpu_bcm_is_current,
+#endif
+};
+
+static const struct udevice_id cpu_bcm_ids[] = {
+	{ .compatible = "arm,cortex-a53" },	/* RPi 3 */
+	{ .compatible = "arm,cortex-a72" },	/* RPi 4 */
+	{ }
+};
+
+static int cpu_bcm_bind(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	plat->cpu_id = dev_read_addr(dev);
+
+	return bcm_init(dev);
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
+		if (!IS_ERR_VALUE(ret))
+			plat->timebase_freq = ret;
+	}
+
+	return ret;
+}
+
+U_BOOT_DRIVER(cpu_bcm_drv) = {
+	.name		= "bcm283x_cpu",
+	.id		= UCLASS_CPU,
+	.of_match	= cpu_bcm_ids,
+	.ops		= &cpu_bcm_ops,
+	.probe		= bcm_cpu_probe,
+	.bind		= cpu_bcm_bind,
+	.flags		= 0,
+};
-- 
2.46.0

