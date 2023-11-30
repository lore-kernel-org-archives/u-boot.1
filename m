Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27EC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51D586C47;
	Thu, 30 Nov 2023 03:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lmMAtwCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B673087483; Thu, 30 Nov 2023 03:45:56 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7948747E
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c9bbb30c34so6058501fa.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ptc8NFXlUgqJ7nbuX7wqHQVuUVpGuvkhZ0OG0zNhWNM=;
 b=lmMAtwCpGwosOSckZ2xqUzy+o0fVTgIl7GG2fOtqR4F/rPMC+RIIW3W8n80ahpbkLy
 N+SpLFq6krLN/uXqW834WQMjBQr5NXBX1Cjl0gRpfUCHFFXKCXwB3qP51TAl6dOtJ0Cu
 1bLFznSXla6G90PMxBrfht58uTvmYR1Q8SyOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptc8NFXlUgqJ7nbuX7wqHQVuUVpGuvkhZ0OG0zNhWNM=;
 b=obbgrgISHgp0dhLJaRAVo71s1orBXGa0MhvKBYjndkOsDNPUOtny8unDYUvk15gqTU
 b7zZ7O3V81YUJdxRAYwChTFu/pus4Kd3QzWHL9bvWqLt+TUQA9bbr1xN7aVauXeJjcMU
 2jmiIbjhLJe1fGG7pe0lpgyZ0+W/vqyBOzc8TebL9bOvQQJIHOEf71gJPJnp90C70vWD
 gcv8r2r9Ss8TwJSI8GTDfG+uxwzCgaJW2mInfVPdXc9HVKwEfoRaJZ5vxayL5IHacY7I
 rVF8bvmcuCXoGg4IxlknbOEVTOxJkLYDC4KUpaTbLrek8wyW5kYH4EpIaOvZPiaqFFF9
 zVbQ==
X-Gm-Message-State: AOJu0YylNEZMcJnT7HMaf20qetSanHBGBBsZH2ehRZrUYAqHjPta9tNw
 nAuBJRcLiSan6JTb2HRknWsmnv4T0613QNEwfJEJSg==
X-Google-Smtp-Source: AGHT+IEWHDyIcHoVy7c1a0rclaAoUmdpiaktzna03jnfGLRHuJ2VvW0SYf2n/cP68bxcSBTV9s1Z2/R868qMTE/oCB4=
X-Received: by 2002:a2e:9a8c:0:b0:2c9:c348:525c with SMTP id
 p12-20020a2e9a8c000000b002c9c348525cmr1793951lji.26.1701312350127; Wed, 29
 Nov 2023 18:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
In-Reply-To: <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:36 -0700
Message-ID: <CAPnjgZ3bMaR=K-GVUgvXJj=TQjU-y0sQUZ6qxwwkFcTZM_ro+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

On Tue, 21 Nov 2023 at 22:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add support for specifying the parameters needed for capsule
> > > generation through a config file, instead of passing them through
> > > command-line. Parameters for more than a single capsule file can be
> > > specified, resulting in generation of multiple capsules through a
> > > single invocation of the command.
> > >
> > > The config file can then be passed to the mkeficapsule tool in such
> > > manner
> > >
> > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  tools/Kconfig              |  15 ++
> > >  tools/Makefile             |   1 +
> > >  tools/eficapsule.h         | 114 ++++++++++++
> > >  tools/mkeficapsule.c       |  87 +++++----
> > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > >  create mode 100644 tools/mkeficapsule_parse.c
> >
> > This patch keeps coming back :-)
> >
> > Can we not add multiple capsules in the binman description? Why do we
> > need a new file format? How can binman decode images produced in this
> > way?
>
> So as Tom mentions, this brings parity with respect to the other
> capsule generation tool in EDKII that generates capsules. IIRC, this
> is something which even Xilix was interested in, and Michal had kind
> of gone through these patches earlier. Lastly, it would be good to
> have support in U-Boot's mkeficapsule tool for generating a single
> capsule file with multiple payloads, and having support for this
> functionality helps in that goal.
>
> Also, you might have noticed that, since your objection to the last
> series, I have removed putting this in binman. So now, this aspect of
> the capsule generation would only be supported through the
> command-line invocation of the tool.

That sounds like the opposite of what I was asking for...

>
> >
> > Also, could we get sandbox to produce one EFI capsule as part of the
> > normal build? I think that discussion trailed off.
>
> Yes, apologies for missing out on this. Slipped my mind. Would you
> want, say, all the non-signed capsules to be generated as part of the
> sandbox build?

Just one would be good. Probably using a signed one makes more sense
since it is more realistic?

You don't need to change any of the existing tests...I just mean to
add a single capsule generated as part of the sandbox binman
invocation.

The problem is that, at the moment, I cannot make much sense of the
build/binman integration since nothing actually uses it. Once sandbox
uses it, I will be able to understand it better and suggest ways to
expand the binman support.

Regards,
Simon
