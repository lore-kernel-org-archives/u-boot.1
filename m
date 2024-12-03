Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8069E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85EF288A0A;
	Tue,  3 Dec 2024 01:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YblkvxlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F9789288; Tue,  3 Dec 2024 01:24:49 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A2A088717
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so717596566b.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185487; x=1733790287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SpkNVWo3XpcDdpNggop1I51dlSbBrchvWP+RFjYa/8g=;
 b=YblkvxlLhS2naH1gzXOrX8Pi+hxNQj9gQGsCmcuSLrWwAGZB+efvqmWDNUH+Ya6gZV
 PNHYpNSfxN3RwiNHEc3bSRhrFux3QHRdvOGf/Zq9Ttlor4FFwyOhERKJ0zt7LGV2Cgyx
 5vYS/RzNYaK5tXpmsqa16uez55g8i1+N4M++c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185487; x=1733790287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpkNVWo3XpcDdpNggop1I51dlSbBrchvWP+RFjYa/8g=;
 b=r3ga2sRqBOyBZloiO9TjI+BgKcyQT/A4Dt0JgJ4aLtnTW+1tZUJcg5Eha9Qtco6ZOj
 jqlA4SnTr/C03G/YsNgqygYXNGpd+7gI0OFMP49LGstKn4/G2ONe9WS12MngrhJY7HQP
 Sev0V0XHzRBG4DjMUYp+E3s5cj6jkR0QWZzgpwL31pzedyuIGMLQKvmMjzoZ6n2xH3CT
 zVGanFOiLmUCqVbGqdbClTn2kWNcw+/I+anTPAIkXAX2Sa/ckNsNrOwpYDNkTdoDd3hH
 J3VpPbjl29ZppRNrDuv7QflPNDEngQjgleY5pBeSqx6iD7S5cTB+A1b9NoqZgIe/iNFP
 XoSA==
X-Gm-Message-State: AOJu0YzOkYlFy1gTX8Lj/7e81S7JVyG5LRGoPlQtYXj5/aWC8zfoCQF4
 l0hiHiQ/j/335ES6GB9Gv8qG6XdTPkTEU1GjpXm/saWc+cN/0J4WGX+8Lh3m6q+ZDoGjWS9Vre+
 FWtrF8FIIPGPZU67N/mMYHTNFPFJ818MH6WF1bK3oEsciYBk=
X-Gm-Gg: ASbGncs+vIY8w5xNZzgO4+SFp5yw0H8ZCRdKzWf2M54oL5A/H1O7yAy7hdqWLoppuXh
 o2pG3kFe/11yCVDySTNYSsEQ/nu3yh+NR
X-Google-Smtp-Source: AGHT+IHtrYmwTJccnWlEgtULEGKET2xfrVfldAmeEhftEqkH3HfhOAQyCyRFABsB5xpe9w34g/z5vlkKVENKTpm8tzM=
X-Received: by 2002:a17:906:2932:b0:aa5:1ef5:261e with SMTP id
 a640c23a62f3a-aa5f7d4ed45mr17827766b.17.1733185487096; Mon, 02 Dec 2024
 16:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
In-Reply-To: <20241202201641.GF2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:24:35 -0700
Message-ID: <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
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

On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > Simplify a few expressions in this function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_memory.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index f1154f73e05..3b1c7528e92 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >                            (carve_desc->num_pages << EFI_PAGE_SHIFT);
> >
> >       /* check whether we're overlapping */
> > -     if ((carve_end <= map_start) || (carve_start >= map_end))
> > +     if (carve_end <= map_start || carve_start >= map_end)
> >               return EFI_CARVE_NO_OVERLAP;
> >
> >       /* We're overlapping with non-RAM, warn the caller if desired */
> > -     if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> > +     if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
> >               return EFI_CARVE_OVERLAPS_NONRAM;
> >
> >       /* Sanitize carve_start and carve_end to lie within our bounds */
>
> As I believe was mentioned in a previous iteration, please drop this as
> they aren't excessive generates a compiler warning, merely for
> clarification and should be kept.

I did this patch because checkpatch complained and I am changing these lines.

Regards,
Simon
