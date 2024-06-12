Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A70C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55C088884;
	Wed, 12 Jun 2024 22:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CgQjPfgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39E38867D; Wed, 12 Jun 2024 22:24:43 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1A288702
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c19e6dc3dcso185082a91.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223878; x=1718828678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bjUTGBXc4lu3ilQmP9Fq1U+WHv4ewkAJlOEAn5WRse4=;
 b=CgQjPfgJ/Pn4vU6o/kg3Ocr9GXhU7+RxOK5ASLngRrheOqVkGFPeqQkqGKeQiPetR2
 a/dZ1AleNUw1MtskVBA997x5k0Eay0zWSeIdFE7QP1oc54eOGGrsDm+xRylyenYlk9Np
 9q0GLy3Wv/7ScN7ZPPaVQ5lGEEjbVDoU3w12o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223878; x=1718828678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjUTGBXc4lu3ilQmP9Fq1U+WHv4ewkAJlOEAn5WRse4=;
 b=o5crMyXw6Xezvp0x73xtgjiw+kCaqNt4wFFj1yjlX2FA+NZD8JXPdcfiU7mrMXtut5
 yWezBzaUSKNIdgtBi4rCIwaiYhK49ncMws4Msh0dkBmAAQT9VifLlkdA7pfwrpTKEgdc
 294eyXYNIWgXYDEarwhwMW5t/E4dvLqT9Xcp74fIQohlfR7izXo/4DaffVleByiF6HHP
 un48ur/zmfPOhbi6c10cLYpM9Kyyf48q66+kwoL6cf6l9Lhl207R2Onb80pKzRO0tcL1
 rjHFS3q0tUCp/o+95rMViDmetKrPcxv+PyNOI5E6KARaG6nQx1olrb79hYYFbEB5S3mo
 AtBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE3hTI9vC5XqUG1Ku7LFlPhiZay5zzEnfWI0IAEjCDMDDlDKusbOJhfauM777Dp6/8HkB5xWKVPhR1aXe0s+dLiDiwWA==
X-Gm-Message-State: AOJu0YygpF5y006y0WMi3PBQZ0gENVhweo27TSsv1LlFU9cS2aYR4Zcs
 96hPi4uP7qw8U7UdJ8mn440NyRokDURb7yJfR9ozBKS5fpxHICRYSKJ7aYky5X9p/gpmj3iJw9M
 I3YlXWTrNinvBx+XLC2mTxF06tp60qEhsO+WG
X-Google-Smtp-Source: AGHT+IExqQpRpziOOeZPXYmhL2H0Kg6nxLtwSxSGp/Jqsksux8XgmpShQ6rGDzrHpSBW/U2vBgk9vWK4uIc6OCiM+9k=
X-Received: by 2002:a17:90a:d56:b0:2c3:16fa:ccdd with SMTP id
 98e67ed59e1d1-2c4a761b844mr2924322a91.7.1718223877682; Wed, 12 Jun 2024
 13:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
In-Reply-To: <20240612172244.GG68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:25 -0600
Message-ID: <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
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

On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
>
> [snip]
> > Also IMO there is only really one LMB list today. We create it at the
> > start of bootm and then it is done when we boot. The file-loading
> > stuff is what makes all this confusing...and with bootstd that is
> > under control as well.
> >
> > At lot of this effort seems to be about dealing with random scripts
> > which load things. We want to make sure we complain if something
> > overlaps. But we should be making the bootstd case work nicely and
> > doing things within that framework. Also EFI sort-of has its own
> > thing, which it is very-much in control of.
> >
> > Overall I think this is a bit more subtle that just combining allocators.
>
> I think this gets to the main misunderstanding. The problem isn't
> handling bootstd, or EFI boot, or even assorted scripts. Those are all
> cases where things are otherwise (sufficiently) well-defined. The
> problem is "security" and that a "carefully crafted payload" could do
> something malicious. That's why we have to do all of this stuff sooner
> rather than later in our boot process.

That's the first I have heard of this, actually, but a bit more detail
would help. How does the payload get loaded? I'm just not sure about
the overall goals. It seems that everyone else is already familiar -
can someone please take the time to point me to the details?

Regards,
Simon
