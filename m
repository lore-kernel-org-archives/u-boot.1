Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF85C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A0787C86;
	Mon, 22 Jul 2024 14:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X//xGUmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E5988363; Mon, 22 Jul 2024 14:59:36 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC53D87BF4
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso3662167a12.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721653173; x=1722257973; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UpkusTrBfUi11Tpf+VSgCi06TEmIXJ27UkmJPOYo7LI=;
 b=X//xGUmv2uw3bU2LQDVuRI9o1oD5tYR+Ht0w3cNKJ84JGEfsB83atDV+ptUdja2kqh
 2uRanVjKMJwbgFGxKjYwv0NmaboBTXzVuJycS+oDAyBRLlNoCchyoHdGJXPRMGxvX1WE
 hiMhnZTesQML/L1X4CtiFLG8ee3SlA5eNDDi4crGnQwIl/5eRfqEMAmI4Y3sEvGiRGZx
 QztUNkRKClRdGgeK8AoEz0WUv0TL66Zabw2Lcgr5XwNhFbfobrz8oReYhv0cdEZpA+vh
 +pke7pJcnx5sU8LwD7liv87m+Ys2Cn+4pz53zqrtJU0XNepKbo/6G3F5TAuVeL/e1don
 clPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721653173; x=1722257973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpkusTrBfUi11Tpf+VSgCi06TEmIXJ27UkmJPOYo7LI=;
 b=RIHwHEOMJ3/jVQZGib2wL/6Vi0PclHrkdRBudAqJDNtC7FbdEMad9JKMTwhnhibqaR
 h3OVdB0ESzJASd9iScmdQKmfOKGAcx12Wqq5WmrcJdYUKgtZg14IwB9E2QZF3vruiV31
 LPb1xPBFhYv+xuV5HCjBMEvpdQ7zzMbOemImxNkD57kXGtMd0dJORuVWcSV5S5T/tUAr
 o4fymPT9BPz9r12ou+dS0rYcgFDDpePpLJTSn2TUv8pwPwdvk+KSWHhSTLI6cNeaRS0/
 M32iDHxsqFUmKOfMg7PItU9jsE37S4x6+3bRUFk4hm6tChxTSoxj9TH8U15/Zix3IW24
 QRcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV3Rs9ra8+0eLqnobEVC5SqOAX5IHNvkSIMIvW47bEIRD4nUpKlLh42lJu5tACbePa0uDS0YY4iAoQ/NeykAbO8bVX6g==
X-Gm-Message-State: AOJu0YyCRTnw6kdQHlOk4HzD80Tvy2FozOdqfhfe0P3rWjoBmPU0SWXE
 VYz/inxgmU9B0r3GQu4OjX4TAiUMcQhgkHBbZM1TpHNFv5f6Ck+Sinj+VDM409VU+9JRarv6uo6
 8ieaOog1212ojOxSlFzF4RB4OifXeAvQ1qD/1mw==
X-Google-Smtp-Source: AGHT+IGrtvH4CUvOWBbEWWs+66UETVLCwGoxdTGwpAqJ3xRlljXX37KWmGUvNKiaI9aQTFMDMZbKEb6zj3sqfvUSQyQ=
X-Received: by 2002:a50:aad6:0:b0:58e:e2a:1b58 with SMTP id
 4fb4d7f45d1cf-5a478b65c56mr4297468a12.2.1721653173229; Mon, 22 Jul 2024
 05:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 22 Jul 2024 18:29:22 +0530
Message-ID: <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> >
> > > Add a Kconfig symbol to enable getting updates on any memory map
> > > changes that might be done by the LMB module. This notification
> > > mechanism can then be used to have a synchronous view of allocated and
> > > free memory.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Change the description to highlight only LMB notifications.
> > > * Add a separate line for dependencies.
> > >
> > >  lib/Kconfig | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 7eea517b3b..b422183a0f 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > >  config LIB_UUID
> > >       bool
> > >
> > > +config MEM_MAP_UPDATE_NOTIFY
> > > +     bool "Get notified of any changes to the LMB memory map"
> > > +     depends on EVENT && LMB && EFI_LOADER
> > > +     default y
> > > +     help
> > > +       Enable this option to get notification on any changes to the
> > > +       memory that is allocated or freed by the LMB module. This will
> > > +       allow different modules that allocate memory or maintain a memory
> > > +       map to have a synchronous view of available and allocated memory.
> >
> > This needs to be select'd when it's going to be used, opting out of
> > making sure memory reservations are obeyed isn't a good idea.
>
> +1 which begs the question, do we need the config option at all ?

The config symbol can be used for removing the code for platforms
which do not support EFI ?

-sughosh

>
> Cheers
> /Ilias
> >
> > --
> > Tom
