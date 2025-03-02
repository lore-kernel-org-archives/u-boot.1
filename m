Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E711C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 14:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2DD81101;
	Sun,  2 Mar 2025 15:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kJaSsTkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8D180050; Sun,  2 Mar 2025 15:22:02 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2E581115
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 15:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 07F1C42827; 
 Sun,  2 Mar 2025 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740925302;
 bh=LlnUiuaTtTNqGvPml2inRexJqVrpT0kyizbYYNrjB7A=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kJaSsTkRBKQaCh0CbEwVsbLaN3GIZ32kz1DdYSI/eh2f7TDC5SAq9ME46VUJS34XA
 buDIIAxUlZxIvK2f5jhzHJNw2q7TG3DIql76CbqGMr8a23y2tcI2CPRW7dPdPxN6wM
 TyHC+TIxjkRVjhf0vdcRkF2Q0LuIgWEE1WMGIccDnYvb9Z8JtNSI3vBSIP93Q1SnTn
 8uWvul1EZ7zkJOihgocR7wG5Q0r6d6hH36ElrfaM5iemWTy/Ov/8ohtH3hn+GfzivC
 UwZ5aVVhbDpsrevPDPOnJ6x0WPH/zlx4kTTCD2zNYsJPKtAtTDzv4QabBjfcoYed1J
 2N11wU+vjhEjg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/5] common: clean up setjmp.h
Date: Sun,  2 Mar 2025 15:21:19 +0100
Message-ID: <20250302142121.150480-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
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

Separate setjmp.h into an architecture independent part and an architecture
specific part. This simplifies moving from using struct jmp_buf_data
directly to using type jmp_buf in our code which is the C compliant way.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/cpu/armv7/exception_level.c |  2 +-
 arch/arm/cpu/armv8/exception_level.c |  2 +-
 arch/arm/include/asm/setjmp.h        | 15 +++--------
 arch/arm/mach-rockchip/bootrom.c     |  2 +-
 arch/riscv/include/asm/setjmp.h      | 15 +++--------
 arch/sandbox/cpu/cpu.c               |  2 +-
 arch/sandbox/include/asm/setjmp.h    | 16 +++--------
 arch/x86/include/asm/setjmp.h        | 11 +++-----
 include/interrupt.h                  |  2 +-
 include/setjmp.h                     | 40 ++++++++++++++++++++++++++++
 lib/efi_loader/efi_boottime.c        |  2 +-
 test/lib/longjmp.c                   |  2 +-
 12 files changed, 59 insertions(+), 52 deletions(-)
 create mode 100644 include/setjmp.h

diff --git a/arch/arm/cpu/armv7/exception_level.c b/arch/arm/cpu/armv7/exception_level.c
index 7baade61b07..c63b0e13666 100644
--- a/arch/arm/cpu/armv7/exception_level.c
+++ b/arch/arm/cpu/armv7/exception_level.c
@@ -11,9 +11,9 @@
 #include <bootm.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <setjmp.h>
 #include <asm/armv7.h>
 #include <asm/secure.h>
-#include <asm/setjmp.h>
 
 /**
  * entry_non_secure() - entry point when switching to non-secure mode
diff --git a/arch/arm/cpu/armv8/exception_level.c b/arch/arm/cpu/armv8/exception_level.c
index 85c78f55789..58e816007f0 100644
--- a/arch/arm/cpu/armv8/exception_level.c
+++ b/arch/arm/cpu/armv8/exception_level.c
@@ -11,8 +11,8 @@
 #include <bootm.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <setjmp.h>
 #include <asm/cache.h>
-#include <asm/setjmp.h>
 
 /**
  * entry_non_secure() - entry point when switching to non-secure mode
diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
index 9a7f5af9f8f..a9eccf7f632 100644
--- a/arch/arm/include/asm/setjmp.h
+++ b/arch/arm/include/asm/setjmp.h
@@ -4,15 +4,11 @@
  * (C) Copyright 2016 Alexander Graf <agraf@suse.de>
  */
 
-#ifndef _SETJMP_H_
-#define _SETJMP_H_	1
+#ifndef _ASM_SETJMP_H_
+#define _ASM_SETJMP_H_	1
 
 #include <asm-generic/int-ll64.h>
 
-/*
- * This really should be opaque, but the EFI implementation wrongly
- * assumes that a 'struct jmp_buf_data' is defined.
- */
 struct jmp_buf_data {
 #if defined(__aarch64__)
 	u64  regs[13];
@@ -21,9 +17,4 @@ struct jmp_buf_data {
 #endif
 };
 
-typedef struct jmp_buf_data jmp_buf[1];
-
-int setjmp(jmp_buf jmp);
-void longjmp(jmp_buf jmp, int ret);
-
-#endif /* _SETJMP_H_ */
+#endif /* _ASM_SETJMP_H_ */
diff --git a/arch/arm/mach-rockchip/bootrom.c b/arch/arm/mach-rockchip/bootrom.c
index 82a0b3efef9..1db38546d55 100644
--- a/arch/arm/mach-rockchip/bootrom.c
+++ b/arch/arm/mach-rockchip/bootrom.c
@@ -4,11 +4,11 @@
  */
 
 #include <hang.h>
+#include <setjmp.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/boot_mode.h>
 #include <asm/cache.h>
 #include <asm/io.h>
-#include <asm/setjmp.h>
 #include <asm/system.h>
 
 /*
diff --git a/arch/riscv/include/asm/setjmp.h b/arch/riscv/include/asm/setjmp.h
index 72383d43303..08687e0f92b 100644
--- a/arch/riscv/include/asm/setjmp.h
+++ b/arch/riscv/include/asm/setjmp.h
@@ -3,13 +3,9 @@
  * (C) Copyright 2018 Alexander Graf <agraf@suse.de>
  */
 
-#ifndef _SETJMP_H_
-#define _SETJMP_H_	1
+#ifndef _ASM_SETJMP_H_
+#define _ASM_SETJMP_H_	1
 
-/*
- * This really should be opaque, but the EFI implementation wrongly
- * assumes that a 'struct jmp_buf_data' is defined.
- */
 struct jmp_buf_data {
 	/* x2, x8, x9, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, sp */
 	unsigned long s_regs[12];	/* s0 - s11 */
@@ -17,9 +13,4 @@ struct jmp_buf_data {
 	unsigned long sp;
 };
 
-typedef struct jmp_buf_data jmp_buf[1];
-
-int setjmp(jmp_buf jmp);
-void longjmp(jmp_buf jmp, int ret);
-
-#endif /* _SETJMP_H_ */
+#endif /* _ASM_SETJMP_H_ */
diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 6407193c5f1..6db8739e66b 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -10,10 +10,10 @@
 #include <errno.h>
 #include <log.h>
 #include <os.h>
+#include <setjmp.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/malloc.h>
-#include <asm/setjmp.h>
 #include <asm/state.h>
 #include <dm/ofnode.h>
 #include <linux/delay.h>
diff --git a/arch/sandbox/include/asm/setjmp.h b/arch/sandbox/include/asm/setjmp.h
index 47dc8938cd6..3413c747783 100644
--- a/arch/sandbox/include/asm/setjmp.h
+++ b/arch/sandbox/include/asm/setjmp.h
@@ -4,8 +4,8 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#ifndef _SETJMP_H_
-#define _SETJMP_H_
+#ifndef _ASM_SETJMP_H_
+#define _ASM_SETJMP_H_
 
 struct jmp_buf_data {
 	/*
@@ -22,14 +22,4 @@ struct jmp_buf_data {
 	unsigned long data[128];
 };
 
-typedef struct jmp_buf_data jmp_buf[1];
-
-/*
- * We have to directly link with the system versions of
- * setjmp/longjmp, because setjmp must not return as otherwise
- * the stack may become invalid.
- */
-int setjmp(jmp_buf jmp);
-__noreturn void longjmp(jmp_buf jmp, int ret);
-
-#endif /* _SETJMP_H_ */
+#endif /* _ASM_SETJMP_H_ */
diff --git a/arch/x86/include/asm/setjmp.h b/arch/x86/include/asm/setjmp.h
index 15915d0dc6b..13772574e15 100644
--- a/arch/x86/include/asm/setjmp.h
+++ b/arch/x86/include/asm/setjmp.h
@@ -5,8 +5,8 @@
  * From Linux arch/um/sys-i386/setjmp.S
  */
 
-#ifndef __setjmp_h
-#define __setjmp_h
+#ifndef _ASM_SETJMP_H_
+#define _ASM_SETJMP_H_	1
 
 #ifdef CONFIG_X86_64
 
@@ -34,9 +34,4 @@ struct jmp_buf_data {
 
 #endif
 
-typedef struct jmp_buf_data jmp_buf[1];
-
-int setjmp(jmp_buf env);
-void longjmp(jmp_buf env, int val);
-
-#endif
+#endif /* _ASM_SETJMP_H_ */
diff --git a/include/interrupt.h b/include/interrupt.h
index 46ef2e196d4..6ea28b54a56 100644
--- a/include/interrupt.h
+++ b/include/interrupt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-#include <asm/setjmp.h>
+#include <setjmp.h>
 
 /**
  * struct resume_data - data for resume after interrupt
diff --git a/include/setjmp.h b/include/setjmp.h
new file mode 100644
index 00000000000..37d3a8af85d
--- /dev/null
+++ b/include/setjmp.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _SETJMP_H_
+#define _SETJMP_H_ 1
+
+#ifdef CONFIG_HAVE_SETJMP
+#include <asm/setjmp.h>
+#else
+struct jmp_buf_data {
+};
+#endif
+
+/**
+ * typedef jmp_buf - information needed to restore a calling environment
+ */
+typedef struct jmp_buf_data jmp_buf[1];
+
+/**
+ * setjmp() - prepare for a long jump
+ *
+ * Registers, the stack pointer, and the return address are saved in the
+ * jump bufffer. The function returns zero afterwards. When longjmp() is
+ * executed the function returns a second time with a non-zero value.
+ *
+ * @env:	jump buffer used to store register values
+ * Return:	0 after setting up jump buffer, non-zero after longjmp()
+ */
+int setjmp(jmp_buf env);
+
+/**
+ * longjmp() - long jump
+ *
+ * Jump back to the address and the register state saved by setjmp().
+ *
+ * @env:	jump buffer
+ * @val:	value to be returned by setjmp(), 0 is replaced by 1
+ */
+void longjmp(jmp_buf env, int val);
+
+#endif /* _SETJMP_H_ */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 5164cb15986..bdf9e7e8066 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -21,7 +21,7 @@
 #include <usb.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
-#include <asm/setjmp.h>
+#include <setjmp.h>
 #include <linux/libfdt_env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/test/lib/longjmp.c b/test/lib/longjmp.c
index 79d889bdd5f..74c3465b8c2 100644
--- a/test/lib/longjmp.c
+++ b/test/lib/longjmp.c
@@ -5,10 +5,10 @@
  * Copyright (c) 2021, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
+#include <setjmp.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
-#include <asm/setjmp.h>
 
 struct test_jmp_buf {
 	jmp_buf env;
-- 
2.48.1

