Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9A6C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59B682163;
	Tue,  6 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H6sZZsGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B96082A0D; Tue,  6 May 2025 15:24:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57FC82A36
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5fab81d6677so2533025a12.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746537875; x=1747142675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sv4g4gpwGgQL4p1iZEcIke/DSAXcDmpYnMm1hb2aADA=;
 b=H6sZZsGoEUlrAY5MfLSbSTY8NdNUqpm8xj3hCHfQjAX0g7lm0cVNMpMP4lVUkvC/AY
 u0K5bj0G27PKpr3n0V6nKzGTkAo16G46RmpGBEgAeZOtXXecoOhS+GJZi2TNMfEOYOWH
 hpdNiPPSRQap5EY4nvqrkeXOkleafZ240RXjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537875; x=1747142675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sv4g4gpwGgQL4p1iZEcIke/DSAXcDmpYnMm1hb2aADA=;
 b=i2Xi5SNFD8SEkpVQJv/Ina5Zbzl1i+GXK1AJdsx+/Z2QDK3Vu0gjfQMKKaoBc2DjIy
 f3Pauky/OcpLqsAmMNVGKQqUj6a8E8K2rmgqFHNB/0Z1xu28t7XBmlSS2jkQwmHaZ7Xx
 jqX/B35R9NMTgvRiD3eLYgcv8NM6swiXnPTQqClRh2M3c2uf1jm065C+OAupfP7ZV2Wy
 bylQyWXNJ1HfC2Jk2wP0mmvHgQvEYvsdpOuS7nZJpi8elVyxfH3VURmkbk4rzT5LJ9wr
 pLVpOeqjfWJcaeqyepU4W8p1SeH+eu79004JAY8iWbyyZOZ0KXrSya7vdWtJ8pIDWaau
 vsPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSo/SOEvcteL55+XbwzYW3NptPJDqEQSxS5nmNP9rekHhU8AU7KsVeuolriiW3tNQWR3EDeq0=@lists.denx.de
X-Gm-Message-State: AOJu0YzWGeC3KbVxPu7KKKW4PGXyhKx0SIiEy+PpX//7hE8iXQ61mAL/
 G17b2/AcfZYsS08JxVOOB2SJ24FHQwHGlnc/M3jgSXQ9jg3nNWdTR3z/av1gYxTb2Q/FldOps4q
 Ln80cOs+GFWlkSKUfttB/1oFuFiH8u3SuBUUF
X-Gm-Gg: ASbGnctEMAnCviLJwMainwTpNaQd1TJP0O5BuiT002kfe6l0DR27CTJGbfdZ00JCFJh
 68Fc1H+36bKiGXCLBDsBESh22ddum2lHTcpNON9MjBfB6FUEc3jZTuk/ujMzEfD6M6nweZU4RSC
 TT83SmbEwTljwAF3UvEzZrdA+ffnJFSmjGrw==
X-Google-Smtp-Source: AGHT+IHWnSD4nSXYr6bnSuvnc1ASBSUN6LpO3pGjElX/+kf9XbKKVi9aVxT2excAOpzJDFAS7gD6pewLu2gKr0jFUJs=
X-Received: by 2002:a05:6402:2801:b0:5fa:a42f:70ee with SMTP id
 4fb4d7f45d1cf-5fab04bbe66mr8754701a12.0.1746537875291; Tue, 06 May 2025
 06:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-16-sjg@chromium.org>
 <5403d72f-65b3-47f8-912e-d1b64e111f00@cherry.de>
 <CAFLszTh1Sm9ymBDRLqwncaSHyRVYiabsQvd-hUrzLwo2iOvUnQ@mail.gmail.com>
 <20250505164143.GG5430@bill-the-cat>
In-Reply-To: <20250505164143.GG5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 15:24:18 +0200
X-Gm-Features: ATxdqUGcgukAaFAjr-lvRuYur2JQjG6_a8MNDtV960pJHfwwm9LKh-wUQ2Hg1Qs
Message-ID: <CAFLszTiu41PxU6i5NstS3mZLD6C8AGaS8EUwe=9gLfO7T5waOg@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] bootstd: Provide a command to select the bootdev
 order
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 5 May 2025 at 18:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 05, 2025 at 05:37:33PM +0200, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 5 May 2025 at 10:34, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 5/1/25 3:37 PM, Simon Glass wrote:
> > > [...]
> > > > diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> > > > index 9bee73ead58..294865feb64 100644
> > > > --- a/boot/bootstd-uclass.c
> > > > +++ b/boot/bootstd-uclass.c
> > > > @@ -6,6 +6,8 @@
> > > >    * Written by Simon Glass <sjg@chromium.org>
> > > >    */
> > > >
> > > > +#define LOG_CATEGORY UCLASS_BOOTSTD
> > > > +
> > > >   #include <alist.h>
> > > >   #include <blk.h>
> > > >   #include <bootdev.h>
> > > > @@ -132,6 +134,22 @@ const char *const *const bootstd_get_bootdev_order(struct udevice *dev,
> > > >       return std->bootdev_order;
> > > >   }
> > > >
> > > > +void bootstd_set_bootdev_order(struct udevice *dev, const char **order_str)
> > > > +{
> > > > +     struct bootstd_priv *std = dev_get_priv(dev);
> > > > +     const char **name;
> > > > +
> > > > +     free(std->bootdev_order);  /* leak; convert to use alist */
> > > > +
> > >
> > > leak? and aren't you using alist already?
> >
> > Not for this, yet.
> >
> > >
> > > [...]
> > >
> > > > diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> > > > index 98a0f43c580..abede194cba 100644
> > > > --- a/doc/usage/cmd/bootdev.rst
> > > > +++ b/doc/usage/cmd/bootdev.rst
> > > > @@ -13,6 +13,7 @@ Synopsis
> > > >
> > > >       bootdev list [-p]        - list all available bootdevs (-p to probe)
> > > >       bootdev hunt [-l|<spec>] - use hunt drivers to find bootdevs
> > > > +    bootdev order [clear] | [<spec> ...]  - view or update bootdev order
> > > >       bootdev select <bm>      - select a bootdev by name
> > > >       bootdev info [-p]        - show information about a bootdev
> > > >
> > > > @@ -78,6 +79,27 @@ To run hunters, specify the name of the hunter to run, e.g. "mmc". If no
> > > >   name is provided, all hunters are run.
> > > >
> > > >
> > > > +bootdev order
> > > > +~~~~~~~~~~~~~
> > > > +
> > > > +This allows the bootdev order to be examined or set. With no argument the
> > > > +current ordering is shown, one item per line.
> > > > +
> > > > +The argument can either be 'clear' or a space-separated list of labels. Each
> > > > +label can be the name of a bootdev (e.g. "mmc1.bootdev"), a bootdev sequence
> > > > +number ("3") or a media uclass ("mmc") with an optional sequence number (mmc2).
> > > > +
> > > > +Use `bootdev order clear` to clear any ordering and use the default.
> > > > +
> > > > +By default, the ordering is defined by the `boot_targets` environment variable
> > > > +or, failing that, the bootstd node in the devicetree ("bootdev-order" property).
> > > > +If no ordering is provided, then a default one is used.
> > > > +
> > >
> > > Not sure what's the benefit if we can simply set the environment variable?
> >
> > The environment variable is there to maintain backwards compatibility
> > with the distro scripts. It now seems that we are unlikely to ever
> > drop those, but you never know.
>
> Repeating myself from some other discussion before, it's not just "distro
> scripts", managing things with the environment is an intentional
> feature, not a backwards compatible legacy thing. Solutions to "boot
> this device" that do not have some support for using the environment to
> modify things as needed are unlikely to be flexible enough for all use
> cases.

For bootstd I would rather define something designed for that purpose,
than use a boot_targets environment variable. If we are relying on an
environment variable to have a particular value, then erasing the
environment might stop the board from booting. The idea with bootstd
is that it should always be able to boot.

But in any case, we have this variable today. Removing it would
require some discussion and thought and is not likely in the
foreseeable future.

Regards,
Simon
