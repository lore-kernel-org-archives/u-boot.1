Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB6CC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 20:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE72805C3;
	Tue,  4 Mar 2025 21:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKTRTj9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8122C80805; Tue,  4 Mar 2025 21:42:25 +0100 (CET)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30DD800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 21:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-6fd65f1d262so27591567b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741120880; x=1741725680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x/IlooRqGYppi9ceipFGTgCqc/L76kjLnRPpLIi5yjw=;
 b=kKTRTj9bHLbS2puw/m+hxuFOrThbl6qUlZtO7+SRJlFngmBjDbuW56vrvHQdNF7xfK
 gSd2pVi6mziE/VwPrZdPfziCvCyN5YzlyhYV6CX+cmq+FOhVvjyYcFIRoyxdn/1hVYw+
 tvRjXcdM4g2UrE0z3mWlsYzSK8Elp8B37iQ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741120880; x=1741725680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x/IlooRqGYppi9ceipFGTgCqc/L76kjLnRPpLIi5yjw=;
 b=ibfcoRAgFvkfXqE5IKtR6cSLDHhPQLfHQhFK/Olbs0vvC1tQhDTEPfDRJOLZkcKpCm
 wY9Xb0zXr17qw1RZOVKiXt2DzQKBB+ybcBQvfnSdBnOXoLCqqGvoNpkV1Je0YpnDiU5d
 BwYZOsM3HEJpmlD6SJS91ch6hzsWD/rU9Pfxpd/afhW2xmI6XGLATb0/t3Zvs20KK3/m
 wYs3sH9LBA2Qb+mYHjhYvF8M8yPWrvI4VJR1ZqWgC++Pr6dp/wY3OMwqprnfjLfpaQ00
 18wXQIyNuK2fVM9/T5iwEGaaisk3pOB3GAO49P07XheD42SG7IrNd/AxC+O/OeFlBAws
 9M/Q==
X-Gm-Message-State: AOJu0Yx83jD9nWQ4a1RRqayf8yA1oHbqWe9DQQIR51PCCpkK9cKB38Ha
 P/cujUr5sRbodamBx0igDfU2dfq6jkIjPIAm76SIIfbbYcTx0U7rDs+g3nSWTPfH9XHlxzog0VS
 B
X-Gm-Gg: ASbGncshjOkExu3u/gZdJAS6pDHKbYaTml7Gv4uH+4su21vJ7mfgNSFQVaCDcWqx3Ky
 bYE6IHNa/fGrB7ft++94ILWqu6ZfbkzkFa9IAosc8dDfUilpxH0SqTxM50iKKrvkc6UU3FbarMC
 G4Z5q1a7+jTWFUmdV53DVWKW4d+/4XtOfDH6PVV9u6IUxRrcMgcC/YdDGSIf8WuDra28lxElox1
 +4Kh4A5ri+u8eJsLTjCiWoGJDp+Sk1J+QLKOK6GqxqP4GfXWyiAO3coIZbqoUy25jLKizNEQQtG
 NH8OceetSuqLUPRADMfBoR2YbIbpXpc7WHQiDlagqg/Dug==
X-Google-Smtp-Source: AGHT+IHIjLbjW4tB+frIpUck9uwMKXXk6LpHoc1zMd4WeHsRrJY3pRFVy9bO+z5EkGX5b7EcLPMn/Q==
X-Received: by 2002:a05:690c:30e:b0:6f9:4bb6:eb46 with SMTP id
 00721157ae682-6fda30f2c8cmr11597107b3.31.1741120879251; 
 Tue, 04 Mar 2025 12:41:19 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cba094csm26062487b3.115.2025.03.04.12.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 12:41:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH] Kbuild: Always use $(PHASE_)
Date: Tue,  4 Mar 2025 14:41:14 -0600
Message-ID: <20250304204116.2834889-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in our
Makefiles as part of the macros to determine when to do something in our
Makefiles based on what phase of the build we are in. For consistency,
bring this down to a single macro and use "$(PHASE_)" only.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

This leads a little bit of dead code in scripts/Makefile.xpl that I
didn't remove as this is an RFC. This also omits expanding on our build
documentation slightly.

With the following patches applied (which are correct regardless of this
RFC and so separate):
https://patchwork.ozlabs.org/project/uboot/patch/20250304203235.2834031-1-trini@konsulko.com/
https://patchwork.ozlabs.org/project/uboot/patch/20250304202436.2783784-1-trini@konsulko.com/

There's no change in the resulting build before/after this patch.

We could do the other direction and drop $(PHASE_) in favour of $(XPL_)
but that would require updating the logic of how XPL_ is defined.

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
 arch/sandbox/lib/Makefile               |  2 +-
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
 drivers/dfu/Makefile                    | 18 +++++-----
 drivers/firmware/Makefile               |  2 +-
 drivers/gpio/Makefile                   | 10 +++---
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
 lib/Makefile                            | 10 +++---
 lib/acpi/Makefile                       |  8 ++---
 lib/aes/Makefile                        |  2 +-
 lib/crypto/Makefile                     | 20 +++++------
 lib/ecdsa/Makefile                      |  2 +-
 lib/lwip/Makefile                       |  2 +-
 lib/mbedtls/Makefile                    | 38 ++++++++++----------
 net/Makefile                            |  6 ++--
 net/lwip/Makefile                       |  2 +-
 test/Makefile                           |  6 ++--
 test/boot/Makefile                      |  2 +-
 test/cmd/Makefile                       |  2 +-
 test/common/Makefile                    |  6 ++--
 test/fuzz/Makefile                      |  2 +-
 test/lib/Makefile                       |  4 +--
 tools/qconfig.py                        |  4 +--
 87 files changed, 230 insertions(+), 232 deletions(-)

diff --git a/Makefile b/Makefile
index 5f90cea11d70..9961970e1aa3 100644
--- a/Makefile
+++ b/Makefile
@@ -835,7 +835,7 @@ UBOOTINCLUDE    := \
 		-I$(srctree)/lib/mbedtls/port \
 		-I$(srctree)/lib/mbedtls/external/mbedtls \
 		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
-	$(if $(CONFIG_$(XPL_)SYS_THUMB_BUILD), \
+	$(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
 			$(if $(CONFIG_CPU_V7M), \
 				-I$(srctree)/arch/arm/thumb1/include), \
@@ -872,7 +872,7 @@ libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
 libs-$(CONFIG_SYS_FSL_MMDC) += drivers/ddr/fsl/
-libs-$(CONFIG_$(XPL_)ALTERA_SDRAM) += drivers/ddr/altera/
+libs-$(CONFIG_$(PHASE_)ALTERA_SDRAM) += drivers/ddr/altera/
 libs-y += drivers/usb/cdns3/
 libs-y += drivers/usb/dwc3/
 libs-y += drivers/usb/common/
diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index e0045e222713..6e725ba1081a 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -40,7 +40,7 @@ PLATFORM_ELFFLAGS += -B arm -O elf32-littlearm
 endif
 
 # Choose between ARM/Thumb instruction sets
-ifeq ($(CONFIG_$(XPL_)SYS_THUMB_BUILD),y)
+ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
 AFLAGS_IMPLICIT_IT	:= $(call as-option,-Wa$(comma)-mimplicit-it=always)
 PF_CPPFLAGS_ARM		:= $(AFLAGS_IMPLICIT_IT) \
 			$(call cc-option, -mthumb -mthumb-interwork,\
@@ -53,7 +53,7 @@ PF_CPPFLAGS_ARM := $(call cc-option,-marm,) \
 endif
 
 # Only test once
-ifeq ($(CONFIG_$(XPL_)SYS_THUMB_BUILD),y)
+ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
 archprepare: checkthumb checkgcc6
 
 checkthumb:
@@ -116,7 +116,7 @@ LDFLAGS_u-boot += -pie
 #
 # http://sourceware.org/bugzilla/show_bug.cgi?id=12532
 #
-ifeq ($(CONFIG_$(XPL_)SYS_THUMB_BUILD),y)
+ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
 ifeq ($(GAS_BUG_12532),)
 export GAS_BUG_12532:=$(shell if [ $(call binutils-version) -lt 0222 ] ; \
 	then echo y; else echo n; fi)
diff --git a/arch/arm/cpu/arm920t/Makefile b/arch/arm/cpu/arm920t/Makefile
index 06456fe5a813..9929b5ab878c 100644
--- a/arch/arm/cpu/arm920t/Makefile
+++ b/arch/arm/cpu/arm920t/Makefile
@@ -9,6 +9,6 @@ obj-y	+= cpu.o
 
 # some files can only build in ARM mode
 
-ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 CFLAGS_cpu.o := -marm
 endif
diff --git a/arch/arm/cpu/arm926ejs/Makefile b/arch/arm/cpu/arm926ejs/Makefile
index 750cb94dc6e6..41d8af506d89 100644
--- a/arch/arm/cpu/arm926ejs/Makefile
+++ b/arch/arm/cpu/arm926ejs/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_ARCH_SUNXI) += sunxi/
 
 # some files can only build in ARM or THUMB2, not THUMB1
 
-ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
 CFLAGS_cpu.o := -marm
diff --git a/arch/arm/cpu/armv7/Makefile b/arch/arm/cpu/armv7/Makefile
index 6461f5f5bdef..318a71f24b1d 100644
--- a/arch/arm/cpu/armv7/Makefile
+++ b/arch/arm/cpu/armv7/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_EFI_LOADER) += sctlr.o
 obj-$(CONFIG_ARMV7_NONSEC) += exception_level.o
 endif
 
-ifneq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),y)
+ifneq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),y)
 obj-y	+= lowlevel_init.o
 endif
 
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index b4126c61df15..dd0191a12fac 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -9,7 +9,7 @@ obj-y	+= cpu.o
 ifndef CONFIG_$(PHASE_)TIMER
 obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
 endif
-ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
+ifndef CONFIG_$(PHASE_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
@@ -33,7 +33,7 @@ obj-$(CONFIG_ACPI_PARKING_PROTOCOL) += acpi_park_v8.o
 else
 obj-$(CONFIG_ARCH_SUNXI) += fel_utils.o
 endif
-obj-$(CONFIG_$(XPL_)ARMV8_SEC_FIRMWARE_SUPPORT) += sec_firmware.o sec_firmware_asm.o
+obj-$(CONFIG_$(PHASE_)ARMV8_SEC_FIRMWARE_SUPPORT) += sec_firmware.o sec_firmware_asm.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_RECOVER_DATA_SECTION) += spl_data.o
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed21..99989d60e456 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -96,7 +96,7 @@ endif
 
 # some files can only build in ARM or THUMB2, not THUMB1
 
-ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 asflags-$(CONFIG_HAS_THUMB2) += -DCONFIG_THUMB2_KERNEL
 ifndef CONFIG_HAS_THUMB2
 
diff --git a/arch/arm/mach-at91/arm926ejs/Makefile b/arch/arm/mach-at91/arm926ejs/Makefile
index 8f0bc5d997e6..62c44b997e42 100644
--- a/arch/arm/mach-at91/arm926ejs/Makefile
+++ b/arch/arm/mach-at91/arm926ejs/Makefile
@@ -32,7 +32,7 @@ obj-y	+= lowlevel_init.o
 endif
 endif
 
-ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
 CFLAGS_cache.o := -marm
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 011cca5d975b..8bd85e889abc 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_IMX_RDC) += rdc-sema.o
 ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
 endif
-obj-$(CONFIG_$(XPL_)SATA) += sata.o
+obj-$(CONFIG_$(PHASE_)SATA) += sata.o
 obj-$(CONFIG_IMX_HAB)    += hab.o
 obj-$(CONFIG_SYSCOUNTER_TIMER) += syscounter.o
 endif
diff --git a/arch/arm/mach-omap2/am33xx/Makefile b/arch/arm/mach-omap2/am33xx/Makefile
index 6f3587f01d03..233dcc843931 100644
--- a/arch/arm/mach-omap2/am33xx/Makefile
+++ b/arch/arm/mach-omap2/am33xx/Makefile
@@ -11,7 +11,7 @@ endif
 
 obj-y	+= sys_info.o
 obj-y	+= ddr.o
-ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),)
 obj-y	+= emif4.o
 endif
 obj-y	+= board.o
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 3c381dedaf88..d0769b55efa4 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -11,13 +11,13 @@ obj-y	= cpu.o
 obj-y	+= dram.o
 obj-y	+= timer.o
 
-ifndef CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT
+ifndef CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT
 obj-y	+= lowlevel_init.o
 endif
 
 # some files can only build in ARM or THUMB2, not THUMB1
 
-ifdef CONFIG_$(XPL_)SYS_THUMB_BUILD
+ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2
 
 CFLAGS_cpu.o := -marm
diff --git a/arch/arm/mach-stm32mp/stm32mp1/Makefile b/arch/arm/mach-stm32mp/stm32mp1/Makefile
index db160c24cbcc..0df6dabaaab5 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/Makefile
+++ b/arch/arm/mach-stm32mp/stm32mp1/Makefile
@@ -15,5 +15,5 @@ else
 obj-$(CONFIG_ARMV7_PSCI) += psci.o
 endif
 
-obj-$(CONFIG_$(XPL_)STM32MP15_PWR) += pwr_regulator.o
+obj-$(CONFIG_$(PHASE_)STM32MP15_PWR) += pwr_regulator.o
 obj-$(CONFIG_OF_SYSTEM_SETUP) += fdt.o
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index ebac3473a1fe..2f0341bc02a7 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_TEGRA_GP_PADCTRL) += ap.o
 obj-y += board.o board2.o
 obj-y += cache.o
 obj-$(CONFIG_TEGRA_CLKRST) += clock.o
-obj-$(CONFIG_$(XPL_)TEGRA_CRYPTO) += crypto.o
+obj-$(CONFIG_$(PHASE_)TEGRA_CRYPTO) += crypto.o
 obj-$(CONFIG_TEGRA_PMC) += powergate.o
 obj-y += xusb-padctl-dummy.o
 
diff --git a/arch/arm/mach-tegra/tegra20/Makefile b/arch/arm/mach-tegra/tegra20/Makefile
index 32c1866b099c..a3ea759d7642 100644
--- a/arch/arm/mach-tegra/tegra20/Makefile
+++ b/arch/arm/mach-tegra/tegra20/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2010,2011 Nvidia Corporation.
 
 obj-$(CONFIG_XPL_BUILD) += cpu.o
-obj-$(CONFIG_$(XPL_)CMD_EBTUPDATE) += bct.o
+obj-$(CONFIG_$(PHASE_)CMD_EBTUPDATE) += bct.o
 
 # The AVP is ARMv4T architecture so we must use special compiler
 # flags for any startup files it might use.
diff --git a/arch/arm/mach-tegra/tegra30/Makefile b/arch/arm/mach-tegra/tegra30/Makefile
index b36657a432f5..d6351734ec08 100644
--- a/arch/arm/mach-tegra/tegra30/Makefile
+++ b/arch/arm/mach-tegra/tegra30/Makefile
@@ -3,6 +3,6 @@
 # Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
 
 obj-$(CONFIG_XPL_BUILD) += cpu.o
-obj-$(CONFIG_$(XPL_)CMD_EBTUPDATE) += bct.o
+obj-$(CONFIG_$(PHASE_)CMD_EBTUPDATE) += bct.o
 
 obj-y	+= clock.o
diff --git a/arch/arm/mach-zynqmp/Makefile b/arch/arm/mach-zynqmp/Makefile
index ff4260447970..4bd4014dc15f 100644
--- a/arch/arm/mach-zynqmp/Makefile
+++ b/arch/arm/mach-zynqmp/Makefile
@@ -7,7 +7,7 @@ obj-y	+= aes.o clk.o cpu.o
 obj-$(CONFIG_MP)	+= mp.o
 obj-$(CONFIG_XPL_BUILD) += spl.o handoff.o psu_spl_init.o
 obj-$(CONFIG_SPL_ZYNQMP_DRAM_ECC_INIT) += ecc_spl_init.o
-obj-$(CONFIG_$(XPL_)ZYNQMP_PSU_INIT_ENABLED)	+= psu_spl_init.o
+obj-$(CONFIG_$(PHASE_)ZYNQMP_PSU_INIT_ENABLED)	+= psu_spl_init.o
 
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ZYNQMP) += zynqmp.o
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 4e6f347038df..6f80f4a7108c 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -48,7 +48,7 @@ endif
 ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
 	     -mcmodel=$(CMODEL)
 
-ifeq ($(CONFIG_$(XPL_)FRAMEPOINTER),y)
+ifeq ($(CONFIG_$(PHASE_)FRAMEPOINTER),y)
 	ARCH_FLAGS += -fno-omit-frame-pointer
 endif
 
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 268116f37579..22b675ffe82d 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -11,19 +11,19 @@ obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
-ifeq ($(CONFIG_$(XPL_)RISCV_MMODE),y)
-obj-$(CONFIG_$(XPL_)RISCV_ACLINT) += aclint_ipi.o
+ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
+obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) += aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
 else
 obj-$(CONFIG_SBI) += sbi.o
 obj-$(CONFIG_SBI_IPI) += sbi_ipi.o
 endif
 obj-y	+= interrupts.o
-ifeq ($(CONFIG_$(XPL_)SYSRESET),)
+ifeq ($(CONFIG_$(PHASE_)SYSRESET),)
 obj-y	+= reset.o
 endif
 obj-y   += setjmp.o
-obj-$(CONFIG_$(XPL_)SMP) += smp.o
+obj-$(CONFIG_$(PHASE_)SMP) += smp.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-y   += fdt_fixup.o
 obj-$(CONFIG_$(SPL)CMD_BDI) += bdinfo.o
diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
index 5d7beb250cd8..cefe26d8fc08 100644
--- a/arch/sandbox/lib/Makefile
+++ b/arch/sandbox/lib/Makefile
@@ -9,4 +9,4 @@ obj-y				+= fdt_fixup.o interrupts.o
 obj-$(CONFIG_PCI)		+= pci_io.o
 obj-$(CONFIG_CMD_BOOTM)		+= bootm.o
 obj-$(CONFIG_CMD_BOOTZ)		+= bootm.o
-obj-$(CONFIG_$(SPL_)ACPIGEN)	+= acpi_table.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN)	+= acpi_table.o
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fd409b9f7207..7dc3171cebf8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifeq ($(CONFIG_EFI_APP),)
-ifdef CONFIG_$(XPL_)X86_64
+ifdef CONFIG_$(PHASE_)X86_64
 head-y := arch/x86/cpu/start64.o
 else
 ifeq ($(CONFIG_$(PHASE_)X86_16BIT_INIT),y)
diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index 39c8b0835cc8..cc55c8fa39cd 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -6,7 +6,7 @@
 # (C) Copyright 2002
 # Daniel Engström, Omicron Ceti AB, daniel@omicron.se.
 
-ifeq ($(CONFIG_$(XPL_)X86_64),y)
+ifeq ($(CONFIG_$(PHASE_)X86_64),y)
 extra-y	= start64.o
 else
 ifeq ($(CONFIG_$(PHASE_)X86_16BIT_INIT),y)
@@ -31,7 +31,7 @@ ifndef CONFIG_TPL_BUILD
 obj-y	+= cpu_x86.o
 endif
 
-ifndef CONFIG_$(XPL_)X86_64
+ifndef CONFIG_$(PHASE_)X86_64
 AFLAGS_REMOVE_call32.o := -mregparm=3 \
 	$(if $(CONFIG_EFI_STUB_64BIT),-march=i386 -m32)
 AFLAGS_call32.o := -fpic -fshort-wchar \
@@ -59,18 +59,18 @@ obj-$(CONFIG_QFW) += qfw_cpu.o
 ifndef CONFIG_SYS_COREBOOT
 obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += irq.o
 endif
-ifndef CONFIG_$(XPL_)X86_64
-obj-$(CONFIG_$(XPL_)SMP) += mp_init.o
+ifndef CONFIG_$(PHASE_)X86_64
+obj-$(CONFIG_$(PHASE_)SMP) += mp_init.o
 endif
 obj-y += mtrr.o
 obj-$(CONFIG_PCI) += pci.o
-ifndef CONFIG_$(XPL_)X86_64
+ifndef CONFIG_$(PHASE_)X86_64
 obj-$(CONFIG_SMP) += sipi_vector.o
 endif
 obj-y += turbo.o
 obj-$(CONFIG_HAVE_ACPI_RESUME) += wakeup.o
 
-ifeq ($(CONFIG_$(XPL_)X86_64),y)
+ifeq ($(CONFIG_$(PHASE_)X86_64),y)
 obj-y += x86_64/
 else
 obj-y += i386/
diff --git a/arch/x86/cpu/intel_common/Makefile b/arch/x86/cpu/intel_common/Makefile
index a28e6c77c9cc..3f77f2ba2f16 100644
--- a/arch/x86/cpu/intel_common/Makefile
+++ b/arch/x86/cpu/intel_common/Makefile
@@ -26,10 +26,10 @@ obj-y += cpu.o
 obj-y += fast_spi.o
 obj-y += lpc.o
 obj-y += lpss.o
-obj-$(CONFIG_$(XPL_)INTEL_GENERIC_WIFI) += generic_wifi.o
+obj-$(CONFIG_$(PHASE_)INTEL_GENERIC_WIFI) += generic_wifi.o
 ifndef CONFIG_EFI_APP
 obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += microcode.o
-ifndef CONFIG_$(XPL_)X86_64
+ifndef CONFIG_$(PHASE_)X86_64
 obj-y += microcode.o
 endif
 endif
diff --git a/arch/x86/cpu/ivybridge/Makefile b/arch/x86/cpu/ivybridge/Makefile
index 471ad8d7ebc6..6f6d10a405b0 100644
--- a/arch/x86/cpu/ivybridge/Makefile
+++ b/arch/x86/cpu/ivybridge/Makefile
@@ -5,15 +5,15 @@
 ifdef CONFIG_HAVE_FSP
 obj-y += fsp_configs.o ivybridge.o
 else
-obj-$(CONFIG_$(XPL_)X86_32BIT_INIT) += cpu.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += cpu.o
 obj-y += early_me.o
 obj-y += lpc.o
 obj-y += northbridge.o
 ifndef CONFIG_XPL_BUILD
 obj-y += sata.o
 endif
-obj-$(CONFIG_$(XPL_)X86_32BIT_INIT) += sdram.o
-ifndef CONFIG_$(XPL_)X86_32BIT_INIT
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += sdram.o
+ifndef CONFIG_$(PHASE_)X86_32BIT_INIT
 obj-y += sdram_nop.o
 endif
 endif
diff --git a/arch/x86/cpu/qemu/Makefile b/arch/x86/cpu/qemu/Makefile
index 1439916ac2d4..2134b0d8654c 100644
--- a/arch/x86/cpu/qemu/Makefile
+++ b/arch/x86/cpu/qemu/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
 
-ifndef CONFIG_$(XPL_)X86_64
+ifndef CONFIG_$(PHASE_)X86_64
 obj-y += car.o
 endif
 obj-y += dram.o
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 43e6a1de77d9..c60a479cc7da 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -19,7 +19,7 @@ ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 endif
 obj-y	+= cmd_boot.o
-obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO)	+= coreboot/
+obj-$(CONFIG_$(PHASE_)COREBOOT_SYSINFO)	+= coreboot/
 obj-$(CONFIG_SEABIOS) += coreboot_table.o
 obj-y	+= early_cmos.o
 obj-y	+= e820.o
@@ -90,7 +90,7 @@ endif
 
 ifdef CONFIG_EFI_STUB
 
-ifeq ($(CONFIG_$(XPL_)X86_64),)
+ifeq ($(CONFIG_$(PHASE_)X86_64),)
 extra-y += $(EFI_CRT0) $(EFI_RELOC)
 endif
 
diff --git a/board/bosch/guardian/Makefile b/board/bosch/guardian/Makefile
index 8e38881ec2c6..87c34c730415 100644
--- a/board/bosch/guardian/Makefile
+++ b/board/bosch/guardian/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2018 Robert Bosch Power Tools GmbH
 #
 
-ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index 468a06725c1e..b04e19e94282 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_FSL_NGPIXIS)	+= ngpixis.o
 endif
 obj-$(I2C_COMMON)		+= i2c_common.o
 obj-$(CONFIG_FSL_USE_PCA9547_MUX)		+= i2c_mux.o
-obj-$(CONFIG_$(XPL_)VID)	+= vid.o
+obj-$(CONFIG_$(PHASE_)VID)	+= vid.o
 obj-$(CONFIG_FSL_QIXIS)	+= qixis.o
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ID_EEPROM)	+= sys_eeprom.o
@@ -54,7 +54,7 @@ obj-$(CONFIG_TARGET_MPC8548CDS)	+= cds_pci_ft.o
 obj-$(CONFIG_TARGET_P3041DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P4080DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P5040DS)		+= ics307_clk.o
-ifeq ($(CONFIG_$(XPL_)POWER_LEGACY),y)
+ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
 obj-$(CONFIG_DM_PMIC_PFUZE100)	+= pfuze.o
diff --git a/board/st/common/Makefile b/board/st/common/Makefile
index fda48d2ff992..122b13c3aa8d 100644
--- a/board/st/common/Makefile
+++ b/board/st/common/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 
 ifeq ($(CONFIG_ARCH_STM32MP),y)
 obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
-obj-$(CONFIG_$(XPL_)DFU_VIRT) += stm32mp_dfu_virt.o
+obj-$(CONFIG_$(PHASE_)DFU_VIRT) += stm32mp_dfu_virt.o
 endif
 
 obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o
diff --git a/board/tcl/sl50/Makefile b/board/tcl/sl50/Makefile
index 1502990174b6..399e8cb0da67 100644
--- a/board/tcl/sl50/Makefile
+++ b/board/tcl/sl50/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2015 Toby Churchill Ltd - http://www.toby-churchill.com/
 
-ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/ti/am335x/Makefile b/board/ti/am335x/Makefile
index 6ef87c22eaa8..7df62fadb7fe 100644
--- a/board/ti/am335x/Makefile
+++ b/board/ti/am335x/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/ti/am43xx/Makefile b/board/ti/am43xx/Makefile
index 5b7b5b371a47..800157deaf39 100644
--- a/board/ti/am43xx/Makefile
+++ b/board/ti/am43xx/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
 
-ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/vscom/baltos/Makefile b/board/vscom/baltos/Makefile
index 6ef87c22eaa8..7df62fadb7fe 100644
--- a/board/vscom/baltos/Makefile
+++ b/board/vscom/baltos/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifeq ($(CONFIG_$(XPL_)SKIP_LOWLEVEL_INIT),)
+ifeq ($(CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT),)
 obj-y	:= mux.o
 endif
 
diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 6476f20eb837..5b2b6e1f33ca 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -31,7 +31,7 @@ $(warning Put custom psu_init_gpl.c/h to board/xilinx/zynqmp/custom_hw_platform/
 endif
 endif
 
-obj-$(CONFIG_$(XPL_)ZYNQMP_PSU_INIT_ENABLED) += $(init-objs)
+obj-$(CONFIG_$(PHASE_)ZYNQMP_PSU_INIT_ENABLED) += $(init-objs)
 
 ifdef CONFIG_XPL_BUILD
 ifneq ($(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE),"")
diff --git a/boot/Makefile b/boot/Makefile
index 34bac26c4e2d..71dafaefa76b 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_$(PHASE_)UPL_WRITE) += upl_write.o
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(PHASE_)FIT_SIGNATURE) += fdt_region.o
 obj-$(CONFIG_$(PHASE_)FIT) += image-fit.o
-obj-$(CONFIG_$(XPL_)MULTI_DTB_FIT) += boot_fit.o common_fit.o
+obj-$(CONFIG_$(PHASE_)MULTI_DTB_FIT) += boot_fit.o common_fit.o
 obj-$(CONFIG_$(PHASE_)IMAGE_PRE_LOAD) += image-pre-load.o
 obj-$(CONFIG_$(PHASE_)IMAGE_SIGN_INFO) += image-sig.o
 obj-$(CONFIG_$(PHASE_)FIT_SIGNATURE) += image-fit-sig.o
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb0..e43234e290cc 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -256,7 +256,7 @@ obj-$(CONFIG_ARCH_K3) += ti/
 obj-$(CONFIG_ARCH_OMAP2PLUS) += ti/
 endif # !CONFIG_XPL_BUILD
 
-obj-$(CONFIG_$(XPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
+obj-$(CONFIG_$(PHASE_)CMD_TLV_EEPROM) += tlv_eeprom.o
 
 obj-$(CONFIG_CMD_BCM_EXT_UTILS) += broadcom/
 
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 5f3c43d5da24..7657ea9ddb10 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -309,15 +309,15 @@ an #ifdef since the suite will automatically be compiled out in that case.
 Finally, add the test to the build by adding to the Makefile in the same
 directory::
 
-  obj-$(CONFIG_$(XPL_)CMDLINE) += wibble.o
+  obj-$(CONFIG_$(PHASE_)CMDLINE) += wibble.o
 
 Note that CMDLINE is never enabled in SPL, so this test will only be present in
 U-Boot proper. See below for how to do SPL tests.
 
 You can add an extra Kconfig check if needed::
 
-  ifneq ($(CONFIG_$(XPL_)WIBBLE),)
-  obj-$(CONFIG_$(XPL_)CMDLINE) += wibble.o
+  ifneq ($(CONFIG_$(PHASE_)WIBBLE),)
+  obj-$(CONFIG_$(PHASE_)CMDLINE) += wibble.o
   endif
 
 Each suite can have an optional init and uninit function. These are run before
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b8..3c0ad17138f0 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -34,15 +34,15 @@ obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
 obj-$(CONFIG_$(PHASE_)SPI) += spi/
 obj-$(CONFIG_$(PHASE_)TIMER) += timer/
 obj-$(CONFIG_$(PHASE_)VIRTIO) += virtio/
-obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox/
-obj-$(CONFIG_$(XPL_)REMOTEPROC) += remoteproc/
-obj-$(CONFIG_$(XPL_)SYSINFO) += sysinfo/
+obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox/
+obj-$(CONFIG_$(PHASE_)REMOTEPROC) += remoteproc/
+obj-$(CONFIG_$(PHASE_)SYSINFO) += sysinfo/
 obj-$(CONFIG_$(PHASE_)SM) += sm/
 obj-$(CONFIG_$(PHASE_)TPM) += tpm/
-obj-$(CONFIG_$(XPL_)NVME) += nvme/
+obj-$(CONFIG_$(PHASE_)NVME) += nvme/
 obj-$(CONFIG_XEN) += xen/
-obj-$(CONFIG_$(XPL_)FPGA) += fpga/
-obj-$(CONFIG_$(XPL_)VIDEO) += video/
+obj-$(CONFIG_$(PHASE_)FPGA) += fpga/
+obj-$(CONFIG_$(PHASE_)VIDEO) += video/
 
 obj-y += bus/
 
@@ -55,7 +55,7 @@ obj-$(CONFIG_SPL_CRYPTO) += crypto/
 obj-$(CONFIG_SPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 obj-$(CONFIG_ARMADA_38X) += ddr/marvell/a38x/
 obj-$(CONFIG_ARMADA_XP) += ddr/marvell/axp/
-obj-$(CONFIG_$(XPL_)ALTERA_SDRAM) += ddr/altera/
+obj-$(CONFIG_$(PHASE_)ALTERA_SDRAM) += ddr/altera/
 obj-$(CONFIG_ARCH_IMX8M) += ddr/imx/imx8m/
 obj-$(CONFIG_IMX8ULP_DRAM) += ddr/imx/imx8ulp/
 obj-$(CONFIG_ARCH_IMX9) += ddr/imx/imx9/
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 69fa9b707e01..20e33f2f27ac 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_DWC_AHCI) += dwc_ahci.o
 obj-$(CONFIG_AHCI) += ahci-uclass.o
-obj-$(CONFIG_$(XPL_)AHCI_PCI) += ahci-pci.o
+obj-$(CONFIG_$(PHASE_)AHCI_PCI) += ahci-pci.o
 obj-$(CONFIG_SCSI_AHCI) += ahci.o
 obj-$(CONFIG_DWC_AHSATA) += dwc_ahsata.o
 obj-$(CONFIG_FSL_SATA) += fsl_sata.o
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index ee2906205453..f5a9d8637a3c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_$(PHASE_)BLK) += blk-uclass.o
 
-ifndef CONFIG_$(XPL_)BLK
+ifndef CONFIG_$(PHASE_)BLK
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
 endif
 
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 7daf82472476..2d242bc2886b 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
 
-obj-$(CONFIG_$(XPL_)TI_SYSC)	+= ti-sysc.o
+obj-$(CONFIG_$(PHASE_)TI_SYSC)	+= ti-sysc.o
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index 9ea57911f89d..5fb5b519a30e 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -6,16 +6,16 @@ obj-y	+= device.o fdtaddr.o lists.o root.o uclass.o util.o tag.o
 obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
 obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
 obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)	+= device-remove.o
-obj-$(CONFIG_$(XPL_)SIMPLE_BUS)	+= simple-bus.o
+obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)	+= simple-bus.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
 obj-$(CONFIG_$(PHASE_)REGMAP)	+= regmap.o
 obj-$(CONFIG_$(PHASE_)SYSCON)	+= syscon-uclass.o
-obj-$(CONFIG_$(XPL_)OF_LIVE) += of_access.o of_addr.o
+obj-$(CONFIG_$(PHASE_)OF_LIVE) += of_access.o of_addr.o
 ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
 endif
-obj-$(CONFIG_$(XPL_)OF_PLATDATA) += read.o
+obj-$(CONFIG_$(PHASE_)OF_PLATDATA) += read.o
 obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o
 
 ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index b19f36018135..c627f16711e7 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -6,7 +6,7 @@
 # (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
 # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
 
-ifdef CONFIG_$(XPL_)ALTERA_SDRAM
+ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
 obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
diff --git a/drivers/dfu/Makefile b/drivers/dfu/Makefile
index 6e1ab1c2ea55..eb4ae5e20749 100644
--- a/drivers/dfu/Makefile
+++ b/drivers/dfu/Makefile
@@ -3,12 +3,12 @@
 # Copyright (C) 2012 Samsung Electronics
 # Lukasz Majewski <l.majewski@samsung.com>
 
-obj-$(CONFIG_$(XPL_)DFU) += dfu.o
-obj-$(CONFIG_$(XPL_)DFU_MMC) += dfu_mmc.o
-obj-$(CONFIG_$(XPL_)DFU_MTD) += dfu_mtd.o
-obj-$(CONFIG_$(XPL_)DFU_NAND) += dfu_nand.o
-obj-$(CONFIG_$(XPL_)DFU_RAM) += dfu_ram.o
-obj-$(CONFIG_$(XPL_)DFU_SF) += dfu_sf.o
-obj-$(CONFIG_$(XPL_)DFU_WRITE_ALT) += dfu_alt.o
-obj-$(CONFIG_$(XPL_)DFU_VIRT) += dfu_virt.o
-obj-$(CONFIG_$(XPL_)DFU_SCSI) += dfu_scsi.o
+obj-$(CONFIG_$(PHASE_)DFU) += dfu.o
+obj-$(CONFIG_$(PHASE_)DFU_MMC) += dfu_mmc.o
+obj-$(CONFIG_$(PHASE_)DFU_MTD) += dfu_mtd.o
+obj-$(CONFIG_$(PHASE_)DFU_NAND) += dfu_nand.o
+obj-$(CONFIG_$(PHASE_)DFU_RAM) += dfu_ram.o
+obj-$(CONFIG_$(PHASE_)DFU_SF) += dfu_sf.o
+obj-$(CONFIG_$(PHASE_)DFU_WRITE_ALT) += dfu_alt.o
+obj-$(CONFIG_$(PHASE_)DFU_VIRT) += dfu_virt.o
+obj-$(CONFIG_$(PHASE_)DFU_SCSI) += dfu_scsi.o
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 8b979f69ed99..9e7b118b074f 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_FIRMWARE)		+= firmware-uclass.o
-obj-$(CONFIG_$(XPL_)ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_$(PHASE_)ARM_PSCI_FW)	+= psci.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_SANDBOX)		+= firmware-sandbox.o
 obj-$(CONFIG_ZYNQMP_FIRMWARE)	+= firmware-zynqmp.o
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 3f882c065d82..fb2c572cc44f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
 endif
 obj-$(CONFIG_$(PHASE_)DM_GPIO) += gpio-uclass.o
 
-obj-$(CONFIG_$(XPL_)DM_PCA953X)	+= pca953x_gpio.o
+obj-$(CONFIG_$(PHASE_)DM_PCA953X)	+= pca953x_gpio.o
 
 obj-$(CONFIG_ASPEED_GPIO)	+= gpio-aspeed.o
 obj-$(CONFIG_ASPEED_G7_GPIO)	+= gpio-aspeed-g7.o
@@ -58,12 +58,12 @@ obj-$(CONFIG_VYBRID_GPIO)	+= vybrid_gpio.o
 obj-$(CONFIG_HIKEY_GPIO)	+= hi6220_gpio.o
 obj-$(CONFIG_HSDK_CREG_GPIO)	+= hsdk-creg-gpio.o
 obj-$(CONFIG_IMX_RGPIO2P)	+= imx_rgpio2p.o
-obj-$(CONFIG_$(XPL_)PALMAS_GPIO)	+= palmas_gpio.o
+obj-$(CONFIG_$(PHASE_)PALMAS_GPIO)	+= palmas_gpio.o
 obj-$(CONFIG_PIC32_GPIO)	+= pic32_gpio.o
 obj-$(CONFIG_OCTEON_GPIO)	+= octeon_gpio.o
 obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
 obj-$(CONFIG_MSM_GPIO)		+= msm_gpio.o
-obj-$(CONFIG_$(XPL_)PCF8575_GPIO)	+= pcf8575_gpio.o
+obj-$(CONFIG_$(PHASE_)PCF8575_GPIO)	+= pcf8575_gpio.o
 obj-$(CONFIG_$(PHASE_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o
 obj-$(CONFIG_MT7620_GPIO)	+= mt7620_gpio.o
 obj-$(CONFIG_MT7621_GPIO)	+= mt7621_gpio.o
@@ -72,10 +72,10 @@ obj-$(CONFIG_NX_GPIO)		+= nx_gpio.o
 obj-$(CONFIG_SIFIVE_GPIO)	+= sifive-gpio.o
 obj-$(CONFIG_NOMADIK_GPIO)	+= nmk_gpio.o
 obj-$(CONFIG_MAX7320_GPIO)	+= max7320_gpio.o
-obj-$(CONFIG_$(XPL_)MAX77663_GPIO)	+= max77663_gpio.o
+obj-$(CONFIG_$(PHASE_)MAX77663_GPIO)	+= max77663_gpio.o
 obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
-obj-$(CONFIG_$(SPL_)ADP5585_GPIO)	+= adp5585_gpio.o
+obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index bebd728e7da6..c9d4616cc87c 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -2,15 +2,15 @@
 #
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-obj-$(CONFIG_$(XPL_)DM_I2C) += i2c-uclass.o
-ifdef CONFIG_$(XPL_)ACPIGEN
-obj-$(CONFIG_$(XPL_)DM_I2C) += acpi_i2c.o
+obj-$(CONFIG_$(PHASE_)DM_I2C) += i2c-uclass.o
+ifdef CONFIG_$(PHASE_)ACPIGEN
+obj-$(CONFIG_$(PHASE_)DM_I2C) += acpi_i2c.o
 endif
-obj-$(CONFIG_$(XPL_)DM_I2C_GPIO) += i2c-gpio.o
-obj-$(CONFIG_$(XPL_)I2C_CROS_EC_TUNNEL) += cros_ec_tunnel.o
-obj-$(CONFIG_$(XPL_)I2C_CROS_EC_LDO) += cros_ec_ldo.o
+obj-$(CONFIG_$(PHASE_)DM_I2C_GPIO) += i2c-gpio.o
+obj-$(CONFIG_$(PHASE_)I2C_CROS_EC_TUNNEL) += cros_ec_tunnel.o
+obj-$(CONFIG_$(PHASE_)I2C_CROS_EC_LDO) += cros_ec_ldo.o
 
-obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) += i2c_core.o
+obj-$(CONFIG_$(PHASE_)SYS_I2C_LEGACY) += i2c_core.o
 obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
 obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
 obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
@@ -57,4 +57,4 @@ obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
 obj-$(CONFIG_SYS_I2C_XILINX_XIIC) += xilinx_xiic.o
 obj-$(CONFIG_TEGRA186_BPMP_I2C) += tegra186_bpmp_i2c.o
 
-obj-$(CONFIG_$(XPL_)I2C_MUX) += muxes/
+obj-$(CONFIG_$(PHASE_)I2C_MUX) += muxes/
diff --git a/drivers/led/Makefile b/drivers/led/Makefile
index aa64a38b4e11..996753b88aee 100644
--- a/drivers/led/Makefile
+++ b/drivers/led/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
 obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
 obj-$(CONFIG_LED_BCM6858) += led_bcm6858.o
 obj-$(CONFIG_LED_PWM) += led_pwm.o
-obj-$(CONFIG_$(XPL_)LED_GPIO) += led_gpio.o
+obj-$(CONFIG_$(PHASE_)LED_GPIO) += led_gpio.o
 obj-$(CONFIG_LED_CORTINA) += led_cortina.o
 obj-$(CONFIG_LED_LP5562) += led_lp5562.o
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956b7..45d9c5a6c195 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2016, NVIDIA CORPORATION.
 #
 
-obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index dac805e4cdd4..4b62cd780482 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SANDBOX) += p2sb_sandbox.o p2sb_emul.o
 obj-$(CONFIG_SANDBOX) += swap_case.o
 endif
 
-ifdef CONFIG_$(XPL_)DM_I2C
+ifdef CONFIG_$(PHASE_)DM_I2C
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += i2c_eeprom_emul.o
 obj-$(CONFIG_USB_HUB_USB251XB) += usb251xb.o
@@ -37,14 +37,14 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(XPL_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
 obj-$(CONFIG_GDSYS_RXAUI_CTRL) += gdsys_rxaui_ctrl.o
 obj-$(CONFIG_GDSYS_SOC) += gdsys_soc.o
 obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
-obj-$(CONFIG_$(XPL_)I2C_EEPROM) += i2c_eeprom.o
+obj-$(CONFIG_$(PHASE_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
@@ -52,14 +52,14 @@ obj-$(CONFIG_LED_STATUS) += status_led.o
 obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(PHASE_)LS2_SFP) += ls2_sfp.o
-obj-$(CONFIG_$(XPL_)MXC_OCOTP) += mxc_ocotp.o
+obj-$(CONFIG_$(PHASE_)MXC_OCOTP) += mxc_ocotp.o
 obj-$(CONFIG_MXS_OCOTP) += mxs_ocotp.o
 obj-$(CONFIG_NPCM_OTP) += npcm_otp.o
 obj-$(CONFIG_NPCM_HOST) += npcm_host_intf.o
 obj-$(CONFIG_NUVOTON_NCT6102D) += nuvoton_nct6102d.o
 obj-$(CONFIG_P2SB) += p2sb-uclass.o
 obj-$(CONFIG_PCA9551_LED) += pca9551_led.o
-obj-$(CONFIG_$(XPL_)PWRSEQ) += pwrseq-uclass.o
+obj-$(CONFIG_$(PHASE_)PWRSEQ) += pwrseq-uclass.o
 ifdef CONFIG_QFW
 obj-y += qfw.o
 obj-$(CONFIG_QFW_ACPI) += qfw_acpi.o
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 90e76f907694..cf131045b07a 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -4,17 +4,17 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-y += mmc.o
-obj-$(CONFIG_$(XPL_)DM_MMC) += mmc-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_MMC) += mmc-uclass.o
 
 ifdef CONFIG_$(PHASE_)DM_MMC
 obj-$(CONFIG_$(PHASE_)BOOTSTD) += mmc_bootdev.o
 endif
 
 obj-$(CONFIG_$(PHASE_)MMC_WRITE) += mmc_write.o
-obj-$(CONFIG_$(XPL_)MMC_PWRSEQ) += mmc-pwrseq.o
+obj-$(CONFIG_$(PHASE_)MMC_PWRSEQ) += mmc-pwrseq.o
 obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
 
-ifndef CONFIG_$(XPL_)BLK
+ifndef CONFIG_$(PHASE_)BLK
 obj-y += mmc_legacy.o
 endif
 
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index 63770e12bd15..b61f713c301e 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -4,4 +4,4 @@
 # Jean-Jacques Hiblot <jjhiblot@ti.com>
 
 obj-$(CONFIG_MULTIPLEXER) += mux-uclass.o
-obj-$(CONFIG_$(XPL_)MUX_MMIO) += mmio.o
+obj-$(CONFIG_$(PHASE_)MUX_MMIO) += mmio.o
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index 8c32cfbfc0f7..5f8ed79077db 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -4,4 +4,4 @@
 
 obj-y += nvme-uclass.o nvme.o nvme_show.o
 obj-$(CONFIG_NVME_APPLE) += nvme_apple.o
-obj-$(CONFIG_$(XPL_)NVME_PCI) += nvme_pci.o
+obj-$(CONFIG_$(PHASE_)NVME_PCI) += nvme_pci.o
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c35f9294dd9f..9840a553fc29 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -8,8 +8,8 @@ obj-y += marvell/
 obj-y += rockchip/
 obj-y += socionext/
 
-obj-$(CONFIG_$(XPL_)PHY) += phy-uclass.o
-obj-$(CONFIG_$(XPL_)NOP_PHY) += nop-phy.o
+obj-$(CONFIG_$(PHASE_)PHY) += phy-uclass.o
+obj-$(CONFIG_$(PHASE_)NOP_PHY) += nop-phy.o
 obj-$(CONFIG_MIPI_DPHY_HELPERS) += phy-core-mipi-dphy.o
 obj-$(CONFIG_AB8500_USB_PHY) += phy-ab8500-usb.o
 obj-$(CONFIG_APPLE_ATCPHY) += phy-apple-atc.o
@@ -19,7 +19,7 @@ obj-$(CONFIG_BCM6358_USBH_PHY) += bcm6358-usbh-phy.o
 obj-$(CONFIG_BCM6368_USBH_PHY) += bcm6368-usbh-phy.o
 obj-$(CONFIG_BCM_SR_PCIE_PHY) += phy-bcm-sr-pcie.o
 obj-$(CONFIG_PHY_SANDBOX) += sandbox-phy.o
-obj-$(CONFIG_$(XPL_)PIPE3_PHY) += ti-pipe3-phy.o
+obj-$(CONFIG_$(PHASE_)PIPE3_PHY) += ti-pipe3-phy.o
 obj-$(CONFIG_AM654_PHY) += phy-ti-am654.o
 obj-$(CONFIG_STI_USB_PHY) += sti_usb_phy.o
 obj-$(CONFIG_PHY_RCAR_GEN2) += phy-rcar-gen2.o
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
index e0da41cd7eb3..2b1e51768da7 100644
--- a/drivers/phy/cadence/Makefile
+++ b/drivers/phy/cadence/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_$(XPL_)PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
-obj-$(CONFIG_$(XPL_)PHY_CADENCE_TORRENT) += phy-cadence-torrent.o
+obj-$(CONFIG_$(PHASE_)PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
+obj-$(CONFIG_$(PHASE_)PHY_CADENCE_TORRENT) += phy-cadence-torrent.o
diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
index 699901fd15e0..169036a08d7e 100644
--- a/drivers/phy/ti/Makefile
+++ b/drivers/phy/ti/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_$(XPL_)PHY_J721E_WIZ)	+= phy-j721e-wiz.o
+obj-$(CONFIG_$(PHASE_)PHY_J721E_WIZ)	+= phy-j721e-wiz.o
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 634047a91f4c..58b4635841f5 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y					+= pinctrl-uclass.o
-obj-$(CONFIG_$(XPL_)PINCTRL_GENERIC)	+= pinctrl-generic.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
 obj-y					+= nxp/
-obj-$(CONFIG_$(XPL_)PINCTRL_ROCKCHIP)	+= rockchip/
+obj-$(CONFIG_$(PHASE_)PINCTRL_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_ARCH_ASPEED) += aspeed/
 obj-$(CONFIG_ARCH_ATH79) += ath79/
 obj-$(CONFIG_PINCTRL_INTEL) += intel/
@@ -18,7 +18,7 @@ obj-$(CONFIG_ARCH_RENESAS) += renesas/
 obj-$(CONFIG_ARCH_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
-obj-$(CONFIG_$(XPL_)PINCTRL_TEGRA)	+= tegra/
+obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
@@ -32,7 +32,7 @@ obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
 obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
-obj-$(CONFIG_$(XPL_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
 obj-y				+= broadcom/
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 110646c503ab..c82684198bab 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2016, NVIDIA CORPORATION.
 #
 
-obj-$(CONFIG_$(XPL_)POWER_DOMAIN) += power-domain-uclass.o
+obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += power-domain-uclass.o
 obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index bc138f563ffd..4232cb4f5f98 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -4,33 +4,33 @@
 # Lukasz Majewski <l.majewski@samsung.com>
 
 obj-$(CONFIG_$(PHASE_)DM_PMIC) += pmic-uclass.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_FAN53555) += fan53555.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_DA9063) += da9063.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_MAX77663) += max77663.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_FAN53555) += fan53555.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_DA9063) += da9063.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_MAX77663) += max77663.o
 obj-$(CONFIG_DM_PMIC_MAX77686) += max77686.o
 obj-$(CONFIG_DM_PMIC_MAX8998) += max8998.o
 obj-$(CONFIG_DM_PMIC_MC34708) += mc34708.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_BD71837) += bd71837.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_MP5416) += mp5416.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_PFUZE100) += pfuze100.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_PCA9450) += pca9450.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_BD71837) += bd71837.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_MP5416) += mp5416.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_PFUZE100) += pfuze100.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_PCA9450) += pca9450.o
 obj-$(CONFIG_PMIC_S2MPS11) += s2mps11.o
 obj-$(CONFIG_DM_PMIC_SANDBOX) += sandbox.o i2c_pmic_emul.o
 obj-$(CONFIG_PMIC_AB8500) += ab8500.o
 obj-$(CONFIG_PMIC_ACT8846) += act8846.o
 obj-$(CONFIG_PMIC_AS3722) += as3722.o as3722_gpio.o
-obj-$(CONFIG_$(XPL_)PMIC_AXP) += axp.o
+obj-$(CONFIG_$(PHASE_)PMIC_AXP) += axp.o
 obj-$(CONFIG_PMIC_MAX8997) += max8997.o
 obj-$(CONFIG_PMIC_QCOM) += pmic_qcom.o
 obj-$(CONFIG_$(PHASE_)PMIC_RK8XX) += rk8xx.o
-obj-$(CONFIG_$(XPL_)PMIC_RN5T567) += rn5t567.o
+obj-$(CONFIG_$(PHASE_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o
 obj-$(CONFIG_PMIC_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_PMIC_TPS65910) += pmic_tps65910_dm.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_TPS80031) += tps80031.o
-obj-$(CONFIG_$(XPL_)PMIC_PALMAS) += palmas.o
-obj-$(CONFIG_$(XPL_)PMIC_LP873X) += lp873x.o
-obj-$(CONFIG_$(XPL_)PMIC_LP87565) += lp87565.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_TPS80031) += tps80031.o
+obj-$(CONFIG_$(PHASE_)PMIC_PALMAS) += palmas.o
+obj-$(CONFIG_$(PHASE_)PMIC_LP873X) += lp873x.o
+obj-$(CONFIG_$(PHASE_)PMIC_LP87565) += lp87565.o
 obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
 obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
@@ -38,7 +38,7 @@ obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
 obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 
-ifeq ($(CONFIG_$(XPL_)POWER_LEGACY),y)
+ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
 obj-$(CONFIG_POWER_PCA9450) += pmic_pca9450.o
 obj-$(CONFIG_POWER_PFUZE100) += pmic_pfuze100.o
@@ -47,5 +47,5 @@ obj-$(CONFIG_POWER_HI6553) += pmic_hi6553.o
 obj-$(CONFIG_POWER_MC34VR500) += pmic_mc34vr500.o
 endif
 
-obj-$(CONFIG_$(XPL_)POWER_TPS62362) += pmic_tps62362.o
+obj-$(CONFIG_$(PHASE_)POWER_TPS62362) += pmic_tps62362.o
 obj-$(CONFIG_SPL_POWER_TPS65910) += pmic_tps65910.o
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index ca6c89d13b5c..30d8f3a4a41f 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -4,41 +4,41 @@
 # Przemyslaw Marczak <p.marczak@samsung.com>
 #
 
-obj-$(CONFIG_$(XPL_)DM_REGULATOR) += regulator-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR) += regulator-uclass.o
 obj-$(CONFIG_REGULATOR_ACT8846) += act8846.o
 obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
-obj-$(CONFIG_$(XPL_)REGULATOR_AXP) += axp_regulator.o
-obj-$(CONFIG_$(XPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_DA9063) += da9063.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_MAX77663) += max77663_regulator.o
+obj-$(CONFIG_$(PHASE_)REGULATOR_AXP) += axp_regulator.o
+obj-$(CONFIG_$(PHASE_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_DA9063) += da9063.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX77663) += max77663_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
-obj-$(CONFIG_$(XPL_)DM_PMIC_PFUZE100) += pfuze100.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_BD71837) += bd71837.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_PCA9450) += pca9450.o
-obj-$(CONFIG_$(XPL_)REGULATOR_PWM) += pwm_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_FAN53555) += fan53555.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_COMMON) += regulator_common.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_FIXED) += fixed.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_PFUZE100) += pfuze100.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_BD71837) += bd71837.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PCA9450) += pca9450.o
+obj-$(CONFIG_$(PHASE_)REGULATOR_PWM) += pwm_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_FAN53555) += fan53555.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_COMMON) += regulator_common.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_FIXED) += fixed.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
 obj-$(CONFIG_REGULATOR_TPS65090) += tps65090_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_PALMAS) += palmas_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_PBIAS) += pbias_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_LP873X) += lp873x_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_LP87565) += lp87565_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PALMAS) += palmas_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PBIAS) += pbias_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_LP873X) += lp873x_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_LP87565) += lp87565_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_DM_REGULATOR_TPS65910) += tps65910_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_TPS65911) += tps65911_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_TPS65911) += tps65911_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS62360) += tps62360_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_TPS6287X) += tps6287x_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_TPS6287X) += tps6287x_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_STPMIC1) += stpmic1.o
 obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
 obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
-obj-$(CONFIG_$(XPL_)DM_REGULATOR_ANATOP) += anatop_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index f81e5009c5e8..e20e6e4fa399 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -4,7 +4,7 @@
 # Texas Instruments Incorporated - https://www.ti.com/
 #
 
-obj-$(CONFIG_$(XPL_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
+obj-$(CONFIG_$(PHASE_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
 
 # Remote proc drivers - Please keep this list alphabetically sorted.
 obj-$(CONFIG_K3_SYSTEM_CONTROLLER) += k3_system_controller.o
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index ebe692a99635..9e4c42abdac4 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -11,7 +11,7 @@ endif
 
 obj-$(CONFIG_PL01X_SERIAL) += serial_pl01x.o
 obj-$(CONFIG_PL011_SERIAL) += serial_pl01x.o
-obj-$(CONFIG_$(XPL_)SYS_NS16550_SERIAL) += serial_ns16550.o
+obj-$(CONFIG_$(PHASE_)SYS_NS16550_SERIAL) += serial_ns16550.o
 
 obj-$(CONFIG_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_ALTERA_JTAG_UART) += altera_jtag_uart.o
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index 7a847e8388bb..21db0d317fed 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -5,14 +5,14 @@
 obj-y += timer-uclass.o
 obj-$(CONFIG_ADI_SC5XX_TIMER) += adi_sc5xx_timer.o
 obj-$(CONFIG_ALTERA_TIMER)	+= altera_timer.o
-obj-$(CONFIG_$(XPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
+obj-$(CONFIG_$(PHASE_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
 obj-$(CONFIG_ARC_TIMER)	+= arc_timer.o
 obj-$(CONFIG_ARM_TWD_TIMER)	+= arm_twd_timer.o
 obj-$(CONFIG_AST_TIMER)	+= ast_timer.o
 obj-$(CONFIG_AST_IBEX_TIMER)	+= ast_ibex_timer.o
 obj-$(CONFIG_ATCPIT100_TIMER) += atcpit100_timer.o
-obj-$(CONFIG_$(XPL_)ATMEL_PIT_TIMER) += atmel_pit_timer.o
-obj-$(CONFIG_$(XPL_)ATMEL_TCB_TIMER) += atmel_tcb_timer.o
+obj-$(CONFIG_$(PHASE_)ATMEL_PIT_TIMER) += atmel_pit_timer.o
+obj-$(CONFIG_$(PHASE_)ATMEL_TCB_TIMER) += atmel_tcb_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence-ttc.o
 obj-$(CONFIG_DESIGNWARE_APB_TIMER)	+= dw-apb-timer.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= fttmr010_timer.o
@@ -27,7 +27,7 @@ obj-$(CONFIG_RISCV_TIMER) += riscv_timer.o
 obj-$(CONFIG_ROCKCHIP_TIMER) += rockchip_timer.o
 obj-$(CONFIG_SANDBOX_TIMER)	+= sandbox_timer.o
 obj-$(CONFIG_SP804_TIMER)	+= sp804_timer.o
-obj-$(CONFIG_$(XPL_)RISCV_ACLINT) += riscv_aclint_timer.o
+obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) += riscv_aclint_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)	+= arm_global_timer.o
 obj-$(CONFIG_STM32_TIMER)	+= stm32_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra-timer.o
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index d60478560919..96689f11108c 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -4,8 +4,8 @@ cdns3-y					:= core.o drd.o
 
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 
-cdns3-$(CONFIG_$(XPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
+cdns3-$(CONFIG_$(PHASE_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
 
-cdns3-$(CONFIG_$(XPL_)USB_CDNS3_HOST)	+= host.o
+cdns3-$(CONFIG_$(PHASE_)USB_CDNS3_HOST)	+= host.o
 
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 11cc4657a0f4..4c597c166c61 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2016 Freescale Semiconductor, Inc.
 #
 
-obj-$(CONFIG_$(XPL_)DM_USB) += common.o
+obj-$(CONFIG_$(PHASE_)DM_USB) += common.o
 obj-$(CONFIG_USB_ISP1760) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 985206eafe4b..a619cd374fb4 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -6,11 +6,11 @@ dwc3-y					:= core.o
 
 obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
 
-obj-$(CONFIG_$(XPL_)USB_DWC3_AM62)	+= dwc3-am62.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+= dwc3-am62.o
 obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
-obj-$(CONFIG_$(XPL_)USB_DWC3_GENERIC)		+= dwc3-generic.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
 obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 4b6a8fdfeeea..56b9b123fa16 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -2,9 +2,9 @@
 #
 # USB peripheral controller drivers
 
-ifndef CONFIG_$(XPL_)DM_USB_GADGET
+ifndef CONFIG_$(PHASE_)DM_USB_GADGET
 obj-$(CONFIG_USB_DWC3_GADGET)	+= udc-core.o
 endif
 
-obj-$(CONFIG_$(XPL_)DM_USB_GADGET)	+= udc-core.o
+obj-$(CONFIG_$(PHASE_)DM_USB_GADGET)	+= udc-core.o
 obj-y += udc-uclass.o
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 902d68d03786..ef4ce62a680c 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_$(XPL_)DM_USB
+ifdef CONFIG_$(PHASE_)DM_USB
 obj-y += usb-uclass.o
 obj-$(CONFIG_SANDBOX) += usb-sandbox.o
 endif
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 5a00438ce064..2ae9e5da21d1 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -34,7 +34,7 @@ obj-${CONFIG_EXYNOS_FB} += exynos/
 obj-${CONFIG_VIDEO_ROCKCHIP} += rockchip/
 obj-${CONFIG_VIDEO_STM32} += stm32/
 obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
-obj-${CONFIG_$(XPL_)VIDEO_TIDSS} += tidss/
+obj-${CONFIG_$(PHASE_)VIDEO_TIDSS} += tidss/
 obj-y += ti/
 
 obj-$(CONFIG_ATMEL_HLCD) += atmel_hlcdfb.o
diff --git a/drivers/video/tidss/Makefile b/drivers/video/tidss/Makefile
index f0cbe1d4ed18..3381a5fec57a 100644
--- a/drivers/video/tidss/Makefile
+++ b/drivers/video/tidss/Makefile
@@ -9,4 +9,4 @@
 # Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 
-obj-${CONFIG_$(XPL_)VIDEO_TIDSS} = tidss_drv.o
+obj-${CONFIG_$(PHASE_)VIDEO_TIDSS} = tidss_drv.o
diff --git a/fs/fat/Makefile b/fs/fat/Makefile
index 7414b3602aa4..3e7390445378 100644
--- a/fs/fat/Makefile
+++ b/fs/fat/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-$(CONFIG_$(XPL_)FS_FAT) = fat.o
-obj-$(CONFIG_$(XPL_)FAT_WRITE) = fat_write.o
+obj-$(CONFIG_$(PHASE_)FS_FAT) = fat.o
+obj-$(CONFIG_$(PHASE_)FAT_WRITE) = fat_write.o
diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 0772e1a497d7..c71c9d43d7a8 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-$(CONFIG_$(XPL_)FS_SQUASHFS) = sqfs.o \
+obj-$(CONFIG_$(PHASE_)FS_SQUASHFS) = sqfs.o \
 				sqfs_inode.o \
 				sqfs_dir.o \
 				sqfs_decompressor.o
diff --git a/lib/Makefile b/lib/Makefile
index a7bc2f3134a7..948aae50c925 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -75,7 +75,7 @@ obj-y += crypto/
 
 obj-$(CONFIG_$(PHASE_)ACPI) += acpi/
 obj-$(CONFIG_ECDSA) += ecdsa/
-obj-$(CONFIG_$(XPL_)RSA) += rsa/
+obj-$(CONFIG_$(PHASE_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
 
@@ -86,7 +86,7 @@ obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_LEGACY) += sha512.o
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
-obj-$(CONFIG_$(XPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
+obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
@@ -95,14 +95,14 @@ obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
 obj-$(CONFIG_$(PHASE_)LZ4) += lz4_wrapper.o
 
-obj-$(CONFIG_$(XPL_)LIB_RATIONAL) += rational.o
+obj-$(CONFIG_$(PHASE_)LIB_RATIONAL) += rational.o
 
 obj-$(CONFIG_LIBAVB) += libavb/
 
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(PHASE_)OF_REAL) += fdtdec_common.o fdtdec.o
 
-obj-$(CONFIG_$(XPL_)MBEDTLS_LIB) += mbedtls/
+obj-$(CONFIG_$(PHASE_)MBEDTLS_LIB) += mbedtls/
 
 obj-$(CONFIG_NET_LWIP) += lwip/
 
@@ -154,7 +154,7 @@ else
 obj-y += vsprintf.o strto.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 endif
-obj-$(CONFIG_$(XPL_)OID_REGISTRY) += oid_registry.o
+obj-$(CONFIG_$(PHASE_)OID_REGISTRY) += oid_registry.o
 
 obj-y += abuf.o
 obj-y += alist.o
diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
index dcca0c67268f..64f06deaf112 100644
--- a/lib/acpi/Makefile
+++ b/lib/acpi/Makefile
@@ -5,10 +5,10 @@ obj-y += acpi.o
 
 ifdef CONFIG_$(PHASE_)GENERATE_ACPI_TABLE
 
-obj-$(CONFIG_$(XPL_)ACPIGEN) += acpigen.o
-obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_device.o
-obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_dp.o
-obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_table.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpigen.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_device.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_dp.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_table.o
 obj-y += acpi_writer.o
 
 # With QEMU the ACPI tables come from there, not from U-Boot
diff --git a/lib/aes/Makefile b/lib/aes/Makefile
index ad6228a7dad5..41ebdd060449 100644
--- a/lib/aes/Makefile
+++ b/lib/aes/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright (c) 2019, Softathome
 
-obj-$(CONFIG_$(XPL_)FIT_CIPHER) += aes-decrypt.o
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += aes-decrypt.o
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index b729824df3c8..ac2b9a7d72fa 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -3,17 +3,17 @@
 # Makefile for asymmetric cryptographic keys
 #
 
-obj-$(CONFIG_$(XPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
+obj-$(CONFIG_$(PHASE_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
 
 asymmetric_keys-y := asymmetric_type.o
 
-obj-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_helper.o
-obj-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
+obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_helper.o
+obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
 
 #
 # RSA public key parser
 #
-obj-$(CONFIG_$(XPL_)RSA_PUBLIC_KEY_PARSER_LEGACY) += rsa_public_key.o
+obj-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_LEGACY) += rsa_public_key.o
 rsa_public_key-y := \
 	rsapubkey.asn1.o \
 	rsa_helper.o
@@ -31,9 +31,9 @@ endif
 #
 # X.509 Certificate handling
 #
-obj-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
+obj-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
 x509_key_parser-y := x509_helper.o
-x509_key_parser-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER_LEGACY) += \
+x509_key_parser-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_LEGACY) += \
 	x509.asn1.o \
 	x509_akid.asn1.o \
 	x509_cert_parser.o \
@@ -49,21 +49,21 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 #
 # PKCS#7 message handling
 #
-obj-$(CONFIG_$(XPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
+obj-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := pkcs7_helper.o
-pkcs7_message-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_LEGACY) += \
+pkcs7_message-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_LEGACY) += \
 	pkcs7.asn1.o \
 	pkcs7_parser.o
 
 $(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
 
-obj-$(CONFIG_$(XPL_)PKCS7_VERIFY) += pkcs7_verify.o
+obj-$(CONFIG_$(PHASE_)PKCS7_VERIFY) += pkcs7_verify.o
 
 #
 # Signed PE binary-wrapped key handling
 #
-obj-$(CONFIG_$(XPL_)MSCODE_PARSER_LEGACY) += mscode.o
+obj-$(CONFIG_$(PHASE_)MSCODE_PARSER_LEGACY) += mscode.o
 
 mscode-y := \
 	mscode_parser.o \
diff --git a/lib/ecdsa/Makefile b/lib/ecdsa/Makefile
index 32b6183f6ff0..9db9f7b17b9c 100644
--- a/lib/ecdsa/Makefile
+++ b/lib/ecdsa/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_$(XPL_)ECDSA_VERIFY) += ecdsa-verify.o
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY) += ecdsa-verify.o
diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
index fe2b64c9acc5..e9e8caee93a8 100644
--- a/lib/lwip/Makefile
+++ b/lib/lwip/Makefile
@@ -54,5 +54,5 @@ obj-y += \
 	lwip/src/core/udp.o \
 	lwip/src/netif/ethernet.o
 
-obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
+obj-$(CONFIG_$(PHASE_)MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
 	lwip/src/apps/altcp_tls/altcp_tls_mbedtls_mem.o
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index e66c2018d970..eb22a84035a7 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -6,19 +6,19 @@
 MBEDTLS_LIB_DIR = external/mbedtls/library
 
 # shim layer for hash
-obj-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
-obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
-obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
-obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
+obj-$(CONFIG_$(PHASE_)MD5_MBEDTLS) += md5.o
+obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
+obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
+obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
 # x509 libraries
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
+obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
-obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
+obj-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
-obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
-obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
-obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
+obj-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
+obj-$(CONFIG_$(PHASE_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
+obj-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
@@ -27,35 +27,35 @@ mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/constant_time.o \
 	$(MBEDTLS_LIB_DIR)/md.o
 
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
+mbedtls_lib_crypto-$(CONFIG_$(PHASE_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
+mbedtls_lib_crypto-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
+mbedtls_lib_crypto-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha256.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
+mbedtls_lib_crypto-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha512.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
+mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/hkdf.o
 
 # MbedTLS X509 library
 obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/bignum.o \
 	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pk.o \
 	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
 	$(MBEDTLS_LIB_DIR)/pkparse.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crl.o \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pkcs7.o
 
 #mbedTLS TLS support
diff --git a/net/Makefile b/net/Makefile
index 7c917b318c0c..41edbacabc95 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_CMD_DNS)  += dns.o
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
-obj-$(CONFIG_$(XPL_)DM_ETH) += net.o
+obj-$(CONFIG_$(PHASE_)DM_ETH) += net.o
 obj-$(CONFIG_IPV6)     += net6.o
 obj-$(CONFIG_CMD_NFS)  += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
@@ -39,11 +39,11 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 endif
 
 ifeq ($(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)),y)
-obj-$(CONFIG_$(XPL_)DM_ETH) += eth-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
-obj-$(CONFIG_$(XPL_)DM_ETH) += eth_common.o
+obj-$(CONFIG_$(PHASE_)DM_ETH) += eth_common.o
 obj-y += net-common.o
 endif
 
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 79dd6b3fb506..1c69ca089452 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -1,6 +1,6 @@
 ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
-obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
+obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
diff --git a/test/Makefile b/test/Makefile
index 99d4797d968b..f7ab9a36b2aa 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -4,15 +4,15 @@
 
 obj-y += test-main.o
 
-obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
-obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += cmd/
+obj-$(CONFIG_$(PHASE_)CMDLINE) += cmd_ut.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
 obj-$(CONFIG_UNIT_TEST) += lib/
 endif
 ifneq ($(CONFIG_HUSH_PARSER),)
-obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
+obj-$(CONFIG_$(PHASE_)CMDLINE) += hush/
 endif
 obj-$(CONFIG_UT_OPTEE) += optee/
 obj-y += ut.o
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 63487e8d29e4..00223b44fe03 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_CEDIT) += cedit.o
 endif
 
 ifdef CONFIG_SANDBOX
-obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += bootm.o
 endif
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index d8a5e77402dc..8596c5ad7530 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2013 Google, Inc
 # Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
-obj-$(CONFIG_$(XPL_)CMDLINE) += command.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += command.o
 ifdef CONFIG_HUSH_PARSER
 obj-$(CONFIG_CONSOLE_RECORD) += test_echo.o
 endif
diff --git a/test/common/Makefile b/test/common/Makefile
index 1ad6c24b7e22..baefc7b3622c 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
 
-ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+ifneq ($(CONFIG_$(PHASE_)BLOBLIST),)
 ifdef CONFIG_BLOBLIST_FIXED
-obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += bloblist.o
 endif
 endif
 
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
-obj-$(CONFIG_$(XPL_)CMDLINE) += print.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += print.o
diff --git a/test/fuzz/Makefile b/test/fuzz/Makefile
index 8a135b65e4b1..0a8f3d12239f 100644
--- a/test/fuzz/Makefile
+++ b/test/fuzz/Makefile
@@ -4,5 +4,5 @@
 # Written by Andrew Scull <ascull@google.com>
 #
 
-obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_fuzz.o
+obj-$(CONFIG_$(PHASE_)CMDLINE) += cmd_fuzz.o
 obj-$(CONFIG_VIRTIO_SANDBOX) += virtio.o
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 0e4cb8e3dfdd..edf8585da56f 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2018
 # Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
 
-obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
+obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
@@ -29,7 +29,7 @@ obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
 obj-$(CONFIG_UT_TIME) += time.o
-obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
+obj-$(CONFIG_$(PHASE_)UT_UNICODE) += unicode.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
 obj-$(CONFIG_SANDBOX) += kconfig_spl.o
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 259adbe1bc9e..544254f6e78f 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1220,8 +1220,6 @@ def scan_makefiles(fnames):
 
     >>> RE_MK_CONFIGS.search('CONFIG_FRED').groups()
     (None, 'FRED')
-    >>> RE_MK_CONFIGS.search('CONFIG_$(XPL_)MARY').groups()
-    ('$(XPL_)', 'MARY')
     >>> RE_MK_CONFIGS.search('CONFIG_$(PHASE_)MARY').groups()
     ('$(PHASE_)', 'MARY')
     """
@@ -1321,7 +1319,7 @@ def do_scan_source(path, do_update):
             spl_mode (int): If MODE_SPL, look at source code which implies
                 an xPL_ option, but for which there is none;
                 for MOD_PROPER, look at source code which implies a Proper
-                option (i.e. use of CONFIG_IS_ENABLED() or $(XPL_) or
+                option (i.e. use of CONFIG_IS_ENABLED() or $(PHASE_) or
                 $(PHASE_) but for which there none;
                 if MODE_NORMAL, ignore SPL
 
-- 
2.43.0

