Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A21C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E74A87BD3;
	Fri, 15 Dec 2023 21:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AmUNrJ2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39446876B2; Fri, 15 Dec 2023 21:00:25 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30C687BD3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3365752934bso538284f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702670422; x=1703275222; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnYNx8DnO5kIEt0IExgDmDyYhn8rOtLJWJtZzX2eLeY=;
 b=AmUNrJ2z/pF9sZ70VE+JiNAevxqtFwPvL1xz77ngYtbszqchBmt5/+R1GUOwEnrN2m
 xyH9EDY4XKOIHLXEZ8q2Lfgb/WxjorfK99CfW0Rxogg6YfieYtQvAopL9MkZkAsOEbtd
 4DIzW16pAjg/XKOiKnktRZGrOTglauILKQ1SpVq8xG6Wt87zkNjyfhmx8iK6Z9mDLbIl
 ljX3TlPYGPhswb2jodBwqxxx5VOXCz9gEqFzxxLBxk5GLL46n+uTghWOoZOwwS8XOk/C
 CQxY5Cp67ml5lcgH8HMvaCAwrbH4ZYtthVohznQ1earRKbWKNwyRhFhdkbQK5dsY+v/W
 iLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702670422; x=1703275222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnYNx8DnO5kIEt0IExgDmDyYhn8rOtLJWJtZzX2eLeY=;
 b=Lu4ZMyI4dHbTqw9w0bswNkEtoxnbZmai5eoeqxAowvvN7uaxfgOs+XOwVCvDGaOa24
 VYouC/jAakT0UZJFVwhULqkIErETkNfvJxtErA3+EQsn6zRqxI0wHZkKP+r6VSIJnVMs
 Cqu+5+m04jWp9IRFKk5n0BwPFaGEfQ1UU7ZY0vbTqP/mGd6Ysb7JfSbjtFoEWWCk5xlK
 BdG+GpiWrAuA4I8tciMjI0nh55qnRH/gEP/dTnV2be/oUkiSNpy0fQXEPZMe/Xv5lv7c
 zFR4BOazb9wYcnv4F8+hI/iZoeQl2YYnR4CkLKilaKNtFGeE87QL0YkBxu6G6l88zkLH
 TMxw==
X-Gm-Message-State: AOJu0Yw3CL6GufAA9KgzxSslV2w+TaapsLiBI3SggS+Jcy9lGsEjk5dS
 o7rJTGHvy4L2WMSBr/8hrAIrVqj5gYUOsiPTzjVSGeF/
X-Google-Smtp-Source: AGHT+IF5Cz0f+YZGIJN/AxtFH4qFomZIcuabd02gCnxLY2EorGm5N1N+LBXMTBDIRpSNVotdk0Oo/0oDJq+boJ7VXWU=
X-Received: by 2002:a5d:5382:0:b0:336:44cd:7269 with SMTP id
 d2-20020a5d5382000000b0033644cd7269mr2043692wrv.136.1702670421988; Fri, 15
 Dec 2023 12:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20231117075240.15741-1-clamor95@gmail.com>
 <20231117075240.15741-2-clamor95@gmail.com>
 <af9d8670-a99b-5ad3-712b-49ccf31cdea0@gmail.com>
 <CAPVz0n22VgkjEQC4pGD1Eq+jJs0y8o61itnrKC_WvvEb=zop7A@mail.gmail.com>
 <ac7c89c4-0b81-ae12-6bc4-ab191fee3b1c@gmail.com>
In-Reply-To: <ac7c89c4-0b81-ae12-6bc4-ab191fee3b1c@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 15 Dec 2023 22:00:10 +0200
Message-ID: <CAPVz0n2NbYCBwL8ccG6WMarD7bD4S-y34rueCCuQeCsSyWj=Uw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: clk-gpio: add actual gated clock
To: Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
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

=D0=BF=D1=82, 15 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 20:4=
5 Sean Anderson <seanga2@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 12/15/23 13:26, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 15 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE =
19:25 Sean Anderson <seanga2@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 11/17/23 02:52, Svyatoslav Ryhel wrote:
> >>> Existing gpio-gate-clock driver acts like a simple GPIO switch withou=
t any
> >>> effect on gated clock. Add actual clock actions into enable/disable o=
ps and
> >>> implement get_rate op by passing gated clock if it is enabled.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    drivers/clk/clk-gpio.c | 47 +++++++++++++++++++++++++++++++++++---=
----
> >>>    1 file changed, 40 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> >>> index 26d795b978..a55470cfbf 100644
> >>> --- a/drivers/clk/clk-gpio.c
> >>> +++ b/drivers/clk/clk-gpio.c
> >>> @@ -3,19 +3,23 @@
> >>>     * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org=
>
> >>>     */
> >>>
> >>> -#include <asm/gpio.h>
> >>> -#include <common.h>
> >>> -#include <clk-uclass.h>
> >>> +#include <clk.h>
> >>>    #include <dm.h>
> >>> +#include <clk-uclass.h>
> >>> +#include <linux/clk-provider.h>
> >>> +
> >>> +#include <asm/gpio.h>
> >>>
> >>>    struct clk_gpio_priv {
> >>>        struct gpio_desc        enable;
> >>> +     struct clk              *clk;
> >>
> >> Please name this "parent".
> >>
> > I see no need in this since clk is generic name and this driver can
> > accept only one clock with any name.
>
> It's good documentation. It makes it clear what the purpose of the member=
 is.
>
This driver uses a single (1) clock with a single purpose.

Why do you think you need a clock in a clock-gpio driver? Hm, I don't
know. This will remain a mystery for future archeo-coders yeah.

> >>>    };
> >>>
> >>>    static int clk_gpio_enable(struct clk *clk)
> >>>    {
> >>>        struct clk_gpio_priv *priv =3D dev_get_priv(clk->dev);
> >>>
> >>> +     clk_prepare_enable(priv->clk);
> >>
> >> Just clk_enable is fine. We don't have a separate prepare stage line L=
inux.
> >>
> > U-Boot supports clk_prepare_enable and since this support is present I
> > see no contradiction in using it.
>
> These functions are only there for to make it easier to port code from Li=
nux.
> Since this code was written for U-Boot, just use the actual function.
>
Then document that its use is discouraged. Until then it is not restricted.

> >>>        dm_gpio_set_value(&priv->enable, 1);
> >>>
> >>>        return 0;
> >>> @@ -26,21 +30,50 @@ static int clk_gpio_disable(struct clk *clk)
> >>>        struct clk_gpio_priv *priv =3D dev_get_priv(clk->dev);
> >>>
> >>>        dm_gpio_set_value(&priv->enable, 0);
> >>> +     clk_disable_unprepare(priv->clk);
> >>>
> >>>        return 0;
> >>>    }
> >>>
> >>> +static ulong clk_gpio_get_rate(struct clk *clk)
> >>> +{
> >>> +     struct clk_gpio_priv *priv =3D dev_get_priv(clk->dev);
> >>> +     int ret;
> >>> +
> >>> +     ret =3D dm_gpio_get_value(&priv->enable);
> >>> +     if (ret)
> >>> +             return clk_get_rate(priv->clk);
> >>> +     else
> >>> +             return -EINVAL;
> >>
> >> This should always return the parent rate.
> >>
> > How can you return clock rate if the gate is disabled?
>
> This allows consumers to know what the rate will be before they
> enable the clock.
>
I don't quite understand the logic behind this but ok.

> >>> +}
> >>> +
> >>>    const struct clk_ops clk_gpio_ops =3D {
> >>>        .enable         =3D clk_gpio_enable,
> >>>        .disable        =3D clk_gpio_disable,
> >>> +     .get_rate       =3D clk_gpio_get_rate,
> >>>    };
> >>>
> >>> -static int clk_gpio_probe(struct udevice *dev)
> >>> +static int clk_gpio_of_to_plat(struct udevice *dev)
> >>
> >> This change should be a separate commit.
> >>
> > This actually should not be accepted first place
> >
> > .of_to_plat - convert device tree data to plat
> > .probe - make a device ready for use
> >
> > https://github.com/u-boot/u-boot/blob/master/doc/develop/driver-model/d=
esign.rst
>
> Yes, this is why I was a bit confused :)
>
> >>>    {
> >>>        struct clk_gpio_priv *priv =3D dev_get_priv(dev);
> >>> +     int ret;
> >>>
> >>> -     return gpio_request_by_name(dev, "enable-gpios", 0,
> >>> -                                 &priv->enable, GPIOD_IS_OUT);
> >>> +     priv->clk =3D devm_clk_get(dev, NULL);
> >>> +     if (IS_ERR(priv->clk)) {
> >>> +             log_err("%s: Could not get gated clock: %ld\n",
> >>> +                     __func__, PTR_ERR(priv->clk));
> >>> +             return PTR_ERR(priv->clk);
> >>> +     }
> >>> +
> >>> +     ret =3D gpio_request_by_name(dev, "enable-gpios", 0,
> >>> +                                &priv->enable, GPIOD_IS_OUT);
> >>> +     if (ret) {
> >>> +             log_err("%s: Could not decode enable-gpios (%d)\n",
> >>> +                     __func__, ret);
> >>
> >> Use dev_dbg for probe errors to reduce binary size.
> >>
> > These errors provide intel about probing 2 key parts of the driver.
> > How would you know it fails in case you have no devices which face
> > this error? Iis there any convention or restriction which prohibits
> > this? If yes, then provide a document please.
>
> https://docs.u-boot.org/en/latest/develop/driver-model/design.html#error-=
codes
>
> | Ideally, messages in drivers should only be displayed when debugging,
> | e.g. by using log_debug() although in extreme cases log_warning() or
> | log_error() may be used.
>
> > All other general clock drivers use log_err/dev_err versions btw.
>
> Yeah, it's something we have not been so consistent with enforcing.
>
Alright

> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>>    }
> >>>
> >>>    /*
> >>> @@ -59,7 +92,7 @@ U_BOOT_DRIVER(gpio_gate_clock) =3D {
> >>>        .name           =3D "gpio_clock",
> >>>        .id             =3D UCLASS_CLK,
> >>>        .of_match       =3D clk_gpio_match,
> >>> -     .probe          =3D clk_gpio_probe,
> >>> +     .of_to_plat     =3D clk_gpio_of_to_plat,
> >>>        .priv_auto      =3D sizeof(struct clk_gpio_priv),
> >>>        .ops            =3D &clk_gpio_ops,
> >>>        .flags          =3D DM_FLAG_PRE_RELOC,
> >>
> >> --Sean
>
