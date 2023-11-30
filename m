Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DD0C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2307E87671;
	Thu, 30 Nov 2023 03:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RpFzA5nM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463D787638; Thu, 30 Nov 2023 03:46:26 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5584787660
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5cfc3a48ab2so4828027b3.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312381; x=1701917181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lHmyVVBvU0s8JR4Ira3eLCfCpRgbYA5WyfD0twPlW/Y=;
 b=RpFzA5nMOWRmrf8oaWFG5ByWBgMrCqE8030GyZLIsnTRUcHnyJxV64iBDeI6xcLK9b
 k3IOeTpTseD0WIGHZjbicC7+Q6iAnDlZcXRG70v1UTMTxWju5fTyI1oMDdvgrg2LAGpI
 1k+ApKZZ3dUZB/ZdNcDfoFJhx8XFBQwBxLqwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312381; x=1701917181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHmyVVBvU0s8JR4Ira3eLCfCpRgbYA5WyfD0twPlW/Y=;
 b=FJzNXaLoIjaHWwfmYsXA6Ux941oQrHfRS1isNV3fMaz0PNOabIy/DKUJRs3o9G1Wzd
 j3CPZSYUoR0QMrCsFDQcW5zuwgIf0tltsgxQO6vqUkzUqJbFOGoUecdcLIlgdrccUPM4
 3TtgSk5Z13xeYL+edtukYdEu0v6H95bH2jBWTI4i+LbA+aypsT64y6cKl2YdbuA9m9/M
 jL68r2vX0fqopzJs46WErh9OsD6k3wzj8N0cqOTyQx1JpK7MS2CbpwkkjoYgzoKEV9Ew
 XzbkQ47ucHKUU6CGcvi30Zh84NDci4thEMhxPsWJFZHV16sesID9ZGz/utGX6Cm5EPE3
 +9yA==
X-Gm-Message-State: AOJu0YyiWBYfkg6D9ZBxSRnKWYldZOn9wLf77Qxu1xmFyA0cPD48IyjJ
 rKKOQ/atJrA9DD0J248yKJRz2lJA4jaO9gDtJGZfGw==
X-Google-Smtp-Source: AGHT+IFbMiWB7AYlpJjg8nQ+zmCv6rfZ+UNG/egFSuLz4o4hbMHSlcN69pgT1+jOt3RXpvYpb/zdV1/b+0cFW1N2nQw=
X-Received: by 2002:a05:690c:448d:b0:5d1:4412:1866 with SMTP id
 gr13-20020a05690c448d00b005d144121866mr7877943ywb.26.1701312380814; Wed, 29
 Nov 2023 18:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
 <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
 <CADg8p96mfEtCySQyXPLqKuwnYu7BPO5guoz9+0452aujgs-zsg@mail.gmail.com>
In-Reply-To: <CADg8p96mfEtCySQyXPLqKuwnYu7BPO5guoz9+0452aujgs-zsg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:40 -0700
Message-ID: <CAPnjgZ09vvyhBTUW03armbz_sevRr0qQeqL2vaQ3BNq+Wo9_dA@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

Hi Sughosh,

On Wed, 22 Nov 2023 at 00:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Ilias,
>
> On Wed, 22 Nov 2023 at 13:06, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > On Wed, 22 Nov 2023 at 07:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Simon,
> > >
> > > On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Add support for specifying the parameters needed for capsule
> > > > > generation through a config file, instead of passing them through
> > > > > command-line. Parameters for more than a single capsule file can be
> > > > > specified, resulting in generation of multiple capsules through a
> > > > > single invocation of the command.
> > > > >
> > > > > The config file can then be passed to the mkeficapsule tool in such
> > > > > manner
> > > > >
> > > > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  tools/Kconfig              |  15 ++
> > > > >  tools/Makefile             |   1 +
> > > > >  tools/eficapsule.h         | 114 ++++++++++++
> > > > >  tools/mkeficapsule.c       |  87 +++++----
> > > > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > > > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > > > >  create mode 100644 tools/mkeficapsule_parse.c
> > > >
> > > > This patch keeps coming back :-)
> > > >
> > > > Can we not add multiple capsules in the binman description? Why do we
> > > > need a new file format? How can binman decode images produced in this
> > > > way?
> > >
> > > So as Tom mentions, this brings parity with respect to the other
> > > capsule generation tool in EDKII that generates capsules. IIRC, this
> > > is something which even Xilix was interested in, and Michal had kind
> > > of gone through these patches earlier. Lastly, it would be good to
> > > have support in U-Boot's mkeficapsule tool for generating a single
> > > capsule file with multiple payloads, and having support for this
> > > functionality helps in that goal.
> > >
> > > Also, you might have noticed that, since your objection to the last
> > > series, I have removed putting this in binman. So now, this aspect of
> > > the capsule generation would only be supported through the
> > > command-line invocation of the tool.
> >
> > I think that overall the approach is sane. mkeficapsule is currently
> > supported and compiled for distros, so the multiple payload support is
> > useful. If we want to add support to binman, instead of rewriting this
> > in python, we could just call that tool for parsing and creating
> > capsules
>
> Given the amount of time these patches have been under review(also
> number of iterations), I would request that this series be reviewed
> and merged first. I think there is general consensus that there is
> value to have this functionality in the mkeficapsule tool. If it is
> deemed fit to support this through binman as well, that task can be
> taken up separately. Thanks.

The point you are missing is that it is the entire goal of 'skirting
around' binman which is suspect.

If there is a need to generate an output file from the build, we
should support it in binman. If people start creating configuration
files all over the place, then they are not using binman, right?

I understand that there are pre-existing vendor-specific config files,
etc. that the EFI thing is a grey area, but I cannot imagine that this
patch would lead to a good outcome.

The goal of binman is to bring order to the chaos of firmware
packaging...we cannot do that if it is not actually used.

So let's figure out what is missing from binman's capsule generation
(multiple capsules? accept/reject capsules?) and how best to add it.

>
> -sughosh
>
> >
> > Thanks
> > /Ilias
> > >
> > > >
> > > > Also, could we get sandbox to produce one EFI capsule as part of the
> > > > normal build? I think that discussion trailed off.
> > >
> > > Yes, apologies for missing out on this. Slipped my mind. Would you
> > > want, say, all the non-signed capsules to be generated as part of the
> > > sandbox build?
> > >
> > > -sughosh

Regards,
Simon
