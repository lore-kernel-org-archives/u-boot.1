Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81940C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 10:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8919B866BB;
	Fri, 25 Aug 2023 12:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mw/swVMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2A386795; Fri, 25 Aug 2023 12:27:58 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B3C866D4
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cryosay@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bca857accbso607178a34.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692959274; x=1693564074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgRxPGBVtXKvhuikIdD3/8wc3ZcXh6x8EF2/0GPgjk0=;
 b=Mw/swVMmSPMF8lPlasyCsJHwWkI2QG7dXrQFAEKbYRLBED958OSjFqKbyaDPQcYdrw
 v472p4Mhb5RSGZU08Mnw+0inqpughiyWOFUzA8Pmm+w/WYjD0xcluzY2ReeHmnhlcAX9
 1SsDAFeUT0VbLhoooe6GipmA4zlnhY51wPRZev4/eahLh3p1RU5Z/yYf6lQBHtmJt4DX
 FqXpAa9LEbShkHQrFWC6eJvXuKZreQPHsnE0H3BOJsO04BSoPELAPSBCPLtIKIENiq0K
 E0ZTtzbMt+at8LLp0BPbWNVff9loOEt6qFnzcYfj8+4Wgx88LnrP0CpiN3YbsA9rsf3c
 pOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692959274; x=1693564074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgRxPGBVtXKvhuikIdD3/8wc3ZcXh6x8EF2/0GPgjk0=;
 b=l6HB5837MK26IHE8coxsWi2offjMnTtfY/ykDjal8Z550SGMbx1yP6LuluGhR+DILO
 KQnp4nflbMquPEdjZiK26I4HlhOFmDQPpzqHTplRq55i+bvsyCAuSzbTEGpOggdKgnWN
 4SJxKo3wZa+Z+J2w+TKpScp3Az3RXihQop/fLPX6KTsx72+f2kikFWbHgPC90AsPz2M0
 LE65P9WIKgq8KJWPazo59EoqLEEcnbvMotxEHgPsfaYXQ4n7ci4zU87gY4rswCnEeiA+
 gi0TTZeODo09hTb0+DHIq6NMpUBbndvzaffcWt3ethsfUjJy4ZwJvreqeIGPZyY+IdlC
 mneg==
X-Gm-Message-State: AOJu0Yw9g+mnv3wNBNqTDwfODaN3ZXarDCoZEzgiETEomaN8ZaYiWZ3w
 9SSfdie2v6C8J8nH3N56G3f/bOqBF4Cg+m0/nVE=
X-Google-Smtp-Source: AGHT+IHLZtPFjrcepmKt+XNE7+ExhVAr8GCvOYKdYYIINJtBO1ZdVEDH2OdFWwYv0S+KuSCfk6U/7XjBE9PbU34w3H4=
X-Received: by 2002:a05:6830:108b:b0:6b9:4155:7dbd with SMTP id
 y11-20020a056830108b00b006b941557dbdmr4971706oto.0.1692959273949; Fri, 25 Aug
 2023 03:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230823182156.32353-1-oleksandr.suvorov@foundries.io>
 <3ff9dce0-4eee-16b8-9e8b-26842b4c9aef@denx.de>
In-Reply-To: <3ff9dce0-4eee-16b8-9e8b-26842b4c9aef@denx.de>
From: Oleksandr Suvorov <cryosay@gmail.com>
Date: Fri, 25 Aug 2023 13:27:36 +0300
Message-ID: <CAGgjyvGj1WgvSMefWLopS+rPnbomDM17RgK8ahxRktTifTUYJw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
To: Marek Vasut <marex@denx.de>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

On Wed, Aug 23, 2023 at 9:29=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 8/23/23 20:21, Oleksandr Suvorov wrote:
> > In the usb/dwc3-layerscape driver the first option should be renamed
> > to the latter as well. Do it.
> >
> > Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > ---
> >
> > Changes in v2:
> > - [asked by Tom Rini] shrink the code using CONFIG_IS_ENABLED()
> >
> >   drivers/usb/dwc3/dwc3-layerscape.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3=
-layerscape.c
> > index 79cf71f7a85..58baa017ad1 100644
> > --- a/drivers/usb/dwc3/dwc3-layerscape.c
> > +++ b/drivers/usb/dwc3/dwc3-layerscape.c
> > @@ -134,8 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) =3D {
> >   };
> >   #endif
> >
> > -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
> > -     !defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
> > +#if CONFIG_IS_ENABLED(USB_HOST)
> >   static int dwc3_layerscape_host_probe(struct udevice *dev)
> >   {
> >       struct xhci_hcor *hcor;
> > @@ -194,7 +193,7 @@ static int dwc3_layerscape_bind(struct udevice *dev=
)
> >               driver =3D "dwc3-layerscape-peripheral";
> >               break;
> >   #endif
> > -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || !defined(CONFIG_SPL_BUILD)
> > +#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>
> Why not CONFIG_IS_ENABLED(USB_HOST) here too ?

The original logic is not equivalent to CONFIG_IS_ENABLED(USB_HOST),
so IMHO it would be better to fix it in a separate commit.

--=20
Best regards
Oleksandr

Oleksandr Suvorov
cryosay@gmail.com
