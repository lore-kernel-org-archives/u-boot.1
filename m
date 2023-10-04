Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF14E8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67851871A8;
	Wed,  4 Oct 2023 04:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NxxgaYlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB22286E88; Wed,  4 Oct 2023 04:11:18 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39A186E8C
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso282791366b.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696385475; x=1696990275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hGKNAJZeGbM+fE4ctlVfTN8G4nnd4utD0IxhzwXSdbw=;
 b=NxxgaYlKD3hBbRRgY4d1qpDN0t2IQRn0lTlZnz+hG6j59t9trwiaj5nMwiFbXrguur
 5RlPfOU5ljAr2/i4RgbP4BERz05g2UCIC13qn3Q+B/2PduPPhjEZ+HSnDyFQJRt7MiXK
 rXxhbx2uxmN7qQzvOpKVDGVVharfvyrNpeBOXqvMg4ezZ8HxTL5v2VLxNDG/OX4QqWhH
 a5BzsMfHjpzNk2vFTaU39Sd1qsG/Fq1B9jp+UF8v410YQ0l7GQV3whJKly9E3EwM36mP
 ZWQNkhlhvcNUR+eq/Wmt4dNQYQy1YrFpoESR/YnryW3xovQ3koqpMDJ6hEewLJoqOFV4
 J1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385475; x=1696990275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hGKNAJZeGbM+fE4ctlVfTN8G4nnd4utD0IxhzwXSdbw=;
 b=G4oQxN+xhGDAgHZm2OuRtY8tQZHDJQ4JPYF1mEAqGHS2hMbct/Yj6VZc3ccUmG2EyO
 JW0bQYBvm/Mo6iTYDYOqjFc/EYzkeeHzmFN/aW+hKj1j8NJjsD0OrnR5mNnew2PmQJ5A
 K7pAa7Zd44iv0KqUdKZZdx1HvYM5muMSH6flhdotJZsykfwslbYUCR3CINiblXGPPlLS
 oGXreLXhhNm6U2nwYWIzIUKyGwXwlN4JuFsJH7heTn3wpTEwQTGm8LzahOukX9bC+qcz
 X5YQL+Nj/sGrcL4xTEinBHP4HJo3iB2d3HliWC2J0i3dcKIKV7v/NtKhGahpzg8P9qKX
 Dopw==
X-Gm-Message-State: AOJu0YyfCrtgkh6b5B3PnzVohJxTs4iKqSyXeb9ynDjqgWhqw6Nv/DHi
 E4vEC/8UQQ0lGAYaymjjTqma43uI8NeyWLW1hFVpQo5L7VJDAR35Exo=
X-Google-Smtp-Source: AGHT+IEFiCuv0fxQBCCn0pbOucr8nDisAcDx/5HN2o4ECU1k0heDSxQo4kZLAkw5Bm22/rf2l38/HxGznsvnYduH/Wo=
X-Received: by 2002:a17:906:76d2:b0:9a9:f14a:22fa with SMTP id
 q18-20020a17090676d200b009a9f14a22famr774928ejn.16.1696385474779; Tue, 03 Oct
 2023 19:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230919073049.1418-1-kuanlim.lee@starfivetech.com>
In-Reply-To: <20230919073049.1418-1-kuanlim.lee@starfivetech.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 3 Oct 2023 20:10:51 -0600
Message-ID: <CAPnjgZ0L++Mc+P3xOBetaiB_ziXVQ5JAnSHjKunYqODQRMrwSA@mail.gmail.com>
Subject: Re: [PATCH] timer: starfive: Add Starfive timer support
To: kuanlim.lee@starfivetech.com
Cc: u-boot@lists.denx.de, weiliang.lim@starfivetech.com
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

On Tue, 19 Sept 2023 at 06:08, Kuan Lim Lee
<kuanlim.lee@starfivetech.com> wrote:
>
> Add timer driver in Starfive SoC. It is an timer that outside
> of CPU core and inside Starfive SoC.
>
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
> ---
>  drivers/timer/Kconfig          |  7 +++
>  drivers/timer/Makefile         |  1 +
>  drivers/timer/starfive-timer.c | 94 ++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 drivers/timer/starfive-timer.c

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

>
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index 915b2af160..a98be9dfae 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -326,4 +326,11 @@ config XILINX_TIMER
>           Select this to enable support for the timer found on
>           any Xilinx boards (axi timer).
>
> +config STARFIVE_TIMER
> +       bool "Starfive timer support"
> +       depends on TIMER
> +       help
> +         Select this to enable support for the timer found on
> +         Starfive SoC.

What resolution is the timer? How is it clocked? Is there only one channel?

> +
>  endmenu
> diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
> index 1ca74805fd..1ef814970b 100644
> --- a/drivers/timer/Makefile
> +++ b/drivers/timer/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_MTK_TIMER)               += mtk_timer.o
>  obj-$(CONFIG_MCHP_PIT64B_TIMER)        += mchp-pit64b-timer.o
>  obj-$(CONFIG_IMX_GPT_TIMER)    += imx-gpt-timer.o
>  obj-$(CONFIG_XILINX_TIMER)     += xilinx-timer.o
> +obj-$(CONFIG_STARFIVE_TIMER)   += starfive-timer.o
> diff --git a/drivers/timer/starfive-timer.c b/drivers/timer/starfive-timer.c
> new file mode 100644
> index 0000000000..816402fdbf
> --- /dev/null
> +++ b/drivers/timer/starfive-timer.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 StarFive, Inc. All rights reserved.
> + *   Author: Lee Kuan Lim <kuanlim.lee@starfivetech.com>
> + */
> +
> +#include <common.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <time.h>
> +#include <timer.h>
> +#include <asm/io.h>
> +#include <dm/device-internal.h>
> +#include <linux/err.h>
> +
> +#define        STF_TIMER_INT_STATUS    0x00
> +#define STF_TIMER_CTL          0x04
> +#define STF_TIMER_LOAD         0x08
> +#define STF_TIMER_ENABLE       0x10
> +#define STF_TIMER_RELOAD       0x14
> +#define STF_TIMER_VALUE                0x18
> +#define STF_TIMER_INT_CLR      0x20
> +#define STF_TIMER_INT_MASK     0x24
> +
> +struct starfive_timer_priv {
> +       void __iomem *base;
> +       u32 timer_size;
> +};
> +
> +static u64 notrace starfive_get_count(struct udevice *dev)
> +{
> +       struct starfive_timer_priv *priv = dev_get_priv(dev);
> +
> +       /* Read decrement timer value and convert to increment value */
> +       return priv->timer_size - readl(priv->base + STF_TIMER_VALUE);
> +}

As an enhancement, you could provide a timer_early_get_count()
function and an easly setup, so you can use bootstage.

> +
> +static const struct timer_ops starfive_ops = {
> +       .get_count = starfive_get_count,
> +};
> +
> +static int starfive_probe(struct udevice *dev)
> +{
> +       struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +       struct starfive_timer_priv *priv = dev_get_priv(dev);
> +       int timer_channel;
> +       struct clk clk;
> +       int ret;
> +
> +       priv->base = dev_read_addr_ptr(dev);
> +       if (IS_ERR(priv->base))

if (!priv->base)
    return -EINVAL

> +               return PTR_ERR(priv->base);
> +
> +       timer_channel = dev_read_u32_default(dev, "channel", 0);
> +       priv->base = priv->base + (0x40 * timer_channel);
> +
> +       /* Get clock rate from channel selectecd*/
> +       ret = clk_get_by_index(dev, timer_channel, &clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_enable(&clk);
> +       if (ret)
> +               return ret;
> +       uc_priv->clock_rate = clk_get_rate(&clk);
> +
> +       /* Initiate timer, channel 0 */
> +       /* Unmask Interrupt Mask */

multi-line comment style is:

 /*
  * line 1
  * line 2
  */

> +       writel(0, priv->base + STF_TIMER_INT_MASK);
> +       /* Single run mode Setting */
> +       if (dev_read_bool(dev, "single-run"))
> +               writel(1, priv->base + STF_TIMER_CTL);
> +       /* Set Reload value */
> +       priv->timer_size = dev_read_u32_default(dev, "timer-size", 0xffffffff);

-1U  ?

> +       writel(priv->timer_size, priv->base + STF_TIMER_LOAD);
> +       /* Enable to start timer */
> +       writel(1, priv->base + STF_TIMER_ENABLE);
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id starfive_ids[] = {
> +       { .compatible = "starfive,jh8100-timers" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(jh8100_starfive_timer) = {
> +       .name           = "jh8100_starfive_timer",

What is jh8100 ? Do you need that?

> +       .id             = UCLASS_TIMER,
> +       .of_match       = starfive_ids,
> +       .probe          = starfive_probe,
> +       .ops            = &starfive_ops,
> +       .priv_auto      = sizeof(struct starfive_timer_priv),
> +};
> --
> 2.34.1
>

Regards,
Simon
