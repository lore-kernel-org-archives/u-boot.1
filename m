Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B0BCF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 12:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B17DB88960;
	Sun, 29 Sep 2024 14:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f0X52K9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D3088960; Sun, 29 Sep 2024 14:48:14 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92EF88953
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 14:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso27142475e9.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727614091; x=1728218891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7cxe6M0ctaqETfmESy+DVTEaQYVf5sLm00fI6ebRvcQ=;
 b=f0X52K9oXKwyckSaMypJrbDiC+cgD07KQxtwT9z5XNFNzUz4Sz19mo+rsTVf1jBwNh
 aZAReqrpPVKSXhGV+O/ZepJN+bWXLE1k3crGQzKsfeuYeCCx+0CQg+6SmSYu7F0RQMp6
 NT2gdHWEgjyOwxGmsA6BY4LMoCzV/0syfQOFxLWJxrfHP6te5grZ/p0MJ6Kw5t+Zb7VV
 fSxO1y07+u4TdUe/3PyWPWFIuObqvNZwn9YoJWsBhSlGG1sOuKIv3KQCSrwmr20AvVOl
 7X0B9Jhm9liu41TmuDCsfBhjDqayzv+7Yu6AeQt2KUIgWjtPnB/1iyUVI1iMWyJs3/zD
 7dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727614091; x=1728218891;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cxe6M0ctaqETfmESy+DVTEaQYVf5sLm00fI6ebRvcQ=;
 b=GTozBHO5hjGISwZEecROQAPhx/qNjATcpF0TyDDA5TYGnAx6sQknDlxzNwv5KT5XlE
 pcSie090xCFAet3sqg+PI5/dpqFfhvtQGL6E9IBjvEiPy+sVoVcc4PpLBXxMLNGXEUy0
 zfv6DK/LbE42Uxh6yd1M/yE1XgmfnC3F9KsnEJ3GSCpgO6wgqRN5QXoh5n7KODH/3XZz
 MkBtC8UsReD5NmxUkIBKiTJST6qe6qQziATkew5QWa4WayghMz6rSMi0j3Uwx3j8iTG1
 NO869BGI+8pyttKrBLKp9KvTRpl1D90l8EbSkwnXP7/BvXXJi0kYLUi4pldbpPkjkpJG
 cagw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy//yoSQgWrzLcSJ6W3nc2hxN+dUEcbGMVeF7i5c4YmXYVwxbDZ2k2LtjAaDPUie/NSt1HX6w=@lists.denx.de
X-Gm-Message-State: AOJu0YzTu7l1WTbH9kez1/4wsVd+sINksAYh0CTiDjL0ctdVFYGogIXL
 JcT3NZEvHsHjDZ1BxIWtgWQDacntV+n602y9f8UppzGy4myA9zFl
X-Google-Smtp-Source: AGHT+IHSXmkTnyLYnxMPwqEh9VEsAtSuRnmhLgY+FPB0AwvW0HujKXpOzwM5IDG25Qx5AD8qIkwf/w==
X-Received: by 2002:a05:6000:12cc:b0:37c:cd40:a993 with SMTP id
 ffacd0b85a97d-37cd5a8a39emr4634753f8f.22.1727614090772; 
 Sun, 29 Sep 2024 05:48:10 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565de45sm6811798f8f.32.2024.09.29.05.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 05:48:09 -0700 (PDT)
Message-ID: <66f94c89.5d0a0220.286c21.6077@mx.google.com>
X-Google-Original-Message-ID: <ZvlMhOXC09yLBasi@Ansuel-XPS.>
Date: Sun, 29 Sep 2024 14:48:04 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
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
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4 03/11] led: implement LED boot API
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-4-ansuelsmth@gmail.com>
 <CAFLszThtgGo9aszNyB45rBbWB1FPsiao1CKeiAARZnGqDhc2jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThtgGo9aszNyB45rBbWB1FPsiao1CKeiAARZnGqDhc2jA@mail.gmail.com>
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

On Thu, Sep 26, 2024 at 11:33:18PM +0200, Simon Glass wrote:
> Hi Christian,
> 
> On Sat, 21 Sept 2024 at 00:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Implement LED boot API to signal correct boot of the system.
> >
> > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > designated boot LED.
> >
> > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > This makes use of the /options/u-boot property "boot-led" to the
> > define the boot LED.
> > It's also introduced a new /options/u-boot property "boot-led-period"
> > to define the default period when the LED is set to blink mode.
> >
> > If "boot-led-period" is not defined, the value of 250 (ms) is
> > used by default.
> >
> > If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> > led_boot_blink call will fallback to simple LED ON.
> >
> > To cache the data we repurpose the now unused led_uc_priv for storage of
> > global LED uclass info.
> 
> Some things to tweak below
> 

Hi, thanks for the review. I asked some clarification, thanks for any
comments.

> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/led/Kconfig      |   7 +++
> >  drivers/led/led-uclass.c | 100 +++++++++++++++++++++++++++++++++++++++
> >  include/led.h            |  56 +++++++++++++++++++++-
> >  3 files changed, 161 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> > index bee74b25751..6149cfa02b8 100644
> > --- a/drivers/led/Kconfig
> > +++ b/drivers/led/Kconfig
> > @@ -9,6 +9,13 @@ config LED
> >           can provide access to board-specific LEDs. Use of the device tree
> >           for configuration is encouraged.
> >
> > +config LED_BOOT
> > +       bool "Enable LED boot support"
> > +       help
> > +         Enable LED boot support.
> > +
> > +         LED boot is a specific LED assigned to signal boot operation status.
> 
> Here you should link to the /options binding in
> doc/device-tree-bindings/options, perhaps
>

Ok.

> > +
> >  config LED_BCM6328
> >         bool "LED Support for BCM6328"
> >         depends on LED && ARCH_BMIPS
> > diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> > index 199d68bc25a..c5b560982b0 100644
> > --- a/drivers/led/led-uclass.c
> > +++ b/drivers/led/led-uclass.c
> > @@ -94,17 +94,101 @@ int led_set_period(struct udevice *dev, int period_ms)
> >         return -ENOSYS;
> >  }
> >
> > +#ifdef CONFIG_LED_BOOT
> > +int led_boot_on(void)
> > +{
> > +       struct uclass *uc = uclass_find(UCLASS_LED);
> > +       struct led_uc_priv *priv;
> > +       struct udevice *dev;
> > +
> > +       if (!uc)
> > +               return -ENOENT;
> > +
> 
> The normal way is:
> 
> ret = uclass_first_device_ret(UCLASS_LED, &dev);
> if (ret)
>    return ret;
> 
> > +       priv = uclass_get_priv(uc);
> > +       if (!priv->boot_led_dev ||
> > +           uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
> 
> That is an internal function...I suppose it should really have an
> underscore and be in uclass-internal.h
> 
> But if you are looking for boot_led_label, don't you need to search
> through the LEDs to find it? Or use led_get_by_label() ?
> 

Idea here and up is to cache the dev on bind to prevent
useless/additional loop on search in each UCLASS LED the boot LED.

uclass_get_device_tail is needed to actually trigger probe of the LED if
it hasn't been done prev.

The uclass_get_priv is followed by the rkmtd_get_cur_dev()
implementation, for the sake of getting the UCLASS alone it seems too
much to have all the additional operation to get the first device.

Also considering uclass_get_device_tail is also used by get_by_label I
assume it's ok to also use it here.

Should I ignore caching the dev and just search for the boot LED from
label everytime out of simplicity?

> > +               printf("Failed to get boot LED %s\n",
> > +                      priv->boot_led_label);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return led_set_state(dev, LEDST_ON);
> > +}
> > +
> > +int led_boot_off(void)
> > +{
> > +       struct uclass *uc = uclass_find(UCLASS_LED);
> > +       struct led_uc_priv *priv;
> > +       struct udevice *dev;
> > +
> > +       if (!uc)
> > +               return -ENOENT;
> > +
> 
> Same here.
> 
> > +       priv = uclass_get_priv(uc);
> > +       if (!priv->boot_led_dev ||
> > +           uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
> > +               printf("Failed to get boot LED %s\n",
> > +                      priv->boot_led_label);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return led_set_state(dev, LEDST_OFF);
> > +}
> > +
> > +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
> > +int led_boot_blink(void)
> > +{
> > +       struct uclass *uc = uclass_find(UCLASS_LED);
> > +       struct led_uc_priv *priv;
> > +       struct udevice *dev;
> > +       int ret;
> > +
> > +       if (!uc)
> > +               return -ENOENT;
> > +
> > +       priv = uclass_get_priv(uc);
> > +       if (!priv->boot_led_dev ||
> > +           uclass_get_device_tail(priv->boot_led_dev, 0, &dev)) {
> > +               printf("Failed to get boot LED %s\n",
> > +                      priv->boot_led_label);
> > +               return -EINVAL;
> > +       }
> 
> This looks like the same code again. I think it should be in a
> function so the code is not repeated.
> 
> > +
> > +       ret = led_set_period(dev, priv->boot_led_period);
> > +       if (ret) {
> > +               if (ret != -ENOSYS)
> > +                       return ret;
> > +
> > +               /* fallback to ON with no set_period and no SW_BLINK */
> > +               return led_set_state(dev, LEDST_ON);
> > +       }
> > +
> > +       return led_set_state(dev, LEDST_BLINK);
> > +}
> > +#endif
> > +#endif
> > +
> >  static int led_post_bind(struct udevice *dev)
> >  {
> >         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> >         const char *default_state;
> >
> > +#ifdef CONFIG_LED_BOOT
> > +       struct led_uc_priv *priv = uclass_get_priv(dev->uclass);
> > +#endif
> > +
> >         if (!uc_plat->label)
> >                 uc_plat->label = dev_read_string(dev, "label");
> >
> >         if (!uc_plat->label && !dev_read_string(dev, "compatible"))
> >                 uc_plat->label = ofnode_get_name(dev_ofnode(dev));
> >
> > +#ifdef CONFIG_LED_BOOT
> > +       /* check if we are binding boot LED and assign it */
> > +       if (!strcmp(priv->boot_led_label, uc_plat->label))
> > +               priv->boot_led_dev = dev;
> > +#endif
> > +
> >         uc_plat->default_state = LEDST_COUNT;
> >
> >         default_state = dev_read_string(dev, "default-state");
> > @@ -158,10 +242,26 @@ static int led_post_probe(struct udevice *dev)
> >         return ret;
> >  }
> >
> > +#ifdef CONFIG_LED_BOOT
> > +static int led_init(struct uclass *uc)
> > +{
> > +       struct led_uc_priv *priv = uclass_get_priv(uc);
> > +
> > +       priv->boot_led_label = ofnode_options_read_str("boot-led");
> > +       priv->boot_led_period = ofnode_options_read_int("boot-led-period", 250);
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> >  UCLASS_DRIVER(led) = {
> >         .id             = UCLASS_LED,
> >         .name           = "led",
> >         .per_device_plat_auto   = sizeof(struct led_uc_plat),
> >         .post_bind      = led_post_bind,
> >         .post_probe     = led_post_probe,
> > +#ifdef CONFIG_LED_BOOT
> > +       .init           = led_init,
> > +       .priv_auto      = sizeof(struct led_uc_priv),
> > +#endif
> 
> I don't love all these #ifdefs but I suppose it is OK here. Ideally we
> would have static inline accessors for the fields, in the header file,
> e.g. like asm-generic/global_data.h
> 

Didn't know of the global_data but then I read the comments and it seems
we should not really pollute it with too much stuff. Also considering
most of the LED are driven with gpio the possibility of having this that
early on boot might be closer to 0.

> >  };
> > diff --git a/include/led.h b/include/led.h
> > index 99f93c5ef86..ca495217777 100644
> > --- a/include/led.h
> > +++ b/include/led.h
> > @@ -9,6 +9,7 @@
> >
> >  #include <stdbool.h>
> >  #include <cyclic.h>
> > +#include <dm/ofnode.h>
> >
> >  struct udevice;
> >
> > @@ -52,10 +53,16 @@ struct led_uc_plat {
> >  /**
> >   * struct led_uc_priv - Private data the uclass stores about each device
> >   *
> > - * @period_ms: Flash period in milliseconds
> > + * @boot_led_label:    Boot LED label
> > + * @boot_led_dev:      Boot LED dev
> > + * @boot_led_period:   Boot LED blink period
> >   */
> >  struct led_uc_priv {
> > -       int period_ms;
> > +#ifdef CONFIG_LED_BOOT
> > +       const char *boot_led_label;
> > +       struct udevice *boot_led_dev;
> > +       int boot_led_period;
> > +#endif
> >  };
> >
> >  struct led_ops {
> > @@ -141,4 +148,49 @@ int led_sw_set_period(struct udevice *dev, int period_ms);
> >  bool led_sw_is_blinking(struct udevice *dev);
> >  bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
> >
> > +#ifdef CONFIG_LED_BOOT
> > +
> > +/**
> > + * led_boot_on() - turn ON the designated LED for booting
> > + *
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int led_boot_on(void);
> > +
> > +/**
> > + * led_boot_off() - turn OFF the designated LED for booting
> > + *
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int led_boot_off(void);
> > +
> > +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
> > +/**
> > + * led_boot_blink() - turn ON the designated LED for booting
> > + *
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int led_boot_blink(void);
> > +
> > +#else
> > +/* If LED BLINK is not supported/enabled, fallback to LED ON */
> > +#define led_boot_blink led_boot_on
> > +#endif
> > +#else
> > +static inline int led_boot_on(void)
> > +{
> > +       return -ENOSYS;
> > +}
> > +
> > +static inline int led_boot_off(void)
> > +{
> > +       return -ENOSYS;
> > +}
> > +
> > +static inline int led_boot_blink(void)
> > +{
> > +       return -ENOSYS;
> > +}
> > +#endif
> > +
> >  #endif
> > --
> > 2.45.2
> >
> 
> Regards,
> Simon

-- 
	Ansuel
