Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929A3C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 18:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C4F882D6;
	Sun, 28 Jul 2024 20:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uh6R3/Uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2CC88703; Sun, 28 Jul 2024 20:07:49 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5048C87D1A
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso31298221fa.3
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722190066; x=1722794866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PAfCm6mK/dZ1DrxT5Hw7lyHXtPW3SQytOQJG5BKlkPE=;
 b=uh6R3/UqSyqp9ye/hXpGxW40vNTL917fI5OGE/pPkT3NK2TLmcKc8SsSi8wbCy9pWC
 AAcbdYSbXl4czpVP85Eg/0VowKvdNZP7F9W9NUvQ9sVuvtM5LzntKppjZl5Tx2773Vck
 v8WJgLQ9QzxpHBYJ8x/remERNQb3N6FlfYyZ8WqSNMc7/O+iLR9zzMQ5WhyQqD4BBrEW
 uDMRN1hBPYyWkK3dvXf6uEqxrXBQksNK6+E261DnPMOo2tWdDgjOB1xCokUcLdv8svY5
 t2oLkoV44DYNZQznOaUjS70y1k06PLVRMcrmXcvGIzL+FGAYN/K66UYTlbay0kMwSmL/
 9uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722190066; x=1722794866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PAfCm6mK/dZ1DrxT5Hw7lyHXtPW3SQytOQJG5BKlkPE=;
 b=fsGkOAhG/s8GrxA7sbYbwaS3ExW9Woruizh4qy/6kMdxcbodzfOr0R6dEEBmklKziI
 47DLlWOGSYY1KWnu8IsHNe7Y90xPVXIOST4LxSoDtlgBslY00twOeUvHTi3YC942Qu+E
 lE6hJaafaf+2r1lwHiRs1uGZlk66cP8IGI/CHyJEINStqzM9FGXklfu6Ny9eJzp+stgJ
 K2YLQWOSHQR55hFHU/xodYUmjZbyge9YAjmnYJpJibbgeFIax/0ZBSzr24iJjOGDv4+L
 dXqk73BmdOutih3xO/MJKHRnzLmfenAiESVqjq89EOiL/yxd5zL1gY22VcrUCR0kbtol
 5aAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmfwflEGA/Y9NqEkTwMvHWH+JVxGy32wKsvPNLpjUev8hXajDopsqrtC2u0wGPsFn9Im51/ikERe8ClaDEosPWff/GHA==
X-Gm-Message-State: AOJu0Yw/9CxU6tFdW1a1vhvaiQiFtd0zE9UKBs7/Ma2s2RZT9WMSItOP
 PvS8/8nafOGISuC4za7qhBtXTPU1X8Q/553zgSXa0loxEyMiv9rbK5NRiMgTibvVU6xfsPO9CFW
 WgTS2r0xHnO1H/4X+TPFriJDLqryhLoke3C3wBg==
X-Google-Smtp-Source: AGHT+IHH18HjUlHn7Z11kUeKwZI6eLlAT1n/rqFxQlo7HclREMq4xxYHOIM9+b5/vUiBHoJU7yUyJcrhuAcmsZsB8/4=
X-Received: by 2002:a2e:740a:0:b0:2ec:568e:336e with SMTP id
 38308e7fff4ca-2f12edefd15mr36015051fa.1.1722190066179; Sun, 28 Jul 2024
 11:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
In-Reply-To: <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sun, 28 Jul 2024 23:37:35 +0530
Message-ID: <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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

On Thu, 25 Jul 2024 at 18:24, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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

I have worked on implementing the LMB maps using simple lists, and we
do get a good size benefit with the list based implementation. I have
used the script that was shared by Tom some time back to get the size
impact [1]. The readings are with 1) alists with realloc 2) alist with
malloc and 3) using linked list. These are on a RPI4 build, which has
LMB enabled. I have checked the impact on a xilinx_versal_mini config
as well, which does not have LMB enabled, and the size impact result
is best with lists. The list based changes can be checked on my github
[2].

-sughosh

[1] - https://gist.github.com/sughoshg/d4f9bda8d8a33f715dab892738d192ba
[2] - https://github.com/sughoshg/u-boot/tree/lmb_only_linked_lists_v3
