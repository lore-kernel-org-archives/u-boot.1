Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8A0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 09:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A9688431;
	Tue, 18 Jun 2024 11:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VpsuGQ61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06AE2884BA; Tue, 18 Jun 2024 11:18:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0B3881DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57c83100c5fso5647449a12.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718702333; x=1719307133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=255s2HcufYfk4j2co4jClvNgg21jue8k44bQwAJC6dw=;
 b=VpsuGQ61H+vvrqzwv0LHpsKNdm/BU4stV75o2ui9iy819i2jRN3B8NOrXTHnoZoVXo
 OJMa3qfJCSbGQ8JZ12xfH0uhQKf5fto9EhER75/OR+slTLpbUJAFTvwfWt/sGfNJsxRm
 QIoRkqBJ3EAGlX5Aiw/ednlTyo+a1SoNYw70o3ykaW0vuxeBXhMmSoOhd25ZBSPcEuxG
 3E0YnqfAhk3YdJoxXnvh2/hm2EXdP8OfGCnbhMEY4sokJJI9FAmZwplWLfcttI1/06j7
 KjGc6qTrB9NqDbcfNppPcxJrfXlgnlMmo6l/dZU72e+bb/WIxg34lz/XAljhpyfQhXpa
 Dq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718702333; x=1719307133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=255s2HcufYfk4j2co4jClvNgg21jue8k44bQwAJC6dw=;
 b=vBSuWaqs4BDH/fI0bVlE6qqBrxgP03ngKqLAWf3o8+SFQ9I7UyAVfk/8dB1G+/nUEU
 mYCpXkKpG/2+Smv94rT9dlImMyQfCJE8ksOeplRGUp7sG6byG7l8g4sMe0utQXO5NwOO
 qQ1wWQFpeGpU/tYvZXnRcyEd3+IJVLVRUltM2bRVqblh4NlTpxXK+VXYP4AECqPe3gQk
 qSDhFZX85Qk9wCvrYPj6/I2qmo3G8WLSbfu0lPhI1sMD68IMuwT2kDDGQgPHvVOSY4HH
 g7YevS5vgX4gZJan0pQGe3PTLHKzV0O8d2FGJ/VkE5YLRXaHqad4ErxZUSUUujycbjc7
 4p2g==
X-Gm-Message-State: AOJu0YwpwsprqI+g0M2b00UKdMlAKlSfQm4Awoc41uVnCKqNOlT/Ab+N
 LwZnLoABS17l/MpZnBYb8khoUpa/bKWJKUFXxz5MeXESdN1m7GRLdcToN3MzWN6wMvfH+rhLO7I
 H+G7eSpqmNLdZK4EklrBi58EC0pE=
X-Google-Smtp-Source: AGHT+IF3GhvPKR9N01+cjI7DKclyP1Y8OueXESX68AADWqUUt6W86Y9yY+phbqDBr/BdMp8YFulB9/88qp6L7mQ0tBE=
X-Received: by 2002:a50:f69d:0:b0:578:56e1:7ba3 with SMTP id
 4fb4d7f45d1cf-57cbd8e7a9emr6933925a12.38.1718702333047; Tue, 18 Jun 2024
 02:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240618010548.1379-1-naoki@radxa.com>
In-Reply-To: <20240618010548.1379-1-naoki@radxa.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 18 Jun 2024 10:18:41 +0100
Message-ID: <CALeDE9PPMUE_P+keN2UbEQbV=p_Rp60f9DKa=wFp-5bGZuG=NA@mail.gmail.com>
Subject: Re: [PATCH 1/3] configs: rockchip: cosmetic changes for rk3308,
 rk3328, rk3399, rk3568, and rk3588
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, andy.yan@rock-chips.com, 
 gajjar04akash@gmail.com, jonas@kwiboo.se
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

On Tue, 18 Jun 2024 at 02:06, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> no functional change is intended.

Can you please explain what the patch is doing then, the subject of
"cosmetic changes for rk3308, rk3328, rk3399, rk3568, and rk3588"
doesn't really explain it either. Something like "adjust indentation
for consistency" or what the patch actually does is useful.


> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  include/configs/rk3308_common.h | 26 ++++++++++-----------
>  include/configs/rk3328_common.h | 28 +++++++++++------------
>  include/configs/rk3399_common.h | 40 ++++++++++++++++-----------------
>  include/configs/rk3568_common.h | 14 ++++++------
>  include/configs/rk3588_common.h | 12 +++++-----
>  5 files changed, 60 insertions(+), 60 deletions(-)
>
> diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
> index 861154fbeb..80113220e4 100644
> --- a/include/configs/rk3308_common.h
> +++ b/include/configs/rk3308_common.h
> @@ -8,24 +8,24 @@
>
>  #include "rockchip-common.h"
>
> -#define CFG_IRAM_BASE          0xfff80000
> +#define CFG_IRAM_BASE                  0xfff80000
>
>  #define CFG_SYS_SDRAM_BASE             0
>  #define SDRAM_MAX_SIZE                 0xff000000
>
> -#define ENV_MEM_LAYOUT_SETTINGS \
> -       "scriptaddr=0x00500000\0" \
> -       "pxefile_addr_r=0x00600000\0" \
> -       "fdt_addr_r=0x03e00000\0" \
> -       "fdtoverlay_addr_r=0x03f00000\0" \
> -       "kernel_addr_r=0x00680000\0" \
> +#define ENV_MEM_LAYOUT_SETTINGS                \
> +       "scriptaddr=0x00500000\0"       \
> +       "pxefile_addr_r=0x00600000\0"   \
> +       "fdt_addr_r=0x03e00000\0"       \
> +       "fdtoverlay_addr_r=0x03f00000\0"        \
> +       "kernel_addr_r=0x00680000\0"    \
>         "ramdisk_addr_r=0x04000000\0"
>
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -       ENV_MEM_LAYOUT_SETTINGS \
> -       "partitions=" PARTS_DEFAULT \
> -       ROCKCHIP_DEVICE_SETTINGS \
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "partitions=" PARTS_DEFAULT     \
> +       ENV_MEM_LAYOUT_SETTINGS         \
> +       ROCKCHIP_DEVICE_SETTINGS        \
>         "boot_targets=" BOOT_TARGETS "\0"
>
> -#endif
> +#endif /* __CONFIG_RK3308_COMMON_H */
> diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
> index 2c40674b22..f9e6634c5f 100644
> --- a/include/configs/rk3328_common.h
> +++ b/include/configs/rk3328_common.h
> @@ -8,25 +8,25 @@
>
>  #include "rockchip-common.h"
>
> -#define CFG_IRAM_BASE          0xff090000
> +#define CFG_IRAM_BASE                  0xff090000
>
>  #define CFG_SYS_SDRAM_BASE             0
>  #define SDRAM_MAX_SIZE                 0xff000000
>
> -#define ENV_MEM_LAYOUT_SETTINGS \
> -       "scriptaddr=0x00500000\0" \
> -       "pxefile_addr_r=0x00600000\0" \
> -       "fdt_addr_r=0x01f00000\0" \
> -       "kernel_addr_r=0x02080000\0" \
> -       "ramdisk_addr_r=0x06000000\0" \
> -       "kernel_comp_addr_r=0x08000000\0" \
> +#define ENV_MEM_LAYOUT_SETTINGS                \
> +       "scriptaddr=0x00500000\0"       \
> +       "pxefile_addr_r=0x00600000\0"   \
> +       "fdt_addr_r=0x01f00000\0"       \
> +       "kernel_addr_r=0x02080000\0"    \
> +       "ramdisk_addr_r=0x06000000\0"   \
> +       "kernel_comp_addr_r=0x08000000\0"       \
>         "kernel_comp_size=0x2000000\0"
>
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       ENV_MEM_LAYOUT_SETTINGS \
> -       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -       "partitions=" PARTS_DEFAULT \
> -       ROCKCHIP_DEVICE_SETTINGS \
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "partitions=" PARTS_DEFAULT     \
> +       ENV_MEM_LAYOUT_SETTINGS         \
> +       ROCKCHIP_DEVICE_SETTINGS        \
>         "boot_targets=" BOOT_TARGETS "\0"
>
> -#endif
> +#endif /* __CONFIG_RK3328_COMMON_H */
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index 4e75771055..62007c8b27 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -8,36 +8,36 @@
>
>  #include "rockchip-common.h"
>
> -#define CFG_IRAM_BASE          0xff8c0000
> +#define CFG_IRAM_BASE                  0xff8c0000
>
>  #define CFG_SYS_SDRAM_BASE             0
>  #define SDRAM_MAX_SIZE                 0xf8000000
>
>  #ifndef CONFIG_SPL_BUILD
>
> -#define ENV_MEM_LAYOUT_SETTINGS \
> -       "scriptaddr=0x00500000\0" \
> -       "script_offset_f=0xffe000\0" \
> -       "script_size_f=0x2000\0" \
> -       "pxefile_addr_r=0x00600000\0" \
> -       "fdt_addr_r=0x01f00000\0" \
> -       "fdtoverlay_addr_r=0x02000000\0" \
> -       "kernel_addr_r=0x02080000\0" \
> -       "ramdisk_addr_r=0x06000000\0" \
> -       "kernel_comp_addr_r=0x08000000\0" \
> -       "kernel_comp_size=0x2000000\0"
> -
>  #ifndef ROCKCHIP_DEVICE_SETTINGS
>  #define ROCKCHIP_DEVICE_SETTINGS
>  #endif
>
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       ENV_MEM_LAYOUT_SETTINGS \
> -       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -       "partitions=" PARTS_DEFAULT \
> -       ROCKCHIP_DEVICE_SETTINGS \
> +#define ENV_MEM_LAYOUT_SETTINGS                \
> +       "scriptaddr=0x00500000\0"       \
> +       "script_offset_f=0xffe000\0"    \
> +       "script_size_f=0x2000\0"        \
> +       "pxefile_addr_r=0x00600000\0"   \
> +       "fdt_addr_r=0x01f00000\0"       \
> +       "fdtoverlay_addr_r=0x02000000\0"        \
> +       "kernel_addr_r=0x02080000\0"    \
> +       "ramdisk_addr_r=0x06000000\0"   \
> +       "kernel_comp_addr_r=0x08000000\0"       \
> +       "kernel_comp_size=0x2000000\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "partitions=" PARTS_DEFAULT     \
> +       ENV_MEM_LAYOUT_SETTINGS         \
> +       ROCKCHIP_DEVICE_SETTINGS        \
>         "boot_targets=" BOOT_TARGETS "\0"
>
> -#endif
> +#endif /* CONFIG_SPL_BUILD */
>
> -#endif
> +#endif /* __CONFIG_RK3399_COMMON_H */
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> index 48f93083de..09b7b71c6a 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier:     GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * (C) Copyright 2021 Rockchip Electronics Co., Ltd
>   */
> @@ -10,7 +10,7 @@
>
>  #include "rockchip-common.h"
>
> -#define CFG_IRAM_BASE          0xfdcc0000
> +#define CFG_IRAM_BASE                  0xfdcc0000
>
>  #define CFG_SYS_SDRAM_BASE             0
>  #define SDRAM_MAX_SIZE                 0xf0000000
> @@ -28,10 +28,10 @@
>         "kernel_comp_size=0x8000000\0"
>
>  #define CFG_EXTRA_ENV_SETTINGS         \
> -       ENV_MEM_LAYOUT_SETTINGS                 \
> -       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -       "partitions=" PARTS_DEFAULT             \
> -       ROCKCHIP_DEVICE_SETTINGS \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "partitions=" PARTS_DEFAULT     \
> +       ENV_MEM_LAYOUT_SETTINGS         \
> +       ROCKCHIP_DEVICE_SETTINGS        \
>         "boot_targets=" BOOT_TARGETS "\0"
>
> -#endif
> +#endif /* __CONFIG_RK3568_COMMON_H */
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index 70430612ef..e6654c275a 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier:     GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * (C) Copyright 2021 Rockchip Electronics Co., Ltd
>   * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> @@ -26,11 +26,11 @@
>         "ramdisk_addr_r=0x12180000\0"   \
>         "kernel_comp_size=0x8000000\0"
>
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -       "partitions=" PARTS_DEFAULT             \
> -       ENV_MEM_LAYOUT_SETTINGS                 \
> -       ROCKCHIP_DEVICE_SETTINGS \
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "partitions=" PARTS_DEFAULT     \
> +       ENV_MEM_LAYOUT_SETTINGS         \
> +       ROCKCHIP_DEVICE_SETTINGS        \
>         "boot_targets=" BOOT_TARGETS "\0"
>
>  #endif /* __CONFIG_RK3588_COMMON_H */
> --
> 2.43.0
>
