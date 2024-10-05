Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE6BCFB42C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969D588CEB;
	Sat,  5 Oct 2024 21:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KMZHCoWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074B788A24; Sat,  5 Oct 2024 21:14:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7022A889C5
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728155642; x=1759691642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lt7OuzLe5nqzYpcxnc2TPb8Uy6dh0Z8WgM8sEjo+5rY=;
 b=KMZHCoWZHm2PtJ+HuE8oRmPcQvjIpoz0EJvArw+VvuMZCpdENv/ZyY/p
 0nQB7H5xkD7XBXXGH2bly7sK28I8eVJXNmvSj1WWd+5Ue4iBSNQU3qSuI
 70oB1W9Eh1ym+fLrOYliG+HFtyiVef1YayfbVHAlV8zT4uDAN0G3EaB28
 GR2qI2w65rZFAaovnb7tp0vF+5Gy5GXShmorJH1xkf2qboo05ZBxSc4t0
 9ESRj2IHwjbbW0ePYsDLRxTY5miKMLRbPgLVqI2BBTxn9m0K+PntACOhm
 2p7IdJZMuY05wwMdvkWKTE7BVGdfyZdtSU3vBnQ/i079gmUxwggeinp4N g==;
X-CSE-ConnectionGUID: YjgLPDdITxK75noBJDoncQ==
X-CSE-MsgGUID: xBl9JhlTSc6Lhlwg2k1EIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="38742264"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="38742264"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2024 12:13:58 -0700
X-CSE-ConnectionGUID: MBQbptlVSuuzzv6YhMNBGw==
X-CSE-MsgGUID: JL06+9onTv2Kix32uQgN+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="79813922"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa005.jf.intel.com with ESMTP; 05 Oct 2024 12:13:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 005F5177; Sat, 05 Oct 2024 22:13:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 1/4] x86: cpu: Use default print_cpuinfo() for all
Date: Sat,  5 Oct 2024 22:11:57 +0300
Message-ID: <20241005191353.1927660-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Most of the copies of the print_cpuinfo() call the default method.
Remove all of those in order to have only the default one when
no `cpu` command is compiled.

This also helps avoiding compiler warning, e.g.:

  arch/x86/cpu/tangier/tangier.c:23:5: warning: no previous prototype for ‘print_cpuinfo’ [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/cpu/broadwell/cpu.c                 | 12 ------------
 arch/x86/cpu/coreboot/coreboot.c             |  5 -----
 arch/x86/cpu/cpu.c                           |  6 +++++-
 arch/x86/cpu/efi/app.c                       |  5 -----
 arch/x86/cpu/efi/payload.c                   |  5 -----
 arch/x86/cpu/ivybridge/cpu.c                 | 14 --------------
 arch/x86/cpu/qemu/qemu.c                     |  6 ------
 arch/x86/cpu/quark/quark.c                   |  6 ------
 arch/x86/cpu/slimbootloader/slimbootloader.c |  5 -----
 arch/x86/cpu/tangier/tangier.c               |  5 -----
 arch/x86/cpu/x86_64/misc.c                   |  5 -----
 arch/x86/include/asm/u-boot-x86.h            |  1 -
 arch/x86/lib/fsp/fsp_common.c                |  6 ------
 13 files changed, 5 insertions(+), 76 deletions(-)

diff --git a/arch/x86/cpu/broadwell/cpu.c b/arch/x86/cpu/broadwell/cpu.c
index dc6717eca40e..63698362e420 100644
--- a/arch/x86/cpu/broadwell/cpu.c
+++ b/arch/x86/cpu/broadwell/cpu.c
@@ -88,18 +88,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	char processor_name[CPU_MAX_NAME_LEN];
-	const char *name;
-
-	/* Print processor name */
-	name = cpu_get_name(processor_name);
-	printf("CPU:   %s\n", name);
-
-	return 0;
-}
-
 void board_debug_uart_init(void)
 {
 	/* com1 / com2 decode range */
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d474c79e25ef..8ed4483b24b2 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -43,11 +43,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-
 static void board_final_init(void)
 {
 	/*
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index ad21fdb457a3..3aa35b811b36 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -163,8 +163,11 @@ char *cpu_get_name(char *name)
 	return ptr;
 }
 
-int default_print_cpuinfo(void)
+#if !CONFIG_IS_ENABLED(CPU)
+int print_cpuinfo(void)
 {
+	post_code(POST_CPU_INFO);
+
 	printf("CPU: %s, vendor %s, device %xh\n",
 	       cpu_has_64bit() ? "x86_64" : "x86",
 	       cpu_vendor_name(gd->arch.x86_vendor), gd->arch.x86_device);
@@ -176,6 +179,7 @@ int default_print_cpuinfo(void)
 
 	return 0;
 }
+#endif
 
 #if CONFIG_IS_ENABLED(SHOW_BOOT_PROGRESS)
 void show_boot_progress(int val)
diff --git a/arch/x86/cpu/efi/app.c b/arch/x86/cpu/efi/app.c
index 218a68c4642d..84fe50e2f2f8 100644
--- a/arch/x86/cpu/efi/app.c
+++ b/arch/x86/cpu/efi/app.c
@@ -19,11 +19,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-
 void board_final_init(void)
 {
 }
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 642a87a37d8b..6845ce72ff94 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -144,11 +144,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-
 /* Find any available tables and copy them to a safe place */
 int reserve_arch(void)
 {
diff --git a/arch/x86/cpu/ivybridge/cpu.c b/arch/x86/cpu/ivybridge/cpu.c
index d71ab0a6385e..c2ec52b9a912 100644
--- a/arch/x86/cpu/ivybridge/cpu.c
+++ b/arch/x86/cpu/ivybridge/cpu.c
@@ -187,20 +187,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	char processor_name[CPU_MAX_NAME_LEN];
-	const char *name;
-
-	/* Print processor name */
-	name = cpu_get_name(processor_name);
-	printf("CPU:   %s\n", name);
-
-	post_code(POST_CPU_INFO);
-
-	return 0;
-}
-
 void board_debug_uart_init(void)
 {
 	/* This enables the debug UART */
diff --git a/arch/x86/cpu/qemu/qemu.c b/arch/x86/cpu/qemu/qemu.c
index 262584d01f0f..563f63e2bc81 100644
--- a/arch/x86/cpu/qemu/qemu.c
+++ b/arch/x86/cpu/qemu/qemu.c
@@ -109,12 +109,6 @@ int checkcpu(void)
 {
 	return 0;
 }
-
-int print_cpuinfo(void)
-{
-	post_code(POST_CPU_INFO);
-	return default_print_cpuinfo();
-}
 #endif
 
 int arch_early_init_r(void)
diff --git a/arch/x86/cpu/quark/quark.c b/arch/x86/cpu/quark/quark.c
index fdf92b2c0c3a..07504faaffb7 100644
--- a/arch/x86/cpu/quark/quark.c
+++ b/arch/x86/cpu/quark/quark.c
@@ -266,12 +266,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	post_code(POST_CPU_INFO);
-	return default_print_cpuinfo();
-}
-
 static void quark_pcie_init(void)
 {
 	u32 val;
diff --git a/arch/x86/cpu/slimbootloader/slimbootloader.c b/arch/x86/cpu/slimbootloader/slimbootloader.c
index 142c9341cf86..8a5c78595aa6 100644
--- a/arch/x86/cpu/slimbootloader/slimbootloader.c
+++ b/arch/x86/cpu/slimbootloader/slimbootloader.c
@@ -54,8 +54,3 @@ int checkcpu(void)
 {
 	return 0;
 }
-
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
diff --git a/arch/x86/cpu/tangier/tangier.c b/arch/x86/cpu/tangier/tangier.c
index 8a8f7d27a9d1..b005bc7d9a0e 100644
--- a/arch/x86/cpu/tangier/tangier.c
+++ b/arch/x86/cpu/tangier/tangier.c
@@ -19,8 +19,3 @@ int checkcpu(void)
 {
 	return 0;
 }
-
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
diff --git a/arch/x86/cpu/x86_64/misc.c b/arch/x86/cpu/x86_64/misc.c
index 294511e6ebab..fc449ca4ed67 100644
--- a/arch/x86/cpu/x86_64/misc.c
+++ b/arch/x86/cpu/x86_64/misc.c
@@ -32,9 +32,4 @@ int checkcpu(void)
 {
 	return 0;
 }
-
-int print_cpuinfo(void)
-{
-	return 0;
-}
 #endif
diff --git a/arch/x86/include/asm/u-boot-x86.h b/arch/x86/include/asm/u-boot-x86.h
index 3acc58ad74b4..9418ef9742a4 100644
--- a/arch/x86/include/asm/u-boot-x86.h
+++ b/arch/x86/include/asm/u-boot-x86.h
@@ -78,7 +78,6 @@ void x86_enable_caches(void);
 void x86_disable_caches(void);
 int x86_init_cache(void);
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size);
-int default_print_cpuinfo(void);
 
 /* Set up a UART which can be used with printch(), printhex8(), etc. */
 int setup_internal_uart(int enable);
diff --git a/arch/x86/lib/fsp/fsp_common.c b/arch/x86/lib/fsp/fsp_common.c
index c47e6ca47388..7e4c14766347 100644
--- a/arch/x86/lib/fsp/fsp_common.c
+++ b/arch/x86/lib/fsp/fsp_common.c
@@ -26,12 +26,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	post_code(POST_CPU_INFO);
-	return default_print_cpuinfo();
-}
-
 int fsp_init_phase_pci(void)
 {
 	u32 status;
-- 
2.43.0.rc1.1336.g36b5255a03ac

