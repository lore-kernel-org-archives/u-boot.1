Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FACE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 15:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7615C801E8;
	Mon,  6 Jan 2025 16:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wtablidv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9C48021A; Mon,  6 Jan 2025 16:54:42 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 942AF801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 16:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso21690658a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736178879; x=1736783679; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+xHfqsLAj0VkqseznEtQqy3kAZA37U0Pcv2EY8uskbQ=;
 b=wtablidv1WxUYmQIY7ZkkeAzNiVNqY0bHDaaDuiVF54WBK29m82tLmkCp+HBBv5Yqd
 bedYvHSHWH6g+dLu4tQ7/kut9jJdyjR0+/lgI8DVl56ijuDXgKAszLhYcteJyc9kqKM6
 LmylHVh7QCCHEmzXi9o+KPYorc4qwrRbt2JD+2MzdBKQj3PGeV1t1rpwsOrvKWfBWbW3
 2+4fmRc0DUkKHHicMOBJoSgrluAqiDkJTAohoWiSPT14rE+mL6FqILO7HwUIushf9FL1
 2YrwGMMuqWxo3SbEPOY0pVBOX/ZOoTCN8c/S7abfllwGsyD/WfyDsFNLxg0ZjPreRn4R
 Q9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736178879; x=1736783679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xHfqsLAj0VkqseznEtQqy3kAZA37U0Pcv2EY8uskbQ=;
 b=vlPC5Ohx6R4jHyV9LzkPOUK4zVuN/MMSPQhTtxoeirVBg50vk1Nn6dMzfQZhH840/O
 VlrsP3XruZOO0m7Vnq6LRLsoIGgFw2PPjTP6DVHIbBzU7bXHQ9OE2iVg8cXxr8GI44nj
 gXeh1f5GyoiDWIQEGDXWAtVY/WO0I+TjAPGXxG1N3lVoZe0KY7bGaoBj9VedwtJuvWYQ
 k/Q2EVyR3JmgL7EPQ3x131Li7aO+jL69EHHza0tJF7tUaM/DRjXsQTonD0J+vnT1dN/d
 f5cV3vqXgaBwojHF9V3LeNm/pq8Ipo9u9TgzHBIrzunnHw/JC9tRF7tgFfbi+oNljLPV
 mhKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkhkQGXv9QEhehWSDSGGR+ed7AR25NLCqJ2e+v+nh173PjuUsDeux5ZkreuJdyLVj3sGGHnCA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3gS83UqL9l8Gy1LqZ7o320UG0s5Rje7IqIo6AoIYMuZ+F0W0H
 dfNdpJ3BNTpfnyPRWfV6Pv4tUeWh3wlqP/jyVh7E40SbGHeU4YNUEzyopaNDX2Q=
X-Gm-Gg: ASbGnct2dgC5j7o0OZV3qh7b8TROSU5WHoyl9R9vuFV5MtPo4YwbVk81+7+x5LUGzYU
 IsvtMg9HWHlH2a1FrOJYL87ZvpeVp/r6D79JMqz1DgVqoFiJtUK43OXqyHb434JVZ1mBYwz/x6u
 mlWlaAHntAgD6E8E2NLMZhp644KphSM4cHQg4vtPRRhTA1qf8F42mxJvCQIoKoiCjG5ReVlR45p
 vNGKUCLo/9/yAxN0gZo2DLbN2CXXOByflg4EQujBiGYcwQPZHx63yFgdK8VJ1gwG9H9Gklhg0gp
 6Wm5SpGQdN8vvEWrwgCFGyxGzC8mRp7Ih3gIsXA=
X-Google-Smtp-Source: AGHT+IFfMyKRlxlSyIz9XEarM23ggTt3xaoXF0n+DeMYgPx3BB0PnvXT1iCMKHS0RxCIqs/TpmNh9A==
X-Received: by 2002:a05:6402:5245:b0:5d3:ba42:e9fa with SMTP id
 4fb4d7f45d1cf-5d81ddc01a0mr144224279a12.16.1736178878808; 
 Mon, 06 Jan 2025 07:54:38 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e83017asm2263246166b.32.2025.01.06.07.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 07:54:38 -0800 (PST)
Message-ID: <4da1b2d0-2549-4792-8e58-2a6546b447fb@linaro.org>
Date: Mon, 6 Jan 2025 16:54:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] common: board: make static calls
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <cover.1736174204.git.jerome.forissier@linaro.org>
 <43abf76bf40d47806f8e3480baa7b745ae281188.1736174204.git.jerome.forissier@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <43abf76bf40d47806f8e3480baa7b745ae281188.1736174204.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Thanks for this!

On 06/01/2025 15:40, Jerome Forissier wrote:
> Change board_init_f(), board_init_f_r() and board_init_r() to make
> static calls instead of iterating over the init_sequence_f,
> init_sequence_f_r and init_sequence_r arrays, respectively. This makes
> the code a simpler (and even more so when initcall_run_list() is
> later removed) and it reduces the binary size as well. Tested with
> xilinx_zynqmp_kria_defconfig; bloat-o-meter results:
> 
> - With LTO
> add/remove: 106/196 grow/shrink: 10/28 up/down: 31548/-33829 (-2281)
> Total: Before=1070471, After=1068190, chg -0.21%
> - Without LTO
> add/remove: 0/54 grow/shrink: 3/0 up/down: 2322/-2832 (-510)
> Total: Before=1121723, After=1121213, chg -0.05%
> 
> Execution time does not change in a noticeable way.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/board_f.c   | 218 ++++++++++++++++++++-------------------
>  common/board_r.c   | 251 +++++++++++++++++++++++----------------------
>  include/initcall.h |  27 +++++
>  3 files changed, 266 insertions(+), 230 deletions(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index 54c48d42ee9..cf88e97b9e2 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -38,6 +38,7 @@
>  #include <spl.h>
>  #include <status_led.h>
>  #include <sysreset.h>
> +#include <time.h>
>  #include <timer.h>
>  #include <trace.h>
>  #include <upl.h>
> @@ -870,81 +871,86 @@ static int initf_upl(void)
>  	return 0;
>  }
>  
> -static const init_fnc_t init_sequence_f[] = {
> -	setup_mon_len,
> -#ifdef CONFIG_OF_CONTROL
> -	fdtdec_setup,
> +static void initcall_run_f(void)
> +{
> +	/*
> +	 * Please do not add logic to this function (variables, if (), etc.).
> +	 * For simplicity it should remain an ordered list of function calls.
> +	 */
> +	INITCALL(setup_mon_len);
> +#if CONFIG_IS_ENABLED(OF_CONTROL)
> +	INITCALL(fdtdec_setup);
>  #endif
> -#ifdef CONFIG_TRACE_EARLY
> -	trace_early_init,
> +#if CONFIG_IS_ENABLED(TRACE_EARLY)
> +	INITCALL(trace_early_init);
>  #endif
> -	initf_malloc,
> -	initf_upl,
> -	log_init,
> -	initf_bootstage,	/* uses its own timer, so does not need DM */
> -	event_init,
> -	bloblist_maybe_init,
> -	setup_spl_handoff,
> -#if defined(CONFIG_CONSOLE_RECORD_INIT_F)
> -	console_record_init,
> +	INITCALL(initf_malloc);
> +	INITCALL(initf_upl);
> +	INITCALL(log_init);
> +	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
> +	INITCALL(event_init);
> +	INITCALL(bloblist_maybe_init);
> +	INITCALL(setup_spl_handoff);
> +#if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
> +	INITCALL(console_record_init);
>  #endif
> -	INITCALL_EVENT(EVT_FSP_INIT_F),
> -	arch_cpu_init,		/* basic arch cpu dependent setup */
> -	mach_cpu_init,		/* SoC/machine dependent CPU setup */
> -	initf_dm,
> -#if defined(CONFIG_BOARD_EARLY_INIT_F)
> -	board_early_init_f,
> +	INITCALL_EVT(EVT_FSP_INIT_F);
> +	INITCALL(arch_cpu_init);	/* basic arch cpu dependent setup */
> +	INITCALL(mach_cpu_init);	/* SoC/machine dependent CPU setup */
> +	INITCALL(initf_dm);
> +#if CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F)
> +	INITCALL(board_early_init_f);
>  #endif
>  #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
>  	/* get CPU and bus clocks according to the environment variable */
> -	get_clocks,		/* get CPU and bus clocks (etc.) */
> +	INITCALL(get_clocks);		/* get CPU and bus clocks (etc.) */
>  #endif
>  #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
> -	timer_init,		/* initialize timer */
> +	INITCALL(timer_init);		/* initialize timer */
>  #endif
> -#if defined(CONFIG_BOARD_POSTCLK_INIT)
> -	board_postclk_init,
> +#if CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT)
> +	INITCALL(board_postclk_init);
>  #endif
> -	env_init,		/* initialize environment */
> -	init_baud_rate,		/* initialze baudrate settings */
> -	serial_init,		/* serial communications setup */
> -	console_init_f,		/* stage 1 init of console */
> -	display_options,	/* say that we are here */
> -	display_text_info,	/* show debugging info if required */
> -	checkcpu,
> -#if defined(CONFIG_SYSRESET)
> -	print_resetinfo,
> +	INITCALL(env_init);		/* initialize environment */
> +	INITCALL(init_baud_rate);	/* initialze baudrate settings */
> +	INITCALL(serial_init);		/* serial communications setup */
> +	INITCALL(console_init_f);	/* stage 1 init of console */
> +	INITCALL(display_options);	/* say that we are here */
> +	INITCALL(display_text_info);	/* show debugging info if required */
> +	INITCALL(checkcpu);
> +#if CONFIG_IS_ENABLED(SYSRESET)
> +	INITCALL(print_resetinfo);
>  #endif
> -#if defined(CONFIG_DISPLAY_CPUINFO)
> -	print_cpuinfo,		/* display cpu info (and speed) */
> +	/* display cpu info (and speed) */
> +#if CONFIG_IS_ENABLED(DISPLAY_CPUINFO)
> +	INITCALL(print_cpuinfo);
>  #endif
> -#if defined(CONFIG_DTB_RESELECT)
> -	embedded_dtb_select,
> +#if CONFIG_IS_ENABLED(DTB_RESELECT)
> +	INITCALL(embedded_dtb_select);
>  #endif
> -#if defined(CONFIG_DISPLAY_BOARDINFO)
> -	show_board_info,
> +#if CONFIG_IS_ENABLED(DISPLAY_BOARDINFO)
> +	INITCALL(show_board_info);
>  #endif
> -	INIT_FUNC_WATCHDOG_INIT
> -	INITCALL_EVENT(EVT_MISC_INIT_F),
> -	INIT_FUNC_WATCHDOG_RESET
> +	WATCHDOG_INIT();
> +	INITCALL_EVT(EVT_MISC_INIT_F);
> +	WATCHDOG_RESET();
>  #if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
> -	init_func_i2c,
> +	INITCALL(init_func_i2c);
>  #endif
> -	announce_dram_init,
> -	dram_init,		/* configure available RAM banks */
> -#ifdef CONFIG_POST
> -	post_init_f,
> +	INITCALL(announce_dram_init);
> +	INITCALL(dram_init);		/* configure available RAM banks */
> +#if CONFIG_IS_ENABLED(POST)
> +	INITCALL(post_init_f);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> +	WATCHDOG_RESET();
>  #if defined(CFG_SYS_DRAM_TEST)
> -	testdram,
> +	INITCALL(testdram);
>  #endif /* CFG_SYS_DRAM_TEST */
> -	INIT_FUNC_WATCHDOG_RESET
> -
> -#ifdef CONFIG_POST
> -	init_post,
> +	WATCHDOG_RESET();
> +#if CONFIG_IS_ENABLED(POST)
> +	INITCALL(init_post);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> +	WATCHDOG_RESET();
>  	/*
>  	 * Now that we have DRAM mapped and working, we can
>  	 * relocate the code and continue running from DRAM.
> @@ -957,48 +963,50 @@ static const init_fnc_t init_sequence_f[] = {
>  	 *  - monitor code
>  	 *  - board info struct
>  	 */
> -	setup_dest_addr,
> +	INITCALL(setup_dest_addr);
>  #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -	fix_fdt,
> +	INITCALL(fix_fdt);
>  #endif
>  #ifdef CFG_PRAM
> -	reserve_pram,
> +	INITCALL(reserve_pram);
>  #endif
> -	reserve_round_4k,
> -	setup_relocaddr_from_bloblist,
> -	arch_reserve_mmu,
> -	reserve_video,
> -	reserve_trace,
> -	reserve_uboot,
> -	reserve_malloc,
> -	reserve_board,
> -	reserve_global_data,
> -	reserve_fdt,
> -#if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -	reloc_fdt,
> -	fix_fdt,
> +	INITCALL(reserve_round_4k);
> +	INITCALL(setup_relocaddr_from_bloblist);
> +	INITCALL(arch_reserve_mmu);
> +	INITCALL(reserve_video);
> +	INITCALL(reserve_trace);
> +	INITCALL(reserve_uboot);
> +	INITCALL(reserve_malloc);
> +	INITCALL(reserve_board);
> +	INITCALL(reserve_global_data);
> +	INITCALL(reserve_fdt);
> +#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
> +    CONFIG_IS_ENABLED(INITIAL_DTB_READONLY)
> +	INITCALL(reloc_fdt);
> +	INITCALL(fix_fdt);
>  #endif
> -	reserve_bootstage,
> -	reserve_bloblist,
> -	reserve_arch,
> -	reserve_stacks,
> -	dram_init_banksize,
> -	show_dram_config,
> -	INIT_FUNC_WATCHDOG_RESET
> -	setup_bdinfo,
> -	display_new_sp,
> -	INIT_FUNC_WATCHDOG_RESET
> -#if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -	reloc_fdt,
> +	INITCALL(reserve_bootstage);
> +	INITCALL(reserve_bloblist);
> +	INITCALL(reserve_arch);
> +	INITCALL(reserve_stacks);
> +	INITCALL(dram_init_banksize);
> +	INITCALL(show_dram_config);
> +	WATCHDOG_RESET();
> +	INITCALL(setup_bdinfo);
> +	INITCALL(display_new_sp);
> +	WATCHDOG_RESET();
> +#if !CONFIG_IS_ENABLED(OF_BOARD_FIXUP) || \
> +    !CONFIG_IS_ENABLED(INITIAL_DTB_READONLY)
> +	INITCALL(reloc_fdt);
>  #endif
> -	reloc_bootstage,
> -	reloc_bloblist,
> -	setup_reloc,
> -#if defined(CONFIG_X86) || defined(CONFIG_ARC)
> -	copy_uboot_to_ram,
> -	do_elf_reloc_fixups,
> +	INITCALL(reloc_bootstage);
> +	INITCALL(reloc_bloblist);
> +	INITCALL(setup_reloc);
> +#if CONFIG_IS_ENABLED(X86) || CONFIG_IS_ENABLED(ARC)
> +	INITCALL(copy_uboot_to_ram);
> +	INITCALL(do_elf_reloc_fixups);
>  #endif
> -	clear_bss,
> +	INITCALL(clear_bss);
>  	/*
>  	 * Deregister all cyclic functions before relocation, so that
>  	 * gd->cyclic_list does not contain any references to pre-relocation
> @@ -1008,12 +1016,11 @@ static const init_fnc_t init_sequence_f[] = {
>  	 * This should happen as late as possible so that the window where a
>  	 * watchdog device is not serviced is as small as possible.
>  	 */
> -	cyclic_unregister_all,
> -#if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
> -	jump_to_copy,
> +	INITCALL(cyclic_unregister_all);
> +#if !CONFIG_IS_ENABLED(ARM) && !CONFIG_IS_ENABLED(SANDBOX)
> +	INITCALL(jump_to_copy);
>  #endif
> -	NULL,
> -};
> +}
>  
>  void board_init_f(ulong boot_flags)
>  {
> @@ -1023,8 +1030,7 @@ void board_init_f(ulong boot_flags)
>  	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>  	gd->boardf = &boardf;
>  
> -	if (initcall_run_list(init_sequence_f))
> -		hang();
> +	initcall_run_f();
>  
>  #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>  		!defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
> @@ -1038,8 +1044,8 @@ void board_init_f(ulong boot_flags)
>  /*
>   * For now this code is only used on x86.
>   *
> - * init_sequence_f_r is the list of init functions which are run when
> - * U-Boot is executing from Flash with a semi-limited 'C' environment.
> + * Run init functions which are run when U-Boot is executing from Flash with a
> + * semi-limited 'C' environment.
>   * The following limitations must be considered when implementing an
>   * '_f_r' function:
>   *  - 'static' variables are read-only
> @@ -1052,18 +1058,16 @@ void board_init_f(ulong boot_flags)
>   * NOTE: At present only x86 uses this route, but it is intended that
>   * all archs will move to this when generic relocation is implemented.
>   */
> -static const init_fnc_t init_sequence_f_r[] = {
> -#if !CONFIG_IS_ENABLED(X86_64)
> -	init_cache_f_r,
> +static void initcall_run_f_r(void)
> +{
> +#if CONFIG_IS_ENABLED(X86_64)
> +	INITCALL(init_cache_f_r);
>  #endif
> -
> -	NULL,
> -};
> +}
>  
>  void board_init_f_r(void)
>  {
> -	if (initcall_run_list(init_sequence_f_r))
> -		hang();
> +	initcall_run_f_r();
>  
>  	/*
>  	 * The pre-relocation drivers may be using memory that has now gone
> diff --git a/common/board_r.c b/common/board_r.c
> index f63c6aed4d5..74ebbdc7de9 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -582,21 +582,24 @@ static int run_main_loop(void)
>  }
>  
>  /*
> - * Over time we hope to remove these functions with code fragments and
> - * stub functions, and instead call the relevant function directly.
> - *
> - * We also hope to remove most of the driver-related init and do it if/when
> - * the driver is later used.
> + * Over time we hope to remove most of the driver-related init and do it
> + * if/when the driver is later used.
>   *
>   * TODO: perhaps reset the watchdog in the initcall function after each call?
>   */
> -static init_fnc_t init_sequence_r[] = {
> -	initr_trace,
> -	initr_reloc,
> -	event_init,
> +
> +static void initcall_run_r(void)
> +{
> +	/*
> +	 * Please do not add logic to this function (variables, if (), etc.).
> +	 * For simplicity it should remain an ordered list of function calls.
> +	 */
> +	INITCALL(initr_trace);
> +	INITCALL(initr_reloc);
> +	INITCALL(event_init);
>  	/* TODO: could x86/PPC have this also perhaps? */
> -#if defined(CONFIG_ARM) || defined(CONFIG_RISCV)
> -	initr_caches,
> +#if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV)
> +	INITCALL(initr_caches);
>  	/* Note: For Freescale LS2 SoCs, new MMU table is created in DDR.
>  	 *	 A temporary mapping of IFC high region is since removed,
>  	 *	 so environmental variables in NOR flash is not available
> @@ -604,29 +607,30 @@ static init_fnc_t init_sequence_r[] = {
>  	 *	 region.
>  	 */
>  #endif
> -	initr_reloc_global_data,
> -#if defined(CONFIG_SYS_INIT_RAM_LOCK) && defined(CONFIG_E500)
> -	initr_unlock_ram_in_cache,
> +	INITCALL(initr_reloc_global_data);
> +#if CONFIG_IS_ENABLED(SYS_INIT_RAM_LOCK) && CONFIG_IS_ENABLED(E500)
> +	INITCALL(initr_unlock_ram_in_cache);
>  #endif
> -	initr_barrier,
> -	initr_malloc,
> -	log_init,
> -	initr_bootstage,	/* Needs malloc() but has its own timer */
> -#if defined(CONFIG_CONSOLE_RECORD)
> -	console_record_init,
> +	INITCALL(initr_barrier);
> +	INITCALL(initr_malloc);
> +	INITCALL(log_init);
> +	INITCALL(initr_bootstage); /* Needs malloc() but has its own timer */
> +#if CONFIG_IS_ENABLED(CONSOLE_RECORD)
> +	INITCALL(console_record_init);
>  #endif
> -#ifdef CONFIG_SYS_NONCACHED_MEMORY
> -	noncached_init,
> +#if CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY)
> +	INITCALL(noncached_init);
>  #endif
> -	initr_of_live,
> -#ifdef CONFIG_DM
> -	initr_dm,
> +	INITCALL(initr_of_live);
> +#if CONFIG_IS_ENABLED(DM)
> +	INITCALL(initr_dm);
>  #endif
> -#ifdef CONFIG_ADDR_MAP
> -	init_addr_map,
> +#if CONFIG_IS_ENABLED(ADDR_MAP)
> +	INITCALL(init_addr_map);
>  #endif
> -#if defined(CONFIG_ARM) || defined(CONFIG_RISCV) || defined(CONFIG_SANDBOX)
> -	board_init,	/* Setup chipselects */
> +#if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV) || \
> +    CONFIG_IS_ENABLED(SANDBOX)
> +	INITCALL(board_init);	/* Setup chipselects */
>  #endif
>  	/*
>  	 * TODO: printing of the clock inforamtion of the board is now
> @@ -634,142 +638,144 @@ static init_fnc_t init_sequence_r[] = {
>  	 * davinci SOC's is added. Remove this check once all the board
>  	 * implement this.
>  	 */
> -#ifdef CONFIG_CLOCKS
> -	set_cpu_clk_info, /* Setup clock information */
> +#if CONFIG_IS_ENABLED(CLOCKS)
> +	INITCALL(set_cpu_clk_info);
>  #endif
> -	initr_lmb,
> -#ifdef CONFIG_EFI_LOADER
> -	efi_memory_init,
> +	INITCALL(initr_lmb);
> +#if CONFIG_IS_ENABLED(EFI_LOADER)
> +	INITCALL(efi_memory_init);
>  #endif
> -#ifdef CONFIG_BINMAN_FDT
> -	initr_binman,
> +#if CONFIG_IS_ENABLED(BINMAN_FDT)
> +	INITCALL(initr_binman);
>  #endif
> -#ifdef CONFIG_FSP_VERSION2
> -	arch_fsp_init_r,
> +#if CONFIG_IS_ENABLED(FSP_VERSION2)
> +	INITCALL(arch_fsp_init_r);
>  #endif
> -	initr_dm_devices,
> -	stdio_init_tables,
> -	serial_initialize,
> -	initr_announce,
> -	dm_announce,
> +	INITCALL(initr_dm_devices);
> +	INITCALL(stdio_init_tables);
> +	INITCALL(serial_initialize);
> +	INITCALL(initr_announce);
> +	INITCALL(dm_announce);
>  #if CONFIG_IS_ENABLED(WDT)
> -	initr_watchdog,
> +	INITCALL(initr_watchdog);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -	arch_initr_trap,
> -#if defined(CONFIG_BOARD_EARLY_INIT_R)
> -	board_early_init_r,
> +	WATCHDOG_RESET();
> +	INITCALL(arch_initr_trap);
> +#if CONFIG_IS_ENABLED(BOARD_EARLY_INIT_R)
> +	INITCALL(board_early_init_r);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -#ifdef CONFIG_POST
> -	post_output_backlog,
> +	WATCHDOG_RESET();
> +#if CONFIG_IS_ENABLED(POST)
> +	INITCALL(post_output_backlog);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -#if defined(CONFIG_PCI_INIT_R) && defined(CONFIG_SYS_EARLY_PCI_INIT)
> +	WATCHDOG_RESET();
> +#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
>  	/*
>  	 * Do early PCI configuration _before_ the flash gets initialised,
>  	 * because PCU resources are crucial for flash access on some boards.
>  	 */
> -	pci_init,
> +	INITCALL(pci_init);
>  #endif
> -#ifdef CONFIG_ARCH_EARLY_INIT_R
> -	arch_early_init_r,
> +#if CONFIG_IS_ENABLED(ARCH_EARLY_INIT_R)
> +	INITCALL(arch_early_init_r);
>  #endif
> -	power_init_board,
> -#ifdef CONFIG_MTD_NOR_FLASH
> -	initr_flash,
> +	INITCALL(power_init_board);
> +#if CONFIG_IS_ENABLED(MTD_NOR_FLASH)
> +	INITCALL(initr_flash);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -#if defined(CONFIG_PPC) || defined(CONFIG_M68K) || defined(CONFIG_X86)
> +	WATCHDOG_RESET();
> +#if CONFIG_IS_ENABLED(PPC) || CONFIG_IS_ENABLED(M68K) || CONFIG_IS_ENABLED(X86)
>  	/* initialize higher level parts of CPU like time base and timers */
> -	cpu_init_r,
> +	INITCALL(cpu_init_r);
>  #endif
> -#ifdef CONFIG_EFI_LOADER
> -	efi_init_early,
> +#if CONFIG_IS_ENABLED(EFI_LOADER)
> +	INITCALL(efi_init_early);
>  #endif
> -#ifdef CONFIG_CMD_NAND
> -	initr_nand,
> +#if CONFIG_IS_ENABLED(CMD_NAND)
> +	INITCALL(initr_nand);
>  #endif
> -#ifdef CONFIG_CMD_ONENAND
> -	initr_onenand,
> +#if CONFIG_IS_ENABLED(CMD_ONENAND)
> +	INITCALL(initr_onenand);
>  #endif
> -#ifdef CONFIG_MMC
> -	initr_mmc,
> +#if CONFIG_IS_ENABLED(MMC)
> +	INITCALL(initr_mmc);
>  #endif
> -#ifdef CONFIG_XEN
> -	xen_init,
> +#if CONFIG_IS_ENABLED(XEN)
> +	INITCALL(xen_init);
>  #endif
> -#ifdef CONFIG_PVBLOCK
> -	initr_pvblock,
> +#if CONFIG_IS_ENABLED(PVBLOCK)
> +	INITCALL(initr_pvblock);
>  #endif
> -	initr_env,
> -#ifdef CONFIG_SYS_MALLOC_BOOTPARAMS
> -	initr_malloc_bootparams,
> +	INITCALL(initr_env);
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_BOOTPARAMS)
> +	INITCALL(initr_malloc_bootparams);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -	cpu_secondary_init_r,
> -#if defined(CONFIG_ID_EEPROM)
> -	mac_read_from_eeprom,
> +	WATCHDOG_RESET();
> +	INITCALL(cpu_secondary_init_r);
> +#if CONFIG_IS_ENABLED(ID_EEPROM)
> +	INITCALL(mac_read_from_eeprom);
>  #endif
> -	INITCALL_EVENT(EVT_SETTINGS_R),
> -	INIT_FUNC_WATCHDOG_RESET
> -#if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
> +	INITCALL_EVT(EVT_SETTINGS_R);
> +	WATCHDOG_RESET();
> +#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
>  	/*
>  	 * Do pci configuration
>  	 */
> -	pci_init,
> +	INITCALL(pci_init);
>  #endif
> -	stdio_add_devices,
> -	jumptable_init,
> -#ifdef CONFIG_API
> -	api_init,
> +	INITCALL(stdio_add_devices);
> +	INITCALL(jumptable_init);
> +#if CONFIG_IS_ENABLED(API)
> +	INITCALL(api_init);
>  #endif
> -	console_init_r,		/* fully init console as a device */
> -#ifdef CONFIG_DISPLAY_BOARDINFO_LATE
> -	console_announce_r,
> -	show_board_info,
> +	INITCALL(console_init_r);	/* fully init console as a device */
> +#if CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE)
> +	INITCALL(console_announce_r);
> +	INITCALL(show_board_info);
>  #endif
> -#ifdef CONFIG_ARCH_MISC_INIT
> -	arch_misc_init,		/* miscellaneous arch-dependent init */
> +	/* miscellaneous arch-dependent init */
> +#if CONFIG_IS_ENABLED(ARCH_MISC_INIT)
> +	INITCALL(arch_misc_init);
>  #endif
> -#ifdef CONFIG_MISC_INIT_R
> -	misc_init_r,		/* miscellaneous platform-dependent init */
> +	/* miscellaneous platform-dependent init */
> +#if CONFIG_IS_ENABLED(MISC_INIT_R)
> +	INITCALL(misc_init_r);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -#ifdef CONFIG_CMD_KGDB
> -	kgdb_init,
> +	WATCHDOG_RESET();
> +#if CONFIG_IS_ENABLED(CMD_KGDB)
> +	INITCALL(kgdb_init);
>  #endif
> -	interrupt_init,
> +	INITCALL(interrupt_init);
>  #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
> -	timer_init,		/* initialize timer */
> +	INITCALL(timer_init);		/* initialize timer */
>  #endif
> -	initr_status_led,
> -	initr_boot_led_blink,
> +	INITCALL(initr_status_led);
> +	INITCALL(initr_boot_led_blink);
>  	/* PPC has a udelay(20) here dating from 2002. Why? */
> -#ifdef CONFIG_BOARD_LATE_INIT
> -	board_late_init,
> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
> +	INITCALL(board_late_init);
>  #endif
> -#ifdef CONFIG_BITBANGMII
> -	bb_miiphy_init,
> +#if CONFIG_IS_ENABLED(BITBANGMII)
> +	INITCALL(bb_miiphy_init);
>  #endif
> -#ifdef CONFIG_PCI_ENDPOINT
> -	pci_ep_init,
> +#if CONFIG_IS_ENABLED(PCI_ENDPOINT)
> +	INITCALL(pci_ep_init);
>  #endif
> -#if defined(CONFIG_CMD_NET)
> -	INIT_FUNC_WATCHDOG_RESET
> -	initr_net,
> +#if CONFIG_IS_ENABLED(CMD_NET)
> +	WATCHDOG_RESET();
> +	INITCALL(initr_net);
>  #endif
> -#ifdef CONFIG_POST
> -	initr_post,
> +#if CONFIG_IS_ENABLED(POST)
> +	INITCALL(initr_post);
>  #endif
> -	INIT_FUNC_WATCHDOG_RESET
> -	INITCALL_EVENT(EVT_LAST_STAGE_INIT),
> +	WATCHDOG_RESET();
> +	INITCALL_EVT(EVT_LAST_STAGE_INIT);
>  #if defined(CFG_PRAM)
> -	initr_mem,
> +	INITCALL(initr_mem);
>  #endif
> -	initr_boot_led_on,
> -	run_main_loop,
> -};
> +	INITCALL(initr_boot_led_on);
> +	INITCALL(run_main_loop);
> +}
>  
>  void board_init_r(gd_t *new_gd, ulong dest_addr)
>  {
> @@ -796,8 +802,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
>  #endif
>  	gd->flags &= ~GD_FLG_LOG_READY;
>  
> -	if (initcall_run_list(init_sequence_r))
> -		hang();
> +	initcall_run_r();
>  
>  	/* NOTREACHED - run_main_loop() does not return */
>  	hang();
> diff --git a/include/initcall.h b/include/initcall.h
> index 62d3bb67f08..8e22526dd9e 100644
> --- a/include/initcall.h
> +++ b/include/initcall.h
> @@ -8,6 +8,7 @@
>  
>  #include <asm/types.h>
>  #include <event.h>
> +#include <hang.h>
>  
>  _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>  
> @@ -35,4 +36,30 @@ typedef int (*init_fnc_t)(void);
>   */
>  int initcall_run_list(const init_fnc_t init_sequence[]);
>  
> +#define INITCALL(_call) \
> +	do { \
> +		if (_call()) { \
> +			printf("%s(): initcall %s() failed\n", __func__, \
> +			       #_call); \
> +			hang(); \
> +		} \
> +	} while (0)
> +
> +#define INITCALL_EVT(_evt) \
> +	do { \
> +		if (event_notify_null(_evt)) { \
> +			printf("%s(): event %d/%s failed\n", __func__, _evt, \
> +			       event_type_name(_evt)) ; \
> +			hang(); \
> +		} \
> +	} while (0)
> +
> +#if defined(CONFIG_WATCHDOG) || defined(CONFIG_HW_WATCHDOG)
> +#define WATCHDOG_INIT() INITCALL(init_func_watchdog_init)
> +#define WATCHDOG_RESET() INITCALL(init_func_watchdog_reset)
> +#else
> +#define WATCHDOG_INIT()
> +#define WATCHDOG_RESET()
> +#endif
> +
>  #endif

-- 
// Caleb (they/them)

