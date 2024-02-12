Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE6CC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A206987CC2;
	Mon, 12 Feb 2024 14:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AUXXhAAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF0187BC3; Mon, 12 Feb 2024 14:41:39 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D0087CC2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so4280073a12.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707745296; x=1708350096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m5LHfdEogM6p6FoEkg3MS+sW+APIAppY7KiVeBX4qbw=;
 b=AUXXhAArExxI5ZR7V1lPTxZyF+x61G2dqBZRxWKV15s+2zufDXdTBh0SLgZ3PGhZoH
 txeRrB03WG9uSFEA3ZY1k8qIYRjsmreCcZh7hDdFdgRxXqRQdA2PPAObWYEeI7xigmXc
 /NBHVQ8mwhfzswQnpZc5DrV/AfFowtnpcracRPbvFw2LEL/fj/+sY5Hqs5zOoO+8+z0k
 QfzJWlJ4ae7k2Dvke3y/RjMPXN/K48vOcaXYRPS8YcfnrZPxGoyFUXAgNZmo/fLKr91I
 BzX5e+lCIX6odZNoanNHV3zUcleDnZIy/hmzLxm54GcaOs7lR6mPnt6BPzE7gM4GDwlY
 +xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707745296; x=1708350096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5LHfdEogM6p6FoEkg3MS+sW+APIAppY7KiVeBX4qbw=;
 b=NiZFPOAS9AV0eBt5AojtgJlUJpH1RL3+iqZpY8Scdb9lzph5GFufISFXPVsPQQOA5t
 utI4UxH9Qt1zHDMIHLe/YheHvFXDUSXYJm3OIvoOktuwcVuEwJGa6LLZEAvVqc7wCpzd
 wwjf+9p2fEnY9W+wySimDrPdkEXmJfeV9kR7kMUR5k8V1JGmhBPSd5n49ggoKfqC7xR7
 hafnNNb6IPWFAAm9QLiUQHkqVgSPPYa4JdN6lBowWuzogsn48yo8m9QT5pzM2+NGRtJO
 ljLfAjMRcj1uGAJbw475QCYJ1r5HX1nVNw66Q2rGS5qqmHzHAbOua7b42mhnBRe1NYSh
 z78w==
X-Gm-Message-State: AOJu0YyCPp+yVWv8935XztQ5uFZGqCovhz5pDcadtIWR5GR3FR8sSZ3u
 S0/AHV0++1Tx09aa24tMw3lm1H8g7i7q2bqvd8/WBIsMZUt/HBs9ei5Cvry2XJC00AjQ06G/LxS
 ol97cxyqRSVBeMtEITA0GGr5bGA0=
X-Google-Smtp-Source: AGHT+IFj3ZMFPpF1YyC/Y7NJZ2k21JgBh+IHdfCcMqmwKwIncuGtguMG7ASoy8UbNoggx+sxZPQkD7t+4pC5DVMYpWs=
X-Received: by 2002:a05:6402:1608:b0:561:212a:114 with SMTP id
 f8-20020a056402160800b00561212a0114mr4826438edv.32.1707745295861; Mon, 12 Feb
 2024 05:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-4-6c9ffe09b924@theobroma-systems.com>
In-Reply-To: <20240209-jaguar-v2-4-6c9ffe09b924@theobroma-systems.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 12 Feb 2024 13:41:24 +0000
Message-ID: <CALeDE9NSsp7j2nmFJvPrK9CxhGM1wKcR0ZnRfSy02kFSYwVW6Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] rockchip: pine64: pinebook-pro: migrate to
 rockchip_early_misc_init_r
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

On Fri, 9 Feb 2024 at 09:50, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Compared to the original misc_init_r from Rockchip mach code,
> setup_iodomain() is added and rockchip_setup_macaddr() is not called.
>
> It is assumed adding rockchip_setup_macaddr() back is fine.
> Let's use rockchip_early_misc_init_r instead of reimplementing the whole
> misc_init_r from Rockchip (the side effect being that
> rockchip_setup_macaddr() is back).

The Pinebook Pro doesn't have onboard ethernet, nor an alias defined,
I wonder if rockchip_setup_macaddr should be gated on GMAC_ROCKCHIP or
something similar. Otherwise:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> index 4ad780767ea..2408a367305 100644
> --- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> +++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> @@ -11,7 +11,6 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/grf_rk3399.h>
>  #include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/misc.h>
>  #include <linux/printk.h>
>  #include <power/regulator.h>
>
> @@ -54,23 +53,10 @@ static void setup_iodomain(void)
>         rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>  }
>
> -int misc_init_r(void)
> +int rockchip_early_misc_init_r(void)
>  {
> -       const u32 cpuid_offset = 0x7;
> -       const u32 cpuid_length = 0x10;
> -       u8 cpuid[cpuid_length];
> -       int ret;
> -
>         setup_iodomain();
>
> -       ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
> -       if (ret)
> -               return ret;
> -
> -       ret = rockchip_cpuid_set(cpuid, cpuid_length);
> -       if (ret)
> -               return ret;
> -
> -       return ret;
> +       return 0;
>  }
>  #endif
>
> --
> 2.43.0
>
