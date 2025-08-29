Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA9BCA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 15:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05EF83675;
	Fri, 29 Aug 2025 17:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bx8r3FKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6018D8367F; Fri, 29 Aug 2025 17:14:05 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4204283106
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 17:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso3767136a12.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756480443; x=1757085243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pmnPoGXPIWHgfHquuYfYF++qpBWWQSK9Mt1Kz7ijTig=;
 b=Bx8r3FKzD6CZ4QPg5usykwtVmGCSsTyLRS/z2iUy02m8qvz4j4vCS2Ww3tyx32DDhA
 LGm8o2bOBR+xvSldDZA43Z27YcDR49P5EZmBn2mNgh/ShlQRAaD+rfURlAqDp+3Sm/uf
 PsJDa8oUS22Eg7Oh0ea2Ohf2WEePtgskPKvTTnanPKdI9gD1k1RB8moVJIYfXrvwxA9m
 rPoKJwW75NK5EdcTtAgdRv5ZffylefN55ndu4eQ/f86WVS2mmmsyo3d7J12J/Mgm+UJw
 klwJAwCg5xP0CJLYvgd6sFf8zgXC/zgeDmAvuDl7SOH7j6m3FXx90k+4q34kGTnNdiPf
 gR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756480443; x=1757085243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmnPoGXPIWHgfHquuYfYF++qpBWWQSK9Mt1Kz7ijTig=;
 b=ab2VH3u9VnmR/qV+xgyAH9UJyhzfnT6zS0yHEccMINK24eXQhTdpY91lauDUsHgypt
 SPqAh/HJTlvuTXgEIXKmT3mey33uVgvHpEL+oN9U8axDgeP1JwttDlpJ1rRDmBVyKBgA
 Quvk3RGL2mcWBEAig013di88DhmvMaFZR5RFl81Y2qrhnrhU+Y/l0z8CFou1gTMsdkxr
 CEug3+FN0zCIC8RZixhPZWC5rmqqNi7yaN48Zh9SJYZ6cWWzRQO3zuSX7OwPdq1yaP2A
 jU/JKbkKF4appYMEOJjE/TGWYJcK4md5552l5fhCUYk1n69ynZBwLjzFj/ZtxVsrVHUt
 Gk4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVIC7jYJJD1wekRHGT5w5CmE+EF+MioFDuKfuQS8emfl7xtofVi5rQEIe1aC8LpSBxHlGnUa8=@lists.denx.de
X-Gm-Message-State: AOJu0YwrDAyw7Y+6gfiRV6fUcd/bDeks/DJaJsHidFsXiYxt40BmfqM8
 JC0aA06sQxK96sZ4j/Ig/nQwZi7EbiQ4blff/w/TjsCGiqaMjuZa/u2gf2isx9WlI/dowiSHAyx
 09vgIyfoCb5T2oiLgNDk4A24h7kKMNGY=
X-Gm-Gg: ASbGncurOzun5THRcOigCz0w+yo4N1QD8n6q/G5gpF7c+y7fjxUUIpZTrIJBYhaqX71
 SW3Mb/PZZiUMyzrPZ+rUIxKZs/hpInlAOcS+IBCjXtINGJWXWH10gK5PJg4l3H3RaqV43ZFnfao
 xKsYCj1wJQtV/CFUcmb4XHsWl588yEvo5Dc/Pfeq0NcbFCJYrfkPiFNvMXWvQIJiJOaRDCrqOxd
 oAv74xjppLy+fcq6BYFb5eyJkAKPIn3YZVkLqLKUAE60g==
X-Google-Smtp-Source: AGHT+IEYME9wl8VPG4xTG9w4FQGLgWinjYmz96uYKMRwHQSzGHXXDgTvHIfQHX/e9mm2PhCPzt5Fs0K+dOBgwsgPO7I=
X-Received: by 2002:a05:6402:3589:b0:61c:5f9d:4b3f with SMTP id
 4fb4d7f45d1cf-61c5f9d7e89mr15300681a12.29.1756480442590; Fri, 29 Aug 2025
 08:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250827075017.1583168-1-pbrobinson@gmail.com>
 <20250829153124.55f35ac6@minigeek.lan>
In-Reply-To: <20250829153124.55f35ac6@minigeek.lan>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 29 Aug 2025 16:13:51 +0100
X-Gm-Features: Ac12FXx0Gk6H89I2u143AJBnpU6cYOFH09NAKLTAeVdgN6Xu7xfR6tQckUpj2J8
Message-ID: <CALeDE9NQq+7yxEQ3v6KB=2OK58+MC-923nPr1tbxaw0vEcfMAA@mail.gmail.com>
Subject: Re: [PATCH] Allwinner: fix booting on a number of devices
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de
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

Hi Andre,

> > Revert "sunxi: enable MMU_PGPROT proper page table protection"
> >
> > This reverts commit 16cfccda4dbf0b53473b8212897f5c63bfbeb6e1.
> >
> > This causes the follow issue on the A64 boards I have including
> > Pine64+, Pine64-LTS and the Pinephone. Revert until the issue
> > can be properly investigated.
> >
> > CPU:   Allwinner A64 (SUN50I)
> > Model: Pine64+
> > DRAM:  2 GiB
> > Insufficient RAM for page table: 0x5000 > 0x4000. Please increase the size in get_page_table_size()
>
> Mmh, how did you get this? I just ran mainline on a Pine64-LTS, and
> didn't see any issues. Are you running on some specific setup? I am on
> GCC 11.2.0, TF-A is some v2.12.0-724-gf745e004a, and that's with
> pine64-lts_defconfig.

Fedora 42/43, gcc 15.2, binutils 2.44, TF-A 2.13.

I've seen it across Pine64+, Pine64-LTS and Pinephone.

No special setup and I reproduced in on the vanilla upstream checkout
from a couple of days ago when I had the time to do the bisect.

> > resetting ...
> > System reset not supported on this platform
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  arch/arm/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 40368abc297..b8be270e4d7 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1207,7 +1207,6 @@ config ARCH_SUNXI
> >       select DM_SPI_FLASH if SPI && MTD
> >       select DM_KEYBOARD
> >       select DM_SERIAL
> > -     select MMU_PGPROT if ARM64
>
> Regardless that's quite a sledgehammer. If that's a real issue, we
> could surely provide our own get_page_table_size() implementation which
> is more generous?

You commit that reverts says "This might trigger runtime exceptions in
misbehaving drivers, which should then be fixed." which shows that it
might cause a problem, and I agree that any drivers should be fixed,
but the above output tells me absolutely nothing about even where to
begin to look so to use your sledgehammer analogy, if I knew whether I
needed a ball-peen hammer or a claw hammer I could but I am basically
blind and with my testing the sledge hammer solves the problem.

Peter
