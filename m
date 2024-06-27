Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B28C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADCCE8854E;
	Thu, 27 Jun 2024 21:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SOnXRlw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4068854E; Thu, 27 Jun 2024 21:05:59 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2BF884F9
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c7dd54d3d2so6630566a91.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719515155; x=1720119955; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZB6N4Lq7tDWVhcOGXqli0iZIT0AOQYtNdFsx8z+KMAg=;
 b=SOnXRlw77Yntn4EW4jQnYnKg9XYotxR6ZrgkgE2pOPeT6G1SDm7EmnRgjBcDEVeAFB
 oL6+7tMhDITAouOxE7W2/KI2/ADVfex2Gj4okh0CEGmwTV+Vvd2SNahkCso6wQI3V5Lt
 E5YKL7q5rcp2Tqh5raEX7ywUlnccRGWuBHvc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719515155; x=1720119955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZB6N4Lq7tDWVhcOGXqli0iZIT0AOQYtNdFsx8z+KMAg=;
 b=pYfJZYpbR0MEjDx4YJ9TQvwZfuGr+VqxLvEx0GXX75DRVnpv7bfw5+DVEjNqMiNaW0
 V22dVuwl9NNHKGFoFgJQNd1HzsJiBRhuYBxN8p7fLTwJctS0W8Y8V/Q83kw/cZFIg6tp
 9Sjpto59maR3dhV/tUNE9Joy1rh73gR6GGFYDDudxvst/YDS62yiwpa966wy4YQE40c9
 Zbh1NuhuUjai9MEz5SaTi6URN/Ys2yffsJGICUhjEVRPRrsViBJAUSiOEOjeKqjD6l4d
 AaX0ziMehbTSdAuHpZVqFFU7GjhgmLoUy8gJzdE8GvauuXCw/t0tL4vNaVaPXibi2rLy
 w4jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGjIkBA1n7dERCrOWZC0VTUjHgjHflcynV8TEuD+NPIn17M/j7T0Hq/Mdn+ku7Uu94isjSemnLdCNgXAncToISf9SYVw==
X-Gm-Message-State: AOJu0YwO6U47KrjV5yEgAAW3nzvSgkPxK/Z13cFJO4X3csutOOw3Qv5i
 Y82QFq5fBjYnapSmWzKuLsYsr5fYYD5vy4YKPKCh+86U5yuWgnWz+aoUmJmYg+mbKt5Jky7Sixg
 dcJY11iX1K4t89pVrApadP+NIE2XtNjoShkva
X-Google-Smtp-Source: AGHT+IGvhl0CnvvIZ080wZlXreSh3RmW2l6A+5hrcrjXHkqJAzFR4rhv1Pocm/e0pVVv1itC3F28etuSj5XMsLKhNTc=
X-Received: by 2002:a17:90a:6885:b0:2c7:e24d:f695 with SMTP id
 98e67ed59e1d1-2c861246b47mr13553796a91.12.1719515155432; Thu, 27 Jun 2024
 12:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 20:05:43 +0100
Message-ID: <CAFLszTiQubBhXf5585htt9tJUNDxkJKmM3r3Kg8r1Zmrk8Rf0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] led: Implement software led blinking
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de, 
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

On Thu, 27 Jun 2024 at 12:31, Mikhail Kshevetskiy
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
>  drivers/led/Kconfig      |   9 ++
>  drivers/led/led-uclass.c | 190 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 195 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 9837960198d..4330f014239 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -73,6 +73,15 @@ config LED_BLINK
>           This option enables support for this which adds slightly to the
>           code size.
>
> +config LED_SW_BLINK
> +       bool "Support software LED blinking"
> +       depends on LED_BLINK
> +       select CYCLIC
> +       help
> +         Turns on led blinking implemented in the software, useful when
> +         the hardware doesn't support led blinking. Does nothing if
> +         driver supports blinking.

Can you talk about the blinking p[eriod / API?

> +
>  config SPL_LED
>         bool "Enable LED support in SPL"
>         depends on SPL_DM
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index a4be56fc258..b35964f2e99 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -15,6 +15,10 @@
>  #include <dm/root.h>
>  #include <dm/uclass-internal.h>
>
> +#ifdef CONFIG_LED_SW_BLINK
> +#include <malloc.h>
> +#endif

You should not need to #ifdef include files

> +
>  int led_bind_generic(struct udevice *parent, const char *driver_name)
>  {
>         struct udevice *dev;
> @@ -41,6 +45,7 @@ int led_get_by_label(const char *label, struct udevice **devp)
>         ret = uclass_get(UCLASS_LED, &uc);
>         if (ret)
>                 return ret;
> +
>         uclass_foreach_dev(dev, uc) {
>                 struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>
> @@ -52,14 +57,180 @@ int led_get_by_label(const char *label, struct udevice **devp)
>         return -ENODEV;
>  }
>
> -int led_set_state(struct udevice *dev, enum led_state_t state)
> +#ifdef CONFIG_LED_SW_BLINK
> +
> +enum led_sw_blink_state_t {
> +       LED_SW_BLINK_ST_OFF = 0,
> +       LED_SW_BLINK_ST_ON = 1,
> +       LED_SW_BLINK_ST_NONE = 2,
> +};
> +
> +struct sw_blink_state {
> +       struct udevice *dev;
> +       enum led_sw_blink_state_t cur_blink_state;
> +};
> +
> +static bool led_driver_supports_hw_blinking(const struct udevice *dev)
> +{
> +       struct led_ops *ops = led_get_ops(dev);
> +
> +       /*
> +        * We assume that if driver supports set_period, then it correctly
> +        * handles all other requests, for example, that
> +        * led_set_state(LEDST_BLINK) works correctly.
> +        */
> +       return ops->set_period != NULL;
> +}
> +
> +static const char *led_sw_label_to_cyclic_func_name(const char *label)
> +{
> +#define MAX_NAME_LEN 50
> +       static char cyclic_func_name[MAX_NAME_LEN] = {0};
> +
> +       snprintf(cyclic_func_name, MAX_NAME_LEN, "sw_blink_%s", label);
> +       return cyclic_func_name;
> +#undef MAX_NAME_LEN
> +}
> +
> +static struct cyclic_info *led_sw_find_blinking_led(const char *label)
> +{
> +       struct cyclic_info *cyclic;
> +       const char *cyclic_name;
> +
> +       cyclic_name = led_sw_label_to_cyclic_func_name(label);
> +
> +       hlist_for_each_entry(cyclic, cyclic_get_list(), list) {
> +               if (strcmp(cyclic->name, cyclic_name) == 0)
> +                       return cyclic;
> +       }
> +
> +       return NULL;
> +}
> +
> +static bool led_sw_is_blinking(struct udevice *dev)
> +{
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +       struct cyclic_info *cyclic = led_sw_find_blinking_led(uc_plat->label);
> +
> +       if (cyclic != NULL) {

if (cyclic) {

> +               struct sw_blink_state *state;
> +
> +               state = (struct sw_blink_state *)cyclic->ctx;
> +               return state->cur_blink_state != LED_SW_BLINK_ST_NONE;
> +       }
> +
> +       return false;
> +}
> +
> +static void led_sw_blink(void *void_state)
> +{
> +       struct sw_blink_state *state = (struct sw_blink_state *)void_state;

You should not need that cast

> +       struct udevice *dev = state->dev;
> +       struct led_ops *ops = led_get_ops(dev);
> +
> +       switch (state->cur_blink_state) {
> +       case LED_SW_BLINK_ST_OFF:
> +               state->cur_blink_state = LED_SW_BLINK_ST_ON;
> +               ops->set_state(dev, LEDST_ON);
> +               break;
> +       case LED_SW_BLINK_ST_ON:
> +               state->cur_blink_state = LED_SW_BLINK_ST_OFF;
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
> +static void led_sw_free_cyclic(struct cyclic_info *cyclic)
> +{
> +       free(cyclic->ctx);
> +       cyclic_unregister(cyclic);
> +}
> +
> +static int led_sw_set_period(struct udevice *dev, int period_ms)
> +{
> +       struct cyclic_info *cyclic;
> +       struct sw_blink_state *state;
> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +       const char *cyclic_func_name;
> +
> +       state = malloc(sizeof(struct sw_blink_state));
> +       if (state == NULL) {
> +               printf("Allocating memory for sw_blink_state for %s failed\n",
> +                      uc_plat->label);
> +               return -ENOMEM;
> +       }

I think it would be better to put struct sw_blink_state fields inside
uc_plat. After all, it is pretty tiny. We try not to malloc() data for
devices.

> +
> +       state->cur_blink_state = LED_SW_BLINK_ST_NONE;
> +       state->dev = dev;
> +
> +       /*
> +        * Make sure that there is no cyclic function already
> +        * registered for this label
> +        */
> +       cyclic = led_sw_find_blinking_led(uc_plat->label);
> +       if (cyclic != NULL)

if (cyclic)

please fix globally

> +               led_sw_free_cyclic(cyclic);
> +
> +       cyclic_func_name = led_sw_label_to_cyclic_func_name(uc_plat->label);
> +
> +       cyclic = cyclic_register(led_sw_blink, period_ms * 1000,
> +                                cyclic_func_name, (void *)state);
> +       if (cyclic == NULL) {
> +               printf("Registering of blinking function for %s failed\n",
> +                      uc_plat->label);

log_err()

> +               free(state);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +#endif
> +
> +int led_set_state(struct udevice *dev, enum led_state_t new_state)
>  {
>         struct led_ops *ops = led_get_ops(dev);
>
>         if (!ops->set_state)
>                 return -ENOSYS;
>
> -       return ops->set_state(dev, state);
> +#ifdef CONFIG_LED_SW_BLINK

if (IS_ENABLED(CONFIG_LED_SW_BLINK))

> +       if (!led_driver_supports_hw_blinking(dev)) {
> +               struct cyclic_info *cyclic;
> +               struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +               cyclic = led_sw_find_blinking_led(uc_plat->label);
> +
> +               if (cyclic != NULL) {
> +                       if (new_state == LEDST_BLINK) {
> +                               struct sw_blink_state *cur_st;
> +
> +                               cur_st = (struct sw_blink_state *)cyclic->ctx;
> +
> +                               /*
> +                                * Next call to led_sw_blink will start blinking
> +                                */
> +                               cur_st->cur_blink_state = LED_SW_BLINK_ST_OFF;
> +                               return 0;
> +                       }
> +
> +                       /*
> +                        * Changing current blinking state to
> +                        * something else
> +                        */
> +                       led_sw_free_cyclic(cyclic);
> +               }
> +       }
> +#endif
> +
> +       return ops->set_state(dev, new_state);
>  }
>
>  enum led_state_t led_get_state(struct udevice *dev)
> @@ -69,19 +240,31 @@ enum led_state_t led_get_state(struct udevice *dev)
>         if (!ops->get_state)
>                 return -ENOSYS;
>
> +#ifdef CONFIG_LED_SW_BLINK
> +       if (!led_driver_supports_hw_blinking(dev) && led_sw_is_blinking(dev))
> +               return LEDST_BLINK;
> +#endif
> +
>         return ops->get_state(dev);
>  }
>
>  #ifdef CONFIG_LED_BLINK
> +
>  int led_set_period(struct udevice *dev, int period_ms)
>  {
>         struct led_ops *ops = led_get_ops(dev);
>
> -       if (!ops->set_period)
> +       if (!ops->set_period) {
> +#ifdef CONFIG_LED_SW_BLINK
> +               return led_sw_set_period(dev, period_ms);
> +#else
>                 return -ENOSYS;
> +#endif
> +       }

This is a bit strange...you are in effect creating a default implementation?

>
>         return ops->set_period(dev, period_ms);
>  }
> +
>  #endif
>
>  static int led_post_bind(struct udevice *dev)
> @@ -113,7 +296,6 @@ static int led_post_bind(struct udevice *dev)
>          * probe() to configure its default state during startup.
>          */
>         dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> -

Unrelated change (we use a blank line before the final return in each function)

>         return 0;
>  }
>
> --
> 2.43.0
>

Regards,
Simon
