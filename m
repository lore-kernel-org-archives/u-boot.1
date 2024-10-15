Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86310CFC27C
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 747DE88B5D;
	Tue, 15 Oct 2024 17:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UYdrFL/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF27088969; Tue, 15 Oct 2024 17:28:10 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4CA788AC2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbe8119e21so44753146d6.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729006087; x=1729610887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R5eREgCnzBuwuMDrr+BI8UyW3R+9W+lYmu4ISd0JRMg=;
 b=UYdrFL/QBL2rXjX+mm470HzbOXCBX8lupkMBYgp+LNaFhwMSRst8/NW+k0BRpenNrG
 wCnduA+5YO7WT/P9+Srnk7ocnJX54YFWIn+DB8fjWBB8b+IiKNk6I4Ts6qw9Riyp35AD
 X24sC4e6NnlJfROk/ULpvCM8ptj/5pJrodA48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729006087; x=1729610887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5eREgCnzBuwuMDrr+BI8UyW3R+9W+lYmu4ISd0JRMg=;
 b=urXNWG6eKG9N/umCgJd8uI+//UIR/5r8LVe/3sZQL++L5Zo52hEnljaOVNBK03s4dg
 NEjq81fOoKdVLmSpA3JxxGUadl478tpnRMwQu5fou20FFgI9nad/FLSgGoKjdUFrKMR4
 T4gie6KkhH6wtGbcgEnu/iTcRavuV/fTxiiSCsJYv5WIvnbxJbIYP07VjCQ+gzb/x5DJ
 jW3mptneFVI0eJSMX/tceDF3PKMJReA3tFTnzvBZ675G1pzpXoC/IrsNLoXEw6KQCn4A
 TREKJqb+uK8n+aR75KA3DgbleynNZQ4mgIW7lYj+SUv5Y8mj6h6rL8ODK5BV3xGjqAP/
 rjvg==
X-Gm-Message-State: AOJu0YwEliNO/t3B7sRL2/fmfIusnGap0QU2ffb3PiToweAw3l+RJ+AV
 LmPd3wDV1VJrnC5ZSFjH7EfAENDDhnxByalcgp07eI2rxvQ33JPdI5SdL1KL/D6MDUaDP21FQAU
 +VwREJ4vm31F78dgBSqpjLKqAsmlv+0I5ILks
X-Google-Smtp-Source: AGHT+IEHqQy9pOslFVttRC4nu30PzbtDdEP3pi0VJzZu3HdLoTvEMnF+RBmcM+XWKRn3vBmW2JJA8CGBVMFNE31tIiE=
X-Received: by 2002:a05:6214:31a1:b0:6cb:eb0e:761f with SMTP id
 6a1803df08f44-6cc2b8dc202mr10131066d6.27.1729006087552; Tue, 15 Oct 2024
 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-4-sjg@chromium.org>
 <20241015143730.GN53053@bill-the-cat>
In-Reply-To: <20241015143730.GN53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 09:27:56 -0600
Message-ID: <CAFLszTgpH-exrut_8A58sAU=x4yUy6rjUe1TwOBCONTPN6fo7g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] am65x: Use map_to_sysmem() to convert from pointer
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, Nishanth Menon <nm@ti.com>
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

On Tue, 15 Oct 2024 at 08:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 15, 2024 at 07:33:00AM -0600, Simon Glass wrote:
>
> > The board_init_f() function for am65x is a bit confusing, since it uses
> > the variable name 'pool_addr' to hold a pointer. It then casts it to an
> > address to pass to mem_alloc_init()
> >
> > Rename the variable and use mapmem to convert to an address.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/mach-k3/am65x/am654_init.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-k3/am65x/am654_init.c b/arch/arm/mach-k3/am65x/am654_init.c
> > index a4f038029d7..ddcc1355210 100644
> > --- a/arch/arm/mach-k3/am65x/am654_init.c
> > +++ b/arch/arm/mach-k3/am65x/am654_init.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <fdt_support.h>
> >  #include <init.h>
> > +#include <mapmem.h>
> >  #include <asm/global_data.h>
> >  #include <asm/io.h>
> >  #include <spl.h>
> > @@ -165,7 +166,7 @@ void board_init_f(ulong dummy)
> >  #if defined(CONFIG_K3_LOAD_SYSFW) || defined(CONFIG_K3_AM654_DDRSS)
> >       struct udevice *dev;
> >       size_t pool_size;
> > -     void *pool_addr;
> > +     void *pool;
> >       int ret;
> >  #endif
> >       /*
> > @@ -204,14 +205,14 @@ void board_init_f(ulong dummy)
> >        * malloc pool of which we use all that's left.
> >        */
> >       pool_size = CONFIG_VAL(SYS_MALLOC_F_LEN) - gd->malloc_ptr;
> > -     pool_addr = malloc(pool_size);
> > -     if (!pool_addr)
> > +     pool = malloc(pool_size);
> > +     if (!pool)
> >               panic("ERROR: Can't allocate full malloc pool!\n");
> >
> > -     mem_malloc_init((ulong)pool_addr, (ulong)pool_size);
> > +     mem_malloc_init(map_to_sysmem(pool), (ulong)pool_size);
> >       gd->flags |= GD_FLG_FULL_MALLOC_INIT;
> >       debug("%s: initialized an early full malloc pool at 0x%08lx of 0x%lx bytes\n",
> > -           __func__, (unsigned long)pool_addr, (unsigned long)pool_size);
> > +           __func__, (unsigned long)pool, (unsigned long)pool_size);
> >       /*
> >        * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
> >        * regardless of the result of pinctrl. Do this without probing the
>
> This covers half of what we talked about in v2. But map_to_sysmem() is a
> sandbox thing that should not be called outside of (a) arch/sandbox or
> (b) common code that runs on sandbox. And honestly, we should work to
> hide that abstraction as much as we can, not start introducing it more.

Yes that's right. Perhaps we should document that.

We can drop this patch.

Regards,
Simon
