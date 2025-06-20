Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B4C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 19:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0EC182D06;
	Fri, 20 Jun 2025 21:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pryOZU3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21BC82E05; Fri, 20 Jun 2025 21:08:38 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F99B82BA1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 21:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so2622341b3a.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750446513; x=1751051313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mKjzRf+A+jatTM6AIGUDR7OFOKp2lsezQuMr/vfhr94=;
 b=pryOZU3xsXMIJ7hnFZ0iLbShq56g4uG3K2FfLIhdqB4JCaxCujZA7N9VvevX1AB8tf
 t6NxcRYN1HxnIDjFc+sbZbFPjz1VfO1HCjd0CV1eSJaUikavZWHo+X5bCpzvNY9VdPPO
 AZPc35pWJEqA+G9Yu1x7DQ+7MpHzuFF0TdkiAmV3JclX5rAuF4FkVB2pzsOh6Ciz6M0f
 qwiHmhH2X9ABSYgqAKProVI3jzVMIhD6D50dXMx7jSxDVx0DGXMgEWTcLma2nzxYYIY4
 hXeCLEZgsrDJATVBwWVhGl9rorzBlIEotXI14+zsFNDRwucVuwvwsLPw7K9nZOrk5hiK
 43Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750446513; x=1751051313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mKjzRf+A+jatTM6AIGUDR7OFOKp2lsezQuMr/vfhr94=;
 b=s8FGGodIINDkRuSzF382eADqwtGUozk1fav/ZrZ6ReFLhkyXm4nSc7zWzMwbPt5n5P
 cWs7QMz83OfvEPrePa89x5WLlbY6/pJPi4QfHDYa20keWQhKUODZWVcFAM6Pz/sy7HOt
 dSyBdDTO3ajk0YsqQcBbgZY5oeBL99LNsq+m5Z0P1weOcOx5ET251gysRjrR3n1i+Cqi
 gQnZWMQEOAec97tMkLSt/1LaFaL0v1LMwfS9cPwuUlB/iiEXmYFq8vCw96LmDFwCoTE7
 OR+2XBauS5ssqgtS40yOIQM+O7sXVX98iOQ+RHRUZvOvFrjwKsPoPMhyOF5gMzQakXij
 gy3Q==
X-Gm-Message-State: AOJu0Yxnqimu9+cJJpFrgoydq9DaRneKYNT8ieoA5/kjm6DbRdMj62me
 IH7CFgn4LNWps/pSVUppdmi/48R/Lyf0nVNhH9gtClZOIZhiAoTSM4kj2SOx0xlZ+ZzhLNeWADr
 hXlyVUTKmmCBnZWLzfSXdd8z9JJP9pxTAz1RCQAIfBQ==
X-Gm-Gg: ASbGncu7WolW4IZHGzW2SURWdolCAt1x4TH23Odn2p6492wzJrbhBsfsAfeTQjP36Ei
 JHDBfpfHN5MNwlWNhgNLwM1E3pSTW6mynpIGWTLQQ6CL1VOXmgpjHq3F0KtFomgJ8qZ0+sD5t6K
 wMRWldMOs3z4+uqBqNMyQ4TxDpAlbBMhO3+gFn3C6S4aAc
X-Google-Smtp-Source: AGHT+IH2yq/gk8TK+ttbSFZ3ypzHAtbhMuwhlMrR/eWNtTrWrMR1VKoQIW/froKxj0cJSAZa6Knn5l7ut25ntTct6ww=
X-Received: by 2002:a17:90b:54d0:b0:314:2840:8b21 with SMTP id
 98e67ed59e1d1-3159d8f50e9mr5654743a91.32.1750446513524; Fri, 20 Jun 2025
 12:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
 <20250620171957.GL216500@bill-the-cat>
 <CAEfUkU+BaZxHSk9DUhF0D-1fmZYXBkiY8Bb6YEOzU0s+SMi4zA@mail.gmail.com>
 <20250620190013.GN216500@bill-the-cat>
In-Reply-To: <20250620190013.GN216500@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 20 Jun 2025 15:08:22 -0400
X-Gm-Features: AX0GCFsOpsLjFuqX8rBpgW-XN-qSz65QKDKmx_3jnrSG1L47NZ0exjKfXZJdgoU
Message-ID: <CAEfUkUJ+oXKdi6pWmNHpU_E7g-Vi37Q-x=W9ZY-UN486k2uizw@mail.gmail.com>
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

On Fri, 20 Jun 2025 at 15:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 20, 2025 at 02:00:09PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Fri, 20 Jun 2025 at 13:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jun 20, 2025 at 08:10:08AM -0700, Raymond Mao wrote:
> > > > Introduce the implementation of udivti3 and udivmodti4 from LLVM
> > > > compiler-rt builtins for building MbedTLS bignum module via Clang.
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > >  lib/mbedtls/port/compiler-rt/LICENSE.TXT      | 311 ++++++++++++++++++
> > > >  lib/mbedtls/port/compiler-rt/README.txt       |  11 +
> > > >  .../compiler-rt/lib/builtins/int_endianness.h | 114 +++++++
> > > >  .../port/compiler-rt/lib/builtins/int_lib.h   | 171 ++++++++++
> > > >  .../port/compiler-rt/lib/builtins/int_types.h | 276 ++++++++++++++++
> > > >  .../port/compiler-rt/lib/builtins/int_util.h  |  47 +++
> > > >  .../compiler-rt/lib/builtins/udivmodti4.c     | 158 +++++++++
> > > >  .../port/compiler-rt/lib/builtins/udivti3.c   |  23 ++
> > > >  8 files changed, 1111 insertions(+)
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/README.txt
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
> > > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c
> > > >
> > > > diff --git a/lib/mbedtls/port/compiler-rt/LICENSE.TXT b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > > > new file mode 100644
> > > > index 00000000000..5a79a1b9d5c
> > > > --- /dev/null
> > > > +++ b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > > > @@ -0,0 +1,311 @@
> > > > +==============================================================================
> > > > +The LLVM Project is under the Apache License v2.0 with LLVM Exceptions:
> > > > +==============================================================================
> > > > +
> > > > +                                 Apache License
> > > > +                           Version 2.0, January 2004
> > > > +                        http://www.apache.org/licenses/
> > >
> > > I don't know that this is compatible for us. Looking at
> > > https://www.apache.org/licenses/GPL-compatibility.html it talks about
> > > how you can use it with GPLv3 (which we are *NOT*) but not GPLv2.
> > >
> > My bad didn't realize Apache 2.0 is not compatible with GPLv2...
> > I am not sure but it seems that this incompatibility does not even
> > allow static linking into a GPLv2 project.
> > Then, how to make it possible to use LLVM? Can we upgrade to GPLv2+?
>
> However the linux kernel people do it, we can do it too. And perhaps
> that's part of what's motivating LLVM to be able to disable these
> intrinsics that we don't actually need?
>
OP-TEE did the same thing, it is GPLv2 too.

Raymond


> --
> Tom
