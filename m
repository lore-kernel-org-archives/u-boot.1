Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A424ECF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8837589269;
	Thu, 19 Sep 2024 16:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YwfHUazl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F228189269; Thu, 19 Sep 2024 16:14:13 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F7989265
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso745955b3a.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755250; x=1727360050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CjtUWFckn7AfjdNHWir9FOPx05njDKN50SOkIDiXUv8=;
 b=YwfHUazlsXm6+5SzSi8Gs1uRyeBU/AZ+p4YxVG7ZvBF8pX82MMA2AGYtW1SNT57jJQ
 uw7GL8raoOOKvjuBtIMdV8GIHPW7XvdqzzL86WcIAbOFH/sT4LAoswwMHD906l5X5u3F
 I23rHbi2hEQ79+ScrridJlRA2LfzL3RJxKkkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755250; x=1727360050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CjtUWFckn7AfjdNHWir9FOPx05njDKN50SOkIDiXUv8=;
 b=j9jGjnDt7XfW/4mg37SnkBTTeopCy+XEsHuguIEKugVuxgnEXO61mBfCKLyjxys91o
 uVr1d8Wa3i11JmhLS5G/uPb/49ZsYqXDXFRgY73s7fJiUdwEw928FscyIHV5edcCwFrF
 eL3AjqG/If+PjjmDUKNjThKLYOR82M/qGfqJ9ROKUkprtBqm+fMiSnhCYQVAf+CEpQoJ
 nSnfAj1KyShOljKvA5mSnOeDe9ZHJzxRuGauDtY2tDniKtaFO5Geuk+zjdmRJf6Mh39+
 uQb1+eYXWZ8LmzVjUOWxHPXO7OOz654AuxanC/D9DJ3Mx6PwikJVf5y25OIJk8XDfBXz
 j1lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQfmJC2gLipCwWDpBynuYYO1nWVmp2L5qbMzSa3Hyo7rWV58u/LjO1j0M8JPDOkEuiC8bcZI4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9xbf0tCZTO6Mglc6szm7+60i6g+14kBPKcg1grc462rx2LxQh
 gO2V/F5vdR2XM07e64rf1mIRa/n7IPnmp3mYdeW9yW72dgB7LrjWFqnX2q4aPutHgySJoRBTrMk
 xP+sjqLgKOPzi9vH18kGGyHEXJT669Sm/vL0f
X-Google-Smtp-Source: AGHT+IELtx1d4tS7tYAdlJ/oRZNwLQpFMsEbXYv8VRI1q6QBhUqUszjERrA6Lou8WYioYXR8NS1iQSSJutCSO0v3Zgo=
X-Received: by 2002:a05:6a00:3993:b0:717:950e:b589 with SMTP id
 d2e1a72fcca58-719261ead3bmr43050370b3a.19.1726755250210; Thu, 19 Sep 2024
 07:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-6-ansuelsmth@gmail.com>
In-Reply-To: <20240812103254.26972-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:55 +0200
Message-ID: <CAFLszTgetgVByWGeNwzKs+L7k5QJUAK4XpoZ8KTzpcmgRt+FmQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] led: implement LED activity API
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
> Implement LED activity API similar to BOOT LED API.
>
> Usual activity might be a file transfer with TFTP, a flash write...
>
> User of this API will call led_activity_on/off/blink() to signal these
> kind of activity.
>
> New Kconfig are implemented similar to BOOT LED, LED_ACTIVITY_ENABLE to
> enable support for it.
>
> It's introduced a new /config property "u-boot,activity-led" and
> "u-boot,activity-led-period" to define the activity LED label and the
> default period when the activity LED is set to blink mode.
>
> If "u-boot,activity-led-period" is not defined, the value of 250 (ms) is
> used by default.
>
> If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> led_boot_blink call will fallback to simple LED ON.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  doc/device-tree-bindings/config.txt |  4 ++
>  drivers/led/Kconfig                 | 21 ++++++++++
>  include/led.h                       | 63 +++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)

Please see comments about /options on the other patch.

This is a nice feature to have!

>
> diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
> index 68edd177040..cd9ec88909b 100644
> --- a/doc/device-tree-bindings/config.txt
> +++ b/doc/device-tree-bindings/config.txt
> @@ -30,8 +30,12 @@ u-boot,boot-led (string)
>  u-boot,error-led (string)
>         This is used to specify the label for an LED to indicate an error and
>         a successful boot, on supported hardware.
> +u-boot,activity-led (string)
> +       This is used to specify the label for an LED to indicate an activity
> +       if supported by the operation.
>
>  u-boot,boot-led-period (int)
> +u-boot,activity-led-period (int)
>         This is used to specify the default period for an LED in blink mode.
>
>  bootsecure (int)
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index fd9442edaf3..1336f943dab 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -29,6 +29,27 @@ config LED_BOOT_PERIOD
>         help
>           LED boot blink period in ms.
>
> +config LED_ACTIVITY_ENABLE
> +       bool "Enable LED activity support"
> +       help
> +         Enable LED activity support.
> +
> +         LED activity is a specific LED assigned to signal activity operation
> +         like file trasnfer, flash write/erase...
> +
> +config LED_ACTIVITY_LABEL
> +       string "LED activity label"
> +       depends on LED_ACTIVITY_ENABLE
> +       help
> +         LED label defined in DT to assign for LED activity usage.
> +
> +config LED_ACTIVITY_PERIOD
> +       int "LED activity period"
> +       depends on LED_ACTIVITY_ENABLE && (LED_BLINK || LED_SW_BLINK)
> +       default 2
> +       help
> +         LED activity blink period in ms.
> +
>  config LED_BCM6328
>         bool "LED Support for BCM6328"
>         depends on LED && ARCH_BMIPS
> diff --git a/include/led.h b/include/led.h
> index 2d3b89674e2..6a1471dae85 100644
> --- a/include/led.h
> +++ b/include/led.h
> @@ -223,4 +223,67 @@ static inline int led_boot_blink(void)
>  #endif
>  #endif
>
> +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> +
> +/**
> + * led_activity_on() - turn ON the designated LED for activity
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static inline int led_activity_on(void)
> +{
> +       const char *led_name;
> +
> +       led_name = ofnode_conf_read_str("u-boot,activity-led");
> +       if (!led_name)
> +               return -ENOENT;
> +
> +       return led_set_state_by_label(led_name, LEDST_ON);
> +}
> +
> +/**
> + * led_activity_off() - turn OFF the designated LED for activity
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static inline int led_activity_off(void)
> +{
> +       const char *led_name;
> +
> +       led_name = ofnode_conf_read_str("u-boot,activity-led");
> +       if (!led_name)
> +               return -ENOENT;

-EINVAL for devicetree things that are missing. Also, please read the
config in of_to_plat() rather than doing it when the driver is
actually being used.

> +
> +       return led_set_state_by_label(led_name, LEDST_OFF);
> +}
> +
> +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
> +/**
> + * led_activity_blink() - turn ON the designated LED for activity
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static inline int led_activity_blink(void)

Hmm again this code should be in a C file and in of_to_plat method..

> +{
> +       const char *led_name;
> +       int led_period, ret;
> +
> +       led_name = ofnode_conf_read_str("u-boot,activity-led");
> +       if (!led_name)
> +               return -ENOENT;
> +
> +       led_period = ofnode_conf_read_int("u-boot,activity-led-period", 250);
> +
> +       ret = led_set_period_by_label(led_name, led_period);
> +       if (ret)
> +               return ret;
> +
> +       return led_set_state_by_label(led_name, LEDST_BLINK);
> +}
> +#else
> +/* If LED BLINK is not supported/enabled, fallback to LED ON */
> +#define led_activity_blink led_activity_on
> +#endif
> +#endif
> +
>  #endif
> --
> 2.45.2
>

Regards,
Simon
