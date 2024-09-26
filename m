Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC820CCFA07
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D40E8905C;
	Fri, 27 Sep 2024 00:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nUfjvqcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB7788FCB; Fri, 27 Sep 2024 00:45:13 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B62988F9B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-4583209a17dso11048561cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390708; x=1727995508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qHObg1PXjnQVDlmzv2RcFwOKeqk8tzOEnXVRpTM3SM=;
 b=nUfjvqcfH/Fi3cre+KFGUZe5g4B9BKbEBjfhVmwdOpmkzJqLj3QnCeCnqVFtbsRaqa
 ThjtblHJjQ49VV9mqrzNMBHeEdHcgJA/3vWr3RdwsIlyO9i4Cyp5s4YlMF36JFyAenEL
 IRdisYRqslN5UQjePi5WYsp26DoHFdTfslAnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390708; x=1727995508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qHObg1PXjnQVDlmzv2RcFwOKeqk8tzOEnXVRpTM3SM=;
 b=VyaruZ0wKwEBFg9eZtvAzlzCDz2izhRzayBIubFYcZYzp+4X4tDdrfYijNl7zcPsiJ
 PJbYhcfzoXIJnDZvDKQvlVz1v/y2ChSGAC5ag0OAjGAi1vqKanwtS9x5BZaEXbKv2gi3
 kLeH/JsRf0kIuo5XCQJGRhAmMfvjvxrELI93f/wgykIlfUoi+tn+2CSBwglx8Zb/C7H4
 RoHFgvSiFTBY+MDauWodUkGSPsFazw/yAPXhNU7AR/uK8w1iE+ySgeV9ZmuC33tWkeL3
 /lVYcTNu1erjQtABN7kZTgp646ybdGCEmE0GuUvuBLxUuHQ94NUChOnKTsjhrBcTQXbf
 vLYw==
X-Gm-Message-State: AOJu0Yxodnt+nezxcYrcBrYfS2ZMpRVCVwZvzolixdbQeA64B54iCOjZ
 tK6DsrA4D/Iwphol571v7osRAIKnzulGb8+6ReyrJi5wzx6CE2EPXt+oc9moGwEcWz/YqhMjHXD
 joAQAIjtEgg==
X-Google-Smtp-Source: AGHT+IG7zZ6ReW8B3DGovukGs3fiXABiNdHrOGdwqV+5bvcKfox1CsjOn6mPF6+nl5ko+cTNmlwd0A==
X-Received: by 2002:a05:622a:10f:b0:458:5e19:b3a4 with SMTP id
 d75a77b69052e-45c9f284e48mr13898331cf.38.1727390707089; 
 Thu, 26 Sep 2024 15:45:07 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:45:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Dragan Simic <dsimic@manjaro.org>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Richard Weinberger <richard@nod.at>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH 30/42] global: Rename SPL_TPL_ to PHASE_
Date: Fri, 27 Sep 2024 00:35:55 +0200
Message-ID: <20240926223814.1276764-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Sep 2024 00:50:46 +0200
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

Use PHASE_ as the symbol to select a particular XPL build. This means
that SPL_TPL_ is no-longer set.

Update the comment in bootstage to refer to this symbol, instead of
SPL_

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                              |  2 +-
 arch/arm/cpu/armv8/Makefile           |  2 +-
 arch/arm/lib/Makefile                 | 16 +++---
 arch/arm/mach-at91/arm926ejs/Makefile |  2 +-
 arch/arm/mach-omap2/Makefile          |  2 +-
 arch/arm/mach-rockchip/Makefile       |  2 +-
 arch/powerpc/lib/Makefile             |  2 +-
 arch/riscv/lib/Makefile               | 14 ++---
 arch/x86/Makefile                     |  6 +-
 arch/x86/cpu/Makefile                 |  8 +--
 arch/x86/cpu/broadwell/Makefile       | 10 ++--
 arch/x86/cpu/intel_common/Makefile    | 10 ++--
 arch/x86/lib/Makefile                 |  6 +-
 board/coreboot/coreboot/Makefile      |  2 +-
 boot/Makefile                         | 80 +++++++++++++--------------
 common/Makefile                       | 26 ++++-----
 common/bootstage.c                    |  4 +-
 common/init/Makefile                  |  2 +-
 common/spl/Makefile                   | 56 +++++++++----------
 disk/Makefile                         | 18 +++---
 drivers/Makefile                      | 70 +++++++++++------------
 drivers/adc/Makefile                  |  2 +-
 drivers/block/Makefile                |  8 +--
 drivers/cache/Makefile                |  2 +-
 drivers/clk/Makefile                  | 18 +++---
 drivers/clk/exynos/Makefile           |  2 +-
 drivers/clk/imx/Makefile              | 20 +++----
 drivers/clk/ti/Makefile               |  4 +-
 drivers/core/Makefile                 | 10 ++--
 drivers/crypto/fsl/Makefile           |  2 +-
 drivers/gpio/Makefile                 |  6 +-
 drivers/input/Makefile                |  6 +-
 drivers/misc/Makefile                 | 16 +++---
 drivers/mmc/Makefile                  |  6 +-
 drivers/mtd/Makefile                  |  4 +-
 drivers/mtd/nand/Makefile             |  2 +-
 drivers/mtd/nand/raw/Makefile         |  2 +-
 drivers/mtd/spi/Makefile              |  8 +--
 drivers/pinctrl/starfive/Makefile     |  4 +-
 drivers/power/Makefile                |  8 +--
 drivers/power/acpi_pmc/Makefile       |  2 +-
 drivers/power/pmic/Makefile           |  4 +-
 drivers/power/regulator/Makefile      |  2 +-
 drivers/ram/Makefile                  |  2 +-
 drivers/reset/Makefile                |  2 +-
 drivers/rng/Makefile                  |  2 +-
 drivers/rtc/Makefile                  |  6 +-
 drivers/scsi/Makefile                 |  2 +-
 drivers/serial/Makefile               |  2 +-
 drivers/spi/Makefile                  |  2 +-
 drivers/sysreset/Makefile             | 14 ++---
 drivers/tpm/Makefile                  |  4 +-
 drivers/usb/gadget/Makefile           |  6 +-
 drivers/usb/host/Makefile             |  4 +-
 drivers/video/Makefile                | 16 +++---
 drivers/watchdog/Makefile             |  2 +-
 env/Makefile                          | 22 ++++----
 fs/sandbox/Makefile                   |  2 +-
 lib/Makefile                          | 34 ++++++------
 lib/acpi/Makefile                     |  2 +-
 lib/libfdt/Makefile                   |  2 +-
 lib/rsa/Makefile                      |  4 +-
 net/Makefile                          |  6 +-
 scripts/Kbuild.include                |  8 +--
 scripts/Makefile.xpl                  | 44 +++++++--------
 test/dm/Makefile                      |  4 +-
 tools/qconfig.py                      |  6 +-
 67 files changed, 338 insertions(+), 338 deletions(-)

diff --git a/Makefile b/Makefile
index d38adcbd1e6..ca74406f21c 100644
--- a/Makefile
+++ b/Makefile
@@ -883,7 +883,7 @@ libs-y += drivers/usb/ulpi/
 ifdef CONFIG_POST
 libs-y += post/
 endif
-libs-$(CONFIG_$(SPL_TPL_)UNIT_TEST) += test/
+libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
 libs-$(CONFIG_UT_ENV) += test/env/
 libs-$(CONFIG_UT_OPTEE) += test/optee/
 libs-$(CONFIG_UT_OVERLAY) += test/overlay/
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index c5f568e2cb7..8747d2eb186 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -6,7 +6,7 @@
 extra-y	:= start.o
 
 obj-y	+= cpu.o
-ifndef CONFIG_$(SPL_TPL_)TIMER
+ifndef CONFIG_$(PHASE_)TIMER
 obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
 endif
 ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index b73a0397541..211ff4960e1 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
 else
-obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
+obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
 ifdef CONFIG_SPL_FRAMEWORK
 obj-$(CONFIG_CMD_BOOTI) += image.o
 obj-$(CONFIG_CMD_BOOTZ) += zimage.o
@@ -42,14 +42,14 @@ endif
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 endif
 ifdef CONFIG_ARM64
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMSET) += memset-arm64.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMCPY) += memcpy-arm64.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMSET) += memset-arm64.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMCPY) += memcpy-arm64.o
 else
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMSET) += memset.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMCPY) += memcpy.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMSET) += memset.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMCPY) += memcpy.o
 endif
-obj-$(CONFIG_$(SPL_TPL_)SYS_L2_PL310) += cache-pl310.o
-obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
+obj-$(CONFIG_$(PHASE_)SYS_L2_PL310) += cache-pl310.o
+obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
 ifneq ($(filter y,$(CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR) $(CONFIG_SAVE_PREV_BL_FDT_ADDR)),)
 obj-y += save_prev_bl_data.o
@@ -73,7 +73,7 @@ obj-y	+= interrupts_64.o
 else
 obj-y	+= interrupts.o
 endif
-ifndef CONFIG_$(SPL_TPL_)SYSRESET
+ifndef CONFIG_$(PHASE_)SYSRESET
 obj-y	+= reset.o
 endif
 
diff --git a/arch/arm/mach-at91/arm926ejs/Makefile b/arch/arm/mach-at91/arm926ejs/Makefile
index 1695708831c..8f0bc5d997e 100644
--- a/arch/arm/mach-at91/arm926ejs/Makefile
+++ b/arch/arm/mach-at91/arm926ejs/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_AT91SAM9X5)	+= at91sam9x5_devices.o
 obj-$(CONFIG_SAM9X60)		+= sam9x60_devices.o
 obj-y += clock.o
 obj-y += cpu.o
-ifndef CONFIG_$(SPL_TPL_)SYSRESET
+ifndef CONFIG_$(PHASE_)SYSRESET
 obj-y	+= reset.o
 endif
 ifneq ($(CONFIG_ATMEL_PIT_TIMER),y)
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9a85c764a55..fb5ea97e56e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -26,7 +26,7 @@ obj-y	+= vc.o
 obj-y	+= abb.o
 endif
 
-ifeq ($(CONFIG_$(SPL_TPL_)SYS_DCACHE_OFF),)
+ifeq ($(CONFIG_$(PHASE_)SYS_DCACHE_OFF),)
 obj-y	+= omap-cache.o
 endif
 
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 70f0af4733c..c0265fe006e 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)RAM) += sdram.o
+obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
 
 obj-$(CONFIG_ROCKCHIP_PX30) += px30/
 obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 64ac4930b62..6089901fe74 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -44,5 +44,5 @@ obj-y	+= traps.o
 endif # not minimal
 
 ifdef CONFIG_XPL_BUILD
-obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
+obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
 endif
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 34b69c13392..608118135d7 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -40,11 +40,11 @@ extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
 extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
 extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
 
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMSET) += memset.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMMOVE) += memmove.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMCPY) += memcpy.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_STRLEN) += strlen_zbb.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_STRCMP) += strcmp_zbb.o
-obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_STRNCMP) += strncmp_zbb.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMSET) += memset.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMMOVE) += memmove.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMCPY) += memcpy.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_STRLEN) += strlen_zbb.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_STRCMP) += strcmp_zbb.o
+obj-$(CONFIG_$(PHASE_)USE_ARCH_STRNCMP) += strncmp_zbb.o
 
-obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
+obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index bc1e1ede12a..fd409b9f720 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -4,7 +4,7 @@ ifeq ($(CONFIG_EFI_APP),)
 ifdef CONFIG_$(XPL_)X86_64
 head-y := arch/x86/cpu/start64.o
 else
-ifeq ($(CONFIG_$(SPL_TPL_)X86_16BIT_INIT),y)
+ifeq ($(CONFIG_$(PHASE_)X86_16BIT_INIT),y)
 head-y := arch/x86/cpu/start.o
 else
 ifndef CONFIG_SPL
@@ -20,8 +20,8 @@ endif
 endif
 endif # EFI
 
-head-$(CONFIG_$(SPL_TPL_)X86_16BIT_INIT) += arch/x86/cpu/start16.o
-head-$(CONFIG_$(SPL_TPL_)X86_16BIT_INIT) += arch/x86/cpu/resetvec.o
+head-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += arch/x86/cpu/start16.o
+head-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += arch/x86/cpu/resetvec.o
 
 libs-y += arch/x86/cpu/
 libs-y += arch/x86/lib/
diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index 8899830370c..39c8b0835cc 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -9,7 +9,7 @@
 ifeq ($(CONFIG_$(XPL_)X86_64),y)
 extra-y	= start64.o
 else
-ifeq ($(CONFIG_$(SPL_TPL_)X86_16BIT_INIT),y)
+ifeq ($(CONFIG_$(PHASE_)X86_16BIT_INIT),y)
 extra-y	= start.o
 else
 ifndef CONFIG_SPL
@@ -24,7 +24,7 @@ endif
 endif
 endif
 
-extra-$(CONFIG_$(SPL_TPL_)X86_16BIT_INIT) += resetvec.o start16.o
+extra-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += resetvec.o start16.o
 
 obj-y	+= cpu.o
 ifndef CONFIG_TPL_BUILD
@@ -54,10 +54,10 @@ obj-$(CONFIG_INTEL_QUARK) += quark/
 obj-$(CONFIG_INTEL_QUEENSBAY) += queensbay/
 obj-$(CONFIG_INTEL_TANGIER) += tangier/
 obj-$(CONFIG_APIC) += lapic.o ioapic.o
-obj-$(CONFIG_$(SPL_TPL_)ACPI_GPE) += acpi_gpe.o
+obj-$(CONFIG_$(PHASE_)ACPI_GPE) += acpi_gpe.o
 obj-$(CONFIG_QFW) += qfw_cpu.o
 ifndef CONFIG_SYS_COREBOOT
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += irq.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += irq.o
 endif
 ifndef CONFIG_$(XPL_)X86_64
 obj-$(CONFIG_$(XPL_)SMP) += mp_init.o
diff --git a/arch/x86/cpu/broadwell/Makefile b/arch/x86/cpu/broadwell/Makefile
index 6c6d0edac9b..dfe013e3833 100644
--- a/arch/x86/cpu/broadwell/Makefile
+++ b/arch/x86/cpu/broadwell/Makefile
@@ -2,8 +2,8 @@
 #
 # Copyright (c) 2016 Google, Inc
 
-obj-$(CONFIG_$(SPL_TPL_)X86_16BIT_INIT) += cpu.o
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += cpu_full.o
+obj-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += cpu.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += cpu_full.o
 
 ifdef CONFIG_SPL
 ifndef CONFIG_XPL_BUILD
@@ -18,7 +18,7 @@ obj-y += sata.o
 endif
 endif
 
-ifeq ($(CONFIG_$(SPL_TPL_)X86_32BIT_INIT),)
+ifeq ($(CONFIG_$(PHASE_)X86_32BIT_INIT),)
 #obj-y += cpu_from_spl.o
 endif
 
@@ -29,5 +29,5 @@ obj-y += northbridge.o
 obj-y += pch.o
 obj-y += pinctrl_broadwell.o
 obj-y += power_state.o
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += refcode.o
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += sdram.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += refcode.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += sdram.o
diff --git a/arch/x86/cpu/intel_common/Makefile b/arch/x86/cpu/intel_common/Makefile
index d2db5897377..a28e6c77c9c 100644
--- a/arch/x86/cpu/intel_common/Makefile
+++ b/arch/x86/cpu/intel_common/Makefile
@@ -5,10 +5,10 @@
 obj-$(CONFIG_INTEL_ACPIGEN) += acpi.o
 
 ifdef CONFIG_HAVE_MRC
-obj-$(CONFIG_$(SPL_TPL_)X86_16BIT_INIT) += car.o
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += me_status.o
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += report_platform.o
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += mrc.o
+obj-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += car.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += me_status.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += report_platform.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += mrc.o
 endif
 
 ifndef CONFIG_XPL_BUILD
@@ -28,7 +28,7 @@ obj-y += lpc.o
 obj-y += lpss.o
 obj-$(CONFIG_$(XPL_)INTEL_GENERIC_WIFI) += generic_wifi.o
 ifndef CONFIG_EFI_APP
-obj-$(CONFIG_$(SPL_TPL_)X86_32BIT_INIT) += microcode.o
+obj-$(CONFIG_$(PHASE_)X86_32BIT_INIT) += microcode.o
 ifndef CONFIG_$(XPL_)X86_64
 obj-y += microcode.o
 endif
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index decf2e5c628..8677b2a88dc 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -5,7 +5,7 @@
 
 obj-y	+= bdinfo.o
 
-ifndef CONFIG_$(SPL_TPL_)X86_64
+ifndef CONFIG_$(PHASE_)X86_64
 obj-y += bios.o
 obj-y += bios_asm.o
 obj-y += bios_interrupts.o
@@ -27,7 +27,7 @@ obj-y	+= init_helpers.o
 obj-y	+= interrupts.o
 obj-y	+= lpc-uclass.o
 obj-y	+= mpspec.o
-obj-$(CONFIG_$(SPL_TPL_)ACPIGEN) += acpi_nhlt.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_nhlt.o
 obj-y	+= northbridge-uclass.o
 obj-$(CONFIG_I8259_PIC) += i8259.o
 obj-$(CONFIG_I8254_TIMER) += i8254.o
@@ -44,7 +44,7 @@ obj-y	+= acpi.o
 obj-$(CONFIG_HAVE_ACPI_RESUME) += acpi_s3.o
 ifndef CONFIG_QEMU
 obj-y += acpigen.o
-obj-$(CONFIG_$(SPL_TPL_)GENERATE_ACPI_TABLE) += acpi_table.o
+obj-$(CONFIG_$(PHASE_)GENERATE_ACPI_TABLE) += acpi_table.o
 endif
 obj-y	+= tables.o
 ifndef CONFIG_XPL_BUILD
diff --git a/board/coreboot/coreboot/Makefile b/board/coreboot/coreboot/Makefile
index 75bfbd18943..0abdb7df534 100644
--- a/board/coreboot/coreboot/Makefile
+++ b/board/coreboot/coreboot/Makefile
@@ -11,4 +11,4 @@
 # Daniel Engström, Omicron Ceti AB, daniel@omicron.se.
 
 obj-y	+= coreboot.o
-obj-$(CONFIG_$(SPL_TPL_)SMBIOS_PARSER)	+= sysinfo.o
+obj-$(CONFIG_$(PHASE_)SMBIOS_PARSER)	+= sysinfo.o
diff --git a/boot/Makefile b/boot/Makefile
index 1b6901970e3..b24f806d5bf 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -19,54 +19,54 @@ obj-y += image.o image-board.o
 obj-$(CONFIG_ANDROID_AB) += android_ab.o
 obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
 
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootdev-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootmeth-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootstd-uclass.o
-
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD_PROG) += prog_boot.o
-
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
-obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
-ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootdev-uclass.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootflow.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootmeth-uclass.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
+
+obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
+
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
+obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
+ifdef CONFIG_$(PHASE_)BOOTSTD_FULL
+obj-$(CONFIG_$(PHASE_)EXPO) += bootflow_menu.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootflow_menu.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
-obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) += fdt_simplefb.o
+obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdt_support.o
+obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) += fdt_simplefb.o
 
-obj-$(CONFIG_$(SPL_TPL_)UPL) += upl_common.o
-obj-$(CONFIG_$(SPL_TPL_)UPL_READ) += upl_read.o
-obj-$(CONFIG_$(SPL_TPL_)UPL_WRITE) += upl_write.o
+obj-$(CONFIG_$(PHASE_)UPL) += upl_common.o
+obj-$(CONFIG_$(PHASE_)UPL_READ) += upl_read.o
+obj-$(CONFIG_$(PHASE_)UPL_WRITE) += upl_write.o
 
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
-obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
-obj-$(CONFIG_$(SPL_TPL_)FIT) += image-fit.o
+obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += image-fdt.o
+obj-$(CONFIG_$(PHASE_)FIT_SIGNATURE) += fdt_region.o
+obj-$(CONFIG_$(PHASE_)FIT) += image-fit.o
 obj-$(CONFIG_$(XPL_)MULTI_DTB_FIT) += boot_fit.o common_fit.o
-obj-$(CONFIG_$(SPL_TPL_)IMAGE_PRE_LOAD) += image-pre-load.o
-obj-$(CONFIG_$(SPL_TPL_)IMAGE_SIGN_INFO) += image-sig.o
-obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += image-fit-sig.o
-obj-$(CONFIG_$(SPL_TPL_)FIT_CIPHER) += image-cipher.o
+obj-$(CONFIG_$(PHASE_)IMAGE_PRE_LOAD) += image-pre-load.o
+obj-$(CONFIG_$(PHASE_)IMAGE_SIGN_INFO) += image-sig.o
+obj-$(CONFIG_$(PHASE_)FIT_SIGNATURE) += image-fit-sig.o
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += image-cipher.o
 
 obj-$(CONFIG_CMD_ADTIMG) += image-android-dt.o
 
-obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += common_fit.o
+obj-$(CONFIG_$(PHASE_)LOAD_FIT) += common_fit.o
 
-obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
-obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
+obj-$(CONFIG_$(PHASE_)EXPO) += expo.o scene.o expo_build.o
+obj-$(CONFIG_$(PHASE_)EXPO) += scene_menu.o scene_textline.o
 
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE) += vbe.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_REQUEST) += vbe_request.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE) += vbe.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_REQUEST) += vbe_request.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_ANDROID) += bootmeth_android.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
diff --git a/common/Makefile b/common/Makefile
index ae8984659c0..2ee5ef9cc6e 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -44,8 +44,8 @@ obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
 
 endif # !CONFIG_XPL_BUILD
 
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
-obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
+obj-$(CONFIG_$(PHASE_)BOOTSTAGE) += bootstage.o
+obj-$(CONFIG_$(PHASE_)BLOBLIST) += bloblist.o
 
 ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_DFU
@@ -65,16 +65,16 @@ obj-$(CONFIG_DDR_SPD) += ddr_spd.o
 obj-$(CONFIG_SPD_EEPROM) += ddr_spd.o
 obj-$(CONFIG_HWCONFIG) += hwconfig.o
 obj-$(CONFIG_BOUNCE_BUFFER) += bouncebuf.o
-obj-$(CONFIG_$(SPL_TPL_)SERIAL) += console.o
+obj-$(CONFIG_$(PHASE_)SERIAL) += console.o
 
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
-obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
+obj-$(CONFIG_$(PHASE_)SYS_MALLOC_F) += malloc_simple.o
 
-obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
-obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
+obj-$(CONFIG_$(PHASE_)CYCLIC) += cyclic.o
+obj-$(CONFIG_$(PHASE_)EVENT) += event.o
 
-obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
+obj-$(CONFIG_$(PHASE_)HASH) += hash.o
 obj-$(CONFIG_IO_TRACE) += iotrace.o
 obj-y += memsize.o
 obj-y += stdio.o
@@ -88,15 +88,15 @@ obj-$(CONFIG_FSL_DDR_INTERACTIVE) += cli_getch.o cli_simple.o cli_readline.o
 obj-$(CONFIG_STM32MP1_DDR_INTERACTIVE) += cli_getch.o cli_simple.o cli_readline.o
 obj-$(CONFIG_DFU_OVER_USB) += dfu.o
 obj-y += command.o
-obj-$(CONFIG_$(SPL_TPL_)LOG) += log.o
-obj-$(CONFIG_$(SPL_TPL_)LOG_CONSOLE) += log_console.o
-obj-$(CONFIG_$(SPL_TPL_)LOG_SYSLOG) += log_syslog.o
+obj-$(CONFIG_$(PHASE_)LOG) += log.o
+obj-$(CONFIG_$(PHASE_)LOG_CONSOLE) += log_console.o
+obj-$(CONFIG_$(PHASE_)LOG_SYSLOG) += log_syslog.o
 obj-y += s_record.o
 obj-$(CONFIG_CMD_LOADB) += xyzModem.o
-obj-$(CONFIG_$(SPL_TPL_)YMODEM_SUPPORT) += xyzModem.o
+obj-$(CONFIG_$(PHASE_)YMODEM_SUPPORT) += xyzModem.o
 
-obj-$(CONFIG_$(SPL_TPL_)AVB_VERIFY) += avb_verify.o
-obj-$(CONFIG_$(SPL_TPL_)STACKPROTECTOR) += stackprot.o
+obj-$(CONFIG_$(PHASE_)AVB_VERIFY) += avb_verify.o
+obj-$(CONFIG_$(PHASE_)STACKPROTECTOR) += stackprot.o
 obj-$(CONFIG_SCP03) += scp03.o
 
 obj-$(CONFIG_QFW) += qfw.o
diff --git a/common/bootstage.c b/common/bootstage.c
index 49acc9078a6..72d80ee9fe5 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -351,7 +351,7 @@ void bootstage_report(void)
 	}
 	if (data->rec_count > RECORD_COUNT)
 		printf("Overflowed internal boot id table by %d entries\n"
-		       "Please increase CONFIG_(SPL_TPL_)BOOTSTAGE_RECORD_COUNT\n",
+		       "Please increase CONFIG_(PHASE_)BOOTSTAGE_RECORD_COUNT\n",
 		       data->rec_count - RECORD_COUNT);
 
 	puts("\nAccumulated time:\n");
@@ -473,7 +473,7 @@ int bootstage_unstash(const void *base, int size)
 
 	if (data->rec_count + hdr->count > RECORD_COUNT) {
 		debug("%s: Bootstage has %d records, we have space for %d\n"
-			"Please increase CONFIG_(SPL_)BOOTSTAGE_RECORD_COUNT\n",
+			"Please increase CONFIG_(PHASE_)BOOTSTAGE_RECORD_COUNT\n",
 		      __func__, hdr->count, RECORD_COUNT - data->rec_count);
 		return -ENOSPC;
 	}
diff --git a/common/init/Makefile b/common/init/Makefile
index 853b56d1e57..224e092f88c 100644
--- a/common/init/Makefile
+++ b/common/init/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += board_init.o
-obj-$(CONFIG_$(SPL_TPL_)HANDOFF) += handoff.o
+obj-$(CONFIG_$(PHASE_)HANDOFF) += handoff.o
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 10528b31a7c..75123eb666b 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -7,35 +7,35 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTROM_SUPPORT) += spl_bootrom.o
-obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += spl_fit.o
-obj-$(CONFIG_$(SPL_TPL_)BLK_FS) += spl_blk_fs.o
-obj-$(CONFIG_$(SPL_TPL_)LEGACY_IMAGE_FORMAT) += spl_legacy.o
-obj-$(CONFIG_$(SPL_TPL_)NOR_SUPPORT) += spl_nor.o
-obj-$(CONFIG_$(SPL_TPL_)XIP_SUPPORT) += spl_xip.o
-obj-$(CONFIG_$(SPL_TPL_)YMODEM_SUPPORT) += spl_ymodem.o
+obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
+obj-$(CONFIG_$(PHASE_)BOOTROM_SUPPORT) += spl_bootrom.o
+obj-$(CONFIG_$(PHASE_)LOAD_FIT) += spl_fit.o
+obj-$(CONFIG_$(PHASE_)BLK_FS) += spl_blk_fs.o
+obj-$(CONFIG_$(PHASE_)LEGACY_IMAGE_FORMAT) += spl_legacy.o
+obj-$(CONFIG_$(PHASE_)NOR_SUPPORT) += spl_nor.o
+obj-$(CONFIG_$(PHASE_)XIP_SUPPORT) += spl_xip.o
+obj-$(CONFIG_$(PHASE_)YMODEM_SUPPORT) += spl_ymodem.o
 ifndef CONFIG_SPL_UBI
-obj-$(CONFIG_$(SPL_TPL_)NAND_SUPPORT) += spl_nand.o
-obj-$(CONFIG_$(SPL_TPL_)ONENAND_SUPPORT) += spl_onenand.o
+obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += spl_nand.o
+obj-$(CONFIG_$(PHASE_)ONENAND_SUPPORT) += spl_onenand.o
 endif
-obj-$(CONFIG_$(SPL_TPL_)UBI) += spl_ubi.o
-obj-$(CONFIG_$(SPL_TPL_)NET) += spl_net.o
-obj-$(CONFIG_$(SPL_TPL_)MMC) += spl_mmc.o
-obj-$(CONFIG_$(SPL_TPL_)ATF) += spl_atf.o
-obj-$(CONFIG_$(SPL_TPL_)OPTEE_IMAGE) += spl_optee.o
-obj-$(CONFIG_$(SPL_TPL_)OPENSBI) += spl_opensbi.o
-obj-$(CONFIG_$(SPL_TPL_)USB_STORAGE) += spl_usb.o
-obj-$(CONFIG_$(SPL_TPL_)FS_FAT) += spl_fat.o
-obj-$(CONFIG_$(SPL_TPL_)FS_EXT4) += spl_ext.o
-obj-$(CONFIG_$(SPL_TPL_)LOAD_IMX_CONTAINER) += spl_imx_container.o
-obj-$(CONFIG_$(SPL_TPL_)SATA) += spl_sata.o
-obj-$(CONFIG_$(SPL_TPL_)NVME) += spl_nvme.o
-obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += spl_semihosting.o
-obj-$(CONFIG_$(SPL_TPL_)DFU) += spl_dfu.o
-obj-$(CONFIG_$(SPL_TPL_)SPI_LOAD) += spl_spi.o
-obj-$(CONFIG_$(SPL_TPL_)RAM_SUPPORT) += spl_ram.o
-obj-$(CONFIG_$(SPL_TPL_)USB_SDP_SUPPORT) += spl_sdp.o
+obj-$(CONFIG_$(PHASE_)UBI) += spl_ubi.o
+obj-$(CONFIG_$(PHASE_)NET) += spl_net.o
+obj-$(CONFIG_$(PHASE_)MMC) += spl_mmc.o
+obj-$(CONFIG_$(PHASE_)ATF) += spl_atf.o
+obj-$(CONFIG_$(PHASE_)OPTEE_IMAGE) += spl_optee.o
+obj-$(CONFIG_$(PHASE_)OPENSBI) += spl_opensbi.o
+obj-$(CONFIG_$(PHASE_)USB_STORAGE) += spl_usb.o
+obj-$(CONFIG_$(PHASE_)FS_FAT) += spl_fat.o
+obj-$(CONFIG_$(PHASE_)FS_EXT4) += spl_ext.o
+obj-$(CONFIG_$(PHASE_)LOAD_IMX_CONTAINER) += spl_imx_container.o
+obj-$(CONFIG_$(PHASE_)SATA) += spl_sata.o
+obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
+obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
+obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
+obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
+obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
+obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)UPL) += spl_upl.o
+obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
diff --git a/disk/Makefile b/disk/Makefile
index 45588cf66e4..2248a659f8b 100644
--- a/disk/Makefile
+++ b/disk/Makefile
@@ -5,16 +5,16 @@
 
 #ccflags-y += -DET_DEBUG -DDEBUG
 
-obj-$(CONFIG_$(SPL_TPL_)PARTITIONS)  += part.o
-ifdef CONFIG_$(SPL_TPL_)BLK
-obj-$(CONFIG_$(SPL_TPL_)PARTITIONS)  += disk-uclass.o
+obj-$(CONFIG_$(PHASE_)PARTITIONS)  += part.o
+ifdef CONFIG_$(PHASE_)BLK
+obj-$(CONFIG_$(PHASE_)PARTITIONS)  += disk-uclass.o
 endif
 
 # Must have BLK or SPL_LEGACY_BLOCK to support partitions
-ifneq ($(CONFIG_$(SPL_TPL_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
-obj-$(CONFIG_$(SPL_TPL_)MAC_PARTITION)   += part_mac.o
-obj-$(CONFIG_$(SPL_TPL_)DOS_PARTITION)   += part_dos.o
-obj-$(CONFIG_$(SPL_TPL_)ISO_PARTITION)   += part_iso.o
-obj-$(CONFIG_$(SPL_TPL_)AMIGA_PARTITION) += part_amiga.o
-obj-$(CONFIG_$(SPL_TPL_)EFI_PARTITION)   += part_efi.o
+ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
+obj-$(CONFIG_$(PHASE_)MAC_PARTITION)   += part_mac.o
+obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
+obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
+obj-$(CONFIG_$(PHASE_)AMIGA_PARTITION) += part_amiga.o
+obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
 endif
diff --git a/drivers/Makefile b/drivers/Makefile
index fd247265fe5..af593501261 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -1,43 +1,43 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_$(SPL_TPL_)ADC) += adc/
-obj-$(CONFIG_$(SPL_TPL_)BIOSEMU) += bios_emulator/
-obj-$(CONFIG_$(SPL_TPL_)BLK) += block/
-obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
-obj-$(CONFIG_$(SPL_TPL_)BUTTON) += button/
-obj-$(CONFIG_$(SPL_TPL_)CACHE) += cache/
-obj-$(CONFIG_$(SPL_TPL_)CLK) += clk/
-obj-$(CONFIG_$(SPL_TPL_)DM) += core/
-obj-$(CONFIG_$(SPL_TPL_)DMA) += dma/
-obj-$(CONFIG_$(SPL_TPL_)DMA_LEGACY) += dma/
-obj-$(CONFIG_$(SPL_TPL_)DFU) += dfu/
-obj-$(CONFIG_$(SPL_TPL_)EXTCON) += extcon/
-obj-$(CONFIG_$(SPL_TPL_)GPIO) += gpio/
-obj-$(CONFIG_$(SPL_TPL_)DRIVERS_MISC) += misc/
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET) += sysreset/
-obj-$(CONFIG_$(SPL_TPL_)FIRMWARE) +=firmware/
-obj-$(CONFIG_$(SPL_TPL_)I2C) += i2c/
-obj-$(CONFIG_$(SPL_TPL_)INPUT) += input/
-obj-$(CONFIG_$(SPL_TPL_)LED) += led/
-obj-$(CONFIG_$(SPL_TPL_)MMC) += mmc/
+obj-$(CONFIG_$(PHASE_)ADC) += adc/
+obj-$(CONFIG_$(PHASE_)BIOSEMU) += bios_emulator/
+obj-$(CONFIG_$(PHASE_)BLK) += block/
+obj-$(CONFIG_$(PHASE_)BOOTCOUNT_LIMIT) += bootcount/
+obj-$(CONFIG_$(PHASE_)BUTTON) += button/
+obj-$(CONFIG_$(PHASE_)CACHE) += cache/
+obj-$(CONFIG_$(PHASE_)CLK) += clk/
+obj-$(CONFIG_$(PHASE_)DM) += core/
+obj-$(CONFIG_$(PHASE_)DMA) += dma/
+obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
+obj-$(CONFIG_$(PHASE_)DFU) += dfu/
+obj-$(CONFIG_$(PHASE_)EXTCON) += extcon/
+obj-$(CONFIG_$(PHASE_)GPIO) += gpio/
+obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
+obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
+obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
+obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)INPUT) += input/
+obj-$(CONFIG_$(PHASE_)LED) += led/
+obj-$(CONFIG_$(PHASE_)MMC) += mmc/
 obj-y += mtd/
-obj-$(CONFIG_$(SPL_TPL_)ETH) += net/
-obj-$(CONFIG_$(SPL_TPL_)PCH) += pch/
-obj-$(CONFIG_$(SPL_TPL_)PCI) += pci/
-obj-$(CONFIG_$(SPL_TPL_)PHY) += phy/
-obj-$(CONFIG_$(SPL_TPL_)PINCTRL) += pinctrl/
-obj-$(CONFIG_$(SPL_TPL_)POWER) += power/
-obj-$(CONFIG_$(SPL_TPL_)RAM) += ram/
-obj-$(CONFIG_$(SPL_TPL_)RTC) += rtc/
-obj-$(CONFIG_$(SPL_TPL_)SERIAL) += serial/
-obj-$(CONFIG_$(SPL_TPL_)SPI) += spi/
-obj-$(CONFIG_$(SPL_TPL_)TIMER) += timer/
-obj-$(CONFIG_$(SPL_TPL_)VIRTIO) += virtio/
+obj-$(CONFIG_$(PHASE_)ETH) += net/
+obj-$(CONFIG_$(PHASE_)PCH) += pch/
+obj-$(CONFIG_$(PHASE_)PCI) += pci/
+obj-$(CONFIG_$(PHASE_)PHY) += phy/
+obj-$(CONFIG_$(PHASE_)PINCTRL) += pinctrl/
+obj-$(CONFIG_$(PHASE_)POWER) += power/
+obj-$(CONFIG_$(PHASE_)RAM) += ram/
+obj-$(CONFIG_$(PHASE_)RTC) += rtc/
+obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
+obj-$(CONFIG_$(PHASE_)SPI) += spi/
+obj-$(CONFIG_$(PHASE_)TIMER) += timer/
+obj-$(CONFIG_$(PHASE_)VIRTIO) += virtio/
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox/
 obj-$(CONFIG_$(XPL_)REMOTEPROC) += remoteproc/
 obj-$(CONFIG_$(XPL_)SYSINFO) += sysinfo/
-obj-$(CONFIG_$(SPL_TPL_)SM) += sm/
-obj-$(CONFIG_$(SPL_TPL_)TPM) += tpm/
+obj-$(CONFIG_$(PHASE_)SM) += sm/
+obj-$(CONFIG_$(PHASE_)TPM) += tpm/
 obj-$(CONFIG_$(XPL_)NVME) += nvme/
 obj-$(CONFIG_XEN) += xen/
 obj-$(CONFIG_$(XPL_)FPGA) += fpga/
@@ -122,7 +122,7 @@ obj-$(CONFIG_W1_EEPROM) += w1-eeprom/
 obj-$(CONFIG_MACH_PIC32) += ddr/microchip/
 obj-$(CONFIG_FUZZ) += fuzz/
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock/
-obj-$(CONFIG_$(SPL_TPL_)DM_RNG) += rng/
+obj-$(CONFIG_$(PHASE_)DM_RNG) += rng/
 endif
 
 obj-y += soc/
diff --git a/drivers/adc/Makefile b/drivers/adc/Makefile
index dca0b39c2e2..665a7965412 100644
--- a/drivers/adc/Makefile
+++ b/drivers/adc/Makefile
@@ -4,7 +4,7 @@
 # Przemyslaw Marczak <p.marczak@samsung.com>
 #
 
-obj-$(CONFIG_$(SPL_TPL_)ADC) += adc-uclass.o
+obj-$(CONFIG_$(PHASE_)ADC) += adc-uclass.o
 obj-$(CONFIG_ADC_EXYNOS) += exynos-adc.o
 obj-$(CONFIG_ADC_SANDBOX) += sandbox.o
 obj-$(CONFIG_SARADC_ROCKCHIP) += rockchip-saradc.o
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 98a34c01c38..ee290620545 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)BLK) += blk-uclass.o
+obj-$(CONFIG_$(PHASE_)BLK) += blk-uclass.o
 
 ifndef CONFIG_$(XPL_)BLK
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
@@ -14,9 +14,9 @@ obj-$(CONFIG_IDE) += ide.o
 obj-$(CONFIG_RKMTD) += rkmtd.o
 endif
 obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
-obj-$(CONFIG_$(SPL_TPL_)BLOCK_CACHE) += blkcache.o
-obj-$(CONFIG_$(SPL_TPL_)BLKMAP) += blkmap.o
-obj-$(CONFIG_$(SPL_TPL_)BLKMAP) += blkmap_helper.o
+obj-$(CONFIG_$(PHASE_)BLOCK_CACHE) += blkcache.o
+obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap.o
+obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap_helper.o
 
 obj-$(CONFIG_EFI_MEDIA) += efi-media-uclass.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += sb_efi_media.o
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index e1b71e0ed51..2f683866b87 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -1,5 +1,5 @@
 
-obj-$(CONFIG_$(SPL_TPL_)CACHE) += cache-uclass.o
+obj-$(CONFIG_$(PHASE_)CACHE) += cache-uclass.o
 obj-$(CONFIG_SANDBOX) += sandbox_cache.o
 obj-$(CONFIG_L2X0_CACHE) += cache-l2x0.o
 obj-$(CONFIG_NCORE_CACHE) += cache-ncore.o
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f9b90a38b00..7f84f22d4b1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,13 +4,13 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
-obj-$(CONFIG_$(SPL_TPL_)CLK) += clk-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_rate.o
-obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_factor.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-fixed-factor.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_COMPOSITE_CCF) += clk-composite.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_GPIO) += clk-gpio.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
+obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
+obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 
 obj-y += adi/
 obj-y += analogbits/
@@ -18,7 +18,7 @@ obj-y += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
 obj-y += tegra/
 obj-y += ti/
-obj-$(CONFIG_$(SPL_TPL_)CLK_INTEL) += intel/
+obj-$(CONFIG_$(PHASE_)CLK_INTEL) += intel/
 obj-$(CONFIG_ARCH_ASPEED) += aspeed/
 obj-$(CONFIG_ARCH_MEDIATEK) += mediatek/
 obj-$(CONFIG_ARCH_MESON) += meson/
@@ -42,7 +42,7 @@ obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
 obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
-obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
+obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
 obj-$(CONFIG_CLK_SUNXI) += sunxi/
diff --git a/drivers/clk/exynos/Makefile b/drivers/clk/exynos/Makefile
index 734100e2bff..77385864fef 100644
--- a/drivers/clk/exynos/Makefile
+++ b/drivers/clk/exynos/Makefile
@@ -7,6 +7,6 @@
 #   Thomas Abraham <thomas.ab@samsung.com>
 #   Sam Protsenko <semen.protsenko@linaro.org>
 
-obj-$(CONFIG_$(SPL_TPL_)CLK_CCF)	+= clk.o clk-pll.o
+obj-$(CONFIG_$(PHASE_)CLK_CCF)	+= clk.o clk-pll.o
 obj-$(CONFIG_CLK_EXYNOS7420)		+= clk-exynos7420.o
 obj-$(CONFIG_CLK_EXYNOS850)		+= clk-exynos850.o
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 6d4bcd35714..a89ee7acb12 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -2,25 +2,25 @@
 #
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-gate2.o clk-pllv3.o clk-pfd.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMX6Q) += clk-imx6q.o
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-gate2.o clk-pllv3.o clk-pfd.o
+obj-$(CONFIG_$(PHASE_)CLK_IMX6Q) += clk-imx6q.o
 obj-$(CONFIG_CLK_IMX8) += clk-imx8.o
 
 ifdef CONFIG_CLK_IMX8
 obj-$(CONFIG_IMX8QXP) += clk-imx8qxp.o
 obj-$(CONFIG_IMX8QM) += clk-imx8qm.o
 endif
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMX8MM) += clk-imx8mm.o clk-pll14xx.o \
+obj-$(CONFIG_$(PHASE_)CLK_IMX8MM) += clk-imx8mm.o clk-pll14xx.o \
 				clk-composite-8m.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMX8MN) += clk-imx8mn.o clk-pll14xx.o \
+obj-$(CONFIG_$(PHASE_)CLK_IMX8MN) += clk-imx8mn.o clk-pll14xx.o \
 				clk-composite-8m.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMX8MP) += clk-imx8mp.o clk-pll14xx.o \
+obj-$(CONFIG_$(PHASE_)CLK_IMX8MP) += clk-imx8mp.o clk-pll14xx.o \
 				clk-composite-8m.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMX8MQ) += clk-imx8mq.o clk-pll14xx.o \
+obj-$(CONFIG_$(PHASE_)CLK_IMX8MQ) += clk-imx8mq.o clk-pll14xx.o \
 				clk-composite-8m.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMX93) += clk-imx93.o clk-fracn-gppll.o \
+obj-$(CONFIG_$(PHASE_)CLK_IMX93) += clk-imx93.o clk-fracn-gppll.o \
 				clk-gate-93.o clk-composite-93.o
 
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMXRT1020) += clk-imxrt1020.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMXRT1050) += clk-imxrt1050.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_IMXRT1170) += clk-imxrt1170.o
+obj-$(CONFIG_$(PHASE_)CLK_IMXRT1020) += clk-imxrt1020.o
+obj-$(CONFIG_$(PHASE_)CLK_IMXRT1050) += clk-imxrt1050.o
+obj-$(CONFIG_$(PHASE_)CLK_IMXRT1170) += clk-imxrt1170.o
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 07aa9a53e08..a58f19f46d9 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -11,5 +11,5 @@ obj-$(CONFIG_CLK_TI_DIVIDER) += clk-divider.o
 obj-$(CONFIG_CLK_TI_GATE) += clk-gate.o
 obj-$(CONFIG_CLK_TI_MUX) += clk-mux.o
 obj-$(CONFIG_CLK_TI_SCI) += clk-sci.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_K3_PLL) += clk-k3-pll.o
-obj-$(CONFIG_$(SPL_TPL_)CLK_K3) += clk-k3.o
+obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) += clk-k3-pll.o
+obj-$(CONFIG_$(PHASE_)CLK_K3) += clk-k3.o
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index 20dbff6f956..9ea57911f89 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -3,14 +3,14 @@
 # Copyright (c) 2013 Google, Inc
 
 obj-y	+= device.o fdtaddr.o lists.o root.o uclass.o util.o tag.o
-obj-$(CONFIG_$(SPL_TPL_)ACPIGEN) += acpi.o
-obj-$(CONFIG_$(SPL_TPL_)DEVRES) += devres.o
-obj-$(CONFIG_$(SPL_TPL_)DM_DEVICE_REMOVE)	+= device-remove.o
+obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
+obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
+obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)	+= device-remove.o
 obj-$(CONFIG_$(XPL_)SIMPLE_BUS)	+= simple-bus.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
-obj-$(CONFIG_$(SPL_TPL_)REGMAP)	+= regmap.o
-obj-$(CONFIG_$(SPL_TPL_)SYSCON)	+= syscon-uclass.o
+obj-$(CONFIG_$(PHASE_)REGMAP)	+= regmap.o
+obj-$(CONFIG_$(PHASE_)SYSCON)	+= syscon-uclass.o
 obj-$(CONFIG_$(XPL_)OF_LIVE) += of_access.o of_addr.o
 ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
index 4fbce519a0b..965c4938c8c 100644
--- a/drivers/crypto/fsl/Makefile
+++ b/drivers/crypto/fsl/Makefile
@@ -6,6 +6,6 @@ obj-y += sec.o
 obj-$(CONFIG_FSL_CAAM) += jr.o fsl_hash.o jobdesc.o error.o
 obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) += fsl_blob.o
 obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
-obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) += rng.o
+obj-$(CONFIG_$(PHASE_)FSL_CAAM_RNG) += rng.o
 obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
 obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 24d1b0394fb..21b4325e4f9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_DWAPB_GPIO)	+= dwapb_gpio.o
 obj-$(CONFIG_AXP_GPIO)		+= axp_gpio.o
 obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
 endif
-obj-$(CONFIG_$(SPL_TPL_)DM_GPIO) += gpio-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_GPIO) += gpio-uclass.o
 
 obj-$(CONFIG_$(XPL_)DM_PCA953X)	+= pca953x_gpio.o
 
@@ -24,7 +24,7 @@ obj-$(CONFIG_INTEL_ICH6_GPIO)	+= intel_ich6_gpio.o
 obj-$(CONFIG_INTEL_BROADWELL_GPIO)	+= intel_broadwell_gpio.o
 obj-$(CONFIG_IPROC_GPIO)	+= iproc_gpio.o
 obj-$(CONFIG_KIRKWOOD_GPIO)	+= kw_gpio.o
-obj-$(CONFIG_$(SPL_TPL_)MCP230XX_GPIO)	+= mcp230xx_gpio.o
+obj-$(CONFIG_$(PHASE_)MCP230XX_GPIO)	+= mcp230xx_gpio.o
 obj-$(CONFIG_MXC_GPIO)	+= mxc_gpio.o
 obj-$(CONFIG_MXS_GPIO)	+= mxs_gpio.o
 obj-$(CONFIG_NPCM_GPIO)      	+= npcm_gpio.o
@@ -63,7 +63,7 @@ obj-$(CONFIG_OCTEON_GPIO)	+= octeon_gpio.o
 obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
 obj-$(CONFIG_MSM_GPIO)		+= msm_gpio.o
 obj-$(CONFIG_$(XPL_)PCF8575_GPIO)	+= pcf8575_gpio.o
-obj-$(CONFIG_$(SPL_TPL_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o
+obj-$(CONFIG_$(PHASE_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o
 obj-$(CONFIG_MT7620_GPIO)	+= mt7620_gpio.o
 obj-$(CONFIG_MT7621_GPIO)	+= mt7621_gpio.o
 obj-$(CONFIG_MSCC_SGPIO)	+= mscc_sgpio.o
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 3e855346bce..8d4107b8848 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -3,9 +3,9 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)CROS_EC_KEYB) += cros_ec_keyb.o
-obj-$(CONFIG_$(SPL_TPL_)OF_CONTROL) += key_matrix.o
-obj-$(CONFIG_$(SPL_TPL_)DM_KEYBOARD) += input.o keyboard-uclass.o
+obj-$(CONFIG_$(PHASE_)CROS_EC_KEYB) += cros_ec_keyb.o
+obj-$(CONFIG_$(PHASE_)OF_CONTROL) += key_matrix.o
+obj-$(CONFIG_$(PHASE_)DM_KEYBOARD) += input.o keyboard-uclass.o
 obj-$(CONFIG_BUTTON_KEYBOARD) += button_kbd.o
 
 ifndef CONFIG_XPL_BUILD
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 794c2a2d38e..79e54c4a1b5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -3,12 +3,12 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)MISC) += misc-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)NVMEM) += nvmem.o
+obj-$(CONFIG_$(PHASE_)MISC) += misc-uclass.o
+obj-$(CONFIG_$(PHASE_)NVMEM) += nvmem.o
 
-obj-$(CONFIG_$(SPL_TPL_)CROS_EC) += cros_ec.o
-obj-$(CONFIG_$(SPL_TPL_)CROS_EC_SANDBOX) += cros_ec_sandbox.o
-obj-$(CONFIG_$(SPL_TPL_)CROS_EC_LPC) += cros_ec_lpc.o
+obj-$(CONFIG_$(PHASE_)CROS_EC) += cros_ec.o
+obj-$(CONFIG_$(PHASE_)CROS_EC_SANDBOX) += cros_ec_sandbox.o
+obj-$(CONFIG_$(PHASE_)CROS_EC_LPC) += cros_ec_lpc.o
 
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += sandbox_adder.o
@@ -51,7 +51,7 @@ obj-$(CONFIG_IMX_ELE) += imx_ele/
 obj-$(CONFIG_LED_STATUS) += status_led.o
 obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
-obj-$(CONFIG_$(SPL_TPL_)LS2_SFP) += ls2_sfp.o
+obj-$(CONFIG_$(PHASE_)LS2_SFP) += ls2_sfp.o
 obj-$(CONFIG_$(XPL_)MXC_OCOTP) += mxc_ocotp.o
 obj-$(CONFIG_MXS_OCOTP) += mxs_ocotp.o
 obj-$(CONFIG_NPCM_OTP) += npcm_otp.o
@@ -70,7 +70,7 @@ obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o
-obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
+obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
 obj-$(CONFIG_SIFIVE_OTP) += sifive-otp.o
 obj-$(CONFIG_SMSC_LPC47M) += smsc_lpc47m.o
@@ -81,7 +81,7 @@ obj-$(CONFIG_SYS_DPAA_QBMAN) += fsl_portals.o
 obj-$(CONFIG_TEGRA186_BPMP) += tegra186_bpmp.o
 obj-$(CONFIG_TEGRA_CAR) += tegra_car.o
 obj-$(CONFIG_TEST_DRV) += test_drv.o
-obj-$(CONFIG_$(SPL_TPL_)TURRIS_OMNIA_MCU) += turris_omnia_mcu.o
+obj-$(CONFIG_$(PHASE_)TURRIS_OMNIA_MCU) += turris_omnia_mcu.o
 obj-$(CONFIG_TWL4030_LED) += twl4030_led.o
 obj-$(CONFIG_VEXPRESS_CONFIG) += vexpress_config.o
 obj-$(CONFIG_WINBOND_W83627) += winbond_w83627.o
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 328653b8823..868f3090ff2 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -6,11 +6,11 @@
 obj-y += mmc.o
 obj-$(CONFIG_$(XPL_)DM_MMC) += mmc-uclass.o
 
-ifdef CONFIG_$(SPL_TPL_)DM_MMC
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
+ifdef CONFIG_$(PHASE_)DM_MMC
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += mmc_bootdev.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
+obj-$(CONFIG_$(PHASE_)MMC_WRITE) += mmc_write.o
 obj-$(CONFIG_$(XPL_)MMC_PWRSEQ) += mmc-pwrseq.o
 obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
 
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 2388d2aa27c..e204f19ff8b 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -34,9 +34,9 @@ else
 ifneq ($(mtd-y),)
 obj-$(CONFIG_SPL_MTD) += mtd.o
 endif
-obj-$(CONFIG_$(SPL_TPL_)NAND_SUPPORT) += nand/
+obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
-obj-$(CONFIG_$(SPL_TPL_)SPI_FLASH_SUPPORT) += spi/
+obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
 obj-$(CONFIG_SPL_UBI) += ubispl/
 
 endif
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index ad02095b35b..cf53c5f601e 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -6,5 +6,5 @@ obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
 else
-obj-$(CONFIG_$(SPL_TPL_)NAND_SUPPORT) += raw/
+obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
 endif
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index ca10ac7aecb..b47a3d787ce 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SPL_NAND_BASE) += nand_base.o nand_amd.o nand_hynix.o \
 				nand_macronix.o nand_micron.o \
 				nand_samsung.o nand_toshiba.o
 obj-$(CONFIG_SPL_NAND_IDENT) += nand_ids.o nand_timings.o
-obj-$(CONFIG_$(SPL_TPL_)NAND_INIT) += nand.o
+obj-$(CONFIG_$(PHASE_)NAND_INIT) += nand.o
 ifeq ($(CONFIG_SPL_ENV_SUPPORT),y)
 obj-$(CONFIG_ENV_IS_IN_NAND) += nand_util.o
 endif
diff --git a/drivers/mtd/spi/Makefile b/drivers/mtd/spi/Makefile
index 2a287a62a47..44e67cd913a 100644
--- a/drivers/mtd/spi/Makefile
+++ b/drivers/mtd/spi/Makefile
@@ -3,12 +3,12 @@
 # (C) Copyright 2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)DM_SPI_FLASH) += sf-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_SPI_FLASH) += sf-uclass.o
 spi-nor-y := sf_probe.o spi-nor-ids.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_SPI_BOOT)	+= fsl_espi_spl.o
-ifeq ($(CONFIG_$(SPL_TPL_)SPI_FLASH_TINY),y)
+ifeq ($(CONFIG_$(PHASE_)SPI_FLASH_TINY),y)
 spi-nor-y += spi-nor-tiny.o
 else
 spi-nor-y += spi-nor-core.o
@@ -19,6 +19,6 @@ endif
 
 obj-$(CONFIG_SPI_FLASH) += spi-nor.o
 obj-$(CONFIG_SPI_FLASH_DATAFLASH) += sf_dataflash.o
-obj-$(CONFIG_$(SPL_TPL_)SPI_FLASH_MTD) += sf_mtd.o
+obj-$(CONFIG_$(PHASE_)SPI_FLASH_MTD) += sf_mtd.o
 obj-$(CONFIG_SPI_FLASH_SANDBOX) += sandbox.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_SPI_FLASH) += sf_bootdev.o
+obj-$(CONFIG_$(PHASE_)BOOTDEV_SPI_FLASH) += sf_bootdev.o
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index a4a12069b36..1503153ddc9 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -1,6 +1,6 @@
 
 # SPDX-License-Identifier: GPL-2.0
 # Core
-obj-$(CONFIG_$(SPL_TPL_)PINCTRL_STARFIVE) += pinctrl-starfive.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_STARFIVE) += pinctrl-starfive.o
 # SoC Drivers
-obj-$(CONFIG_$(SPL_TPL_)PINCTRL_STARFIVE_JH7110)	+= pinctrl-jh7110-sys.o pinctrl-jh7110-aon.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_STARFIVE_JH7110)	+= pinctrl-jh7110-sys.o pinctrl-jh7110-aon.o
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 5a987194cda..3f4d56f5139 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -3,8 +3,8 @@
 # Copyright (c) 2009 Wind River Systems, Inc.
 # Tom Rix <Tom.Rix at windriver.com>
 
-obj-$(CONFIG_$(SPL_TPL_)ACPI_PMC) += acpi_pmc/
-obj-$(CONFIG_$(SPL_TPL_)POWER_DOMAIN) += domain/
+obj-$(CONFIG_$(PHASE_)ACPI_PMC) += acpi_pmc/
+obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += domain/
 obj-y += pmic/
 obj-y += regulator/
 
@@ -23,9 +23,9 @@ obj-$(CONFIG_SY8106A_POWER)	+= sy8106a.o
 obj-$(CONFIG_TPS6586X_POWER)	+= tps6586x.o
 obj-$(CONFIG_TWL4030_POWER)	+= twl4030.o
 obj-$(CONFIG_PALMAS_POWER)	+= palmas.o
-obj-$(CONFIG_$(SPL_TPL_)POWER_LEGACY) += power_core.o
+obj-$(CONFIG_$(PHASE_)POWER_LEGACY) += power_core.o
 obj-$(CONFIG_DIALOG_POWER) += power_dialog.o
 obj-$(CONFIG_POWER_FSL) += power_fsl.o
-obj-$(CONFIG_$(SPL_TPL_)POWER_I2C) += power_i2c.o
+obj-$(CONFIG_$(PHASE_)POWER_I2C) += power_i2c.o
 obj-$(CONFIG_POWER_SPI) += power_spi.o
 obj-$(CONFIG_POWER_MT6323) += mt6323.o
diff --git a/drivers/power/acpi_pmc/Makefile b/drivers/power/acpi_pmc/Makefile
index 0db52a65824..3259b397a9a 100644
--- a/drivers/power/acpi_pmc/Makefile
+++ b/drivers/power/acpi_pmc/Makefile
@@ -3,4 +3,4 @@
 # Copyright 2019 Google LLC
 
 obj-y += acpi-pmc-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)ACPI_PMC_SANDBOX) += sandbox.o pmc_emul.o
+obj-$(CONFIG_$(PHASE_)ACPI_PMC_SANDBOX) += sandbox.o pmc_emul.o
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 48f7dd49ef8..bc138f563ff 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2012 Samsung Electronics
 # Lukasz Majewski <l.majewski@samsung.com>
 
-obj-$(CONFIG_$(SPL_TPL_)DM_PMIC) += pmic-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC) += pmic-uclass.o
 obj-$(CONFIG_$(XPL_)DM_PMIC_FAN53555) += fan53555.o
 obj-$(CONFIG_$(XPL_)DM_PMIC_DA9063) += da9063.o
 obj-$(CONFIG_$(XPL_)DM_PMIC_MAX77663) += max77663.o
@@ -22,7 +22,7 @@ obj-$(CONFIG_PMIC_AS3722) += as3722.o as3722_gpio.o
 obj-$(CONFIG_$(XPL_)PMIC_AXP) += axp.o
 obj-$(CONFIG_PMIC_MAX8997) += max8997.o
 obj-$(CONFIG_PMIC_QCOM) += pmic_qcom.o
-obj-$(CONFIG_$(SPL_TPL_)PMIC_RK8XX) += rk8xx.o
+obj-$(CONFIG_$(PHASE_)PMIC_RK8XX) += rk8xx.o
 obj-$(CONFIG_$(XPL_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o
 obj-$(CONFIG_PMIC_S5M8767) += s5m8767.o
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index cac02aaa36f..ca6c89d13b5 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_$(XPL_)DM_REGULATOR_COMMON) += regulator_common.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_FIXED) += fixed.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
-obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
+obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
index 35d8f5761e1..f92e86eaa3f 100644
--- a/drivers/ram/Makefile
+++ b/drivers/ram/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2015 Google, Inc
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
-obj-$(CONFIG_$(SPL_TPL_)DM) += ram-uclass.o
+obj-$(CONFIG_$(PHASE_)DM) += ram-uclass.o
 obj-$(CONFIG_MPC83XX_SDRAM) += mpc83xx_sdram.o
 obj-$(CONFIG_SANDBOX) += sandbox_ram.o
 obj-$(CONFIG_STM32MP1_DDR) += stm32mp1/
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 2eb639e4a65..d99a78c9828 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -32,4 +32,4 @@ obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o
 obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
-obj-$(CONFIG_$(SPL_TPL_)RESET_JH7110) += reset-jh7110.o
+obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 30553c9d6e9..30c58272d41 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2019, Linaro Limited
 #
 
-obj-$(CONFIG_$(SPL_TPL_)DM_RNG) += rng-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_RNG) += rng-uclass.o
 obj-$(CONFIG_RNG_MESON) += meson-rng.o
 obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
 obj-$(CONFIG_RNG_MSM) += msm_rng.o
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 03a424c31a5..99b5a2a346a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #ccflags-y += -DDEBUG
 
-obj-$(CONFIG_$(SPL_TPL_)DM_RTC) += rtc-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
@@ -17,7 +17,7 @@ obj-$(CONFIG_RTC_DS3232) += ds3232.o
 obj-$(CONFIG_RTC_EMULATION) += emul_rtc.o
 obj-$(CONFIG_RTC_GOLDFISH) += goldfish_rtc.o
 obj-$(CONFIG_RTC_HT1380) += ht1380.o
-obj-$(CONFIG_$(SPL_TPL_)RTC_SANDBOX) += i2c_rtc_emul.o
+obj-$(CONFIG_$(PHASE_)RTC_SANDBOX) += i2c_rtc_emul.o
 obj-$(CONFIG_RTC_ISL1208) += isl1208.o
 obj-$(CONFIG_RTC_M41T62) += m41t62.o
 obj-$(CONFIG_RTC_MAX313XX) += max313xx.o
@@ -37,6 +37,6 @@ obj-$(CONFIG_RTC_RX8025) += rx8025.o
 obj-$(CONFIG_RTC_RX8010SJ) += rx8010sj.o
 obj-$(CONFIG_RTC_S35392A) += s35392a.o
 obj-$(CONFIG_RTC_STM32) += stm32_rtc.o
-obj-$(CONFIG_$(SPL_TPL_)RTC_SANDBOX) += sandbox_rtc.o
+obj-$(CONFIG_$(PHASE_)RTC_SANDBOX) += sandbox_rtc.o
 obj-$(CONFIG_RTC_ABX80X) += abx80x.o
 obj-$(CONFIG_RTC_ZYNQMP) += zynqmp_rtc.o
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 7c19a435722..b76de1b22a8 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -6,7 +6,7 @@
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 ifdef CONFIG_SCSI
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += scsi_bootdev.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += scsi_bootdev.o
 obj-$(CONFIG_SANDBOX) += sandbox_scsi.o
 obj-$(CONFIG_SANDBOX) += scsi_emul.o
 endif
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 1c0b013eb1f..ebe692a9963 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2006-2009
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifeq ($(CONFIG_$(SPL_TPL_)DM_SERIAL),y)
+ifeq ($(CONFIG_$(PHASE_)DM_SERIAL),y)
 obj-y += serial-uclass.o
 else
 obj-y += serial.o
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 32d7bf7237a..7051e2a00c6 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 # There are many options which enable SPI, so make this library available
-ifdef CONFIG_$(SPL_TPL_)DM_SPI
+ifdef CONFIG_$(PHASE_)DM_SPI
 obj-y += spi-uclass.o
 obj-$(CONFIG_CADENCE_QSPI) += cadence_qspi.o cadence_qspi_apb.o
 obj-$(CONFIG_CADENCE_OSPI_VERSAL) += cadence_ospi_versal.o
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index a6a0584585c..796fc9effa5 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2016 Cadence Design Systems Inc.
 
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET) += sysreset-uclass.o
+obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset-uclass.o
 obj-$(CONFIG_ARCH_ASPEED) += sysreset_ast.o
 obj-$(CONFIG_ARCH_ROCKCHIP) += sysreset_rockchip.o
 obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
@@ -10,24 +10,24 @@ obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
 obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
 obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
 obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET_MAX77663) += sysreset_max77663.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_MAX77663) += sysreset_max77663.o
 obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
 obj-$(CONFIG_SYSRESET_OCTEON) += sysreset_octeon.o
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET_PALMAS) += sysreset_palmas.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_PALMAS) += sysreset_palmas.o
 obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
 obj-$(CONFIG_SYSRESET_SBI) += sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
 obj-$(CONFIG_SYSRESET_TEGRA) += sysreset_tegra.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET_TPS65910) += sysreset_tps65910.o
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET_TPS80031) += sysreset_tps80031.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_TPS65910) += sysreset_tps65910.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_TPS80031) += sysreset_tps80031.o
 obj-$(CONFIG_SYSRESET_SYSCON) += sysreset_syscon.o
 obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
 obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
-obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/tpm/Makefile b/drivers/tpm/Makefile
index 9540fd7fe78..76e516dbbaf 100644
--- a/drivers/tpm/Makefile
+++ b/drivers/tpm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
 
-obj-$(CONFIG_$(SPL_TPL_)TPM) += tpm-uclass.o
+obj-$(CONFIG_$(PHASE_)TPM) += tpm-uclass.o
 
 obj-$(CONFIG_TPM_ATMEL_TWI) += tpm_atmel_twi.o
 obj-$(CONFIG_TPM_TIS_INFINEON) += tpm_tis_infineon.o
@@ -10,7 +10,7 @@ obj-$(CONFIG_TPM_TIS_SANDBOX) += tpm_tis_sandbox.o sandbox_common.o
 obj-$(CONFIG_TPM_ST33ZP24_I2C) += tpm_tis_st33zp24_i2c.o
 obj-$(CONFIG_TPM_ST33ZP24_SPI) += tpm_tis_st33zp24_spi.o
 
-obj-$(CONFIG_$(SPL_TPL_)TPM2_CR50_I2C) += cr50_i2c.o
+obj-$(CONFIG_$(PHASE_)TPM2_CR50_I2C) += cr50_i2c.o
 obj-$(CONFIG_TPM2_TIS_SANDBOX) += tpm2_tis_sandbox.o sandbox_common.o
 obj-$(CONFIG_TPM2_TIS_SPI) += tpm2_tis_core.o tpm2_tis_spi.o
 obj-$(CONFIG_TPM2_TIS_I2C) += tpm2_tis_core.o tpm2_tis_i2c.o
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 3158487cba4..a44b2bfc1f2 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -3,9 +3,9 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)USB_GADGET) += epautoconf.o config.o usbstring.o
-obj-$(CONFIG_$(SPL_TPL_)USB_ETHER) += epautoconf.o config.o usbstring.o ether.o
-obj-$(CONFIG_$(SPL_TPL_)USB_ETH_RNDIS) += rndis.o
+obj-$(CONFIG_$(PHASE_)USB_GADGET) += epautoconf.o config.o usbstring.o
+obj-$(CONFIG_$(PHASE_)USB_ETHER) += epautoconf.o config.o usbstring.o ether.o
+obj-$(CONFIG_$(PHASE_)USB_ETH_RNDIS) += rndis.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 07deb4fadd6..792956e647a 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -8,8 +8,8 @@ obj-y += usb-uclass.o
 obj-$(CONFIG_SANDBOX) += usb-sandbox.o
 endif
 
-ifdef CONFIG_$(SPL_TPL_)USB_STORAGE
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += usb_bootdev.o
+ifdef CONFIG_$(PHASE_)USB_STORAGE
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += usb_bootdev.o
 endif
 
 # ohci
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 93fed8c491a..af8b2b266e2 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -4,12 +4,12 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 ifdef CONFIG_DM
-obj-$(CONFIG_$(SPL_TPL_)BACKLIGHT) += backlight-uclass.o
+obj-$(CONFIG_$(PHASE_)BACKLIGHT) += backlight-uclass.o
 obj-$(CONFIG_BACKLIGHT_GPIO) += backlight_gpio.o
 obj-$(CONFIG_BACKLIGHT_PWM) += pwm_backlight.o
-obj-$(CONFIG_$(SPL_TPL_)CONSOLE_NORMAL) += console_normal.o
+obj-$(CONFIG_$(PHASE_)CONSOLE_NORMAL) += console_normal.o
 obj-$(CONFIG_CONSOLE_ROTATION) += console_rotate.o
-ifdef CONFIG_$(SPL_TPL_)CONSOLE_NORMAL
+ifdef CONFIG_$(PHASE_)CONSOLE_NORMAL
 obj-y += console_core.o
 else ifdef CONFIG_CONSOLE_ROTATION
 obj-y += console_core.o
@@ -18,14 +18,14 @@ obj-$(CONFIG_CONSOLE_ROTATION) += console_core.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += console_truetype.o fonts/
 obj-$(CONFIG_DISPLAY) += display-uclass.o
 obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi-host-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)VIDEO) += video-uclass.o vidconsole-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)VIDEO) += video_bmp.o
-obj-$(CONFIG_$(SPL_TPL_)PANEL) += panel-uclass.o
+obj-$(CONFIG_$(PHASE_)VIDEO) += video-uclass.o vidconsole-uclass.o
+obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
+obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
-obj-$(CONFIG_$(SPL_TPL_)SIMPLE_PANEL) += simple_panel.o
+obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
-obj-$(CONFIG_$(SPL_TPL_)BMP) += bmp.o
+obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
 endif
 
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7b39adcf0ff..1639d827fee 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_XILINX_TB_WATCHDOG) += xilinx_tb_wdt.o
 obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
 obj-$(CONFIG_DESIGNWARE_WATCHDOG) += designware_wdt.o
 obj-$(CONFIG_ULP_WATCHDOG) += ulp_wdog.o
-obj-$(CONFIG_$(SPL_TPL_)WDT) += wdt-uclass.o
+obj-$(CONFIG_$(PHASE_)WDT) += wdt-uclass.o
 obj-$(CONFIG_WDT_SANDBOX) += sandbox_wdt.o
 obj-$(CONFIG_WDT_ALARM_SANDBOX) += sandbox_alarm-wdt.o
 obj-$(CONFIG_WDT_APPLE) += apple_wdt.o
diff --git a/env/Makefile b/env/Makefile
index c5145c1735f..a54e924d419 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -3,10 +3,10 @@
 # (C) Copyright 2004-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += common.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += env.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += attr.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += flags.o
+obj-$(CONFIG_$(PHASE_)ENV_SUPPORT) += common.o
+obj-$(CONFIG_$(PHASE_)ENV_SUPPORT) += env.o
+obj-$(CONFIG_$(PHASE_)ENV_SUPPORT) += attr.o
+obj-$(CONFIG_$(PHASE_)ENV_SUPPORT) += flags.o
 
 ifndef CONFIG_XPL_BUILD
 obj-y += callback.o
@@ -20,12 +20,12 @@ obj-$(CONFIG_ENV_IS_IN_REMOTE) += remote.o
 obj-$(CONFIG_ENV_IS_IN_UBI) += ubi.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_NOWHERE) += nowhere.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_IN_MMC) += mmc.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_IN_FAT) += fat.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_IN_EXT4) += ext4.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_IN_NAND) += nand.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_IN_SPI_FLASH) += sf.o
-obj-$(CONFIG_$(SPL_TPL_)ENV_IS_IN_FLASH) += flash.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_NOWHERE) += nowhere.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_MMC) += mmc.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FAT) += fat.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_EXT4) += ext4.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_NAND) += nand.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_FLASH) += sf.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
 
 CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
diff --git a/fs/sandbox/Makefile b/fs/sandbox/Makefile
index 880d59dd693..54ad842d1fe 100644
--- a/fs/sandbox/Makefile
+++ b/fs/sandbox/Makefile
@@ -9,4 +9,4 @@
 # Pavel Bartusek, Sysgo Real-Time Solutions AG, pba@sysgo.de
 
 obj-y := sandboxfs.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += host_bootdev.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD) += host_bootdev.o
diff --git a/lib/Makefile b/lib/Makefile
index 139476a4a23..7ccc91f5d33 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_OPTEE_LIB) += optee/
 
 obj-$(CONFIG_AES) += aes.o
 obj-$(CONFIG_AES) += aes/
-obj-$(CONFIG_$(SPL_TPL_)BINMAN_FDT) += binman.o
+obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o
 
 ifndef API_BUILD
 ifneq ($(CONFIG_CHARSET),)
@@ -56,8 +56,8 @@ obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-y += list_sort.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)TPM) += tpm-common.o
-ifeq ($(CONFIG_$(SPL_TPL_)TPM),y)
+obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
+ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
 obj-$(CONFIG_TPM_V1) += tpm-v1.o
 obj-$(CONFIG_TPM_V2) += tpm-v2.o
@@ -65,12 +65,12 @@ obj-$(CONFIG_EFI_TCG2_PROTOCOL) += tpm_tcg2.o
 obj-$(CONFIG_MEASURED_BOOT) += tpm_tcg2.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)CRC8) += crc8.o
-obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
+obj-$(CONFIG_$(PHASE_)CRC8) += crc8.o
+obj-$(CONFIG_$(PHASE_)CRC16) += crc16.o
 
 obj-y += crypto/
 
-obj-$(CONFIG_$(SPL_TPL_)ACPI) += acpi/
+obj-$(CONFIG_$(PHASE_)ACPI) += acpi/
 obj-$(CONFIG_$(XPL_)MD5) += md5.o
 obj-$(CONFIG_ECDSA) += ecdsa/
 obj-$(CONFIG_$(XPL_)RSA) += rsa/
@@ -93,12 +93,12 @@ obj-$(CONFIG_$(XPL_)LIB_RATIONAL) += rational.o
 
 obj-$(CONFIG_LIBAVB) += libavb/
 
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
-obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
+obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += libfdt/
+obj-$(CONFIG_$(PHASE_)OF_REAL) += fdtdec_common.o fdtdec.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
-obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
+obj-$(CONFIG_$(PHASE_)HASH) += crc16-ccitt.o
 obj-$(CONFIG_MMC_SPI_CRC_ON) += crc16-ccitt.o
 obj-y += net_utils.o
 endif
@@ -110,15 +110,15 @@ obj-y += display_options.o
 CFLAGS_display_options.o := $(if $(BUILD_TAG),-DBUILD_TAG='"$(BUILD_TAG)"')
 obj-$(CONFIG_BCH) += bch.o
 obj-$(CONFIG_MMC_SPI) += crc7.o
-obj-$(CONFIG_$(SPL_TPL_)CRC32) += crc32.o
+obj-$(CONFIG_$(PHASE_)CRC32) += crc32.o
 obj-$(CONFIG_CRC32C) += crc32c.o
 obj-y += ctype.o
 obj-y += div64.o
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdtdec.o fdtdec_common.o
+obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdtdec.o fdtdec_common.o
 obj-y += hang.o
 obj-y += linux_compat.o
 obj-y += linux_string.o
-obj-$(CONFIG_$(SPL_TPL_)LMB) += lmb.o
+obj-$(CONFIG_$(PHASE_)LMB) += lmb.o
 obj-y += membuff.o
 obj-$(CONFIG_REGEX) += slre.o
 obj-y += string.o
@@ -133,12 +133,12 @@ obj-y += panic.o
 
 ifeq ($(CONFIG_XPL_BUILD),y)
 # SPL U-Boot may use full-printf, tiny-printf or none at all
-ifdef CONFIG_$(SPL_TPL_)USE_TINY_PRINTF
-obj-$(CONFIG_$(SPL_TPL_)SPRINTF) += tiny-printf.o
+ifdef CONFIG_$(PHASE_)USE_TINY_PRINTF
+obj-$(CONFIG_$(PHASE_)SPRINTF) += tiny-printf.o
 else
-obj-$(CONFIG_$(SPL_TPL_)SPRINTF) += vsprintf.o
+obj-$(CONFIG_$(PHASE_)SPRINTF) += vsprintf.o
 endif
-obj-$(CONFIG_$(SPL_TPL_)STRTO) += strto.o
+obj-$(CONFIG_$(PHASE_)STRTO) += strto.o
 else
 # Main U-Boot always uses the full printf support
 obj-y += vsprintf.o strto.o
@@ -152,7 +152,7 @@ obj-y += date.o
 obj-y += rtc-lib.o
 obj-$(CONFIG_LIB_ELF) += elf.o
 
-obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
+obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
 
 #
 # Build a fast OID lookup registry from include/linux/oid_registry.h
diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
index 99be19adb4c..dcca0c67268 100644
--- a/lib/acpi/Makefile
+++ b/lib/acpi/Makefile
@@ -3,7 +3,7 @@
 
 obj-y += acpi.o
 
-ifdef CONFIG_$(SPL_TPL_)GENERATE_ACPI_TABLE
+ifdef CONFIG_$(PHASE_)GENERATE_ACPI_TABLE
 
 obj-$(CONFIG_$(XPL_)ACPIGEN) += acpigen.o
 obj-$(CONFIG_$(XPL_)ACPIGEN) += acpi_device.o
diff --git a/lib/libfdt/Makefile b/lib/libfdt/Makefile
index 1fe50ecbe52..c492377032b 100644
--- a/lib/libfdt/Makefile
+++ b/lib/libfdt/Makefile
@@ -16,4 +16,4 @@ obj-y += \
 obj-$(CONFIG_OF_LIBFDT_OVERLAY) += fdt_overlay.o
 
 ccflags-y := -I$(srctree)/scripts/dtc/libfdt \
-	-DFDT_ASSUME_MASK=$(CONFIG_$(SPL_TPL_)OF_LIBFDT_ASSUME_MASK)
+	-DFDT_ASSUME_MASK=$(CONFIG_$(PHASE_)OF_LIBFDT_ASSUME_MASK)
diff --git a/lib/rsa/Makefile b/lib/rsa/Makefile
index c9ac72c1e26..1f9b24001bf 100644
--- a/lib/rsa/Makefile
+++ b/lib/rsa/Makefile
@@ -5,6 +5,6 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_$(SPL_TPL_)RSA_VERIFY) += rsa-verify.o
-obj-$(CONFIG_$(SPL_TPL_)RSA_VERIFY_WITH_PKEY) += rsa-keyprop.o
+obj-$(CONFIG_$(PHASE_)RSA_VERIFY) += rsa-verify.o
+obj-$(CONFIG_$(PHASE_)RSA_VERIFY_WITH_PKEY) += rsa-keyprop.o
 obj-$(CONFIG_RSA_SOFTWARE_EXP) += rsa-mod-exp.o
diff --git a/net/Makefile b/net/Makefile
index a1d37855593..a7075c36a04 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_CMD_DNS)  += dns.o
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_$(XPL_)DM_ETH) += eth-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += eth_bootdev.o
+obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
 obj-$(CONFIG_$(XPL_)DM_ETH) += eth_common.o
@@ -27,8 +27,8 @@ obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_CMD_RARP) += rarp.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
-obj-$(CONFIG_$(SPL_TPL_)UDP_FUNCTION_FASTBOOT)  += fastboot_udp.o
-obj-$(CONFIG_$(SPL_TPL_)TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
+obj-$(CONFIG_$(PHASE_)UDP_FUNCTION_FASTBOOT)  += fastboot_udp.o
+obj-$(CONFIG_$(PHASE_)TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
 obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 1a6b28feedf..edc91b24e45 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -327,15 +327,15 @@ endif
 ifdef CONFIG_XPL_BUILD
 XPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
-SPL_TPL_ := VPL_
+PHASE_ := VPL_
 else
 ifeq ($(CONFIG_TPL_BUILD),y)
-SPL_TPL_ := TPL_
+PHASE_ := TPL_
 else
-SPL_TPL_ := SPL_
+PHASE_ := SPL_
 endif
 endif
 else
 XPL_ :=
-SPL_TPL_ :=
+PHASE_ :=
 endif
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 11ae93f8556..dca5f4539d0 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -61,17 +61,17 @@ export SPL_NAME
 ifdef CONFIG_XPL_BUILD
 XPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
-SPL_TPL_ := VPL_
+PHASE_ := VPL_
 else
 ifeq ($(CONFIG_TPL_BUILD),y)
-SPL_TPL_ := TPL_
+PHASE_ := TPL_
 else
-SPL_TPL_ := SPL_
+PHASE_ := SPL_
 endif
 endif
 else
 XPL_ :=
-SPL_TPL_ :=
+PHASE_ :=
 endif
 
 ifeq ($(obj)$(CONFIG_SUPPORT_SPL),spl)
@@ -93,7 +93,7 @@ include $(srctree)/scripts/Makefile.lib
 KBUILD_CFLAGS += -ffunction-sections -fdata-sections
 LDFLAGS_FINAL += --gc-sections
 
-ifeq ($(CONFIG_$(SPL_TPL_)STACKPROTECTOR),y)
+ifeq ($(CONFIG_$(PHASE_)STACKPROTECTOR),y)
 KBUILD_CFLAGS += -fstack-protector-strong
 else
 KBUILD_CFLAGS += -fno-stack-protector
@@ -117,8 +117,8 @@ endif
 libs-y += common/init/
 
 # Special handling for a few options which support SPL/TPL/VPL
-libs-$(CONFIG_$(SPL_TPL_)LIBCOMMON_SUPPORT) += boot/ common/ cmd/ env/
-libs-$(CONFIG_$(SPL_TPL_)LIBGENERIC_SUPPORT) += lib/
+libs-$(CONFIG_$(PHASE_)LIBCOMMON_SUPPORT) += boot/ common/ cmd/ env/
+libs-$(CONFIG_$(PHASE_)LIBGENERIC_SUPPORT) += lib/
 ifdef CONFIG_SPL_FRAMEWORK
 libs-$(CONFIG_PARTITIONS) += disk/
 endif
@@ -131,7 +131,7 @@ libs-y += dts/
 libs-y += fs/
 libs-$(CONFIG_SPL_POST_MEM_SUPPORT) += post/drivers/
 libs-$(CONFIG_SPL_NET) += net/
-libs-$(CONFIG_$(SPL_TPL_)UNIT_TEST) += test/
+libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
 
 head-y		:= $(addprefix $(obj)/,$(head-y))
 libs-y		:= $(addprefix $(obj)/,$(libs-y))
@@ -147,12 +147,12 @@ endif
 
 u-boot-spl-init := $(head-y)
 u-boot-spl-main := $(libs-y)
-ifdef CONFIG_$(SPL_TPL_)OF_PLATDATA
+ifdef CONFIG_$(PHASE_)OF_PLATDATA
 platdata-hdr := include/generated/dt-structs-gen.h include/generated/dt-decl.h
 platdata-inst := $(obj)/dts/dt-uclass.o $(obj)/dts/dt-device.o
 platdata-noinst := $(obj)/dts/dt-plat.o
 
-ifdef CONFIG_$(SPL_TPL_)OF_PLATDATA_INST
+ifdef CONFIG_$(PHASE_)OF_PLATDATA_INST
 u-boot-spl-platdata := $(platdata-inst)
 u-boot-spl-old-platdata := $(platdata-noinst)
 else
@@ -169,9 +169,9 @@ endif  # OF_PLATDATA
 
 # Linker Script
 # First test whether there's a linker-script for the specific stage defined...
-ifneq ($(CONFIG_$(SPL_TPL_)LDSCRIPT),)
+ifneq ($(CONFIG_$(PHASE_)LDSCRIPT),)
 # need to strip off double quotes
-LDSCRIPT := $(addprefix $(srctree)/,$(CONFIG_$(SPL_TPL_)LDSCRIPT:"%"=%))
+LDSCRIPT := $(addprefix $(srctree)/,$(CONFIG_$(PHASE_)LDSCRIPT:"%"=%))
 else
 # ...then fall back to the generic SPL linker-script
 ifneq ($(CONFIG_SPL_LDSCRIPT),)
@@ -205,11 +205,11 @@ LDPPFLAGS += \
 
 # Turn various CONFIG symbols into IMAGE symbols for easy reuse of
 # the scripts between SPL, TPL and VPL.
-ifneq ($(CONFIG_$(SPL_TPL_)MAX_SIZE),0x0)
-LDPPFLAGS += -DIMAGE_MAX_SIZE=$(CONFIG_$(SPL_TPL_)MAX_SIZE)
+ifneq ($(CONFIG_$(PHASE_)MAX_SIZE),0x0)
+LDPPFLAGS += -DIMAGE_MAX_SIZE=$(CONFIG_$(PHASE_)MAX_SIZE)
 endif
-ifneq ($(CONFIG_$(SPL_TPL_)TEXT_BASE),)
-LDPPFLAGS += -DIMAGE_TEXT_BASE=$(CONFIG_$(SPL_TPL_)TEXT_BASE)
+ifneq ($(CONFIG_$(PHASE_)TEXT_BASE),)
+LDPPFLAGS += -DIMAGE_TEXT_BASE=$(CONFIG_$(PHASE_)TEXT_BASE)
 endif
 
 MKIMAGEOUTPUT ?= /dev/null
@@ -323,7 +323,7 @@ endif
 #   - OF_REAL is enabled
 #   - we have either OF_SEPARATE or OF_HOSTFILE
 build_dtb :=
-ifneq ($(CONFIG_$(SPL_TPL_)OF_REAL),)
+ifneq ($(CONFIG_$(PHASE_)OF_REAL),)
 ifneq ($(CONFIG_OF_SEPARATE)$(CONFIG_SANDBOX),)
 build_dtb := y
 endif
@@ -331,7 +331,7 @@ endif
 
 ifneq ($(build_dtb),)
 $(obj)/$(SPL_BIN)-dtb.bin: $(obj)/$(SPL_BIN)-nodtb.bin \
-		$(if $(CONFIG_$(SPL_TPL_)SEPARATE_BSS),,$(obj)/$(SPL_BIN)-pad.bin) \
+		$(if $(CONFIG_$(PHASE_)SEPARATE_BSS),,$(obj)/$(SPL_BIN)-pad.bin) \
 		$(FINAL_DTB_CONTAINER)  FORCE
 	$(call if_changed,cat)
 
@@ -355,7 +355,7 @@ pythonpath = PYTHONPATH=scripts/dtc/pylibfdt
 DTOC_ARGS := $(pythonpath) $(srctree)/tools/dtoc/dtoc \
 	-d $(obj)/$(SPL_BIN).dtb -p $(SPL_NAME)
 
-ifneq ($(CONFIG_$(SPL_TPL_)OF_PLATDATA_INST),)
+ifneq ($(CONFIG_$(PHASE_)OF_PLATDATA_INST),)
 DTOC_ARGS += -i
 endif
 
@@ -400,7 +400,7 @@ quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
 OBJCOPYFLAGS_$(SPL_BIN)-nodtb.bin = $(SPL_OBJCFLAGS) -O binary \
-		$(if $(CONFIG_$(SPL_TPL_)X86_16BIT_INIT),-R .start16 -R .resetvec)
+		$(if $(CONFIG_$(PHASE_)X86_16BIT_INIT),-R .start16 -R .resetvec)
 
 $(obj)/$(SPL_BIN)-nodtb.bin: $(obj)/$(SPL_BIN) FORCE
 	$(call if_changed,objcopy)
@@ -429,8 +429,8 @@ LDFLAGS_$(SPL_BIN) += $(call ld-option, --no-dynamic-linker)
 LDFLAGS_$(SPL_BIN) += --build-id=none
 
 # Pick the best match (e.g. SPL_TEXT_BASE for SPL, TPL_TEXT_BASE for TPL)
-ifneq ($(CONFIG_$(SPL_TPL_)TEXT_BASE),)
-LDFLAGS_$(SPL_BIN) += -Ttext $(CONFIG_$(SPL_TPL_)TEXT_BASE)
+ifneq ($(CONFIG_$(PHASE_)TEXT_BASE),)
+LDFLAGS_$(SPL_BIN) += -Ttext $(CONFIG_$(PHASE_)TEXT_BASE)
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_ARRIA10
diff --git a/test/dm/Makefile b/test/dm/Makefile
index c6c63051e0b..6c9ebb8d07c 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_CLK) += clk.o clk_ccf.o
 obj-$(CONFIG_CPU) += cpu.o
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-$(CONFIG_PWM_CROS_EC) += cros_ec_pwm.o
-obj-$(CONFIG_$(SPL_TPL_)DEVRES) += devres.o
+obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
 obj-$(CONFIG_DMA) += dma.o
 obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi_host.o
 obj-$(CONFIG_DM_DSA) += dsa.o
@@ -102,7 +102,7 @@ obj-$(CONFIG_DM_RESET) += reset.o
 obj-$(CONFIG_SYSRESET) += sysreset.o
 obj-$(CONFIG_DM_REGULATOR) += regulator.o
 obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
-obj-$(CONFIG_$(SPL_TPL_)DM_RNG) += rng.o
+obj-$(CONFIG_$(PHASE_)DM_RNG) += rng.o
 obj-$(CONFIG_DM_RTC) += rtc.o
 obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
 obj-$(CONFIG_SCSI) += scsi.o
diff --git a/tools/qconfig.py b/tools/qconfig.py
index e025f560928..7b4934b726d 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1222,8 +1222,8 @@ def scan_makefiles(fnames):
     (None, 'FRED')
     >>> RE_MK_CONFIGS.search('CONFIG_$(XPL_)MARY').groups()
     ('$(XPL_)', 'MARY')
-    >>> RE_MK_CONFIGS.search('CONFIG_$(SPL_TPL_)MARY').groups()
-    ('$(SPL_TPL_)', 'MARY')
+    >>> RE_MK_CONFIGS.search('CONFIG_$(PHASE_)MARY').groups()
+    ('$(PHASE_)', 'MARY')
     """
     all_uses = collections.defaultdict(list)
     fname_uses = {}
@@ -1322,7 +1322,7 @@ def do_scan_source(path, do_update):
                 an SPL_ option, but for which there is none;
                 for MOD_PROPER, look at source code which implies a Proper
                 option (i.e. use of CONFIG_IS_ENABLED() or $(XPL_) or
-                $(SPL_TPL_) but for which there none;
+                $(PHASE_) but for which there none;
                 if MODE_NORMAL, ignore SPL
 
         Returns:
-- 
2.43.0

