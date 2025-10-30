Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E44ECCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 21:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F8E83677;
	Thu, 30 Oct 2025 22:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Lyv+Kn6Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jJB9hmga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F047083887; Thu, 30 Oct 2025 22:24:11 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439FD8334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 22:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cyHDS63qxz9sp2;
 Thu, 30 Oct 2025 22:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761859448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aIPhI9dwLRWDBbB575LyYZd9Zv9xXDFWfDuxWPt4Atg=;
 b=Lyv+Kn6Q8BdFdjWwqeZe6blpGoWp6DyPNU1Ofb0DgQkuQKvbWIwL90XxJlFrNmhErrdFRv
 5OaH+4atVWXtKEO9+PMvdJznm6Qsa8aYZlZKnpNP7MvcHwb3VElOGp9xcs+rnzzlbOna2n
 jMg7EeVoDwx8poFkV/0j5wA1pAqxojLD0kBJJGUi05puvj+NK4N3z8bl9XGbyS/LzbA46V
 lskWc6Qjs/DXQldIPhelfGbJ/+Mkb89phaE0+m1E++xHySmOPQPhMtFm4psnJPW8JuFRra
 92fm6pU6ZILkdICQex9ydN3Qsy+qi9SuFzuM+sbbGlZcUeaUpUzWF/JSBt8vJg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761859446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aIPhI9dwLRWDBbB575LyYZd9Zv9xXDFWfDuxWPt4Atg=;
 b=jJB9hmgab4Q2yOaOMMHufeX1y8Y66pshD1iIz5LvIcPijsZCFiZwBTryDxNVsqUYACq3kM
 FTlLfggko2w014/zfbAT6NJDUYyLKcpjmvCOAxDX/WggAPDE3I2lp1M+4+AWaEh0DYL1Oe
 UwrLHsHGw6G+N+4I8IE3unURTvAMTmCdj6czkFz271Pl7hIFYCuFh/aso99KlEaYv+LNqk
 ++4Hycl8a1lTxt5OE6xlRNfThmGpnjp/GnnDefukrEwv9IW4b8wK7SmEHhxqLghRiyv0oI
 omJBl7qEfY33ZzzQT9U9IT6FzMcmUfJtmPDwtEX/FOF37wZVOaCgssiCCAiNHg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/2] ARM: bootm: Add support for starting Linux through
 OPTEE-OS on ARMv7a
Date: Thu, 30 Oct 2025 22:23:49 +0100
Message-ID: <20251030212359.12824-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c000879d6814d8306f7
X-MBO-RS-META: nm8udyy7359thhjiujkykdu4dnizz441
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

Add support for jumping to Linux kernel through OPTEE-OS on ARMv7a.
This is only supported if U-Boot runs in PL1 secure. This change adds
two components, one is fitImage OPTEE-OS loadable handler, which makes
a note of OPTEE-OS being loaded and stores the load address for later
jump to it. The second part is the actual jump to Linux through OPTEE-OS.
The jump through OPTEE-OS requires set up of multiple CPU registers, r1
and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
Linux kernel entry point. This setup is done by new assembler function
boot_jump_linux_via_optee().

The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
configuration write, this cannot be moved easily, hence the ifdef.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Janne Grunau <j@jannau.net>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Add ifdeffery around armv7_init_nonsec(), boot_jump_linux_via_optee(),
      secure_ram_addr() due to external dependencies which may not be reachable
    - Add ifdeffery around arch_tee_image_process() to avoid breaking OMAP2
      IH_TYPE_TEE loading
V3: Add documentation
V4: s@OpTee-OS@OPTEE-OS@
---
 arch/arm/include/asm/armv7.h       |  2 +
 arch/arm/lib/Makefile              |  3 ++
 arch/arm/lib/bootm-optee.S         | 30 ++++++++++++
 arch/arm/lib/bootm.c               | 56 ++++++++++++++++++----
 doc/usage/fit/index.rst            |  1 +
 doc/usage/fit/kernel_fdt_optee.rst | 76 ++++++++++++++++++++++++++++++
 6 files changed, 159 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/lib/bootm-optee.S
 create mode 100644 doc/usage/fit/kernel_fdt_optee.rst

diff --git a/arch/arm/include/asm/armv7.h b/arch/arm/include/asm/armv7.h
index c002998ac0b..bfffbbd5d9a 100644
--- a/arch/arm/include/asm/armv7.h
+++ b/arch/arm/include/asm/armv7.h
@@ -142,6 +142,8 @@ bool armv7_boot_nonsec(void);
 unsigned int _nonsec_init(void);
 void _do_nonsec_entry(void *target_pc, unsigned long r0,
 		      unsigned long r1, unsigned long r2);
+void boot_jump_linux_via_optee(void *target_pc, unsigned long r1,
+			       unsigned long r2, unsigned long tee_entry);
 void _smp_pen(void);
 
 extern char __secure_start[];
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index ade42d0ca43..92149d7058c 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_CMD_BOOTZ) += zimage.o
 endif
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 endif
+ifndef CONFIG_ARM64
+obj-$(CONFIG_BOOTM_OPTEE) += bootm-optee.o
+endif
 ifdef CONFIG_ARM64
 obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMSET) += memset-arm64.o
 obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMCPY) += memcpy-arm64.o
diff --git a/arch/arm/lib/bootm-optee.S b/arch/arm/lib/bootm-optee.S
new file mode 100644
index 00000000000..9d1a77b563d
--- /dev/null
+++ b/arch/arm/lib/bootm-optee.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright (C) 2025 Marek Vasut
+ */
+#include <config.h>
+#include <linux/linkage.h>
+
+ENTRY(boot_jump_linux_via_optee)
+	mov	r4, r3
+	mov	lr, r0
+	mov	r3, #0
+	mov	r0, #0
+
+	/*
+	 * Special TZC handling on this platform, the last
+	 * 'str' has to be immediately before 'bx' and can
+	 * not be interleaved with any return from function
+	 * call, if it is then the system hangs.
+	 */
+#if defined(CONFIG_STM32MP13X) && !defined(CONFIG_TFABOOT)
+	ldr	r6, =STM32_TZC_BASE + 0x114 + (0x20 * 2)
+	mov	r7, #0x0
+	str	r7, [r6]
+	ldr	r6, =STM32_TZC_BASE + 0x110 + (0x20 * 1)
+	mov	r7, #0x1
+	str	r7, [r6]
+#endif
+
+	bx	r4
+ENDPROC(boot_jump_linux_via_optee)
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index b874aa252c6..019eca95780 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -259,6 +259,11 @@ bool armv7_boot_nonsec(void)
 
 	return nonsec;
 }
+#else
+bool armv7_boot_nonsec(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_ARM64
@@ -284,9 +289,9 @@ static void switch_to_el1(void)
 #endif
 
 /* Subcommand: GO */
+#ifdef CONFIG_ARM64
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
-#ifdef CONFIG_ARM64
 	void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
 			void *res2);
 	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
@@ -324,7 +329,13 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 					    ES_TO_AARCH64);
 #endif
 	}
+}
 #else
+static __maybe_unused bool boot_jump_via_optee;
+static __maybe_unused unsigned long boot_jump_via_optee_addr;
+
+static void boot_jump_linux(struct bootm_headers *images, int flag)
+{
 	unsigned long machid = gd->bd->bi_arch_number;
 	char *s;
 	void (*kernel_entry)(int zero, int arch, uint params);
@@ -336,6 +347,13 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	ulong addr = (ulong)kernel_entry | 1;
 	kernel_entry = (void *)addr;
 #endif
+
+	if (IS_ENABLED(CONFIG_ARMV7_NONSEC) && armv7_boot_nonsec() &&
+	    boot_jump_via_optee) {
+		printf("Cannot start OPTEE-OS from NS\n");
+		return;
+	}
+
 	s = env_get("machid");
 	if (s) {
 		if (strict_strtoul(s, 16, &machid) < 0) {
@@ -355,19 +373,39 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	else
 		r2 = gd->bd->bi_boot_params;
 
-	if (!fake) {
+	if (fake)
+		return;
+
 #ifdef CONFIG_ARMV7_NONSEC
-		if (armv7_boot_nonsec()) {
-			armv7_init_nonsec();
-			secure_ram_addr(_do_nonsec_entry)(kernel_entry,
-							  0, machid, r2);
-		} else
+	if (armv7_boot_nonsec())
+		armv7_init_nonsec();
 #endif
-			kernel_entry(0, machid, r2);
-	}
+
+#ifdef CONFIG_BOOTM_OPTEE
+	if (boot_jump_via_optee)
+		boot_jump_linux_via_optee(kernel_entry, machid, r2, boot_jump_via_optee_addr);
+#endif
+
+#ifdef CONFIG_ARMV7_NONSEC
+	if (armv7_boot_nonsec()) {
+		secure_ram_addr(_do_nonsec_entry)(kernel_entry, 0, machid, r2);
+	} else
 #endif
+	{
+		kernel_entry(0, machid, r2);
+	}
 }
 
+#ifndef CONFIG_TI_SECURE_DEVICE
+static void arch_tee_image_process(ulong image, size_t size)
+{
+	boot_jump_via_optee = true;
+	boot_jump_via_optee_addr = image;
+}
+U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TEE, arch_tee_image_process);
+#endif
+#endif
+
 /* Main Entry point for arm bootm implementation
  *
  * Modeled after the powerpc implementation
diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index a822bf20cb2..6c78d8584ed 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -14,6 +14,7 @@ images that it reads and boots. Documentation about FIT is available in
     howto
     kernel_fdt
     kernel_fdts_compressed
+    kernel_fdt_optee
     kernel
     multi
     multi_spl
diff --git a/doc/usage/fit/kernel_fdt_optee.rst b/doc/usage/fit/kernel_fdt_optee.rst
new file mode 100644
index 00000000000..07587710fe5
--- /dev/null
+++ b/doc/usage/fit/kernel_fdt_optee.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Single kernel, FDT blob and OPTEE-OS
+====================================
+
+Example FIT image description file demonstrating the usage of the
+bootm command to launch OPTEE-OS before starting Linux kernel on
+STM32MP13xx.
+
+::
+
+    /dts-v1/;
+
+    / {
+        description = "Simple image with single Linux kernel and FDT blob";
+        #address-cells = <1>;
+
+        images {
+            kernel {
+                description = "Vanilla Linux kernel";
+                data = /incbin/("./arch/arm/boot/zImage");
+                type = "kernel";
+                arch = "arm";
+                os = "linux";
+                compression = "none";
+                load = <0xc0008000>;
+                entry = <0xc0008000>;
+                hash-1 {
+                    algo = "crc32";
+                };
+                hash-2 {
+                    algo = "sha256";
+                };
+            };
+            fdt-1 {
+                description = "Flattened Device Tree blob";
+                data = /incbin/("./arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb");
+                type = "flat_dt";
+                arch = "arm";
+                compression = "none";
+                hash-1 {
+                    algo = "crc32";
+                };
+                hash-2 {
+                    algo = "sha256";
+                };
+            };
+            /* Bundled OPTEE-OS */
+            tee-1 {
+                description = "OP-TEE";
+                data = /incbin/("/path/to/optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin");
+                type = "tee";
+                arch = "arm";
+                compression = "none";
+                os = "tee";
+                load = <0xde000000>;
+                entry = <0xde000000>;
+                hash-1 {
+                    algo = "crc32";
+                };
+                hash-2 {
+                    algo = "sha256";
+                };
+            };
+        };
+
+        configurations {
+            default = "conf-1";
+            conf-1 {
+                description = "Boot Linux kernel with FDT blob";
+                kernel = "kernel";
+                fdt = "fdt-1";
+                loadables = "tee-1"; /* OPTEE-OS */
+            };
+        };
+    };
-- 
2.51.0

