Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D47C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3561382B54;
	Sat, 10 May 2025 13:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGE5FJdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9670782B63; Sat, 10 May 2025 13:27:56 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A686682B39
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5fbf29d0ff1so4524365a12.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876474; x=1747481274; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bg+Ei7nthq7PuS+fUGu4b2mwvXUYZQ9x+4nVekaWwVw=;
 b=VGE5FJdOWQEzzMVEZvOxe9i7pYpgn+pUb8+7xS7NzcgDiLHy6IxPA4RHTzfO48a3mw
 wYRhOH9PuwcGk/EQLSp8mfyveJY8dMjpcMUKYHfu4oKfo8iIMxpQ/UVfOuFCehMDiA7/
 caos/+ojod3mhmuYeonDAFJQ8DpT0dN6XG+Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876474; x=1747481274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg+Ei7nthq7PuS+fUGu4b2mwvXUYZQ9x+4nVekaWwVw=;
 b=XU3en1Fx5dIOPsyM+KNEe3A6dgkOk4L9+/SJ6QX7KbGCmaHWmCBtuP3puU3PB8ydY5
 vFGmE3hIWcNB9eguruZ5ZL7IIzU3GS1yFIx46804A3hzEDz771lSPg26w9+AcMSieYFQ
 kJvYcUtMDuO8HjcmPWt3/GAiDCEpETFO89l5bqG50uOhPU8Fdoe7OByGY52SLcSXiHmh
 bWH/NVkuRS1JrKzCrJfzhPdh52CbrSXqHZWrN8PSyu7Hx8XeURs+EedbYzhRJe1Uh3We
 FAA3i/bDLbhWWOEE0e9SgQYRPnq+uGgJ/rSLLh8UzkKLwJgW7XpzXMPwpqXvB/qpqf3Y
 kaZQ==
X-Gm-Message-State: AOJu0Yw6FMT/G31kQpqJGYji0wfFx/SZXAc35NxJODkoa5HHoQOXTASW
 +knsNcKIr1zwLtj1Fm+59JQM1JfmTu68rLYKD2LhpLk5ANNKZtllf9oOLAE/oKvTciQ/xhxdcWV
 TJCiTbMgnAKaI+DEK6b95fF0D0+YgLJINYnaeApq3duQsxuB4rmxjSRCTSg==
X-Gm-Gg: ASbGnct3BBpJwTISuTzHS7zu7A2c78Ku6qtYvjwTygvYygP9vNOds2sjlzTPMBEOviE
 LBeXSHqzBkoDnhKW/qRFK6sP1kqzORuDm9UuhSAFZ80jLga+vgsTTkEXZRTCIcIngzchFBeeqNR
 CDqcyOV0yRNW5EvSfCTAx/k0T5KT3FSDR6pA==
X-Google-Smtp-Source: AGHT+IHUUoeNatrp87/B9yKK7biCHg8H8Fv7cJZhVKHRnBnOsxyWzOBCDkUKvbRsy1xGIOdLhE0W+BmCa5YCuG1PGIU=
X-Received: by 2002:a05:6402:26c1:b0:5ec:cbf8:ab28 with SMTP id
 4fb4d7f45d1cf-5fca07eda6dmr5576821a12.22.1746876474037; Sat, 10 May 2025
 04:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250418105919.1645824-1-sjg@chromium.org>
 <20250418133943.GK5495@bill-the-cat>
 <CAFLszTgaqCyK5t+5XqbW6SZ-vC1PCUv4h+YPqt0Zem1yXEn4AQ@mail.gmail.com>
 <20250507152323.GJ5430@bill-the-cat> <20250507154710.GK5430@bill-the-cat>
In-Reply-To: <20250507154710.GK5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:27:36 +0200
X-Gm-Features: AX0GCFuKP9D0go1EFeod-8Mm6_qtCl-Wqk7gq-FftGI3B-lG52GfEVQcjUyErdw
Message-ID: <CAFLszTjXdfatQZDBhE3FrusJY7q_p7sR96TbTtLin7ute_q+9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bring in linux/limits.h
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Raymond Mao <raymond.mao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 7 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 07, 2025 at 09:23:23AM -0600, Tom Rini wrote:
> > On Wed, May 07, 2025 at 10:47:13AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Apr 2025 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Apr 18, 2025 at 04:59:13AM -0600, Simon Glass wrote:
> > > >
> > > > > From: Simon Glass <simon.glass@canonical.com>
> > > > >
> > > > > Add part of this file from Linux v6.14 so we can include it from =
the
> > > > > linux/overflow.h file. Drop the relevant section from kernel.h
> > > > >
> > > > > The top of the file is omitted since it defines things used in mb=
edos
> > > > > and we get an error on SIZE_MAX.
> > > > >
> > > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > > ---
> > > > > Error is:
> > > > >
> > > > >   In file included from include/limits.h:6,
> > > > >                  from lib/mbedtls/external/mbedtls/library/consta=
nt_time.c:14:
> > > > >   include/linux/limits.h:7:35: error: missing binary operator bef=
ore token "0"
> > > > >     7 | #define SIZE_MAX        (~(size_t)0)
> > > > >       |                                   ^
> > > > >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:6=
5:6: note: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> > > > >    65 | #if (SIZE_MAX > 0xffffffffffffffffULL)
> > > > >       |      ^~~~~~~~
> > > > >   include/linux/limits.h:7:35: error: missing binary operator bef=
ore token "0"
> > > > >     7 | #define SIZE_MAX        (~(size_t)0)
> > > > >       |                                   ^
> > > > >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:7=
1:8: note: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> > > > >    71 | #elif (SIZE_MAX > 0xffffffff) || defined(MBEDTLS_HAVE_INT=
64)
> > > > >       |        ^~~~~~~~
> > > > >   make[3]: *** [scripts/Makefile.build:256: lib/mbedtls/external/=
mbedtls/library/constant_time.o] Error 1
> > > > >   make[2]: *** [scripts/Makefile.build:398: lib/mbedtls] Error 2
> > > > >
> > > > > Changes in v2:
> > > > > - Add new patch to bring in linux/limits.h
> > > > >
> > > > >  include/limits.h       |  2 ++
> > > > >  include/linux/kernel.h | 12 ------------
> > > > >  include/linux/limits.h | 21 +++++++++++++++++++++
> > > > >  3 files changed, 23 insertions(+), 12 deletions(-)
> > > > >  create mode 100644 include/linux/limits.h
> > > >
> > > > Ugh. I think we need to:
> > > > - Fix lib/string.c (and Fixes commit 7c7361b98d6e ("lib: implement
> > > >   strnstr()")) to not bring in <limits.h> as that should be limited=
 to
> > > >   mbedtls usage.
> > > > - Not bring <linux/limits.h> to <limits.h> to start with at least (=
we
> > > >   can worry about handling wrappers around overflow protection ther=
e
> > > >   separately).
> > >
> > > There are quite a few places which need the limits. If I remove the
> > > dups from kernel.h then some things don't compile, at least not
> > > without including linux/limits,h in limits,h (which it seems to me we
> > > should do).
> >
> > So, looking at things more to understand the problem, mbedTLS uses
> > constants for types (reasonable choice) and the Linux kernel uses types
> > and casts (also reasonable choice), and these can't be mixed and
> > matched, that's what results in the error you see. So, I'll re-evaluate
> > your v2, that might be the best compromise.
>
> Yeah, for v3 you need to address the comments on 3/3 still.

Yes...I'll split it up a bit so it is easier to review.

Regards,
Simon
