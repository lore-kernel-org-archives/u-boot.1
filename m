Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95112C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 08:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B41885E1;
	Tue, 11 Jun 2024 10:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yGJQS4SK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D56885EC; Tue, 11 Jun 2024 10:50:56 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6158332E
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 10:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c7440876bso1000674a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718095853; x=1718700653; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZURMeBsm3U82KPUq4cRvsaz/m8be/dtghf9SYzj5oO8=;
 b=yGJQS4SKpjfBYmlPSAZhZ2QtFgegASenxSGZKnUoVjRQ4HcYpmbDytVURsLI6yl7Zu
 TkRpeMyzC3aGZwvUxoskcePzo3YdPaWnD7SjQKGk1CYeLbF4zhDzUGKpLSKxAMv6PWvq
 dYo3wQJjXMsuMN9sbupdA71iMTnkEg2FPIR6aeV3twOC50zBeokxvRO88yyp8rNVf0XU
 Z6At1I/m1kPK+0g9/+Qx1IH+dFVFvAFhSdQUFhm553oNY2K9dFrp72jjvMiWLPdDfq9r
 fpwFif41vDcP3lGaPFxLXjDUf2MIfaodTxtoZjwyaIVcc8oi9CAmhond03SNLhYDs8fX
 X4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718095853; x=1718700653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZURMeBsm3U82KPUq4cRvsaz/m8be/dtghf9SYzj5oO8=;
 b=I5TYt7mTIY/zN/deEDu7vMaCGC2BVeAhTh5IXoIMqjtbL/1ZkXIagz/euXXNipiPPL
 MHOhzFUuK5X8XYUAuR41J+dZhefuYgTX/7oNz6z9yVLYCzgKL2yy121hSsI/UG1L7nG5
 cncDDBgE3AUBzmiEQqYkV9hm01fhT3FgKuhGCv+RjfL0kpPVJJpqqsAYgseW2CBjgSqL
 YZYbup7lmRJ7dQJyFa1M3nmsiCohkvzT0S55n0LAM07BCzATWmdQywT0BgtE0oLi4zBE
 iCW/411d8RIp4671Jr4b45/SHf/ROidPT4iHOc0BYtJc7Lh0hGsP8l/CEip567u4kuhl
 qDxw==
X-Gm-Message-State: AOJu0YwxrRkpRrbIoxQ1+Lu/HKRlUMfH2S/SBLA9S2pVtYxe66BeXhCt
 sgRhSB4egVJVihNhfvGlth9XqSJg+jgMHv30JSUTuxniZMbdyrRuz6rUlAtZ3jwSfxXkpEVZuP1
 YkZnn3Y472HFjHiz2jNxNxNZjSn08iLgVSWoROw==
X-Google-Smtp-Source: AGHT+IEG6HsE+2TWoU/3HukxcR94Q9VEoB8WlF3PGTzIxx0/vNFALCLD3SDTMSZbX4iJ+ylvOUe4WFxsc66oSC6vM7M=
X-Received: by 2002:a50:9b42:0:b0:57c:9dbc:2b6e with SMTP id
 4fb4d7f45d1cf-57c9dbc2cdcmr190428a12.42.1718095852784; Tue, 11 Jun 2024
 01:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-9-sughosh.ganu@linaro.org>
 <20240610173102.GW68077@bill-the-cat>
In-Reply-To: <20240610173102.GW68077@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Jun 2024 14:20:40 +0530
Message-ID: <CADg8p95aA1h_0XgANyHjXFKpPjQdKvrH5jcTKL9Gu8ouhp-gqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/31] lmb: replcace the lmb_init_and_reserve()
 function
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Mon, 10 Jun 2024 at 23:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jun 08, 2024 at 12:22:17AM +0530, Sughosh Ganu wrote:
> > With the changes to make the Logical Memory Block(LMB) allocations
> > persistent and with the common memory regions being reserved during
> > board init, the lmb_init_and_reserve() API can be removed and replaced
> > with a lmb_add_memory() API, which adds all the available memory to
> > the LMB pool.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  arch/arm/mach-apple/board.c          |  2 +-
> >  arch/arm/mach-snapdragon/board.c     |  2 +-
> >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |  2 +-
> >  cmd/bdinfo.c                         |  2 +-
> >  cmd/load.c                           |  2 +-
> >  fs/fs.c                              |  2 +-
> >  include/lmb.h                        | 12 +++++++++++-
> >  lib/lmb.c                            | 15 +++++++++++----
> >  net/tftp.c                           |  2 +-
> >  net/wget.c                           |  2 +-
> >  test/cmd/bdinfo.c                    | 10 +---------
> >  11 files changed, 31 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index c877c7b94c..2e72d03edd 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -776,7 +776,7 @@ int board_late_init(void)
> >  {
> >       u32 status = 0;
> >
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > +     lmb_add_memory(gd->bd);
> >
> >       /* somewhat based on the Linux Kernel boot requirements:
> >        * align by 2M and maximal FDT size 2M
>
> We already reserved gd->bd as part of the initr_lmb call. So I think
> this commit needs rethinking, or am I missing something?

I believe the LMB memory API's also get called from SPL(not sure about
TPL/VPL though). The memory that gets added in the other commit is for
U-Boot main, post relocation. These calls will then be needed for
prior stages of U-Boot that want to use LMB memory.

-sughosh
