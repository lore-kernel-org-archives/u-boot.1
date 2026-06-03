Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5B7CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B987D84874;
	Wed,  3 Jun 2026 11:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vhCo2RVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836CF8489D; Wed,  3 Jun 2026 11:55:05 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE74B84874
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2857CC6245C;
 Wed,  3 Jun 2026 09:55:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 545C55FFA8;
 Wed,  3 Jun 2026 09:55:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B924110888413; 
 Wed,  3 Jun 2026 11:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480499; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=iW+phyhyZ3KB1DPOycAhKZA5xyMNvgynW1d7v45oj9A=;
 b=vhCo2RVmB5zpJPCvQIrI9Swlcr+MVqQyxN/kHpBKqhGU6O92nYfdF4Bd/4PfdNhBkBVM1W
 h77z9YfXcCagqder7sqF9hz+q9LUd1HlV5G0WlfRHXBCDJx0nVsHcaLcSstLdIR3p7BzHB
 Lv+8pUsSPs18NZn6ZqXU+maJPaWBo5FfZYiGtUdOAr0f0EJqfHkxavyCP7F2BLTVLzFArQ
 biZlD4BeIlQcu0Ye6z6nzLo6B4pbyTFnyg8a1BF4XPvEbLBgIwQsdQLKHatvjUOuhabzrC
 hhQ8s8co85VfPawNyfG+ajbCquvqUdV4m+uTE3zAYc3JzXJVX5ljEF7SHgl7IA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v2 02/16] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
Date: Wed,  3 Jun 2026 11:54:35 +0200
Message-ID: <20260603095449.2089514-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

Add helper functions that are used by respective SoCs in LPM resume flow.

- lpm_process() is called at boot time to:
  - retrieve the LPM memory region from DTS
  - save ATF/OPTEE certificates information and DM code in this memory
    region
  - Forward the LPM address to TIFS via TISCI_MSG_LPM_SAVE_ADDR
TIFS will use this address to save TFA context and its own minimal
context just before suspend.

- do_resume() is called at resume, just after bringing the DDR out of
  retention to:
  - retrieve the LPM memory region from DTS
  - authenticate certificates from LPM memory region and apply firewalls
  - ask TIFS to restore TFA and its own minimal context
  - start TFA on remote proc
  - load and jump to DM

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#lpm-msg-lpm-save-addr

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/common.h        |  16 +++
 arch/arm/mach-k3/lpm-common.h    |  15 ++
 arch/arm/mach-k3/r5/Kconfig      |   4 +
 arch/arm/mach-k3/r5/Makefile     |   1 +
 arch/arm/mach-k3/r5/common.c     |  17 +--
 arch/arm/mach-k3/r5/lpm-common.c | 234 +++++++++++++++++++++++++++++++
 6 files changed, 275 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c

diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index e970076d08ec..50e670f845e3 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -8,6 +8,7 @@
 
 #include <asm/armv7_mpu.h>
 #include <asm/hardware.h>
+#include <image.h>
 #include <mach/security.h>
 
 /* keep ram_top in the 32-bit address space */
@@ -16,6 +17,21 @@
 #define K3_FIREWALL_BACKGROUND_BIT	(8)
 #define K3_SPEED_GRADE_UNKNOWN		'\0'
 
+#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
+enum {
+	IMAGE_ID_ATF,
+	IMAGE_ID_OPTEE,
+	IMAGE_ID_SPL,
+	IMAGE_ID_DM_FW,
+	IMAGE_ID_TIFSSTUB_HS,
+	IMAGE_ID_TIFSSTUB_FS,
+	IMAGE_ID_TIFSSTUB_GP,
+	IMAGE_AMT,
+};
+
+extern struct image_info fit_image_info[IMAGE_AMT];
+#endif
+
 struct fwl_data {
 	const char *name;
 	u16 fwl_id;
diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
new file mode 100644
index 000000000000..2b360e6f03f3
--- /dev/null
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3: LPM Architecture common definitions
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2026 Bootlin
+ */
+
+#ifndef _LPM_COMMON_H_
+#define _LPM_COMMON_H_
+
+void __noreturn do_resume(void);
+void lpm_process(void);
+
+#endif
diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
index 12335880e106..7a9c005a6d7c 100644
--- a/arch/arm/mach-k3/r5/Kconfig
+++ b/arch/arm/mach-k3/r5/Kconfig
@@ -1,6 +1,10 @@
 config K3_LOAD_SYSFW
 	bool
 
+config K3_LPM
+	bool
+	default y if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J784S4 || SOC_K3_J722S || SOC_K3_J721S2
+
 config K3_OPP_LOW
 	depends on ARCH_K3 && K3_AVS0
 	bool "Enable OPP_LOW on supported TI K3 SoCs"
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index 074e3b61a262..ccededbc0d60 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SOC_K3_J722S) += j722s/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
 
 obj-y += common.o
+obj-$(CONFIG_K3_LPM) += lpm-common.o
 obj-y += lowlevel_init.o
 obj-y += r5_mpu.o
 
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 03638366046b..a80e903de85a 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -18,19 +18,9 @@
 #include <elf.h>
 
 #include "../common.h"
+#include "../lpm-common.h"
 
 #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
-enum {
-	IMAGE_ID_ATF,
-	IMAGE_ID_OPTEE,
-	IMAGE_ID_SPL,
-	IMAGE_ID_DM_FW,
-	IMAGE_ID_TIFSSTUB_HS,
-	IMAGE_ID_TIFSSTUB_FS,
-	IMAGE_ID_TIFSSTUB_GP,
-	IMAGE_AMT,
-};
-
 #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
 static const char *image_os_match[IMAGE_AMT] = {
 	"arm-trusted-firmware",
@@ -43,7 +33,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 };
 #endif
 
-static struct image_info fit_image_info[IMAGE_AMT];
+struct image_info fit_image_info[IMAGE_AMT];
 
 void init_env(void)
 {
@@ -170,6 +160,9 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 	if (ret)
 		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
 
+	if (IS_ENABLED(CONFIG_K3_LPM))
+		lpm_process();
+
 #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
 	/* Authenticate ATF */
 	void *image_addr = (void *)fit_image_info[IMAGE_ID_ATF].image_start;
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
new file mode 100644
index 000000000000..5cd0fb8b6885
--- /dev/null
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * K3: R5 Common LPM Architecture initialization
+ *
+ * Copyright (C) 2023-2026 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2026 Bootlin
+ */
+
+#include <clk.h>
+#include <dm/read.h>
+#include <elf.h>
+#include <linux/printk.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <power-domain.h>
+#include <remoteproc.h>
+#include <mach/security.h>
+
+#include "../common.h"
+#include "../lpm-common.h"
+
+#define FW_IMAGE_SIZE 0x80000
+
+struct lpm_addr_info {
+	unsigned long context_save_addr;
+	unsigned long atf_cert_addr;
+	unsigned long optee_cert_addr;
+	unsigned long dm_save_addr;
+	u32 size;
+};
+
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
+
+static int extract_lpm_region(struct lpm_addr_info *mem_addr_lpm)
+{
+	ofnode node;
+	fdt_addr_t lpm_reg_addr;
+	fdt_size_t lpm_reg_size;
+
+	node = ofnode_path("/reserved-memory/lpm-memory");
+	if (!ofnode_valid(node)) {
+		printf("lpm will not be functional\n");
+		return -ENODEV;
+	}
+
+	lpm_reg_addr = ofnode_get_addr(node);
+	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+	}
+
+	lpm_reg_size = ofnode_get_size(node);
+	if (lpm_reg_size == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+	}
+
+	mem_addr_lpm->context_save_addr = lpm_reg_addr;
+	mem_addr_lpm->atf_cert_addr = mem_addr_lpm->context_save_addr + FW_IMAGE_SIZE;
+	mem_addr_lpm->optee_cert_addr = mem_addr_lpm->atf_cert_addr + FW_IMAGE_SIZE;
+	mem_addr_lpm->dm_save_addr = mem_addr_lpm->optee_cert_addr + (2 * FW_IMAGE_SIZE);
+	mem_addr_lpm->size = lpm_reg_size;
+
+	return 0;
+}
+
+static int save_certificate(struct lpm_addr_info *mem_addr_lpm)
+{
+	int ret;
+
+	if (!fit_image_info[IMAGE_ID_ATF].image_start ||
+	    !fit_image_info[IMAGE_ID_OPTEE].image_start ||
+	    !fit_image_info[IMAGE_ID_DM_FW].image_start) {
+		pr_err("Invalid images to save\n");
+		return -EINVAL;
+	}
+
+	ret = extract_lpm_region(mem_addr_lpm);
+	if (ret) {
+		pr_err("Cannot find valid LPM address range..\n");
+		return -ENOMEM;
+	}
+
+	memcpy((void *)mem_addr_lpm->atf_cert_addr,
+	       (void *)fit_image_info[IMAGE_ID_ATF].image_start,
+	       fit_image_info[IMAGE_ID_ATF].image_len);
+
+	memcpy((void *)mem_addr_lpm->optee_cert_addr,
+	       (void *)fit_image_info[IMAGE_ID_OPTEE].image_start,
+	       fit_image_info[IMAGE_ID_OPTEE].image_len);
+
+	memcpy((void *)mem_addr_lpm->dm_save_addr,
+	       (void *)fit_image_info[IMAGE_ID_DM_FW].image_start,
+	       fit_image_info[IMAGE_ID_DM_FW].image_len);
+
+	return 0;
+}
+
+void lpm_process(void)
+{
+	int ret = 0;
+	struct lpm_addr_info mem_addr_lpm;
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+
+	ret = save_certificate(&mem_addr_lpm);
+	if (ret)
+		return;
+	/*
+	 * As there is no function to check TIFS capabilities, we can't really
+	 * know if the call failed because it's not supported by TIFS or for
+	 * another reason.
+	 */
+	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
+						mem_addr_lpm.context_save_addr,
+						mem_addr_lpm.size);
+	if (ret)
+		pr_err("TIFS lpm save addr fails (message not supported?)\n");
+}
+
+static unsigned long resume_to_dm_f(const struct lpm_addr_info *mem_addr_lpm)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	unsigned long loadaddr;
+	int ret = 0;
+
+	loadaddr = mem_addr_lpm->dm_save_addr;
+	if (!valid_elf_image(loadaddr))
+		panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
+		      __func__);
+
+	loadaddr = load_elf_image_phdr(loadaddr);
+	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
+						mem_addr_lpm->context_save_addr,
+						mem_addr_lpm->size);
+	if (ret)
+		panic("TIFS lpm save addr fail : %x\n", ret);
+
+	/*
+	 * TIFS minimal context restore
+	 * This restores also the firewall
+	 */
+	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, 0);
+	if (ret)
+		panic("TIFS restore_context failed (%d)\n", ret);
+
+	/*
+	 * Restore TFA in msmc memory
+	 */
+	ret = ti_sci->ops.lpm_ops.decrypt_tfa(ti_sci,
+					      CONFIG_K3_ATF_LOAD_ADDR);
+	if (ret)
+		panic("%s: TIFS failed to decrytp TFA : %x\n", __func__, ret);
+
+	/* restore TFA resume vector address in main core */
+	ret = ti_sci->ops.lpm_ops.core_resume(ti_sci);
+	if (ret)
+		panic("ATF failed to resume (%d)\n", ret);
+
+	return loadaddr;
+}
+
+static void resume_rproc_f(void)
+{
+	struct power_domain rproc_pwrdmn;
+	unsigned long gtc_rate;
+	struct udevice *dev;
+	struct clk gtc_clk;
+	void *gtc_base;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
+	if (ret)
+		panic("Unknown remote processor 1 (%d)\n", ret);
+
+	ret = power_domain_get_by_index(dev, &rproc_pwrdmn, 1);
+	if (ret)
+		panic("power_domain_get_rproc() failed: %d\n", ret);
+
+	ret = clk_get_by_index(dev, 0, &gtc_clk);
+	if (ret)
+		panic("clk_get failed: %d\n", ret);
+
+	gtc_base = dev_read_addr_ptr(dev);
+	if (!gtc_base)
+		panic("Get GTC address failed\n");
+
+	gtc_rate = clk_get_rate(&gtc_clk);
+
+#define GTC_CNTCR_REG	0x0
+#define GTC_CNTFID0_REG	0x20
+#define GTC_CNTR_EN	0x3
+	/* TFA expect the Global Timebase Counter to be set-up */
+	writel((u32)gtc_rate, gtc_base + GTC_CNTFID0_REG);
+	writel(GTC_CNTR_EN, gtc_base + GTC_CNTCR_REG);
+
+	ret = power_domain_on(&rproc_pwrdmn);
+	if (ret)
+		panic("power_domain_on failed: %d\n", ret);
+}
+
+typedef void __noreturn (*image_entry_noargs_t)(void);
+
+void __noreturn do_resume(void)
+{
+	struct lpm_addr_info mem_addr_lpm;
+	image_entry_noargs_t image_entry;
+	size_t sz = FW_IMAGE_SIZE;
+	unsigned long loadaddr;
+	void *image_addr;
+	int ret;
+
+	ret = extract_lpm_region(&mem_addr_lpm);
+	if (ret)
+		panic("Cannot find valid LPM address range... LPM resume failed\n");
+
+	ret = rproc_load(1, mem_addr_lpm.atf_cert_addr, 0x200);
+	if (ret)
+		panic("rproc failed to be initialized (%d)\n", ret);
+
+	image_addr = (void *)mem_addr_lpm.atf_cert_addr;
+	ti_secure_image_auth_apply_fwls(&image_addr, sz);
+
+	image_addr = (void *)mem_addr_lpm.optee_cert_addr;
+	ti_secure_image_auth_apply_fwls(&image_addr, sz);
+
+	loadaddr = resume_to_dm_f(&mem_addr_lpm);
+	printf("Starting ATF on ARM64 core...\n\n");
+	resume_rproc_f();
+
+	image_entry = (image_entry_noargs_t)loadaddr;
+	image_entry();
+}
-- 
2.47.3

