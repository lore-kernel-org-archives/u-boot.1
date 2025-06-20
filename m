Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD61C7115A
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 02:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D8282CDF;
	Fri, 20 Jun 2025 04:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pQ4NxHkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7180482CDF; Fri, 20 Jun 2025 04:41:21 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F0F082CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e7d9d480e6cso1187635276.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750387278; x=1750992078; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEa/P9I543PaHb59oNoRLxpkJsQBW/05poQnQZm7mzc=;
 b=pQ4NxHkr6AqmMEcXZcEBxqQ7axXnhpQSqxcXhwTTWOXjmVHShdnp0B57Koj/qzjxse
 xuVNKqtRQZUQ6AAD/suzlhGm1aRyeKb2UypfCbOZ+UY0t6np0216tTqsEnbJoEuxpgMC
 ahII0qvLao9gUElf91s9C+qmtgks2OuN3i0hfvoA2AsNa6uiBNZcLqgeD5ELTz7ms6t3
 yJF3YTutPMxgSSi3xO+R1V19xIsHfuhV4Qq/SEDdc3q9h3ruDI1BoBwshQdV5aVLNWnb
 +k2c3ia+GTziW4QFzsMxvDD9TyHNB2vvZGfp49+rxb/S16VcRrVOI5IdLT4pkgCMmVdU
 PjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750387278; x=1750992078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEa/P9I543PaHb59oNoRLxpkJsQBW/05poQnQZm7mzc=;
 b=kfOYgIS02wtwZRQH2SwiQWL8klXLfqljBKprgaMXE5Mli9ULxbTf1Dd3KdnZhee0yI
 0TL1ApVqhh0x9dbUc9KULrSSd2z6KeDnH47B8a39N4rPTNokloMUyQHIYEVgSM58elXD
 gbwkUXujXfWKb/hkOOhtACkxjKH+uRxuJS+O4h/myKZSMM2ihoeX86J9QTb7d/L1O6Dr
 zL+OJuaLwrvUyLzAV6ECciEbJNvLMbs97Ciqrr5uhbB8/M4JPsNfSCBxd2n1cvegD8go
 dRbX9k/57vQQ/XNmV/4q7oHknQrPf5ai0qr1TqV5ZVtiBqBFyJo34TsZjVj6+Eg9LeZe
 cw3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo442yit/mc2ZMrOPWu7b1g67qEEHbdP3LWGB4FQizMYTTI1rb177HMGa3zIId5syHSMqZJgs=@lists.denx.de
X-Gm-Message-State: AOJu0YyhrN/GZKRpVsPHsRuDPiL+87USnYC2/RK5UOi5JApEtcHWm7m2
 bS9MHVw5fIK61IfqIiPOyAUB2MKdDgGgZQC5P9Ddsu56YL7CUftoRC4X0JrpxX1iTLztev2ynda
 jlzIyDtmUxU/y7fO82BPXQKc/c+hi5xAFmXMh9dVRkJOFG4RLazYt
X-Gm-Gg: ASbGncsx8cZ2Me2BJdtZrx5dXyDR1WQMDIKmN4jcDqmbofhcf5D4LRUSvBtbGanBrB0
 AIOuMlN6Ojh+BXQdBmYwP5lNbqQ5JgXXSjk3YCrEag6SpeRmaxifwWHC0DoXxyLaOVQLj3FZoEd
 KBv2nZGINjBDEpfl0vX2WkcF89ebJR+hUh2harG5flPqnrNnSlxJfDXPcatJ8oCCbGMuQB18eqk
 TToxg==
X-Google-Smtp-Source: AGHT+IHofnWVEaFalWEUuLWTC6haN/uNDtC5roh6aGUUebdaQzl5d2vmzuHH/FP+fPrqsMtz2g5utdXl8UbVoxW1RL8=
X-Received: by 2002:a05:690c:9689:b0:707:dba5:2e44 with SMTP id
 00721157ae682-712c6512c50mr20636057b3.30.1750387277836; Thu, 19 Jun 2025
 19:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
 <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
 <CAFLszTiZdbMu64_+=LV3gxUf_Jm9Ngxdmg=+XrVhGNHR9FDAnw@mail.gmail.com>
 <CAPLW+4nCr1j4MxR9mjAt3JtocwsxBKgWpah_ARODX+6ENs-xDg@mail.gmail.com>
 <20250619223520.GE216500@bill-the-cat>
In-Reply-To: <20250619223520.GE216500@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 19 Jun 2025 21:41:07 -0500
X-Gm-Features: AX0GCFv3yW0qc09uQYpjFNFEWhuYXcfEPOWh-wI9yM1nUWjuYNCyi2WncRD-WJ8
Message-ID: <CAPLW+4npMfxD8ihnBPNxrG6PjagC4RHUzEyvfrEMw8AyK8WVSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
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

On Thu, Jun 19, 2025 at 5:35=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

[snip]

> >
> > Is it possible to just apply this patch without a test? It's clearly
> > fixing a memleak. Not that I'm lazy or anything, I came up with a test
> > like below, but I don't want to send something that is quite hard to
> > test. If you think this test is really essential, I can send it once
> > bootstd tests are fixed and can be run in one command without any
> > extra non-documented work.
> >

[snip]

>
> Yes, we can do this in a follow-up I think. I'll take this series to
> -next soon.
>

Thanks Tom! It's not very recent though, should I rebase it and re-submit?

> --
> Tom
