Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC2D18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DAE88DC7;
	Mon, 14 Oct 2024 17:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7Fjz2hF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E388913C; Mon, 14 Oct 2024 17:50:50 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB0388DC7
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-45effbc3348so38334781cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921046; x=1729525846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T0SNkV9RMQ1FiCbCsPI9c+gOFP7wKzKYtrwGrXVubwg=;
 b=N7Fjz2hFJvfiZGuZVOCUzK8dGGP64Ps88L9Pf23FDK4BoLMeTKaIVqe1K6CngKwQOh
 Xig2xGyYs653Tpp+25LwVGeUX+DrTzNhJQIkynCHfVyweFrM20EjGtUMzov+ITYf63Wb
 XmP36LGDspAxUaOVquhwmDQMPkL+kGeLy3jDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921046; x=1729525846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0SNkV9RMQ1FiCbCsPI9c+gOFP7wKzKYtrwGrXVubwg=;
 b=WHj/drPBCcdC3pc4WVcJ6ymFpczV8Hc7AvR97nE4Trmpu7PvfluPaB+1KUlIMlM4zG
 0ugVVt8uu3o5gfJ4l8Yn/jPIfETq90f7dJ1WZ50ZWXiWktSpZa04bHWkT/ZhQck5qki+
 LvIHBVzef13PCfA0Lrw9qbzIGt/GsK0Zdwwb/pFYd9xuqE8O6xkbAFqK2OldxSrXIk7N
 S6WFxqYi7RJnNNywD3H6lr9gN5K4JM2GXoD/M9p9IMQ162p/UIumfOTiiUd6jX4fEcAO
 UWp3nVcPKu0aoAzqQ/mTPT30vftD15SsR5oVC9IA5l/v7aDlEzSogBV7GasetSybAhCM
 xS+g==
X-Gm-Message-State: AOJu0YwZzfseJmzAxq0Yyn9bpOwhxrC6PBauhbX569f66eqsoJZ9HJ7N
 BJfuhHyrEccdFTVLdJzQR3/5a2EJBtDhljJOwfQioFI0nP/nm5lvd08xceOvXvmGe8qIzBwARHp
 ukj6Y/dwTj4wZOi+8HqS5X1MhJH3pi52pxl+O
X-Google-Smtp-Source: AGHT+IH3s2kyWvrdrX6K6xQ1ILdlXf+aMSkAxNj4JMq0XqJRItfncZ+8aSv39r2cyCr6dDIsXNBqJ5mR9ho9LjolvJc=
X-Received: by 2002:a05:6214:5911:b0:6cb:9359:1e90 with SMTP id
 6a1803df08f44-6cbf9ea302dmr143383066d6.43.1728921046257; Mon, 14 Oct 2024
 08:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-2-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:35 -0600
Message-ID: <CAFLszTgVQH-4ef7kj+ziSUKrpwjjZB8QnJASpgn6nRFmKO7jGQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] lmb: add versions of the lmb API with flags
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB module is to be used as a backend for allocating and freeing
> up memory requested from other modules like EFI. These memory requests
> are different from the typical LMB reservations in that memory
> required by the EFI module cannot be overwritten, or re-requested. Add
> versions of the LMB API functions with flags for allocating and
> freeing up memory. The caller can then use these API's for specifying
> the type of memory that is required. For now, these functions will be
> used by the EFI memory module.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  include/lmb.h | 56 +++++++++++++++++++++++++++++++++
>  lib/lmb.c     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 140 insertions(+), 1 deletion(-)
>

lmb_alloc_base() should call lmb_alloc_base() as well. It looks that
you fixed that in this version?

I'm not very keen on __ before functions. That is normally reserved
for the C library. I wonder if a single one would be enough, or use an
underscore suffix instead?

Other than that:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
