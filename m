Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC23E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667418032B;
	Fri, 20 Dec 2024 01:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ASiZ6nKc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ckYasqzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5858033A; Fri, 20 Dec 2024 01:03:51 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215BC80312
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YDnh35ZxPz9tV4;
 Fri, 20 Dec 2024 01:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbqAMIXdDPla/NWD1liyKANGn/4MDJWFL2C5DtYgtUo=;
 b=ASiZ6nKcm8tomMk5cVniXA8PSq0NZbBUznlkxCgp6KNUUsWjEsjkbZH65RF3Eo7pkHLyMT
 Tv6oHxn5G1pEGLeY2Mw0s1we8h+6+7GAaHvI1tG2AyX3uhX86HhFGfS/adChT5WjMAgC+1
 AIjc+PFVec2m8JJ+i1kS3VWDyJZwhz+6eBDzrd3fYyvkwPcPh01B1B0Vb9V8ePvKzjG/Gq
 NmTtAZG5fyHpNBJHJpMTqngsk6kXSs4q6AigCzMlTnrANUma8yk+6dul5O+C5+AouCqIDb
 nYimjcZKMA7/ng4yx7L5bfxl9txShSctKVSBMu7+MU9jlJh7o6+XaRPn62zxhg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbqAMIXdDPla/NWD1liyKANGn/4MDJWFL2C5DtYgtUo=;
 b=ckYasqziBqgQYiCk1HJXQo1S86lkXAbR2bvroLHV+5OR/6Bgz0YlrnwCQ5e5GPu48ZfNc2
 3FHwh95r03GnLZo+uLqxhyEkY2guzYvdc+Jbxc0tuGe8IaiuMqKWwY8dDNsdTv2a8Ualso
 kqwIfX3TkIj0WT8G6zx7pr8ejkTiZU2aBH7L0ySfutZiG2v+sibsXgbTMjIHaqd1Uc8Kfo
 RrZ6JUFrvxb2m+u6ujDzMSONU+8TsomUBigXD8t/gzzTmJOmK1njqerSRl57W36DnGWfGS
 M5W5wC6baxg+9aHeOGYELl+GcGnK3EA0ObtsKZ0FLWpgYIkeJFeumUXc3mTEFA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] remoteproc: renesas: Add Renesas R-Car Gen4 remote
 processor driver
Date: Fri, 20 Dec 2024 01:02:14 +0100
Message-ID: <20241220000320.167110-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ofnig83sd6u79ddus8xep4aujjt3mkgs
X-MBO-RS-ID: 51c787b387defb910b3
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

Add R-Car Gen4 APMU controller remoteproc driver capable of starting
the Cortex-R52 cores in Renesas R8A779G0 V4H/V4M SoC. The APMU IP is
in fact a power management unit capable of additional operations, but
those are not used by U-Boot so far.

This requires slight adjustment to the SPL entry point code, as that
is being executed on the Cortex-R52 #0 and the Cortex-R52 #0 enters an
endless loop once it starts the rest of the SPL on Cortex-A76 core.
The endless loop now checks for content of APMU CRBARP registers and
tests whether valid VLD_BARP and BAREN_VALID bits are set, if so, the
Cortex-R52 core exits the endless loop and jumps to address started
in CRBARP[31:18] register in ARM mode, which is a trampoline code to
jump to the final entry point.

The trampoline code is in place to avoid limitation of CRBARP[31:18]
address field, which limits the core start address to memory addresses
aligned to 0x40000 or 256 kiB . The trampoline is placed at 0x40000
aligned address and jumps to the final entry point, which can be at
an address with arbitrary alignment at instruction granularity.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/include/mach/boot0.h |  28 ++-
 drivers/remoteproc/Kconfig                 |   8 +
 drivers/remoteproc/Makefile                |   1 +
 drivers/remoteproc/renesas_apmu.c          | 266 +++++++++++++++++++++
 4 files changed, 293 insertions(+), 10 deletions(-)
 create mode 100644 drivers/remoteproc/renesas_apmu.c

diff --git a/arch/arm/mach-renesas/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
index 9cc0b819e4d..f7886d8c300 100644
--- a/arch/arm/mach-renesas/include/mach/boot0.h
+++ b/arch/arm/mach-renesas/include/mach/boot0.h
@@ -28,19 +28,19 @@ _start:
 	/* r1=0xe6170800 */
 	.inst	0xe3a004e6	/* mov     r0,     #0xe6000000 */
 	.inst	0xe3801817	/* orr     r1, r0, #0x170000 */
-	.inst	0xe3811b02	/* orr     r1, r1, #0x800 */
+	.inst	0xe3814b02	/* orr     r4, r1, #0x800 */
 
 	/* r0=0xe6280000 */
 	.inst	0xe380070a	/* orr     r0, r0, #0x280000 */
 
 	/* APMU_RVBARPLC0 = (address of 'b reset' below) | CA_CORE0_VLD_RVBARP */
-	.inst	0xe28f3068	/* add     r3, pc, #0x68 */
+	.inst	0xe28f3088	/* add     r3, pc, #0x88 */
 	.inst	0xe3833001	/* orr     r3, r3, #1 */
-	.inst	0xe5813038	/* str     r3, [r1, #56]   @ 0x38 */
+	.inst	0xe5843038	/* str     r3, [r4, #56]   @ 0x38 */
 
 	/* APMU_RVBARPHC0 = 0 */
-	.inst	0xe3a03000	/* mov     r3, #0 */
-	.inst	0xe581303c	/* str     r3, [r1, #60]   @ 0x3c */
+	.inst	0xe3a05000	/* mov     r5, #0 */
+	.inst	0xe584503c	/* str     r5, [r4, #60]   @ 0x3c */
 
 	/* PRR & 0xff00 ?= 0x5c00, test if this is V4H or V4M */
 	.inst	0xe3a024ff	/* mov     r2, #0xff000000 */
@@ -67,13 +67,21 @@ _start:
 	/* } */
 	/* APMU_PWRCTRLC0 = CA_CORE0_WUP_REQ */
 	.inst	0xe3a03001	/* mov     r3, #1 */
-	.inst	0xe5813000	/* str     r3, [r1] */
-	/* Endless loop */
+	.inst	0xe5843000	/* str     r3, [r4] */
+	/* Test for APMU_CRBARP valid BAR flags and jump to CR entry point */
+	.inst	0xe3814c03	/* orr     r4, r1, #768    @ 0x300 */
+	.inst	0xe584503c	/* str     r5, [r4, #60]   @ 0x3c */
+	.inst	0xe594203c	/* ldr     r2, [r4, #60]   @ 0x3c */
+	.inst	0xe20230ff	/* and     r3, r2, #255    @ 0xff */
+	.inst	0xe3530011	/* cmp     r3, #17 */
+	.inst	0x1afffffb	/* bne     78 <reset-0x28> */
+	.inst	0xe1a02922	/* lsr     r2, r2, #18 */
+	.inst	0xe1a02902	/* lsl     r2, r2, #18 */
+	.inst	0xe1a0f002	/* mov     pc, r2 */
+	.inst	0xeafffffe	/* b       94 <reset-0xc> */
 	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
-	.inst	0xeafffffd	/* b       70 <reset-0x10> */
 	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
-	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
-	/* Offset 0x80 */
+	/* Offset 0xa0 */
 #endif
 	b	reset
 #endif
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index a49802c1323..2790b168b19 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -22,6 +22,14 @@ config K3_SYSTEM_CONTROLLER
 	help
 	  Say 'y' here to add support for TI' K3 System Controller.
 
+config REMOTEPROC_RENESAS_APMU
+	bool "Support for Renesas R-Car Gen4 APMU start of CR52 processor"
+	select REMOTEPROC
+	depends on ARCH_RENESAS && RCAR_GEN4 && DM && OF_CONTROL
+	help
+	  Say 'y' here to add support for Renesas R-Car Gen4 Cortex-A52
+	  processor via the remoteproc framework.
+
 config REMOTEPROC_SANDBOX
 	bool "Support for Test processor for Sandbox"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 801b0965e4f..3a092b7660e 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(XPL_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
 
 # Remote proc drivers - Please keep this list alphabetically sorted.
 obj-$(CONFIG_K3_SYSTEM_CONTROLLER) += k3_system_controller.o
+obj-$(CONFIG_REMOTEPROC_RENESAS_APMU) += renesas_apmu.o
 obj-$(CONFIG_REMOTEPROC_SANDBOX) += sandbox_testproc.o
 obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
diff --git a/drivers/remoteproc/renesas_apmu.c b/drivers/remoteproc/renesas_apmu.c
new file mode 100644
index 00000000000..32d138e6487
--- /dev/null
+++ b/drivers/remoteproc/renesas_apmu.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <hang.h>
+#include <linux/iopoll.h>
+#include <linux/sizes.h>
+#include <malloc.h>
+#include <remoteproc.h>
+
+/* R-Car V4H/V4M contain 3 clusters / 3 cores */
+#define RCAR4_CR52_CORES		3
+
+/* Reset Control Register for Cortex-R52 #n */
+#define APMU_CRRSTCTRL(n)		(0x304 + ((n) * 0x40))
+#define APMU_CRRSTCTRL_CR52RST		BIT(0)
+
+/* Base Address Register for Cortex-R52 #n */
+#define APMU_CRBARP(n)			(0x33c + ((n) * 0x40))
+#define APMU_CRBARP_CR_VLD_BARP		BIT(0)
+#define APMU_CRBARP_CR_BAREN_VALID	BIT(4)
+#define APMU_CRBARP_CR_RBAR_MASK	0xfffc0000
+#define APMU_CRBARP_CR_RBAR_ALIGN	0x40000
+
+/**
+ * struct renesas_apmu_rproc_privdata - remote processor private data
+ * @regs:		controller registers
+ * @core_id:		CPU core id
+ * @trampoline:		jump trampoline code
+ */
+struct renesas_apmu_rproc_privdata {
+	void __iomem	*regs;
+	ulong		core_id;
+	u32		*trampoline;
+};
+
+/*
+ * CRBARP address is aligned to 0x40000 / 256 kiB , this trampoline
+ * allows arbitrary address alignment at instruction granularity.
+ */
+static const u32 renesas_apmu_rproc_trampoline[4] = {
+	0xe59f0004,	/* ldr r0, [pc, #4] */
+	0xe1a0f000,	/* mov pc, r0 */
+	0xeafffffe,	/* 1: b 1b */
+	0xabcd1234	/* jump target (rewritten on load) */
+};
+
+/**
+ * renesas_apmu_rproc_load() - Load the remote processor
+ * @dev:	corresponding remote processor device
+ * @addr:	Address in memory where image is stored
+ * @size:	Size in bytes of the image
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+	u32 trampolineaddr = (u32)(uintptr_t)(priv->trampoline);
+
+	priv->trampoline[3] = addr;
+	flush_dcache_range(trampolineaddr,
+			   trampolineaddr +
+			   sizeof(renesas_apmu_rproc_trampoline));
+
+	/* CR52 boot address set */
+	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP,
+	       priv->regs + APMU_CRBARP(priv->core_id));
+	writel(trampolineaddr | APMU_CRBARP_CR_VLD_BARP | APMU_CRBARP_CR_BAREN_VALID,
+	       priv->regs + APMU_CRBARP(priv->core_id));
+
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_start() - Start the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_start(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+
+	/* Clear APMU_CRRSTCTRL_CR52RST, the only bit in this register */
+	writel(0, priv->regs + APMU_CRRSTCTRL(priv->core_id));
+
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_stop() - Stop the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_stop(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+
+	/* Set APMU_CRRSTCTRL_CR52RST, the only bit in this register */
+	writel(APMU_CRRSTCTRL_CR52RST,
+	       priv->regs + APMU_CRRSTCTRL(priv->core_id));
+
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_reset() - Reset the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_reset(struct udevice *dev)
+{
+	renesas_apmu_rproc_stop(dev);
+	renesas_apmu_rproc_start(dev);
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_is_running() - Is the remote processor running
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if the remote processor is running, 1 otherwise
+ */
+static int renesas_apmu_rproc_is_running(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+
+	return readl(priv->regs + APMU_CRRSTCTRL(priv->core_id)) &
+	       APMU_CRRSTCTRL_CR52RST;
+}
+
+/**
+ * renesas_apmu_rproc_init() - Initialize the remote processor CRBAR registers
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_init(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+
+	/* If the core is running already, do nothing. */
+	if (renesas_apmu_rproc_is_running(dev))
+		return 0;
+
+	/* Clear and invalidate CRBARP content */
+	writel(0, priv->regs + APMU_CRBARP(priv->core_id));
+
+	return 0;
+}
+
+/**
+ * renesas_apmu_rproc_device_to_virt() - Convert device address to virtual address
+ * @dev:	corresponding remote processor device
+ * @da:		device address
+ * @size:	Size of the memory region @da is pointing to
+ *
+ * Return: converted virtual address
+ */
+static void *renesas_apmu_rproc_device_to_virt(struct udevice *dev, ulong da,
+					       ulong size)
+{
+	/*
+	 * The Cortex R52 and A76 share the same address space,
+	 * this operation is a no-op.
+	 */
+	return (void *)da;
+}
+
+static const struct dm_rproc_ops renesas_apmu_rproc_ops = {
+	.init		= renesas_apmu_rproc_init,
+	.load		= renesas_apmu_rproc_load,
+	.start		= renesas_apmu_rproc_start,
+	.stop		= renesas_apmu_rproc_stop,
+	.reset		= renesas_apmu_rproc_reset,
+	.is_running	= renesas_apmu_rproc_is_running,
+	.device_to_virt	= renesas_apmu_rproc_device_to_virt,
+};
+
+/**
+ * renesas_apmu_rproc_of_to_plat() - Convert OF data to platform data
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_of_to_plat(struct udevice *dev)
+{
+	struct renesas_apmu_rproc_privdata *priv = dev_get_priv(dev);
+
+	priv->core_id = dev_get_driver_data(dev);
+
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs)
+		return -EINVAL;
+
+	priv->trampoline = memalign(APMU_CRBARP_CR_RBAR_ALIGN,
+				    sizeof(renesas_apmu_rproc_trampoline));
+	if (!priv->trampoline)
+		return -ENOMEM;
+
+	memcpy(priv->trampoline, renesas_apmu_rproc_trampoline,
+	       sizeof(renesas_apmu_rproc_trampoline));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(renesas_apmu_cr52) = {
+	.name		= "rcar-apmu-cr52",
+	.id		= UCLASS_REMOTEPROC,
+	.ops		= &renesas_apmu_rproc_ops,
+	.of_to_plat	= renesas_apmu_rproc_of_to_plat,
+	.priv_auto	= sizeof(struct renesas_apmu_rproc_privdata),
+};
+
+/**
+ * renesas_apmu_rproc_bind() - Bind rproc driver to each core control
+ * @dev:	corresponding remote processor parent device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_apmu_rproc_bind(struct udevice *parent)
+{
+	const ulong cr52cores = RCAR4_CR52_CORES;
+	ofnode pnode = dev_ofnode(parent);
+	struct udevice *cdev;
+	struct driver *cdrv;
+	char name[32];
+	ulong i;
+	int ret;
+
+	cdrv = lists_driver_lookup_name("rcar-apmu-cr52");
+	if (!cdrv)
+		return -ENOENT;
+
+	for (i = 0; i < cr52cores; i++) {
+		snprintf(name, sizeof(name), "rcar-apmu-cr52.%ld", i);
+		ret = device_bind_with_driver_data(parent, cdrv, strdup(name),
+						   i, pnode, &cdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id renesas_apmu_rproc_ids[] = {
+	{ .compatible = "renesas,r8a779g0-cr52" },
+	{ .compatible = "renesas,r8a779h0-cr52" },
+	{ }
+};
+
+U_BOOT_DRIVER(renesas_apmu_rproc) = {
+	.name		= "rcar-apmu-rproc",
+	.of_match	= renesas_apmu_rproc_ids,
+	.id		= UCLASS_NOP,
+	.bind		= renesas_apmu_rproc_bind,
+};
-- 
2.45.2

