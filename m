Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D543BE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5155D805E9;
	Tue,  7 Jan 2025 16:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hpXsog9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9A1805F5; Tue,  7 Jan 2025 16:30:34 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3485080608
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216426b0865so225804505ad.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263828; x=1736868628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q1R7UR81+U8u+QrN6JWxZq1+Wr1YFfBafViaoKR/k+k=;
 b=hpXsog9Ndwzb2AgH6pZY48gSiwRtF8Cjbdjx3+Uz6RxJlvQ0dz9LUmFzt99MNCWnEl
 Ygggbjzp5Oxx4fieTVV77Rj+lrx0HTkNA8RQwkngHC7+vNkJEIZMinevIkoqXcnj5w+X
 Z3K6coO3GLeoCRugNodqCcJ+wAEZGoh3sYxVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263828; x=1736868628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1R7UR81+U8u+QrN6JWxZq1+Wr1YFfBafViaoKR/k+k=;
 b=BSyQOi6kdl1HRGQ8Sofh+JQ6Qc+NC7qbZlo+weayBqG443LmZdjR1sa62aBI6dsbXR
 SuebcV6h7JBf16F0henAs00Av6skopaRbNjHP6whZTiFNXU0WQAMMvLR4HjQyAec58RV
 GBH3DvmX8ksrwkoaLfZS1rG2gyMjiNnANLsmBITZO4NrIPUgocw4Byoh/Ny4RCjGCTlw
 eSW7GQI9NlPUmBlRj5H73FWxrtYYMt4dWjhT9acK6mEcqmLjMkAH4uk8U2FPGpQ0SbL6
 RY6wSaSSnXnSMVVQl10Pli685PoXZXW2dY0qM5hzu4KgOKWnCD1WbiBzYp7dz60Pc1if
 u0qQ==
X-Gm-Message-State: AOJu0Yy3h4QdDs2s/uu0eKyJI84Jr/qBvtSG5/jdUc6hEANRsRLOv9gc
 dp03FNUB/6yojR4dJMzatib0Znfgi+EeFhE8qDXZLsc/rRL8/jtlv60r2Lp6XlnuAsWRDi6ybBS
 G+FFk6KOiT5cjNSGl5Oqx273/766QiwYhvu+lpzNsWz+2Fik=
X-Gm-Gg: ASbGncvp7pDLLJBW1KeLATPE67w4eqdkm6BHnahNtDXoPhOBVPHlDf4Xp8S9HG/7Puo
 ZcFhf0xX2khntNiZW4jMGLy4z6t/iv30pjuEQL6M=
X-Google-Smtp-Source: AGHT+IEh/9AZU4vp7uuXy7KkhbTEt7l1ZStr2msndcxCEu5OShBTK0BRCALLd1TQzZHo+LuUkt/uv/0lGxXyqCqPeqQ=
X-Received: by 2002:a05:6a20:2443:b0:1e1:ace6:c98 with SMTP id
 adf61e73a8af0-1e5e081cb7dmr101611882637.43.1736263827550; Tue, 07 Jan 2025
 07:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20250107150258.813289-1-raymond.mao@linaro.org>
 <20250107150258.813289-2-raymond.mao@linaro.org>
In-Reply-To: <20250107150258.813289-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:07 -0700
X-Gm-Features: AbW1kvbmB-Ay_ByUMy7q-lBP39qJWRufhHzjaC4MDupC46m80ZQj0b5V1fuzTRQ
Message-ID: <CAFLszTj7Jf24kP9-XHYATdOzWMD06jV+nVaFXm1u+6KwqV8bgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
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

Hi Raymond,

On Tue, 7 Jan 2025 at 08:03, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove patch dependency.
> - Remove the fallback to FDT when BLOBLIST is selected.
>
>  lib/tpm_tcg2.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

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

Unrelated to this patch, we should use ulong for addresses (at least
those which refer to a real memory address that U-Boot can access). If
you want a pointer, it should be named 'ptr' (or ptrp in this case).
Size should normally be ulong.

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

Regards,
Simon
