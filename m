Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660D8C4829E
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 11:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBEA87C60;
	Sun, 18 Feb 2024 12:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c2HIi816";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F224B87EAA; Sun, 18 Feb 2024 12:24:32 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28B087C5D
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 12:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d21a68dd3bso26085791fa.1
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708255463; x=1708860263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h2wVkV6XhkGEXp8Hb/Iifq1wdWbMVvSg6b8le/iZR54=;
 b=c2HIi816ofmb952ECiwlnRqVtpVlTlNH5o0l1j1FT3B/u0fTxBbfI7QhGGST0ZbWNe
 87rC3UaGbcJXuguVlu6sVJrI4NABwfdWK5Q/7wLlWMId5kn3eMZI8FpgPLzH65o2zXb3
 js5vx+J+unk0oqT4YHM9oSm412YVwcYGPTuGx41hJuKYF8ie0MXIusn8nCaq6hCNNIWR
 rhWn3MY5HlmWvHiY7C+oPKomvup8KlVKd5MWCRD8PG55r8h0LtEF3dz/QmiX0FTyVI9J
 sNlEufqPYmlAOwtKgJgJ4WW+boVBC2oVJ40LmuS/vGnvwsiBEUe7vmiQk1FMLIKyN/r/
 LvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708255463; x=1708860263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2wVkV6XhkGEXp8Hb/Iifq1wdWbMVvSg6b8le/iZR54=;
 b=WDDf4hkxuWd/77SF7C7AqHVUUpd4z2GY8pnvE5LWjmG/nbLGLQRAd1PNfEROeeWhZJ
 z585IZiGCubFIIIz/EfUPYjevyXg9lKijKJp0JBhmxOh51MxbrFxGpk3kOCa2pex2h+Z
 jG+5EoCYzpRqX5U4aVcvqUx2jTEHE9+Dtnx9SKxpV3jDIFfCfMz73NaopPNXOMSCyEeG
 IKql0EsZKDtYcR73N+7xht3HiAlxfUUc+MmEDIYgdqrYU3OiFcVcIP8nRv3Ii4MDITr7
 dw1xdCBiTeJJnJLyE3XYfbTa7FUMA5z6+xx0St6ueQdPaszFNdC1LdCKSpkEEA/rjofJ
 T3pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5tjeZYNRjAqEK3BdmvCHK1OUC361XzxJn4Yp+21GRA8Q5GI8M9JR4MJsz6Nju7rGuZTaXaMheaM6KjJ3kILG8T1Yqmw==
X-Gm-Message-State: AOJu0Yy088+EpsGhEB3ZxNaxsppNymd0ii/y4SzmtNkvHwkDtar22ern
 lHjvHe1O3Tb8gNzcGXHLrPKmXg5OpaMJnqotqkAt+D7mZgqBn0C77ou46ik7bgwckXDgN/gjMlc
 BzpC6BhCgszB+HkuqRx4tqMFhNn0=
X-Google-Smtp-Source: AGHT+IHiFaSZdrv+Gz4v9SdsbBcdN8H85jVeM/jyCO+SsZZpNj3WNQ1gQWOYfETTDMIgU61uYjh/WtXzFRRuGm5qQmc=
X-Received: by 2002:a05:6512:3e08:b0:512:852d:dc35 with SMTP id
 i8-20020a0565123e0800b00512852ddc35mr8820136lfv.40.1708255462763; Sun, 18 Feb
 2024 03:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-5-jonas@kwiboo.se>
In-Reply-To: <20240217183610.2621132-5-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 18 Feb 2024 11:24:11 +0000
Message-ID: <CALeDE9NTCPBEmyHJtK3JS02+UQJAZcj13ukV-vtvjVkNBmLzrw@mail.gmail.com>
Subject: Re: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Christopher Obbard <chris.obbard@collabora.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
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

On Sat, 17 Feb 2024 at 18:40, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
> into its own board target and update related defconfigs to use the new
> TARGET_ROCKPI4_RK3399 option.
>
> Also move the call to gpt_capsule_update_setup() from the weak function
> rk_board_late_init() into the main board_late_init() function.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Looks good.
> ---
>  arch/arm/mach-rockchip/board.c                | 10 +++---
>  arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++++
>  board/radxa/rockpi4-rk3399/Kconfig            | 15 +++++++++
>  board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++++++++++++
>  .../rockpi4-rk3399}/Makefile                  |  2 +-
>  .../rockpi4-rk3399/rockpi4-rk3399.c}          | 13 ++------
>  board/rockchip/evb_rk3399/MAINTAINERS         | 29 -----------------
>  configs/rock-4c-plus-rk3399_defconfig         |  2 +-
>  configs/rock-4se-rk3399_defconfig             |  2 +-
>  configs/rock-pi-4-rk3399_defconfig            |  2 +-
>  configs/rock-pi-4c-rk3399_defconfig           |  2 +-
>  include/configs/rk3399_common.h               | 16 ----------
>  include/configs/rockpi4-rk3399.h              | 32 +++++++++++++++++++
>  13 files changed, 95 insertions(+), 65 deletions(-)
>  create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
>  create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
>  rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile (79%)
>  rename board/{rockchip/evb_rk3399/evb-rk3399.c => radxa/rockpi4-rk3399/rockpi4-rk3399.c} (79%)
>  create mode 100644 include/configs/rockpi4-rk3399.h
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 4f666aee706f..dea5805c4665 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -34,7 +34,7 @@
>  #include <asm/arch-rockchip/periph.h>
>  #include <power/regulator.h>
>
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
>
>  #define DFU_ALT_BUF_LEN                        SZ_1K
>
> @@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
>
>  __weak int rk_board_late_init(void)
>  {
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> -       gpt_capsule_update_setup();
> -#endif
> -
>         return 0;
>  }
>
> @@ -196,6 +192,10 @@ int board_late_init(void)
>  {
>         setup_boot_mode();
>
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> +       gpt_capsule_update_setup();
> +#endif
> +
>         return rk_board_late_init();
>  }
>
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index d01063ac98b6..bf3600aee2ad 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -89,6 +89,11 @@ config TARGET_ROCK960_RK3399
>            * 2x USB 3.0 type A, 2x USB 2.0 type A (host mode only),
>              1x USB 3.0 type C OTG
>
> +config TARGET_ROCKPI4_RK3399
> +       bool "Radxa ROCK Pi 4 board"
> +       help
> +         Support for ROCK Pi 4 board family by Radxa.
> +
>  config TARGET_ROCKPRO64_RK3399
>         bool "Pine64 Rockpro64 board"
>         help
> @@ -174,6 +179,7 @@ source "board/google/gru/Kconfig"
>  source "board/pine64/pinebook-pro-rk3399/Kconfig"
>  source "board/pine64/pinephone-pro-rk3399/Kconfig"
>  source "board/pine64/rockpro64_rk3399/Kconfig"
> +source "board/radxa/rockpi4-rk3399/Kconfig"
>  source "board/rockchip/evb_rk3399/Kconfig"
>  source "board/theobroma-systems/puma_rk3399/Kconfig"
>  source "board/vamrs/rock960_rk3399/Kconfig"
> diff --git a/board/radxa/rockpi4-rk3399/Kconfig b/board/radxa/rockpi4-rk3399/Kconfig
> new file mode 100644
> index 000000000000..d82663506b12
> --- /dev/null
> +++ b/board/radxa/rockpi4-rk3399/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_ROCKPI4_RK3399
> +
> +config SYS_BOARD
> +       default "rockpi4-rk3399"
> +
> +config SYS_VENDOR
> +       default "radxa"
> +
> +config SYS_CONFIG_NAME
> +       default "rockpi4-rk3399"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +       def_bool y
> +
> +endif
> diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS b/board/radxa/rockpi4-rk3399/MAINTAINERS
> new file mode 100644
> index 000000000000..12d4f35af881
> --- /dev/null
> +++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
> @@ -0,0 +1,29 @@
> +ROCK-PI-4
> +M:     Jagan Teki <jagan@amarulasolutions.com>
> +R:     Jonas Karlman <jonas@kwiboo.se>
> +S:     Maintained
> +F:     board/radxa/rockpi4-rk3399/
> +F:     configs/rock-pi-4-rk3399_defconfig
> +F:     arch/arm/dts/rk3399-rock-pi-4.dtsi
> +F:     arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +F:     arch/arm/dts/rk3399-rock-pi-4a.dts
> +F:     arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> +F:     configs/rock-pi-4c-rk3399_defconfig
> +F:     arch/arm/dts/rk3399-rock-pi-4c.dts
> +F:     arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> +
> +ROCK-4C+
> +M:     FUKAUMI Naoki <naoki@radxa.com>
> +R:     Jonas Karlman <jonas@kwiboo.se>
> +S:     Maintained
> +F:     configs/rock-4c-plus-rk3399_defconfig
> +F:     arch/arm/dts/rk3399-rock-4c-plus.dts
> +F:     arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +
> +ROCK-4SE
> +M:     Christopher Obbard <chris.obbard@collabora.com>
> +R:     Jonas Karlman <jonas@kwiboo.se>
> +S:     Maintained
> +F:     configs/rock-4se-rk3399_defconfig
> +F:     arch/arm/dts/rk3399-rock-4se.dts
> +F:     arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> diff --git a/board/rockchip/evb_rk3399/Makefile b/board/radxa/rockpi4-rk3399/Makefile
> similarity index 79%
> rename from board/rockchip/evb_rk3399/Makefile
> rename to board/radxa/rockpi4-rk3399/Makefile
> index aaa51c212e52..3d0225332275 100644
> --- a/board/rockchip/evb_rk3399/Makefile
> +++ b/board/radxa/rockpi4-rk3399/Makefile
> @@ -4,4 +4,4 @@
>  # SPDX-License-Identifier:     GPL-2.0+
>  #
>
> -obj-y  += evb-rk3399.o
> +obj-y  += rockpi4-rk3399.o
> diff --git a/board/rockchip/evb_rk3399/evb-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> similarity index 79%
> rename from board/rockchip/evb_rk3399/evb-rk3399.c
> rename to board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> index ebdd74a7b97f..a533128b92fc 100644
> --- a/board/rockchip/evb_rk3399/evb-rk3399.c
> +++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> @@ -3,13 +3,8 @@
>   * (C) Copyright 2016 Rockchip Electronics Co., Ltd
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <efi_loader.h>
> -#include <init.h>
> -#include <log.h>
> -#include <asm/arch-rockchip/periph.h>
> -#include <linux/kernel.h>
>
>  #define ROCKPI4_UPDATABLE_IMAGES       2
>
> @@ -24,17 +19,15 @@ struct efi_capsule_update_info update_info = {
>  #endif
>
>  #ifndef CONFIG_SPL_BUILD
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
>  static bool board_is_rockpi_4b(void)
>  {
> -       return CONFIG_IS_ENABLED(TARGET_EVB_RK3399) &&
> -               of_machine_is_compatible("radxa,rockpi4b");
> +       return of_machine_is_compatible("radxa,rockpi4b");
>  }
>
>  static bool board_is_rockpi_4c(void)
>  {
> -       return CONFIG_IS_ENABLED(TARGET_EVB_RK3399) &&
> -               of_machine_is_compatible("radxa,rockpi4c");
> +       return of_machine_is_compatible("radxa,rockpi4c");
>  }
>
>  void rockchip_capsule_update_board_setup(void)
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index fa1f320f5a00..c1196e800e5e 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -95,35 +95,6 @@ F:   configs/orangepi-rk3399_defconfig
>  F:     arch/arm/dts/rk3399-orangepi.dts
>  F:     arch/arm/dts/rk3399-orangepi-u-boot.dtsi
>
> -ROCK-4C+
> -M:     FUKAUMI Naoki <naoki@radxa.com>
> -R:     Jonas Karlman <jonas@kwiboo.se>
> -S:     Maintained
> -F:     configs/rock-4c-plus-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-rock-4c-plus.dts
> -F:     arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> -
> -ROCK-4SE
> -M:     Christopher Obbard <chris.obbard@collabora.com>
> -R:     Jonas Karlman <jonas@kwiboo.se>
> -S:     Maintained
> -F:     configs/rock-4se-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-rock-4se.dts
> -F:     arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> -
> -ROCK-PI-4
> -M:     Jagan Teki <jagan@amarulasolutions.com>
> -R:     Jonas Karlman <jonas@kwiboo.se>
> -S:     Maintained
> -F:     configs/rock-pi-4-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-rock-pi-4.dtsi
> -F:     arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> -F:     arch/arm/dts/rk3399-rock-pi-4a.dts
> -F:     arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> -F:     configs/rock-pi-4c-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-rock-pi-4c.dts
> -F:     arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> -
>  ROCK-PI-N10
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  S:     Maintained
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index 94a9803ac6b5..8d4bfe902e8f 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
> -CONFIG_TARGET_EVB_RK3399=y
> +CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SPL_STACK=0x400000
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index e27e4a221267..9acdf52a82f2 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
> -CONFIG_TARGET_EVB_RK3399=y
> +CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SPL_STACK=0x400000
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index eb6727f22ae2..dcc9fd3084e3 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
> -CONFIG_TARGET_EVB_RK3399=y
> +CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SPL_STACK=0x400000
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 247518c42b13..da2e7349f677 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
> -CONFIG_TARGET_EVB_RK3399=y
> +CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SPL_STACK=0x400000
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index 96ba19c659bd..4e75771055b8 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -13,22 +13,6 @@
>  #define CFG_SYS_SDRAM_BASE             0
>  #define SDRAM_MAX_SIZE                 0xf8000000
>
> -#define ROCKPI_4B_IDBLOADER_IMAGE_GUID \
> -       EFI_GUID(0x02f4d760, 0xcfd5, 0x43bd, 0x8e, 0x2d, \
> -                0xa4, 0x2a, 0xcb, 0x33, 0xc6, 0x60)
> -
> -#define ROCKPI_4B_UBOOT_IMAGE_GUID \
> -       EFI_GUID(0x4ce292da, 0x1dd8, 0x428d, 0xa1, 0xc2, \
> -                0x77, 0x74, 0x3e, 0xf8, 0xb9, 0x6e)
> -
> -#define ROCKPI_4C_IDBLOADER_IMAGE_GUID \
> -       EFI_GUID(0xfd68510c, 0x12d3, 0x4f0a, 0xb8, 0xd3, \
> -                0xd8, 0x79, 0xe1, 0xd3, 0xa5, 0x40)
> -
> -#define ROCKPI_4C_UBOOT_IMAGE_GUID \
> -       EFI_GUID(0xb81fb4ae, 0xe4f3, 0x471b, 0x99, 0xb4, \
> -                0x0b, 0x3d, 0xa5, 0x49, 0xce, 0x13)
> -
>  #ifndef CONFIG_SPL_BUILD
>
>  #define ENV_MEM_LAYOUT_SETTINGS \
> diff --git a/include/configs/rockpi4-rk3399.h b/include/configs/rockpi4-rk3399.h
> new file mode 100644
> index 000000000000..1936e06ab3c2
> --- /dev/null
> +++ b/include/configs/rockpi4-rk3399.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __ROCKPI4_RK3399_H
> +#define __ROCKPI4_RK3399_H
> +
> +#define ROCKPI_4B_IDBLOADER_IMAGE_GUID \
> +       EFI_GUID(0x02f4d760, 0xcfd5, 0x43bd, 0x8e, 0x2d, \
> +                0xa4, 0x2a, 0xcb, 0x33, 0xc6, 0x60)
> +
> +#define ROCKPI_4B_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x4ce292da, 0x1dd8, 0x428d, 0xa1, 0xc2, \
> +                0x77, 0x74, 0x3e, 0xf8, 0xb9, 0x6e)
> +
> +#define ROCKPI_4C_IDBLOADER_IMAGE_GUID \
> +       EFI_GUID(0xfd68510c, 0x12d3, 0x4f0a, 0xb8, 0xd3, \
> +                0xd8, 0x79, 0xe1, 0xd3, 0xa5, 0x40)
> +
> +#define ROCKPI_4C_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0xb81fb4ae, 0xe4f3, 0x471b, 0x99, 0xb4, \
> +                0x0b, 0x3d, 0xa5, 0x49, 0xce, 0x13)
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +               "stdin=serial,usbkbd\0" \
> +               "stdout=serial,vidconsole\0" \
> +               "stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3399_common.h>
> +
> +#endif
> --
> 2.43.0
>
