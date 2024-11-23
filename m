Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3559ED75E5D
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 18:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DB6892B5;
	Sat, 23 Nov 2024 19:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hVnIc1LO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A8A8935F; Sat, 23 Nov 2024 19:23:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C87F1891B1
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 19:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B42883F2B5
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732386228;
 bh=px9DRITtx+UVMw/KmAKB0Xppc4H87ohE0C+c9ZIoHy4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=hVnIc1LOdUXouPl3SG+WOCPb3iM8uUdNDD3hX8Q9cmovJh5AWofLIUpYsdgxHKw4p
 tuX8uVRzdQD+GOK8kpVnt1At0GvYmQ/lCqwDNZoYLss5lKnMArhbJ09OavYtcp5/0r
 1IeUEOp9G27FEr/6lNJV9Ro5G6DIeM7RA8/0w5HvnxITJ7+murfZnobn71zOoMhV0c
 IZcCtnjrceKYc8Zwj3twe+gCY4P8/0Ngp3g8It6EjPP11C9zhpiNH+8QWlKBn8X3F0
 1vlvIyMPuJNg+XwntPsJFWy7GwKIi+NSNL+6fmr74PwndRluK/Opd1Mfs3ESKlgZwS
 W+gTjAlQuamhA==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ea873d84edso3331015a91.1
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 10:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732386227; x=1732991027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=px9DRITtx+UVMw/KmAKB0Xppc4H87ohE0C+c9ZIoHy4=;
 b=AcMCGFO7i4kxqJe/q9kren2EEfQL88M/T138Xz082EZ+8JZ/3cFMLNyRyPsX+UFtx8
 T2HavMIK0ArtyoYN2uoZ4DZ1pZ7ajGczsH0rxSQpjEDNvIxqfHljR58ylkI4G0nVHmKX
 gs+dqCLj8rVyWmmpEShw+rikhIKpRB0wf3iKvqshvp766dGHFURURvrti884k7RLcOvQ
 TZQPgCgHCzqXK4ymxbG70NV4GJMTBQRqXSjXo/IbeuYFokRnFE4bCRGHv1+YBCdm0Y7t
 emNlG/XSBCge2LAiIYW04vdHKblYFHZl3Rz56IK15Qq5G3+ALrEmT8syqRTwUEEx9JB5
 1iiQ==
X-Gm-Message-State: AOJu0YyimLTMh1e7log/Gd4xL/VncclF+fOxZ8nvjMeK/yO4/ANmDvT4
 cZyCFiY1QdPdq1iRlA2sAvdwNJL6eIJeQHyV5E4P8lJgZ7MkG50gPeDZZhHC6s4yOTvbqifs3Ju
 JBU50iu14F07ROZIKihW7UnvY4NsToARt//qsClaF1+oCsOtJH9+ZdCmZcCkseJ443A6fXJmh1y
 GvFbf49RtI8ubac2mHHzE3Mkp35p93NUhuXiF6l6uJraKt13uLnQ==
X-Gm-Gg: ASbGnctPz4xM1YUZKyiez40LsvcY7oDx/A4bvmIeugXkzw/zyEcM2NdrWtE7s9mRGlb
 msBfMWS3uWLLA9DbTMCzPwbwZtmEsbvaX
X-Received: by 2002:a17:90b:2683:b0:2ea:4150:3f7f with SMTP id
 98e67ed59e1d1-2eb0e234d0emr8707830a91.14.1732386227156; 
 Sat, 23 Nov 2024 10:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlTjeb+BiCqsjG1xVSkcZV4pXJsERQ56M+QBFJX30iZy4m8CQfDFZg84q/WOsVAEGDqLop1bg2/04NdK2RAa0=
X-Received: by 2002:a17:90b:2683:b0:2ea:4150:3f7f with SMTP id
 98e67ed59e1d1-2eb0e234d0emr8707820a91.14.1732386226850; Sat, 23 Nov 2024
 10:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
 <20241123152447.GZ3600562@bill-the-cat>
In-Reply-To: <20241123152447.GZ3600562@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sat, 23 Nov 2024 19:23:35 +0100
Message-ID: <CAM=mAO=zNaaBMFzcqyek8OTZfLbD26gw+OMH2eB8dMgYJXfa5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Tom Rini <trini@konsulko.com> schrieb am Sa., 23. Nov. 2024, 16:24:

> On Sat, Nov 23, 2024 at 09:48:53AM +0100, Heinrich Schuchardt wrote:
> > On many 32-bit ARM boards including QEMU memory starts at 0x40000000.
>
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  examples/api/Makefile | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/examples/api/Makefile b/examples/api/Makefile
> > index 722c7e45904..f0f107562f1 100644
> > --- a/examples/api/Makefile
> > +++ b/examples/api/Makefile
> > @@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
> >  LOAD_ADDR = 0x40000
> >  endif
> >  ifeq ($(ARCH),arm)
> > -ifdef CONFIG_64BIT
> >  LOAD_ADDR = 0x40400000
> > -else
> > -LOAD_ADDR = 0x1000000
> > -endif
> >  endif
> >  ifeq ($(ARCH),mips)
> >  ifdef CONFIG_64BIT
>
> If we're going to start cleaning this area up and expecting it to work
> more broadly, is there a reason we can't use CONFIG_SYS_LOAD_ADDR or
> CONFIG_STANDALONE_LOAD_ADDR here?
>

loadaddr == CONFIG_SYS_LOAD_ADDR on RISC-V QEMU. Command bootelf did not
work for me, if the ELF binary had been loaded to its LOAD_ADDR.

I did not investigate yet why bootelf fails in this case.

Best regards

Heinrich


> --
> Tom
>
