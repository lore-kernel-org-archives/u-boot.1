Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ADCE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334C980269;
	Wed, 18 Dec 2024 15:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OuGbksfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D735980274; Wed, 18 Dec 2024 15:02:55 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E4878022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso43743215e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734530573; x=1735135373; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krTvidh0XnxXVw0Oa/XQBnwcaJqzuaTIs9b1kIfmlhM=;
 b=OuGbksfuXZ+WGi7oxrBhA8Z/ZHqZcn/s+WbccMlgTlFnpIG5Cz6kvHEXk5rQdHoqH6
 xtFcGhyRBOx06mXbhgGHWjPQyOqRZ9brDa4JNBFf7TIPw96I/4c97Yt9t+k0r652BUVV
 Wgkr0DP2RPLCpw3RuX0ToViHSsy7YrDCwcIm55OYYZa23/NC5ftaF1lPXOPV8ND00Vr0
 FXRoBsNPP82fwKa7Rq4JDXvCVCRxkfmxe9PYkmetuZWsgKToSmbxfNn86fuG/+7cj96q
 wqRTqiETcuhzo2hTGm0+RVI2zYvGXArl97GLfu5GJmJhtl83H1q85VLh77P6b8irlo9R
 0I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734530573; x=1735135373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krTvidh0XnxXVw0Oa/XQBnwcaJqzuaTIs9b1kIfmlhM=;
 b=rxhhczzwbQc+rYWfq1dyLqffZFyw9uG8qsLn+ugiT5KL7WDQSalNhKGeDjkw18m42i
 WtQ+RUSlVn6NAnkEYgFL+nE2FpNpRZrmy/4dSYlmtWfYH0MtlLxStZiFJj/EB/KEodUk
 2ybn7gMzsu+HqA9b2fZQ6grcpZkMdY2Kv1qHF2RhXrlK9Y03qee8e9y+C/v33dP1Sq/F
 04BtYWqtJrnUmGcWNu6vpDS8VXBmFN+efLOo3TY48OixK2CbWapkz+YAk0Fg3oEJIdRb
 oymDdKZ9Tmu0B/UvB+R1BpqEjARgVj7I8dC4E9cIxDeHIam8FuPHj4MSMXAgGEnxOW5N
 sPdQ==
X-Gm-Message-State: AOJu0YxxH99/dV0icAoZy2s12LrgE4vD1Fpl1W6Yj8A7x/67OqYCwRRU
 dFpWqharqclmONkjQJ6gmM9nwY3E+ru/uFAyOXl0B+h4yAUV/CsZEnzSFPZKM0M=
X-Gm-Gg: ASbGncv6R8HQ3zTRZI30qyIu4BEn2m3TM3cptre7sXQHAqGlZ0SCZRYqg2pcWMCdsyq
 0AmiqN3nXEL5yjWJk10CA6GNpbNP7N2i2TqWIiCMCyRqC55nFFjmuPR6aNUo37e/h17Wh1mJjiX
 8i7GiQAuvbYMGVHXV4TbcsFF2fKktLVVZDIAysJBbUtC4Owlk6ZgGh6FDYflA4uCVQ+zvbhsVu+
 O3D9iNO72vt/+/BY/zIOsx871eINzR6QJD+drf2vnZUdnhlL7Pnqkd609TqXgrZuiZF5MC6mbu6
 0BWT2jn+B8mZpcNgWnHU4ilXbipzSrSO02DS
X-Google-Smtp-Source: AGHT+IFFP0zhP9A3wB2XCoiTwUsvcYq2dJRY6O5G4MgVCHPfNjB5ycASa/S0ll6ywHcYLuOZ9LG8Lg==
X-Received: by 2002:a05:600c:4588:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-4365535f550mr24671035e9.8.1734530572639; 
 Wed, 18 Dec 2024 06:02:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9?
 ([2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b202f7sm21309365e9.41.2024.12.18.06.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 06:02:52 -0800 (PST)
Message-ID: <1b942f98-c149-4a91-8b7f-d6e669019fd6@linaro.org>
Date: Wed, 18 Dec 2024 15:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] board_init_f(): use static calls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
References: <cover.1734448827.git.jerome.forissier@linaro.org>
 <3fff1720f52db5929f46666536a7ffb73eaf45b4.1734448827.git.jerome.forissier@linaro.org>
 <CAC_iWjKeBe68FNMrPPPXAq+0jHgmn77SVo4gWw4B=LC6pVxhGw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjKeBe68FNMrPPPXAq+0jHgmn77SVo4gWw4B=LC6pVxhGw@mail.gmail.com>
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



On 12/18/24 13:38, Ilias Apalodimas wrote:
> Hi Jerome
> 
> On Tue, 17 Dec 2024 at 18:00, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Make static calls instead of iterating over the init_sequence_f arrays.
>> Tested on a KV260 board (xilinx_zynqmp_kria_defconfig).
>>
>> - With LTO enabled, the code size reported by bloat-o-meter is 1184
>>   bytes less (-0.11%)
>> - With LTO disabled, the code is 592 bytes smaller (-0.05%)
>> - Execution time does not change in a noticeable way
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  common/board_f.c   | 167 +++++++++++++++++++++++----------------------
>>  include/initcall.h |  25 +++++++
>>  2 files changed, 111 insertions(+), 81 deletions(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index a4d8850cb7d..ba1af3d8055 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -38,6 +38,7 @@
>>  #include <spl.h>
>>  #include <status_led.h>
>>  #include <sysreset.h>
>> +#include <time.h>
>>  #include <timer.h>
>>  #include <trace.h>
>>  #include <upl.h>
>> @@ -870,58 +871,62 @@ static int initf_upl(void)
>>         return 0;
>>  }
>>
>> -static const init_fnc_t init_sequence_f[] = {
>> -       setup_mon_len,
>> -       CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
>> -       CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
>> -       initf_malloc,
>> -       initf_upl,
>> -       log_init,
>> -       initf_bootstage,        /* uses its own timer, so does not need DM */
>> -       event_init,
>> -       bloblist_maybe_init,
>> -       setup_spl_handoff,
>> -       CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
>> -       INITCALL_EVENT(EVT_FSP_INIT_F),
>> -       arch_cpu_init,          /* basic arch cpu dependent setup */
>> -       mach_cpu_init,          /* SoC/machine dependent CPU setup */
>> -       initf_dm,
>> -       CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
>> +static int initcall_run_f(void)
>> +{
>> +       int ret = 0;
>> +
>> +       INITCALL(setup_mon_len);
>> +       CONFIG_IS_ENABLED(OF_CONTROL, (INITCALL(fdtdec_setup)));
>> +       CONFIG_IS_ENABLED(TRACE_EARLY, (INITCALL(trace_early_init)));
>> +       INITCALL(initf_malloc);
>> +       INITCALL(initf_upl);
>> +       INITCALL(log_init);
>> +       INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
>> +       INITCALL(event_init);
>> +       INITCALL(bloblist_maybe_init);
>> +       INITCALL(setup_spl_handoff);
>> +       CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F,
>> +                         (INITCALL(console_record_init);))
>> +       INITCALL_EVT(EVT_FSP_INIT_F);
>> +       INITCALL(arch_cpu_init);        /* basic arch cpu dependent setup */
>> +       INITCALL(mach_cpu_init);        /* SoC/machine dependent CPU setup */
>> +       INITCALL(initf_dm);
>> +       CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (INITCALL(board_early_init_f);))
>>  #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
>>         /* get CPU and bus clocks according to the environment variable */
>> -       get_clocks,             /* get CPU and bus clocks (etc.) */
>> +       INITCALL(get_clocks);           /* get CPU and bus clocks (etc.) */
>>  #endif
>>  #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
>> -       timer_init,             /* initialize timer */
>> +       INITCALL(timer_init);           /* initialize timer */
>>  #endif
>> -       CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
>> -       env_init,               /* initialize environment */
>> -       init_baud_rate,         /* initialze baudrate settings */
>> -       serial_init,            /* serial communications setup */
>> -       console_init_f,         /* stage 1 init of console */
>> -       display_options,        /* say that we are here */
>> -       display_text_info,      /* show debugging info if required */
>> -       checkcpu,
>> -       CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
>> +       CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT,
>> +                         (INITCALL(board_postclk_init);))
>> +       INITCALL(env_init);             /* initialize environment */
>> +       INITCALL(init_baud_rate);       /* initialze baudrate settings */
>> +       INITCALL(serial_init);          /* serial communications setup */
>> +       INITCALL(console_init_f);       /* stage 1 init of console */
>> +       INITCALL(display_options);      /* say that we are here */
>> +       INITCALL(display_text_info);    /* show debugging info if required */
>> +       INITCALL(checkcpu);
>> +       CONFIG_IS_ENABLED(SYSRESET, (INITCALL(print_resetinfo);))
>>         /* display cpu info (and speed) */
>> -       CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
>> -       CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
>> -       CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
>> -       INIT_FUNC_WATCHDOG_INIT
>> -       INITCALL_EVENT(EVT_MISC_INIT_F),
>> -       INIT_FUNC_WATCHDOG_RESET
>> -       CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
>> -       announce_dram_init,
>> -       dram_init,              /* configure available RAM banks */
>> -       CONFIG_IS_ENABLED(POST, (post_init_f,))
>> -       INIT_FUNC_WATCHDOG_RESET
>> +       CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (INITCALL(print_cpuinfo);))
>> +       CONFIG_IS_ENABLED(DTB_RESELECT, (INITCALL(embedded_dtb_select);))
>> +       CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (INITCALL(show_board_info);))
>> +       WATCHDOG_INIT();
>> +       INITCALL_EVT(EVT_MISC_INIT_F);
>> +       WATCHDOG_RESET();
>> +       CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (INITCALL(init_func_i2c);))
>> +       INITCALL(announce_dram_init);
>> +       INITCALL(dram_init);            /* configure available RAM banks */
>> +       CONFIG_IS_ENABLED(POST, (INITCALL(post_init_f);))
>> +       WATCHDOG_INIT();
>>  #if defined(CFG_SYS_DRAM_TEST)
>> -       testdram,
>> +       INITCALL(testdram);
>>  #endif /* CFG_SYS_DRAM_TEST */
>> -       INIT_FUNC_WATCHDOG_RESET
>> -
>> -       CONFIG_IS_ENABLED(POST, (init_post,))
>> -       INIT_FUNC_WATCHDOG_RESET
>> +       WATCHDOG_RESET();
>> +       CONFIG_IS_ENABLED(POST, (INITCALL(init_post);))
>> +       WATCHDOG_RESET();
>>         /*
>>          * Now that we have DRAM mapped and working, we can
>>          * relocate the code and continue running from DRAM.
>> @@ -934,48 +939,48 @@ static const init_fnc_t init_sequence_f[] = {
>>          *  - monitor code
>>          *  - board info struct
>>          */
>> -       setup_dest_addr,
>> +       INITCALL(setup_dest_addr);
>>  #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
>> -       fix_fdt,
>> +       INITCALL(fix_fdt);
>>  #endif
>>  #ifdef CFG_PRAM
>> -       reserve_pram,
>> +       INITCALL(reserve_pram);
>>  #endif
>> -       reserve_round_4k,
>> -       setup_relocaddr_from_bloblist,
>> -       arch_reserve_mmu,
>> -       reserve_video,
>> -       reserve_trace,
>> -       reserve_uboot,
>> -       reserve_malloc,
>> -       reserve_board,
>> -       reserve_global_data,
>> -       reserve_fdt,
>> +       INITCALL(reserve_round_4k);
>> +       INITCALL(setup_relocaddr_from_bloblist);
>> +       INITCALL(arch_reserve_mmu);
>> +       INITCALL(reserve_video);
>> +       INITCALL(reserve_trace);
>> +       INITCALL(reserve_uboot);
>> +       INITCALL(reserve_malloc);
>> +       INITCALL(reserve_board);
>> +       INITCALL(reserve_global_data);
>> +       INITCALL(reserve_fdt);
>>  #if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
>> -       reloc_fdt,
>> -       fix_fdt,
>> +       INITCALL(reloc_fdt);
>> +       INITCALL(fix_fdt);
>>  #endif
>> -       reserve_bootstage,
>> -       reserve_bloblist,
>> -       reserve_arch,
>> -       reserve_stacks,
>> -       dram_init_banksize,
>> -       show_dram_config,
>> -       INIT_FUNC_WATCHDOG_RESET
>> -       setup_bdinfo,
>> -       display_new_sp,
>> -       INIT_FUNC_WATCHDOG_RESET
>> +       INITCALL(reserve_bootstage);
>> +       INITCALL(reserve_bloblist);
>> +       INITCALL(reserve_arch);
>> +       INITCALL(reserve_stacks);
>> +       INITCALL(dram_init_banksize);
>> +       INITCALL(show_dram_config);
>> +       WATCHDOG_RESET();
>> +       INITCALL(setup_bdinfo);
>> +       INITCALL(display_new_sp);
>> +       WATCHDOG_RESET();
>>  #if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
>> -       reloc_fdt,
>> +       INITCALL(reloc_fdt);
>>  #endif
>> -       reloc_bootstage,
>> -       reloc_bloblist,
>> -       setup_reloc,
>> +       INITCALL(reloc_bootstage);
>> +       INITCALL(reloc_bloblist);
>> +       INITCALL(setup_reloc);
>>  #if defined(CONFIG_X86) || defined(CONFIG_ARC)
>> -       copy_uboot_to_ram,
>> -       do_elf_reloc_fixups,
>> +       INITCALL(copy_uboot_to_ram);
>> +       INITCALL(do_elf_reloc_fixups);
>>  #endif
>> -       clear_bss,
>> +       INITCALL(clear_bss);
>>         /*
>>          * Deregister all cyclic functions before relocation, so that
>>          * gd->cyclic_list does not contain any references to pre-relocation
>> @@ -985,12 +990,12 @@ static const init_fnc_t init_sequence_f[] = {
>>          * This should happen as late as possible so that the window where a
>>          * watchdog device is not serviced is as small as possible.
>>          */
>> -       cyclic_unregister_all,
>> +       INITCALL(cyclic_unregister_all);
>>  #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
>> -       jump_to_copy,
>> +       INITCALL(jump_to_copy);
>>  #endif
>> -       NULL,
>> -};
>> +       return ret;
>> +}
>>
>>  void board_init_f(ulong boot_flags)
>>  {
>> @@ -1000,7 +1005,7 @@ void board_init_f(ulong boot_flags)
>>         gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>>         gd->boardf = &boardf;
>>
>> -       if (initcall_run_list(init_sequence_f))
>> +       if (initcall_run_f())
>>                 hang();
>>
>>  #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>> diff --git a/include/initcall.h b/include/initcall.h
>> index 62d3bb67f08..72faab42ada 100644
>> --- a/include/initcall.h
>> +++ b/include/initcall.h
>> @@ -35,4 +35,29 @@ typedef int (*init_fnc_t)(void);
>>   */
>>  int initcall_run_list(const init_fnc_t init_sequence[]);
>>
>> +#define INITCALL(_call) \
>> +       do { \
>> +               if (!ret) { \
>> +                       debug("%s(): calling %s()\n", __func__, #_call); \
>> +                       ret = _call(); \
>> +               } \
>> +       } while (0)
>> +
>> +#define INITCALL_EVT(_evt) \
>> +       do { \
>> +               if (!ret) { \
>> +                       debug("%s(): event %d/%s\n", __func__, _evt, \
>> +                             event_type_name(_evt)) ; \
>> +                       ret = event_notify_null(_evt); \
>> +               } \
>> +       } while (0)
>> +
> 
> I think you want to run the function and return the error code here?

No, we want to run the function only if the previous one has not failed
(in other words, stop running the initcalls as soon as one fails).
The macro acts on the caller's 'ret' variable, which is not good
practice, I know.

> 
> Something like
> #define INITCALL(_call) \
>     do { \
>         int _ret; _ret = _call(); \
>         if (!ret) \
>                debug("%s(): calling %s() failed\n", __func__, #_call); \
>         _ret; \
> } while (0)

In fact, since the caller of initcall_run_f() will call hang() on error
we may as well do it sooner:

#define INITCALL(_call) \
	do { \
		if (_call()) { \
			debug("%s(): calling %s() failed\n", __func__, \
			      #_call); \
			hang(); \
		} \
        } while(0)

I'll post a v2. Thanks for reviewing.

-- 
Jerome

> 
> Cheers
> /Ilias
> 
>> +#if defined(CONFIG_WATCHDOG) || defined(CONFIG_HW_WATCHDOG)
>> +#define WATCHDOG_INIT() INITCALL(init_func_watchdog_init)
>> +#define WATCHDOG_RESET() INITCALL(init_func_watchdog_reset)
>> +#else
>> +#define WATCHDOG_INIT()
>> +#define WATCHDOG_RESET()
>> +#endif
>> +
>>  #endif
>> --
>> 2.43.0
>>
