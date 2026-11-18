Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A820606A330
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XWZWVALN;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=K0Uhsy6O
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47DB881235;
	Wed, 18 Nov 2026 13:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WASgXZlXZlBX; Wed, 18 Nov 2026 13:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E3A181230
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007919;
	b=ROdkZCtbU8leFtoBkw+FltfplEDquiU0SJ2AGh6U0AptCWW1KVjAc7W0/c+pxY2JL+06
	 xnoV83+zQ5vTamtOUc9MOUqPhl+R3sHOTrjCM6iQcn5QvXh+U9Qf80/GzZqhLhLu+94wc
	 lfSaBxcE2H5w4KBJmJ5WIx8J9QFUjNwCs7QVjjINClczRB43KVVD67Sl+EjJ18VO0Rn4u
	 5HwmZBMbbQyjMPddQ4BEcK1+ZI+wqB5VI884QCdmVMl6Uj5sBrIpXYs7SYKoqvuZXS9pB
	 zgoPVwZzUSpYg53BP+EOnVlk3DJLC14o7CoNNQel2/b2yfFd+IKTXQ94451eA4qR7sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gS2qpo7n1hB2ok+TDcIUDUx3RtyutVjvrkbiJZmAWcc=;
	b=gw51cp6EUd3L6g9ym9ApiJMI2Pv1nDpHOAbByV7LcxXoDznMjKARoN38IemIw1/fmVnS
	 opPvhrS53bwAXUCxeFwJSmo9WvSw8ZBpUTmke/2GMAmmqdrBPzY5GbTujMZNg5pE7QSOF
	 AHjewpcn1CryKMLcg5TByGLx5CFmwcMkjhU0gMnW43l3s4VHpRBeIPdNRIXsq2OFTLIve
	 bfDwPJt2SCVsfxIzsB/lktwA3QgDpADJyx5z7kxiD0OvMKwKpanNTSRHwgYj/E1ElindI
	 JcQY0JjuT3rOk7kFmkYVu2+sSJ1g5WLl7O3ukIaOPpez9tiHM6c3HY5me7tGM4nuqZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007919;
	bh=gS2qpo7n1hB2ok+TDcIUDUx3RtyutVjvrkbiJZmAWcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XWZWVALN1I+XJCW0/Stnyxt5d4tHm19vD/EdP4AC5HKDvJ9zfvoNkqSCqXDjDVKzS
	 kBPq/3XzL+qY8liKtObX+0wt19fuBTEMzHt8pZJVgCkgK7SLflQzTDPZRFZuGx4ksq
	 m1596eTCozElKE7p6FXEzp83+vAFxe544gyNovuy5EAJ8nWrXnvQ/BA8Y6MqZDQ5kB
	 tyZr/FesqYA4JyWGpR2wULyEj50HK3J4yVNKyoztakA7YxQpE2+rYn6fagRt+h3ugR
	 qhUu9oe5AOa9G7dYdW/+d6joKpsGyThHt8eYWl1WQgrI2zhe5D4go5FpoDX0yg6a2d
	 3l3RlUTrMuUNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E3A181230;
	Wed, 18 Nov 2026 13:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DAA6A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03B1A60A6B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2M-cLeUE2-w for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8609360A51
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=K0Uhsy6O
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8609360A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E4EE2C4F77E;
 Wed, 18 Nov 2026 13:18:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 16CA95FE9B;
 Wed, 18 Nov 2026 13:18:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40E2011BC140F; Wed, 18 Nov 2026 14:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007907; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=gS2qpo7n1hB2ok+TDcIUDUx3RtyutVjvrkbiJZmAWcc=;
 b=K0Uhsy6OO2LxOemmcdOmls5hOj1swwGQmMMvPhMlD7jzIOq5r2vIddYl9v5X7QOTgKs15b
 jSBhk3M3C4daqVAehpd9/nP5PVIral6U7BzTxr17t9kVCkf0F/2ktmBuy0ZnxNj6EC6q9p
 /Gznav6DePf1BpnzIPpQ3zoifm0dpale/XisbieOQVpSCOhxlcMFt0hbtEGEHFj6Uk0DL/
 JXxQ4iKW81UnWWZY7RmoyNapkGbsbMH3fpNz+jgxAgHH5ruK3diZI2hV3MtZh220UwL9Pt
 r4cp1SGaWwntq7Hkw8zy5twpSmijwiZs/AFWwBCK8HuJzL/fTdTx4FEv0d3g6A==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 03/20] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
Date: Wed, 18 Nov 2026 14:17:50 +0100
Message-ID: <20261118131807.135859-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Prasanth Babu Mantena <p-mantena@ti.com>

Add helper functions that are used by respective SoCs in LPM resume flow.

Those functions will only be compiled if K3_LPM is selected.
As it only works with TIFS 11.02.06 or superior, K3_LPM is default n to
prevent breaking board with older TIFS.

Very early at boot time, save_lpm_region_idx() is called to:
  - retrieve the LPM memory region from DTS
  - save ATF/OPTEE certificates information and DM code in this memory
    region
It has to be called before the DM image is processed, has we want to
keep it's certificate intact. (and ti_secure_image_post_process()
consumes the DM certificate)

- Later on at boot time, lpm_process() is called to:
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
 arch/arm/mach-k3/common.h        |  17 ++
 arch/arm/mach-k3/lpm-common.h    |  31 ++++
 arch/arm/mach-k3/r5/Kconfig      |   8 +
 arch/arm/mach-k3/r5/Makefile     |   1 +
 arch/arm/mach-k3/r5/common.c     |  21 +--
 arch/arm/mach-k3/r5/lpm-common.c | 294 +++++++++++++++++++++++++++++++
 6 files changed, 359 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-k3/lpm-common.h
 create mode 100644 arch/arm/mach-k3/r5/lpm-common.c

diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 37ff98d89924..4686f31ea99b 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -8,6 +8,7 @@
 
 #include <asm/armv7_mpu.h>
 #include <asm/hardware.h>
+#include <image.h>
 #include <mach/security.h>
 
 /* keep ram_top in the 32-bit address space */
@@ -16,6 +17,22 @@
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
+	IMAGE_ID_HSM,
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
index 000000000000..27a27065442c
--- /dev/null
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -0,0 +1,31 @@
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
+#include <linux/errno.h>
+
+#if IS_ENABLED(CONFIG_K3_LPM)
+void __noreturn do_resume(void);
+void lpm_process(void);
+int save_lpm_region_idx(unsigned int image_id, unsigned long image_start);
+void k3_set_lpm_core_bus_node_path(const char *node_path);
+void k3_set_lpm_core_compatible(const char *compatible);
+#else
+static inline void do_resume(void) { ; }
+static inline void lpm_process(void) { ; }
+static inline int save_lpm_region_idx(unsigned int image_id,
+				      unsigned long image_start) { return -EOPNOTSUPP; }
+static inline void k3_deassert_ddr_ret(const char *pmic_name,
+				       unsigned int ddr_ret_val,
+				       unsigned int ddr_ret_clk, bool toggle) { ; }
+static inline void k3_set_lpm_core_bus_node_path(const char *node_path) { ; }
+static inline void k3_set_lpm_core_compatible(const char *compatible) { ; }
+#endif
+#endif
diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
index 672c8a226dfd..6d85fa9fbf59 100644
--- a/arch/arm/mach-k3/r5/Kconfig
+++ b/arch/arm/mach-k3/r5/Kconfig
@@ -1,6 +1,14 @@
 config K3_LOAD_SYSFW
 	bool
 
+config K3_LPM
+	bool "Enable suspend on supported TI K3 SoCs"
+	depends on SPL_EARLY_BSS && \
+		(SOC_K3_J7200 || SOC_K3_J784S4 || SOC_K3_J722S || SOC_K3_J721S2)
+	help
+	  Enable suspend to RAM on J7200, J784S4, J722S and J721S2.
+	  NB: it will need TIFS 11.02.06 or newer.
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
index aedde7bda3de..be7531502fb7 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -18,20 +18,9 @@
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
-	IMAGE_ID_HSM,
-	IMAGE_AMT,
-};
-
 #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
 static const char *image_os_match[IMAGE_AMT] = {
 	"arm-trusted-firmware",
@@ -45,7 +34,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 };
 #endif
 
-static struct image_info fit_image_info[IMAGE_AMT];
+struct image_info fit_image_info[IMAGE_AMT];
 
 void init_env(void)
 {
@@ -189,6 +178,9 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 	if (ret)
 		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
 
+	if (IS_ENABLED(CONFIG_K3_LPM))
+		lpm_process();
+
 #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
 	/* Authenticate ATF */
 	void *image_addr = (void *)fit_image_info[IMAGE_ID_ATF].image_start;
@@ -373,6 +365,9 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_K3_LPM))
+		save_lpm_region_idx(i, (unsigned int)*p_image);
+
 	/*
 	 * Only DM and the DTBs are being authenticated here,
 	 * rest will be authenticated when A72 cluster is up
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
new file mode 100644
index 000000000000..91707fd19501
--- /dev/null
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -0,0 +1,294 @@
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
+#define CONTEXT_SAVE_SZ	0x80000
+#define ATF_CERT_SZ	0x80000
+#define OPTEE_CERT_SZ	0x100000
+#define DM_SAVE_SZ	0x100000
+#define LPM_REG_MIN_SIZE (CONTEXT_SAVE_SZ + ATF_CERT_SZ + OPTEE_CERT_SZ + DM_SAVE_SZ)
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
+		printf("LPM core bus path not set\n");
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
+	if (lpm_reg_size < LPM_REG_MIN_SIZE) {
+		printf("LPM memory region too small (0x%x instead of 0x%x)!\n",
+		       lpm_reg_size, LPM_REG_MIN_SIZE);
+		return -EINVAL;
+	}
+
+	mem_addr_lpm->context_save_addr = lpm_reg_addr;
+	mem_addr_lpm->atf_cert_addr = mem_addr_lpm->context_save_addr + CONTEXT_SAVE_SZ;
+	mem_addr_lpm->optee_cert_addr = mem_addr_lpm->atf_cert_addr + ATF_CERT_SZ;
+	mem_addr_lpm->dm_save_addr = mem_addr_lpm->optee_cert_addr + OPTEE_CERT_SZ;
+	mem_addr_lpm->size = lpm_reg_size;
+
+	return 0;
+}
+
+/* Used to save LPM addresses at boot time */
+static struct lpm_addr_info boot_mem_addr_lpm;
+
+int save_lpm_region_idx(unsigned int image_id, unsigned long image_start)
+{
+	static bool lpm_region_extracted;
+	unsigned long dst;
+	int ret;
+
+	if (!lpm_region_extracted) {
+		ret = extract_lpm_region(&boot_mem_addr_lpm);
+		if (ret) {
+			pr_err("Cannot find valid LPM address range..\n");
+			return ret;
+		}
+	}
+	lpm_region_extracted = true;
+
+	switch (image_id) {
+	case IMAGE_ID_ATF:
+		dst = boot_mem_addr_lpm.atf_cert_addr;
+		break;
+	case IMAGE_ID_OPTEE:
+		dst = boot_mem_addr_lpm.optee_cert_addr;
+		break;
+	case IMAGE_ID_DM_FW:
+		dst = boot_mem_addr_lpm.dm_save_addr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!image_start || !fit_image_info[image_id].image_len)
+		return -EINVAL;
+
+	memcpy((void *)dst, (void *)image_start,
+	       fit_image_info[image_id].image_len);
+
+	return 0;
+}
+
+void lpm_process(void)
+{
+	int ret = 0;
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+
+	/*
+	 * As there is no function to check TIFS capabilities, we can't really
+	 * know if the call failed because it's not supported by TIFS or for
+	 * another reason.
+	 */
+	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
+						boot_mem_addr_lpm.context_save_addr,
+						boot_mem_addr_lpm.size);
+	if (ret)
+		pr_err("TIFS lpm save addr fails (message not supported?)\n");
+}
+
+static unsigned long resume_to_dm_f(const struct lpm_addr_info *mem_addr_lpm)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	unsigned long loadaddr;
+	size_t dm_sz = DM_SAVE_SZ;
+	void *p_image = (void *)mem_addr_lpm->dm_save_addr;
+	int ret = 0;
+
+	ti_secure_image_auth_apply_fwls(&p_image, dm_sz);
+
+	/*
+	 * Unlike ti_secure_image_post_process(), the certificate replay
+	 * above does not consume the saved blob, so the certificate stays
+	 * in place for the next suspend/resume cycle. Skip it to find the
+	 * DM ELF.
+	 */
+	ti_secure_skip_cert(&p_image, &dm_sz);
+
+	loadaddr = (unsigned long)p_image;
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
+	unsigned long loadaddr;
+	void *image_addr;
+	int ret;
+
+	ret = extract_lpm_region(&mem_addr_lpm);
+	if (ret)
+		panic("Cannot find valid LPM address range... LPM resume failed\n");
+
+	/*
+	 * Disclaimer:
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
+	ti_secure_image_auth_apply_fwls(&image_addr, ATF_CERT_SZ);
+
+	image_addr = (void *)mem_addr_lpm.optee_cert_addr;
+	ti_secure_image_auth_apply_fwls(&image_addr, OPTEE_CERT_SZ);
+
+	loadaddr = resume_to_dm_f(&mem_addr_lpm);
+	printf("Starting ATF on ARM64 core...\n\n");
+	resume_rproc_f();
+
+	image_entry = (image_entry_noargs_t)loadaddr;
+	image_entry();
+}
