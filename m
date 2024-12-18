Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2041EE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1C08021A;
	Wed, 18 Dec 2024 13:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X9TW3zjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B89C8021D; Wed, 18 Dec 2024 13:04:33 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA7D80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f150ddc86dso51661717b3.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734523469; x=1735128269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Y5V29+iTjeyFQfOsIZceOS9F0NKHRqD4OXEqxj6S5A=;
 b=X9TW3zjY3lZenOJtVp0Gsa67m43jqon4RtxQpcsn4CYQXW6PQpzWuhJmB/mFfgBoz4
 tm1Btpe1lFZIwUN1XvTtoZL0vgkukIHFzuW254YwutDHM7wEDdwScGCRYA5q8mw9Gr4B
 5aTdo1DGccR3yeq11whpNyISpX8veJ8S6b0LPBdntvGRDXOA4ng+RPHnCNCYNjdo0+yL
 68c5AAyIuYw5xv9KGaLAX0m5PXRO3jWp7GF2eexpvwX5JkgH0W+dCg0WsOwDaGsoiOk5
 HdJInrLhPjJaDtORRxDQImD1wNwM29FWNpgIv0hqHjNouBPJCb9Qd3d+rcYNWjEuUwAY
 pIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734523469; x=1735128269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Y5V29+iTjeyFQfOsIZceOS9F0NKHRqD4OXEqxj6S5A=;
 b=HVwH9uvVnKI56JnoSphLRbJ/8HmwqbyVUijVBXarVPUCc/N+p2N5wbjsEFzlLSm0sB
 BHyen3BzJJRh1HPweQUAxwUXelFgk/8OdVv3Vb0JzKWUDwRcBgik85/hQNeuleqSBpBt
 w4G0xRRA4HJHctquxRDjCMtAJk7GjGC5oNZs/fnprfHySrRmHv5ElHF0ziYEyMjMwBYV
 a1vByYDUAodKKelDHmpeKXY5CeJvsPRlcWi8Ad6mk0CP24nbQh031lZBVqHadFTQcesj
 GZBXX8UXwDfMouosoW7ZThsymEAzmvl+t2oM4pin3HiT589y/m1qcvMz0fz0wZneDtJD
 H92w==
X-Gm-Message-State: AOJu0YyBYMWdCgf0glu+V3Nm8o+l6Y/rJnOKoMuYY/ucelT7+lLgt0iY
 lB3pTpGx+1quXjC5RuX7fAJOkZw61BWmvSSH2tI+X79rgVmlVEdZa4Z7Rgg7BVbU0RDugorJSyB
 LZPEDMiqhT5ArJaiWs2w1BilpmRz3cZER5ah0MQ==
X-Gm-Gg: ASbGncue3uPEWZzk7afSdXd7YQHt9chfUKPguu3N03lyRk1JehEM2v4/p7FN78u3Z8B
 JfEJnyty+LjLrAHc2U2bB1o16M6PDGa9eGd33lg==
X-Google-Smtp-Source: AGHT+IFCpeDRWS6bBC7sdjEYIBKsyRriwRwZWc1zBtvJJBZ5m2WjnFznkn7ECXTyz9eh005FNQw9drF+tvkePwZ760s=
X-Received: by 2002:a05:690c:6285:b0:6ef:c24e:5e2 with SMTP id
 00721157ae682-6f3d1e850e1mr16640397b3.19.1734523469222; Wed, 18 Dec 2024
 04:04:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734448827.git.jerome.forissier@linaro.org>
 <73f839b31900ffadcea27a6d58bd9ac5d65a9f1c.1734448827.git.jerome.forissier@linaro.org>
In-Reply-To: <73f839b31900ffadcea27a6d58bd9ac5d65a9f1c.1734448827.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Dec 2024 14:03:53 +0200
Message-ID: <CAC_iWjJvjS7rNx+owtGPJ8cg6kQrP-spnzTSz9TjVYbErPCx4g@mail.gmail.com>
Subject: Re: [PATCH 1/5] common: board: Simplify array with function pointers
 with CONFIG_IS_ENABLED
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jerome,


This doesn't apply on -master, can you rebase it? OR was it meant for -next?

Thanks
/Ilias

On Tue, 17 Dec 2024 at 18:00, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> From: Michal Simek <michal.simek@amd.com>
>
> Convert all simple cases where current ifdef is used with using
> CONFIG_IS_ENABLED.
> The change doesn't have impact on code size and it is only cleaning up
> description.
>
> Checkpatch is reporting issue:
> space required after that ',' (ctx:VxB)
>
> When space is there another warning is coming up:
> space prohibited before that close parenthesis ')'
>
> but there is no way how to fix it that's why leave it like it is.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> [jf: s/Simply/Simplify/ in subject]
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  common/board_f.c |  49 +++++-------------
>  common/board_r.c | 128 ++++++++++++-----------------------------------
>  2 files changed, 46 insertions(+), 131 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 54c48d42ee9..a4d8850cb7d 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -872,12 +872,8 @@ static int initf_upl(void)
>
>  static const init_fnc_t init_sequence_f[] = {
>         setup_mon_len,
> -#ifdef CONFIG_OF_CONTROL
> -       fdtdec_setup,
> -#endif
> -#ifdef CONFIG_TRACE_EARLY
> -       trace_early_init,
> -#endif
> +       CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
> +       CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
>         initf_malloc,
>         initf_upl,
>         log_init,
> @@ -885,16 +881,12 @@ static const init_fnc_t init_sequence_f[] = {
>         event_init,
>         bloblist_maybe_init,
>         setup_spl_handoff,
> -#if defined(CONFIG_CONSOLE_RECORD_INIT_F)
> -       console_record_init,
> -#endif
> +       CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
>         INITCALL_EVENT(EVT_FSP_INIT_F),
>         arch_cpu_init,          /* basic arch cpu dependent setup */
>         mach_cpu_init,          /* SoC/machine dependent CPU setup */
>         initf_dm,
> -#if defined(CONFIG_BOARD_EARLY_INIT_F)
> -       board_early_init_f,
> -#endif
> +       CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
>  #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
>         /* get CPU and bus clocks according to the environment variable */
>         get_clocks,             /* get CPU and bus clocks (etc.) */
> @@ -902,9 +894,7 @@ static const init_fnc_t init_sequence_f[] = {
>  #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
>         timer_init,             /* initialize timer */
>  #endif
> -#if defined(CONFIG_BOARD_POSTCLK_INIT)
> -       board_postclk_init,
> -#endif
> +       CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
>         env_init,               /* initialize environment */
>         init_baud_rate,         /* initialze baudrate settings */
>         serial_init,            /* serial communications setup */
> @@ -912,38 +902,25 @@ static const init_fnc_t init_sequence_f[] = {
>         display_options,        /* say that we are here */
>         display_text_info,      /* show debugging info if required */
>         checkcpu,
> -#if defined(CONFIG_SYSRESET)
> -       print_resetinfo,
> -#endif
> -#if defined(CONFIG_DISPLAY_CPUINFO)
> -       print_cpuinfo,          /* display cpu info (and speed) */
> -#endif
> -#if defined(CONFIG_DTB_RESELECT)
> -       embedded_dtb_select,
> -#endif
> -#if defined(CONFIG_DISPLAY_BOARDINFO)
> -       show_board_info,
> -#endif
> +       CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
> +       /* display cpu info (and speed) */
> +       CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
> +       CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
> +       CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
>         INIT_FUNC_WATCHDOG_INIT
>         INITCALL_EVENT(EVT_MISC_INIT_F),
>         INIT_FUNC_WATCHDOG_RESET
> -#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
> -       init_func_i2c,
> -#endif
> +       CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
>         announce_dram_init,
>         dram_init,              /* configure available RAM banks */
> -#ifdef CONFIG_POST
> -       post_init_f,
> -#endif
> +       CONFIG_IS_ENABLED(POST, (post_init_f,))
>         INIT_FUNC_WATCHDOG_RESET
>  #if defined(CFG_SYS_DRAM_TEST)
>         testdram,
>  #endif /* CFG_SYS_DRAM_TEST */
>         INIT_FUNC_WATCHDOG_RESET
>
> -#ifdef CONFIG_POST
> -       init_post,
> -#endif
> +       CONFIG_IS_ENABLED(POST, (init_post,))
>         INIT_FUNC_WATCHDOG_RESET
>         /*
>          * Now that we have DRAM mapped and working, we can
> diff --git a/common/board_r.c b/common/board_r.c
> index 23ebc41868c..19bcf3950d5 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -612,19 +612,11 @@ static init_fnc_t init_sequence_r[] = {
>         initr_malloc,
>         log_init,
>         initr_bootstage,        /* Needs malloc() but has its own timer */
> -#if defined(CONFIG_CONSOLE_RECORD)
> -       console_record_init,
> -#endif
> -#ifdef CONFIG_SYS_NONCACHED_MEMORY
> -       noncached_init,
> -#endif
> +       CONFIG_IS_ENABLED(CONSOLE_RECORD, (console_record_init,))
> +       CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY, (noncached_init,))
>         initr_of_live,
> -#ifdef CONFIG_DM
> -       initr_dm,
> -#endif
> -#ifdef CONFIG_ADDR_MAP
> -       init_addr_map,
> -#endif
> +       CONFIG_IS_ENABLED(DM, (initr_dm,))
> +       CONFIG_IS_ENABLED(ADDR_MAP, (init_addr_map,))
>  #if defined(CONFIG_ARM) || defined(CONFIG_RISCV) || defined(CONFIG_SANDBOX)
>         board_init,     /* Setup chipselects */
>  #endif
> @@ -634,36 +626,22 @@ static init_fnc_t init_sequence_r[] = {
>          * davinci SOC's is added. Remove this check once all the board
>          * implement this.
>          */
> -#ifdef CONFIG_CLOCKS
> -       set_cpu_clk_info, /* Setup clock information */
> -#endif
> +       CONFIG_IS_ENABLED(CLOCKS, (set_cpu_clk_info,)) /* Setup clock information */
>         initr_lmb,
> -#ifdef CONFIG_EFI_LOADER
> -       efi_memory_init,
> -#endif
> -#ifdef CONFIG_BINMAN_FDT
> -       initr_binman,
> -#endif
> -#ifdef CONFIG_FSP_VERSION2
> -       arch_fsp_init_r,
> -#endif
> +       CONFIG_IS_ENABLED(EFI_LOADER, (efi_memory_init,))
> +       CONFIG_IS_ENABLED(BINMAN_FDT, (initr_binman,))
> +       CONFIG_IS_ENABLED(FSP_VERSION2, (arch_fsp_init_r,))
>         initr_dm_devices,
>         stdio_init_tables,
>         serial_initialize,
>         initr_announce,
>         dm_announce,
> -#if CONFIG_IS_ENABLED(WDT)
> -       initr_watchdog,
> -#endif
> +       CONFIG_IS_ENABLED(WDT, (initr_watchdog,))
>         INIT_FUNC_WATCHDOG_RESET
>         arch_initr_trap,
> -#if defined(CONFIG_BOARD_EARLY_INIT_R)
> -       board_early_init_r,
> -#endif
> +       CONFIG_IS_ENABLED(BOARD_EARLY_INIT_R, (board_early_init_r,))
>         INIT_FUNC_WATCHDOG_RESET
> -#ifdef CONFIG_POST
> -       post_output_backlog,
> -#endif
> +       CONFIG_IS_ENABLED(POST, (post_output_backlog,))
>         INIT_FUNC_WATCHDOG_RESET
>  #if defined(CONFIG_PCI_INIT_R) && defined(CONFIG_SYS_EARLY_PCI_INIT)
>         /*
> @@ -672,45 +650,25 @@ static init_fnc_t init_sequence_r[] = {
>          */
>         pci_init,
>  #endif
> -#ifdef CONFIG_ARCH_EARLY_INIT_R
> -       arch_early_init_r,
> -#endif
> +       CONFIG_IS_ENABLED(ARCH_EARLY_INIT_R, (arch_early_init_r,))
>         power_init_board,
> -#ifdef CONFIG_MTD_NOR_FLASH
> -       initr_flash,
> -#endif
> +       CONFIG_IS_ENABLED(MTD_NOR_FLASH, (initr_flash,))
>         INIT_FUNC_WATCHDOG_RESET
>  #if defined(CONFIG_PPC) || defined(CONFIG_M68K) || defined(CONFIG_X86)
>         /* initialize higher level parts of CPU like time base and timers */
>         cpu_init_r,
>  #endif
> -#ifdef CONFIG_EFI_LOADER
> -       efi_init_early,
> -#endif
> -#ifdef CONFIG_CMD_NAND
> -       initr_nand,
> -#endif
> -#ifdef CONFIG_CMD_ONENAND
> -       initr_onenand,
> -#endif
> -#ifdef CONFIG_MMC
> -       initr_mmc,
> -#endif
> -#ifdef CONFIG_XEN
> -       xen_init,
> -#endif
> -#ifdef CONFIG_PVBLOCK
> -       initr_pvblock,
> -#endif
> +       CONFIG_IS_ENABLED(EFI_LOADER, (efi_init_early,))
> +       CONFIG_IS_ENABLED(CMD_NAND, (initr_nand,))
> +       CONFIG_IS_ENABLED(CMD_ONENAND, (initr_onenand,))
> +       CONFIG_IS_ENABLED(MMC, (initr_mmc,))
> +       CONFIG_IS_ENABLED(XEN, (xen_init,))
> +       CONFIG_IS_ENABLED(PVBLOCK, (initr_pvblock,))
>         initr_env,
> -#ifdef CONFIG_SYS_MALLOC_BOOTPARAMS
> -       initr_malloc_bootparams,
> -#endif
> +       CONFIG_IS_ENABLED(SYS_MALLOC_BOOTPARAMS, (initr_malloc_bootparams,))
>         INIT_FUNC_WATCHDOG_RESET
>         cpu_secondary_init_r,
> -#if defined(CONFIG_ID_EEPROM)
> -       mac_read_from_eeprom,
> -#endif
> +       CONFIG_IS_ENABLED(ID_EEPROM, (mac_read_from_eeprom,))
>         INITCALL_EVENT(EVT_SETTINGS_R),
>         INIT_FUNC_WATCHDOG_RESET
>  #if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
> @@ -721,24 +679,15 @@ static init_fnc_t init_sequence_r[] = {
>  #endif
>         stdio_add_devices,
>         jumptable_init,
> -#ifdef CONFIG_API
> -       api_init,
> -#endif
> +       CONFIG_IS_ENABLED(API, (api_init,))
>         console_init_r,         /* fully init console as a device */
> -#ifdef CONFIG_DISPLAY_BOARDINFO_LATE
> -       console_announce_r,
> -       show_board_info,
> -#endif
> -#ifdef CONFIG_ARCH_MISC_INIT
> -       arch_misc_init,         /* miscellaneous arch-dependent init */
> -#endif
> -#ifdef CONFIG_MISC_INIT_R
> -       misc_init_r,            /* miscellaneous platform-dependent init */
> -#endif
> +       CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE, (console_announce_r, show_board_info,))
> +       /* miscellaneous arch-dependent init */
> +       CONFIG_IS_ENABLED(ARCH_MISC_INIT, (arch_misc_init,))
> +       /* miscellaneous platform-dependent init */
> +       CONFIG_IS_ENABLED(MISC_INIT_R, (misc_init_r,))
>         INIT_FUNC_WATCHDOG_RESET
> -#ifdef CONFIG_CMD_KGDB
> -       kgdb_init,
> -#endif
> +       CONFIG_IS_ENABLED(CMD_KGDB, (kgdb_init,))
>         interrupt_init,
>  #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
>         timer_init,             /* initialize timer */
> @@ -746,22 +695,11 @@ static init_fnc_t init_sequence_r[] = {
>         initr_status_led,
>         initr_boot_led_blink,
>         /* PPC has a udelay(20) here dating from 2002. Why? */
> -#ifdef CONFIG_BOARD_LATE_INIT
> -       board_late_init,
> -#endif
> -#ifdef CONFIG_BITBANGMII
> -       bb_miiphy_init,
> -#endif
> -#ifdef CONFIG_PCI_ENDPOINT
> -       pci_ep_init,
> -#endif
> -#if defined(CONFIG_CMD_NET)
> -       INIT_FUNC_WATCHDOG_RESET
> -       initr_net,
> -#endif
> -#ifdef CONFIG_POST
> -       initr_post,
> -#endif
> +       CONFIG_IS_ENABLED(BOARD_LATE_INIT, (board_late_init,))
> +       CONFIG_IS_ENABLED(BITBANGMII, (bb_miiphy_init,))
> +       CONFIG_IS_ENABLED(PCI_ENDPOINT, (pci_ep_init,))
> +       CONFIG_IS_ENABLED(CMD_NET, (INIT_FUNC_WATCHDOG_RESET initr_net,))
> +       CONFIG_IS_ENABLED(POST, (initr_post,))
>         INIT_FUNC_WATCHDOG_RESET
>         INITCALL_EVENT(EVT_LAST_STAGE_INIT),
>  #if defined(CFG_PRAM)
> --
> 2.43.0
>
