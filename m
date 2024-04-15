Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99BFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305B487D14;
	Mon, 15 Apr 2024 13:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="N926qzoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D4287E83; Mon, 15 Apr 2024 13:11:50 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A2B87D14
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2a68a2b3747so1707661a91.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713179506; x=1713784306; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehVbmGUiarRZUM8/OP5zvAcrydXAO4gufpW257mHjjE=;
 b=N926qzoa64rPDEJ7rep5n0B+0gxMsPF+FnndBIFAgyVyr6pAHj+F4G9i5v++wzjBzg
 AmJllVsq4E3C8mNR5COzX6gwn/1/P9UqJ6QhxrtW6YvbUDZsGEaQyAH8PqSaHkGtuuyN
 bvzGiXEN2mMpadvW0RCn5bIdMzz7clJ98dJl4Hjk5+cq8FGNJlgkKFuqTBi3furrDmgD
 giB3ae4m9/hEqLfjrcMlLs+9KKDgwyqt4vOGwXhxivEAaCqQdQsH0yto78dMvXb+25P/
 ZKmYtRJeuQvV7VZedoSkITyL6bbJCPiG2wvakJY81CAn9ToyDvC6BrVy/RKb/ocCJKG/
 T9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713179506; x=1713784306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehVbmGUiarRZUM8/OP5zvAcrydXAO4gufpW257mHjjE=;
 b=Jx5LRV3UyCIibz6Z2e+9GrSQ7+ak6/3ZjWf+BagO7Vu6I/dyTkM7e5BlovwssEJlL6
 5QPgeaQoTzd9ZKO8Ryd722h0ajTJvaU5Gg0lXDhziIVJzfFk4vTNFRgmuJ1065hfcYwi
 ojjNf1WNxrRQnuA6iTEu4/54AcjNKgVsblj+5/uuBOrC0JavMaAGdhTN9TO+uWTLT8fM
 M+otvo3hOouHhBeVGqvTgumcAMxsa8XXdAILXFM6F4wuaKUV5ZQ7nudkbfqxU6/kqgDF
 YL1CISplAg0jPWsy1jNbL1i+pZB5meXsa0WnPcY5qOJeBRfc7DDq72USrwgh3KErQDCA
 O9OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJMiyZkdB2SegFbksM1a7dakzfPH1zviAXqxPqzBpbsw3GvntZ/F01KuyTAWExCgC5jIS1M1pYviR0TiqlHBcicJslqA==
X-Gm-Message-State: AOJu0YwDlyt1pD2V3AzPbuNsEdj9LWZb8xqT+hp/xGsXKESOOwUD1CZO
 lxsYSqoZuruxvMaeigGb2WfQ8RNTDvjqiePySQd7WKWMkHPlo0lmtOrauMROocMx828cIsKCcFa
 CKz3JvDz02pVxvMvXphiBN8tndJnT+1qrcskrdQ==
X-Google-Smtp-Source: AGHT+IE6iKxmfP9xJPF3X41uSxvLfvyubde1q0kbd7gkCd71lpAGsGBfHidT0iHtOhoBgYVh7Mca2ob2yNU3mDda3qQ=
X-Received: by 2002:a17:90b:4b45:b0:2a2:f9d:f600 with SMTP id
 mi5-20020a17090b4b4500b002a20f9df600mr7117961pjb.22.1713179506373; Mon, 15
 Apr 2024 04:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240415105405.432679-1-robert.marko@sartura.hr>
 <a2ea41b8-8656-4734-8594-c1d38a30e25e@linaro.org>
In-Reply-To: <a2ea41b8-8656-4734-8594-c1d38a30e25e@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 15 Apr 2024 13:11:35 +0200
Message-ID: <CA+HBbNH=UGLY63-bSoNmmV7ZBkt2zkbS0sdqbTLTmqikzhrb_g@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3-generic: fix support without DM_REGULATOR
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: marex@denx.de, trini@konsulko.com, jonas@kwiboo.se, 
 kever.yang@rock-chips.com, jagan@amarulasolutions.com, 
 mkorpershoek@baylibre.com, peter@korsgaard.com, sjg@chromium.org, 
 neil.armstrong@linaro.org, u-boot@lists.denx.de, j.beck@linefinity.com
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

On Mon, Apr 15, 2024 at 12:57=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
>
>
> On 15/04/2024 11:53, Robert Marko wrote:
> > Recent addition of vbus-supply support has broke platform which dont us=
e
> > controllable regulators for USB.
> >
> > Issue is that even withou DM_REGULATOR being enabled regulator related
> > functions will still build as there is a stub in regulator.h but they w=
ill
> > simply return -ENOSYS which will then make dwc3_generic_host_probe()
> > return the same error thus breaking probe.
>
> Rather than stubbing out the code, could you check for -ENOSYS and
> ignore the error in that case? I believe there's only one place where
> this matters (marked below).

Sure, that was my first approach but it did not seem right to me.
But if its OK with you, I can do that.

Regards,
Robert

> >
> > Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulato=
r")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/usb/dwc3/dwc3-generic.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-ge=
neric.c
> > index 7a00529a2a..784d3ec2ed 100644
> > --- a/drivers/usb/dwc3/dwc3-generic.c
> > +++ b/drivers/usb/dwc3/dwc3-generic.c
> > @@ -242,6 +242,7 @@ static int dwc3_generic_host_probe(struct udevice *=
dev)
> >       if (rc)
> >               return rc;
> >
> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> >       rc =3D device_get_supply_regulator(dev, "vbus-supply", &priv->vbu=
s_supply);
> >       if (rc)
> >               debug("%s: No vbus regulator found: %d\n", dev->name, rc)=
;
> > @@ -250,14 +251,17 @@ static int dwc3_generic_host_probe(struct udevice=
 *dev)
> >       rc =3D regulator_set_enable_if_allowed(priv->vbus_supply, true);
> >       if (rc)
> >               return rc;
>
> Here, if (rc && rc !=3D -ENOSYS)
> or even if (CONFIG_IS_ENABLED(DM_REGULATOR) && rc) to be verbose (maybe
> not the preferred style though).
>
> All the other regulator_* calls either ignore the result or only print a
> debug message.
> > +#endif
> >
> >       hccr =3D (struct xhci_hccr *)priv->gen_priv.base;
> >       hcor =3D (struct xhci_hcor *)(priv->gen_priv.base +
> >                       HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
> >
> >       rc =3D xhci_register(dev, hccr, hcor);
> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> >       if (rc)
> >               regulator_set_enable_if_allowed(priv->vbus_supply, false)=
;
> > +#endif
> >
> >       return rc;
> >  }
> > @@ -265,14 +269,18 @@ static int dwc3_generic_host_probe(struct udevice=
 *dev)
> >  static int dwc3_generic_host_remove(struct udevice *dev)
> >  {
> >       struct dwc3_generic_host_priv *priv =3D dev_get_priv(dev);
> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> >       int rc;
> > +#endif
> >
> >       /* This function always returns 0 */
> >       xhci_deregister(dev);
> >
> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> >       rc =3D regulator_set_enable_if_allowed(priv->vbus_supply, false);
> >       if (rc)
> >               debug("%s: Failed to disable vbus regulator: %d\n", dev->=
name, rc);
> > +#endif
> >
> >       return dwc3_generic_remove(dev, &priv->gen_priv);
> >  }
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
