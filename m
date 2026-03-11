Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC28D104950E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 09:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273A083FB6;
	Wed, 11 Mar 2026 10:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="QjuS7aZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858A483FD3; Wed, 11 Mar 2026 10:30:58 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9AFC83F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 10:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso7402791b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773221453; x=1773826253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=feYkVQ220cIGyzUQl8EVdIIYBWOJWA4o13iyQRDZR3g=;
 b=QjuS7aZWMhRCdLglG+uzTmCDnbK+jPTpCjfsY6JaPK5QKdJUNsLGp/Z95v2rSuHjw2
 inIKWXP6LUIx+MgyBPRYaWpA/QLk4BBnjQCcPOFljOQu6dxv7uosMnHjDf7aZt04f68O
 bOky6SCK/nliOJiq39MjxZ1D3GDUOa+zO8w+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773221453; x=1773826253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feYkVQ220cIGyzUQl8EVdIIYBWOJWA4o13iyQRDZR3g=;
 b=nEuMoCj7MepGHSk7USj9BjBTNlc01fJf2tuUsG7a6fDNDr7r8GUnZNzCzOhQr96Kr8
 KcWDDyJnQ8R8h9DYPODKSh7hhw1oHuztFuANpCwIZm+sZf591xIikjKrdRZo2DZEbqil
 diAqPU0DlmvpM9veF0XGjVpyyLZBSbeQrVFyHYK6h1eqvV1VFuOwbAiTyjHSoIMu0l5v
 u2IGrpmr92TQhA0AmJ0FyLRTvv9VRyl0du+YeBB6dBJ7juJV5crdPP0xpm33zWGV0zV7
 OJVyx/VbjPLJdZuteULYb8kxSiCRxz2knqf+ER/mMY5Ic6k1wBw4RrTuyEauWi2bGeg8
 TDUA==
X-Gm-Message-State: AOJu0YxcD8PVHkNSgt+KEkLK+UkQcJRqaB98M4vVaURUEJNqpcjMnaYL
 vjhbd82vYsL5l5ufV/q+3mCVBjO6Pj3w+bNClgfz7P9JhB02ln4Zvb4u5XEJMsWVcOk7aJuvLRt
 03XjF
X-Gm-Gg: ATEYQzx9w5AKGLxIaJtHDctvCCKyZC9vbkFanXh+NHcgN2TWkObUtx63i01c/rhWWta
 UdgeGqfY+xjWEL1Lb5392cD8YXO/wevTwVpSAZw5U26Q5H+lp0lV4aSIBXTc63tO9Bv18qsei9m
 H3SyOBE661F7tTKR+BwOsfjiCTVnde2Imb6yuYom5+Di/MLl7JW+FiViNnUJkmOtFIvAxDMs25p
 dX1i8RaMz60Up0f/ToIigU/0DeFll0FY+eTOVV7ZBXgW8QEr96mqIA2WSuvawAsJTKRmH/dGJIZ
 zBOPPUtV9oMA9q4DQAjkSKkqKLM29/xYb9X30EgQfr90AeZ0du0FyMkmPtC6xG5XpZhbmG+6qD0
 cZUml0b+vsMgZgfquqbZ8DdkpcgkAvuugOc7zJo1Qo7DV+WNb+ewSNqXFwNgyWyAlIHp7lI98DN
 6ichO5LSOf8vzS
X-Received: by 2002:a05:6a00:3d4e:b0:829:a8a8:307e with SMTP id
 d2e1a72fcca58-829f71c4b63mr2116532b3a.65.1773221453110; 
 Wed, 11 Mar 2026 02:30:53 -0700 (PDT)
Received: from kinako ([2400:2200:413:a1d:f125:1dc2:b046:d067])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-829f703a47bsm1640694b3a.60.2026.03.11.02.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 02:30:52 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] m68k: Add LTO support
Date: Wed, 11 Mar 2026 18:30:48 +0900
Message-ID: <20260311093048.1773382-1-daniel@thingy.jp>
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

This is another patch from my vault that I have been using
on various classic m68k machines for ages. I haven't tested
it with coldfire though.

 arch/Kconfig                        |  1 +
 arch/m68k/config.mk                 | 11 +++++++++--
 arch/m68k/cpu/m680x0/cpu.c          |  2 +-
 arch/m68k/include/asm/global_data.h | 19 +++++++++++++++++++
 arch/m68k/lib/ashldi3.c             |  1 +
 arch/m68k/lib/lshrdi3.c             |  1 +
 arch/m68k/lib/muldi3.c              |  1 +
 common/board_r.c                    |  4 ++--
 common/init/board_init.c            |  2 +-
 9 files changed, 36 insertions(+), 6 deletions(-)

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
index 458953f97122..1be46adda966 100644
--- a/arch/m68k/config.mk
+++ b/arch/m68k/config.mk
@@ -8,9 +8,16 @@ ifneq ($(CONFIG_M680x0),y)
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
+ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
+LDFLAGS_FINAL     += --gc-sections
+endif
+
+ifneq ($(LTO_ENABLE),y)
+PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
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
index 9a4bc676bf4c..82bd9113ecbf 100644
--- a/arch/m68k/lib/ashldi3.c
+++ b/arch/m68k/lib/ashldi3.c
@@ -21,6 +21,7 @@ typedef union
   DItype ll;
 } DIunion;
 
+DItype __ashldi3 (DItype u, word_type b) __attribute__((used));
 DItype __ashldi3 (DItype u, word_type b)
 {
 	DIunion w;
diff --git a/arch/m68k/lib/lshrdi3.c b/arch/m68k/lib/lshrdi3.c
index e639e676a269..691d503d7313 100644
--- a/arch/m68k/lib/lshrdi3.c
+++ b/arch/m68k/lib/lshrdi3.c
@@ -21,6 +21,7 @@ typedef union
   DItype ll;
 } DIunion;
 
+DItype __lshrdi3 (DItype u, word_type b) __attribute__((used));
 DItype __lshrdi3 (DItype u, word_type b)
 {
 	DIunion w;
diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
index c42ca1d753e5..53d674701531 100644
--- a/arch/m68k/lib/muldi3.c
+++ b/arch/m68k/lib/muldi3.c
@@ -54,6 +54,7 @@ typedef union
 	DItype ll;
 } DIunion;
 
+DItype __muldi3 (DItype u, DItype v) __attribute__((used));
 DItype __muldi3 (DItype u, DItype v)
 {
 	DIunion w;
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
index 2a6f39f51adb..c56b33e7be7c 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -17,7 +17,7 @@ DECLARE_GLOBAL_DATA_PTR;
  * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
  * as macro and cannot be assigned.
  */
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && !defined(CONFIG_M68K)
 __weak void arch_setup_gd(struct global_data *gd_ptr)
 {
 	gd = gd_ptr;
-- 
2.51.0

