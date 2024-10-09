Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB66CCEE34F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE6988D38;
	Wed,  9 Oct 2024 23:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQ7aPWix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABFE88C98; Wed,  9 Oct 2024 23:14:38 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFCB888DFB
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c3f12d3930so1681316d6.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508475; x=1729113275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cu1jd+23b9HI1/Y+AWwj0Gsfzffh8bxBpUWrq6L0UEE=;
 b=oQ7aPWixF7s/Cf4fxH4cQTVeaPeQQHkggVrjo23guckJfN7YZTJH5MFY9nNB6tKY45
 ROpiXabhLDTam5gypnL8x+j2yTIRyhItxsd4UevaIZD29zXbuzQOqjKHSiIWkY42j0jt
 8xoR2YMZeOlnZg5CvGrvPt3PfAmxKV9RbF4wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508475; x=1729113275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cu1jd+23b9HI1/Y+AWwj0Gsfzffh8bxBpUWrq6L0UEE=;
 b=JIwbqCsHtilUxh5nTQ+CWGuem08mXbrDeCZxjmrsv1NcGUSdPQI4ITxEkbjKFXa0yZ
 0fs5kE1uG+oufSiI2jyvFDbYCrCEOTy/SPApVpYJlblObakCTomKniDwD0DywGe+3FfN
 QnvISwVVBvT2JpjQ8r35evfPmra0QysRyZKBsCqDWz/sjdbhobvNZH3vJOH/1sOmjdnf
 Hl/vdJwOJ/QNcvet9mZv3knxKt+XJuY4lDm2K1SxJJq9L3LEJttuUDZMYrUl+Vcd9pTy
 KpMDnbpfKo3SCcsPiBf2STArqHyOEWc2r8RF4y/M/AdJHYtUkyQkW/YNDpEYnpO9c8oV
 EvaQ==
X-Gm-Message-State: AOJu0YwH1jEe4YnCNGayQNIPCfJ+SppzDlcD71bvZQ/Okt66z0PiUweG
 1mgZI4VIJQ8xiBxHR5IaMCX716H3ILKMR8HCzB4m/34gdHAXl06MYiwCq0LGe5sggtxJSHjx9d5
 hReJ6eMbY5hTvkJqq+CS+MaAAfZVlTEBTmVCh
X-Google-Smtp-Source: AGHT+IGpsxLK5K134uWNDpucjS/H5GhAcOtB1hixj/lFQLpXEljeuQCz7PuQn0slgJHBQQ3MJdRktBnAwjFzGzksUf4=
X-Received: by 2002:a05:6214:4611:b0:6cb:c798:3103 with SMTP id
 6a1803df08f44-6cbc9570830mr54205826d6.39.1728508475604; Wed, 09 Oct 2024
 14:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
In-Reply-To: <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:14:25 -0600
Message-ID: <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
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

Hi Ilias,

On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> We already have a mem info command, which is pretty useless. Can't we
> reuse that ?

I am not too keen on using that as 'info' is pretty vague. We could
perhaps create a 'mem' command with 'info' as one subcommand and 'map'
as another?

[..]

Regards,
Simon
