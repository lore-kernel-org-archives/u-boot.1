Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97545108B91E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 01:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E92A8352B;
	Wed, 25 Mar 2026 02:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TfU/J0fP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wxVuPVbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9A783CD3; Wed, 25 Mar 2026 02:14:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD3F81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fgTT76jVpz9tVj;
 Wed, 25 Mar 2026 02:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774401260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qpmQdMHmrhktONqLe3kzvldPll/h66aPdR/zPXqvIV0=;
 b=TfU/J0fPQoXjwHIyXg7C00+uj8JbtVV9yK4TmjCAGsDsNHSdI6YRdK004IMEhxH4voIkko
 3c+eAVI3eVM2GiTTXYcjNOdbme3STrhIsSLbVO/zNfTqlV1BKvBoRDyk1lmYwyH4F2aOg0
 jeshritIxB32k0AcH578WfJ9kiOhu+v1aXNNbOhtSoOS67nmYFyuzT23jEs9l74k0Ucr5D
 kqcViULE0d2bQbSaO4jRBj4lh4fHrchElKDxF19KLuVHNQm3Ly5BM7ZLAqCT08XrbyWjX3
 fsY3gfwAxPuYU/73WRxX6lbJ/VTqUMWYUyOnU4LVEwH8S5olrHoI4y5RZSBQ9w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wxVuPVbX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774401258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qpmQdMHmrhktONqLe3kzvldPll/h66aPdR/zPXqvIV0=;
 b=wxVuPVbXjOUWT95EShf4amqhFChL52Ict8EECzIShJRdAhVA3xXYiXbsEwA5S1MH8m/SYK
 YGTqTOr7ihlTT1OfoErB3L800cOsYA+b4r8U6wNuPCbeqe8LmxzkheFk2JCOT4G/iUTAxc
 8hgKycofxNbUAVQURans9CyoVOOHWM57Enu5HyZZqCXTR2zh1e+abh9ONULwFt+BQG/5Gl
 bkFZMBtYtBlRp76U6/5VAXdcvEIs2PyViDWzHdf4mCY6TWV1+4bPh1dcsTB/DDkXyOM+tb
 6E5VmJmWgyWC3qxlxsK4U+TnZ4Yc9sB11gOPNmroXHwt80ySXmVAfHICKCTmBw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Add ARMv8-M aarch32 support
Date: Wed, 25 Mar 2026 02:13:57 +0100
Message-ID: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0608e8d2afacf736254
X-MBO-RS-META: xp9zf6m1dp7h9ermik83ydnx5q6ir6xj
X-Rspamd-Queue-Id: 4fgTT76jVpz9tVj
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

Add configuration for ARMv8-M aarch32 core, which are currently
Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
cores, except the code has to be compiled with matching compiler
-march=armv8-m.main flag . These cores have no MMU, they have MPU,
which is currently not configured.

Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
initialization code is built from from arch/arm/cpu/armv7m and not
armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
for devices using these cores do come from arch/arm64/boot/dts .

To avoid excess duplication in Makefiles, introduce one new Kconfig
symbol, CPU_V78M. The CPU_V78M cover both ARMv7-M and ARMv8-M cores.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Makefile                         |  8 ++++++--
 arch/arm/Kconfig                 | 18 +++++++++++++++---
 arch/arm/Makefile                |  2 ++
 arch/arm/cpu/armv7m/Makefile     |  3 ++-
 arch/arm/include/asm/armv7_mpu.h |  2 +-
 arch/arm/include/asm/unified.h   |  2 +-
 arch/arm/lib/Makefile            |  6 +++---
 arch/arm/lib/bootm.c             |  2 +-
 arch/arm/lib/crt0.S              |  2 +-
 arch/arm/lib/relocate.S          |  4 ++--
 arch/arm/lib/semihosting.S       |  2 +-
 arch/arm/lib/vectors_m.S         |  6 +++++-
 cmd/Kconfig                      |  2 +-
 dts/Makefile                     |  4 ++++
 lib/efi_selftest/Makefile        |  2 +-
 15 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 8295cd4e5e8..4ee1457cc6d 100644
--- a/Makefile
+++ b/Makefile
@@ -531,7 +531,7 @@ UBOOTINCLUDE    := \
 		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
 	$(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
-			$(if $(CONFIG_CPU_V7M), \
+			$(if $(CONFIG_CPU_V78M), \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
@@ -1050,7 +1050,7 @@ UBOOTINCLUDE    := \
 		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
 	$(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
-			$(if $(CONFIG_CPU_V7M), \
+			$(if $(CONFIG_CPU_V78M), \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
@@ -1446,11 +1446,15 @@ quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
 ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_CPU_V8M),y)
+dt_dir := dts/upstream/src/arm64
+else
 ifeq ($(CONFIG_ARM64),y)
 dt_dir := dts/upstream/src/arm64
 else
 dt_dir := dts/upstream/src/$(ARCH)
 endif
+endif
 else
 dt_dir := arch/$(ARCH)/dts
 endif
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 03416c55265..31650a9154b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -363,15 +363,20 @@ config CPU_V7A
 	select SYS_CACHE_SHIFT_6
 	imply SYS_ARM_MMU
 
-config CPU_V7M
+# ARMv7-M/ARMv8-M
+config CPU_V78M
 	bool
 	select HAS_THUMB2
 	select SYS_ARM_MPU
-	select SYS_CACHE_SHIFT_5
 	select SYS_THUMB_BUILD
 	select THUMB2_KERNEL
 	select NVIC
 
+config CPU_V7M
+	bool
+	select CPU_V78M
+	select SYS_CACHE_SHIFT_5
+
 config CPU_V7R
 	bool
 	select HAS_THUMB2
@@ -379,6 +384,11 @@ config CPU_V7R
 	select SYS_ARM_MPU
 	select SYS_CACHE_SHIFT_6
 
+config CPU_V8M
+	bool
+	select CPU_V78M
+	select SYS_CACHE_SHIFT_6
+
 config SYS_CPU
 	default "arm720t" if CPU_ARM720T
 	default "arm920t" if CPU_ARM920T
@@ -389,6 +399,7 @@ config SYS_CPU
 	default "armv7" if CPU_V7A
 	default "armv7" if CPU_V7R
 	default "armv7m" if CPU_V7M
+	default "armv7m" if CPU_V8M
 	default "armv8" if ARM64
 
 config SYS_ARM_ARCH
@@ -402,6 +413,7 @@ config SYS_ARM_ARCH
 	default 7 if CPU_V7A
 	default 7 if CPU_V7M
 	default 7 if CPU_V7R
+	default 7 if CPU_V8M
 	default 8 if ARM64
 
 choice
@@ -445,7 +457,7 @@ config ARCH_CPU_INIT
 
 config SYS_ARCH_TIMER
 	bool "ARM Generic Timer support"
-	depends on CPU_V7A || CPU_V7M || ARM64
+	depends on CPU_V7A || CPU_V78M || ARM64
 	default y if ARM64
 	help
 	  The ARM Generic Timer (aka arch-timer) provides an architected
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b36b0742580..de975fc9368 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,7 @@ arch-$(CONFIG_CPU_V7A)		=$(call cc-option, -march=armv7-a, \
 				 $(call cc-option, -march=armv7))
 arch-$(CONFIG_CPU_V7M)		=-march=armv7-m
 arch-$(CONFIG_CPU_V7R)		=-march=armv7-r
+arch-$(CONFIG_CPU_V8M)		=-march=armv8-m.main
 ifeq ($(CONFIG_ARM64_CRC32),y)
 arch-$(CONFIG_ARM64)		=-march=armv8-a+crc
 else
@@ -42,6 +43,7 @@ tune-$(CONFIG_CPU_ARM1136)	=
 tune-$(CONFIG_CPU_ARM1176)	=
 tune-$(CONFIG_CPU_V7A)		=-mtune=generic-armv7-a
 tune-$(CONFIG_CPU_V7R)		=
+tune-$(CONFIG_CPU_V8M)		=
 tune-$(CONFIG_ARM64)		=
 
 # Evaluate tune cc-option calls now
diff --git a/arch/arm/cpu/armv7m/Makefile b/arch/arm/cpu/armv7m/Makefile
index baeac9343d9..33d49dc3d35 100644
--- a/arch/arm/cpu/armv7m/Makefile
+++ b/arch/arm/cpu/armv7m/Makefile
@@ -4,6 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 extra-y := start.o
-obj-y += cpu.o cache.o
+obj-y += cache.o
+obj-$(CONFIG_CPU_V7M) += cpu.o
 obj-$(CONFIG_SYS_ARM_MPU) += mpu.o
 obj-$(CONFIG_SYS_ARCH_TIMER) += systick-timer.o
diff --git a/arch/arm/include/asm/armv7_mpu.h b/arch/arm/include/asm/armv7_mpu.h
index 16b9d0d1aeb..b615b1bc9dc 100644
--- a/arch/arm/include/asm/armv7_mpu.h
+++ b/arch/arm/include/asm/armv7_mpu.h
@@ -11,7 +11,7 @@
 #include <linux/bitops.h>
 #endif
 
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V78M
 #define AP_SHIFT			24
 #define XN_SHIFT			28
 #define TEX_SHIFT			19
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 2fae54ebd89..30db0aa9054 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -12,7 +12,7 @@
 	.syntax unified
 #endif
 
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V78M
 #define AR_CLASS(x...)
 #define M_CLASS(x...)	x
 #else
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 11cb3a7145e..9c9195ad80b 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_$(PHASE_)LIB_BOOTZ) += zimage.o
 obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
 
-ifdef CONFIG_CPU_V7M
+ifdef CONFIG_CPU_V78M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
 obj-y	+= crt0_64.o
@@ -32,7 +32,7 @@ else
 obj-y	+= relocate.o
 endif
 
-obj-$(CONFIG_CPU_V7M) += cmd_boot.o
+obj-$(CONFIG_CPU_V78M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 else
@@ -62,7 +62,7 @@ obj-y	+= sections.o
 CFLAGS_REMOVE_sections.o := $(LTO_CFLAGS)
 
 obj-y	+= stack.o
-ifdef CONFIG_CPU_V7M
+ifdef CONFIG_CPU_V78M
 obj-y	+= interrupts_m.o
 else ifdef CONFIG_ARM64
 obj-$(CONFIG_FSL_LAYERSCAPE) += ccn504.o
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 727b9c5ca5b..8c471f19244 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -304,7 +304,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	void (*kernel_entry)(int zero, int arch, uint params);
 	unsigned long r2;
 	kernel_entry = (void (*)(int, int, uint))images->ep;
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V78M
 	ulong addr = (ulong)kernel_entry | 1;
 	kernel_entry = (void *)addr;
 #endif
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index f2c5aa37a8f..eedbb7244c6 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -153,7 +153,7 @@ ENTRY(_main)
 #endif
 	ldr	r0, [r9, #GD_RELOC_OFF]		/* r0 = gd->reloc_off */
 	add	lr, lr, r0
-#if defined(CONFIG_CPU_V7M)
+#if defined(CONFIG_CPU_V78M)
 	orr	lr, #1				/* As required by Thumb-only */
 #endif
 	ldr	r0, [r9, #GD_RELOCADDR]		/* r0 = gd->relocaddr */
diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index d3bec4677f3..d92f46f384f 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -10,7 +10,7 @@
 #include <config.h>
 #include <elf.h>
 #include <linux/linkage.h>
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V78M
 #include <asm/armv7m.h>
 #endif
 
@@ -26,7 +26,7 @@
 
 WEAK(relocate_vectors)
 
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V78M
 	/*
 	 * On ARMv7-M we only have to write the new vector address
 	 * to VTOR register.
diff --git a/arch/arm/lib/semihosting.S b/arch/arm/lib/semihosting.S
index 6e1691a832c..0da33607f6d 100644
--- a/arch/arm/lib/semihosting.S
+++ b/arch/arm/lib/semihosting.S
@@ -13,7 +13,7 @@ ENTRY(smh_trap)
 
 #if defined(CONFIG_ARM64)
 	hlt	#0xf000
-#elif defined(CONFIG_CPU_V7M)
+#elif defined(CONFIG_CPU_V78M)
 	bkpt	#0xab
 #elif defined(CONFIG_SYS_THUMB_BUILD)
 	svc	#0xab
diff --git a/arch/arm/lib/vectors_m.S b/arch/arm/lib/vectors_m.S
index 8d88cc756fc..38b32d87152 100644
--- a/arch/arm/lib/vectors_m.S
+++ b/arch/arm/lib/vectors_m.S
@@ -52,6 +52,10 @@ ENTRY(_start)
 	.long	__invalid_entry			@ 13 - Reserved
 	.long	__invalid_entry			@ 14 - PendSV
 	.long	__invalid_entry			@ 15 - SysTick
-	.rept	255 - 16
+#ifdef CONFIG_CPU_V7M
+	.rept	256 - 16
+#else /* V8M / V8R */
+	.rept	512 - 16
+#endif
 	.long	__invalid_entry			@ 16..255 - External Interrupts
 	.endr
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 317ff8e9987..1f4ce13e647 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2084,7 +2084,7 @@ config BOOTP_PXE_DHCP_OPTION
 config BOOTP_VCI_STRING
 	string
 	depends on CMD_BOOTP
-	default "U-Boot.armv7" if CPU_V7A || CPU_V7M || CPU_V7R
+	default "U-Boot.armv7" if CPU_V7A || CPU_V78M || CPU_V7R
 	default "U-Boot.armv8" if ARM64
 	default "U-Boot.arm" if ARM
 	default "U-Boot"
diff --git a/dts/Makefile b/dts/Makefile
index bec6c49da2c..befc6de1805 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -11,11 +11,15 @@ DEVICE_TREE := unset
 endif
 
 ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_CPU_V8M),y)
+dt_dir := dts/upstream/src/arm64
+else
 ifeq ($(CONFIG_ARM64),y)
 dt_dir := dts/upstream/src/arm64
 else
 dt_dir := dts/upstream/src/$(ARCH)
 endif
+endif
 else
 dt_dir := arch/$(ARCH)/dts
 endif
diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 842433f68aa..0889f3607b7 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_selftest_devicepath.o
 obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += \
 efi_selftest_unicode_collation.o
 
-ifeq ($(CONFIG_CPU_V7A)$(CONFIG_CPU_V7M)$(CONFIG_CPU_V7R),y)
+ifeq ($(CONFIG_CPU_V7A)$(CONFIG_CPU_V78M)$(CONFIG_CPU_V7R),y)
 obj-y += efi_selftest_unaligned.o
 endif
 obj-$(CONFIG_EFI_LOADER_HII) += efi_selftest_hii.o
-- 
2.53.0

