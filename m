Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9935E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEDFB805EA;
	Fri, 10 Jan 2025 14:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SKOZ95jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47F2800D0; Fri, 10 Jan 2025 14:32:45 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D608036B
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so3405404276.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515962; x=1737120762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8F1Bz7F0wp0DJU319nfGySG4eyzADKE30OKMsTTCacg=;
 b=SKOZ95jUXUM7Lu1f/3W7o/JpOp5qOR2Yx/1h9uzKoPTcBPgIDuZ1WQaHB0hri7awK9
 jzxD3U1kE0m/kIO/AQ/xpqG8xJJxQX+jWGDB0OUY3bmKz/nXl0RowCqTlwycRkbeJrpv
 bG1YlDr53w6gyrrpUYC4uRccE8fr3SBzbHNrKnjVdmkKkpF7M44fpxDlaUFE4EiaGVtB
 7HnhQdMMEr8mR2/NwF+/7IQlSplOLk4LU/i0c7Mhp0Y17FePKayGgSOJVLhw0CwLqs7N
 kpHBgMzNbIlLl5OL2XThrs67O0dS7h7lAWZrI0xKaWbVtAD7lz0ma9sYDIGMeXvZM/I7
 bX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515962; x=1737120762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8F1Bz7F0wp0DJU319nfGySG4eyzADKE30OKMsTTCacg=;
 b=qgEY0OBtXRwIqzJ1CweUkmXFcHuU8minNuXAKrLd3z/8RTAKufNity6N6v4HQNilZe
 CgedkvXwWQtHkI+Yfr5GfrNnPkNGNUTjydDlmi4zF89HRAI9q7daGDadDKxjzELRlb7/
 pzMhHyXyXB2Mwp916OBCeEWINXTkpzaXOR1xm8Cwxuf4WqwrLSGv6y14gI+8vjjE29wd
 Eco/uw+L5oN4tHGmdmggIS92EEh3zBU2kAkhoC+xe2hCuj2ZOL5N71oSFfg4P533Cf8p
 yr7OqDl0amMrrCBSF6zd5hEMaCW/3OWdmc4OMN3yntjpWR5Ji6AKa1+SJaih0vRcpN2P
 YaGw==
X-Gm-Message-State: AOJu0YyvRRHNcvnOM9fKIohn6zj0VC9WLWYjeNw3wC09gVVawUsgzJBu
 8ruuv54Jeiw/wIamYgG1LpSWCPjrl8JNCNSJanXkcD5KT3MVhsj7kz0nSqJz3/MGXEfqbTnMOW0
 Y1ciXCi7rG7lz5I1mcZXRFaPUKRTZnF6nFl+bEw==
X-Gm-Gg: ASbGncu1LWtoiMg3FJLyRQ6tjinC2eGDVPH0zuuPsgUG/9k+I8dibKWMWVIsSbtz0N5
 VQUlCzbwCisen5SF6Hjo8EBIuiq0w0wTx47ZFXA==
X-Google-Smtp-Source: AGHT+IHaTo7RSSZ7pJvOVglxPATyaZr7dR015oNVLbzyqCCLJ6LCwdwxopcQmkBJHfRRM8igvvN5UA3hyNd0iLL0+/E=
X-Received: by 2002:a05:690c:6005:b0:6ef:7f89:d906 with SMTP id
 00721157ae682-6f5312d3afemr82707857b3.33.1736515962158; Fri, 10 Jan 2025
 05:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20250109150928.878849-1-raymond.mao@linaro.org>
 <20250109150928.878849-2-raymond.mao@linaro.org>
In-Reply-To: <20250109150928.878849-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jan 2025 15:32:06 +0200
X-Gm-Features: AbW1kvYeqG4tLltF7LDBfpDzwI7ipcH6wBK6dH_tYQUQoD_Mcmgoptq5a7B6Whc
Message-ID: <CAC_iWjLLMiu_B=A3g-r6d9MiQpwRnyghSFVCJ5GNQGmMHb4DuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
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

On Thu, 9 Jan 2025 at 17:09, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> As a fallback, when no event log from previous stage is observed
> and no user buffer is passed, malloc an 8KB buffer to initialize
> the event log.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove patch dependency.
> - Remove the fallback to FDT when BLOBLIST is selected.
> Changes in v3
> - Malloc an 8KB buffer when user eventlog buffer does not exist.
>
>  include/tpm_tcg2.h |  2 ++
>  lib/tpm_tcg2.c     | 55 ++++++++++++++++++++++++++++++----------------
>  2 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> index 6519004cc4..6ea316888b 100644
> --- a/include/tpm_tcg2.h
> +++ b/include/tpm_tcg2.h
> @@ -65,6 +65,8 @@
>  #define EFI_DTB_EVENT_STRING \
>         "DTB DATA"
>
> +#define EVENT_LOG_DEF_BUF_SIZE 0x2000

That's too small for an eventlog. We have a confog option for the TCG
eventlog size (EFI_TCG2_PROTOCOL_EVENTLOG_SIZE). I'd prefer decoupling
this from EFI only and using that instead.

Cheers
/Ilias
> +
>  /**
>   *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
>   *
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 7f868cc883..d880b14888 100644
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
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>                       u32 *pcr_banks)
> @@ -607,15 +609,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
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
> +               elog->log = malloc(EVENT_LOG_DEF_BUF_SIZE);
> +               if (!elog->log)
> +                       return -ENOMEM;
> +
> +               memset(elog->log, 0, EVENT_LOG_DEF_BUF_SIZE);
> +               elog->log_size = EVENT_LOG_DEF_BUF_SIZE;
> +       }
>
> -       return rc;
> +       return tcg2_log_init(dev, elog);
>  }
>
>  int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
> @@ -668,10 +679,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
> +       else if (CONFIG_IS_ENABLED(BLOBLIST))
> +               return -ENODEV;
> +
>         addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>         if (!addr_prop)
>                 addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> @@ -686,22 +706,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
