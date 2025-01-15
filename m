Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F03E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5809680735;
	Wed, 15 Jan 2025 02:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ny1veSZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A9880714; Wed, 15 Jan 2025 02:17:06 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821C5806EB
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so1003995366b.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903824; x=1737508624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h4e1PCp57iGXllR0euP5+QBOR8eqmhs9+DVh3cmxTXg=;
 b=ny1veSZQTZXMQYRKEFeKKTpeapFGc7xxQVfWpH1UNbOrRF3IesNqD3N+IXL7Kjxgkq
 Q0ydG3cLWOfUbvfwaKP09w/tPY/ycuU8wN/W4/YHyRaBbx7DTSidSFzimIc6w/zxDFJS
 253PpgKIyU81+B3nxT552zyD4UDmkel3PCcME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903824; x=1737508624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4e1PCp57iGXllR0euP5+QBOR8eqmhs9+DVh3cmxTXg=;
 b=eRX0+X/nfO20OxqmmIXdtzgbZPsdXyJn43csN+f+N1IDk1ctYKoOUhE6mxdqJ/xySy
 EGl+wlcs6m1IqQlwsARTT52cfAXjbCOIZA6XWghtbJvAa8nxtYEA/XLSrTyl3WZPDPNl
 TLHxo99clfJbqhWFYcPV59UnIlHq+B6YrXEQ/+WJok2YaPFSHsKocMH767Ug1wiUxiXT
 WaHM+9kSTA0lSvn1XWY05rKZ7sdAD20P0mzyC1kX5zYIkVmpI/v3XWW4qqebAJMmRkSA
 9hxGOl/YZ64omAu40erHIPuk67In9Nm/XI9kb57EQFKwoTsbG3RxVuszXodmoDvrml+C
 b/JA==
X-Gm-Message-State: AOJu0YyYPFpGwAV/9NAuFheF5oV1g5NSJcdieBmTio2LU/yCT/0jWoJZ
 Ry8fvxKjxxg25UZamtWmFoJUX4qjf1hJ7yug1mHIqv8Jq0gX1dixmWBpzzXk+8b0O/XVeuYbD4C
 udxpTAvofY1EAZIAYmyTLq8rtcL/xn5jfgC38
X-Gm-Gg: ASbGnctIZqnUXGfJqWaxJozm9bVUuChXVxnRw7s04TyK/wEL3tnPppYZSzZV6muI1ZR
 yp6PCm1Cvu/amyu5b8UaTceY9Gp6ZeBlqdiqyvE0=
X-Google-Smtp-Source: AGHT+IGPwCMxJD51oGfX0Mo4YSjRXWLcFMZi1WehSq+kj4cD2lr5YVOJ22LMFMO1nFQQa1ZNwME0ByBct4f5276xQsM=
X-Received: by 2002:a17:907:c03:b0:aae:8308:b9f9 with SMTP id
 a640c23a62f3a-ab2ab6c1ae0mr2409858666b.13.1736903823921; Tue, 14 Jan 2025
 17:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20250114152022.933662-1-raymond.mao@linaro.org>
 <20250114152022.933662-3-raymond.mao@linaro.org>
In-Reply-To: <20250114152022.933662-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:16:51 -0700
X-Gm-Features: AbW1kvYdAAhJBmaK0sJ2fTpdME6vCi9YPA0lu1Wk7drAXjKrX8JGbz1XVlTZ0EM
Message-ID: <CAFLszTh=d=Brcrd-4He0nDZgybjKOdAqqUxvh_z245xjF1giuw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Raymond,

On Tue, 14 Jan 2025 at 08:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> As a fallback, when no event log from previous stage is observed
> and no user buffer is passed, malloc a default buffer to initialize
> the event log.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove patch dependency.
> - Remove the fallback to FDT when BLOBLIST is selected.
> Changes in v3
> - Malloc an 8KB buffer when user eventlog buffer does not exist.
> Changes in v4
> - Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
> Changes in v5
> - Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
> - Add an inline TODO comment.
>
>  lib/tpm_tcg2.c | 61 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 19 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit in case you respin again: -ENODEV is for driver model, when there
is no device. It is actually handling specially by driver model. So
-ENOENT is what I try to use for things that don't exist but aren't
devices.

>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 4134d93a35..2d9076f091 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -5,6 +5,7 @@
>
>  #include <dm.h>
>  #include <dm/of_access.h>
> +#include <malloc.h>
>  #include <tpm_api.h>
>  #include <tpm-common.h>
>  #include <tpm-v2.h>
> @@ -19,6 +20,7 @@
>  #include <linux/unaligned/generic.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include "tpm-utils.h"
> +#include <bloblist.h>
>
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
>                       u32 *bank_num)
> @@ -615,15 +617,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
>                 elog->found = log.found;
>         }
>
> +       if (elog->found)
> +               return 0;
> +
>         /*
> -        * Initialize the log buffer if no log was discovered and the buffer is
> -        * valid. User's can pass in their own buffer as a fallback if no
> -        * memory region is found.
> +        * Initialize the log buffer if no log was discovered.
> +        * User can pass in their own buffer as a fallback if no memory region
> +        * is found, else malloc a buffer if it does not exist.
>          */
> -       if (!elog->found && elog->log_size)
> -               rc = tcg2_log_init(dev, elog);
> +       if (!elog->log_size) {
> +               elog->log = malloc(CONFIG_TPM2_EVENT_LOG_SIZE);
> +               if (!elog->log)
> +                       return -ENOMEM;
> +
> +               memset(elog->log, 0, CONFIG_TPM2_EVENT_LOG_SIZE);
> +               elog->log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
> +       }
>
> -       return rc;
> +       return tcg2_log_init(dev, elog);
>  }
>
>  int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
> @@ -676,10 +687,25 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>         const __be32 *size_prop;
>         int asize;
>         int ssize;
> +       struct ofnode_phandle_args args;
> +       phys_addr_t a;
> +       fdt_size_t s;
>
>         *addr = NULL;
>         *size = 0;
>
> +       *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> +       if (*addr && *size)
> +               return 0;
> +       /*
> +        * TODO:
> +        * replace BLOBLIST with a new kconfig for handoff all components
> +        * (fdt, tpm event log, etc...) from previous boot stage via bloblist
> +        * mandatorily following Firmware Handoff spec.
> +        */
> +       else if (CONFIG_IS_ENABLED(BLOBLIST))
> +               return -ENODEV;
> +
>         addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>         if (!addr_prop)
>                 addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> @@ -694,22 +720,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>
>                 *addr = map_physmem(a, s, MAP_NOCACHE);
>                 *size = (u32)s;
> -       } else {
> -               struct ofnode_phandle_args args;
> -               phys_addr_t a;
> -               fdt_size_t s;
>
> -               if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
> -                                              0, &args))
> -                       return -ENODEV;
> +               return 0;
> +       }
>
> -               a = ofnode_get_addr_size(args.node, "reg", &s);
> -               if (a == FDT_ADDR_T_NONE)
> -                       return -ENOMEM;
> +       if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args))
> +               return -ENODEV;
>
> -               *addr = map_physmem(a, s, MAP_NOCACHE);
> -               *size = (u32)s;
> -       }
> +       a = ofnode_get_addr_size(args.node, "reg", &s);
> +       if (a == FDT_ADDR_T_NONE)
> +               return -ENOMEM;
> +
> +       *addr = map_physmem(a, s, MAP_NOCACHE);
> +       *size = (u32)s;
>
>         return 0;
>  }
> --
> 2.25.1
>

Regards,
SImon
