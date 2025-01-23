Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE23C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 15:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1ED801B0;
	Thu, 23 Jan 2025 16:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wUz6bCik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D15580214; Thu, 23 Jan 2025 16:51:16 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03D280137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 16:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2161eb94cceso13262995ad.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737647472; x=1738252272; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dDH8gZJ6mvQhxtOv1KRDTMzWg3NqNMyEDG0J4Z3XrGU=;
 b=wUz6bCikkAVIH1wZm0nPpgbpX62o43MXDAXgVJx0J9dxVn/Ksznwt8BXgJtnCIhgHN
 vRf5RAn0dSKKGhCnFvFxYP/ko7ytGEa7mjbHVjvl05zT665AL50y1HsxBVa4afUmWgke
 dBAeMNe+4B6gNMVijqhcwHAjKLTgIHYikwEHuzX5kanZ3h/kEAP7KTxp/XsY1FNDKPqx
 akBkx6M0/AoMg0ggKwdD53Va2GLttaYRn5cNBhf9A2cVrdx39kZM+1WqVQVE1gM6gN9+
 dv5yk2DN5ftQq5Os4gGfIrsFxieKLG7SxF2CmnX8YNlDRlXq/g3lZ9M2jfPS4Ae0fWIG
 Ng2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737647472; x=1738252272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dDH8gZJ6mvQhxtOv1KRDTMzWg3NqNMyEDG0J4Z3XrGU=;
 b=qcuhcDwsyJnekDtT92NBXLcukNOY46ciEoUCZuOH66zkgkoQ1wH8K5Mvz/m8/hi+5V
 yUViyMp7/kG6TP4kQl0tYskoEJiIVgCkI0xdEbocejOSP4JGfNdDdpM46F87eBXlxv6y
 /me1Xwl+u6a4cDgZJUDt1s4sihHQT0weYHsrkW/cfzhN/8vQJByIP/dYiFTempfF3d21
 3kzhV28vMDj9h/HV9ducGCGBjgnZiVc9kleW3Vo9A3enOXNWDJ1zXkyW4oA1n6qUFwun
 e86sbOeN1z+aXk52sRKcV8RslT0MpEkFgA5IYpiU2h8a1/7ugX2hnLz2f89DfRoxmJzm
 Sx1w==
X-Gm-Message-State: AOJu0Yz7N+g8JwT+RUoojPLEZTbtHbgL4NIzQK3BN7DvaMqCNZq1fCkf
 bemnYsXrAH2470VfbUB9q+DEMFsiP8eyahgADVwULMqRMg7SGEX/hefWTcVQrj2qQ97Rf68L2hp
 7TBggtC/fKw0FSdaNRN8UFehMk6FGVLaZMyyo5Q==
X-Gm-Gg: ASbGncvZKc/dTCR3BpLOd5TNoJcgK/E7WEkuJl6NzLUpLJg2vIqoan02P6wnGK3cic1
 4xKEUVMYy6u26o81l/dWB1U+1QSOHQxnoykxwXR8DV/r3+QM8KjvpXrstmYZXmuXLETcV7cnDOG
 AmAv/dXgOkjomK3N7kNo4=
X-Google-Smtp-Source: AGHT+IEc+RQJ/x/+81g+J3efL89uaM53IWoSF67S7NyIHlvDUFf/ZthFFQPkV5bqKwo/4e6zXO8QKaUZnyXRkHe99LI=
X-Received: by 2002:a17:903:22c4:b0:215:352c:af73 with SMTP id
 d9443c01a7336-21c3550db34mr340514935ad.18.1737647472277; Thu, 23 Jan 2025
 07:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20250117163545.88627-1-raymond.mao@linaro.org>
 <20250117163545.88627-3-raymond.mao@linaro.org>
 <CAC_iWjJ0JO8sB4Q5Gc_5LBByaVmiz6D0sgWjFggqCd9xEX2RLg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ0JO8sB4Q5Gc_5LBByaVmiz6D0sgWjFggqCd9xEX2RLg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 23 Jan 2025 10:50:58 -0500
X-Gm-Features: AbW1kvYWTEMBI5B7hElqM0vgHa6ETxwcS4dapQFaUD4-GcbKnFSqf-cyaqmZrLQ
Message-ID: <CAEfUkUKOqF=yOjqxKszQwY3q_3JOq4jPpRWw0oy19gTheMbL9A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tpm: get tpm event log from bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Thu, 23 Jan 2025 at 02:00, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Fri, 17 Jan 2025 at 18:36, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Get tpm event log from bloblist instead of FDT when bloblist is
> > enabled and valid from previous boot stage.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Remove patch dependency.
> > - Remove the fallback to FDT when BLOBLIST is selected.
> > Changes in v3
> > - Malloc an 8KB buffer when user eventlog buffer does not exist.
> > Changes in v4
> > - Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
> > Changes in v5
> > - Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
> > - Add an inline TODO comment.
> > Changes in v6
> > - Remove the malloc and keep the buffer pointed by "sml" for the fallback
> >   as it is the right place for linux to discover the eventlog.
> >
> >  lib/tpm_tcg2.c | 58 +++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 38 insertions(+), 20 deletions(-)
> >
> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > index 4134d93a35..6425bf143a 100644
> > --- a/lib/tpm_tcg2.c
> > +++ b/lib/tpm_tcg2.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <dm.h>
> >  #include <dm/of_access.h>
> > +#include <malloc.h>
>
> This is probably a leftover from your V2
>
>
Yes, I will remove it.


> >  #include <tpm_api.h>
> >  #include <tpm-common.h>
> >  #include <tpm-v2.h>
> > @@ -19,6 +20,7 @@
> >  #include <linux/unaligned/generic.h>
> >  #include <linux/unaligned/le_byteshift.h>
> >  #include "tpm-utils.h"
> > +#include <bloblist.h>
> >
> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32
> *active_bank,
> >                       u32 *bank_num)
> > @@ -672,21 +674,40 @@ void tcg2_measurement_term(struct udevice *dev,
> struct tcg2_event_log *elog,
> >
> >  __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32
> *size)
> >  {
> > -       const __be32 *addr_prop;
> > -       const __be32 *size_prop;
> > +       const __be32 *addr_prop = NULL;
> > +       const __be32 *size_prop = NULL;
> >         int asize;
> >         int ssize;
> > +       struct ofnode_phandle_args args;
> > +       phys_addr_t a;
> > +       fdt_size_t s;
> >
> >         *addr = NULL;
> >         *size = 0;
> >
> > -       addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
> > -       if (!addr_prop)
> > -               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> > +       *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> > +       if (*addr && *size)
>
> Don't we need map_physmem here as well?
>
>
I don't think so. Unlike the ones from dt, bloblist_get_blob() returns a
virtual address.

Regards,
Raymond


> Thanks
> /Ilias
> > +               return 0;
> >
> > -       size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
> > -       if (!size_prop)
> > +       /*
> > +        * TODO:
> > +        * Replace BLOBLIST with a new kconfig for handoff all components
> > +        * (fdt, tpm event log, etc...) from previous boot stage via
> bloblist
> > +        * mandatorily following Firmware Handoff spec.
> > +        */
> > +       if (!CONFIG_IS_ENABLED(BLOBLIST)) {
> > +               addr_prop = dev_read_prop(dev, "tpm_event_log_addr",
> &asize);
> > +               size_prop = dev_read_prop(dev, "tpm_event_log_size",
> &ssize);
> > +       }
> > +
> > +       /*
> > +        * If no eventlog was observed, a sml buffer is required for the
> kernel
> > +        * to discover the eventlog.
> > +        */
> > +       if (!addr_prop || !size_prop) {
> > +               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> >                 size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
> > +       }
> >
> >         if (addr_prop && size_prop) {
> >                 u64 a = of_read_number(addr_prop, asize /
> sizeof(__be32));
> > @@ -694,22 +715,19 @@ __weak int tcg2_platform_get_log(struct udevice
> *dev, void **addr, u32 *size)
> >
> >                 *addr = map_physmem(a, s, MAP_NOCACHE);
> >                 *size = (u32)s;
> > -       } else {
> > -               struct ofnode_phandle_args args;
> > -               phys_addr_t a;
> > -               fdt_size_t s;
> >
> > -               if (dev_read_phandle_with_args(dev, "memory-region",
> NULL, 0,
> > -                                              0, &args))
> > -                       return -ENODEV;
> > +               return 0;
> > +       }
> > +
> > +       if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0,
> &args))
> > +               return -ENODEV;
> >
> > -               a = ofnode_get_addr_size(args.node, "reg", &s);
> > -               if (a == FDT_ADDR_T_NONE)
> > -                       return -ENOMEM;
> > +       a = ofnode_get_addr_size(args.node, "reg", &s);
> > +       if (a == FDT_ADDR_T_NONE)
> > +               return -ENOMEM;
> >
> > -               *addr = map_physmem(a, s, MAP_NOCACHE);
> > -               *size = (u32)s;
> > -       }
> > +       *addr = map_physmem(a, s, MAP_NOCACHE);
> > +       *size = (u32)s;
> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >
>
