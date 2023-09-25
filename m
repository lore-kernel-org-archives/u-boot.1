Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF20CE7A9E
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 16:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F72986B58;
	Mon, 25 Sep 2023 18:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QVRhQ5dx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D6C86B91; Mon, 25 Sep 2023 18:19:16 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1427886A88
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 18:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so4522496a12.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695658753; x=1696263553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OKuWoraEK3yATTYuqAS+es5gLvarj+bC1XQMUfMHE0U=;
 b=QVRhQ5dxic9PpDJ3ys0b8IHHbDf3xWL+d3vcG1v+EyAe6XlAOWDEwZ0IgMmibO8yYV
 uWZj54rjk3BTMO1GWWQH1GrL3kHmQO/XYDo6PvYCscXtF2u9XPnxXMqtpnMD1zQt9EMK
 XMVvQSD2fG7ChKOT5m50Sk8mzschqlYiaNrjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695658753; x=1696263553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OKuWoraEK3yATTYuqAS+es5gLvarj+bC1XQMUfMHE0U=;
 b=IxSDDVl2vdwnj6mo7FQwGyYzxsvdbGVpZHAhKWnK2WqQAwjaAzoKCLZTkm6VZ8GJOs
 MuNtJOTmQWKrG5iF4H9w7UQ/yoD6t45gpws0rEx3zSGSPcsvthHnFquLRUgbkKupc8Bl
 1LNtqnZtAjOwovQGTfWHAb0rHNKwoaGu9gAB/7v1rsFQ3t3SoiOUgn2Ub/OPx0wcmsmS
 7BFbKaRjhHUPYJhzXSa5+KatG6IeUHqB75uQbgena3EluIrPBX/hpzjEcHwK+TgwZwZX
 wS4ge+eAPH3B3hGDKGUeCsx+Ql8wB4e0uBTe/+J0GlTh4/SyraG5Us3NZnRhfMoJXJF4
 /e2A==
X-Gm-Message-State: AOJu0YwtXIZI9WfSZ/UQGPc8a2yeX6g/07nBBRxvk9m8ZQBi+yt7+599
 DCPjmBSuFtdECNhY8IHqcB29IByKgZPPYhfYTEKsM3yV/VqlscMcIv0=
X-Google-Smtp-Source: AGHT+IEfT7LfiD64vXNO3P28H0s1G0rTdF+J3NK/VzJodxIGF7L1rUymoy+oIHqSOw4bicqohVFyHyjqj7JLIbA4tT0=
X-Received: by 2002:aa7:c0c6:0:b0:530:4bcd:626c with SMTP id
 j6-20020aa7c0c6000000b005304bcd626cmr6294318edp.23.1695658753307; Mon, 25 Sep
 2023 09:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925140838.GV305624@bill-the-cat>
 <CAPnjgZ2gBRWt6v1i21Mq+bnqScnHYKATCURMtJ6E7DGspOdpnw@mail.gmail.com>
 <20230925151340.GB305624@bill-the-cat>
In-Reply-To: <20230925151340.GB305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 10:18:55 -0600
Message-ID: <CAPnjgZ3-AAE11afQx12iqCH6gTeGo-XTBL5ZQn-b-CgOwry7=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] common: Remove a few more header files
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 25 Sept 2023 at 09:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 25, 2023 at 08:35:44AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 25 Sept 2023 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Sep 24, 2023 at 08:39:49PM -0600, Simon Glass wrote:
> > >
> > > > This series removes two more header files from the common.h header. It
> > > > also tidies up code style for time.h functions, to simplify similar
> > > > maintenance in future.
> > > >
> > > >
> > > > Simon Glass (3):
> > > >   Fix code style for time functions
> > > >   common: Drop time.h from common header
> > > >   common: Drop linux/string.h from common header
> > > [snip]
> > > >  1709 files changed, 1854 insertions(+), 34 deletions(-)
> > >
> > > This is where I start to get worried we're possibly taking the wrong
> > > approach to the problem.  Perhaps it would be better to:
> > > 1. Start finding headers which include <common.h>, remove and fixup the
> > > breakage directly.
> > > 2. Move on to removing <common.h> from files, a directory at a time.
> > >
> >
> > The bigger question is whether you want common.h gone or not?
>
> Yes, I'd like it gone.
>
> > I shared my script with you so you can see what it is doing. But if a
> > board uses memcmp(), for example, then it needs linux/string.h
> > included. We can discuss why so many files use string functions, or
> > whether the script is not perfect, but ultimately that is the
> > question.
> >
> > Just these simple queries give you a sense of the scale:
> >
> >  git grep -l strcat |wc
> >      45      45    1134
> > git grep -l memcpy |wc
> >     834     834   21643
> >
> > If you are suggesting that we add fewer includes for now, relying on
> > transitive includes in header files, then I don't think that is very
> > useful in the end. I had a series a few years back which removed
> > common.h entirely and it foundered on this same issue.
>
> The problem I see with the approach you're taking now is that it's quite
> hard to provide meaningful review.  Looking at the time.h patch here, I
> assume you agree it would be better to just remove
> arch/arm/include/asm/arch-tegra/timer.h as it's just a single prototype
> already found in include/time.h.  And the example where time.h was
> included inside a comment block is a tooling issue.  But then looking at
> the printk.h patch I did just apply, I had to drop a few files because
> they introduced seemingly random changes to the resulting build on some
> platforms.

That is very strange. But I think with the Kconfig thing we
established that the build size can vary slightly for all sorts of
reasons, nothing to do with actual functional changes, particularly
with LTO. So as things standard, a build-size change isn't a good
signal.

>  And something like that is much easier to deal with and
> explain _why_ it's happening if we're removing the header file by file,
> rather than world-wide move-a-header.

With the Kconfig series I was unable to explain the minor 4-8 byte
changes, despite quite a bit of effort, as you know.

My suggestion is that we press ahead with the migration. If some
maintainers want to do clean-up afterwards, then that would be great.

Regards,
Simon
