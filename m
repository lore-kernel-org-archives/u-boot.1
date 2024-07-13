Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF2AC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF2A588850;
	Sat, 13 Jul 2024 17:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AYKHmlXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CB488820; Sat, 13 Jul 2024 17:13:56 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C738B88823
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-447feb144dfso16829471cf.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883632; x=1721488432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+3zZQvRM5rhBDfxHhhnNfuo8TXr5bowh872NNHVlPk=;
 b=AYKHmlXtDHOtjQQINzVj/tNCCZJ7EO+EncukhbZCWRy8FUKC1CVI8SSRQdt8munw+I
 fnus9I147ENxV85DJp8G6B7d0/w7DWfiHUvARCRVeCIT8wBMpn0qOkGxbp9S8M8fNGkH
 wbKAD43szlU4yzbYxVLLZcV1RUzIJiJU8iiZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883632; x=1721488432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T+3zZQvRM5rhBDfxHhhnNfuo8TXr5bowh872NNHVlPk=;
 b=vNB3SjGwWq5bFzYyqdcTn6qjNpgAaQWkT4ybKGGxnZm/GjtJrt7OwVImN3QKjszwyI
 kut84MqpWFQ+KOnsZD7c22h7dzhPpKSniW/AsuTR+bfmjWpMdCluNXGPoatgkFd2Z5Ja
 mYfhT5PrZG18sTSh/L0xxLniy5V+Lpw4lQkB/zB4mQ8hhOmWv0QOna3B0R2n+ubFeXO1
 xAXVXTMMF/Oj8ER0twXO4Nwj9VNgYdLwZWi5fvnjfUZXy9fajdyH3oM4DQo0b1NC5iib
 oUQBr6SB+z266QVr/jwSBsCnK2KA1VmjEvitvujgIck0tiqZByUpvfYKqLfSG6nRCRwV
 pwoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Q41A4rvDT4FBkTmnUjNbF1ptNBHKEZ52Fj+7/oNRKHCvj8BXHSJwiJHkOung676OEf47JiYM0zSoa3DufFJGOSHCgQ==
X-Gm-Message-State: AOJu0YwcsTGhjFYahHUDBz6g5fSlRegJbVuCNIbjUuuZhwf+WE6mfOnA
 zS++jtM4dCWQg5OqTtAkUXr0nS2rK/rZmum5Pf866JPe6wf7VKodlffevxVAxXxFD+u1bexeG5o
 +oDo2cmn+yce8h8vlDYeKQoYpxIw4V2tZdzxl
X-Google-Smtp-Source: AGHT+IHRFxJYDJYi1sEetBzrmLW5EL3rZ6M+Cud/bsIniFWvJyAR8BPUnBhnBMtyHY56Q+cXvgIITWJk8vZOtUe57RE=
X-Received: by 2002:a05:6214:2521:b0:6b4:ffa9:c320 with SMTP id
 6a1803df08f44-6b61bce07d9mr191144776d6.22.1720883632732; Sat, 13 Jul 2024
 08:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
 <20240712052507.2496669-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240712052507.2496669-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:41 +0100
Message-ID: <CAFLszThBPaojbFHZf_OpJz=Ub+ikcMZeoa11GeJ422HNPa-s9A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] led: Add dts property to specify blinking of the
 led
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
> The standard property
>
>     linux,default-trigger = "pattern";
>
> used to get an effect. No blinking parameters can be set yet.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/led-uclass.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 4f5dd66765e..90047ad35ba 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -100,6 +100,9 @@ static int led_post_bind(struct udevice *dev)
>  {
>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>         const char *default_state;
> +#ifdef CONFIG_LED_BLINK
> +       const char *trigger;
> +#endif
>
>         if (!uc_plat->label)
>                 uc_plat->label = dev_read_string(dev, "label");
> @@ -120,6 +123,12 @@ static int led_post_bind(struct udevice *dev)
>         else
>                 return 0;
>
> +#ifdef CONFIG_LED_BLINK
> +       trigger = dev_read_string(dev, "linux,default-trigger");
> +       if (trigger && !strncmp(trigger, "pattern", 7))
> +               uc_plat->default_state = LEDST_BLINK;
> +#endif

I still wonder whether you can use IS_ENABLED() instead of adding #ifdefs?

> +
>         /*
>          * In case the LED has default-state DT property, trigger
>          * probe() to configure its default state during startup.
> @@ -132,12 +141,28 @@ static int led_post_bind(struct udevice *dev)
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
