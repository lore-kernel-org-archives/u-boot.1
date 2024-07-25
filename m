Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83273C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E08A87C86;
	Thu, 25 Jul 2024 16:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UJzJXanc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3478088005; Thu, 25 Jul 2024 16:00:09 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EEB187C86
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso1433842b3a.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721916005; x=1722520805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VjbAs5bXl0enMfF0HR89il7BM/GAr3u5sF2LEm9a2r4=;
 b=UJzJXanc3GnghhUcDSUm5FqMBB1+9Gh+B2JM7h5iqcc61OXD7b5VNEiYzS9kF9CmLt
 BjSE3IXqWoLdS+zhO1tx5AlptKL0dRgroG1zrULDv9oHe8caiKtuPlI3hW9l8kMBOcnl
 YH9glSgPB+TukejjM42Z5YU8tscP/KxZK4rww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916005; x=1722520805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjbAs5bXl0enMfF0HR89il7BM/GAr3u5sF2LEm9a2r4=;
 b=uY5cZefo/8wA3qzs9hb/IU7apIJvN8Lm0akoA8SE84O/hM/WlyQsZ5uirZKeZmgOs5
 4wnqJiVSpZyeoR+25GSDMHQZTOFLcivmuMnyTlSFbAJ07rCbYR8ulgPm5+ZC222UzgvA
 1Q0uQLMWwbql+mpzhuv01cNDkCCpDY+qwAsMUUHyLlh8j4mdcnFa1iZ3dgtAfR7Z3ZBX
 +iQfT2SRUjr6k80glB/8GCNhpqq+zJWfTNmwZiwZwnP5MI/wxSo5QgPwP/xTcsJB8QPH
 CYA1gmJ9+hv4E0JZSuX2JtzUzbUEa8AMbVINZV9tRm25FvPzWD6RzY/EFRGaCrbon9lJ
 WwNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2r5i5N0uJONm7bxfFryvv1AGwkix+2HeToGN5LvMoWntQWY1kUlvt8YW4pv2RFZ7bpj3EU+4fKrXecpNJaOIA4YtJdg==
X-Gm-Message-State: AOJu0Yy0Y7rSP5dtglDvS+fBIAEvy5Yd+Gv83g2wXK4a2+NNHsBPKxGx
 9+QlrkXZcv6zSPZub6MpzYhEftqOE8c8LiIjrdLnZi00H6q4iZ0/aKU1SBupfmsnZmatKLWB4Zo
 QMx467fPancuyK8ysxY2pnPKG5rnpzBl1UiIz
X-Google-Smtp-Source: AGHT+IF95xyU4gOnAxaep1hh3W68aMcGoNWqRNsvGDOsIQxAfPec2DHz4FuFyENCAtAPRDtS30p0GjuuGhI2VvUYMTo=
X-Received: by 2002:a17:90b:17cd:b0:2cb:5bc9:e3e1 with SMTP id
 98e67ed59e1d1-2cdb93878e5mr9142699a91.2.1721916005396; Thu, 25 Jul 2024
 07:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
In-Reply-To: <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 07:59:52 -0600
Message-ID: <CAFLszTiYt6hPf7YuR5wqr6WjoX1BSKrNtKGdx66qD_g5L9hF7w@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Thu, 25 Jul 2024 at 06:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > Use this new data structure in the utility function.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > >  1 file changed, 19 insertions(+), 16 deletions(-)
> >
> > This is rather big growth when we didn't already have realloc:
> > 05: lib: Convert str_to_list() to use alist
> >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> >                  function                                   old     new   delta
> >                  realloc                                      -    1120   +1120
> >                  alist_ensure_ptr                             -     140    +140
> >                  alist_expand_to                              -     136    +136
> >                  alist_init                                   -     108    +108
> >                  alist_uninit_move_ptr                        -      76     +76
> >                  alist_add_ptr                                -      72     +72
> >                  alist_uninit                                 -      48     +48
> >                  str_to_list                                204     232     +28
> >
>
> I am working on an implementation of lmb maps using lists. The list
> nodes are then allocated with calloc, which I believe is included in
> most of the board images. We can then compare the size impact with the
> two implementations (alist vs list). Thanks.

This is for use with EFI, which is very large, so I doubt it is worth
it. The alist code is simpler to work with and will be used in UPL and
likely some other areas.

We could provide a variant which uses malloc()/free() instead of
realloc(), as I mentioned/ The impact then would be very small.

Regards,
Simon
