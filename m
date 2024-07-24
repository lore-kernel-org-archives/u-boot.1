Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D85C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0140088929;
	Wed, 24 Jul 2024 17:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iSgbe3b5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592428898B; Wed, 24 Jul 2024 17:40:51 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83EC28897D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e0875f1e9edso4151113276.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721835646; x=1722440446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VZQSzm833zFe+5Xruewp0tm85zrVqZs8SrLevamZegU=;
 b=iSgbe3b5oDLk0y6lwPbT/9wjaKB1DLTp/PwdMqOVadu7qWSyx6TTGYsHVR0F1ypDBi
 OaLL5oF1D//0TXHo/eujZWNMxfeIsRWiDVFDxtTeLI21/RAO/AjBINQa3WZ+8MdW7vu5
 vAmdkoLsPMV4mbB2e2YwFLd/mtE+bRGenuazo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721835646; x=1722440446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZQSzm833zFe+5Xruewp0tm85zrVqZs8SrLevamZegU=;
 b=pHn1uqIGZ9wAIWNQN8vIQXlxUC6/Ixo8Jyc0KfQR17S+uq2G/WnjyAdUfbvHBShCr4
 YBaYZ3O38gI1AVesCm/NERQCVIVYbmPXXSl2w1UP+63FawN4x5lzT9Qvy8prkeBoRM3G
 yZ2A9rH+k4IE/FST0LFd8IZEyuKu7BSwm4POfyvjrWl10CNpIsQZtr8chlLGmsWT3QDF
 kkmT87Mrp2SNZHXfQojpa6hxCjHBbkkSufdLb4j9hk+Fw7yOqJrUPytLaGpbx0CT5KKy
 Jf2sBNj0pwoTGoyX6/ypUusLod29xCNcRsBS0MZoAG5Uyk66GWTFS7j9S7ZQ4+uMi/gy
 zs8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNOmLR3aHP6d+b0txT9ZlkieEUcnqlSuAPp8YulLOCR6TI+fy9CnIlPeuBYApO22ptFMRqdhbWB+vX/REW8Wg1i3eIw==
X-Gm-Message-State: AOJu0YyibEeo15fFDaFatXnOvYjFjNskVbAsoR3x2ocdPpCyLPttpbhW
 yHtxka1Euwx/BQO3wHAVKYyql+Y6AC/WV9jHIEu95sQAcZ1S1dvTVLl0aib/HaxVlFbTMDJW8Rt
 m5FkNSlqP/q4fe5auBF2+8OxwhMIM4hjvd+gxf69jwBzI3Os=
X-Google-Smtp-Source: AGHT+IGgsMTcLREymf7Movu7swuEZvPmC4U1lVsv4Mz9NhPPqdYB4K7kJZmH0N+feMfF57ZQqWcrk0iRP8kLqQJbb6Q=
X-Received: by 2002:a05:6902:72a:b0:e03:5d90:cfc1 with SMTP id
 3f1490d57ef6-e0870062720mr21353123276.7.1721835646279; Wed, 24 Jul 2024
 08:40:46 -0700 (PDT)
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
In-Reply-To: <20240724145201.GL989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 09:40:35 -0600
Message-ID: <CAFLszTgoh6aLQ0BiHjkHYyzE9v0LP5d10Abq-k875kO7kP3ATA@mail.gmail.com>
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

On Wed, 24 Jul 2024 at 08:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 24, 2024 at 08:37:14AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 23 Jul 2024 at 08:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 01:42:59PM +0100, Simon Glass wrote:
> > > > Hi Sughosh,
> > > >
> > > > On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> > > > > > >
> > > > > > > > Add a Kconfig symbol to enable getting updates on any memory map
> > > > > > > > changes that might be done by the LMB module. This notification
> > > > > > > > mechanism can then be used to have a synchronous view of allocated and
> > > > > > > > free memory.
> > > > > > > >
> > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > ---
> > > > > > > > Changes since V1:
> > > > > > > > * Change the description to highlight only LMB notifications.
> > > > > > > > * Add a separate line for dependencies.
> > > > > > > >
> > > > > > > >  lib/Kconfig | 10 ++++++++++
> > > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > > index 7eea517b3b..b422183a0f 100644
> > > > > > > > --- a/lib/Kconfig
> > > > > > > > +++ b/lib/Kconfig
> > > > > > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > > > > > >  config LIB_UUID
> > > > > > > >       bool
> > > > > > > >
> > > > > > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > > > > > +     bool "Get notified of any changes to the LMB memory map"
> > > > > > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > > > > > +     default y
> > > > > > > > +     help
> > > > > > > > +       Enable this option to get notification on any changes to the
> > > > > > > > +       memory that is allocated or freed by the LMB module. This will
> > > > > > > > +       allow different modules that allocate memory or maintain a memory
> > > > > > > > +       map to have a synchronous view of available and allocated memory.
> > > > > > >
> > > > > > > This needs to be select'd when it's going to be used, opting out of
> > > > > > > making sure memory reservations are obeyed isn't a good idea.
> > > > > >
> > > > > > +1 which begs the question, do we need the config option at all ?
> > > > >
> > > > > The config symbol can be used for removing the code for platforms
> > > > > which do not support EFI ?
> > > >
> > > > I am still of the so-far firm opinion that this can be done once,
> > > > before booting, rather than maintaining two separate tables as we go.
> > >
> > > Did you see the part in the thread where he explained the multiple entry
> > > points that would need to be kept in sync?
> >
> > Yes, but I'm not sure what they are, nor why a shared function cannot
> > be called twice from two different places.
>
> Because we don't want to miss the third or fourth entry point down the
> road. That's why going the other direction makes more sense I believe,
> we won't have a future problem here because we designed with that in
> mind.

You might be right, but I don't even know what we are referring to
here...what are the two 'entry points'?

My current belief is that we can set up the EFI memory table before
booting, with a single pass through the table. Maintaining two
independent tables as we go doesn't seem very useful. It is harder to
test too.

Regards,
Simon
