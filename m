Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ACFE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3D4801CE;
	Tue, 17 Dec 2024 20:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lFESk6D6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BCC4801FB; Tue, 17 Dec 2024 20:46:31 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D6E80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fc01so1627072a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464789; x=1735069589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=82T5v230eAHpv/4Afs+OYGARvMjWGPtfAi5n8jWD2/Q=;
 b=lFESk6D6UhDtvopckz8cEd0ALcziUPZ7RvtZY/1twKfSrukap/ifgYVRgaG62T7yKC
 Vz6slvKcif3ajLYYl7UNtPqcOmZPw/j3jh8TXQ388fAocHlJNA1KqfKHJfChllNDr/6w
 hD11aNYueABZNTZvOBuF18OtcOVm5WKelmLhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464789; x=1735069589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=82T5v230eAHpv/4Afs+OYGARvMjWGPtfAi5n8jWD2/Q=;
 b=LKpOJR6AgGuHRLMrVHLqIS8Xd7/Y5YcfJQ4o9j/D0M7epEni/Wr/IOCFfQTNj9vNhi
 jCvH+ffFoaEAjeOt2Zop0rpsURrCLTFanIy9OZd/D/Swl7dQIz1UpHAiL4p8x9ouyn6m
 ZYyzIdHHrrc4CGXMahBYAQ16fN+xTzwvPCHMf5ZFuT+DgPCmY4jPP/HxPjomkDHN1uZ0
 UoghqHlKcyMAGxgHcKIgW7c4gZml7aXskjx+XwG2kUxz//+9EbDnz2jELfR8TKxm8MbC
 xwyxwyquT4txQpp/TimSOM2MxI+0/DjLHBHn7420GhKCAC2mKvYNXA4ozJD0qniDR2KK
 EPrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkzAMoFYA6onmWWqFymeUXoJCD9TzwWdcuvyVJ/A+YdRaTZ0Li6gFHjp1sDga6Rrdo50/xzpk=@lists.denx.de
X-Gm-Message-State: AOJu0YwycLYgo/x6VUL6sW/MFR64gJfFXBZbaCKZ4RGA46W+coyPBdRO
 Xm2oIikahedjKVZjTxP5gltuzhr8A5LdXD0hR0LvlKfIkXn5BgfwdNPW2XsCoyXBuQ4GQfJPSuD
 cKFGYq+iCkglkiNwA4qmIOZF5bmeBF+KQb95u
X-Gm-Gg: ASbGncvi0+47nG/DZxeP+lAJRPBIWKj3OldBQWpydYuEPTUFha8RvW4lZPBC4SmZEHu
 hU42Hx9Xji6ZwlOQfua6w8flt69TE6n7d4QjcfCI=
X-Google-Smtp-Source: AGHT+IF7Nizp+GdTmoJS1f+sF/MBu+l7NTJsNILFDLfYoVwFq8p4x12/9tRianEV5M4avPg82Dg6BYaaUu8ScA6suZQ=
X-Received: by 2002:a17:907:7216:b0:aab:76bd:5f8e with SMTP id
 a640c23a62f3a-aab77ed35d6mr1812466766b.53.1734464788900; Tue, 17 Dec 2024
 11:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
In-Reply-To: <20241217142527.GL1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 12:46:17 -0700
Message-ID: <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 17 Dec 2024 at 07:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 08:00:56AM -0600, Simon Glass wrote:
>
> > While we do plan to switch to OF_SEPARATE now it is supported, it seems
> > worth at least showing how OF_EMBED could be used instead, just for the
> > record.
> >
> > So make the Makefile rule conditional on OF_SEPARATE and adjust fdtdec
> > to avoid a build error when OF_EMBED is used.
> >
> > Finally. the dtb symbol has a double underscore, so update it to avoid a
> > build warning.
> >
> > With future patches, OF_EMBED will no-longer be used with the EFI app,
> > so it is expected that it will eventually stop working.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app")
> > ---
> >
> >  Makefile                       | 2 +-
> >  include/asm-generic/sections.h | 2 +-
> >  lib/fdtdec.c                   | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > Applied to sjg/master, thanks!
>
> Since you've picked up several series that no one was objecting to and
> providing reasonable feedback on and applied them to your own tree, do
> you plan to squash/rebase them and repost so they can be applied to
> master / next at some point?

The original EFI-app series actually had objections in toto. Did you
not see the comments from Heinrich?

I've offered to send pull requests every now and then, to keep things
in sync, if that is your goal? But I don't believe I can do that for
particular patches/series. It is going to be hard enough for me to
just maintain my own tree, let along dealing with your/Linaro tree.

Regards,
SImon
