Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BCDC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351BF884CC;
	Fri, 26 Jul 2024 01:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aE0mkYH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90510884CC; Fri, 26 Jul 2024 01:32:36 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E90F8842C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b5d42758a7so419666d6.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950353; x=1722555153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SQstrDsOq7Ng11Yjdi9QZ1WTzI/EcG4Dfe1IzDp+KNI=;
 b=aE0mkYH0WgBHytuum4k8v02/Rj6mlg9lR3V4yNUJ5vp2bv2sRNZZD3grXFIFRYCWGG
 7wi2q/PJIXHZWTPj5dQ4gWOv7eoysuVmk6l55lC+aL2+nDKtB6Pr7kiDzyCiy7Lo6lhs
 ob3RPHlPnS13KYWdennRMTWTX5u/ReVN2+ps8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950353; x=1722555153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQstrDsOq7Ng11Yjdi9QZ1WTzI/EcG4Dfe1IzDp+KNI=;
 b=ehhIviHIY41b3Jqya5jHCkcHTWUx3oT5CEWSnEkACpCl1dTEj0BsSiDk3U/2LgIJ6i
 tXdXTW+NFfvn1wtPnIBmKZqrqgqZHLWrOSvkveO2ebik8xmC+yycE85aj37+JmrPnPuz
 0fbQz4JjYa1D3sYLRbSNmELW0Js/uErBuZtvuemtTif81TxbrTZ+ZG7IHr7ndB2oFva8
 SCpGw/h9LMrZGXcrx7cCBZTjFpZhNyMObaJdoEU2BY9IhDOWEGIUJsjdVgmb/Hqs+mLt
 SfDjwrIJZSNZGwR2oG5/rnm6japF8SB7POrSfjsCkqzTy8ScV+4lC7v8yAP4P0jsxMz/
 v83Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf2S7b9uhN0e+QsPFv3tD+dcjS7dwj6FOaiONfO5MyMuUs7kgslq3Hgb7lVeSEaru9wSZZ/q0rexVcMlo9EprruAFVCA==
X-Gm-Message-State: AOJu0Yy2Em/kMKh8Yan2IqxxQaPxa5SfI5A0GKRVEvs0saGoutthqmaY
 L4KAZTIDmvA0UHZk3Igf7ejTmTAj+kAPHRa9mJiACQcO7fLT0e6vQ3rMkXTejVOIqh9wj6uIxYh
 NFNA+HLDq0DDngb2evoRpZVZmdLYogiVvqhwx7NixHBg2azY=
X-Google-Smtp-Source: AGHT+IFpaEcFBgN5RaL+cD6BoTSBv4Z5MSgXQZ2bVdQ7/HlHZDIrFNx5dKe/Uf46DtPNib/01taJgw4+3EQT3rX+GGY=
X-Received: by 2002:a05:6214:76f:b0:6b9:5fb9:113f with SMTP id
 6a1803df08f44-6bb3ca544fdmr56551136d6.27.1721950353157; Thu, 25 Jul 2024
 16:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
 <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
 <20240723142055.GG989285@bill-the-cat>
 <CAFLszTgG9WuzYp97ANm=k3iju-DH+c5A2HfgwmUznti9tQyzpw@mail.gmail.com>
 <20240724145201.GL989285@bill-the-cat>
 <CAFLszTgoh6aLQ0BiHjkHYyzE9v0LP5d10Abq-k875kO7kP3ATA@mail.gmail.com>
 <20240724224719.GR989285@bill-the-cat>
In-Reply-To: <20240724224719.GR989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:22 -0600
Message-ID: <CAFLszTgwkVCs+7-HnjXfQTOpHvuEpN9RRWBgxzFH3j4MOXPYDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Tom,

On Wed, 24 Jul 2024 at 16:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 24, 2024 at 09:40:35AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 24 Jul 2024 at 08:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jul 24, 2024 at 08:37:14AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 23 Jul 2024 at 08:20, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jul 23, 2024 at 01:42:59PM +0100, Simon Glass wrote:
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> > > > > > > > >
> > > > > > > > > > Add a Kconfig symbol to enable getting updates on any memory map
> > > > > > > > > > changes that might be done by the LMB module. This notification
> > > > > > > > > > mechanism can then be used to have a synchronous view of allocated and
> > > > > > > > > > free memory.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > > Changes since V1:
> > > > > > > > > > * Change the description to highlight only LMB notifications.
> > > > > > > > > > * Add a separate line for dependencies.
> > > > > > > > > >
> > > > > > > > > >  lib/Kconfig | 10 ++++++++++
> > > > > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > > > > index 7eea517b3b..b422183a0f 100644
> > > > > > > > > > --- a/lib/Kconfig
> > > > > > > > > > +++ b/lib/Kconfig
> > > > > > > > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > > > > > > > >  config LIB_UUID
> > > > > > > > > >       bool
> > > > > > > > > >
> > > > > > > > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > > > > > > > +     bool "Get notified of any changes to the LMB memory map"
> > > > > > > > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > > > > > > > +     default y
> > > > > > > > > > +     help
> > > > > > > > > > +       Enable this option to get notification on any changes to the
> > > > > > > > > > +       memory that is allocated or freed by the LMB module. This will
> > > > > > > > > > +       allow different modules that allocate memory or maintain a memory
> > > > > > > > > > +       map to have a synchronous view of available and allocated memory.
> > > > > > > > >
> > > > > > > > > This needs to be select'd when it's going to be used, opting out of
> > > > > > > > > making sure memory reservations are obeyed isn't a good idea.
> > > > > > > >
> > > > > > > > +1 which begs the question, do we need the config option at all ?
> > > > > > >
> > > > > > > The config symbol can be used for removing the code for platforms
> > > > > > > which do not support EFI ?
> > > > > >
> > > > > > I am still of the so-far firm opinion that this can be done once,
> > > > > > before booting, rather than maintaining two separate tables as we go.
> > > > >
> > > > > Did you see the part in the thread where he explained the multiple entry
> > > > > points that would need to be kept in sync?
> > > >
> > > > Yes, but I'm not sure what they are, nor why a shared function cannot
> > > > be called twice from two different places.
> > >
> > > Because we don't want to miss the third or fourth entry point down the
> > > road. That's why going the other direction makes more sense I believe,
> > > we won't have a future problem here because we designed with that in
> > > mind.
> >
> > You might be right, but I don't even know what we are referring to
> > here...what are the two 'entry points'?
>
> I would have to refer back to Sughosh's explanation to repeat it, sorry.
>
> > My current belief is that we can set up the EFI memory table before
> > booting, with a single pass through the table. Maintaining two
> > independent tables as we go doesn't seem very useful. It is harder to
> > test too.
>
> You seem to be fixated on "booting" when at least part of the issue is
> re-entering the EFI_LOADER. And since EFI_LOADER needs X/Y/Z as well, we
> had much earlier rejected "make EFI_LOADER's memory model what
> everything else uses".

I wouldn't say I am fixated. EFI_LOADER's purpose is to boot an OS.

What do you mean by re-entering the EFI_LOADER? Do you mean running
one app, then coming back to U-Boot, then running another? I am not
suggesting we reinit EFI in that case, if that is what you are worried
about.

I sent a separate series to show some of the issues I've been
concerned about for a few years now. Perhaps we should schedule a
discussion to talk all this through one day?

Regards,
Simon
