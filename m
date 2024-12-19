Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C09BE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 11:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D868021D;
	Thu, 19 Dec 2024 12:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XPTi441x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFEA8022B; Thu, 19 Dec 2024 12:46:42 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B157801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 12:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa69107179cso113668266b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734608800; x=1735213600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ddVBLLj5KpcoQs0MM0dgZ+GTiEZW0pHqzvttGfEYowo=;
 b=XPTi441xUXaU4I9NaERfZUm932c23aGPe6WuC4tYP9fU7/WE9R82r1JfLX9Vm8Yl69
 tVR/HCmA041PxnZXzEzRyH3DNFvC6jIjAOh6aOpZlE7/8tln2WqPF6IpiB1YZyTLx5h6
 2J1lCGDyd3uPugXp1ZZjPxpW0po5HSx2x1m3ZSPuN70taFhdfzmOVdQCNwkThy8RB6zG
 uYyAAIg4xEs60hnJuaYzUIHLL+xGKpg7lXKDyX/ngTBfIeBNLcA1NHs7I/4K03X9AOxH
 NMi1h6uUjmalRybMCPDx4Z1qpulDN1vJQs54oYggR5Ee+lRByOrx1uyDLivL9TFKWYcu
 a1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734608800; x=1735213600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ddVBLLj5KpcoQs0MM0dgZ+GTiEZW0pHqzvttGfEYowo=;
 b=CyCAR/Bw9xpIcSRENK4vpRbqQ8DUrnsf41ISyECXnYC1Y2Or82mstFSOTEhe5Bsl0j
 k8IyWbh5c9maaZZlEGjz4AGlOsCz8pVvweva976blZHlL3N7xNb0sG7VK8FSve3gvfX1
 Lx5xmY3AeDDQbEFVX4DPbQCRp2W7miaaoKhpeWamf6wvDfYbxsmWeoL+PU8uHRDiRSFP
 SILzSZaO9mF/07pcc0NipcoWwrMVzdC8XQylmE7QJnm/tV7/pmQ2i4iLCAn5A9kRiW2x
 lzaHzIAFThP4ZgGVIqjwZLQMKILUM4XIdf4RWfIsAxWsmtg5yHz+TD0jkSRFO45Y1a4N
 AZVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTdRbdPE+pOs+2/+kAfFWi/KlGJHjrpmiXUX8gedOzIR7i9iZX8qLuWSJUte82AKXb2baR4ZM=@lists.denx.de
X-Gm-Message-State: AOJu0YwCeXJY6dLU5edl1euYtiDkC8j/EsrDyOjsVRXpRRGKNlljJlcB
 yFIO5rH1b2el0SHEd1xA+Fj4q9ijZ0eTeHStIU3FiCAZ3Pzq5gE52G0s9x5auPNampFrhUpEYk7
 gIm+MuWDC1WUco341aYil2oahsbE=
X-Gm-Gg: ASbGnctCO25g6jOLL2+tYBGRVbFdgcKZoc+zEafa4baoingGcN3V1w6VEkqtulBSjbL
 IfuAMVfhb2/tTKdoBsbQAU1SbKiZPAwxF6yOm7Q==
X-Google-Smtp-Source: AGHT+IGKgdUk0iuYx3qV3F65GVps6OMydiUhiorNgrXxWnTgU4gRFj0LogbqyM0WUZnldSGB0k3+78eh+NRSH+oclCk=
X-Received: by 2002:a17:906:3296:b0:aa6:92de:ddae with SMTP id
 a640c23a62f3a-aac078faf05mr267233966b.16.1734608798990; Thu, 19 Dec 2024
 03:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
 <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
 <20241217202900.GT1505244@bill-the-cat>
In-Reply-To: <20241217202900.GT1505244@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 19 Dec 2024 11:46:27 +0000
Message-ID: <CALeDE9PaDtmthbtw3HSoyNb+3vZS9rb1-BwfnEX=2xt_hxA9-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 17 Dec 2024 at 20:29, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Dec 17, 2024 at 01:17:42PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Dec 2024 at 12:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 12:46:17PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 17 Dec 2024 at 07:25, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Dec 17, 2024 at 08:00:56AM -0600, Simon Glass wrote:
> > > > >
> > > > > > While we do plan to switch to OF_SEPARATE now it is supported,
> it seems
> > > > > > worth at least showing how OF_EMBED could be used instead, just
> for the
> > > > > > record.
> > > > > >
> > > > > > So make the Makefile rule conditional on OF_SEPARATE and adjust
> fdtdec
> > > > > > to avoid a build error when OF_EMBED is used.
> > > > > >
> > > > > > Finally. the dtb symbol has a double underscore, so update it to
> avoid a
> > > > > > build warning.
> > > > > >
> > > > > > With future patches, OF_EMBED will no-longer be used with the
> EFI app,
> > > > > > so it is expected that it will eventually stop working.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI
> app")
> > > > > > ---
> > > > > >
> > > > > >  Makefile                       | 2 +-
> > > > > >  include/asm-generic/sections.h | 2 +-
> > > > > >  lib/fdtdec.c                   | 2 +-
> > > > > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > Applied to sjg/master, thanks!
> > > > >
> > > > > Since you've picked up several series that no one was objecting to
> and
> > > > > providing reasonable feedback on and applied them to your own
> tree, do
> > > > > you plan to squash/rebase them and repost so they can be applied to
> > > > > master / next at some point?
> > > >
> > > > The original EFI-app series actually had objections in toto. Did you
> > > > not see the comments from Heinrich?
> > >
> > > I assume you mean:
> > >
> https://patchwork.ozlabs.org/project/uboot/patch/20241123195616.305687-2-mjg59@srcf.ucam.org/#3419029
> > > which is a question.
> >
> > Apart from the general tone, it was mostly the cover letter.
>
> Which is
>
> https://patchwork.ozlabs.org/project/uboot/cover/20241123195616.305687-1-mjg59@srcf.ucam.org/#3418939
> and an open question to explain the use case more.
>
> > > > I've offered to send pull requests every now and then, to keep things
> > > > in sync, if that is your goal? But I don't believe I can do that for
> > > > particular patches/series. It is going to be hard enough for me to
> > > > just maintain my own tree, let along dealing with your/Linaro tree.
> > >
> > > I find you calling the mainline project tree "your/Linaro tree"
> > > offensive. And I'm again asking you to explain in public what you are
> > > doing exactly.
> >
> > I'm sorry you are offended. Please suggest a better name that I can
> > use. Honestly, from my point of view, it feels like a
> > Linaro-controlled tree. There's nothing particularly wrong with that,
> > but I would like the freedom to continue to innovate U-Boot, without
> > Linaro telling me what to do. Does that sound OK to you?
>

It's the mainline, there are numerous other vendors that are contributing,
there's NXP, ST, TI, plus numerous other volunteer contributors such as
myself. The fact that Linaro is contributing a lot at the moment is
irrelevant. Contributors to projects wax and wane depending on their own
requirements.


> It's mainline. The tree at https://source.denx.de/u-boot/u-boot is the
> mainline tree for the Das U-Boot project, and I am the maintainer of
> that tree and the nominal head of the U-Boot project. If you want to
> ignore the feedback you have been given by other people to do whatever
> you like, please don't call it U-Boot. It is not "Linaro" disagreeing
> with your ideas, it's a number of people. It's most frequently myself
> (neither I nor my company get any money from Linaro, nor Arm Ltd),
> Heinrich (employed at Canonical, like you) or Ilias (yes, Linaro).
>

Simon, you are free to fork the project, it's one of the main glorious
features of open source software! I was wondering what you were up to when
you were replying with applied to messages for patches that were still
under review.

What it does not give you the right to do is to use the infrastructure,
such as this mailing list, patchwork, CI and what ever else, of the project
you're forking. You don't see the many hardware vendors that have forks of
the project, which they are well within their rights to do, using the
project infrastructure for their forks.

There is nothing OK about what you are doing. The community has the right
to know what you are doing purely because of the fact you are using the
project's infrastructure. If you're going to fork it you have no
requirements to notify if you go off and do it in your own area of the
internet.

Peter
