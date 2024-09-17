Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2365AC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B534088E61;
	Tue, 17 Sep 2024 14:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nh1K0cv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D39988E6F; Tue, 17 Sep 2024 14:36:52 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE5F88E08
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c40942358eso2153326a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726576603; x=1727181403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WJhSZoaRGh4pJvYjshlI9HWFb7qFDCNfDi5VxcUKm0M=;
 b=Nh1K0cv8Xehw3KKNGYlSJgLKkcSFaBN0nc1l9L/oAovv/oClZcRlXshqt5l5sJvd3Z
 pLR/WnF/M2jm4M686n5A7Wz819vJFziB6ZmWisAHjSRKB4GBqLIAbjIWhSXbJqD5mkLn
 eFUKiZoddjJ0LKpxHrUT/vhNNp+9pk94WxfveQi9ymsddoOI7IJ2wrZKhjdEozlq+d26
 EujR1SkZhjbzDkYtMr7knL+Y0Fp1AIu5eLERp+BFQbLyxgoGF379EzVGZbsq18Z2HGdX
 52Ieaz/Rr9tYdJfI97rUNiXx5Gpl5j1bvF5OdxhID9kJow4fiL8hfAy8D1Wiu4l8Ymy5
 fjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576603; x=1727181403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJhSZoaRGh4pJvYjshlI9HWFb7qFDCNfDi5VxcUKm0M=;
 b=GzDdmzgS3Wo/BoGlEry01BW4sWLV34BlGZucn+2kfb91UZG3eqRkWkF5hJR7TmK4jb
 OOXUjUfR2eQ5W9Ag8STutNdLqc/lZsFnc+mnmGYHx0PlRWrJLUZeWhfEG0dDmCFN3sln
 07znplvsvpGQeQWVuINuWQYXf8vXsKsWdDYDajNvr3ut373KEi5nvgufTvf0Ap7FCmeS
 vGiUnoc8tnuDea3SqNiqI81Su7SvIPQLfDDfrQ3oaKOfryiOkuScyVy7pjVT13uzKBM/
 T7uEUeem38EVMslmiqJRKwbLFpfa4fi/E3L+wQb2BxkpHLBaPQA26d8Ejzw/oolpuDPJ
 2Waw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJseiJfJIDKuoFZAdO5pucbczZtzXUKK/zGRRhetVFpm9FZT3G5NEcUVr3ieZvBqBRKk36KXI=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ4YThojz3Mhx7mr5rq3gRtIJrfHhGr/EmRyXt0wuhXOmZNNGh
 NpLjPyHtGcmL1cA7C2fU9tl0wTEtXROJkr4LrZLepMCWLHtecfwAXlGt+SPNmIOztceCk0jGuru
 OgTevIhdm5KxcZ9vOtrPKlW5FDHk4f3QIfVy8oQ==
X-Google-Smtp-Source: AGHT+IHridwPA912CGLOK80PLeJqFkiH13wl6vLvMtLbktb+NF3Lfz0hJ94T/6Lhl4835l1urjJsehMch8LsqVD0qcI=
X-Received: by 2002:a05:6402:40c8:b0:5c4:2319:50a7 with SMTP id
 4fb4d7f45d1cf-5c4231951e0mr15573052a12.8.1726576602799; Tue, 17 Sep 2024
 05:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-6-sughosh.ganu@linaro.org>
 <096933ed-72c2-480e-94a2-5f33b907f427@gmx.de>
In-Reply-To: <096933ed-72c2-480e-94a2-5f33b907f427@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 18:06:31 +0530
Message-ID: <CADg8p95HgH_DvfSZzOsoyE1aSqLtVuS2ni_cYEwOOcnksKUGaA@mail.gmail.com>
Subject: Re: [PATCH 05/16] lib: Kconfig: add a config symbol for getting lmb
 memory map updates
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 14 Sept 2024 at 20:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/5/24 10:28, Sughosh Ganu wrote:
> > Add a Kconfig symbol to enable getting updates on any memory map
> > changes that might be done by the LMB module. This notification
> > mechanism can then be used to have a synchronous view of allocated and
> > free memory.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/Kconfig | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 5f282ecb54..2e73cda580 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -74,6 +74,17 @@ config HAVE_PRIVATE_LIBGCC
> >   config LIB_UUID
> >       bool
> >
> > +config MEM_MAP_UPDATE_NOTIFY
> > +     bool "Get notified of any changes to the LMB memory map"
> > +     depends on LMB && EFI_LOADER
> > +     select EVENT
> > +     default y
> > +     help
> > +       Enable this option to get notification on any changes to the
> > +       memory that is allocated or freed by the LMB module. This will
> > +       allow different modules that allocate memory or maintain a memory
> > +       map to have a synchronous view of available and allocated memory.
>
> We should have only one store for all LMB allocations. They should not
> be duplicated in the EFI sub-system.

We do have a single allocator for handling the conventional memory,
which is LMB. The notifications are needed so that the EFI memory map
also has visibility of which memory regions are currently being used,
and which are free. So, for e.g. if a user wants to view the EFI
memory map with the 'efidebug memmap' command, the EFI memory map
should be up-to-date when it comes to conventional memory. And this
also includes memory which is being consumed by other non-EFI modules.

-sughosh

>
> The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
>
> Best regards
>
> Heinrich
>
>
> > +
> >   config RANDOM_UUID
> >       bool "GPT Random UUID generation"
> >       select LIB_UUID
>
