Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8E2C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 02:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7FD889A6;
	Thu, 25 Jul 2024 04:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lHLZEBmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CA788961; Thu, 25 Jul 2024 04:07:51 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6750889DF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 04:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so3883486d6.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 19:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721873267; x=1722478067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KCwG8plBEbF6XIgrcd7VT3WUNTMi2oILc76YnC67y5c=;
 b=lHLZEBmXAufWwgYHkzVs6ecWcYyHK9jvvF7l5aRZXgTQmekQsHgaVCbu/vN/wxjo6p
 UgirV+ymDpoKeD5WTjrymGkEyUkdJm9vPWfR7tWvDpsqWdIKG+0Px22GdARdJIgYtpiZ
 xZomBJEzUhBofRZ897SGKQ2TSEa8b9ngKrjdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721873267; x=1722478067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCwG8plBEbF6XIgrcd7VT3WUNTMi2oILc76YnC67y5c=;
 b=O+l2vJ2g0qjIE/V89XPvtc5ihkJT1xAEjS/y274eRufQJbDp3ydEzGg3BEN0x7z4AX
 iXSyRed7cIwlXRe72V9R1u3pA0VIKXcQsZC+K+6oDUJ+bd7BMQAqYZQZI86VhKkzub+8
 FlAGA9s7pAi7nazQamrf2nI4krQPcDy27qbkg1Jl5mlkI6SUa0KSctQL4ECNba3yrksc
 yeLECueodgFkFgXxF0OLY20yWKEjWm0nNDVBAx+VggCnzM99kY1hDBOU3GHzeG33748M
 WIBy2dLtO3PZcMt8VaJs6PCoBP96WjUq914LFhv0e28YXUxq38yxfMiznPVsHeEOnx4z
 NAKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH6BKUmsntXpHoZs7hPqTlacUws/7RKz3/Gb/nZkw7YJuMxpCTBBL8FS8VwE69RhuJbnP2mB09R0oE10ggWT+YAuAxow==
X-Gm-Message-State: AOJu0Yy6/n1083LttUCrlMGbbRx8TOijnddLN6HT15/T2fM8Prb2smLG
 a2SYJFiPEtulI6a9YzfLYrVRz5t8PNMJfdN7dIMk0KlyDMKOPbq+LdIdn8/i5m8BuH9GoLlKkhY
 KPgopBKujsf0dwvTIRxZ0Q2SwDgcKTlF3i3x1
X-Google-Smtp-Source: AGHT+IFByKjr8c54pAiynuE/IwslYkx+GvzIHRrKX2RncPkivqG6oFUyn0mnFQnFDH3nISixeEjQhEMTpcx/unD/yr8=
X-Received: by 2002:ad4:5b83:0:b0:6b2:9e53:fe50 with SMTP id
 6a1803df08f44-6bb3c961411mr25560816d6.22.1721873267572; Wed, 24 Jul 2024
 19:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CAFLszTiY7hDq4x56UDDCEOOHCGKUSfv0HqwA4-y0nFAFpywvFw@mail.gmail.com>
 <20240724223554.GO989285@bill-the-cat>
In-Reply-To: <20240724223554.GO989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 20:07:36 -0600
Message-ID: <CAFLszTi-nzHrbA0-xhfpfCJgBRKaT8wDaQCk-Zaz4+ZbQ+eL+Q@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 24 Jul 2024 at 16:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 24, 2024 at 04:17:32PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 24 Jul 2024 at 14:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > >
> > > > From: Simon Glass <sjg@chromium.org>
> > > >
> > > > Use this new data structure in the utility function.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > >
> > > This is rather big growth when we didn't already have realloc:
> > > 05: lib: Convert str_to_list() to use alist
> > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > >                  function                                   old     new   delta
> > >                  realloc                                      -    1120   +1120
> > >                  alist_ensure_ptr                             -     140    +140
> > >                  alist_expand_to                              -     136    +136
> > >                  alist_init                                   -     108    +108
> > >                  alist_uninit_move_ptr                        -      76     +76
> > >                  alist_add_ptr                                -      72     +72
> > >                  alist_uninit                                 -      48     +48
> > >                  str_to_list                                204     232     +28
> >
> > We can just drop this patch, perhaps? It was really just a demo of alist.
>
> Yes, and no. The next good example would be on
> cortina_presidio-asic-pnand where the reason this series is a size
> growth rather than reduction (where it is BTW on LTO using platforms) is
> again, realloc. Is this just an unfortunate given then?

Hmmm maybe. We can of course malloc() and then free() rather than
calling realloc(), although that is likely not as efficient. We could
have a 'cut down' alist implementation which requires that the initial
size be declared, but that defeats the point, really.

Anyway we certainly don't need to apply this patch to strto...there is
no particular benefit. I'll leave it up to you.

Regards,
Simon
