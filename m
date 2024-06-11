Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5FDC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AD38871E;
	Tue, 11 Jun 2024 23:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbH92Kkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2341588732; Tue, 11 Jun 2024 23:43:00 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFB48871E
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so74312511fa.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718142177; x=1718746977; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mrmbbhms7NUUwiMgALvSgcqkLu1IrOOMJPyzsmxvwP4=;
 b=CbH92KkwR+PxQYpOO6APAI1QiRCXguEW1LStaYpwJehERsAoGloNjMUpLKLuLVR9hs
 cXr2rrgy5OUJGw6+KJ08HW00OhUVG5QRm4NiZ30kRxbwjRZpByBW9HeLQQDd3qmKFl3k
 vpr/vYKr3z17Ltyu98iTvwk7iSmlOc3zKQpBz0euk4/Ra+yNhV7y62SzHlzs2t+YPh+9
 3mW9A5pwXFxkgkIhUqPhCFch4zsfaW/yw88tW3VqXkY5yv+8mcEgJcE3zhv9rf8/nybH
 Hmlzl89KA8WitiokIPwpqFhxjBG19M+iQaLxjDwulEoOEfD9K547wHSdtAhdW1O3gxLl
 5lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718142177; x=1718746977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mrmbbhms7NUUwiMgALvSgcqkLu1IrOOMJPyzsmxvwP4=;
 b=UO1Yz/rVHD5pGRlh+qxocGrdw/lmq0CLHUK0PLzDmayQrExsYrLRMqsieiwEFAhHkY
 A99ULc7Mo/Ft+eoO5DIpGNsleTsuJQ8JuUYkaPcQLmI8DgIeblpApPeo0lUSAVNZQIMU
 o1fDvUNcipJItC8N1wdDAtTQMqEeO/X5jd4CXKJyRUTzjbN5EJNDQZIHE1tGTjezK/4O
 7qaTDw9CqwX/S9zVUE3dii3y88ptKluvPviG8EDdO0tCe0j1afpHZ1Dg2voMrtkjhWSp
 GkwNYpZHj4DxdFMGWMzE8zRwr3rhh4IqUAyW14TKB99QTRl2Dn9v4oeOWY6ffZI8wdDn
 C4Dg==
X-Gm-Message-State: AOJu0YxM6D1zSTDl2Mzr+9qmQ8Fxz/GUNbSAXcTDPP1eUk1/JkViaFaj
 GGubzEZN1VWdUCQo8o/2vD0hOg4VUfRWpSWqRFx3oDkrET2QRVLaAaHKOaU07Jc/xIxtcsDcD0b
 h3NJ/M8w64D2VSdhYibXNABRW7V8=
X-Google-Smtp-Source: AGHT+IGvy4PRgAfX1wkRwD6d6tMoiKOApOs2YtWzfE/DNN6LQMiBurGO+uROSjdXxGrjibQUeoEb4r9cZmdvLPDDjJ8=
X-Received: by 2002:a2e:241a:0:b0:2ea:e12e:bee5 with SMTP id
 38308e7fff4ca-2ebfc8ff832mr238961fa.4.1718142176531; Tue, 11 Jun 2024
 14:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240610003431.14148-1-mibodhi@gmail.com>
 <2f5754a5c9f50ed735d80153f1e72082@manjaro.org>
In-Reply-To: <2f5754a5c9f50ed735d80153f1e72082@manjaro.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 11 Jun 2024 14:42:44 -0700
Message-ID: <CAJaLiFwLYFoRsewPi=ZEUQ8eRCH3aC1ubqcO0FTjHs9A85sKTA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: mvebu: Update DTS for Thecus N2350 board
To: Dragan Simic <dsimic@manjaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
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

Hi Dragan,

On Sun, Jun 9, 2024 at 6:07=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Tony,
>
> Please see a few comments below.
>
> On 2024-06-10 02:34, Tony Dinh wrote:
> > - Change the spi-max-frequency to 50000000 (50 Mhz). According to the
> > data sheet[1], the MX25L3205D max frequency is 86 Mhz. Using 50 Mhz in
> > the DTS to ensure u-boot is consistent with what Linux kernel expected.
> > - Update GPIO fan to conform to the latest DT binding.
>
> There's no need for the bullet points, plain prose will do fine instead.

I like bullet points :) All my patch descriptions have bullet points
when there are 2 or more different items.

>
> > [1]
> > MX25L3205D-MX25L1605D-MX25L6405D-Macronix-MX25L3205DM2I-12G-datasheet.p=
df
>
> Unless you can provide a real, working URL for the datasheet, this
> reference
> should actually be deleted.

It was my oversight. That should have been this URL:

https://www.macronix.com/Lists/Datasheet/Attachments/8575/MX25L3205D,%203V,=
%2032Mb,%20v1.5.pdf

I'll wait for Stefan to review the patch and let him decide whether I
should send in a V2 patch or he will modify the commit description.

Thanks for the comments!

All the best,
Tony

>
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  arch/arm/dts/armada-385-thecus-n2350.dts | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/dts/armada-385-thecus-n2350.dts
> > b/arch/arm/dts/armada-385-thecus-n2350.dts
> > index 253cf01130..fdaa444e51 100644
> > --- a/arch/arm/dts/armada-385-thecus-n2350.dts
> > +++ b/arch/arm/dts/armada-385-thecus-n2350.dts
> > @@ -2,7 +2,7 @@
> >  /*
> >   * Device Tree file for Thecus N2350 board
> >   *
> > - * Copyright (C) 2018-2023 Tony Dinh <mibodhi@gmail.com>
> > + * Copyright (C) 2018-2024 Tony Dinh <mibodhi@gmail.com>
> >   * Copyright (C) 2018 Manuel Jung <manuel.jung@hotmail.com>
> >   */
> >
> > @@ -143,9 +143,9 @@
> >       fan {
> >               compatible =3D "gpio-fan";
> >               gpios =3D <&gpio1 16 GPIO_ACTIVE_HIGH>;
> > -             gpio-fan,speed-map =3D <    0  0
> > -                                     600  1
> > -                                     3000 2 >;
> > +             gpio-fan,speed-map =3D <    0  0>,
> > +                                     <600  1>,
> > +                                     <3000 2 >;
> >               pinctrl-0 =3D <&pmx_fan>;
> >               pinctrl-names =3D "default";
> >       };
> > @@ -415,7 +415,7 @@
> >               compatible =3D "jedec,spi-nor";
> >               reg =3D <0>;
> >
> > -             spi-max-frequency =3D <108000000>;
> > +             spi-max-frequency =3D <50000000>;
> >               spi-cpha;
> >
> >               partition@0 {
