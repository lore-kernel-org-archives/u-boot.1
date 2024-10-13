Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400B0CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 07:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD8988E6F;
	Sun, 13 Oct 2024 09:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jr+EUpkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80DB88E81; Sun, 13 Oct 2024 09:48:23 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A735F88E17
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 09:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so2021818a12.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728805696; x=1729410496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gCp4UFEbdgpymrRZqQQGuNbv9YNxAezaSE2NGjkdD7g=;
 b=jr+EUpkj5dcvaz9Wb+DI/m87IgS9qYcJ6YtCsyXwR9Pn2qdl8E1rghpFd+5A0570Qv
 UBRwcUl+qv5ywT77D3Pq7vrinusB5youX8GlKZkeOYyQRUhT8anjRlG+JxkAbdhe8e7Y
 q+Ez4ReeNGj33Xs4TvGbN4tQcT4w+iRA0wYaE5a39iDNyh8CH3f5AtKoWcd88TA0FiAL
 otFpCD4JAen6VQTGjN3lbhuLlWPO4wMFpEY7vgnsWbgeY7v2y49VIj93J1IB9g2qjZ+5
 hSW73Bne4fPW/KaZ21pFqL8p/96Ju/H6YksUCkbL9aKT1cFsSQlO4Kv/l+/pile6OEZ8
 wctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728805696; x=1729410496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gCp4UFEbdgpymrRZqQQGuNbv9YNxAezaSE2NGjkdD7g=;
 b=lu3IC3Vr1Ty/LdO/cHTOGRPYL1Ya6eFmNmwUdCxKjpHMzFFZHSzO96XE8VCCmX3LN/
 F+a1fU5vT+z8+2PPynqFawvMch1uNwYyE9oCoJ4Nm4DSUIFLZfmcD0WmbpjqVJvXuJmM
 9f4c203+Szt+nNoQutzzROscqX3u/Ek3qj3/vyCFsSGlYXSRs2rkAV8yc6xlsAuHQSoE
 1Dz+3EOhORRtE5P+7TSKXiXSo0fA0Nwm4k/xY/tjZ+cJ7jLYcDxMzEldku2ng/GrLSeU
 KrlT+5TnMcmqmyFiaj7BEJ8pds+pk6QFC4Ui2Dm7IxHfKzEkg4AJCZav2sUxqwmBzgcT
 pxkQ==
X-Gm-Message-State: AOJu0Yyis663YnuAKRIxMa7p2DFURrLCjxUa4iamulAkLewHUCgZmCBg
 1nmkc+s/skgn7yidepkSRamXKjKYOOan40/hCYH43BflIRu3MJSRI7Uafv1t1y63MbX/jTYMF+t
 y8A51z9UbidHnCfLOqb3d2UeJG/Mulo3JkiGGYA==
X-Google-Smtp-Source: AGHT+IHSASB3DJEY/HefJlMJ56GYZIVwIKOE8qtdu5UcVLmDCgYAa5Xq65f5IexmEZp4wxAD2D8eWlIpR9jdrcUYZBg=
X-Received: by 2002:a05:6402:50c6:b0:5c9:6b2a:ec8 with SMTP id
 4fb4d7f45d1cf-5c96b2a11bdmr1813607a12.30.1728805695488; Sun, 13 Oct 2024
 00:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-5-sughosh.ganu@linaro.org>
 <CAC_iWjKMoLz2=cwMP6gebeHYdf0XBXfai+ou5F0_6OVMchEGhQ@mail.gmail.com>
 <CADg8p963a4d5DLZ-ZvvR55HjAz4dT_gpvGrRVEp3RT7afFEwbw@mail.gmail.com>
In-Reply-To: <CADg8p963a4d5DLZ-ZvvR55HjAz4dT_gpvGrRVEp3RT7afFEwbw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sun, 13 Oct 2024 13:18:03 +0530
Message-ID: <CADg8p971LRRY2heMH4dRnGKE8kYUo4Lp21-4G2htevyDmZDpzg@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
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

On Sat, 12 Oct 2024 at 13:10, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 11 Oct 2024 at 15:56, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sughosh
> >
> > On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add a Kconfig symbol to enable getting updates on any memory map
> > > changes that might be done by the LMB module. This notification
> > > mechanism can then be used to have a synchronous view of allocated and
> > > free memory.
> > >
> >
> > Are there size concerns to enable or disable this? I think we should
> > always sync and get rid of this
>
> This is needed only for platforms that enable EFI_LOADER. I haven't
> checked if not having this check would result in any kind of build
> failures and/or size impact on platforms that do not enable
> EFI_LOADER. I will check this, and keep it if any build/size impact
> happens.

 Not using the config symbol causes build failure on boards which do
not have EFI_LOADER enabled. So we need some kind of a check to call
the notification function lmb_map_update_notify(). If not this symbol,
there would have to be a check for EFI_LOADER, but I don't think
having checks for EFI_LOADER in lmb.c is a clean solution. Thanks.

-sughosh

>
> -sughosh
>
> >
> > Thanks
> > /Ilias
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Add a config for SPL stage
> > >
> > >  lib/Kconfig | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 1dd4f271595..61452f7ac94 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -75,6 +75,23 @@ config LIB_UUID
> > >         bool
> > >         select SHA1
> > >
> > > +config MEM_MAP_UPDATE_NOTIFY
> > > +       bool "Get notified of any changes to the LMB memory map"
> > > +       default y if EFI_LOADER
> > > +       help
> > > +         Enable this option to get notification on any changes to the
> > > +         memory that is allocated or freed by the LMB module. This will
> > > +         allow different modules that allocate memory or maintain a memory
> > > +         map to have a synchronous view of available and allocated memory.
> > > +
> > > +config SPL_MEM_MAP_UPDATE_NOTIFY
> > > +       bool "Get notified of any changes to the LMB memory map in SPL"
> > > +       help
> > > +         Enable this option to get notification on any changes to the
> > > +         memory that is allocated or freed by the LMB module. This will
> > > +         allow different modules that allocate memory or maintain a memory
> > > +         map to have a synchronous view of available and allocated memory.
> > > +
> > >  config RANDOM_UUID
> > >         bool "GPT Random UUID generation"
> > >         select LIB_UUID
> > > --
> > > 2.34.1
> > >
