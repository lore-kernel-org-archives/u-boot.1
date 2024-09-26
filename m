Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE401CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C7688EAB;
	Thu, 26 Sep 2024 23:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGjdcE9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B5F88E6F; Thu, 26 Sep 2024 23:33:35 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F0D88E77
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6c54a5fbceeso8667956d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386411; x=1727991211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Bv7sZAIXPxgxd9xQNUwpfrk2rJ/3nLh6UYaObnhpEk=;
 b=RGjdcE9TAKjIzhM/A9yS0+3A4llYpEAZY1hNjqJwh8aU8q6oQNvm63+rvQbbXVmEUh
 YGz12cZgJEQ1VppEnt9NkPNNXAmVxVeRMHP2j0WVFZRSiwK2432mHf+ae84Gs5EhycKk
 d3uJJQXQsp9XstTOe15QHwUJaqDDFeBHAewc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386411; x=1727991211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Bv7sZAIXPxgxd9xQNUwpfrk2rJ/3nLh6UYaObnhpEk=;
 b=C8HseZCCfbVa8doAHkzrkKZ1ukTMNJP9VzW4g6XeVvB4x8qaGkTDE/NgxXq+MiFyBM
 S8ov8AlJxeCif8oELLGMNsPUMTiPYoVQYdNXJBM8DJn4vWX2tTLIbvzbGsw8HZ+a7/EP
 IQPgU4k9NDw3w9j3UfPoTlwDKcs3KALXD6RI3S6JAj/aP05pXqoHlIFLQ1TGPL+xO/zC
 3Z7NOEJ/Uh15f8ZcmRZ/9z35nbvJFAspGezlhaEwS9kvrRQ38TxviHQ/OCMuLey1RJoq
 7rJzzLaxtxhOiirn0NsBSFXbtEyAc6fwbxCaVCos77pB5dy5mtkjhttKH5Nf6eaZNT9M
 xA7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAh5IB2FR7/E7znR4zF1Cngte1gn5OUiGMWi8DrB3O3eSEfhjyUJ1u1TjbpOPKScUpqI/ZiJc=@lists.denx.de
X-Gm-Message-State: AOJu0YzIE10vlOOLeWjrZ3m7KJJVbnvyDor0V69Tku2mLzFqn4zpXm0a
 i07tzt44kStqYeaNRIkMo0HvtAG3aEdv2uGakXRMXxU4Cqq24dYHtjQbO+iDBEiogScDSIwQoyB
 SICcTjkNvgsdMENGsoDL0hsjPprfZyemtqGsa
X-Google-Smtp-Source: AGHT+IENFiBok5orkLsyMjVDQYBJOXkPFOGKH5ebKcsXvfZK17dA4K/pyCbcyG5v7jj/Ejx4tkAD9fhAHL8i2HWaHUw=
X-Received: by 2002:a05:6214:328e:b0:6cb:2ad6:78ef with SMTP id
 6a1803df08f44-6cb3b5c6732mr14222826d6.4.1727386411517; Thu, 26 Sep 2024
 14:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-4-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:18 +0200
Message-ID: <CAFLszThtgGo9aszNyB45rBbWB1FPsiao1CKeiAARZnGqDhc2jA@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] led: implement LED boot API
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

Hi Christian,

On Sat, 21 Sept 2024 at 00:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement LED boot API to signal correct boot of the system.
>
> led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> designated boot LED.
>
> New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> This makes use of the /options/u-boot property "boot-led" to the
> define the boot LED.
> It's also introduced a new /options/u-boot property "boot-led-period"
> to define the default period when the LED is set to blink mode.
>
> If "boot-led-period" is not defined, the value of 250 (ms) is
> used by default.
>
> If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> led_boot_blink call will fallback to simple LED ON.
>
> To cache the data we repurpose the now unused led_uc_priv for storage of
> global LED uclass info.

Some things to tweak below

>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/Kconfig      |   7 +++
>  drivers/led/led-uclass.c | 100 +++++++++++++++++++++++++++++++++++++++
>  include/led.h            |  56 +++++++++++++++++++++-
>  3 files changed, 161 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index bee74b25751..6149cfa02b8 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -9,6 +9,13 @@ config LED
>           can provide access to board-specific LEDs. Use of the device tree
>           for configuration is encouraged.
>
> +config LED_BOOT
> +       bool "Enable LED boot support"
> +       help
> +         Enable LED boot support.
> +
> +         LED boot is a specific LED assigned to signal boot operation status.

Here you should link to the /options binding in
doc/device-tree-bindings/options, perhaps

> +
>  config LED_BCM6328
>         bool "LED Support for BCM6328"
>         depends on LED && ARCH_BMIPS
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 199d68bc25a..c5b560982b0 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -94,17 +94,101 @@ int led_set_period(struct udevice *dev, int period_ms)
>         return -ENOSYS;
>  }
>
> +#ifdef CONFIG_LED_BOOT
> +int led_boot_on(void)
> +{
> +       struct uclass *uc = uclass_find(UCLASS_LED);
> +       struct led_uc_priv *priv;
> +       struct udevice *dev;
> +
> +       if (!uc)
> +               return -ENOENT;
> +

The normal way is:

ret = uclass_first_device_ret(UCLASS_LED, &dev);
if (ret)
   return ret;

> +       priv = uclass_get_priv(uc);
> +       if (!priv->boot_led_dev ||
> +           uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {

That is an internal function...I suppose it should really have an
underscore and be in uclass-internal.h

But if you are looking for boot_led_label, don't you need to search
through the LEDs to find it? Or use led_get_by_label() ?

> +               printf("Failed to get boot LED %s\n",
> +                      priv->boot_led_label);
> +               return -EINVAL;
> +       }
> +
> +       return led_set_state(dev, LEDST_ON);
> +}
> +
> +int led_boot_off(void)
> +{
> +       struct uclass *uc = uclass_find(UCLASS_LED);
> +       struct led_uc_priv *priv;
> +       struct udevice *dev;
> +
> +       if (!uc)
> +               return -ENOENT;
> +

Same here.

> +       priv = uclass_get_priv(uc);
> +       if (!priv->boot_led_dev ||
> +           uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
> +               printf("Failed to get boot LED %s\n",
> +                      priv->boot_led_label);
> +               return -EINVAL;
> +       }
> +
> +       return led_set_state(dev, LEDST_OFF);
> +}
> +
> +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
> +int led_boot_blink(void)
> +{
> +       struct uclass *uc = uclass_find(UCLASS_LED);
> +       struct led_uc_priv *priv;
> +       struct udevice *dev;
> +       int ret;
> +
> +       if (!uc)
> +               return -ENOENT;
> +
> +       priv = uclass_get_priv(uc);
> +       if (!priv->boot_led_dev ||
> +           uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
> +               printf("Failed to get boot LED %s\n",
> +                      priv->boot_led_label);
> +               return -EINVAL;
> +       }

This looks like the same code again. I think it should be in a
function so the code is not repeated.

> +
> +       ret = led_set_period(dev, priv->boot_led_period);
> +       if (ret) {
> +               if (ret != -ENOSYS)
> +                       return ret;
> +
> +               /* fallback to ON with no set_period and no SW_BLINK */
> +               return led_set_state(dev, LEDST_ON);
> +       }
> +
> +       return led_set_state(dev, LEDST_BLINK);
> +}
> +#endif
> +#endif
> +
>  static int led_post_bind(struct udevice *dev)
>  {
>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>         const char *default_state;
>
> +#ifdef CONFIG_LED_BOOT
> +       struct led_uc_priv *priv = uclass_get_priv(dev->uclass);
> +#endif
> +
>         if (!uc_plat->label)
>                 uc_plat->label = dev_read_string(dev, "label");
>
>         if (!uc_plat->label && !dev_read_string(dev, "compatible"))
>                 uc_plat->label = ofnode_get_name(dev_ofnode(dev));
>
> +#ifdef CONFIG_LED_BOOT
> +       /* check if we are binding boot LED and assign it */
> +       if (!strcmp(priv->boot_led_label, uc_plat->label))
> +               priv->boot_led_dev = dev;
> +#endif
> +
>         uc_plat->default_state = LEDST_COUNT;
>
>         default_state = dev_read_string(dev, "default-state");
> @@ -158,10 +242,26 @@ static int led_post_probe(struct udevice *dev)
>         return ret;
>  }
>
> +#ifdef CONFIG_LED_BOOT
> +static int led_init(struct uclass *uc)
> +{
> +       struct led_uc_priv *priv = uclass_get_priv(uc);
> +
> +       priv->boot_led_label = ofnode_options_read_str("boot-led");
> +       priv->boot_led_period = ofnode_options_read_int("boot-led-period", 250);
> +
> +       return 0;
> +}
> +#endif
> +
>  UCLASS_DRIVER(led) = {
>         .id             = UCLASS_LED,
>         .name           = "led",
>         .per_device_plat_auto   = sizeof(struct led_uc_plat),
>         .post_bind      = led_post_bind,
>         .post_probe     = led_post_probe,
> +#ifdef CONFIG_LED_BOOT
> +       .init           = led_init,
> +       .priv_auto      = sizeof(struct led_uc_priv),
> +#endif

I don't love all these #ifdefs but I suppose it is OK here. Ideally we
would have static inline accessors for the fields, in the header file,
e.g. like asm-generic/global_data.h

>  };
> diff --git a/include/led.h b/include/led.h
> index 99f93c5ef86..ca495217777 100644
> --- a/include/led.h
> +++ b/include/led.h
> @@ -9,6 +9,7 @@
>
>  #include <stdbool.h>
>  #include <cyclic.h>
> +#include <dm/ofnode.h>
>
>  struct udevice;
>
> @@ -52,10 +53,16 @@ struct led_uc_plat {
>  /**
>   * struct led_uc_priv - Private data the uclass stores about each device
>   *
> - * @period_ms: Flash period in milliseconds
> + * @boot_led_label:    Boot LED label
> + * @boot_led_dev:      Boot LED dev
> + * @boot_led_period:   Boot LED blink period
>   */
>  struct led_uc_priv {
> -       int period_ms;
> +#ifdef CONFIG_LED_BOOT
> +       const char *boot_led_label;
> +       struct udevice *boot_led_dev;
> +       int boot_led_period;
> +#endif
>  };
>
>  struct led_ops {
> @@ -141,4 +148,49 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
>  bool led_sw_is_blinking(struct udevice *dev);
>  bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
>
> +#ifdef CONFIG_LED_BOOT
> +
> +/**
> + * led_boot_on() - turn ON the designated LED for booting
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int led_boot_on(void);
> +
> +/**
> + * led_boot_off() - turn OFF the designated LED for booting
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int led_boot_off(void);
> +
> +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
> +/**
> + * led_boot_blink() - turn ON the designated LED for booting
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int led_boot_blink(void);
> +
> +#else
> +/* If LED BLINK is not supported/enabled, fallback to LED ON */
> +#define led_boot_blink led_boot_on
> +#endif
> +#else
> +static inline int led_boot_on(void)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int led_boot_off(void)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int led_boot_blink(void)
> +{
> +       return -ENOSYS;
> +}
> +#endif
> +
>  #endif
> --
> 2.45.2
>

Regards,
Simon
