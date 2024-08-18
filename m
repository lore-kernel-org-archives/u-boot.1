Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012FAC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 19:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106C288100;
	Sun, 18 Aug 2024 21:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cXOagFTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9447D87ED0; Sun, 18 Aug 2024 21:32:48 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45DA88100
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 21:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso423889166b.0
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724009565; x=1724614365;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phEf1gm9B5Q0T/B0qQyqqd+OvQIkn43+9qelkJzhTQg=;
 b=cXOagFTCn5S0Glss01tkFTysNQV8UZDyN3bxYXvtl3HMCsiw0Zs9Ep1M0wf+65aTCx
 h87Vgm7oqd6k2JwPNKaqz2Mc/R80VfeZu82RObtMpZsnOT4wEexQW8WscUR/jdB0NCKX
 g979gR98qE44EGvnc0qAZAyVm3WG/Y2ncfSbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724009565; x=1724614365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phEf1gm9B5Q0T/B0qQyqqd+OvQIkn43+9qelkJzhTQg=;
 b=UvvRH1wK/kZzpSiNV6dig2t+5tjFLvyaoZ5RVPrLZQx4Vw0cIgS3MReWku0Wc2iz5b
 rFW7sRwAwhCGrjf1M02YCECxcnLDL/E1EdR+PbvKbKPrkIPAieA/s3RK17uiwwyKl+7Z
 LLoXNeF37DlrR7bs7iL2IVNLLuby6A/s3hAJOX3R/8IgKRvJKg3/T1C64zToKwG8R6Jo
 E5qUlzLSjEh9zJa9sdCF51rhS21+w2DrekOy1L/aX1LyPbXS0BS13cVKHIbIshAgLtXO
 CFHQqm2f0A6k0SXTpR8smhuF9isTq72ErvtM2AEd35db70QZ7mp+bxL2Llk6fkwN7zwv
 Z7JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCafccYs8/L/kC8dkFQmig3zupjK0Y1HQtg6tzW/gW4dSdCX1BorTYfE5jPEym/wUS51hrbKOt18ZNS1CP6iY2krGA+A==
X-Gm-Message-State: AOJu0Yx4Zfty624ciNy6QCqGonl8SibQsbp193O1apTh3nudlygo4V+G
 QDFzsk+12H5RzK2IE8ocQmCNfLfhZoTWEn6woyOq+QExWr5YVkAHYpF8s+EWhy1B4djY9OSWEhL
 DCS7E8wfBIAILIz+lLWwMFGQvk/p+Or98gkq6BQ==
X-Google-Smtp-Source: AGHT+IH3biBHwDjvdWlsfwHOsew0RQ6f3+XR0n2vtEo6ooUavTWhbhbe/Npw5iEW6Uh40HtpVq950h04lW8zzTE1OMM=
X-Received: by 2002:a17:907:e60f:b0:a7d:3c46:f4ae with SMTP id
 a640c23a62f3a-a83929d37acmr610802866b.55.1724009564413; Sun, 18 Aug 2024
 12:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-9-ansuelsmth@gmail.com>
 <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
 <CAOf5uw=x866W0Uw0ZmDrD4eAputNBb3n3b=-TED2ga4H+MfYPw@mail.gmail.com>
 <66c2202c.050a0220.241426.5b85@mx.google.com>
In-Reply-To: <66c2202c.050a0220.241426.5b85@mx.google.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 18 Aug 2024 21:32:32 +0200
Message-ID: <CAOf5uwn6EAQREOkj4LtgN60La7jH5kSB3oNj=OSuJj5iPgRASQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ubi: implement support for LED activity
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: hs@denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
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

Hi

On Sun, Aug 18, 2024 at 6:24=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Wed, Aug 14, 2024 at 10:17:18AM +0200, Michael Nazzareno Trimarchi wro=
te:
> > Hi all
> >
> > On Wed, Aug 14, 2024 at 6:34=E2=80=AFAM Heiko Schocher <hs@denx.de> wro=
te:
> > >
> > > Hello Christian,
> > >
> > > On 12.08.24 12:32, Christian Marangi wrote:
> > > > Implement support for LED activity. If the feature is enabled,
> > > > make the defined ACTIVITY LED to signal ubi write operation.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >   cmd/ubi.c | 17 +++++++++++++++--
> > > >   1 file changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > > > index 0e62e449327..6f679eae9c3 100644
> > > > --- a/cmd/ubi.c
> > > > +++ b/cmd/ubi.c
> > > > @@ -14,6 +14,7 @@
> > > >   #include <command.h>
> > > >   #include <env.h>
> > > >   #include <exports.h>
> > > > +#include <led.h>
> > > >   #include <malloc.h>
> > > >   #include <memalign.h>
> > > >   #include <mtd.h>
> > > > @@ -488,10 +489,22 @@ exit:
> > > >
> > > >   int ubi_volume_write(char *volume, void *buf, loff_t offset, size=
_t size)
> > > >   {
> > > > +     int ret;
> > > > +
> > > > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > > > +     led_activity_blink();
> > > > +#endif
> > >
> > > Do we really need ifdef? May it is possible to declare an empty funct=
ion
> > > when CONFIG_LED_ACTIVITY_ENABLE is not set? May this applies for the =
whole
> > > series?
> > >
> > > > +
> > > >       if (!offset)
> > > > -             return ubi_volume_begin_write(volume, buf, size, size=
);
> > > > +             ret =3D ubi_volume_begin_write(volume, buf, size, siz=
e);
> > > > +     else
> > > > +             ret =3D ubi_volume_offset_write(volume, buf, offset, =
size);
> > > >
> > > > -     return ubi_volume_offset_write(volume, buf, offset, size);
> > > > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > > > +     led_activity_off();
> > > > +#endif
> > > > +
> > > > +     return ret;
> > > >   }
> > > >
> > > >   int ubi_volume_read(char *volume, char *buf, loff_t offset, size_=
t size)
> > > >
> > >
> > I rather prefer to have some registration of events that need to be exe=
cuted for
> > a particular i/o activity and then a subscription process from led
> > subsystem if that
> > particular event is connected to the dts or just on a board file
> >
>
> My concern is that it might become too complex just for the sake of
> putting a LED intro a state. Do we have other case where such event
> subsystem might be useful?

I was thinking of reusing the cyclic subsystem that allows you to
subscribe to functions
that are executed periodically. I mean it's not exciting to have
function call everywhere,
and anyway I think that

#if defined(CONFIG_FOO)
foo_activity
#else
foo_activity() { };
#endif

This is my preference to not have it ENABLED everywhere. As I
mentioned I even not
have experience about having such needs in in code. Most can be implemented
in a script except blinking like:

led on; ext4load <> ; led off. We can definitely script most of it.
The only exception can be
led blink; ext4load <>; led off.

>
> Uboot is not really multi thread so we don't expect that much thing to
> happen at the same time. Do we have case where an i/o might happen in
> multiple place? Example transfering data and writing them at the same
> time? The common practice is to first transfer and then handle.
>

Michael

> >
> >
> > > bye,
> > > Heiko
> > > --
> > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
>
> --
>         Ansuel



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
