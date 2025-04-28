Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E574C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEB682958;
	Mon, 28 Apr 2025 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y7IjYTw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B052D820F6; Mon, 28 Apr 2025 21:24:46 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A3B80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso5252861b3a.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868282; x=1746473082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPhLgWTaNDFKbWy6US5y0+GZA/iIcvgfjvNFkmIDZSU=;
 b=Y7IjYTw6h5gZOFARmzDktZYyiqrj8nObrlSBlDtUtx8wLZ7suFzJGkd6Fc0X6cztuo
 LoWxSgoIXNdZFqeL0A5KljL6TGlSbAyt0WRzyzg2ISoDidT3zt3iqL97ZLhIe6Uj0yb/
 mkb1oZJ5o3SZ6QNKTSCsL4wfb3bYmDrTm6Ut8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868282; x=1746473082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPhLgWTaNDFKbWy6US5y0+GZA/iIcvgfjvNFkmIDZSU=;
 b=ZruY4MNx7a2daNaPLIGpDiWUKaQvjeXzeHtZl4WtZixVahKa5GZ3xZvGJ80figawQ6
 S4TyhMpxxzRAfswT+eOcTi4VuOKheJM9fOb+SAXTXvoXCDuxD9vDHkux4JyCLhownfP3
 oAotMqXJ5nXIIoqABfe2Mt+zG718XUPI2hLoBJdtqGgvO69urnl0YhLGVNlyRbUIffqm
 ywXLaViLN5GTWuYlmNVfGSDhGRetqSJ1eeQtJ17Wl0Yfs8cnvYX16IkDQO8+qwYDckCd
 rGQzq9odH3CkeS0tFjIg0o2aIOUOFHPlhktWB1QelXxYHimgzA/lZmpFiTJccw9iuU6q
 0ITA==
X-Gm-Message-State: AOJu0YwpGzwi4RG9quLKlFdDHIU6fuF1FEwmjZihvOTvYIw0W7pRTRwN
 tq843CxfdM13kE477CjOSfrLn209o3CUQyUf1CNMo4NkuOkvW8qDn9ZfD/6sy6TNUP62jfS2qK8
 =
X-Gm-Gg: ASbGnctlbE2UVrAiTtkBZkNc+xqGLPgrHNhIlSa8h0Jj/mM/fBPnqpAL7NivyEbcX7N
 5m+g1jXbxA2mpK/OpAKnqMhGYq9wjdB5jjQjWep6sDIZpCgzLlkHaHiIydLI1J3ZF43ls+8x0Rj
 wkUnPbAVtnAfjatCz+CGiNt7s2B0FTAPNLF6a8xipBLxWrVJfW/RVdy3PD56W3gpnBL/5mvjWnE
 JI75IlYRsqy0ck42u3El4NY7yrLLreJbWjA8mKntpWcSgyYL6DlKh+P1IRD3gC3lURxbZPW+WK8
 nwAGHf8ECGdSLPBLENGpPRsx6mzdIZhbvZe2iFtE30kvj9oqumLVtGXiWHtjhqWcfkXZVNXvdCM
 pSnGVHkY65WkQ
X-Google-Smtp-Source: AGHT+IEQ29Xakf9ZqDn+2vhG4vWZGeQtmPeZT2f9+yM8p0x1SKODgb90w1JhY6PrKIzoycVytPjIBw==
X-Received: by 2002:a05:6a00:181c:b0:736:3c77:31fd with SMTP id
 d2e1a72fcca58-73ff73d813bmr13061054b3a.23.1745868282618; 
 Mon, 28 Apr 2025 12:24:42 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e25aca292sm8347179b3a.168.2025.04.28.12.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:42 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 08/17] arm: Support running U-Boot as a coreboot payload on
 ARM64
Date: Mon, 28 Apr 2025 12:24:15 -0700
Message-ID: <20250428192427.3877612-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/cpu/armv8/Makefile          |  1 +
 arch/arm/cpu/armv8/coreboot/Makefile |  4 ++++
 arch/arm/cpu/armv8/coreboot/cpu.c    | 22 ++++++++++++++++++++++
 arch/arm/include/asm/global_data.h   |  3 +++
 arch/x86/cpu/cpu.c                   | 13 -------------
 include/cb_sysinfo.h                 |  7 +++++++
 lib/coreboot/Kconfig                 | 14 +++++++-------
 lib/coreboot/cb_sysinfo.c            | 13 +++++++++++++
 8 files changed, 57 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index dd0191a12fac..8699433a96ae 100644
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
index 000000000000..d0133049a294
--- /dev/null
+++ b/arch/arm/cpu/armv8/coreboot/cpu.c
@@ -0,0 +1,22 @@
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
index a40563e5a400..f91cfb984c1a 100644
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
index 40d8030dbb8b..f24099fc0ef9 100644
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
index cec0bcc0885f..10b67138a400 100644
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
 	select BINMAN if X86_RUN_64BIT
 	select SYSINFO
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 1ea4ec4a0487..101e5ff4037b 100644
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

