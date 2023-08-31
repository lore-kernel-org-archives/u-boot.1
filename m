Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD411C83F3A
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B78386703;
	Thu, 31 Aug 2023 21:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Frg9Xu6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0725686758; Thu, 31 Aug 2023 21:03:07 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D741386776
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d7bb34576b9so893060276.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508581; x=1694113381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zd2+UgyqdGx0X5fvzolvOz/u1zDlr/G7N+mBSR1ttbk=;
 b=Frg9Xu6a3i/kMADFO2EPYjcnnOGxP1gOREQZUUjmRMvwUNqjC+Rgzwxx8gD5uX9zD8
 nHuOiJNgtv+5vxK/IdrqlHN2xUGM4KcoAWng1mhu+XMgiAEN9J0EQZ4knA5xwm2DwLJt
 drd2Jo20Vg5D0MbklzVLx4/FtSQLRMA5ehtHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508581; x=1694113381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zd2+UgyqdGx0X5fvzolvOz/u1zDlr/G7N+mBSR1ttbk=;
 b=Hbg8gPMdTY90DmrgEKb1/vgY4mRAqXl+JCKYiZbqAgIvksm0G8ephVHvlRuAFRRBCs
 AKqyuV4+l9Qp8a+prgdqY2rX/iur8ed+gCa7Ejyf1piVNwkRntRa+U7s2f2P075RDLhq
 99Nyoc6/uVett9/Fxh4xle9SYJq2J7ml7Q5gbghQNEf3aqZhtsMFUIi3MoQZcBLzji3P
 GZmpF7EB/wieCBbsZc94q6itSuR50cN27Q8AyZtZmTJI/5UV5EJQbvgBbzd+yowEWfqX
 UrSzLGP5WoXnbTnAoXE/jNfd79y0eTRrwjyk1eX45ioUuuXEniZ5KQbvFtM+5eLvh6A/
 tUTw==
X-Gm-Message-State: AOJu0YwnCUQsHc8CJCukki+mHLk41PWdkibBEQRmvlfLlrgIWjKYmsXT
 CWBE1M0PPVAvjm00xbcXSv4f9zyE8tmBDdpM4A68RK6Fj1k2HXX2LpI=
X-Google-Smtp-Source: AGHT+IHzQjwAiACTDWUo1ISZJ14oFdWA6HQqC39VSAHxR08lGLJy4F9aLukc6es+nzrPmCSURV1x88Oh09XO4nh9MEo=
X-Received: by 2002:a25:ca43:0:b0:d0f:6f1d:89ec with SMTP id
 a64-20020a25ca43000000b00d0f6f1d89ecmr575674ybg.35.1693508581413; Thu, 31 Aug
 2023 12:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230829203710.84201-1-seanedmond@linux.microsoft.com>
 <20230829203710.84201-3-seanedmond@linux.microsoft.com>
In-Reply-To: <20230829203710.84201-3-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:02:01 -0600
Message-ID: <CAPnjgZ1isQxqve6snY58z=1mzjOgQ9+BfA+JnMCTcSvjwCZWPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fdt: kaslr seed from tpm entropy
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, macromorgan@hotmail.com
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

Hi Sean,

On Tue, 29 Aug 2023 at 14:37, <seanedmond@linux.microsoft.com> wrote:
>
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> Add support for KASLR seed from TPM device. Invokes tpm_get_random()
> API to read 8-bytes of random bytes for KASLR.
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  boot/image-fdt.c      | 15 +++++++++++++++
>  common/fdt_support.c  | 30 ++++++++++++++++++++++++++++++
>  include/fdt_support.h |  8 ++++++++
>  lib/Kconfig           |  9 +++++++++
>  4 files changed, 62 insertions(+)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index f10200f647..ed38ed77b9 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -624,6 +624,21 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
>                 goto err;
>         }
>
> +       if (IS_ENABLED(CONFIG_KASLR_TPM_SEED)) {
> +               ofnode root;
> +
> +               ret = root_ofnode_from_fdt(blob, &root);

But can't you drop all this code and use an event spy?

> +               if (ret) {
> +                       printf("ERROR: Unable to get root ofnode\n");
> +                       goto err;
> +               }
> +               ret = fdt_tpm_kaslr_seed(root);

This function can have a test.

> +               if (ret) {
> +                       printf("ERROR: fdt fixup KASLR failed: %d\n", ret);
> +                       goto err;
> +               }
> +       }
> +
>         fdt_ret = optee_copy_fdt_nodes(blob);
>         if (fdt_ret) {
>                 printf("ERROR: transfer of optee nodes to new fdt failed: %s\n",
> diff --git a/common/fdt_support.c b/common/fdt_support.c
> index 52be4375b4..d338fcde54 100644
> --- a/common/fdt_support.c
> +++ b/common/fdt_support.c
> @@ -13,6 +13,9 @@
>  #include <mapmem.h>
>  #include <net.h>
>  #include <stdio_dev.h>
> +#include <tpm_api.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
>  #include <dm/ofnode.h>
>  #include <linux/ctype.h>
>  #include <linux/types.h>
> @@ -650,6 +653,33 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
>         return 0;
>  }
>
> +int fdt_tpm_kaslr_seed(ofnode node)
> +{
> +       u8 rand[8] = {0};
> +       struct udevice *dev;
> +       int ret;
> +
> +       ret = uclass_first_device_err(UCLASS_TPM, &dev);
> +       if (ret) {
> +               printf("ERROR: Failed to find TPM device\n");
> +               return ret;
> +       }
> +
> +       ret = tpm_get_random(dev, rand, sizeof(rand));
> +       if (ret) {
> +               printf("ERROR: TPM GetRandom failed, ret=%d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = fdt_fixup_kaslr_seed(node, rand, sizeof(rand));
> +       if (ret) {
> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  int fdt_record_loadable(void *blob, u32 index, const char *name,
>                         uintptr_t load_addr, u32 size, uintptr_t entry_point,
>                         const char *type, const char *os, const char *arch)
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index d967118bed..117ca14ca5 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -130,6 +130,14 @@ void fdt_fixup_ethernet(void *fdt);
>   */
>  int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len);
>
> +/*
> + * fdt_add_tpm_kaslr_seed - Add kalsr-seed node in Device tree with random
> + *                         bytes from TPM device
> + * @node:              ofnode
> + * @eret:              0 for success
> + */
> +int fdt_tpm_kaslr_seed(ofnode node);
> +
>  int fdt_find_and_setprop(void *fdt, const char *node, const char *prop,
>                          const void *val, int len, int create);
>  void fdt_fixup_qe_firmware(void *fdt);
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 3926652db6..1530ef7c86 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -465,6 +465,15 @@ config VPL_TPM
>           for the low-level TPM interface, but only one TPM is supported at
>           a time by the TPM library.
>
> +config KASLR_TPM_SEED
> +       bool "Use TPM for KASLR random seed"
> +       depends on TPM_V1 || TPM_V2
> +       help
> +         This enables support for using TPMs as entropy source for KASLR seed
> +         populated in kernel's device tree. Both TPMv1 and TPMv2 are supported
> +         for the low-level TPM interface, but only one TPM is supported at
> +         a time by the library.
> +
>  endmenu
>
>  menu "Android Verified Boot"
> --
> 2.40.0
>

Regards,
Simon
