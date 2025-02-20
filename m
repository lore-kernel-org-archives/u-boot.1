Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AFEC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37FF8810E5;
	Thu, 20 Feb 2025 22:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="irNkAtJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D88480F84; Thu, 20 Feb 2025 21:59:13 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F2380EC0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22100006bc8so25308875ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085149; x=1740689949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAjEvGwws3OAyI7ABH1Tj05/2ohEAwgobww91Dx8OcU=;
 b=irNkAtJjSZTY/5IT5dL9/0oYVjNu9HUzrbCog/DMHpda9gbWYVdgkStnToRVzxKkqs
 E3j0rtWP+M4fGCKlbXndZKjhsxRIqOGTwDq0TVr7EXd/00tbnRrM2oFQaH5WGFVVpMBv
 P81IRIzkjn9T+xJOssmepf6RuKMdGEEFkZxcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085149; x=1740689949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAjEvGwws3OAyI7ABH1Tj05/2ohEAwgobww91Dx8OcU=;
 b=dP3wMSpApDBVCxbBfnCjOaSfFDGzao6T1MD6poXLVmWmBxWizldGBcq7gpUHxFNG0q
 ouBXFmRgT6E6Ww09lCV3LY5mbw/cnZjOH+/v9+lBdSUsI0iO8aefm7TtHuyXKI/CP/3Z
 SYnkiOkNa8OysTuOeknwHCGcKn9+tXqfdy0P0Gp2OtRmNoL2kd2a9W85lvh1kNIeZ4eh
 DNxdRah/+bECJDX/n3J93PMB2mCbvll0AU0kTSgG07W9V5RbvgJCs2Xkj4sOt8RxV9En
 ptTUNM8uXP1EzZLbIrevQakMVtpbkD6fBcaHD6ZI/TyNG0D5LsmNrL82wU+3GBEp4Bhx
 xGww==
X-Gm-Message-State: AOJu0Ywr3qM0NSSvKfWYzANjHsmjKlOCsT4d8hyHJJpctObqlD+3CXU7
 PbpTdMSzUpFG6hFP0AzEr+45GJyAKWrnQffbJiDIvEtUBrfkRivpMq9ifq7vEGHd/5nNe+7Ku9Y
 =
X-Gm-Gg: ASbGncsmZzdK1WcIDyNw9dv1yq1wMtSqiQfYOf9uThmSSb+ksFhMSzNFgdOtdcdYOpy
 xtHNgS2DCriQC4PfBP2qOSsBLy4EUAZtmVgo0q3klHyoAxauSwVAh2ZgGg75kSrBVlcRmS0gPJw
 +NMof6UhU0+CqBgf+cdCBMZjV5tjTWPzBLSo+Pub8Z2T1Nc0Dn5NWTszrIfB+Qx7aNFERm0SpQP
 j24d/VtDqxz74GTxPPw1DPt9+c9qXHA2WP3u1pcA0oNnv0gsb7qdpjpq7nc5Iu80t5opvMWy/1z
 fnFzd9/twjEApGkcJ8BLn9Oqye5KNjFU0s7VfG27CUIjzWPnNmNcVuI=
X-Google-Smtp-Source: AGHT+IEnWF/Og1YhYMLZ7QUXNmhUNfj9apvIxhqkZAGIMH+uWhSpv573hnRjs8s94OJ1PPaOWQtoMA==
X-Received: by 2002:a17:902:e552:b0:21f:3a7b:f4f1 with SMTP id
 d9443c01a7336-2219ffddf44mr10256355ad.32.1740085149480; 
 Thu, 20 Feb 2025 12:59:09 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-220d558fe3asm124660845ad.234.2025.02.20.12.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:09 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 05/12] arm: Support running U-Boot as a coreboot payload on
 ARM64
Date: Thu, 20 Feb 2025 12:58:47 -0800
Message-ID: <20250220205900.3127680-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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
 arch/arm/Kconfig                     |  2 ++
 arch/arm/cpu/armv8/Makefile          |  1 +
 arch/arm/cpu/armv8/coreboot/Kconfig  | 22 +++++++++++++
 arch/arm/cpu/armv8/coreboot/Makefile |  4 +++
 arch/arm/cpu/armv8/coreboot/cpu.c    | 46 ++++++++++++++++++++++++++++
 arch/arm/include/asm/global_data.h   |  3 ++
 6 files changed, 78 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/coreboot/Kconfig
 create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
 create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 314916527c9e..027e2a31259c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2354,6 +2354,8 @@ source "arch/arm/cpu/armv7/Kconfig"
 
 source "arch/arm/cpu/armv8/Kconfig"
 
+source "arch/arm/cpu/armv8/coreboot/Kconfig"
+
 source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-nexell/Kconfig"
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index b4126c61df15..39258a07db6c 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
 
 obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
+obj-$(CONFIG_SYS_COREBOOT) += coreboot/
diff --git a/arch/arm/cpu/armv8/coreboot/Kconfig b/arch/arm/cpu/armv8/coreboot/Kconfig
new file mode 100644
index 000000000000..9392d941df02
--- /dev/null
+++ b/arch/arm/cpu/armv8/coreboot/Kconfig
@@ -0,0 +1,22 @@
+config SYS_COREBOOT
+	bool "Support for booting u-boot as a coreboot payload"
+	imply SCSI
+	imply SCSI_AHCI
+	imply AHCI_PCI
+	imply MMC
+	imply MMC_PCI
+	imply MMC_SDHCI
+	imply MMC_SDHCI_SDMA
+	imply USB
+	imply USB_EHCI_HCD
+	imply USB_XHCI_HCD
+	imply USB_STORAGE
+	imply USB_KEYBOARD
+	imply ETH_DESIGNWARE
+	imply RTL8169
+	imply CMD_CBFS
+	imply FS_CBFS
+	imply CBMEM_CONSOLE
+	imply USE_PREBOOT
+	select SYSINFO
+	imply SYSINFO_EXTRA
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
index 000000000000..e133656858a9
--- /dev/null
+++ b/arch/arm/cpu/armv8/coreboot/cpu.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <cb_sysinfo.h>
+#include <linux/errno.h>
+#include <linux/sizes.h>
+#include <log.h>
+
+static long detect_coreboot_table_at(ulong start, ulong size)
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
-- 
Sent by a computer, using git, on the internet

