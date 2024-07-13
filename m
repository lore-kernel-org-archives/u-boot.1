Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26CAC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BC888805;
	Sat, 13 Jul 2024 17:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fCQQ9HO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43013887BF; Sat, 13 Jul 2024 17:13:55 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED350887F3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b5dfa44f24so15782516d6.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883632; x=1721488432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6mT7AudKqWj/PR4UoI38YU1EIMIwQhaBkO2QVf9WyNc=;
 b=fCQQ9HO+IpUX46+/MhyxEcymTS7k/HNhjuhXPSuoYghM6pprP6O1t1JGks+Tfs7Bef
 Z5d7Fv2dQkJ38q4cJJBUmYDlCZU3zvRbcfdIFDyROdWxyME1TsAiEPD/taWx6A7owcbr
 WB779nHmhfOkJe+6UCt4uwe2mrX8tW9ONBpeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883632; x=1721488432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mT7AudKqWj/PR4UoI38YU1EIMIwQhaBkO2QVf9WyNc=;
 b=vUsI/+1z+z8kZmaXH4EknkKhgjRBgtTLwoqSZaC8A9hJQIbGpqSToCYHbjrRdonlNt
 BfWQo9kveyboDatm6xd6zs6ne+bioREMyLt85VIdnigO5Pqsd9QZt0G3KrRcp+8DVCvg
 I+5bTPlc1CIZ9nClJi+DRcW8e0zDyZqwxDi3pz/mw6Dhaw0BfAXfSUSiDCj73VVuq8zq
 TQyG5BM58FwoHxomTaxT6lBIq0py+ji9KHxFkX4tGYI1/aqcoEGlFneEv17cZF1P1yUz
 ALmaUiLvIksXrfiFcSypNqnrTgJ8lyo9WnSF8L3/3uDGB3sEtvoFOKLSwsmmDDbw4ePQ
 K6QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWBp1YS3MM00mO/GmvbrceeHY96YxlBrBLMliDZyjVjWIhxwtxg8CGctY4nELuKOXDOPR8tZE0dqQLI49ih6uB9zrPg==
X-Gm-Message-State: AOJu0YycWO4riByhCZ2ydjUXVh1rKgMM1lNLoJKhledBq1f0j1GlLXk8
 Y2jxTnblZQNdqQxwBFVbpG+9haDBEcMAi5o3KWjC/mhpYJH/wGAK/pGLPWOOGoXIRj+Je5b3rxd
 aIZP8wMRGpb0duoPme0YoUuZIZum3+M6Exvs2Y568lL6SXk0=
X-Google-Smtp-Source: AGHT+IEXi8mIiRk8HXxotIn/YctPxAPgKnTmOM1t6dRYpmdRflhmrugfdXKyS8Tt4CAtXP1dYeJahll3Fda2XTMaoKk=
X-Received: by 2002:a05:6214:404:b0:6b5:da50:ac1f with SMTP id
 6a1803df08f44-6b61bf5d57emr181540176d6.38.1720883631845; Sat, 13 Jul 2024
 08:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
 <20240712052507.2496669-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240712052507.2496669-2-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:40 +0100
Message-ID: <CAFLszTgL2tYURExFDrjHP4GMZn5zn0Ho0uKt_w5P1KPFvTEyzA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] led: Implement software led blinking
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
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

Hi Mikhail,

On Fri, 12 Jul 2024 at 06:25, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>
> If hardware (or driver) doesn't support leds blinking, it's
> now possible to use software implementation of blinking instead.
> This relies on cyclic functions.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/Kconfig        |  14 +++++
>  drivers/led/Makefile       |   1 +
>  drivers/led/led-uclass.c   |  19 +++++--
>  drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
>  include/led.h              |  17 ++++++
>  5 files changed, 154 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/led/led_sw_blink.c
>
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 9837960198d..dc9d4c8a757 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -73,6 +73,20 @@ config LED_BLINK
>           This option enables support for this which adds slightly to the
>           code size.
>
> +config LED_SW_BLINK
> +       bool "Support software LED blinking"
> +       depends on LED_BLINK
> +       select CYCLIC
> +       help
> +         Turns on led blinking implemented in the software, useful when
> +         the hardware doesn't support led blinking. Half of the period
> +         led will be ON and the rest time it will be OFF. Standard
> +         led commands can be used to configure blinking. Does nothing
> +         if driver supports blinking.
> +         WARNING: Blinking may be inaccurate during execution of time
> +         consuming commands (ex. flash reading). Also it completely
> +         stops during OS booting.
> +
>  config SPL_LED
>         bool "Enable LED support in SPL"
>         depends on SPL_DM
> diff --git a/drivers/led/Makefile b/drivers/led/Makefile
> index 2bcb8589087..e27aa488482 100644
> --- a/drivers/led/Makefile
> +++ b/drivers/led/Makefile
> @@ -4,6 +4,7 @@
>  # Written by Simon Glass <sjg@chromium.org>
>
>  obj-y += led-uclass.o
> +obj-$(CONFIG_LED_SW_BLINK) += led_sw_blink.o
>  obj-$(CONFIG_LED_BCM6328) += led_bcm6328.o
>  obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
>  obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index f37bf6a1550..4f5dd66765e 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -58,6 +58,10 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
>         if (!ops->set_state)
>                 return -ENOSYS;
>
> +       if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
> +           led_sw_on_state_change(dev, state))
> +               return 0;
> +
>         return ops->set_state(dev, state);
>  }
>
> @@ -68,6 +72,12 @@ enum led_state_t led_get_state(struct udevice *dev)
>         if (!ops->get_state)
>                 return -ENOSYS;
>
> +#ifdef CONFIG_LED_BLINK

It looks like you can use if (IS_ENABLED...) for that ^

> +       if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
> +           led_sw_is_blinking(dev))
> +               return LEDST_BLINK;
> +#endif
> +
>         return ops->get_state(dev);
>  }
>
> @@ -76,10 +86,13 @@ int led_set_period(struct udevice *dev, int period_ms)
>  {
>         struct led_ops *ops = led_get_ops(dev);
>
> -       if (!ops->set_period)
> -               return -ENOSYS;
> +       if (ops->set_period)
> +               return ops->set_period(dev, period_ms);
> +
> +       if (IS_ENABLED(CONFIG_LED_SW_BLINK))
> +               return led_sw_set_period(dev, period_ms);
>
> -       return ops->set_period(dev, period_ms);
> +       return -ENOSYS;
>  }
>  #endif
>
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> new file mode 100644
> index 00000000000..ab56111a60b
> --- /dev/null
> +++ b/drivers/led/led_sw_blink.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Software blinking helpers
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <dm.h>
> +#include <led.h>
> +#include <time.h>
> +#include <stdlib.h>
> +
> +static void led_sw_blink(struct cyclic_info *c)
> +{
> +       struct led_uc_plat *uc_plat;
> +       struct udevice *dev;
> +       struct led_ops *ops;
> +
> +       uc_plat = container_of(c, struct led_uc_plat, cyclic);
> +       dev = uc_plat->dev;
> +       ops = led_get_ops(dev);
> +
> +       switch (uc_plat->sw_blink_state) {
> +       case LED_SW_BLINK_ST_OFF:
> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_ON;
> +               ops->set_state(dev, LEDST_ON);
> +               break;
> +       case LED_SW_BLINK_ST_ON:
> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
> +               ops->set_state(dev, LEDST_OFF);
> +               break;
> +       case LED_SW_BLINK_ST_NOT_READY:
> +               /*
> +                * led_set_period has been called, but
> +                * led_set_state(LDST_BLINK) has not yet,
> +                * so doing nothing
> +                */
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +int led_sw_set_period(struct udevice *dev, int period_ms)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +       struct cyclic_info *cyclic = &uc_plat->cyclic;
> +       struct led_ops *ops = led_get_ops(dev);
> +       int half_period_us;
> +       char *name;
> +       int len;
> +
> +       half_period_us = period_ms * 1000 / 2;
> +
> +       name = (char *)cyclic->name;
> +       if (name == NULL) {

if (!name)

> +               len = snprintf(NULL, 0, "led_sw_blink_%s", uc_plat->label);
> +               if (len <= 0)
> +                       return -ENOMEM;
> +
> +               name = malloc(len + 1);
> +               if (!name)
> +                       return -ENOMEM;
> +
> +               snprintf(name, len + 1, "led_sw_blink_%s", uc_plat->label);

I think it would be OK to have a fixed-length name (say 20-30 chars)
and use snprintf()...would reduce the code size.

> +       }
> +
> +       if (uc_plat->sw_blink_state == LED_SW_BLINK_ST_DISABLED) {
> +               uc_plat->dev = dev;
> +               cyclic_register(cyclic, led_sw_blink, half_period_us, name);
> +       } else {
> +               cyclic->delay_us = half_period_us;
> +               cyclic->start_time_us = timer_get_us();
> +       }
> +
> +       uc_plat->sw_blink_state = LED_SW_BLINK_ST_NOT_READY;
> +       ops->set_state(dev, LEDST_OFF);
> +
> +       return 0;
> +}
> +
> +bool led_sw_is_blinking(struct udevice *dev)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +       return (uc_plat->sw_blink_state > LED_SW_BLINK_ST_NOT_READY);

drop ()

> +}
> +
> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +       if (uc_plat->sw_blink_state != LED_SW_BLINK_ST_DISABLED) {
> +               if (state == LEDST_BLINK) {
> +                       /* start blinking on next led_sw_blink() call */
> +                       uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
> +                       return true;
> +               }
> +
> +               /* stop blinking */
> +               cyclic_unregister(&uc_plat->cyclic);
> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_DISABLED;
> +       }
> +
> +       return false;
> +}
> diff --git a/include/led.h b/include/led.h
> index a6353166289..26955269d3e 100644
> --- a/include/led.h
> +++ b/include/led.h
> @@ -20,6 +20,13 @@ enum led_state_t {
>         LEDST_COUNT,
>  };
>
> +enum led_sw_blink_state_t {
> +       LED_SW_BLINK_ST_DISABLED,
> +       LED_SW_BLINK_ST_NOT_READY,
> +       LED_SW_BLINK_ST_OFF,
> +       LED_SW_BLINK_ST_ON,
> +};
> +
>  /**
>   * struct led_uc_plat - Platform data the uclass stores about each device
>   *
> @@ -29,6 +36,11 @@ enum led_state_t {
>  struct led_uc_plat {
>         const char *label;
>         enum led_state_t default_state;
> +#ifdef CONFIG_LED_SW_BLINK
> +       struct udevice *dev;
> +       struct cyclic_info cyclic;
> +       enum led_sw_blink_state_t sw_blink_state;
> +#endif
>  };
>
>  /**
> @@ -118,4 +130,9 @@ int led_set_period(struct udevice *dev, int period_ms);
>   */
>  int led_bind_generic(struct udevice *parent, const char *driver_name);
>
> +/* Internal functions for software blinking. Do not use them in your code */
> +int led_sw_set_period(struct udevice *dev, int period_ms);
> +bool led_sw_is_blinking(struct udevice *dev);
> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
> +
>  #endif
> --
> 2.39.2
>

Regards,
Simon
