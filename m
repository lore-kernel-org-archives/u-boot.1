Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157E6C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 06:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F1C875F1;
	Thu, 23 Nov 2023 07:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DWegiALg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A322875F5; Thu, 23 Nov 2023 07:18:36 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BCE87443
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 07:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so6053161fa.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 22:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700720313; x=1701325113; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Og5iusS1fsXnkhinHPxYVMljuipVk46rFiWQs20MHiY=;
 b=DWegiALgrjnt8yZzBgDQds4f9Ss+DywFivJHiraSlN4gDiBgqoMUzZnweq53VfMbr9
 AeIivLVlvSoV2Wvpo3VO8QgglCYzHiExjC71eziEvswdHy++FEXrS8oqJ7Uplh06wLpu
 WzRGxgpn5kkpJAZytvJqEJsI+Xi1okUYRtD9QuxbkdAqIH5WCaYRRvw6lobw1DhUabg+
 +6xbzdw/MDuvq2Mxs9Fnhy0gYqyjfQIsRsye0ZuJkCxpy+KdGukdOPnmh90X2a7lzNUU
 wg7HBl8jjnYe3B2yGfB/E/F6C5ji2RYazTTHY0o1T9Mw4Vej+CPTdG+lL8+l/+uaBVze
 rbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700720313; x=1701325113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Og5iusS1fsXnkhinHPxYVMljuipVk46rFiWQs20MHiY=;
 b=jx1C0eoX5HkWWziFQszgoRTKc6XulS+VniWXaJUoK2mxnMI35LCZYNuIGiEv6hGESV
 DRK5OfiGTcHaQux8hPSE0ztrKhWYr41ONI8tyishJj9ty6h2yLfBKCIsSMb0YiwbKn49
 SMcdd0pqwS4UqjmvGQUfDilyWoLMjCTnboJtsiUue+SkEyeid2fGhNVLG1RQIhaNn2sq
 TRGUxC3NncMRH+f4vgvR/aOC5e3DFxCjXDCnbZ31HzzzyB3Q2KTraesi15bvaz4rMjai
 0+NHeAiilrEFDD/CS6O7kFIIFOs3HqKADy69AIgE8lsXKifS2YRWNmbvp7m9Xnc8mO8+
 Y+iQ==
X-Gm-Message-State: AOJu0YyCAscsYxZExECwt68/J2dtsJH/P1E9kvVDenqKmdoBaNaihFRp
 auXrC9g6FknviasOsGlCT7WyZH50FaMjxkgTJCMadw==
X-Google-Smtp-Source: AGHT+IGQzobGeF9e5K1VM6IDkLw/IEy771kEiwwKekKk6lz+uKchucNAxlmsCDfGcU51c/WavcPSACC7cnKHtH1GYxc=
X-Received: by 2002:a2e:8e38:0:b0:2c5:3261:615e with SMTP id
 r24-20020a2e8e38000000b002c53261615emr2753941ljk.35.1700720313438; Wed, 22
 Nov 2023 22:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-3-seanedmond@linux.microsoft.com>
 <CAC_iWjJf87DM=J0aKUHbOMj8ZhMi=8UtDEEyHRSL3Vv0s+iarQ@mail.gmail.com>
 <89277e39-5b72-4d39-8bac-d5a9f174cd72@linux.microsoft.com>
In-Reply-To: <89277e39-5b72-4d39-8bac-d5a9f174cd72@linux.microsoft.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Nov 2023 08:17:56 +0200
Message-ID: <CAC_iWj+Le_pNhyCGh=z40Vqz2TAH1gEmWGY-YNCFNJ_cNYR_OA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] fdt: kaslr seed from RNG device
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, trini@konsulko.com, 
 sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sean,


On Thu, 23 Nov 2023 at 01:55, Sean Edmond
<seanedmond@linux.microsoft.com> wrote:
>
> Hi Ilias, Applogies, I'm fairly new to upstream contributions and I've mi=
ssed a few things on multi-version patch series such as this one. Simon has=
 elightened about patman though (I feel a bit sheepish that I haven't been =
using this tool all along). Should I resubmit this as a new series to ensur=
e prior reviews and change logs are captured?


No worries, we've all been there. I can re-send my reviewed-by on
those patches. Generally speaking, try to preserve these across
versions, unless something has changed on the patch

Thanks
/Ilias
>
>
>
> Sean
>
> On 2023-11-17 11:33 p.m., Ilias Apalodimas wrote:
>
> Hi Sean
> There are a few reviewed-by tags missing since v3/v4.  Any reason you
> dropped those? The change log doesn't mention anything
>
> Thanks
> /Ilias
>
> On Fri, 17 Nov 2023 at 04:02, <seanedmond@linux.microsoft.com> wrote:
>
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> Add support for KASLR seed from the RNG device. Invokes dm_rng_read()
> API to read 8-bytes of random bytes.  Performs the FDT fixup using event
> spy.  To enable use CONFIG_KASLR_RNG_SEED
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  boot/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig        |  7 +++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 49d14a949be..12defcf645c 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -12,7 +12,10 @@
>  #include <log.h>
>  #include <mapmem.h>
>  #include <net.h>
> +#include <rng.h>
>  #include <stdio_dev.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
>  #include <dm/ofnode.h>
>  #include <linux/ctype.h>
>  #include <linux/types.h>
> @@ -650,6 +653,39 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed=
, int len)
>         return 0;
>  }
>
> +int fdt_rng_kaslr_seed(void *ctx, struct event *event)
> +{
> +       u8 rand[8] =3D {0};
> +       struct udevice *dev;
> +       int ret;
> +       oftree tree =3D event->data.ft_fixup.tree;
> +       ofnode root_node =3D oftree_root(tree);
> +
> +       ret =3D uclass_first_device_err(UCLASS_RNG, &dev);
> +       if (ret) {
> +               printf("ERROR: Failed to find RNG device\n");
> +               return ret;
> +       }
> +
> +       ret =3D dm_rng_read(dev, rand, sizeof(rand));
> +       if (ret) {
> +               printf("ERROR: RNG read failed, ret=3D%d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D fdt_fixup_kaslr_seed(root_node, rand, sizeof(rand));
> +       if (ret) {
> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +#if defined(CONFIG_KASLR_RNG_SEED)
> +EVENT_SPY(EVT_FT_FIXUP, fdt_rng_kaslr_seed);
> +#endif
> +
>  int fdt_record_loadable(void *blob, u32 index, const char *name,
>                         uintptr_t load_addr, u32 size, uintptr_t entry_po=
int,
>                         const char *type, const char *os, const char *arc=
h)
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 19649517a39..4f5dfc00d6f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -477,6 +477,13 @@ config VPL_TPM
>           for the low-level TPM interface, but only one TPM is supported =
at
>           a time by the TPM library.
>
> +config KASLR_RNG_SEED
> +       bool "Use RNG driver for KASLR random seed"
> +       depends on DM_RNG
> +       help
> +         This enables support for using the RNG driver as entropy source=
 for
> +         KASLR seed populated in kernel's device tree.
> +
>  endmenu
>
>  menu "Android Verified Boot"
> --
> 2.42.0
>
