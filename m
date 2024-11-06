Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BA6D59F40
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 15:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B2A88F92;
	Wed,  6 Nov 2024 16:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mgba5zPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC32891BC; Wed,  6 Nov 2024 16:40:52 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E317288DB2
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 16:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso1076665866b.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730907649; x=1731512449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GncE6+xyVvXRZA6tYL5o1pCWmeQkPyVkK/VCd1V8DtQ=;
 b=mgba5zPLn66G7ryXZQRX9uzIflHbbT/Dug0K8dAUQgb+4DpRYAX1UtTwTHk5KqgjiC
 FZxCP5If00HssJBamv6xFBtr5VqnZyZLF2b8vQYC0wno9gSr4hhtZpV+0ymDe86wnD3a
 /8kM3N1esE7x5HERFxEA2g0nokgVe1iuPHZ/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730907649; x=1731512449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GncE6+xyVvXRZA6tYL5o1pCWmeQkPyVkK/VCd1V8DtQ=;
 b=SOVADJ05JVJywYklcgnrvpMto6BRcHtHWBkleNMocr5EmHv28R11o/cJE8AB48WgJR
 9FWsiubxsNaKTEByDEBD90hihRGUFSPBt2rSDVNxc35tZft0lQQRHf9RG29sDTGvegTE
 WvZ9XOHPVJW2lo7IOm27yc/5mhCa1ZVEnoygnFV1QtxNJiY0O3F8FpxnO5L+Hgf+KedY
 wWLf1gQNvPXfBfcEUrTvV4I/7MZT/WY9230uaBnlxbIyItnjb20f/cSaJs7x9bcOSQ0n
 npoL+nHFZSe+uMk9oRNBPvpWQfNUtnhpMV8U9OAQdKUN0yCu2bxrzcYu892kBdoZPSpO
 fW5A==
X-Gm-Message-State: AOJu0Yz8RR8gwybe7z7lfr/t7YwdH8X6ac4aIy2u8dxAwri0SOSILMLY
 7SFqCEV5H5TLSKt2cWxNRM3OAnZ7j46IYTE3aqNHRAqeG+EUdCoTJ3jYtxEF5nkFhBaxTDDEnvv
 M6DAWPsD4gYwOf+LTvIzVOnLnRDy3ML5XPgvl
X-Google-Smtp-Source: AGHT+IGRIgtdJvEWkMN2LNSFAl2rf09KYxoPHUFkhYqchGuwpzH4Vi9tEDqNywPH8QcQxnlZxz7V980Ty+6WUNQkPU0=
X-Received: by 2002:a17:907:9405:b0:a9a:1792:f24 with SMTP id
 a640c23a62f3a-a9de5ee19acmr4059204466b.24.1730907649313; Wed, 06 Nov 2024
 07:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20241105160738.3795497-1-sjg@chromium.org>
 <20241105160738.3795497-5-sjg@chromium.org>
 <20241105161145.GJ3600562@bill-the-cat>
 <CAFLszTj2=0t1LmNr5kY=SBxaZtR8DB6bHwdfcgXwRqAr5ue5UQ@mail.gmail.com>
 <20241105164554.GK3600562@bill-the-cat>
 <CAFLszThuzMvK+iSin+6sHP=g2xF5bBTMNG7ig2B733vpi3wxfg@mail.gmail.com>
 <20241105205518.GM3600562@bill-the-cat>
In-Reply-To: <20241105205518.GM3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 6 Nov 2024 08:40:38 -0700
Message-ID: <CAFLszTga6qRskaa3KppFQLKSG+UnmkXrXt8WXbgj5zrfKOx7AQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] docker: Adjust packages for arm64
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Tue, 5 Nov 2024 at 13:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 05, 2024 at 12:20:51PM -0700, Simon Glass wrote:
> > HI Tom,
> >
> > On Tue, 5 Nov 2024 at 09:45, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 05, 2024 at 09:26:10AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 5 Nov 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Nov 05, 2024 at 09:07:33AM -0700, Simon Glass wrote:
> > > > > > The package names are slightly different for arm64 and we don't seem to
> > > > > > have a linux-image-kvm package. Provide a different set for arm64
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Swap order so that amd64 is the exception
> > > > > >
> > > > > >  tools/docker/Dockerfile | 12 +++++++-----
> > > > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > > > > index 540718df062..84661b036c6 100644
> > > > > > --- a/tools/docker/Dockerfile
> > > > > > +++ b/tools/docker/Dockerfile
> > > > > > @@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
> > > > > >  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> > > > >
> > > > > Oh no, here's a big problem ^^^^^
> > > > > You didn't switch to downloading arm64 toolchains, no wonder everything
> > > > > else blows up.
> > > >
> > > > Er, yes I know that...I would have to put 'if' statements on each one,
> > > > but I was hoping we could come up with a better way of handling this.
> > >
> > > Yes, hopefully we can do something with $TARGETPLATFORM to set another
> > > variable that's exposed for wider use.
> >
> > I recall that docker doesn't let variables set in one phase affect
> > subsequent ones, but perhaps something can be done in the ENV section
>
> Yes, my hope is we could set something in the ENV section.
>
> > > > Same with all the variables being set for grub.
> > > >
> > > > >
> > > > > >  # Update and install things from apt now
> > > > > > -RUN apt-get update && apt-get install -y \
> > > > > > +RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
> > > > > > +             EXTRA_PACKAGES="grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linux-image-kvm"; \
> > > > > > +     else \
> > > > > > +             EXTRA_PACKAGES="grub-efi linux-image-generic"; \
> > > > > > +     fi; \
> > > > >
> > > > > Again, grub-efi should be used for everyone and linux/amd64 adds
> > > > > grub-efi-ia32-bin. And linux-image-generic should work for everyone,
> > > > > too.
> > > >
> > > > So what about this commit?[1]
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] f9abaa53ec8 tools: docker: Install a readable kernel for libguestfs-tools
> > >
> > > Yes, linux-image-generic should also provide a useful image, and you
> > > would need to check what CI says when using this image.
> >
> > OK, so we don't actually need the kvm one, it seems?
>
> No, that was just a reasonable at the time choice for a kernel image
> file.

OK

>
> > Anyway, the upshot of all of this is that you want arm64 to run the
> > full suite of tests, including kvm and world builds. But presumably
> > not in addition to the x86_64 ones...? I suppose I am just unclear as
> > to what you are looking for. Are you trying to test that QEMU works
> > properly, or that U-Boot's code works?
> >
> > My expectation was that we just want sandbox testing on arm64...I
> > don't see much point in anything else. What am I missing?
>
> I would like, especially if we get additional compute resources donated,
> to duplicate much of the testing we do _also_ on arm64 as a host, at
> least on tagged releases. This is a thing more and more people do, and
> it would be good to be able to point at CI when something like:
> https://source.denx.de/u-boot/u-boot/-/issues/44
> is filed.

Well, that issue is a mystery to me too.

Anyway, this is mostly a difference in approach. I like to do things
incrementally, rather than trying to do everything at once.

Regards,
Simon
