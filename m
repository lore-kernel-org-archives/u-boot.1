Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4776C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 07:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F4B819B1;
	Tue, 28 Jan 2025 08:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tum45s7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DBB81BF4; Tue, 28 Jan 2025 08:11:12 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C016D81875
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 08:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so9050190276.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 23:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738048268; x=1738653068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H3VuyuE9Qb2QSamldQsJQAJSjZrkwvxTpk2boNYWMSM=;
 b=Tum45s7b9l7jh9qew9oHaICpivK4OWKi2YO67yaWa49R5p831iNz3GP9Om/0exzWWJ
 YCASzRlvZgbI7DJCTEdOr9pIOnmExBykhaUABNAJjoYfcGDdFP9Qw2BmGkfmQGQzG1yP
 3vbbiGF/p/ibxoadO23q0zzhGdsm3SiUFUKYd8q+2/xn3WBm4YhkThvQT6JRkXbX417X
 R8X+Zxf0dMjsLgRwvDPpK4+tFowREEhMy7xzuKehhMfdBPZvEGIXISTwZrVLUA4yymVH
 gpmkCKlblbPHM2LHlNotC496DHrxpf2Iqt94wN4AljGlM1aWRSfH15KZPZAGg+AmJSID
 aLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738048268; x=1738653068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H3VuyuE9Qb2QSamldQsJQAJSjZrkwvxTpk2boNYWMSM=;
 b=gZmzTIi6fizYyHhhiEev8cNwECbFZyxtjbn6uBZRgoGTnOEyaMSJ8a6fhbA7PYPsbS
 ecd5bCrSc4ay9bLPaE9qozNf4tZeImWuyTUwznI7TNEsgn37o/0q2F9pAFbKGbopOYV/
 O23ZccXlEz/vFUVO4irl4sBlsfQ5mOnaag2LgobRCIuO3oiXjbsR+7ssOTUtfPrF3NYO
 DC+XUEJ4UT04c6buPqxM6T2Cv6wQOaS0Xf3ukfNJMrPskWgpHVJEtFcoy7C5ggZKotb9
 yhLeklV+MNwztkXaa+/6rVYCW0bzX5sLpbSG5belbY0NDLVn6lq0ma/syZ2n5GD+Hlwu
 1+qw==
X-Gm-Message-State: AOJu0YwMzv4hpE9vOGnO6tdh9KgwA92rAb9hyvX38kY1GPxWCUb+MkgC
 GEkhBrWrkVttvYWl5O0Cw0+FIXeSrzSAae4e6CBuIcxGskc3edsqDsP9GsggeswkhVZchumvoA/
 PoXGn1rkDrgME2tG2Ech2ZPWK68T+aKxpsBV/Fw==
X-Gm-Gg: ASbGncsAufrsKlOG7KJPPyA5NgKf0MEn8j/A+6dB8oP69lSfAGviF5/WAceuEq5+KFA
 6HoXAxPqAXF4g/4g2fY7Q6ONwSNSnYyHLXCgQqqc6Bztb9NXRRpbz1K9ISuIdXOAAWR9n22BR
X-Google-Smtp-Source: AGHT+IF4yed3BlK3Xr4rVyVeC0k5aOWZfe6MWXjy7QA41nGq92casMno8nzXZXMeOR3t4Y2owSVe4uf7Qb6lihww/kM=
X-Received: by 2002:a05:6902:2707:b0:e58:1565:b542 with SMTP id
 3f1490d57ef6-e581565b80fmr18700494276.1.1738048268630; Mon, 27 Jan 2025
 23:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20250127144941.645544-1-raymond.mao@linaro.org>
 <20250127144941.645544-3-raymond.mao@linaro.org>
In-Reply-To: <20250127144941.645544-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Jan 2025 09:10:32 +0200
X-Gm-Features: AWEUYZnx4VIPVfkajykLCGf0Ep93jZ5x-FWFfxY2wSIzkAjIaqfUQPsPHUihaTc
Message-ID: <CAC_iWjKcP4zpLk9AOpUOx+cpgP7W9LYhmM_zAd7x2c043iXfdg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Eddie James <eajames@linux.ibm.com>,
 Tim Harvey <tharvey@gateworks.com>
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

On Mon, 27 Jan 2025 at 16:50, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> Changes in v7
> - Remove '#include <malloc.h>'.
> - Add mapping for the blob address.
>
>  lib/tpm_tcg2.c | 59 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 4134d93a35..adb32a14f0 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -19,6 +19,7 @@
>  #include <linux/unaligned/generic.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include "tpm-utils.h"
> +#include <bloblist.h>
>
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
>                       u32 *bank_num)
> @@ -672,21 +673,42 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
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
> +       if (*addr && *size) {
> +               *addr = map_physmem((uintptr_t)(*addr), *size, MAP_NOCACHE);
> +               return 0;
> +       }
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
> @@ -694,22 +716,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
