Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074A6C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6006980FA4;
	Thu, 20 Feb 2025 22:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WP/iUUuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97BD80F5F; Thu, 20 Feb 2025 14:56:06 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619798001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4398e839cd4so12510525e9.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059764; x=1740664564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE7LbKIfrrFvQvUE4Er+NhcZNjIniCA0xj7Zf/eun+Q=;
 b=WP/iUUuhliUmLDrmhpGavvx6XfskQUTPWqLY7iQXT9CIW7L6HjAqLo/Pms+9qPtevO
 yRHWdsMUDde7rHdd9cd1KIR/kWSWgFM5nmF/BP7iQRoYtKN4I2LA+eRl2/MstsjXpvFv
 RTGHbQ/YfpX39v3ZVD+H3nM87bIDKC9GQTHR0BUxbIFxKPf0WkR4ibI7n+v3WV2pH6XJ
 Wea5PtjCgzhBxzVBpzXqiKfxQMqU8TNuN0+mwZxM7Wlbug1Et67jgghM7EkSZWItFnu+
 FBn/snZqG8s7BoiuffQu251tQRXHQUKE0P8wHwgfVHIwj6MfwHDZ5YOm8Gpp4srQdQcQ
 V7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059764; x=1740664564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SE7LbKIfrrFvQvUE4Er+NhcZNjIniCA0xj7Zf/eun+Q=;
 b=lesxXdW3tgZjUqDCC7MHEYC3pifVf7hKWJ5sBTSgsZHcof5Zs6EQozM2U9gHmTl4kK
 O9GHe0qkUZ5zqUVWGauFDHwizwi2X2YV/4tEP2Z8u6oUksAxbj3Xdnk5Agc7BfUKSelz
 aZZ4DuEWmgxsnnt2yNu7gc4SWpd/I5FOd6Zv1O6zKSgmGRN2pyRM4O13xnLHVAAoIX5d
 yy79QKbWDaMTwktfpUd59WqlF1UFvXCj4Gu/EKPI57LBpLzccdsZCLmZusXgruHLjmzn
 E3GRcvEmDuJ/0ewDLIn9/615u8aPPBtCkLUwcDt0Mo+MEddKbY70PaQcAeQR3AxJW3Nt
 5sxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvRP5foT8p2eWPpb2Nx9R2q1f7klttaeKhhfxWQt0fmQ5Qan/B2PkPXMYpYFpAFNn3SqwGpVY=@lists.denx.de
X-Gm-Message-State: AOJu0YxYEeVBJz7mwAPneImYTkakKStCpDwLfhMJ9xNxq6Ag4twlN3Ui
 0aRxGW/v+Y8eLyD5VyAlaSYXKgSzyzNC9dcQ70tfiwKu/haEzFnIL8U0r+JtQws=
X-Gm-Gg: ASbGncucOd9Hcd5yX5NWJG5k3VjtsdRTTFwUfwZPN0zPaogNf6vs5SiXXlFwcTJJQNE
 tcbs+aat35BLjFqt7wfgZ1fUrpwfMIXiNdd8phDEdIzbDKZ6xO1PrVk0XkurpRG1KJ9d7m99WR4
 qMWx9WzJGpewo9qf9byrssw3UqNsZKrGYTLmnvw1BBbJFL2C3z/ZXTx29b4yXzY/eVQqUmN7RRB
 DMQYNC9zmrHf+jegN82vuclh0qVBNl2/AAM/fIRAueuLGQtpDdGhjYWlbf2RwjyK5AcUeSYg+4+
 V+JgcZ+o1fmmkCkZmCYnJMkWh/DIKbrpp5FPU78jWLvhFvsrWSwrdXHpzFkwYgD7xe+9GQ==
X-Google-Smtp-Source: AGHT+IG8y9aOKGZJkxZKg1L5PnUVrRPVZYdnMguOXwfYC2UsfjGZAFv5pp2LAl6iW8WV3mDEsBtVCA==
X-Received: by 2002:a05:600c:6d87:b0:439:8a64:db3c with SMTP id
 5b1f17b1804b1-439a2eb0ce6mr28695805e9.1.1740059763772; 
 Thu, 20 Feb 2025 05:56:03 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:56:03 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 5/6] treewide: Add a function to change page permissions
Date: Thu, 20 Feb 2025 15:54:42 +0200
Message-ID: <20250220135506.151894-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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
index 5169fc627fa5..2f8b14f77b55 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
index 5b87a3af91b2..6051fd47c449 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
index d11420d2fdd0..937b32a7f136 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
index b6d08b7aad73..b16a9c8f723b 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 670379e17b7a..b6ea7efc7b75 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -1028,6 +1029,30 @@ skip_break:
 	__asm_invalidate_tlb_all();
 }
 
+int pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
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
+		log_err("Unknown attribute %llx\n", perm);
+		return -EINVAL;
+	}
+
+	mmu_change_region_attr(addr, size, attrs, false);
+
+	return 0;
+}
+
 #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 
 /*
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf9..d4f1528b453d 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
index 370ad40f1423..fce852db2988 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
index 8f543f2a2f26..70f258a1760b 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
index a9cd7b8d30ac..b434fbc4b4a5 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index 71e4937ab542..d3ec9d460259 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index 99acc5999652..4e6751bfd2f5 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
index e6a7f6827fc2..17e1e21f28b9 100644
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
+int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
+{
+	return -ENOSYS;
+}
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 7e81c4364a73..ed21bf71293f 100644
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
+int pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
+
 /**
  * noncached_init() - Initialize non-cached memory region
  *
-- 
2.47.2

