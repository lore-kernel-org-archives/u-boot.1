Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E541F34C4E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139E58407D;
	Mon, 13 Apr 2026 15:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X9w0rXHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7F38421D; Mon, 13 Apr 2026 15:16:35 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C928E83DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so547870566b.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776086193; cv=none;
 d=google.com; s=arc-20240605;
 b=aT8d+mwNPhEq1kDvq9k+/UQLJNdILrBVZferbh6cumiihjKiMfqBgNbi5ox2xm2lUs
 W6XQljNtNREwQ/u7m/5tTMNieGMAqzVnQSu87EIgmWBqwW4kzfDiomqP3UuOESGm0q0y
 a0Jeom5g+lphLNV9j+aLSm0lqwA0EKZX1Ei9HGBkXhg9Yxf42F3Aa/l/YUvR7yOQh3w3
 biOy1Am3/sX0NduBp6oNfqtDe9hca13BNejJvwsnQ5Kig6VIHkpWiE7zsKDhyzPeq5Hr
 EsqI7wHZKdS2xFcQZ+ghWeCjhLYN5cTBz3Z6dq2mSTmveTK7onm3jA3CqhX4cAApyI6U
 RvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZS6huNxE88/LGhVtCridH9Kt8eJsVcoUjWK1f4yIe9o=;
 fh=hwc0z0Mp1uXaDJbAcaNfs+adm+vgVJQt+uwEfvCRJQw=;
 b=Pv3abI1QDufZl8A/yxNsGCroTxocUL5+ZTw9Pw8MABCrbYq9N583tc9lSLkRJ1UCoZ
 uexJeLgP2dVG52dv+8yfI2y5ReiHOyXZRTxZAT8mnkkBE3BDPvBDQj8Pq4DN2E0VJ9Fh
 FY4Vz04mPDtXykruOhiEN+IVIsgDHh3o8JB/aCwPYv01bq0EwPES2yb+h2wztbZ4QLup
 7imY7xJw4iPBYJXn2DXmUNbmNlifIpea+GzPaYyAwrBbn4ATczUWcBeGI2KUFFkvVm3L
 iCi38qdWbm63/bFkUwkDF8SJl1mCm8beXwS4mhZzvBJhET0Hii9O7ueiEV+cJQ7cebun
 rEdA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776086193; x=1776690993; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZS6huNxE88/LGhVtCridH9Kt8eJsVcoUjWK1f4yIe9o=;
 b=X9w0rXHZdBx56/mdL6tyH++60n/Ypf/lrmK+kSPJEO0ea2MMIm8x3FWXOrZfu2yn04
 A8jhb1lZlEwX7iV/3ihk0bjPMlXVR3f8q8K50hI0DL2qdKp9ATeRa2EtBWiYLijcaWRL
 W+t0p5qh0Auv2xjNWWn4Ih8cSbkbuShWg4zfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776086193; x=1776690993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZS6huNxE88/LGhVtCridH9Kt8eJsVcoUjWK1f4yIe9o=;
 b=AWirNqcdPx5cdGskAMtOFALdczsgscXO0j7Omt12CCSsX4ecAKvFNIx72krEFoGULF
 LicAE+1kW2EnN2ViQnsH8zOrOrC1TFIgOz3aPxppDPviz6NrAnt9Z3kkq7oVYqEwkya3
 i18bedLHZoqO1jF9NPouPkT+Jb5qiymcWEzH3aL5IL9Rg8V0xWbJCLCozJ0fw3qq+ruV
 2sXwYTHej3fnhX2Gsl7U8/nNg2JrgZNBQ6dsgxSn6ovHYEsTrxCjQfrxkANrguashkwz
 /4AxJ1rmfQ5lorBjxKh7AOLdy38jjGIKsZksKUjO+akRHreQHSqxu+fpJ5GjE4bhjIq+
 GliA==
X-Gm-Message-State: AOJu0YyZtOxtWcCd5p/SQQZWHDowfNGmNZdSl4inFjetlKir30aqb/RZ
 1V4u+4ae+HBLBXjfpenB7dTs4kFZCgu+m6/W9SAuxFfrcMXR3DxwmOagmYHNbQ17wyrH5eQ0ub3
 CtN5txf7nwIzhYKZJtq9b7SKzHl+Si84/4E7FE1Bs
X-Gm-Gg: AeBDievk8eLMKIJGvc/xrhQ1NO8SekV174zu4jjUVbxoAc3AdtWV/nFbyKOwTU6JOnE
 NtvmIvHKeePZnXtZCpKiYB6aJeFE76JsgkImM3lx7c1LDUMecvyrNtDfo5wPV7N1zYxU3z7+dLd
 XajjTxGxsKPS63Ny7qMyGZuzq7vzFk990+4MGtwniq/Vcsoev56UI60d13992p8RneFwhnetc8I
 fKr8TssTkfPdnYvCCLFXJDbJwdteH02eNzHB8SKnNu6+/SeYrA6TuntSudQOqqTo0f4/Ipv0/fs
 tmYC5A==
X-Received: by 2002:a17:907:25cb:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9d7248ab3bmr693310266b.18.1776086192776; Mon, 13 Apr 2026
 06:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260405104224.530051-1-sjg@chromium.org>
 <20260405104224.530051-2-sjg@chromium.org>
 <874ilkpqgt.fsf@prevas.dk>
In-Reply-To: <874ilkpqgt.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 07:16:21 -0600
X-Gm-Features: AQROBzD0Y3fmqr0jUH1JA9S3qvZ5GfLwwC3yd-MFqAdfmQqbuMc85aEj4uhC-is
Message-ID: <CAFLszTg2n4b9r3G8YK-E1OW-8+S_a1LwWEUghAnKyU1g4Rm_iw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: Use if_changed for font and splash .incbin
 rules
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Thu, 9 Apr 2026 at 01:01, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Sun, Apr 05 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > The generated .S files for fonts and splash screens use .incbin with the
> > full prerequisite path. When building with O= this bakes an absolute
> > path into the .S file. If the build directory is later used on a
> > different machine (e.g. in a container), the assembler cannot find the
> > source file.
> >
> > Follow the existing DTB convention: rename the object targets to use
> > compound suffixes (.ttf.o, .bmp.o), switch the pattern rules from
> > direct $(call cmd,...) to FORCE + $(call if_changed,...), and register
> > the new suffixes with intermediate_targets so that kbuild loads their
> > .cmd files. This lets if_changed detect when the recorded command
> > (including source paths) has changed and regenerate the .S file
> > automatically.
> >
> > The EFI rule is left unchanged since its prerequisite is a generated
> > file in the build directory, like the DTB and DTBO rules.
> >
> > Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Use if_changed with compound suffixes (.ttf.o, .bmp.o)
> >
> > Changes in v2:
> > - Move U-Boot .incbin rules to Makefile.lib-u-boot first (previous patch)
> > - Drop the EFI .incbin change since .efi files are generated, not source
> > - Use per-file AFLAGS instead of modifying a_flags in Makefile.lib
> >
>
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index e625f99986e..067c38c4cdd 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -438,7 +438,9 @@ intermediate_targets = $(foreach sfx, $(2), \
> >  targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
> >          $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
> >          $(call intermediate_targets, .lex.o, .lex.c) \
> > -        $(call intermediate_targets, .tab.o, .tab.c .tab.h)
> > +        $(call intermediate_targets, .tab.o, .tab.c .tab.h) \
> > +        $(call intermediate_targets, .ttf.o, .ttf.S) \
> > +        $(call intermediate_targets, .bmp.o, .bmp.S)
>
> Do these extra lines need to go here, causing a conflict with the next
> kbuild sync, or could one instead add
>
>   targets += $(call intermediate_targets, .ttf.o, .ttf.S) \
>              $(call intermediate_targets, .bmp.o, .bmp.S)
>
> in the new Makefile.lib-u-boot? I think that would make more sense. But
> there may be some ordering of makefile includes that makes that not
> posssible.
>
> At the very least, I think the additions to targets should go in a new
> 'targets +=', just to separate them a little better from upstream and
> making it pure code addition instead of having to modify that last line
> to add a continuation marker.

OK I did the latter and updated the commit msg with why the former can't work.

Regards,
Simon

>
> Rasmus
