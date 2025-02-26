Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F0FC19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4A381253;
	Wed, 26 Feb 2025 23:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nLbBVAUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0528118B; Wed, 26 Feb 2025 23:16:24 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B8C81110
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22349dc31bcso4098075ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608178; x=1741212978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rQNrB28Ye6HGzfFJHxCZ9IVQk+hjFqL/MuOXUbHF5k=;
 b=nLbBVAUbfs1U3eBJskt0xgLwQ4IxarbEDl6VBwSwO6vqWc1l8W3JiDAUP/EWDAvRiT
 IAn2/FCZNiBUs+1cA86MZWo81gvj2IWommBLD2Chihh9KpjjG/Qn4y6/lCmoGxjowPts
 dJSd8TAngd7myWJX4Hx88xFrnDZ5LW2hfR6Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608178; x=1741212978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rQNrB28Ye6HGzfFJHxCZ9IVQk+hjFqL/MuOXUbHF5k=;
 b=lPUpJ0C/UFsvy4yceGd9yEzIkyiqG0rsPp5CgVBVRwAUGW8FSfjw2I7ti1pDvMtw7j
 2BhGRlSI0YxoT0rqYn7GyOg80TOE0cdu7vh+QEnPqNXKRlQt84CYcvCWg93EgW53Df1A
 p9eXrH+0GTU1QhpQQj6b5ZJMq18aq987LHZGF8qx0ujOBUE39WjJFr65XmThd6FRYNG5
 KUXa20Qa9rbd4Em7R50OWkzQjQw01IDNVxJ/GUPYbOD5JryTZq0L60tJylC8BCVX7poc
 uA8WyofivQWGQJzNVhs88OFS2ns3FdK3b+PgwxfoTK8he8zWCnnRraotFmjk2VaLzJcU
 6yQw==
X-Gm-Message-State: AOJu0Yzv3xBhuhSAGzhDwiYFjit5dc1RqIezy4ohbhsGQcq4OtWPr5RT
 G+udxkwnbqonxVHAWXdlv8YdewViP137X/5ggvTsRx81XYoeOSGLjDjvNIq3E09klwrZ0kyIcI8
 =
X-Gm-Gg: ASbGncs6D97cs069UUcMl6ATqsYxefjT7cfB1W6flf/6+v/2y+8x+zWZdd4iE781Po7
 mknlwcadomvQCkHHEbYbwQa2TkDhEY4EliIFFJs6A7Ffdnvr2dBbvwz2yYnJviVlrmVLLgG2Ss0
 4NtyGCPZiiaa1gZPDIfz2Q3SNyo6laB30CnXyGT+p9urB8MrGhu2Yc9iHPYGSZZox/JD9/UPkv4
 ApjlJxIHTEyr8XoDFcXPuiz1uka3+Rg0GyffxOB4H3xKfVdJLc3qrkNp76d2pq/v8dnu8yPtHiP
 KFEumcTqKVyzG3qu6RISem6ytgKk36oIGIRbQRfNv6BKfDoHZ4PRt+yoVaO6Uy5eOA==
X-Google-Smtp-Source: AGHT+IEbWieHFutn7SyMNxTgjZlC5j5hIbBhaC+TO9xZ7W/f5gp88frSLlOA37TYHAAEuchCdApptA==
X-Received: by 2002:a05:6a21:33a1:b0:1ee:cf3f:1bbe with SMTP id
 adf61e73a8af0-1eef52d9897mr40501309637.13.1740608178285; 
 Wed, 26 Feb 2025 14:16:18 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7349fe2ae47sm66090b3a.1.2025.02.26.14.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:17 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 06/15] arm: Support running U-Boot as a coreboot payload on
 ARM64
Date: Wed, 26 Feb 2025 14:15:52 -0800
Message-ID: <20250226221607.1283592-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

Add a 'coreboot' cpu to armv8 that looks for the coreboot table near the
top of the 4G address space.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/cpu/armv8/Makefile          |  1 +
 arch/arm/cpu/armv8/coreboot/Makefile |  4 ++++
 arch/arm/cpu/armv8/coreboot/cpu.c    | 33 ++++++++++++++++++++++++++++
 arch/arm/include/asm/global_data.h   |  3 +++
 arch/x86/cpu/cpu.c                   | 13 -----------
 include/cb_sysinfo.h                 |  7 ++++++
 lib/coreboot/Kconfig                 | 14 ++++++------
 lib/coreboot/cb_sysinfo.c            | 13 +++++++++++
 8 files changed, 68 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index b4126c61df15..39258a07db6c 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
 
 obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
+obj-$(CONFIG_SYS_COREBOOT) += coreboot/
diff --git a/arch/arm/cpu/armv8/coreboot/Makefile b/arch/arm/cpu/armv8/coreboot/Makefile
new file mode 100644
index 000000000000..0eca9ff05900
--- /dev/null
+++ b/arch/arm/cpu/armv8/coreboot/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += cpu.o
+
diff --git a/arch/arm/cpu/armv8/coreboot/cpu.c b/arch/arm/cpu/armv8/coreboot/cpu.c
new file mode 100644
index 000000000000..05ceff967989
--- /dev/null
+++ b/arch/arm/cpu/armv8/coreboot/cpu.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <cb_sysinfo.h>
+#include <linux/errno.h>
+#include <linux/sizes.h>
+#include <log.h>
+
+long locate_coreboot_table(void)
+{
+	long addr;
+
+	/*
+	 * We look for LBIO somewhere inside the CBMEM arena, which is
+	 * typically at the top of the first 4G of RAM.
+	 */
+	addr = detect_coreboot_table_at(SZ_4G - SZ_8M, SZ_8M);
+	if (addr < 0)
+		return -ENOENT;
+
+	debug("Located coreboot table at %#lx\n", addr);
+	return addr;
+}
+
+int arch_cpu_init(void)
+{
+	int ret;
+
+	ret = get_coreboot_info(&lib_sysinfo);
+	if (ret != 0)
+		debug("Failed to parse coreboot tables.\n");
+
+	return 0;
+}
diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 45401d5e3c8a..70299aec2df4 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,6 +108,9 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+#ifdef CONFIG_SYS_COREBOOT
+	ulong coreboot_table;		/* Address of coreboot table */
+#endif
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index 9ac2a6bf4a09..704a00e26045 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -340,19 +340,6 @@ int reserve_arch(void)
 }
 #endif
 
-static long detect_coreboot_table_at(ulong start, ulong size)
-{
-	u32 *ptr, *end;
-
-	size /= 4;
-	for (ptr = (void *)start, end = ptr + size; ptr < end; ptr += 4) {
-		if (*ptr == 0x4f49424c) /* "LBIO" */
-			return (long)ptr;
-	}
-
-	return -ENOENT;
-}
-
 long locate_coreboot_table(void)
 {
 	long addr;
diff --git a/include/cb_sysinfo.h b/include/cb_sysinfo.h
index 62a483e10cef..3bd997dcca39 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -228,6 +228,13 @@ struct sysinfo_t {
 
 extern struct sysinfo_t lib_sysinfo;
 
+/**
+ * detect_coreboot_table_at() - Helper to find coreboot table
+ *
+ * Return: Address of coreboot table or -ENOENT on failure
+ */
+long detect_coreboot_table_at(ulong start, ulong size);
+
 /**
  * get_coreboot_info() - parse the coreboot sysinfo table
  *
diff --git a/lib/coreboot/Kconfig b/lib/coreboot/Kconfig
index 870693dca66c..eb686ac3c69f 100644
--- a/lib/coreboot/Kconfig
+++ b/lib/coreboot/Kconfig
@@ -1,9 +1,9 @@
 menu "U-Boot as Coreboot payload"
-	depends on VENDOR_COREBOOT
+	depends on ARM64 || VENDOR_COREBOOT
 
 config SYS_COREBOOT
-	bool
-	default y
+	bool "Support for booting u-boot as a coreboot payload" if ARM64
+	default VENDOR_COREBOOT
 	imply SYS_NS16550
 	imply SCSI
 	imply SCSI_AHCI
@@ -17,15 +17,15 @@ config SYS_COREBOOT
 	imply USB_XHCI_HCD
 	imply USB_STORAGE
 	imply USB_KEYBOARD
-	imply VIDEO_COREBOOT
-	imply E1000
+	imply VIDEO_COREBOOT if x86
+	imply E1000 if x86
 	imply ETH_DESIGNWARE
-	imply PCH_GBE
+	imply PCH_GBE if X86
 	imply RTL8169
 	imply CMD_CBFS
 	imply FS_CBFS
 	imply CBMEM_CONSOLE
-	imply X86_TSC_READ_BASE
+	imply X86_TSC_READ_BASE if X86
 	imply USE_PREBOOT
 	select BINMAN if X86_64
 	select SYSINFO
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index f8f2002d46f0..36cd352818a2 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -446,6 +446,19 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
 	return 1;
 }
 
+long detect_coreboot_table_at(ulong start, ulong size)
+{
+	u32 *ptr, *end;
+
+	size /= 4;
+	for (ptr = (void *)start, end = ptr + size; ptr < end; ptr += 4) {
+		if (*ptr == 0x4f49424c) /* "LBIO" */
+			return (long)ptr;
+	}
+
+	return -ENOENT;
+}
+
 int get_coreboot_info(struct sysinfo_t *info)
 {
 	long addr;
-- 
Sent by a computer, using git, on the internet

