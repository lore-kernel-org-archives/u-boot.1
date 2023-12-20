Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51839C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 15:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A86F86CF4;
	Wed, 20 Dec 2023 16:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="schBIN5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6440587469; Wed, 20 Dec 2023 16:36:23 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DB3869B6
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-593ea4c2baaso1117980eaf.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703086580; x=1703691380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6vyAIH+BeRi4YBx59yZLVPwkCyVwl0V0+EsRn1eOalA=;
 b=schBIN5gppdQFi81Pt3eKVIlH2mTRQ8Wq3aGez9z1siCSjxxNFepY/FtlyOXS89ePL
 mJSOWDtEWB0eO33nJkInTmBWavsKidmZerRRKThiakhn7jzP+Ais5kFCilY4Vu3hStmL
 RvgWw5kiKShCEns9CZ3n5kQdGIqEIYQYv0lFxqMdFNH/1nbhH+uE+VSU0lBgpwoFKKER
 ERdFyBJUSXa7lQ5qoxj8KUs2qrzsCCDRrb9zGRP8D+zhOI46TlVrKmJwK2Kl9iC1fOf4
 pxEeXFS3oKqOPzCT23wTdNqLx1TOELBbj6YekyB7IM4o1XHrdz+iJ5PaOUM0kxN6XqBd
 dZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703086580; x=1703691380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6vyAIH+BeRi4YBx59yZLVPwkCyVwl0V0+EsRn1eOalA=;
 b=Z3Wxu6WPBmsku+yy8ocD04W4ouNJl7GPA2ooLkixovgRuLuai3DkDZAwKBPpK1LUjH
 WeCjuaqS4frPAY80y8ao1A3SQTT3jDxLYj5XGJcDir0tJaJYIAUPn4mQY1yqIGkgxynB
 ouIwmvNHy/d8AUiaj0Nui7SamRpqEe3TOOsyTanuQZxw/kPPd7eOcm5IupjXFjw1RlnG
 cytPvEzwWYHxasSMDb5PTQyngTRsEntSJfazG+9bN1QberI7GLAoizrSkEG8frnV3kgN
 sIDvO0cZVQ39BnlVacWsPj83vpJGHd2JxpIizmV++oGPFbMjYgZglbqTFHI2ZHkiKxct
 zAsw==
X-Gm-Message-State: AOJu0Yz9naeM3bcCKxcNM9+UGRM8Guo+IYKASHdQwW8y4digK8yJWqvK
 WxN7X9eMd8G2gEItYJFgjHPbpNPezjwB6fq2IWwVTg==
X-Google-Smtp-Source: AGHT+IEjFMZSe5gRwzalnq8+BPs84lHlilEJ0W2lbtPtYVX/fy832dSkmuMUWP2qWkXr2NU88FfwlPh+DQam0/Hpn1w=
X-Received: by 2002:a05:6358:8a4:b0:172:aebe:698d with SMTP id
 m36-20020a05635808a400b00172aebe698dmr5176795rwj.61.1703086579642; Wed, 20
 Dec 2023 07:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-3-raymond.mao@linaro.org>
 <5fc01bbe-01ac-43fc-b7a9-03ff149b6014@amd.com>
In-Reply-To: <5fc01bbe-01ac-43fc-b7a9-03ff149b6014@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 20 Dec 2023 10:36:08 -0500
Message-ID: <CAEfUkUJFaKN6q0NLR4KQRXrZ_BQ-gA7cyhv8x6Gnoejre2jhjw@mail.gmail.com>
Subject: Re: [PATCH 2/5] qemu-arm: Get bloblist from boot arguments
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Michal,
Yes, I can put this part as armv8/v7 common functions.

Thanks and regards,
Raymond

On Wed, 20 Dec 2023 at 06:03, Michal Simek <michal.simek@amd.com> wrote:

>
>
> On 12/19/23 22:11, Raymond Mao wrote:
> > Add platform custom function to get bloblist from boot arguments.
> > Check whether boot arguments aligns with the register conventions
> > defined in FW Handoff spec v0.9.
> > Add bloblist related options into qemu default config.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >   board/emulation/qemu-arm/Makefile        |  1 +
> >   board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
> >   board/emulation/qemu-arm/qemu-arm.c      | 51 ++++++++++++++++++++++++
> >   configs/qemu_arm64_defconfig             |  3 ++
> >   4 files changed, 74 insertions(+)
> >   create mode 100644 board/emulation/qemu-arm/lowlevel_init.S
> >
> > diff --git a/board/emulation/qemu-arm/Makefile
> b/board/emulation/qemu-arm/Makefile
> > index a22d1237ff..0eb262e4e2 100644
> > --- a/board/emulation/qemu-arm/Makefile
> > +++ b/board/emulation/qemu-arm/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >
> >   obj-y       += qemu-arm.o
> > +obj-y        += lowlevel_init.o
> > diff --git a/board/emulation/qemu-arm/lowlevel_init.S
> b/board/emulation/qemu-arm/lowlevel_init.S
> > new file mode 100644
> > index 0000000000..d72d7c938a
> > --- /dev/null
> > +++ b/board/emulation/qemu-arm/lowlevel_init.S
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: BSD-2-Clause */
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#include <config.h>
> > +
> > +.global save_boot_params
> > +save_boot_params:
> > +#ifdef CONFIG_ARM64
> > +     adr x9, qemu_saved_args
> > +     stp x0, x1, [x9]
> > +     /* Increment the address by 16 bytes for the next pair of values */
> > +     stp x2, x3, [x9, #16]
>
> There is specified how transfer list should be passed from one stage to
> another.
> Which pretty much saying that when bloblist is enabled this is what you
> can
> expect on arm64.
> Why not to add it directly to?
> arch/arm/cpu/armv8/start.S
>
> WEAK(save_boot_params)
> #if bloblist
>         (your code)
> #endif
>         b       save_boot_params_ret    /* back to my caller */
> ENDPROC(save_boot_params)
>
> because pretty much all platforms which want to switch to it will just c&p
> your
> code.
>
> that being said qemu_saved_args can become just generic save_args and you
> can
> also allocate space in .data section in this file.
>
> > +#else
> > +     ldr r12, =qemu_saved_args
> > +     stm r12, {r0, r1, r2, r3}
>
> And this part should go to arch/arm/cpu/armv7/start.S
>
> M
>
