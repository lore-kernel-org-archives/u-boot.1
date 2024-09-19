Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B2CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5AF89271;
	Thu, 19 Sep 2024 16:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lztVVtz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78FEE8926F; Thu, 19 Sep 2024 16:14:36 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35434891F7
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so807084b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755273; x=1727360073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ovdnCN7GNEkulp7UVrHBr8GNIgU2PvJMUNGdQhQ/bFI=;
 b=lztVVtz3ijCqut88K7bsE6V3aiSItOy1XBPhmKOizENKSLPP04kHCq/F1eLunKNbzx
 o0EAltVLLpjeqG+inXOT5jaPaqIDm9h3zLxjCMujjigY6De2caBlvXBlgkZ3jkP4JJK8
 NbIQNANPTYTWWUmM8j7eox3+pPKKMM0P9P1G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755273; x=1727360073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovdnCN7GNEkulp7UVrHBr8GNIgU2PvJMUNGdQhQ/bFI=;
 b=FiluRJVgfv6VzwzT9cWvLw181+ENVDqdz65VmjlhOlgRz2sI/xAbLg26l8JdDHN3cK
 uHFoJsxykRfNOJ4IfIu5rzOCQUTuJ0nhI9j3E+VrvK9tBppwI6jAN/iPb/QrAgFt9rpw
 i+G1elAGaDZe7NCseCRGkkHmR12fgaFrkaCtS55oMIyRCdY6WKSiC6Bqw+AFrxfgpD76
 vl/uiNhUIYEql3fIKTRiVW9Omly0RCEhgUA0GJkjAKUIxpt46YNtfy/QoZeT4Z9c/gg5
 A0LfcvR4FyrAJn/Tf5XA24U8h7BGFJewgTzB8dARg/RgHCP6Ax9CcuPa9GEz0Q9p+2e5
 9gpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULHhEua9gjMVI+xG9O7AHBXVnS6NDMdTZp60Od03Gt93POTcJq/IHgOZarjn9p7/1k6XNQipo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxtw6KsgdUhLePZ7cwqxXqcCCU3vlJzQOyZYZtzv4HvKoX0a73q
 W20oJ2h04CrRq4X58nOOIxSx1kVsd4DoPonZkx2uiJQur4tJHimywEtFMNC6AwiNCoxi7v6aBXo
 PoiWDd0aEjlDHtH2eyJt6ja/+6iezxaqjHq0K
X-Google-Smtp-Source: AGHT+IH/4fpggNji2524yTm1Srw1QsklY7gWFp3kc79aBVm4oJ3+nOCXzUEgrA0EKbdrCcADeR6I/4SNRJpc9ZDj3xc=
X-Received: by 2002:a05:6a00:2d11:b0:714:2198:26a1 with SMTP id
 d2e1a72fcca58-7192620d8d3mr38039737b3a.27.1726755272692; Thu, 19 Sep 2024
 07:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-4-ansuelsmth@gmail.com>
In-Reply-To: <20240812103254.26972-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:14:05 +0200
Message-ID: <CAFLszThAUJfxkduhFsrE3WLFROwhy-mDMedvRKR9ix71TTbwQA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] led: implement LED boot API
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Dmitry Dunaev <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
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

On Mon, 12 Aug 2024 at 12:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement LED boot API to signal correct boot of the system.
>
> led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> designated boot LED.
>
> New Kconfig are introduced, CONFIG_LED_BOOT_ENABLE to enable the feature.
> This makes use of the /config property "u-boot,boot-led" to the define
> the boot LED.
> It's also introduced a new /config property "u-boot,boot-led-period" to
> define the default period when the LED is set to blink mode.
>
> If "u-boot,boot-led-period" is not defined, the value of 250 (ms) is
> used by default.
>
> If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> led_boot_blink call will fallback to simple LED ON.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  doc/device-tree-bindings/config.txt |  3 ++
>  drivers/led/Kconfig                 | 20 +++++++++
>  include/led.h                       | 64 +++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>
> diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
> index f50c68bbdc3..68edd177040 100644
> --- a/doc/device-tree-bindings/config.txt
> +++ b/doc/device-tree-bindings/config.txt
> @@ -31,6 +31,9 @@ u-boot,error-led (string)
>         This is used to specify the label for an LED to indicate an error and
>         a successful boot, on supported hardware.
>
> +u-boot,boot-led-period (int)
> +       This is used to specify the default period for an LED in blink mode.
> +

I'm sorry to say that this is out-of-date.

The new schema is in options/ and is documented at dtschema:

dtschema/schemas/options/u-boot.yaml

You should add new things there. If you have time, it would be great
if you could send bindings for the things in config.txt

>  bootsecure (int)
>         Indicates that U-Boot should use secure_boot_cmd() to run commands,
>         rather than the normal CLI. This can be used in production images, to
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index bee74b25751..fd9442edaf3 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -9,6 +9,26 @@ config LED
>           can provide access to board-specific LEDs. Use of the device tree
>           for configuration is encouraged.
>
> +config LED_BOOT_ENABLE
> +       bool "Enable LED boot support"
> +       help
> +         Enable LED boot support.
> +
> +         LED boot is a specific LED assigned to signal boot operation status.
> +
> +config LED_BOOT_LABEL
> +       string "LED boot label"
> +       depends on LED_BOOT_ENABLE
> +       help
> +         LED label defined in DT to assign for LED boot usage.
> +
> +config LED_BOOT_PERIOD
> +       int "LED boot period"
> +       depends on LED_BOOT_ENABLE && (LED_BLINK || LED_SW_BLINK)
> +       default 2

Should that be 2000? It is a very fast blink if it is 2ms

> +       help
> +         LED boot blink period in ms.
> +
>  config LED_BCM6328
>         bool "LED Support for BCM6328"
>         depends on LED && ARCH_BMIPS
> diff --git a/include/led.h b/include/led.h
> index c1f3380f253..2d3b89674e2 100644
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
> @@ -159,4 +160,67 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
>  bool led_sw_is_blinking(struct udevice *dev);
>  bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
>
> +#ifdef CONFIG_LED_BOOT_ENABLE
> +
> +/**
> + * led_boot_on() - turn ON the designated LED for booting
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static inline int led_boot_on(void)

I wonder why these are inline functions?

You should be able to put this code in the C file, with an #ifdef in
the header to create an empty, static-inline function if needed.

> +{
> +       const char *led_name;
> +
> +       led_name = ofnode_conf_read_str("u-boot,boot-led");
> +       if (!led_name)
> +               return -ENOENT;
> +
> +       return led_set_state_by_label(led_name, LEDST_ON);
> +}
> +
> +/**
> + * led_boot_off() - turn OFF the designated LED for booting
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static inline int led_boot_off(void)
> +{
> +       const char *led_name;
> +
> +       led_name = ofnode_conf_read_str("u-boot,boot-led");
> +       if (!led_name)
> +               return -ENOENT;
> +
> +       return led_set_state_by_label(CONFIG_LED_BOOT_LABEL, LEDST_OFF);
> +}
> +
> +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
> +/**
> + * led_boot_blink() - turn ON the designated LED for booting
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static inline int led_boot_blink(void)
> +{
> +       const char *led_name;
> +       int led_period, ret;
> +
> +       led_name = ofnode_conf_read_str("u-boot,boot-led");
> +       if (!led_name)
> +               return -ENOENT;
> +
> +       led_period = ofnode_conf_read_int("u-boot,boot-led-period", 250);
> +
> +       ret = led_set_period_by_label(led_name, led_period);
> +       if (ret)
> +               return ret;
> +
> +       return led_set_state_by_label(led_name, LEDST_BLINK);
> +}
> +#else
> +/* If LED BLINK is not supported/enabled, fallback to LED ON */
> +#define led_boot_blink led_boot_on
> +#endif
> +#endif
> +
>  #endif
> --
> 2.45.2
>

Regards,
Simon
