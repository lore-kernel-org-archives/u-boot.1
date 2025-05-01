Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A6FC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9414880F03;
	Thu,  1 May 2025 17:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hKjDsVME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C1981E72; Thu,  1 May 2025 17:03:40 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8066B8212B
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso177912466b.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746111817; x=1746716617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lK99kX6DciqZusGJ3DjEFzj09RmLQSy2k+bEsOdcEWo=;
 b=hKjDsVMEsTOnbMKpWVNpWnK5ur78eZW0vlOrQnl8btUkbe0OgANaa9GNe6a6FxLAZ+
 4SG72eHrCWODeaeqh3vxXPyRyoMrg8GUHQEIU7BDzOo+ooT5AcnvtqkilOkZfkguRQ0M
 1U4HYm8yEIVi18+tgpta0OmJ++6v+8mvwYG7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111817; x=1746716617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lK99kX6DciqZusGJ3DjEFzj09RmLQSy2k+bEsOdcEWo=;
 b=LZUeGxWxJ5j00TkqBODyxor6sbg+E5GbqluIpr0OcSEHEA8mL5EPBZmrGuplfplHMl
 FCCcqNVee5Ji9ZCYHGu97nFf89cyudwN8WllClirVWcbfB6jnF0NMteJZ7YAQLa/xpVr
 RAK5Mw+GRSY8E+jr2n5pIvLpTj2+jRmreFvfKp7rvUeKaZZxxgAm/nIduPDmKMZkl6tT
 lQgDGIe2ePcwtxiN6ta3MPACPd4h5IRru7tnCi5Bcw/pejxM2EWbw24IpKj2JIhgtMJ9
 0RE1UvgF9wT16iQebmuhJSEm+/6XNI+7NcMS34s+z4pVLpzwx+pMAt1rbwI55FvQbMYH
 xU8w==
X-Gm-Message-State: AOJu0YwImTUcT1n0Wb/uBskPE5eyyxGFULNMM2TCDDX1fjzNUmXuOK4e
 /BTvNErDLs1kIWUmra2kM3BjSCfj9T5q57iaFUDj68cNmt4Z02FK9zEAfZviR6QA8GCeBLXLKuC
 9wZqlTh/CTN0SGtfpmkLlt5Q1Lfj775hwrGco
X-Gm-Gg: ASbGnctlaLF+T/qcyrQ0UPKofrPu/hm+8lXcW52ZUAKPq8RZFYzOzoL2Gr0w0T4AQWR
 zXrZ7n203hTVePSXKISthYOuPX4YDwHzpS6EA04HPKiU42nB3lzbr2F1n0QfVnnWLU/dSpyxN3C
 DVEhNw5wxnsWthPZLwiWSR0+I=
X-Google-Smtp-Source: AGHT+IGyEIyi6eujvznizO+YQNc3MvUS5/fScFzEOb0CirBUWM6igtAwOCFD/WavHoOoU52wEwXHkpUtUSpyYWbkTsA=
X-Received: by 2002:a17:907:96a2:b0:ace:bead:5ee6 with SMTP id
 a640c23a62f3a-acef45a2514mr294772666b.37.1746111816300; Thu, 01 May 2025
 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
 <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
 <20250418140844.GP5495@bill-the-cat>
 <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
 <20250501145918.GF1261075@bill-the-cat>
In-Reply-To: <20250501145918.GF1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 09:03:21 -0600
X-Gm-Features: ATxdqUGi7TOYCrFLLDJ09JR8-J4AHG_Bb7nJeXu4sj-ow8Eblu-R87GvzJiJyLU
Message-ID: <CAFLszTj24JPD+tC6LiP9z_o01PbBOy9Yyqqzmfk3P_Bc5nnWoQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 1 May 2025 at 08:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 07:06:03AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Apr 18, 2025 at 07:46:59AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
> > > > >
> > > > > > This series restores the original behaviour of extlinux booting linux
> > > > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > > > > > a limit of 10x the compressed size.
> > > > > >
> > > > > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > > > > >
> > > > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > > > logic.
> > > > > >
> > > > > >
> > > > > > Simon Glass (3):
> > > > > >   boot: Add a function to check if a linux Image is supported
> > > > > >   bootm: Add RISC-V support in booti_is_supported()
> > > > > >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> > > > > >
> > > > > >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> > > > > >  cmd/booti.c     |  1 +
> > > > > >  include/bootm.h |  3 +++
> > > > > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > > > >
> > > > > This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so much as
> > > > > it was never relevant here to start with. The documentation
> > > > > (doc/usage/cmd/booti.rst) has explained that we use 10 x
> > > > > kernel_comp_size for the limit. The "bootm" namespace has largely been
> > > > > about uImage (and then FIT images when not using it's own namespace)
> > > > > images and not applied elsewhere, which is why bootz/booti handled
> > > > > things outside that namespace. And then, still, this series doesn't
> > > > > unify cmd/booti.c with your changes, it just introduces duplicated
> > > > > functionality, which is generally understood to be a bad thing.
> > > > >
> > > > > So again, please do similar to what you did for cmd/bootz.c and that
> > > > > report and move the existing functionality over. We can then look at
> > > > > cleaning it up (which should look like / abstract what we do for
> > > > > compressed FIT images) as a follow up, in order to make bisecting any
> > > > > regressions here easier down the line. Thanks.
> > > >
> > > > Well, I still don't understand what you are getting at here.
> > > >
> > > > The existing functionality for booti is already there. Marek added it
> > > > a few years back. Can you please be more specific as to what
> > > > functionality you think is missing?
> > >
> > > With:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250409155723.431102-1-sjg@chromium.org/
> > > You moved the functionality from cmd/bootz.c and over to boot/bootm.c
> > >
> > > You need to do the same thing here.
> >
> > That code is already there. Here is the code you are talking about, in
> > cmd/booti.c (which is a hack, BTW)
>
> Hey, thanks for insulting my code, BTW. Best way to make sure I really want
> to take your way of refactoring the code, rather than the way I asked
> you to.
>
> I'll look at this again tomorrow.

Oops, I didn't know it was your code, sorry.

Regards,
Simon
