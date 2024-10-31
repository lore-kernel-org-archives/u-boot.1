Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393E1D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36C388E18;
	Thu, 31 Oct 2024 19:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lB/qLjsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61BF892A2; Thu, 31 Oct 2024 19:04:30 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601E088B8F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2a999b287so1040097a91.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397867; x=1731002667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1pxtFTXyr+bZYMyhIFw7hCN7R5L0OtFWsGxafnPTQ8Y=;
 b=lB/qLjsMUvx41mxXh8AgDEtLwY4ZPfXx48usHMnIZtRXjRy03FQ/ODeu1DSRFtuJNs
 Pa3X/o+xlZXcchSIN2H2aNO/KiejDoaO5ieqS20lsT/r3WmAJDwiHsz+zqL8pfRMSq10
 xXH2pnf+rX6z6v/AUNvnX2LVoia2NgblJlOXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397867; x=1731002667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pxtFTXyr+bZYMyhIFw7hCN7R5L0OtFWsGxafnPTQ8Y=;
 b=vbOGCSttjkS7Imqo1UHJILkmDhsIkbs6s5BoUpN3rqp9JGbJQdZc6eMrdhruuu4R8f
 ST/WjzuDX39LMk2m9nocRBZbo0spIznj9SI8NzjE2C4ITCivW+mpY3oAvgzrrnz9ViVK
 IDPZkEjvNaJqwYKDezIYhk8OtMkEOanx8ag7NUX6mOYouvcU1xjo+YFVby/rVovBa1Yn
 I84/0idplcH17VAms9DOLpMra1Q3dcAlRPHIaxvN0Dks4cXmJR40JjRXBoWEZFqN07Ge
 TnfaXjKbDvjZdCP3SLQ1A616GenpDbivdthWXX8acVmlRK5x7mLrAGY1ZZ/otahGLhyj
 7mDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv9m6orJDNrH5//uCRAaGKXSS3PuTp4+QxF1XwzkJK13Vn9CQLeUQQmxbhSq4Tj+ClI4d1g4c=@lists.denx.de
X-Gm-Message-State: AOJu0YwXynZOKtSTJqhPsnvic8Ltb4QRod9CnGn6fflg2R9/yAC/cSRw
 sG7iRZim+EcKYVDfV2xednd//86alNDNRq6UTa3qTh4EWj7LTs65bE1q/dcB2RKDAxkyi7BUvb+
 x7pAzf4UnJBiP1w9oaBry7LGe4meZnjOZ7VSB
X-Google-Smtp-Source: AGHT+IE+bGO36c634uqBZXu5iUZd1QWFiVST8tkX7eRXkipem1F9YOmeg1GuacM3lTtlq3qaW9qDvl7X4h4NUCbVh/E=
X-Received: by 2002:a17:90b:17c2:b0:2d8:a744:a820 with SMTP id
 98e67ed59e1d1-2e93c2fd8b3mr5307121a91.36.1730397866906; Thu, 31 Oct 2024
 11:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
 <20241018180439.GD4959@bill-the-cat>
 <CAFLszTjEvoPLiq5iuCRk8q3iA50q-UHGF4GBJJeNNWwqMXD_aw@mail.gmail.com>
 <20241018213022.GL4959@bill-the-cat>
 <CAFLszTg0=9kvMRG_=S19W5o5Y5ugdXT-chEb=5wZ+jFK0CtQwQ@mail.gmail.com>
 <20241019163025.GU4959@bill-the-cat>
 <CAFLszTjAYhGGF+dm+egcw_yixo-akmKZUNb5EWnegD0dgETeWg@mail.gmail.com>
 <20241022150125.GF4959@bill-the-cat>
 <CAFLszTjnEzUDFRBXvySiMD0bROV5JdFrNt16Q5_BHUFHyBz5Vg@mail.gmail.com>
 <20241023184130.GM4959@bill-the-cat>
In-Reply-To: <20241023184130.GM4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:04:11 +0100
Message-ID: <CAFLszTgn3n9Rty-Yw1fAqmewxunN7gcXUX7UDB-GpEs+DuNN2A@mail.gmail.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
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

On Wed, 23 Oct 2024 at 20:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 07:00:44PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 22 Oct 2024 at 17:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 22, 2024 at 02:16:52PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 19 Oct 2024 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Oct 19, 2024 at 05:49:40AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 18 Oct 2024 at 15:30, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 18, 2024 at 12:48:31PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > > > > > > > > > >We want to keep track of images which are loaded, or those which could
> > > > > > > > > > > > > >perhaps be loaded. This will make it easier to manage memory allocation,
> > > > > > > > > > > > > >as well as permit removal of the EFI set_efi_bootdev() hack.
> > > > > > > > > > > >
> > > > > > > > > > > > I'll change this 'hack' to 'feature'.
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Please, keep in mind that files can be loaded manually, e.g. via the dhcp, the wget, and the loady commands. These are outside bootflows.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, this series is only going to help if bootstd is used. For ad-hoc
> > > > > > > > > > > > use, EFI will need to rely on the above feature, at least until
> > > > > > > > > > > > someone can think of another solution.
> > > > > > > > > > >
> > > > > > > > > > > Perhaps I need to try and be clearer here than I might have been in the
> > > > > > > > > > > past. The consensus among off the shelf free software operating systems
> > > > > > > > > > > is "just give me an EFI interface". This simplifies things on their end
> > > > > > > > > > > if regardless of architecture it's the same interface. This means that
> > > > > > > > > > > in U-Boot we need to treat EFI as one of the primary interfaces. Not a
> > > > > > > > > > > novelty. Not a "some people might use". It is a frequent and commonly
> > > > > > > > > > > used feature.
> > > > > > > > > >
> > > > > > > > > > Yes, EFI is everywhere and growing. All the more reason to tidy up
> > > > > > > > > > this piece. I would like to see bootmgr use this new API, for example.
> > > > > > > > > >
> > > > > > > > > > But how does this comment affect this patch?
> > > > > > > > >
> > > > > > > > > Because at the very high level, I wonder if I made a mistake a few years
> > > > > > > > > back. As I understand it, the nominal case is "bootefi bootmgr". I was
> > > > > > > > > saying at the time that perhaps bootstd can just fire that off, and move
> > > > > > > > > on. Now it seems like we're going along the path of re-inventing that,
> > > > > > > > > and not integrating well with it either.
> > > > > > > >
> > > > > > > > In what way are we re-inventing that? bootstd supports lots of
> > > > > > > > different ways of booting, not just EFI.
> > > > > > >
> > > > > > > At the high level, bootflow scan is re-implementing "bootefi bootmgr".
> > > > > > > but handling non-EFI payloads.
> > > > > >
> > > > > > bootstd is about replacing the distro scripts, not bootmgr.
> > > > >
> > > > > And the distro scripts are functionally replaced by "bootefi bootmgr",
> > > > > outside of bootstd.
> > > >
> > > > But that doesn't support anything other than EFI apps, so isn't useful
> > > > for when EFI is not wanted.
> > >
> > > Yes, the distro scripts wanted to move more firmly / quickly in this
> > > direction. For all of the reasons they've elaborated before.
> >
> > OK, well good luck to them, I suppose.
> >
> > >
> > > > > > > > Also I hope that one day EFI
> > > > > > > > will be implemented more as part of U-Boot than as a bolt-on, so will
> > > > > > > > make use of bootflows, etc.
> > > > > > >
> > > > > > > And stuff like that is why I said what I said in here first. To me it
> > > > > > > sounds like you keep implying it's a hack that's not well integrated.
> > > > > > > When it's honestly at this point gotten more traction than FIT images
> > > > > > > have I think (as much as I wish FIT images had "won", it's like VHS vs
> > > > > > > Betamax, to bring in another technology metaphor).
> > > > > >
> > > > > > The 'hack' I was referring to is efi_set_bootdev(), not EFI_LOADER as a whole!
> > > > >
> > > > > I wasn't clear enough, sorry. I didn't mean just in this series where
> > > > > you referred to storing the needed property as a hack but rather
> > > > > "bolt-on" in what I quoted and "tidy up this" and "tidy up that". I'm
> > > > > just saying what impression your words leave with me, and quite possibly
> > > > > others.
> > > >
> > > > OK I will try to be more gentle with my language.
> > >
> > > Thanks.
> > >
> > > > > > > > > So, to try and bring things back together. If U-Boot decides to load
> > > > > > > > > $FOO from device $BAR, at that common point is where we need to:
> > > > > > > > > - Is there an lmb for the location this is supposed to go to (for the if
> > > > > > > > >   we know it, entire size)?
> > > > > > > > > - Note down everything else we know, now.
> > > > > > > >
> > > > > > > > Yes.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > This means that we can note down enough stuff so that EFI can construct
> > > > > > > > > the path it needs. And if we're being told a filesystem, that filename
> > > > > > > > > is good enough for the IH_TYPE thing you're wanting, or at least a good
> > > > > > > > > chunk of it I hope.
> > > > > > > >
> > > > > > > > You want me to ignore the type that I know (kernel, ramdisk, logo,
> > > > > > > > etc.) and infer the type from a filename? Why?
> > > > > > >
> > > > > > > No, I want you to save and display the filename. That's probably much
> > > > > > > more useful when debugging than "kernel". If you actually know some
> > > > > > > other type information (ie extlinux.conf says ...) then yes, it too can
> > > > > > > be stored as that's useful too.
> > > > > >
> > > > > > The filename is already saved in bootflow->filename, and now it is in
> > > > > > struct bootflow_img.
> > > > >
> > > > > OK. But that's not generic enough.
> > > >
> > > > How about we see how things work out here rather than giving up at the
> > > > start? It is pretty clear in my head, so far.
> > >
> > > I'd really rather not since it looks like it's starting in the wrong
> > > direction. I really do not understand why when we load the file / do the
> > > network request / read the flash area / etc is the wrong place to start
> > > recording the information about what we load.
> >
> > It isn't that it is the wrong place, it's just that we know more when
> > a bootmeth is in place. Are you thinking about the distro scripts or
> > people's custom scripts, or something else?
> [snip]
> > > Yes, perhaps some series that shows what works / doesn't work and how it
> > > works would be helpful. I'd really like to see where you're starting
> > > your abstractions from.
> >
> > OK I'll send a version with an add-on patch for the 'load' command,
> > with the concept of an ad-hoc bootflow.
>
> I want to combine these two (and I hope not drop any important context),
> to reply. A challenge is that for EFI, we need to know where we loaded
> something from. You hope that EFI_LOADER will make use of bootmeths at
> some future point, but that's not on your TODO list? What I'm saying is
> that in for example fs_read(), we have the common point between
> bootmeth, EFI_LOADER and "load" and already need to be doing sanity
> checks and can record what information we have now. Can bootmeth add to
> it? Sure. But I still don't see why this is the wrong place to start.
> And there are analogous points for network, flash, etc.

There is already a bootmeth_efi which uses EFI_LOADER

But the point here is something different. I am not suggesting use of
a bootmeth, but use of a bootflow. My idea is to use an ad-hoc
bootflow which collects things not attached to an existing bootflow.
I'll get some time to send the series again, with a few more patches
at the end, to show the approach. But this series is the bones of it.

Regards,
Simon
