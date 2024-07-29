Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457C2C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F1688247;
	Mon, 29 Jul 2024 10:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ia3S4VUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E618C87F51; Mon, 29 Jul 2024 10:40:08 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F215E88247
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so198409a12.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722242406; x=1722847206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J3eoHqZoFbnrUrRRHPVrxz+uHlGIFoqJO7hrZzIOt5s=;
 b=Ia3S4VUJjAAPD42XpKmWQnyWprEAF6o1Nsdn4/bzkFcQ6c1RSoWWo03A9iIQqcKIx/
 vf6uEhwzo3RmqR6eBoRxsdM1nVcQq8mIP1mbZc7J7S0zDtHV44tQ+kXzpC50j50Q7ZT7
 T+xfb2fwXoQ5fqhHGUefUFtyHnOOk1b/zqT5Bb+SLLmMkBNwb2CJWnaqmmuobOaYWAPP
 8QVcKLZvAfLOR3f/a5QphltjNwwdRqF5uPzK+4GjqIha3jh70rEhz/lW6EpBYBvL/al2
 vUVPzziBIxFizJbq7qyGRhmQ7ET+Rjjc1iPjAIk9yPt+vstpMPn0aT1HodaB53YXjXv+
 z53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242406; x=1722847206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3eoHqZoFbnrUrRRHPVrxz+uHlGIFoqJO7hrZzIOt5s=;
 b=osEoKD7druao3ZpYeaHWhor4zvTW5L17Nb6JvlUN5n+XkoUy3sCAryIYcIcvNfcxyv
 zMFJQafA8YzF7OCHzZk4SWNxBx1VnytlbzpM+3SyCjTsqFPGAP8FcygQivWHG4IvGUmu
 3LAUxOeIJJEsA9y1QdtthAz81etNF4MzY2RE18NG1zjjZixAC7c+JhfL6kn0yuj0rxGA
 ZDhvsCgMSIlsK10TpB6uRxihMMSbRcKxRLCW99MzdD9/Zmghee5zSaIt9SaB4oh3YTtF
 Base/YWzXw+gH6CyhpWsZCzM3tVQJq+rNHkGA5YmjZPwOfxXw3MdQU9S06/7hWU1HWCQ
 g4ng==
X-Gm-Message-State: AOJu0Yx++1g8UfPDXVqpD7wBBdH+wDqtwMspFWzluMiGjeE+IdJiAQHQ
 0hYeAIFvu2/Wk1ea4YeLut2KLfMuCr5p2wTaYg9AEu7hQRmrXBhAWCNYtEYoB31iOTOo7WbZyyB
 oUyG82cbrLaQ39hPlY0HHYkbRU03dQEm+uSva7w==
X-Google-Smtp-Source: AGHT+IHbsOh9yxgRc4tw4V+FC6vIzPOEDIGfnoNIKJfWqSL0eWEkVmmh0bj0dau1y6G59lTueNXlNLcl5dAhUz5pRJk=
X-Received: by 2002:a05:6402:26c2:b0:5a1:1740:33cc with SMTP id
 4fb4d7f45d1cf-5b0205d5b82mr5673135a12.3.1722242406203; Mon, 29 Jul 2024
 01:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-24-sughosh.ganu@linaro.org>
 <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
In-Reply-To: <CAFLszTibBKMmPWjApmRUxRLWj11=Nf5NTz7+bGP+n5guYeFqYw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:09:55 +0530
Message-ID: <CADg8p94pVzK4AaBsCVg4PoQmbBHMKTdzB2MiBxuOzA6=Um3kmg@mail.gmail.com>
Subject: Re: [PATCH 23/40] lmb: add a flags parameter to the API's
To: Simon Glass <sjg@chromium.org>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add a flags parameter to the LMB API functions. The parameter can then
> > be used to pass any other type of reservations or allocations needed
> > by the callers. These will be used in a subsequent set of changes for
> > allocation requests coming from the EFI subsystem.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: New patch
> >
> >  arch/arm/mach-apple/board.c       |  17 ++--
> >  arch/arm/mach-snapdragon/board.c  |   2 +-
> >  arch/arm/mach-stm32mp/dram_init.c |   4 +-
> >  arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
> >  arch/powerpc/lib/bootm.c          |   2 +-
> >  board/xilinx/common/board.c       |   4 +-
> >  boot/bootm.c                      |   5 +-
> >  boot/image-board.c                |  15 ++-
> >  boot/image-fdt.c                  |  15 +--
> >  cmd/booti.c                       |   2 +-
> >  cmd/bootz.c                       |   2 +-
> >  cmd/load.c                        |   4 +-
> >  drivers/iommu/apple_dart.c        |   6 +-
> >  drivers/iommu/sandbox_iommu.c     |   6 +-
> >  fs/fs.c                           |   2 +-
> >  include/lmb.h                     |  23 ++---
> >  lib/lmb.c                         |  48 ++++------
> >  test/lib/lmb.c                    | 150 +++++++++++++++---------------
> >  18 files changed, 150 insertions(+), 159 deletions(-)
>
> This negates any code-size advantage of dropping the lmb parameter.
>
> All of these are LMB_NONE. Can we have a separate function (e.g.
> lmb_alloc_type()) for when we actually need to specify the type?

We will be passing different values when we call the LMB API's from
the EFI allocation function. This is only adding a parameter to the
allocation API's, which I believe is better than adding separate
functions which take a flag parameter only to be called from the EFI
subsystem.

-sughosh
