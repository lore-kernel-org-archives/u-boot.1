Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF91C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 09:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCEA08091A;
	Fri, 24 Jan 2025 10:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CmUlZv67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87518808E6; Fri, 24 Jan 2025 10:10:50 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEB38083C
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436341f575fso19357045e9.1
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 01:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737709847; x=1738314647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTUYKwD46bJMSFFEld1BHf5MAfVbfpisgbSirFFCGGg=;
 b=CmUlZv67IpxXco87yrq3WMBBoEVlPpz2D4rXWxdGCkbJLefq/2KIkmQ0j2zPqQarLn
 XHnpUidEk5B8vdnDQb+DTkhHgNxncpGHtiokFuEUHbhdHAwb4cpkHxTUEFWJZZbVvsnL
 0h4ffugmM/1vk83g8d6fOSNtV9z2+4RV0qoqy9tp6qJ4fKlF5jPYaRTq96Y8UWtjv79E
 YeAJqrK8oI8MTX8q/Yfv2Tfz3q+3mspmLjmJLWcBAz62S2rvXc9x1j2HWcjnYJnenHvJ
 Jz+5rjCclrc9fGEVN9Vv+yw7pRz4jfaDMxc8kNTsa0UrT8Kkl2exm/bvZomhW5AXa4hK
 SF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737709847; x=1738314647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTUYKwD46bJMSFFEld1BHf5MAfVbfpisgbSirFFCGGg=;
 b=OKXqrcIDlyD+WxJbBUrw93WhxJpi+dPfJTneBiNTL90h3P7plZOOBFr0iM7VStVYyi
 BjqaW621jmF5dexj3g714BcCx7N67dPsrGVuJ+VPhZpDHSgeG8PYVvgEs9m3n/vnLnp1
 ag/LwDJVz9+10EMfz5NNF01dbdYph7etYMTtb15SnP7b34zLlae8yaOWscryZQq51luX
 prl761quVMRDqS29xX+mHuN2hYLgkK0dIdi7kgaxalbpWlZsJ3/bSn5EnIQ8DCi72qF+
 XaiIlneYw9U7gl7CZUwuI+s0y2G4Nw5TEYAky07NYxD3nYf6FwQUKjOV3dqp/7PaD7xW
 9MrQ==
X-Gm-Message-State: AOJu0YxpNvSESbpSJSs78PYG6ZbwV356yseeZ5QLvbOPmYuU38gVrxOS
 LLifZP49j2SYCnFplMg+z0Qjc7vcQvGMIL1LG6cXUyFFbCC+1yrQgsSXC1oGmTnueUKEFSPvvmX
 3WubYoQ==
X-Gm-Gg: ASbGncukB/huS+NW0x7SY9o3vJPZxPDJxhcOPRMctBZZuVy6W21KABzBUeak/5Ilnml
 DH1rGGVyONsv51oqY4zSq/ZG7QOa0I5jqtqZiwz9TECoxSMUFH1u6jIfmQPnnWY0L9QEAfTw8z7
 6fhWocKh1yHXqlcKR5UyozUJyuy8rXlNls46x0iIuXrf+KxJr12ctR6XoGMAJ+VnLS0JiQMfYVj
 2TgermPGKmTQugj/u14nf94TN0Y6cYIPlrRY4xNtsmhLljOnVuu2nCnX4csITMOiof8bod8Jxrd
 TdV+88LXoBvPXg==
X-Google-Smtp-Source: AGHT+IGyU2pVikh5tSKjxfGOE904hJtbBbUj9bftiXT8qmXs/7tjyj+Rqs1LU9ta+TU0IUwE2/g54A==
X-Received: by 2002:a05:600c:4e12:b0:436:2238:97f6 with SMTP id
 5b1f17b1804b1-438913c646bmr231603625e9.1.1737709846916; 
 Fri, 24 Jan 2025 01:10:46 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e9c0:313f:f99a:cc15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm18943385e9.39.2025.01.24.01.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:10:46 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 2/3] common: board: make initcalls static
Date: Fri, 24 Jan 2025 10:10:28 +0100
Message-ID: <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737709089.git.jerome.forissier@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
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

Change board_init_f(), board_init_f_r() and board_init_r() to make
static calls instead of iterating over the init_sequence_f,
init_sequence_f_r and init_sequence_r arrays, respectively. This makes
the code a simpler (and even more so when initcall_run_list() is
later removed) and it reduces the binary size as well. Tested with
xilinx_zynqmp_kria_defconfig; bloat-o-meter results:

- With LTO
add/remove: 106/196 grow/shrink: 10/28 up/down: 31548/-33829 (-2281)
Total: Before=1070471, After=1068190, chg -0.21%
- Without LTO
add/remove: 0/54 grow/shrink: 3/0 up/down: 2322/-2832 (-510)
Total: Before=1121723, After=1121213, chg -0.05%

Execution time does not change in a noticeable way.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/sh/lib/board.c         |   9 +-
 common/board_f.c            | 223 ++++++++++++++++----------------
 common/board_r.c            | 251 ++++++++++++++++++------------------
 include/initcall.h          |  27 ++++
 test/py/tests/test_trace.py |   8 +-
 5 files changed, 275 insertions(+), 243 deletions(-)

diff --git a/arch/sh/lib/board.c b/arch/sh/lib/board.c
index 53b1c147c2e..2daf54e7c33 100644
--- a/arch/sh/lib/board.c
+++ b/arch/sh/lib/board.c
@@ -19,18 +19,13 @@ int dram_init(void)
 
 void relocate_code(ulong start_addr_sp, gd_t *new_gd, ulong relocaddr)
 {
-	void (*reloc_board_init_r)(gd_t *gd, ulong dest) = board_init_r;
-
-	if (new_gd->reloc_off) {
+	if (new_gd->reloc_off)
 		memcpy((void *)new_gd->relocaddr,
 		       (void *)(new_gd->relocaddr - new_gd->reloc_off),
 		       new_gd->mon_len);
 
-		reloc_board_init_r += new_gd->reloc_off;
-	}
-
 	__asm__ __volatile__("mov.l %0, r15\n" : : "m" (new_gd->start_addr_sp));
 
 	while (1)
-		reloc_board_init_r(new_gd, 0x0);
+		board_init_r(new_gd, 0x0);
 }
diff --git a/common/board_f.c b/common/board_f.c
index 54c48d42ee9..fe096b774c1 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -38,6 +38,7 @@
 #include <spl.h>
 #include <status_led.h>
 #include <sysreset.h>
+#include <time.h>
 #include <timer.h>
 #include <trace.h>
 #include <upl.h>
@@ -747,7 +748,7 @@ static int setup_reloc(void)
 	return 0;
 }
 
-#ifdef CONFIG_OF_BOARD_FIXUP
+#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
 static int fix_fdt(void)
 {
 	return board_fix_fdt((void *)gd->fdt_blob);
@@ -870,81 +871,86 @@ static int initf_upl(void)
 	return 0;
 }
 
-static const init_fnc_t init_sequence_f[] = {
-	setup_mon_len,
-#ifdef CONFIG_OF_CONTROL
-	fdtdec_setup,
+static void initcall_run_f(void)
+{
+	/*
+	 * Please do not add logic to this function (variables, if (), etc.).
+	 * For simplicity it should remain an ordered list of function calls.
+	 */
+	INITCALL(setup_mon_len);
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+	INITCALL(fdtdec_setup);
 #endif
-#ifdef CONFIG_TRACE_EARLY
-	trace_early_init,
+#if CONFIG_IS_ENABLED(TRACE_EARLY)
+	INITCALL(trace_early_init);
 #endif
-	initf_malloc,
-	initf_upl,
-	log_init,
-	initf_bootstage,	/* uses its own timer, so does not need DM */
-	event_init,
-	bloblist_maybe_init,
-	setup_spl_handoff,
-#if defined(CONFIG_CONSOLE_RECORD_INIT_F)
-	console_record_init,
+	INITCALL(initf_malloc);
+	INITCALL(initf_upl);
+	INITCALL(log_init);
+	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
+	INITCALL(event_init);
+	INITCALL(bloblist_maybe_init);
+	INITCALL(setup_spl_handoff);
+#if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
+	INITCALL(console_record_init);
 #endif
-	INITCALL_EVENT(EVT_FSP_INIT_F),
-	arch_cpu_init,		/* basic arch cpu dependent setup */
-	mach_cpu_init,		/* SoC/machine dependent CPU setup */
-	initf_dm,
-#if defined(CONFIG_BOARD_EARLY_INIT_F)
-	board_early_init_f,
+	INITCALL_EVT(EVT_FSP_INIT_F);
+	INITCALL(arch_cpu_init);	/* basic arch cpu dependent setup */
+	INITCALL(mach_cpu_init);	/* SoC/machine dependent CPU setup */
+	INITCALL(initf_dm);
+#if CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F)
+	INITCALL(board_early_init_f);
 #endif
 #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
 	/* get CPU and bus clocks according to the environment variable */
-	get_clocks,		/* get CPU and bus clocks (etc.) */
+	INITCALL(get_clocks);		/* get CPU and bus clocks (etc.) */
 #endif
 #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
-	timer_init,		/* initialize timer */
+	INITCALL(timer_init);		/* initialize timer */
 #endif
-#if defined(CONFIG_BOARD_POSTCLK_INIT)
-	board_postclk_init,
+#if CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT)
+	INITCALL(board_postclk_init);
 #endif
-	env_init,		/* initialize environment */
-	init_baud_rate,		/* initialze baudrate settings */
-	serial_init,		/* serial communications setup */
-	console_init_f,		/* stage 1 init of console */
-	display_options,	/* say that we are here */
-	display_text_info,	/* show debugging info if required */
-	checkcpu,
-#if defined(CONFIG_SYSRESET)
-	print_resetinfo,
+	INITCALL(env_init);		/* initialize environment */
+	INITCALL(init_baud_rate);	/* initialze baudrate settings */
+	INITCALL(serial_init);		/* serial communications setup */
+	INITCALL(console_init_f);	/* stage 1 init of console */
+	INITCALL(display_options);	/* say that we are here */
+	INITCALL(display_text_info);	/* show debugging info if required */
+	INITCALL(checkcpu);
+#if CONFIG_IS_ENABLED(SYSRESET)
+	INITCALL(print_resetinfo);
 #endif
-#if defined(CONFIG_DISPLAY_CPUINFO)
-	print_cpuinfo,		/* display cpu info (and speed) */
+	/* display cpu info (and speed) */
+#if CONFIG_IS_ENABLED(DISPLAY_CPUINFO)
+	INITCALL(print_cpuinfo);
 #endif
-#if defined(CONFIG_DTB_RESELECT)
-	embedded_dtb_select,
+#if CONFIG_IS_ENABLED(DTB_RESELECT)
+	INITCALL(embedded_dtb_select);
 #endif
-#if defined(CONFIG_DISPLAY_BOARDINFO)
-	show_board_info,
+#if CONFIG_IS_ENABLED(DISPLAY_BOARDINFO)
+	INITCALL(show_board_info);
 #endif
-	INIT_FUNC_WATCHDOG_INIT
-	INITCALL_EVENT(EVT_MISC_INIT_F),
-	INIT_FUNC_WATCHDOG_RESET
+	WATCHDOG_INIT();
+	INITCALL_EVT(EVT_MISC_INIT_F);
+	WATCHDOG_RESET();
 #if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-	init_func_i2c,
+	INITCALL(init_func_i2c);
 #endif
-	announce_dram_init,
-	dram_init,		/* configure available RAM banks */
-#ifdef CONFIG_POST
-	post_init_f,
+	INITCALL(announce_dram_init);
+	INITCALL(dram_init);		/* configure available RAM banks */
+#if CONFIG_IS_ENABLED(POST)
+	INITCALL(post_init_f);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
+	WATCHDOG_RESET();
 #if defined(CFG_SYS_DRAM_TEST)
-	testdram,
+	INITCALL(testdram);
 #endif /* CFG_SYS_DRAM_TEST */
-	INIT_FUNC_WATCHDOG_RESET
-
-#ifdef CONFIG_POST
-	init_post,
+	WATCHDOG_RESET();
+#if CONFIG_IS_ENABLED(POST)
+	INITCALL(init_post);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
+	WATCHDOG_RESET();
 	/*
 	 * Now that we have DRAM mapped and working, we can
 	 * relocate the code and continue running from DRAM.
@@ -957,48 +963,51 @@ static const init_fnc_t init_sequence_f[] = {
 	 *  - monitor code
 	 *  - board info struct
 	 */
-	setup_dest_addr,
-#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
-	fix_fdt,
+	INITCALL(setup_dest_addr);
+#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
+    !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
+	INITCALL(fix_fdt);
 #endif
 #ifdef CFG_PRAM
-	reserve_pram,
+	INITCALL(reserve_pram);
 #endif
-	reserve_round_4k,
-	setup_relocaddr_from_bloblist,
-	arch_reserve_mmu,
-	reserve_video,
-	reserve_trace,
-	reserve_uboot,
-	reserve_malloc,
-	reserve_board,
-	reserve_global_data,
-	reserve_fdt,
-#if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
-	reloc_fdt,
-	fix_fdt,
+	INITCALL(reserve_round_4k);
+	INITCALL(setup_relocaddr_from_bloblist);
+	INITCALL(arch_reserve_mmu);
+	INITCALL(reserve_video);
+	INITCALL(reserve_trace);
+	INITCALL(reserve_uboot);
+	INITCALL(reserve_malloc);
+	INITCALL(reserve_board);
+	INITCALL(reserve_global_data);
+	INITCALL(reserve_fdt);
+#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
+    CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
+	INITCALL(reloc_fdt);
+	INITCALL(fix_fdt);
 #endif
-	reserve_bootstage,
-	reserve_bloblist,
-	reserve_arch,
-	reserve_stacks,
-	dram_init_banksize,
-	show_dram_config,
-	INIT_FUNC_WATCHDOG_RESET
-	setup_bdinfo,
-	display_new_sp,
-	INIT_FUNC_WATCHDOG_RESET
-#if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
-	reloc_fdt,
+	INITCALL(reserve_bootstage);
+	INITCALL(reserve_bloblist);
+	INITCALL(reserve_arch);
+	INITCALL(reserve_stacks);
+	INITCALL(dram_init_banksize);
+	INITCALL(show_dram_config);
+	WATCHDOG_RESET();
+	INITCALL(setup_bdinfo);
+	INITCALL(display_new_sp);
+	WATCHDOG_RESET();
+#if !CONFIG_IS_ENABLED(OF_BOARD_FIXUP) || \
+    !CONFIG_IS_ENABLED(INITIAL_DTB_READONLY)
+	INITCALL(reloc_fdt);
 #endif
-	reloc_bootstage,
-	reloc_bloblist,
-	setup_reloc,
-#if defined(CONFIG_X86) || defined(CONFIG_ARC)
-	copy_uboot_to_ram,
-	do_elf_reloc_fixups,
+	INITCALL(reloc_bootstage);
+	INITCALL(reloc_bloblist);
+	INITCALL(setup_reloc);
+#if CONFIG_IS_ENABLED(X86) || CONFIG_IS_ENABLED(ARC)
+	INITCALL(copy_uboot_to_ram);
+	INITCALL(do_elf_reloc_fixups);
 #endif
-	clear_bss,
+	INITCALL(clear_bss);
 	/*
 	 * Deregister all cyclic functions before relocation, so that
 	 * gd->cyclic_list does not contain any references to pre-relocation
@@ -1008,12 +1017,11 @@ static const init_fnc_t init_sequence_f[] = {
 	 * This should happen as late as possible so that the window where a
 	 * watchdog device is not serviced is as small as possible.
 	 */
-	cyclic_unregister_all,
-#if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
-	jump_to_copy,
+	INITCALL(cyclic_unregister_all);
+#if !CONFIG_IS_ENABLED(ARM) && !CONFIG_IS_ENABLED(SANDBOX)
+	INITCALL(jump_to_copy);
 #endif
-	NULL,
-};
+}
 
 void board_init_f(ulong boot_flags)
 {
@@ -1023,8 +1031,7 @@ void board_init_f(ulong boot_flags)
 	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
 	gd->boardf = &boardf;
 
-	if (initcall_run_list(init_sequence_f))
-		hang();
+	initcall_run_f();
 
 #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
 		!defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
@@ -1038,8 +1045,8 @@ void board_init_f(ulong boot_flags)
 /*
  * For now this code is only used on x86.
  *
- * init_sequence_f_r is the list of init functions which are run when
- * U-Boot is executing from Flash with a semi-limited 'C' environment.
+ * Run init functions which are run when U-Boot is executing from Flash with a
+ * semi-limited 'C' environment.
  * The following limitations must be considered when implementing an
  * '_f_r' function:
  *  - 'static' variables are read-only
@@ -1052,18 +1059,16 @@ void board_init_f(ulong boot_flags)
  * NOTE: At present only x86 uses this route, but it is intended that
  * all archs will move to this when generic relocation is implemented.
  */
-static const init_fnc_t init_sequence_f_r[] = {
-#if !CONFIG_IS_ENABLED(X86_64)
-	init_cache_f_r,
+static void initcall_run_f_r(void)
+{
+#if CONFIG_IS_ENABLED(X86_64)
+	INITCALL(init_cache_f_r);
 #endif
-
-	NULL,
-};
+}
 
 void board_init_f_r(void)
 {
-	if (initcall_run_list(init_sequence_f_r))
-		hang();
+	initcall_run_f_r();
 
 	/*
 	 * The pre-relocation drivers may be using memory that has now gone
diff --git a/common/board_r.c b/common/board_r.c
index f63c6aed4d5..21a8b97d1bc 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -582,21 +582,24 @@ static int run_main_loop(void)
 }
 
 /*
- * Over time we hope to remove these functions with code fragments and
- * stub functions, and instead call the relevant function directly.
- *
- * We also hope to remove most of the driver-related init and do it if/when
- * the driver is later used.
+ * Over time we hope to remove most of the driver-related init and do it
+ * if/when the driver is later used.
  *
  * TODO: perhaps reset the watchdog in the initcall function after each call?
  */
-static init_fnc_t init_sequence_r[] = {
-	initr_trace,
-	initr_reloc,
-	event_init,
+
+static void initcall_run_r(void)
+{
+	/*
+	 * Please do not add logic to this function (variables, if (), etc.).
+	 * For simplicity it should remain an ordered list of function calls.
+	 */
+	INITCALL(initr_trace);
+	INITCALL(initr_reloc);
+	INITCALL(event_init);
 	/* TODO: could x86/PPC have this also perhaps? */
-#if defined(CONFIG_ARM) || defined(CONFIG_RISCV)
-	initr_caches,
+#if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV)
+	INITCALL(initr_caches);
 	/* Note: For Freescale LS2 SoCs, new MMU table is created in DDR.
 	 *	 A temporary mapping of IFC high region is since removed,
 	 *	 so environmental variables in NOR flash is not available
@@ -604,29 +607,30 @@ static init_fnc_t init_sequence_r[] = {
 	 *	 region.
 	 */
 #endif
-	initr_reloc_global_data,
-#if defined(CONFIG_SYS_INIT_RAM_LOCK) && defined(CONFIG_E500)
-	initr_unlock_ram_in_cache,
+	INITCALL(initr_reloc_global_data);
+#if CONFIG_IS_ENABLED(SYS_INIT_RAM_LOCK) && CONFIG_IS_ENABLED(E500)
+	INITCALL(initr_unlock_ram_in_cache);
 #endif
-	initr_barrier,
-	initr_malloc,
-	log_init,
-	initr_bootstage,	/* Needs malloc() but has its own timer */
-#if defined(CONFIG_CONSOLE_RECORD)
-	console_record_init,
+	INITCALL(initr_barrier);
+	INITCALL(initr_malloc);
+	INITCALL(log_init);
+	INITCALL(initr_bootstage); /* Needs malloc() but has its own timer */
+#if CONFIG_IS_ENABLED(CONSOLE_RECORD)
+	INITCALL(console_record_init);
 #endif
-#ifdef CONFIG_SYS_NONCACHED_MEMORY
-	noncached_init,
+#if CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY)
+	INITCALL(noncached_init);
 #endif
-	initr_of_live,
-#ifdef CONFIG_DM
-	initr_dm,
+	INITCALL(initr_of_live);
+#if CONFIG_IS_ENABLED(DM)
+	INITCALL(initr_dm);
 #endif
-#ifdef CONFIG_ADDR_MAP
-	init_addr_map,
+#if CONFIG_IS_ENABLED(ADDR_MAP)
+	INITCALL(init_addr_map);
 #endif
-#if defined(CONFIG_ARM) || defined(CONFIG_RISCV) || defined(CONFIG_SANDBOX)
-	board_init,	/* Setup chipselects */
+#if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV) || \
+    CONFIG_IS_ENABLED(SANDBOX)
+	INITCALL(board_init);	/* Setup chipselects */
 #endif
 	/*
 	 * TODO: printing of the clock inforamtion of the board is now
@@ -634,142 +638,144 @@ static init_fnc_t init_sequence_r[] = {
 	 * davinci SOC's is added. Remove this check once all the board
 	 * implement this.
 	 */
-#ifdef CONFIG_CLOCKS
-	set_cpu_clk_info, /* Setup clock information */
+#if CONFIG_IS_ENABLED(CLOCKS)
+	INITCALL(set_cpu_clk_info);
 #endif
-	initr_lmb,
-#ifdef CONFIG_EFI_LOADER
-	efi_memory_init,
+	INITCALL(initr_lmb);
+#if CONFIG_IS_ENABLED(EFI_LOADER)
+	INITCALL(efi_memory_init);
 #endif
-#ifdef CONFIG_BINMAN_FDT
-	initr_binman,
+#if CONFIG_IS_ENABLED(BINMAN_FDT)
+	INITCALL(initr_binman);
 #endif
-#ifdef CONFIG_FSP_VERSION2
-	arch_fsp_init_r,
+#if CONFIG_IS_ENABLED(FSP_VERSION2)
+	INITCALL(arch_fsp_init_r);
 #endif
-	initr_dm_devices,
-	stdio_init_tables,
-	serial_initialize,
-	initr_announce,
-	dm_announce,
+	INITCALL(initr_dm_devices);
+	INITCALL(stdio_init_tables);
+	INITCALL(serial_initialize);
+	INITCALL(initr_announce);
+	INITCALL(dm_announce);
 #if CONFIG_IS_ENABLED(WDT)
-	initr_watchdog,
+	INITCALL(initr_watchdog);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-	arch_initr_trap,
-#if defined(CONFIG_BOARD_EARLY_INIT_R)
-	board_early_init_r,
+	WATCHDOG_RESET();
+	INITCALL(arch_initr_trap);
+#if CONFIG_IS_ENABLED(BOARD_EARLY_INIT_R)
+	INITCALL(board_early_init_r);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-#ifdef CONFIG_POST
-	post_output_backlog,
+	WATCHDOG_RESET();
+#if CONFIG_IS_ENABLED(POST)
+	INITCALL(post_output_backlog);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-#if defined(CONFIG_PCI_INIT_R) && defined(CONFIG_SYS_EARLY_PCI_INIT)
+	WATCHDOG_RESET();
+#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
 	/*
 	 * Do early PCI configuration _before_ the flash gets initialised,
 	 * because PCU resources are crucial for flash access on some boards.
 	 */
-	pci_init,
+	INITCALL(pci_init);
 #endif
-#ifdef CONFIG_ARCH_EARLY_INIT_R
-	arch_early_init_r,
+#if CONFIG_IS_ENABLED(ARCH_EARLY_INIT_R)
+	INITCALL(arch_early_init_r);
 #endif
-	power_init_board,
-#ifdef CONFIG_MTD_NOR_FLASH
-	initr_flash,
+	INITCALL(power_init_board);
+#if CONFIG_IS_ENABLED(MTD_NOR_FLASH)
+	INITCALL(initr_flash);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-#if defined(CONFIG_PPC) || defined(CONFIG_M68K) || defined(CONFIG_X86)
+	WATCHDOG_RESET();
+#if CONFIG_IS_ENABLED(PPC) || CONFIG_IS_ENABLED(M68K) || CONFIG_IS_ENABLED(X86)
 	/* initialize higher level parts of CPU like time base and timers */
-	cpu_init_r,
+	INITCALL(cpu_init_r);
 #endif
-#ifdef CONFIG_EFI_LOADER
-	efi_init_early,
+#if CONFIG_IS_ENABLED(EFI_LOADER)
+	INITCALL(efi_init_early);
 #endif
-#ifdef CONFIG_CMD_NAND
-	initr_nand,
+#if CONFIG_IS_ENABLED(CMD_NAND)
+	INITCALL(initr_nand);
 #endif
-#ifdef CONFIG_CMD_ONENAND
-	initr_onenand,
+#if CONFIG_IS_ENABLED(CMD_ONENAND)
+	INITCALL(initr_onenand);
 #endif
-#ifdef CONFIG_MMC
-	initr_mmc,
+#if CONFIG_IS_ENABLED(MMC)
+	INITCALL(initr_mmc);
 #endif
-#ifdef CONFIG_XEN
-	xen_init,
+#if CONFIG_IS_ENABLED(XEN)
+	INITCALL(xen_init);
 #endif
-#ifdef CONFIG_PVBLOCK
-	initr_pvblock,
+#if CONFIG_IS_ENABLED(PVBLOCK)
+	INITCALL(initr_pvblock);
 #endif
-	initr_env,
-#ifdef CONFIG_SYS_MALLOC_BOOTPARAMS
-	initr_malloc_bootparams,
+	INITCALL(initr_env);
+#if CONFIG_IS_ENABLED(SYS_MALLOC_BOOTPARAMS)
+	INITCALL(initr_malloc_bootparams);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-	cpu_secondary_init_r,
-#if defined(CONFIG_ID_EEPROM)
-	mac_read_from_eeprom,
+	WATCHDOG_RESET();
+	INITCALL(cpu_secondary_init_r);
+#if CONFIG_IS_ENABLED(ID_EEPROM)
+	INITCALL(mac_read_from_eeprom);
 #endif
-	INITCALL_EVENT(EVT_SETTINGS_R),
-	INIT_FUNC_WATCHDOG_RESET
-#if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
+	INITCALL_EVT(EVT_SETTINGS_R);
+	WATCHDOG_RESET();
+#if CONFIG_IS_ENABLED(PCI_INIT_R) && !CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
 	/*
 	 * Do pci configuration
 	 */
-	pci_init,
+	INITCALL(pci_init);
 #endif
-	stdio_add_devices,
-	jumptable_init,
-#ifdef CONFIG_API
-	api_init,
+	INITCALL(stdio_add_devices);
+	INITCALL(jumptable_init);
+#if CONFIG_IS_ENABLED(API)
+	INITCALL(api_init);
 #endif
-	console_init_r,		/* fully init console as a device */
-#ifdef CONFIG_DISPLAY_BOARDINFO_LATE
-	console_announce_r,
-	show_board_info,
+	INITCALL(console_init_r);	/* fully init console as a device */
+#if CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE)
+	INITCALL(console_announce_r);
+	INITCALL(show_board_info);
 #endif
-#ifdef CONFIG_ARCH_MISC_INIT
-	arch_misc_init,		/* miscellaneous arch-dependent init */
+	/* miscellaneous arch-dependent init */
+#if CONFIG_IS_ENABLED(ARCH_MISC_INIT)
+	INITCALL(arch_misc_init);
 #endif
-#ifdef CONFIG_MISC_INIT_R
-	misc_init_r,		/* miscellaneous platform-dependent init */
+	/* miscellaneous platform-dependent init */
+#if CONFIG_IS_ENABLED(MISC_INIT_R)
+	INITCALL(misc_init_r);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-#ifdef CONFIG_CMD_KGDB
-	kgdb_init,
+	WATCHDOG_RESET();
+#if CONFIG_IS_ENABLED(CMD_KGDB)
+	INITCALL(kgdb_init);
 #endif
-	interrupt_init,
+	INITCALL(interrupt_init);
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
-	timer_init,		/* initialize timer */
+	INITCALL(timer_init);		/* initialize timer */
 #endif
-	initr_status_led,
-	initr_boot_led_blink,
+	INITCALL(initr_status_led);
+	INITCALL(initr_boot_led_blink);
 	/* PPC has a udelay(20) here dating from 2002. Why? */
-#ifdef CONFIG_BOARD_LATE_INIT
-	board_late_init,
+#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
+	INITCALL(board_late_init);
 #endif
-#ifdef CONFIG_BITBANGMII
-	bb_miiphy_init,
+#if CONFIG_IS_ENABLED(BITBANGMII)
+	INITCALL(bb_miiphy_init);
 #endif
-#ifdef CONFIG_PCI_ENDPOINT
-	pci_ep_init,
+#if CONFIG_IS_ENABLED(PCI_ENDPOINT)
+	INITCALL(pci_ep_init);
 #endif
-#if defined(CONFIG_CMD_NET)
-	INIT_FUNC_WATCHDOG_RESET
-	initr_net,
+#if CONFIG_IS_ENABLED(CMD_NET)
+	WATCHDOG_RESET();
+	INITCALL(initr_net);
 #endif
-#ifdef CONFIG_POST
-	initr_post,
+#if CONFIG_IS_ENABLED(POST)
+	INITCALL(initr_post);
 #endif
-	INIT_FUNC_WATCHDOG_RESET
-	INITCALL_EVENT(EVT_LAST_STAGE_INIT),
+	WATCHDOG_RESET();
+	INITCALL_EVT(EVT_LAST_STAGE_INIT);
 #if defined(CFG_PRAM)
-	initr_mem,
+	INITCALL(initr_mem);
 #endif
-	initr_boot_led_on,
-	run_main_loop,
-};
+	INITCALL(initr_boot_led_on);
+	INITCALL(run_main_loop);
+}
 
 void board_init_r(gd_t *new_gd, ulong dest_addr)
 {
@@ -796,8 +802,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
 
-	if (initcall_run_list(init_sequence_r))
-		hang();
+	initcall_run_r();
 
 	/* NOTREACHED - run_main_loop() does not return */
 	hang();
diff --git a/include/initcall.h b/include/initcall.h
index 62d3bb67f08..8e22526dd9e 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -8,6 +8,7 @@
 
 #include <asm/types.h>
 #include <event.h>
+#include <hang.h>
 
 _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
 
@@ -35,4 +36,30 @@ typedef int (*init_fnc_t)(void);
  */
 int initcall_run_list(const init_fnc_t init_sequence[]);
 
+#define INITCALL(_call) \
+	do { \
+		if (_call()) { \
+			printf("%s(): initcall %s() failed\n", __func__, \
+			       #_call); \
+			hang(); \
+		} \
+	} while (0)
+
+#define INITCALL_EVT(_evt) \
+	do { \
+		if (event_notify_null(_evt)) { \
+			printf("%s(): event %d/%s failed\n", __func__, _evt, \
+			       event_type_name(_evt)) ; \
+			hang(); \
+		} \
+	} while (0)
+
+#if defined(CONFIG_WATCHDOG) || defined(CONFIG_HW_WATCHDOG)
+#define WATCHDOG_INIT() INITCALL(init_func_watchdog_init)
+#define WATCHDOG_RESET() INITCALL(init_func_watchdog_reset)
+#else
+#define WATCHDOG_INIT()
+#define WATCHDOG_RESET()
+#endif
+
 #endif
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 44239da5280..1b072df73b6 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -201,7 +201,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Then look for this:
     #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
     # Then check for this:
-    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    calc_reloc_ofs();
+    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    event_init();
 
     expected_indent = None
     found_start = False
@@ -224,8 +224,8 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
                 found_end = True
 
     # The next function after initf_bootstage() exits should be
-    # initcall_is_event()
-    assert upto == 'calc_reloc_ofs()'
+    # event_init()
+    assert upto == 'event_init()'
 
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
@@ -274,7 +274,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
     # We expect dm_timer_init() to be called twice: once before relocation and
     # once after
     look1 = 'initf_dm;dm_timer_init 1'
-    look2 = 'board_init_r;initcall_run_list;initr_dm_devices;dm_timer_init 1'
+    look2 = 'board_init_r;initcall_run_r;initr_dm_devices;dm_timer_init 1'
     found = 0
     with open(trace_fg, 'r') as fd:
         for line in fd:
-- 
2.43.0

