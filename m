Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF64E67801
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 17:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E1283B99;
	Mon, 22 Dec 2025 18:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJ5jpV04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 804F683D1A; Mon, 22 Dec 2025 18:05:34 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63E983B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29f2676bb21so54479595ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766423130; x=1767027930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QeY1iRwuaxxp0PYyR3xxGpTxxue9vcM7d1H98RWrJqo=;
 b=RJ5jpV04AkOV6IEVkwKydkVW0lSb8ogTjwzBsgI4s5fb3I77OQELmXDT1BZhU6ry8L
 KBj1QDDbbvn/qq/2ct82KRQFdvIGRz7rePV0qnN1EXK0PB+b5Om2KwBz8w35CQT8f7w8
 K70lq7O2qgPY8Xc1eYcbdH5lH8RBzPQ3Gk3JG0iLXBZtn3gXZfDzmJT/k9VOd3VdRVNp
 L3T3ZMgPTontRONdvUKFseIMk8JDmgPFBX6lAZc5Zek27LPATWLXwQQJco91QUn1J9GW
 C57Uzi01RsGjlyf2OShAWZRwbWAhIdFXvy71b3dmDKZCc0sARjW3RCyIUGyhDG1OpMwl
 4ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766423130; x=1767027930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeY1iRwuaxxp0PYyR3xxGpTxxue9vcM7d1H98RWrJqo=;
 b=HZN6xTjSTtbC82n7LC1qMWKZkvVt0POmDa3xbj8iJuX6+dPDttGt//yO38UdBqQtJl
 aRp+owbbP99QjDNB3rmYyGfiJj9rxiDcvUWq2FXfTIqKNRw9EoCl1619qJyPozSeDOb4
 +Os1jFNAtFYy3mFKCMD+mqBkDqy1+/jirhpfEoRKs42ELcIS2MIHbL/wimd9FOz183WK
 qf9FPMfGXn/f+je4/iRFIjJpIO62cE+malmYNeMMKdMj25tD+5ohVz8uWh4usHzmjBbn
 Cbe11ZT7FaL4yM2vbkvGxR+XInAxjeN09NqVSzTjOvYLI/RO+dzJqflEweYsuN2kJK3d
 llbQ==
X-Gm-Message-State: AOJu0YxQUsgeX8Rx52E37UCIJLasjTZNOIF/xbjroOsthLPNhNcHQHRc
 iAYQnSXJdrIXFGPE6ubi1xj2+ozj6jknGR8r43stgU2YXZNPteqItk5RxG/GHzaIDEE=
X-Gm-Gg: AY/fxX6Wcc9P8OV9FRS+vORhqNhjBuetcZERvdlU4Pi16P+XIMpMB3Itn+kNvQBg7Es
 6XY6D7K2Kg1vcQIPBauVFLhL9/6Gjaa4q7l/pQOgmeQ/AcukM1v4BK7RULmcY9srkHN+yzXNpoC
 eD/b/oFMKLe7suf81ywL4YiY3xyPCvl30gwpoZYVJ+WkMbLmpRgLkdXJi04eJGxQUnUqP1EeGMB
 pAm2XJqgVdddJgJjlddL0MjzUkSvjSTwAEk0xPkDAKGFi9B1OcHXZpg6UndEHyImLVQQiuL2MCB
 YmJEnddYPVR40ru5heN5RwUOiqCOd+iC771hUjZ/fNNCW/JWxVs+fdJL1lXDptgwWY2GrQcpLNp
 uTs9vbwu9I19RF2NaFJ/Sm+xJDMLJWEbbHj5f26/x8uXSdCqlfXaSkzFkxcDnA3SerhNuXscrEV
 Yr5ULYatXFeR95aFUcFMoMxSoMfh8zzZJk
X-Google-Smtp-Source: AGHT+IH0wFFrlYTjWaIS7ol8KEtPvAyERBKdeo+QCfpFdZoxf5fBjBT8DSALTrhC8bIu+rZh/Mwm8g==
X-Received: by 2002:a17:903:984:b0:2a0:c1f6:6bc2 with SMTP id
 d9443c01a7336-2a2f2c4db0dmr122019475ad.59.1766423129968; 
 Mon, 22 Dec 2025 09:05:29 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4cb9csm101595855ad.47.2025.12.22.09.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 09:05:29 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v1] Replace TARGET namespace and cleanup properly
Date: Tue, 23 Dec 2025 01:05:21 +0800
Message-Id: <20251222170521.147815-1-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
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

TARGET namespace is for machines / boards / what-have-you that
 building U-Boot for. Simply replace from TARGET to ARCH
make things more clear and proper for GEN5 SoCFPGA
where GEN5 is referring to both Cyclone5 and Arria5.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 Kconfig                                       |  2 +-
 arch/arm/Kconfig                              |  8 +++----
 arch/arm/dts/Makefile                         |  1 +
 arch/arm/mach-socfpga/Kconfig                 | 22 +++++++++----------
 arch/arm/mach-socfpga/Makefile                |  6 ++---
 arch/arm/mach-socfpga/clock_manager.c         |  6 ++---
 .../mach-socfpga/include/mach/clock_manager.h |  2 +-
 .../mach-socfpga/include/mach/fpga_manager.h  |  2 +-
 arch/arm/mach-socfpga/include/mach/misc.h     |  2 +-
 .../mach-socfpga/include/mach/reset_manager.h |  2 +-
 arch/arm/mach-socfpga/include/mach/sdram.h    |  2 +-
 .../include/mach/system_manager.h             |  2 +-
 common/spl/Kconfig                            |  4 ++--
 drivers/ddr/altera/Kconfig                    |  6 ++---
 drivers/ddr/altera/Makefile                   |  2 +-
 drivers/fpga/Makefile                         |  2 +-
 drivers/sysreset/Kconfig                      |  2 +-
 include/configs/socfpga_common.h              |  2 +-
 scripts/Makefile.xpl                          |  2 +-
 19 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/Kconfig b/Kconfig
index 1d600342685..a58ec8f75d7 100644
--- a/Kconfig
+++ b/Kconfig
@@ -525,7 +525,7 @@ config BUILD_TARGET
 	default "u-boot-with-spl.imx" if ARCH_MX6 && SPL
 	default "u-boot-with-spl.kwb" if ARMADA_32BIT && SPL
 	default "u-boot-with-spl.sfp" if TARGET_SOCFPGA_ARRIA10
-	default "u-boot-with-spl.sfp" if TARGET_SOCFPGA_GEN5
+	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_GEN5
 	default "u-boot.itb" if !BINMAN && SPL_LOAD_FIT && (ARCH_ROCKCHIP || \
 				RISCV || ARCH_ZYNQMP)
 	default "u-boot.kwb" if (ARCH_KIRKWOOD || ARMADA_32BIT) && !SPL
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3db5474a05b..9e0d2f40744 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1152,11 +1152,11 @@ config ARCH_SOCFPGA
 	select ARCH_EARLY_INIT_R
 	select ARCH_MISC_INIT if !TARGET_SOCFPGA_ARRIA10
 	select ARM64 if TARGET_SOCFPGA_SOC64
-	select CPU_V7A if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
+	select CPU_V7A if ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select DM
 	select DM_SERIAL
 	select GPIO_EXTRA_HEADER
-	select ENABLE_ARM_SOC_BOOT0_HOOK if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
+	select ENABLE_ARM_SOC_BOOT0_HOOK if ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select LMB_ARCH_MEM_MAP if TARGET_SOCFPGA_SOC64
 	select OF_CONTROL
 	select SPL_DM_RESET if DM_RESET
@@ -1172,9 +1172,9 @@ config ARCH_SOCFPGA
 	select SPL_WATCHDOG
 	select SUPPORT_SPL
 	select SYS_NS16550
-	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
+	select SYS_THUMB_BUILD if ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET
-	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
+	select SYSRESET_SOCFPGA if ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
            TARGET_SOCFPGA_SOC64
 	select SYSRESET_PSCI if TARGET_SOCFPGA_AGILEX5
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fcad6fb2fc7..103145a2d7b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -468,6 +468,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_socrates.dtb			\
 	socfpga_cyclone5_sr1500.dtb			\
 	socfpga_cyclone5_vining_fpga.dtb		\
+	socfpga_cyclone5_ac501soc.dtb			\
 	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..a8390e54a22 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,7 +1,7 @@
 if ARCH_SOCFPGA
 
 config ERR_PTR_OFFSET
-	default 0xfffec000 if TARGET_SOCFPGA_GEN5 # Boot ROM range
+	default 0xfffec000 if ARCH_SOCFPGA_GEN5 # Boot ROM range
 
 config NR_DRAM_BANKS
 	default 1
@@ -23,30 +23,30 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
 	depends on SOCFPGA_SECURE_VAB_AUTH
 
 config SPL_SIZE_LIMIT
-	default 0x10000 if TARGET_SOCFPGA_GEN5
+	default 0x10000 if ARCH_SOCFPGA_GEN5
 
 config SPL_SIZE_LIMIT_PROVIDE_STACK
-	default 0x200 if TARGET_SOCFPGA_GEN5
+	default 0x200 if ARCH_SOCFPGA_GEN5
 
 config SPL_STACK_R_ADDR
-	default 0x00800000 if TARGET_SOCFPGA_GEN5
+	default 0x00800000 if ARCH_SOCFPGA_GEN5
 
 config SPL_SYS_MALLOC_F
-	default y if TARGET_SOCFPGA_GEN5
+	default y if ARCH_SOCFPGA_GEN5
 
 config SPL_SYS_MALLOC_F_LEN
-	default 0x800 if TARGET_SOCFPGA_GEN5
+	default 0x800 if ARCH_SOCFPGA_GEN5
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE
 	default 0xa2
 
 config SYS_MALLOC_F_LEN
 	default 0x2000 if TARGET_SOCFPGA_ARRIA10
-	default 0x2000 if TARGET_SOCFPGA_GEN5
+	default 0x2000 if ARCH_SOCFPGA_GEN5
 
 config TEXT_BASE
 	default 0x01000040 if TARGET_SOCFPGA_ARRIA10
-	default 0x01000040 if TARGET_SOCFPGA_GEN5
+	default 0x01000040 if ARCH_SOCFPGA_GEN5
 
 config TARGET_SOCFPGA_AGILEX
 	bool
@@ -82,7 +82,7 @@ config TARGET_SOCFPGA_AGILEX5
 
 config TARGET_SOCFPGA_ARRIA5
 	bool
-	select TARGET_SOCFPGA_GEN5
+	select ARCH_SOCFPGA_GEN5
 
 config TARGET_SOCFPGA_ARRIA10
 	bool
@@ -113,9 +113,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 
 config TARGET_SOCFPGA_CYCLONE5
 	bool
-	select TARGET_SOCFPGA_GEN5
+	select ARCH_SOCFPGA_GEN5
 
-config TARGET_SOCFPGA_GEN5
+config ARCH_SOCFPGA_GEN5
 	bool
 	select SPL_ALTERA_SDRAM
 	imply FPGA_SOCFPGA
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 4e85bfb00d4..883dee95851 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -10,7 +10,7 @@ obj-y	+= board.o
 obj-y	+= clock_manager.o
 obj-y	+= misc.o
 
-ifdef CONFIG_TARGET_SOCFPGA_GEN5
+ifdef CONFIG_ARCH_SOCFPGA_GEN5
 obj-y	+= clock_manager_gen5.o
 obj-y	+= misc_gen5.o
 obj-y	+= reset_manager_gen5.o
@@ -105,7 +105,7 @@ obj-y	+= wrap_pll_config_soc64.o
 endif
 
 ifdef CONFIG_XPL_BUILD
-ifdef CONFIG_TARGET_SOCFPGA_GEN5
+ifdef CONFIG_ARCH_SOCFPGA_GEN5
 obj-y	+= spl_gen5.o
 obj-y	+= freeze_controller.o
 obj-y	+= wrap_iocsr_config.o
@@ -140,7 +140,7 @@ obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
 obj-$(CONFIG_SPL_ATF) += smc_api.o
 endif
 
-ifdef CONFIG_TARGET_SOCFPGA_GEN5
+ifdef CONFIG_ARCH_SOCFPGA_GEN5
 # QTS-generated config file wrappers
 CFLAGS_wrap_iocsr_config.o	+= -I$(srctree)/board/$(BOARDDIR)
 CFLAGS_wrap_pinmux_config.o	+= -I$(srctree)/board/$(BOARDDIR)
diff --git a/arch/arm/mach-socfpga/clock_manager.c b/arch/arm/mach-socfpga/clock_manager.c
index 134eaf08e0a..695a8f5ef19 100644
--- a/arch/arm/mach-socfpga/clock_manager.c
+++ b/arch/arm/mach-socfpga/clock_manager.c
@@ -18,7 +18,7 @@ void cm_wait_for_lock(u32 mask)
 	u32 inter_val;
 	u32 retry = 0;
 	do {
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 		inter_val = readl(socfpga_get_clkmgr_addr() +
 				  CLKMGR_INTER) & mask;
 #else
@@ -45,7 +45,7 @@ int cm_wait_for_fsm(void)
 
 int set_cpu_clk_info(void)
 {
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 	/* Calculate the clock frequencies required for drivers */
 	cm_get_l4_sp_clk_hz();
 	cm_get_mmc_controller_clk_hz();
@@ -54,7 +54,7 @@ int set_cpu_clk_info(void)
 	gd->bd->bi_arm_freq = cm_get_mpu_clk_hz() / 1000000;
 	gd->bd->bi_dsp_freq = 0;
 
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 	gd->bd->bi_ddr_freq = cm_get_sdram_clk_hz() / 1000000;
 #else
 	gd->bd->bi_ddr_freq = 0;
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h b/arch/arm/mach-socfpga/include/mach/clock_manager.h
index f0431c081d8..cac2b100b27 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
@@ -22,7 +22,7 @@ int cm_set_qspi_controller_clk_hz(u32 clk_hz);
 #endif
 #endif
 
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 #include <asm/arch/clock_manager_gen5.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
 #include <asm/arch/clock_manager_arria10.h>
diff --git a/arch/arm/mach-socfpga/include/mach/fpga_manager.h b/arch/arm/mach-socfpga/include/mach/fpga_manager.h
index 481b66bbd86..b65308b4b60 100644
--- a/arch/arm/mach-socfpga/include/mach/fpga_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/fpga_manager.h
@@ -9,7 +9,7 @@
 
 #include <altera.h>
 
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 #include <asm/arch/fpga_manager_gen5.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
 #include <asm/arch/fpga_manager_arria10.h>
diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index 0b80e952131..3f56d2ae4b7 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -24,7 +24,7 @@ void socfpga_fpga_add(void *fpga_desc);
 static inline void socfpga_fpga_add(void *fpga_desc) {}
 #endif
 
-#ifdef CONFIG_TARGET_SOCFPGA_GEN5
+#ifdef CONFIG_ARCH_SOCFPGA_GEN5
 void socfpga_sdram_remap_zero(void);
 static inline bool socfpga_is_booting_from_fpga(void)
 {
diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager.h b/arch/arm/mach-socfpga/include/mach/reset_manager.h
index 1d68034cb55..875045af081 100644
--- a/arch/arm/mach-socfpga/include/mach/reset_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/reset_manager.h
@@ -39,7 +39,7 @@ void socfpga_per_reset_all(void);
 /* Create a human-readable reference to SoCFPGA reset. */
 #define SOCFPGA_RESET(_name)	RSTMGR_##_name
 
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 #include <asm/arch/reset_manager_gen5.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
 #include <asm/arch/reset_manager_arria10.h>
diff --git a/arch/arm/mach-socfpga/include/mach/sdram.h b/arch/arm/mach-socfpga/include/mach/sdram.h
index 79cb9e6064a..b41e1188613 100644
--- a/arch/arm/mach-socfpga/include/mach/sdram.h
+++ b/arch/arm/mach-socfpga/include/mach/sdram.h
@@ -7,7 +7,7 @@
 
 #ifndef __ASSEMBLY__
 
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 #include <asm/arch/sdram_gen5.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
 #include <asm/arch/sdram_arria10.h>
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager.h b/arch/arm/mach-socfpga/include/mach/system_manager.h
index 5603eaa3d02..975cfad19d4 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager.h
@@ -85,7 +85,7 @@ phys_addr_t socfpga_get_sysmgr_addr(void);
 #define ALT_SYSMGR_ECC_INTSTAT_SERR_OCRAM_SET_MSK	BIT(1)
 #define ALT_SYSMGR_ECC_INTSTAT_DERR_OCRAM_SET_MSK	BIT(1)
 
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 #include <asm/arch/system_manager_gen5.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
 #include <asm/arch/system_manager_arria10.h>
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 3b7b6cafef8..749e2dc1395 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -545,7 +545,7 @@ config SPL_SYS_MMCSD_RAW_MODE
 	depends on SPL_DM_MMC || SPL_MMC
 	default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
 		     ARCH_MX6 || ARCH_MX7 || \
-		     ARCH_ROCKCHIP || ARCH_MVEBU || TARGET_SOCFPGA_GEN5 || \
+		     ARCH_ROCKCHIP || ARCH_MVEBU || ARCH_SOCFPGA_GEN5 || \
 		     ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		     OMAP54XX || AM33XX || AM43XX || \
 		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
@@ -589,7 +589,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	default 0x8a if ARCH_MX6 || ARCH_MX7
 	default 0x100 if ARCH_UNIPHIER
 	default 0x0 if ARCH_MVEBU
-	default 0x200 if TARGET_SOCFPGA_GEN5 || ARCH_AT91
+	default 0x200 if ARCH_SOCFPGA_GEN5 || ARCH_AT91
 	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
 	default 0x4000 if ARCH_ROCKCHIP
diff --git a/drivers/ddr/altera/Kconfig b/drivers/ddr/altera/Kconfig
index 4660d20deff..b67bc3484ab 100644
--- a/drivers/ddr/altera/Kconfig
+++ b/drivers/ddr/altera/Kconfig
@@ -1,8 +1,8 @@
 config SPL_ALTERA_SDRAM
 	bool "SoCFPGA DDR SDRAM driver in SPL"
 	depends on SPL
-	depends on TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10 || TARGET_SOCFPGA_SOC64
-	select RAM if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_SOC64
-	select SPL_RAM if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_SOC64
+	depends on ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10 || TARGET_SOCFPGA_SOC64
+	select RAM if ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_SOC64
+	select SPL_RAM if ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_SOC64
 	help
 	  Enable DDR SDRAM controller for the SoCFPGA devices.
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 7ed43965be5..19eaff6a447 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -7,7 +7,7 @@
 # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
 
 ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
-obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
+obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f22d3b3d86e..2facdeba673 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -21,6 +21,6 @@ obj-$(CONFIG_FPGA_INTEL_SDM_MAILBOX) += intel_sdm_mb.o
 obj-$(CONFIG_FPGA_STRATIX_II) += stratixII.o
 obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
 obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
-obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += socfpga_gen5.o
+obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += socfpga_gen5.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += socfpga_arria10.o
 endif
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 0181f6cd581..33e7ffd2fc1 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -196,7 +196,7 @@ config SYSRESET_SBI
 
 config SYSRESET_SOCFPGA
 	bool "Enable support for Intel SOCFPGA family"
-	depends on ARCH_SOCFPGA && (TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10)
+	depends on ARCH_SOCFPGA && (ARCH_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10)
 	help
 	  This enables the system reset driver support for Intel SOCFPGA SoCs
 	  (Cyclone 5, Arria 5 and Arria 10).
diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 2acfdc7df4a..17f68e7d307 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -11,7 +11,7 @@
  * Memory configurations
  */
 #define PHYS_SDRAM_1			0x0
-#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
+#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
 #define CFG_SYS_INIT_RAM_ADDR	0xFFFF0000
 #define CFG_SYS_INIT_RAM_SIZE	SOCFPGA_PHYS_OCRAM_SIZE
 #elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 52f014ad332..f5829191662 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -266,7 +266,7 @@ ifneq ($(CONFIG_ARCH_EXYNOS)$(CONFIG_ARCH_S5PC1XX),)
 INPUTS-y	+= $(obj)/$(BOARD)-spl.bin
 endif
 
-ifneq ($(CONFIG_TARGET_SOCFPGA_GEN5)$(CONFIG_TARGET_SOCFPGA_ARRIA10),)
+ifneq ($(CONFIG_ARCH_SOCFPGA_GEN5)$(CONFIG_TARGET_SOCFPGA_ARRIA10),)
 INPUTS-y	+= $(obj)/$(SPL_BIN).sfp
 endif
 
-- 
2.34.1

