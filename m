Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747CAC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 11:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E062A884AC;
	Mon, 10 Jun 2024 13:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cv3H8Ubi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EC48811A; Mon, 10 Jun 2024 13:48:04 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9365884AC
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so5714562a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718020082; x=1718624882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DBYtmtyBstmZxMNw1C2R6/1BKJrTBMbv39Hgp7dSzSo=;
 b=cv3H8UbilvxmYirfHbO1YtgDgM5A6XRyUNa95UI2FYVNvgp33fIJ6hDIE6dqnytB2D
 vrfU+YGsng8285EqGcwO0vaNSS11v1bF12PS+59wuymmtVShXRjCPxrDdDHHNqwt0QFa
 GO/VQ/E7P3+5Zzol4I/glxAd/0CbVzIDp4vATpbgGzc/1QNliAgNMSZVfXpIT2qFyyhP
 xZOkZPb8q7/ZYMGgBKhIskoooVuHCHN36YRQi4/yB0/Z87jhCZofhmHTmdFO1BoCkwcp
 sAVgm6bCe7v4Q8Mf3xpWyQuvYHs5Nr2CbjFdZ0RtP5hAu3iFuyavuvVlPMoOYwx4l8Zi
 l32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718020082; x=1718624882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBYtmtyBstmZxMNw1C2R6/1BKJrTBMbv39Hgp7dSzSo=;
 b=VNNyN3WrQVsUgL0d343Nf0BCnoaxRs4vB0jCO2XhNmNVCaz0/m/DAWg6zDKvMVJxQv
 cQb+Bn/e1cXVq+L3JlfNSBwwt7IemUPfUZvVB8nTYLxpphOUkYVr1B1eGE8G5pA6ar+o
 YY00FZ+CLfa564uTSUs1pBD8zgz//qTgr2OOo9waV2nvhIv2qC3kAVKmk3IgSLGgvpSx
 EsvyjdDjJDXZnTRhpDr0dX8R849tKTMHYil2Q17zihtadc/FHXm0/P+6zVTD5kajGX/R
 itfFf4MRw2kgTB3mwuCOZIMNVuPA140A6AoopdTFFyaUhb8ekpT6C+2DfIxSJ3wyP3UJ
 6k/Q==
X-Gm-Message-State: AOJu0YyV4LFttd/ktZMRAf6j2mBCdkFl8HkVOStJRR5TaYQQxvTF5WNb
 M5z335lxUwjIrBlz+EBV9ds67RV6Z6znnIt58MAn+9QgvTSSGzV7OioCmVwiTNzzP9REvXUP0ZO
 dFkJQQILcX0+VvYDJSlBrAfOiiHhFFJYhTFfLXQ==
X-Google-Smtp-Source: AGHT+IGl/uvUP7Jj8vPDWwa+D0U4/NcaOG3EdQHEa4fwbIpL7bwNvbOnVk/uYS1yAiFFOKX7yuvTkLX2X4MLOue8PX0=
X-Received: by 2002:aa7:d887:0:b0:57c:58c4:3ff2 with SMTP id
 4fb4d7f45d1cf-57c58c44089mr6193758a12.2.1718020082121; Mon, 10 Jun 2024
 04:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-12-sughosh.ganu@linaro.org>
 <CAC_iWjJTtZsdPKB+RBUDnN9KturZH5M9oiGz35D0dfgrE52F6g@mail.gmail.com>
In-Reply-To: <CAC_iWjJTtZsdPKB+RBUDnN9KturZH5M9oiGz35D0dfgrE52F6g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 17:17:51 +0530
Message-ID: <CADg8p97jPeMYJXpa4CUhJ=8d2891bPzWNDvCh9Wz=p9swLUMaA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/31] lib: Kconfig: add a config symbol for getting
 memory map updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

hi Ilias,

On Mon, 10 Jun 2024 at 17:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add a Kconfig symbol to enable getting updates on any memory map
> > changes that might be done by some other module. This notification
> > mechanism can then be used to have a synchronous view of allocated and
> > free memory.
>
> Is there any chance we want to build a firmware that allows memory not
> to be reserved?
> I think we should make the feature mandatory

LMB is enabled for all architectures, but the EFI code is not. This
config is only for enabling the notification code. Which is why it is
enabled only when LMB and EFI_LOADER configs are enabled.

-sughosh

>
> Cheers
> /Ilias
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  lib/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 189e6eb31a..9ea02ae006 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -74,6 +74,15 @@ config HAVE_PRIVATE_LIBGCC
> >  config LIB_UUID
> >         bool
> >
> > +config MEM_MAP_UPDATE_NOTIFY
> > +       bool "Get notified of any changes to the memory map"
> > +       default y if EVENT && LMB && EFI_LOADER
> > +       help
> > +         Enable this option to get notification on any changes to the
> > +         memory that is allocated or freed. This will allow different
> > +         modules that allocate memory to have a synchronous view of available
> > +         and allocated memory.
> > +
> >  config RANDOM_UUID
> >         bool "GPT Random UUID generation"
> >         select LIB_UUID
> > --
> > 2.34.1
> >
