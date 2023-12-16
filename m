Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B11C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 16:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF894876E8;
	Sat, 16 Dec 2023 17:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QsOPhD9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00938876F8; Sat, 16 Dec 2023 17:55:16 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E353A876DB
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 17:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c3fe6c1b5so18358015e9.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 08:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702745712; x=1703350512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lselR/hKOYOY3TijP7NJgKfh7dIIffYxax+R2OYLv1k=;
 b=QsOPhD9iIiQSqujTAl7JkJPZFgkLV/u2nMwakeNhwAlSh7jX0LUB8mZjlgQxyJj1xu
 YpEfwdM8vLUnBknEsMPlj7w6odqtkwBQxjPuDjMNyO56oPTKCO6/ZF88X2o1YQ98oxst
 Rz+x+lcUs+KXnC7Lhv9BIjXDPjUlLVXOFOgg4xAZNVvHqgP+TIWQuwDROv2TCRQTnUkZ
 T9QG7R8+uapomFtJ6Nz/gciNr4Nr+Wd5u6NOUDwdAM0zBdV7ILpafjAYF4klMCJ27y09
 0rsCuhOcWEyFmPaSxOC993yKlUQS1GU+DTq7NleqnbGlW0jq12EY1ze37UPCfIzclzzi
 7g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702745712; x=1703350512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lselR/hKOYOY3TijP7NJgKfh7dIIffYxax+R2OYLv1k=;
 b=tpxaAQv3Yc10unxZv7iWXOINXL//2ES7qy+wHLsZC52ZM+vyriSKi+o4VwQlzZoV8n
 x3cTJx0dZYBtHzDNhYT3Qs+JMuh6dmp7k1J/rozHZKz9ao1qLRHsZl6524zIim9anVtF
 PAT3E8TcOdBwf1O24xHt6NtdLzblMg2T5gX73Nj3Rfvi54YwpGqJRKm0bB/UcjKd9NzJ
 apgnXe3t85y1d71FWSpQv4a/B5zeN+G7hB4PoZyQ9uFQEIYiY7bW+Sk/YJ1BKzL/SvHv
 P8j/t5EstJdOzOG0cVzEZblnuLpJr6eWRgvpwLEr1rYWgYvfsO1fIdRZ5kP5aNQpHOFD
 zK1g==
X-Gm-Message-State: AOJu0YxQ4MHGk9gIEpkxpKtqRuEuRkEU401HFAaEN2TaJjkbhCtKDzHv
 m/qlsw4nTN2SLF6BtvqN9meCE8oDXF/c6sXE5AU=
X-Google-Smtp-Source: AGHT+IEqN3bKVKMmoQMolUapWqf2mkoBRJDwDf0fUokTx82oFkkz01DR8VL9fNpqRLZiFcGD3i5uHPR7OXj7kGl6Ygo=
X-Received: by 2002:a05:600c:54f1:b0:40c:2395:1fa7 with SMTP id
 jb17-20020a05600c54f100b0040c23951fa7mr6435391wmb.141.1702745712002; Sat, 16
 Dec 2023 08:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
In-Reply-To: <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 16 Dec 2023 18:55:00 +0200
Message-ID: <CAPVz0n1nX6kC6UOd8kSa9=NuYtdumvrWQaScXUh-KnYKiAqMAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
To: Marek Vasut <marex@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D0=B1, 16 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 18:5=
2 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 12/16/23 16:37, Sean Anderson wrote:
> > On 12/16/23 03:48, Svyatoslav Ryhel wrote:
> >> Existing gpio-gate-clock driver acts like a simple GPIO switch without
> >> any
> >> effect on gated clock. Add actual clock actions into enable/disable
> >> ops and
> >> implement get_rate op by passing gated clock if it is enabled.
> >>
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>   drivers/clk/clk-gpio.c | 44 ++++++++++++++++++++++++++++++++++------=
--
> >>   1 file changed, 36 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> >> index 26d795b978..72d9747a47 100644
> >> --- a/drivers/clk/clk-gpio.c
> >> +++ b/drivers/clk/clk-gpio.c
> >> @@ -3,19 +3,23 @@
> >>    * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>    */
> >> -#include <asm/gpio.h>
> >> -#include <common.h>
> >> -#include <clk-uclass.h>
> >> +#include <clk.h>
> >>   #include <dm.h>
> >> +#include <clk-uclass.h>
> >> +#include <linux/clk-provider.h>
> >> +
> >> +#include <asm/gpio.h>
> >>   struct clk_gpio_priv {
> >> -    struct gpio_desc    enable;
> >> +    struct gpio_desc    enable;    /* GPIO, controlling the gate */
> >> +    struct clk        *clk;    /* Gated clock */
> >>   };
> >>   static int clk_gpio_enable(struct clk *clk)
> >>   {
> >>       struct clk_gpio_priv *priv =3D dev_get_priv(clk->dev);
> >> +    clk_enable(priv->clk);
> >>       dm_gpio_set_value(&priv->enable, 1);
> >>       return 0;
> >> @@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
> >>       struct clk_gpio_priv *priv =3D dev_get_priv(clk->dev);
> >>       dm_gpio_set_value(&priv->enable, 0);
> >> +    clk_disable(priv->clk);
> >>       return 0;
> >>   }
> >> +static ulong clk_gpio_get_rate(struct clk *clk)
> >> +{
> >> +    struct clk_gpio_priv *priv =3D dev_get_priv(clk->dev);
> >> +
> >> +    return clk_get_rate(priv->clk);
> >> +}
> >> +
> >>   const struct clk_ops clk_gpio_ops =3D {
> >>       .enable        =3D clk_gpio_enable,
> >>       .disable    =3D clk_gpio_disable,
> >> +    .get_rate    =3D clk_gpio_get_rate,
> >>   };
> >> -static int clk_gpio_probe(struct udevice *dev)
> >> +static int clk_gpio_of_to_plat(struct udevice *dev)
> >>   {
> >>       struct clk_gpio_priv *priv =3D dev_get_priv(dev);
> >> +    int ret;
> >> -    return gpio_request_by_name(dev, "enable-gpios", 0,
> >> -                    &priv->enable, GPIOD_IS_OUT);
> >> +    priv->clk =3D devm_clk_get(dev, NULL);
> >> +    if (IS_ERR(priv->clk)) {
> >> +        log_debug("%s: Could not get gated clock: %ld\n",
> >> +              __func__, PTR_ERR(priv->clk));
> >> +        return PTR_ERR(priv->clk);
> >> +    }
> >> +
> >> +    ret =3D gpio_request_by_name(dev, "enable-gpios", 0,
> >> +                   &priv->enable, GPIOD_IS_OUT);
> >> +    if (ret) {
> >> +        log_debug("%s: Could not decode enable-gpios (%d)\n",
> >> +              __func__, ret);
> >> +        return ret;
> >> +    }
> >> +
> >> +    return 0;
>
> All this forwarding of clock enable/disable/get_rate for parent clock
> should already be done in clock core. If it is not, then it should be
> fixed in clock core.

It is not and this driver, as is, did not work on tegra since you
messed up headers.
