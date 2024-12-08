Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D8E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F2D89473;
	Sun,  8 Dec 2024 16:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBpbqtIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD26C89541; Sun,  8 Dec 2024 16:29:14 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5958894B7
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so685127166b.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671752; x=1734276552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0qhEGENIR1sSJLu2s5gtvTL8wIIjzO6lmAoVNM/qb0=;
 b=YBpbqtIxTNPozohZLohMzBvkIM9nGrTp61u6OswJlFkuIK5V22SU07+KIvgNuj5z6X
 aUJVU9R/vnvCavQIdEcph49WZO/iRjBPGXE/jh3cIDTDMgVSRDXdiTM6xUlUsP04tRhk
 vflf7Cw2j/Br3JP9i2vp+yY5QF8jLQUOJlXzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671752; x=1734276552;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0qhEGENIR1sSJLu2s5gtvTL8wIIjzO6lmAoVNM/qb0=;
 b=Lu1N5Vz7t2BqewLAev/E4sCBlwaH4+2GlA2jhbMdEvTnme2q/9yD+91/B9yECC4iPn
 oag3/8rjnm/vH1kCGLpflq30UTlgWxT6Y8SrRiprSEPqpll1/gNjjX9/vKlcRQzfMrfe
 HoI3lUAOAdJzQY0i1dGVGOWTIiNBCQkmo7xiXTcHRy9a6V65yki5gJd7ifjFRNJK2KHf
 OMpJqBAIyKU8Ych9R09yy88xJeHiJRKdfiTirqjPK8hpIDrZqInoOcRG/bOMfHPTJkRr
 XS81fRoolLrPJdG9E8Q2mMgh+Qzg24vBKguRLpZBhlb8mL2AF8cm+y/HT7jTN/mUIXXX
 s9KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOkvfUsUleHptlfzxHLr8IZeQeWsbKuvrFameQsVOMHXvGgHCrdGZ/Z+NMHiGXnYp6Y+oJkTQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzCRtLP/CrDN+rZFJOYJ2L189ua4CI6mBjQpkhMH5aGzsd9qus6
 Uuwdkrh6ulOq8BAFHhZMSILyUOK+AvcJmTG++xeH4IbB/NMsCODo1PIyv1C3AZXkrlQJUUOUoZI
 B14wkicKfFxwzBMURRl5shf4wu5Bq2IT443hS
X-Gm-Gg: ASbGncvT70gZpdglXmIGZzPOFUghLmAophGAtBJ096Y46cDOWPjhEID8pRfvwEs/bVK
 79dGGED3yj/x3c2L6XhodFdRKL2Ma9l2d
X-Google-Smtp-Source: AGHT+IGBq9jg/rgqDgnlS26u4gxV0mXSf9ZcCAjf3Z7CAQWf2QRHVo1pQ96OvCwk6rZP7T3JC0uQP0tus3wBNPxcLTo=
X-Received: by 2002:a17:906:308d:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-aa6800a1bacmr170204866b.7.1733671752236; Sun, 08 Dec 2024
 07:29:12 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 07:29:11 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTgZKx_rT5K9Y5WSy31buXJV_c9g0fA40f76Dnnjp_ix+Q@mail.gmail.com>
References: <CAFLszTgZKx_rT5K9Y5WSy31buXJV_c9g0fA40f76Dnnjp_ix+Q@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-11-mjg59@srcf.ucam.org>
 <b79cd88a-4346-444d-979c-8eb2ed913d5e@gmx.de>
Date: Sun, 8 Dec 2024 07:29:11 -0800
X-Google-Sender-Auth: G0whzKtaxHsp5VyfHV7LqJw66O8
Message-ID: <CAFLszTh-puzSBEGg3ErgCgTGOSfcFSzbT9GGmtSJmYoTVs7tiw@mail.gmail.com>
Subject: Re: [PATCH 10/10] Add command to set an environment variable to an
 EFI variable
To: Simon Glass <sjg@chromium.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, u-boot@lists.denx.de, 
 Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sun, 24 Nov 2024 at 08:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/23/24 20:55, Matthew Garrett wrote:
> > From: Matthew Garrett <mgarrett@aurora.tech>
> >
> > We may want to make things conditional on EFI variable state
> >
> > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> > ---
> >
> >   cmd/Kconfig     |   4 ++
> >   cmd/Makefile    |   1 +
> >   cmd/efigetenv.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 138 insertions(+)
> >   create mode 100644 cmd/efigetenv.c
> >
Applied to ci/master, thanks!
