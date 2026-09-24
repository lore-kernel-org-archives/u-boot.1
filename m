Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447BC98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2011A40B55;
	Thu, 24 Sep 2026 12:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3LQ3zc_h08yV; Thu, 24 Sep 2026 12:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 96A6140783
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253383;
	b=OV8CCswCg5pz7AYmj6JqeG8Fu5BtLpug/bvkD/9BSfSc5KILYL8dC9zC6gqU73/ydRaM
	 fm5FdYfPnJDrzGr6rlCc4ivcwNmgbdc1VWdVStTS5YPZKXP6DPXwd1zhbZLvaWKIbiwjG
	 lnz+F8R7jy/dQA4ZSUKY7dvayj97gpohaNXQsQHUnLXXQKndv6qUIbpu9vZZpKhD+YgJz
	 8vuf7ELYiPwVkqkMJUNb+qPzpwSsipz8uZxGE5QKFecobevc0rOMtGS1LgNXV82cC7WBm
	 RAxjxiLUycopkhHQ9QfEMLBUiKxPPvWWDe9SCOCqH8cR7xfjd3OqLmT4ApHDQlYHQHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xdfV5TiNjVWT7j/sbA+qjIdLGLrzAZ93wZgai/YqY58=;
	b=iGFhIx8cWICKAhkci8bUFoNUH5DCCcF8BQZzXKx247+gUz+fQnizsRTPCPK/MIpnlCBs
	 jqMjSpoGpreKEp9SL9Bh9+QtV4p5j/v/fGkwC4SaV/AwtaayJAut1qy3k4zXA0SCAw91a
	 kxLebeNKq0TEvvNwdB8dsEhgQdb0GKTDQE2aktP1V873OiorpgAMOBP30YH4GIbqTxXSj
	 MuqzBBnw6N/wVKkoSxIeZ6N6pPn6G52baWNtNmaYy0GMUv8e8rkJZLuD+Oh61uQwu/qnm
	 xXFifDIQIwTn8lXv3PQU4cJPv4wAEgnWtruIE2ukIScScP+VYADStg1xp57kzu1wRtQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253383;
	bh=xdfV5TiNjVWT7j/sbA+qjIdLGLrzAZ93wZgai/YqY58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yaR6gJhBW+ZWKmePB+MrLyednB/CuTqLw7lV9Fx/TqUKFV7edmWaAmHMrnU9lU99O
	 Er434J9LVdKaTPPZH7upSQe21Dy8bmzOBLDB+i6lhd2oTFToBoF0zSZWxUI6fpl1a3
	 eu3b6Pkaa9CqvxwHM14sNlvstUKXCQvYw5LjsM/0KfBLhwv1ynnukHHAH+3+5RzbZc
	 PQilSYcKCJpF/zzUfzGOQ0L/EISN30w/A33VwTbi0lmrJQ0Su36UFEMkcsqRhTcb6T
	 Dwbv+21hjcHp5NbY9kcZK1iUhl4jxgafcbCHH5Oc2jPqF3U5RQDQckH9D8UHXNl/Bc
	 pTEdyjDU9lyoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96A6140783;
	Thu, 24 Sep 2026 12:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E3441FB6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FF6540456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ku58k007xsH for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B2673400FB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253381;
 b=WHUwLb80WG0BU0BDQHog7ga/+qy96b5UdMUPIVo9pEEjq4YniE2kK45lvjAQ88g81+wi
 RAY7D3iikejsPfNNp1WMtA9F7oDSBoLzTNvrPP2RX/TYL0ezgvtHvGs6j1AgX84RbudH0
 06YAJvw/dV0QBHew9PyKZ3F0Xp9jjBs9hsOjEkQBWKsHwIhUxKXGdOo6A9YCPvxRywjrs
 bSqey+sVBVAIIg2UGUVL4osuHjRtKESB4jIMYpw6z1mSK9RMHMKggCgCqKhO5nzg4E48F
 e1jlrRT7RfWZTCL6auaZtZB3I/lSsguCIeq+Wwo/Z+JYsfE3+qEcnnb7roLZ+SwllHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253381;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=xdfV5TiNjVWT7j/sbA+qjIdLGLrzAZ93wZgai/YqY58=;
 b=kmPS3H7Wog2h1gnPp5l2mJ165NoBNiOVUmt1Mpbh19Kl8QEu2hbLY6a1VVgsI3d4tiW2
 HZbTBbyo7krd7rWMKMYKxz0zRJAmZiU8POG6R7560sfDSyH3bjAKKgRDK/19+ZterifhO
 F+Kvzh/SO0VpVZMrUKo6DxAEPFlqaP0QyGgT5SiRMxw38YXxcZez7XJ/v1oIk5QKbuZS3
 VcgNVaVmMHf3pSLY6g4x6y1MCS4PZejN7XMaKHJPw/wQxOKeUpNWL0pvlmiR102XQiIlr
 vmYstZwImLmv/LHycxwqSTacJ47ghSA7zXYeS+Ku38l4ZX1+/FbpW43+YFAPVqzXYsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AI8ZxX7C; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=AI8ZxX7C
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2673400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3F2C7C211C1;
 Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C2B1C60341;
 Thu, 24 Sep 2026 12:36:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B5D4103284AD; 
 Thu, 24 Sep 2026 14:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253373; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xdfV5TiNjVWT7j/sbA+qjIdLGLrzAZ93wZgai/YqY58=;
 b=AI8ZxX7CHWQpDPzmRglosjzf65i1K1MQARPNacQAOBMWkI6AcxaQFHxD3c5+xuBXYvbHFA
 ftEdblCamiKfnx+NCrvSKzakt8Fu82ZYcfiq3uV1WXHTqWu7bqvLkIgb03c3nG9B2coE2q
 Nn+EwpadKEfw4eGHpO53FteHE03VqAPMt0DfgpGybMRMkeLmtiJmGpZr5ZQWEysPM+J2vA
 hIKtpimaphI0BGeUUx7NrwjLjlo+UNKT4oGijszuFW+FdM3I0/c7eiT0wANxjE9x4uF3tI
 OdG1gxoTWCecBy18xuqbGIuWMUyCEkxryutTgp9+kSutIasVVHN4cxIkvTQ4FA==
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
Subject: [PATCH v6 05/22] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
Date: Thu, 24 Sep 2026 14:35:16 +0200
Message-ID: <20260924123533.2599438-6-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
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
 arch/arm/mach-k3/common.h        |  16 ++
 arch/arm/mach-k3/lpm-common.h    |  31 ++++
 arch/arm/mach-k3/r5/Kconfig      |   8 +
 arch/arm/mach-k3/r5/Makefile     |   1 +
 arch/arm/mach-k3/r5/common.c     |  20 +--
 arch/arm/mach-k3/r5/lpm-common.c | 294 +++++++++++++++++++++++++++++++
 6 files changed, 358 insertions(+), 12 deletions(-)
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
index 12335880e106..c1832606547c 100644
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
index 13736ca5dbc0..cc5a1af0442b 100644
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
@@ -352,6 +345,9 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
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
-- 
2.55.0

