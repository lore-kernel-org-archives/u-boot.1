Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E56C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC0486540;
	Thu, 24 Aug 2023 01:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="M9JriNTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9538A864F9; Thu, 24 Aug 2023 01:59:28 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B0F86515
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d746ea563f9so4757217276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NGmqAAZOwDuwljgc8eX29z6OYSLGbeaQC7aoRbGYlmg=;
 b=M9JriNTHCRcXwDoy4b6/dkrKYozj3lEHDC0meKz1QvMCekj8f/+lrubtEPngsjwxW5
 LkD2yxJbrtyDoo2b8Cn1hYtFB7h1kt9S9OmPyxLTF1ANGSV3ehleIXxrfjVlFnE+cmug
 zDclepMfzjExxuzss/cqf6F2+nAAV2otvPzWD6L/U2ME8b7oIN8eHNyP/zMG1lZd/G5x
 HWGKafrHbe1BBhdtqYxmX/0p0pbbQ8Shx38gzDaVibZHSvca/POZfO0fCiv9tvU3x6mS
 dkwh0uIk/y6UfSia14TOE4mwT6AvzXb/zyn3oMTTzlV2CPNbMbf7dEBiZ3daPi/yaFF5
 X71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGmqAAZOwDuwljgc8eX29z6OYSLGbeaQC7aoRbGYlmg=;
 b=hOA97Dwx1YMarccj+z8B8ENZpl3nx3/k5z3fxWzINCXO/tGK1J4vvMmCTA1Ig9ID29
 KsoaXF5xaCCVz2ohBpU8JsGKfUlMMXorO3tpjFXPzM2/w8SiqKhC4G/o/BqSEimDtk8q
 Ka8e2KDVhba1QvuxvlMV5Ruacsswxu1xhuZ/C1369jW34Rks1N5bWLolIJXa1gtO6yWs
 CIXhZna5hO6W2fo+ErYgMrD8fyJDt4mh923zDsEvcuBet/JEW7BMHlHEcWtcYmQYIbn5
 INY1J0Gk4jLc7Q1/+2Z1kB72Rtj2ht7Yhtki+ewZmwFN3uWEByGscoZIEjpfrGI++uFO
 yGfA==
X-Gm-Message-State: AOJu0Yzigi6NwpF5cZjnVLNb7jB7WievLTZky3/Ty7kRkUQJ/tjK3/nT
 OeVPAfbRalPVEvDgg1jxZ9medBkyU/y6bTHsFfzdDw==
X-Google-Smtp-Source: AGHT+IFlFFf82VWTwZcv4eMbfSPz2/u63pNj0fKLJceEzNSOlFTGCPtCY/kcYnFZZxneedRtKoiZkek2at/IVJBP5tY=
X-Received: by 2002:a25:bb85:0:b0:d15:454e:8ecd with SMTP id
 y5-20020a25bb85000000b00d15454e8ecdmr13339784ybg.13.1692835156468; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-16-clamor95@gmail.com>
In-Reply-To: <20230822112217.4646-16-clamor95@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 17:57:34 -0600
Message-ID: <CAPnjgZ3zyLjoX5-2zvC9X3Bz+h2KzODpq6X8kNAqR038qtaFVA@mail.gmail.com>
Subject: Re: [PATCH v1 15/19] ARM: tegra: board2: add generic late init
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Tue, 22 Aug 2023 at 05:25, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Board specific late init allows vendors to set up different device
> or board specific env variables (like serial number, platform name).
> In case this information is missing, u-boot will lack info regards
> serial or platform.
>
> To avoid this prior nvidia_board_late_init internal generic function
> is called which fills required data. In this case platform name is
> obtained from get_chip and serialno is filled with SoC id.
>
> Though SoC id is not dedicated to be devices serial but it fits well
> in case of restriction of data about device and since SoC is basically
> a main chip of the device.
>
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Transformers
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/mach-tegra/board2.c | 43 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
> index 981768bb0e..ee69cb657a 100644
> --- a/arch/arm/mach-tegra/board2.c
> +++ b/arch/arm/mach-tegra/board2.c
> @@ -26,6 +26,10 @@
>  #include <asm/arch-tegra/gpu.h>
>  #include <asm/arch-tegra/usb.h>
>  #include <asm/arch-tegra/xusb-padctl.h>
> +#ifndef CONFIG_TEGRA186
> +#include <asm/arch-tegra/fuse.h>
> +#include <asm/arch/gp_padctrl.h>
> +#endif
>  #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
>  #include <asm/arch/clock.h>
>  #endif
> @@ -256,6 +260,37 @@ int board_early_init_f(void)
>  }
>  #endif /* EARLY_INIT */
>
> +#ifndef CONFIG_TEGRA186
> +static void nvidia_board_late_init_generic(void)
> +{
> +       char serialno_str[17];
> +
> +       /* Set chip id as serialno */
> +       sprintf(serialno_str, "%016llx", tegra_chip_uid());
> +       env_set("serial#", serialno_str);
> +
> +       switch (tegra_get_chip()) {
> +       case CHIPID_TEGRA20:
> +               env_set("platform", "Tegra 2 T20");
> +               break;
> +       case CHIPID_TEGRA30:
> +               env_set("platform", "Tegra 3 T30");
> +               break;
> +       case CHIPID_TEGRA114:
> +               env_set("platform", "Tegra 4 T114");
> +               break;
> +       case CHIPID_TEGRA124:
> +               env_set("platform", "Tegra K1 T124");
> +               break;
> +       case CHIPID_TEGRA210:
> +               env_set("platform", "Tegra X1 T210");
> +               break;
> +       default:
> +               return;
> +       }
> +}
> +#endif
> +
>  int board_late_init(void)
>  {
>  #if defined(CONFIG_TEGRA_SUPPORT_NON_SECURE)
> @@ -268,6 +303,14 @@ int board_late_init(void)
>  #endif
>         start_cpu_fan();
>         cboot_late_init();
> +
> +       /*
> +        * Perform generic env setup in case
> +        * vendor does not provide it.
> +        */
> +#ifndef CONFIG_TEGRA186
> +       nvidia_board_late_init_generic();
> +#endif
>         nvidia_board_late_init();
>
>         return 0;
> --
> 2.39.2
>

This would be better done with events. I just sent a series that
converts board_late_init() to use events [1] and with that you can add
as many 'spy' functions as you like [2].

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=369742
[2] https://u-boot.readthedocs.io/en/latest/develop/event.html
