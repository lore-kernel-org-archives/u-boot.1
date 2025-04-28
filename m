Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708DAC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADEF828C2;
	Mon, 28 Apr 2025 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SC+LLP8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2C6820F6; Mon, 28 Apr 2025 21:24:44 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D099E82132
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso3823677a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868280; x=1746473080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQaZ5Is8+W1jZIv7huVP62m5f4bvlPaWssegR19WVA8=;
 b=SC+LLP8JJbeJTwjt/40ZP7LQRZ/MXo5E357GpVFeUAa8FLTzSloztjHVbsOX+9iObH
 CQFdf05HvHb2lExdB/2U3LAg1hrdv8gx+8MaJRqfPcSje2nKEbyaaHgci0Zj8qBM6KhQ
 XLs5iero2PsQ7Lxrj+kUeBXnmHK5KuEdAOKzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868280; x=1746473080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQaZ5Is8+W1jZIv7huVP62m5f4bvlPaWssegR19WVA8=;
 b=fpDornBnzLbcetUZCOejGafkOhDArV5Ba7H9J2QW/KpC5z9N5xy+UPpK0Y1G7503wd
 oa4Ev3WiVOpuTnNo6LbBM+KRuJ28GbiL4NMeCNi6yNynEjgeEEiAE/UBs7CR2OEMGkrM
 c+cxnz7fMwqCnfvfcGiO8MDYo4zp3PtzyCKFrvaC0/7QvYpJSNdPw0hB9s98RuD+PGDi
 bezOSj1wSx4hB+SuSXW8AngM/PYlgA08am+r5yJFm2l2nfbiWge76QYydjt8f8Dh+PFF
 5buBwvfVEF22DGU0t+A1f6y8Sq9h8rBWMWL50C4DrYknWrQmG5dBhUSTlfIwkHutqwnA
 Desg==
X-Gm-Message-State: AOJu0YzVj3jrRaTu6L9B8hMy8iiNLhM2jQapAbZRdk9ASRtGr24frK10
 sikXzbOEy8XKZIz7k9OvjLmCUbgZSTj5ecXVOcWQGb/BDfvYDBGU3mENbmAdszPvr5RZuFembtY
 =
X-Gm-Gg: ASbGncsNjSYKtpe7Zs8sV0yUEi7xsgELU+PQLDd0+8wxOKL2sw+rPvHIreAJftj4jKW
 RatULUrvZz+4RaiMH6g3NLRE8C2s16dIR8l1j64IPrbehggezB4MCymLzdWLjkBGlM5xJWMiFfr
 aKbfGro7e79ZePmWq60ZCSQ3DuZqjnu+p1y63ApDiCGZ//LDgFN65xn9dQC3CeKIYCEUgnrmTMP
 gqtSm2Szh8DdNZIV4NjrDWeOSBCS7H6LPoEe1dl8ttil7XweYSXyRUb+V4dwlukAgM2ttEEt5FL
 JEXOpWF/ruSbLTIed/4l2TajsJdhx7tNmp3JKcqI8BpG3fo7fETpvDZ8A7B0YgbmKznimOsDdo5
 TtQ==
X-Google-Smtp-Source: AGHT+IGAWbMTbfoC2Vonildjfejq/JJZENoc5Whehty+StxjSufxAakC01GPmdIZT3bDufyHL6zfmg==
X-Received: by 2002:a17:90b:554d:b0:2f4:4500:bb4d with SMTP id
 98e67ed59e1d1-30a0132ba1emr14905689a91.20.1745868279792; 
 Mon, 28 Apr 2025 12:24:39 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309ef03bb26sm10464615a91.6.2025.04.28.12.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:39 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 06/17] coreboot: Move coreboot logic out of x86 to a
 generic place
Date: Mon, 28 Apr 2025 12:24:13 -0700
Message-ID: <20250428192427.3877612-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Lay the groundwork to run U-Boot as a payload on ARM coreboot based
devices. Move the coreboot table parsing code out of arch/x86 into
lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
to be globally accessible, so move them into the top level include
directory. Introduce helper functions like
board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
dram_init_banksize_from_coreboot() so that boards can still override
these common functions while also supporting booting as a coreboot
payload.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/x86/Kconfig                              | 22 ------
 arch/x86/cpu/coreboot/Kconfig                 | 33 --------
 arch/x86/cpu/coreboot/coreboot.c              |  4 +-
 arch/x86/cpu/coreboot/sdram.c                 | 78 +------------------
 arch/x86/cpu/coreboot/timestamp.c             |  2 +-
 arch/x86/cpu/cpu.c                            |  2 +-
 arch/x86/cpu/i386/cpu.c                       |  2 +-
 .../x86/include/asm/arch-coreboot/timestamp.h |  2 +-
 arch/x86/lib/coreboot/Makefile                |  1 -
 arch/x86/lib/coreboot/cb_support.c            |  2 +-
 arch/x86/lib/coreboot_table.c                 |  2 +-
 arch/x86/lib/tables.c                         |  2 +-
 board/coreboot/coreboot/coreboot.c            |  2 +-
 board/coreboot/coreboot/sysinfo.c             |  2 +-
 board/google/chromebook_coral/coral.c         |  2 +-
 boot/Kconfig                                  |  1 +
 boot/expo_build_cb.c                          |  2 +-
 cmd/version.c                                 |  2 +-
 cmd/x86/cbcmos.c                              |  2 +-
 cmd/x86/cbsysinfo.c                           |  2 +-
 drivers/misc/cbmem_console.c                  |  2 +-
 drivers/serial/serial_coreboot.c              |  2 +-
 drivers/video/coreboot.c                      |  2 +-
 .../x86/include/asm => include}/cb_sysinfo.h  | 22 +++++-
 .../include/asm => include}/coreboot_tables.h |  0
 lib/Makefile                                  |  2 +
 lib/coreboot/Kconfig                          | 55 +++++++++++++
 lib/coreboot/Makefile                         | 17 ++++
 {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 14 +---
 {arch/x86/cpu => lib}/coreboot/sdram.c        | 15 +---
 30 files changed, 125 insertions(+), 173 deletions(-)
 delete mode 100644 arch/x86/cpu/coreboot/Kconfig
 rename {arch/x86/include/asm => include}/cb_sysinfo.h (94%)
 rename {arch/x86/include/asm => include}/coreboot_tables.h (100%)
 create mode 100644 lib/coreboot/Kconfig
 create mode 100644 lib/coreboot/Makefile
 rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (95%)
 copy {arch/x86/cpu => lib}/coreboot/sdram.c (87%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dc9483ad7232..670fc04eb312 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,7 +119,6 @@ source "arch/x86/cpu/apollolake/Kconfig"
 source "arch/x86/cpu/baytrail/Kconfig"
 source "arch/x86/cpu/braswell/Kconfig"
 source "arch/x86/cpu/broadwell/Kconfig"
-source "arch/x86/cpu/coreboot/Kconfig"
 source "arch/x86/cpu/ivybridge/Kconfig"
 source "arch/x86/cpu/efi/Kconfig"
 source "arch/x86/cpu/qemu/Kconfig"
@@ -1049,27 +1048,6 @@ config INTEL_GMA_SWSMISCI
 
 endif # INTEL_SOC
 
-config COREBOOT_SYSINFO
-	bool "Support reading coreboot sysinfo"
-	default y if SYS_COREBOOT
-	help
-	  Select this option to read the coreboot sysinfo table on start-up,
-	  if present. This is written by coreboot before it exits and provides
-	  various pieces of information about the running system, including
-	  display, memory and build information. It is stored in
-	  struct sysinfo_t after parsing by get_coreboot_info().
-
-config SPL_COREBOOT_SYSINFO
-	bool "Support reading coreboot sysinfo"
-	depends on SPL
-	default y if COREBOOT_SYSINFO
-	help
-	  Select this option to read the coreboot sysinfo table in SPL,
-	  if present. This is written by coreboot before it exits and provides
-	  various pieces of information about the running system, including
-	  display, memory and build information. It is stored in
-	  struct sysinfo_t after parsing by get_coreboot_info().
-
 config ZBOOT
 	bool "Support the zImage format"
 	default y
diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconfig
deleted file mode 100644
index 66f25533b97f..000000000000
--- a/arch/x86/cpu/coreboot/Kconfig
+++ /dev/null
@@ -1,33 +0,0 @@
-if VENDOR_COREBOOT
-
-config SYS_COREBOOT
-	bool
-	default y
-	imply SYS_NS16550
-	imply SCSI
-	imply SCSI_AHCI
-	imply AHCI_PCI
-	imply MMC
-	imply MMC_PCI
-	imply MMC_SDHCI
-	imply MMC_SDHCI_SDMA
-	imply USB
-	imply USB_EHCI_HCD
-	imply USB_XHCI_HCD
-	imply USB_STORAGE
-	imply USB_KEYBOARD
-	imply VIDEO_COREBOOT
-	imply E1000
-	imply ETH_DESIGNWARE
-	imply PCH_GBE
-	imply RTL8169
-	imply CMD_CBFS
-	imply FS_CBFS
-	imply CBMEM_CONSOLE
-	imply X86_TSC_READ_BASE
-	imply USE_PREBOOT
-	select BINMAN if X86_RUN_64BIT
-	select SYSINFO
-	imply SYSINFO_EXTRA
-
-endif
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d0719d1a4056..cd9ad22b3db3 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -5,6 +5,7 @@
  * Graeme Russ, graeme.russ@gmail.com.
  */
 
+#include <cb_sysinfo.h>
 #include <cpu_func.h>
 #include <event.h>
 #include <fdtdec.h>
@@ -14,7 +15,6 @@
 #include <asm/io.h>
 #include <asm/msr.h>
 #include <asm/mtrr.h>
-#include <asm/cb_sysinfo.h>
 #include <asm/arch/timestamp.h>
 #include <dm/ofnode.h>
 
@@ -32,6 +32,8 @@ int arch_cpu_init(void)
 		printf("Failed to parse coreboot tables.\n");
 		return ret;
 	}
+	gd_set_acpi_start(map_to_sysmem(lib_sysinfo.rsdp));
+	gd_set_smbios_start(lib_sysinfo.smbios_start);
 
 	timestamp_init();
 
diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
index 013225f129a9..d286993d82ac 100644
--- a/arch/x86/cpu/coreboot/sdram.c
+++ b/arch/x86/cpu/coreboot/sdram.c
@@ -5,98 +5,28 @@
  * Graeme Russ, <graeme.russ@gmail.com>
  */
 
+#include <cb_sysinfo.h>
 #include <init.h>
 #include <asm/e820.h>
-#include <asm/cb_sysinfo.h>
 #include <asm/global_data.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 unsigned int install_e820_map(unsigned int max_entries,
 			      struct e820_entry *entries)
 {
 	return cb_install_e820_map(max_entries, entries);
 }
 
-/*
- * This function looks for the highest region of memory lower than 4GB which
- * has enough space for U-Boot where U-Boot is aligned on a page boundary. It
- * overrides the default implementation found elsewhere which simply picks the
- * end of ram, wherever that may be. The location of the stack, the relocation
- * address, and how far U-Boot is moved by relocation are set in the global
- * data structure.
- */
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
-	uintptr_t dest_addr = 0;
-	int i;
-
-	for (i = 0; i < lib_sysinfo.n_memranges; i++) {
-		struct memrange *memrange = &lib_sysinfo.memrange[i];
-		/* Force U-Boot to relocate to a page aligned address. */
-		uint64_t start = roundup(memrange->base, 1 << 12);
-		uint64_t end = memrange->base + memrange->size;
-
-		/* Ignore non-memory regions. */
-		if (memrange->type != CB_MEM_RAM)
-			continue;
-
-		/* Filter memory over 4GB. */
-		if (end > 0xffffffffULL)
-			end = 0x100000000ULL;
-		/* Skip this region if it's too small. */
-		if (end - start < total_size)
-			continue;
-
-		/* Use this address if it's the largest so far. */
-		if (end > dest_addr)
-			dest_addr = end;
-	}
-
-	/* If no suitable area was found, return an error. */
-	if (!dest_addr)
-		panic("No available memory found for relocation");
-
-	return (ulong)dest_addr;
+	return coreboot_board_get_usable_ram_top(total_size);
 }
 
 int dram_init(void)
 {
-	int i;
-	phys_size_t ram_size = 0;
-
-	for (i = 0; i < lib_sysinfo.n_memranges; i++) {
-		struct memrange *memrange = &lib_sysinfo.memrange[i];
-		unsigned long long end = memrange->base + memrange->size;
-
-		if (memrange->type == CB_MEM_RAM && end > ram_size)
-			ram_size += memrange->size;
-	}
-
-	gd->ram_size = ram_size;
-	if (ram_size == 0)
-		return -1;
-
-	return 0;
+	return coreboot_dram_init()
 }
 
 int dram_init_banksize(void)
 {
-	int i, j;
-
-	if (CONFIG_NR_DRAM_BANKS) {
-		for (i = 0, j = 0; i < lib_sysinfo.n_memranges; i++) {
-			struct memrange *memrange = &lib_sysinfo.memrange[i];
-
-			if (memrange->type == CB_MEM_RAM) {
-				gd->bd->bi_dram[j].start = memrange->base;
-				gd->bd->bi_dram[j].size = memrange->size;
-				j++;
-				if (j >= CONFIG_NR_DRAM_BANKS)
-					break;
-			}
-		}
-	}
-
-	return 0;
+	return coreboot_dram_init_banksize();
 }
diff --git a/arch/x86/cpu/coreboot/timestamp.c b/arch/x86/cpu/coreboot/timestamp.c
index 681191d85bb6..18be969ccea6 100644
--- a/arch/x86/cpu/coreboot/timestamp.c
+++ b/arch/x86/cpu/coreboot/timestamp.c
@@ -6,9 +6,9 @@
  */
 
 #include <bootstage.h>
+#include <cb_sysinfo.h>
 #include <errno.h>
 #include <asm/arch/timestamp.h>
-#include <asm/cb_sysinfo.h>
 #include <asm/u-boot-x86.h>
 #include <linux/compiler.h>
 
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index c373b14df30c..a40563e5a400 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -22,6 +22,7 @@
 
 #include <bootstage.h>
 #include <command.h>
+#include <coreboot_tables.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
@@ -35,7 +36,6 @@
 #include <acpi/acpi_table.h>
 #include <asm/acpi.h>
 #include <asm/control_regs.h>
-#include <asm/coreboot_tables.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/lapic.h>
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index ee6dbeb5c48e..14a79963b112 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -18,13 +18,13 @@
  * src/arch/x86/lib/cpu.c
  */
 
+#include <coreboot_tables.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <log.h>
 #include <malloc.h>
 #include <spl.h>
 #include <asm/control_regs.h>
-#include <asm/coreboot_tables.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/mp.h>
diff --git a/arch/x86/include/asm/arch-coreboot/timestamp.h b/arch/x86/include/asm/arch-coreboot/timestamp.h
index bbf89447dde4..227316975047 100644
--- a/arch/x86/include/asm/arch-coreboot/timestamp.h
+++ b/arch/x86/include/asm/arch-coreboot/timestamp.h
@@ -8,7 +8,7 @@
 #ifndef __COREBOOT_TIMESTAMP_H__
 #define __COREBOOT_TIMESTAMP_H__
 
-#include <asm/cb_sysinfo.h>
+#include <cb_sysinfo.h>
 
 void timestamp_init(void);
 void timestamp_add(enum timestamp_id id, uint64_t ts_time);
diff --git a/arch/x86/lib/coreboot/Makefile b/arch/x86/lib/coreboot/Makefile
index cb0ae1d017b2..95dcaf8920db 100644
--- a/arch/x86/lib/coreboot/Makefile
+++ b/arch/x86/lib/coreboot/Makefile
@@ -3,5 +3,4 @@
 # Copyright 2021 Google LLC
 #
 
-obj-y += cb_sysinfo.o
 obj-y += cb_support.o
diff --git a/arch/x86/lib/coreboot/cb_support.c b/arch/x86/lib/coreboot/cb_support.c
index b4d5fa4af327..32880d18ed1e 100644
--- a/arch/x86/lib/coreboot/cb_support.c
+++ b/arch/x86/lib/coreboot/cb_support.c
@@ -5,7 +5,7 @@
  * Copyright 2021 Google LLC
  */
 
-#include <asm/cb_sysinfo.h>
+#include <cb_sysinfo.h>
 #include <asm/e820.h>
 #include <linux/kernel.h>
 
diff --git a/arch/x86/lib/coreboot_table.c b/arch/x86/lib/coreboot_table.c
index 33fce5d0a5e5..ffe98ea491a0 100644
--- a/arch/x86/lib/coreboot_table.c
+++ b/arch/x86/lib/coreboot_table.c
@@ -3,11 +3,11 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <coreboot_tables.h>
 #include <malloc.h>
 #include <net.h>
 #include <vesa.h>
 #include <acpi/acpi_s3.h>
-#include <asm/coreboot_tables.h>
 #include <asm/e820.h>
 #include <asm/global_data.h>
 
diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index ec52992209f0..dadc5694cfbc 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -6,6 +6,7 @@
 #define LOG_CATEGORY LOGC_ACPI
 
 #include <bloblist.h>
+#include <coreboot_tables.h>
 #include <log.h>
 #include <malloc.h>
 #include <smbios.h>
@@ -14,7 +15,6 @@
 #include <asm/sfi.h>
 #include <asm/mpspec.h>
 #include <asm/tables.h>
-#include <asm/coreboot_tables.h>
 #include <linux/log2.h>
 #include <linux/sizes.h>
 
diff --git a/board/coreboot/coreboot/coreboot.c b/board/coreboot/coreboot/coreboot.c
index f2ca10767681..c12af5c79322 100644
--- a/board/coreboot/coreboot/coreboot.c
+++ b/board/coreboot/coreboot/coreboot.c
@@ -3,10 +3,10 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <cb_sysinfo.h>
 #include <splash.h>
 #include <init.h>
 #include <smbios.h>
-#include <asm/cb_sysinfo.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/coreboot/coreboot/sysinfo.c b/board/coreboot/coreboot/sysinfo.c
index d6b19530023e..c510cd1e1b7f 100644
--- a/board/coreboot/coreboot/sysinfo.c
+++ b/board/coreboot/coreboot/sysinfo.c
@@ -6,10 +6,10 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <cb_sysinfo.h>
 #include <dm.h>
 #include <smbios.h>
 #include <sysinfo.h>
-#include <asm/cb_sysinfo.h>
 
 struct cb_sysinfo_priv {
 	const struct smbios_header *bios;
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index db96534857c8..c0d50bf4c717 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -6,6 +6,7 @@
 #define LOG_CATEGORY	UCLASS_SYSINFO
 
 #include <bloblist.h>
+#include <cb_sysinfo.h>
 #include <command.h>
 #include <cros_ec.h>
 #include <dm.h>
@@ -16,7 +17,6 @@
 #include <acpi/acpigen.h>
 #include <asm-generic/gpio.h>
 #include <asm/acpi_nhlt.h>
-#include <asm/cb_sysinfo.h>
 #include <asm/intel_gnvs.h>
 #include <asm/intel_pinctrl.h>
 #include <dm/acpi.h>
diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc95..9d24e22f5603 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1,5 +1,6 @@
 menu "Boot options"
 
+source "lib/coreboot/Kconfig"
 source "lib/efi_loader/Kconfig"
 
 menu "Boot images"
diff --git a/boot/expo_build_cb.c b/boot/expo_build_cb.c
index 442ad760e796..47c62ca7e920 100644
--- a/boot/expo_build_cb.c
+++ b/boot/expo_build_cb.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
+#include <cb_sysinfo.h>
 #include <cedit.h>
 #include <ctype.h>
 #include <errno.h>
@@ -15,7 +16,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <vsprintf.h>
-#include <asm/cb_sysinfo.h>
 
 /**
  * struct build_info - Information to use when building
diff --git a/cmd/version.c b/cmd/version.c
index 62406608eb0b..31c8dc5e85bc 100644
--- a/cmd/version.c
+++ b/cmd/version.c
@@ -10,7 +10,7 @@
 #include <version_string.h>
 #include <linux/compiler.h>
 #ifdef CONFIG_SYS_COREBOOT
-#include <asm/cb_sysinfo.h>
+#include <cb_sysinfo.h>
 #endif
 
 static int do_version(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/x86/cbcmos.c b/cmd/x86/cbcmos.c
index fe5582fbf511..84a81be53cdd 100644
--- a/cmd/x86/cbcmos.c
+++ b/cmd/x86/cbcmos.c
@@ -7,10 +7,10 @@
 
 #define LOG_CATEGORY	UCLASS_RTC
 
+#include <cb_sysinfo.h>
 #include <command.h>
 #include <dm.h>
 #include <rtc.h>
-#include <asm/cb_sysinfo.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/cmd/x86/cbsysinfo.c b/cmd/x86/cbsysinfo.c
index ea4d89616f62..3936d30da0e1 100644
--- a/cmd/x86/cbsysinfo.c
+++ b/cmd/x86/cbsysinfo.c
@@ -4,7 +4,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <asm/cb_sysinfo.h>
+#include <cb_sysinfo.h>
 #include <command.h>
 #include <console.h>
 #include <asm/global_data.h>
diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_console.c
index 8220addd579b..5113e50c53b8 100644
--- a/drivers/misc/cbmem_console.c
+++ b/drivers/misc/cbmem_console.c
@@ -3,9 +3,9 @@
  * Copyright (C) 2011 The ChromiumOS Authors.  All rights reserved.
  */
 
+#include <cb_sysinfo.h>
 #include <console.h>
 #include <linux/string.h>
-#include <asm/cb_sysinfo.h>
 
 void cbmemc_putc(struct stdio_dev *dev, char data)
 {
diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998cf..1835e333aec0 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -7,12 +7,12 @@
 
 #define LOG_CATGEGORY	UCLASS_SERIAL
 
+#include <cb_sysinfo.h>
 #include <dm.h>
 #include <log.h>
 #include <ns16550.h>
 #include <serial.h>
 #include <acpi/acpi_table.h>
-#include <asm/cb_sysinfo.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/video/coreboot.c b/drivers/video/coreboot.c
index 9aede2626423..ed589cc42bfd 100644
--- a/drivers/video/coreboot.c
+++ b/drivers/video/coreboot.c
@@ -3,11 +3,11 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <cb_sysinfo.h>
 #include <dm.h>
 #include <init.h>
 #include <vesa.h>
 #include <video.h>
-#include <asm/cb_sysinfo.h>
 
 static int save_vesa_mode(struct cb_framebuffer *fb,
 			  struct vesa_mode_info *vesa)
diff --git a/arch/x86/include/asm/cb_sysinfo.h b/include/cb_sysinfo.h
similarity index 94%
rename from arch/x86/include/asm/cb_sysinfo.h
rename to include/cb_sysinfo.h
index 5864b2700cec..62a483e10cef 100644
--- a/arch/x86/include/asm/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -8,7 +8,7 @@
 #ifndef _COREBOOT_SYSINFO_H
 #define _COREBOOT_SYSINFO_H
 
-#include <asm/coreboot_tables.h>
+#include <coreboot_tables.h>
 #include <linux/types.h>
 
 /* Maximum number of memory range definitions */
@@ -246,4 +246,24 @@ int get_coreboot_info(struct sysinfo_t *info);
  */
 const struct sysinfo_t *cb_get_sysinfo(void);
 
+/**
+ * coreboot_dram_init_banksize() - Initilize RAM banksize from coreboot sysinfo
+ * table
+ */
+int coreboot_dram_init_banksize(void);
+
+/**
+ * coreboot_dram_init() - Configure available RAM banks from coreboot sysinfo
+ * table
+ */
+int coreboot_dram_init(void);
+
+/**
+ * coreboot_board_get_usable_ram_top() - Get the top of RAM usable by U-Boot
+ * while running as a coreboot payload
+ *
+ * Return: Physical address as the top of RAM
+ */
+phys_addr_t coreboot_board_get_usable_ram_top(phys_size_t total_size);
+
 #endif
diff --git a/arch/x86/include/asm/coreboot_tables.h b/include/coreboot_tables.h
similarity index 100%
rename from arch/x86/include/asm/coreboot_tables.h
rename to include/coreboot_tables.h
diff --git a/lib/Makefile b/lib/Makefile
index 18ae0cd87bfc..ff3d8cacc0fc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -136,6 +136,8 @@ obj-$(CONFIG_LIB_UUID) += uuid.o
 obj-$(CONFIG_LIB_RAND) += rand.o
 obj-y += panic.o
 
+obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO)	+= coreboot/
+
 ifeq ($(CONFIG_XPL_BUILD),y)
 # SPL U-Boot may use full-printf, tiny-printf or none at all
 ifdef CONFIG_$(PHASE_)USE_TINY_PRINTF
diff --git a/lib/coreboot/Kconfig b/lib/coreboot/Kconfig
new file mode 100644
index 000000000000..cec0bcc0885f
--- /dev/null
+++ b/lib/coreboot/Kconfig
@@ -0,0 +1,55 @@
+menu "U-Boot as Coreboot payload"
+	depends on VENDOR_COREBOOT
+
+config SYS_COREBOOT
+	bool
+	default y
+	imply SYS_NS16550
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
+	imply VIDEO_COREBOOT
+	imply E1000
+	imply ETH_DESIGNWARE
+	imply PCH_GBE
+	imply RTL8169
+	imply CMD_CBFS
+	imply FS_CBFS
+	imply CBMEM_CONSOLE
+	imply X86_TSC_READ_BASE
+	imply USE_PREBOOT
+	select BINMAN if X86_RUN_64BIT
+	select SYSINFO
+	imply SYSINFO_EXTRA
+
+config COREBOOT_SYSINFO
+	bool "Support reading coreboot sysinfo"
+	default y if SYS_COREBOOT
+	help
+	  Select this option to read the coreboot sysinfo table on start-up,
+	  if present. This is written by coreboot before it exits and provides
+	  various pieces of information about the running system, including
+	  display, memory and build information. It is stored in
+	  struct sysinfo_t after parsing by get_coreboot_info().
+
+config SPL_COREBOOT_SYSINFO
+	bool "Support reading coreboot sysinfo"
+	depends on SPL
+	default y if COREBOOT_SYSINFO
+	help
+	  Select this option to read the coreboot sysinfo table in SPL,
+	  if present. This is written by coreboot before it exits and provides
+	  various pieces of information about the running system, including
+	  display, memory and build information. It is stored in
+	  struct sysinfo_t after parsing by get_coreboot_info().
+
+endmenu
diff --git a/lib/coreboot/Makefile b/lib/coreboot/Makefile
new file mode 100644
index 000000000000..0f5cb90a056e
--- /dev/null
+++ b/lib/coreboot/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2011 The Chromium OS Authors.
+#
+# (C) Copyright 2008
+# Graeme Russ, graeme.russ@gmail.com.
+#
+# (C) Copyright 2006
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+#
+# (C) Copyright 2002
+# Daniel Engström, Omicron Ceti AB, daniel@omicron.se.
+
+obj-y += cb_sysinfo.o
+ifndef CONFIG_XPL_BUILD
+obj-y += sdram.o
+endif
diff --git a/arch/x86/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
similarity index 95%
rename from arch/x86/lib/coreboot/cb_sysinfo.c
rename to lib/coreboot/cb_sysinfo.c
index ec997fa49cf2..f8f2002d46f0 100644
--- a/arch/x86/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2009 coresystems GmbH
  */
 
-#include <asm/cb_sysinfo.h>
+#include <cb_sysinfo.h>
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
@@ -23,13 +23,6 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 struct sysinfo_t lib_sysinfo __section(".data");
 
-/*
- * Some of this is x86 specific, and the rest of it is generic. Right now,
- * since we only support x86, we'll avoid trying to make lots of infrastructure
- * we don't need. If in the future, we want to use coreboot on some other
- * architecture, then take out the generic parsing code and move it elsewhere.
- */
-
 /* === Parsing code === */
 /* This is the generic parsing code */
 
@@ -453,9 +446,6 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
 	return 1;
 }
 
-/* == Architecture specific == */
-/* This is the x86 specific stuff */
-
 int get_coreboot_info(struct sysinfo_t *info)
 {
 	long addr;
@@ -470,8 +460,6 @@ int get_coreboot_info(struct sysinfo_t *info)
 	if (!ret)
 		return -ENOENT;
 	gd->arch.coreboot_table = addr;
-	gd_set_acpi_start(map_to_sysmem(info->rsdp));
-	gd_set_smbios_start(info->smbios_start);
 	gd->flags |= GD_FLG_SKIP_LL_INIT;
 
 	return 0;
diff --git a/arch/x86/cpu/coreboot/sdram.c b/lib/coreboot/sdram.c
similarity index 87%
copy from arch/x86/cpu/coreboot/sdram.c
copy to lib/coreboot/sdram.c
index 013225f129a9..ac9a95b1d378 100644
--- a/arch/x86/cpu/coreboot/sdram.c
+++ b/lib/coreboot/sdram.c
@@ -6,18 +6,11 @@
  */
 
 #include <init.h>
-#include <asm/e820.h>
-#include <asm/cb_sysinfo.h>
+#include <cb_sysinfo.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-unsigned int install_e820_map(unsigned int max_entries,
-			      struct e820_entry *entries)
-{
-	return cb_install_e820_map(max_entries, entries);
-}
-
 /*
  * This function looks for the highest region of memory lower than 4GB which
  * has enough space for U-Boot where U-Boot is aligned on a page boundary. It
@@ -26,7 +19,7 @@ unsigned int install_e820_map(unsigned int max_entries,
  * address, and how far U-Boot is moved by relocation are set in the global
  * data structure.
  */
-phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+phys_addr_t coreboot_board_get_usable_ram_top(phys_size_t total_size)
 {
 	uintptr_t dest_addr = 0;
 	int i;
@@ -60,7 +53,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return (ulong)dest_addr;
 }
 
-int dram_init(void)
+int coreboot_dram_init(void)
 {
 	int i;
 	phys_size_t ram_size = 0;
@@ -80,7 +73,7 @@ int dram_init(void)
 	return 0;
 }
 
-int dram_init_banksize(void)
+int coreboot_dram_init_banksize(void)
 {
 	int i, j;
 
-- 
Sent by a computer, using git, on the internet

