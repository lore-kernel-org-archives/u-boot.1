Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93C6E77184
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 12:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7278780423;
	Sat, 21 Dec 2024 13:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nLf7VRgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D0C80433; Sat, 21 Dec 2024 13:08:52 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03AB980137
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 13:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso567950566b.1
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734782929; x=1735387729; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rhenlaQDDvIIxfjs+TiA/tnj3Ohl8XcCg9ablvS8Nk4=;
 b=nLf7VRgts31GqTunokrlFCsfWTKwODInfVeMvxulzeoGWXydKqimTDSH0diZe+Kzdb
 DxzazEfiPVHh8IPw4/qYh2EFZq5lfcioiSSc27fnJhSqlCleWeoAbXikWPHxV3q+fZDJ
 IzGx820fZpyOZVZolpssY5LpBlo6D73PvqRBnL8aiFv7VPEhkk4Ms82V+lt0Sv25/wVd
 MptR00ZstPEGcV7ovbmp648DtNirUIw5J4qk46SaUf2SWS13UHkOb85vsYAkAt1etWJj
 1a64X0r8SR+NsoRmY/C1WKgWG0XetxtqR1JpX+4lV/aSKnxYTD30SqOCn242M0lYOLxh
 DXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734782929; x=1735387729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhenlaQDDvIIxfjs+TiA/tnj3Ohl8XcCg9ablvS8Nk4=;
 b=gndG3LzlKRhM1SwRIEeW1G/391/f9rg7+mEy7OBhztCcEeAoLj24g7tfF786WBgRqv
 rOcT/ZQVMHesq2JhtTzr72oGWydblrf/Cc4MB6rd/kzMdTKbI6va3zB3xKePXOsNZMyt
 +wkhc5EiDTFF3xK5Tf7buyKxgeNVGh3BxxicojQrS9gpf3wCmh2U6Os8SgQsw3/Jp8xb
 OQL0dmz8sX3UTrjiOpghfnlYVZVsFzzkZ0xCmWUOUsJV8drHOKWXeajPC+GY37rA5fX/
 ku3ClMlsq2357IUDxdH+pi4KUowmmU6jTyHTu9bjUbw4Sv4Ip5h4h9Eo5e7vvQ2BrLJO
 0xIQ==
X-Gm-Message-State: AOJu0YxrixGbPpiOVe0fvzZsQwUuelPu5p3/+f3X68gxk/uIwTse+xdN
 KL3nV0HW0xwsjhnVN1E0dH3g2Ni74Wv45+NLK3RLMOQkAuerIQ8tjAQS7QCw4Fc=
X-Gm-Gg: ASbGnctTxPqrDLaT9D/vgrX52R6yU7AgFvylgPAp1+PmeyOA5FeMO074LM2pUnP8Fdh
 UL3INSHF0O2BNk9iwf5uk9JNZRJW++gvnAd/QpPSIPqSIikb1IozYnXigFS+dudGzdQGHMYs7G7
 bRuKqPE0CVHPFPhJlJRzQ0odSbT/rGHXDPYIi1mqqbNXa3N0hs9ISTqbmzXh/MFM/F9K0E0V1eI
 DokO8ZxPIg7kRrLeia6NAI03Jv4GomFezwKCq90I2jK7zEs/NZ2f7uHVOOxuxdgJPsc+aOg9+8C
 r4+4qFmyL8SvniF/fY1TEBulB2IMbmIVezs0
X-Google-Smtp-Source: AGHT+IFvJgnOpbk6eRukzsxdRFYa99KCyQxtZxf3a/LDZzj86XiP9yef9kgiCTdDJ2tdrlXKxPmaGw==
X-Received: by 2002:a17:907:d9f:b0:aa6:9ee3:e51f with SMTP id
 a640c23a62f3a-aac334e377amr580060666b.41.1734782929227; 
 Sat, 21 Dec 2024 04:08:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d8e8:3f63:24c5:4b4c?
 ([2a01:e0a:3cb:7bb0:d8e8:3f63:24c5:4b4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe3958sm274202566b.96.2024.12.21.04.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 04:08:48 -0800 (PST)
Message-ID: <e470add5-7366-41e1-8e76-8f4d0231236c@linaro.org>
Date: Sat, 21 Dec 2024 13:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] board_init_f(): use static calls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
 <CAC_iWjJ=0fDmKVz2shO1e3EjeLY_e9rWk4zD_Uxgt-Y7nExwpg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJ=0fDmKVz2shO1e3EjeLY_e9rWk4zD_Uxgt-Y7nExwpg@mail.gmail.com>
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

Hi Ilias,

On 12/21/24 09:10, Ilias Apalodimas wrote:
> Hi Jerome
> 
> [...]
> 
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
> 
> The previous function was calling
> init, reset, reset for the watchdog.
> The new code does init, reset, init, reset etc. Is this intentional?
> Was that a bug of the existing code?

Good catch, it's a mistake. I'll fix in v3.

Thanks,
-- 
 Jerome

> 
> Thanks
> /Ilias
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
>> @@ -934,48 +937,48 @@ static const init_fnc_t init_sequence_f[] = {
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
>> @@ -985,12 +988,11 @@ static const init_fnc_t init_sequence_f[] = {
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
>> +}
>>
>>  void board_init_f(ulong boot_flags)
>>  {
>> @@ -1000,8 +1002,7 @@ void board_init_f(ulong boot_flags)
>>         gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>>         gd->boardf = &boardf;
>>
>> -       if (initcall_run_list(init_sequence_f))
>> -               hang();
>> +       initcall_run_f();
>>
>>  #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>>                 !defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
>> diff --git a/include/initcall.h b/include/initcall.h
>> index 62d3bb67f08..9398a3ec7d5 100644
>> --- a/include/initcall.h
>> +++ b/include/initcall.h
>> @@ -8,6 +8,7 @@
>>
>>  #include <asm/types.h>
>>  #include <event.h>
>> +#include <hang.h>
>>
>>  _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>>
>> @@ -35,4 +36,30 @@ typedef int (*init_fnc_t)(void);
>>   */
>>  int initcall_run_list(const init_fnc_t init_sequence[]);
>>
>> +#define INITCALL(_call) \
>> +       do { \
>> +               if (_call()) { \
>> +                       debug("%s(): calling %s() failed\n", __func__, \
>> +                             #_call); \
>> +                       hang(); \
>> +               } \
>> +       } while (0)
>> +
>> +#define INITCALL_EVT(_evt) \
>> +       do { \
>> +               if (event_notify_null(_evt)) { \
>> +                       debug("%s(): event %d/%s failed\n", __func__, _evt, \
>> +                             event_type_name(_evt)) ; \
>> +                       hang(); \
>> +               } \
>> +       } while (0)
>> +
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
