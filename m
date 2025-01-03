Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B927E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 11:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF458036E;
	Fri,  3 Jan 2025 12:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UFskeRMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A60803E4; Fri,  3 Jan 2025 12:13:42 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3509280384
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 12:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so125792385e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 03:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735902819; x=1736507619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMd+sinb3q6PanhAEgJJk6fMv9pR722mvZp/v9GXDrs=;
 b=UFskeRMAq92ZVsV0PTmQ+cif/XESXtaLpd8B/nzZblOEU+FF/QT31e0SvYKNSX9B35
 rEAPUoF+OJcu90BjXRVCgUCCBKRjZu3zggyJXu95w1liD9PqsDZbij6jnSD/YrBZ4zkt
 xIdM2M2Fc2YnBErz5zBHsVi/e3cmZ1bgVkP27SEDQpT1mH/Uw3pViJDezrELrRxq7G+K
 m6h4Zooey0NOo/Ay71LAUONUumhyPtQ1m14jzPEcwDsC4wc4GcyGLJ/5EakAUwNVGgNZ
 OmMikLJLf8LNYGPc9eFT0P6gxLadW3e6q5v6PPfDBFT21zUpNk2QusiCiUNTGt0a2kM8
 UUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735902819; x=1736507619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMd+sinb3q6PanhAEgJJk6fMv9pR722mvZp/v9GXDrs=;
 b=pn8UzdEuc5RVYinSr3Pq8dnJjP9moCtijFAqi7Jail0xiar523y+hHLVLH63xtEWc/
 CfxFwQrG5G/EhdCIXuHK7Tj/gXkplI4zVi3ag/9Pv6EBY0GgGcPKPtfOEvYcT8odkCbT
 aPgo/xqZ+rBFCNUVqOmCojBsAyszilSw36/gdV04NVxrX08duhLC6nKnHTlRLxulo2iy
 tPa8vNX81P13aJB8YsfyGP22kpNn8y+te4dzrd/ic8ZFnaVuMNGHR05tT6l/WFx3IMJ0
 X/x9INnB1SXthnRIRD16dKT5wQH8xQpVGY47xEKwPQgXc6jujechj6E909czbjVj7gUi
 FnHg==
X-Gm-Message-State: AOJu0Yx+uA1HoRuMeXzwqTu8nEcKC6b+gZxmLdxZZkBbqGXSw0AVglXG
 uKlbAneoWXY86vBDQGoUCgbCdWYRUk07oaVuYSUzCiNh6vYs0rbQxoRNftYwIfiPUNqUjURk3Ch
 NxeM=
X-Gm-Gg: ASbGnctbBIHRZTJhtgd3Gv5eXckirhnDPy3KC0KA2QTbXukT/CQ660h8ZWbSyacYe1O
 FkBQepRX09lPmc6Cx1UjCbgWzk9QSuvUVUqRz7En7udd6Qu7qf/S2v1T0oftS2xkJB1sbrHgkRR
 caoHJam3Ktyqe2Ga0gGWwvJ46Ti8Hp5bqd45dgatibA5wlG527vnDVf5q5ASZ8tXu4fpwwGeOwE
 +NsOGTBzptFqH3PyOsedMLmz9DgSLNuDrijrp+YtoyY6kriZSjOlO12sd3E0h+9qw==
X-Google-Smtp-Source: AGHT+IEQPtl3e0+bB8xof9LrNU8TiTTHiG/a5PBVl5iklrSpDL1TGIneUoxPzN2QF9Z858rEnFC7lQ==
X-Received: by 2002:a05:600c:474d:b0:436:18d0:aa6e with SMTP id
 5b1f17b1804b1-4366835c14fmr418470625e9.5.1735902819392; 
 Fri, 03 Jan 2025 03:13:39 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm513138075e9.0.2025.01.03.03.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 03:13:39 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 4/5] board_init_r(): use static calls
Date: Fri,  3 Jan 2025 12:13:16 +0100
Message-ID: <c86ca0914ab1496a7f63371e47f36f2109d7d97a.1735896540.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735896540.git.jerome.forissier@linaro.org>
References: <cover.1735896540.git.jerome.forissier@linaro.org>
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

Replace the init_sequence_r function array by direct calls.
bloat-o-meter stats before/after on u-boot.bin for configuration
xilinx_zynqmp_kria_defconfig are the following:

- With LTO:
add/remove: 87/128 grow/shrink: 8/23 up/down: 19743/-20923 (-1180)
Total: Before=1067882, After=1066702, chg -0.11%

- Without LTO:
add/remove: 0/23 grow/shrink: 2/0 up/down: 795/-1112 (-317)
Total: Before=1119494, After=1119177, chg -0.03%

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/sh/lib/board.c         |   9 +-
 common/board_r.c            | 175 ++++++++++++++++++------------------
 test/py/tests/test_trace.py |   8 +-
 3 files changed, 96 insertions(+), 96 deletions(-)

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
diff --git a/common/board_r.c b/common/board_r.c
index c65c0b2ed1e..56016994b11 100644
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
 #if defined(CONFIG_ARM) || defined(CONFIG_RISCV)
-	initr_caches,
+	INITCALL(initr_caches);
 	/* Note: For Freescale LS2 SoCs, new MMU table is created in DDR.
 	 *	 A temporary mapping of IFC high region is since removed,
 	 *	 so environmental variables in NOR flash is not available
@@ -604,21 +607,21 @@ static init_fnc_t init_sequence_r[] = {
 	 *	 region.
 	 */
 #endif
-	initr_reloc_global_data,
+	INITCALL(initr_reloc_global_data);
 #if defined(CONFIG_SYS_INIT_RAM_LOCK) && defined(CONFIG_E500)
-	initr_unlock_ram_in_cache,
+	INITCALL(initr_unlock_ram_in_cache);
 #endif
-	initr_barrier,
-	initr_malloc,
-	log_init,
-	initr_bootstage,	/* Needs malloc() but has its own timer */
-	CONFIG_IS_ENABLED(CONSOLE_RECORD, (console_record_init,))
-	CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY, (noncached_init,))
-	initr_of_live,
-	CONFIG_IS_ENABLED(DM, (initr_dm,))
-	CONFIG_IS_ENABLED(ADDR_MAP, (init_addr_map,))
+	INITCALL(initr_barrier);
+	INITCALL(initr_malloc);
+	INITCALL(log_init);
+	INITCALL(initr_bootstage); /* Needs malloc() but has its own timer */
+	CONFIG_IS_ENABLED(CONSOLE_RECORD, (INITCALL(console_record_init);))
+	CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY, (INITCALL(noncached_init);))
+	INITCALL(initr_of_live);
+	CONFIG_IS_ENABLED(DM, (INITCALL(initr_dm);))
+	CONFIG_IS_ENABLED(ADDR_MAP, (INITCALL(init_addr_map);))
 #if defined(CONFIG_ARM) || defined(CONFIG_RISCV) || defined(CONFIG_SANDBOX)
-	board_init,	/* Setup chipselects */
+	INITCALL(board_init);	/* Setup chipselects */
 #endif
 	/*
 	 * TODO: printing of the clock inforamtion of the board is now
@@ -626,88 +629,91 @@ static init_fnc_t init_sequence_r[] = {
 	 * davinci SOC's is added. Remove this check once all the board
 	 * implement this.
 	 */
-	CONFIG_IS_ENABLED(CLOCKS, (set_cpu_clk_info,)) /* Setup clock information */
-	initr_lmb,
-	CONFIG_IS_ENABLED(EFI_LOADER, (efi_memory_init,))
-	CONFIG_IS_ENABLED(BINMAN_FDT, (initr_binman,))
-	CONFIG_IS_ENABLED(FSP_VERSION2, (arch_fsp_init_r,))
-	initr_dm_devices,
-	stdio_init_tables,
-	serial_initialize,
-	initr_announce,
-	dm_announce,
-	CONFIG_IS_ENABLED(WDT, (initr_watchdog,))
-	INIT_FUNC_WATCHDOG_RESET
-	arch_initr_trap,
-	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_R, (board_early_init_r,))
-	INIT_FUNC_WATCHDOG_RESET
-	CONFIG_IS_ENABLED(POST, (post_output_backlog,))
-	INIT_FUNC_WATCHDOG_RESET
+	CONFIG_IS_ENABLED(CLOCKS, (INITCALL(set_cpu_clk_info);))
+	INITCALL(initr_lmb);
+	CONFIG_IS_ENABLED(EFI_LOADER, (INITCALL(efi_memory_init);))
+	CONFIG_IS_ENABLED(BINMAN_FDT, (INITCALL(initr_binman);))
+	CONFIG_IS_ENABLED(FSP_VERSION2, (INITCALL(arch_fsp_init_r);))
+	INITCALL(initr_dm_devices);
+	INITCALL(stdio_init_tables);
+	INITCALL(serial_initialize);
+	INITCALL(initr_announce);
+	INITCALL(dm_announce);
+	CONFIG_IS_ENABLED(WDT, (INITCALL(initr_watchdog);))
+	WATCHDOG_RESET();
+	INITCALL(arch_initr_trap);
+	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_R, (INITCALL(board_early_init_r);))
+	WATCHDOG_RESET();
+	CONFIG_IS_ENABLED(POST, (INITCALL(post_output_backlog);))
+	WATCHDOG_RESET();
 #if defined(CONFIG_PCI_INIT_R) && defined(CONFIG_SYS_EARLY_PCI_INIT)
 	/*
 	 * Do early PCI configuration _before_ the flash gets initialised,
 	 * because PCU resources are crucial for flash access on some boards.
 	 */
-	pci_init,
+	INITCALL(pci_init);
 #endif
-	CONFIG_IS_ENABLED(ARCH_EARLY_INIT_R, (arch_early_init_r,))
-	power_init_board,
-	CONFIG_IS_ENABLED(MTD_NOR_FLASH, (initr_flash,))
-	INIT_FUNC_WATCHDOG_RESET
+	CONFIG_IS_ENABLED(ARCH_EARLY_INIT_R, (INITCALL(arch_early_init_r);))
+	INITCALL(power_init_board);
+	CONFIG_IS_ENABLED(MTD_NOR_FLASH, (INITCALL(initr_flash);))
+	WATCHDOG_RESET();
 #if defined(CONFIG_PPC) || defined(CONFIG_M68K) || defined(CONFIG_X86)
 	/* initialize higher level parts of CPU like time base and timers */
-	cpu_init_r,
+	INITCALL(cpu_init_r);
 #endif
-	CONFIG_IS_ENABLED(EFI_LOADER, (efi_init_early,))
-	CONFIG_IS_ENABLED(CMD_NAND, (initr_nand,))
-	CONFIG_IS_ENABLED(CMD_ONENAND, (initr_onenand,))
-	CONFIG_IS_ENABLED(MMC, (initr_mmc,))
-	CONFIG_IS_ENABLED(XEN, (xen_init,))
-	CONFIG_IS_ENABLED(PVBLOCK, (initr_pvblock,))
-	initr_env,
-	CONFIG_IS_ENABLED(SYS_MALLOC_BOOTPARAMS, (initr_malloc_bootparams,))
-	INIT_FUNC_WATCHDOG_RESET
-	cpu_secondary_init_r,
-	CONFIG_IS_ENABLED(ID_EEPROM, (mac_read_from_eeprom,))
-	INITCALL_EVENT(EVT_SETTINGS_R),
-	INIT_FUNC_WATCHDOG_RESET
+	CONFIG_IS_ENABLED(EFI_LOADER, (INITCALL(efi_init_early);))
+	CONFIG_IS_ENABLED(CMD_NAND, (INITCALL(initr_nand);))
+	CONFIG_IS_ENABLED(CMD_ONENAND, (INITCALL(initr_onenand);))
+	CONFIG_IS_ENABLED(MMC, (INITCALL(initr_mmc);))
+	CONFIG_IS_ENABLED(XEN, (INITCALL(xen_init);))
+	CONFIG_IS_ENABLED(PVBLOCK, (INITCALL(initr_pvblock);))
+	INITCALL(initr_env);
+	CONFIG_IS_ENABLED(SYS_MALLOC_BOOTPARAMS,
+			  (INITCALL(initr_malloc_bootparams);))
+	WATCHDOG_RESET();
+	INITCALL(cpu_secondary_init_r);
+	CONFIG_IS_ENABLED(ID_EEPROM, (INITCALL(mac_read_from_eeprom);))
+	INITCALL_EVT(EVT_SETTINGS_R);
+	WATCHDOG_RESET();
 #if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
 	/*
 	 * Do pci configuration
 	 */
-	pci_init,
+	INITCALL(pci_init);
 #endif
-	stdio_add_devices,
-	jumptable_init,
-	CONFIG_IS_ENABLED(API, (api_init,))
-	console_init_r,		/* fully init console as a device */
-	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE, (console_announce_r, show_board_info,))
+	INITCALL(stdio_add_devices);
+	INITCALL(jumptable_init);
+	CONFIG_IS_ENABLED(API, (INITCALL(api_init);))
+	INITCALL(console_init_r);	/* fully init console as a device */
+	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE,
+			  (INITCALL(console_announce_r);
+			   INITCALL(show_board_info);))
 	/* miscellaneous arch-dependent init */
-	CONFIG_IS_ENABLED(ARCH_MISC_INIT, (arch_misc_init,))
+	CONFIG_IS_ENABLED(ARCH_MISC_INIT, (INITCALL(arch_misc_init);))
 	/* miscellaneous platform-dependent init */
-	CONFIG_IS_ENABLED(MISC_INIT_R, (misc_init_r,))
-	INIT_FUNC_WATCHDOG_RESET
-	CONFIG_IS_ENABLED(CMD_KGDB, (kgdb_init,))
-	interrupt_init,
+	CONFIG_IS_ENABLED(MISC_INIT_R, (INITCALL(misc_init_r);))
+	WATCHDOG_RESET();
+	CONFIG_IS_ENABLED(CMD_KGDB, (INITCALL(kgdb_init);))
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
-	CONFIG_IS_ENABLED(BOARD_LATE_INIT, (board_late_init,))
-	CONFIG_IS_ENABLED(BITBANGMII, (bb_miiphy_init,))
-	CONFIG_IS_ENABLED(PCI_ENDPOINT, (pci_ep_init,))
-	CONFIG_IS_ENABLED(CMD_NET, (INIT_FUNC_WATCHDOG_RESET initr_net,))
-	CONFIG_IS_ENABLED(POST, (initr_post,))
-	INIT_FUNC_WATCHDOG_RESET
-	INITCALL_EVENT(EVT_LAST_STAGE_INIT),
+	CONFIG_IS_ENABLED(BOARD_LATE_INIT, (INITCALL(board_late_init);))
+	CONFIG_IS_ENABLED(BITBANGMII, (INITCALL(bb_miiphy_init);))
+	CONFIG_IS_ENABLED(PCI_ENDPOINT, (INITCALL(pci_ep_init);))
+	CONFIG_IS_ENABLED(CMD_NET, (WATCHDOG_RESET(); INITCALL(initr_net);))
+	CONFIG_IS_ENABLED(POST, (INITCALL(initr_post);))
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
@@ -734,8 +740,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
 
-	if (initcall_run_list(init_sequence_r))
-		hang();
+	initcall_run_r();
 
 	/* NOTREACHED - run_main_loop() does not return */
 	hang();
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

