Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F10C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7971888C9;
	Sat, 13 Jul 2024 17:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZoTOcBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF12887E13; Sat, 13 Jul 2024 17:14:38 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90AB688852
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c9baecc80fso2180704a91.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883673; x=1721488473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x85kd1R36lrre3YVHlKs04YinJGTRFWJ+z18QFh3U58=;
 b=AZoTOcBwdqSGo5k+ze5pLgsXi9MsBK2w8Hco9sa2py8hpGIWP7PhRHWdjq+pZuwjf0
 myc59XaxUdHmZNMiFpeDTJ0NnQ74dfDkxGaJC3xgdHQhaQ7FMyY4D3y5RlOfXJLafcs/
 djFxysT/mY87QGKfrnW804KbqnKqLneDks7Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883673; x=1721488473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x85kd1R36lrre3YVHlKs04YinJGTRFWJ+z18QFh3U58=;
 b=lqAe58a392hucyxcDy2KNJtqmB6wbfrZOsue0iCv8JAIVN6RQR8kj/ddqo+pN9qSsi
 Ym8i/7dLWB/Y2QzHsRoW+9WLPfgFgsvbB34AzTh2b0IXCg8EU3ASA9zCDaq+n7JEIokS
 oJm5R5N83PShsr0IiTt375Zd/e9DF7yDUCLfrYMcK/ATgPK1l3/Xcl7Ej4bJ3O5hhQ4Z
 pF/zJ0UHbEgNGXP4cJEPVcIqB83OYi1cBp3shwvPvRSyDP1oCoEOqk5pf38xCvFISddF
 R8LlsEje4RMWsjtoRq0o9AzB+0V8kJWYw4fyu6UE/FGdUIJKRBnhVo69l37vw5+MSiDA
 veow==
X-Gm-Message-State: AOJu0YwUVP3mU3aHuypsTbJSua6ICunUx2STYeNLHEQqojrJ3fsfro1y
 0AZS1V3EoRJ3Zl5U4da7KxauzCTQXrYPPKbsXGpN584P2i60CTe9i+aD8Qx/OwzZNiJCVAt8Rug
 yD0zIPoRLDeKLrvw3rTL2rNiNCLLyarfFQ9lbrr5WzPZjXas=
X-Google-Smtp-Source: AGHT+IEvLKtcqJw89uIUf4tDZ3mKZBw8mzgyWzg5NF0+3kgqRNo72f8N0QJaBfSjiZZxX2kLRrWjYO3CRdITF50huJU=
X-Received: by 2002:a17:90a:bd87:b0:2c2:e45b:ecd with SMTP id
 98e67ed59e1d1-2ca35c3aa03mr10218426a91.12.1720883672994; Sat, 13 Jul 2024
 08:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240703212338.1436606-1-trini@konsulko.com>
 <20240711212710.2743991-1-trini@konsulko.com>
In-Reply-To: <20240711212710.2743991-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:50 +0100
Message-ID: <CAFLszThp7ygWBVMmksYQrO8HTRSm5optwSh63==5fMEQ7btM+g@mail.gmail.com>
Subject: Re: [v2] bootstash: Do not provide a default address for all
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Thu, 11 Jul 2024 at 22:27, Tom Rini <trini@konsulko.com> wrote:
>
> A valid memory location to stash bootstage information at will be
> architecture dependent. Move the existing defaults to the main Kconfig
> file for this option and set 0x0 as the default only for sandbox.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Seeing that BOOTSTAGE_STASH_ADDR did not depend on BOOTSTAGE_STASH in
>   turn lead to discovering that (minor) BOOTSTAGE_STASH_SIZE was also
>   missing a depends on line and then that a number of places built code
>   with BOOTSTAGE_STASH_ADDR=0x0 as a compiles-but-likely-fails option.
>   Rework a number of spots to guard usage around BOOTSTAGE_STASH being
>   enabled.
> ---
>  arch/arm/mach-rockchip/tpl.c      |  4 ++--
>  arch/arm/mach-stm32mp/Kconfig.13x |  3 ---
>  arch/arm/mach-stm32mp/Kconfig.15x |  3 ---
>  arch/arm/mach-stm32mp/Kconfig.25x |  3 ---
>  arch/x86/cpu/cpu.c                |  2 ++
>  boot/Kconfig                      |  6 +++++-
>  cmd/bootstage.c                   |  8 +++++++-
>  common/board_f.c                  |  2 ++
>  common/bootstage.c                |  2 ++
>  common/spl/spl.c                  |  2 ++
>  include/bootstage.h               | 14 ++++++++------
>  11 files changed, 30 insertions(+), 19 deletions(-)

There is quite a bit going on in this patch.

>
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index 50f04f9474a0..a47cba5163ab 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -92,10 +92,10 @@ void board_init_f(ulong dummy)
>  int board_return_to_bootrom(struct spl_image_info *spl_image,
>                             struct spl_boot_device *bootdev)
>  {
> -#ifdef CONFIG_BOOTSTAGE_STASH
> -       int ret;
> +       int __maybe_unused ret;
>
>         bootstage_mark_name(BOOTSTAGE_ID_END_TPL, "end tpl");
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)

It should be enough to just call bootstage_stash_default() here,
unconditionally. It does nothing if not enabled.

>         ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
>                               CONFIG_BOOTSTAGE_STASH_SIZE);
>         if (ret)
> diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
> index 4d74b35055b8..bc8b3f8cf77f 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.13x
> +++ b/arch/arm/mach-stm32mp/Kconfig.13x
> @@ -28,9 +28,6 @@ config PRE_CON_BUF_ADDR
>  config PRE_CON_BUF_SZ
>         default 4096
>
> -config BOOTSTAGE_STASH_ADDR
> -       default 0xC3000000
> -
>  if BOOTCOUNT_GENERIC
>  config SYS_BOOTCOUNT_SINGLEWORD
>         default y
> diff --git a/arch/arm/mach-stm32mp/Kconfig.15x b/arch/arm/mach-stm32mp/Kconfig.15x
> index d99aa9fd694a..42da36a73e85 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.15x
> +++ b/arch/arm/mach-stm32mp/Kconfig.15x
> @@ -86,9 +86,6 @@ config PRE_CON_BUF_ADDR
>  config PRE_CON_BUF_SZ
>         default 4096
>
> -config BOOTSTAGE_STASH_ADDR
> -       default 0xC3000000
> -
>  if BOOTCOUNT_GENERIC
>  config SYS_BOOTCOUNT_SINGLEWORD
>         default y
> diff --git a/arch/arm/mach-stm32mp/Kconfig.25x b/arch/arm/mach-stm32mp/Kconfig.25x
> index 2c0f691f8b54..7d2d8171845b 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.25x
> +++ b/arch/arm/mach-stm32mp/Kconfig.25x
> @@ -24,9 +24,6 @@ config PRE_CON_BUF_ADDR
>  config PRE_CON_BUF_SZ
>         default 4096
>
> -config BOOTSTAGE_STASH_ADDR
> -       default 0x87000000
> -
>  if DEBUG_UART
>
>  config DEBUG_UART_BOARD_INIT
> diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
> index c8433360f28e..7ce6443cc77e 100644
> --- a/arch/x86/cpu/cpu.c
> +++ b/arch/x86/cpu/cpu.c
> @@ -75,8 +75,10 @@ int __weak x86_cleanup_before_linux(void)
>         ret = mp_park_aps();
>         if (ret)
>                 return log_msg_ret("park", ret);
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>         bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
>                         CONFIG_BOOTSTAGE_STASH_SIZE);
> +#endif

Same here

>
>         return 0;
>  }
> diff --git a/boot/Kconfig b/boot/Kconfig
> index ffcae840a506..ba8bddd14219 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1002,13 +1002,17 @@ config BOOTSTAGE_STASH
>
>  config BOOTSTAGE_STASH_ADDR
>         hex "Address to stash boot timing information"
> -       default 0x0
> +       depends on BOOTSTAGE_STASH
> +       default 0xC3000000 if STM32MP13X || STM32MP15X
> +       default 0x87000000 if STM32MP25X
> +       default 0x0 if SANDBOX
>         help
>           Provide an address which will not be overwritten by the OS when it
>           starts, so that it can read this information when ready.
>
>  config BOOTSTAGE_STASH_SIZE
>         hex "Size of boot timing stash region"
> +       depends on BOOTSTAGE_STASH
>         default 0x1000
>         help
>           This should be large enough to hold the bootstage stash. A value of
> diff --git a/cmd/bootstage.c b/cmd/bootstage.c
> index 5246924f39a4..4ae09a6fd03d 100644
> --- a/cmd/bootstage.c
> +++ b/cmd/bootstage.c
> @@ -15,6 +15,7 @@ static int do_bootstage_report(struct cmd_tbl *cmdtp, int flag, int argc,
>         return 0;
>  }
>
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>  static int get_base_size(int argc, char *const argv[], ulong *basep,
>                          ulong *sizep)
>  {
> @@ -58,11 +59,14 @@ static int do_bootstage_stash(struct cmd_tbl *cmdtp, int flag, int argc,
>
>         return 0;
>  }
> +#endif
>
>  static struct cmd_tbl cmd_bootstage_sub[] = {
>         U_BOOT_CMD_MKENT(report, 2, 1, do_bootstage_report, "", ""),
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>         U_BOOT_CMD_MKENT(stash, 4, 0, do_bootstage_stash, "", ""),
>         U_BOOT_CMD_MKENT(unstash, 4, 0, do_bootstage_stash, "", ""),
> +#endif
>  };
>
>  /*
> @@ -91,6 +95,8 @@ U_BOOT_CMD(bootstage, 4, 1, do_boostage,
>         "Boot stage command",
>         " - check boot progress and timing\n"
>         "report                      - Print a report\n"
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>         "stash [<start> [<size>]]    - Stash data into memory\n"
> -       "unstash [<start> [<size>]]  - Unstash data from memory"
> +       "unstash [<start> [<size>]]  - Unstash data from memory\n"
> +#endif
>  );
> diff --git a/common/board_f.c b/common/board_f.c
> index 212ffb3090b2..37ae1641f1f0 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -809,6 +809,7 @@ static int initf_bootstage(void)
>         ret = bootstage_init(!from_spl);
>         if (ret)
>                 return ret;
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>         if (from_spl) {
>                 const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
>                                                CONFIG_BOOTSTAGE_STASH_SIZE);
> @@ -819,6 +820,7 @@ static int initf_bootstage(void)
>                         return ret;
>                 }
>         }
> +#endif
>
>         bootstage_mark_name(BOOTSTAGE_ID_START_UBOOT_F, "board_init_f");
>
> diff --git a/common/bootstage.c b/common/bootstage.c
> index fb6befcbc4a8..5e6462cd0a34 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -501,6 +501,7 @@ int bootstage_unstash(const void *base, int size)
>         return 0;
>  }
>
> +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>  int _bootstage_stash_default(void)
>  {
>         return bootstage_stash(map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR, 0),
> @@ -514,6 +515,7 @@ int _bootstage_unstash_default(void)
>
>         return bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
>  }
> +#endif
>
>  int bootstage_get_size(void)
>  {
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccade1..47db4ead5050 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -472,11 +472,13 @@ static int spl_common_init(bool setup_malloc)
>                       ret);
>                 return ret;
>         }
> +#if CONFIG_IS_ENABLED(BOOTSTAGE)

I don't think this #ifdef is needed.

>         if (!u_boot_first_phase()) {
>                 ret = bootstage_unstash_default();
>                 if (ret)
>                         log_debug("Failed to unstash bootstage: ret=%d\n", ret);
>         }
> +#endif
>         bootstage_mark_name(get_bootstage_id(true),
>                             spl_phase_name(spl_phase()));
>  #if CONFIG_IS_ENABLED(LOG)
> diff --git a/include/bootstage.h b/include/bootstage.h
> index f4e77b09d747..2d4987f31414 100644
> --- a/include/bootstage.h
> +++ b/include/bootstage.h
> @@ -462,18 +462,20 @@ int _bootstage_unstash_default(void);
>
>  static inline int bootstage_stash_default(void)
>  {
> -       if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
> -               return _bootstage_stash_default();
> -
> +#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> +       return _bootstage_stash_default();
> +#else
>         return 0;
> +#endif

I believe you can leave this as it is.

>  }
>
>  static inline int bootstage_unstash_default(void)
>  {
> -       if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
> -               return _bootstage_unstash_default();
> -
> +#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> +       return _bootstage_unstash_default();
> +#else
>         return 0;
> +#endif

and this

>  }
>
>  /* Helper macro for adding a bootstage to a line of code */
> --
> 2.34.1
>

Regards,
Simon
