Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CC3C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 11:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7819488A99;
	Fri, 16 Aug 2024 13:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MVegJsww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE4388A75; Fri, 16 Aug 2024 13:26:31 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F167188AC0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 13:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5becdf7d36aso655347a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723807583; x=1724412383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yv6b5YSGCrnVpDXL5VOhfluyhCKWal5voPV74JvrOPE=;
 b=MVegJswwbQOwTbP5IE/8rpWd4w2F3DEk3vAZIuyIK+Wgg74C/WWiLKDyNBm5mSCnUH
 i7J0KRPMIqvyrqJGhTPaE7S9G5vc9UasnCHaNQosjWPyEoBnhczqJzB4dYMv36lOLgVu
 R6kM5y+SjP9ETxqonueE5XbJ7hqOfoz6u2FM43ZR+flaWHGKiWz+GYOIzw4J8FRrLf+1
 6xKfRJTyb4vvbQAPQC8faiyUg9dMOsIjXStIC+JaUHyh9CNIY13LcuSQFOG03vSjqX3R
 dcL13VT8rXieai+NvvwX37mq2spzFkxcS9L3gakkCyfabdCFFxIi7TJlCVWnJu9XxiS5
 bQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723807583; x=1724412383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yv6b5YSGCrnVpDXL5VOhfluyhCKWal5voPV74JvrOPE=;
 b=YcIfVQt+fdsIP3VpqeS1HWStMb2Td1Ur9mP9thfKoMzydRI8xM07HlhPehRZAaQ2t7
 2u/DlqtwiOcfpdmj96viFl05RB8/4QADUZT6lgjDESKIyQlWq2TWAZWsTCTt/Fr18XwM
 7C/hgLFfXpJzaY5DLCOf43oShB6qUlWf6oU2FyROAa7quu2Y8fog9xfi+uIpyfGRDeVu
 vLX4HoLKMuL6EVmvf3QJJfqlAKOCr7oWCqX6PgW+jfVtrmVPaCc9YtjXNlCBJ8hU7BSn
 VaolXxenNB1rN+vHwipcbeb1F+JSh3/9nHCceUVna38c78b5Aki1iO4xqrPq+vkt6SlT
 P99g==
X-Gm-Message-State: AOJu0YyZqUScLhwmns1xA8ZRY0yv+bGMthYF46PQkCXA91HIyu0QMc9Z
 rHsGc3KEc02M181uASN1nU3CoxiqbInd2lgSTYNlPcVDDxvoUmYwh7nZQNnLcYyoZbY9kITL1eR
 dJyoAejmicrCnH8KyrRSZsjSUYn4Es/2/1ymLAg==
X-Google-Smtp-Source: AGHT+IG9nVGBgzR1noMyrsgLmC9VyN87cU8JSmCSMQhcxqLC8/R6SBoRmWPUeifu1y0azzonIhszAxBxdPY89Riha3c=
X-Received: by 2002:a05:6402:354e:b0:57d:17c3:a593 with SMTP id
 4fb4d7f45d1cf-5beca5adf4amr1591863a12.22.1723807583258; Fri, 16 Aug 2024
 04:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-19-sughosh.ganu@linaro.org>
 <CAFLszTipEUzOg9S-Sqo74Q-HCqE1U6RwKrgxE8FKiggZD26MHA@mail.gmail.com>
In-Reply-To: <CAFLszTipEUzOg9S-Sqo74Q-HCqE1U6RwKrgxE8FKiggZD26MHA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 16 Aug 2024 16:56:12 +0530
Message-ID: <CADg8p97eRtHRR7Us4OerrStCwLV5J_MO-N11Xot1V6iB6guQbw@mail.gmail.com>
Subject: Re: [PATCH v2 18/32] lmb: add a common implementation of
 arch_lmb_reserve()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
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

On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 14 Aug 2024 at 12:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Almost all of the current definitions of arch_lmb_reserve() are doing
> > the same thing. The only exception in a couple of cases is the
> > alignment parameter requirement. Have a generic weak implementation of
> > this function, keeping the highest value of alignment that is being
> > used(16K).
> >
> > Also, instead of using the current value of stack pointer for starting
> > the reserved region, have a fixed value, considering the stack size
> > config value.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: None
> >
> >  arch/arc/lib/cache.c        | 14 --------------
> >  arch/arm/lib/stack.c        | 14 --------------
> >  arch/m68k/lib/bootm.c       | 17 -----------------
> >  arch/microblaze/lib/bootm.c | 14 --------------
> >  arch/mips/lib/bootm.c       | 15 ---------------
> >  arch/nios2/lib/bootm.c      | 13 -------------
> >  arch/powerpc/lib/bootm.c    | 13 +++----------
> >  arch/riscv/lib/bootm.c      | 13 -------------
> >  arch/sh/lib/bootm.c         | 13 -------------
> >  arch/x86/lib/bootm.c        | 18 ------------------
> >  arch/xtensa/lib/bootm.c     | 13 -------------
> >  lib/lmb.c                   |  6 +++++-
> >  12 files changed, 8 insertions(+), 155 deletions(-)
>
> Rather than a weak function, can you put the extra ppc code into your
> generic function, behind an #ifdef or whatever. We don't want it to
> diverge again.

I am attempting to implement this in a slightly different manner, by
moving the ppc specific code to arch_misc_init() instead, and doing
away with arch_lmb_reserve() and board_lmb_reserve(). Thanks.

-sughosh

>
> Regards,
> Simon
