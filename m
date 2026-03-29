Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67B2FF4927
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 23:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6858083B48;
	Mon, 30 Mar 2026 01:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z8G2ISAQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TfSBaPLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD2483C5E; Mon, 30 Mar 2026 01:14:50 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDEC8063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 01:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fkVZv64Bkz9t02;
 Mon, 30 Mar 2026 01:14:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774826087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVGL/NZ6t/FiIHFyzL7S+r7w2+FikcpdFPpXyhuJ/0s=;
 b=Z8G2ISAQFfuBV9bzrwX5DaWWUpyMeutyskfn3kfqEMh8W/CeTh/6EP4pD7DrJAF1qDMsfJ
 MdCoeyOl//tvJihqzPV2M3RUA9oUZdFskDImx1d3xSDMTutwMB6PM+GqxpxKBLUB60ALdI
 NoZV9m7jNXc9nsLHrU4Y2lJbULSfZIJwQ0uIFcHysumBOxp4QPGyV8k12lneSgUpiv8vxh
 9Gv6fnrdrW6/nKQAecaUl7zqs0f3wjOzGRAjiP03ZoyaGlYjeYH0m04mOpeGlyrixO7fQG
 qNVFugPA1pWu819P0Ln/gY71iqg5zcDwhNRZClqAS449kvDrh9xJX8hheCal5A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774826086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVGL/NZ6t/FiIHFyzL7S+r7w2+FikcpdFPpXyhuJ/0s=;
 b=TfSBaPLkZ9maObHaRm+hzX1ncDArWUYq+SHfqEcSWDNxYdLecG0AxP8S0KfI55J01U7Meo
 I4mhb7VfeLXxMjiPkyVzGbhNzecbtY81tSR6X70j2oGp8l6Qbgr1D5jyEEBtzUJz96Kgb5
 MiJI4RmBkkKC0Twxaj1QL+jFziSnMv/4ncq8iT0rLuH2wcsIGP2VHptoZ1HN8E+fhMNrCD
 JJVaoOTSb3lgX8ojGTuCjq4Q1UWm9P2BkXQ/12uhP0baFnp5LeRfLmyb/Gk6SdU7PpghOg
 OuUhnnyTJgz0eIROG32sT/e+mDFAI34Ox5rmB/FDGIAMHxYa8aTMWw9wrYFHhg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] arm: Add ARMv8-M aarch32 support
Date: Mon, 30 Mar 2026 01:14:12 +0200
Message-ID: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mq8wkd6tyoxsfia4qe87ca316ucjb7ju
X-MBO-RS-ID: 5e0456b4bd4191a6f3b
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
symbol, CPU_V7M_V8M. The CPU_V7M_V8M cover both ARMv7-M and ARMv8-M
cores.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de
---
V2: - Rename CPU_V78M to CPU_V7M_V8M
    - Isolate V7M specific and otherwise option bits in cpu.c
---
 Makefile                         |  8 ++++++--
 arch/arm/Kconfig                 | 15 +++++++++++++--
 arch/arm/Makefile                |  2 ++
 arch/arm/cpu/armv7m/cpu.c        | 10 ++++++++--
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
 15 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 8295cd4e5e8..cb4b5a2635e 100644
--- a/Makefile
+++ b/Makefile
@@ -531,7 +531,7 @@ UBOOTINCLUDE    := \
 		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
 	$(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
-			$(if $(CONFIG_CPU_V7M), \
+			$(if $(CONFIG_CPU_V7M_V8M), \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
@@ -1050,7 +1050,7 @@ UBOOTINCLUDE    := \
 		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
 	$(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
-			$(if $(CONFIG_CPU_V7M), \
+			$(if $(CONFIG_CPU_V7M_V8M), \
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
index 03416c55265..f624675eadf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -363,7 +363,8 @@ config CPU_V7A
 	select SYS_CACHE_SHIFT_6
 	imply SYS_ARM_MMU
 
-config CPU_V7M
+# ARMv7-M/ARMv8-M
+config CPU_V7M_V8M
 	bool
 	select HAS_THUMB2
 	select SYS_ARM_MPU
@@ -372,6 +373,10 @@ config CPU_V7M
 	select THUMB2_KERNEL
 	select NVIC
 
+config CPU_V7M
+	bool
+	select CPU_V7M_V8M
+
 config CPU_V7R
 	bool
 	select HAS_THUMB2
@@ -379,6 +384,10 @@ config CPU_V7R
 	select SYS_ARM_MPU
 	select SYS_CACHE_SHIFT_6
 
+config CPU_V8M
+	bool
+	select CPU_V7M_V8M
+
 config SYS_CPU
 	default "arm720t" if CPU_ARM720T
 	default "arm920t" if CPU_ARM920T
@@ -389,6 +398,7 @@ config SYS_CPU
 	default "armv7" if CPU_V7A
 	default "armv7" if CPU_V7R
 	default "armv7m" if CPU_V7M
+	default "armv7m" if CPU_V8M
 	default "armv8" if ARM64
 
 config SYS_ARM_ARCH
@@ -402,6 +412,7 @@ config SYS_ARM_ARCH
 	default 7 if CPU_V7A
 	default 7 if CPU_V7M
 	default 7 if CPU_V7R
+	default 7 if CPU_V8M
 	default 8 if ARM64
 
 choice
@@ -445,7 +456,7 @@ config ARCH_CPU_INIT
 
 config SYS_ARCH_TIMER
 	bool "ARM Generic Timer support"
-	depends on CPU_V7A || CPU_V7M || ARM64
+	depends on CPU_V7A || CPU_V7M_V8M || ARM64
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
diff --git a/arch/arm/cpu/armv7m/cpu.c b/arch/arm/cpu/armv7m/cpu.c
index bea0e1d3263..292730c1d7c 100644
--- a/arch/arm/cpu/armv7m/cpu.c
+++ b/arch/arm/cpu/armv7m/cpu.c
@@ -19,6 +19,9 @@
  */
 int cleanup_before_linux(void)
 {
+	if (!CONFIG_IS_ENABLED(LIB_BOOTM) && !CONFIG_IS_ENABLED(LIB_BOOTZ))
+		return 0;
+
 	/*
 	 * this function is called just before we call linux
 	 * it prepares the processor for linux
@@ -45,8 +48,9 @@ int cleanup_before_linux(void)
 }
 
 /*
- * Perform the low-level reset.
+ * Perform the low-level reset. ARMv7M only.
  */
+#if IS_ENABLED(CONFIG_CPU_V7M)
 void reset_cpu(void)
 {
 	/*
@@ -56,8 +60,10 @@ void reset_cpu(void)
 		| (V7M_SCB->aircr & V7M_AIRCR_PRIGROUP_MSK)
 		| V7M_AIRCR_SYSRESET, &V7M_SCB->aircr);
 }
+#endif
 
 void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
-	spl_image->entry_point |= 0x1;
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		spl_image->entry_point |= 0x1;
 }
diff --git a/arch/arm/include/asm/armv7_mpu.h b/arch/arm/include/asm/armv7_mpu.h
index 16b9d0d1aeb..4a6524290d3 100644
--- a/arch/arm/include/asm/armv7_mpu.h
+++ b/arch/arm/include/asm/armv7_mpu.h
@@ -11,7 +11,7 @@
 #include <linux/bitops.h>
 #endif
 
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V7M_V8M
 #define AP_SHIFT			24
 #define XN_SHIFT			28
 #define TEX_SHIFT			19
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 2fae54ebd89..53715db4207 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -12,7 +12,7 @@
 	.syntax unified
 #endif
 
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V7M_V8M
 #define AR_CLASS(x...)
 #define M_CLASS(x...)	x
 #else
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 11cb3a7145e..7b60cecbd49 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_$(PHASE_)LIB_BOOTZ) += zimage.o
 obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
 
-ifdef CONFIG_CPU_V7M
+ifdef CONFIG_CPU_V7M_V8M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
 obj-y	+= crt0_64.o
@@ -32,7 +32,7 @@ else
 obj-y	+= relocate.o
 endif
 
-obj-$(CONFIG_CPU_V7M) += cmd_boot.o
+obj-$(CONFIG_CPU_V7M_V8M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 else
@@ -62,7 +62,7 @@ obj-y	+= sections.o
 CFLAGS_REMOVE_sections.o := $(LTO_CFLAGS)
 
 obj-y	+= stack.o
-ifdef CONFIG_CPU_V7M
+ifdef CONFIG_CPU_V7M_V8M
 obj-y	+= interrupts_m.o
 else ifdef CONFIG_ARM64
 obj-$(CONFIG_FSL_LAYERSCAPE) += ccn504.o
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 727b9c5ca5b..1cde655bc80 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -304,7 +304,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	void (*kernel_entry)(int zero, int arch, uint params);
 	unsigned long r2;
 	kernel_entry = (void (*)(int, int, uint))images->ep;
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V7M_V8M
 	ulong addr = (ulong)kernel_entry | 1;
 	kernel_entry = (void *)addr;
 #endif
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index f2c5aa37a8f..a2c03f3d2f9 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -153,7 +153,7 @@ ENTRY(_main)
 #endif
 	ldr	r0, [r9, #GD_RELOC_OFF]		/* r0 = gd->reloc_off */
 	add	lr, lr, r0
-#if defined(CONFIG_CPU_V7M)
+#if defined(CONFIG_CPU_V7M_V8M)
 	orr	lr, #1				/* As required by Thumb-only */
 #endif
 	ldr	r0, [r9, #GD_RELOCADDR]		/* r0 = gd->relocaddr */
diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index b6a648708f4..21d89e49f13 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -10,7 +10,7 @@
 #include <config.h>
 #include <elf.h>
 #include <linux/linkage.h>
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V7M_V8M
 #include <asm/armv7m.h>
 #endif
 
@@ -26,7 +26,7 @@
 
 WEAK(relocate_vectors)
 
-#ifdef CONFIG_CPU_V7M
+#ifdef CONFIG_CPU_V7M_V8M
 	/*
 	 * On ARMv7-M we only have to write the new vector address
 	 * to VTOR register.
diff --git a/arch/arm/lib/semihosting.S b/arch/arm/lib/semihosting.S
index 6e1691a832c..d50c19f3f8d 100644
--- a/arch/arm/lib/semihosting.S
+++ b/arch/arm/lib/semihosting.S
@@ -13,7 +13,7 @@ ENTRY(smh_trap)
 
 #if defined(CONFIG_ARM64)
 	hlt	#0xf000
-#elif defined(CONFIG_CPU_V7M)
+#elif defined(CONFIG_CPU_V7M_V8M)
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
index 71c0db601aa..366ae771d9b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2093,7 +2093,7 @@ config BOOTP_PXE_DHCP_OPTION
 config BOOTP_VCI_STRING
 	string
 	depends on CMD_BOOTP
-	default "U-Boot.armv7" if CPU_V7A || CPU_V7M || CPU_V7R
+	default "U-Boot.armv7" if CPU_V7A || CPU_V7M_V8M || CPU_V7R
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
index 842433f68aa..67102648703 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_selftest_devicepath.o
 obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += \
 efi_selftest_unicode_collation.o
 
-ifeq ($(CONFIG_CPU_V7A)$(CONFIG_CPU_V7M)$(CONFIG_CPU_V7R),y)
+ifeq ($(CONFIG_CPU_V7A)$(CONFIG_CPU_V7M_V8M)$(CONFIG_CPU_V7R),y)
 obj-y += efi_selftest_unaligned.o
 endif
 obj-$(CONFIG_EFI_LOADER_HII) += efi_selftest_hii.o
-- 
2.53.0

