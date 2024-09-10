Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2030EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850F0890E6;
	Tue, 10 Sep 2024 20:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ohf2jaZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7375D890E6; Tue, 10 Sep 2024 20:45:54 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DF088CE7
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-846b934981aso1547313241.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993950; x=1726598750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PA6j3oQ6oVG76BBqECu/QHnlFbg42aQgRgV9b4Jx220=;
 b=ohf2jaZmOF2SO1rIi7zxxE4QgDu5TXaXhvFolb2hTPW/WoVCb3RVt8M67wYjJHNeuA
 YbRr7Q2Gfdfq/tXse/SatgLkjfLmQWNUwa5zIGEOnpZ8Z8gvH026FjGjQ5aTQAX8G6xF
 Uc629NpsEhlPNsJ24fR2nDTrVJn49Yoy5VibM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993950; x=1726598750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PA6j3oQ6oVG76BBqECu/QHnlFbg42aQgRgV9b4Jx220=;
 b=huxzcSwAgTfOGRZgIQx9yf1KbwWtfKDqYr2OHzhBwGrn0NHLjGx1dF5XkhqwM0V9q3
 xvwBndwOlWyJTcaBllFHlGF0iOylLPbrsBTvDyipyTU3ls8A717EezNlA4eh2hKx05nL
 0TLOkqpbX7YmpXd4AsCARaxEcbyN4NzlS7ERYyVngXXHnnBnmvGZeLJwhc88jaC+WtqD
 XWoXQY14qz0uhy/6WPdiKvZs7uH64ECs+VKgWDdUt9evP4WHbWWWzIe5e5ziqLLps78M
 8X2zSYEqd907qhftlPn7HD604nJ7S6AtFG121PcKsqYGqwV/orfJ+N9XNRpm9Q0j0Qer
 B3vA==
X-Gm-Message-State: AOJu0YxxEWUJ0faY7tZyfkpIcUb26QrAs5hz8ilJcFI7NASPzkuqtx8q
 rBmpf+H9/py1XDlZH2cJqbN1ftQuYG3MPsmN+I8IKh9kmSj/Gcqp6EqrcT6PddDXbree76hF+15
 +nqav2PQP9ISQ5rAYrig8GVaCtLwahR0yhAm9
X-Google-Smtp-Source: AGHT+IE0MZOsDdyH0Cjy5ZsAI5lrW58Qs2YIw3K48/4IIH3vnWtUIIf5xf0XnUW8PKEai2fioxMXN8UPpBYAAivTP18=
X-Received: by 2002:a05:6102:2ac9:b0:492:aded:1914 with SMTP id
 ada2fe7eead31-49bde194993mr17843193137.10.1725993949851; Tue, 10 Sep 2024
 11:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
 <20240902153904.GX2479150@bill-the-cat>
 <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
 <20240910184242.GL4252@bill-the-cat>
In-Reply-To: <20240910184242.GL4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:45:39 -0600
Message-ID: <CAFLszTjfU8m-dQyXXAHJ0FWGfAMdvF3yYDMOofN87qocY0mRyg@mail.gmail.com>
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

On Tue, 10 Sept 2024 at 12:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 10, 2024 at 12:41:11PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Sept 2024 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > For most boards, the device-tree compiler is built in-tree, ignoring the
> > > > > > > > > system version. Add a special option to skip this build. This can be
> > > > > > > > > useful when the system dtc is up-to-date, as it speeds up the build.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> > > > > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > > > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
> > > > > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > We should probably do this more generically, outside of buildman. We
> > > > > > > > have scripts/dtc-version.sh and if the system version isn't new enough
> > > > > > > > (and we just need to define whatever the minimum version is), then we
> > > > > > > > build our (not currently that new anymore) dtc instead.
> > > > > > >
> > > > > > > Yes I think I did a patch for that ages ago [1], but it was rejected.
> > > > > > >
> > > > > > > I'd be very happy for it to be applied as I think it is a better
> > > > > > > solution than this one.
> > > > > > >
> > > > > > > I see that some poor sod tried to do this in Linux this morning.
> > > > > >
> > > > > > Any thoughts on that patch?
> > > > >
> > > > > I'm open to re-considering [1] again, but we need to handle the warning
> > > > > problem first. That means...
> > > > >
> > > > > > Also I do see one problem. Newer dtc version produce a lot of
> > > > > > warnings, which causes CI to fail. So if we always use the newest
> > > > > > version, people are going to see a ton of warnings when they run
> > > > > > locally. Am I missing something here?
> > > > >
> > > > > Well, it would be great to get our Kbuild logic anywhere close to
> > > > > in-sync again with upstream. But syncing up the disabling warning flags
> > > > > shouldn't be too hard.
> > > >
> > > > So, coming back to this patch, the nice thing about it is that it is
> > > > deterministic. So people who build U-Boot and don't want funky
> > > > behaviour will be happy. It will use the internal dtc by default. To
> > > > use the external one, you must provide an option.
> > > >
> > > > This patch only affects buildman, but as you can see the mechanism it
> > > > uses is to set the DTC variable, which people can do without buildman.
> > > > It's just a convenience, but useful enough to have a flag, I believe.
> > >
> > > Wait, that's right, we have DTC as a thing that can be set in the
> > > environment, so why do we need something for buildman at all?
> >
> > It's a convenience. I have found that it speeds things up quite a bit,
> > so I want to enable it most of the time. But we can't do it by default
> > and need it to be optional, I believe.
>
> I wasn't clear, sorry. Why is:
> $ export DTC=/usr/local/bin/dtc
> $ tools/buildman/buildman ...
>
> Enough?

My patch is more equivalent to:

DTC=`which dtc` buildman...

As I said it is a convenience which I want to use all the time,
including in CI. Are you worried about changing buildman? What is the
issue here?

Regards,
Simon
