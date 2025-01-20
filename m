Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0654C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836028032B;
	Mon, 20 Jan 2025 20:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SWGtIoNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E1080716; Mon, 20 Jan 2025 20:21:36 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4EB801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fdafso9705438a12.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737400893; x=1738005693; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxPXzK/74zWQi88EZQ48KpIY3Fxfbnm+RRFkssgW9i4=;
 b=SWGtIoNwoHZtlEb07rPH0iiIvmTXwx8J/1BM3+ywFGvBIfJp2UKIb4qGNMl1oofHFj
 N/ffVGs4yhe4YztavxjkJZMYzQAcWo3eHJZlDuJnR4tVKfILYvHnMzuH0Se7k3jvf27j
 JDfEd/S58YTTG2H+n2NW32K6XlnDk8HB0fGD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737400893; x=1738005693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MxPXzK/74zWQi88EZQ48KpIY3Fxfbnm+RRFkssgW9i4=;
 b=xB96q42eAHPsYls7Rc/An0ZYvNI8mJT1wIrdNBQwjKSlwU9icBjtFgBdi0y8GNSuA+
 JM6L/DXa6rId3ii9MRkdv/DFd/ahJdCTCcMCmIdyKElN59CyvIoCC1QqFsqWokM6zZmI
 GTN75USUtogeXnXX7AVU5CDRmVEggJctJikhQFRp9lzTJho54/OU9Zgoes89CghoIEDp
 1khI9umdgOdXIWAzTUIMveChQM53RmBQpwyEpmoNptqL5exZvIpmMvgaA6Op604bGQ2q
 dXN7dWe2fIw9r74a3yu1zm9udnZQC/I6YjmCEiADJaBl23RhAjT0iKgMY7NLRPk3SKvh
 FgCA==
X-Gm-Message-State: AOJu0YwnlRoWOLxGjq0YPzlbznF5bNan1zWVWqLSt0Rfr3iueLaGtWcB
 xNyS9++GBym+gFDS3tXdwo4lzezIASv+GqPHq3hh2V2NqE6tAb9lRkl3DsjRicpgyscEQ/Mz/jI
 NnKVShCF/+RHLon6C60h0wfwf7t7zvYSJ9kPk
X-Gm-Gg: ASbGncvF4junGqXcOoXLOOr+l3ynYtfrqLwzQTvr6b2r2IcfSU9ckSu9dT/frs2mUe8
 7ZVdDMi7pQvcs8J9T1ahVo5bWHfhpKHi9POVIN6V74xRkUsYSI/nJ
X-Google-Smtp-Source: AGHT+IGlQ/JyGinueY6MgC0UL0gzdEKnnVWvn4kKm0QgbWmXanS0bywWwjXnyTkLpuenzg1E8yyVhtctXSL6z1u8ZOA=
X-Received: by 2002:a17:907:7296:b0:ab3:4c32:aa6c with SMTP id
 a640c23a62f3a-ab38b10cfa4mr1407363566b.20.1737400893378; Mon, 20 Jan 2025
 11:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20250117163545.88627-1-raymond.mao@linaro.org>
 <20250117163545.88627-3-raymond.mao@linaro.org>
In-Reply-To: <20250117163545.88627-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Jan 2025 12:21:21 -0700
X-Gm-Features: AbW1kvZ8N9XBKqcI0qjIcKGY52fkInVklg_Kfp_NYNTMbDvNyzqLHPSaNapmK6w
Message-ID: <CAFLszThLo5y6eaqcyX6twbmyYU0sfXpO8RkG2hLE=amgs=T6Bg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>, 
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

On Fri, 17 Jan 2025 at 09:36, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
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
> Changes in v6
> - Remove the malloc and keep the buffer pointed by "sml" for the fallback
>   as it is the right place for linux to discover the eventlog.
>
>  lib/tpm_tcg2.c | 58 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with nit below

>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 4134d93a35..6425bf143a 100644
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
> @@ -672,21 +674,40 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
>
>  __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>  {
> -       const __be32 *addr_prop;
> -       const __be32 *size_prop;
> +       const __be32 *addr_prop = NULL;
> +       const __be32 *size_prop = NULL;
>         int asize;
>         int ssize;
> +       struct ofnode_phandle_args args;
> +       phys_addr_t a;
> +       fdt_size_t s;
>
>         *addr = NULL;
>         *size = 0;
>
> -       addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
> -       if (!addr_prop)
> -               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> +       *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> +       if (*addr && *size)
> +               return 0;
>
> -       size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
> -       if (!size_prop)
> +       /*
> +        * TODO:
> +        * Replace BLOBLIST with a new kconfig for handoff all components
> +        * (fdt, tpm event log, etc...) from previous boot stage via bloblist
> +        * mandatorily following Firmware Handoff spec.

Just to mention, this patch is fine with me, but I don't agree with
having a new Kconfig for this. That would need a separate discussion.

> +        */
> +       if (!CONFIG_IS_ENABLED(BLOBLIST)) {
> +               addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
> +               size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
> +       }
> +
> +       /*
> +        * If no eventlog was observed, a sml buffer is required for the kernel
> +        * to discover the eventlog.
> +        */
> +       if (!addr_prop || !size_prop) {
> +               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
>                 size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
> +       }
>
>         if (addr_prop && size_prop) {
>                 u64 a = of_read_number(addr_prop, asize / sizeof(__be32));
> @@ -694,22 +715,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
> +
> +       if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args))
> +               return -ENODEV;
>
> -               a = ofnode_get_addr_size(args.node, "reg", &s);
> -               if (a == FDT_ADDR_T_NONE)
> -                       return -ENOMEM;
> +       a = ofnode_get_addr_size(args.node, "reg", &s);
> +       if (a == FDT_ADDR_T_NONE)
> +               return -ENOMEM;
>
> -               *addr = map_physmem(a, s, MAP_NOCACHE);
> -               *size = (u32)s;
> -       }
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
