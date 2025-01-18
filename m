Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1D1C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB3780657;
	Sat, 18 Jan 2025 05:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mIGmFyJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7A28070C; Sat, 18 Jan 2025 05:31:27 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DDD68036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso514564366b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174685; x=1737779485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9gYlIK4tinMcZes27KDcKrEFP88YH216Cy7A8UWNmc=;
 b=mIGmFyJ5MkdXZxR5hVl7B86UqRxFa6odT7uFgb1YwL/DIEnm3PprmN5uCfvyAtLvvl
 JYq37hYGASArhTTANeQkNmHgiM5ts6rx9ymMCIVyI9ewoLHurIlH3beMphtIW3hYhWU0
 piRNYAMTEAAP+XHtYdWfkiXAZMTwzgV8rFBa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174685; x=1737779485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9gYlIK4tinMcZes27KDcKrEFP88YH216Cy7A8UWNmc=;
 b=AsyUP2V0SQ1Zr7SbKtFYzCgHPWuX95K/UoIbiWItZB1gAwqO5iPDuFt6egRUX8681j
 pD9EwuZH4sAUR4TNnnV0+3Kc0Lc+fWM2bX6/DF/goJNo19KIhfFYd5pEVRO7+2vf+Bfh
 7FhCjb8TH6egGoZlGsiEtkL0VRJjMo/LwAQgSLQkjoXUGIi1Ssf3vgEIZ9lQr8zcWsRc
 n3ur+03bL98wQNk1pjY/vFnjJTlI5g4RAc007JxjHC+WWgJ25qkPOXFyTZNP3jTeqegw
 f0XmcDnBujs6LNG5oRdzBph3MICl3WjW+X/bf+DHHsQHx1IQEW7LVelrHlcD+OmV34JH
 ZGTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIVYlF7cIOwW0Dfa71QFo3tLuyN6kKVVwklRaOVIpQMGSFoFfecyDjrVFaNzE6ByO7/6hOL9w=@lists.denx.de
X-Gm-Message-State: AOJu0YxrvJg5mQ+VjM4ur61XNYyK8d9I7uDkmWFlG1NEuWHywxUeOJzW
 Ki8J5X99eQo9ZOlK8erXU2+FNiM+ntDOYa2IdjnK1Po5RJBHAiGb6DTkwJTBDPVZpfoUHngGBnm
 DQMn/bXH90FsGWtU3K3/77G6xh84pxgy20cRG
X-Gm-Gg: ASbGncsEx7LLssaxK3kktd29E8k07eidYC3C9FRnQ2+dbTNO+qpN3LUXObDY5xFADB8
 RMz4FfUjTgpHyFoXScpDxT7WxCPGWpB3m3uDt3RMyeoGWnq7zn5dpG8jHKAgdV7LJFSlC8QPqAe
 8rWlWBS/UZ
X-Google-Smtp-Source: AGHT+IFqD0zLlLSfUAgo1onPnxx94jycgn2haO4bcuKYiPSbjoRcKT2ZSJVOdak/KNfg6AGOzEZkUwU3s0ifiN5RMmE=
X-Received: by 2002:a17:906:7314:b0:aa6:6a52:970 with SMTP id
 a640c23a62f3a-ab38b0ba253mr488914966b.1.1737174684760; Fri, 17 Jan 2025
 20:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20250114152022.933662-1-raymond.mao@linaro.org>
 <20250114152022.933662-3-raymond.mao@linaro.org>
 <CAFLszTh=d=Brcrd-4He0nDZgybjKOdAqqUxvh_z245xjF1giuw@mail.gmail.com>
 <CAC_iWjL7y6QyjQtRp6qd_5QxF6aUw+qrhY6snXZ2B-Qiz7Dy1g@mail.gmail.com>
In-Reply-To: <CAC_iWjL7y6QyjQtRp6qd_5QxF6aUw+qrhY6snXZ2B-Qiz7Dy1g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:31:12 -0800
X-Gm-Features: AbW1kvbPdHB6DUUeuGlbc7ABbtlmg7WRV62uE9JFf_Svn8y6xd-UW8wznJo9udo
Message-ID: <CAFLszTiE05TAFQfcGANsCve-UhRV8gh6ZUB-nLZeLQpAr+0sRQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tpm: get tpm event log from bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Thu, 16 Jan 2025 at 07:35, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:
>
> On Wed, 15 Jan 2025 at 03:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Tue, 14 Jan 2025 at 08:20, Raymond Mao <raymond.mao@linaro.org>
wrote:
> > >
> > > Get tpm event log from bloblist instead of FDT when bloblist is
> > > enabled and valid from previous boot stage.
> > >
> > > As a fallback, when no event log from previous stage is observed
> > > and no user buffer is passed, malloc a default buffer to initialize
> > > the event log.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > > Changes in v2
> > > - Remove patch dependency.
> > > - Remove the fallback to FDT when BLOBLIST is selected.
> > > Changes in v3
> > > - Malloc an 8KB buffer when user eventlog buffer does not exist.
> > > Changes in v4
> > > - Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
> > > Changes in v5
> > > - Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
> > > - Add an inline TODO comment.
> > >
> > >  lib/tpm_tcg2.c | 61
++++++++++++++++++++++++++++++++++----------------
> > >  1 file changed, 42 insertions(+), 19 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > nit in case you respin again: -ENODEV is for driver model, when there
> > is no device. It is actually handling specially by driver model. So
> > -ENOENT is what I try to use for things that don't exist but aren't
> > devices.
> >
>
> +1,
>
>
> > >
> > > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > index 4134d93a35..2d9076f091 100644
> > > --- a/lib/tpm_tcg2.c
> > > +++ b/lib/tpm_tcg2.c
> > > @@ -5,6 +5,7 @@
> > >
> > >  #include <dm.h>
> > >  #include <dm/of_access.h>
> > > +#include <malloc.h>
> > >  #include <tpm_api.h>
> > >  #include <tpm-common.h>
> > >  #include <tpm-v2.h>
> > > @@ -19,6 +20,7 @@
> > >  #include <linux/unaligned/generic.h>
> > >  #include <linux/unaligned/le_byteshift.h>
> > >  #include "tpm-utils.h"
> > > +#include <bloblist.h>
> > >
> > >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32
*active_bank,
> > >                       u32 *bank_num)
> > > @@ -615,15 +617,24 @@ int tcg2_log_prepare_buffer(struct udevice
*dev, struct tcg2_event_log *elog,
> > >                 elog->found = log.found;
> > >         }
> > >
> > > +       if (elog->found)
> > > +               return 0;
> > > +
> > >         /*
> > > -        * Initialize the log buffer if no log was discovered and the
buffer is
> > > -        * valid. User's can pass in their own buffer as a fallback
if no
> > > -        * memory region is found.
> > > +        * Initialize the log buffer if no log was discovered.
> > > +        * User can pass in their own buffer as a fallback if no
memory region
> > > +        * is found, else malloc a buffer if it does not exist.
> > >          */
> > > -       if (!elog->found && elog->log_size)
> > > -               rc = tcg2_log_init(dev, elog);
> > > +       if (!elog->log_size) {
> > > +               elog->log = malloc(CONFIG_TPM2_EVENT_LOG_SIZE);
> > > +               if (!elog->log)
> > > +                       return -ENOMEM;
> > > +
> > > +               memset(elog->log, 0, CONFIG_TPM2_EVENT_LOG_SIZE);
> > > +               elog->log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
>
> Why are you doing this? There are 2 ways to pass an EventLog to the
> kernel. Either via a config table from EFI, or using sml-base and
> sml-size in a DT (which are both required). IOW you will create an
> EventLog no one will discover

My understanding is that it is still added to those tables (e.g. EFI).
Linux does not see the bloblist structure.

Regards,
Simon
