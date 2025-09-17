Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B6CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 14:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D3B835B9;
	Wed, 17 Sep 2025 16:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HF4T+PV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F453835EA; Wed, 17 Sep 2025 16:01:28 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BCA8354B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 16:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45cb5e5e71eso42909145e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758117685; x=1758722485; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zriWZae3e3G7v/FbOwlYlp4gh3qQkNbfhrxiX1HUNeM=;
 b=HF4T+PV+EuRdaRy1CJJQ8SrO4/5yKlWkOG/zQY4HBWNYrE4NbBPUKaDWOlWXkB4hBu
 1osWrUfs2t0W2ZuDMFDDFvdWe+Gpe9RTziTzo1RAXmKV0DRxSd8qjoHLn5CPtCd7cAGj
 zBpKWauN8Xmc3OnaC9gqH6b8VrsBK0fMnIQrlgionqHeY1RfKrduLXRfLgvJAiMGI+SQ
 jNq2AwmC3qGmTmmYOsKXVr/hFn57gYJEe7ucdHPeWbpEuimdCYqt4p6T2VJ6KVJY3j0V
 zPLbJF1zw2CwO+vbevWqqDXcinnjaey4RgVpeEnVpwkAIakR7PtJtYJizB6gSUV0dK0J
 7eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758117685; x=1758722485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zriWZae3e3G7v/FbOwlYlp4gh3qQkNbfhrxiX1HUNeM=;
 b=C+KflM2vp7dO1bQ+bZIL5PDANaOrbtDAHcDHxDt4dXZs+4wofc031t1edJu+II1CbR
 Vj2hsebh701sVdQUQisbaJqbSajye0DUyP4sgi0Ych8+gYwYsRv1HUisXy1KEKWDNoyF
 0SKcwkw58+Z/xEgMqQelJRQeO4L9sWdG6nv95uX30KUmqGP5hvVRxtT1TGYQhHO0py9s
 ELGdgAwrRravhIPqMn5q6NPrK315Yjh/0MCTHU70GGufiz4SRQvCnVNEtP/rRNvP/s0E
 dAsTbK0aYwQGv3UQ5Ic3nTvPtoBJxQFKooYYff4qQ6UWbtLpz7Ymp+uVT16rFpx4yHCt
 xvyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUW8LWCWMF9Y4/HomH3eAw+jfbNULtDwpVJejOYvmFx2EdxnOhtzgftLgZxrv/2xyItaHXi5M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5qbBEPGdtSOXQRl+MtRoRjG42nxSdDUzRkOVAIAbmUZikaq7w
 uLhYBlj26FGnLZGJFScyK3TcnLciK2R0/4gIC1h9NqTNrmM4Vn2FR4MFgZeFKtg5Q3y6sDGVpQY
 WPme2GC5+nMTKvx6+rRqr1q0/HnYWQZU=
X-Gm-Gg: ASbGncshZtXfLl43v5+uYxkNwALpUTJ6Pxiz3rYJEl8XKErUZDaU1SUwTk6cm6U8SRZ
 8qaiiP0UcFg5lsOA4KLcx0ucccxTu2cO4EUkR1GsS197BulhI6G5Ep6tI7Ym7LD+DS2nll7rprD
 gYiLOCFBlNakHtubrkjDDlvn42DoPbiVWuedxosNxFs28Wv/QA4RJz4ME062vCBIjdjGZpB1qYZ
 H43/XbI
X-Google-Smtp-Source: AGHT+IHKOu1rcky6uXzEDgAVg2u8h/MNxvO8krw2SmYnXfkxnQl+p1a/K7fZGE7KNLDMpthF+nlP4acR73ETs2KyqVM=
X-Received: by 2002:a05:600c:3151:b0:45f:28cd:e033 with SMTP id
 5b1f17b1804b1-46202bf7eebmr25155995e9.10.1758117684015; Wed, 17 Sep 2025
 07:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <20250826093936.3521235-2-lukma@nabladev.com>
In-Reply-To: <20250826093936.3521235-2-lukma@nabladev.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 17 Sep 2025 17:01:05 +0300
X-Gm-Features: AS18NWBjjDhd1z4shCDFQRYtMvKDauBsrMri4REDQSHCwlXnqJUzL3R6A-T_HNw
Message-ID: <CAPVz0n3LNfmM1aN88UWRpf2=TxHSEhCVRvZ5MHLqy+eg+5BEqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add implementation of NVIDIA's Tegra 30
 watchdog driver
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 12:3=
9 Lukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This commit provides support for Tegra's 30 watchdog functionality.
> The WATCHDOG index 0 in conjunction with TIMER 5 has been used. as the
> same setup is used in Linux kernel driver.
>
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>  drivers/watchdog/Kconfig     |   7 ++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/tegra_wdt.c | 121 +++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/watchdog/tegra_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9e149a75e81..a10baed7232 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -454,6 +454,13 @@ config WDT_TANGIER
>           Intel Tangier SoC. If you're using a board with Intel Tangier
>           SoC, say Y here.
>
> +config WDT_TEGRA
> +       bool "Tegra watchdog"
> +       depends on WDT && ARCH_TEGRA
> +       help
> +         Select this to enable support for the watchdog timer
> +         embedded in NVIDIA Tegra SoCs.
> +
>  config WDT_ARM_SMC
>         bool "ARM SMC watchdog timer support"
>         depends on WDT && ARM_SMCCC
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index d52d17e1c90..02e2674f8af 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_WDT_STARFIVE) +=3D starfive_wdt.o
>  obj-$(CONFIG_WDT_STM32MP) +=3D stm32mp_wdt.o
>  obj-$(CONFIG_WDT_SUNXI) +=3D sunxi_wdt.o
>  obj-$(CONFIG_WDT_TANGIER) +=3D tangier_wdt.o
> +obj-$(CONFIG_WDT_TEGRA) +=3D tegra_wdt.o
>  obj-$(CONFIG_WDT_XILINX) +=3D xilinx_wwdt.o
>  obj-$(CONFIG_WDT_ADI) +=3D adi_wdt.o
>  obj-$(CONFIG_WDT_QCOM) +=3D qcom-wdt.o
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> new file mode 100644
> index 00000000000..812ec312fee
> --- /dev/null
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVIDIA Tegra Watchdog driver
> + *
> + * Copyright (C) 2025 NABLA Software Engineering
> + * Lukasz Majewski, NABLA Software Engineering, lukma@nabladev.com
> + */
> +
> +#include <dm.h>
> +#include <wdt.h>
> +#include <hang.h>
> +#include <asm/io.h>
> +#include <watchdog.h>
> +
> +/* Timer registers */
> +#define TIMER_PTV                      (0x0)

Here and further, use 0x0 without (), hex numbers in lower case

> +#define TIMER_EN                       BIT(31)
> +#define TIMER_PERIODIC                 BIT(30)
> +
> +/* WDT registers */
> +#define WDT_CFG                                (0x0)
> +#define WDT_CFG_PERIOD_SHIFT           4
> +#define WDT_CFG_PERIOD_MASK            GENMASK(7, 0)
> +#define WDT_CFG_INT_EN                 BIT(12)
> +#define WDT_CFG_PMC2CAR_RST_EN         BIT(15)
> +#define WDT_CMD                                (0x8)
> +#define WDT_CMD_START_COUNTER          BIT(0)
> +#define WDT_CMD_DISABLE_COUNTER                BIT(1)
> +#define WDT_UNLOCK                     (0xC)
> +#define WDT_UNLOCK_PATTERN             (0xc45a)
> +
> +/* Use watchdog ID 0 */
> +#define WDT0_BASE                      0x100
> +
> +/* Use Timer 5 as WDT counter */
> +#define WDT_TIM5_BASE                  0x60
> +#define WDT_TIM5_ID                    5
> +
> +struct tegra_wdt_priv {
> +       void __iomem *wdt_base;
> +       void __iomem *tim_base;
> +};
> +
> +static int tegra_wdt_reset(struct udevice *dev)
> +{
> +       struct tegra_wdt_priv *priv =3D dev_get_priv(dev);
> +
> +       writel(WDT_CMD_START_COUNTER, priv->wdt_base + WDT_CMD);
> +
> +       return 0;
> +}
> +
> +static int tegra_wdt_start(struct udevice *dev, u64 timeout, ulong flags=
)
> +{
> +       struct tegra_wdt_priv *priv =3D dev_get_priv(dev);
> +       u32 timeout_sec =3D timeout / 1000;
> +
> +       /*
> +        * Timer for WDT has a fixed 1MHz clock, so for 1 second period o=
ne
> +        * shall write 1000000ul.
> +        *
> +        * On Tegra the watchdog reset actually occurs on the 4th expirat=
ion
> +        * of this counter, so we set the period to 1/4.
> +        */
> +       writel(TIMER_EN | TIMER_PERIODIC | (1000000ul / 4),
> +              priv->tim_base + TIMER_PTV);
> +
> +       /* Support for timeout from 1 to 255 seconds */
> +       if (timeout_sec < 1 || timeout_sec > 255)
> +               return -EINVAL;

Check should be before any register writing is done.

> +
> +       writel(WDT_CFG_PMC2CAR_RST_EN | (timeout_sec << WDT_CFG_PERIOD_SH=
IFT) |
> +              WDT_TIM5_ID, priv->wdt_base + WDT_CFG);
> +
> +       writel(WDT_CMD_START_COUNTER, priv->wdt_base + WDT_CMD);
> +
> +       return 0;
> +}
> +
> +static int tegra_wdt_stop(struct udevice *dev)
> +{
> +       struct tegra_wdt_priv *priv =3D dev_get_priv(dev);
> +
> +       writel(WDT_UNLOCK_PATTERN, priv->wdt_base + WDT_UNLOCK);
> +       writel(WDT_CMD_DISABLE_COUNTER, priv->wdt_base + WDT_CMD);
> +       writel(0, priv->tim_base + TIMER_PTV);
> +
> +       return 0;
> +}
> +
> +static int tegra_wdt_probe(struct udevice *dev)
> +{
> +       struct tegra_wdt_priv *priv =3D dev_get_priv(dev);
> +       void __iomem *base;
> +
> +       if (!device_is_compatible(dev, "nvidia,tegra30-timer"))
> +               return -ENODEV;

Remove this restriction, it is not needed.

> +
> +       base =3D dev_read_addr_ptr(dev);
> +       if (!base)
> +               return -ENOENT;
> +
> +       priv->wdt_base =3D base + WDT0_BASE;
> +       priv->tim_base =3D base + WDT_TIM5_BASE;
> +
> +       return 0;
> +}
> +
> +static const struct wdt_ops tegra_wdt_ops =3D {
> +       .start          =3D tegra_wdt_start,
> +       .stop           =3D tegra_wdt_stop,
> +       .reset          =3D tegra_wdt_reset,
> +};
> +
> +U_BOOT_DRIVER(tegra_wdt) =3D {
> +       .name =3D "tegra_wdt",
> +       .id =3D UCLASS_WDT,
> +       .priv_auto =3D sizeof(struct tegra_wdt_priv),
> +       .probe =3D tegra_wdt_probe,
> +       .ops =3D &tegra_wdt_ops,
> +};
> --
> 2.39.5
>

Everything else seems to be fine. Apply those cosmetic changes and I
will pick your patches.
