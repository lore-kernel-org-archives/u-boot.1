Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE626CD80D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086D086B79;
	Tue, 10 Oct 2023 15:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="QDLuFEY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A3C86B87; Tue, 10 Oct 2023 15:45:02 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505B786B05
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 15:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso949798966b.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696945495; x=1697550295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s/9O7kJq8EKZVjl3N5VMv+jDIZ+mGhlBDgS6ckIu6Q8=;
 b=QDLuFEY2rSGyOYZGwGnwGQNrc0pdq3l+4zdETuExb/kcarmPXdKigKKAf86ZcK672X
 qrrak32GDxzw3tmr1QV6hIumRBgq/chp8t+VNdIlK/Ng85Im5IMOAh02+AKHHL5ymxF2
 lvqj/kSnQA+2AhLxqGQ2Avvlo/sY06SDZib8A2dLqomxCpo5AU/1/YchccQf8rWIupVX
 zUhfO9+h+Vsn/GgAe7VaPmZi9XuwmVMcmkp9NVJY0+xklGGAMlImhWhj1QbH8FgJ6C7D
 lhDM9d880noq/cUsv0+ZfONC+jw3lF1S6gr9QmYI33lRjjyAvrnnva9H0IORpQf+FFFn
 pI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696945495; x=1697550295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s/9O7kJq8EKZVjl3N5VMv+jDIZ+mGhlBDgS6ckIu6Q8=;
 b=DxivZo/CbjZKwN9Lx3P/mWSa9Y0S8O86B/nJF8/xxQ5adlVCZpFHFLtE0i56MlZxFy
 6vlgw3dN+j0pfQYeeEWQ+UR3LRgTuMSM4quQw5/O9htEsod5SjqEKZxFWey0hBKslXRI
 ShwYTQC8CmcrKhOxtVSP79I/ySV2vKjT5y6WF9mjvVbg0VNxKlzrWN7TiFSSWdxTeBwB
 CQeAnSXYZdGUUD7A4FggBDw9cqOSlpY2V0g5RpFVW55IofWz5woWlQZbkHYhpU5nP5Kr
 ikVG0LKqly9wEba8xwuCvk9sdavaLca/pEtfzz4AYZmko4wJwz4PXmRjLCkyboj9F9vl
 PYdA==
X-Gm-Message-State: AOJu0YwG/CAQAC+0jVYbYFWue0wDAvYKlWN7jHVy8ImHAecnzA9mHHdm
 NJPYfn6sGQxWgverSUFUUnNlnmk/NFQAL21jMgskbV7oGZyBq+ZuA94=
X-Google-Smtp-Source: AGHT+IHHUUrw5vTNDhp96lmYf724XYUZ9wf1D0d4DuzRsnXiOq1eUMLoqQImjnxL7jth7VoS3eIPyyfWBjEirDGpehU=
X-Received: by 2002:a17:907:7f26:b0:99d:ddae:f5d4 with SMTP id
 qf38-20020a1709077f2600b0099dddaef5d4mr20585652ejc.44.1696945495345; Tue, 10
 Oct 2023 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230919073049.1418-1-kuanlim.lee@starfivetech.com>
 <CAPnjgZ0L++Mc+P3xOBetaiB_ziXVQ5JAnSHjKunYqODQRMrwSA@mail.gmail.com>
 <ee1bf93e2a0a40c9b46cce9f7672433a@EXMBX066.cuchost.com>
In-Reply-To: <ee1bf93e2a0a40c9b46cce9f7672433a@EXMBX066.cuchost.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 10 Oct 2023 07:44:44 -0600
Message-ID: <CAPnjgZ2nhfgU7BWziYLv8Pnb-sE9eNbfRpCUvGoRQJEmipd7vA@mail.gmail.com>
Subject: Re: [PATCH] timer: starfive: Add Starfive timer support
To: "KuanLim.Lee" <kuanlim.lee@starfivetech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 WeiLiang Lim <weiliang.lim@starfivetech.com>
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

Hi,

On Wed, 4 Oct 2023 at 03:49, KuanLim.Lee <kuanlim.lee@starfivetech.com> wrote:
>
> Hi Simon,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@google.com>
> > Sent: Wednesday, October 4, 2023 10:11 AM
> > To: KuanLim.Lee <kuanlim.lee@starfivetech.com>
> > Cc: u-boot@lists.denx.de; WeiLiang Lim <weiliang.lim@starfivetech.com>
> > Subject: Re: [PATCH] timer: starfive: Add Starfive timer support
> >
> > On Tue, 19 Sept 2023 at 06:08, Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> > wrote:
> > >
> > > Add timer driver in Starfive SoC. It is an timer that outside of CPU
> > > core and inside Starfive SoC.
> > >
> > > Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> > > Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
> > > ---
> > >  drivers/timer/Kconfig          |  7 +++
> > >  drivers/timer/Makefile         |  1 +
> > >  drivers/timer/starfive-timer.c | 94
> > > ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 102 insertions(+)
> > >  create mode 100644 drivers/timer/starfive-timer.c
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > nits below
> What are the nits?
> How do the nits to be solved?

they are the things I mentioned below

> >
> > >
> > > diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig index
> > > 915b2af160..a98be9dfae 100644
> > > --- a/drivers/timer/Kconfig
> > > +++ b/drivers/timer/Kconfig
> > > @@ -326,4 +326,11 @@ config XILINX_TIMER
> > >           Select this to enable support for the timer found on
> > >           any Xilinx boards (axi timer).
> > >
> > > +config STARFIVE_TIMER
> > > +       bool "Starfive timer support"
> > > +       depends on TIMER
> > > +       help
> > > +         Select this to enable support for the timer found on
> > > +         Starfive SoC.
> >
> > What resolution is the timer? How is it clocked? Is there only one channel?
> Timer will be driven by clock pulses from clocks. The clocks are defined in device tree.
> Four channels timer, each timer has own clock source.
> Clock source frequency is gotten by clk_get_by_index () and clk_get_rate().
> The timer counter register is a 32bits size register.

OK so could you put these details in the help?

> >
> > > +
> > >  endmenu
> > > diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile index
> > > 1ca74805fd..1ef814970b 100644
> > > --- a/drivers/timer/Makefile
> > > +++ b/drivers/timer/Makefile
> > > @@ -34,3 +34,4 @@ obj-$(CONFIG_MTK_TIMER)               += mtk_timer.o
> > >  obj-$(CONFIG_MCHP_PIT64B_TIMER)        += mchp-pit64b-timer.o
> > >  obj-$(CONFIG_IMX_GPT_TIMER)    += imx-gpt-timer.o
> > >  obj-$(CONFIG_XILINX_TIMER)     += xilinx-timer.o
> > > +obj-$(CONFIG_STARFIVE_TIMER)   += starfive-timer.o
> > > diff --git a/drivers/timer/starfive-timer.c
> > > b/drivers/timer/starfive-timer.c new file mode 100644 index
> > > 0000000000..816402fdbf
> > > --- /dev/null
> > > +++ b/drivers/timer/starfive-timer.c
> > > @@ -0,0 +1,94 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2022 StarFive, Inc. All rights reserved.
> > > + *   Author: Lee Kuan Lim <kuanlim.lee@starfivetech.com>
> > > + */
> > > +
> > > +#include <common.h>
> > > +#include <clk.h>
> > > +#include <dm.h>
> > > +#include <time.h>
> > > +#include <timer.h>
> > > +#include <asm/io.h>
> > > +#include <dm/device-internal.h>
> > > +#include <linux/err.h>
> > > +
> > > +#define        STF_TIMER_INT_STATUS    0x00
> > > +#define STF_TIMER_CTL          0x04
> > > +#define STF_TIMER_LOAD         0x08
> > > +#define STF_TIMER_ENABLE       0x10
> > > +#define STF_TIMER_RELOAD       0x14
> > > +#define STF_TIMER_VALUE                0x18
> > > +#define STF_TIMER_INT_CLR      0x20
> > > +#define STF_TIMER_INT_MASK     0x24
> > > +
> > > +struct starfive_timer_priv {
> > > +       void __iomem *base;
> > > +       u32 timer_size;
> > > +};
> > > +
> > > +static u64 notrace starfive_get_count(struct udevice *dev) {
> > > +       struct starfive_timer_priv *priv = dev_get_priv(dev);
> > > +
> > > +       /* Read decrement timer value and convert to increment value */
> > > +       return priv->timer_size - readl(priv->base + STF_TIMER_VALUE);
> > > +}
> >
> > As an enhancement, you could provide a timer_early_get_count() function and
> > an easly setup, so you can use bootstage.
> >
> Is this a must? If so, I must define some fixed address to get the timer count,
> enable timer, clock source frequency because I can't get base address and
> frequency from the device tree in early stage.

No it isn't. It is useful for bootstage though. I suspect you can read
DT early, though.

> > > +
> > > +static const struct timer_ops starfive_ops = {
> > > +       .get_count = starfive_get_count, };
> > > +
> > > +static int starfive_probe(struct udevice *dev) {
> > > +       struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> > > +       struct starfive_timer_priv *priv = dev_get_priv(dev);
> > > +       int timer_channel;
> > > +       struct clk clk;
> > > +       int ret;
> > > +
> > > +       priv->base = dev_read_addr_ptr(dev);
> > > +       if (IS_ERR(priv->base))
> >
> > if (!priv->base)
> >     return -EINVAL
> >
> Noted.
> > > +               return PTR_ERR(priv->base);
> > > +
> > > +       timer_channel = dev_read_u32_default(dev, "channel", 0);
> > > +       priv->base = priv->base + (0x40 * timer_channel);
> > > +
> > > +       /* Get clock rate from channel selectecd*/
> > > +       ret = clk_get_by_index(dev, timer_channel, &clk);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = clk_enable(&clk);
> > > +       if (ret)
> > > +               return ret;
> > > +       uc_priv->clock_rate = clk_get_rate(&clk);
> > > +
> > > +       /* Initiate timer, channel 0 */
> > > +       /* Unmask Interrupt Mask */
> >
> > multi-line comment style is:
> >
> >  /*
> >   * line 1
> >   * line 2
> >   */
> >
> Noted.
> > > +       writel(0, priv->base + STF_TIMER_INT_MASK);
> > > +       /* Single run mode Setting */
> > > +       if (dev_read_bool(dev, "single-run"))
> > > +               writel(1, priv->base + STF_TIMER_CTL);
> > > +       /* Set Reload value */
> > > +       priv->timer_size = dev_read_u32_default(dev, "timer-size",
> > > + 0xffffffff);
> >
> > -1U  ?
> >
> Will replace 0xffffffff to -1U
> > > +       writel(priv->timer_size, priv->base + STF_TIMER_LOAD);
> > > +       /* Enable to start timer */
> > > +       writel(1, priv->base + STF_TIMER_ENABLE);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct udevice_id starfive_ids[] = {
> > > +       { .compatible = "starfive,jh8100-timers" },
> > > +       { }
> > > +};
> > > +
> > > +U_BOOT_DRIVER(jh8100_starfive_timer) = {
> > > +       .name           = "jh8100_starfive_timer",
> >
> Will use name " starfive_timer" instead of "jh8100_starfive_timer"
> > What is jh8100 ? Do you need that?
> >
> > > +       .id             = UCLASS_TIMER,
> > > +       .of_match       = starfive_ids,
> > > +       .probe          = starfive_probe,
> > > +       .ops            = &starfive_ops,
> > > +       .priv_auto      = sizeof(struct starfive_timer_priv),
> > > +};
> > > --
> > > 2.34.1
> > >
> >

Regards,
Simon
