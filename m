Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA8E6FE57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579788641B;
	Fri, 22 Sep 2023 17:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K4OjKurN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4988667B; Fri, 22 Sep 2023 17:27:02 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6A986284
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53087f0e18bso2695037a12.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695396420; x=1696001220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9XCXrtWL7+qRrh6md7kkqI7c6rXxH1GuDjs2P68Gh9M=;
 b=K4OjKurNqKG6Jeu0eXRh/BHR/T8oGIAFMWvx1f8Jrfsfxhdo6WX/pEpN5jp4g3vNd/
 I6/ogPq64RxvtmbmiYgoIYqxuNX93+SGORlDW5XTlOfTtJepuykEHpI/3jQKcqQM/S5W
 jhFj/wlmLk6nZIgFT2JbzQh/upeFimmGUjLus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396420; x=1696001220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9XCXrtWL7+qRrh6md7kkqI7c6rXxH1GuDjs2P68Gh9M=;
 b=I8neY+gUO6Cqdr8ifIyVPzofWg3hQSx7KUlf1zZ+ovMD5dDCyMCeERUrM8+XguziU/
 OGrg9GOOUUfvaNQjQQsPHiukpj0LkcpN/LcokX36+fB5jZM2+x+SRbBK/F7pRik8D5Fv
 quOxeupscUmUKIpXPakdT7kjWYL9/Hdw/Et2MANDX0ZlD0jLtYy3rQFJN1E/Bfi1gOaz
 vfUbMy/VcpAAa6q4Xs2iQ3qbnbCMXm9iuam6qIOGgJ57vdMTYp9dsZgC/8dQbf0fxWa1
 GfyCD3ciaaPanh5ZZbxJKhrz/U4oHBM98tZjveWtx7ZI+sReOAMKwgI1fBFBSNlX18up
 F2MA==
X-Gm-Message-State: AOJu0YzlaFn9ZE+GKSHgdzySdf+/JwKzu3+2giFN9+AXsPhxH+l5Jy18
 /h68VVxF7yQWNhRo635gE4bn7862dQ+fc1x8pRrqvwEXj7Tfbm6PIFM=
X-Google-Smtp-Source: AGHT+IHmoQHLdyXn/XrbCJFQlek58oTKyqU7xYNclGO4StwMHaMDxVvbxM7WtWzCAzNYJqzCxDgEuQ+svBzH1bp1mHo=
X-Received: by 2002:a05:6402:193:b0:531:1f3b:cb36 with SMTP id
 r19-20020a056402019300b005311f3bcb36mr7770291edv.9.1695396420376; Fri, 22 Sep
 2023 08:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
 <e52f81a9-1006-ca4f-8501-7c6c1f6087e5@prevas.dk>
In-Reply-To: <e52f81a9-1006-ca4f-8501-7c6c1f6087e5@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 09:26:48 -0600
Message-ID: <CAPnjgZ09St0710SRLzubphauTYMtE1PyxAFWEKsupA2dAhXRbw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

On Thu, 21 Sept 2023 at 01:57, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 21/09/2023 03.02, Simon Glass wrote:
> > Hi Rasmus,
> >
> > On Tue, 19 Sept 2023 at 05:37, Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> >>
> >> In some cases, using the "external data" feature is impossible or
> >> undesirable, but one may still want (or need) the FIT image to have a
> >> certain alignment. Also, given the current 'mkimage -h' output,
> >>
> >>   -B => align size in hex for FIT structure and header
> >>
> >> it is quite unexpected for -B to be effectively ignored without -E.
> >>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >> ---
> >>  tools/fit_image.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Q below
> >
> >>
> >> diff --git a/tools/fit_image.c b/tools/fit_image.c
> >> index 9fe69ea0d9..2f5b25098a 100644
> >> --- a/tools/fit_image.c
> >> +++ b/tools/fit_image.c
> >> @@ -712,6 +712,42 @@ err:
> >>         return ret;
> >>  }
> >>
> >> +/**
> >> + * fit_align() - Ensure FIT image has certain alignment
> >> + *
> >> + * This takes a normal FIT file (with embedded data) and increases its
> >> + * size so that it is a multiple of params->bl_len.
> >> + */
> >> +static int fit_align(struct image_tool_params *params, const char *fname)
> >> +{
> >> +       int fit_size, new_size;
> >> +       int fd;
> >> +       struct stat sbuf;
> >> +       void *fdt;
> >> +       int ret = 0;
> >> +       int align_size;
> >> +
> >> +       align_size = params->bl_len;
> >> +       fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
> >> +       if (fd < 0)
> >> +               return -EIO;
> >> +
> >> +       fit_size = fdt_totalsize(fdt);
> >> +       new_size = ALIGN(fit_size, align_size);
> >> +       fdt_set_totalsize(fdt, new_size);
> >
> > Shouldn't this be fdt_open_into()?
>
> I honestly just copy-pasted fit_extract_data() and shaved it down to the
> part that does the "align the FDT part of the file".
>
> I don't really understand your question. Are you saying this doesn't
> work (or maybe doesn't work in some cases), or are you saying that
> there's a simpler way to do this? For the latter, sure, one doesn't
> really need to parse the whole FDT; we could just
>
>   open()
>   pread() length from FDT header, convert to cpu-endianness
>   length = ALIGN(length)
>   pwrite() the new length in fdt-endianness
>   ftruncate()
>   close()
>
> but I thought it was better to stay closer to how fit_extract_data() was
> done.

I mean that fdt_open_into() does more than just set the size (from
what I can tell). But looking further I see other code which calls
fdt_set_totalsize() so perhaps it is fine.

Regards,
SImon
