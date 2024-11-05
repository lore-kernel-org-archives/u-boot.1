Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F72BD3610E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6708917B;
	Tue,  5 Nov 2024 20:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bQKTPVoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAE4891AB; Tue,  5 Nov 2024 20:21:06 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A660688D8D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso935400366b.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730834463; x=1731439263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oVUU8qlebiOmTinyrIiM5leftM7Cx8bP6lE3VBD2F8M=;
 b=bQKTPVoijaYnxhtY0Y5dAwI9Ul8jNkrhORUU16sroPAPS9iTXMDeX5wy1tYeiyxx7P
 tZs2/V2MMmFYP5YyzE2m8EHnPHxD+StQZ2C11kPwsNAH9H6UZpTqixSF/OoddrTMF+B3
 5X/Vqh/BZKmt3iZ19O/bswrT59U5yaPTliZxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730834463; x=1731439263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVUU8qlebiOmTinyrIiM5leftM7Cx8bP6lE3VBD2F8M=;
 b=mOLJ1FnfQ3Fwob7HdbGz2blPFhyzOo9Kl64+pX5ZjYVG7RGstAe3X93Cs2uLpEDhoH
 /PVi+trX/mFuL2p7a+YHKMsg5KLwF9ZBHed00VewdO8JvzexDi/28bMMt5SUcB4Hvuea
 C/B7c2d61ShaGCX5QTHZ033lFonODgC80AExvEHkSkMALPDwSG6C9nRIFnQT/mJrH4mN
 s9CSLkZiYrzsv/lkFuTLgFtFhiYJwktngD9CFFvoQJmZcWa0wevQLkNXnI7Na5AwdJ6z
 so+Icl4zM9w2bhIBINLjLLuBoreyiKGn+jHZzBKdQYDI2e+UJ0woZg+2sk4rvaFv7iNo
 Hwiw==
X-Gm-Message-State: AOJu0YyVrhqNrRjIayxGBitNoDj4cKP7ZcS3OJsmsgerdH1YvH+xIwHd
 HW3ScRJgklFNuZtWLH9GI5m525DeuAD7119H5Pr9TAeO77Yb5vMxwI8FL1+Mfq21mf6S1FQYb8a
 FDl+r3J7QmQOSPcAIVYd4/AsGdK1G93bPM/kb
X-Google-Smtp-Source: AGHT+IFcC1UW6RKMHuwwhBEz7t0wf1A6v61LRgbEhVHgiCzKIYlQTP7WxZCTs+Bbjn7ZJwvGK5eXzlq8EDcS78q79kY=
X-Received: by 2002:a17:907:7204:b0:a9a:c57f:964f with SMTP id
 a640c23a62f3a-a9e655705f0mr1812325466b.16.1730834462917; Tue, 05 Nov 2024
 11:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20241105160738.3795497-1-sjg@chromium.org>
 <20241105160738.3795497-5-sjg@chromium.org>
 <20241105161145.GJ3600562@bill-the-cat>
 <CAFLszTj2=0t1LmNr5kY=SBxaZtR8DB6bHwdfcgXwRqAr5ue5UQ@mail.gmail.com>
 <20241105164554.GK3600562@bill-the-cat>
In-Reply-To: <20241105164554.GK3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 12:20:51 -0700
Message-ID: <CAFLszThuzMvK+iSin+6sHP=g2xF5bBTMNG7ig2B733vpi3wxfg@mail.gmail.com>
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

HI Tom,

On Tue, 5 Nov 2024 at 09:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 05, 2024 at 09:26:10AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 5 Nov 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 05, 2024 at 09:07:33AM -0700, Simon Glass wrote:
> > > > The package names are slightly different for arm64 and we don't seem to
> > > > have a linux-image-kvm package. Provide a different set for arm64
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Swap order so that amd64 is the exception
> > > >
> > > >  tools/docker/Dockerfile | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > > index 540718df062..84661b036c6 100644
> > > > --- a/tools/docker/Dockerfile
> > > > +++ b/tools/docker/Dockerfile
> > > > @@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
> > > >  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> > >
> > > Oh no, here's a big problem ^^^^^
> > > You didn't switch to downloading arm64 toolchains, no wonder everything
> > > else blows up.
> >
> > Er, yes I know that...I would have to put 'if' statements on each one,
> > but I was hoping we could come up with a better way of handling this.
>
> Yes, hopefully we can do something with $TARGETPLATFORM to set another
> variable that's exposed for wider use.

I recall that docker doesn't let variables set in one phase affect
subsequent ones, but perhaps something can be done in the ENV section

>
> > Same with all the variables being set for grub.
> >
> > >
> > > >  # Update and install things from apt now
> > > > -RUN apt-get update && apt-get install -y \
> > > > +RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
> > > > +             EXTRA_PACKAGES="grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linux-image-kvm"; \
> > > > +     else \
> > > > +             EXTRA_PACKAGES="grub-efi linux-image-generic"; \
> > > > +     fi; \
> > >
> > > Again, grub-efi should be used for everyone and linux/amd64 adds
> > > grub-efi-ia32-bin. And linux-image-generic should work for everyone,
> > > too.
> >
> > So what about this commit?[1]
> >
> > Regards,
> > Simon
> >
> > [1] f9abaa53ec8 tools: docker: Install a readable kernel for libguestfs-tools
>
> Yes, linux-image-generic should also provide a useful image, and you
> would need to check what CI says when using this image.

OK, so we don't actually need the kvm one, it seems?

Anyway, the upshot of all of this is that you want arm64 to run the
full suite of tests, including kvm and world builds. But presumably
not in addition to the x86_64 ones...? I suppose I am just unclear as
to what you are looking for. Are you trying to test that QEMU works
properly, or that U-Boot's code works?

My expectation was that we just want sandbox testing on arm64...I
don't see much point in anything else. What am I missing?

Regards,
Simon
