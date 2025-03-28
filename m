Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61EBC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590228129B;
	Fri, 28 Mar 2025 16:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="muGzoMQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8789F8144A; Fri, 28 Mar 2025 16:06:05 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7107810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so2995853a91.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743174361; x=1743779161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GAXWC45HZ0pcjfTz0SB5sK7CIjkyI0oxI4oJPU/HKbY=;
 b=muGzoMQFimsji8h6F4kvmah9X1UbHswtopCtgNOwqJ48H4q8bCVGo4IG4F6JHmIUez
 KeDrTkx4+bu4NEgQaCsK/TNj3Pchi5+fc6BHTbLm9CMGcgaD+397qtCs2VypazcZGUDD
 D5yOZHpRPcZ3/KXXZzijMLmaBt6KCEUbcAT+AK3gOxQXTU/Z7AUe6jAuXREPilmOy79L
 K1hLdHWO9QYiAowsR7NUUelszm7kizPW5FL1eMFDMvqhJyZirgcfTHZ90iWn3KzgOxXt
 jwug7Y4kjeEoGnwmfPmZB7kmzZzejjyPQFSL97W6K3Ad0hT9M09DGCn348VcOpAecf5i
 cAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743174361; x=1743779161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GAXWC45HZ0pcjfTz0SB5sK7CIjkyI0oxI4oJPU/HKbY=;
 b=qr1cYJQhRgV90Vde9gxeS1vfDGU1fdaVknkMrTXDfiUTh8oO4d547d+hy85XGB85lr
 E9tXzvM7NyJwX8g+DNuMJ0WUUd/z3R4WzcApDvJZV44b8jMd2epcid7csyZ/JSHPso+m
 OIn0VY4/HGPiLLIeUOm8awRVpEvFxdrFTu+tKX05MVwyrmu7xTp6oLYW+NGMFKClwbse
 Xq75osjxbUtuwKu6xuKfXxATrpS8OB5fguzO04QYZlKuW2p1WgECUoqZofoqspEN8Qox
 SV8nwRCkynF3TD4JQWYWdMP84rcBRZOEGte3dzXlWBhc+xYsnkWn+IoGFDYcw4E+Ge5O
 +ujA==
X-Gm-Message-State: AOJu0Yyf+QvvR7I1K4fm0Nhes317y0B0IqopqF1YKzeXdpvL1VJcwnSS
 cNLKRky+ViLIiJA7uwKWDEBdGh4+b4mmoNhGSssPcIJb1wttDfsuOFuRMqWmv146ypAQ0v784u8
 YYYoMV4e/omRPCe2mv6WAcpVof0+kby8bnMMDNw==
X-Gm-Gg: ASbGnct1qvs0qFv5SkS9bY2R3wGAulsZJBFsm2TQK9ZyPjvXPjrEoFqkXjDbVVYOUdk
 9K8qY0Ix6BaXcaU7P144TiWNVvXuKIWPD200bt7Z3aT0nJmALC/OC646UW+ONSh5InFmVcJy1H4
 3C5sib4a3WmiqzULdcL0Qg0BF4FTbd
X-Google-Smtp-Source: AGHT+IGV+zfbc4u+AejX/QCmSXXK+NuUYFs+Oal9Bslqp36tO4dYYw4FpHey8JQb6HYyjZW2oclNVOvdFxdGkbK5h4I=
X-Received: by 2002:a17:90b:3c4b:b0:2fe:d766:ad95 with SMTP id
 98e67ed59e1d1-303a7d614e1mr12627840a91.9.1743174360935; Fri, 28 Mar 2025
 08:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
In-Reply-To: <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 11:05:47 -0400
X-Gm-Features: AQ5f1Jp1-kIyDlTsuPKnqa47AmShCjJPRO0EgNoYjU5TysPjVnvjt9krPUEXrGw
Message-ID: <CAEfUkULhW6fi9119WwTuUq__77Ga_ORcDpXsDzh+vs73QZmbkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Simon,

On Fri, 28 Mar 2025 at 07:35, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > is a default address for bootefi, bootm and booti to look for the
> > device tree when launching the kernel.
>
> I wonder if we can drop use of that environment variable at some
> point? It seems strange to set a variable to gd->fdt_addr only to use
> it later. Why not just use gd->fdt_addr ?
>

First, the fdtdec happens in an early stage and it is not able to set
the env variable at that time.
Secondly, the fdt_addr is commonly used to boot the kernel by booti,
bootm and bootefi, if it is not pointed to gd->fdt_addr when
gd->fdt_src is FDTSRC_BLOBLIST, it will need a big refactoring on all
boot commands to observe where it should get the correct fdt.

I don't agree with the idea that the board or env can override a valid
fdt handed off from the previous boot stage, it just messes up without
any benefits.

> I hit this in the bootstd conversion but wasn't sure what to do. So
> much confusion.
>
> I see quite a few boards setting this variable in their environment.
> So this patch would override that setting, wouldn't it? It's just not
> clear what any of this means.
>

This will be only active when "gd->fdt_src is FDTSRC_BLOBLIST" - It
explicitly indicates a previous boot stage is passing a valid fdt.
What is the purpose of dropping it?

> So I think at this point we should update the code to use the internal
> control FDT directly.
>
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  env/common.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/env/common.c b/env/common.c
> > index a58955a4f42..a38e5d107a8 100644
> > --- a/env/common.c
> > +++ b/env/common.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/global_data.h>
> >  #include <linux/printk.h>
> >  #include <linux/stddef.h>
> > +#include <mapmem.h>
> >  #include <search.h>
> >  #include <errno.h>
> >  #include <malloc.h>
> > @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
> >         return env_get_from_linear(default_environment, name, buf, len);
> >  }
> >
> > +static int env_update_fdt_addr_from_bloblist(void)
> > +{
> > +       /*
> > +        * fdt_addr is by default used by booti, bootm and bootefi,
> > +        * thus set it to point to the fdt embedded in a bloblist if it exists.
> > +        */
> > +       if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
> > +               return 0;
>
> This is just too messy, sorry.

This means we update the variable only when the bloblist is being used
and a valid fdt is in the bloblist which is already saved in the gd.
In other cases, the transfer list is not being used and the value from
the user will not be replaced.
Not sure why you feel messy.

Regards,
Raymond

>
> > +
> > +       return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
> > +}
> > +
> >  void env_set_default(const char *s, int flags)
> >  {
> >         if (s) {
> > @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
> >
> >         gd->flags |= GD_FLG_ENV_READY;
> >         gd->flags |= GD_FLG_ENV_DEFAULT;
> > +
> > +       /* This has to be done after GD_FLG_ENV_READY is set */
> > +       if (env_update_fdt_addr_from_bloblist())
> > +               pr_err("Failed to set fdt_addr to point at DTB\n");
> >  }
> >
> >  /* [re]set individual variables to their value in the default environment */
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
>
>
>
> On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > is a default address for bootefi, bootm and booti to look for the
> > device tree when launching the kernel.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  env/common.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/env/common.c b/env/common.c
> > index a58955a4f42..a38e5d107a8 100644
> > --- a/env/common.c
> > +++ b/env/common.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/global_data.h>
> >  #include <linux/printk.h>
> >  #include <linux/stddef.h>
> > +#include <mapmem.h>
> >  #include <search.h>
> >  #include <errno.h>
> >  #include <malloc.h>
> > @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
> >         return env_get_from_linear(default_environment, name, buf, len);
> >  }
> >
> > +static int env_update_fdt_addr_from_bloblist(void)
> > +{
> > +       /*
> > +        * fdt_addr is by default used by booti, bootm and bootefi,
> > +        * thus set it to point to the fdt embedded in a bloblist if it exists.
> > +        */
> > +       if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
> > +               return 0;
> > +
> > +       return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
> > +}
> > +
> >  void env_set_default(const char *s, int flags)
> >  {
> >         if (s) {
> > @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
> >
> >         gd->flags |= GD_FLG_ENV_READY;
> >         gd->flags |= GD_FLG_ENV_DEFAULT;
> > +
> > +       /* This has to be done after GD_FLG_ENV_READY is set */
> > +       if (env_update_fdt_addr_from_bloblist())
> > +               pr_err("Failed to set fdt_addr to point at DTB\n");
> >  }
> >
> >  /* [re]set individual variables to their value in the default environment */
> > --
> > 2.25.1
> >
