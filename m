Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A927CCE79AB
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 07:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC0286AC0;
	Wed, 20 Sep 2023 09:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NxtiVddI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176B986AA7; Wed, 20 Sep 2023 09:45:35 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C74586C3E
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 09:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-530e180ffcbso4192226a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1695195931; x=1695800731;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y6wFaQuObfeEipzODxmiguDZEKiWBCREDCNx43vJogk=;
 b=NxtiVddIZpm6l2Z0kyfAoiduLd+GISlCiaZZrQGXZ7dVHaf7wxMMx3N94+C2Oqbs/n
 KTZ0D2buK+IohxyKLmoqXYYPiO3XkFwmwfUxMZL2w3V09mzDHVHMF6kvtYO0Bu/pxpMG
 f5Q4dN5g3566hnpfrsnbKvcD46YTt/DUGnZn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695195931; x=1695800731;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6wFaQuObfeEipzODxmiguDZEKiWBCREDCNx43vJogk=;
 b=HBYcYIPlRRyboylK0/ui1UcPxnNob3pkeBfmJCMs1kRPul0jevwMZYSfW5e+U15to7
 Srr1+wk2CO/nsvhuQSQJ9xdIjj+nuzZGaC0ywLc300qy4gsSRgXwXsLgfG6laNStZCYN
 qmqMHNa5pTDsFn507BilzmXJlUPnJCb9ibBKJU9D9u0VSDaGsA1tWg/Ryk+jrcTSyblD
 puTwUr1beoCadBeoNObVt4RAoSKF2rlVCc84Z4wnvlbv5hHVGFg7clPVEOK3qFrKtv9G
 gz55lK23KL3Udj+L3O+N/unu9Sz1g58JYSKygWmMuuieubps2KAlq7Z+LulyMgaeZ72u
 zKEA==
X-Gm-Message-State: AOJu0YzDl31VONi8Nkw7105s/yeHxW+pZIIYRjc9ObGpU3KiA0s2hf2e
 wIAphuwuKDKcCjgi/RCvMGk4o4d0F3CNskCJSqvNtQ==
X-Google-Smtp-Source: AGHT+IG9lfxxdc65YE+c/9HDzZOcmJNcmoGPKKnowO9r9Z5vYHz4/w2B3/fyoiecjs2XPum75XumEPoHWwewHZg46yE=
X-Received: by 2002:aa7:d291:0:b0:525:734a:bf30 with SMTP id
 w17-20020aa7d291000000b00525734abf30mr1545157edq.36.1695195930603; Wed, 20
 Sep 2023 00:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230808130250.188588-1-ada@thorsis.com>
 <20230808130250.188588-3-ada@thorsis.com>
 <CAOf5uwkgaoGyB3kS7Kf4GZyvAcGDJMTRPajXa4SQVy7LU6BJDA@mail.gmail.com>
 <20230808-elusive-apple-4e3ce1331b5a@ifak-system.com>
 <e913d8c6-3daf-0a58-3813-253cb5dee79c@collabora.com>
 <CAOf5uwkzJXU6XU-3gaSAkApzjv0Yf_C7iqjwrVptsyWyfRTm8g@mail.gmail.com>
 <e05bf619-0d9b-2b56-9b50-41b1e24b5500@collabora.com>
 <20230920-renewed-lantern-717bbbd48120@ifak-system.com>
In-Reply-To: <20230920-renewed-lantern-717bbbd48120@ifak-system.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 20 Sep 2023 09:45:18 +0200
Message-ID: <CAOf5uwm8LHejpxf7A1R_0iymr6d2rcbYTLHeg-sGv4Y1vrS2_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: nand: raw: atmel: Add error handling when
 rb-gpios missing
To: Eugen Hristev <eugen.hristev@collabora.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Mihai Sain <mihai.sain@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Il mer 20 set 2023, 08:13 Alexander Dahl <ada@thorsis.com> ha scritto:

> Hello Eugen, hello Michael,
>
> Am Wed, Aug 23, 2023 at 01:59:58PM +0300 schrieb Eugen Hristev:
> > On 8/23/23 09:54, Michael Nazzareno Trimarchi wrote:
> > > Hi
> > >
> > > On Wed, Aug 23, 2023 at 8:28=E2=80=AFAM Eugen Hristev
> > > <eugen.hristev@collabora.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 8/8/23 18:03, Alexander Dahl wrote:
> > > > > Hello Michael,
> > > > >
> > > > > Am Tue, Aug 08, 2023 at 03:49:45PM +0200 schrieb Michael Nazzaren=
o
> Trimarchi:
> > > > > > Hi
> > > > > >
> > > > > > On Tue, Aug 8, 2023 at 3:03=E2=80=AFPM Alexander Dahl <ada@thor=
sis.com>
> wrote:
> > > > > > >
> > > > > > > Adapt behaviour to Linux kernel driver.
> > > > > > >
> > > > > > > The return value of gpio_request_by_name_nodev() was not
> checked before,
> > > > > > > and thus in case 'rb-gpios' was missing in DT, rb.type was se=
t
> to
> > > > > > > ATMEL_NAND_GPIO_RB nevertheless, leading to output like this
> for
> > > > > > > example (on sam9x60-curiosity with the line removed from dts)=
:
> > > > > > >
> > > > > > >       NAND:  Could not find valid ONFI parameter page; aborti=
ng
> > > > > > >       device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> > > > > > >       Macronix NAND 512MiB 3,3V 8-bit
> > > > > > >       512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB
> size: 64
> > > > > > >       atmel-nand-controller nand-controller: NAND scan failed=
:
> -22
> > > > > > >       Failed to probe nand driver (err =3D -22)
> > > > > > >       Failed to initialize NAND controller. (error -22)
> > > > > > >       0 MiB
> > > > > > >
> > > > > > > Note: not having that gpio assigned in dts is fine, the drive=
r
> does not
> > > > > > > override nand_chip->dev_ready() then and a generic solution i=
s
> used.
> > > > > > >
> > > > > > > Fixes: 6a8dfd57220d ("nand: atmel: Add DM based NAND driver")
> > > > > > > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > > > > > > ---
> > > > > > >    drivers/mtd/nand/raw/atmel/nand-controller.c | 11
> +++++++----
> > > > > > >    1 file changed, 7 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c
> b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > > > > > > index 2b29c8def6..8e745a5111 100644
> > > > > > > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > > > > > > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > > > > > > @@ -1600,10 +1600,13 @@ static struct atmel_nand
> *atmel_nand_create(struct atmel_nand_controller *nc,
> > > > > > >                           nand->cs[i].rb.type =3D
> ATMEL_NAND_NATIVE_RB;
> > > > > > >                           nand->cs[i].rb.id =3D val;
> > > > > > >                   } else {
> > > > > > > -                       gpio_request_by_name_nodev(np,
> "rb-gpios", 0,
> > > > > > > -
> &nand->cs[i].rb.gpio,
> > > > > > > -
> GPIOD_IS_IN);
> > > > > > > -                       nand->cs[i].rb.type =3D
> ATMEL_NAND_GPIO_RB;
> > > > > > > +                       ret =3D gpio_request_by_name_nodev(np=
,
> "rb-gpios", 0,
> > > > > > > +
> &nand->cs[i].rb.gpio,
> > > > > > > +
> GPIOD_IS_IN);
> > > > > > > +                       if (ret)
> > > > > > > +                               dev_err(nc->dev, "Failed to
> get R/B gpio (err =3D %d)\n", ret);
> > > > > >
> > > > > > Should not then an error here
> > > > >
> > > > > Different log level or no message at all?
> > > > >
> > > > > Note: Linux prints the same message with error level in that case=
.
> > > > >
> > > > > Greets
> > > > > Alex
> > > > >
> > > >
> > > > Since the rb-gpios is optional, we can continue probing without it.
> > > > Throwing an error message is optional and pure informative. So I am
> fine
> > > > with it
> > > >
> > >
> > > Yes ok, but I'm not sure linux give an error if the gpio is get as
> > > optional and condition
> > > is IS_ERR. Am I right?
> >
> >
> >                       if (IS_ERR(gpio) && PTR_ERR(gpio) !=3D -ENOENT) {
> >                               dev_err(nc->dev,
> >                                       "Failed to get R/B gpio (err =3D
> %ld)\n",
> >                                       PTR_ERR(gpio));
> >                               return ERR_CAST(gpio);
> >                       }
> >
> > So Linux throws the message if IS_ERR . If the property is missing
> (ENOENT)
> > it moves on.
> >
> > Can we replicate the same behavior or this behavior does not suit us in
> > U-boot ?
> >
> > Basically I think it should be :
> >
> >               if (ret && ret !=3D -ENOENT)
> >                       dev_err(...)
> >               if (!ret)
> >                       rb.type =3D ATMEL_NAND_GPIO_RB;
> >
> > Is this what you had in mind Michael ?
>
> The discussion between you guys somehow got stuck.  I still have this
> patch on my TODO list, but I'm not sure how to proceed.  Please advice
> in which direction to go forward, there's still an error condition
> (described in the initial commit message) here, which needs to be
> handled, otherwise the NAND flash might not be usable.


Yes the suggestion above is what is the right path to follow.

Michael

>
> Greets
> Alex
>
> >
> > Eugen
> >
> > >
> > > For the rest is fine
> > >
> > > Michael
> > >
> > > > What I wanted to ask is what happens with nand->cs[i].rb.type , is
> it 0
> > > > by default ?
> > > >
> > > > Other than that, I can apply this patch, Michael, do you have any
> more
> > > > comments on it ?
> > > >
> > > > Thanks,
> > > > Eugen
> > > > > >
> > > > > > Michael
> > > > > >
> > > > > > > +                       else
> > > > > > > +                               nand->cs[i].rb.type =3D
> ATMEL_NAND_GPIO_RB;
> > > > > > >                   }
> > > > > > >
> > > > > > >                   gpio_request_by_name_nodev(np, "cs-gpios", =
0,
> > > > > > > --
> > > > > > > 2.30.2
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Michael Nazzareno Trimarchi
> > > > > > Co-Founder & Chief Executive Officer
> > > > > > M. +39 347 913 2170
> > > > > > michael@amarulasolutions.com
> > > > > > __________________________________
> > > > > >
> > > > > > Amarula Solutions BV
> > > > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > > > > T. +31 (0)85 111 9172
> > > > > > info@amarulasolutions.com
> > > > > > www.amarulasolutions.com
> > > >
> > >
> > >
> >
>
