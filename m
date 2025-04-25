Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354DC369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D147825A6;
	Fri, 25 Apr 2025 16:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gxHkYkco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A618267E; Fri, 25 Apr 2025 16:36:25 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1D348212B
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aca99fc253bso349366866b.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745591783; x=1746196583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8DXD7pBd3EBTv5TOdmmJU57+NdIw2OhEDGaEPRujv08=;
 b=gxHkYkcogHGLxsA1zeOiAWJ70Dab8/HKcU2D2CZ/jrIrDhlCfxhyS54ObuN9Wgb33c
 8Bm/GA+RA44GEbE8BbB5+geZvkEFy10llT9G9b1Oqnj/4SA2go1RqOHteVVoVcdc3I4m
 4L9KJoMHia4xhCgSkENYUR1GYQ89BZzFtjHf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591783; x=1746196583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8DXD7pBd3EBTv5TOdmmJU57+NdIw2OhEDGaEPRujv08=;
 b=LskjxHGl59lIBMnp71IiMlzfbAX0apwoXLo9Ds1m8zBlMspf3Jv/fjFhdoWa03Gagu
 PurxJJsethPawemq8JqoneP75nZG+A964N1KYiilZGzLnxEDgMMBexVEl3jqbg4o/uui
 oOV3wO1T3PMsACpepqRdP4oMc+Q58It5JHDn3lqBq9P2PzTApaorv8N/o6JGEQH7hhyx
 FpxF2TAIQJ6wtECoEnqLTCPAE7rXHw+PrsKmEw1iktPrwI2fez3HoK7qvEd98p8e/vAX
 Nv6kJGzy3pxliY3pSRGQ+g2ypr9Ivmp4SqZ3hjxrpslqjDoqald7gVLa+/YFn8AQ/QOB
 JXoA==
X-Gm-Message-State: AOJu0Yw/R9b0bkS0/0Zd2Gi8a+VaHTkdFI7vO6mdd064HYTowtTaJyvA
 YpD6URL11J8KIOU38/TxpCuagWWXJzt5Jyb/7trHBMqNMMIIw/eSxSY1TexOKH/DLuR41YlRh3f
 w94AYtB+FFX4eN4N+sZrlQmtQxETggw7986kB
X-Gm-Gg: ASbGncte3a4fSYpu0NkWzhzw/SHDpDe9zNteSytGeSzaGJ0VW7k/tYMKz0IhAh4DXzR
 SM8kMIhAvi2xiTNSPYgOOiYEBK4Ot7WpzoNUtBvSZrEATXdzDPLvyfdiOw96d3eC2TYwuWeW6xs
 Cu5IxPm3RKM5r9X/BwOz0GOBI=
X-Google-Smtp-Source: AGHT+IGqwexryYrIs9jQTTADyeenVyUXsV6r7CvaDbTPFUiRPJgUJ/m3DrsEc/eJ6WLpdZdsE1NkuUOk2cz2Hu9n10U=
X-Received: by 2002:a17:906:2a4b:b0:ace:827d:4efe with SMTP id
 a640c23a62f3a-ace827d4fc6mr8844866b.32.1745591783180; Fri, 25 Apr 2025
 07:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250423144913.3918472-1-trini@konsulko.com>
 <CAFLszTh9vzZS1m3xbQt7Ws06myLU2WUjA6U_3yRvfKQsj9ejrg@mail.gmail.com>
 <20250424184929.GN5495@bill-the-cat>
In-Reply-To: <20250424184929.GN5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Apr 2025 08:36:11 -0600
X-Gm-Features: ATxdqUG0-I0Mz0xvjdHOjnTaFY6a275wZqE-A-AyL0NLYIbFy6aigK3w40Mzeu8
Message-ID: <CAFLszThW8Z6GCug-Y7TPzBYMLUMTsn4TN7N=fvqyNPmadL3SXQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Rework BLK dependency
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 24, 2025 at 12:30:50PM -0600, Simon Glass wrote:
> > On Wed, 23 Apr 2025 at 08:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > The bootstd code itself does not have any dependency on BLK in order to
> > > build. However, in order to minimize size growth of non-migrated
> > > platforms, change this from being "default y" to "default y if BLK".
> > > This will make it easier to begin migration of platforms which do not
> > > have any BLK-class device but do want to use bootstd.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >  boot/Kconfig | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Thank you for letting this happen.
>
> It's what I was asking you to do, FWIW. As I was unsure what part of my
> message was unclear, I just went and did it.

OK good. It certainly wasn't clear to me.

Regards,
Simon
