Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D1BC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 03:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3241D88EBC;
	Thu, 22 Aug 2024 05:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="egrJ/JUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623BA88EB2; Thu, 22 Aug 2024 05:00:39 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E135B88C87
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 05:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf8a662467so1251236d6.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 20:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295636; x=1724900436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcUJP70ozUuYgfKfgDecynhevT92/g709JqcfNnOVq0=;
 b=egrJ/JUUICmIetEMwh2jVGkbnfffXG1h9iTidYEHJwuyIYenoQLQ4SFDh419ne8Lv2
 sHWYl9Z8/Qhh160fwkghMVh6+8LXJ6Il3UFKO+cjo/19q2k39zwjNbCVbZpa7VK5JJ3u
 7KPuqrtRM6PPlX1AbFeblNjqVFOLgL/w27Ex8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295636; x=1724900436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcUJP70ozUuYgfKfgDecynhevT92/g709JqcfNnOVq0=;
 b=wqUyDg1jkGGuF2RHtCZeNmftMcAFrogX7uvBQlwwuLhgnk6Sk1vpsmIN/hvDs37fcp
 YBLCQWugniza+C7IdM3IBLmSYPnWBFskeUAMzjMpz2QyEPlVN+vbU+Mq8/kFfkO5Ua3I
 o1naGl1s5pa7dNHSlP4EcOLjpp/gnAiZWhs3xOeP2UdZNeoYj0vkPGfWDXr+GlkwPCOs
 bSXTBXemGyUIj406ITkRPOn8i8ouQm8Z2aJR8J7W93we7fuNgj/GUKlEPERTYDJ2OKym
 Bz9vH0enhV9N7M3AD2SEHttcZJ3CF0Qdw/uRWVtXAmF2oYTnx7q8IYwmspiN/5QZzPTK
 TFtA==
X-Gm-Message-State: AOJu0Yxz7ieVaM8RSmmOHVw2wDlZ9cVH3THwCR4TsiyUjYb2g/lH/v66
 m7J2wqU71RTxlZfJwWmWf5LIXdJ80wMcCQaUurzq2ZQXQoW1SBBxgMT9MEzlLdshWtuf1Aif0aR
 UQ6C9yBrzsjqIoCHdJNwVFQAqv13wU2BWSkVw
X-Google-Smtp-Source: AGHT+IEFR1X4Agj5a+wGxeatSlr/iWmPs0aWnq5D/mul3B+xKbypBW5CazpTl/sZpYA3inPmTw1zVIpkyGNKYqMUorc=
X-Received: by 2002:ad4:4d83:0:b0:6c1:62bf:292a with SMTP id
 6a1803df08f44-6c162bf296amr8882196d6.10.1724295635737; Wed, 21 Aug 2024
 20:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
In-Reply-To: <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 21:00:25 -0600
Message-ID: <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> >
> > > For most boards, the device-tree compiler is built in-tree, ignoring the
> > > system version. Add a special option to skip this build. This can be
> > > useful when the system dtc is up-to-date, as it speeds up the build.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> > >  tools/buildman/builderthread.py |  4 ++--
> > >  tools/buildman/buildman.rst     |  3 +++
> > >  tools/buildman/cmdline.py       |  2 ++
> > >  tools/buildman/control.py       |  3 ++-
> > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
> > >  6 files changed, 66 insertions(+), 4 deletions(-)
> >
> > We should probably do this more generically, outside of buildman. We
> > have scripts/dtc-version.sh and if the system version isn't new enough
> > (and we just need to define whatever the minimum version is), then we
> > build our (not currently that new anymore) dtc instead.
>
> Yes I think I did a patch for that ages ago [1], but it was rejected.
>
> I'd be very happy for it to be applied as I think it is a better
> solution than this one.
>
> I see that some poor sod tried to do this in Linux this morning.

Any thoughts on that patch?

Also I do see one problem. Newer dtc version produce a lot of
warnings, which causes CI to fail. So if we always use the newest
version, people are going to see a ton of warnings when they run
locally. Am I missing something here?

Regards,
SImon
