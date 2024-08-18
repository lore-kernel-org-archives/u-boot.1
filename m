Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1440C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 16:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026428895A;
	Sun, 18 Aug 2024 18:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WZ5UWqhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D478E87042; Sun, 18 Aug 2024 18:24:15 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EA48826E
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 18:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428119da952so27662775e9.0
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723998253; x=1724603053; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=avlX9O+++1P/Bn+JNdQskHLfuvBgrkTG1l74BM6ATAI=;
 b=WZ5UWqhdZogVzVY+AhbzwPcSYSv1JMzSeEhm2vwsSR1axaZqUQPpezFQ7FHuGRwQe4
 +mla++MAJwaEdj1sPIUbOgHthb1sqFnihOmzyQz0/esNiGsn/BbwlHyN6HadNknvPu03
 GZcHJjK9YRvBbnS3znHsh5kJNlk5T4sWUBQtcjYWmTbTXtkIhhBM7ANdQ8BVayZRr23t
 B6OWxr244nemTkU/LAOX9LX8kAPN3ZHqyCn/Fp08kFmr+AZtbKcnu+xyDBwzK8/szrbe
 Npoiz8ftX5ngfstVxJPZJ7M1eHoUOO6CEei5Rr1EIvenqXZK425PRWZQlDPn/d0vR9BH
 cxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723998253; x=1724603053;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avlX9O+++1P/Bn+JNdQskHLfuvBgrkTG1l74BM6ATAI=;
 b=bF7YMAnFLJigtTeVKmbXpkXVdEzYx8hRliQZV+HTHDYNtr/eQhaeu41wNaqSK18JAN
 RChiJhvnx2huraWuy5kyrsexOGhy3zasGM0otWyR8kYK5Fko8Z7OSf02SoYYqQdE11Rh
 46ZAtzS+VWvFHx1ZOZmFsmaqVUsxxHiG4H+NJ8RoJx26jyryYLfhMAzuaIXtwTgKij2p
 b0gLaGLIL/zQyk1FY17PDLmzJqnYet0Ae4t2SBpOOsmPDoUkoHDT65VkEPH0wPwxvwFx
 kPMu/Bk6Pu1kXPicUzk4yEqvtF/YBsmvIpnE8xj1nm54BZUP+5I+7EWbrnfm6ivrpVM4
 UuOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6zoWETpLrF3dX2OEKV+QLmv8x7HtvUONcwgXmbXpNu0usQvK7o8Bjx3rR4X6miSV/hTesI4JQETX1TUxbRsw/2pahbQ==
X-Gm-Message-State: AOJu0YxMj1cDdx/ntfeCo1UHnbgEEjPeFIeSK+kHmaH50hr9MARVf8ZJ
 H+3eC/4EvOcHP40lpSlM5Z+bLmt+cnxbKsw9/lspVp45KGVQlFYE
X-Google-Smtp-Source: AGHT+IGghnLvizfg77Gk3Do18WR3qXs2fV5XohasYylexxhsXq11lwHuItR7skNLNlwyRaq1XLOqvQ==
X-Received: by 2002:a05:600c:4f4f:b0:426:64a2:5375 with SMTP id
 5b1f17b1804b1-429ed77da5fmr63618505e9.1.1723998252991; 
 Sun, 18 Aug 2024 09:24:12 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-47-255-50.retail.telecomitalia.it.
 [79.47.255.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded18468sm132363935e9.2.2024.08.18.09.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 09:24:12 -0700 (PDT)
Message-ID: <66c2202c.050a0220.241426.5b85@mx.google.com>
X-Google-Original-Message-ID: <ZsIa7DjG68jMf8Ju@Ansuel-XPS.>
Date: Sun, 18 Aug 2024 18:01:48 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uw=x866W0Uw0ZmDrD4eAputNBb3n3b=-TED2ga4H+MfYPw@mail.gmail.com>
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

On Wed, Aug 14, 2024 at 10:17:18AM +0200, Michael Nazzareno Trimarchi wrote:
> Hi all
> 
> On Wed, Aug 14, 2024 at 6:34 AM Heiko Schocher <hs@denx.de> wrote:
> >
> > Hello Christian,
> >
> > On 12.08.24 12:32, Christian Marangi wrote:
> > > Implement support for LED activity. If the feature is enabled,
> > > make the defined ACTIVITY LED to signal ubi write operation.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >   cmd/ubi.c | 17 +++++++++++++++--
> > >   1 file changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > > index 0e62e449327..6f679eae9c3 100644
> > > --- a/cmd/ubi.c
> > > +++ b/cmd/ubi.c
> > > @@ -14,6 +14,7 @@
> > >   #include <command.h>
> > >   #include <env.h>
> > >   #include <exports.h>
> > > +#include <led.h>
> > >   #include <malloc.h>
> > >   #include <memalign.h>
> > >   #include <mtd.h>
> > > @@ -488,10 +489,22 @@ exit:
> > >
> > >   int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
> > >   {
> > > +     int ret;
> > > +
> > > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > > +     led_activity_blink();
> > > +#endif
> >
> > Do we really need ifdef? May it is possible to declare an empty function
> > when CONFIG_LED_ACTIVITY_ENABLE is not set? May this applies for the whole
> > series?
> >
> > > +
> > >       if (!offset)
> > > -             return ubi_volume_begin_write(volume, buf, size, size);
> > > +             ret = ubi_volume_begin_write(volume, buf, size, size);
> > > +     else
> > > +             ret = ubi_volume_offset_write(volume, buf, offset, size);
> > >
> > > -     return ubi_volume_offset_write(volume, buf, offset, size);
> > > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > > +     led_activity_off();
> > > +#endif
> > > +
> > > +     return ret;
> > >   }
> > >
> > >   int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
> > >
> >
> I rather prefer to have some registration of events that need to be executed for
> a particular i/o activity and then a subscription process from led
> subsystem if that
> particular event is connected to the dts or just on a board file
>

My concern is that it might become too complex just for the sake of
putting a LED intro a state. Do we have other case where such event
subsystem might be useful?

Uboot is not really multi thread so we don't expect that much thing to
happen at the same time. Do we have case where an i/o might happen in
multiple place? Example transfering data and writing them at the same
time? The common practice is to first transfer and then handle.

> 
> 
> > bye,
> > Heiko
> > --
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
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
