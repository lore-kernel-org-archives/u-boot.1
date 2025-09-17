Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF48CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6632A8357D;
	Wed, 17 Sep 2025 15:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YxY3K4OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0957A835C6; Wed, 17 Sep 2025 15:41:03 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DCE833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ec44b601b8so1573026f8f.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758116460; x=1758721260; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viSlWv4V7bGn04ftwzJpengKJBBhmBYsZogdcO/ErsA=;
 b=YxY3K4OLRT46hRufQN98XSHrnSu5qOHfDX5Jsk7VvKusW1HewgFpmOS2TryriSoJOq
 KaDqeiSBl8y9zWi2OcBWdmsYVppW/MOrbJ8fXJ4nE1p287dXi1XddRSIYRDB3ZSnhvdl
 W0hzleyQTZgVd9PCu8pdNLPxb0/RUfrWzKOPeNEZaOoD0Dbd7zBeaVbPQxM43r+zlsby
 doSFTV0A9qpClh//PXpiMhAyiI6SiZi0dl/Gyhd0cnC3e3YnMpeQK+SeABIHVWV9nCRj
 RjLqCrDBdgsQIl/QW5m8gQzuRPkSXWHHp69swQuuGB1wzuu1WbymOabHm0yxwX6DG6Ta
 vJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116460; x=1758721260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viSlWv4V7bGn04ftwzJpengKJBBhmBYsZogdcO/ErsA=;
 b=xB8gsbseEhLaXkm67se0dr4/0+eK5DMwmIhpxd4a0RikHHoYd8go4R8+OwQnCLZqgO
 3DpSTrACpJlnBS0NHn5Sq5Qf7whkDSHuBFFFAQiZDP3Q9LlZr2UzkMd4MZQ7FSE+AT00
 KDyo54Aj/G6U7dpe/IQ3aU6zJM9zwwzJT0FftnhPiHGgQZdkqhgaNL2ZSeYorWF21iZK
 TJI6SUvvQw5AMmtlQ1qbh5sJ9c3zTAQFQDo5aM2wnNcJJltQqnegMYjAISh4rhE4Corc
 /NgHgdHNOFcXZw70cCeB0C6sbzQU4C/pXVbK/s6+f6chw+nU1HooW7fVx72asCmW31KO
 GiWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9g0u49H32BaDyR73HxmN7rey76DN7o+tXRS/fO6mB//J4skvYXW4bp7yqUFbe4NEdF5KaQ9I=@lists.denx.de
X-Gm-Message-State: AOJu0YwM9cFCVK7xBmoR/iMuCysxbXYBaSjpI3uigZ/HnduG4nRN2fFF
 m2bOOnK7rXYmn9MEyMKifrfoH0wm2UfVL0kuG3XGe9PLUxKnQNs4ZLsQUHIVa/rc/cKanGryMrL
 iNXAoNxAz9chcFCXZ5nhpkgf908ojwfwi2Q==
X-Gm-Gg: ASbGncuJTRb0QspyhNwzCnOl3jQXhbgNvKrvfGFjSUciubq9Uj4khjI5Z3Rn2upA+MN
 WjPtsSfu0Rh8/6QdSxBjpCaZ5Lygg8Fy/XHVBEss5roT3mONUPcYeFo/zBt777SG1TnyFQp3ql0
 FiaOaAZTeyDDZeNHQ0iTEFA6B8YZ2Q9szNbitql8RPCcoI82dZThp1wAqwE5TeZngoBcVEdY4Z0
 G9qtIx3
X-Google-Smtp-Source: AGHT+IHBCdU7A827POLMAjtKPCkUZFbIX2/X6fVVmiRLFGEqNBQMd/8L10izc+/s6XeDLAd9Iu9wIrnu6FFfLVYO5v0=
X-Received: by 2002:a05:6000:604:b0:3e9:3647:bb1e with SMTP id
 ffacd0b85a97d-3ecdfa5ed9emr2509138f8f.44.1758116460078; Wed, 17 Sep 2025
 06:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <20250917144604.49f792b4@wsk>
In-Reply-To: <20250917144604.49f792b4@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 17 Sep 2025 16:40:48 +0300
X-Gm-Features: AS18NWBKBO79My630LeM9h5ccxzbJhBpamU7HEgtvQWO3WCbsnv-gGj2KQrzKCA
Message-ID: <CAPVz0n2RGNHTtvjauhgjhOGfN5G473aFEM+bv1e=ErQS_jb8Jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
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

=D1=81=D1=80, 17 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:46 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Dear Community,
>
> > The Tegra30 SoC is a bit special, as it doesn't have the separate IP
> > block to provide watchdog functionality.
> >
> > Instead, timer IP block allows such functionality when properly
> > configured.
> >
> > As in the tegra30.dtsi there is a timer node, which "covers" all
> > timers, with 'nvidia,tegra30-timer' compatibility it was necessary to
> > manually bind U-Boot's WDT driver (based on WDT_UCLASS).
> >

You don't need to describe all this, just describe what you have done
in the patch.

> > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > ---
> >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/timer/tegra-timer.c b/drivers/timer/tegra-timer.c
> > index 3545424889d..361539efa43 100644
> > --- a/drivers/timer/tegra-timer.c
> > +++ b/drivers/timer/tegra-timer.c
> > @@ -11,6 +11,8 @@
> >  #include <asm/arch/clock.h>
> >  #include <asm/arch/tegra.h>
> >
> > +#include <dm/lists.h>
> > +
> >  #define TEGRA_OSC_CLK_ENB_L_SET              (NV_PA_CLK_RST_BASE +
> > 0x320) #define TEGRA_OSC_SET_CLK_ENB_TMR      BIT(5)
> >
> > @@ -106,6 +108,21 @@ static int tegra_timer_probe(struct udevice *dev)
> >       return 0;
> >  }
> >
> > +static int tegra_timer_bind(struct udevice *dev)
> > +{
> > +     /*
> > +      * In Tegra 30 SoC the Watchdog is accomplished

remove the Tegra30 SoC, all Tegra SoC generation can use timer 5 as
watchdog, not only Tegra30

> > +      * by the timer IP block (timer5).
> > +      */
> > +     if (CONFIG_IS_ENABLED(WDT_TEGRA))
> > +             return device_bind_driver_to_node(dev, "tegra_wdt",
> > +                                               "tegra-wdt",
> > +                                               dev_ofnode(dev),
> > +                                               NULL);
> > +
> > +     return 0;
> > +}
> > +
> >  static const struct timer_ops tegra_timer_ops =3D {
> >       .get_count =3D tegra_timer_get_count,
> >  };
> > @@ -124,6 +141,7 @@ U_BOOT_DRIVER(tegra_timer) =3D {
> >       .id             =3D UCLASS_TIMER,
> >       .of_match       =3D tegra_timer_ids,
> >       .probe          =3D tegra_timer_probe,
> > +     .bind           =3D tegra_timer_bind,
> >       .ops            =3D &tegra_timer_ops,
> >       .flags          =3D DM_FLAG_PRE_RELOC,
> >  };
>
> Are there any new comments regarding this patch set?
>
> --
> Best regards,
>
> Lukasz Majewski
>
> --
> Nabla Software Engineering GmbH
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschftsfhrer : Stefano Babic
