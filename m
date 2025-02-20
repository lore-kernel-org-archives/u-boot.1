Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67029C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D887681026;
	Thu, 20 Feb 2025 22:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZX0RDe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9ACE80F5F; Thu, 20 Feb 2025 21:59:12 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2E08006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220f048c038so25573975ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085148; x=1740689948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eULIhs1pBgBinyyrgQ17Oj3tStvxhly9euzuZ49B6vk=;
 b=oZX0RDe4Rd2h2sMEc+ah+gqxajbe8QcnsTJtfl2VoRBN3V1/3BzKWJM/vkcMbkobne
 PuiSuwEqepNPBppDkXIr2EDaMYHDyl7GRn61LUGntihVuhFgDQu+giuBbiRSQjO1aDkF
 A5EzShiQuHPMB+d5vKtBcYfExaKnsXTedgwMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085148; x=1740689948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eULIhs1pBgBinyyrgQ17Oj3tStvxhly9euzuZ49B6vk=;
 b=mZh7MX1jOCHwHO9PXly4QMOxoTP3VsshtxaQlAzHn84L38+8ABUAgQAZpQDcmAKbmI
 TvLWYFpzvXG5LsykL7WH8XbVQSZROrcp1n0Xr5SFVRNGb/zqbg5js0EOa5isUwSWK/WZ
 6xzgoDBTEHfZ++m/5XwG8kDOlEuDHkO2wD38fUMe5rxwo+bExDACM7LctBqkdS9Ifh33
 jGtm9Nw6mlFd10REx/DJjnvWojSMxbHbHMapnTBRyQGg4GcG7K3Pq+K2uCOpcQr9upoF
 FF4eZfCewEssE2q8KNYp1osm1SW861odpsV2NXHUbk/5Fr6IphrNikqGB92X22uGuUrk
 TiDQ==
X-Gm-Message-State: AOJu0Yw0B4CEGebbfQ+YDcUwN5G33zOHJhJHBCaD8e6IabceJXzhYSnP
 wVLbkJppeGH7yz7Vyi0hcQRKdbDPnmrncDaG8Dp2ObZ6+sUFAr1Pt91neZPAVSQRCK40nBMQgoc
 =
X-Gm-Gg: ASbGncvn2JscfDLkO+/DqCLuBJqXK+F7M0BcEx3Cwj7mTWzsjWeRmHxukGSCmBVooSt
 Jzt89aFxdUdP/RvMATmhzaijsHVAqPs5BhJlI3d6xI1PBNqCoMwV+2YjVriU1OXStzXxVVQMc4K
 5MdphT4ict/zZ++Rcg94W+3DVwe0Hs2ZtzWdCY+EXNDWrn/KVNFRdL7GwoWkaKDKOjKa7J8xHqS
 8K8QCEhwF4gqKdYKWJ/opXZ/r1drx8t/i342sSOr32G30aMp5Mv3q4FhtV8fymqHhMcjVlwkHce
 Ir1rSg5upwkzR1AAiDfoibkU6MSAoCgXZW4cGvxOoupEihmlNHsSXJU=
X-Google-Smtp-Source: AGHT+IEJk7Rb2vO/qGV/zfIyTEMQyh5zWdp/qzzlxLorKTfZ1w3LggFLQdzFzMGtkynYYFSjOUKclQ==
X-Received: by 2002:a05:6a20:3d84:b0:1ee:b033:6dde with SMTP id
 adf61e73a8af0-1eef3c720d5mr1207740637.3.1740085148138; 
 Thu, 20 Feb 2025 12:59:08 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-adb5813a687sm11239185a12.20.2025.02.20.12.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:07 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 04/12] coreboot: Move coreboot logic out of x86 to a generic
 place
Date: Thu, 20 Feb 2025 12:58:46 -0800
Message-ID: <20250220205900.3127680-5-swboyd@chromium.org>
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
 arch/x86/Kconfig                              | 21 -----
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
 boot/expo_build_cb.c                          |  2 +-
 cmd/version.c                                 |  2 +-
 cmd/x86/cbcmos.c                              |  2 +-
 cmd/x86/cbsysinfo.c                           |  2 +-
 drivers/misc/cbmem_console.c                  |  2 +-
 drivers/serial/serial_coreboot.c              |  2 +-
 drivers/video/coreboot.c                      |  2 +-
 .../x86/include/asm => include}/cb_sysinfo.h  |  6 +-
 .../include/asm => include}/coreboot_tables.h |  0
 lib/Kconfig                                   | 21 +++++
 lib/Makefile                                  |  2 +
 lib/coreboot/Makefile                         |  4 +
 {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   |  7 +-
 {arch/x86/cpu => lib}/coreboot/sdram.c        | 15 +---
 28 files changed, 61 insertions(+), 132 deletions(-)
 rename {arch/x86/include/asm => include}/cb_sysinfo.h (98%)
 rename {arch/x86/include/asm => include}/coreboot_tables.h (100%)
 create mode 100644 lib/coreboot/Makefile
 rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (98%)
 copy {arch/x86/cpu => lib}/coreboot/sdram.c (87%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 006a59d6fa63..b18354466f8e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1041,27 +1041,6 @@ config INTEL_GMA_SWSMISCI
 
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
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index fa7430b436f9..a092e8a27027 100644
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
index 013225f129a9..9c670ea66440 100644
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
+	return board_get_usable_ram_top_from_coreboot(total_size);
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
+	return dram_init_from_coreboot()
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
+	return dram_init_banksize_from_coreboot();
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
index a8b21406ac06..9ac2a6bf4a09 100644
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
index a51a24498a7f..fd35cabe552f 100644
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
index 45a70e927634..194e8379be28 100644
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
 
 DECLARE_GLOBAL_DATA_PTR;
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
index 53db1a0b6bd1..6c786314bfe5 100644
--- a/cmd/version.c
+++ b/cmd/version.c
@@ -9,7 +9,7 @@
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
similarity index 98%
rename from arch/x86/include/asm/cb_sysinfo.h
rename to include/cb_sysinfo.h
index 5864b2700cec..69b02db4f281 100644
--- a/arch/x86/include/asm/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -8,7 +8,7 @@
 #ifndef _COREBOOT_SYSINFO_H
 #define _COREBOOT_SYSINFO_H
 
-#include <asm/coreboot_tables.h>
+#include <coreboot_tables.h>
 #include <linux/types.h>
 
 /* Maximum number of memory range definitions */
@@ -246,4 +246,8 @@ int get_coreboot_info(struct sysinfo_t *info);
  */
 const struct sysinfo_t *cb_get_sysinfo(void);
 
+int dram_init_banksize_from_coreboot(void);
+int dram_init_from_coreboot(void);
+phys_addr_t board_get_usable_ram_top_from_coreboot(phys_size_t total_size);
+
 #endif
diff --git a/arch/x86/include/asm/coreboot_tables.h b/include/coreboot_tables.h
similarity index 100%
rename from arch/x86/include/asm/coreboot_tables.h
rename to include/coreboot_tables.h
diff --git a/lib/Kconfig b/lib/Kconfig
index baeb615626d5..6dc5fcb685da 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1234,4 +1234,25 @@ config PHANDLE_CHECK_SEQ
 
 endmenu
 
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
 source "lib/fwu_updates/Kconfig"
diff --git a/lib/Makefile b/lib/Makefile
index 3595086af7cc..1c3c43e85061 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -137,6 +137,8 @@ obj-$(CONFIG_LIB_UUID) += uuid.o
 obj-$(CONFIG_LIB_RAND) += rand.o
 obj-y += panic.o
 
+obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO)	+= coreboot/
+
 ifeq ($(CONFIG_XPL_BUILD),y)
 # SPL U-Boot may use full-printf, tiny-printf or none at all
 ifdef CONFIG_$(PHASE_)USE_TINY_PRINTF
diff --git a/lib/coreboot/Makefile b/lib/coreboot/Makefile
new file mode 100644
index 000000000000..78d6b419246e
--- /dev/null
+++ b/lib/coreboot/Makefile
@@ -0,0 +1,4 @@
+obj-y += cb_sysinfo.o
+ifndef CONFIG_XPL_BUILD
+obj-y += sdram.o
+endif
diff --git a/arch/x86/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
similarity index 98%
rename from arch/x86/lib/coreboot/cb_sysinfo.c
rename to lib/coreboot/cb_sysinfo.c
index ec997fa49cf2..6cbd08ad3982 100644
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
@@ -453,9 +453,6 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
 	return 1;
 }
 
-/* == Architecture specific == */
-/* This is the x86 specific stuff */
-
 int get_coreboot_info(struct sysinfo_t *info)
 {
 	long addr;
@@ -470,8 +467,6 @@ int get_coreboot_info(struct sysinfo_t *info)
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
index 013225f129a9..a4da7ca6e18f 100644
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
+phys_addr_t board_get_usable_ram_top_from_coreboot(phys_size_t total_size)
 {
 	uintptr_t dest_addr = 0;
 	int i;
@@ -60,7 +53,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return (ulong)dest_addr;
 }
 
-int dram_init(void)
+int dram_init_from_coreboot(void)
 {
 	int i;
 	phys_size_t ram_size = 0;
@@ -80,7 +73,7 @@ int dram_init(void)
 	return 0;
 }
 
-int dram_init_banksize(void)
+int dram_init_banksize_from_coreboot(void)
 {
 	int i, j;
 
-- 
Sent by a computer, using git, on the internet

