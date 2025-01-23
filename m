Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA83EC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 07:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF54F801B0;
	Thu, 23 Jan 2025 08:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yPopKld8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC27980214; Thu, 23 Jan 2025 08:00:59 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BE780137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 08:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so933630276.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737615656; x=1738220456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dgFCDGK7bpjis+8rEGIwkzUX5vO0Me2pB4HRgUBFR8=;
 b=yPopKld8baGWtE7udmgFJ6Kp2iQz/SxlfLDOw1Cg3PaqNd8OpsJeLyI6yhQiOnZcip
 UMwyAt++4HaksRUJMxDcW3hJ7ZM0uYK3FI5/tgSyfZeof5UuXbGGla9D4kC+waBfwh0w
 eMrUtalYlaQbRF49/z3WQ7m5KWiA31vdMQBelVMxilmck+/M3NL7PQmOGu6D7oNopxfo
 dj8adAl7mY485XNPxLCNL9o2spdsshcmsAF9XKeUTgcgww9BIGsFmn7/Vd0gQoJ0Q4Qr
 ypf/rhY8H0rlVjtZTYzT/SMPb2xaQcr3r+EjOxUoEwxIi1fkVEs4irUonqsc+SzMeD9E
 ldtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737615656; x=1738220456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dgFCDGK7bpjis+8rEGIwkzUX5vO0Me2pB4HRgUBFR8=;
 b=l8Qv/bQPd4vvmCSdBgkZG7scYrTiwF6Y16ZYp2zECCDMqyYwCCE8o3bwbgsu+NVlpR
 mSz7Cd9vpu5S9jlBGdiMlunV9FMUZESRYY/NFsPGSljUIQ2/uF9bmCwQaBs3L+iyugGS
 G0lhMde0m1IEqGP3LMxOiBPoKCwzJbVmJGxjMkiurDX7yn26aQaPJ/cqykfeTmdAj/7J
 AAQslgnwz3dvDwUk9UN40wAqWWzZcf7LvF6+S97JR9fFrxY9mc2k/JZu/KgG1Q19Car9
 uy2IO+9zPTMgK6NwptjML9BVFVBN0W1tCv2nCW8CrRKptPqq2J8c8dasv735If0A5O6D
 OVdw==
X-Gm-Message-State: AOJu0Yz6A9NXm3qBSCzpDFHEnkjWeQvN26A9Idol0OS9PGXeLz4plTBQ
 1Nbf72dkIzH5fGGH4oGeFtZUBHqpPVhgkHrbtuDeOej+cp11oPKrSajtwkhvUKXHnyo+mx6pQDk
 9pTm67uGJJ2rjfjdco9GKEQn5xcJe922Rukip0g==
X-Gm-Gg: ASbGncsMNkS1AJ0xCmyNw8GzZeOp21p7fK9dbaU8gOqNuyhjv1wgasS/EmSAPLZdPBH
 CINEwavOjbc3dZ4HC6pnSc22gSF8OxCgAL1xMxIeN2io2X+TPl1p2UUj2XEy8BA==
X-Google-Smtp-Source: AGHT+IFz6OF321KgRDEpbg1+K8+XtfJk5Q4ipvvWRpHqcrPMsAf2RUnpSCNVxyNUgFduq8RTmdrC/RGQ2Kw19AO9axo=
X-Received: by 2002:a25:5889:0:b0:e57:d438:be50 with SMTP id
 3f1490d57ef6-e57d438bf30mr10298168276.2.1737615656135; Wed, 22 Jan 2025
 23:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20250117163545.88627-1-raymond.mao@linaro.org>
 <20250117163545.88627-3-raymond.mao@linaro.org>
In-Reply-To: <20250117163545.88627-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jan 2025 09:00:19 +0200
X-Gm-Features: AbW1kvas3iwZcX4jTOnqxI7YLJaC4bxQPhmSpq40ZYJc-EOtjUVp7j0RaPWoXbI
Message-ID: <CAC_iWjJ0JO8sB4Q5Gc_5LBByaVmiz6D0sgWjFggqCd9xEX2RLg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond

On Fri, 17 Jan 2025 at 18:36, Raymond Mao <raymond.mao@linaro.org> wrote:
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

This is probably a leftover from your V2

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

Don't we need map_physmem here as well?

Thanks
/Ilias
> +               return 0;
>
> -       size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
> -       if (!size_prop)
> +       /*
> +        * TODO:
> +        * Replace BLOBLIST with a new kconfig for handoff all components
> +        * (fdt, tpm event log, etc...) from previous boot stage via bloblist
> +        * mandatorily following Firmware Handoff spec.
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
