Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0879CC5320E
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 11:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3956F88C47;
	Thu, 22 Aug 2024 13:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxgB2BOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7CE88EE2; Thu, 22 Aug 2024 13:19:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A029388C47
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 13:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42ab97465c8so4624275e9.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724325559; x=1724930359; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/WkgSlk77ZLIhKVjGFhhghU7ZuEVGKOTzAk0gJUKHbU=;
 b=KxgB2BOvsGcq/11wdXk32ByjSttkedQhEOgaXikdxhHi9RdY6erCzhSqRdS1dwgd0G
 SR8j3ApFOf6BRBXvhID+yaUUBLHF+p708ccuawU+wTuM0jm4RseInR57bu1l0+qmwrAs
 u0JCszL3JtA3zR9GJv8IJ74xj/SHUpirNjwXx6PKd28C1WZ+RbvH2B9KEEqWzJ6W0KP0
 u5scjy4b9n/2GPKFGSL7nV4Gh3du6Bd89ryOs7on6rYve8c/uPQniKOhbduJWW1kaC4j
 bsqAp4sl4Fvp0gvjDNynTHV+2qBKuM05R5oDqGe4ebTNDgixqG2QoSPSSUjMmjvrWp5W
 T4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724325559; x=1724930359;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/WkgSlk77ZLIhKVjGFhhghU7ZuEVGKOTzAk0gJUKHbU=;
 b=iqULxSz/ewBv1nPna5M+T2bVxjIir2fn3cx6LOZWZGGz142MFN5akhc8y3P8zo64NV
 vYwryalZGRP4hRfC/LoE1VXEcvSWo8Gig4nEavEjlXkWBWOnFJp/9kdFmvaRfDcf633I
 wvVDRr63rYTmW0RZDBfvJEgdEIiu7Hc38DJVTH8/G/17jRBjWkWC+MHihxHp9G+J7/1Y
 ccUIaSvdfjuJK+k7gYzciK79BvjM5qhZda6HMZqv5dcmBYtk/L5rvQGe7Ftg4rLkxMkk
 Y5bk+nPNHSZqBvoY4DBxScOdI55y8i6I8CZd+b1zx/N5RiEByPdhazWSE8UeVN8vMzDe
 jh0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnLnXh5PIxdNffqbkHwlxj3lcQwuAEsRL/AtaPbpSTe+2lKlfl/hkpLHuOSpuYzJLXnMVWSfs=@lists.denx.de
X-Gm-Message-State: AOJu0YxcY8XAHm7zjP9Lg+cSASkWtalpwEnQiy44sbEbRGXz5iTbnp88
 0oUn8xpGUH62l34GEUR8jlDpNDUjqvw+nOUTs4rKb8h+4gnfs1xQ
X-Google-Smtp-Source: AGHT+IHvsbsJHIY9ur7e/QSL/Epqyynlx3AFOt0oQsHPJxEy6HSwIhsPQjs8TzTUDDlcVchWKMQvgA==
X-Received: by 2002:a05:600c:1d1d:b0:426:593c:935f with SMTP id
 5b1f17b1804b1-42abf03d0e3mr32905445e9.1.1724325558473; 
 Thu, 22 Aug 2024 04:19:18 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-209-141.retail.telecomitalia.it.
 [87.1.209.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308110420sm1456821f8f.6.2024.08.22.04.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 04:19:18 -0700 (PDT)
Message-ID: <66c71eb6.df0a0220.1e0004.2caa@mx.google.com>
X-Google-Original-Message-ID: <ZscW32aDFHtXCB_l@Ansuel-XPS.>
Date: Thu, 22 Aug 2024 12:45:51 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: hs@denx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 8/9] ubi: implement support for LED activity
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-9-ansuelsmth@gmail.com>
 <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
 <CAOf5uw=x866W0Uw0ZmDrD4eAputNBb3n3b=-TED2ga4H+MfYPw@mail.gmail.com>
 <66c2202c.050a0220.241426.5b85@mx.google.com>
 <CAOf5uwn6EAQREOkj4LtgN60La7jH5kSB3oNj=OSuJj5iPgRASQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwn6EAQREOkj4LtgN60La7jH5kSB3oNj=OSuJj5iPgRASQ@mail.gmail.com>
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

On Sun, Aug 18, 2024 at 09:32:32PM +0200, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Sun, Aug 18, 2024 at 6:24 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Wed, Aug 14, 2024 at 10:17:18AM +0200, Michael Nazzareno Trimarchi wrote:
> > > Hi all
> > >
> > > On Wed, Aug 14, 2024 at 6:34 AM Heiko Schocher <hs@denx.de> wrote:
> > > >
> > > > Hello Christian,
> > > >
> > > > On 12.08.24 12:32, Christian Marangi wrote:
> > > > > Implement support for LED activity. If the feature is enabled,
> > > > > make the defined ACTIVITY LED to signal ubi write operation.
> > > > >
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > >   cmd/ubi.c | 17 +++++++++++++++--
> > > > >   1 file changed, 15 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > > > > index 0e62e449327..6f679eae9c3 100644
> > > > > --- a/cmd/ubi.c
> > > > > +++ b/cmd/ubi.c
> > > > > @@ -14,6 +14,7 @@
> > > > >   #include <command.h>
> > > > >   #include <env.h>
> > > > >   #include <exports.h>
> > > > > +#include <led.h>
> > > > >   #include <malloc.h>
> > > > >   #include <memalign.h>
> > > > >   #include <mtd.h>
> > > > > @@ -488,10 +489,22 @@ exit:
> > > > >
> > > > >   int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
> > > > >   {
> > > > > +     int ret;
> > > > > +
> > > > > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > > > > +     led_activity_blink();
> > > > > +#endif
> > > >
> > > > Do we really need ifdef? May it is possible to declare an empty function
> > > > when CONFIG_LED_ACTIVITY_ENABLE is not set? May this applies for the whole
> > > > series?
> > > >
> > > > > +
> > > > >       if (!offset)
> > > > > -             return ubi_volume_begin_write(volume, buf, size, size);
> > > > > +             ret = ubi_volume_begin_write(volume, buf, size, size);
> > > > > +     else
> > > > > +             ret = ubi_volume_offset_write(volume, buf, offset, size);
> > > > >
> > > > > -     return ubi_volume_offset_write(volume, buf, offset, size);
> > > > > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > > > > +     led_activity_off();
> > > > > +#endif
> > > > > +
> > > > > +     return ret;
> > > > >   }
> > > > >
> > > > >   int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
> > > > >
> > > >
> > > I rather prefer to have some registration of events that need to be executed for
> > > a particular i/o activity and then a subscription process from led
> > > subsystem if that
> > > particular event is connected to the dts or just on a board file
> > >
> >
> > My concern is that it might become too complex just for the sake of
> > putting a LED intro a state. Do we have other case where such event
> > subsystem might be useful?
> 
> I was thinking of reusing the cyclic subsystem that allows you to
> subscribe to functions
> that are executed periodically. I mean it's not exciting to have
> function call everywhere,
> and anyway I think that
> 
> #if defined(CONFIG_FOO)
> foo_activity
> #else
> foo_activity() { };
> #endif

Yes that was suggested and I will change code to use this

> 
> This is my preference to not have it ENABLED everywhere. As I
> mentioned I even not
> have experience about having such needs in in code. Most can be implemented
> in a script except blinking like:
> 
> led on; ext4load <> ; led off. We can definitely script most of it.
> The only exception can be
> led blink; ext4load <>; led off.
>

It's really a choice but currently for the boot led people have to use
board code to turn on the LED or use the preboot env to run command...
Not very clean. Is it really that bad to have these simple call in these
functions?

> >
> > Uboot is not really multi thread so we don't expect that much thing to
> > happen at the same time. Do we have case where an i/o might happen in
> > multiple place? Example transfering data and writing them at the same
> > time? The common practice is to first transfer and then handle.
> >
> 
> Michael
> 
> > >
> > >
> > > > bye,
> > > > Heiko
> > > > --
> > > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > > > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> > >
> > >
> > >
> > > --
> > > Michael Nazzareno Trimarchi
> > > Co-Founder & Chief Executive Officer
> > > M. +39 347 913 2170
> > > michael@amarulasolutions.com
> > > __________________________________
> > >
> > > Amarula Solutions BV
> > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > T. +31 (0)85 111 9172
> > > info@amarulasolutions.com
> > > www.amarulasolutions.com
> >
> > --
> >         Ansuel
> 
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com

-- 
	Ansuel
