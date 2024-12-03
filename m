Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48094E74AC1
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 15:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A29889651;
	Tue,  3 Dec 2024 16:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A9sI2QKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9835A8961F; Tue,  3 Dec 2024 16:53:46 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74A289505
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so796306866b.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 07:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733241223; x=1733846023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5CiBsexxBif5I5simurwgC5Xw0wHu/owvHSvqSzbw30=;
 b=A9sI2QKanyQm1/7WgAzjdcKZGROL4xXvUAozhmO8isxIThJcZwnPA56KQmmJLCUwPJ
 fsmK+kHy+juIby6gW+F30MEXHnxL1aJyMOKpywnEQOibpjHPIbcCwOYPLwr2bnSs/Uut
 SDTxduOezPmpjAKgJ6FrjxoaG1Kwe6b6cz1uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241223; x=1733846023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5CiBsexxBif5I5simurwgC5Xw0wHu/owvHSvqSzbw30=;
 b=lqhqBGcoBHCDqafn6kIH1gzh2WBPnUNgLGTZ4W3DyAM8vxmBFKaH54w9b9oaLlj6xO
 Ws4ISgjEnqGOPIpIRKg5GsWfsLVGK+2A4rKKR/742Ri1pFX3Wwms3qSzTCL2mzrSyeGC
 cxBhyv5sHghI9h7QEIp9Epyq7JPnd8JeyRB6AtAXEw0zTcXrZE1PNU1IPwrBWCpJuaaf
 smoP4QC/nMSshvErGLjcUg/Y+LbT+LsuDj0KZ+vUAXSPpFnfdA0E5RgjSFoOk4V+cg6L
 DqVBbDs2EuLIgRTr5ZXn+mVfHIlupR5opwm1/Rz6QXLMzpRSB/5HOHMulXrJEr5wr2pf
 KEAA==
X-Gm-Message-State: AOJu0YzFD/my/fiazOgNAIQR7xdOVyhMzzHdRpfco50+/jG1dv9Ux9nB
 /Xy3UYTtcMu+H7a2udrqhoZpEHpeM6/tFYvNzxAL2iKRUbnzmtv/8Z6l+W/2IUNFWydLq2TzSp5
 +nSyj0LLqV3WNkaTDB3yve74z0dvIc0wxgUXi
X-Gm-Gg: ASbGncsFhOVHgwmdiJ5zTbh1VMBLoSkEPcWcJbdNE0/lQiot6GwdiNpziKByq6R9CjO
 fvgdJ6VpMP0kQTJKJxvlujch8UqHY6kb+
X-Google-Smtp-Source: AGHT+IF/M3zyyhGeNDV+rCKBZps+helK9HyMWTj+NJxS6n8H1cWm79vlh9V65bpPSau+/1zsGVBntzH+RwJBfQ3wafk=
X-Received: by 2002:a17:906:3110:b0:aa4:9ab1:196c with SMTP id
 a640c23a62f3a-aa5f7cc2a0fmr228618866b.9.1733241223396; Tue, 03 Dec 2024
 07:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
 <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
 <20241203003719.GN2457179@bill-the-cat>
 <CAFLszTh91eW5yQgQHLDVfe67GYw_f9-jzWmdu9pDTaEvNEG2Bg@mail.gmail.com>
 <20241203140400.GU2457179@bill-the-cat>
In-Reply-To: <20241203140400.GU2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 08:53:31 -0700
Message-ID: <CAFLszTjFta03nSumT595tGYitx9JmuQv-F7og_Kr4LkH=zA-Mw@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Tue, 3 Dec 2024 at 07:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 06:46:11AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 17:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 02, 2024 at 05:24:35PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > > > > > Simplify a few expressions in this function.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  lib/efi_loader/efi_memory.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > index f1154f73e05..3b1c7528e92 100644
> > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > > > > >                            (carve_desc->num_pages << EFI_PAGE_SHIFT);
> > > > > >
> > > > > >       /* check whether we're overlapping */
> > > > > > -     if ((carve_end <= map_start) || (carve_start >= map_end))
> > > > > > +     if (carve_end <= map_start || carve_start >= map_end)
> > > > > >               return EFI_CARVE_NO_OVERLAP;
> > > > > >
> > > > > >       /* We're overlapping with non-RAM, warn the caller if desired */
> > > > > > -     if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> > > > > > +     if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
> > > > > >               return EFI_CARVE_OVERLAPS_NONRAM;
> > > > > >
> > > > > >       /* Sanitize carve_start and carve_end to lie within our bounds */
> > > > >
> > > > > As I believe was mentioned in a previous iteration, please drop this as
> > > > > they aren't excessive generates a compiler warning, merely for
> > > > > clarification and should be kept.
> > > >
> > > > I did this patch because checkpatch complained and I am changing these lines.
> > >
> > > And checkpatch is not the authority, it's guidelines.
> >
> > Agreed.
> >
> > > I believe the
> > > review comments are "no, these should stay". Please drop this patch.
> >
> > Just so I can figure out what to do here, are you saying:
> > - merge this patch in with the one that produces a checkpatch warning
> > (i.e. remove brackets so resolve warning), or
> > - drop this patch and ignore the checkpatch warning in the result
>
> Yes, please just drop this patch, I only look at ERROR from checkpatch
> when merging things and then it's a matter of what the error is.
>
> > I don't really mind about this, obviously. But as I suspect this
> > series is not going to be applied to your tree anyway, I'll await
> > events.
>
> Yes, if you're not going to be addressing most of the comments you get
> this is going to linger in, well, whatever it is you plan to be doing
> exactly.

I am keen to address comments, so long as they are about the code,
rather than 'we don't want this patch'.

Regards,
SImon
