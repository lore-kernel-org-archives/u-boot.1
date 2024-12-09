Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7BEE77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 10:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E33088E2B;
	Mon,  9 Dec 2024 11:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJDIsLle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB98E88B1C; Mon,  9 Dec 2024 11:42:26 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA8888E2B
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 11:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a736518eso45225655e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733740944; x=1734345744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MUUlhbxZSKbZ5Y4YjuKGEGkTz1c6b0smhtsBzPUJYk=;
 b=dJDIsLleEZrfGh0dItvH3k3OLq/VzcN9o9G/nzm8v6vtkU9kxwIdD2Dm2gIwXRPH+L
 yJggdLHYABocuaQSDAJUDwlB5emgrCwzBNa9NBo01wFbVpx4VhSeffYiHFclD4ovPI0F
 /gXwcs2k0B9pxJOTmbkmKD80JrdGytNYC7a9yI7pPLT3p1ELt+8gtpkbxzhY+kR5ATb2
 TGvCEyt9LhhCsn8gnUC5bFO6jaaS78ZMtmBcsOG8UmHPMHPd4f6AvBc2+AS2bYW8xP28
 jF4FKjLL6zWUxZUGjZca6xPKojRMUafmqn42CzQeaDgqlMlGMZ1NY7a00I/Moie5vOS5
 cxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733740944; x=1734345744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MUUlhbxZSKbZ5Y4YjuKGEGkTz1c6b0smhtsBzPUJYk=;
 b=s6yBRgzBWsbsqMo0VsHnreRR7AIdGMOidCGlHIzXiR3kmgH4miwy1b1LQkM1RuSkbe
 9mys66jS0U1MGrbb+mkLW/i1sifRcgOtlv2qn7CGb9i4MBHAEBK30jSKZQp6bxEQJBJA
 AolxjqKuj5l+ysyypFt9Y490ET6UMh+0yoftEGSU2P4GBmZQtzUrje884x3hozs246mc
 BYCmCtiZVbakgMDNwWKHIhP2h7koWUhx1r5TCAjRe6YYa45dEWLxuAVNUrMkwGSFGOvr
 1a6W07FRkeKdz9/0Ecr+vTQhUK9kVmmDAnqSB5aPhFIQ5uBKhLMErX/ZoF2iywSxK6yO
 cTKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Ij/HNnuRZi+YTv+UgsXLa0WwmoQYI4yF0/QTWJakxbI80lkO7xs+7FazchZYFmrkjspcXMA=@lists.denx.de
X-Gm-Message-State: AOJu0Yze1VBWc0c0d56ojhsa/3Rz/T9FOwxSASLH9azuDVrh4lTCjArP
 8N6qwVkoOnGiWde80lgDDu439h3Gt3xj2EAS1w2VTLsVSFqTFdr3wF3nE9V1tCg5r80IufSxl4y
 bx5bYKpOqXVKcWWBmGC5x+5HYo7M=
X-Gm-Gg: ASbGncuD+lRlkJZU6egn2Y3hz5LKmGRopFGWLJSLHHt6yKSUguwfWraX2fMsZrT9UQS
 LnuN7JDud3xwosVxJyF9mz23DljxkaJWT
X-Google-Smtp-Source: AGHT+IFcNzCHfd0q1Xv7RUSQ2F4IUP9JyuWiPWjt69vdmB5lRGqKFv+O0XWHKEB/A3BhTZGh01D+QIRS10hAQ+5jwbk=
X-Received: by 2002:a05:6000:401e:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-3862b3cdcd3mr8981053f8f.44.1733740943708; Mon, 09 Dec 2024
 02:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20241209064413.6282-1-clamor95@gmail.com>
 <20241209064413.6282-3-clamor95@gmail.com>
 <2c6deec8-8145-482f-bbf0-e2efab3dcf74@kwiboo.se>
In-Reply-To: <2c6deec8-8145-482f-bbf0-e2efab3dcf74@kwiboo.se>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 9 Dec 2024 12:42:12 +0200
Message-ID: <CAPVz0n2RTFMGqEwJ=eT+=Ub5tp951HxM5DMX2B5agSBYyh0DXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: fix request of PMIC GPIO child
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

=D0=BF=D0=BD, 9 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 12:11=
 Jonas Karlman <jonas@kwiboo.se> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 2024-12-09 07:44, Svyatoslav Ryhel wrote:
> > If correct PMIC child was found it should be requested as well.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpio/gpio-uclass.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> > index e776906fe73..e6c00c48722 100644
> > --- a/drivers/gpio/gpio-uclass.c
> > +++ b/drivers/gpio/gpio-uclass.c
> > @@ -1160,6 +1160,14 @@ static int gpio_request_tail(int ret, const char=
 *nodename,
> >                       /* if loop exits without GPIO device return error=
 */
> >                       if (device_get_uclass_id(desc->dev) !=3D UCLASS_G=
PIO)
> >                               goto err;
> > +
> > +                     ret =3D uclass_get_device_by_name(UCLASS_GPIO, de=
sc->dev->name,
> > +                                                     &desc->dev);
> > +                     if (ret) {
> > +                             log_debug("%s: getting GPIO device failed=
 %d\n",
> > +                                       __func__, ret);
> > +                             goto err;
> > +                     }
> >  #else
> >                       debug("%s: uclass_get_device_by_ofnode failed\n",
> >                             __func__);
>
> Instead of extending this PMIC/GPIO workaround maybe it is better to fix
> the issue at bind time? Look like the max77663 pmic driver use
> device_bind_driver() instead of device_bind_driver_to_node().
>

Actually this is a valid point. Thank you for this suggestion.

> Also palmas gpio driver should not need to be bind, the DTs I can find
> in tree all have a gpio node with compatible =3D ti,palmas-gpio. Do not
> really understand why the palmas driver should need this workaround
> the gpios props seem to bind to &palmas_gpio node in the DTs I checked.

This, on the other hand, will not work since pmic drivers do not
automatically bind all child nodes, I have checked and gpio driver was
not bound.

> Maybe something like following diff could work for your boards? I.e.
> revert c03cd98d1a16 ("drivers: gpio-uclass: support PMIC GPIO children")
> and bind gpio dirver to the pmic node.
>
> Binding to pmic node should probably only happen if the pmic node has
> the gpio-controller prop.
>
> Regards,
> Jonas
>
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 0213271e3a69..67fc776cada2 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -1142,29 +1142,9 @@ static int gpio_request_tail(int ret, const char *=
nodename,
>                 ret =3D uclass_get_device_by_ofnode(UCLASS_GPIO, args->no=
de,
>                                                   &desc->dev);
>                 if (ret) {
> -#if CONFIG_IS_ENABLED(MAX77663_GPIO) || CONFIG_IS_ENABLED(PALMAS_GPIO)
> -                       struct udevice *pmic;
> -                       ret =3D uclass_get_device_by_ofnode(UCLASS_PMIC, =
args->node,
> -                                                         &pmic);
> -                       if (ret) {
> -                               log_debug("%s: PMIC device get failed, er=
r %d\n",
> -                                         __func__, ret);
> -                               goto err;
> -                       }
> -
> -                       device_foreach_child(desc->dev, pmic) {
> -                               if (device_get_uclass_id(desc->dev) =3D=
=3D UCLASS_GPIO)
> -                                       break;
> -                       }
> -
> -                       /* if loop exits without GPIO device return error=
 */
> -                       if (device_get_uclass_id(desc->dev) !=3D UCLASS_G=
PIO)
> -                               goto err;
> -#else
>                         debug("%s: uclass_get_device_by_ofnode failed\n",
>                               __func__);
>                         goto err;
> -#endif
>                 }
>         }
>         ret =3D gpio_find_and_xlate(desc, args);
> diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.=
c
> index cf08b6a7e1df..838eae50740d 100644
> --- a/drivers/power/pmic/max77663.c
> +++ b/drivers/power/pmic/max77663.c
> @@ -56,8 +56,8 @@ static int max77663_bind(struct udevice *dev)
>         }
>
>         if (IS_ENABLED(CONFIG_MAX77663_GPIO)) {
> -               ret =3D device_bind_driver(dev, MAX77663_GPIO_DRIVER,
> -                                        "gpio", NULL);
> +               ret =3D device_bind_driver_to_node(dev, MAX77663_GPIO_DRI=
VER,
> +                                                "gpio", dev_ofnode(dev),=
 NULL);
>                 if (ret) {
>                         log_err("cannot bind GPIOs (ret =3D %d)\n", ret);
>                         return ret;
> diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> index f676bf641694..faa876f4e73d 100644
> --- a/drivers/power/pmic/palmas.c
> +++ b/drivers/power/pmic/palmas.c
> @@ -45,7 +45,6 @@ static int palmas_read(struct udevice *dev, uint reg, u=
int8_t *buff, int len)
>  static int palmas_bind(struct udevice *dev)
>  {
>         ofnode pmic_node =3D ofnode_null(), regulators_node;
> -       ofnode subnode, gpio_node;
>         int children, ret;
>
>         if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
> @@ -57,14 +56,6 @@ static int palmas_bind(struct udevice *dev)
>                 }
>         }
>
> -       gpio_node =3D ofnode_find_subnode(dev_ofnode(dev), "gpio");
> -       if (ofnode_valid(gpio_node)) {
> -               ret =3D device_bind_driver_to_node(dev, PALMAS_GPIO_DRIVE=
R,
> -                                                "gpio", gpio_node, NULL)=
;
> -               if (ret)
> -                       log_err("cannot bind GPIOs (ret =3D %d)\n", ret);
> -       }
> -
>         dev_for_each_subnode(subnode, dev) {
>                 const char *name;
>                 char *temp;
>
>
