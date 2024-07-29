Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37EAC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C1188791;
	Mon, 29 Jul 2024 20:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X3MN3np4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FEBC88874; Mon, 29 Jul 2024 20:08:34 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1167888791
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a15c2dc569so3506663a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722276511; x=1722881311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uzc9yktuWyo8Euf5QTGS9vXF8zqJmXjOJJRp86XgeW0=;
 b=X3MN3np48+yps+KUJqeRtL0qwZXRMlWzSQbc8B9Z+1wiopjwMczrEwUhYBDkV5lX13
 BXLntwogFqPNhI+s5wnOKfoR8Y3WzhYvSzjeH/TtQ/X1OumV5WDIcgtJA0HXrOxvOGhs
 QSNpnEiUD6xerc0FXayOopAtXGncW76W0+/DPj3vkmoGRh8TvzK1Hk+MHm6+L7p4bPDh
 9AdhdbD3aoAEFkmEMWL77MGG5lXFopw7dDk+7jnjnwO9xA0XOiNlStzDe4PAmtYlqwby
 +9bpz6fAQCIqbd5gXj8W2RrNF/7znY/N59efa9YKiLdR8QItqmPEHWHadlsmu95fS1jl
 Ms/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722276511; x=1722881311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uzc9yktuWyo8Euf5QTGS9vXF8zqJmXjOJJRp86XgeW0=;
 b=Jp8JRCWD1KzeXubIqwKMhptTubz9XHS43odrGh3rKcpZKkkEyeHUXWgNu1CubQ4psx
 Rn/0vDtuEY/zn65LgJkPyt97pHLHIoJojvS2iIIIXEfyICexPxgqtHptRf4FGyAtKwB2
 YWph+hNCjMCORefk1sL2ceTAGmZlgk7QepYA5gn0x8IcFcOSlUu6GgQskZH87x9XLxvb
 61T5nILWvL60zhKzV0Pnm5Hgps+L4WIKx/zxgVpIMbj85GWQSpZCq0vD8Ts+YRKBgM1W
 DSEy7kmAYqzTHG5WTAcUtzpUgw7+5Ssgldugd1Hlxo7q5crhEcTeu5XtHK9do36hDX7n
 CDMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH6nMjxFO6hTUL8AIjMPQOhiRnSrEKDWRoCnzTlLsj/JI26rM9Nh0Go+tjxRTcGi5CMlsCzf/vrDSC9MWwWpHMvq0s/Q==
X-Gm-Message-State: AOJu0Yzd8IGbSaKR0AAuqVF5RW7kouNEIEkbHfZDfJmY100mX9rqy3Lw
 aDQUiw915D016HwEMlLPF5zqluVr0EEUx9rBHbflAW6q8ZIQRulXPhvC6+vrTjhjpsgMMncZAIP
 LOnv7QGBqSmRPaXAs7tkD6+9ZxMVJMFas4UVkaA==
X-Google-Smtp-Source: AGHT+IEzvymFSpashjWfIBFgrfu4ICjSvETU3iuOyF7jI1uKAaEB/7z6WAty/cf1U/VwkdnuW92i9PkCn7InwB6PP1o=
X-Received: by 2002:a05:6402:4306:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-5b0212850d7mr7253350a12.2.1722276511424; Mon, 29 Jul 2024
 11:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
 <CADg8p95cc=d31LWXzThVY8L=iV_Cg4dnOpQVy81obZM-ejJzQA@mail.gmail.com>
 <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
In-Reply-To: <CAFLszThHu8xoF4AB0xdSWQzy9JC1ePkpGGg05+4zhbB85qtRkQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 23:38:20 +0530
Message-ID: <CADg8p97qEHSQBv189FvmgMaMTYNJyLLM=D51V4TX1=dk=mZr-Q@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Simon Glass <sjg@chromium.org>
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

On Mon, 29 Jul 2024 at 20:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 28 Jul 2024 at 12:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Thu, 25 Jul 2024 at 18:24, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > > >
> > > > > From: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > Use this new data structure in the utility function.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > >
> > > > This is rather big growth when we didn't already have realloc:
> > > > 05: lib: Convert str_to_list() to use alist
> > > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> > > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > > >                  function                                   old     new   delta
> > > >                  realloc                                      -    1120   +1120
> > > >                  alist_ensure_ptr                             -     140    +140
> > > >                  alist_expand_to                              -     136    +136
> > > >                  alist_init                                   -     108    +108
> > > >                  alist_uninit_move_ptr                        -      76     +76
> > > >                  alist_add_ptr                                -      72     +72
> > > >                  alist_uninit                                 -      48     +48
> > > >                  str_to_list                                204     232     +28
> > > >
> > >
> > > I am working on an implementation of lmb maps using lists. The list
> > > nodes are then allocated with calloc, which I believe is included in
> > > most of the board images. We can then compare the size impact with the
> > > two implementations (alist vs list). Thanks.
> >
> > I have worked on implementing the LMB maps using simple lists, and we
> > do get a good size benefit with the list based implementation. I have
> > used the script that was shared by Tom some time back to get the size
> > impact [1]. The readings are with 1) alists with realloc 2) alist with
> > malloc and 3) using linked list. These are on a RPI4 build, which has
> > LMB enabled. I have checked the impact on a xilinx_versal_mini config
> > as well, which does not have LMB enabled, and the size impact result
> > is best with lists. The list based changes can be checked on my github
> > [2].
>
> Thanks for doing that. It is quite hard to read with the LTO enabled.
> You can try with the -L flag and should get a cleaner result. Also see
> my comment about how you are using alist directly instead of going
> through the API...that might affect things.

I can post the results with the -L flag used. Regarding your comment
on using the alist API's, I don't think that has a bearing on the size
of the image. Using the alist_add() might be faster in certain
scenarios, but I don't see how it impacts the size.

>
> Anyway (once you are using the API), my assumption from my previous
> refactor attempt was that lmb would be easier to deal with with simple
> arrays, which I why I wrote alist. Is that true, or not?

Yes, using the arrays keeps the code on similar lines to it's current
state. But I thought that the main consideration here was the size
impact.

-sughosh

>
> >
> > -sughosh
> >
> > [1] - https://gist.github.com/sughoshg/d4f9bda8d8a33f715dab892738d192ba
> > [2] - https://github.com/sughoshg/u-boot/tree/lmb_only_linked_lists_v3
>
> Regards,
> Simon
