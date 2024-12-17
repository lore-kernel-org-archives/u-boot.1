Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF8AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 20:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298ED801CE;
	Tue, 17 Dec 2024 21:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cx4/bH4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBEF801FB; Tue, 17 Dec 2024 21:17:59 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA1080107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 21:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so4931162b3a.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734466675; x=1735071475; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+hAxUNLxhmdbFeeyxWXo+Fl2a+towRx7I7f/Pq9iDo=;
 b=Cx4/bH4XtTBcRfzSighUK9mq3XmVpTSBXCcM1JHa4UMgiOy3NE4D7+E4b+KI+LBt5p
 KXFNtEITAGSaF54hbvnv2aizTWuxxYVq2udtutfJ0aKynjNG1n9ndfHG0mlUYSih2d/L
 qqSr6RZ3QcVpsGH8lL6o9V21QVn8hJ4l42W0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466675; x=1735071475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+hAxUNLxhmdbFeeyxWXo+Fl2a+towRx7I7f/Pq9iDo=;
 b=liS3MLyXIIaZgMU2LSgj+b+Q3R+xOPY6t1pzIpXAc/ln4SZqKgAJP52WfPM5P3jQD/
 7twko9dFm+LomWnKv96J59IT5tJJgaiu7QjJrLP5oZjyvC5xXyvprnMGrPFyvTdYwQvC
 SsQUns9g3+EZ8LFT9SlvBrezgqJI5VQqdMOq2XNSoDEt7QiQ2apfn4/FYNkADHNKMjSv
 HzddLh5KwB5KptrwsppYJLj+Ht+0rC6Fqferss+sv5l2JlrGgKhe/bUMVd77r1x01WE7
 yX6aUu3aii7qUkZSnuoDRhKx0BQKI9ALlOwaeKE3XVQidWFW25BBbE6VJamf+C99LdrK
 VVsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzib2ODYFJ9GRvKq84OmF+sGpKCOcE+cs9Uq+LTHXnlXspKBIUln9p6QESIqp9TONa7wHpynQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwquxNY2TPv+eourJjKHabCSPc7MwPEjmlUv6dgT48+jt/dyCwp
 6362RXeewpMrLUY4vm4u4IbKoydJSHl1LJ+pWoqEwbwe77L17q9wLpxQXNXiZ2K6jtoGKJ2fQc1
 h48hZ9toFTVhuxx+JhxanSPp7IN7hHapyyMEGmvTtry8Ik8A=
X-Gm-Gg: ASbGncvdbuaX+sMoat1NByQKWJYeEoGSn06MeAr96bRgJkgeQNq9VgiGac8hBbW7mJ/
 /tX4epKQXYvdxmh4zt1R8pybSxFuhfRKlYwcQZ9k=
X-Google-Smtp-Source: AGHT+IEwVC7UuQfwTmKW9C7hCsi0FDiEOXUvcyOwQBWghxGwbxCN5lL4uqG2lXrOY/IxFfDGRQ3ihyQ7L9rJybN+LL0=
X-Received: by 2002:a05:6a21:8dc4:b0:1db:9367:d018 with SMTP id
 adf61e73a8af0-1e5b482c0ebmr637904637.20.1734466675496; Tue, 17 Dec 2024
 12:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
In-Reply-To: <20241217195734.GR1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 13:17:42 -0700
Message-ID: <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 17 Dec 2024 at 12:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 12:46:17PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Dec 2024 at 07:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 08:00:56AM -0600, Simon Glass wrote:
> > >
> > > > While we do plan to switch to OF_SEPARATE now it is supported, it seems
> > > > worth at least showing how OF_EMBED could be used instead, just for the
> > > > record.
> > > >
> > > > So make the Makefile rule conditional on OF_SEPARATE and adjust fdtdec
> > > > to avoid a build error when OF_EMBED is used.
> > > >
> > > > Finally. the dtb symbol has a double underscore, so update it to avoid a
> > > > build warning.
> > > >
> > > > With future patches, OF_EMBED will no-longer be used with the EFI app,
> > > > so it is expected that it will eventually stop working.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app")
> > > > ---
> > > >
> > > >  Makefile                       | 2 +-
> > > >  include/asm-generic/sections.h | 2 +-
> > > >  lib/fdtdec.c                   | 2 +-
> > > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > Applied to sjg/master, thanks!
> > >
> > > Since you've picked up several series that no one was objecting to and
> > > providing reasonable feedback on and applied them to your own tree, do
> > > you plan to squash/rebase them and repost so they can be applied to
> > > master / next at some point?
> >
> > The original EFI-app series actually had objections in toto. Did you
> > not see the comments from Heinrich?
>
> I assume you mean:
> https://patchwork.ozlabs.org/project/uboot/patch/20241123195616.305687-2-mjg59@srcf.ucam.org/#3419029
> which is a question.

Apart from the general tone, it was mostly the cover letter.

>
> > I've offered to send pull requests every now and then, to keep things
> > in sync, if that is your goal? But I don't believe I can do that for
> > particular patches/series. It is going to be hard enough for me to
> > just maintain my own tree, let along dealing with your/Linaro tree.
>
> I find you calling the mainline project tree "your/Linaro tree"
> offensive. And I'm again asking you to explain in public what you are
> doing exactly.

I'm sorry you are offended. Please suggest a better name that I can
use. Honestly, from my point of view, it feels like a
Linaro-controlled tree. There's nothing particularly wrong with that,
but I would like the freedom to continue to innovate U-Boot, without
Linaro telling me what to do. Does that sound OK to you?

Regards,
Simon
