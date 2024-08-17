Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB608C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 16:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B3888892;
	Sat, 17 Aug 2024 17:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GOQepkRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175AB88898; Sat, 17 Aug 2024 17:58:44 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F2888BB0
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e026a2238d8so3034333276.0
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910321; x=1724515121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EXhkJJo/nOwSuCUmg0dLu4LPAEg+JQylpgS3haCROYU=;
 b=GOQepkRc3XT4yfO6EjNCxCceP2KN6T3TwewlYwyf6hPMwXeK5ccDWj8aKteWNbDZVu
 VjJvLukR3U2dUQPEcY0Bv4+WIKLAbmbZM/SQ9Ja/o+EwxZYfTaPuYWkXECkDq2N7nk7H
 48xOsNKq51T4W5qSQmRq/gSF6a7k3FfMUxsEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910321; x=1724515121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXhkJJo/nOwSuCUmg0dLu4LPAEg+JQylpgS3haCROYU=;
 b=FlZUSPwPunZK45zohADx26Ba3cYJcj3+2XasmKFgr57bRexT2S2mcbk/v58bEA4RMK
 z7WxRPTeE/S258+XIpuv2Eri6e1e54P9HFhusIZQgQfos9t0bJVxK8y6XzRwVHI+//W9
 cjTnbekEhOLTUwF3Bf4U478re6+4q1X/idbMzZdgkMbXmE+L2N28eVtOIjyulp83vYxz
 9lR4sXYoeNVPRXJzCuqt+LPlUGr3wunPDv4Q5IuE56tX9c1V+nMKJ9v4oYkv1GTHyyqT
 mf2UfJ3+frG0YcgGssr3hGRReFh/a6fmbPyPh2E5iiZUwjKJySS0YvPeDi0g6gpFFX4G
 nSOQ==
X-Gm-Message-State: AOJu0Yzpzd6uN7NsdCnN9qIO97eJRKnTHg18hjgqIHtnZ+vs4qvFiIBE
 CjPy4xOxo9zBSzqRep4fbNoEfK2kvoIW7LVQtP4y0x1jJBhqYg8z1BdLUdOKTIazz1WauIAp63X
 lPqe2FFCtdy0szjvVAjVPpVqYoGI1iwrVi5Mp
X-Google-Smtp-Source: AGHT+IHpXNYWYhbdM8CiGPMeBgJQxmGEEmEq5TJLPhvnivIOryva2EXmBuhHsYlYHqvklPhBztmlQvZS3gVmzIxe4Ic=
X-Received: by 2002:a05:6902:1021:b0:e11:5738:8610 with SMTP id
 3f1490d57ef6-e1180f831a7mr6132005276.43.1723910320594; Sat, 17 Aug 2024
 08:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240816081922.282155-1-mailinglist1@johanneskirchmair.de>
In-Reply-To: <20240816081922.282155-1-mailinglist1@johanneskirchmair.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:29 -0600
Message-ID: <CAFLszTi3KLSZro2iHc_CDhxUo5hquxQ+Z_CMGo6LCoJYFUK4eg@mail.gmail.com>
Subject: Re: [PATCH] usb: add reset pin handling to onboard-hub driver
To: mailinglist1@johanneskirchmair.de
Cc: u-boot@lists.denx.de, trini@konsulko.com, 
 Johannes Kirchmair <johannes.kirchmair@skidata.com>
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

Hi,

On Fri, 16 Aug 2024 at 07:36, <mailinglist1@johanneskirchmair.de> wrote:
>
> From: Johannes Kirchmair <johannes.kirchmair@skidata.com>
>
> Some onboard-hub chips have external reset pins. This patch adds
> handling of said pin to the onboard-hub driver. The naming for the
> devicetree binding is done in the same way as in the Linux kernel to
> ensure good compatibility between u-boot's and Linux's devicetrees.

U-Boot's

>
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@skidata.com>
> ---
>  common/usb_onboard_hub.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 68a04ac041..5b1bb79c55 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -10,9 +10,11 @@
>  #include <dm.h>
>  #include <dm/device_compat.h>
>  #include <power/regulator.h>
> +#include <asm/gpio.h>
>
>  struct onboard_hub {
>         struct udevice *vdd;
> +       struct gpio_desc reset_pin;
>  };
>
>  static int usb_onboard_hub_probe(struct udevice *dev)
> @@ -27,8 +29,23 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>         }
>
>         ret = regulator_set_enable_if_allowed(hub->vdd, true);
> -       if (ret)
> +       if (ret) {
>                 dev_err(dev, "can't enable vdd-supply: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = gpio_request_by_name(dev, "reset-gpios", 0, &hub->reset_pin,
> +                                  GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +       if (ret && ret != -ENOENT) {
> +               dev_err(dev, "can't get reset-gpios 0: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (hub->reset_pin.dev) {
> +               ret = dm_gpio_set_value(&hub->reset_pin, 0);
> +               if (ret)
> +                       dev_err(dev, "failed setting reset-gpios to 0: %d\n", ret);
> +       }

With the GPIOD_... flags above, this should already be done, so you
don't need this code.

>
>         return ret;
>  }
> @@ -42,12 +59,25 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>         if (ret)
>                 dev_err(dev, "can't disable vdd-supply: %d\n", ret);
>
> +       if (hub->reset_pin.dev) {
> +               ret = dm_gpio_set_value(&hub->reset_pin, 1);
> +               if (ret)
> +                       dev_err(dev, "failed setting reset-gpios to 0: %d\n", ret);

1

Is this putting the device in reset? Could you add a comment as to why?

> +       }
> +
> +       if (hub->reset_pin.dev) {
> +               ret = dm_gpio_free(dev, &hub->reset_pin);
> +               if (ret)
> +                       dev_err(dev, "can't free reset-gpios: %d\n", ret);
> +       }
> +
>         return ret;
>  }
>
>  static const struct udevice_id usb_onboard_hub_ids[] = {
>         /* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>         { .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
> +       { .compatible = "usb4b4,6504" },
>         { }
>  };
>
> --
> 2.34.1
>

Regards,
Simon
