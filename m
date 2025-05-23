Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34D5C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 626C283438;
	Sat, 24 May 2025 01:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oclxWRPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C37783423; Sat, 24 May 2025 00:59:08 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BED8333D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso395666b3a.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041144; x=1748645944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJI1cidjZPJiLYWcOcvyOETAfdNzdwPs12z/4M5own0=;
 b=oclxWRPZFhzYCGzM90Oh24/OmHcT6r8iz+L7neX7fbtmS1b3j8+Ef63UNikVyd7ELO
 i70rtOJsgE4RlpLH5RRjtBfzxciccWvdeIJMnrPrqBn4T6gvSOPySKlez3C4J5NNpTgM
 IKKikhCZ+ZVXnPdRGs/z/3TcwLttX5NRgdepU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041144; x=1748645944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJI1cidjZPJiLYWcOcvyOETAfdNzdwPs12z/4M5own0=;
 b=rZEhCDTuoUdi8f+W0azLFkRBPxOwO9T6zugamsin+K0MJwJy8hac2zCIMv5J60PfE6
 UNSzq0oy7FFfJ9NR9p/Hy3SrdF4p8rMFhI/6eDKbMKHpkj+YlXZrwaXBGWvfa4iMkf4l
 x0K3hxN4vlo5XsguOG2Dutjim9Vs3zx82/2RPz7u2QdIygdfw4x1VZKhfA7EOB8bIQ23
 PlpmyC2COmICHAfGvMmXJGTX3u87qqsm32LmXs/199i3VZbcObLyLKcYE894+8P0iXY6
 ahLUjN2KqUkk2qPoJo70qmIi0tcykAxIEE4hDxHqFDL1XL6/lsXI6x1n9kuHjeQ1ytQ0
 PbTA==
X-Gm-Message-State: AOJu0Yxj59QwUrKdq5S4/8mHTyNmRMp9vvryu8aIjPyeYLm7SWwd9B5l
 jqiLQ6tWeE7Z+w41Z6Ign8y9vdEPb3EQv94q8WET66GRJg7GtEkmHdKsnxa4g30OqoyvdOK3jaS
 i6HI=
X-Gm-Gg: ASbGncsCCkUi/1EYJCdTHCCx1Rc9gEYaLTXBBkFSluu92vwcjG862u/ut3rmUectKEA
 OG/KCRkcFjHCs/qyq0HrTc+V8HO8iHWZUPqP3/DSefOuvcwldm3vwMVdHcWfSMP+tFHcImJ89qM
 zJduZ/jND88pLmz0gP6C8oLATrNzGNc0BTgmtE6WyWDo7b0emCJ4sZhrYQuHYnlg9wjHzbi8LS4
 qgt2w6bTaColH5h4Er39t3mmfKo3ElkrVWOKfffgIuhnEru285ajZqWcGOHbvdHfBX+p0faitDR
 L7jh+EHnG7TOaqHgh44oEKdkAPkz47W0zYPSHU2TRhES8SxvXhxzadFg00X9h7CDfBzHyVcG0e1
 C+i82CwgbWBP+KsU=
X-Google-Smtp-Source: AGHT+IG4uMoRo+7hyQ3RPRFtLVZ0C/B1OeXyN3PyEhpgU4RRk6s+Mct6Kk7VDe0d1PI53r+Lir2BTQ==
X-Received: by 2002:a05:6a00:84c:b0:73c:3f2e:5df5 with SMTP id
 d2e1a72fcca58-745fe068dabmr1724464b3a.9.1748041144344; 
 Fri, 23 May 2025 15:59:04 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a970d75csm13777712b3a.69.2025.05.23.15.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:04 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 11/28] arm: Support running U-Boot as a coreboot payload on
 ARM64
Date: Fri, 23 May 2025 15:58:26 -0700
Message-ID: <20250523225845.2311989-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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
 lib/Makefile                         |  2 +-
 lib/coreboot/Kconfig                 | 14 +++++++-------
 lib/coreboot/cb_sysinfo.c            | 13 +++++++++++++
 9 files changed, 58 insertions(+), 21 deletions(-)
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
diff --git a/lib/Makefile b/lib/Makefile
index 4aa066130918..eda969cea109 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -136,7 +136,7 @@ obj-$(CONFIG_LIB_UUID) += uuid.o
 obj-$(CONFIG_LIB_RAND) += rand.o
 obj-y += panic.o
 
-obj-$(CONFIG_VENDOR_COREBOOT)	+= coreboot/
+obj-$(CONFIG_SYS_COREBOOT)	+= coreboot/
 
 ifeq ($(CONFIG_XPL_BUILD),y)
 # SPL U-Boot may use full-printf, tiny-printf or none at all
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

