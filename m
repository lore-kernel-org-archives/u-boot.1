Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FE9C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE4282998;
	Tue,  8 Jul 2025 12:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h61JdGR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0998329F; Tue,  8 Jul 2025 12:03:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D93283278
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so1911451f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751969031; x=1752573831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oo4R4NBNb4B0kgbk7S5kV3QiM7KqOluHEutuJOHYEVI=;
 b=h61JdGR06mSvjHgDl2n1rMJXCjRRhccyDStagSrH3SIS/4pNt0znt6Ab32Ky7wydY2
 5w7+PdGAOai6GFX/C8dbdIrObGZ02hFpTmO0OMfOv3h4CcTh0eh7ycdEVlqQlsraCxOY
 9cP6Kf3CpCNsmHmuzhW55uYKhporOgT26hRvE9M9lAP5JN2N4IuBIKmDujCLi1t7+itA
 bVvPn5/rtm5NNGoNAt5vYVZoFdsOoXQKhhMS/V5aC7nu5xJlDqio8X5jDXxXGWIG9H0L
 GyRdEcOSi6R8J332grTzpKLs+3XUjvYAq+8Mf5fzGFhtrYoDvBVRDDZETX72YA+0ZyBi
 Brkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751969031; x=1752573831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oo4R4NBNb4B0kgbk7S5kV3QiM7KqOluHEutuJOHYEVI=;
 b=J9Q2zV9QGThJ3/ZVu+pLyd5jhTgjhM/e5AB7fACRY5d6vrwYqfxVHrovoFmZD+aH8k
 4pR7y37AgK9R9FBttMISK+e0i/8AhxR7RepDu9s7QmKW9iev2i0wiEhPtGOTamg4XIKt
 Sp+qlwpAMavz+WC+riwHO25FVvzcjaEPwpCpj+oxHBmMxNNQb5/N5KuGoIyQlNK2rBvv
 Ftlu5qhv9ToCBo3NtUET/70fwUNcfjN4ZN4Ys/3wldGbj4Q8wvvH/DreHaFuZHTBiZ22
 9bFy7gaGMHxlty2B15SAQYpdg+3UxrAsU74GODM9M7zM1ZlyBCdodCdkOJFEymSNGiw+
 jfeA==
X-Gm-Message-State: AOJu0YwcA/PcrVQQd0oHaL2bZT6AWIyXcaZWlCzjBKza4SKLFxNB82p4
 83u2IcTp3Vh94ESYn5cNmwWFZRETyNX/tqDx5ezqiwAY0wg5kNSu9fu+86UDhnjyCuvSiZRWmbU
 IBNuMnaGKYw==
X-Gm-Gg: ASbGnculcl+syNel6GgTeD3s18p4rPJ7Qwib69BS06jOX0M7VklzQAmJLtvbvSMbaKY
 8JVFhQoUYU/9hDyHQiEdHW/cbuV1WbhCAbTzCHyS2n4+euqR5lYKhAl3vJFDx3R0LkzSfHnJJc3
 EN0kjnL+okdOc8FRRoGzh0XneAw3/Aqmjb6LzK4IWdQzEOsSUYEdrvrFhxDRAUPpgZhZ1DM3Thi
 H57H47DchFSYoFIqH9NRIygVkxCTkC8GWlyhztAIiVp1/BMOTmpTXSdvOv+Pdc738CzfGXFnCs+
 0lXeS/Eg7kmawfyjkWXuOx/SnWwSZ0TRSkUjwTKlTJv55uQBqxJqxYwmAZO8dIXTL1oP2Q==
X-Google-Smtp-Source: AGHT+IG7jZ9AJUJUlRT2TankkC6mYPvWO88ADvv+QUA66G9ARL+0iEfbtuDrKcvBJrrcoovEaFupug==
X-Received: by 2002:adf:b641:0:b0:3a5:3af1:e21b with SMTP id
 ffacd0b85a97d-3b5dde9587fmr1617302f8f.47.1751969031223; 
 Tue, 08 Jul 2025 03:03:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fc4b:50ea:edb:b51a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm12302261f8f.83.2025.07.08.03.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:03:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 2/4] arm: move inline assembly CP15 instructions to
 separate .S files
Date: Tue,  8 Jul 2025 12:02:48 +0200
Message-ID: <20250708100322.2153533-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708100322.2153533-1-jerome.forissier@linaro.org>
References: <20250708100322.2153533-1-jerome.forissier@linaro.org>
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

This is a step towards enabling LTO on some files where it is currently
disabled and/or allow building those files in Thumb mode.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 arch/arm/cpu/arm926ejs/Makefile           |  4 +-
 arch/arm/cpu/arm926ejs/cache.c            | 32 +++-----
 arch/arm/cpu/arm926ejs/cp15.S             | 46 ++++++++++++
 arch/arm/cpu/arm926ejs/cpu.c              | 10 +--
 arch/arm/include/asm/system.h             | 22 +++---
 arch/arm/lib/Makefile                     |  9 ++-
 arch/arm/lib/cache-cp15.c                 | 62 ++++++---------
 arch/arm/lib/cache.c                      |  6 +-
 arch/arm/lib/cp15.S                       | 92 +++++++++++++++++++++++
 arch/arm/mach-kirkwood/Makefile           |  5 +-
 arch/arm/mach-kirkwood/cp15.S             | 13 ++++
 arch/arm/mach-kirkwood/include/mach/cpu.h | 12 +--
 12 files changed, 216 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/cpu/arm926ejs/cp15.S
 create mode 100644 arch/arm/lib/cp15.S
 create mode 100644 arch/arm/mach-kirkwood/cp15.S

diff --git a/arch/arm/cpu/arm926ejs/Makefile b/arch/arm/cpu/arm926ejs/Makefile
index 41d8af506d8..1b40d901413 100644
--- a/arch/arm/cpu/arm926ejs/Makefile
+++ b/arch/arm/cpu/arm926ejs/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 extra-y	= start.o
-obj-y	= cpu.o cache.o
+obj-y	= cpu.o cache.o cp15.o
 
 ifdef	CONFIG_XPL_BUILD
 ifdef	CONFIG_SPL_NO_CPU_SUPPORT
@@ -25,5 +25,7 @@ CFLAGS_cache.o := -marm
 CFLAGS_REMOVE_cpu.o := $(LTO_CFLAGS)
 CFLAGS_REMOVE_cache.o := $(LTO_CFLAGS)
 
+AFLAGS_REMOVE_cp15.o := -mthumb -mthumb-interwork
+
 endif
 endif
diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
index 71b8ad0f71d..3524379d335 100644
--- a/arch/arm/cpu/arm926ejs/cache.c
+++ b/arch/arm/cpu/arm926ejs/cache.c
@@ -9,44 +9,33 @@
 #include <linux/types.h>
 
 #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+void _invalidate_dcache_all(void);
 void invalidate_dcache_all(void)
 {
-	asm volatile("mcr p15, 0, %0, c7, c6, 0\n" : : "r"(0));
+	_invalidate_dcache_all();
 }
 
+void _flush_dcache_all(void);
 void flush_dcache_all(void)
 {
-	asm volatile(
-		"0:"
-		"mrc p15, 0, r15, c7, c14, 3\n"
-		"bne 0b\n"
-		"mcr p15, 0, %0, c7, c10, 4\n"
-		 : : "r"(0) : "memory"
-	);
+	_flush_dcache_all();
 }
 
+void _invalidate_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_range(unsigned long start, unsigned long stop)
 {
 	if (!check_cache_range(start, stop))
 		return;
-
-	while (start < stop) {
-		asm volatile("mcr p15, 0, %0, c7, c6, 1\n" : : "r"(start));
-		start += CONFIG_SYS_CACHELINE_SIZE;
-	}
+	_invalidate_dcache_range(start, stop);
 }
 
+void _flush_dcache_range(unsigned long start, unsigned long stop);
 void flush_dcache_range(unsigned long start, unsigned long stop)
 {
 	if (!check_cache_range(start, stop))
 		return;
 
-	while (start < stop) {
-		asm volatile("mcr p15, 0, %0, c7, c14, 1\n" : : "r"(start));
-		start += CONFIG_SYS_CACHELINE_SIZE;
-	}
-
-	asm volatile("mcr p15, 0, %0, c7, c10, 4\n" : : "r"(0));
+	_flush_dcache_range(start, stop);
 }
 #else /* #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 void invalidate_dcache_all(void)
@@ -70,11 +59,10 @@ __weak void invalidate_l2_cache(void) {}
 
 #if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
 /* Invalidate entire I-cache and branch predictor array */
+void _invalidate_icache_all(void);
 void invalidate_icache_all(void)
 {
-	unsigned long i = 0;
-
-	asm ("mcr p15, 0, %0, c7, c5, 0" : : "r" (i));
+	_invalidate_icache_all();
 }
 #else
 void invalidate_icache_all(void) {}
diff --git a/arch/arm/cpu/arm926ejs/cp15.S b/arch/arm/cpu/arm926ejs/cp15.S
new file mode 100644
index 00000000000..2d7626bc858
--- /dev/null
+++ b/arch/arm/cpu/arm926ejs/cp15.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <config.h>
+#include <linux/linkage.h>
+
+ENTRY(_cache_flush)
+	mcr	p15, 0, r0, c7, c7
+	bx	lr
+ENDPROC(_cache_flush)
+
+ENTRY(_invalidate_dcache_all)
+	mcr	p15, 0, r0, c7, c6, 0
+	bx	lr
+ENDPROC(_invalidate_dcache_all)
+
+ENTRY(_flush_dcache_all)
+0:
+	mrc	p15, 0, r15, c7, c14, 3
+	bne	0b
+	mcr	p15, 0, r0, c7, c10, 4
+	bx	lr
+ENDPROC(_flush_dcache_all)
+
+ENTRY(_invalidate_dcache_range)
+0:
+	mcr	p15, 0, r0, c7, c6, 1
+	add	r0, r0, #CONFIG_SYS_CACHELINE_SIZE
+	cmp	r0, r1
+	blt	0b
+	bx	lr
+ENDPROC(_invalidate_dcache_range)
+
+ENTRY(_flush_dcache_range)
+0:
+	mcr	p15, 0, r0, c7, c14, 1
+	add	r0, r0, #CONFIG_SYS_CACHELINE_SIZE
+	cmp	r0, r1
+	blt	0b
+	mcr	p15, 0, r0, c7, c10, 4
+	bx	lr
+ENDPROC(_flush_dcache_range)
+
+ENTRY(_invalidate_icache_all)
+	mcr	p15, 0, r0, c7, c5, 0
+	bx	lr
+ENDPROC(_invalidate_icache_all)
diff --git a/arch/arm/cpu/arm926ejs/cpu.c b/arch/arm/cpu/arm926ejs/cpu.c
index 0e100e6f13d..9e59ff6c66f 100644
--- a/arch/arm/cpu/arm926ejs/cpu.c
+++ b/arch/arm/cpu/arm926ejs/cpu.c
@@ -55,12 +55,12 @@ int cleanup_before_linux (void)
 	return 0;
 }
 
+void _cache_flush(void);
+
 /* flush I/D-cache */
 static void cache_flush (void)
 {
-#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
-	unsigned long i = 0;
-
-	asm ("mcr p15, 0, %0, c7, c7, 0": :"r" (i));
-#endif
+	if (!(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) &&
+	      CONFIG_IS_ENABLED(SYS_DCACHE_OFF)))
+		_cache_flush();
 }
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 849b3d0efb7..e559a48a6c7 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -456,31 +456,29 @@ static inline int is_hyp(void)
 #endif
 }
 
+unsigned int _get_cr_hyp(void);
+unsigned int _get_cr_nohyp(void);
+
 static inline unsigned int get_cr(void)
 {
 	unsigned int val;
 
 	if (is_hyp())
-		asm volatile("mrc p15, 4, %0, c1, c0, 0	@ get CR" : "=r" (val)
-								  :
-								  : "cc");
+		val = _get_cr_hyp();
 	else
-		asm volatile("mrc p15, 0, %0, c1, c0, 0	@ get CR" : "=r" (val)
-								  :
-								  : "cc");
+		val = _get_cr_nohyp();
 	return val;
 }
 
+unsigned int _set_cr_hyp(unsigned int val);
+unsigned int _set_cr_nohyp(unsigned int val);
+
 static inline void set_cr(unsigned int val)
 {
 	if (is_hyp())
-		asm volatile("mcr p15, 4, %0, c1, c0, 0	@ set CR" :
-								  : "r" (val)
-								  : "cc");
+		_set_cr_hyp(val);
 	else
-		asm volatile("mcr p15, 0, %0, c1, c0, 0	@ set CR" :
-								  : "r" (val)
-								  : "cc");
+		_set_cr_nohyp(val);
 	isb();
 }
 
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index ade42d0ca43..23f73dbba32 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -81,6 +81,10 @@ endif
 obj-y	+= cache.o
 obj-$(CONFIG_SYS_ARM_CACHE_CP15)	+= cache-cp15.o
 CFLAGS_REMOVE_cache-cp15.o := $(LTO_CFLAGS)
+# Low-level CP15 instructions (mrc p15...) cause problems with LTO
+# when they are coded as inline assembly. They are implemented
+# in their own .S file instead.
+obj-$(CONFIG_SYS_ARM_CACHE_CP15) += cp15.o
 
 obj-y	+= psci-dt.o
 
@@ -111,13 +115,14 @@ endif
 # For .S, drop -mthumb* and other thumb-related options.
 # CFLAGS_REMOVE_* would not have an effet, so AFLAGS_REMOVE_*
 # was implemented and is used here.
-# Also, define ${target}_NO_THUMB_BUILD for these two targets
-# so that the code knows it should not use Thumb.
+# Also, define ${target}_NO_THUMB_BUILD for the targets that
+# need to know they should not use Thumb.
 
 AFLAGS_REMOVE_memset.o := -mthumb -mthumb-interwork
 AFLAGS_REMOVE_memcpy.o := -mthumb -mthumb-interwork
 AFLAGS_memset.o := -DMEMSET_NO_THUMB_BUILD
 AFLAGS_memcpy.o := -DMEMCPY_NO_THUMB_BUILD
+AFLAGS_REMOVE_cp15.o := -mthumb -mthumb-interwork
 
 # This is only necessary to force ARM mode on THUMB1 targets.
 ifneq ($(CONFIG_SYS_ARM_ARCH),4)
diff --git a/arch/arm/lib/cache-cp15.c b/arch/arm/lib/cache-cp15.c
index 947012f2996..46eded590eb 100644
--- a/arch/arm/lib/cache-cp15.c
+++ b/arch/arm/lib/cache-cp15.c
@@ -109,6 +109,15 @@ __weak void dram_bank_mmu_setup(int bank)
 		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
 }
 
+void _mmu_helper_lpae_hyp(unsigned long reg, unsigned long addr,
+			  unsigned long attr);
+void _mmu_helper_lpae_nohyp(unsigned long reg, unsigned long addr,
+			    unsigned long attr);
+void _mmu_helper_nolpae_hyp(unsigned long reg);
+void _mmu_helper_nolpae_nohyp(unsigned long reg);
+void _mmu_helper_pt(unsigned long addr);
+void _set_dacr(unsigned long val);
+
 /* to activate the MMU we need to set up virtual memory: use 1M areas */
 static inline void mmu_setup(void)
 {
@@ -141,42 +150,13 @@ static inline void mmu_setup(void)
 	reg |= TTBCR_ORGN0_WBNWA | TTBCR_IRGN0_WBNWA;
 #endif
 
-	if (is_hyp()) {
-		/* Set HTCR to enable LPAE */
-		asm volatile("mcr p15, 4, %0, c2, c0, 2"
-			: : "r" (reg) : "memory");
-		/* Set HTTBR0 */
-		asm volatile("mcrr p15, 4, %0, %1, c2"
-			:
-			: "r"(gd->arch.tlb_addr + (4096 * 4)), "r"(0)
-			: "memory");
-		/* Set HMAIR */
-		asm volatile("mcr p15, 4, %0, c10, c2, 0"
-			: : "r" (MEMORY_ATTRIBUTES) : "memory");
-	} else {
-		/* Set TTBCR to enable LPAE */
-		asm volatile("mcr p15, 0, %0, c2, c0, 2"
-			: : "r" (reg) : "memory");
-		/* Set 64-bit TTBR0 */
-		asm volatile("mcrr p15, 0, %0, %1, c2"
-			:
-			: "r"(gd->arch.tlb_addr + (4096 * 4)), "r"(0)
-			: "memory");
-		/* Set MAIR */
-		asm volatile("mcr p15, 0, %0, c10, c2, 0"
-			: : "r" (MEMORY_ATTRIBUTES) : "memory");
-	}
+	if (is_hyp())
+		_mmu_helper_lpae_hyp(reg, gd->arch.tlb_addr + (4096 * 4),
+				     MEMORY_ATTRIBUTES);
+	else
+		_mmu_helper_lpae_nohyp(reg, gd->arch.tlb_addr + (4096 * 4),
+				       MEMORY_ATTRIBUTES);
 #elif defined(CONFIG_CPU_V7A)
-	if (is_hyp()) {
-		/* Set HTCR to disable LPAE */
-		asm volatile("mcr p15, 4, %0, c2, c0, 2"
-			: : "r" (0) : "memory");
-	} else {
-		/* Set TTBCR to disable LPAE */
-		asm volatile("mcr p15, 0, %0, c2, c0, 2"
-			: : "r" (0) : "memory");
-	}
-	/* Set TTBR0 */
 	reg = gd->arch.tlb_addr & TTBR0_BASE_ADDR_MASK;
 #if defined(CONFIG_SYS_ARM_CACHE_WRITETHROUGH)
 	reg |= TTBR0_RGN_WT | TTBR0_IRGN_WT;
@@ -185,19 +165,19 @@ static inline void mmu_setup(void)
 #else
 	reg |= TTBR0_RGN_WB | TTBR0_IRGN_WB;
 #endif
-	asm volatile("mcr p15, 0, %0, c2, c0, 0"
-		     : : "r" (reg) : "memory");
+	if (is_hyp())
+		_mmu_helper_nolpae_hyp(reg);
+	else
+		_mmu_helper_nolpae_nohyp(reg);
 #else
 	/* Copy the page table address to cp15 */
-	asm volatile("mcr p15, 0, %0, c2, c0, 0"
-		     : : "r" (gd->arch.tlb_addr) : "memory");
+	_mmu_helper_pt(gd->arch.tlb_addr);
 #endif
 	/*
 	 * initial value of Domain Access Control Register (DACR)
 	 * Set the access control to client (1U) for each of the 16 domains
 	 */
-	asm volatile("mcr p15, 0, %0, c3, c0, 0"
-		     : : "r" (0x55555555));
+	_set_dacr(0x55555555);
 
 	/* and enable the mmu */
 	reg = get_cr();	/* get control reg. */
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index dd19bd3e4fb..be3a0b42bff 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -122,12 +122,10 @@ phys_addr_t noncached_alloc(size_t size, size_t align)
 #endif /* CONFIG_SYS_NONCACHED_MEMORY */
 
 #if CONFIG_IS_ENABLED(SYS_THUMB_BUILD)
+void _invalidate_l2_cache(void);
 void invalidate_l2_cache(void)
 {
-	unsigned int val = 0;
-
-	asm volatile("mcr p15, 1, %0, c15, c11, 0 @ invl l2 cache"
-		: : "r" (val) : "cc");
+	_invalidate_l2_cache();
 	isb();
 }
 #endif
diff --git a/arch/arm/lib/cp15.S b/arch/arm/lib/cp15.S
new file mode 100644
index 00000000000..c402d998d64
--- /dev/null
+++ b/arch/arm/lib/cp15.S
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <config.h>
+#include <linux/linkage.h>
+
+ENTRY(_get_cr_hyp)
+	mrc	p15, 4, r0, c1, c0, 0 @ get CR
+	bx	lr
+ENDPROC(_get_cr_hyp)
+
+ENTRY(_get_cr_nohyp)
+	mrc	p15, 0, r0, c1, c0, 0 @ get CR
+	bx	lr
+ENDPROC(_get_cr_nohyp)
+
+ENTRY(_set_cr_hyp)
+	mcr	p15, 4, r0, c1, c0, 0 @ set CR
+	bx	lr
+ENDPROC(_set_cr_hyp)
+
+ENTRY(_set_cr_nohyp)
+	mcr	p15, 0, r0, c1, c0, 0 @ set CR
+	bx	lr
+ENDPROC(_set_cr_nohyp)
+
+ENTRY(_invalidate_l2_cache)
+	mcr	p15, 1, r0, c15, c11, 0 @ invl l2 cache
+	bx	lr
+ENDPROC(_invalidate_l2_cache)
+
+#if defined(CONFIG_ARMV7_LPAE) && __LINUX_ARM_ARCH__ != 4
+
+ENTRY(_mmu_helper_lpae_hyp)
+	/* Set HTCR to enable LPAE */
+	mcr	p15, 4, r0, c2, c0, 2
+	/* Set HTTBR0 */
+	mov	r4, #0
+	mcrr	p15, 4, r1, r4, c2
+	/* Set HMAIR */
+	mcr	p15, 4, r3, c10, c2, 0
+	bx	lr
+ENDPROC(_mmu_helper_lpae_hyp)
+
+ENTRY(_mmu_helper_lpae_nohyp)
+	/* Set TTBCR to enable LPAE */
+	mcr	p15, 0, r0, c2, c0, 2
+	/* Set 64-bit TTBR0 */
+	mov	r4, #0
+	mcrr	p15, 0, r1, r4, c2
+	/* Set MAIR */
+	mcr	p15, 0, r3, c10, c2, 0
+	bx lr
+ENDPROC(_mmu_helper_lpae_nohyp)
+
+#elif defined(CONFIG_CPU_V7A)
+
+ENTRY(_mmu_helper_nolpae_hyp)
+	/* Set HTCR to disable LPAE */
+	mov	r1, #0
+	mcr	p15, 4, r1, c2, c0, 2
+	/* Set TTBR0 */
+	mcr	p15, 0, r0, c2, c0, 0
+	bx	lr
+ENDPROC(_mmu_helper_nolpae_hyp)
+
+ENTRY(_mmu_helper_nolpae_nohyp)
+	/* Set TTBCR to disable LPAE */
+	mov	r1, #0
+	mcr	p15, 0, r1, c2, c0, 2
+	/* Set TTBR0 */
+	mcr	p15, 0, r0, c2, c0, 0
+	bx	lr
+ENDPROC(_mmu_helper_nolpae_nohyp)
+
+#else
+
+ENTRY(_mmu_helper_pt)
+	mcr	p15, 0, r0, c2, c0, 0
+	bx	lr
+ENDPROC(_mmu_helper_pt)
+
+#endif
+
+#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF)) && \
+    defined(CONFIG_SYS_ARM_MMU)
+
+ENTRY(_set_dacr)
+	mcr p15, 0, r0, c3, c0, 0
+	bx	lr
+ENDPROC(_set_dacr)
+
+#endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 0fb5a2326f5..9581c315af8 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -3,14 +3,17 @@
 # (C) Copyright 2009
 # Marvell Semiconductor <www.marvell.com>
 # Written-by: Prafulla Wadaskar <prafulla@marvell.com>
+# Copyright (C) 2025 Linaro Ltd.
 
 obj-y	= cpu.o
+obj-y	+= cp15.o
 obj-y	+= cache.o
 obj-y	+= lowlevel.o
 obj-y	+= mpp.o
 
-# cpu.o and cache.o contain CP15 instructions which cannot be run in
+# cpu.o, cpu_asm.o and cache.o contain CP15 instructions which cannot be run in
 # Thumb state, so build them for ARM state even with CONFIG_SYS_THUMB_BUILD
 
 CFLAGS_cpu.o := -marm
+CFLAGS_cpu_asm.o := -marm
 CFLAGS_cache.o := -marm
diff --git a/arch/arm/mach-kirkwood/cp15.S b/arch/arm/mach-kirkwood/cp15.S
new file mode 100644
index 00000000000..088db9895f7
--- /dev/null
+++ b/arch/arm/mach-kirkwood/cp15.S
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <linux/linkage.h>
+
+ENTRY(readfr_extra_feature_reg)
+	mrc	p15, 1, r0, c15, c1, 0 @ readfr exfr
+	bx	lr
+ENDPROC(readfr_extra_feature_reg)
+
+ENTRY(_writefr_extra_feature_reg)
+	mcr	p15, 1, r0, c15, c1, 0 @ writefr exfr
+	bx	lr
+ENDPROC(_writefr_extra_feature_reg)
diff --git a/arch/arm/mach-kirkwood/include/mach/cpu.h b/arch/arm/mach-kirkwood/include/mach/cpu.h
index 9eec786fe8f..54487d2af85 100644
--- a/arch/arm/mach-kirkwood/include/mach/cpu.h
+++ b/arch/arm/mach-kirkwood/include/mach/cpu.h
@@ -82,22 +82,16 @@ struct mbus_win {
  * read feroceon/sheeva core extra feature register
  * using co-proc instruction
  */
-static inline unsigned int readfr_extra_feature_reg(void)
-{
-	unsigned int val;
-	asm volatile ("mrc p15, 1, %0, c15, c1, 0 @ readfr exfr":"=r"
-			(val)::"cc");
-	return val;
-}
+unsigned int readfr_extra_feature_reg(void);
 
 /*
  * write feroceon/sheeva core extra feature register
  * using co-proc instruction
  */
+void _writefr_extra_feature_reg(unsigned int val);
 static inline void writefr_extra_feature_reg(unsigned int val)
 {
-	asm volatile ("mcr p15, 1, %0, c15, c1, 0 @ writefr exfr"::"r"
-			(val):"cc");
+	_writefr_extra_feature_reg(val);
 	isb();
 }
 
-- 
2.43.0

