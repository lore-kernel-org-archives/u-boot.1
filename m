Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA33BE732D0
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38BDE86537;
	Thu, 28 Sep 2023 16:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dJhNUJC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD795866AA; Thu, 28 Sep 2023 16:19:24 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5079786504
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-533edb5ac54so11343381a12.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695910762; x=1696515562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=niTDR4a+vEmTJJy0QhCtfJFVDAeucnOr1W3vdTU/8dk=;
 b=dJhNUJC2QGMMUEqlWSfp2R94fOzbmLQlR39kxT9nlIlmOyMc0mp/qX0un/hqQZ1A83
 h45AqjXkbf0pFe0bI6y6GKkxWXElaME8FKdDwRPitiWLQ0iaLO497Gg6wIImUn/Bbhka
 u1szqqsLMJj8HA/6TcmOI4ibRu0KzYNhF2FLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695910762; x=1696515562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=niTDR4a+vEmTJJy0QhCtfJFVDAeucnOr1W3vdTU/8dk=;
 b=TsCSTVJj56e/p4WVPauXGpmuH6BHgq5Dl+r+hfBoJwuiN6yC260kpc093HPvzc/qCs
 PzNrVScvK+9jK151On2OdaUyh1pvlMeFz0bKNR4iU0m6tsUSXCtoDqkxGefrEyxqbAdB
 wohF5AQ7g+Z7nF2KlTNz+GMxB90OP9OmDmrdQvaGLTYHw9kGJqoTchhlHshHftQtefQY
 m9SFqcBB7N6ZBJ8G1gI9TOBkf+1PtjTRqi6OnkN7RoWKprysB8FxXao98raUyd04DKPk
 Z6f1cbqyMInJOnYkvZ3vqjCtFhVddY6ihBhupBLnTvLLYs+ukfs8Cu9muzssaMsKxuh1
 xWZA==
X-Gm-Message-State: AOJu0YzOX+AR0ELhmfW++iS+AG6xSUUjz0bw8eqdkd3cmTQsLeZCupK/
 VWWeA0N4nBHiEXWY5xWUxkpYi2h6q6kO483me5p2og==
X-Google-Smtp-Source: AGHT+IHzgwcWMugumJjQHXlQQP4cOI/zbUY+KwyFoe3IUBCcscym9UUu3K9HWFvsxywapvuGg1EUCt5IlnQYQXhR7d4=
X-Received: by 2002:aa7:d046:0:b0:533:193d:da5e with SMTP id
 n6-20020aa7d046000000b00533193dda5emr1315048edo.29.1695910761505; Thu, 28 Sep
 2023 07:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
 <14f689af-b727-4f5b-b2cf-73676f14167c@canonical.com>
In-Reply-To: <14f689af-b727-4f5b-b2cf-73676f14167c@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Sep 2023 08:19:03 -0600
Message-ID: <CAPnjgZ2yh+z4JwAwt9sQCzKpdNb7Sdb+SVRmt7zGyWqMAzGbFQ@mail.gmail.com>
Subject: Re: SSE instructions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
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

Hi Heinrich,

On Thu, 28 Sept 2023 at 00:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 9/28/23 04:41, Simon Glass wrote:
> > Hi Bin,
> >
> > U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get a
> > compiler error:
> >
> > drivers/video/console_truetype.c: In function 'frac':
> > drivers/video/console_truetype.c:30:15: error: SSE register return
> > with SSE disabled
> > 30 | static double frac(double val)
> >
> > Do you know how to enable SSE for 64-bit?
>
> How could this occur if x86 disables SSE? There must be some
> inconsistency in how this module is built.

We disable SSE on 64-bit x86, even though the CPU always supports it.
The compiler assumes it is available, so presumably emits SSE things.

I suspect there is some CPU init missing after U-Boot changes to
64-bit long mode.

>
> We a need a clarification of the used ABI per architecture and write
> this into our documentation.
>
> The RISC-V profile specification does not foresee float and double in
> S-mode (see RVA20S64 and RVAS22S64 profiles in
> https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#52-rva20s64-profile).
>
> We should convert drivers/video/console_truetype.c to use integers
> (where low bits are used for the fractional part) instead of float and
> double to make the driver compatible to non-x86 platforms.

Good luck with that :-) It uses STB for Truetype...probably there is
an integer implementation somewhere but I'm not sure.

Regards,
Simon
