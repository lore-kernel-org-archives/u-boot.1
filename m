Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F34D31761
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC178904C;
	Tue,  5 Nov 2024 17:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mqYr0uVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09347891A6; Tue,  5 Nov 2024 17:26:25 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B973B88ED9
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so956975466b.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730823982; x=1731428782; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2HSvHPewYocNOVqI9LkNoOTe5i5xVvQmRUn7h8TlUMs=;
 b=mqYr0uVTQqPknRoXvooGU+6MsiTHt5qMICSaXN89D/jXldclUlpSPLx/wmvySmmm6j
 j411y9RXDygVvsIDsx0g70M2+6cbMTdQ19V1kCNHSmkmn5r1sSEzruJ8iJbGvjJK4XNM
 6kkxc+dVDvJ0I3XizTIGo4KcX7AdcGoHYlWVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730823982; x=1731428782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2HSvHPewYocNOVqI9LkNoOTe5i5xVvQmRUn7h8TlUMs=;
 b=oeJBCkv3VdcVN+O0HZ6N6LFrZj8CQyp/Q7z9qWH8YJjelvEn81tx0QHdSiP6tyYxhQ
 Y4RvPaBkK6lv2inc1J9ArhDtpzqf1lyPrkrtxVmbekwajo0PkpVxqL2A6Msn4EUmFgga
 9hGVpoJewZFV2pZNdNUb/fvbEZYaskHFugMmKEM3vb0z90TCd0QAZRhsDV3dU+vuuHKI
 pEKNoPgqsV2cPi/YOSIniaMnwYbf6ZOPjBtmjWtMdk2x90r51SpoP86L3QUnC/e2bhgs
 GyQ0a+db7coW2fEIsvSaH0cRZ/CNMhePDgSZ875OW+LX4phpxarN9FyVAllA/AyTYJ5H
 o6FA==
X-Gm-Message-State: AOJu0YwjAKwEYOp2K3maP5lK/uq0FaELLWsQEKx25m8h/ITzQkEqE+9s
 H8/dG8etaLh0gQiLLwbCiLjihwEDRAhSxk3pCyO0hHH9z8a9BNhTSmVA6JZcA3e2qkx9YkdCwb9
 i72X5gehCsNkS2iyg6fUgVuSiCMz1uOKSmedF
X-Google-Smtp-Source: AGHT+IENR3A4nK/T97ppPJ/A8GZm6vt17lFz2cGj13ko3eUG9sMhmaPOd2UOO/uSFBo0G7C1JmSbZSzszf7TD/8nCUc=
X-Received: by 2002:a17:907:9603:b0:a9a:3da9:6a02 with SMTP id
 a640c23a62f3a-a9e658084cbmr1504445866b.60.1730823982084; Tue, 05 Nov 2024
 08:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20241105160738.3795497-1-sjg@chromium.org>
 <20241105160738.3795497-5-sjg@chromium.org>
 <20241105161145.GJ3600562@bill-the-cat>
In-Reply-To: <20241105161145.GJ3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 09:26:10 -0700
Message-ID: <CAFLszTj2=0t1LmNr5kY=SBxaZtR8DB6bHwdfcgXwRqAr5ue5UQ@mail.gmail.com>
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

On Tue, 5 Nov 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 05, 2024 at 09:07:33AM -0700, Simon Glass wrote:
> > The package names are slightly different for arm64 and we don't seem to
> > have a linux-image-kvm package. Provide a different set for arm64
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Swap order so that amd64 is the exception
> >
> >  tools/docker/Dockerfile | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index 540718df062..84661b036c6 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
> >  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
>
> Oh no, here's a big problem ^^^^^
> You didn't switch to downloading arm64 toolchains, no wonder everything
> else blows up.

Er, yes I know that...I would have to put 'if' statements on each one,
but I was hoping we could come up with a better way of handling this.
Same with all the variables being set for grub.

>
> >  # Update and install things from apt now
> > -RUN apt-get update && apt-get install -y \
> > +RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
> > +             EXTRA_PACKAGES="grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linux-image-kvm"; \
> > +     else \
> > +             EXTRA_PACKAGES="grub-efi linux-image-generic"; \
> > +     fi; \
>
> Again, grub-efi should be used for everyone and linux/amd64 adds
> grub-efi-ia32-bin. And linux-image-generic should work for everyone,
> too.

So what about this commit?[1]

Regards,
Simon

[1] f9abaa53ec8 tools: docker: Install a readable kernel for libguestfs-tools
