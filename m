Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6B3CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEE588B8F;
	Fri, 20 Sep 2024 17:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YofE9r+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6468F88BBC; Fri, 20 Sep 2024 17:59:45 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA1888B8F
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-49bd3bf3b4cso1077102137.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847979; x=1727452779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uYWUX30uSXyaBkuGHBqYAuFk/tcWSLi66fEic+rnQug=;
 b=YofE9r+SZgOaHQOAzyxCSK2dVFOrHCo2kNsBS5F8/w4qmSDjWT6j0o1kvKc64mF9KU
 c60UOrQBZmU443yVhMSWQmq7vH3bHE1hPVGgMpO1b3oPAu0hD6Bna2ppJB5pls2t+BY7
 LAVTITQXSo3Rc+bpq3sqAd9IecODRlWet7Jic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847979; x=1727452779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uYWUX30uSXyaBkuGHBqYAuFk/tcWSLi66fEic+rnQug=;
 b=vpsIjnWSMirjd8j6bEkevIm6kWzlTJJBM6bNvPRPEANMMBFu9KOREWGPU9tLhSgW7y
 ZMGJIthyIJJXQBkCULsU7m/zue92rjfxCTeEdtRaIRT2NsR5mt0+bcXb8g19WkMLfsaL
 CAFAkiWzc4V7STDSVTkQU6rgsbhdL8SKZpVsovh39V5QqNSCZnDgifnzmSMsydHRo1+1
 E1bxByfEkrke5ORtf8TJJrvZA8L1LCryUMZEZvJ2Wl97PLA6G8mWfzn/1cB+d2IXMRld
 PBZZIX5VGSDuPmL+hDsN8dvQDwRtSzEUqJ24sOJqGYg3RaF9RKYz9iyeBbKwxguD4pfa
 wvxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8CkMaYu01T6q3DdzN9zc7sQL1o8wcgvDGQFeZ57UthD1ay86kTLfyYjF0sARv6cMnS2ceKo=@lists.denx.de
X-Gm-Message-State: AOJu0YxrTPKPXJDL1cpLiBGBeZ9XMhgL95rEtlMruYoNd1pchbVmp8BA
 XosvvfHmXj0JamJzmuhj9fARs2VCbteIUbpXWszCB6OA6Xke2ZF/bMcVt27xnsfBp7nyC+vCekD
 JFeRGDpw5Um+J+0TEPUw/C8aI0UueXWkcK5bE
X-Google-Smtp-Source: AGHT+IFVTnxDoWZawszxN+E2wSC3qzCmB/2Km+nV51wlGobvdk8Os3aES4t0SVj7/r5Fhf7IZaxoTTMnqhmnYpG7Z9g=
X-Received: by 2002:a05:6102:c11:b0:49b:d12f:40b0 with SMTP id
 ada2fe7eead31-49fc75373eamr4433651137.1.1726847978902; Fri, 20 Sep 2024
 08:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240919151424.57663-1-sjg@chromium.org>
 <20240919-removal-boney-174f9c8a26df@thorsis.com>
In-Reply-To: <20240919-removal-boney-174f9c8a26df@thorsis.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:59:28 +0200
Message-ID: <CAFLszTiJkzk05ocLJJkZoKPHLCfiWsOFwDLBjrv1JRWej-3S5Q@mail.gmail.com>
Subject: Re: [PATCH] doc: Move the generic memory-documentation to doc/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Alexander Dahl <ada@thorsis.com>
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

Hi Alex,

On Thu, 19 Sept 2024 at 17:28, Alexander Dahl <ada@thorsis.com> wrote:
>
> Hello Simon,
>
> Am Thu, Sep 19, 2024 at 05:14:22PM +0200 schrieb Simon Glass:
> > Move this section of the README into doc/ with some minor updates to
> > mention SPL and user lower-case hex.
>
> Maybe try not to rewrap unchanged paragraphs,
> so `git show --color-moved` can detect those as just moved?

I did try to do that, but perhaps did a line wrong?

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  README                 | 45 ------------------------------------------
> >  doc/develop/index.rst  |  1 +
> >  doc/develop/memory.rst | 45 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+), 45 deletions(-)
> >  create mode 100644 doc/develop/memory.rst
> >
> > diff --git a/README b/README
> > index 4be1e8c22a0..d73042406b6 100644
> > --- a/README
> > +++ b/README
> > @@ -2516,51 +2516,6 @@ On RISC-V, the following registers are used:
> >
> >      ==> U-Boot will use gp to hold a pointer to the global data
> >
> > -Memory Management:
> > -------------------
> > -
> > -U-Boot runs in system state and uses physical addresses, i.e. the
> > -MMU is not used either for address mapping nor for memory protection.
> > -
> > -The available memory is mapped to fixed addresses using the memory
> > -controller. In this process, a contiguous block is formed for each
> > -memory type (Flash, SDRAM, SRAM), even when it consists of several
> > -physical memory banks.
> > -
> > -U-Boot is installed in the first 128 kB of the first Flash bank (on
> > -TQM8xxL modules this is the range 0x40000000 ... 0x4001FFFF). After
> > -booting and sizing and initializing DRAM, the code relocates itself
> > -to the upper end of DRAM. Immediately below the U-Boot code some
> > -memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> > -configuration setting]. Below that, a structure with global Board
> > -Info data is placed, followed by the stack (growing downward).
> > -
> > -Additionally, some exception handler code is copied to the low 8 kB
> > -of DRAM (0x00000000 ... 0x00001FFF).
> > -
> > -So a typical memory configuration with 16 MB of DRAM could look like
> > -this:
> > -
> > -     0x0000 0000     Exception Vector code
> > -           :
> > -     0x0000 1FFF
> > -     0x0000 2000     Free for Application Use
> > -           :
> > -           :
> > -
> > -           :
> > -           :
> > -     0x00FB FF20     Monitor Stack (Growing downward)
> > -     0x00FB FFAC     Board Info Data and permanent copy of global data
> > -     0x00FC 0000     Malloc Arena
> > -           :
> > -     0x00FD FFFF
> > -     0x00FE 0000     RAM Copy of Monitor Code
> > -     ...             eventually: LCD or video framebuffer
> > -     ...             eventually: pRAM (Protected RAM - unchanged by reset)
> > -     0x00FF FFFF     [End of RAM]
> > -
> > -
> >  System Initialization:
> >  ----------------------
> >
> > diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> > index 0d0e60ab56c..cbea38d4323 100644
> > --- a/doc/develop/index.rst
> > +++ b/doc/develop/index.rst
> > @@ -13,6 +13,7 @@ General
> >     codingstyle
> >     designprinciples
> >     docstyle
> > +   memory
> >     patman
> >     process
> >     release_cycle
> > diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> > new file mode 100644
> > index 00000000000..fa1ae5e97ed
> > --- /dev/null
> > +++ b/doc/develop/memory.rst
> > @@ -0,0 +1,45 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +Memory Management
> > +-----------------
> > +
> > +U-Boot runs in system state and uses physical addresses, i.e. the
> > +MMU is not used either for address mapping nor for memory protection.
> > +
> > +The available memory is mapped to fixed addresses using the
> > +memory-controller. In this process, a contiguous block is formed for each
> > +memory type (Flash, SDRAM, SRAM), even when it consists of several
> > +physical-memory banks.
> > +
> > +U-Boot is installed in XIP flash memory, or may be loaded into a lower region of
> > +RAM by a secondary program loader (SPL). After
> > +booting and sizing and initialising DRAM, the code relocates itself
> > +to the upper end of DRAM. Immediately below the U-Boot code some
> > +memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> > +configuration setting]. Below that, a structure with global Board-Info
> > +data is placed, followed by the stack (growing downward).
> > +
> > +Additionally, some exception handler code may be copied to the low 8 kB
> > +of DRAM (0x00000000 ... 0x00001fff).
> > +
> > +So a typical memory configuration with 16 MB of DRAM could look like
> > +this::
> > +
> > +     0x0000 0000     Exception Vector code
> > +           :
> > +     0x0000 1fff
> > +     0x0000 2000     Free for Application Use
> > +           :
> > +           :
> > +
> > +           :
> > +           :
> > +     0x00fb ff20     Monitor Stack (Growing downward)
> > +     0x00fb ffac     Board Info Data and permanent copy of global data
> > +     0x00fc 0000     Malloc Arena
>
> Arena?

Yes, a strange choice of words perhaps, but fair enough.

>
> `make htmldocs` runs fine, page looks okay, thus:
>
> Acked-by: Alexander Dahl <ada@thorsis.com>

Thanks.

>
> Greets
> Alex
>
> > +           :
> > +     0x00fd ffff
> > +     0x00fe 0000     RAM Copy of Monitor Code
> > +     ...             eventually: LCD or video framebuffer
> > +     ...             eventually: pRAM (Protected RAM - unchanged by reset)
> > +     0x00ff ffff     [End of RAM]
> > --
> > 2.43.0
> >

Regards,
Simon
