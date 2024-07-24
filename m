Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A91C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A18B88950;
	Wed, 24 Jul 2024 16:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FIApjkKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0773D88920; Wed, 24 Jul 2024 16:37:29 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D978F8895D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-65cd720cee2so68809677b3.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831846; x=1722436646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jcv0xRB+t/lQ24cY2EvHropBDzNEtxeTwdJm4XnAByk=;
 b=FIApjkKFwNL12syCBu0ULd2IrCHO+ypJmzrbM88KyC2ZegI1+0GqIkYOit+b1diF7T
 y1GlP/0F74Rm1/K9v6jjvCSt/oOwC2ESnR+bXknz9ojKWuBlEHlfNohi/XUJCXtoB6MW
 4LEsHP+QLP9U6JD75lfcKb89GCFYUg+zDsbIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831846; x=1722436646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jcv0xRB+t/lQ24cY2EvHropBDzNEtxeTwdJm4XnAByk=;
 b=w5VOfB4BXDVGtQnuohdmGSX7Ggpw90bS3tpferApQOIctxetrL93bPNR9qX/9X5nW5
 X0VWbKcJ2IkyNHnGLLqftncyKKW6oeQOag6WwPbmNIkP8cpqGDAByqUIP5h2yKGUfKJ8
 vUc5Nj8Jii0GHs8rRFaAzmZTrmOd3nj5bCsYpZupefdBRr58TtEoqmkZAyCATWf8xyPL
 ILU7f3l1583124w+Ml9gkMhU8weEDdQ92vF6xa5RHRxxkWkz7V3SWlscR4M0Cxk85Ds5
 x++SBXYvVEG/xtW0K0CTi0704ce8lmy+f/bhNQo6DO2c8kpsRst7yuCE11k0LfVAlWB1
 oFbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYSlqO9bHRy7zF1PCY292USr3GOfNtunMYDPRjiT9QN72IyK3pZsqnijDZZk3h9q2rq59VxAFQYVZFQnNYSXqWGRQKyQ==
X-Gm-Message-State: AOJu0YyTAvriRdRmLOQvwCX71iYKdfRAH97F8dl6bFxX6BD62LJ1xm0i
 1Xbt9qXnyYE7NarXSxV2PhYOSL5nWifNEHb55ojwAAdGBAz482jt6yj8VvSQ0M0ttzyeNQcovDS
 j2nxLNdINT/zGoQs15VqCpr/BoSs6WmfpjcaJuZ3x8/0OGIU=
X-Google-Smtp-Source: AGHT+IH+Rw4SLKcY+vjP32sJz/3/SouyTzZtnA4UlIMxTOnCgkLzo6VQ0XQFqGwDERZ7T35E/NB2b9tXRMq6n9fmdi4=
X-Received: by 2002:a0d:fb07:0:b0:627:778f:b0a8 with SMTP id
 00721157ae682-671f589adb3mr30939637b3.42.1721831845700; Wed, 24 Jul 2024
 07:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
 <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
 <20240723142055.GG989285@bill-the-cat>
In-Reply-To: <20240723142055.GG989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:37:14 -0600
Message-ID: <CAFLszTgG9WuzYp97ANm=k3iju-DH+c5A2HfgwmUznti9tQyzpw@mail.gmail.com>
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

On Tue, 23 Jul 2024 at 08:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 23, 2024 at 01:42:59PM +0100, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> > > > >
> > > > > > Add a Kconfig symbol to enable getting updates on any memory map
> > > > > > changes that might be done by the LMB module. This notification
> > > > > > mechanism can then be used to have a synchronous view of allocated and
> > > > > > free memory.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > * Change the description to highlight only LMB notifications.
> > > > > > * Add a separate line for dependencies.
> > > > > >
> > > > > >  lib/Kconfig | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > >
> > > > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > index 7eea517b3b..b422183a0f 100644
> > > > > > --- a/lib/Kconfig
> > > > > > +++ b/lib/Kconfig
> > > > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > > > >  config LIB_UUID
> > > > > >       bool
> > > > > >
> > > > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > > > +     bool "Get notified of any changes to the LMB memory map"
> > > > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > > > +     default y
> > > > > > +     help
> > > > > > +       Enable this option to get notification on any changes to the
> > > > > > +       memory that is allocated or freed by the LMB module. This will
> > > > > > +       allow different modules that allocate memory or maintain a memory
> > > > > > +       map to have a synchronous view of available and allocated memory.
> > > > >
> > > > > This needs to be select'd when it's going to be used, opting out of
> > > > > making sure memory reservations are obeyed isn't a good idea.
> > > >
> > > > +1 which begs the question, do we need the config option at all ?
> > >
> > > The config symbol can be used for removing the code for platforms
> > > which do not support EFI ?
> >
> > I am still of the so-far firm opinion that this can be done once,
> > before booting, rather than maintaining two separate tables as we go.
>
> Did you see the part in the thread where he explained the multiple entry
> points that would need to be kept in sync?

Yes, but I'm not sure what they are, nor why a shared function cannot
be called twice from two different places.

Regards,
Simon
