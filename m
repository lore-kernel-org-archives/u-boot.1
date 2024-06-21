Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B5FC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85C28845A;
	Fri, 21 Jun 2024 21:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ST00sVQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E86A884C6; Fri, 21 Jun 2024 21:40:00 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7B688059
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b4ff7cb429so11259376d6.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718998797; x=1719603597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PiXbQHju/lfqol40fciEhTaeXiK0lJwjo7gJQov26KQ=;
 b=ST00sVQ0pCQ3tHzRHBj/HM5P9dyuRFdwiN/CsKqnLHzAENbFdYUz4NcuzfrzlxGpES
 3UbTnNebLI4RejQX34uFyuoZ86J3pTXWU8FMz5eIHHbolZCodYud2zGZdHmCflqTQEjL
 VlwqKGfOyoBIwBwVMZlE9OeIpR1Lba5JRlOWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718998797; x=1719603597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PiXbQHju/lfqol40fciEhTaeXiK0lJwjo7gJQov26KQ=;
 b=AKtO3F4s/JpqkIqIy5GmPRuf2HxU7rOcM0ZvSQZYJvwjrbwlJc+VzsGhESMx9XK0Y/
 oYqnbujVWrnY1Dm1LxQGaicrL1Hto0mqLZlIg4GkhcautPbOiFLUyQRWOZU247FCBriM
 xag6J4UUhuqpwIStiNYG6FXPUHzKt3rA1hwTgMu5pim+/EkcNP0Wyac3KfLLuOqRSswG
 GYw76vSILmjDD3TObA7wes3NukrvudlRGAiMPhFePnuI+O1fvC7gE9eSpTxa+T0+Ic/b
 nEFJL1D+P+gYUkXReyHSZYb0+6jIu2ucIWZTTP3M/Y+B/DHba4UnKQ1UeVEVNaD41ftM
 U50A==
X-Gm-Message-State: AOJu0Yz20oujz/DRFlyOIcfMUl3xT6qCR2KSpsqu29qf7kJRehjbnMGi
 zqp2is5TQYadhiwt71FkLq2O2mW1jgb/5edLEkuBhIzE88IDwo/KUbFuPKGHxPeo5dJKufuzn2X
 +sRS0R0qpkzVucxI5jrjchAej5eoez81qVnVoxB2pCmFmmMdHPw==
X-Google-Smtp-Source: AGHT+IEu5dblY+1MpyL71fYQtJo+IUZmc4msagSra7zodslUJg8Jz4U8hLSX0TqY/6ePeVQbvMdxefZW1wox+5axV8Y=
X-Received: by 2002:a0c:c983:0:b0:6b0:92ac:8193 with SMTP id
 6a1803df08f44-6b516863f17mr57453796d6.54.1718998796884; Fri, 21 Jun 2024
 12:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <20240620143232.GM68077@bill-the-cat>
 <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
 <20240620233026.GU68077@bill-the-cat>
 <CAFLszTi7qXX6R5=LQqCMveH7aJ=N96Mcob+gp11MEPixgrK66A@mail.gmail.com>
 <20240621152229.GV68077@bill-the-cat>
 <CAFLszTi_NBBxz3MZz0HuOW5c2bGT3FgZ2usnAginZ0LC_TdX9A@mail.gmail.com>
 <20240621192617.GA68077@bill-the-cat>
In-Reply-To: <20240621192617.GA68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 13:39:46 -0600
Message-ID: <CAFLszTiA5JFU3EaTi_f142tDRej6rSMk=gCWitnqC2tb8d_vtQ@mail.gmail.com>
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

On Fri, 21 Jun 2024 at 13:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 21, 2024 at 12:19:12PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 21 Jun 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jun 21, 2024 at 08:57:50AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 20 Jun 2024 at 17:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jun 20, 2024 at 05:05:30PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 20 Jun 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > The Python virtualenv tool sets up a few things in the envronment,
> > > > > > > > putting its path first in the PATH environment variable and setting up
> > > > > > > > a sys.prefix different from the sys.base_prefix value.
> > > > > > > >
> > > > > > > > At present buildman puts the toolchain path first in PATH so that it can
> > > > > > > > be found easily during the build. For sandbox this causes problems since
> > > > > > > > /usr/bin/gcc (for example) results in '/usr/bin' being prepended to the
> > > > > > > > PATH variable. As a result, the venv is partially disabled.
> > > > > > > >
> > > > > > > > The result is that sandbox builds within a venv ignore the venv, e.g.
> > > > > > > > when looking for packages.
> > > > > > > >
> > > > > > > > Correct this by detecting the venv and adding the toolchain path after
> > > > > > > > the venv path.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > Why are we using PATH at all in this case? Shouldn't we just be setting
> > > > > > > CROSS_COMPILE=/full/path/to/the/prefix ?
> > > > > >
> > > > > > This is the -p option to buildman. The original commit was:
> > > > > >
> > > > > > commit bb1501f2c22c979961b735db775605cccedd98f6
> > > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > > Date:   Mon Dec 1 17:34:00 2014 -0700
> > > > > >
> > > > > >     buildman: Add an option to use the full tool chain path
> > > > > >
> > > > > >     In some cases there may be multiple toolchains with the same name in the
> > > > > >     path. Provide an option to use the full path in the CROSS_COMPILE
> > > > > >     environment variable.
> > > > > >
> > > > > >     Note: Wolfgang mentioned that this is dangerous since in some cases there
> > > > > >     may be other tools on the path that are needed. So this is set up as an
> > > > > >     option, not the default. I will need test confirmation (i.e. that this
> > > > > >     commit fixes a real problem) before merging it.
> > > > > >
> > > > > > As to why we don't always do this, well that is back in the mists of
> > > > > > time, 10 years ago.
> > > > > >
> > > > > > BTW, this is raising a point ("let's change the behaviour") separate
> > > > > > from the goal of this commit, which is to fix a problem with venv,
> > > > > > albeit that if we made -p the only option, then we could potentially
> > > > > > drop all PATH changes. Perhaps toolchains are built differently now,
> > > > > > such that they always invoke their tools using the same prefix and
> > > > > > dir?
> > > > >
> > > > > Wait, I'm confused. buildman internally updates its own PATH to avoid
> > > > > calling CROSS_COMPILE with the full path due to a concern about
> > > > > toolchain bugs?
> > > >
> > > > Not its own PATH: the one it passes to U-Boot's 'make'.
> > >
> > > OK, but the point stands.
> > >
> > > > I'm not sure why, actually. It is such a long time ago that I don't remember.
> > > >
> > > > I see:
> > > >
> > > > ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ld
> > >
> > > Yes, prefixed version that's allowed to be called by users.
> > >
> > > > and
> > > >
> > > > ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/arm-linux-gnueabi/bin/ld
> > >
> > > Internal usage, here be dragons and all that.
> > >
> > > > but interestingly there is no gcc in the latter directory, which there
> > > > was in 4.6 (and presumably for some time after).
> > > >
> > > > Certainly for sandbox there is no prefix, so we cannot add it in that
> > > > case, and sandbox is actually the arch used to run these tests.
> > >
> > > CROSS_COMPILE is empty for sandbox, yes.
> > >
> > > > What are you suggesting we change about this patch?
> > >
> > > That it's going about things backwards? If you're setting CROSS_COMPILE
> > > _then_ it should be the full path that it already knows otherwise if not
> > > setting CROSS_COMPILE then also not modifying PATH.
> >
> > That is what the code does, yes. It either adds the toolchain path to
> > CROSS_COMPILE or to PATH, not both. The 'full_path' argument controls
> > which one it uses.
>
> I'm saying it should always use the full path to CROSS_COMPILE and never
> modify PATH.

That wouldn't work with toolchains that don't have a prefix, though.
If that is what you want I'm happy to modify the patch.

Regards,
Simon
