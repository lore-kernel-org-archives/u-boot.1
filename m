Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED5BC369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 14:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165A1820E1;
	Sun, 27 Apr 2025 16:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="M2XmHXsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A014F820E1; Sun, 27 Apr 2025 16:52:16 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A63FA80FDA
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 16:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 715F225D52;
 Sun, 27 Apr 2025 16:52:14 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HALkP8sUYLl6; Sun, 27 Apr 2025 16:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745765533; bh=EaiAk+02Ty4Jbf9mFTjoJW9yimUG/8U02OhCFF6Fzr0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M2XmHXsbqvNWn0Lc3dQkphjXEpVlIFpZMMaKh1Zci+EVAXlGQ1oRQUiYZLiF6wx2A
 d6w5qEACg82tDpQgmeyrjXMhOfFEuD3FsTtBeJ8yT4In9bjRHQUUyC0sQj6vtYc2MD
 9e2tX7M/I7+Z1p0UWt1HDRZjbKDbY0lQQT6JeMGfOO61D0gwvUnDEY1coT2h2Uw9DJ
 clfQazuxpRmKDXMEyQY6lsgW8BhCug1MZb49bpmh5/D0KldLz/j9T2HhtcyQ+kGDoB
 Y7YF83919IdS587gxovLpzppiMNnZTAlQ+SEmOA7eY0RsIHId+9MJt4knIgrYvnMBM
 vKLBxi2MRnR2Q==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Nathaniel Hourt <I@nathaniel.land>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/2] riscv: Access gd with inline assembly when building with
 LTO or Clang
Date: Sun, 27 Apr 2025 14:50:11 +0000
Message-ID: <20250427145011.17331-3-ziyao@disroot.org>
In-Reply-To: <20250427145011.17331-1-ziyao@disroot.org>
References: <20250427145011.17331-1-ziyao@disroot.org>
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

Similar to AArch64's case, Clang may wrongly fold accesses to gd pointer
which is defined with register qualifier into constants, breaking
various components.

This patch defines gd as a macro when building with Clang or LTO, which
expands to get_gd() that accesses gp pointer in assembly, making RISC-V
ports function properly and preparing for introduction of LTO in the
future. Board initialization code is also adapted for non-assignable gd.

Reported-by: Nathaniel Hourt <I@nathaniel.land>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/cpu.c                 |  6 ++++++
 arch/riscv/include/asm/global_data.h | 19 +++++++++++++++++++
 common/board_r.c                     |  4 +++-
 common/init/board_init.c             |  7 +++++--
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 5b31da64cbd..15c4e14599d 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -18,6 +18,7 @@
 #include <asm/hwcap.h>
 #include <asm/cpufeature.h>
 #include <asm/cache.h>
+#include <asm/global_data.h>
 #include <dm/uclass-internal.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
@@ -746,3 +747,8 @@ __weak int cleanup_before_linux(void)
 
 	return 0;
 }
+
+void arch_setup_gd(gd_t *new_gd)
+{
+	set_gd(new_gd);
+}
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index d356752a56a..47b5e2cfc8f 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -14,6 +14,7 @@
 #include <asm/smp.h>
 #include <asm/u-boot.h>
 #include <compiler.h>
+#include <config.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
@@ -47,8 +48,26 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
+#if defined(__clang__) || CONFIG_IS_ENABLED(LTO)
+
+#define DECLARE_GLOBAL_DATA_PTR
+#define gd			get_gd()
+
+static inline gd_t *get_gd(void)
+{
+	gd_t *gd_ptr;
+
+	__asm__ volatile ("mv %0, gp\n" : "=r" (gd_ptr));
+
+	return gd_ptr;
+}
+
+#else
+
 #define DECLARE_GLOBAL_DATA_PTR register gd_t *gd asm ("gp")
 
+#endif
+
 static inline void set_gd(volatile gd_t *gd_ptr)
 {
 #ifdef CONFIG_64BIT
diff --git a/common/board_r.c b/common/board_r.c
index bc6fd6448c2..4fa092ab596 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -815,7 +815,9 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 	if (CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP))
 		arch_setup_gd(new_gd);
 
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
+#if defined(CONFIG_RISCV)
+	set_gd(new_gd);
+#elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	gd = new_gd;
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
diff --git a/common/init/board_init.c b/common/init/board_init.c
index a06ec1caa2c..2a6f39f51ad 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -13,8 +13,11 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/* Unfortunately x86 or ARM can't compile this code as gd cannot be assigned */
-#if !defined(CONFIG_X86) && !defined(CONFIG_ARM)
+/*
+ * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
+ * as macro and cannot be assigned.
+ */
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
 __weak void arch_setup_gd(struct global_data *gd_ptr)
 {
 	gd = gd_ptr;
-- 
2.49.0

