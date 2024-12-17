Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8A2E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4515F80295;
	Tue, 17 Dec 2024 17:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mrMAuEcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272F38022E; Tue, 17 Dec 2024 17:00:12 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466BD80285
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so3779334f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451207; x=1735056007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq4WuncKKljg/pggdDuRLbKvEOhV5Tz1Mt4QJiNvWW4=;
 b=mrMAuEcTZSQvaG07eWe8bX7qDTCkbq3XKWfzM48Zw8+20LaO3zQEtIEEnwg6wkbPPs
 v4VscQ9Bh/Ogek0eVNh4fRN3avZTYWWz1eDeILqzNLhUYv1hm0VD+PfMe+e+wUrIeWAI
 7N9N4aTOltaEzAGiyWhaVWLAq2j3ur8XFJL0xCi1F1vB4+lvKJMlC0WWbjVeVQe+W8B0
 SBO8GDwL41YEdh0AqEa4W/OG7TfusmSMxkTXFHfJ+lq9XhH5l8zt7LBY3aJIwvVXn3BG
 LNWr4Aq2eKqifMj/vfZrH8kEBIdS9V/U0KbAdx28nC5cIDgg2VX1EXR1jczWz/9uW+h2
 3LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451207; x=1735056007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq4WuncKKljg/pggdDuRLbKvEOhV5Tz1Mt4QJiNvWW4=;
 b=aRIosMVs7lPccrucIcMZbKjEC/y9SNuSuejjQLT3Td8PYUGaAVCaGiHxcaV4ffvWk7
 qE3eFWoAoHo5aNnaAnUvqVvaj5qlb+tuVsl35a9xtpujiZEZ+/3qQnMrxYx+PlLA0SUc
 rg/Pvy5ip1V2BOEijJnJI93QCL8+CzGe0nxlSo16n/gq5Vwk9TsXvJJpV+DJJHIPCvI3
 FQhEiXbZxtkOWLpal/qm9RSO/d3LqgoxXeOB0xGUrqAhB5wceUdLeq09EwymxMon0hW4
 urW+MZrTT3V2ERZdAxWfmK9eEQ6Zsf2tOXxNV/RAZdOVdKAjrleJw26hdrU3kvtZ8u0h
 MZ1A==
X-Gm-Message-State: AOJu0YzXZX+vY/H5/qnHSw5SiEM5HseK9g2fWaJ7P73wLtgA+tX8wY3V
 a6sFnzyNHwHyXtj/Ee5CY2stDf3Cquldou9WdUGBNYT4fAQb8k34M0gPmyWCWf/F1itM6/d4mAq
 865k=
X-Gm-Gg: ASbGncvyjndQs2tVLAYvd8f4wLsal3ykRyzKso96uRW3T9rNg+sUs630MouOhqfJQXW
 PRBl2Ik+gb/nELUxZKh2DeeeiCHyQTEBIDHrXL4a7kLJt9xHae9lpUgipeb79MLhN+k1400+uad
 uUGXKG8CZpXdmulp1vAwlptG6BRN0/x/lONF26BBD+9ewbjHWyKzWBmDbaBQ6dlf4Ua4o0EDf0u
 u2fYU4rrowqiuVguMc9DEmkw8TvOOcpSFrJRWsmiiH3H0scpWB744v30QMNAHearw==
X-Google-Smtp-Source: AGHT+IHxPC9FlPwLHnWLt/Lb3sIACQiP3ql3WO2ngjJF4Gc3IAJmg7kxAl2TJmPCPYvZt6yM8y3AEQ==
X-Received: by 2002:a5d:64a7:0:b0:385:e9ca:4e18 with SMTP id
 ffacd0b85a97d-38880ac23d0mr14934132f8f.1.1734451207422; 
 Tue, 17 Dec 2024 08:00:07 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ad9asm11390181f8f.58.2024.12.17.08.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 08:00:06 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 4/5] board_init_r(): use static calls
Date: Tue, 17 Dec 2024 16:59:35 +0100
Message-ID: <828684c96f74e847d364224042da430ab90241e4.1734448827.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734448827.git.jerome.forissier@linaro.org>
References: <cover.1734448827.git.jerome.forissier@linaro.org>
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
add/remove: 85/126 grow/shrink: 9/23 up/down: 19228/-20547 (-1319)
Total: Before=1067523, After=1066204, chg -0.12%

- Without LTO:
add/remove: 0/24 grow/shrink: 1/0 up/down: 488/-1124 (-636)
Total: Before=1118923, After=1118287, chg -0.06%

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_r.c            | 174 +++++++++++++++++++-----------------
 test/py/tests/test_trace.py |   8 +-
 2 files changed, 94 insertions(+), 88 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 19bcf3950d5..db28fc0b229 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -582,21 +582,22 @@ static int run_main_loop(void)
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
+static int initcall_run_r(void)
+{
+	int ret = 0;
+
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
@@ -604,21 +605,21 @@ static init_fnc_t init_sequence_r[] = {
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
@@ -626,88 +627,93 @@ static init_fnc_t init_sequence_r[] = {
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
+
+	return ret;
+}
 
 void board_init_r(gd_t *new_gd, ulong dest_addr)
 {
@@ -734,7 +740,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
 
-	if (initcall_run_list(init_sequence_r))
+	if (initcall_run_r())
 		hang();
 
 	/* NOTREACHED - run_main_loop() does not return */
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

