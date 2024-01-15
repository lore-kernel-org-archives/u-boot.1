Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BCFC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 23:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3440F8751B;
	Tue, 16 Jan 2024 00:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="RZilaGFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6BE876EF; Tue, 16 Jan 2024 00:32:51 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F37B86F80
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 00:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7cc4647543aso2755566241.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1705361568; x=1705966368;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOH0+FZMREW/bkIOFXXz87lxzVsYfBP9HEiijQJVG8o=;
 b=RZilaGFpM5RevNbDx7KQuioCkayTd1wtKTou9b2exqIjnqcGPcOPNHAnEunwd6dWDy
 Y2q4K+sjD6EZN9g49onAIHW+X4VQptDodKFytxzn1qi0P8VHVbZ2wTsfPPKd4w1MCDiI
 Yf7T7raFflTcLPp680VMWHNzU2/nHnypyHn0ZL2uBlIfxE1dECWodJ6kllRy2ZDTelpn
 dWidJ6FUDyObwW8CsZ8WsWzkcioACcX4jTg9se6TRd3iw3Ltuh5m47+1vxElD5vYAovW
 mJXSbJJWxIDP35NtIcGO34asxLPJ+jcM8A2uExGFYhgNAR+Vg2Hgnk5CkSmfSxejzcFh
 viCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705361568; x=1705966368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOH0+FZMREW/bkIOFXXz87lxzVsYfBP9HEiijQJVG8o=;
 b=hnNK10zIjeHcMXXem3ZiSTcfgsxkfbewNO83KCXzYuJTzc60eKVDARmyfsIZLdAHZu
 9OjyfGdXdaJDH1C0QjEThC1xEXrvKjGegIddzpoIxDTYvmuUaYjOCk64ADHvtapZYDJT
 GTCahfQJwNnnw7myT8aYonFEA+pksluf2hoheLofNiR9QlepYkrFgfPtUjFDc1IUJNm1
 QgeLbvlttnlSna2vRaBSDwMI2VJofS8z54im+NN6kKzXhdR2eyZskIeh2loAoKcz+CU2
 14Yd3C8o/j0bQdo+dxgq+VWbBBJrCaL8zNUaxMIfAKPNu2nqQOVcD+gAFlivmySbfDdZ
 D/7A==
X-Gm-Message-State: AOJu0Yz856oOxk29xD3mRb8Oo418LkIuVb02q+nF5Jv0qdypy1pfNml/
 k+8f3qJMNfjY7zJgCy3Iy/pM4aCuhHyRSzPSf0l9jX/LWlcjmA==
X-Google-Smtp-Source: AGHT+IGtwSX1uUZnGOGSb8mznDKtMAaIU7u/uQ/cSIBX/7WHxW2LFtPXahFGV8J9AUmNcg/EhfpJfT0ykkc1jHaVIVQ=
X-Received: by 2002:a05:6122:2887:b0:4b7:8e5f:7782 with SMTP id
 fl7-20020a056122288700b004b78e5f7782mr2974721vkb.8.1705361567968; Mon, 15 Jan
 2024 15:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <CABEcMwWzt=z=3XNWq5iAKmmnB+UsjTzp4_OUs3V8bNuc_i5zMw@mail.gmail.com>
In-Reply-To: <CABEcMwWzt=z=3XNWq5iAKmmnB+UsjTzp4_OUs3V8bNuc_i5zMw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 15 Jan 2024 23:32:37 +0000
Message-ID: <CABEcMwU4Ca8hfVfri-_74zm64+qdFwEK5Z+_KRNe+X81N7yNGA@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Mon, Jan 8, 2024 at 10:11=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
> Hi Marex,
>
> On Sat, Dec 9, 2023 at 6:12=E2=80=AFPM Shantur Rathore <i@shantur.com> wr=
ote:
> >
> > Currently when a hub is turned on, all the ports are powered on.
> > This works well for hubs which have individual power control.
> >
> > For the hubs without individual power control this has no effect.
> > Mostly in these scenarios the hub port is powered before the USB
> > controller is enabled, this can lead to some devices in unexpected
> > state.
> >
> > With this patch, we explicitly reset the port while powering up hub
> > This resets the port for hubs without port power control and has
> > no effect on hubs with port power control as the port is still off.
> >
> > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > detected as a USB3.0 Mass Storage device but with this it works as
> > expected.
> >
> > Tested working after this patch:
> > 1. AMicro AM8180 based NVME to USB Adapter
> > 2. Kingston DataTraveler 3.0
> > 3. GenesysLogic USB3.0 Hub
> >
> > The drives were tested while connected directly and via the hub.
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> >
> > ---
> >
> > Changes in v3:
> > - Split up patches as seperate series
> >
> > Changes in v2:
> > - As requested, added fix for regulator-always-on in RockPro64
> >
> >  common/usb_hub.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/usb_hub.c b/common/usb_hub.c
> > index 70279f301d..3fb7e14d10 100644
> > --- a/common/usb_hub.c
> > +++ b/common/usb_hub.c
> > @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device=
 *hub)
> >
> >         debug("enabling power on all ports\n");
> >         for (i =3D 0; i < dev->maxchild; i++) {
> > +               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> > +               debug("Reset : port %d returns %lX\n", i + 1, dev->stat=
us);
> >                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
> > -               debug("port %d returns %lX\n", i + 1, dev->status);
> > +               debug("PowerOn : port %d returns %lX\n", i + 1, dev->st=
atus);
> >         }
> >
> >  #ifdef CONFIG_SANDBOX
> > --
> > 2.40.1
> >
>
> Do you think it is the right time to get this in early so it can be
> tested for a longer time before the next release ?
>
> Kind regards,
> Shantur

Ping.
