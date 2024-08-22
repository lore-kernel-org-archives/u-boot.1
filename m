Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A07C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3301F889D2;
	Thu, 22 Aug 2024 15:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="avv/n/zM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DF88890A; Thu, 22 Aug 2024 15:55:33 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 030CE886E5
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf7658f4aaso3535876d6.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334930; x=1724939730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fFW3/zXx5/BP2fCDCgkhqPsQLI3YvnLlu09Ojt4jUPE=;
 b=avv/n/zMt9Ohz6svMAMHPRIgqotBbyFKw68cYAesSoVGhTGQ4t7GDbaOCGq6tN+Ubl
 8cGhtYn059fiZ/RYNOrwbVg2QX+zXuQW14eYla+F1lg5+Pebm1We655sXdImn8Zxk+6B
 q5huttWDnUmNMi+qoYDZdL1OZz12DJsenCDHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334930; x=1724939730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFW3/zXx5/BP2fCDCgkhqPsQLI3YvnLlu09Ojt4jUPE=;
 b=WkQubr6kRLAqXvh6Sh/YkSIxBG+U+SEAfw4A/Wlw5S3P3jG0Tgie8D8XTOI3y56NIL
 qFlswfaDiATUO8rR7SqEgbbY+bkU4Ho3f5bh0JQLWwRlxDnEubs+zCgEPeLAvhNmKPFY
 q3RIN0CuLQrKeagfKo9jWEjH6Spff8zu/P4W1ifvYR5QqBpSuYe7hX2DASP3U9Je/gBG
 26i90aUyIYluaEXOz+xJuSh+IMWr29Iczgu5g9ZQj4289MGjB9564Z9AaHgFTY5ympP5
 AO3lmqfIxmLedtJfipr4MKQwbyrfJQtjWu61rBO8hNViUYEng6VNNMU91wZWJD1Mms8S
 U1vw==
X-Gm-Message-State: AOJu0YyBvkjUGYSrtgOdnGtmaWf4hLQcMiK2QM/dbP0TZ38JO0sNGAQ/
 lQtGuJHfXy/KEymMQ2OthzTmqFGVx3E0gXUB4PG/6buA0IHvmYWi3QoSIkv5w87IQKhBlGG14jp
 2oJi/NudM3XVsoCj+86Q4sgrRWD4MC7+PF6fl
X-Google-Smtp-Source: AGHT+IFnI31IGQvUwk9c4UNIwPWnvK8B6wEZguCvMVBkPWxDmj4Lf0HdPlEhkwYTOsZ5xB000X5py9qvMZBwqrIXbuY=
X-Received: by 2002:a05:6214:5709:b0:6bf:6dc2:e002 with SMTP id
 6a1803df08f44-6c155d58d8emr66575046d6.12.1724334929804; Thu, 22 Aug 2024
 06:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-8-sjg@chromium.org>
 <f23d8087-3452-4467-9fa4-3ec60058eb19@cherry.de>
In-Reply-To: <f23d8087-3452-4467-9fa4-3ec60058eb19@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Aug 2024 07:55:18 -0600
Message-ID: <CAFLszTgnP1aNXFao3VXGoRAaHMrDOKKg8Q8wa+JuiPRiP9vghA@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] mmc: Use logging instead of pr_err()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

On Mon, 12 Aug 2024 at 03:40, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/11/24 2:29 PM, Simon Glass wrote:
> > Use the log subsystem instead of dev, to avoid including function names
> > in the code.
> >
> > The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> > Changes in v3:
> > - Fix 'enver' typo while we are here
> > - Put enhanced size back to decimal
>
> Did you? Isn't it still using hex base via %#x printf format?
>
> Since the base is explicit and is what I requested in case we changed
> the printf format from decimal to hex base:
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Ooops yes I didn't to that. But if you are OK with hex I think that is
better, given the large numbers involved.

Regards,
Simon
