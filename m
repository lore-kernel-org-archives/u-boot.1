Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8ECD6A223
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AEDA8935E;
	Fri, 15 Nov 2024 15:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQnVZ35j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6F5896AA; Fri, 15 Nov 2024 15:21:06 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7E489354
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso243292266b.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680463; x=1732285263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MPLYdTJ8hfjJcu1LXE4C0tuWhtcILUkmdpiCIUFhFSE=;
 b=dQnVZ35jWnNUS8kVNe+rfnFbdDg0ENewDCNNX7mHvkujzZRvS0rczgIpG+efeRvcsJ
 BU/tM6buLK/NB2EkznNqQukVEszVLaF/iUnjb4S0jACwhEOkfeHo+g/DfETbf3pSmQJT
 2kq9JylRSj3m/wz9yZONFkm5EoAxsEae8sy2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680463; x=1732285263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPLYdTJ8hfjJcu1LXE4C0tuWhtcILUkmdpiCIUFhFSE=;
 b=O8l90ggKOFYXRTq3xHn2mqnwTeIXJynBE6Q6HxmtS4Asi9CLf2WnLkPs/Dz2PvYlwQ
 elB+GWWaIkCgbdJZX/rxbvfKlRCPcaBWBDWkSYNPwp9jo3/TlELsFinmyzr0KPU56bbH
 lY8FWw6O5k788qm72edeAz8Ak7FtGg3yjnYG6W8U862kTSfojQZUIoAn7wh2/9qFX7n+
 oixk3wfXmXijxBm9PGOTP2tg6Szt+rICRIbdJDvxrfmmvar/OQbjcorraHBPjPXUTvx4
 em73hciyMUA88QuPYBj3SjG5iw+ei23aEr6hQhP3RP18gC/7suhgIGqLYJ+WTVoOSVOj
 IROg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt+6YoXhcKhVftBjxsmNzFzsh7v52nOhOilppqU51Ix8aYrBlgx4BdW2qvKdqFpWQjwUdPL3M=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw+CDzcemnJJLYEUFdUaA1aEmWMWNvXao8JimdK9AmOfQF6ZHM
 7Eh0EaLFN5flUt2vtVkpPLtOvi+twI3B/DTTNsARn69nin+20d76fqaLIMLXv4XdK3A+SiDOtfD
 aMPlile9EPVqcJ8bxyTz7sAmReLIBMddbCAsk
X-Google-Smtp-Source: AGHT+IEx/9T8aSMonK/ABnp8SgOm64HoWUA+JOZhYiFG/KBzvJV6ESr569cwbH2wnlhUQSAXZJlcssIkSVw3bC6G4tE=
X-Received: by 2002:a17:907:25c2:b0:a9a:e9c:1d8d with SMTP id
 a640c23a62f3a-aa483426398mr270836266b.17.1731680463086; Fri, 15 Nov 2024
 06:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-5-sjg@chromium.org>
 <135727bd-d2e0-4370-954c-644fdd995036@gmx.de>
In-Reply-To: <135727bd-d2e0-4370-954c-644fdd995036@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:20:51 -0700
Message-ID: <CAFLszTjTYiFqv0QjszwPoek7jrWbDOdAakSZ2w3wP0GvFNyJLQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] compression: test: Move test into lib
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 03:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/2/24 20:36, Simon Glass wrote:
> > This test doesn't belong at the top level. Move it into the lib/
> > directory, since that is where compression is implemented.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/Makefile                | 1 -
> >   test/lib/Makefile            | 3 +++
> >   test/{ => lib}/compression.c | 0
> >   3 files changed, 3 insertions(+), 1 deletion(-)
> >   rename test/{ => lib}/compression.c (100%)
> >
> > diff --git a/test/Makefile b/test/Makefile
> > index 5d62b5c3357..ff621344a03 100644
> > --- a/test/Makefile
> > +++ b/test/Makefile
> > @@ -10,7 +10,6 @@ endif
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
> > -obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
> >   obj-y += dm/
> >   obj-$(CONFIG_FUZZ) += fuzz/
> >   ifndef CONFIG_SANDBOX_VPL
> > diff --git a/test/lib/Makefile b/test/lib/Makefile
> > index a54387a058e..ce22780eed8 100644
> > --- a/test/lib/Makefile
> > +++ b/test/lib/Makefile
> > @@ -2,6 +2,9 @@
> >   #
> >   # (C) Copyright 2018
> >   # Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
> > +
> > +obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
> > +
> >   ifeq ($(CONFIG_XPL_BUILD),)
> >   obj-y += cmd_ut_lib.o
> >   obj-y += abuf.o
> > diff --git a/test/compression.c b/test/lib/compression.c
> > similarity index 100%
> > rename from test/compression.c
> > rename to test/lib/compression.c
>
> Can we now use LIB_TEST instead of the COMPRESSION_TEST macro?

Yes, we could.

There was some discussion (with Tom) as to whether we should break
things up this way. For example I changed bloblist back to being
separate, in the later version of this series.

I would be quite happy with just having ~one test suite per dir.

Regards,
Simon
