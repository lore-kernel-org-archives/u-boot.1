Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D1DC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 11:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E9B878E9;
	Thu,  8 Feb 2024 12:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="GSCz6GAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8245887D1E; Thu,  8 Feb 2024 12:30:25 +0100 (CET)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE4118753E
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 12:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4c01ca67504so643502e0c.2
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707391821; x=1707996621;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHPtZy9lAlkx+OTcN3Yv2JpZSR5yJlzw3PUSWMooKo8=;
 b=GSCz6GAMo1Lq1II0q7xu0WLq+gSP6LNMbmz1IrPo9J/p17LSdqM3TuJTEXrI1INFp/
 WUq9U9ekmtRZXmG6YeYLiinvKGxPbSvBMBxszq0NoYaqovAjJHUFT5tJ4l74lwBj0JiJ
 2fKyoYOszOrcMQ+lGd8enLXhBVA48q7PJvCcu7klSUzkuVoSzjul0WHSGRWN+KeV+0Bz
 4DihwCy9v1rxdA+ZLZXDtgu/3juuGre8MlEMl4/eHx1a4VBflVQ8XZEhrKx+FloaEaU5
 t6H7urlhJDAjWSVAKi+SuDwNx23bWtSsmOIZEvHd0m2pVN1Y+y/lcj68hmloyGfFkqJt
 TT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707391821; x=1707996621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHPtZy9lAlkx+OTcN3Yv2JpZSR5yJlzw3PUSWMooKo8=;
 b=aL/ilXIXM/X+5wqOC0zzoN3HrmgD0Z2Of7FUH/xBPOVqXOVLidljsRrjdx26KsRJFt
 mhgQTNl/BADwgSu1UwzCThsaBCnfxM99MqW13Zi61jpXLNh4yaemo+WKj3OJJSV806FI
 SCNarsiR8Nr5pPyrjsuH0va9s7CNl88bT4CZytFTkO1zjJm8MQl8TUzZ/w9yd+dj+4wi
 1gFMMzVqKLu1dnW9zNqB2gUSDzCsmvKKFd94bTilPROyF1WeYWyDCWduEj9/hloZh05F
 3Mp2U7xD5MIfQyVbiI+AFoKnsP13zfq2RbNCEJ2t3jPBwtXiaXWd2c8jpD1m6W10bWWP
 r19g==
X-Gm-Message-State: AOJu0YwvOa8uVmpQPT6OzzboPJDvSlikLLWTzSnIeMNs9HMVPhvdEAuB
 R9Meou7WhodfxykZJkL0Mf08l0PiH086QIIoKs4cUqzweFjAo2sKeUrHttwUPkXo0ptHI3z4yUv
 l4OfvYfMuVNzNSWZv9ZsKOCdeU8Ipa2Pj/Iex1g==
X-Google-Smtp-Source: AGHT+IF5a6O+3LW0jIiekXg4PiIanKzWrR5DmAfJv7F8viYfppM8kL52EdnDA/zRhS9xUxrxHCk36qoKZdAb5i+sW94=
X-Received: by 2002:a05:6122:4f10:b0:4bd:6486:16fc with SMTP id
 gh16-20020a0561224f1000b004bd648616fcmr5210056vkb.6.1707391821593; Thu, 08
 Feb 2024 03:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
In-Reply-To: <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 8 Feb 2024 11:30:10 +0000
Message-ID: <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, dsimic@manjaro.org, 
 Hector Martin <marcan@marcan.st>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Wed, Feb 7, 2024 at 1:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 2/7/24 11:23, Shantur Rathore wrote:
> > USB 3.0 spec requires hub to reset device while
> > enumeration. Some USB 2.0 hubs / devices don't
> > handle this well and after implementation of
> > reset some USB 2.0 disks weren't detected on
> > Allwinner based boards.
> >
> > Resetting only when hub is USB 3.0 fixes it.
>
> It would be good to include as many details about the faulty hardware in
> the commit message as possible, so that when someone else runs into
> this, they would have all that information available.
>
> > Tested-by: Andre Przywara <andre.przywara@arm.com>
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >
> >   common/usb_hub.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/usb_hub.c b/common/usb_hub.c
> > index 3fb7e14d10..2e054eb935 100644
> > --- a/common/usb_hub.c
> > +++ b/common/usb_hub.c
> > @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device=
 *hub)
> >
> >       debug("enabling power on all ports\n");
> >       for (i =3D 0; i < dev->maxchild; i++) {
> > -             usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> > -             debug("Reset : port %d returns %lX\n", i + 1, dev->status=
);
> > +             if (usb_hub_is_superspeed(dev)) {
>
> Should this condition be "all which are lower than superspeed" instead ,
> so when the next generation of USB comes, this problem won't trigger ?
>
> What does Linux do btw ?

As of now Linux checks if the hub is superspeed
https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2859

which is
 return hdev->descriptor.bDeviceProtocol =3D=3D USB_HUB_PR_SS; // USB_HUB_P=
R_SS =3D 3

This holds true for newer SuperSpeedPlus hubs as well.
https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.h#L155

We can change the check to be  bDeviceProtocol > 2 but who knows if
things change in the newer version of spec.
I am open to suggestions.

Kind regards,
Shantur
