Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED97C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5721781112;
	Fri, 28 Feb 2025 12:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P2jTG9+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2EC81100; Fri, 28 Feb 2025 12:07:10 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5E081113
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-869440f201eso1652030241.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740740827; x=1741345627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+VYUBw0JRc06Yftvy4AKC63ommaG9M5iLcg3jgQvtfg=;
 b=P2jTG9+5nEnw1LYkjjk9qyC21Zzl4vFbYDNtLApRRJGCsdE6QWRFCtpXf3yG+ReiLj
 ng3aLPsdkmrrxEm8qsJvVXMnwwXaJtTJjhyNTEl5hqApDKnXrau3Klav2QkTUYA7/7QI
 H2BSCDBcc0ne/HYJtTq1a5BjCnlPh/XRyLiiPDw1tK4A3w3Rh1Pu7EoMFijD9znlUOgU
 fhKYoIQZ8brK3djw3qOJLtTRlEj64YsGvWCGZNaTKUI24Ij9AQnKBHe2j6cMQuRKt4is
 tmSomtPHs466r/DtDFo0ERWF4Aa8rqnJGcfHqs0trvcndXTM7pMrb7mUMczjq9JCtddD
 pmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740740827; x=1741345627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+VYUBw0JRc06Yftvy4AKC63ommaG9M5iLcg3jgQvtfg=;
 b=W3SnkWywIHdsifPlk0W6LFurXTAKd3i3eFaGw1xyYsM3jQGscUuyXsz2UCPh7qtq1M
 bKci+I8aes+QHx7tiGMmArw6cRqU9iknfjmyNO4oI2IipoarNCHNU8YLGVPPGGDeGQsN
 Vg0XhKCwq99u6mNdBxeOnffM4Y0KIyAhR3QHbW7hUr53hgeZDmLPRrMXI+C56No4uXup
 +Rp+KJGYjcn55FvBjTuPui96Xt4B9uHYpcmnrnrW1/eZS/WyNkn9ccudRnhGkTa/vev1
 F1r5i3zRTfZ1RJXM+ytIC3sbT7YtiGemybYYh7hwDfFdVhuMofAC/TXhJE6WcWW8ocTU
 W0vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYV9//MV3alzl9DbBM0/B3VFXMlIeMrxrmyJDWX7qHSJvELDOcNocpAz7C9jJgvLo+FzVPTKg=@lists.denx.de
X-Gm-Message-State: AOJu0YwPUv7ZEoctQ6P3j9JN4DYYVCKrrDz7oWwnspeUNADsM6IB/aJr
 TRIeQw5RVt/4E4PwwSGtso06Swhh4rYKSFGBeiUG5EIrGHFna+iR1LPs7VNTj47UFelLrlKcruY
 VKDGU1a8JNcm9koXHt17Poov0M3LBJU3K8X8hNQ==
X-Gm-Gg: ASbGnctRb6dBrZAYuSCaODZN7M8FLYTA/cLEtSGW9Cs9bNDNkMVCN2dSWQlIyxRS3Wh
 v+JeKkWJCJBoty/5A1ou9e7z2hUXZKsMocCJLScLfsrIiM3mIZFv7BpWwlLOz9zwNWDtvc2gtrl
 svhR82/wcc5w==
X-Google-Smtp-Source: AGHT+IHALe0hDs+UWhhKi+kgAsKaBUyjQH6qoAVrlN0oqSPJYYGUifX9x+ZNHa9f+lYR+79yimAMDJEKpAlBwZjkdW8=
X-Received: by 2002:a05:6102:4b8b:b0:4ba:99b5:60f5 with SMTP id
 ada2fe7eead31-4c044ef7176mr2172622137.23.1740740826889; Fri, 28 Feb 2025
 03:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <20250228-tigress-curfew-db928c18c24e@thorsis.com>
In-Reply-To: <20250228-tigress-curfew-db928c18c24e@thorsis.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 28 Feb 2025 16:36:55 +0530
X-Gm-Features: AQ5f1JoSZSS5z7HCZ0NK-MfyQrPizdLYNr-DLN3FR7AXmwBzCy2uj8khGzsY5uc
Message-ID: <CAFA6WYOAi6=XMAz9Gt-G1yEeJnEEfxfnqMJZt=mwt+QPxAqG7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
To: ada@thorsis.com
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, kever.yang@rock-chips.com, 
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de, 
 Oliver.Gaskell@analog.com, aford173@gmail.com, prasad.kummari@amd.com, 
 caleb.connolly@linaro.org, andre.przywara@arm.com, neil.armstrong@linaro.org, 
 mibodhi@gmail.com, nicolas.ferre@microchip.com, mihai.sain@microchip.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

On Fri, 28 Feb 2025 at 13:46, Alexander Dahl <ada@thorsis.com> wrote:
>
> Hei hei,
>
> Am Thu, Feb 27, 2025 at 03:05:52PM +0530 schrieb Manikandan Muralidharan:
> > Add PMC clock definitions for MCK and UTMI which will be required
> > for the sam9x7 OF_upstream DT since the clock framework is not in
> > sync with Linux and also include this header in 'clock/at91.h' file
> >
> > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> > ---
> >  include/dt-bindings/clk/at91.h   | 3 +++
> >  include/dt-bindings/clock/at91.h | 2 ++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> > index a178b94157b..016c6e0c620 100644
> > --- a/include/dt-bindings/clk/at91.h
> > +++ b/include/dt-bindings/clk/at91.h
> > @@ -24,4 +24,7 @@
> >  #define USB_UTMI2            1
> >  #define USB_UTMI3            2
> >
> > +#define PMC_MCK                      1
> > +#define PMC_UTMI             2
>
> These are in include/dt-bindings/clock/at91.h in Linux.
>
> > +
> >  #endif
> > diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> > index ab3ee241d10..7235b3ba01e 100644
> > --- a/include/dt-bindings/clock/at91.h
> > +++ b/include/dt-bindings/clock/at91.h
> > @@ -6,6 +6,8 @@
> >   * Licensed under GPLv2 or later.
> >   */
> >
> > +#include <dt-bindings/clk/at91.h>
>
> If the u-boot driver or some *-u-boot.dtsi needs that additional
> header, I would include it there.
>
> Besides this, you might be interested those bindings are in a process
> of rework in Linux currently.  Especially the PMC clock IDs you ported
> from Linux are about to be split out into SoC specific headers.
> Discussion over here:
>
> https://lore.kernel.org/linux-clk/20250210164506.495747-2-ada@thorsis.com/

AFAICS, currently you are just creating duplicate SoC headers. I
suppose you don't plan to drop bits from
include/dt-bindings/clock/at91.h since that will be a backwards
incompatible change and will break U-Boot drivers since they will rely
on it.

-Sumit

>
> Greets
> Alex
>
>
> > +
> >  #ifndef _DT_BINDINGS_CLK_AT91_H
> >  #define _DT_BINDINGS_CLK_AT91_H
> >
> > --
> > 2.25.1
> >
