Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBB4C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 08:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F80B887C1;
	Wed,  3 Jul 2024 10:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G946Ysd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB3B887E7; Wed,  3 Jul 2024 10:08:24 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B6988155
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b5cf1b8b94so7961026d6.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719994101; x=1720598901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OIXg6rDGmSjP8hUj2ySvmH9uDPF9mzterb0iANbwML4=;
 b=G946Ysd3A2O6Y+MBvmayZw5EA4L9wG2/FLczmqd/AFzlcbgdPYUqZCs3/xiAhZLMCz
 NDYQYOsdgczEymWLBiZbbxbWXkRUo2n8Nn64XPnTdk7jNZ0upeWm8er6jSYLkWf//EQI
 WIV3QnpZTBLv2+ecKlkRisADbSBiPHi6MS98I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719994101; x=1720598901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIXg6rDGmSjP8hUj2ySvmH9uDPF9mzterb0iANbwML4=;
 b=EG7fnFuItjw2SDM/O6qgwrdDjdQm2TXisW1ikU8MEItzPrlTeNS3IcrbhQ3Sv3eu2E
 rjXEYs89oOKXZ1kava7yRWmd2ncsV4ecrGbJTH3oB2gtUuoa25wFlgSE4ldC8IVgSCj/
 B27QJhWuYWIoMf9oI8g9z0pnyyatrnQ9JpYLGgGgP5tq/QP7hSwkqn19aKko8yHq4dq0
 K+pXYP6Po/o1YaTZf9hMqrq40jQDpjdlL4x/jKcdCxfDFXwD4QQr9wFp4NdQzk8tQSxd
 R35WI5tP+/MhJ41eBhuqqU7+9fnBdgCW7aDzlp/MDQ17hWL6hxYJqYiO5Ccd2k30Qxt/
 1wiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWqEEl1f/XIh8c70/u1XEkAtFMIzxRhmrYrY/bxQ/vI/t6owRdYbktyNUmVzZMcPVT4AhMmkEmUaBDTbq5xJxPX5kIBQ==
X-Gm-Message-State: AOJu0Yx0iHQ7nSNalJSgN+3yQN5ersARoPFz+pCMdATwT8nD2zGkDpPi
 gMQ5KgOpQJSzfC3PGGfNmEysznLycmfkQszjROMOB3Bvik+SlKtBNjsMyHGZyM0VluXE7xGQKbn
 PCMQnIupAD1lyarSnOOUjdI/jazfbbAFL4GXr
X-Google-Smtp-Source: AGHT+IEOkcHfYtsKGupMLvCTO3ljUG5up6TYe76AxQgNyp6b6h9KEhYy77yQimXkjIPzxA6MJODz/q9xN5qRSqxu23E=
X-Received: by 2002:a05:6214:21a8:b0:6b5:df8d:4a3b with SMTP id
 6a1803df08f44-6b5df8d4c6cmr17496166d6.18.1719994100729; Wed, 03 Jul 2024
 01:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
 <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
 <20240703010131.1735100-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240703010131.1735100-2-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jul 2024 09:08:10 +0100
Message-ID: <CAFLszTh3ufDxkFkLWaYgP6Sd7kCL-0oMZWkjFtwHfztW_iYaJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] led: Implement software led blinking
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
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

On Wed, 3 Jul 2024 at 02:02, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>
> If hardware (or driver) doesn't support leds blinking, it's
> now possible to use software implementation of blinking instead.
> This relies on cyclic functions.
>
> v2 changes:
>  * Drop sw_blink_state structure, move its necessary fields to
>    led_uc_plat structure.
>  * Add cyclic_info pointer to led_uc_plat structure. This
>    simplify code a lot.
>  * Remove cyclic function search logic. Not needed anymore.
>  * Fix blinking period. It was twice large.
>  * Other cleanups.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

LGTM except for the #ifdefs...I've put an idea below.

> ---
>  drivers/led/Kconfig      |  14 ++++++
>  drivers/led/led-uclass.c | 102 +++++++++++++++++++++++++++++++++++++++
>  include/led.h            |  12 +++++
>  3 files changed, 128 insertions(+)
>
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 9837960198d..1afb081df11 100644
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
> +         consuming commands (ex. flash reading). Also it will completely
> +         stops during OS booting.

Drop the word 'will'

> +
>  config SPL_LED
>         bool "Enable LED support in SPL"
>         depends on SPL_DM
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index a4be56fc258..d021c3bbf20 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -52,6 +52,94 @@ int led_get_by_label(const char *label, struct udevice **devp)
>         return -ENODEV;
>  }
>
> +#ifdef CONFIG_LED_SW_BLINK

You can put this block into a separate file, like led_blink.c and
export the functions, since it accesses members which are behind an
#ifdef

obj-$(CONFIG_LED_SW_BLINK) += led_blink.o

> +static void led_sw_blink(void *data)
> +{
> +       struct udevice *dev = data;
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +       struct led_ops *ops = led_get_ops(dev);
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
> +       case LED_SW_BLINK_ST_NONE:
> +               /*
> +                * led_set_period has been called, but
> +                * led_set_state(LDST_BLINK) has not yet,
> +                * so doing nothing
> +                */
> +               break;
> +       }
> +}
> +
> +static int led_sw_set_period(struct udevice *dev, int period_ms)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +       struct cyclic_info *cyclic = uc_plat->cyclic;
> +       struct led_ops *ops = led_get_ops(dev);
> +       char cyclic_name[64];
> +       int half_period_us;
> +
> +       uc_plat->sw_blink_state = LED_SW_BLINK_ST_NONE;
> +       ops->set_state(dev, LEDST_OFF);
> +
> +       half_period_us = period_ms * 1000 / 2;
> +
> +       if (cyclic) {
> +               cyclic->delay_us = half_period_us;
> +               cyclic->start_time_us = timer_get_us();
> +       } else {
> +               snprintf(cyclic_name, sizeof(cyclic_name),
> +                        "led_sw_blink_%s", uc_plat->label);
> +
> +               cyclic = cyclic_register(led_sw_blink, half_period_us,
> +                                        cyclic_name, dev);
> +               if (!cyclic) {
> +                       log_err("Registering of blinking function for %s failed\n",
> +                               uc_plat->label);
> +                       return -ENOMEM;
> +               }
> +
> +               uc_plat->cyclic = cyclic;
> +       }
> +
> +       return 0;
> +}
> +
> +static bool led_sw_is_blinking(struct udevice *dev)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +       return (uc_plat->sw_blink_state != LED_SW_BLINK_ST_NONE);
> +}
> +
> +static bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +       if (uc_plat->cyclic) {
> +               if (state == LEDST_BLINK) {
> +                       /* start blinking on next led_sw_blink() call */
> +                       uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
> +                       return true;
> +               }
> +
> +               /* stop blinking */
> +               cyclic_unregister(uc_plat->cyclic);
> +               uc_plat->cyclic = NULL;
> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_NONE;
> +       }
> +
> +       return false;
> +}
> +#endif /* CONFIG_LED_SW_BLINK */
> +
>  int led_set_state(struct udevice *dev, enum led_state_t state)
>  {
>         struct led_ops *ops = led_get_ops(dev);
> @@ -59,6 +147,11 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
>         if (!ops->set_state)
>                 return -ENOSYS;
>
> +#ifdef CONFIG_LED_SW_BLINK

Then these #ifdefs should be able to change to

if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
    led_sw_on_state_change(dev, state))
...

I suppose static inlines are another way if you prefer, but as there
is only one caller it probably isn't worth it.

> +       if (led_sw_on_state_change(dev, state))
> +               return 0;
> +#endif
> +
>         return ops->set_state(dev, state);
>  }
>
> @@ -69,6 +162,11 @@ enum led_state_t led_get_state(struct udevice *dev)
>         if (!ops->get_state)
>                 return -ENOSYS;
>
> +#ifdef CONFIG_LED_SW_BLINK
> +       if (led_sw_is_blinking(dev))
> +               return LEDST_BLINK;
> +#endif
> +
>         return ops->get_state(dev);
>  }
>
> @@ -78,7 +176,11 @@ int led_set_period(struct udevice *dev, int period_ms)
>         struct led_ops *ops = led_get_ops(dev);
>
>         if (!ops->set_period)
> +#ifdef CONFIG_LED_SW_BLINK
> +               return led_sw_set_period(dev, period_ms);
> +#else
>                 return -ENOSYS;
> +#endif
>
>         return ops->set_period(dev, period_ms);
>  }
> diff --git a/include/led.h b/include/led.h
> index a6353166289..bd50fdf33ef 100644
> --- a/include/led.h
> +++ b/include/led.h
> @@ -20,6 +20,14 @@ enum led_state_t {
>         LEDST_COUNT,
>  };
>
> +#ifdef CONFIG_LED_SW_BLINK

can drop this #ifdef

> +enum led_sw_blink_state_t {
> +       LED_SW_BLINK_ST_NONE = 0,
> +       LED_SW_BLINK_ST_OFF = 1,
> +       LED_SW_BLINK_ST_ON = 2,
> +};
> +#endif
> +
>  /**
>   * struct led_uc_plat - Platform data the uclass stores about each device
>   *
> @@ -29,6 +37,10 @@ enum led_state_t {
>  struct led_uc_plat {
>         const char *label;
>         enum led_state_t default_state;
> +#ifdef CONFIG_LED_SW_BLINK
> +       enum led_sw_blink_state_t sw_blink_state;
> +       struct cyclic_info *cyclic;
> +#endif
>  };
>

Need to add function prototypes here for flashing API.

>  /**
> --
> 2.39.2
>

Regards,
Simon
