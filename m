Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F8E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E968967D;
	Tue,  3 Dec 2024 20:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBsp3FIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B279989185; Tue,  3 Dec 2024 20:45:54 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B90C8967D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so3179505a91.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255151; x=1733859951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/wwKnHlrrhFtggrRgH7Jk+wNOQK0l75ifLc8O43KmE=;
 b=hBsp3FIKdAcPn2yKMGvrOG3VmN0ZflvegK+4Cuv805sHJnnNrkBDvNeCxpialuH5LE
 s5Wfr8j1yW+Lqq2hz31VNYzylkdW4MrTV+000NGCn+5q76nTTaYjqcpT70GYh5ZemTlQ
 ZMkkpUIE+OAYHzhl1qSMXpsIcV904cFSl8DZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255151; x=1733859951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/wwKnHlrrhFtggrRgH7Jk+wNOQK0l75ifLc8O43KmE=;
 b=si+/xk/tMb8LANZIBzZgHFOljMPFGtGVW+MR1NLS2T9zl/UshX1QCZ1FyAIIDKZWpp
 dmGiRvzFvsTCO8KpI8ArvKLO55iRMLVj5Gk4+f3PwDrluPyo3yGJatLcuiqiglTqKhEI
 EqmU+GscBn1PTsYS4RNNkUC6zYRZvCA7D+AK9wNlNxEGpS3WDAbZ0DpXP21t4n9CRPbK
 pTnb2sdnVE7eaKr9ihFKilhzJaZu5+LdQvwYya+m+EPZROkmwbl1YmZ/jTdi2BsbEm7h
 /iFpwD1w4KJ7cTYFuDxqmKKdIZLN8OyeKDtQnn8MnwlmTzZp14bMtlKrlSYFdiil1aPP
 0a5Q==
X-Gm-Message-State: AOJu0Yz2gICL0wEQXf3nWEa1C/a5gmHtuWXiO8u3r8MjBLkAXsyWjdnW
 YeWpIlS/RLHyUlStjT4CJah/AnZ4XGhICLr8s0Ydd4jwwzrZJRlx/QMyFESl1m+YjjEw+zIvYM8
 rk180PLNj5pRcZ1i1iRH8acnF7KZV/QUEQSou
X-Gm-Gg: ASbGnctmARoSmnggnP57vCyihR/quqUZyOfEP3XxIWs5pT9frTGAQa8h16+u/fuO3XC
 uJBiO8DKgZouIjdwaKakWMgKPAt9sW9Ew
X-Google-Smtp-Source: AGHT+IHZ0zdfwBBxuaEVB10xARpqRxTh0WdAntvSxgiDiyPImLMBtUn+UXS37kZ1vMxfLsf7e3KURfRvieIK6dUliiU=
X-Received: by 2002:a17:90b:4fca:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2ef011e6829mr4695467a91.1.1733255150810; Tue, 03 Dec 2024
 11:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
 <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
 <20241203003719.GN2457179@bill-the-cat>
 <CAFLszTh91eW5yQgQHLDVfe67GYw_f9-jzWmdu9pDTaEvNEG2Bg@mail.gmail.com>
 <20241203140400.GU2457179@bill-the-cat>
 <CAFLszTjFta03nSumT595tGYitx9JmuQv-F7og_Kr4LkH=zA-Mw@mail.gmail.com>
 <20241203160258.GX2457179@bill-the-cat>
In-Reply-To: <20241203160258.GX2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:31 -0700
Message-ID: <CAFLszThtuv6DcsLM=TaGtUuS+0HH+yWCu5aah=E572dC+stCsQ@mail.gmail.com>
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

On Tue, 3 Dec 2024 at 09:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 08:53:31AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 3 Dec 2024 at 07:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 03, 2024 at 06:46:11AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 2 Dec 2024 at 17:37, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2024 at 05:24:35PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > > > > > > > Simplify a few expressions in this function.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  lib/efi_loader/efi_memory.c | 4 ++--
> > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > > > index f1154f73e05..3b1c7528e92 100644
> > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > > > > > > >                            (carve_desc->num_pages << EFI_PAGE_SHIFT);
> > > > > > > >
> > > > > > > >       /* check whether we're overlapping */
> > > > > > > > -     if ((carve_end <= map_start) || (carve_start >= map_end))
> > > > > > > > +     if (carve_end <= map_start || carve_start >= map_end)
> > > > > > > >               return EFI_CARVE_NO_OVERLAP;
> > > > > > > >
> > > > > > > >       /* We're overlapping with non-RAM, warn the caller if desired */
> > > > > > > > -     if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> > > > > > > > +     if (overlap_conventional && map_desc->type != EFI_CONVENTIONAL_MEMORY)
> > > > > > > >               return EFI_CARVE_OVERLAPS_NONRAM;
> > > > > > > >
> > > > > > > >       /* Sanitize carve_start and carve_end to lie within our bounds */
> > > > > > >
> > > > > > > As I believe was mentioned in a previous iteration, please drop this as
> > > > > > > they aren't excessive generates a compiler warning, merely for
> > > > > > > clarification and should be kept.
> > > > > >
> > > > > > I did this patch because checkpatch complained and I am changing these lines.
> > > > >
> > > > > And checkpatch is not the authority, it's guidelines.
> > > >
> > > > Agreed.
> > > >
> > > > > I believe the
> > > > > review comments are "no, these should stay". Please drop this patch.
> > > >
> > > > Just so I can figure out what to do here, are you saying:
> > > > - merge this patch in with the one that produces a checkpatch warning
> > > > (i.e. remove brackets so resolve warning), or
> > > > - drop this patch and ignore the checkpatch warning in the result
> > >
> > > Yes, please just drop this patch, I only look at ERROR from checkpatch
> > > when merging things and then it's a matter of what the error is.
> > >
> > > > I don't really mind about this, obviously. But as I suspect this
> > > > series is not going to be applied to your tree anyway, I'll await
> > > > events.
> > >
> > > Yes, if you're not going to be addressing most of the comments you get
> > > this is going to linger in, well, whatever it is you plan to be doing
> > > exactly.
> >
> > I am keen to address comments, so long as they are about the code,
> > rather than 'we don't want this patch'.
>
> We don't want this patch because the parenthesis do make reviewing the
> code and order of operations clearer. This was the previous feedback.

Given that this whole series is being rejected, I don't think this
feedback is critical.

Regards,
SImon
