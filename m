Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470B0C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 08:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966338800C;
	Wed, 14 Aug 2024 10:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XM+FM3yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD940889B4; Wed, 14 Aug 2024 10:17:33 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F5885B66
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 10:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so685246566b.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723623451; x=1724228251;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZWl/mkCX+T5hiKbbfPSPQ7fRq8WfoVtLgu2kBTiSyA=;
 b=XM+FM3yF+q89ewGzO/1vQggxve6OyCvGD4lxsaHrC5aO9k9cH4KsOPh7lpwpQ/Yuri
 DnLBsFJ6tSSFvTvQRfcrRXYiKbd+6EZ7pHctErxmAgjjZYHOhvXwOIVWbT4eyTYZgh0B
 agTqGeqCWwn/o8PWVCdq6iI4lTlPGsVWagNT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723623451; x=1724228251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ZWl/mkCX+T5hiKbbfPSPQ7fRq8WfoVtLgu2kBTiSyA=;
 b=cNJdVDi18wKqXtJmHne3fGMfVed2AD1RRQmrKACREFXwT1pBdDCiHfG3l8aeSW2dR7
 r/KfMhmlU87CPS4Ptc7Y5obDz0K9NC+I7DGfZO0lcS+uUl3xQEtp3hCVdwUaqtrCeLpe
 PusDMDKnUKtAYVSAggGPqqZ38gi0z13CwVhz2JrftOt7aEP8nUKP5mJmck9hBdLc+zzW
 GFstP25E12642F/gFJwxjyIt34eGzWNuIUsgjA8F/GHl4ldDCTkTqnLsrooBD/iWGZmL
 jdLzKoOsq0Qox5fSR5BhXLYRnO8CU317+nJFapjEz0nuguoXVIQvJGTShcl987L/AIF3
 dUzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtDyH8FnN/JpLJnYMjdsdhxTlMU/ET+k7DRTUgqiemwlOC03jRHaLxxoiSNQZpGErvwQK8iSItBCJsZnSNTKF7pxpbbQ==
X-Gm-Message-State: AOJu0Yy6zKopBS1x8trdRuR9aerG0WeE8jgeGLKPTvGniD7ENjfkRdyR
 G8KSz/0DzAfH1VacMzhbr38EcI7++RBiQnslHQ5h/YAdwleQpL+JhOTJ18bqn0BkLpYXJ1UmTbz
 TiD0X3gnFOZRiNO3ezfQxaqRkXQxfIbGZMq/UoA==
X-Google-Smtp-Source: AGHT+IFYFrjvwUaa5hFzZrCr6/uR42dLaosNzbQhwCzDIAft8XjNRr8oDQLq3iiSr5jlOgg4EMGsgRvLrumoUkIyBo8=
X-Received: by 2002:a17:907:e615:b0:a7a:ba59:3164 with SMTP id
 a640c23a62f3a-a8366ff3fdemr130828066b.53.1723623450985; Wed, 14 Aug 2024
 01:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-9-ansuelsmth@gmail.com>
 <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
In-Reply-To: <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 14 Aug 2024 10:17:18 +0200
Message-ID: <CAOf5uw=x866W0Uw0ZmDrD4eAputNBb3n3b=-TED2ga4H+MfYPw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ubi: implement support for LED activity
To: hs@denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Dmitry Dunaev <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
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

Hi all

On Wed, Aug 14, 2024 at 6:34=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Christian,
>
> On 12.08.24 12:32, Christian Marangi wrote:
> > Implement support for LED activity. If the feature is enabled,
> > make the defined ACTIVITY LED to signal ubi write operation.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   cmd/ubi.c | 17 +++++++++++++++--
> >   1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > index 0e62e449327..6f679eae9c3 100644
> > --- a/cmd/ubi.c
> > +++ b/cmd/ubi.c
> > @@ -14,6 +14,7 @@
> >   #include <command.h>
> >   #include <env.h>
> >   #include <exports.h>
> > +#include <led.h>
> >   #include <malloc.h>
> >   #include <memalign.h>
> >   #include <mtd.h>
> > @@ -488,10 +489,22 @@ exit:
> >
> >   int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t s=
ize)
> >   {
> > +     int ret;
> > +
> > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > +     led_activity_blink();
> > +#endif
>
> Do we really need ifdef? May it is possible to declare an empty function
> when CONFIG_LED_ACTIVITY_ENABLE is not set? May this applies for the whol=
e
> series?
>
> > +
> >       if (!offset)
> > -             return ubi_volume_begin_write(volume, buf, size, size);
> > +             ret =3D ubi_volume_begin_write(volume, buf, size, size);
> > +     else
> > +             ret =3D ubi_volume_offset_write(volume, buf, offset, size=
);
> >
> > -     return ubi_volume_offset_write(volume, buf, offset, size);
> > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > +     led_activity_off();
> > +#endif
> > +
> > +     return ret;
> >   }
> >
> >   int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t si=
ze)
> >
>
I rather prefer to have some registration of events that need to be execute=
d for
a particular i/o activity and then a subscription process from led
subsystem if that
particular event is connected to the dts or just on a board file

Michael


> bye,
> Heiko
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
