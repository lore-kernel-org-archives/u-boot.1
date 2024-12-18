Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF35BE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E938B80371;
	Wed, 18 Dec 2024 16:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cg8VDSir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C13580352; Wed, 18 Dec 2024 16:54:25 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABFA802EF
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385dece873cso3172492f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537262; x=1735142062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsxw3Alwb3wcmuK5p5xByPEpjhZBP1J+ez9xHBVTDig=;
 b=cg8VDSireQ1bEWwWosPv8sVsZnD7b65PsF/3x4NR3cjO9JO91S9ouY6txYORkWDKNC
 hNBlibgT1kX+S5PMmpcyjfSGSegxlOul+o6d6kUXg0tVqd0x3hN8AfLrmv/OPrnUYKZm
 In0YVptPGz+A4Jk+Ta44UD12Zxgc1Sb7IMPHbaB/GeBBCYYQ0yEsO+/pQKawA8d0QaHt
 ols3BZINHeFn2mW5qYpzKMoHL2nqLeI1UDNL0CwsaSx4bh0J6YRjmdHQww+3BHIdBPWs
 ItBESTOZuQTkzKtH+MbTqGRcChm+CGUjuSibe6RSmXPNb37MYuYj1huW+n2a7Ls31i7q
 wWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537262; x=1735142062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsxw3Alwb3wcmuK5p5xByPEpjhZBP1J+ez9xHBVTDig=;
 b=ohSYOPO1TowriZ9o9Ao+ksPzV/HRmWKJq93kxTPYuF5IFpk8bSBUIfTpHkEjyynu7X
 54tFxwA8mzNYHo3No8Rx8D2udSgfzNpDK4aJfv0VIgFrkTHvb9j4y6rGzdYbW4CEz0o7
 ViUOaH1nptn78MIzkRW9qxR44bbQtbiTPsuE2JSA/VJsUM3M0YP3ZSAr9aSAxlFsCKCP
 VrIKkz60i/P6L0tJIBAnSKtUttBkHMWPyCeWKq3+GoRgC3sxxv2yDcdDg6+U9JGOJJi1
 JmRsF83N/N0FNQVqHC/97agPSoQ4B+0P3GyoFcOA/WVvzcaJTbZzV5PjxICjLljvduNc
 Jlsw==
X-Gm-Message-State: AOJu0YxJwiU4OAz8lWc5kYIx2uVJiw3pj5YMIcoxDHAJWF9lRMPuRPSw
 x5ims2cFpADeaa+EES2Af3hIDqV4QDe3t9MbSku/Af74LvDzSnEc5htmq/Yxetu1ZC5UEiExJvc
 M/WE=
X-Gm-Gg: ASbGncsDZ+DUItERzO9YfkWaphrR6kz1M0W1zOViCU6Iiumr+05Q5cqnvivJXm7rCy8
 0qi/gOMruEJCJOqMCSU4kAFSz6cDE9oDAcRafXeggZGKRejxVaYyUfBFYZNiZDTBupzQeRBYp1L
 D9TsosEZGn2cHK52OXxMMu3ZTS19BDQwLQB5HI3RT9rHkoPnPR5F537VLp6p9rYYpiL9cTtR2jM
 Pl5ktS4qj9vVCG61d5xjyW1JjYRS8Il241MRBalifahmfwWFNWInFIVoN1ul0i1FQ==
X-Google-Smtp-Source: AGHT+IGcFwyldeSHmSxbzNGEqEhho05iAkOshNcmsgC5YnW3zOpQQ6FPG/Jeh+Vo3lZIf4cD9BlvFw==
X-Received: by 2002:a05:6000:144c:b0:385:ec89:2f07 with SMTP id
 ffacd0b85a97d-388e4d5db3fmr2758907f8f.32.1734537262482; 
 Wed, 18 Dec 2024 07:54:22 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc125sm25181705e9.6.2024.12.18.07.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:54:22 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 4/5] board_init_r(): use static calls
Date: Wed, 18 Dec 2024 16:53:57 +0100
Message-ID: <0a23ea67d824450012a4d7c44df65a70a99e3424.1734537135.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734537135.git.jerome.forissier@linaro.org>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
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
add/remove: 87/128 grow/shrink: 9/22 up/down: 19608/-20915 (-1307)
Total: Before=1067719, After=1066412, chg -0.12%

- Without LTO:
add/remove: 0/24 grow/shrink: 1/0 up/down: 488/-1124 (-636)
Total: Before=1119091, After=1118455, chg -0.06%

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_r.c            | 171 ++++++++++++++++++------------------
 test/py/tests/test_trace.py |   8 +-
 2 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 19bcf3950d5..ee54654ac71 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -582,21 +582,20 @@ static int run_main_loop(void)
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
@@ -604,21 +603,21 @@ static init_fnc_t init_sequence_r[] = {
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
@@ -626,88 +625,91 @@ static init_fnc_t init_sequence_r[] = {
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
@@ -734,8 +736,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
 
-	if (initcall_run_list(init_sequence_r))
-		hang();
+	initcall_run_r();
 
 	/* NOTREACHED - run_main_loop() does not return */
 	hang();
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index ec1e624722c..4c159ad9b16 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -175,7 +175,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Then look for this:
     #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
     # Then check for this:
-    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    calc_reloc_ofs();
+    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    event_init();
 
     expected_indent = None
     found_start = False
@@ -198,8 +198,8 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
                 found_end = True
 
     # The next function after initf_bootstage() exits should be
-    # initcall_is_event()
-    assert upto == 'calc_reloc_ofs()'
+    # event_init()
+    assert upto == 'event_init()'
 
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
@@ -248,7 +248,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
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

