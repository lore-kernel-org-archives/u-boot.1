Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B022DC07E97
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 06:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4EA8701F;
	Fri,  1 Dec 2023 07:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sptuW4dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A1D87083; Fri,  1 Dec 2023 07:39:27 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F9786FB6
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 07:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54af1daf6a9so2910051a12.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 22:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701412764; x=1702017564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3NHGtDU2jKKM29m4LdDKq6pK9po4Pk38w16NAoro70=;
 b=sptuW4dzhMmE8Ogq3pHxd0aHwK6Nmt+5UWRemmczvk/hpvWz4RVp1NomH6uk69yzOu
 L3XglrwZhvAaKKInOddYka+sPLYrbJ4xyQkML0GIcPznNclcQ/bGczpEU79yAV+j32bw
 t4EBJjm6tAUM2iSeIzm9/Z0Lst1M4xsYgCGYCU+2E0W2kehRkLDI7dzVVRzyzT3b1+4C
 MDizJ05bvlfvVdb2xCXkOZb0pJQs9Qg521Skn5qfWoT9D2JxbiXx1U0M2ntLFJxDXUr1
 wC8/SjvzCCWP9cl0fWjRM0ZIEJ6jl7K9umjxPUMmLbhPoeViBOQaU5HgQ7UHPLbWwh1F
 ledA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701412764; x=1702017564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3NHGtDU2jKKM29m4LdDKq6pK9po4Pk38w16NAoro70=;
 b=p4ntB+6dP1E06XFwBOYJzofQlJN0NFqxaVDiNED49h4LodzMjzpGH2EtdN9HUBhLJv
 Ik79GBl5SNpmDoz6P6c/0HfK2ih9nUbqZ5knp9FGkRAysKWJhEdpewY/hC7Z7nimvNl8
 rbOs5kxNq191Vu1wk61pzaJDaSRWni7f30f3nEYzJSMQwTGmeo/a3oe7GD7FUiebl7Gi
 R0N6sy7bNEjGBxAKHWDS9v5wIgEJME6lRlmbFkMXblvTdFxNDO4lsasd8CLJiloAazak
 ZpyTn0YbFxzNbRbA0LIBapCqAVlxSV6cyu2Cin8IZmyNN1A5V0NMxVGu3fJyOcD3XJQW
 06ZA==
X-Gm-Message-State: AOJu0Ywhgk5vqfY7gM+MiCSUf7O8Z5+/UYFjrv11+KUHvrgmR+8mGCct
 L/vjAcBzKR7tTaV2jM7dFLA41JqTzygRurV6zCia7Q==
X-Google-Smtp-Source: AGHT+IGm4gsNsQlVG+lwJG4Lqck5y7hBfIRgrmaouCQJ5E2xLhYDgRKep+kpx8vlQ3oypc9ak7NFE3VzRA2+jXPMh/s=
X-Received: by 2002:aa7:d307:0:b0:548:62d8:3c82 with SMTP id
 p7-20020aa7d307000000b0054862d83c82mr746886edq.16.1701412759180; Thu, 30 Nov
 2023 22:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
 <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
 <CADg8p96mfEtCySQyXPLqKuwnYu7BPO5guoz9+0452aujgs-zsg@mail.gmail.com>
 <CAPnjgZ09vvyhBTUW03armbz_sevRr0qQeqL2vaQ3BNq+Wo9_dA@mail.gmail.com>
In-Reply-To: <CAPnjgZ09vvyhBTUW03armbz_sevRr0qQeqL2vaQ3BNq+Wo9_dA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 1 Dec 2023 12:09:08 +0530
Message-ID: <CADg8p96yHf7gSzHX4H6zaV-nx-BQ7qwmnBn6n5+xn969FCZKnQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Simon Glass <sjg@chromium.org>
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

hi Simon,

On Thu, 30 Nov 2023 at 08:16, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 22 Nov 2023 at 00:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Ilias,
> >
> > On Wed, 22 Nov 2023 at 13:06, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > On Wed, 22 Nov 2023 at 07:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > hi Simon,
> > > >
> > > > On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > Add support for specifying the parameters needed for capsule
> > > > > > generation through a config file, instead of passing them through
> > > > > > command-line. Parameters for more than a single capsule file can be
> > > > > > specified, resulting in generation of multiple capsules through a
> > > > > > single invocation of the command.
> > > > > >
> > > > > > The config file can then be passed to the mkeficapsule tool in such
> > > > > > manner
> > > > > >
> > > > > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > >  tools/Kconfig              |  15 ++
> > > > > >  tools/Makefile             |   1 +
> > > > > >  tools/eficapsule.h         | 114 ++++++++++++
> > > > > >  tools/mkeficapsule.c       |  87 +++++----
> > > > > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > > > > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > > > > >  create mode 100644 tools/mkeficapsule_parse.c
> > > > >
> > > > > This patch keeps coming back :-)
> > > > >
> > > > > Can we not add multiple capsules in the binman description? Why do we
> > > > > need a new file format? How can binman decode images produced in this
> > > > > way?
> > > >
> > > > So as Tom mentions, this brings parity with respect to the other
> > > > capsule generation tool in EDKII that generates capsules. IIRC, this
> > > > is something which even Xilix was interested in, and Michal had kind
> > > > of gone through these patches earlier. Lastly, it would be good to
> > > > have support in U-Boot's mkeficapsule tool for generating a single
> > > > capsule file with multiple payloads, and having support for this
> > > > functionality helps in that goal.
> > > >
> > > > Also, you might have noticed that, since your objection to the last
> > > > series, I have removed putting this in binman. So now, this aspect of
> > > > the capsule generation would only be supported through the
> > > > command-line invocation of the tool.
> > >
> > > I think that overall the approach is sane. mkeficapsule is currently
> > > supported and compiled for distros, so the multiple payload support is
> > > useful. If we want to add support to binman, instead of rewriting this
> > > in python, we could just call that tool for parsing and creating
> > > capsules
> >
> > Given the amount of time these patches have been under review(also
> > number of iterations), I would request that this series be reviewed
> > and merged first. I think there is general consensus that there is
> > value to have this functionality in the mkeficapsule tool. If it is
> > deemed fit to support this through binman as well, that task can be
> > taken up separately. Thanks.
>
> The point you are missing is that it is the entire goal of 'skirting
> around' binman which is suspect.
>
> If there is a need to generate an output file from the build, we
> should support it in binman. If people start creating configuration
> files all over the place, then they are not using binman, right?
>
> I understand that there are pre-existing vendor-specific config files,
> etc. that the EFI thing is a grey area, but I cannot imagine that this
> patch would lead to a good outcome.
>
> The goal of binman is to bring order to the chaos of firmware
> packaging...we cannot do that if it is not actually used.
>
> So let's figure out what is missing from binman's capsule generation
> (multiple capsules? accept/reject capsules?) and how best to add it.

I think I need to jog your memory back a bit. For context, I have
jotted down the points.

* The mkeficapsule tool generates capsules in U-Boot.
* Currently, when the tool is invoked from the command-line, the
capsules are generated by passing the capsule parameters as cmd-line
options.
* I had earlier added support for generating the capsules as part of
U-Boot build, through binman. This support has been merged.
* I had followed these patches up with another series [1] which
generates capsules by parsing the capsule parameters through a config
file instead of cmd-line options.
* This series also had patches which were attempting to integrate this
functionality into binman [2].
* As part of reviewing the patch series, you had objected to adding
this support in binman, primarily because this way of specifying the
capsule parameters goes against the normal way of image description in
binman [3].
* I have described in this mail thread about why we need to have
support for generating capsules through config files [4].

So, in essence, this functionality is needed to be added to the tool.
I have earlier tried integrating this in binman, but that was
rejected. So, the way I see this moving ahead is to first add support
for this feature in the tool, and then see if this can also be added
in binman. As I mentioned earlier, I am fine with this functionality
not getting integrated with binman, if this contravenes the idea of
describing images in binman, and if no exceptions can be made on that
regard. But please do understand that no attempt is being made at
'skirting around binman'. In fact, I had worked on your earlier
objection of using absolute paths in testing this functionality in
binman. But then you had put the other objection of how this does not
follow the idea or concept of image description in binman. Hence this
approach.

-sughosh

[1] - https://lore.kernel.org/u-boot/20230908120002.29851-1-sughosh.ganu@linaro.org/
[2] - https://lore.kernel.org/u-boot/20230908120002.29851-4-sughosh.ganu@linaro.org/
[3] - https://lore.kernel.org/u-boot/CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com/
[4] - https://lore.kernel.org/u-boot/CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com/

>
> >
> > -sughosh
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > >
> > > > > Also, could we get sandbox to produce one EFI capsule as part of the
> > > > > normal build? I think that discussion trailed off.
> > > >
> > > > Yes, apologies for missing out on this. Slipped my mind. Would you
> > > > want, say, all the non-signed capsules to be generated as part of the
> > > > sandbox build?
> > > >
> > > > -sughosh
>
> Regards,
> Simon
