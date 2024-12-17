Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B3CE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6F6802D5;
	Tue, 17 Dec 2024 17:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="onCpzhug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA65E80250; Tue, 17 Dec 2024 17:00:09 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3FD80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso36796135e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451205; x=1735056005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yT2rj/WYoAY5tdlzxAsfm5J7Y/QzQwwoHMWZAc/nufM=;
 b=onCpzhugS2QYQWda/SFbxg2xxfmlFvIVpKaz9fui650q/JTYTHfev8uoe9T06jNWMF
 S2YGDbgeSLVos0aKep0L8/y6L40adxHNujvLBANuLmqEKKAHUZ69lgbx8664lzORmcqb
 0PIBgyU9iFPuDOl2satc/5lCaHpB8WGDIEtuxsYdpb2ap2OOuCtqV15R+G+jUvFGJW5G
 OwMkJrlx6tAmTYQ70myW3KbnOw8JzZbBJUujtyLK3RrmtZCVQt3eETfe+9NAGuVUYjXx
 Kz4ibErUEbsl4z/L6J7MmMC+UeFoNpMHZ4FbZAU5ozhUKu9FckIoiiTUgTOPtUO/6uC+
 lDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451205; x=1735056005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yT2rj/WYoAY5tdlzxAsfm5J7Y/QzQwwoHMWZAc/nufM=;
 b=VVbczZXUoygXrB6hOHsrP3BVUCQ/oU4Z2KdcwlRwPXWhirg6cjwdy7FbVTUsrz5Mik
 tYMdj1d9OFFf90kfpvRWlqcDYlK7zNiVVJiCKdpV18un+jpT5Ucx0PqiSqOjXLwBqRZv
 YRhqbySmuiInrX/z1rDyi6pC4OHYAjbMXvY79df0rhXI4iKoi057FItX0UShq7/aMMLb
 TtUGm8MuGPnsnHTIia9ZYArewuFAx54k+njXg5o92Geg0yUSx3AtfnLv+M/L/69hVRJ9
 zodhBolNg2QvFVMEx9sDtDFU+Ba2srSJitpR8Zc8Wz/m/3zfVMUo9PRZz24cRB9A/siv
 3VDA==
X-Gm-Message-State: AOJu0YyVXMjuNJ4aCYUMVgGc+Cu9f8fNu3xaApdoLCe9Pa9BipcoAmoW
 ESCepfd5C0Q2Br/fHvHxQtqzjZDmU1sC/i0lVwhgXdb4nCiPfsp1NAT4SSqPQ05FqZvldlK5G1R
 2ASk=
X-Gm-Gg: ASbGncuCKBKxCNICw2n10dmewMXfVk2JGTGbhEtwjM4o9NZmwy8v2dpY2B6QGR1Ibk3
 za3j2qk5MUpuE81/c0bEvijWeXoRlAjMeQymCuRFWiLAH1gbXd0Dq1q973UneGGbvP8+0Hds4+J
 l4aJegbbjHkq6vzKgZwn/X17MwZETBOGdvGy3QE0AYzN7d1SMPifyX37MqO4+dSzHvnUECCu97c
 n9hjdJ235sDIJrRoKFrOLVGSEcsK3ZAu18bTaJ629OBRJkEDOAoV67bCgm3uS+tMQ==
X-Google-Smtp-Source: AGHT+IF+aXgZjXnlUkNFpBg4X8BR5xuryDbhsQIu8/CMcujuRmDeVgHvI2hgIOp8Bn7j4zvZ+vT+NQ==
X-Received: by 2002:a5d:47a2:0:b0:385:eecb:6f02 with SMTP id
 ffacd0b85a97d-38880ad97cfmr12875004f8f.28.1734451204926; 
 Tue, 17 Dec 2024 08:00:04 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ad9asm11390181f8f.58.2024.12.17.08.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 08:00:04 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH 2/5] board_init_f(): use static calls
Date: Tue, 17 Dec 2024 16:59:33 +0100
Message-ID: <3fff1720f52db5929f46666536a7ffb73eaf45b4.1734448827.git.jerome.forissier@linaro.org>
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

Make static calls instead of iterating over the init_sequence_f arrays.
Tested on a KV260 board (xilinx_zynqmp_kria_defconfig).

- With LTO enabled, the code size reported by bloat-o-meter is 1184
  bytes less (-0.11%)
- With LTO disabled, the code is 592 bytes smaller (-0.05%)
- Execution time does not change in a noticeable way

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_f.c   | 167 +++++++++++++++++++++++----------------------
 include/initcall.h |  25 +++++++
 2 files changed, 111 insertions(+), 81 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index a4d8850cb7d..ba1af3d8055 100644
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
@@ -870,58 +871,62 @@ static int initf_upl(void)
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
+static int initcall_run_f(void)
+{
+	int ret = 0;
+
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
+	WATCHDOG_INIT();
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
@@ -934,48 +939,48 @@ static const init_fnc_t init_sequence_f[] = {
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
@@ -985,12 +990,12 @@ static const init_fnc_t init_sequence_f[] = {
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
+	return ret;
+}
 
 void board_init_f(ulong boot_flags)
 {
@@ -1000,7 +1005,7 @@ void board_init_f(ulong boot_flags)
 	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
 	gd->boardf = &boardf;
 
-	if (initcall_run_list(init_sequence_f))
+	if (initcall_run_f())
 		hang();
 
 #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
diff --git a/include/initcall.h b/include/initcall.h
index 62d3bb67f08..72faab42ada 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -35,4 +35,29 @@ typedef int (*init_fnc_t)(void);
  */
 int initcall_run_list(const init_fnc_t init_sequence[]);
 
+#define INITCALL(_call) \
+	do { \
+		if (!ret) { \
+			debug("%s(): calling %s()\n", __func__, #_call); \
+			ret = _call(); \
+		} \
+	} while (0)
+
+#define INITCALL_EVT(_evt) \
+	do { \
+		if (!ret) { \
+			debug("%s(): event %d/%s\n", __func__, _evt, \
+			      event_type_name(_evt)) ; \
+			ret = event_notify_null(_evt); \
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

