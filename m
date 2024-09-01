Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B1ACD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E389889AE;
	Sun,  1 Sep 2024 22:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SVtfVv1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A316587DEA; Sun,  1 Sep 2024 22:09:53 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8248888675
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf8a662467so18835726d6.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221390; x=1725826190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OzFl/nYD3DK4ZD/xwETm+Te69rbGKDwdqs40sdmKYew=;
 b=SVtfVv1KPFPsAVt6C/gHS1H2/3vV/dGRqoIxwfSz1Gn8H4aoboHmSTrs7/ezBYkLjv
 rYEVAhAbJeAfeWIwaI5Fsuk0jSI0gJ9xjAG5qpSK6AU4YQx1rAO74Hm3ptmtoiXIQKrp
 13SBIwHgzZ3owF9BwQOqvIA8t71ofXTNrcpeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221390; x=1725826190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OzFl/nYD3DK4ZD/xwETm+Te69rbGKDwdqs40sdmKYew=;
 b=llXAd64FBaWJfEDRUbWrt1PWSlXM2SE+YTHAMb6Bu+rnpGYqmpSqwMQTzo/TXR4Bsh
 sXfovWBoaDCbrfuBX3Oqdw8BAfFwmWcMzQ6TzvK7yOAcvDYOaOprSBWF+dgSsUSZ6baY
 P7E5AgCEx3wARSmyXctlU6S3XtDP0ATQyyMg1KE2Z888LuJ22BTQr54ae+IKvEBh7Hfz
 xKE8TsMwSGFjUgISroUw2fAt1P6YEwzKbBBVhrvgqWVeCmhCP2TFrsesR1SptiR9OZ0o
 ApdJaKS49o9zQLHooNIBUJvY9/ETw4syzJd3hOe0gzcZDwaifhJER7/JZXUUF5aYVD5t
 EEiw==
X-Gm-Message-State: AOJu0YzJRDL36WRL3LMJmiXmDTDbKpZCe1eUBy/f3yPPlpUCoV5oZutN
 Rg0mBuqR/OX883QX+ZZ1IhvEv+YpgVVcPTs8lkSCv8nX+Xx/bOdmAn2ONofwecxc1G+sZATxUA7
 3Iovm4wrYpj/xc0j33Qgad0fP8UbiNkPTgeiE
X-Google-Smtp-Source: AGHT+IH9UqMmzAOnMPDfUidu2b6GbWMAYmaxMQjnkmx8JKTeGZFC2aWoU4KJ3vk+LHGvJa9+wy4RShJ8MlbMWo/cBoI=
X-Received: by 2002:a05:6214:318e:b0:6c3:4c75:f0fe with SMTP id
 6a1803df08f44-6c3554a6dd4mr48795486d6.47.1725221390370; Sun, 01 Sep 2024
 13:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
In-Reply-To: <20240822141013.GQ1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:39 -0600
Message-ID: <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
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

On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > > >
> > > > > For most boards, the device-tree compiler is built in-tree, ignoring the
> > > > > system version. Add a special option to skip this build. This can be
> > > > > useful when the system dtc is up-to-date, as it speeds up the build.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > >  tools/buildman/control.py       |  3 ++-
> > > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
> > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > >
> > > > We should probably do this more generically, outside of buildman. We
> > > > have scripts/dtc-version.sh and if the system version isn't new enough
> > > > (and we just need to define whatever the minimum version is), then we
> > > > build our (not currently that new anymore) dtc instead.
> > >
> > > Yes I think I did a patch for that ages ago [1], but it was rejected.
> > >
> > > I'd be very happy for it to be applied as I think it is a better
> > > solution than this one.
> > >
> > > I see that some poor sod tried to do this in Linux this morning.
> >
> > Any thoughts on that patch?
>
> I'm open to re-considering [1] again, but we need to handle the warning
> problem first. That means...
>
> > Also I do see one problem. Newer dtc version produce a lot of
> > warnings, which causes CI to fail. So if we always use the newest
> > version, people are going to see a ton of warnings when they run
> > locally. Am I missing something here?
>
> Well, it would be great to get our Kbuild logic anywhere close to
> in-sync again with upstream. But syncing up the disabling warning flags
> shouldn't be too hard.

So, coming back to this patch, the nice thing about it is that it is
deterministic. So people who build U-Boot and don't want funky
behaviour will be happy. It will use the internal dtc by default. To
use the external one, you must provide an option.

This patch only affects buildman, but as you can see the mechanism it
uses is to set the DTC variable, which people can do without buildman.
It's just a convenience, but useful enough to have a flag, I believe.

Regards,
Simon
