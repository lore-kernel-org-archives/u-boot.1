Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B404C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 11:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A965181FEE;
	Mon, 19 May 2025 13:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="wdexxwMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCA04803DF; Mon, 19 May 2025 13:33:20 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647DE81E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 13:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso636300766b.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747654398; x=1748259198;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI5aHSVo4R4/QCc8KXjFhiQ7g+78w5vltVcztKByYz4=;
 b=wdexxwMBqrloE/i04hlw0YGnsi5tOVjzjuYPskdssPbjffLz4Rt6lZ1wXY1+uUDQDB
 U/60DBrEDezKey/clY/GRGzLp8zDc/07nxjzHMpWN9HD7ltyzwafhHRAYQQR1xQ0avmM
 MbFOt/TfS2G1NrZRxG6l/QSmWMBD3RaeL6HTIIkhFz0jef/8xIkiDMDcpGqVLb0cH6cj
 5If2OLl2h9TAcsgE1TGCOT7nYMnVk+A4nBx3P30s0Q3xlSY6WBVpiepqiGm1VnpkdKob
 FJRI7NWzZuIK6o6LQQ/Toaiy5n6xdD5Tc7ROCy83EvH53OuEtkvPWHTpahFuULhvs1RK
 MeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747654398; x=1748259198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI5aHSVo4R4/QCc8KXjFhiQ7g+78w5vltVcztKByYz4=;
 b=gFxMEUaLo/8tNE8WlmfsnX78BKSd1qc7jYCLrckEdg+0W5vaabMqJykWmZhXb983hf
 XiZlx/cYmaiuLt+mhsjyvQzVXPGywnq+i57cRFvSi8aQlRB+hjieLbu9cF8qbr3edXvk
 UVdLfM5rdxLiyjmjY/9L2xOXZHAh28YtQ/UzBoLQlcbM0TC2AveeARI/WhOnLrPGrf3X
 zSdimUWsPFqAvYbuxQ6CFP4GrELBkT7SXewXkf/vv1gaMvJEHjps7vA2hMgroZ0+4Uv/
 T7qh1nYO9pwxY4m8+xAkKMFtTXejyg8yxdQ+9WbO6XHY0mlC8uQNTQOMxYugoLrN5hOB
 cTAw==
X-Gm-Message-State: AOJu0YxoqgwC+NZ1Ie44D4x0A8L11BWdXa/Cr0hyGKhQkiNjsg1zfh/Z
 pasGHtY4NLSRwX2k0cn/UhqIujDi7pbC2tU7c5L8L4E0TaNv6ncJeUEp49y+O3Vl5eNPTa2NMl/
 jGVdMThjvxUWKORqwX+ZiY8mlkgGKHDY3JDiYZwe9Qg==
X-Gm-Gg: ASbGncuaisQ6l3HxOn9UH9rV74lJKcyrW2KxlzBUt41LkqtwKQ8g1OO3G3TNPiNeZXC
 IsU8rI6elIFTw5P81SGpFqJvZ2cyVdqUnsKo/Wev5wUqhJU19pxkWtjbfrrvsnN3xedlycuqii5
 EDtIRkrFTufJxq+ZytUw1CoXDW5qtDcE0=
X-Google-Smtp-Source: AGHT+IFAmPLDl/EH+fX+PWuZhHSIDQh1KYS3Ai6jII78geS+PJdNolRvBWh0A2ixB5xB6abRULNOoyDcP+gEcqqrNNs=
X-Received: by 2002:a17:906:6a14:b0:acb:6746:8769 with SMTP id
 a640c23a62f3a-ad52d4c7c4dmr1130237666b.18.1747654397708; Mon, 19 May 2025
 04:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-3-3cc5a06087cf@thaumatec.com>
 <31a94b99-9341-474d-bfa4-869ed7962688@cherry.de>
In-Reply-To: <31a94b99-9341-474d-bfa4-869ed7962688@cherry.de>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Mon, 19 May 2025 13:33:07 +0200
X-Gm-Features: AX0GCFtOpY8IxNcRXeip0t9FPjTBsbEsNXMjxsfvGFx68BmLQTh2sDhqUssHess
Message-ID: <CABd623v_mq54kUH4ZT=vkeW7ROnyAMq9Bf2_eJ2pxc6sk-6gKQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: onboard-hub: Add support for multiple power
 supplies
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

pt., 16 maj 2025 o 17:05 Quentin Schulz <quentin.schulz@cherry.de> napisa=
=C5=82(a):
>
> Hi Lukasz,
>
> On 4/25/25 12:56 PM, Lukasz Czechowski wrote:
> > Some of the onboard hubs require multiple power supplies, so extend
> > the driver to support them.
> > The implementation is inspired by the kernel driver, as introduced
> > by commit [1] in the v6.10 kernel.
> >
> > [1] https://github.com/torvalds/linux/commit/ec1848cd5df426f57a7f6a8a6b=
95b69259c52cfc
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > ---
> >   common/usb_onboard_hub.c | 45 +++++++++++++++++++++++++++++++++------=
------
> >   1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> > index 325c274ed952..b8fa38a4111d 100644
> > --- a/common/usb_onboard_hub.c
> > +++ b/common/usb_onboard_hub.c
> > @@ -20,14 +20,18 @@
> >   #define USB5744_CONFIG_REG_ACCESS   0x0037
> >   #define USB5744_CONFIG_REG_ACCESS_LSB       0x99
> >
> > +#define MAX_SUPPLIES 2
> > +
> >   struct onboard_hub {
> > -     struct udevice *vdd;
> > +     struct udevice *vdd[MAX_SUPPLIES];
> >       struct gpio_desc *reset_gpio;
> >   };
> >
> >   struct onboard_hub_data {
> >       unsigned long reset_us;
> >       unsigned long power_on_delay_us;
> > +     unsigned int num_supplies;
> > +     const char * const supply_names[MAX_SUPPLIES];
> >       int (*init)(struct udevice *dev);
> >   };
> >
> > @@ -144,20 +148,28 @@ static int usb_onboard_hub_probe(struct udevice *=
dev)
> >       struct onboard_hub_data *data =3D
> >               (struct onboard_hub_data *)dev_get_driver_data(dev);
> >       struct onboard_hub *hub =3D dev_get_priv(dev);
> > +     unsigned int i;
> >       int ret;
> >
> > -     ret =3D device_get_supply_regulator(dev, "vdd-supply", &hub->vdd)=
;
> > -     if (ret && ret !=3D -ENOENT) {
> > -             dev_err(dev, "can't get vdd-supply: %d\n", ret);
> > -             return ret;
> > +     if (data->num_supplies > MAX_SUPPLIES) {
> > +             dev_err(dev, "invalid supplies number, max supported: %d\=
n", MAX_SUPPLIES);
> > +             return -EINVAL;
> >       }
> >
> > -     if (hub->vdd) {
> > -             ret =3D regulator_set_enable_if_allowed(hub->vdd, true);
> > -             if (ret && ret !=3D -ENOSYS) {
> > -                     dev_err(dev, "can't enable vdd-supply: %d\n", ret=
);
> > +     for (i =3D 0; i < data->num_supplies; i++) {
> > +             ret =3D device_get_supply_regulator(dev, data->supply_nam=
es[i], &hub->vdd[i]);
> > +             if (ret && ret !=3D -ENOENT) {
> > +                     dev_err(dev, "can't get %s: %d\n", data->supply_n=
ames[i], ret);
> >                       return ret;
> >               }
> > +
> > +             if (hub->vdd[i]) {
> > +                     ret =3D regulator_set_enable_if_allowed(hub->vdd[=
i], true);
> > +                     if (ret && ret !=3D -ENOSYS) {
> > +                             dev_err(dev, "can't enable %s: %d\n", dat=
a->supply_names[i], ret);
> > +                             return ret;
> > +                     }
> > +             }
>
> I'm wondering if we shouldn't have all return ret; actually be goto err;
> instead? I would assume that the error path in the probe function should
> be really close to what we have in remove function?
>
> To that extent, before this patch even, I think we should probably
> dm_gpio_set_value() the reset line when there's an error so that the hub
> is held in reset?
>
> Additionally, I believe the dm_gpio_free() in the remove function is
> unnecessary because we request the gpio with a devm_ function which
> should call dm_gpio_free() whenever appropriate?
>

 I think it's worth improving, and this can be done in separate patch,

> Finally, specifically for this patch here, I believe we should disable
> all regulators in the opposite order when in the error path?
>
> Something like:
>
> err:
>      for (i =3D data->num_supplies - 1; i >=3D 0; i--) {
>          ret =3D regulator_set_enable_if_allowed(hub->vdd[i], false);
>          if (ret)
>              dev_err(dev, "can't disable %s: %d\n",
> data->supply_names[i], ret);
>      }
>
> ? what do you think?
>

Thanks for the comments. That's a good point. I'll update it in v2.

> >       }
> >
> >       ret =3D usb_onboard_hub_reset(dev);
> > @@ -208,7 +220,10 @@ static int usb_onboard_hub_bind(struct udevice *de=
v)
> >
> >   static int usb_onboard_hub_remove(struct udevice *dev)
> >   {
> > +     struct onboard_hub_data *data =3D
> > +             (struct onboard_hub_data *)dev_get_driver_data(dev);
> >       struct onboard_hub *hub =3D dev_get_priv(dev);
> > +     unsigned int i;
> >       int ret;
> >
> >       if (hub->reset_gpio) {
> > @@ -216,9 +231,11 @@ static int usb_onboard_hub_remove(struct udevice *=
dev)
> >               dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
> >       }
> >
> > -     ret =3D regulator_set_enable_if_allowed(hub->vdd, false);
> > -     if (ret)
> > -             dev_err(dev, "can't disable vdd-supply: %d\n", ret);
> > +     for (i =3D 0; i < data->num_supplies; i++) {
> > +             ret =3D regulator_set_enable_if_allowed(hub->vdd[i], fals=
e);
> > +             if (ret)
> > +                     dev_err(dev, "can't disable %s: %d\n", data->supp=
ly_names[i], ret);
> > +     }
> >
>
> The error/remove path is usually unwinding in opposite order than the
> normal path, so that would be looping from last supply to first. C.f.
> regulator_bulk_disable in the Linux kernel.
>
> >       return ret;
>
> This one's an issue now, it'll return 0 if the last
> regulator_set_enable_if_allowed is 0, overriding the return code from
> dm_gpio_set_value and earlier regulator_set_enable_if_allowed calls. We
> should probably |=3D them or return some appropriate hardcoded value if a=
t
> least one failed.
>
> Cheers,
> Quentin

Best regards,
Lukasz
