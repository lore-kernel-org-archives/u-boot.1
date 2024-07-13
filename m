Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFFEC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E214788912;
	Sat, 13 Jul 2024 17:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kNESGyD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0075088936; Sat, 13 Jul 2024 17:16:19 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A37588912
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c98660fc91so2117636a91.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883774; x=1721488574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kMii+ZiUcH7PnBOcHyVu9b7rPrhsnVCG74FTipWRZ/s=;
 b=kNESGyD6b1kwiMhYG58iAAIyVVEPoc4jU2NoYFXE/mJjySU+naD2BBxF9QeNf9hpMW
 nXbb/qgEA03mxDVCWUq+vISnYFFLvMtzSpaqU0RfFV1frRzSIXXCKftsr0zCIsdL/IJi
 xe5x3RHnn6RdSkvJBaXikdsdxLkdDCtCm8QYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883774; x=1721488574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMii+ZiUcH7PnBOcHyVu9b7rPrhsnVCG74FTipWRZ/s=;
 b=OvMOIhPkRATaA8NZ11v7aqo3kNIoBQhEoOkxd8QCwHSb9P7//9y/YHXv0nzahjehwZ
 qRuyJiMvXGnbPdNhxe0X39hQgNHAOeQDik/97ILcnLdLPk+8jHZHcJPu6TSjoHSGdbif
 NfEFQ42V3q4PIFk6q/NO6vnC4An1Eht1fQOQu+VWLE6zh5l0PZokjZ0mROrhQy+hkrtW
 9aiIEQzNFWLhY/wyxjwXsqPP1fttTSBrotIzbWJXS4ZpLboBw4PIqXEpS+YcWvu4GraA
 z17nWGeRgV54XG6FMm4jZdK44qZvjktwyvAHr+VLz1QHBCJVFTShHitDPuqcY40BsSoq
 8pQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAb1bX1bPbALZz9eTXwL503rvPr1MWH3bADsUfhC2DGvT8b40oL8bf6CbRKlkrYIBc7z3fMd8Pc7JDfy31C7+4T7RFhg==
X-Gm-Message-State: AOJu0YwvFr07L0/Wkl70zdEW1SHxvFuZEECCKxQBlFd9xXoNgrDgsEDm
 dfPxQcHVHVoK6PGHxKYYp4CxDWwf3fXWkQdYp2JBkEnOKoRgxYqdXuoOpUi9rBReiSyzWB7zVjt
 oHzy12/A87Vmp6nclLd2SHhCyOb8kXO/6xAtfKbEE6VrXRBA=
X-Google-Smtp-Source: AGHT+IFWjwQZ51drsOWxgpjxeH2v6PkNySOIqjXzpfGY3J2wYwlK+Mmpz7iivpXCggdAzwis3UGgLlyihDY+G+FI768=
X-Received: by 2002:a17:90b:1086:b0:2c6:ee50:5af4 with SMTP id
 98e67ed59e1d1-2ca35bdeb0amr11296032a91.6.1720883774062; Sat, 13 Jul 2024
 08:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-17-sughosh.ganu@linaro.org>
 <20240705194841.GO38804@bill-the-cat>
 <CADg8p95b2XybOZSB=YcX6hwP6mQrvxZs4tLNjhT5g3AeKve4cA@mail.gmail.com>
 <20240708144626.GD38804@bill-the-cat>
In-Reply-To: <20240708144626.GD38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:52 +0100
Message-ID: <CAFLszTif7d1v6O3w2w2STm-NsTM=E5MzYp30SrWipejx_MzKOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/48] lmb: config: add lmb config symbols for SPL
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi,

On Mon, 8 Jul 2024 at 15:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 08, 2024 at 05:06:45PM +0530, Sughosh Ganu wrote:
> > On Sat, 6 Jul 2024 at 01:18, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jul 04, 2024 at 01:05:12PM +0530, Sughosh Ganu wrote:
> > >
> > > > Add separate config symbols for enabling the LMB module for the SPL
> > > > phase. The LMB module implementation now relies on alloced list data
> > > > structure which requires heap area to be present. Add specific config
> > > > symbol for the SPL phase of U-Boot so that this can be enabled on
> > > > platforms which support a heap in SPL.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1: New patch
> > > >
> > > >  lib/Kconfig | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > index 072ed0ecfa..7eea517b3b 100644
> > > > --- a/lib/Kconfig
> > > > +++ b/lib/Kconfig
> > > > @@ -1103,7 +1103,17 @@ config LMB
> > > >       default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
> > > >                    NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
> > > >       help
> > > > -       Support the library logical memory blocks.
> > > > +       Support the library logical memory blocks. This will require
> > > > +       a malloc() implementation for defining the data structures
> > > > +       needed for maintaining the LMB memory map.
> > >
> > > Even today, LMB really should be def_bool y rather than an option, so
> > > this series should correct that. That said...
> >
> > Okay
> >
> > >
> > > > +config SPL_LMB
> > > > +     bool "Enable LMB module for SPL"
> > > > +     depends on SPL && SPL_FRAMEWORK && SPL_SYS_MALLOC
> > > > +     help
> > > > +       Enable support for Logical Memory Block library routines in
> > > > +       SPL. This will require a malloc() implementation for defining
> > > > +       the data structures needed for maintaining the LMB memory map.
> > >
> > > The question I guess becomes when do we need LMB in SPL, exactly? And I
> > > guess it's another case where it should be def_bool y (but still depends
> > > on what you have here) since we need to make sure we don't overwrite
> > > running SPL.
> >
> > So this is a question even I had. Do we really need to enable LMB in
> > SPL ? The main reason for introducing the symbol was to have more
> > granularity to remove the LMB code from SPL, but should this really be
> > enabled in SPL is something that I am not too sure about.
>
> Yes, we need to ensure we obey reservations in SPL, both for U-Boot and
> for when we boot the OS from SPL.

I believe we will use it, e.g. in VPL. But we don't have (nor perhaps
even want) a mechanism for passing the lmb from one phase to the next.

Regards,
Simon
