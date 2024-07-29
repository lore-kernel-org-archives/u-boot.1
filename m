Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96BAC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB99D88813;
	Mon, 29 Jul 2024 17:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MWfrbJBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323708855C; Mon, 29 Jul 2024 17:26:33 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C5C88808
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a1d0ad7113so239457085a.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266790; x=1722871590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=en7fnYdwTcOmTtstiLoSKdNE5zzQYsvkPzfMdfetJ9c=;
 b=MWfrbJBFmkIuKzt2MbsZw07k21X+k4ZGgF+CNoFKIIjcKcDh9fw9LvqS49Fxdb/6BS
 T9opfl878/H9yV/NA2vQjcukYtQv7E922VU38nKuisTGH+5OH36Unft6J6v+4kEsufQo
 DUItNIneGG8xyDm6VuaEzPyO1JK13YTowZ/bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266790; x=1722871590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=en7fnYdwTcOmTtstiLoSKdNE5zzQYsvkPzfMdfetJ9c=;
 b=Q7oUkLe+WI6bKhEQ8+xBwD3eQNtdH2xiu32CfQC4qEDx/gSYSE0xQk3FQ228EiPc3Q
 0lybiRtIKSseT8EVVhG0jIM1o+7aNhMyqopgp3v8BzpJzF3Qxn3759RDqlolLTun5o0/
 Ys5cKFbG7Dft9Nb7rVkIoKQwxOEM76RJZzYOVDY4RUNpAsRtHxTKe4fHPeo7aWoW96gO
 qaOrOzvWc7c9vqDguwmGxYIKVJfuNP10AoUayYXDyDl1acLrqO9K9/WGTgWQXKZ9mwBg
 0+R0w9OAEB+8nxVeSG7viLwmN5X4vb6xLRyc94iN3FtxxzYckcY+wcy3OsdsTxI6a/Zo
 kcbA==
X-Gm-Message-State: AOJu0YwBM/atZQvQs0TH6upcCHfB9R3XOLQyVsTpUxyzp10CKQngTYNF
 86Qf86KNIg34wHJxkKnu1ak7Amt6tpWZd2luJ5uHxAizM1OsLQmepi8C4dFb8oRDmkUVXbIT+xQ
 6T3ZmwJgvaHPbv1hvHJUB8JVUXp0vnRwufwNk
X-Google-Smtp-Source: AGHT+IEE10MKpOkWi/4rypVw3dFZ+ovJrcBSxAXG/YgwXvhk720zbqABbSk45JDDbxnKZsLjO0Aa86nHmzfUwLo8vBU=
X-Received: by 2002:a05:6214:d8e:b0:6b0:7427:875d with SMTP id
 6a1803df08f44-6bb55a0cc37mr84699526d6.28.1722266789927; Mon, 29 Jul 2024
 08:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-23-sughosh.ganu@linaro.org>
 <CAFLszTgriMAkLmeB18SyWKf-mGh=mbEHooKb5PyTsY2y25mrFg@mail.gmail.com>
 <CADg8p97T7p=EoXCQwaxrHais7PYCHD8mWLSE8QWY5xB6pZADYg@mail.gmail.com>
In-Reply-To: <CADg8p97T7p=EoXCQwaxrHais7PYCHD8mWLSE8QWY5xB6pZADYg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:26:19 -0600
Message-ID: <CAFLszTgJkk1hh2pJ4cCDqhv64jqNcD0AG4pAsRZpSCZsoAgr6Q@mail.gmail.com>
Subject: Re: [PATCH 22/40] lmb: init: initialise the lmb data structures
 during board init
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
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

On Mon, 29 Jul 2024 at 02:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The memory map maintained by the LMB module is now persistent and
> > > global. This memory map is being maintained through the alloced list
> > > structure which can be extended at runtime -- there is one list for
> > > the available memory, and one for the used memory. Allocate and
> > > initialise these lists during the board init.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  common/board_r.c |  4 ++++
> > >  common/spl/spl.c |  3 +++
> > >  include/lmb.h    | 11 +++++++++++
> > >  lib/lmb.c        | 20 ++++++++++++++++++++
> > >  4 files changed, 38 insertions(+)
> > >
> > > diff --git a/common/board_r.c b/common/board_r.c
> > > index d4ba245ac6..eaf9b40ec0 100644
> > > --- a/common/board_r.c
> > > +++ b/common/board_r.c
> > > @@ -22,6 +22,7 @@
> > >  #include <hang.h>
> > >  #include <image.h>
> > >  #include <irq_func.h>
> > > +#include <lmb.h>
> > >  #include <log.h>
> > >  #include <net.h>
> > >  #include <asm/cache.h>
> > > @@ -610,6 +611,9 @@ static init_fnc_t init_sequence_r[] = {
> > >  #ifdef CONFIG_CLOCKS
> > >         set_cpu_clk_info, /* Setup clock information */
> > >  #endif
> > > +#if CONFIG_IS_ENABLED(LMB)
> > > +       initr_lmb,
> > > +#endif
> >
> > Can you put the if() in the function, to avoid #ifdefs here?
>
> Will do
>
> >
> > >  #ifdef CONFIG_EFI_LOADER
> > >         efi_memory_init,
> > >  #endif
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > index 7794ddccad..38ac0608bb 100644
> > > --- a/common/spl/spl.c
> > > +++ b/common/spl/spl.c
> > > @@ -723,6 +723,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > >             IS_ENABLED(CONFIG_SPL_ATF))
> > >                 dram_init_banksize();
> > >
> > > +       if (IS_ENABLED(CONFIG_SPL_LMB))
> > > +               initr_lmb();
> > > +
> >
> > Still unsure why this is needed. I'm also not sure how it works, since
> > SPL allocations will not transfer to U-Boot proper.
>
> I am not sure if I get your question right, but we initialise the LMB
> lists, and add to it's available memory map, both in SPL and in U-Boot
> proper. These are being initialised for SPL separately once the ram
> memory has been set up, including the dram banksize values.

We can worry about it later, but we don't have a mechanism to transfer
the LMB from SPL to U-Boot proper, so any SPL allocations will go
away. I suspect that is fine for now.

Regards,
Simon
