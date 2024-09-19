Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C77DCF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A10A089248;
	Thu, 19 Sep 2024 16:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZNfOzQqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC22489248; Thu, 19 Sep 2024 16:13:26 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E3F8921D
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso594241b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755202; x=1727360002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TtXMUcEYAYqd9swFPL8SCfCRbml91zhkaxsNCodotN0=;
 b=ZNfOzQqUkku9cu72UcyEOQbq65GVBcOYEdcSMSZn0WxsRh7nB61rMsxGPPa2N+1+Ym
 tTjIaNsAHHNGP8R71DfUVTpQu+rIrYloQqEFtjtLnT97NJDvLQhpZ9cpWrsV5i0UYZBx
 zB9z7dDGSa0FcCOp19iV33Lqby9/hPfVYY64U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755202; x=1727360002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TtXMUcEYAYqd9swFPL8SCfCRbml91zhkaxsNCodotN0=;
 b=UreXRrGYn2rNAdURyGPy0le0xi1Iu6d2iXfSd8h8BKHVaFLINmCxA/y3GWWHhXHi3w
 srpZUNUBOwXxyo201CK7r1SNBicwmjPnZHP71Q5GT79Mo69z88tsQRDvBqlwaWUqN6yT
 FJ4pdagFrR9EW0vIiKH6IwD3zV9Z1QcQbYHK/T9OtWABTssCDs0HFYHm4TwsX5vy3z2v
 2yIUahFRy1ha9pU3wibc9nutHm4rLHp5Mvb1R03OiNiDrkHlL5rB1apuA0FWy3aG99Zc
 159m4yez2HMLviA8bcv7KSGHEy5If3NhfUr+atPAqXSg3HhkRFSKO6czR8E0waFd7F3z
 O9/A==
X-Gm-Message-State: AOJu0YwqlG1gAcRe3wO3jAXvrK3sRM5nXcKKY2RlWe3DbxWzft2+OcpS
 GFQotyP87tvY5i9KzPR/onYk1ObpxE6KZBDUgvSJfN5eeI8ScVb45/4oki8Mgum4/GNIAw/aEaR
 1BALiLL52rZNiFwe1pgd7rLqlW+pA/PSIUsqg
X-Google-Smtp-Source: AGHT+IG5pjfjoT2jmEz5Bn1H8Wuj3Z/QEvcLJFyEAqNh4NdxlKqUel2gUbyX6yXemi9ksDEephk6NZYYvvYAAjFIORk=
X-Received: by 2002:a05:6a00:8610:b0:712:7195:265d with SMTP id
 d2e1a72fcca58-7198e148eb0mr3684077b3a.0.1726755202453; Thu, 19 Sep 2024
 07:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240822141013.GQ1626301@bill-the-cat>
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
In-Reply-To: <20240912174448.GS4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:07 +0200
Message-ID: <CAFLszThz=vvpnz+mwzFmiUm+SgjsdwrTAbOceyDWRbFY-zL3aw@mail.gmail.com>
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
