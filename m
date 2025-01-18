Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F69C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 10:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40C480792;
	Sat, 18 Jan 2025 11:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eolneqV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7AF80786; Sat, 18 Jan 2025 11:08:03 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4275F8063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 11:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e39779a268bso4580733276.1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 02:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737194876; x=1737799676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cdeURmY1Utuj3vRgHeQJpa3e4zGvo4Tok7bpDceSjps=;
 b=eolneqV4CfjDBkPAAeDPN+EL2WFsVa4Hv8dPaGWc4BvSy1aAaSzO1nDluL4GyyALzn
 jNvUjK0pSvILw2z5wgUiVpBd4KtBAioWMhP20pW9qBHG4F0BAtEgx3OjzFFq7PRk4NI6
 oDhD3Tt4KZPzP25khbcoqEs5iHVaoiLEFbfq/iBlkSx5qAi8u9Qh6DRqCfPDv10VunBK
 ixhUPBIr/hCIZ+np/tFSaZGYR17Q/SdpcJ8PXPbp70u2MosS0zMMjvRN6J7EcNiNcNRb
 D+g3dWhwokuqpDvwmRB+X/EyJ96qOYsSb1QPlxUdOBSqt6l+apiReXLv5Za9cnlMRDqO
 VoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737194876; x=1737799676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdeURmY1Utuj3vRgHeQJpa3e4zGvo4Tok7bpDceSjps=;
 b=WuDWZ7cK+nUoDI780r1NSmm6F3aLNMxidQU7gKHZ4NI5Dmym+2MeLgc92IDimYXhj+
 foT+nrhcdmL578HO256EpOKPl3fkSgVWULfSUZSK4aqaKIY8JAvPIU3J/xoLQsSPkTrG
 I9SDGajDEwKKzFSkaeYH/gtHXgxiHCQBwvgNyK98auKVPu8pp1wtAANKRB+UYob5eQE+
 +JXg6mOiUC2LZmgegdV3WDfx1DKnB8qMHpP9noJRZq2+DHyk1MyHDevnIS6HiWHAN5kK
 8423URJeJJ+RMNamr0NMOb53glnsZswRf2NMoRKYXqS/x2Kg5UEAsen3iz82h5Fwpaxw
 GpOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv2LbprzHxwNTiT9BwLPsv1iM4CnC3jrdvbCmUYCsczs8YJAi6Zn0R8skUceCyNlIygdwvKec=@lists.denx.de
X-Gm-Message-State: AOJu0YwP1Bqora4n0rKDHRIutVA46Cps378spMcVilYxaCT48xfX3SZd
 AMTOFU6vYqbnxg70YQVhpAkl3KwLy3IHLM8OubvyImFlHE/+3V94jKwc5hWcD+sxDeF92W427Rn
 O9L76GUnLo9PWXKkPPZklXm5s3XFEtLbo+DirMA==
X-Gm-Gg: ASbGncv/dl3y3dh62ZXHRKV12fM6PMi4+O5aSa7Hn7DeQ+fwHa+2B4RR+UZnKWsex9Z
 G6RY6QeqJjdSgLeVHdkgwkpW9P521eprKmFRKxYgmgPTlazRukbs=
X-Google-Smtp-Source: AGHT+IEBu6h+NY3pq+QUO+OqGjclK988CaMb04zZIw9sm29SYc7YN30PjB7/BE7DuIyXn3o2WNNANDsEiJaT3naWxio=
X-Received: by 2002:a05:6902:12cc:b0:e57:3a14:a22a with SMTP id
 3f1490d57ef6-e57b0c59d08mr4670200276.19.1737194875981; Sat, 18 Jan 2025
 02:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20250114152022.933662-1-raymond.mao@linaro.org>
 <20250114152022.933662-3-raymond.mao@linaro.org>
 <CAFLszTh=d=Brcrd-4He0nDZgybjKOdAqqUxvh_z245xjF1giuw@mail.gmail.com>
 <CAC_iWjL7y6QyjQtRp6qd_5QxF6aUw+qrhY6snXZ2B-Qiz7Dy1g@mail.gmail.com>
 <CAFLszTiE05TAFQfcGANsCve-UhRV8gh6ZUB-nLZeLQpAr+0sRQ@mail.gmail.com>
In-Reply-To: <CAFLszTiE05TAFQfcGANsCve-UhRV8gh6ZUB-nLZeLQpAr+0sRQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Jan 2025 12:07:20 +0200
X-Gm-Features: AbW1kvbyQNRHbdztgxxnDz7g-kil0aaLmo5DBRxkB0nvP5P_IKXIaPeI24ACevA
Message-ID: <CAC_iWjJZUVmyYN6j1AFYGejaXWYNg2vXOz8VMKhObcj9u2HrtQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tpm: get tpm event log from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

On Sat, 18 Jan 2025 at 06:31, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 16 Jan 2025 at 07:35, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 15 Jan 2025 at 03:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Tue, 14 Jan 2025 at 08:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Get tpm event log from bloblist instead of FDT when bloblist is
> > > > enabled and valid from previous boot stage.
> > > >
> > > > As a fallback, when no event log from previous stage is observed
> > > > and no user buffer is passed, malloc a default buffer to initialize
> > > > the event log.
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > > Changes in v2
> > > > - Remove patch dependency.
> > > > - Remove the fallback to FDT when BLOBLIST is selected.
> > > > Changes in v3
> > > > - Malloc an 8KB buffer when user eventlog buffer does not exist.
> > > > Changes in v4
> > > > - Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
> > > > Changes in v5
> > > > - Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
> > > > - Add an inline TODO comment.
> > > >
> > > >  lib/tpm_tcg2.c | 61 ++++++++++++++++++++++++++++++++++----------------
> > > >  1 file changed, 42 insertions(+), 19 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > nit in case you respin again: -ENODEV is for driver model, when there
> > > is no device. It is actually handling specially by driver model. So
> > > -ENOENT is what I try to use for things that don't exist but aren't
> > > devices.
> > >
> >
> > +1,
> >
> >
> > > >
> > > > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > > index 4134d93a35..2d9076f091 100644
> > > > --- a/lib/tpm_tcg2.c
> > > > +++ b/lib/tpm_tcg2.c
> > > > @@ -5,6 +5,7 @@
> > > >
> > > >  #include <dm.h>
> > > >  #include <dm/of_access.h>
> > > > +#include <malloc.h>
> > > >  #include <tpm_api.h>
> > > >  #include <tpm-common.h>
> > > >  #include <tpm-v2.h>
> > > > @@ -19,6 +20,7 @@
> > > >  #include <linux/unaligned/generic.h>
> > > >  #include <linux/unaligned/le_byteshift.h>
> > > >  #include "tpm-utils.h"
> > > > +#include <bloblist.h>
> > > >
> > > >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
> > > >                       u32 *bank_num)
> > > > @@ -615,15 +617,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
> > > >                 elog->found = log.found;
> > > >         }
> > > >
> > > > +       if (elog->found)
> > > > +               return 0;
> > > > +
> > > >         /*
> > > > -        * Initialize the log buffer if no log was discovered and the buffer is
> > > > -        * valid. User's can pass in their own buffer as a fallback if no
> > > > -        * memory region is found.
> > > > +        * Initialize the log buffer if no log was discovered.
> > > > +        * User can pass in their own buffer as a fallback if no memory region
> > > > +        * is found, else malloc a buffer if it does not exist.
> > > >          */
> > > > -       if (!elog->found && elog->log_size)
> > > > -               rc = tcg2_log_init(dev, elog);
> > > > +       if (!elog->log_size) {
> > > > +               elog->log = malloc(CONFIG_TPM2_EVENT_LOG_SIZE);
> > > > +               if (!elog->log)
> > > > +                       return -ENOMEM;
> > > > +
> > > > +               memset(elog->log, 0, CONFIG_TPM2_EVENT_LOG_SIZE);
> > > > +               elog->log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
> >
> > Why are you doing this? There are 2 ways to pass an EventLog to the
> > kernel. Either via a config table from EFI, or using sml-base and
> > sml-size in a DT (which are both required). IOW you will create an
> > EventLog no one will discover
>
> My understanding is that it is still added to those tables (e.g. EFI). Linux does not see the bloblist structure.

No that's not what happens.
We either explicitly allocate memory from the EFI subsystem and use
that, or parse the DT and map whatever the DT tells us, If you want to
use malloc for allocating a non-EFI consumed EventLog you have to
inject these values to a DT otherwise the OS won't be able to find it.

>
> Regards,
> Simon
