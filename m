Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DBAC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 17:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2953587966;
	Thu, 11 Jan 2024 18:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jDwnbOLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2A2876AE; Thu, 11 Jan 2024 18:32:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F63A8642A
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 18:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e629c5a42so4680035e9.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704994353; x=1705599153; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjpd5IUBOeB/J2gQckxUU8y/gV3jpqFZjxLFFpLA/Hs=;
 b=jDwnbOLhwDphSUFpsKgvYdJFG/BkFgV6KYcCj/ekwr3SShDq1XcbZ+xAFdBb3xz3yD
 2vXINw6UpDyyz9JA5vpzCeSkHJz0/EmEQvz0ldzEQCPdhqhkltWZNbfPAoZCCgGl9h5u
 9inL6tePMlrW+2aKCLz93gRZpjA3eliTlwrvRhCAGRKGOc4UOljY2nLALw/AEeCZYi6+
 WNNGnjjbBvYnMxDfbOlU+/FN0UMuxLrUkcpVk1jFrhLsN4z7qHg//J3MCZ0lothSvbck
 uJdqfdwJIqcMUPLGCO03NXQaKTxSsqRQMe5wT7HFqcKSbLtom9jqEkOaaGHihdR1QLJ5
 3+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704994353; x=1705599153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjpd5IUBOeB/J2gQckxUU8y/gV3jpqFZjxLFFpLA/Hs=;
 b=xHOBjdR+w6SE6UnltWWvYjy0do9A8Erkz8KGDIkODWhmt1lFcRDrl5ueYSKiBy8uSK
 V3vSyp0tf4J+u7Yb1jH4aiFVpO165UTPn4FmrIvKcj1kjFj+69B6F34LRGZSivswGGxG
 o2lk8lfAGobY/XF8KLdQ+Lk4IsLjRGRcsjdX7SzhnB+rHxvpa24HcTodhLMOe6Ls5EGa
 v6s183N5n+XOZD8NLfCUAPAs95qgbt2WlD/2N+QsoHEFxpZoiWy+KwYv+FFmO2lHw7zT
 BTNU9ElAiUwMXsPnatR1mQBTrYNzSgeT6B3HWi/vBW2HWLzaU7jomKHSvB72uleZS0Wl
 n/DQ==
X-Gm-Message-State: AOJu0YzfdgxQxvNul2wvvuZAiitZjBww7KBYPFBh66MHmCeTsRFmd9wN
 EGAFe9BMDooZbU8YFNLfVM2ZXVTPJWN0pqmuMKM=
X-Google-Smtp-Source: AGHT+IGGqBmnBN34WGkrpIjNRipWYfqHPnfcfspah2pdLS4Lu4k3vNAKADguoDSqaYUWsnXZKR6+V44qhfh6Jjvhq4Q=
X-Received: by 2002:a7b:cd95:0:b0:40e:5f22:34ed with SMTP id
 y21-20020a7bcd95000000b0040e5f2234edmr84867wmj.211.1704994353120; Thu, 11 Jan
 2024 09:32:33 -0800 (PST)
MIME-Version: 1.0
References: <20240107112713.61966-1-seashell11234455@gmail.com>
 <20240107112713.61966-2-seashell11234455@gmail.com>
 <20240108204251.GP1610741@bill-the-cat>
In-Reply-To: <20240108204251.GP1610741@bill-the-cat>
From: =?UTF-8?B?5YiY5a2U6Ziz?= <seashell11234455@gmail.com>
Date: Fri, 12 Jan 2024 01:32:19 +0800
Message-ID: <CAOKwTdpoGCEpAAwvTntg3HNj2zPr05gZ2cvUNisereqRVa4mJA@mail.gmail.com>
Subject: Re: [PATCH 1/4] riscv: sophgo: milkv_duo: initial support added
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng@tinylab.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>, 
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>, 
 Shengyu Qu <wiagn233@outlook.com>, Yu Chien Peter Lin <peterlin@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Jan 2024 18:55:51 +0100
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

Tom Rini <trini@konsulko.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=8C 04:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jan 07, 2024 at 07:27:07PM +0800, Kongyang Liu wrote:
>
> > Add support for Sophgo's Milk-V Duo board, only minimal device tree and
> > serial console are enabled, and it can boot via vendor first stage
> > bootloader.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> >
> > ---
> >
> >  arch/riscv/Kconfig                 |  4 ++++
> >  board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
> >  board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
> >  board/sophgo/milkv_duo/Makefile    |  5 +++++
> >  board/sophgo/milkv_duo/board.c     |  9 +++++++++
> >  include/configs/milkv_duo.h        | 16 ++++++++++++++++
>
> The defconfig patch should be folded in to this one.
>
I will fold it in next version.

> [snip]
> > diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/bo=
ard.c
> > new file mode 100644
> > index 0000000000..eaa47be173
> > --- /dev/null
> > +++ b/board/sophgo/milkv_duo/board.c
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > + */
> > +
> > +int board_init(void)
> > +{
> > +     return 0;
> > +}
>
> Shouldn't you enable caches here?
>
Enable caches will cause other problems, and I will implement it
in subsequent patches.

> > diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
> > new file mode 100644
> > index 0000000000..dd1d146c50
> > --- /dev/null
> > +++ b/include/configs/milkv_duo.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > + *
> > + */
> > +
> > +#ifndef __CONFIG_H
> > +#define __CONFIG_H
> > +
> > +#define CFG_SYS_SDRAM_BASE         0x80000000
> > +
> > +#define CFG_EXTRA_ENV_SETTINGS                 \
> > +     "consoledev=3DttyS0"                         \
> > +     "baudrate=3D115200\0"                        \
>
> We shouldn't need to set baudrate, it will be handled for us. Is
> consoledev something that must be set? Can it all be done in a plain
> text environment anyhow? Thanks.
>
I will check and detele it if it is unnecessary.

Best regards
Kongyang Liu
> --
> Tom
