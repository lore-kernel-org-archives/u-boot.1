Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C779C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 14:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E61B8773C;
	Wed, 20 Dec 2023 15:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tUDpwMAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671A8876E4; Wed, 20 Dec 2023 15:10:06 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5B2876E9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 15:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-466a9c3ffebso468104137.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703081400; x=1703686200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qsm2fUnL/gIa8UOLX4Ia4mW/hClvcvxgmyHAEJ+WPe4=;
 b=tUDpwMAnXz43kEmQgoB2iTujE2ZXo2AZCTnYB2CE/4gu0CC98tiXklJ5D/UvJfetYS
 Z6MLuzz5GH0/NMwOIS2vWQeB25o09U862j8PjBAPcTZ9xW+I9Up6E5qL4Syb9nMjmxJk
 POdm/H6VQDvSzJVGij/7ltxpIxOB82kApsyPDkuKUX+umdJXovy0qJYp+oUCr69HYpj1
 +TcTAzP9DcQtw78d8uVHKft+TWe5pXRm82TFR0qT1Bw5NFZ8WZc0zB8KiPcZOwMU0plU
 ZEhbYFCABVj9vTyxWQCOHwCZGwxLtqDJSCcmzhuMIT3PmkBgBHyucMf1s+pVYXgP+kHB
 Wp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703081400; x=1703686200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsm2fUnL/gIa8UOLX4Ia4mW/hClvcvxgmyHAEJ+WPe4=;
 b=PB4G2WfY8YUvFRIlMGCSpPRZgp0kIB1BQvPMuRLQ+x1mKyVbgD0r5pP+eZA5fG3i0s
 qmHkYx9XEScnFhmC4aV04uVyagpAaPn3k4A6Q+9d0LPR8O9rwrz95dFrGbgF+RDgEvFf
 0+meDgNjN96L1vf5upXm1vmLR/r0FQOP1V2UxqoH2iK+/NmN/xKmENbWeUElFAHL+KoO
 jB/RenLfo69SX/gKLxjwz8FaAYjD8KN0pRJDQt/D1ViwMX6uvIURuuCFBkTDTCs0XwPm
 QllCQpBPNf/jMvH9fyJF1sJv/G8H/wUK+3ff1rpJgR+jiTEb5fMXAt0ARcCamngUvb13
 xcIw==
X-Gm-Message-State: AOJu0YwKH0PQ1LbqU+Gh9hrFtEibxuY+3JtUj0zWY9IcpuxfRR5wER6a
 Rd7naEcA+0TWe5RrJf3dF4v+Vy8Ozxlk2AXfKm5GsnEiO8Zhgw==
X-Google-Smtp-Source: AGHT+IHkIKQqSNhEz6gIe5xvET7F/wrKhzcA3ihXptsz8Ae7bH+j5xqOmNESIkGySMFYSIG50Ob5w7nrfOQ7awKbvo8=
X-Received: by 2002:a05:6102:2f0:b0:466:a1da:99b1 with SMTP id
 j16-20020a05610202f000b00466a1da99b1mr1968681vsj.28.1703081400551; Wed, 20
 Dec 2023 06:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <20231218072428.1802969-3-sumit.garg@linaro.org>
 <3310b183-c0f5-48e9-b92c-5c98508b2b90@linaro.org>
In-Reply-To: <3310b183-c0f5-48e9-b92c-5c98508b2b90@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 19:39:49 +0530
Message-ID: <CAFA6WYPvLpdGe7OwFTeZk1JUtGGv5VzTS4n3BEabJd5Ern4X-Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] serial_msm: Add support for RS232 GPIOs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com, 
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

On Tue, 19 Dec 2023 at 22:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> I guess these GPIOs are RTS/CTS? Missing description...

No, these GPIOs (99 and 100) on HMIBSC board rather act as a mux to
control UART mode out of rs232/422/485. I will add a corresponding
description.

>
> Given that you just set them to their respective values, you should be
> able to configure these using pinctrl with this patch [1], so we can
> avoid adding these non-standard bindings.

Okay I will try to use them once we resolve the conflicts discussed in
the other thread.

>
> I tested your next patch, setting "MSM_UART_MR1_RX_RDY_CTL" in
> uart_dm_init() on db410c and db820c and I don't notice any issues with
> setting that bit unconditionally. If it's definitely needed for your
> board then I'd be ok with a patch to always set it with a comment
> offering some context.

Yeah it's needed for RS232 mode to operate correctly. I will make it
unconditional then.

-Sumit

>
> [1]:
> https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-10-b6dd9704219e@linaro.org/
>
> On 18/12/2023 07:24, Sumit Garg wrote:
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/serial/serial_msm.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> > index a22623c316e..43e58595dc2 100644
> > --- a/drivers/serial/serial_msm.c
> > +++ b/drivers/serial/serial_msm.c
> > @@ -16,6 +16,7 @@
> >  #include <serial.h>
> >  #include <watchdog.h>
> >  #include <asm/global_data.h>
> > +#include <asm/gpio.h>
> >  #include <asm/io.h>
> >  #include <linux/compiler.h>
> >  #include <linux/delay.h>
> > @@ -210,6 +211,7 @@ static int msm_serial_probe(struct udevice *dev)
> >  {
> >       int ret;
> >       struct msm_serial_data *priv = dev_get_priv(dev);
> > +     struct gpio_desc rs232_0, rs232_1;
> >
> >       /* No need to reinitialize the UART after relocation */
> >       if (gd->flags & GD_FLG_RELOC)
> > @@ -219,6 +221,11 @@ static int msm_serial_probe(struct udevice *dev)
> >       if (ret)
> >               return ret;
> >
> > +     if (!gpio_request_by_name(dev, "gpios", 0, &rs232_0, GPIOD_IS_OUT))
> > +             dm_gpio_set_value(&rs232_0, 1);
> > +     if (!gpio_request_by_name(dev, "gpios", 1, &rs232_1, GPIOD_IS_OUT))
> > +             dm_gpio_set_value(&rs232_1, 0);
> > +
> >       pinctrl_select_state(dev, "uart");
> >       uart_dm_init(priv);
> >
>
> --
> // Caleb (they/them)
