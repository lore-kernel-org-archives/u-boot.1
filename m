Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2DACDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 036FD86E8B;
	Fri, 13 Oct 2023 01:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="abTYYqaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9DAB869CA; Fri, 13 Oct 2023 01:05:00 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C67586E5D
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7c011e113so20515627b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151846; x=1697756646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9IV3LCsNvJZo//pm0Ndh0AQd0el7BAqKWXkoJyz/g0=;
 b=abTYYqaLts+U7BFAPQhPsZD5Oth9peF0ie36W/CvT3MmYqqaZh6YYsCMdY+TGAuEha
 sWj4EE4Hcu8YFQ4qomQsnnG+F/1/PtIBEzz5Cyr71llq20nwh/AGhQ4Nv+mKHH9z32Du
 oIAKFj7NMDtWn/skI94xh7WtfY21zoLrBsLYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151846; x=1697756646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9IV3LCsNvJZo//pm0Ndh0AQd0el7BAqKWXkoJyz/g0=;
 b=V+YHb5gP+3YCm1odj9YkjIlxWEygKNSa9fjFGtu9d1lm77C1R5xSKL1PLt+mu/ZY7Q
 rfh4S5VI+8SrF9nkCvrCBV4EYNKbu07crQ+/hf+ApJtrsmvVLL6hFGY/AxxBopstKVAe
 PuZxwT6Z4DZ0+wwYPueK8U+dwAaTDyvZJyqhYsH7qCgk5/FcYZO1wcEs7qQk70RoWmUC
 tDU4505wZzF6HiEjRI/KXQm48b7uRNbEVoNMJN+w5kWYVmhJjW+JBrUNaOqBQHtnnwPK
 RqjSegXSyoymx85tLpgV1VA7BG1i9RFMq4FIQE9DApAT26I1TtIu6BsM3IwZz6r8nY5O
 cWPw==
X-Gm-Message-State: AOJu0YxIGZAfoTM/t8yXDZGhypx0wI1KUxV6xBEgEgzYQAwY+XMZCs8W
 TNqtHujWN4YUgWgczvAURexIUtYNFrPLcyGy7ENKvg==
X-Google-Smtp-Source: AGHT+IFiam2u1c3jT7n8zJKaHX0oN3M6F0RmGR0hKmLMA6FiGNPM1dYp68bwo3HmDAgP4HiUPb8vqA==
X-Received: by 2002:a81:4306:0:b0:5a7:a81d:e410 with SMTP id
 q6-20020a814306000000b005a7a81de410mr11889286ywa.18.1697151846258; 
 Thu, 12 Oct 2023 16:04:06 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Subject: [PATCH 7/7] riscv: Remove common.h usage
Date: Thu, 12 Oct 2023 19:03:59 -0400
Message-Id: <20231012230359.2005249-7-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012230359.2005249-1-trini@konsulko.com>
References: <20231012230359.2005249-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We can remove common.h from most cases of the code here, and only a few
places need an additional header instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>
---
 arch/riscv/cpu/andesv5/cache.c                      | 1 -
 arch/riscv/cpu/andesv5/cpu.c                        | 1 -
 arch/riscv/cpu/andesv5/spl.c                        | 1 -
 arch/riscv/cpu/cpu.c                                | 1 -
 arch/riscv/cpu/fu540/dram.c                         | 1 -
 arch/riscv/cpu/fu740/dram.c                         | 1 -
 arch/riscv/cpu/generic/cpu.c                        | 1 -
 arch/riscv/cpu/generic/dram.c                       | 1 -
 arch/riscv/cpu/jh7110/dram.c                        | 1 -
 arch/riscv/cpu/jh7110/spl.c                         | 1 -
 arch/riscv/cpu/mtrap.S                              | 1 -
 arch/riscv/cpu/start.S                              | 1 -
 arch/riscv/include/asm/arch-andes/csr.h             | 1 +
 arch/riscv/include/asm/arch-jh7110/eeprom.h         | 2 ++
 arch/riscv/include/asm/dma-mapping.h                | 1 -
 arch/riscv/include/asm/smp.h                        | 2 ++
 arch/riscv/lib/aclint_ipi.c                         | 1 -
 arch/riscv/lib/andes_plicsw.c                       | 1 -
 arch/riscv/lib/asm-offsets.c                        | 1 -
 arch/riscv/lib/boot.c                               | 3 +--
 arch/riscv/lib/bootm.c                              | 1 -
 arch/riscv/lib/cache.c                              | 1 -
 arch/riscv/lib/fdt_fixup.c                          | 1 -
 arch/riscv/lib/image.c                              | 1 -
 arch/riscv/lib/interrupts.c                         | 1 -
 arch/riscv/lib/reset.c                              | 1 -
 arch/riscv/lib/sbi.c                                | 2 +-
 arch/riscv/lib/sbi_ipi.c                            | 1 -
 arch/riscv/lib/sifive_cache.c                       | 2 +-
 arch/riscv/lib/smp.c                                | 1 -
 arch/riscv/lib/spl.c                                | 1 -
 board/AndesTech/ae350/ae350.c                       | 2 +-
 board/sifive/unmatched/hifive-platform-i2c-eeprom.c | 1 -
 board/sifive/unmatched/unmatched.c                  | 1 -
 34 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/cpu/andesv5/cache.c b/arch/riscv/cpu/andesv5/cache.c
index 40d77f671c87..269bb27f75a6 100644
--- a/arch/riscv/cpu/andesv5/cache.c
+++ b/arch/riscv/cpu/andesv5/cache.c
@@ -6,7 +6,6 @@
 
 #include <asm/csr.h>
 #include <asm/asm.h>
-#include <common.h>
 #include <cache.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/arch/riscv/cpu/andesv5/cpu.c b/arch/riscv/cpu/andesv5/cpu.c
index 06e379bcb1fe..63bc24cdfc7c 100644
--- a/arch/riscv/cpu/andesv5/cpu.c
+++ b/arch/riscv/cpu/andesv5/cpu.c
@@ -5,7 +5,6 @@
  */
 
 /* CPU specific code */
-#include <common.h>
 #include <cpu_func.h>
 #include <irq_func.h>
 #include <asm/cache.h>
diff --git a/arch/riscv/cpu/andesv5/spl.c b/arch/riscv/cpu/andesv5/spl.c
index 413849043b18..a13dc4095a45 100644
--- a/arch/riscv/cpu/andesv5/spl.c
+++ b/arch/riscv/cpu/andesv5/spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Andes Technology Corporation
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index c1a9638c1ab7..ebd39cb41a60 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <dm/lists.h>
diff --git a/arch/riscv/cpu/fu540/dram.c b/arch/riscv/cpu/fu540/dram.c
index 94d8018407e6..7b5a3471ac88 100644
--- a/arch/riscv/cpu/fu540/dram.c
+++ b/arch/riscv/cpu/fu540/dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/arch/riscv/cpu/fu740/dram.c b/arch/riscv/cpu/fu740/dram.c
index 8657fcd165c3..61f551763f1c 100644
--- a/arch/riscv/cpu/fu740/dram.c
+++ b/arch/riscv/cpu/fu740/dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <linux/sizes.h>
diff --git a/arch/riscv/cpu/generic/cpu.c b/arch/riscv/cpu/generic/cpu.c
index d78e1a3453af..f13c18942f3d 100644
--- a/arch/riscv/cpu/generic/cpu.c
+++ b/arch/riscv/cpu/generic/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <irq_func.h>
 #include <asm/cache.h>
 
diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
index 94d8018407e6..7b5a3471ac88 100644
--- a/arch/riscv/cpu/generic/dram.c
+++ b/arch/riscv/cpu/generic/dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/arch/riscv/cpu/jh7110/dram.c b/arch/riscv/cpu/jh7110/dram.c
index 1a9fa46d14b9..664b9b93eb62 100644
--- a/arch/riscv/cpu/jh7110/dram.c
+++ b/arch/riscv/cpu/jh7110/dram.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <linux/sizes.h>
diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
index 4047b10efe83..6bdf8b9c72f0 100644
--- a/arch/riscv/cpu/jh7110/spl.c
+++ b/arch/riscv/cpu/jh7110/spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022 StarFive Technology Co., Ltd.
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
-#include <common.h>
 #include <asm/arch/eeprom.h>
 #include <asm/csr.h>
 #include <asm/sections.h>
diff --git a/arch/riscv/cpu/mtrap.S b/arch/riscv/cpu/mtrap.S
index e40c7bd3f4ff..6eb3ed1d5a88 100644
--- a/arch/riscv/cpu/mtrap.S
+++ b/arch/riscv/cpu/mtrap.S
@@ -11,7 +11,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/encoding.h>
 
 #ifdef CONFIG_32BIT
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 30cf6743701b..6cecadfac56d 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -11,7 +11,6 @@
 
 #include <asm-offsets.h>
 #include <config.h>
-#include <common.h>
 #include <elf.h>
 #include <system-constants.h>
 #include <asm/encoding.h>
diff --git a/arch/riscv/include/asm/arch-andes/csr.h b/arch/riscv/include/asm/arch-andes/csr.h
index c7ed920cde57..393d51c6dde1 100644
--- a/arch/riscv/include/asm/arch-andes/csr.h
+++ b/arch/riscv/include/asm/arch-andes/csr.h
@@ -7,6 +7,7 @@
 #define _ASM_ANDES_CSR_H
 
 #include <asm/asm.h>
+#include <linux/bitops.h>
 #include <linux/const.h>
 
 #define CSR_MCACHE_CTL 0x7ca
diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index f354d5c60cdc..d2776d5b6cb3 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_RISCV_EEPROM_H
 #define _ASM_RISCV_EEPROM_H
 
+#include <linux/types.h>
+
 u8 get_pcb_revision_from_eeprom(void);
 u32 get_ddr_size_from_eeprom(void);
 
diff --git a/arch/riscv/include/asm/dma-mapping.h b/arch/riscv/include/asm/dma-mapping.h
index 6ecadab41cd9..d0cc5d7c7757 100644
--- a/arch/riscv/include/asm/dma-mapping.h
+++ b/arch/riscv/include/asm/dma-mapping.h
@@ -9,7 +9,6 @@
 #ifndef __ASM_RISCV_DMA_MAPPING_H
 #define __ASM_RISCV_DMA_MAPPING_H
 
-#include <common.h>
 #include <linux/types.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 4284a332e98f..ee749dd11954 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_RISCV_SMP_H
 #define _ASM_RISCV_SMP_H
 
+#include <linux/types.h>
+
 /**
  * struct ipi_data - Inter-processor interrupt (IPI) data structure
  *
diff --git a/arch/riscv/lib/aclint_ipi.c b/arch/riscv/lib/aclint_ipi.c
index 90b8e128cb16..dcd7e5e6b344 100644
--- a/arch/riscv/lib/aclint_ipi.c
+++ b/arch/riscv/lib/aclint_ipi.c
@@ -8,7 +8,6 @@
  * associated with software and timer interrupts.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
diff --git a/arch/riscv/lib/andes_plicsw.c b/arch/riscv/lib/andes_plicsw.c
index 75184080890f..c188bfffc7c2 100644
--- a/arch/riscv/lib/andes_plicsw.c
+++ b/arch/riscv/lib/andes_plicsw.c
@@ -8,7 +8,6 @@
  * similar to RISC-V PLIC.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
diff --git a/arch/riscv/lib/asm-offsets.c b/arch/riscv/lib/asm-offsets.c
index 452dfcea97f7..875bb9a6d983 100644
--- a/arch/riscv/lib/asm-offsets.c
+++ b/arch/riscv/lib/asm-offsets.c
@@ -8,7 +8,6 @@
  * assembly language modules.
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <linux/kbuild.h>
 
diff --git a/arch/riscv/lib/boot.c b/arch/riscv/lib/boot.c
index 778d011f7cea..03014c56dce2 100644
--- a/arch/riscv/lib/boot.c
+++ b/arch/riscv/lib/boot.c
@@ -4,8 +4,7 @@
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
 
-#include <common.h>
-#include <command.h>
+#include <asm/u-boot.h>
 
 unsigned long do_go_exec(ulong (*entry)(int, char * const []),
 			 int argc, char *const argv[])
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index cc30efc90498..f9e1e18ae026 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -6,7 +6,6 @@
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <dm.h>
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index 686e699efbcd..c46b49eb0ac6 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -4,7 +4,6 @@
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 
 void invalidate_icache_all(void)
diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index 36c16e9be2ae..c658e72bd39e 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
index a65a5b8d17c1..a82f48e9a505 100644
--- a/arch/riscv/lib/image.c
+++ b/arch/riscv/lib/image.c
@@ -6,7 +6,6 @@
  * Based on arm/lib/image.c
  */
 
-#include <common.h>
 #include <image.h>
 #include <mapmem.h>
 #include <errno.h>
diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index e966afa7e3e3..02dbcfd42380 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/compat.h>
-#include <common.h>
 #include <efi_loader.h>
 #include <hang.h>
 #include <irq_func.h>
diff --git a/arch/riscv/lib/reset.c b/arch/riscv/lib/reset.c
index 8779c619cc5a..712e1bdb8e1d 100644
--- a/arch/riscv/lib/reset.c
+++ b/arch/riscv/lib/reset.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <hang.h>
 
diff --git a/arch/riscv/lib/sbi.c b/arch/riscv/lib/sbi.c
index 55a3bc3b5c9d..35a7d3b12f51 100644
--- a/arch/riscv/lib/sbi.c
+++ b/arch/riscv/lib/sbi.c
@@ -7,7 +7,7 @@
  * Taken from Linux arch/riscv/kernel/sbi.c
  */
 
-#include <common.h>
+#include <errno.h>
 #include <asm/encoding.h>
 #include <asm/sbi.h>
 
diff --git a/arch/riscv/lib/sbi_ipi.c b/arch/riscv/lib/sbi_ipi.c
index d02e2b4c4882..511d3816da84 100644
--- a/arch/riscv/lib/sbi_ipi.c
+++ b/arch/riscv/lib/sbi_ipi.c
@@ -4,7 +4,6 @@
  * Lukas Auer <lukas.auer@aisec.fraunhofer.de>
  */
 
-#include <common.h>
 #include <asm/encoding.h>
 #include <asm/sbi.h>
 
diff --git a/arch/riscv/lib/sifive_cache.c b/arch/riscv/lib/sifive_cache.c
index 28154878fcc8..39b0248c3234 100644
--- a/arch/riscv/lib/sifive_cache.c
+++ b/arch/riscv/lib/sifive_cache.c
@@ -3,9 +3,9 @@
  * Copyright (C) 2021 SiFive, Inc
  */
 
-#include <common.h>
 #include <cache.h>
 #include <cpu_func.h>
+#include <log.h>
 #include <dm.h>
 
 void enable_caches(void)
diff --git a/arch/riscv/lib/smp.c b/arch/riscv/lib/smp.c
index f3cd8b9044a8..a692f065edd7 100644
--- a/arch/riscv/lib/smp.c
+++ b/arch/riscv/lib/smp.c
@@ -4,7 +4,6 @@
  * Lukas Auer <lukas.auer@aisec.fraunhofer.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <asm/barrier.h>
diff --git a/arch/riscv/lib/spl.c b/arch/riscv/lib/spl.c
index 9b242ed82129..9a7a4f6ac8d3 100644
--- a/arch/riscv/lib/spl.c
+++ b/arch/riscv/lib/spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Fraunhofer AISEC,
  * Lukas Auer <lukas.auer@aisec.fraunhofer.de>
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
index 1c2288b6ce9f..36375d9def99 100644
--- a/board/AndesTech/ae350/ae350.c
+++ b/board/AndesTech/ae350/ae350.c
@@ -4,7 +4,7 @@
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <flash.h>
 #include <image.h>
diff --git a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
index 2b985b9b228e..938cedea6481 100644
--- a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
+++ b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
@@ -9,7 +9,6 @@
  * Timur Tabi (timur@freescale.com)
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <i2c.h>
diff --git a/board/sifive/unmatched/unmatched.c b/board/sifive/unmatched/unmatched.c
index 6675548c2bf8..c8696270ba27 100644
--- a/board/sifive/unmatched/unmatched.c
+++ b/board/sifive/unmatched/unmatched.c
@@ -6,7 +6,6 @@
  *   Pragnesh Patel <pragnesh.patel@sifive.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <asm/sections.h>
-- 
2.34.1

