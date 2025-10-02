Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA78FCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F87835D8;
	Thu,  2 Oct 2025 18:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M+pdk3o1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48DE183642; Thu,  2 Oct 2025 18:30:19 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D7C8004F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-631787faf35so2469522a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759422617; x=1760027417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ItMjIPsePatlYjM0XAMIXi8TOnbTkNHMdFbWQZOCavM=;
 b=M+pdk3o1vVTH624R+V9PWOL6fgMUCzQkp+rvcxQ5da1+YlqakBlHuBFiuDfgdQfE4e
 T4GW1nv6dEiUrP1ayGuckTOIVmoRdFIF3rVwTBWkm6q8EtYCdLbeZeDZnnPUHbxIucGw
 uGFS0WekjwfNAEvQRSut7cIYFof413XzmOTxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759422617; x=1760027417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ItMjIPsePatlYjM0XAMIXi8TOnbTkNHMdFbWQZOCavM=;
 b=qg+FQ9ubHXKJPoNjmWQS7nuizxcWj4xBcOvYm2bcIYMaldOCqOpU1vBPcyTArWpIbq
 EHW8Xy4ulDyMRLMihVg9TLFpn1NtoGxY4uA48CCCcnv+MvcHhgnjpm33BEL8Xv4aOOnO
 K+HEMn7PHc034JYBUPj1Ki/Fe2ZDM8/8UC32x5xdy459W0KxADyBVPZ6OIvZJ45HSLlM
 OfUPEmsUocbKt94xQBYWBdWozq09eMyO9XKXan/w3MCgsGy9fGFe5L3IkHh4kosv1bXB
 3Kn3d6nVXocNzb7QZpKss5t08icASUO0DtdJJF60tmYZZgtXbbI22pRIMNkkRySy3+qz
 kTYw==
X-Gm-Message-State: AOJu0YxQrjGlWzT4+AheoOdPJJnIrwnu/jb++e1BttcAThW/ev06f0wB
 CFVdUbycZOCv8mjv6BzXFaILMvXkXWSTlk9rulNypg3bKRSDup7Rw6mra/WzNtQ+4wjsp8Cu384
 Jad09yNdF77+iq7zsPfhQSPus1ZgLcopg7Xy/Z5H7Q9021PtTf8G/ng==
X-Gm-Gg: ASbGncv+oCrtOPosGRFd7qtEmDzk3x60Cda05zNQ/s7otfm+lNNpfy49W13jBW80wv9
 AZeo4pYlWm15D9rHl0Sdmap7qOQ024m8nFf/mRnC6SqaLy9/E2/2e+fCEkD4R5t+TrpcxcAiRl8
 176Zn9SKu1WKq0eRSlR3nOfZDnBoa6zgkkX9T6GmRckT3TZE1MplkcpiTQhIubYO/cVloikMX4N
 8eBJcERIqnV1sDRDhZXy/z58MgDHw==
X-Google-Smtp-Source: AGHT+IGhWinadSOt9ZV+gYu4Z4t0NJ9RekXiA7Xlgr3JQxcyOnBDxs77ICaGEnLmqNa0GI6WbNoXG9Tio7oUoD3JoZY=
X-Received: by 2002:a17:906:9fcf:b0:b41:e675:95e3 with SMTP id
 a640c23a62f3a-b49c20531d6mr8135166b.16.1759422616821; Thu, 02 Oct 2025
 09:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251001232259.3599563-1-apr@cn-eng.de>
In-Reply-To: <20251001232259.3599563-1-apr@cn-eng.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Oct 2025 10:30:04 -0600
X-Gm-Features: AS18NWDPkx_jX4N5_Ak24WrTmgTvOvtUCnVhOvQzkiU0fxhnt-GZ1J1nk8qpedA
Message-ID: <CAFLszThMci29aiyCUfEwUpWjdncQ=KQZfvBsSz961=KYjy2u1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] bootstd: rauc: fix doc and info msg to reflect real
 flow
To: Andreas Pretzsch <apr@cn-eng.de>
Cc: u-boot@lists.denx.de, Martin Schwan <m.schwan@phytec.de>
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

Hi,

On Wed, 1 Oct 2025 at 17:22, Andreas Pretzsch <apr@cn-eng.de> wrote:
>
> For the RAUC bootmethod, newly introduced in U-Boot 2025.10, both code
> and documentation contain some incorrect (maybe outdated) statements,
> so they do not reflect the real behaviour.
> This series corrects both the docs and one log_info in the code, to now
> reflect the real flow. Beside being visible in the code, all of it was
> tested on a real machine.
>
> Despite the very late time in RC cycle, I suggest inclusion before release
> of U-Boot 2025.10, as the current statements are simply incorrect. Also I
> do not see any risk in these non-functional changes.
>
> Andreas Pretzsch (2):
>   bootstd: rauc: no valid slot fallback: fix info msg to reflect real
>     flow
>   bootstd: rauc: extend and fix doc to reflect real flow
>
>  boot/bootmeth_rauc.c         |  3 ++-
>  doc/develop/bootstd/rauc.rst | 19 +++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)

While we are talking about this bootmeth, does anyone know what
happened re a test for it?

Regards,
Simon
