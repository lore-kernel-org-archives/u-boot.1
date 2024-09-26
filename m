Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187D6CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A517388FF6;
	Fri, 27 Sep 2024 00:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jX7X0OTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC6588FFB; Fri, 27 Sep 2024 00:44:45 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0047B88FF7
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-4582c4aa2c2so9030511cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390679; x=1727995479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tuee9F1OeMcFuod3Tk2bU5inzNAEYB5ECpzH+RT3H5A=;
 b=jX7X0OTZYEPrVFPEnKTPwqN7A3gVXS6Cf9Idt/+ryvKEWkMUtQ6U3VyTkhrAB/podn
 hOESJ4wdlwNKXS3PX1RcbJNxyDjDETs5hKrPNC08Tfq8FahcS0A3vurc3sdLKfmrz+uT
 HkuisPLOQBHO4jMQRa4fLqkGDxvCwQaRO48T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390679; x=1727995479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tuee9F1OeMcFuod3Tk2bU5inzNAEYB5ECpzH+RT3H5A=;
 b=ESd65YYwqK8Y8u0jz70ZymvgbpD3WbEqU9jCgNazDlKMR468uYnzZjBkYLJkDVeCkG
 cmOCXJIEAxXI8XiSkhTzg60aHWanISmvuO+LyfLQ2SPFSgrDAXPzCP+QeYUl+vzLCgm7
 mnnFx7qyHzFrwzePSnjETmnCEz7gMucuu47s2QsSptlzgni9DseLiAlcj3Ijpo+F8T0o
 uAeDINCNNuLUf2rMYjA2P741vYmM/MS/EDTEb56ZC89z1JAyOfWFBhhTJy7HoRWcNpm8
 /hMGUQOxui+8JitLHHDHeoWpjv5XIYj5LYyUGFj84HKBYUZrGS9T8UL/lGGtT2Cpj3dx
 soog==
X-Gm-Message-State: AOJu0YwOlHt7h1DGhZ+nkohxyQE8I7mvAw5xn6wA1QBLh9u0EQIJZl68
 JZoBlTkc1vl9uwfFywBvW+7brTdyokDOvdTdB3V+zlZSPeVVoIhtRtdkTrfl3HpX2brBKQnpnc8
 1LNsNPIKKzA==
X-Google-Smtp-Source: AGHT+IHNUsEbxyOBaE3CxmvPcfCB7JYpnt3ElyD92a8b/1pnJAMpKbT6ruAcCwCnz67xU0fAk+r1qQ==
X-Received: by 2002:a05:622a:40c:b0:453:1afe:c711 with SMTP id
 d75a77b69052e-45c9f236c08mr11877761cf.28.1727390678071; 
 Thu, 26 Sep 2024 15:44:38 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:44:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH 29/42] global: Rename SPL_ to XPL_
Date: Fri, 27 Sep 2024 00:35:54 +0200
Message-ID: <20240926223814.1276764-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use XPL_ as the symbol to indicate an SPL build. This means that SPL_ is
no-longer set.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                                |  4 +--
 arch/arm/config.mk                      |  6 ++--
 arch/arm/cpu/arm920t/Makefile           |  2 +-
 arch/arm/cpu/arm926ejs/Makefile         |  2 +-
 arch/arm/cpu/armv7/Makefile             |  2 +-
 arch/arm/cpu/armv8/Makefile             |  4 +--
 arch/arm/lib/Makefile                   |  2 +-
 arch/arm/mach-at91/arm926ejs/Makefile   |  2 +-
 arch/arm/mach-imx/Makefile              |  2 +-
 arch/arm/mach-omap2/am33xx/Makefile     |  2 +-
 arch/arm/mach-orion5x/Makefile          |  4 +--
 arch/arm/mach-stm32mp/stm32mp1/Makefile |  2 +-
 arch/arm/mach-tegra/Makefile            |  2 +-
 arch/arm/mach-tegra/tegra20/Makefile    |  2 +-
 arch/arm/mach-tegra/tegra30/Makefile    |  2 +-
 arch/arm/mach-zynqmp/Makefile           |  2 +-
 arch/riscv/Makefile                     |  2 +-
 arch/riscv/lib/Makefile                 |  8 ++---
 arch/x86/Makefile                       |  2 +-
 arch/x86/cpu/Makefile                   | 12 +++----
 arch/x86/cpu/intel_common/Makefile      |  4 +--
 arch/x86/cpu/ivybridge/Makefile         |  6 ++--
 arch/x86/cpu/qemu/Makefile              |  2 +-
 arch/x86/lib/Makefile                   |  4 +--
 board/bosch/guardian/Makefile           |  2 +-
 board/freescale/common/Makefile         |  4 +--
 board/st/common/Makefile                |  2 +-
 board/tcl/sl50/Makefile                 |  2 +-
 board/ti/am335x/Makefile                |  2 +-
 board/ti/am43xx/Makefile                |  2 +-
 board/vscom/baltos/Makefile             |  2 +-
 board/xilinx/zynqmp/Makefile            |  2 +-
 boot/Makefile                           |  2 +-
 cmd/Makefile                            |  2 +-
 doc/develop/tests_writing.rst           |  6 ++--
 drivers/Makefile                        | 14 ++++----
 drivers/ata/Makefile                    |  2 +-
 drivers/block/Makefile                  |  2 +-
 drivers/bus/Makefile                    |  2 +-
 drivers/core/Makefile                   |  6 ++--
 drivers/ddr/altera/Makefile             |  2 +-
 drivers/dfu/Makefile                    | 16 ++++-----
 drivers/firmware/Makefile               |  2 +-
 drivers/gpio/Makefile                   |  8 ++---
 drivers/i2c/Makefile                    | 16 ++++-----
 drivers/led/Makefile                    |  2 +-
 drivers/mailbox/Makefile                |  2 +-
 drivers/misc/Makefile                   | 10 +++---
 drivers/mmc/Makefile                    |  6 ++--
 drivers/mux/Makefile                    |  2 +-
 drivers/nvme/Makefile                   |  2 +-
 drivers/phy/Makefile                    |  6 ++--
 drivers/phy/cadence/Makefile            |  4 +--
 drivers/phy/ti/Makefile                 |  2 +-
 drivers/pinctrl/Makefile                |  8 ++---
 drivers/power/domain/Makefile           |  2 +-
 drivers/power/pmic/Makefile             | 30 ++++++++--------
 drivers/power/regulator/Makefile        | 46 ++++++++++++-------------
 drivers/remoteproc/Makefile             |  2 +-
 drivers/serial/Makefile                 |  2 +-
 drivers/timer/Makefile                  |  8 ++---
 drivers/usb/cdns3/Makefile              |  4 +--
 drivers/usb/common/Makefile             |  2 +-
 drivers/usb/dwc3/Makefile               |  4 +--
 drivers/usb/gadget/udc/Makefile         |  4 +--
 drivers/usb/host/Makefile               |  2 +-
 drivers/video/Makefile                  |  2 +-
 drivers/video/tidss/Makefile            |  2 +-
 fs/fat/Makefile                         |  4 +--
 fs/squashfs/Makefile                    |  2 +-
 lib/Makefile                            | 28 +++++++--------
 lib/acpi/Makefile                       |  8 ++---
 lib/aes/Makefile                        |  2 +-
 lib/crypto/Makefile                     | 14 ++++----
 lib/ecdsa/Makefile                      |  2 +-
 net/Makefile                            |  6 ++--
 scripts/Kbuild.include                  |  4 +--
 scripts/Makefile.xpl                    |  4 +--
 test/Makefile                           | 22 ++++++------
 test/fuzz/Makefile                      |  2 +-
 tools/qconfig.py                        |  6 ++--
 81 files changed, 219 insertions(+), 219 deletions(-)

diff --git a/Makefile b/Makefile
index 4378993ccfd..d38adcbd1e6 100644
--- a/Makefile
+++ b/Makefile
@@ -829,7 +829,7 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
-	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
+	$(if $(CONFIG_$(XPL_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
 			$(if $(CONFIG_CPU_V7M), \
 				-I$(srctree)/arch/arm/thumb1/include), \
@@ -864,7 +864,7 @@ libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
 libs-$(CONFIG_SYS_FSL_MMDC) += drivers/ddr/fsl/
-libs-$(CONFIG_$(SPL_)ALTERA_SDRAM) += drivers/ddr/altera/
+libs-$(CONFIG_$(XPL_)ALTERA_SDRAM) += drivers/ddr/altera/
 libs-y += drivers/usb/cdns3/
 libs-y += drivers/usb/dwc3/
 libs-y += drivers/usb/common/
diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 084fd399931..e0045e22271 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -40,7 +40,7 @@ PLATFORM_ELFFLAGS += -B arm -O elf32-littlearm
 endif
 
 # Choose between ARM/Thumb instruction sets
-ifeq ($(CONFIG_$(SPL_)SYS_THUMB_BUILD),y)
+ifeq ($(CONFIG_$(XPL_)SYS_THUMB_BUILD),y)
 AFLAGS_IMPLICIT_IT	:= $(call as-option,-Wa$(comma)-mimplicit-it=always)
 PF_CPPFLAGS_ARM		:= $(AFLAGS_IMPLICIT_IT) \
 			$(call cc-option, -mthumb -mthumb-interwork,\
@@ -53,7 +53,7 @@ PF_CPPFLAGS_ARM := $(call cc-option,-marm,) \
 endif
 
 # Only test once
-ifeq ($(CONFIG_$(SPL_)SYS_THUMB_BUILD),y)
+ifeq ($(CONFIG_$(XPL_)SYS_THUMB_BUILD),y)
 archprepare: checkthumb checkgcc6
 
 checkthumb:
@@ -116,7 +116,7 @@ LDFLAGS_u-boot += -pie
 #
 # http://sourceware.org/bugzilla/show_bug.cgi?id=12532
 #
-ifeq ($(CONFIG_$(SPL_)SYS_THUMB_BUILD),y)
+ifeq ($(CONFIG_$(XPL_)SYS_THUMB_BUILD),y)
 ifeq ($(GAS_BUG_12532),)
 export GAS_BUG_12532:=$(shell if [ $(call binutils-version) -lt 0222 ] ; \
 	then echo y; else echo n; fi)
diff --git a/arch/arm/cpu/arm920t/Makefile b/arch/arm/cpu/arm920t/Makefile
index 5ac3740621c..06456fe5a81 100644
--- a/arch/arm/cpu/arm920t/Makefile
+++ b/arch/arm/cpu/arm920t/Makefile
@@ -9,6 +9,6 @@ obj-y	+= cpu.o
 
 # some files can only build in ARM mode
 
-ifdef CONFIG_$(SPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
 CFLAGS_cpu.o := -marm
 endif
diff --git a/arch/arm/cpu/arm926ejs/Makefile b/arch/arm/cpu/arm926ejs/Makefile
index 75513889c5d..750cb94dc6e 100644
--- a/arch/arm/cpu/arm926ejs/Makefile
+++ b/arch/arm/cpu/arm926ejs/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_ARCH_SUNXI) += sunxi/
 
 # some files can only build in ARM or THUMB2, not THUMB1
 
-ifdef CONFIG_$(SPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
 CFLAGS_cpu.o := -marm
diff --git a/arch/arm/cpu/armv7/Makefile b/arch/arm/cpu/armv7/Makefile
index 0e7d769bd40..6461f5f5bde 100644
--- a/arch/arm/cpu/armv7/Makefile
+++ b/arch/arm/cpu/armv7/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_EFI_LOADER) += sctlr.o
 obj-$(CONFIG_ARMV7_NONSEC) += exception_level.o
 endif
 
-ifneq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),y)
+ifneq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),y)
 obj-y	+= lowlevel_init.o
 endif
 
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 722ec89d239..c5f568e2cb7 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -9,7 +9,7 @@ obj-y	+= cpu.o
 ifndef CONFIG_$(SPL_TPL_)TIMER
 obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
 endif
-ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
+ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
@@ -32,7 +32,7 @@ obj-$(CONFIG_ARMV8_SPIN_TABLE) += spin_table.o spin_table_v8.o
 else
 obj-$(CONFIG_ARCH_SUNXI) += fel_utils.o
 endif
-obj-$(CONFIG_$(SPL_)ARMV8_SEC_FIRMWARE_SUPPORT) += sec_firmware.o sec_firmware_asm.o
+obj-$(CONFIG_$(XPL_)ARMV8_SEC_FIRMWARE_SUPPORT) += sec_firmware.o sec_firmware_asm.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_RECOVER_DATA_SECTION) += spl_data.o
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index e343e81cf32..b73a0397541 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -94,7 +94,7 @@ endif
 
 # some files can only build in ARM or THUMB2, not THUMB1
 
-ifdef CONFIG_$(SPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
 asflags-$(CONFIG_HAS_THUMB2) += -DCONFIG_THUMB2_KERNEL
 ifndef CONFIG_HAS_THUMB2
 
diff --git a/arch/arm/mach-at91/arm926ejs/Makefile b/arch/arm/mach-at91/arm926ejs/Makefile
index a8916862b3f..1695708831c 100644
--- a/arch/arm/mach-at91/arm926ejs/Makefile
+++ b/arch/arm/mach-at91/arm926ejs/Makefile
@@ -32,7 +32,7 @@ obj-y	+= lowlevel_init.o
 endif
 endif
 
-ifdef CONFIG_$(SPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
 CFLAGS_cache.o := -marm
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index af62a39a671..21d955b4aef 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_IMX_RDC) += rdc-sema.o
 ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
 endif
-obj-$(CONFIG_$(SPL_)SATA) += sata.o
+obj-$(CONFIG_$(XPL_)SATA) += sata.o
 obj-$(CONFIG_IMX_HAB)    += hab.o
 obj-$(CONFIG_SYSCOUNTER_TIMER) += syscounter.o
 endif
diff --git a/arch/arm/mach-omap2/am33xx/Makefile b/arch/arm/mach-omap2/am33xx/Makefile
index 3f1af7f1633..6f3587f01d0 100644
--- a/arch/arm/mach-omap2/am33xx/Makefile
+++ b/arch/arm/mach-omap2/am33xx/Makefile
@@ -11,7 +11,7 @@ endif
 
 obj-y	+= sys_info.o
 obj-y	+= ddr.o
-ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	+= emif4.o
 endif
 obj-y	+= board.o
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index a8b87f6d710..3c381dedaf8 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -11,13 +11,13 @@ obj-y	= cpu.o
 obj-y	+= dram.o
 obj-y	+= timer.o
 
-ifndef CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT
+ifndef CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT
 obj-y	+= lowlevel_init.o
 endif
 
 # some files can only build in ARM or THUMB2, not THUMB1
 
-ifdef CONFIG_$(SPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
 CFLAGS_cpu.o := -marm
diff --git a/arch/arm/mach-stm32mp/stm32mp1/Makefile b/arch/arm/mach-stm32mp/stm32mp1/Makefile
index 5ae1a536ff1..db160c24cbc 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/Makefile
+++ b/arch/arm/mach-stm32mp/stm32mp1/Makefile
@@ -15,5 +15,5 @@ else
 obj-$(CONFIG_ARMV7_PSCI) += psci.o
 endif
 
-obj-$(CONFIG_$(SPL_)STM32MP15_PWR) += pwr_regulator.o
+obj-$(CONFIG_$(XPL_)STM32MP15_PWR) += pwr_regulator.o
 obj-$(CONFIG_OF_SYSTEM_SETUP) += fdt.o
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index a87e6a6c352..ebac3473a1f 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_TEGRA_GP_PADCTRL) += ap.o
 obj-y += board.o board2.o
 obj-y += cache.o
 obj-$(CONFIG_TEGRA_CLKRST) += clock.o
-obj-$(CONFIG_$(SPL_)TEGRA_CRYPTO) += crypto.o
+obj-$(CONFIG_$(XPL_)TEGRA_CRYPTO) += crypto.o
 obj-$(CONFIG_TEGRA_PMC) += powergate.o
 obj-y += xusb-padctl-dummy.o
 
diff --git a/arch/arm/mach-tegra/tegra20/Makefile b/arch/arm/mach-tegra/tegra20/Makefile
index 2774c866b02..32c1866b099 100644
--- a/arch/arm/mach-tegra/tegra20/Makefile
+++ b/arch/arm/mach-tegra/tegra20/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2010,2011 Nvidia Corporation.
 
 obj-$(CONFIG_XPL_BUILD) += cpu.o
-obj-$(CONFIG_$(SPL_)CMD_EBTUPDATE) += bct.o
+obj-$(CONFIG_$(XPL_)CMD_EBTUPDATE) += bct.o
 
 # The AVP is ARMv4T architecture so we must use special compiler
 # flags for any startup files it might use.
diff --git a/arch/arm/mach-tegra/tegra30/Makefile b/arch/arm/mach-tegra/tegra30/Makefile
index 5edc7c9ce7d..b36657a432f 100644
--- a/arch/arm/mach-tegra/tegra30/Makefile
+++ b/arch/arm/mach-tegra/tegra30/Makefile
@@ -3,6 +3,6 @@
 # Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
 
 obj-$(CONFIG_XPL_BUILD) += cpu.o
-obj-$(CONFIG_$(SPL_)CMD_EBTUPDATE) += bct.o
+obj-$(CONFIG_$(XPL_)CMD_EBTUPDATE) += bct.o
 
 obj-y	+= clock.o
diff --git a/arch/arm/mach-zynqmp/Makefile b/arch/arm/mach-zynqmp/Makefile
index 7c95f32a5c3..ff426044797 100644
--- a/arch/arm/mach-zynqmp/Makefile
+++ b/arch/arm/mach-zynqmp/Makefile
@@ -7,7 +7,7 @@ obj-y	+= aes.o clk.o cpu.o
 obj-$(CONFIG_MP)	+= mp.o
 obj-$(CONFIG_XPL_BUILD) += spl.o handoff.o psu_spl_init.o
 obj-$(CONFIG_SPL_ZYNQMP_DRAM_ECC_INIT) += ecc_spl_init.o
-obj-$(CONFIG_$(SPL_)ZYNQMP_PSU_INIT_ENABLED)	+= psu_spl_init.o
+obj-$(CONFIG_$(XPL_)ZYNQMP_PSU_INIT_ENABLED)	+= psu_spl_init.o
 
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ZYNQMP) += zynqmp.o
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index c36a8533e0f..4e6f347038d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -48,7 +48,7 @@ endif
 ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
 	     -mcmodel=$(CMODEL)
 
-ifeq ($(CONFIG_$(SPL_)FRAMEPOINTER),y)
+ifeq ($(CONFIG_$(XPL_)FRAMEPOINTER),y)
 	ARCH_FLAGS += -fno-omit-frame-pointer
 endif
 
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 3bc34cd61fb..34b69c13392 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -11,19 +11,19 @@ obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
-ifeq ($(CONFIG_$(SPL_)RISCV_MMODE),y)
-obj-$(CONFIG_$(SPL_)RISCV_ACLINT) += aclint_ipi.o
+ifeq ($(CONFIG_$(XPL_)RISCV_MMODE),y)
+obj-$(CONFIG_$(XPL_)RISCV_ACLINT) += aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
 else
 obj-$(CONFIG_SBI) += sbi.o
 obj-$(CONFIG_SBI_IPI) += sbi_ipi.o
 endif
 obj-y	+= interrupts.o
-ifeq ($(CONFIG_$(SPL_)SYSRESET),)
+ifeq ($(CONFIG_$(XPL_)SYSRESET),)
 obj-y	+= reset.o
 endif
 obj-y   += setjmp.o
-obj-$(CONFIG_$(SPL_)SMP) += smp.o
+obj-$(CONFIG_$(XPL_)SMP) += smp.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-y   += fdt_fixup.o
 obj-$(CONFIG_$(SPL)CMD_BDI) += bdinfo.o
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3c8c541efbc..bc1e1ede12a 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifeq ($(CONFIG_EFI_APP),)
-ifdef CONFIG_$(SPL_)X86_64
+ifdef CONFIG_$(XPL_)X86_64
 head-y := arch/x86/cpu/start64.o
 else
 ifeq ($(CONFIG_$(SPL_TPL_)X86_16BIT_INIT),y)
diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index c21d6d6d438..8899830370c 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -6,7 +6,7 @@
 # (C) Copyright 2002
 # Daniel Engström, Omicron Ceti AB, daniel@omicron.se.
 
-ifeq ($(CONFIG_$(SPL_)X86_64),y)
+ifeq ($(CONFIG_$(XPL_)X86_64),y)
 extra-y	= start64.o
 else
 ifeq ($(CONFIG_$(SPL_TPL_)X86_16BIT_INIT),y)
@@ -31,7 +31,7 @@ ifndef CONFIG_TPL_BUILD
 obj-y	+= cpu_x86.o
 endif
 
-ifndef CONFIG_$(SPL_)X86_64
+ifndef CONFIG_$(XPL_)X86_64
 AFLAGS_REMOVE_call32.o := -mregparm=3 \
 	$(if $(CONFIG_EFI_STUB_64BIT),-march=i386 -m32)
 AFLAGS_call32.o := -fpic -fshort-wchar \
@@ -59,18 +59,18 @@ obj-$(CONFIG_QFW) += qfw_cpu.o
 ifndef CONFIG_SYS_COREBOOT
 obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += irq.o
 endif
-ifndef CONFIG_$(SPL_)X86_64
-obj-$(CONFIG_$(SPL_)SMP) += mp_init.o
+ifndef CONFIG_$(XPL_)X86_64
+obj-$(CONFIG_$(XPL_)SMP) += mp_init.o
 endif
 obj-y += mtrr.o
 obj-$(CONFIG_PCI) += pci.o
-ifndef CONFIG_$(SPL_)X86_64
+ifndef CONFIG_$(XPL_)X86_64
 obj-$(CONFIG_SMP) += sipi_vector.o
 endif
 obj-y += turbo.o
 obj-$(CONFIG_HAVE_ACPI_RESUME) += wakeup.o
 
-ifeq ($(CONFIG_$(SPL_)X86_64),y)
+ifeq ($(CONFIG_$(XPL_)X86_64),y)
 obj-y += x86_64/
 else
 obj-y += i386/
diff --git a/arch/x86/cpu/intel_common/Makefile b/arch/x86/cpu/intel_common/Makefile
index 2e312a30353..d2db5897377 100644
--- a/arch/x86/cpu/intel_common/Makefile
+++ b/arch/x86/cpu/intel_common/Makefile
@@ -26,10 +26,10 @@ obj-y += cpu.o
 obj-y += fast_spi.o
 obj-y += lpc.o
 obj-y += lpss.o
-obj-$(CONFIG_$(SPL_)INTEL_GENERIC_WIFI) += generic_wifi.o
+obj-$(CONFIG_$(XPL_)INTEL_GENERIC_WIFI) += generic_wifi.o
 ifndef CONFIG_EFI_APP
 obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += microcode.o
-ifndef CONFIG_$(SPL_)X86_64
+ifndef CONFIG_$(XPL_)X86_64
 obj-y += microcode.o
 endif
 endif
diff --git a/arch/x86/cpu/ivybridge/Makefile b/arch/x86/cpu/ivybridge/Makefile
index 1f3b0c092f1..471ad8d7ebc 100644
--- a/arch/x86/cpu/ivybridge/Makefile
+++ b/arch/x86/cpu/ivybridge/Makefile
@@ -5,15 +5,15 @@
 ifdef CONFIG_HAVE_FSP
 obj-y += fsp_configs.o ivybridge.o
 else
-obj-$(CONFIG_$(SPL_)X86_32BIT_INIT) += cpu.o
+obj-$(CONFIG_$(XPL_)X86_32BIT_INIT) += cpu.o
 obj-y += early_me.o
 obj-y += lpc.o
 obj-y += northbridge.o
 ifndef CONFIG_XPL_BUILD
 obj-y += sata.o
 endif
-obj-$(CONFIG_$(SPL_)X86_32BIT_INIT) += sdram.o
-ifndef CONFIG_$(SPL_)X86_32BIT_INIT
+obj-$(CONFIG_$(XPL_)X86_32BIT_INIT) += sdram.o
+ifndef CONFIG_$(XPL_)X86_32BIT_INIT
 obj-y += sdram_nop.o
 endif
 endif
diff --git a/arch/x86/cpu/qemu/Makefile b/arch/x86/cpu/qemu/Makefile
index b7dd5bd46c7..1439916ac2d 100644
--- a/arch/x86/cpu/qemu/Makefile
+++ b/arch/x86/cpu/qemu/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
 
-ifndef CONFIG_$(SPL_)X86_64
+ifndef CONFIG_$(XPL_)X86_64
 obj-y += car.o
 endif
 obj-y += dram.o
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index bf0605ad662..decf2e5c628 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -19,7 +19,7 @@ ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 endif
 obj-y	+= cmd_boot.o
-obj-$(CONFIG_$(SPL_)COREBOOT_SYSINFO)	+= coreboot/
+obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO)	+= coreboot/
 obj-$(CONFIG_SEABIOS) += coreboot_table.o
 obj-y	+= early_cmos.o
 obj-y	+= e820.o
@@ -85,7 +85,7 @@ endif
 
 ifdef CONFIG_EFI_STUB
 
-ifeq ($(CONFIG_$(SPL_)X86_64),)
+ifeq ($(CONFIG_$(XPL_)X86_64),)
 extra-y += $(EFI_CRT0) $(EFI_RELOC)
 endif
 
diff --git a/board/bosch/guardian/Makefile b/board/bosch/guardian/Makefile
index 20cecbfb64e..8e38881ec2c 100644
--- a/board/bosch/guardian/Makefile
+++ b/board/bosch/guardian/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2018 Robert Bosch Power Tools GmbH
 #
 
-ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index 0e1dec49238..279d390db64 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_FSL_NGPIXIS)	+= ngpixis.o
 endif
 obj-$(I2C_COMMON)		+= i2c_common.o
 obj-$(CONFIG_FSL_USE_PCA9547_MUX)		+= i2c_mux.o
-obj-$(CONFIG_$(SPL_)VID)	+= vid.o
+obj-$(CONFIG_$(XPL_)VID)	+= vid.o
 obj-$(CONFIG_FSL_QIXIS)	+= qixis.o
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ID_EEPROM)	+= sys_eeprom.o
@@ -52,7 +52,7 @@ obj-$(CONFIG_TARGET_MPC8548CDS)	+= cds_pci_ft.o
 obj-$(CONFIG_TARGET_P3041DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P4080DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P5040DS)		+= ics307_clk.o
-ifeq ($(CONFIG_$(SPL_)POWER_LEGACY),y)
+ifeq ($(CONFIG_$(XPL_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
 obj-$(CONFIG_DM_PMIC_PFUZE100)	+= pfuze.o
diff --git a/board/st/common/Makefile b/board/st/common/Makefile
index b01245e4b48..fda48d2ff99 100644
--- a/board/st/common/Makefile
+++ b/board/st/common/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 
 ifeq ($(CONFIG_ARCH_STM32MP),y)
 obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
-obj-$(CONFIG_$(SPL_)DFU_VIRT) += stm32mp_dfu_virt.o
+obj-$(CONFIG_$(XPL_)DFU_VIRT) += stm32mp_dfu_virt.o
 endif
 
 obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o
diff --git a/board/tcl/sl50/Makefile b/board/tcl/sl50/Makefile
index 0ac0ba36cdb..1502990174b 100644
--- a/board/tcl/sl50/Makefile
+++ b/board/tcl/sl50/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2015 Toby Churchill Ltd - http://www.toby-churchill.com/
 
-ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/ti/am335x/Makefile b/board/ti/am335x/Makefile
index 2b1e21a1788..6ef87c22eaa 100644
--- a/board/ti/am335x/Makefile
+++ b/board/ti/am335x/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/ti/am43xx/Makefile b/board/ti/am43xx/Makefile
index b618f632eff..5b7b5b371a4 100644
--- a/board/ti/am43xx/Makefile
+++ b/board/ti/am43xx/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
 
-ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/vscom/baltos/Makefile b/board/vscom/baltos/Makefile
index 2b1e21a1788..6ef87c22eaa 100644
--- a/board/vscom/baltos/Makefile
+++ b/board/vscom/baltos/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifeq ($(CONFIG_$(SPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 544346d686e..6476f20eb83 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -31,7 +31,7 @@ $(warning Put custom psu_init_gpl.c/h to board/xilinx/zynqmp/custom_hw_platform/
 endif
 endif
 
-obj-$(CONFIG_$(SPL_)ZYNQMP_PSU_INIT_ENABLED) += $(init-objs)
+obj-$(CONFIG_$(XPL_)ZYNQMP_PSU_INIT_ENABLED) += $(init-objs)
 
 ifdef CONFIG_XPL_BUILD
 ifneq ($(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE),"")
diff --git a/boot/Makefile b/boot/Makefile
index 5bf07e83388..1b6901970e3 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -50,7 +50,7 @@ obj-$(CONFIG_$(SPL_TPL_)UPL_WRITE) += upl_write.o
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
 obj-$(CONFIG_$(SPL_TPL_)FIT) += image-fit.o
-obj-$(CONFIG_$(SPL_)MULTI_DTB_FIT) += boot_fit.o common_fit.o
+obj-$(CONFIG_$(XPL_)MULTI_DTB_FIT) += boot_fit.o common_fit.o
 obj-$(CONFIG_$(SPL_TPL_)IMAGE_PRE_LOAD) += image-pre-load.o
 obj-$(CONFIG_$(SPL_TPL_)IMAGE_SIGN_INFO) += image-sig.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += image-fit-sig.o
diff --git a/cmd/Makefile b/cmd/Makefile
index ed62e1c45f8..21d376309b9 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -249,7 +249,7 @@ obj-$(CONFIG_ARCH_K3) += ti/
 obj-$(CONFIG_ARCH_OMAP2PLUS) += ti/
 endif # !CONFIG_XPL_BUILD
 
-obj-$(CONFIG_$(SPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
+obj-$(CONFIG_$(XPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
 
 obj-$(CONFIG_CMD_BCM_EXT_UTILS) += broadcom/
 
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index a328ebfef33..54efb7e1b04 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -321,15 +321,15 @@ to control that.
 Finally, add the test to the build by adding to the Makefile in the same
 directory::
 
-  obj-$(CONFIG_$(SPL_)CMDLINE) += wibble.o
+  obj-$(CONFIG_$(XPL_)CMDLINE) += wibble.o
 
 Note that CMDLINE is never enabled in SPL, so this test will only be present in
 U-Boot proper. See below for how to do SPL tests.
 
 As before, you can add an extra Kconfig check if needed::
 
-  ifneq ($(CONFIG_$(SPL_)WIBBLE),)
-  obj-$(CONFIG_$(SPL_)CMDLINE) += wibble.o
+  ifneq ($(CONFIG_$(XPL_)WIBBLE),)
+  obj-$(CONFIG_$(XPL_)CMDLINE) += wibble.o
   endif
 
 
diff --git a/drivers/Makefile b/drivers/Makefile
index 260bde957db..fd247265fe5 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -33,15 +33,15 @@ obj-$(CONFIG_$(SPL_TPL_)SERIAL) += serial/
 obj-$(CONFIG_$(SPL_TPL_)SPI) += spi/
 obj-$(CONFIG_$(SPL_TPL_)TIMER) += timer/
 obj-$(CONFIG_$(SPL_TPL_)VIRTIO) += virtio/
-obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox/
-obj-$(CONFIG_$(SPL_)REMOTEPROC) += remoteproc/
-obj-$(CONFIG_$(SPL_)SYSINFO) += sysinfo/
+obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox/
+obj-$(CONFIG_$(XPL_)REMOTEPROC) += remoteproc/
+obj-$(CONFIG_$(XPL_)SYSINFO) += sysinfo/
 obj-$(CONFIG_$(SPL_TPL_)SM) += sm/
 obj-$(CONFIG_$(SPL_TPL_)TPM) += tpm/
-obj-$(CONFIG_$(SPL_)NVME) += nvme/
+obj-$(CONFIG_$(XPL_)NVME) += nvme/
 obj-$(CONFIG_XEN) += xen/
-obj-$(CONFIG_$(SPL_)FPGA) += fpga/
-obj-$(CONFIG_$(SPL_)VIDEO) += video/
+obj-$(CONFIG_$(XPL_)FPGA) += fpga/
+obj-$(CONFIG_$(XPL_)VIDEO) += video/
 
 obj-y += bus/
 
@@ -52,7 +52,7 @@ obj-$(CONFIG_SPL_CRYPTO) += crypto/
 obj-$(CONFIG_SPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 obj-$(CONFIG_ARMADA_38X) += ddr/marvell/a38x/
 obj-$(CONFIG_ARMADA_XP) += ddr/marvell/axp/
-obj-$(CONFIG_$(SPL_)ALTERA_SDRAM) += ddr/altera/
+obj-$(CONFIG_$(XPL_)ALTERA_SDRAM) += ddr/altera/
 obj-$(CONFIG_ARCH_IMX8M) += ddr/imx/imx8m/
 obj-$(CONFIG_IMX8ULP_DRAM) += ddr/imx/imx8ulp/
 obj-$(CONFIG_ARCH_IMX9) += ddr/imx/imx9/
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index af6f0bf2780..ee10c4445b0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_DWC_AHCI) += dwc_ahci.o
 obj-$(CONFIG_AHCI) += ahci-uclass.o
-obj-$(CONFIG_$(SPL_)AHCI_PCI) += ahci-pci.o
+obj-$(CONFIG_$(XPL_)AHCI_PCI) += ahci-pci.o
 obj-$(CONFIG_SCSI_AHCI) += ahci.o
 obj-$(CONFIG_DWC_AHSATA) += dwc_ahsata.o
 obj-$(CONFIG_FSL_SATA) += fsl_sata.o
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a551591fc91..98a34c01c38 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_$(SPL_TPL_)BLK) += blk-uclass.o
 
-ifndef CONFIG_$(SPL_)BLK
+ifndef CONFIG_$(XPL_)BLK
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
 endif
 
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index b7e6452c48c..c40139f04d0 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
 
-obj-$(CONFIG_$(SPL_)TI_SYSC)	+= ti-sysc.o
+obj-$(CONFIG_$(XPL_)TI_SYSC)	+= ti-sysc.o
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index acbd2bf2cef..20dbff6f956 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -6,16 +6,16 @@ obj-y	+= device.o fdtaddr.o lists.o root.o uclass.o util.o tag.o
 obj-$(CONFIG_$(SPL_TPL_)ACPIGEN) += acpi.o
 obj-$(CONFIG_$(SPL_TPL_)DEVRES) += devres.o
 obj-$(CONFIG_$(SPL_TPL_)DM_DEVICE_REMOVE)	+= device-remove.o
-obj-$(CONFIG_$(SPL_)SIMPLE_BUS)	+= simple-bus.o
+obj-$(CONFIG_$(XPL_)SIMPLE_BUS)	+= simple-bus.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
 obj-$(CONFIG_$(SPL_TPL_)REGMAP)	+= regmap.o
 obj-$(CONFIG_$(SPL_TPL_)SYSCON)	+= syscon-uclass.o
-obj-$(CONFIG_$(SPL_)OF_LIVE) += of_access.o of_addr.o
+obj-$(CONFIG_$(XPL_)OF_LIVE) += of_access.o of_addr.o
 ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
 endif
-obj-$(CONFIG_$(SPL_)OF_PLATDATA) += read.o
+obj-$(CONFIG_$(XPL_)OF_PLATDATA) += read.o
 obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o
 
 ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 9fa5d85a27e..c1d6a6b6c59 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -6,7 +6,7 @@
 # (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
 # Copyright (C) 2014-2021 Altera Corporation <www.altera.com>
 
-ifdef CONFIG_$(SPL_)ALTERA_SDRAM
+ifdef CONFIG_$(XPL_)ALTERA_SDRAM
 obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
diff --git a/drivers/dfu/Makefile b/drivers/dfu/Makefile
index dfbf64da667..05d7cc61caa 100644
--- a/drivers/dfu/Makefile
+++ b/drivers/dfu/Makefile
@@ -3,11 +3,11 @@
 # Copyright (C) 2012 Samsung Electronics
 # Lukasz Majewski <l.majewski@samsung.com>
 
-obj-$(CONFIG_$(SPL_)DFU) += dfu.o
-obj-$(CONFIG_$(SPL_)DFU_MMC) += dfu_mmc.o
-obj-$(CONFIG_$(SPL_)DFU_MTD) += dfu_mtd.o
-obj-$(CONFIG_$(SPL_)DFU_NAND) += dfu_nand.o
-obj-$(CONFIG_$(SPL_)DFU_RAM) += dfu_ram.o
-obj-$(CONFIG_$(SPL_)DFU_SF) += dfu_sf.o
-obj-$(CONFIG_$(SPL_)DFU_WRITE_ALT) += dfu_alt.o
-obj-$(CONFIG_$(SPL_)DFU_VIRT) += dfu_virt.o
+obj-$(CONFIG_$(XPL_)DFU) += dfu.o
+obj-$(CONFIG_$(XPL_)DFU_MMC) += dfu_mmc.o
+obj-$(CONFIG_$(XPL_)DFU_MTD) += dfu_mtd.o
+obj-$(CONFIG_$(XPL_)DFU_NAND) += dfu_nand.o
+obj-$(CONFIG_$(XPL_)DFU_RAM) += dfu_ram.o
+obj-$(CONFIG_$(XPL_)DFU_SF) += dfu_sf.o
+obj-$(CONFIG_$(XPL_)DFU_WRITE_ALT) += dfu_alt.o
+obj-$(CONFIG_$(XPL_)DFU_VIRT) += dfu_virt.o
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 7ce83d72bd3..8b979f69ed9 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_FIRMWARE)		+= firmware-uclass.o
-obj-$(CONFIG_$(SPL_)ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_$(XPL_)ARM_PSCI_FW)	+= psci.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_SANDBOX)		+= firmware-sandbox.o
 obj-$(CONFIG_ZYNQMP_FIRMWARE)	+= firmware-zynqmp.o
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 990a670dd7b..24d1b0394fb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
 endif
 obj-$(CONFIG_$(SPL_TPL_)DM_GPIO) += gpio-uclass.o
 
-obj-$(CONFIG_$(SPL_)DM_PCA953X)	+= pca953x_gpio.o
+obj-$(CONFIG_$(XPL_)DM_PCA953X)	+= pca953x_gpio.o
 
 obj-$(CONFIG_ASPEED_GPIO)	+= gpio-aspeed.o
 obj-$(CONFIG_ASPEED_G7_GPIO)	+= gpio-aspeed-g7.o
@@ -57,12 +57,12 @@ obj-$(CONFIG_VYBRID_GPIO)	+= vybrid_gpio.o
 obj-$(CONFIG_HIKEY_GPIO)	+= hi6220_gpio.o
 obj-$(CONFIG_HSDK_CREG_GPIO)	+= hsdk-creg-gpio.o
 obj-$(CONFIG_IMX_RGPIO2P)	+= imx_rgpio2p.o
-obj-$(CONFIG_$(SPL_)PALMAS_GPIO)	+= palmas_gpio.o
+obj-$(CONFIG_$(XPL_)PALMAS_GPIO)	+= palmas_gpio.o
 obj-$(CONFIG_PIC32_GPIO)	+= pic32_gpio.o
 obj-$(CONFIG_OCTEON_GPIO)	+= octeon_gpio.o
 obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
 obj-$(CONFIG_MSM_GPIO)		+= msm_gpio.o
-obj-$(CONFIG_$(SPL_)PCF8575_GPIO)	+= pcf8575_gpio.o
+obj-$(CONFIG_$(XPL_)PCF8575_GPIO)	+= pcf8575_gpio.o
 obj-$(CONFIG_$(SPL_TPL_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o
 obj-$(CONFIG_MT7620_GPIO)	+= mt7620_gpio.o
 obj-$(CONFIG_MT7621_GPIO)	+= mt7621_gpio.o
@@ -71,7 +71,7 @@ obj-$(CONFIG_NX_GPIO)		+= nx_gpio.o
 obj-$(CONFIG_SIFIVE_GPIO)	+= sifive-gpio.o
 obj-$(CONFIG_NOMADIK_GPIO)	+= nmk_gpio.o
 obj-$(CONFIG_MAX7320_GPIO)	+= max7320_gpio.o
-obj-$(CONFIG_$(SPL_)MAX77663_GPIO)	+= max77663_gpio.o
+obj-$(CONFIG_$(XPL_)MAX77663_GPIO)	+= max77663_gpio.o
 obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 00b90523c62..bebd728e7da 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -2,15 +2,15 @@
 #
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-obj-$(CONFIG_$(SPL_)DM_I2C) += i2c-uclass.o
-ifdef CONFIG_$(SPL_)ACPIGEN
-obj-$(CONFIG_$(SPL_)DM_I2C) += acpi_i2c.o
+obj-$(CONFIG_$(XPL_)DM_I2C) += i2c-uclass.o
+ifdef CONFIG_$(XPL_)ACPIGEN
+obj-$(CONFIG_$(XPL_)DM_I2C) += acpi_i2c.o
 endif
-obj-$(CONFIG_$(SPL_)DM_I2C_GPIO) += i2c-gpio.o
-obj-$(CONFIG_$(SPL_)I2C_CROS_EC_TUNNEL) += cros_ec_tunnel.o
-obj-$(CONFIG_$(SPL_)I2C_CROS_EC_LDO) += cros_ec_ldo.o
+obj-$(CONFIG_$(XPL_)DM_I2C_GPIO) += i2c-gpio.o
+obj-$(CONFIG_$(XPL_)I2C_CROS_EC_TUNNEL) += cros_ec_tunnel.o
+obj-$(CONFIG_$(XPL_)I2C_CROS_EC_LDO) += cros_ec_ldo.o
 
-obj-$(CONFIG_$(SPL_)SYS_I2C_LEGACY) += i2c_core.o
+obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) += i2c_core.o
 obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
 obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
 obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
@@ -57,4 +57,4 @@ obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
 obj-$(CONFIG_SYS_I2C_XILINX_XIIC) += xilinx_xiic.o
 obj-$(CONFIG_TEGRA186_BPMP_I2C) += tegra186_bpmp_i2c.o
 
-obj-$(CONFIG_$(SPL_)I2C_MUX) += muxes/
+obj-$(CONFIG_$(XPL_)I2C_MUX) += muxes/
diff --git a/drivers/led/Makefile b/drivers/led/Makefile
index e27aa488482..aa64a38b4e1 100644
--- a/drivers/led/Makefile
+++ b/drivers/led/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
 obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
 obj-$(CONFIG_LED_BCM6858) += led_bcm6858.o
 obj-$(CONFIG_LED_PWM) += led_pwm.o
-obj-$(CONFIG_$(SPL_)LED_GPIO) += led_gpio.o
+obj-$(CONFIG_$(XPL_)LED_GPIO) += led_gpio.o
 obj-$(CONFIG_LED_CORTINA) += led_cortina.o
 obj-$(CONFIG_LED_LP5562) += led_lp5562.o
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 59e8d0de93c..6072fa1956b 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2016, NVIDIA CORPORATION.
 #
 
-obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox-uclass.o
+obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 51ef51f1ed3..794c2a2d38e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SANDBOX) += p2sb_sandbox.o p2sb_emul.o
 obj-$(CONFIG_SANDBOX) += swap_case.o
 endif
 
-ifdef CONFIG_$(SPL_)DM_I2C
+ifdef CONFIG_$(XPL_)DM_I2C
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += i2c_eeprom_emul.o
 obj-$(CONFIG_USB_HUB_USB251XB) += usb251xb.o
@@ -37,14 +37,14 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(SPL_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_$(XPL_)FS_LOADER) += fs_loader.o
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
 obj-$(CONFIG_GDSYS_RXAUI_CTRL) += gdsys_rxaui_ctrl.o
 obj-$(CONFIG_GDSYS_SOC) += gdsys_soc.o
 obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
-obj-$(CONFIG_$(SPL_)I2C_EEPROM) += i2c_eeprom.o
+obj-$(CONFIG_$(XPL_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
@@ -52,14 +52,14 @@ obj-$(CONFIG_LED_STATUS) += status_led.o
 obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(SPL_TPL_)LS2_SFP) += ls2_sfp.o
-obj-$(CONFIG_$(SPL_)MXC_OCOTP) += mxc_ocotp.o
+obj-$(CONFIG_$(XPL_)MXC_OCOTP) += mxc_ocotp.o
 obj-$(CONFIG_MXS_OCOTP) += mxs_ocotp.o
 obj-$(CONFIG_NPCM_OTP) += npcm_otp.o
 obj-$(CONFIG_NPCM_HOST) += npcm_host_intf.o
 obj-$(CONFIG_NUVOTON_NCT6102D) += nuvoton_nct6102d.o
 obj-$(CONFIG_P2SB) += p2sb-uclass.o
 obj-$(CONFIG_PCA9551_LED) += pca9551_led.o
-obj-$(CONFIG_$(SPL_)PWRSEQ) += pwrseq-uclass.o
+obj-$(CONFIG_$(XPL_)PWRSEQ) += pwrseq-uclass.o
 ifdef CONFIG_QFW
 obj-y += qfw.o
 obj-$(CONFIG_QFW_ACPI) += qfw_acpi.o
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 952201923d8..328653b8823 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -4,17 +4,17 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-y += mmc.o
-obj-$(CONFIG_$(SPL_)DM_MMC) += mmc-uclass.o
+obj-$(CONFIG_$(XPL_)DM_MMC) += mmc-uclass.o
 
 ifdef CONFIG_$(SPL_TPL_)DM_MMC
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
-obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) += mmc-pwrseq.o
+obj-$(CONFIG_$(XPL_)MMC_PWRSEQ) += mmc-pwrseq.o
 obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
 
-ifndef CONFIG_$(SPL_)BLK
+ifndef CONFIG_$(XPL_)BLK
 obj-y += mmc_legacy.o
 endif
 
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index d4e24789d33..63770e12bd1 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -4,4 +4,4 @@
 # Jean-Jacques Hiblot <jjhiblot@ti.com>
 
 obj-$(CONFIG_MULTIPLEXER) += mux-uclass.o
-obj-$(CONFIG_$(SPL_)MUX_MMIO) += mmio.o
+obj-$(CONFIG_$(XPL_)MUX_MMIO) += mmio.o
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index fd3e68a91dc..8c32cfbfc0f 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -4,4 +4,4 @@
 
 obj-y += nvme-uclass.o nvme.o nvme_show.o
 obj-$(CONFIG_NVME_APPLE) += nvme_apple.o
-obj-$(CONFIG_$(SPL_)NVME_PCI) += nvme_pci.o
+obj-$(CONFIG_$(XPL_)NVME_PCI) += nvme_pci.o
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 7a2b764492b..c35f9294dd9 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -8,8 +8,8 @@ obj-y += marvell/
 obj-y += rockchip/
 obj-y += socionext/
 
-obj-$(CONFIG_$(SPL_)PHY) += phy-uclass.o
-obj-$(CONFIG_$(SPL_)NOP_PHY) += nop-phy.o
+obj-$(CONFIG_$(XPL_)PHY) += phy-uclass.o
+obj-$(CONFIG_$(XPL_)NOP_PHY) += nop-phy.o
 obj-$(CONFIG_MIPI_DPHY_HELPERS) += phy-core-mipi-dphy.o
 obj-$(CONFIG_AB8500_USB_PHY) += phy-ab8500-usb.o
 obj-$(CONFIG_APPLE_ATCPHY) += phy-apple-atc.o
@@ -19,7 +19,7 @@ obj-$(CONFIG_BCM6358_USBH_PHY) += bcm6358-usbh-phy.o
 obj-$(CONFIG_BCM6368_USBH_PHY) += bcm6368-usbh-phy.o
 obj-$(CONFIG_BCM_SR_PCIE_PHY) += phy-bcm-sr-pcie.o
 obj-$(CONFIG_PHY_SANDBOX) += sandbox-phy.o
-obj-$(CONFIG_$(SPL_)PIPE3_PHY) += ti-pipe3-phy.o
+obj-$(CONFIG_$(XPL_)PIPE3_PHY) += ti-pipe3-phy.o
 obj-$(CONFIG_AM654_PHY) += phy-ti-am654.o
 obj-$(CONFIG_STI_USB_PHY) += sti_usb_phy.o
 obj-$(CONFIG_PHY_RCAR_GEN2) += phy-rcar-gen2.o
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
index af63b32d9f5..e0da41cd7eb 100644
--- a/drivers/phy/cadence/Makefile
+++ b/drivers/phy/cadence/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_$(SPL_)PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
-obj-$(CONFIG_$(SPL_)PHY_CADENCE_TORRENT) += phy-cadence-torrent.o
+obj-$(CONFIG_$(XPL_)PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
+obj-$(CONFIG_$(XPL_)PHY_CADENCE_TORRENT) += phy-cadence-torrent.o
diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
index 873ddbf0363..699901fd15e 100644
--- a/drivers/phy/ti/Makefile
+++ b/drivers/phy/ti/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_$(SPL_)PHY_J721E_WIZ)	+= phy-j721e-wiz.o
+obj-$(CONFIG_$(XPL_)PHY_J721E_WIZ)	+= phy-j721e-wiz.o
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 6d7b7cd9051..634047a91f4 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y					+= pinctrl-uclass.o
-obj-$(CONFIG_$(SPL_)PINCTRL_GENERIC)	+= pinctrl-generic.o
+obj-$(CONFIG_$(XPL_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
 obj-y					+= nxp/
-obj-$(CONFIG_$(SPL_)PINCTRL_ROCKCHIP)	+= rockchip/
+obj-$(CONFIG_$(XPL_)PINCTRL_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_ARCH_ASPEED) += aspeed/
 obj-$(CONFIG_ARCH_ATH79) += ath79/
 obj-$(CONFIG_PINCTRL_INTEL) += intel/
@@ -18,7 +18,7 @@ obj-$(CONFIG_ARCH_RENESAS) += renesas/
 obj-$(CONFIG_ARCH_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
-obj-$(CONFIG_$(SPL_)PINCTRL_TEGRA)	+= tegra/
+obj-$(CONFIG_$(XPL_)PINCTRL_TEGRA)	+= tegra/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
@@ -32,7 +32,7 @@ obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
 obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
-obj-$(CONFIG_$(SPL_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
+obj-$(CONFIG_$(XPL_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
 obj-y				+= broadcom/
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 2daab73eb75..110646c503a 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2016, NVIDIA CORPORATION.
 #
 
-obj-$(CONFIG_$(SPL_)POWER_DOMAIN) += power-domain-uclass.o
+obj-$(CONFIG_$(XPL_)POWER_DOMAIN) += power-domain-uclass.o
 obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index a2d59deeed8..48f7dd49ef8 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -4,33 +4,33 @@
 # Lukasz Majewski <l.majewski@samsung.com>
 
 obj-$(CONFIG_$(SPL_TPL_)DM_PMIC) += pmic-uclass.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_FAN53555) += fan53555.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_DA9063) += da9063.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_MAX77663) += max77663.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_FAN53555) += fan53555.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_DA9063) += da9063.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_MAX77663) += max77663.o
 obj-$(CONFIG_DM_PMIC_MAX77686) += max77686.o
 obj-$(CONFIG_DM_PMIC_MAX8998) += max8998.o
 obj-$(CONFIG_DM_PMIC_MC34708) += mc34708.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_BD71837) += bd71837.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_MP5416) += mp5416.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_PCA9450) += pca9450.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_BD71837) += bd71837.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_MP5416) += mp5416.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_PFUZE100) += pfuze100.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_PCA9450) += pca9450.o
 obj-$(CONFIG_PMIC_S2MPS11) += s2mps11.o
 obj-$(CONFIG_DM_PMIC_SANDBOX) += sandbox.o i2c_pmic_emul.o
 obj-$(CONFIG_PMIC_AB8500) += ab8500.o
 obj-$(CONFIG_PMIC_ACT8846) += act8846.o
 obj-$(CONFIG_PMIC_AS3722) += as3722.o as3722_gpio.o
-obj-$(CONFIG_$(SPL_)PMIC_AXP) += axp.o
+obj-$(CONFIG_$(XPL_)PMIC_AXP) += axp.o
 obj-$(CONFIG_PMIC_MAX8997) += max8997.o
 obj-$(CONFIG_PMIC_QCOM) += pmic_qcom.o
 obj-$(CONFIG_$(SPL_TPL_)PMIC_RK8XX) += rk8xx.o
-obj-$(CONFIG_$(SPL_)PMIC_RN5T567) += rn5t567.o
+obj-$(CONFIG_$(XPL_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o
 obj-$(CONFIG_PMIC_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_PMIC_TPS65910) += pmic_tps65910_dm.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_TPS80031) += tps80031.o
-obj-$(CONFIG_$(SPL_)PMIC_PALMAS) += palmas.o
-obj-$(CONFIG_$(SPL_)PMIC_LP873X) += lp873x.o
-obj-$(CONFIG_$(SPL_)PMIC_LP87565) += lp87565.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_TPS80031) += tps80031.o
+obj-$(CONFIG_$(XPL_)PMIC_PALMAS) += palmas.o
+obj-$(CONFIG_$(XPL_)PMIC_LP873X) += lp873x.o
+obj-$(CONFIG_$(XPL_)PMIC_LP87565) += lp87565.o
 obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
 obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
@@ -38,7 +38,7 @@ obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
 obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 
-ifeq ($(CONFIG_$(SPL_)POWER_LEGACY),y)
+ifeq ($(CONFIG_$(XPL_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
 obj-$(CONFIG_POWER_PCA9450) += pmic_pca9450.o
 obj-$(CONFIG_POWER_PFUZE100) += pmic_pfuze100.o
@@ -47,5 +47,5 @@ obj-$(CONFIG_POWER_HI6553) += pmic_hi6553.o
 obj-$(CONFIG_POWER_MC34VR500) += pmic_mc34vr500.o
 endif
 
-obj-$(CONFIG_$(SPL_)POWER_TPS62362) += pmic_tps62362.o
+obj-$(CONFIG_$(XPL_)POWER_TPS62362) += pmic_tps62362.o
 obj-$(CONFIG_SPL_POWER_TPS65910) += pmic_tps65910.o
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 54db0885657..cac02aaa36f 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -4,41 +4,41 @@
 # Przemyslaw Marczak <p.marczak@samsung.com>
 #
 
-obj-$(CONFIG_$(SPL_)DM_REGULATOR) += regulator-uclass.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR) += regulator-uclass.o
 obj-$(CONFIG_REGULATOR_ACT8846) += act8846.o
 obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
-obj-$(CONFIG_$(SPL_)REGULATOR_AXP) += axp_regulator.o
-obj-$(CONFIG_$(SPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_DA9063) += da9063.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_MAX77663) += max77663_regulator.o
+obj-$(CONFIG_$(XPL_)REGULATOR_AXP) += axp_regulator.o
+obj-$(CONFIG_$(XPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_DA9063) += da9063.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_MAX77663) += max77663_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
-obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_BD71837) += bd71837.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_PCA9450) += pca9450.o
-obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_FIXED) += fixed.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
+obj-$(CONFIG_$(XPL_)DM_PMIC_PFUZE100) += pfuze100.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_BD71837) += bd71837.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_PCA9450) += pca9450.o
+obj-$(CONFIG_$(XPL_)REGULATOR_PWM) += pwm_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_FAN53555) += fan53555.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_COMMON) += regulator_common.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_FIXED) += fixed.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
 obj-$(CONFIG_REGULATOR_TPS65090) += tps65090_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_PALMAS) += palmas_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_PBIAS) += pbias_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_LP873X) += lp873x_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_LP87565) += lp87565_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_PALMAS) += palmas_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_PBIAS) += pbias_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_LP873X) += lp873x_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_LP87565) += lp87565_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_DM_REGULATOR_TPS65910) += tps65910_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS65911) += tps65911_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_TPS65911) += tps65911_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS62360) += tps62360_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS6287X) += tps6287x_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_TPS6287X) += tps6287x_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
 obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
 obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
-obj-$(CONFIG_$(SPL_)DM_REGULATOR_ANATOP) += anatop_regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e09ed1aa4d4..801b0965e4f 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -4,7 +4,7 @@
 # Texas Instruments Incorporated - https://www.ti.com/
 #
 
-obj-$(CONFIG_$(SPL_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
+obj-$(CONFIG_$(XPL_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
 
 # Remote proc drivers - Please keep this list alphabetically sorted.
 obj-$(CONFIG_K3_SYSTEM_CONTROLLER) += k3_system_controller.o
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 66bd30b837b..1c0b013eb1f 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -11,7 +11,7 @@ endif
 
 obj-$(CONFIG_PL01X_SERIAL) += serial_pl01x.o
 obj-$(CONFIG_PL011_SERIAL) += serial_pl01x.o
-obj-$(CONFIG_$(SPL_)SYS_NS16550_SERIAL) += serial_ns16550.o
+obj-$(CONFIG_$(XPL_)SYS_NS16550_SERIAL) += serial_ns16550.o
 
 obj-$(CONFIG_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_ALTERA_JTAG_UART) += altera_jtag_uart.o
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index fec4af392e6..7a847e8388b 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -5,14 +5,14 @@
 obj-y += timer-uclass.o
 obj-$(CONFIG_ADI_SC5XX_TIMER) += adi_sc5xx_timer.o
 obj-$(CONFIG_ALTERA_TIMER)	+= altera_timer.o
-obj-$(CONFIG_$(SPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
+obj-$(CONFIG_$(XPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
 obj-$(CONFIG_ARC_TIMER)	+= arc_timer.o
 obj-$(CONFIG_ARM_TWD_TIMER)	+= arm_twd_timer.o
 obj-$(CONFIG_AST_TIMER)	+= ast_timer.o
 obj-$(CONFIG_AST_IBEX_TIMER)	+= ast_ibex_timer.o
 obj-$(CONFIG_ATCPIT100_TIMER) += atcpit100_timer.o
-obj-$(CONFIG_$(SPL_)ATMEL_PIT_TIMER) += atmel_pit_timer.o
-obj-$(CONFIG_$(SPL_)ATMEL_TCB_TIMER) += atmel_tcb_timer.o
+obj-$(CONFIG_$(XPL_)ATMEL_PIT_TIMER) += atmel_pit_timer.o
+obj-$(CONFIG_$(XPL_)ATMEL_TCB_TIMER) += atmel_tcb_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence-ttc.o
 obj-$(CONFIG_DESIGNWARE_APB_TIMER)	+= dw-apb-timer.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= fttmr010_timer.o
@@ -27,7 +27,7 @@ obj-$(CONFIG_RISCV_TIMER) += riscv_timer.o
 obj-$(CONFIG_ROCKCHIP_TIMER) += rockchip_timer.o
 obj-$(CONFIG_SANDBOX_TIMER)	+= sandbox_timer.o
 obj-$(CONFIG_SP804_TIMER)	+= sp804_timer.o
-obj-$(CONFIG_$(SPL_)RISCV_ACLINT) += riscv_aclint_timer.o
+obj-$(CONFIG_$(XPL_)RISCV_ACLINT) += riscv_aclint_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)	+= arm_global_timer.o
 obj-$(CONFIG_STM32_TIMER)	+= stm32_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra-timer.o
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 18d7190755d..d6047856091 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -4,8 +4,8 @@ cdns3-y					:= core.o drd.o
 
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 
-cdns3-$(CONFIG_$(SPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
+cdns3-$(CONFIG_$(XPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
 
-cdns3-$(CONFIG_$(SPL_)USB_CDNS3_HOST)	+= host.o
+cdns3-$(CONFIG_$(XPL_)USB_CDNS3_HOST)	+= host.o
 
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 2e9353b76a6..11cc4657a0f 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2016 Freescale Semiconductor, Inc.
 #
 
-obj-$(CONFIG_$(SPL_)DM_USB) += common.o
+obj-$(CONFIG_$(XPL_)DM_USB) += common.o
 obj-$(CONFIG_USB_ISP1760) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index a46b6824ab7..a085c9d4628 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -6,11 +6,11 @@ dwc3-y					:= core.o
 
 obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
 
-obj-$(CONFIG_$(SPL_)USB_DWC3_AM62)	+= dwc3-am62.o
+obj-$(CONFIG_$(XPL_)USB_DWC3_AM62)	+= dwc3-am62.o
 obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
-obj-$(CONFIG_$(SPL_)USB_DWC3_GENERIC)		+= dwc3-generic.o
+obj-$(CONFIG_$(XPL_)USB_DWC3_GENERIC)		+= dwc3-generic.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
 obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 467c566f6d3..4b6a8fdfeee 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -2,9 +2,9 @@
 #
 # USB peripheral controller drivers
 
-ifndef CONFIG_$(SPL_)DM_USB_GADGET
+ifndef CONFIG_$(XPL_)DM_USB_GADGET
 obj-$(CONFIG_USB_DWC3_GADGET)	+= udc-core.o
 endif
 
-obj-$(CONFIG_$(SPL_)DM_USB_GADGET)	+= udc-core.o
+obj-$(CONFIG_$(XPL_)DM_USB_GADGET)	+= udc-core.o
 obj-y += udc-uclass.o
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 8dad36f9369..07deb4fadd6 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_$(SPL_)DM_USB
+ifdef CONFIG_$(XPL_)DM_USB
 obj-y += usb-uclass.o
 obj-$(CONFIG_SANDBOX) += usb-sandbox.o
 endif
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f3f70cd04a1..93fed8c491a 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -34,7 +34,7 @@ obj-${CONFIG_EXYNOS_FB} += exynos/
 obj-${CONFIG_VIDEO_ROCKCHIP} += rockchip/
 obj-${CONFIG_VIDEO_STM32} += stm32/
 obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
-obj-${CONFIG_$(SPL_)VIDEO_TIDSS} += tidss/
+obj-${CONFIG_$(XPL_)VIDEO_TIDSS} += tidss/
 obj-y += ti/
 
 obj-$(CONFIG_ATMEL_HLCD) += atmel_hlcdfb.o
diff --git a/drivers/video/tidss/Makefile b/drivers/video/tidss/Makefile
index a29cee2a414..f0cbe1d4ed1 100644
--- a/drivers/video/tidss/Makefile
+++ b/drivers/video/tidss/Makefile
@@ -9,4 +9,4 @@
 # Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 
-obj-${CONFIG_$(SPL_)VIDEO_TIDSS} = tidss_drv.o
+obj-${CONFIG_$(XPL_)VIDEO_TIDSS} = tidss_drv.o
diff --git a/fs/fat/Makefile b/fs/fat/Makefile
index f84efaccc75..7414b3602aa 100644
--- a/fs/fat/Makefile
+++ b/fs/fat/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-$(CONFIG_$(SPL_)FS_FAT) = fat.o
-obj-$(CONFIG_$(SPL_)FAT_WRITE) = fat_write.o
+obj-$(CONFIG_$(XPL_)FS_FAT) = fat.o
+obj-$(CONFIG_$(XPL_)FAT_WRITE) = fat_write.o
diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index ba66ee821c2..0772e1a497d 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-$(CONFIG_$(SPL_)FS_SQUASHFS) = sqfs.o \
+obj-$(CONFIG_$(XPL_)FS_SQUASHFS) = sqfs.o \
 				sqfs_inode.o \
 				sqfs_dir.o \
 				sqfs_decompressor.o
diff --git a/lib/Makefile b/lib/Makefile
index 66f84408aae..139476a4a23 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -71,25 +71,25 @@ obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
 obj-y += crypto/
 
 obj-$(CONFIG_$(SPL_TPL_)ACPI) += acpi/
-obj-$(CONFIG_$(SPL_)MD5) += md5.o
+obj-$(CONFIG_$(XPL_)MD5) += md5.o
 obj-$(CONFIG_ECDSA) += ecdsa/
-obj-$(CONFIG_$(SPL_)RSA) += rsa/
+obj-$(CONFIG_$(XPL_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
-obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
-obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
-obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
+obj-$(CONFIG_$(XPL_)SHA1) += sha1.o
+obj-$(CONFIG_$(XPL_)SHA256) += sha256.o
+obj-$(CONFIG_$(XPL_)SHA512) += sha512.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
-obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
+obj-$(CONFIG_$(XPL_)ASN1_DECODER) += asn1_decoder.o
 
-obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
-obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
-obj-$(CONFIG_$(SPL_)GZIP) += gunzip.o
-obj-$(CONFIG_$(SPL_)LZO) += lzo/
-obj-$(CONFIG_$(SPL_)LZMA) += lzma/
-obj-$(CONFIG_$(SPL_)LZ4) += lz4_wrapper.o
+obj-$(CONFIG_$(XPL_)ZLIB) += zlib/
+obj-$(CONFIG_$(XPL_)ZSTD) += zstd/
+obj-$(CONFIG_$(XPL_)GZIP) += gunzip.o
+obj-$(CONFIG_$(XPL_)LZO) += lzo/
+obj-$(CONFIG_$(XPL_)LZMA) += lzma/
+obj-$(CONFIG_$(XPL_)LZ4) += lz4_wrapper.o
 
-obj-$(CONFIG_$(SPL_)LIB_RATIONAL) += rational.o
+obj-$(CONFIG_$(XPL_)LIB_RATIONAL) += rational.o
 
 obj-$(CONFIG_LIBAVB) += libavb/
 
@@ -144,7 +144,7 @@ else
 obj-y += vsprintf.o strto.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 endif
-obj-$(CONFIG_$(SPL_)OID_REGISTRY) += oid_registry.o
+obj-$(CONFIG_$(XPL_)OID_REGISTRY) += oid_registry.o
 
 obj-y += abuf.o
 obj-y += alist.o
diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
index cc2868488a0..99be19adb4c 100644
--- a/lib/acpi/Makefile
+++ b/lib/acpi/Makefile
@@ -5,10 +5,10 @@ obj-y += acpi.o
 
 ifdef CONFIG_$(SPL_TPL_)GENERATE_ACPI_TABLE
 
-obj-$(CONFIG_$(SPL_)ACPIGEN) += acpigen.o
-obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_device.o
-obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_dp.o
-obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_table.o
+obj-$(CONFIG_$(XPL_)ACPIGEN) += acpigen.o
+obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_device.o
+obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_dp.o
+obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_table.o
 obj-y += acpi_writer.o
 
 # With QEMU the ACPI tables come from there, not from U-Boot
diff --git a/lib/aes/Makefile b/lib/aes/Makefile
index daed52a713b..ad6228a7dad 100644
--- a/lib/aes/Makefile
+++ b/lib/aes/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright (c) 2019, Softathome
 
-obj-$(CONFIG_$(SPL_)FIT_CIPHER) += aes-decrypt.o
+obj-$(CONFIG_$(XPL_)FIT_CIPHER) += aes-decrypt.o
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 3259c951241..de1510d3eb5 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -3,16 +3,16 @@
 # Makefile for asymmetric cryptographic keys
 #
 
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
+obj-$(CONFIG_$(XPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
 
 asymmetric_keys-y := asymmetric_type.o
 
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
 
 #
 # RSA public key parser
 #
-obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += rsa_public_key.o
+obj-$(CONFIG_$(XPL_)RSA_PUBLIC_KEY_PARSER) += rsa_public_key.o
 rsa_public_key-y := \
 	rsapubkey.asn1.o \
 	rsa_helper.o
@@ -30,7 +30,7 @@ endif
 #
 # X.509 Certificate handling
 #
-obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
+obj-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
 x509_key_parser-y := \
 	x509.asn1.o \
 	x509_akid.asn1.o \
@@ -47,11 +47,11 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 #
 # PKCS#7 message handling
 #
-obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
+obj-$(CONFIG_$(XPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := \
 	pkcs7.asn1.o \
 	pkcs7_parser.o
-obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
+obj-$(CONFIG_$(XPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
 $(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
@@ -59,7 +59,7 @@ $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
 #
 # Signed PE binary-wrapped key handling
 #
-obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
+obj-$(CONFIG_$(XPL_)MSCODE_PARSER) += mscode.o
 
 mscode-y := \
 	mscode_parser.o \
diff --git a/lib/ecdsa/Makefile b/lib/ecdsa/Makefile
index 771d6d3135b..32b6183f6ff 100644
--- a/lib/ecdsa/Makefile
+++ b/lib/ecdsa/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_$(SPL_)ECDSA_VERIFY) += ecdsa-verify.o
+obj-$(CONFIG_$(XPL_)ECDSA_VERIFY) += ecdsa-verify.o
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..a1d37855593 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -10,14 +10,14 @@ obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_CMD_DNS)  += dns.o
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
-obj-$(CONFIG_$(SPL_)DM_ETH) += eth-uclass.o
+obj-$(CONFIG_$(XPL_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
-obj-$(CONFIG_$(SPL_)DM_ETH) += eth_common.o
+obj-$(CONFIG_$(XPL_)DM_ETH) += eth_common.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
-obj-$(CONFIG_$(SPL_)DM_ETH) += net.o
+obj-$(CONFIG_$(XPL_)DM_ETH) += net.o
 obj-$(CONFIG_IPV6)     += net6.o
 obj-$(CONFIG_CMD_NFS)  += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b70b75ee68d..1a6b28feedf 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -325,7 +325,7 @@ endif
 .SECONDARY:
 
 ifdef CONFIG_XPL_BUILD
-SPL_ := SPL_
+XPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
 SPL_TPL_ := VPL_
 else
@@ -336,6 +336,6 @@ SPL_TPL_ := SPL_
 endif
 endif
 else
-SPL_ :=
+XPL_ :=
 SPL_TPL_ :=
 endif
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index b43ff998679..11ae93f8556 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -59,7 +59,7 @@ endif
 export SPL_NAME
 
 ifdef CONFIG_XPL_BUILD
-SPL_ := SPL_
+XPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
 SPL_TPL_ := VPL_
 else
@@ -70,7 +70,7 @@ SPL_TPL_ := SPL_
 endif
 endif
 else
-SPL_ :=
+XPL_ :=
 SPL_TPL_ :=
 endif
 
diff --git a/test/Makefile b/test/Makefile
index f801d87e385..145c952d2c3 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -4,24 +4,24 @@
 
 obj-y += test-main.o
 
-ifneq ($(CONFIG_$(SPL_)BLOBLIST),)
-obj-$(CONFIG_$(SPL_)CMDLINE) += bloblist.o
-obj-$(CONFIG_$(SPL_)CMDLINE) += bootm.o
+ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
 endif
-obj-$(CONFIG_$(SPL_)CMDLINE) += cmd/
-obj-$(CONFIG_$(SPL_)CMDLINE) += cmd_ut.o
-obj-$(CONFIG_$(SPL_)CMDLINE) += command_ut.o
-obj-$(CONFIG_$(SPL_)UT_COMPRESSION) += compression.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
+obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
+obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
 obj-$(CONFIG_UNIT_TEST) += lib/
 endif
 ifneq ($(CONFIG_HUSH_PARSER),)
-obj-$(CONFIG_$(SPL_)CMDLINE) += hush/
+obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_$(SPL_)CMDLINE) += print_ut.o
-obj-$(CONFIG_$(SPL_)CMDLINE) += str_ut.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += print_ut.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
@@ -29,7 +29,7 @@ ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
-obj-$(CONFIG_$(SPL_)UT_UNICODE) += unicode_ut.o
+obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode_ut.o
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
 endif
diff --git a/test/fuzz/Makefile b/test/fuzz/Makefile
index 663b79ce80b..8a135b65e4b 100644
--- a/test/fuzz/Makefile
+++ b/test/fuzz/Makefile
@@ -4,5 +4,5 @@
 # Written by Andrew Scull <ascull@google.com>
 #
 
-obj-$(CONFIG_$(SPL_)CMDLINE) += cmd_fuzz.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_fuzz.o
 obj-$(CONFIG_VIRTIO_SANDBOX) += virtio.o
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 71e911eeb3b..e025f560928 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1220,8 +1220,8 @@ def scan_makefiles(fnames):
 
     >>> RE_MK_CONFIGS.search('CONFIG_FRED').groups()
     (None, 'FRED')
-    >>> RE_MK_CONFIGS.search('CONFIG_$(SPL_)MARY').groups()
-    ('$(SPL_)', 'MARY')
+    >>> RE_MK_CONFIGS.search('CONFIG_$(XPL_)MARY').groups()
+    ('$(XPL_)', 'MARY')
     >>> RE_MK_CONFIGS.search('CONFIG_$(SPL_TPL_)MARY').groups()
     ('$(SPL_TPL_)', 'MARY')
     """
@@ -1321,7 +1321,7 @@ def do_scan_source(path, do_update):
             spl_mode (int): If MODE_SPL, look at source code which implies
                 an SPL_ option, but for which there is none;
                 for MOD_PROPER, look at source code which implies a Proper
-                option (i.e. use of CONFIG_IS_ENABLED() or $(SPL_) or
+                option (i.e. use of CONFIG_IS_ENABLED() or $(XPL_) or
                 $(SPL_TPL_) but for which there none;
                 if MODE_NORMAL, ignore SPL
 
-- 
2.43.0

