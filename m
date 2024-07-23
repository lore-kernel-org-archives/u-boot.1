Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB0FC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 12:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A328872F;
	Tue, 23 Jul 2024 14:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EN9TqG2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83EF488496; Tue, 23 Jul 2024 14:43:16 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35258872F
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-66498fd4f91so50615117b3.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721738590; x=1722343390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gVr8FY/r5QXgIHJVHTeL9HpVj+vvt7WzsonxvPsu2Ns=;
 b=EN9TqG2aDhbm8vQ3T8Uf/1o+dqOlIMwzRk50QVN0zZe+yaAlei3N8m8VM9ircbYAP+
 GHBlXEyftVPCH5yGGAqsxp/d4L/BNRKGY588tdZSPVQm9/lImZhL8/fYhmJ4AwiaExuV
 4+COkvXPHfQGHH3YrI9l1LL6/QfOnyzAk/a7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721738590; x=1722343390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVr8FY/r5QXgIHJVHTeL9HpVj+vvt7WzsonxvPsu2Ns=;
 b=G/mS7uPhAi3y3sZsC8VnbRM0eEhZswfG74ABdv2zmFmCTgIxKJZ098SU5Q/bAjjql4
 cz0TkjH1h8KbWn+TtE7JCMcj49MLZotuJBQ2BzCFFqm6Z0QTDBCZ4/hGqYv+8gWJmGs+
 ZKpHv03gizILyxSZ2mYTo16pGolL6kLVK12DeeI/iIfVyssv8P/jC9rvRVA+EhnWcN1Q
 YgBiz+N/Kfqs/JOncSALgTFwPe04u/oodJcYW5A5pMiewbzLa9XXL9BqpBPZJFye9p6l
 T6cJq8U6wR/x/jHdVBl/WBIMLNy4u1bINnD7ePdEA7Uhx/ORGP44DrhXeCwfgJMTeZmu
 6z2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf5UjRmHXxRUlH7GvCIPDuXbWPo3CyBdVxXtW/94w19Tk7h1m8VBZtpiz6BGjRCgzoHFQ8Od9S2OAbVWuEwMFMeXj+8g==
X-Gm-Message-State: AOJu0Yz0bwHP3biUXH3t3uDOklbnepta030SqrYcu1e74JCa0ZHxYm31
 gYo0B7fOCc3lZlNcXAIRTjexObdv46QrHId/DwZnmHL26T2MHI0M31xirw6ZxpFqJIKJZX/7cBH
 rvMVaMckyubIZ4lWdRVufe4F9hcLmsK2u8Qyg
X-Google-Smtp-Source: AGHT+IHSuH3V6ZJ8s5UaotWsHN49F9H2+qxfD0i2Xk21VpsZGu+ohO9KjerhX9JB/KOvB68AFe0w22E0DP+rdPFtI1w=
X-Received: by 2002:a05:690c:318e:b0:64a:4161:4f91 with SMTP id
 00721157ae682-66ad8cc880dmr97091117b3.14.1721738590643; Tue, 23 Jul 2024
 05:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
In-Reply-To: <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jul 2024 13:42:59 +0100
Message-ID: <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
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

Hi Sughosh,

On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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

I am still of the so-far firm opinion that this can be done once,
before booting, rather than maintaining two separate tables as we go.

Regards,
Simon
