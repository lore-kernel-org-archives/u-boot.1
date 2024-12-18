Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B09E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3F280274;
	Wed, 18 Dec 2024 19:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2HRaZpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7386680283; Wed, 18 Dec 2024 19:22:02 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102CD80269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 19:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so4354874a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546119; x=1735150919; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4MvtRymrnnySKy1uKgPRbsoCRs8oH65n7K3gFvjulis=;
 b=n2HRaZpP4XFPPBuUdH+ZL06gXG14kStaHQ6gZRdH+Qeweng6pip7u3HhySgUSDOQt2
 V3OJUix8dIHuM8monaEdHFwV0N5PfI8gJesHCIcZkiBlA50acCaKkv6vLcqRsjXX1rcy
 LyDVxgsnnihANtBITLK4etGQb9yDZHnTDLrDloa2/+iHzr+srPxfbnMr9tNkfmEWrZxZ
 AR498khFVHlSDCkdLT1pkhXr8iZFHoibwu4eu//rTsvYfXxugDWdcGqboaYERmJKMwaP
 1MjeKqd6ZFzdQDRAXDHhe4FEHI0uUiNdRVi+6l7OI6tBkccW2DbjFBGJJn9T+JrGXwEz
 nUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546119; x=1735150919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4MvtRymrnnySKy1uKgPRbsoCRs8oH65n7K3gFvjulis=;
 b=Or/czYhRrohsBFL/ma0eRo46Q2GuA8RxkKrYSYiSJDcXkcbKXpyGekup7OJlqIepK1
 Azk/n22sgBqaxrZ7hDPHuuvQ46iLqECVlzTZ29zIy28O8KCmAr6i/WKg4MAgDwm86Waq
 M7XUN7zu2Z3IOXG/e66wLG6dU5Hfpqin+XcF/92Jdv9f2OoTOxoVmRQovNDQ/iUprm00
 3yMpXxeaB15cPI75ArK8e0iwqjOvWMeZ/XRifpZXQYCF+irkFqiOhlegn+ijTUwU8U+T
 /cObY67DH5hqguM3X0WkBJkI1Y9a3VZg95/IcrWPy0kB2o1hp2d0QUI8J+K+O+/Bk89t
 B4kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVho4AIv08MRTC8+37YJqTqwIYfNORK766a0bHYHd5eaYq6yH8ys3Yi4UNKHu+jU99gjjPLKhc=@lists.denx.de
X-Gm-Message-State: AOJu0YzSX+CiisNGzGXRWb0f+u1DjzBqDyY4p7J0xFXny+NqK/SecdBg
 xQsDOKy4VtMu3/MmeHQW+5GYma1Y28zorXER3TdLSrg2NxJrTKMHUnyEEHbcqGE=
X-Gm-Gg: ASbGncsxYp1FBh1vbZkEhD/f+m+r1+b+E9W5ijUWNsE1GBaPzcLC2h9IvcZHxVJ0Gm3
 gaVW8GSfnMrxnBSa6vECBMqkRzrrUWs8ZVbLhvteY+hkgrpycyU7AcbFbGb9N++2wsQmDSHrF3G
 1ijr3spSNgyrMKyp6UaxQOPfVLwSDOv8OP+syQV+1kLzrFNGCrCVX6fT5CZLIuUc1xOxqM4rfZe
 NXRH04Vd7Le/8Au1nPzDfwmzu5Z61TIzypNACRSmJUUcGGcCH1UcheWkfYsck0Pbk3txJiyfxDx
 CVDxlS8X6fWl+H1cIDur+A34S5TTJutT2Z2F
X-Google-Smtp-Source: AGHT+IGi9KWzEzhQVNx7zCxth+cC9fkJYoy/k/F1civWj4ExEzyT8W3uylCG/zYb2C7YU+jcDAt3Kg==
X-Received: by 2002:a17:907:3f9d:b0:aab:73c5:838 with SMTP id
 a640c23a62f3a-aabf478729dmr328686366b.29.1734546119338; 
 Wed, 18 Dec 2024 10:21:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9?
 ([2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96359ca3sm576658166b.118.2024.12.18.10.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 10:21:59 -0800 (PST)
Message-ID: <f927541e-6e7c-4f51-bf61-2ebf395d7827@linaro.org>
Date: Wed, 18 Dec 2024 19:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] board_init_f(): use static calls
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Devarsh Thakkar <devarsht@ti.com>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
 <fd8470e7-4527-4024-8477-63248a7cc6de@cherry.de>
 <bbcffca1-39d2-4f10-ac7a-fa15c2ca7522@linaro.org>
 <23608512-7271-407c-bc5d-a21231667ab4@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <23608512-7271-407c-bc5d-a21231667ab4@cherry.de>
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



On 12/18/24 18:47, Quentin Schulz wrote:
> Hi Jerome,
> 
> On 12/18/24 6:38 PM, Jerome Forissier wrote:
>> Hi Quentin,
>>
>> On 12/18/24 18:27, Quentin Schulz wrote:
>>> Hi Jerome,
>>>
>>> On 12/18/24 4:53 PM, Jerome Forissier wrote:
>>>> Make static calls instead of iterating over the init_sequence_f arrays.
>>>> Tested on a KV260 board (xilinx_zynqmp_kria_defconfig).
>>>>
>>>> - With LTO enabled, the code size reported by bloat-o-meter is 1200
>>>>     bytes less (-0.11%)
>>>> - With LTO disabled, the code is 594 bytes smaller (-0.05%)
>>>> - Execution time does not change in a noticeable way
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>    common/board_f.c   | 165 +++++++++++++++++++++++----------------------
>>>>    include/initcall.h |  27 ++++++++
>>>>    2 files changed, 110 insertions(+), 82 deletions(-)
>>>>
>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>> index a4d8850cb7d..cebed85ed4d 100644
>>>> --- a/common/board_f.c
>>>> +++ b/common/board_f.c
>>>> @@ -38,6 +38,7 @@
>>>>    #include <spl.h>
>>>>    #include <status_led.h>
>>>>    #include <sysreset.h>
>>>> +#include <time.h>
>>>>    #include <timer.h>
>>>>    #include <trace.h>
>>>>    #include <upl.h>
>>>> @@ -870,58 +871,60 @@ static int initf_upl(void)
>>>>        return 0;
>>>>    }
>>>>    -static const init_fnc_t init_sequence_f[] = {
>>>> -    setup_mon_len,
>>>> -    CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
>>>> -    CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
>>>> -    initf_malloc,
>>>> -    initf_upl,
>>>> -    log_init,
>>>> -    initf_bootstage,    /* uses its own timer, so does not need DM */
>>>> -    event_init,
>>>> -    bloblist_maybe_init,
>>>> -    setup_spl_handoff,
>>>> -    CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
>>>> -    INITCALL_EVENT(EVT_FSP_INIT_F),
>>>> -    arch_cpu_init,        /* basic arch cpu dependent setup */
>>>> -    mach_cpu_init,        /* SoC/machine dependent CPU setup */
>>>> -    initf_dm,
>>>> -    CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
>>>> +static void initcall_run_f(void)
>>>> +{
>>>> +    INITCALL(setup_mon_len);
>>>> +    CONFIG_IS_ENABLED(OF_CONTROL, (INITCALL(fdtdec_setup)));
>>>> +    CONFIG_IS_ENABLED(TRACE_EARLY, (INITCALL(trace_early_init)));
>>>> +    INITCALL(initf_malloc);
>>>> +    INITCALL(initf_upl);
>>>> +    INITCALL(log_init);
>>>> +    INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
>>>> +    INITCALL(event_init);
>>>> +    INITCALL(bloblist_maybe_init);
>>>> +    INITCALL(setup_spl_handoff);
>>>> +    CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F,
>>>> +              (INITCALL(console_record_init);))
>>>> +    INITCALL_EVT(EVT_FSP_INIT_F);
>>>> +    INITCALL(arch_cpu_init);    /* basic arch cpu dependent setup */
>>>> +    INITCALL(mach_cpu_init);    /* SoC/machine dependent CPU setup */
>>>> +    INITCALL(initf_dm);
>>>> +    CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (INITCALL(board_early_init_f);))
>>>>    #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
>>>>        /* get CPU and bus clocks according to the environment variable */
>>>> -    get_clocks,        /* get CPU and bus clocks (etc.) */
>>>> +    INITCALL(get_clocks);        /* get CPU and bus clocks (etc.) */
>>>>    #endif
>>>>    #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
>>>> -    timer_init,        /* initialize timer */
>>>> +    INITCALL(timer_init);        /* initialize timer */
>>>>    #endif
>>>> -    CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
>>>> -    env_init,        /* initialize environment */
>>>> -    init_baud_rate,        /* initialze baudrate settings */
>>>> -    serial_init,        /* serial communications setup */
>>>> -    console_init_f,        /* stage 1 init of console */
>>>> -    display_options,    /* say that we are here */
>>>> -    display_text_info,    /* show debugging info if required */
>>>> -    checkcpu,
>>>> -    CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
>>>> +    CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT,
>>>> +              (INITCALL(board_postclk_init);))
>>>> +    INITCALL(env_init);        /* initialize environment */
>>>> +    INITCALL(init_baud_rate);    /* initialze baudrate settings */
>>>> +    INITCALL(serial_init);        /* serial communications setup */
>>>> +    INITCALL(console_init_f);    /* stage 1 init of console */
>>>> +    INITCALL(display_options);    /* say that we are here */
>>>> +    INITCALL(display_text_info);    /* show debugging info if required */
>>>> +    INITCALL(checkcpu);
>>>> +    CONFIG_IS_ENABLED(SYSRESET, (INITCALL(print_resetinfo);))
>>>>        /* display cpu info (and speed) */
>>>> -    CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
>>>> -    CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
>>>> -    CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
>>>> -    INIT_FUNC_WATCHDOG_INIT
>>>> -    INITCALL_EVENT(EVT_MISC_INIT_F),
>>>> -    INIT_FUNC_WATCHDOG_RESET
>>>> -    CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
>>>> -    announce_dram_init,
>>>> -    dram_init,        /* configure available RAM banks */
>>>> -    CONFIG_IS_ENABLED(POST, (post_init_f,))
>>>> -    INIT_FUNC_WATCHDOG_RESET
>>>> +    CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (INITCALL(print_cpuinfo);))
>>>> +    CONFIG_IS_ENABLED(DTB_RESELECT, (INITCALL(embedded_dtb_select);))
>>>> +    CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (INITCALL(show_board_info);))
>>>> +    WATCHDOG_INIT();
>>>> +    INITCALL_EVT(EVT_MISC_INIT_F);
>>>> +    WATCHDOG_RESET();
>>>> +    CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (INITCALL(init_func_i2c);))
>>>> +    INITCALL(announce_dram_init);
>>>> +    INITCALL(dram_init);        /* configure available RAM banks */
>>>> +    CONFIG_IS_ENABLED(POST, (INITCALL(post_init_f);))
>>>> +    WATCHDOG_INIT();
>>>>    #if defined(CFG_SYS_DRAM_TEST)
>>>> -    testdram,
>>>> +    INITCALL(testdram);
>>>>    #endif /* CFG_SYS_DRAM_TEST */
>>>> -    INIT_FUNC_WATCHDOG_RESET
>>>> -
>>>> -    CONFIG_IS_ENABLED(POST, (init_post,))
>>>> -    INIT_FUNC_WATCHDOG_RESET
>>>> +    WATCHDOG_RESET();
>>>> +    CONFIG_IS_ENABLED(POST, (INITCALL(init_post);))
>>>> +    WATCHDOG_RESET();
>>>>        /*
>>>>         * Now that we have DRAM mapped and working, we can
>>>>         * relocate the code and continue running from DRAM.
>>>> @@ -934,48 +937,48 @@ static const init_fnc_t init_sequence_f[] = {
>>>>         *  - monitor code
>>>>         *  - board info struct
>>>>         */
>>>> -    setup_dest_addr,
>>>> +    INITCALL(setup_dest_addr);
>>>>    #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
>>>> -    fix_fdt,
>>>> +    INITCALL(fix_fdt);
>>>>    #endif
>>>>    #ifdef CFG_PRAM
>>>> -    reserve_pram,
>>>> +    INITCALL(reserve_pram);
>>>>    #endif
>>>> -    reserve_round_4k,
>>>> -    setup_relocaddr_from_bloblist,
>>>> -    arch_reserve_mmu,
>>>> -    reserve_video,
>>>> -    reserve_trace,
>>>> -    reserve_uboot,
>>>> -    reserve_malloc,
>>>> -    reserve_board,
>>>> -    reserve_global_data,
>>>> -    reserve_fdt,
>>>> +    INITCALL(reserve_round_4k);
>>>> +    INITCALL(setup_relocaddr_from_bloblist);
>>>> +    INITCALL(arch_reserve_mmu);
>>>> +    INITCALL(reserve_video);
>>>> +    INITCALL(reserve_trace);
>>>> +    INITCALL(reserve_uboot);
>>>> +    INITCALL(reserve_malloc);
>>>> +    INITCALL(reserve_board);
>>>> +    INITCALL(reserve_global_data);
>>>> +    INITCALL(reserve_fdt);
>>>>    #if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
>>>> -    reloc_fdt,
>>>> -    fix_fdt,
>>>> +    INITCALL(reloc_fdt);
>>>> +    INITCALL(fix_fdt);
>>>>    #endif
>>>> -    reserve_bootstage,
>>>> -    reserve_bloblist,
>>>> -    reserve_arch,
>>>> -    reserve_stacks,
>>>> -    dram_init_banksize,
>>>> -    show_dram_config,
>>>> -    INIT_FUNC_WATCHDOG_RESET
>>>> -    setup_bdinfo,
>>>> -    display_new_sp,
>>>> -    INIT_FUNC_WATCHDOG_RESET
>>>> +    INITCALL(reserve_bootstage);
>>>> +    INITCALL(reserve_bloblist);
>>>> +    INITCALL(reserve_arch);
>>>> +    INITCALL(reserve_stacks);
>>>> +    INITCALL(dram_init_banksize);
>>>> +    INITCALL(show_dram_config);
>>>> +    WATCHDOG_RESET();
>>>> +    INITCALL(setup_bdinfo);
>>>> +    INITCALL(display_new_sp);
>>>> +    WATCHDOG_RESET();
>>>>    #if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
>>>> -    reloc_fdt,
>>>> +    INITCALL(reloc_fdt);
>>>>    #endif
>>>> -    reloc_bootstage,
>>>> -    reloc_bloblist,
>>>> -    setup_reloc,
>>>> +    INITCALL(reloc_bootstage);
>>>> +    INITCALL(reloc_bloblist);
>>>> +    INITCALL(setup_reloc);
>>>>    #if defined(CONFIG_X86) || defined(CONFIG_ARC)
>>>> -    copy_uboot_to_ram,
>>>> -    do_elf_reloc_fixups,
>>>> +    INITCALL(copy_uboot_to_ram);
>>>> +    INITCALL(do_elf_reloc_fixups);
>>>>    #endif
>>>> -    clear_bss,
>>>> +    INITCALL(clear_bss);
>>>>        /*
>>>>         * Deregister all cyclic functions before relocation, so that
>>>>         * gd->cyclic_list does not contain any references to pre-relocation
>>>> @@ -985,12 +988,11 @@ static const init_fnc_t init_sequence_f[] = {
>>>>         * This should happen as late as possible so that the window where a
>>>>         * watchdog device is not serviced is as small as possible.
>>>>         */
>>>> -    cyclic_unregister_all,
>>>> +    INITCALL(cyclic_unregister_all);
>>>>    #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
>>>> -    jump_to_copy,
>>>> +    INITCALL(jump_to_copy);
>>>>    #endif
>>>> -    NULL,
>>>> -};
>>>> +}
>>>>      void board_init_f(ulong boot_flags)
>>>>    {
>>>> @@ -1000,8 +1002,7 @@ void board_init_f(ulong boot_flags)
>>>>        gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>>>>        gd->boardf = &boardf;
>>>>    -    if (initcall_run_list(init_sequence_f))
>>>> -        hang();
>>>> +    initcall_run_f();
>>>>      #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>>>>            !defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
>>>> diff --git a/include/initcall.h b/include/initcall.h
>>>> index 62d3bb67f08..9398a3ec7d5 100644
>>>> --- a/include/initcall.h
>>>> +++ b/include/initcall.h
>>>> @@ -8,6 +8,7 @@
>>>>      #include <asm/types.h>
>>>>    #include <event.h>
>>>> +#include <hang.h>
>>>>      _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>>>>    @@ -35,4 +36,30 @@ typedef int (*init_fnc_t)(void);
>>>>     */
>>>>    int initcall_run_list(const init_fnc_t init_sequence[]);
>>>>    +#define INITCALL(_call) \
>>>> +    do { \
>>>> +        if (_call()) { \
>>>> +            debug("%s(): calling %s() failed\n", __func__, \
>>>> +                  #_call); \
>>>> +            hang(); \
>>>> +        } \
>>>> +    } while (0)
>>>> +
>>>> +#define INITCALL_EVT(_evt) \
>>>> +    do { \
>>>> +        if (event_notify_null(_evt)) { \
>>>> +            debug("%s(): event %d/%s failed\n", __func__, _evt, \
>>>> +                  event_type_name(_evt)) ; \
>>>> +            hang(); \
>>>> +        } \
>>>> +    } while (0)
>>>> +
>>>
>>> initcall_run_list() currently prints (printf) whenever an initcall fails. It's happened to me a lot already while debugging/bringing up boards to have an initcall fail on me and that message wasn't really enough to put me on the right track, but at least I had something. Now I believe this would just hang without notifying you before. Is my understanding correct?
>>
>> The debug print is still there, the line just before hang() ;-)
>>
> 
> It's now a debug() instead of a printf() is what I meant. So it's not shown by default anymore I believe, unless we have #define DEBUG in the file?

Oh, right. There was a debug() before the initcall and a printf() in
case of error. Sorry for overlooking this. I will change the debug() to
a printf().

Thanks,
-- 
Jerome

> 
> Cheers,
> Quentin
