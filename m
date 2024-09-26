Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760B9CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AAE88FAC;
	Fri, 27 Sep 2024 00:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O/iD1JPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A4388F33; Fri, 27 Sep 2024 00:07:48 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FCB88F46
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1085768a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388461; x=1727993261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ck+qkrz5YYNskXZyqW6b6zgn8OAQWsIiLYJA4iw9S8=;
 b=O/iD1JPCf0f4fX2dyfneQY4kpMR4428pWQ6KIdcjq5zGy1Yu6tDnPAm6AG0pHfq5/j
 u1camOUCQqIb/A8TOUMYnVqm4oZ2wDDsKSoKO1D+7p+zAxSBqgCUfvNXpnI+KZ8FuX39
 tMK9XviBXa7v1jlEV46trxuC/MtBK/3F+MMvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388461; x=1727993261;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ck+qkrz5YYNskXZyqW6b6zgn8OAQWsIiLYJA4iw9S8=;
 b=bGqQYb3qD2nXB9ZVvSspox1stzVw2AXAWOnu9SkDwSsemDF4+lgqDZaeKKMktDUQAe
 2LHH2fBlUKRERyYWLwCev9Z6pyv7QWcue1pnBNlePn4MgNPPFxhNkkaW13ffy2iCjTD7
 KetZp3Gf0jFmUPiceSgpcczEUJ2nKyby6+UnD/1O+FHQJOW/x6wKBy6mL1UmzBNa92T8
 ESJ5t2Ijg0cqAQs+wrLk8J4o8VHlWkCUwNzWA58NkvHqVgiv8E/aPScfx8EGaE2FH/W1
 +vMe7+I1HgrlnFrbIQlRL8shNFqFBju0dWP49K0iCwVjg+B05ApiVZqLoIcXF6n5ZPea
 c1Rg==
X-Gm-Message-State: AOJu0YzeG5ratWnVFXSqcDyD7ByjKiqTKSTeQaLUFbiwdkEY/6bWQwlO
 wxYkV2RDcDvY67ml1LeWqgNFkPPkRGjO2PgbPIke6HDillUK85H/OhC5AAv9lNVbmGzf8VuxmxO
 oLndxz3W5ohq2aI+vqMBLSrEfJooCfAamwQLf
X-Google-Smtp-Source: AGHT+IHoIbnAmYQ7UKBgkV/cI9GYnw0J42C4EEHfoIA9P1/Ineg3I3p1udw69sIHGpsk/YtV+FT3JhHisyzVXco/8YE=
X-Received: by 2002:a17:90a:5e47:b0:2e0:9d84:e2b2 with SMTP id
 98e67ed59e1d1-2e0b8ed4bdcmr1142676a91.38.1727388461143; Thu, 26 Sep 2024
 15:07:41 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThz=vvpnz+mwzFmiUm+SgjsdwrTAbOceyDWRbFY-zL3aw@mail.gmail.com>
References: <CAFLszThz=vvpnz+mwzFmiUm+SgjsdwrTAbOceyDWRbFY-zL3aw@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
 <20240902153904.GX2479150@bill-the-cat>
 <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
 <20240910184242.GL4252@bill-the-cat>
 <CAFLszTjfU8m-dQyXXAHJ0FWGfAMdvF3yYDMOofN87qocY0mRyg@mail.gmail.com>
 <20240910185237.GM4252@bill-the-cat>
 <CAFLszTgNPmHD7t4k1BkB_eSVZz7ZgP9=vuoPykm2ZGV0PQxg3g@mail.gmail.com>
 <20240910220708.GN4252@bill-the-cat>
 <CAFLszTj_TEO6K+SU76FHwxsk6awKTXkZ2hS1yJiB5wGA7LMm-A@mail.gmail.com>
 <20240912174448.GS4252@bill-the-cat>
Date: Thu, 26 Sep 2024 15:07:39 -0700
X-Google-Sender-Auth: p8jQPzWaeVmbQ82cohF8fDUhKhY
Message-ID: <CAFLszTh2x+fNc+T4nDOwZ2NnBu6+tpaxWBQZcJ+zQUJtz4RdxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 12 Sept 2024 at 19:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 11, 2024 at 07:01:37PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 10 Sept 2024 at 16:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Sep 10, 2024 at 02:14:35PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 10 Sept 2024 at 12:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Sep 10, 2024 at 12:45:39PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 10 Sept 2024 at 12:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 10, 2024 at 12:41:11PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 2 Sept 2024 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > For most boards, the device-tree compiler is built in-tree, ignoring the
> > > > > > > > > > > > > > > system version. Add a special option to skip this build. This can be
> > > > > > > > > > > > > > > useful when the system dtc is up-to-date, as it speeds up the build.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> > > > > > > > > > > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > > > > > > > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > > > > > > > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > > > > > > > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > > > > > > > > > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
> > > > > > > > > > > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > We should probably do this more generically, outside of buildman. We
> > > > > > > > > > > > > > have scripts/dtc-version.sh and if the system version isn't new enough
> > > > > > > > > > > > > > (and we just need to define whatever the minimum version is), then we
> > > > > > > > > > > > > > build our (not currently that new anymore) dtc instead.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes I think I did a patch for that ages ago [1], but it was rejected.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'd be very happy for it to be applied as I think it is a better
> > > > > > > > > > > > > solution than this one.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I see that some poor sod tried to do this in Linux this morning.
> > > > > > > > > > > >
> > > > > > > > > > > > Any thoughts on that patch?
> > > > > > > > > > >
> > > > > > > > > > > I'm open to re-considering [1] again, but we need to handle the warning
> > > > > > > > > > > problem first. That means...
> > > > > > > > > > >
> > > > > > > > > > > > Also I do see one problem. Newer dtc version produce a lot of
> > > > > > > > > > > > warnings, which causes CI to fail. So if we always use the newest
> > > > > > > > > > > > version, people are going to see a ton of warnings when they run
> > > > > > > > > > > > locally. Am I missing something here?
> > > > > > > > > > >
> > > > > > > > > > > Well, it would be great to get our Kbuild logic anywhere close to
> > > > > > > > > > > in-sync again with upstream. But syncing up the disabling warning flags
> > > > > > > > > > > shouldn't be too hard.
> > > > > > > > > >
> > > > > > > > > > So, coming back to this patch, the nice thing about it is that it is
> > > > > > > > > > deterministic. So people who build U-Boot and don't want funky
> > > > > > > > > > behaviour will be happy. It will use the internal dtc by default. To
> > > > > > > > > > use the external one, you must provide an option.
> > > > > > > > > >
> > > > > > > > > > This patch only affects buildman, but as you can see the mechanism it
> > > > > > > > > > uses is to set the DTC variable, which people can do without buildman.
> > > > > > > > > > It's just a convenience, but useful enough to have a flag, I believe.
> > > > > > > > >
> > > > > > > > > Wait, that's right, we have DTC as a thing that can be set in the
> > > > > > > > > environment, so why do we need something for buildman at all?
> > > > > > > >
> > > > > > > > It's a convenience. I have found that it speeds things up quite a bit,
> > > > > > > > so I want to enable it most of the time. But we can't do it by default
> > > > > > > > and need it to be optional, I believe.
> > > > > > >
> > > > > > > I wasn't clear, sorry. Why is:
> > > > > > > $ export DTC=/usr/local/bin/dtc
> > > > > > > $ tools/buildman/buildman ...
> > > > > > >
> > > > > > > Enough?
> > > > > >
> > > > > > My patch is more equivalent to:
> > > > > >
> > > > > > DTC=`which dtc` buildman...
> > > > > >
> > > > > > As I said it is a convenience which I want to use all the time,
> > > > > > including in CI. Are you worried about changing buildman? What is the
> > > > > > issue here?
> > > > >
> > > > > My question / concern is why do we need:
> > > > >
> > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > >
> > > > > When we can do it with zero code changes?
> > > >
> > > > We don't need anything here...but this helps with my productivity as
> > > > and can add this flag easily when doing large builds.
> > > >
> > > > Note that half of those lines are a test and another half are just
> > > > plumbing it through all the layers. Any new flag will end up with
> > > > this, even if it is a few lines of 'real' code.
> > > >
> > > > > And then similar to the
> > > > > worries I set aside with the "venv" related changes,
> > > >
> > > > That change does fix a bug. Without the change, we cannot run code
> > > > coverage in CI, which I very-much want to turn on once Marek can
> > > > figure out the missing Binman tests.
> > > >
> > > > > you're making one
> > > > > tool be clever and work as exactly as expected (but perhaps in a "do
> > > > > what I meant, not what I said" manner?) way.
> > > >
> > > > The only magic is that it locates dtc on the path, but that is the
> > > > thing that I find valuable.
> > > >
> > > > > If we have "set DTC in
> > > > > environment, it's always obeyed, can be passed directly to make" but
> > > > > also "pass buildman a flag to say where dtc is" why do we need the
> > > > > latter if it should already be working, and I think already is working?
> > > >
> > > > The flag doesn't tell buildman where dtc is, though. It tells buildman
> > > > to hunt for it and use that in preference to the internal build. I am
> > > > not suggesting adding anything non-deterministics.
> > > >
> > > > A general point here...buildman is pretty stable but it is not perfect
> > > > and we continue to tweak it to help make it a better tool. When it is
> > > > perfect, I will certainly stop sending patches for it. I normally only
> > > > send a patch when a bug is reported or something annoys me. The dtc
> > > > thing annoys me *a lot* because it chews up ~20% of my CPU for no
> > > > purpose. I had not realised how bad this problem was.
> > >
> > > Thanks for explaining. Whenever you want to pick this one up, go ahead
> > > and send it along then. And I guess at some point we should look at (a)
> > > re-syncing our libfdt code and (b) switching to using system dtc by
> > > default?
> >
> > OK thank you. Perhaps we should file an issue for that? I am trying to
> > do one issue a week, although I have failed the last few weeks.
>
> Can't hurt, yeah.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/24
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/25

Regards,
Simon

Applied to u-boot-dm/next, thanks!
