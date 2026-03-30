Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227F41061B24
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 22:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704A88352B;
	Tue, 31 Mar 2026 00:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="RlVZwlnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341A083CE3; Tue, 31 Mar 2026 00:01:38 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B69280212
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35da8d037a5so602876a91.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1774908093; x=1775512893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sT3+dgYjJQ/g+c3prJPPxCudB6Kw3CFizw1NngUSp5s=;
 b=RlVZwlnIdiipHrjQUsXFBpz5GZWqGlgIGLZ7JtJxi+MZp3UTyMUu1lyDqVbocPytWb
 hsiZc/42AGQuKamTXBf90y3Pk02atGhojyyI/UB81D+lMmvx7Tysho0WauzVRRJzt4Ik
 NKbAcQEy2j8tu9Jd6/cXDoYdZwIkuwe7XyUFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774908093; x=1775512893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sT3+dgYjJQ/g+c3prJPPxCudB6Kw3CFizw1NngUSp5s=;
 b=pwhECjBfVwgl8ekPMWOnmsA49lZgZzV5l/mcyYgtJohHXvYsKsHjNPjOivWfTr+u0f
 8DxbEx7jVxVzD+T3K14k5I58EodHv/7/kWkJa6szNeY4/IeEsYl5l41K24ppaItbJBYw
 YzpFkDIUFc4MySWfDdXNk/lqNI0O25neJ9Wo0ZXAL0WCvoeO3V4GNvadGqg80uVXplLq
 XUHDyw7MxErDPYB6m47vxqyvsL7mynO7SeiBWKjbcqBTsn2VWZLStic3OG7P6oeJ1ohF
 Vva3kJhtw7c31+2yaOqnG7iTwYhRgW09XqeNWcjZyiHNHqAnXNANsyA5w63JdF//FWor
 mpSQ==
X-Gm-Message-State: AOJu0YxTxdxxJf72e3ee8EMKmwDaNqLZgKeOstwXcfuK9syhNHz+BXIh
 cxjf3xQonJ4+B1pEFnyP8MGl0sUYWIymi02xr20GNY+FjdtPxOZJHxL+1J9LJpk5xCzmWvPASI2
 1xuyd
X-Gm-Gg: ATEYQzw+vj/w7ikGp5mRGw98Xm3nkIBdVqzfkp8W+N8U6wWPWmfOc7N8OCoR2ZOfF3u
 4Ltqi/Po3lD3v/aFco6vXoYKxzR19z4XsEVmw/R0yNpT0KtAosZFRrAU9/lr+cF0k1QckWCP8sw
 /X2bMoQBJ7+fAFdPun12PxizayBpDWd42bZHP8fRZK3OGCXpJrT8ER+aVz8NhhWt5HahIDmKkB2
 NZMUu0W90Vx3JCdtoSVt/RIG9QWzbEqEBx/ermkWhuuDwrKItGuO0KczASECJ2o8TFdXpW0JhDx
 lsvsRkB+lxcdSDqhbHLg++9S3HcqgIYquQh3sbZqMXKMkZcUg/OJ4BfeqIah/TqdjUYaIkFZ8j7
 9AaHNUTTCisyBglct1jbcTncFW65NSJf/tvxOdpyLr54zHccu8KdpWNisJ3t0mUW0tWulchXvT/
 MrIIE9Zv8Zm1TgpQ==
X-Received: by 2002:a17:90b:46:b0:35d:9c43:57fe with SMTP id
 98e67ed59e1d1-35d9c435b02mr7274547a91.13.1774908092506; 
 Mon, 30 Mar 2026 15:01:32 -0700 (PDT)
Received: from kinako ([2400:2200:6b0:ddf0:675d:2610:7c9b:872f])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35da9ef1b70sm3950740a91.16.2026.03.30.15.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 15:01:32 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2] m68k: Add LTO support
Date: Tue, 31 Mar 2026 07:01:24 +0900
Message-ID: <20260330220124.2747127-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
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

Most m68k retro/homebrew machines will have limited flash/RAM
so having LTO working would be nice.

Not many changes are need really. Most of this is copy/paste
from the ARM32 version.

The major change is that the direct register usage of d7 for gd
needs to be hidden so that when LTO passes over everything it
doesn't see multiple instances of d7.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/Kconfig                        |  1 +
 arch/m68k/config.mk                 |  8 ++++++--
 arch/m68k/cpu/m680x0/cpu.c          |  2 +-
 arch/m68k/include/asm/global_data.h | 19 +++++++++++++++++++
 arch/m68k/lib/ashldi3.c             |  6 ++++--
 arch/m68k/lib/lshrdi3.c             |  6 ++++--
 arch/m68k/lib/muldi3.c              |  4 +++-
 common/board_r.c                    |  4 ++--
 common/init/board_init.c            |  4 ++--
 9 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4af0da2485fb..488de442f557 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -112,6 +112,7 @@ config ARM
 
 config M68K
 	bool "M68000 architecture"
+	select ARCH_SUPPORTS_LTO
 	select HAVE_PRIVATE_LIBGCC
 	select USE_PRIVATE_LIBGCC
 	select SYS_BOOT_GET_CMDLINE
diff --git a/arch/m68k/config.mk b/arch/m68k/config.mk
index 458953f97122..4d8c83b51cdb 100644
--- a/arch/m68k/config.mk
+++ b/arch/m68k/config.mk
@@ -8,9 +8,13 @@ ifneq ($(CONFIG_M680x0),y)
 PLATFORM_CPPFLAGS += -fPIC
 endif
 KBUILD_LDFLAGS    += -n -pie
-PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
 PLATFORM_RELFLAGS += -ffixed-d7
 ifneq ($(CONFIG_M680x0),y)
 PLATFORM_RELFLAGS += -msep-data
 endif
-LDFLAGS_FINAL     += --gc-sections -pie
+LDFLAGS_FINAL     += -pie
+
+ifneq ($(LTO_ENABLE),y)
+PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
+LDFLAGS_FINAL     += --gc-sections
+endif
diff --git a/arch/m68k/cpu/m680x0/cpu.c b/arch/m68k/cpu/m680x0/cpu.c
index f60b932c7dd4..3f87076b8c3d 100644
--- a/arch/m68k/cpu/m680x0/cpu.c
+++ b/arch/m68k/cpu/m680x0/cpu.c
@@ -24,7 +24,7 @@ void m68k_virt_init_reserve(ulong base)
 	for (i = 0; i < sizeof(*gd_ptr); i++)
 		p[i] = 0;
 
-	gd = gd_ptr;
+	arch_setup_gd(gd);
 
 	gd->malloc_base = base + sizeof(*gd_ptr);
 }
diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
index aea2ccabe083..9150ed4ab466 100644
--- a/arch/m68k/include/asm/global_data.h
+++ b/arch/m68k/include/asm/global_data.h
@@ -32,6 +32,25 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
+#if defined(LTO_ENABLE)
+/* If LTO is enabled we have to hide d7 to avoid multiple symbol declarations */
+#define DECLARE_GLOBAL_DATA_PTR
+#define gd	get_gd()
+
+static inline gd_t *get_gd(void)
+{
+	gd_t *gd_ptr;
+
+	__asm__ volatile("move.l %%d7, %0\n" : "=r" (gd_ptr));
+
+	return gd_ptr;
+}
+#else
 #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("d7")
+#endif
+static inline void arch_setup_gd(gd_t *new_gd)
+{
+	__asm__ volatile("move.l %0, %%d7\n" : : "r" (new_gd));
+}
 
 #endif /* __ASM_GBL_DATA_H */
diff --git a/arch/m68k/lib/ashldi3.c b/arch/m68k/lib/ashldi3.c
index 9a4bc676bf4c..9e84bd0d9a07 100644
--- a/arch/m68k/lib/ashldi3.c
+++ b/arch/m68k/lib/ashldi3.c
@@ -6,6 +6,8 @@
  * Copyright (C) 1989-2015 Free Software Foundation, Inc.
  */
 
+#include <linux/compiler_attributes.h>
+
 #define BITS_PER_UNIT 8
 
 typedef		 int SItype	__attribute__ ((mode (SI)));
@@ -21,7 +23,7 @@ typedef union
   DItype ll;
 } DIunion;
 
-DItype __ashldi3 (DItype u, word_type b)
+__used DItype __ashldi3 (DItype u, word_type b)
 {
 	DIunion w;
 	word_type bm;
@@ -46,4 +48,4 @@ DItype __ashldi3 (DItype u, word_type b)
 	}
 
 	return w.ll;
-}
\ No newline at end of file
+}
diff --git a/arch/m68k/lib/lshrdi3.c b/arch/m68k/lib/lshrdi3.c
index e639e676a269..53163bc5f83f 100644
--- a/arch/m68k/lib/lshrdi3.c
+++ b/arch/m68k/lib/lshrdi3.c
@@ -6,6 +6,8 @@
  * Copyright (C) 1989-2015 Free Software Foundation, Inc.
  */
 
+#include <linux/compiler_attributes.h>
+
 #define BITS_PER_UNIT 8
 
 typedef		 int SItype	__attribute__ ((mode (SI)));
@@ -21,7 +23,7 @@ typedef union
   DItype ll;
 } DIunion;
 
-DItype __lshrdi3 (DItype u, word_type b)
+__used DItype __lshrdi3 (DItype u, word_type b)
 {
 	DIunion w;
 	word_type bm;
@@ -46,4 +48,4 @@ DItype __lshrdi3 (DItype u, word_type b)
 	}
 
 	return w.ll;
-}
\ No newline at end of file
+}
diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
index c42ca1d753e5..06af5533fde3 100644
--- a/arch/m68k/lib/muldi3.c
+++ b/arch/m68k/lib/muldi3.c
@@ -6,6 +6,8 @@
  * Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
  */
 
+#include <linux/compiler_attributes.h>
+
 #define SI_TYPE_SIZE 32
 #define __BITS4 (SI_TYPE_SIZE / 4)
 #define __ll_B (1L << (SI_TYPE_SIZE / 2))
@@ -54,7 +56,7 @@ typedef union
 	DItype ll;
 } DIunion;
 
-DItype __muldi3 (DItype u, DItype v)
+__used DItype __muldi3 (DItype u, DItype v)
 {
 	DIunion w;
 	DIunion uu, vv;
diff --git a/common/board_r.c b/common/board_r.c
index 76f9fc090fbe..58eb69005468 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -800,12 +800,12 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 	 * TODO(sjg@chromium.org): Consider doing this for all archs, or
 	 * dropping the new_gd parameter.
 	 */
-	if (CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP))
+	if ((CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP)) || CONFIG_IS_ENABLED(M68K))
 		arch_setup_gd(new_gd);
 
 #if defined(CONFIG_RISCV)
 	set_gd(new_gd);
-#elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
+#elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64) && !defined(CONFIG_M68K)
 	gd = new_gd;
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
diff --git a/common/init/board_init.c b/common/init/board_init.c
index 2a6f39f51adb..31b499ebad9c 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -14,10 +14,10 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /*
- * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
+ * Unfortunately x86, ARM, RISC-V, M68K can't compile this code as gd is defined
  * as macro and cannot be assigned.
  */
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && !defined(CONFIG_M68K)
 __weak void arch_setup_gd(struct global_data *gd_ptr)
 {
 	gd = gd_ptr;
-- 
2.51.0

