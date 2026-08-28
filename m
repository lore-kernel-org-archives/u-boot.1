Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE854C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A91B040875;
	Fri, 28 Aug 2026 13:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKViw2BwXHJn; Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925490;
	bh=ft1aWxz7P5cdAXLOPU5DUT0/bG/8UQ84VXxTa/+y0Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZdZI7iVK68PSvfk6A70OVJi5SdMYmAX9xIcwQ8m8kezJ4YXUJpLtDXAxv+AfxRjG
	 13imOoCFOp6rjNn/qB5go+COlgJCojrYPLUn26iVXFs/jh61POTbLiHQh/VXILJIG1
	 8RZZbRqAv5R+GO3L1BR5lX4bnaksInL+GYz1JZKMAI2iDv4DAQg+FDOV+jjenNFt83
	 2MJZ2Q8iEx4dWImHMrSsxTZwN1eYr8bti53UFYjQUM9NdgMBRzhIuVLIXA9wEEfehx
	 ze3tWOlfxIKtMXokstqpTx1EqUvBRefR4bXw9WrhZvmnpr8LjLjo5kYTBBAuB5hM2v
	 jDLEY8IZA+RgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B12740859;
	Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B260127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51C84407E7
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeOYH3qE70gF for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=KyOmJKxf
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3EDE4085D
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:06 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1F66A1A18A3;
 Fri, 28 Aug 2026 13:58:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E6D1960537;
 Fri, 28 Aug 2026 13:58:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5ED3C11C78068; 
 Fri, 28 Aug 2026 15:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925483; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ft1aWxz7P5cdAXLOPU5DUT0/bG/8UQ84VXxTa/+y0Xw=;
 b=KyOmJKxfRBay1O+U9Re3WsqLDJn8Ml9X+5LEgwtQy/A4ozdXTWJMOsdS4XnRAu5zDpcTBd
 sPLLapbqcc151XdlnVoNEQkI5TOz1q2UmjHzmEsvPnEoeqJ2ypaCuddEg58BUJJ/9EMaio
 idnuV+lXyEjSEoZCJHwlf76zwIU5AlQ/kiM2RvGx3CEymeS9lODm7AhzmMAkO2L4inlKWt
 O3YcPhclQDxsCVIZN8ImZKwhMkzTX/mlrfN4LH/KwqGqdLy62owSk8YvftNGZMZF1mnUeb
 kkWGl+llD1XRB/qcxWFQ1+s6Xki/pryWO+8ifSqz4gPd2/qCBZJQlh6B8P4OzA==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 04/21] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
Date: Fri, 28 Aug 2026 15:57:13 +0200
Message-ID: <20260828135730.1565643-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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

- k3_set_lpm_core_bus_node_path() and k3_set_lpm_core_compatible() are
  used to locate the lpm memory region in the DTB

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#lpm-msg-lpm-save-addr

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/common.h        |  16 ++
 arch/arm/mach-k3/lpm-common.h    |  17 ++
 arch/arm/mach-k3/r5/Kconfig      |   4 +
 arch/arm/mach-k3/r5/Makefile     |   1 +
 arch/arm/mach-k3/r5/common.c     |  17 +-
 arch/arm/mach-k3/r5/lpm-common.c | 268 +++++++++++++++++++++++++++++++
 6 files changed, 311 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c

diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 37ff98d89924..c97ccc8e0619 100644
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
index 000000000000..83e0fdcca6ca
--- /dev/null
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -0,0 +1,17 @@
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
+void k3_set_lpm_core_bus_node_path(const char *node_path);
+void k3_set_lpm_core_compatible(const char *compatible);
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
index 13736ca5dbc0..572e4848bb5e 100644
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
index 000000000000..9b91081e4f0f
--- /dev/null
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -0,0 +1,268 @@
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
+static const char *lpm_core_compatible;
+static const char *lpm_core_bus_node_path;
+
+void k3_set_lpm_core_bus_node_path(const char *node_path)
+{
+	lpm_core_bus_node_path = node_path;
+}
+
+void k3_set_lpm_core_compatible(const char *compatible)
+{
+	lpm_core_compatible = compatible;
+}
+
+static int extract_lpm_region(struct lpm_addr_info *mem_addr_lpm)
+{
+	struct ofnode_phandle_args memregion_phandle;
+	fdt_addr_t lpm_reg_addr;
+	fdt_size_t lpm_reg_size;
+	ofnode memregion;
+	ofnode bus_node;
+	int ret, idx;
+
+	if (!lpm_core_compatible) {
+		printf("LPM compatible core string not set\n");
+		return -EINVAL;
+	}
+	if (!lpm_core_bus_node_path) {
+		printf("LPM core bus path  not set\n");
+		return -EINVAL;
+	}
+
+	bus_node = ofnode_path(lpm_core_bus_node_path);
+	if (!ofnode_valid(bus_node)) {
+		printf("Failed to find wkup bus\n");
+		return -EINVAL;
+	}
+
+	memregion = ofnode_by_compatible(bus_node, lpm_core_compatible);
+	if (!ofnode_valid(memregion)) {
+		printf("Failed to find r5f devicetree node %s\n",
+		       lpm_core_compatible);
+		return -EINVAL;
+	}
+
+	idx = ofnode_stringlist_search(memregion, "memory-region-names",
+				       "lpm-metadata");
+	if (idx < 0)
+		return idx;
+
+	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
+					     0, idx, &memregion_phandle);
+
+	if (ret) {
+		printf("Failed to parse phandle for lpm memory region\n");
+		return ret;
+	}
+
+	lpm_reg_addr = ofnode_get_addr(memregion_phandle.node);
+	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+	}
+
+	lpm_reg_size = ofnode_get_size(memregion_phandle.node);
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
+	struct udevice *dev;
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
+	/*
+	 * Disclamer:
+	 * ---------
+	 * There's a potential attack vector here, because OPTEE could be
+	 * modified before being reloaded.
+	 *
+	 * Also, if the certificate replay is skipped, then TFA can be
+	 * read from MSMC.
+	 */
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
