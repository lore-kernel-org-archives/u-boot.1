Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB0BC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3578396C;
	Wed, 28 May 2025 18:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YgxQ4O0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AC68398A; Wed, 28 May 2025 18:34:47 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F5978390C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6045a3a2c5eso5118475a12.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748450084; x=1749054884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vyHjaoJOkdiNJ6rJ/1yjSJfPpNa99Pc9kcwAa1a5eOM=;
 b=YgxQ4O0vE2mpbL54t1KTWJYK3/U32OJfk2+R6sNWdySRAhrBuZWkt6sWUU427nxoFp
 HwVV35qg425xRt+j5lwpbSmr3cxlb5dFMycTsEVkteNAQKxSXpiVzabmzmUn2qejt+eA
 oeF3aIYZr+P98PEHmFIUdPW45F865SbvSsU28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748450084; x=1749054884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyHjaoJOkdiNJ6rJ/1yjSJfPpNa99Pc9kcwAa1a5eOM=;
 b=sGUkxTJ3qQnh2RfiO3vtcX41Rf26Zo0HJssmlnJBbit9WLr2He0eRjvNlh7ZVmH9XN
 hkDKYb3lfeDlGPrU6SayZUI+ZZwzh3WD+b/qiBviYu5M96MKZzt1D0m98CDHnJAylGPe
 s8IcDopiabTsR3e8rMWhFCSfCPmmLsg0r9Ohpe0Z7RqMOErjs2LknCM8mBsHl6y1nNOR
 +QQVAu9vCWG+/UYBxwXf0AcdWK0qYUl12EePns6QhpYaBvrLgwfl5TNfXXK5rI7wTF2O
 croeFmPQFGzO6UzJOKk/2R7u3+t2dcz5lLcGhSX6cBXrraFpgUhkBMKcEI3fkgKAIACU
 ippw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd6BbJ0FfBNLJLzpHNBytWWj/fcnOan7Tu0BS+/2Gu9xH2ACP4XBd2YYeav6bQMWcD6Zjoop8=@lists.denx.de
X-Gm-Message-State: AOJu0YzI/Q7krLYYYUaqcD6uOz1DdYFtJfz5anD3Y0+OHIGVBwe/wYWB
 mTcbv/K5DymasC4epzmg1O0PYynJgnQdT+nWfJ0IF91085eRe6t+x/tNF2kSIejyeXtRkp5j5F1
 iNyCmnWxMj04P/QsrY6c8XMzKZqhdXzqyXfPto418
X-Gm-Gg: ASbGncsp/MvIzs6OWnCWgMpgAl1Xc2ixh5Tu8nBonn35nnpZUOCwdzbrOhBTTQ09PbP
 JyKpm2FF6WVn+z15JFZBjfHeVb4L5F0hA4FckogjBFO1D/Z4UqwazMJ7MEvmXYKCOmWfj1LDqTa
 gXrPsPDWSXIgeUworJ3KCnTlL5mAk3OpI=
X-Google-Smtp-Source: AGHT+IHJIG9aMAHK4oetSvPGKP2r+13MgvIfKC4t+ZrRX0u980XA7zJ+/+Koe/jdFO6lGcLZ15GKkJ9tyN3nKkdNDh4=
X-Received: by 2002:a05:6402:3554:b0:602:1b8b:290a with SMTP id
 4fb4d7f45d1cf-602d77b26demr14880719a12.0.1748450083746; Wed, 28 May 2025
 09:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
 <20250528-dev_read_x32_default-v1-1-6ab1734dd7a2@cherry.de>
 <CAFLszTjw2E3v4sWNtuMc0tafLmtPMv64z=xqzbQyHSQ04NE6Rw@mail.gmail.com>
 <85b41ac7-a478-43d3-8163-5df008cd4833@cherry.de>
In-Reply-To: <85b41ac7-a478-43d3-8163-5df008cd4833@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 17:34:31 +0100
X-Gm-Features: AX0GCFvUT8wCTBfBis-m6zyMGs6Vsv2A2nxgMVz7tGjd-JJNIXa1xddffdF1imQ
Message-ID: <CAFLszTgqqq4mQckJCu17RogEaSwuBiNT2HYp9nhnatxHvB90fA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: core: use u32 instead of int for
 dev_read_u32_default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
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

Hi Quentin,

On Wed, 28 May 2025 at 17:15, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/28/25 4:32 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 28 May 2025 at 14:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> dev_read_u32_default is for getting a u32 from a Device Tree property
> >> and allows to take a default value if that property is missing.
> >>
> >> Considering it calls ofnode_read_u32_default which takes a u32 and
> >> returns a u32, it should do the same instead of using an int, especially
> >> considering that int size is typically architecture-specific, as opposed
> >> to u32.
> >>
> >> This incidentally matches all other dev_read_*_default functions (except
> >> dev_read_s32_default which will be tackled in the next commit).
> >>
> >> Fixes: 47a0fd3bad38 ("dm: core: Implement live tree 'read' functions")
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >>   drivers/core/read.c | 4 ++--
> >>   include/dm/read.h   | 6 +++---
> >>   2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > Re your comment above 'int' seems to mean 32-bit on the toolchains we
> > use. For example, in global_data we use int when we want a 32-bit
> > value and long when we want a machine-word-sized value.
> >
>
> Fair enough, the only thing I can say - without real world experience -
> is that int isn't guaranteed to be 4 B by the standard? c.f.
> https://en.wikipedia.org/wiki/C_data_types#Main_types

That's right. I suppose we could include the compiler's stdint.h
somehow and use int32_t but in practice Linux expects things to work
as I described and other embedded projects follow that.

>
> > In general I try to use natural types (int, long, ulong) where
> > possible, to avoid the compiler masking values before calling a
> > function, which can increase code size. In this case I could make the
> > argument either way.
> >
>
> I'm happy to reword this commit log to be less confusing or alarmist. I
> can remove the "especially", would that be enough, do you have something
> else in mind?

No, the patch is fine, I was just adding my comments.

Regards,
Simon
