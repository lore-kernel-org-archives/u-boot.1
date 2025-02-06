Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC770C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D67D80EAF;
	Thu,  6 Feb 2025 22:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738877490;
	bh=sDfd9CbJQwmH6ng6rIMKW77SbMx/n9LqgzILzqfJx+U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gPjr02r/qz0yoSibgEotbuQFTl9WuMsOWgdw777Nc6ZocPHKE5Cm6fLfZTM+tasHu
	 8FiMuce5fynGvKzA97rbHBaOyPEI+Nn83bzjT86WrMNu20H+5oNzwnruIiTUn/CuW6
	 BNvmCSTsKL/WftPd5fkJL8clrLw3ScZiaFgka1v0IRNhb0TgeC0kEFYYhJehad4VRz
	 iUHFxmWtmNYU8hy+MASb0LGfRql1JjCC/73YDMZJTZPmapf3RMwWbDb/ne/uL3UW38
	 G6GBNJuGs53fFNJXBASgpKPUjYZrsQ1HzeCguk5V/Ytfz+t3wzEW+T3ESco4YTY14f
	 74QPic0kwDhog==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC2680ECC; Thu,  6 Feb 2025 22:31:29 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2322980C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aMN1DASW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E0C31048AF46; Thu,  6 Feb 2025 22:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738877485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sDfd9CbJQwmH6ng6rIMKW77SbMx/n9LqgzILzqfJx+U=;
 b=aMN1DASW6+76LK/wPpjrSd9zy7hreoLZ91UWc3y/05sTEkWqih8SO2IC/OUb6Dr021hGTy
 NJGaUsRVN+yup0DDLKFhDcJVAjBYEZhL5g2wJCTH3hwnME7xFuMtnZrwuddeAE0EvHrzJR
 ahM1weUGkIeUlE2667wcJO6aOFfF+Y4IZGPofHw7BgEFQFOXfoSR51DqKpDoIZGL8DlOSk
 9pZ/qJG3rn1EnwJe/fr7sigp1qlDdilgN4WLgMWfRuqxI1LvhfYXYz9aftQu/MrttzPjAf
 lNai9lw6bxZboOtU4ww9aTDI9xkulYrwPK0RGI23++Y+XuYE2YOtoyEm5vuWvg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: versal: Consistently use enum tcm_mode
Date: Thu,  6 Feb 2025 22:29:36 +0100
Message-ID: <20250206213039.42756-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Turn anonymous enum TCM_LOCK/TCM_SPLIT into enum tcm_mode {}, set
TCM_LOCK as 0 and TCM_SPLIT as 1 to match LOCK and SPLIT macros in
mach-zynqmp/mp.c, and unify all the functions and their parameters
on this one single enum tcm_mode {} instead of a mix of bool and u8.
No functional change intended.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: Compile tested only
---
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Padmarao Begari <padmarao.begari@amd.com>
Cc: Prasad Kummari <prasad.kummari@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-versal/include/mach/sys_proto.h | 10 +--
 arch/arm/mach-versal/mp.c                     | 12 +--
 arch/arm/mach-zynqmp/cpu.c                    |  2 +-
 arch/arm/mach-zynqmp/include/mach/sys_proto.h | 12 +--
 arch/arm/mach-zynqmp/mp.c                     | 81 +++++++++----------
 arch/arm/mach-zynqmp/zynqmp.c                 |  2 +-
 6 files changed, 58 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index 757bd873fbe..a6dfa556966 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -5,11 +5,11 @@
 
 #include <linux/build_bug.h>
 
-enum {
-	TCM_LOCK,
-	TCM_SPLIT,
+enum tcm_mode {
+	TCM_LOCK = 0,
+	TCM_SPLIT = 1,
 };
 
-void initialize_tcm(bool mode);
-void tcm_init(u8 mode);
+void initialize_tcm(enum tcm_mode mode);
+void tcm_init(enum tcm_mode mode);
 void mem_map_fill(void);
diff --git a/arch/arm/mach-versal/mp.c b/arch/arm/mach-versal/mp.c
index 921ca49c359..7423b8dc312 100644
--- a/arch/arm/mach-versal/mp.c
+++ b/arch/arm/mach-versal/mp.c
@@ -24,7 +24,7 @@
 #define VERSAL_CRL_RST_CPU_R5_RESET_PGE_MASK	0x10
 #define VERSAL_CRLAPB_CPU_R5_CTRL_CLKACT_MASK	0x1000000
 
-static void set_r5_halt_mode(u8 halt, u8 mode)
+static void set_r5_halt_mode(u8 halt, enum tcm_mode mode)
 {
 	u32 tmp;
 
@@ -45,7 +45,7 @@ static void set_r5_halt_mode(u8 halt, u8 mode)
 	}
 }
 
-static void set_r5_tcm_mode(u8 mode)
+static void set_r5_tcm_mode(enum tcm_mode mode)
 {
 	u32 tmp;
 
@@ -63,7 +63,7 @@ static void set_r5_tcm_mode(u8 mode)
 	writel(tmp, &rpu_base->rpu_glbl_ctrl);
 }
 
-static void release_r5_reset(u8 mode)
+static void release_r5_reset(enum tcm_mode mode)
 {
 	u32 tmp;
 
@@ -87,9 +87,9 @@ static void enable_clock_r5(void)
 	writel(tmp, &crlapb_base->cpu_r5_ctrl);
 }
 
-void initialize_tcm(bool mode)
+void initialize_tcm(enum tcm_mode mode)
 {
-	if (!mode) {
+	if (mode == TCM_LOCK) {
 		set_r5_tcm_mode(TCM_LOCK);
 		set_r5_halt_mode(HALT, TCM_LOCK);
 		enable_clock_r5();
@@ -102,7 +102,7 @@ void initialize_tcm(bool mode)
 	}
 }
 
-void tcm_init(u8 mode)
+void tcm_init(enum tcm_mode mode)
 {
 	puts("WARNING: Initializing TCM overwrites TCM content\n");
 	initialize_tcm(mode);
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 960ffac2105..b7a4142fd54 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -113,7 +113,7 @@ u64 get_page_table_size(void)
 }
 
 #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
-void tcm_init(u8 mode)
+void tcm_init(enum tcm_mode mode)
 {
 	int ret;
 
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index 9af3ab5d6b6..b6a41df1da4 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -41,18 +41,18 @@ enum {
 	ZYNQMP_SILICON_V4,
 };
 
-enum {
-	TCM_LOCK,
-	TCM_SPLIT,
+enum tcm_mode {
+	TCM_LOCK = 0,
+	TCM_SPLIT = 1,
 };
 
 unsigned int zynqmp_get_silicon_version(void);
 
-int check_tcm_mode(bool mode);
-void initialize_tcm(bool mode);
+int check_tcm_mode(enum tcm_mode mode);
+void initialize_tcm(enum tcm_mode mode);
 void mem_map_fill(void);
 #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
-void tcm_init(u8 mode);
+void tcm_init(enum tcm_mode mode);
 #endif
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
index 448bc532867..d2a7f305ccc 100644
--- a/arch/arm/mach-zynqmp/mp.c
+++ b/arch/arm/mach-zynqmp/mp.c
@@ -17,9 +17,6 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 
-#define LOCK		0
-#define SPLIT		1
-
 #define HALT		0
 #define RELEASE		1
 
@@ -65,11 +62,11 @@ int cpu_reset(u32 nr)
 	return 0;
 }
 
-static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
+static void set_r5_halt_mode(u32 nr, u8 halt, enum tcm_mode mode)
 {
 	u32 tmp;
 
-	if (mode == LOCK || nr == ZYNQMP_CORE_RPU0) {
+	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU0) {
 		tmp = readl(&rpu_base->rpu0_cfg);
 		if (halt == HALT)
 			tmp &= ~ZYNQMP_RPU_CFG_CPU_HALT_MASK;
@@ -78,7 +75,7 @@ static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
 		writel(tmp, &rpu_base->rpu0_cfg);
 	}
 
-	if (mode == LOCK || nr == ZYNQMP_CORE_RPU1) {
+	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU1) {
 		tmp = readl(&rpu_base->rpu1_cfg);
 		if (halt == HALT)
 			tmp &= ~ZYNQMP_RPU_CFG_CPU_HALT_MASK;
@@ -88,12 +85,12 @@ static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
 	}
 }
 
-static void set_r5_tcm_mode(u8 mode)
+static void set_r5_tcm_mode(enum tcm_mode mode)
 {
 	u32 tmp;
 
 	tmp = readl(&rpu_base->rpu_glbl_ctrl);
-	if (mode == LOCK) {
+	if (mode == TCM_LOCK) {
 		tmp &= ~ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK;
 		tmp |= ZYNQMP_RPU_GLBL_CTRL_TCM_COMB_MASK |
 		       ZYNQMP_RPU_GLBL_CTRL_SLCLAMP_MASK;
@@ -106,12 +103,12 @@ static void set_r5_tcm_mode(u8 mode)
 	writel(tmp, &rpu_base->rpu_glbl_ctrl);
 }
 
-static void set_r5_reset(u32 nr, u8 mode)
+static void set_r5_reset(u32 nr, enum tcm_mode mode)
 {
 	u32 tmp;
 
 	tmp = readl(&crlapb_base->rst_lpd_top);
-	if (mode == LOCK) {
+	if (mode == TCM_LOCK) {
 		tmp |= (ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
 			ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK |
 			ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK);
@@ -130,16 +127,16 @@ static void set_r5_reset(u32 nr, u8 mode)
 	writel(tmp, &crlapb_base->rst_lpd_top);
 }
 
-static void release_r5_reset(u32 nr, u8 mode)
+static void release_r5_reset(u32 nr, enum tcm_mode mode)
 {
 	u32 tmp;
 
 	tmp = readl(&crlapb_base->rst_lpd_top);
-	if (mode == LOCK || nr == ZYNQMP_CORE_RPU0)
+	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU0)
 		tmp &= ~(ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
 			 ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK);
 
-	if (mode == LOCK || nr == ZYNQMP_CORE_RPU1)
+	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU1)
 		tmp &= ~(ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
 			 ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK);
 
@@ -165,9 +162,9 @@ static int check_r5_mode(void)
 
 	tmp = readl(&rpu_base->rpu_glbl_ctrl);
 	if (tmp & ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK)
-		return SPLIT;
+		return TCM_SPLIT;
 
-	return LOCK;
+	return TCM_LOCK;
 }
 
 int cpu_disable(u32 nr)
@@ -249,27 +246,27 @@ static void write_tcm_boot_trampoline(u32 nr, u32 boot_addr)
 	}
 }
 
-void initialize_tcm(bool mode)
+void initialize_tcm(enum tcm_mode mode)
 {
-	if (!mode) {
-		set_r5_tcm_mode(LOCK);
-		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, LOCK);
+	if (mode == TCM_LOCK) {
+		set_r5_tcm_mode(TCM_LOCK);
+		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, TCM_LOCK);
 		enable_clock_r5();
-		release_r5_reset(ZYNQMP_CORE_RPU0, LOCK);
+		release_r5_reset(ZYNQMP_CORE_RPU0, TCM_LOCK);
 	} else {
-		set_r5_tcm_mode(SPLIT);
-		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, SPLIT);
-		set_r5_halt_mode(ZYNQMP_CORE_RPU1, HALT, SPLIT);
+		set_r5_tcm_mode(TCM_SPLIT);
+		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, TCM_SPLIT);
+		set_r5_halt_mode(ZYNQMP_CORE_RPU1, HALT, TCM_SPLIT);
 		enable_clock_r5();
-		release_r5_reset(ZYNQMP_CORE_RPU0, SPLIT);
-		release_r5_reset(ZYNQMP_CORE_RPU1, SPLIT);
+		release_r5_reset(ZYNQMP_CORE_RPU0, TCM_SPLIT);
+		release_r5_reset(ZYNQMP_CORE_RPU1, TCM_SPLIT);
 	}
 }
 
-int check_tcm_mode(bool mode)
+int check_tcm_mode(enum tcm_mode mode)
 {
 	u32 tmp, cpu_state;
-	bool mode_prev;
+	enum tcm_mode mode_prev;
 
 	tmp = readl(&rpu_base->rpu_glbl_ctrl);
 	mode_prev = FIELD_GET(ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK, tmp);
@@ -279,7 +276,7 @@ int check_tcm_mode(bool mode)
 			      ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK, tmp);
 	cpu_state = cpu_state ? false : true;
 
-	if ((mode_prev == SPLIT && mode == LOCK) && cpu_state)
+	if ((mode_prev == TCM_SPLIT && mode == TCM_LOCK) && cpu_state)
 		return -EACCES;
 
 	if (mode_prev == mode)
@@ -288,11 +285,11 @@ int check_tcm_mode(bool mode)
 	return 0;
 }
 
-static void mark_r5_used(u32 nr, u8 mode)
+static void mark_r5_used(u32 nr, enum tcm_mode mode)
 {
 	u32 mask = 0;
 
-	if (mode == LOCK) {
+	if (mode == TCM_LOCK) {
 		mask = ZYNQMP_RPU0_USE_MASK | ZYNQMP_RPU1_USE_MASK;
 	} else {
 		switch (nr) {
@@ -358,30 +355,30 @@ int cpu_release(u32 nr, int argc, char *const argv[])
 				return 1;
 			}
 			printf("R5 lockstep mode\n");
-			set_r5_reset(nr, LOCK);
-			set_r5_tcm_mode(LOCK);
-			set_r5_halt_mode(nr, HALT, LOCK);
+			set_r5_reset(nr, TCM_LOCK);
+			set_r5_tcm_mode(TCM_LOCK);
+			set_r5_halt_mode(nr, HALT, TCM_LOCK);
 			set_r5_start(boot_addr);
 			enable_clock_r5();
-			release_r5_reset(nr, LOCK);
+			release_r5_reset(nr, TCM_LOCK);
 			dcache_disable();
 			write_tcm_boot_trampoline(nr, boot_addr_uniq);
 			dcache_enable();
-			set_r5_halt_mode(nr, RELEASE, LOCK);
-			mark_r5_used(nr, LOCK);
+			set_r5_halt_mode(nr, RELEASE, TCM_LOCK);
+			mark_r5_used(nr, TCM_LOCK);
 		} else if (!strcmp(argv[1], "split") || !strcmp(argv[1], "1")) {
 			printf("R5 split mode\n");
-			set_r5_reset(nr, SPLIT);
-			set_r5_tcm_mode(SPLIT);
-			set_r5_halt_mode(nr, HALT, SPLIT);
+			set_r5_reset(nr, TCM_SPLIT);
+			set_r5_tcm_mode(TCM_SPLIT);
+			set_r5_halt_mode(nr, HALT, TCM_SPLIT);
 			set_r5_start(boot_addr);
 			enable_clock_r5();
-			release_r5_reset(nr, SPLIT);
+			release_r5_reset(nr, TCM_SPLIT);
 			dcache_disable();
 			write_tcm_boot_trampoline(nr, boot_addr_uniq);
 			dcache_enable();
-			set_r5_halt_mode(nr, RELEASE, SPLIT);
-			mark_r5_used(nr, SPLIT);
+			set_r5_halt_mode(nr, RELEASE, TCM_SPLIT);
+			mark_r5_used(nr, TCM_SPLIT);
 		} else {
 			printf("Unsupported mode\n");
 			return 1;
diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index 3aa218545bb..279006b4d13 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -146,7 +146,7 @@ static int do_zynqmp_aes(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zynqmp_tcm_init(struct cmd_tbl *cmdtp, int flag, int argc,
 			      char *const argv[])
 {
-	u8 mode;
+	enum tcm_mode mode;
 
 	if (argc != cmdtp->maxargs)
 		return CMD_RET_USAGE;
-- 
2.47.2

