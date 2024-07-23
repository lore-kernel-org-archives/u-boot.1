Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14915C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 07:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728CA885E7;
	Tue, 23 Jul 2024 09:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JoASkj4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A96F80805; Tue, 23 Jul 2024 09:09:46 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201B588739
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 09:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d2d7e692eso1163671b3a.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721718578; x=1722323378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3DIEuiZJtnqDLLGfXes/HMVwDdOH2ehIlBVa+jEPQ4A=;
 b=JoASkj4Pf/+sYeuqZiLWn+kD/7LNiQ3loHJ3/EVAZufvl4P7INfJd51UwbdtDXAhaB
 wwBIMD1NMnD73h2vZbLjOrly0MffgvLcU4Zso4dWX37whyVrnMRQvngu7sE2acdTy8Hi
 CiSt60Um78/CNsFNKWQ85FK+sgPztK+J1uRk52a68UYC9LFEZ8ro6n0oT610AmlwJvxx
 iiUFSJ57gLc+6Cl7kYhEMHFFFfcsnA2CFDp59m/DcpemaVst684qajz0Pt9owUbe8yc8
 7rBuG/fyoukm4Ez9cH4XupTlK3WO4OTQ+XQcf7zQAFp7JS7VzpqmOLgbbpqty/Hi6dZm
 GgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721718578; x=1722323378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DIEuiZJtnqDLLGfXes/HMVwDdOH2ehIlBVa+jEPQ4A=;
 b=f+jYX8Qs+SgR4ECUczWtwmPFFJQEIFXiQIf8t+aPPkq28yQFFH6e7Y+pdIUOP4zg6/
 MRyD8MNBl+aCEX+idgTov+w0w0HWXWiP3UNz6PepFBgtdBbeaBcxeFlWhjbBvm1hIt2L
 0zLJIPWC+fLZXFcqgv5V64UFontRlRXddDrivw/F1L7kBOex+UjR6Ml59iMXaqxSY7+s
 7O2hn8kA5MNoubiajf7qDetwtawYfRdFa2F59szseCqHwLgj+twKX7rcyvEbxwo4tNgl
 6taSH8ip4q8VYVHb4KYjynwuf5jGeZcp3EVcRCPu7/awrM/f+ItJ4Cf+e1DSCfEuZTOS
 R2kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5OV3Peere2H41uR6G/w5fMYttczB6L1foK+DR5jLb58kP9Ybp2fHidXm4oU/VuaOfBAOCqsw1emTS9aAsGaPgt+gV7A==
X-Gm-Message-State: AOJu0Yx6RBVU/wnLSlrbIpXx9UIrSIkJTw0RdYcQYZd1XL6jlyS1AXD8
 buOI3N0KHWejf38RlJUdxPuqI1I1iNdIWfdFeTPv7Lowh8UIv8wb9bddwkVFvNHbsFnG6B8Vvgu
 5kugwE/pSNWUT+pH5vsyu13lRwHpR1/2L7L1b7A==
X-Google-Smtp-Source: AGHT+IHr/GI1Y8DpJS8XqoRuxlzcUokN2bltGWJIgJRcAy/ExrtBHVrEa8l5aJVtUAWrHqs3s62htdkbJorM0qz4sjE=
X-Received: by 2002:a05:6a21:999e:b0:1b4:2f6:62b3 with SMTP id
 adf61e73a8af0-1c42857a5c4mr7780977637.26.1721718578375; Tue, 23 Jul 2024
 00:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
In-Reply-To: <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 10:09:02 +0300
Message-ID: <CAC_iWj++R_i-PRjEDAP-26OfKOxO17Fm239k_bBczDQHaonP_w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,


On Mon, 22 Jul 2024 at 15:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> > >
> > > > Add a Kconfig symbol to enable getting updates on any memory map
> > > > changes that might be done by the LMB module. This notification
> > > > mechanism can then be used to have a synchronous view of allocated and
> > > > free memory.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Change the description to highlight only LMB notifications.
> > > > * Add a separate line for dependencies.
> > > >
> > > >  lib/Kconfig | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > index 7eea517b3b..b422183a0f 100644
> > > > --- a/lib/Kconfig
> > > > +++ b/lib/Kconfig
> > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > >  config LIB_UUID
> > > >       bool
> > > >
> > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > +     bool "Get notified of any changes to the LMB memory map"
> > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > +     default y
> > > > +     help
> > > > +       Enable this option to get notification on any changes to the
> > > > +       memory that is allocated or freed by the LMB module. This will
> > > > +       allow different modules that allocate memory or maintain a memory
> > > > +       map to have a synchronous view of available and allocated memory.
> > >
> > > This needs to be select'd when it's going to be used, opting out of
> > > making sure memory reservations are obeyed isn't a good idea.
> >
> > +1 which begs the question, do we need the config option at all ?
>
> The config symbol can be used for removing the code for platforms
> which do not support EFI ?

In that case, it shouldn't be a user config option. It should be a
Kconfig symbol that is automatically set if EFI_LOADER is enabled.

Regards
/Ilias
>
> -sughosh
>
> >
> > Cheers
> > /Ilias
> > >
> > > --
> > > Tom
