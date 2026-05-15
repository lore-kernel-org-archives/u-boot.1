Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35681CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA437846CF;
	Fri, 15 May 2026 20:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dYX5j4+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A2D84852; Fri, 15 May 2026 20:32:44 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06A2846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so18682166b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869962; cv=none;
 d=google.com; s=arc-20240605;
 b=OWx/ReJza8YZpAsKmACwDJPKa+hGsB29tfcXUq4DF6gUDniW2hdNITLHMvBrjfcKQC
 N9xgNnKs0CcCZlBm8nZC130LezfhvpPSX/nXuEjBVhHeOPRjzHWpo2BkFwl8Oqaqj9Wh
 RQjoacbCKaGD7Motgb/6fVqRQx0yxUoryj/rlhwSrlcB2JWR0oiWpf6gB3cfIjEn/TSy
 E4RbA7NiyT2/GJ33wRJiuT80qHleW9Bpkqpw7reFEtZUWc/rmlm3LtRgsjyMJq38Qn8Q
 HN8ur1U8M3lsKFnA+aKzHQ8rdPVWyaCUz1vpmRQVlDGfTo5+2oVhxxOCcDeGCVqyHq3v
 WwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T2w0rmmerPNXxBwkJTCYJPXWrDFX4LSaepKORi44mTc=;
 fh=ZSXGB0WL1g63NMiq65Je9X/TXbVo2/HfjGa4sXbWdA8=;
 b=DRoTmLPdRFrBSGPdREF60oberRViO0IUgIUPEsBHKKLfWd/BKPZl6ATGy2Vvg9a5OY
 1g+tk6onRqU0hB6E9BfW5Gz5Ix7tgd6YHDB4dw6nMFDZGOEsSie+Wa67AROqjnsCgE0m
 tNMQx+lPraAMzC6LDbBUc4BRHwx2YHx2GzYrWtb8aYk3kYIWW6iNkqBTNsiBnuUqagTS
 J67DQYVl5jRpqU0fHAOL+7yUOJJ7JYMQbGdjkrvEJ0HAFtSf0ZhtA4k6DigDiNg5EzEk
 oQ0T4skphVOXkK5xA9wJeC0EuLgKKknb6CUeKTImP+jvCbaS0kR6TGQJHsgjxuiO9Lgm
 cDcw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869962; x=1779474762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T2w0rmmerPNXxBwkJTCYJPXWrDFX4LSaepKORi44mTc=;
 b=dYX5j4+cPQ/Bs6hZmw3EXEq+YpQ42+TkEYWciv6spJ20IsmCwUjoZMjbDuOVYdUT9h
 yTwTAmbzoHXvaR1z5LzBX56u31aDUwl7oUHvEZ6+FbA8nQBZ7/uRAsYViae6N8tavXxF
 OcM7zpoyu/HpsKGYAqa/c1i/2XLHWadzzuhRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869962; x=1779474762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2w0rmmerPNXxBwkJTCYJPXWrDFX4LSaepKORi44mTc=;
 b=dU4qUPOIyy8YjwxZa7jcAOMeLepGwy+HQsnDmMK50a+FpmOLTWXwPzrc6yn/uLAgfb
 +srwMoo7zYw3VIRedt+Gu7VLBLwNL/lj5xPbvcOyFog7qH2DCGZAmShvfJM5QgPt+gr3
 uDFUuM8NSm7tknUmryA93Ww4v0J5dbHcHPXxilRStIa+g2psyCHoE7EP6Wnp5Iu11dNV
 pu6LC67PcW1rj2N1oU+Cb+5VFs//QeWvLdC43CrhCizBmJ84Xai5j+yjwetOUZVGPOd9
 9mCcOQQrhJ3NHzAuhP9yi9Kcxuk8lwoW3ukocewC77TZBZCMgHxraEFEDmLKb9BVBI/k
 68pQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JnZP2eYYjBxWjiSKPC43S/3Hn+M8/B7oZfUdfwH6PVkc10Ry76Gp6qofJQdtyBpmgTEZyJyY=@lists.denx.de
X-Gm-Message-State: AOJu0YyE1ZDHQHbqYN8sasJOgEHO9AaJV/wI6UzMLg59E9z5l94LkYRl
 nM5Kb21J6T/fyr5KqkaaEiySaCacDPGviEnhNiJ6QiGJA6hyjgFiYQI1UAcgFsHbjqlmorYNDF8
 +IZRRWOvBSenv4JbGHulgL8QOCYt7eK3t579nEeXe
X-Gm-Gg: Acq92OHhIRuyMU55KALMmQKQXbdeEpSqvJSXwJrbdJpX+lzUgYyky2vsFl5IJVcaz6P
 mTD66xPrnmppHuUsFbdGlz/bxjTw0YR6JA0vxo0G6rptq6yvnFwpaOIMuAvBcDjdyHicVrLtX+b
 QzB7aHLBs0LEkcHFItU+qEIoRPScLxxG5mCBOAbrXTAN8nduhRY5UZ9gE8RGAUttlm2BOY3A/TP
 qwZoT/ntQhTqjoidkhL9ATc5jCdp3jVfcf6iTktbgjRasvUzwDc1JyjB+0FjFlYxGL2EGtmmyJp
 HIg/Ag==
X-Received: by 2002:a17:907:3cd5:b0:bd2:6089:e72b with SMTP id
 a640c23a62f3a-bd5178f9640mr258345666b.25.1778869962260; Fri, 15 May 2026
 11:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
 <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
 <20260515182441.GI1858239@bill-the-cat>
In-Reply-To: <20260515182441.GI1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:32:30 -0600
X-Gm-Features: AVHnY4KlxEnTlEU2X3JYYUeMU3lZsjSr9eAAT2cCuosIg2wseRj7QmTCiwrZ_mQ
Message-ID: <CAFLszTjHaqck4gVDSiBw0M9V3yZLzUa8+EjaW94G9JcO=-Ny8Q@mail.gmail.com>
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
To: Tom Rini <trini@konsulko.com>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Fri, 15 May 2026 at 12:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 12:13:50PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> > > > >
> > > > > > A file like rm-cfg.yaml accidentally left in the source tree root
> > > > > > shadows the board-specific copy. binman builds the wrong YAML, the
> > > > > > resulting rm-cfg.bin may match a different SoC, and we end up with
> > > > > > the following error:
> > > > > >
> > > > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > > > >       Boot Notification response failed. ret = -110
> > > > > >
> > > > > > Move the board directory ahead of the srctree root so that the
> > > > > > most-specific match wins.
> > > > > >
> > > > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > > > ---
> > > > > >  Makefile | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/Makefile b/Makefile
> > > > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > > > --- a/Makefile
> > > > > > +++ b/Makefile
> > > > > > @@ -1682,7 +1682,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> > > > > >               build -u -d $(binman_dtb) -O . -m \
> > > > > >               --allow-missing --fake-ext-blobs \
> > > > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > > > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> > > > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
> > > > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > > > >               -a atf-bl1-path=${BL1} \
> > > > >
> > > > > Why do we need to look in $(srctree) itself?
> > > >
> > > > See for example:
> > > >
> > > > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =
> > > > "arch/arm/mach-k3/keys/custMpk.pem";
> > >
> > > That's not great, I'm sorry I missed it at the time. I wonder how easy
> > > replacing that key is with a non-dummy key. Hopefully it's done in a way
> > > that doesn't encourage checking private keys in to repositories..
> >
> > Typically we would use an environment var passed in from the Makefile,
> > as we do with BL31, TEE, TI_DM, etc.
> >
> > >
> > > > Also, people sometimes put files in the source tree, e.g. BL31 images,
> > > > in the hope that they will be found.
> > >
> > > That's also a bad practice and what BINMAN_INDIRS is for.
> >
> > Yes, but that came quite a bit later with the bintool stuff (2021).
> >
> > Anyway, with a bit of work I believe we could drop the source dir.
> > Would you like to look at it, or should I?
>
> Well, the first step would be getting some more feedback on how people
> override some of these files for example. Even more environment files
> seems like a bad idea and I'm not sure what BINMAN_INDIRS can't cover
> today.

Assuming you mean 'environment variables', we do need the actual
filename, not just the directory. We could have default filenames for
each entry type, I suppose. Some do already.

Regards,
Simon
