Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA32E64AA9
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF4F89328;
	Tue,  3 Dec 2024 14:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/Trvk+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496A389588; Tue,  3 Dec 2024 14:46:26 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3504E88E35
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffdbc0c103so78056821fa.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733233583; x=1733838383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R0wAnEwdMnxyHJzABkOiE8zDCFF3KyF2/iKS6fntt+k=;
 b=a/Trvk+Oh/d4nejgCuWNiimWEnC4oD1kYDw1+9Pm8oXDbBZbItXyqTeJnYcd5xXzYV
 z9HeeNne5u1N9Xp496Elgkc+eieYsvu4uX7iCuM8Va+inl7kJWDACkdKoyXQIhdJWqEq
 Cjb2fXyhxTLKotItrfb8i69FVovxbFgm67PwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233583; x=1733838383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0wAnEwdMnxyHJzABkOiE8zDCFF3KyF2/iKS6fntt+k=;
 b=Jd5QJNqQuOvxzn+8JsEnioxBdKcxTiQpgjFo00t0K5pKVQXrMMj+PB3kAFpoD8OrcH
 bGLpPlMC+JDKiDqbTkzA9xzoLRCGan74T/50Yu2EoN+xrfcWBuSsJKlldPkzLHIpnPwK
 6hW9RkcCM2I9aDnO/ZZgoQvaWwTu0yC0PGAt6SXc8OiIDFQqv3RORdMdtryK1tu7jYpQ
 CZ3noAyS6Y/UdX1rNfFvvZGCL6Yih9gJkI8QNflAGjmhghrZd0lMWFYksiXcCPQTUH4c
 6XQOZDzyckEYy0/4uatWfPfGc8wXiCQ4yd+HQZSPKetByhOPH743vc1j+boS/U4d3PnG
 On1g==
X-Gm-Message-State: AOJu0YxwI3ETRx1G4DcX5yAWPrO8coDPBJtw9f012JdFjywy87pv8+UY
 zGa7vbKJUuSaX3WALNF0HZ4eTFkBHRtnRXHIEnk0ZUQJ9N4hqDBD1R/uQJO8YRdzwF99WO5jjRB
 YilDngEvWHM/LrIkgCAZh3c4xXD5QznOGHRk39F0TUOIJjmY=
X-Gm-Gg: ASbGncsmyBWtxnMC3ZcMIcF5ChbqejG5AnUc44K8oDdchYSDGjmIqog3RafbVTQrTbv
 D3iKmqNyZ+BZet7hqKxqcnxoOtCO5PxvA
X-Google-Smtp-Source: AGHT+IGU7HlQSrEJgJP7o40EePyDpZliI8abuMUGl0+K6KRsveJ0yLs3H19D+c1rxDdzl7hN+uN7BxtfQqE5hWx/Z88=
X-Received: by 2002:a2e:a5c1:0:b0:2ff:95d7:9ed2 with SMTP id
 38308e7fff4ca-30009cfed00mr25983721fa.32.1733233583493; Tue, 03 Dec 2024
 05:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
 <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
 <20241203003719.GN2457179@bill-the-cat>
In-Reply-To: <20241203003719.GN2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 06:46:11 -0700
Message-ID: <CAFLszTh91eW5yQgQHLDVfe67GYw_f9-jzWmdu9pDTaEvNEG2Bg@mail.gmail.com>
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

On Mon, 2 Dec 2024 at 17:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 02, 2024 at 05:24:35PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > > > Simplify a few expressions in this function.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  lib/efi_loader/efi_memory.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > index f1154f73e05..3b1c7528e92 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > > >                            (carve_desc->num_pages << EFI_PAGE_SHIFT);
> > > >
> > > >       /* check whether we're overlapping */
> > > > -     if ((carve_end <= map_start) || (carve_start >= map_end))
> > > > +     if (carve_end <= map_start || carve_start >= map_end)
> > > >               return EFI_CARVE_NO_OVERLAP;
> > > >
> > > >       /* We're overlapping with non-RAM, warn the caller if desired */
> > > > -     if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> > > > +     if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
> > > >               return EFI_CARVE_OVERLAPS_NONRAM;
> > > >
> > > >       /* Sanitize carve_start and carve_end to lie within our bounds */
> > >
> > > As I believe was mentioned in a previous iteration, please drop this as
> > > they aren't excessive generates a compiler warning, merely for
> > > clarification and should be kept.
> >
> > I did this patch because checkpatch complained and I am changing these lines.
>
> And checkpatch is not the authority, it's guidelines.

Agreed.

> I believe the
> review comments are "no, these should stay". Please drop this patch.

Just so I can figure out what to do here, are you saying:
- merge this patch in with the one that produces a checkpatch warning
(i.e. remove brackets so resolve warning), or
- drop this patch and ignore the checkpatch warning in the result

I don't really mind about this, obviously. But as I suspect this
series is not going to be applied to your tree anyway, I'll await
events.

Regards,
Simon
