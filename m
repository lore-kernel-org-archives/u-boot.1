Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B579EC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 08:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC56C887CA;
	Wed,  3 Jul 2024 10:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g9Tf4Sx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A751887EE; Wed,  3 Jul 2024 10:08:26 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFD1887C7
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b5def3916bso2648906d6.3
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719994102; x=1720598902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TEIWfPReKBquwPNRzza3fL0vaoJP43dEjIqXjhVy0Hw=;
 b=g9Tf4Sx4fby1vxCIQ/5H1sr1gXJ/Sdn0EErJxSwYlGMkBrQ9jO7fNgTQtcSpV071QN
 JPT1vHe5b9MO43xRqisTSGwX65z8sgm/7TrJf0IFPOcDd50CnO4jY5Ct+mGR+LlZ9Cwq
 +luT77oxpBYhBhjGceTBHZ8Ztkv83NQ0xMKlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719994102; x=1720598902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TEIWfPReKBquwPNRzza3fL0vaoJP43dEjIqXjhVy0Hw=;
 b=N9eFJW1cFdDOVzWZMiEtXaSI2HTfXJpifU1JPlzxtcy5IVxx0OSZK2k066846ZTE0v
 rOCZkPjm/3SVTdsMsOlJny1YZpdvRnzyr++tHqxQ3ynhVmGdxyHttMMy42eU5jKxKfD2
 1ARxSfJfHsjBuI5nrbyRGkSdMDj/mXZONq4bu9l4W/qPDDhH9iIAabuvS2uOZcSAzyE9
 1ja3kwF6YENDaIpBv1ZF7WprVqQmsy/rlXBmZOuAbRFm5ELYV8+0juVaX8Bf6YXotlBe
 qK8hYnzng8JwR8sWAiiMBIcgDqNtf7ZqoLtG114kXftQgJBPFF6HpuszX4BJLP272YBt
 KLPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKkIn0yIP0jbGeWAWeoPhBdT6aDJmOHJ77umoUw69TjyaynjWf9anZS7aVhvT3vHDrZ5Ww6kGczHR3HVFqwbm9pR2Sfw==
X-Gm-Message-State: AOJu0Ywr9r/HU4p1iZ/2bfDZljLi7Xa6T/SMKnGs5sS63iAdkHKiiRHp
 aD9sFl+oDRLCL8hA4SfKsAQGhXfrzdSMXfSBBifOC7KFv6QXLP3a3SULN6C+WjYESv7bKIyPCIe
 fDdEt1CZIs6mDyclFROw2ggHKbPMw8wC6Hn23
X-Google-Smtp-Source: AGHT+IENYNy8Fg1c7YLRryjxzYhPG9qRFmQIdCrot/CUOUERRm83980XpsIQNI5d7pn0he4GZMaiDK+DX5kJQuiAaGU=
X-Received: by 2002:a05:6214:d88:b0:6b0:90d8:b698 with SMTP id
 6a1803df08f44-6b5b7161ff6mr127583416d6.45.1719994101873; Wed, 03 Jul 2024
 01:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
 <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
 <20240703010131.1735100-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240703010131.1735100-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jul 2024 09:08:11 +0100
Message-ID: <CAFLszTh-ACEnnR2t11aVrog_wAn1Zxt6GF99MBZo6vMK1M+n_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] led: Add dts property to specify blinking of the led
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
> The standard property
>
>     linux,default-trigger = "pattern";
>
> used to get an effect. No blinking parameters can be set yet.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/led-uclass.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index d021c3bbf20..78d1a3d152b 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -190,6 +190,9 @@ static int led_post_bind(struct udevice *dev)
>  {
>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>         const char *default_state;
> +#ifdef CONFIG_LED_BLINK
> +       const char *trigger;

It looks like this is not used, so you can drop it and use a local
variable here?

> +#endif
>
>         if (!uc_plat->label)
>                 uc_plat->label = dev_read_string(dev, "label");
> @@ -210,6 +213,13 @@ static int led_post_bind(struct udevice *dev)
>         else
>                 return 0;
>
> +#ifdef CONFIG_LED_BLINK

if (IS_ENABLED(CONFIG_LED_BLINK)

> +       trigger = dev_read_string(dev, "linux,default-trigger");
> +       if (trigger && !strncmp(trigger, "pattern", 7)) {
> +               uc_plat->default_state = LEDST_BLINK;
> +       }

No {} around single lines. You can use patman to send patches and it
will check this for you (I hope!).

> +#endif
> +
>         /*
>          * In case the LED has default-state DT property, trigger
>          * probe() to configure its default state during startup.
> @@ -222,12 +232,28 @@ static int led_post_bind(struct udevice *dev)
>  static int led_post_probe(struct udevice *dev)
>  {
>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +       int rc = 0;
>
> -       if (uc_plat->default_state == LEDST_ON ||
> -           uc_plat->default_state == LEDST_OFF)
> -               led_set_state(dev, uc_plat->default_state);
> +       switch (uc_plat->default_state) {
> +       case LEDST_ON:
> +       case LEDST_OFF:
> +               rc = led_set_state(dev, uc_plat->default_state);
> +               break;
> +#ifdef CONFIG_LED_BLINK
> +       case LEDST_BLINK: {

Here again you can use if IS_ENABLED(CONFIG_LED_BLINK) inside the case
which should produce very similar code size, hopefully the same.

> +               const int default_period_ms = 1000;
>
> -       return 0;
> +               rc = led_set_period(dev, default_period_ms);
> +               if (rc == 0)
> +                       rc = led_set_state(dev, uc_plat->default_state);
> +               break;
> +       }
> +#endif
> +       default:
> +               break;
> +       }
> +
> +       return rc;
>  }
>
>  UCLASS_DRIVER(led) = {
> --
> 2.39.2
>

Regards,
Simon
