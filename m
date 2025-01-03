Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52EAE7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 11:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B35803F5;
	Fri,  3 Jan 2025 12:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mRUNm1Zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02182803D2; Fri,  3 Jan 2025 12:13:41 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5478034E
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 12:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4368a293339so84499715e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735902817; x=1736507617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfDOaSAv1fBQA8QtVc5IoWAJsxQS+z+L7wwQ2Zls04s=;
 b=mRUNm1ZtMy/+rJ+s5VWIvJVHi6ETFWk9RMrARtN055G5B2zDbcmvvl8afIin9s8C5Z
 CWRRs/Mfxoo/JQg29UbynwIvtS5WFe+E6MuPviyG16i3NHO/+eOTwINALKxsEY5GSinX
 efp5DojXz7gRNiEhqKlrj3Q5Z/GeIaLYWnIRPnXLZSP5d7ZnhHPDCRb/eTsGr2wLjEF7
 SFg9bZiMKFcyMiBlSLr69T6H/50KXNWG7434bGwlj3L8oZKRdY6IpU5+dBjIQ/QUJ5qJ
 F3+gj+5dQ05gc5Igy6P0rxOf0/V4b3Fll4OBkHCENWqoTkZXGUaGFFxDz0CLu7qrzo95
 69/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735902817; x=1736507617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfDOaSAv1fBQA8QtVc5IoWAJsxQS+z+L7wwQ2Zls04s=;
 b=fMPwUB0y2U8Vi35alNISFr1a4wMLbZ9HK9G6KFEp3IRjm/WIgtuVWii8NJ5owcsaZX
 v06CSTQZjR7jtoQkh8hXdh76W/sqTbFa4JzBx2REGLR7Blbt7ps9vIcSoQqtyJKzQYDy
 1UUyJO99R27vBvHwVkHVa8D0ygeTHbcs3Y167PcePKyIBBeU9bFnz5UPka5vJxQwCNl7
 iOZaMFg145uBcELUxIitOgKzAT0ZGqYftLFuKCs1d9QkxDLz7MfkBMZgpJ3r43r6mCt2
 x8LS/faejPKAu/e0wgTcOd3vJ1dDNGcLoS03/6LuCI0FzO/4PGqzb98TyXbw4VH023Rv
 jFGQ==
X-Gm-Message-State: AOJu0YwVYqy8wylhcMfDyESwfdYUcYdnul4sw8Pz9TC5TxEjKXPFRol6
 x+ugPEeIKPSH12ob6t0RZGh2c7w5l2wvI29C1thmTSqsLcIjB6qHSPwG3Md3TL0H57ELIj0/4DO
 zHhU=
X-Gm-Gg: ASbGncvLvQtBzqh1AmebjdNBgAJY//HQ8x2gt4wLDSxwhInC2Io/sTVNXL83gmX0sq/
 UlqcG+Q/XASdWyRXWO8ViR+OI0MB36O1ljLg/F8d8n/M0R5UIhXU8pHtyy8oiSHx3VoW1x4U7Bb
 W/Tt/MgRMd2YSE6fARHJwXXvUz9st7Zx585Ylx3GLIRIQ244OmJ1M4qcE5mUD9X4FwWUGMSMisc
 S5MImSjPICBeAytiR2JpTa81Cr2tvYEW59g4CAgHQ5rZYWfdhLRvwCuTbdh0zCtiw==
X-Google-Smtp-Source: AGHT+IHf3yG169T8rFo1p1AfGWsWPRJwFTuOQXO/hnWCpLYAxDuM0urON/+z4hiUE2vZZEbmykn4EQ==
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id
 5b1f17b1804b1-43671247b46mr395385645e9.4.1735902817490; 
 Fri, 03 Jan 2025 03:13:37 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm513138075e9.0.2025.01.03.03.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 03:13:37 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v3 2/5] board_init_f(): use static calls
Date: Fri,  3 Jan 2025 12:13:14 +0100
Message-ID: <270cd303e577c51467abc3a8520311a6facb7f68.1735896540.git.jerome.forissier@linaro.org>
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

Make static calls instead of iterating over the init_sequence_f arrays.
Tested on a KV260 board (xilinx_zynqmp_kria_defconfig).

- With LTO enabled, the code size reported by bloat-o-meter is 1037
  bytes less (-0.10%)
- With LTO disabled, the code is 193 bytes smaller (-0.02%)
- Execution time does not change in a noticeable way

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_f.c   | 169 +++++++++++++++++++++++----------------------
 include/initcall.h |  27 ++++++++
 2 files changed, 114 insertions(+), 82 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index a4d8850cb7d..c2446ba344d 100644
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
@@ -870,58 +871,64 @@ static int initf_upl(void)
 	return 0;
 }
 
-static const init_fnc_t init_sequence_f[] = {
-	setup_mon_len,
-	CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
-	CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
-	initf_malloc,
-	initf_upl,
-	log_init,
-	initf_bootstage,	/* uses its own timer, so does not need DM */
-	event_init,
-	bloblist_maybe_init,
-	setup_spl_handoff,
-	CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
-	INITCALL_EVENT(EVT_FSP_INIT_F),
-	arch_cpu_init,		/* basic arch cpu dependent setup */
-	mach_cpu_init,		/* SoC/machine dependent CPU setup */
-	initf_dm,
-	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
+static void initcall_run_f(void)
+{
+	/*
+	 * Please do not add logic to this function (variables, if (), etc.).
+	 * For simplicity it should remain an ordered list of function calls.
+	 */
+	INITCALL(setup_mon_len);
+	CONFIG_IS_ENABLED(OF_CONTROL, (INITCALL(fdtdec_setup)));
+	CONFIG_IS_ENABLED(TRACE_EARLY, (INITCALL(trace_early_init)));
+	INITCALL(initf_malloc);
+	INITCALL(initf_upl);
+	INITCALL(log_init);
+	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
+	INITCALL(event_init);
+	INITCALL(bloblist_maybe_init);
+	INITCALL(setup_spl_handoff);
+	CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F,
+			  (INITCALL(console_record_init);))
+	INITCALL_EVT(EVT_FSP_INIT_F);
+	INITCALL(arch_cpu_init);	/* basic arch cpu dependent setup */
+	INITCALL(mach_cpu_init);	/* SoC/machine dependent CPU setup */
+	INITCALL(initf_dm);
+	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (INITCALL(board_early_init_f);))
 #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
 	/* get CPU and bus clocks according to the environment variable */
-	get_clocks,		/* get CPU and bus clocks (etc.) */
+	INITCALL(get_clocks);		/* get CPU and bus clocks (etc.) */
 #endif
 #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
-	timer_init,		/* initialize timer */
+	INITCALL(timer_init);		/* initialize timer */
 #endif
-	CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
-	env_init,		/* initialize environment */
-	init_baud_rate,		/* initialze baudrate settings */
-	serial_init,		/* serial communications setup */
-	console_init_f,		/* stage 1 init of console */
-	display_options,	/* say that we are here */
-	display_text_info,	/* show debugging info if required */
-	checkcpu,
-	CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
+	CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT,
+			  (INITCALL(board_postclk_init);))
+	INITCALL(env_init);		/* initialize environment */
+	INITCALL(init_baud_rate);	/* initialze baudrate settings */
+	INITCALL(serial_init);		/* serial communications setup */
+	INITCALL(console_init_f);	/* stage 1 init of console */
+	INITCALL(display_options);	/* say that we are here */
+	INITCALL(display_text_info);	/* show debugging info if required */
+	INITCALL(checkcpu);
+	CONFIG_IS_ENABLED(SYSRESET, (INITCALL(print_resetinfo);))
 	/* display cpu info (and speed) */
-	CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
-	CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
-	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
-	INIT_FUNC_WATCHDOG_INIT
-	INITCALL_EVENT(EVT_MISC_INIT_F),
-	INIT_FUNC_WATCHDOG_RESET
-	CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
-	announce_dram_init,
-	dram_init,		/* configure available RAM banks */
-	CONFIG_IS_ENABLED(POST, (post_init_f,))
-	INIT_FUNC_WATCHDOG_RESET
+	CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (INITCALL(print_cpuinfo);))
+	CONFIG_IS_ENABLED(DTB_RESELECT, (INITCALL(embedded_dtb_select);))
+	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (INITCALL(show_board_info);))
+	WATCHDOG_INIT();
+	INITCALL_EVT(EVT_MISC_INIT_F);
+	WATCHDOG_RESET();
+	CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (INITCALL(init_func_i2c);))
+	INITCALL(announce_dram_init);
+	INITCALL(dram_init);		/* configure available RAM banks */
+	CONFIG_IS_ENABLED(POST, (INITCALL(post_init_f);))
+	WATCHDOG_RESET();
 #if defined(CFG_SYS_DRAM_TEST)
-	testdram,
+	INITCALL(testdram);
 #endif /* CFG_SYS_DRAM_TEST */
-	INIT_FUNC_WATCHDOG_RESET
-
-	CONFIG_IS_ENABLED(POST, (init_post,))
-	INIT_FUNC_WATCHDOG_RESET
+	WATCHDOG_RESET();
+	CONFIG_IS_ENABLED(POST, (INITCALL(init_post);))
+	WATCHDOG_RESET();
 	/*
 	 * Now that we have DRAM mapped and working, we can
 	 * relocate the code and continue running from DRAM.
@@ -934,48 +941,48 @@ static const init_fnc_t init_sequence_f[] = {
 	 *  - monitor code
 	 *  - board info struct
 	 */
-	setup_dest_addr,
+	INITCALL(setup_dest_addr);
 #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
-	fix_fdt,
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
 #if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
-	reloc_fdt,
-	fix_fdt,
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
 #if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
-	reloc_fdt,
+	INITCALL(reloc_fdt);
 #endif
-	reloc_bootstage,
-	reloc_bloblist,
-	setup_reloc,
+	INITCALL(reloc_bootstage);
+	INITCALL(reloc_bloblist);
+	INITCALL(setup_reloc);
 #if defined(CONFIG_X86) || defined(CONFIG_ARC)
-	copy_uboot_to_ram,
-	do_elf_reloc_fixups,
+	INITCALL(copy_uboot_to_ram);
+	INITCALL(do_elf_reloc_fixups);
 #endif
-	clear_bss,
+	INITCALL(clear_bss);
 	/*
 	 * Deregister all cyclic functions before relocation, so that
 	 * gd->cyclic_list does not contain any references to pre-relocation
@@ -985,12 +992,11 @@ static const init_fnc_t init_sequence_f[] = {
 	 * This should happen as late as possible so that the window where a
 	 * watchdog device is not serviced is as small as possible.
 	 */
-	cyclic_unregister_all,
+	INITCALL(cyclic_unregister_all);
 #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
-	jump_to_copy,
+	INITCALL(jump_to_copy);
 #endif
-	NULL,
-};
+}
 
 void board_init_f(ulong boot_flags)
 {
@@ -1000,8 +1006,7 @@ void board_init_f(ulong boot_flags)
 	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
 	gd->boardf = &boardf;
 
-	if (initcall_run_list(init_sequence_f))
-		hang();
+	initcall_run_f();
 
 #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
 		!defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
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
-- 
2.43.0

