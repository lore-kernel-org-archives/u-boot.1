Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC7CC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955AD8854A;
	Fri, 21 Jun 2024 16:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GFDOiTNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9873288556; Fri, 21 Jun 2024 16:58:04 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6853B8853F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-795a4fde8bfso132058685a.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981881; x=1719586681; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fCntKDYLJVZNGfUWL+UD+r/f0fcedQUiEPsRz3nIzuY=;
 b=GFDOiTNTTMLJAxy1qm4O03rGdsMT96/osBq66RM2vJwNwZioROLN9NCNrUEmgrhVyl
 mWURsoZPp/eRnoikdKr7r400xdHWg+dnDU+6Dm2AgSqhxU8y16HPEXOoqyPjCTs2mLxq
 HjCGSnqnMvFgrJMRsC07X7jDFlv5izJ5MZ5G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981881; x=1719586681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fCntKDYLJVZNGfUWL+UD+r/f0fcedQUiEPsRz3nIzuY=;
 b=XMRO8vBX3bKnCmarjC0IM1zOmyPAprqiYE556ccPEGOngywCoFzHwxT9Nb9iKgTJQb
 bzv0vbYkT4yYVXZJryRrsf1B6fG+mNdgOeDYw+bWZwUJeMoz+1mBWAwxkXm+2/t6uxZA
 dzs5tQRKziptBJewWTDH5jdw1Y1z66fGvC6j47TBgZ3IUGrFR9+FgCJzCqpG/t+suf4T
 EJZIS/stTclmNyAc6GZhHtbqFqugWxH0q57fREA9mrsj4JlqRm9QJDE2TN6gumQVQr1T
 I6/A9Q/Wk+f+otqVI2S5zxJtnJMk8TIcbAg1T6x9f4lOj/NOqKnreLX9IqtIA1353CfK
 ovaA==
X-Gm-Message-State: AOJu0Yz4GNmT52TABYT+UdtaGuExXZjeoNAJfEnUm59WwWgNOGxVk/6R
 nWaaVLSv6OxoSzxvbn4XlWwp4jUXoaId9YmoHgJIjGJNCG7aumeb1E8sZgtvcIx1myFZ87bjxm+
 mUIW7Dp1v0wXD9cHs+wDDtItSbtVmVv2lmA9P
X-Google-Smtp-Source: AGHT+IEAprfw2nwbOr+CvZBlFBlBjspcER2P5dyB4+hh+ug11L2/hjsdbmGzYNoNVob981k8lLjsk/zAC9A7hBw5YqI=
X-Received: by 2002:a05:6214:e4c:b0:6b5:1976:98ac with SMTP id
 6a1803df08f44-6b519769adcmr46365206d6.28.1718981880967; Fri, 21 Jun 2024
 07:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <20240620143232.GM68077@bill-the-cat>
 <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
 <20240620233026.GU68077@bill-the-cat>
In-Reply-To: <20240620233026.GU68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:50 -0600
Message-ID: <CAFLszTi7qXX6R5=LQqCMveH7aJ=N96Mcob+gp11MEPixgrK66A@mail.gmail.com>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Thu, 20 Jun 2024 at 17:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 20, 2024 at 05:05:30PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 20 Jun 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:
> > >
> > > > The Python virtualenv tool sets up a few things in the envronment,
> > > > putting its path first in the PATH environment variable and setting up
> > > > a sys.prefix different from the sys.base_prefix value.
> > > >
> > > > At present buildman puts the toolchain path first in PATH so that it can
> > > > be found easily during the build. For sandbox this causes problems since
> > > > /usr/bin/gcc (for example) results in '/usr/bin' being prepended to the
> > > > PATH variable. As a result, the venv is partially disabled.
> > > >
> > > > The result is that sandbox builds within a venv ignore the venv, e.g.
> > > > when looking for packages.
> > > >
> > > > Correct this by detecting the venv and adding the toolchain path after
> > > > the venv path.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Why are we using PATH at all in this case? Shouldn't we just be setting
> > > CROSS_COMPILE=/full/path/to/the/prefix ?
> >
> > This is the -p option to buildman. The original commit was:
> >
> > commit bb1501f2c22c979961b735db775605cccedd98f6
> > Author: Simon Glass <sjg@chromium.org>
> > Date:   Mon Dec 1 17:34:00 2014 -0700
> >
> >     buildman: Add an option to use the full tool chain path
> >
> >     In some cases there may be multiple toolchains with the same name in the
> >     path. Provide an option to use the full path in the CROSS_COMPILE
> >     environment variable.
> >
> >     Note: Wolfgang mentioned that this is dangerous since in some cases there
> >     may be other tools on the path that are needed. So this is set up as an
> >     option, not the default. I will need test confirmation (i.e. that this
> >     commit fixes a real problem) before merging it.
> >
> > As to why we don't always do this, well that is back in the mists of
> > time, 10 years ago.
> >
> > BTW, this is raising a point ("let's change the behaviour") separate
> > from the goal of this commit, which is to fix a problem with venv,
> > albeit that if we made -p the only option, then we could potentially
> > drop all PATH changes. Perhaps toolchains are built differently now,
> > such that they always invoke their tools using the same prefix and
> > dir?
>
> Wait, I'm confused. buildman internally updates its own PATH to avoid
> calling CROSS_COMPILE with the full path due to a concern about
> toolchain bugs?

Not its own PATH: the one it passes to U-Boot's 'make'.

I'm not sure why, actually. It is such a long time ago that I don't remember.

I see:

~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ld

and

~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/arm-linux-gnueabi/bin/ld

but interestingly there is no gcc in the latter directory, which there
was in 4.6 (and presumably for some time after).

Certainly for sandbox there is no prefix, so we cannot add it in that
case, and sandbox is actually the arch used to run these tests.

What are you suggesting we change about this patch?

Regards,
Simon
