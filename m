Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7ACC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301CF80708;
	Thu, 16 Jan 2025 15:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O+t1pv1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDC680703; Thu, 16 Jan 2025 15:35:52 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347158022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53c9035003so1606141276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737038149; x=1737642949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7NoCW5IZy44MUXhOERYpEYbqZ4k7cBFqW/+Z7M3scc=;
 b=O+t1pv1OdRx3OPltdO0mqhJmQ8pJ5FRX+h9dzXghcI+gzp0teshM3hX+uEC97iFU4w
 hvkhdObOLiKh6aHBDLQtqy9tRmvRDnTttqZuVJwzF1NqMMUG7Aqakof3wvqXsJ1gQu1R
 WlEmuBlPn0FDzTb6UUAHjL9IegYzlPs8DCnsaaLOUSKpIbSdI5ZApW2pizjtpLogjoUl
 uAVuKP3EiQir192Pg7cPK+ZWcPlzPjqTxVi0DG4SfkC7ohznB65xszco40EVe9ahAH+F
 EX/GTZ7R4vtfDe8F0NSCVf0SAasQiqvTr2JJsvtY7lIraADYWp9POsUxF6tGv5yYSF7s
 iMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038149; x=1737642949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z7NoCW5IZy44MUXhOERYpEYbqZ4k7cBFqW/+Z7M3scc=;
 b=aISmwscO31msOX7YeLcDP91o99mjpKUTEWJ9w7CGidUr/i+JAw5inwfm4K4U8ctCFK
 w6T750aMVRsf+ABDJOvPO3KeXGexZHmwxRJocUWPQHR8QHmStsR3YLPzv0ZdDkuocH86
 GCiUqpIu6cn8jW9LBunyRzan4u71/kAKLOOYx+DECzTPUgYExxR60GLJ/Rbwf+MfM0pO
 T37SPfqUjKSKnE20FtksPa5tys+ap0lKU6bc1AnrDAqtlEyS7XQgeyo6amVV26n4B8H7
 98VZ5t1jk022POf56A5IV2h+w3q84KiAELMpaTBWvgp09A+6NAYQXAgZP/OpvlLlCXii
 JLDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/tFo4SS7d1v+EarV7O/k8ycXCRy90Rvh3dCdV5ZF0gEcFhi40mtPS4vHsFpC78DHwBLrg/Iw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3FH+J5eHzy8ne1n/4rAemxkqnD5kMGAXFtWWsOgUdOXdTopqP
 mJMWlH/v7vRfK0E79vOJgJRShMI3wazP8tKbaxcmhp8q9Q1UPSa61nik+fq9+ninBrHkUAS2AS0
 qqqcLrHWI6JARZ7499evj4BwWBelrwzrLzI/2gA==
X-Gm-Gg: ASbGnctBJWVPA9DnBLhqN6NkNx9+2qlEJDTe251qdtVqUR6uqw4HwArMKNuUC5i7V1X
 Ykbzt6mjKRVxYsCMNieM9G5Tm+8zGKCQ5IHsVIg==
X-Google-Smtp-Source: AGHT+IFWABF2oZXzWU/8iLevzrarOElKwjctSQG3VPmf/RvxriI4c4LcKr294RwBhkkvaZyGN4k4StLxz3pBm8AHhk8=
X-Received: by 2002:a05:690c:4983:b0:6ef:57ad:9d91 with SMTP id
 00721157ae682-6f531238d2amr292353217b3.24.1737038148819; Thu, 16 Jan 2025
 06:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20250114152022.933662-1-raymond.mao@linaro.org>
 <20250114152022.933662-3-raymond.mao@linaro.org>
 <CAFLszTh=d=Brcrd-4He0nDZgybjKOdAqqUxvh_z245xjF1giuw@mail.gmail.com>
In-Reply-To: <CAFLszTh=d=Brcrd-4He0nDZgybjKOdAqqUxvh_z245xjF1giuw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 16:35:12 +0200
X-Gm-Features: AbW1kvaquEag0-1laYSD5K8MRP09zZDvLyAj9Mpz2Km6jEd3ncydzKPdjY6G_uw
Message-ID: <CAC_iWjL7y6QyjQtRp6qd_5QxF6aUw+qrhY6snXZ2B-Qiz7Dy1g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tpm: get tpm event log from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Wed, 15 Jan 2025 at 03:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Tue, 14 Jan 2025 at 08:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Get tpm event log from bloblist instead of FDT when bloblist is
> > enabled and valid from previous boot stage.
> >
> > As a fallback, when no event log from previous stage is observed
> > and no user buffer is passed, malloc a default buffer to initialize
> > the event log.
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
> >
> >  lib/tpm_tcg2.c | 61 ++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 42 insertions(+), 19 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> nit in case you respin again: -ENODEV is for driver model, when there
> is no device. It is actually handling specially by driver model. So
> -ENOENT is what I try to use for things that don't exist but aren't
> devices.
>

+1,


> >
> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > index 4134d93a35..2d9076f091 100644
> > --- a/lib/tpm_tcg2.c
> > +++ b/lib/tpm_tcg2.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <dm.h>
> >  #include <dm/of_access.h>
> > +#include <malloc.h>
> >  #include <tpm_api.h>
> >  #include <tpm-common.h>
> >  #include <tpm-v2.h>
> > @@ -19,6 +20,7 @@
> >  #include <linux/unaligned/generic.h>
> >  #include <linux/unaligned/le_byteshift.h>
> >  #include "tpm-utils.h"
> > +#include <bloblist.h>
> >
> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
> >                       u32 *bank_num)
> > @@ -615,15 +617,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
> >                 elog->found = log.found;
> >         }
> >
> > +       if (elog->found)
> > +               return 0;
> > +
> >         /*
> > -        * Initialize the log buffer if no log was discovered and the buffer is
> > -        * valid. User's can pass in their own buffer as a fallback if no
> > -        * memory region is found.
> > +        * Initialize the log buffer if no log was discovered.
> > +        * User can pass in their own buffer as a fallback if no memory region
> > +        * is found, else malloc a buffer if it does not exist.
> >          */
> > -       if (!elog->found && elog->log_size)
> > -               rc = tcg2_log_init(dev, elog);
> > +       if (!elog->log_size) {
> > +               elog->log = malloc(CONFIG_TPM2_EVENT_LOG_SIZE);
> > +               if (!elog->log)
> > +                       return -ENOMEM;
> > +
> > +               memset(elog->log, 0, CONFIG_TPM2_EVENT_LOG_SIZE);
> > +               elog->log_size = CONFIG_TPM2_EVENT_LOG_SIZE;

Why are you doing this? There are 2 ways to pass an EventLog to the
kernel. Either via a config table from EFI, or using sml-base and
sml-size in a DT (which are both required). IOW you will create an
EventLog no one will discover

Cheers
/Ilias


> > +       }
> >
> > -       return rc;
> > +       return tcg2_log_init(dev, elog);
> >  }
> >
> >  int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
> > @@ -676,10 +687,25 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> >         const __be32 *size_prop;
> >         int asize;
> >         int ssize;
> > +       struct ofnode_phandle_args args;
> > +       phys_addr_t a;
> > +       fdt_size_t s;
> >
> >         *addr = NULL;
> >         *size = 0;
> >
> > +       *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> > +       if (*addr && *size)
> > +               return 0;
> > +       /*
> > +        * TODO:
> > +        * replace BLOBLIST with a new kconfig for handoff all components
> > +        * (fdt, tpm event log, etc...) from previous boot stage via bloblist
> > +        * mandatorily following Firmware Handoff spec.
> > +        */
> > +       else if (CONFIG_IS_ENABLED(BLOBLIST))
> > +               return -ENODEV;
> > +
> >         addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
> >         if (!addr_prop)
> >                 addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> > @@ -694,22 +720,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> >
> >                 *addr = map_physmem(a, s, MAP_NOCACHE);
> >                 *size = (u32)s;
> > -       } else {
> > -               struct ofnode_phandle_args args;
> > -               phys_addr_t a;
> > -               fdt_size_t s;
> >
> > -               if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
> > -                                              0, &args))
> > -                       return -ENODEV;
> > +               return 0;
> > +       }
> >
> > -               a = ofnode_get_addr_size(args.node, "reg", &s);
> > -               if (a == FDT_ADDR_T_NONE)
> > -                       return -ENOMEM;
> > +       if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args))
> > +               return -ENODEV;
> >
> > -               *addr = map_physmem(a, s, MAP_NOCACHE);
> > -               *size = (u32)s;
> > -       }
> > +       a = ofnode_get_addr_size(args.node, "reg", &s);
> > +       if (a == FDT_ADDR_T_NONE)
> > +               return -ENOMEM;
> > +
> > +       *addr = map_physmem(a, s, MAP_NOCACHE);
> > +       *size = (u32)s;
> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >
>
> Regards,
> SImon
