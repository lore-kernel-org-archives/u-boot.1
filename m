Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79E5E77184
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 08:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E808A80423;
	Sat, 21 Dec 2024 09:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x6z34Qrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9232980433; Sat, 21 Dec 2024 09:11:15 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4FD803E0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e39f43344c5so2239824276.1
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734768672; x=1735373472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wyms+KNfrW4AUdt7PTVTXUX0yUlyqKoW5x2VhCZmBlw=;
 b=x6z34Qrdd6AQCBwOKt4orEKF0IYplLbwZgCqHxjKmK8fbFYz+XK8C0Ljdx9NW33S+1
 rAzZj2AHpDXRFfPHZIeptiDY1B1tavKk9dT4N1tsbjcWN1UyMdGAypxXZa+HYhs5HXHz
 eAr5EzMOGvuGCg+LbifdWYtTgpCjBNVhftMChUs3OPvXAwZrQ9mFTGJzkL72IzbKCHIw
 IiPS8N5lW+QVrlfba5gQ9mJSwPc61IRJD4QiOQPS1MUFr31Vn2nZ2YeWqb1qW8DNjfFc
 UKs9KqzAAftmoC+rDgKQdiwc02rITc30zBI66gfIcIHGS/wOKejeE8WswNJTmUmnadYp
 S42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734768672; x=1735373472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wyms+KNfrW4AUdt7PTVTXUX0yUlyqKoW5x2VhCZmBlw=;
 b=lhlXONVAGjGNdDu/zermixyp7JIXYU04I4sWNVSTd65mMktx7N1zkJIt+bSz/rhYez
 npRsulNjlEH5EZW2+tQsveLx/I6q9cwQ0H/1Q2QbRBOCy4xq5qkXLQG2QwyHAQKbyCFk
 fF4k7QmIfODxQryyGoNmxZsYJBlMQ1E9riLibT/dZcYF0bqwcBHYHKIBJyOvdpxVjtCm
 u2BBA6c3nt5qhHNPHS6137vat3ox54Erw7ZTdzebgvARx7XybdWQZOQi8D1+J1/vSwA0
 xQwx6Z/BGYYOnN35oPKN+lzPkky8qD3GruqFaS6lUmb9yO23zAkHkc08y6Tp3PjlNw1B
 FnmA==
X-Gm-Message-State: AOJu0YwpFbTjEjvCVC4TK0CpPYtFwcibyGaL/zVmlgVCLPO4LdxdMaRS
 OBUhL3hGb/94kDnH9IjD1QgAl8/QsVoFd2woiIkvwEs9COA66ga4thSEucFgho471RtoTalZhwU
 fPKAySaqJEs1PEyPDfLnp2fZ1pBIwKHWBSdLKkQ==
X-Gm-Gg: ASbGncvEF2FhIELA6YtPxwelmlEvrdQ/eOfWSKt92y0U/8FHDz6hITDIVTuOawZWCUG
 N++sl3xLAYVpqyO/3yy7pGNqUx8HjQqPF0Sz4FQ==
X-Google-Smtp-Source: AGHT+IHK51HKxwk5zmg9jq01BWTeU525hljzhmq5HE8p4MjJ+u6m8NaRCvOV1PZp7pD3Vuz7sQhvuEomzcntywyciAI=
X-Received: by 2002:a25:58c2:0:b0:e44:afe1:1e4f with SMTP id
 3f1490d57ef6-e538c257a60mr3449226276.19.1734768671986; Sat, 21 Dec 2024
 00:11:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
In-Reply-To: <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 21 Dec 2024 10:10:35 +0200
Message-ID: <CAC_iWjJ=0fDmKVz2shO1e3EjeLY_e9rWk4zD_Uxgt-Y7nExwpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] board_init_f(): use static calls
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
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

Hi Jerome

[...]

> +                         (INITCALL(board_postclk_init);))
> +       INITCALL(env_init);             /* initialize environment */
> +       INITCALL(init_baud_rate);       /* initialze baudrate settings */
> +       INITCALL(serial_init);          /* serial communications setup */
> +       INITCALL(console_init_f);       /* stage 1 init of console */
> +       INITCALL(display_options);      /* say that we are here */
> +       INITCALL(display_text_info);    /* show debugging info if required */
> +       INITCALL(checkcpu);
> +       CONFIG_IS_ENABLED(SYSRESET, (INITCALL(print_resetinfo);))
>         /* display cpu info (and speed) */
> -       CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
> -       CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
> -       CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
> -       INIT_FUNC_WATCHDOG_INIT
> -       INITCALL_EVENT(EVT_MISC_INIT_F),
> -       INIT_FUNC_WATCHDOG_RESET
> -       CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
> -       announce_dram_init,
> -       dram_init,              /* configure available RAM banks */
> -       CONFIG_IS_ENABLED(POST, (post_init_f,))
> -       INIT_FUNC_WATCHDOG_RESET
> +       CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (INITCALL(print_cpuinfo);))
> +       CONFIG_IS_ENABLED(DTB_RESELECT, (INITCALL(embedded_dtb_select);))
> +       CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (INITCALL(show_board_info);))
> +       WATCHDOG_INIT();
> +       INITCALL_EVT(EVT_MISC_INIT_F);
> +       WATCHDOG_RESET();
> +       CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (INITCALL(init_func_i2c);))
> +       INITCALL(announce_dram_init);
> +       INITCALL(dram_init);            /* configure available RAM banks */
> +       CONFIG_IS_ENABLED(POST, (INITCALL(post_init_f);))
> +       WATCHDOG_INIT();

The previous function was calling
init, reset, reset for the watchdog.
The new code does init, reset, init, reset etc. Is this intentional?
Was that a bug of the existing code?

Thanks
/Ilias
>  #if defined(CFG_SYS_DRAM_TEST)
> -       testdram,
> +       INITCALL(testdram);
>  #endif /* CFG_SYS_DRAM_TEST */
> -       INIT_FUNC_WATCHDOG_RESET
> -
> -       CONFIG_IS_ENABLED(POST, (init_post,))
> -       INIT_FUNC_WATCHDOG_RESET
> +       WATCHDOG_RESET();
> +       CONFIG_IS_ENABLED(POST, (INITCALL(init_post);))
> +       WATCHDOG_RESET();
>         /*
>          * Now that we have DRAM mapped and working, we can
>          * relocate the code and continue running from DRAM.
> @@ -934,48 +937,48 @@ static const init_fnc_t init_sequence_f[] = {
>          *  - monitor code
>          *  - board info struct
>          */
> -       setup_dest_addr,
> +       INITCALL(setup_dest_addr);
>  #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -       fix_fdt,
> +       INITCALL(fix_fdt);
>  #endif
>  #ifdef CFG_PRAM
> -       reserve_pram,
> +       INITCALL(reserve_pram);
>  #endif
> -       reserve_round_4k,
> -       setup_relocaddr_from_bloblist,
> -       arch_reserve_mmu,
> -       reserve_video,
> -       reserve_trace,
> -       reserve_uboot,
> -       reserve_malloc,
> -       reserve_board,
> -       reserve_global_data,
> -       reserve_fdt,
> +       INITCALL(reserve_round_4k);
> +       INITCALL(setup_relocaddr_from_bloblist);
> +       INITCALL(arch_reserve_mmu);
> +       INITCALL(reserve_video);
> +       INITCALL(reserve_trace);
> +       INITCALL(reserve_uboot);
> +       INITCALL(reserve_malloc);
> +       INITCALL(reserve_board);
> +       INITCALL(reserve_global_data);
> +       INITCALL(reserve_fdt);
>  #if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -       reloc_fdt,
> -       fix_fdt,
> +       INITCALL(reloc_fdt);
> +       INITCALL(fix_fdt);
>  #endif
> -       reserve_bootstage,
> -       reserve_bloblist,
> -       reserve_arch,
> -       reserve_stacks,
> -       dram_init_banksize,
> -       show_dram_config,
> -       INIT_FUNC_WATCHDOG_RESET
> -       setup_bdinfo,
> -       display_new_sp,
> -       INIT_FUNC_WATCHDOG_RESET
> +       INITCALL(reserve_bootstage);
> +       INITCALL(reserve_bloblist);
> +       INITCALL(reserve_arch);
> +       INITCALL(reserve_stacks);
> +       INITCALL(dram_init_banksize);
> +       INITCALL(show_dram_config);
> +       WATCHDOG_RESET();
> +       INITCALL(setup_bdinfo);
> +       INITCALL(display_new_sp);
> +       WATCHDOG_RESET();
>  #if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -       reloc_fdt,
> +       INITCALL(reloc_fdt);
>  #endif
> -       reloc_bootstage,
> -       reloc_bloblist,
> -       setup_reloc,
> +       INITCALL(reloc_bootstage);
> +       INITCALL(reloc_bloblist);
> +       INITCALL(setup_reloc);
>  #if defined(CONFIG_X86) || defined(CONFIG_ARC)
> -       copy_uboot_to_ram,
> -       do_elf_reloc_fixups,
> +       INITCALL(copy_uboot_to_ram);
> +       INITCALL(do_elf_reloc_fixups);
>  #endif
> -       clear_bss,
> +       INITCALL(clear_bss);
>         /*
>          * Deregister all cyclic functions before relocation, so that
>          * gd->cyclic_list does not contain any references to pre-relocation
> @@ -985,12 +988,11 @@ static const init_fnc_t init_sequence_f[] = {
>          * This should happen as late as possible so that the window where a
>          * watchdog device is not serviced is as small as possible.
>          */
> -       cyclic_unregister_all,
> +       INITCALL(cyclic_unregister_all);
>  #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
> -       jump_to_copy,
> +       INITCALL(jump_to_copy);
>  #endif
> -       NULL,
> -};
> +}
>
>  void board_init_f(ulong boot_flags)
>  {
> @@ -1000,8 +1002,7 @@ void board_init_f(ulong boot_flags)
>         gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>         gd->boardf = &boardf;
>
> -       if (initcall_run_list(init_sequence_f))
> -               hang();
> +       initcall_run_f();
>
>  #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>                 !defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
> diff --git a/include/initcall.h b/include/initcall.h
> index 62d3bb67f08..9398a3ec7d5 100644
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
> +       do { \
> +               if (_call()) { \
> +                       debug("%s(): calling %s() failed\n", __func__, \
> +                             #_call); \
> +                       hang(); \
> +               } \
> +       } while (0)
> +
> +#define INITCALL_EVT(_evt) \
> +       do { \
> +               if (event_notify_null(_evt)) { \
> +                       debug("%s(): event %d/%s failed\n", __func__, _evt, \
> +                             event_type_name(_evt)) ; \
> +                       hang(); \
> +               } \
> +       } while (0)
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
> --
> 2.43.0
>
