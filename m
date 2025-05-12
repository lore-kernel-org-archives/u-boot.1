Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC5CC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B455682952;
	Mon, 12 May 2025 18:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fXSz2x58";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VOGk9ElP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE83826AA; Mon, 12 May 2025 18:53:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658C380584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zx5K10FH5z9sWG;
 Mon, 12 May 2025 18:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P0EPCVHg4L6MRGDBDigNI3ZUbHudu1DEvbG9B4kt+Ag=;
 b=fXSz2x58c9cmJpqD1CcqVWZqIzEtBs42mbGccuLf9euoqCNk22n7kA8/MGxP6skQw5U8HH
 of76F6d95ru6dtQTSYZ1VYxnsPG4cUgo5eIRCxvk8pU5fFMOT8Xgiad/3KfBiO+BSjKhF6
 F61TiHjIrGG3JxlCjv5kjbBPeEAKlYx6aX38cxPzZsOeCrkUoHUfSBttDviLjbKvcL94Qy
 mDhZMZxqcYpx4A8q2fkuygx+cNYL92xrLHssjA4NK/LkSnzm6NOgDMVb1zAqpN7ZkNc16s
 +bGrz0rdDF9ubW4UJT6cnYlJpTn8EqU/7bvLjT0ESFUt5R2F/bnJdYQs/TJuKg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P0EPCVHg4L6MRGDBDigNI3ZUbHudu1DEvbG9B4kt+Ag=;
 b=VOGk9ElPOZhmZWPfjD3/50iqK7nbj9utzLdF/ywnwchEsJrupLQwB7FrJpkOYUufQemmvK
 q9P69kQyMwKoIKqV1M/kdus7Nb246YIfHA//A65un+5DwlmSFaKKV9IYpNTfYS0jdLx31q
 n9sNgDjCUb4vU+Ttdr7IqZ/T9xjEN4dMZa307c/jO+EAEeON2zU7K4L0McJXL1l1pZJcqz
 glgZhrQCCs0jczKiGzM5AKct2C8iqYXstTUalNxvgD/tbY5hEd1yBqf6ROB652EFE5D7Y9
 UK+//L1zmAUiRdmmkpRxa8k+31yqtQ5wNaZo9cmPZNgoOy+H+4Sb3AsjwLgTMQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM: bootm: Add support for starting Linux through
 OpTee-OS on ARMv7a
Date: Mon, 12 May 2025 18:52:12 +0200
Message-ID: <20250512165307.148434-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 04f30aa116c855059ff
X-MBO-RS-META: afexst8suhmepjgijycngdjxb5djes4m
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

Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
This is only supported if U-Boot runs in PL1 secure. This change adds
two components, one is fitImage OpTee-OS loadable handler, which makes
a note of OpTee-OS being loaded and stores the load address for later
jump to it. The second part is the actual jump to Linux through OpTee-OS.
The jump through OpTee-OS requires set up of multiple CPU registers, r1
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
 arch/arm/include/asm/armv7.h |  2 ++
 arch/arm/lib/Makefile        |  3 +++
 arch/arm/lib/bootm-optee.S   | 30 +++++++++++++++++++++++
 arch/arm/lib/bootm.c         | 47 +++++++++++++++++++++++++++---------
 4 files changed, 71 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/lib/bootm-optee.S

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
index 7eb764e1f4e..f5343217505 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -283,9 +283,9 @@ static void switch_to_el1(void)
 #endif
 
 /* Subcommand: GO */
+#ifdef CONFIG_ARM64
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
-#ifdef CONFIG_ARM64
 	void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
 			void *res2);
 	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
@@ -323,7 +323,13 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 					    ES_TO_AARCH64);
 #endif
 	}
+}
 #else
+static bool boot_jump_via_optee;
+static unsigned long boot_jump_via_optee_addr;
+
+static void boot_jump_linux(struct bootm_headers *images, int flag)
+{
 	unsigned long machid = gd->bd->bi_arch_number;
 	char *s;
 	void (*kernel_entry)(int zero, int arch, uint params);
@@ -335,6 +341,13 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	ulong addr = (ulong)kernel_entry | 1;
 	kernel_entry = (void *)addr;
 #endif
+
+	if (IS_ENABLED(CONFIG_ARMV7_NONSEC) && armv7_boot_nonsec() &&
+	    boot_jump_via_optee) {
+		printf("Cannot start OpTee-OS from NS\n");
+		return;
+	}
+
 	s = env_get("machid");
 	if (s) {
 		if (strict_strtoul(s, 16, &machid) < 0) {
@@ -354,19 +367,31 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	else
 		r2 = gd->bd->bi_boot_params;
 
-	if (!fake) {
-#ifdef CONFIG_ARMV7_NONSEC
-		if (armv7_boot_nonsec()) {
-			armv7_init_nonsec();
-			secure_ram_addr(_do_nonsec_entry)(kernel_entry,
-							  0, machid, r2);
-		} else
-#endif
-			kernel_entry(0, machid, r2);
+	if (fake)
+		return;
+
+	if (armv7_boot_nonsec())
+		armv7_init_nonsec();
+
+	if (boot_jump_via_optee)
+		boot_jump_linux_via_optee(kernel_entry, machid, r2, boot_jump_via_optee_addr);
+
+	if (IS_ENABLED(CONFIG_ARMV7_NONSEC) && armv7_boot_nonsec()) {
+		armv7_init_nonsec();
+		secure_ram_addr(_do_nonsec_entry)(kernel_entry, 0, machid, r2);
+	} else {
+		kernel_entry(0, machid, r2);
 	}
-#endif
 }
 
+static void arch_tee_image_process(ulong image, size_t size)
+{
+	boot_jump_via_optee = true;
+	boot_jump_via_optee_addr = image;
+}
+U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TEE, arch_tee_image_process);
+#endif
+
 /* Main Entry point for arm bootm implementation
  *
  * Modeled after the powerpc implementation
-- 
2.47.2

