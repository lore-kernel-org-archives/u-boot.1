Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E961C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A308E8123D;
	Sun,  2 Mar 2025 13:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E3x/EQW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB7D810FE; Sat,  1 Mar 2025 17:50:18 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBF0810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e4ce6e3b8cso4135598a12.1
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847815; x=1741452615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcAqcJNfWqweFE1GPoiBVQCiRLD7w9qqzYkdcnlfdhI=;
 b=E3x/EQW3FdGUykCgR3WZOTbqAnbqFb9cnA4hkyYyGMpOQOj9rG22KIy3mpkWsrohEN
 froe7yqt1o/MLgSLso7lR72BGn7RUIrcrecM+RYu19Dbj13F0Ww5isYFriHdaqr7m2y4
 eKBU9aHukLWGOZdkwqrRaT+cQxfPyYNJzaLNxJhHzN/Ze29Tp4w+IDF32im6QICLX40z
 CjKJQoUh9hXJew9q7G6dllisARXXovbb2vK9U5IhiFsfkUQI6STdDrpx8Za0ooBd1k4Q
 soiVx9lOAdmbKJjjhS6g5p5vgUFf8RWPbsaWxxj7AoHUQIqZMwRoRxr8CevloBCRBDkI
 HRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847815; x=1741452615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OcAqcJNfWqweFE1GPoiBVQCiRLD7w9qqzYkdcnlfdhI=;
 b=C7zUIyZCKYjqd1RVHW4U/aF27XpyLXS3ajNMx6zrkHp4S36+59gYaMIx+AO9bcDUG2
 7+e9EuXy5atjlYKf28Y4Do0K/r0M77v6smw+OeK78YEtcwQnzsaK6/eg7CkiwpACKkbh
 6xvZtt57Otp8lws9pGCS/Os71RNNNwxbAzuYFJsAOoWlLj/VRnCQWw2CMFJQ2t3zSqyP
 C4+Vhf7P0nR8yX7Rk4qXcMBDn/z3l5gDWfYR8JZFM69LqoBT5mqRdMvOee0xXxqiLUJ0
 2ebpGk5rP9gubvKk9n6sCPXWaw5l/gS3MACTniQeibryMXRQ/RWeMLdfRLuiLBctcOrn
 N/cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfq/4k+AEyLW5hh0fC2VYUz+O9xi6cGL6gB1DZRy4DUIimgGHy+UWCJcQKtk8vnZec5jD3pag=@lists.denx.de
X-Gm-Message-State: AOJu0YxJaiiQvFa2yCBr63bc0iVdk6OHYYJnYb6ImRS9NzBdXTMTvFhi
 6j/DOhl6OTi01tCeQ03w/antiw0f6jS5oRqt0rOqTY16/PphRwmMRu09bx3qCt4=
X-Gm-Gg: ASbGnctDDIa8HdPRtWKeEAa7vCss129JqBEBRhE7cYKK7HcokJBWtj3GufChQwIXwb2
 AaCzvu1YDEtn/WXoONzCDfSd2mjtbUU79kCHRDeP1HgZ3RvVGWXqkvDYWjHYKDFixq4I6bve3cL
 PB+06RC0FzH2OWZHCUP6JoK5PqTDta3p7dif0buqohyLEw5jdORvvliRkj9wneKenTiJAs4WNXL
 BEdRt5eV6Wf3o7Var+IbOW1JhozvTVFXQAA7EnW4Jx9dnUvO2Og4rt0pmhct5n4BCyiCHfZm/ly
 5R1oY8TVus/5/IenPlwnpu/wOYGyB6SaGqDA1pMQWtiBnBgBXK8tNbk1zRJBl5N+go1HSrGVIDn
 XTmemUjYBWPyZpZu93Em3AbM=
X-Google-Smtp-Source: AGHT+IFRPRhqM03225vA7hwFoqwJmarrocQ5qsjEN1llQGtIF9np03uY+/Vfro8DpcYSb/4L1TgmSw==
X-Received: by 2002:a05:6402:1e91:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5e4d52ac8b1mr9821022a12.2.1740847815243; 
 Sat, 01 Mar 2025 08:50:15 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:50:14 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 5/6] treewide: Add a function to change page permissions
Date: Sat,  1 Mar 2025 18:49:03 +0200
Message-ID: <20250301164922.397441-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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

For armv8 we are adding proper page permissions for the relocated U-Boot
binary. Add a weak function that can be used across architectures to change
the page permissions

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905X-CC
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arc/lib/cache.c           |  6 ++++++
 arch/arm/cpu/arm926ejs/cache.c |  6 ++++++
 arch/arm/cpu/armv7/cache_v7.c  |  6 ++++++
 arch/arm/cpu/armv7m/cache.c    |  6 ++++++
 arch/arm/cpu/armv8/cache_v8.c  | 25 +++++++++++++++++++++++++
 arch/arm/lib/cache.c           |  6 ++++++
 arch/m68k/lib/cache.c          |  6 ++++++
 arch/nios2/lib/cache.c         |  6 ++++++
 arch/powerpc/lib/cache.c       |  6 ++++++
 arch/riscv/lib/cache.c         |  6 ++++++
 arch/sh/cpu/sh4/cache.c        |  6 ++++++
 arch/xtensa/lib/cache.c        |  6 ++++++
 include/cpu_func.h             | 17 +++++++++++++++++
 13 files changed, 108 insertions(+)

diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
index 5169fc627fa5..08f9e7dceac0 100644
--- a/arch/arc/lib/cache.c
+++ b/arch/arc/lib/cache.c
@@ -8,6 +8,7 @@
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <asm/arcregs.h>
@@ -819,3 +820,8 @@ void sync_n_cleanup_cache_all(void)
 
 	__ic_entire_invalidate();
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
index 5b87a3af91b2..71b8ad0f71d8 100644
--- a/arch/arm/cpu/arm926ejs/cache.c
+++ b/arch/arm/cpu/arm926ejs/cache.c
@@ -5,6 +5,7 @@
  */
 #include <cpu_func.h>
 #include <asm/cache.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
@@ -88,3 +89,8 @@ void enable_caches(void)
 	dcache_enable();
 #endif
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
index d11420d2fdd0..371dc92cd46c 100644
--- a/arch/arm/cpu/armv7/cache_v7.c
+++ b/arch/arm/cpu/armv7/cache_v7.c
@@ -6,6 +6,7 @@
  */
 #include <cpu_func.h>
 #include <asm/cache.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <asm/armv7.h>
 #include <asm/utils.h>
@@ -209,3 +210,8 @@ __weak void v7_outer_cache_flush_all(void) {}
 __weak void v7_outer_cache_inval_all(void) {}
 __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
 __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
index b6d08b7aad73..8e7db7340557 100644
--- a/arch/arm/cpu/armv7m/cache.c
+++ b/arch/arm/cpu/armv7m/cache.c
@@ -11,6 +11,7 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/errno.h>
 
 /* Cache maintenance operation registers */
 
@@ -370,3 +371,8 @@ void enable_caches(void)
 	dcache_enable();
 #endif
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 29100913bc82..b6835206ff7f 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -1032,6 +1033,30 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
 	mmu_change_region_attr_nobreak(addr, siz, attrs);
 }
 
+int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
+
+	switch (perm) {
+	case MMU_ATTR_RO:
+		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
+		break;
+	case MMU_ATTR_RX:
+		attrs |= PTE_BLOCK_RO;
+		break;
+	case MMU_ATTR_RW:
+		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+		break;
+	default:
+		log_err("Unknown attribute %d\n", perm);
+		return -EINVAL;
+	}
+
+	mmu_change_region_attr_nobreak(addr, size, attrs);
+
+	return 0;
+}
+
 #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 
 /*
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf9..dd19bd3e4fb3 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -170,3 +171,8 @@ __weak int arm_reserve_mmu(void)
 
 	return 0;
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
index 370ad40f1423..a21fe3279440 100644
--- a/arch/m68k/lib/cache.c
+++ b/arch/m68k/lib/cache.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <asm/immap.h>
 #include <asm/cache.h>
+#include <linux/errno.h>
 
 volatile int *cf_icache_status = (int *)ICACHE_STATUS;
 volatile int *cf_dcache_status = (int *)DCACHE_STATUS;
@@ -151,3 +152,8 @@ __weak void flush_dcache_range(unsigned long start, unsigned long stop)
 {
 	/* An empty stub, real implementation should be in platform code */
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
index 8f543f2a2f26..d7fd9ca8bd4a 100644
--- a/arch/nios2/lib/cache.c
+++ b/arch/nios2/lib/cache.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -127,3 +128,8 @@ void dcache_disable(void)
 {
 	flush_dcache_all();
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
index a9cd7b8d30ac..e4d9546039d8 100644
--- a/arch/powerpc/lib/cache.c
+++ b/arch/powerpc/lib/cache.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <asm/cache.h>
 #include <watchdog.h>
+#include <linux/errno.h>
 
 static ulong maybe_watchdog_reset(ulong flushed)
 {
@@ -58,3 +59,8 @@ void invalidate_icache_all(void)
 {
 	puts("No arch specific invalidate_icache_all available!\n");
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index 71e4937ab542..31aa30bc7d72 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <asm/insn-def.h>
 #include <linux/const.h>
+#include <linux/errno.h>
 
 #define CBO_INVAL(base)						\
 	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
@@ -151,3 +152,8 @@ __weak void enable_caches(void)
 	if (!zicbom_block_size)
 		log_debug("Zicbom not initialized.\n");
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index 99acc5999652..56161ee72e4b 100644
--- a/arch/sh/cpu/sh4/cache.c
+++ b/arch/sh/cpu/sh4/cache.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <linux/errno.h>
 
 #define CACHE_VALID       1
 #define CACHE_UPDATED     2
@@ -126,3 +127,8 @@ int dcache_status(void)
 {
 	return 0;
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
index e6a7f6827fc2..1229b4077835 100644
--- a/arch/xtensa/lib/cache.c
+++ b/arch/xtensa/lib/cache.c
@@ -6,6 +6,7 @@
 
 #include <cpu_func.h>
 #include <asm/cache.h>
+#include <linux/errno.h>
 
 /*
  * We currently run always with caches enabled when running from memory.
@@ -57,3 +58,8 @@ void invalidate_icache_all(void)
 {
 	__invalidate_icache_all();
 }
+
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
+{
+	return -ENOSYS;
+}
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 7e81c4364a73..70a41ead3f73 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -69,6 +69,23 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_range(unsigned long start, unsigned long stop);
 void invalidate_dcache_all(void);
 void invalidate_icache_all(void);
+
+enum pgprot_attrs {
+	MMU_ATTR_RO,
+	MMU_ATTR_RX,
+	MMU_ATTR_RW,
+};
+
+/** pgprot_set_attrs() - Set page table permissions
+ *
+ * @addr: Physical address start
+ * @size: size of memory to change
+ * @perm: New permissions
+ *
+ * Return: 0 on success, error otherwise.
+ **/
+int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm);
+
 /**
  * noncached_init() - Initialize non-cached memory region
  *
-- 
2.47.2

