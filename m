Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA87C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 18:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A7582CBC;
	Fri, 20 Jun 2025 20:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tvikuWyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505AB82D4E; Fri, 20 Jun 2025 20:00:25 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA68A80C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-313f928718eso1625105a91.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750442421; x=1751047221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2DQ8iwRCY72zsXjbkJgdDbTAWIl52o/HWLEUZZpMoE=;
 b=tvikuWyCKQe4BM/Evo6Xt3OZ67cMVh2TtHXR3LyeeAZ2IxN+vU7nFa/1DMwjrm6nMR
 /C/tToa6X28JIZsGR7GjdZun0xT0/2Mv7YOOdhetbNtFclXB/c8DS5r0rlLQzm/oYhtK
 /889RfxoC+nPuRQ5dbdGpVY11BJK05NrwfTuQ71QLXrGRzSjgMVhnWAYgP9R39Lw6As9
 N8LnsXYRPNCX5HEe6j/HE9R/FFBCmtqatrnJTiyJaWic7/8CJSCdmbyE3cJkwcDG3I+3
 IgxHlhqqZzC/Lpx4Wn9z1A2q8rSfRHmS7q+Jh5zgzm4BYzxfF12cb8DQ1LaIIXLjZ2hu
 LYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750442421; x=1751047221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2DQ8iwRCY72zsXjbkJgdDbTAWIl52o/HWLEUZZpMoE=;
 b=UXbm3PbdoFxKzpSAYA6cVz+xeQOowhZ+eWyMcipX2qr8PaOHlS6bXUBN4Ao5Qdmxap
 pLKMdJv2DPp87Yh3ZQFlo38Cmm3ggY5DLQy8qzWepBHTO+h9CEH0RRysvCAkAqZ+kqW/
 xYAz3u+ouACDqi3He/eWmBMSEIHcxKUi/GwII4TMysbWspjjLFUFiPQQxhBF0rfY8jTY
 mBCVsIx4QJptKfUBUiq1kbJ/rzxrP08GM/tD1bXZrjF1hwwRHYfLB2T2CWSuneVnvMhT
 uyHDA+yiPcdNcxm32MdjZDMNvybxHtKHwStKp+NwnLgeNBc+E1RR8nQMoA2YsHYhK8Fl
 LZsA==
X-Gm-Message-State: AOJu0YyjQi/RsYeZpvre2F7vfhL0TZ77C2LXlhVjnxiLPpEr5DdGyC+c
 AJcTYtY03MV8B1WE0mS1s4ZfCnWZFgt1qJclvzo+FroKYp/hyp7HqzL0kf5njsgMyeOcgDT6UUA
 59MxBXpkPdpG/4+1GP5svIma/OKBj7zuoIxaR6lJmkQ==
X-Gm-Gg: ASbGncs2QGyvidZKcUbeZ39PPMlXOQ+xQ5Qj9DMXmP+MHgOiM6LN4YnJqqfqrgkj6dc
 QyGg0N0qnIJICkSFi0gRLb0CVrKkvgTLR1LUoJYmrrUd2nejXPXEbG5zitVErKxfhbUyOYVSUTm
 F5AgUzwJGQYtZZ8skT9vJzvIwasDQo1aiO9VlZbW8de7rNKvw57NHpGgo=
X-Google-Smtp-Source: AGHT+IFNrjZEgt6I5xkqGoS5yKc0vV2MZCke4d6UqByeBPU1toVcfvh8Ze2MPYOMAIjXJPpQrCIBjpQUdNvzH0Vw0gQ=
X-Received: by 2002:a17:90a:e7c6:b0:313:27cc:69cd with SMTP id
 98e67ed59e1d1-3159d648873mr7462089a91.12.1750442420746; Fri, 20 Jun 2025
 11:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
 <20250620171957.GL216500@bill-the-cat>
In-Reply-To: <20250620171957.GL216500@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 20 Jun 2025 14:00:09 -0400
X-Gm-Features: AX0GCFurblj2FGto9Kn2zpBvbh2BRZ8JRkJ9hVI_HBFC18gl9lIF-95v0_OkkSE
Message-ID: <CAEfUkU+BaZxHSk9DUhF0D-1fmZYXBkiY8Bb6YEOzU0s+SMi4zA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mbedtls: Introduce subset of compiler-rt from LLVM
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Robert Marko <robert.marko@sartura.hr>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
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

On Fri, 20 Jun 2025 at 13:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 20, 2025 at 08:10:08AM -0700, Raymond Mao wrote:
> > Introduce the implementation of udivti3 and udivmodti4 from LLVM
> > compiler-rt builtins for building MbedTLS bignum module via Clang.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  lib/mbedtls/port/compiler-rt/LICENSE.TXT      | 311 ++++++++++++++++++
> >  lib/mbedtls/port/compiler-rt/README.txt       |  11 +
> >  .../compiler-rt/lib/builtins/int_endianness.h | 114 +++++++
> >  .../port/compiler-rt/lib/builtins/int_lib.h   | 171 ++++++++++
> >  .../port/compiler-rt/lib/builtins/int_types.h | 276 ++++++++++++++++
> >  .../port/compiler-rt/lib/builtins/int_util.h  |  47 +++
> >  .../compiler-rt/lib/builtins/udivmodti4.c     | 158 +++++++++
> >  .../port/compiler-rt/lib/builtins/udivti3.c   |  23 ++
> >  8 files changed, 1111 insertions(+)
> >  create mode 100644 lib/mbedtls/port/compiler-rt/LICENSE.TXT
> >  create mode 100644 lib/mbedtls/port/compiler-rt/README.txt
> >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h
> >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
> >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
> >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
> >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
> >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c
> >
> > diff --git a/lib/mbedtls/port/compiler-rt/LICENSE.TXT b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > new file mode 100644
> > index 00000000000..5a79a1b9d5c
> > --- /dev/null
> > +++ b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > @@ -0,0 +1,311 @@
> > +==============================================================================
> > +The LLVM Project is under the Apache License v2.0 with LLVM Exceptions:
> > +==============================================================================
> > +
> > +                                 Apache License
> > +                           Version 2.0, January 2004
> > +                        http://www.apache.org/licenses/
>
> I don't know that this is compatible for us. Looking at
> https://www.apache.org/licenses/GPL-compatibility.html it talks about
> how you can use it with GPLv3 (which we are *NOT*) but not GPLv2.
>
My bad didn't realize Apache 2.0 is not compatible with GPLv2...
I am not sure but it seems that this incompatibility does not even
allow static linking into a GPLv2 project.
Then, how to make it possible to use LLVM? Can we upgrade to GPLv2+?

Regards,
Raymond


> --
> Tom
