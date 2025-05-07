Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121E6C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF3882102;
	Wed,  7 May 2025 10:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kgXttV2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3D38212F; Wed,  7 May 2025 10:47:27 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9911C820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5faaddb09feso7649378a12.2
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746607645; x=1747212445; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVxvENUpxoVu7pN5sgoMxjxO5re5eNGoglkacqYB1o8=;
 b=kgXttV2rb35+4qlHUOHNCZcQx8C7e9sqZz0J00j1BvmEThbJVAqefLTarL9E/gbdvG
 nLNf2FM1YYSsk47F3v4yLDrAgvAtZoKsvhNvU0Y4zWEmLCMQKQdFwV3wq/7jfs4yUP36
 qzSiOjgRlpwZd1tK+CVPkBSRDWknXe1JOKL3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746607645; x=1747212445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVxvENUpxoVu7pN5sgoMxjxO5re5eNGoglkacqYB1o8=;
 b=IeoqEFCkTGlFRBFK8xhzjb1b/pJY3CeYq/gMv7An8hZC8ST4j7PcBCHL9MgoCvUYjy
 DqaLwN1OfTFQZWVlPVmB1cGA6AfSv4fRBOTy7rH8ufZlR5nm0n5x8VnWHb2ikprS2XTu
 kV9OBDOPwtLfJ0DInQ+fzMdaz3TVpbE2P+3SiUnVAfS9dHk76Knf5ATmoDvz00PZea1D
 U1VzubXUU7HCHvxAe7S1S9L/BZGDgv0KBq2Pn2D3EFXcsTPuLYfgXaV4nmJDOjeJrF0m
 iyy1wuZsKOR/ByV049J6tfHwyadk7KuO3OTyXmnBZUNUurOc9XKFJrYa7H1DiMQIb2p6
 us3Q==
X-Gm-Message-State: AOJu0YzPuMkMijMMzop/0mpHWLJdyPTIM1fHXHZS6DY6wOSBgVq5xRgE
 9wy4TSldj7iS34zYmU9Bk/3FS6Cj7T54HXCASwd3BNjSyLdbWhRG5Tfs3EeqDTYWQJR0NmZnNp0
 JPA+zLmvNvEjoZNSQg97shLnEnb7Ske5YMgSs
X-Gm-Gg: ASbGncv2N+ymadbHddwlkE4WWMq8SGiD4cqDok8fv3ohNLgzPNqj5HptMprCUwxlbRv
 gsUK0ZwUt1sW/MWxxtHyot/1PSm/tM2YFQ4Vf/QOyrY+yulRZj56VPOvOrW8E9vY0yH40f3QEtO
 IAphd04fYj8/IsKH+A8xTIKII=
X-Google-Smtp-Source: AGHT+IEAmW00YKpRBDHkhTIvCd+/qUztWd3jUodNTxRFPOERFDSiVmnvGri8aQ8lLao05ov4oLTpyVhcv07Mi6iodMs=
X-Received: by 2002:a05:6402:440b:b0:5ec:fb3d:f51f with SMTP id
 4fb4d7f45d1cf-5fbe9de29bdmr2590882a12.10.1746607644865; Wed, 07 May 2025
 01:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250418105919.1645824-1-sjg@chromium.org>
 <20250418133943.GK5495@bill-the-cat>
In-Reply-To: <20250418133943.GK5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 May 2025 10:47:13 +0200
X-Gm-Features: ATxdqUFdw7v5KtLCiEJv2Qz9AfcNOecBq-qtH_eSr-e3QKvYWG3SKicsbU5Bp8U
Message-ID: <CAFLszTgaqCyK5t+5XqbW6SZ-vC1PCUv4h+YPqt0Zem1yXEn4AQ@mail.gmail.com>
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

On Fri, 18 Apr 2025 at 15:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 18, 2025 at 04:59:13AM -0600, Simon Glass wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Add part of this file from Linux v6.14 so we can include it from the
> > linux/overflow.h file. Drop the relevant section from kernel.h
> >
> > The top of the file is omitted since it defines things used in mbedos
> > and we get an error on SIZE_MAX.
> >
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> > Error is:
> >
> >   In file included from include/limits.h:6,
> >                  from lib/mbedtls/external/mbedtls/library/constant_tim=
e.c:14:
> >   include/linux/limits.h:7:35: error: missing binary operator before to=
ken "0"
> >     7 | #define SIZE_MAX        (~(size_t)0)
> >       |                                   ^
> >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:65:6: n=
ote: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> >    65 | #if (SIZE_MAX > 0xffffffffffffffffULL)
> >       |      ^~~~~~~~
> >   include/linux/limits.h:7:35: error: missing binary operator before to=
ken "0"
> >     7 | #define SIZE_MAX        (~(size_t)0)
> >       |                                   ^
> >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:71:8: n=
ote: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> >    71 | #elif (SIZE_MAX > 0xffffffff) || defined(MBEDTLS_HAVE_INT64)
> >       |        ^~~~~~~~
> >   make[3]: *** [scripts/Makefile.build:256: lib/mbedtls/external/mbedtl=
s/library/constant_time.o] Error 1
> >   make[2]: *** [scripts/Makefile.build:398: lib/mbedtls] Error 2
> >
> > Changes in v2:
> > - Add new patch to bring in linux/limits.h
> >
> >  include/limits.h       |  2 ++
> >  include/linux/kernel.h | 12 ------------
> >  include/linux/limits.h | 21 +++++++++++++++++++++
> >  3 files changed, 23 insertions(+), 12 deletions(-)
> >  create mode 100644 include/linux/limits.h
>
> Ugh. I think we need to:
> - Fix lib/string.c (and Fixes commit 7c7361b98d6e ("lib: implement
>   strnstr()")) to not bring in <limits.h> as that should be limited to
>   mbedtls usage.
> - Not bring <linux/limits.h> to <limits.h> to start with at least (we
>   can worry about handling wrappers around overflow protection there
>   separately).

There are quite a few places which need the limits. If I remove the
dups from kernel.h then some things don't compile, at least not
without including linux/limits,h in limits,h (which it seems to me we
should do).

So is this something you would like to take over, or do we need Linaro
do fix up mbedtls, or...?

Regards,
Simon
