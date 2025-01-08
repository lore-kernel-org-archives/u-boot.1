Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337ADE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 07:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2228801E8;
	Wed,  8 Jan 2025 08:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pJBGwfMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E413C803DC; Wed,  8 Jan 2025 08:17:46 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A41838005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 08:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e3a0acba5feso19013927276.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 23:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736320663; x=1736925463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCBu0XTYGABAQDEphcbWXOfXQpDdSLRwlxveP3Yi0XQ=;
 b=pJBGwfMnh4YVd5KPi9vIPxvBNhHOqJ3/Z9Lin1inbUAdxFX1ZqSFdk5ffDqKPWB6XX
 2V/kt8c/Fh1y7xQWMkchnA+23BVhXYSVacU0f92qQ6ykbu1K44kmBiEzWfYN2ses3m1X
 PrOMhhc6JjTFgzimgcQLwalzP9JVfmbz8AJex6ItTThFLpeGtpoqvh14qoMdMX8M4jqc
 GV38IJM/A+kG4EykpS3kN7YcW1LdLIRFNS950aGNVl5G4c/1N7tZcNBKxZzSnvV631m0
 7g9XmLF7euq+PKSgOQb/xFj//yk4ObOPmOzjqH8r6aDI1MfPlLvno48tQLICuW5fPBfL
 psAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736320663; x=1736925463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCBu0XTYGABAQDEphcbWXOfXQpDdSLRwlxveP3Yi0XQ=;
 b=V0aU1NbrjUtkgVpmurOAl33Sn6a8ZrJeGwhhCV7n1HQfK6hmi87LlCqgjfMfZ9GQJW
 xslk/NfRo9k2RT+3oSC+0RClG4FQzewE73Wp0tabuvr/xGKE7i1JgjfDPkcaiocdjMml
 l3vIrahOrtTczYwOlC4nKs5UfY2Hcz3V2k+q/TKiMDpcZn0JcsqP9VlwV7XEtH0vq33J
 5bsDrqTBQmUpujjmZ4s8itDOl7dmxtuZI6s8TnYxMfenzr4tml/NPAz+SYUiHd78RJnP
 fy+btuHM2rAl6zD1QNdbCZJ4yhIHXxPLMucBFICP+lV7LsyLefkl/z+Xr1VR84laYuZ2
 LC8Q==
X-Gm-Message-State: AOJu0Yx+m1sHuDClKfO903kTZBqoW99xbFYXEpF3rn+2iJvJ+XEnfBU0
 V/fXFSb6rSB5LgD8SaAX8AnQcn/80JHNNnClFPq8xf4jWQOR4pqKzCmz6QHY9RPiDdtWiL3VWCV
 dMGQRqQzb1fWA7Lyne/tL/yIvpjNK67OPSzAYLOu8ombVkv5eKE4=
X-Gm-Gg: ASbGncsicyUS+tnqEjRgx4Dn/9vlQOZqZCZqUXxqCY3Nhax4y/nlvxcQ7JhLPGFuWuo
 rKG90JONgdXMhgHZ5vLDSXbhWZxeF4N6URQCMpA==
X-Google-Smtp-Source: AGHT+IEZIKFXLvndU2zwo6BE+qod5rf1qlsNIiD/n3NEfY7ODOA7IWskZBFlM2vtBWAQv3xdPI3vlTzduyCU7mpS85I=
X-Received: by 2002:a05:6902:158b:b0:e35:d8b1:571e with SMTP id
 3f1490d57ef6-e54edf22c51mr1247590276.10.1736320663521; Tue, 07 Jan 2025
 23:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20250107150258.813289-1-raymond.mao@linaro.org>
 <20250107150258.813289-2-raymond.mao@linaro.org>
In-Reply-To: <20250107150258.813289-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Jan 2025 09:17:07 +0200
X-Gm-Features: AbW1kvbm1r0ec5tI58VEuiGdOga3fV6XL7GO48rDdiKtPNhQ6ziBl-gAQTsP1lo
Message-ID: <CAC_iWj+G1orV2T6kOTbkkTXLR-CNyg-yNn2GTT5MF7qJ1Yw+Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
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

On Tue, 7 Jan 2025 at 17:03, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove patch dependency.
> - Remove the fallback to FDT when BLOBLIST is selected.

There is still a fallback to the FDT if bloblist is enabled.
There are two cases where we search the DT for an EventLog
- tpm_event_log_addr which is an internal TF-A ABI and we should
completely remove in the future
- memory-region within the device node. This one is still an active
fallback. Do we want to remove that as well?

Cheers
/Ilias

>
>  lib/tpm_tcg2.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 7f868cc883..84845fc026 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -19,6 +19,7 @@
>  #include <linux/unaligned/generic.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include "tpm-utils.h"
> +#include <bloblist.h>
>
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>                       u32 *pcr_banks)
> @@ -668,10 +669,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
> +               goto map_log_mem;
> +
>         addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>         if (!addr_prop)
>                 addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> @@ -686,22 +696,20 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
> +map_log_mem:
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
