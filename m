Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA27C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F2B87464;
	Sun, 12 Nov 2023 21:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMGFOyWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958F58744C; Sun, 12 Nov 2023 21:03:41 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB68E8747B
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5bf58914bacso40629357b3.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819417; x=1700424217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gXcVZ1DSQiNg4WEPHaLKUdq7LIFhMHxn2UZF4Xbhdoo=;
 b=AMGFOyWSyWZR1H0veWrJAVj6K6n76nYJo3Nb/hFRiI2dpatCJurMcRHsqJ1/+VB9gX
 AmmHgxZ0UhvuxYiFc2BWBiem7an55hv9Ql6lOlZFLKr2ZcbvU5a10ZtirrY3PuWWVrCB
 SZN+t+FxAVDExWFiUNkOlHKqB7C47cJ/YvCkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819417; x=1700424217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXcVZ1DSQiNg4WEPHaLKUdq7LIFhMHxn2UZF4Xbhdoo=;
 b=aqthMslOapbnMKJGHZmF7aGQwZCeUaGN0Cg+BoZ65Hn4WC9cs3egKWovp/tsuVYibx
 dQr0oGMjIoAznkD/IY1zLa9/PDUvBDaBZhe/nN6EE8qjXXS2i5zihyumJOADrLaOPsj/
 xCHBllNIkcKbwINNQlPdV7jXTdwlg50NFFGGn1xxchjCIpmAEgdZEyyd/e/FLQjikKRH
 sruqDq5VQdyG6Jq37s7Oz466wQ0Aaf3VKZlXRF42VLOaoRpMe8zl08XzL3nCZJ+NeIxs
 SJn27fctlvbWflvObJuUkdYO4WCq4+rTvc3OOhGM6kL/BKPrjGQTAUFG7SOHaq/BE0+e
 1ZDw==
X-Gm-Message-State: AOJu0YxBnEKPLBIZNFwWkOGHs0DRPI87Wqxhi6rgRUW36shy3zqAxXfO
 aM4JdXKOiS2xibDQY01Izt0WAOmerRBipmyX5IPpZA==
X-Google-Smtp-Source: AGHT+IGuORoo/b3qcChB9Em96i57rr5AIg9+UDmoAnrQgwP9AcZFbTRoUYlEnOfa9FInJRdUeYj2I7BDVddBjEuBsr4=
X-Received: by 2002:a0d:d283:0:b0:5b3:1d71:6df7 with SMTP id
 u125-20020a0dd283000000b005b31d716df7mr4743443ywd.22.1699819416988; Sun, 12
 Nov 2023 12:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
 <20231103183844.2308934-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20231103183844.2308934-2-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:08 -0700
Message-ID: <CAPnjgZ2xTSSbAPhB0Beu6cOOsSfFG7YJJCM+KqcFyCO9a2D29A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fdt: common API to populate kaslr seed
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

On Fri, 3 Nov 2023 at 12:39, <seanedmond@linux.microsoft.com> wrote:
>
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> fdt_fixup_kaslr_seed() will update given ofnode with random seed value.
> Source for random seed can be TPM or RNG driver in u-boot or sec
> firmware (ARM).
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Sean Edmond <senaedmond@microsoft.com>
> ---
>  arch/arm/cpu/armv8/sec_firmware.c | 39 +++++++++++--------------------
>  boot/fdt_support.c                | 19 +++++++++++++++
>  drivers/core/ofnode.c             | 17 ++++++++++++++
>  include/dm/ofnode.h               | 12 ++++++++++
>  include/fdt_support.h             |  9 +++++++
>  5 files changed, 71 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
> index c0e8726346f..5f04cd8aecd 100644
> --- a/arch/arm/cpu/armv8/sec_firmware.c
> +++ b/arch/arm/cpu/armv8/sec_firmware.c
> @@ -411,46 +411,35 @@ int sec_firmware_init(const void *sec_firmware_img,
>  /*
>   * fdt_fix_kaslr - Add kalsr-seed node in Device tree
>   * @fdt:               Device tree
> - * @eret:              0 in case of error, 1 for success
> + * @eret:              0 for success
>   */
>  int fdt_fixup_kaslr(void *fdt)
>  {
> -       int nodeoffset;
> -       int err, ret = 0;
> -       u8 rand[8];
> +       int ret = 0;
>
>  #if defined(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT)
> +       u8 rand[8];
> +       ofnode root;
> +
>         /* Check if random seed generation is  supported */
>         if (sec_firmware_support_hwrng() == false) {
>                 printf("WARNING: SEC firmware not running, no kaslr-seed\n");
> -               return 0;
> +               return -EOPNOTSUPP;
>         }
>
> -       err = sec_firmware_get_random(rand, 8);
> -       if (err < 0) {
> +       ret = sec_firmware_get_random(rand, 8);
> +       if (ret < 0) {
>                 printf("WARNING: No random number to set kaslr-seed\n");
> -               return 0;
> +               return ret;
>         }
>
> -       err = fdt_check_header(fdt);
> -       if (err < 0) {
> -               printf("fdt_chosen: %s\n", fdt_strerror(err));
> -               return 0;
> +       ret = root_ofnode_from_fdt(fdt, &root);
> +       if (ret < 0) {
> +               printf("WARNING: Unable to get root ofnode\n");
> +               return ret;
>         }
>
> -       /* find or create "/chosen" node. */
> -       nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
> -       if (nodeoffset < 0)
> -               return 0;
> -
> -       err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", rand,
> -                                 sizeof(rand));
> -       if (err < 0) {
> -               printf("WARNING: can't set kaslr-seed %s.\n",
> -                      fdt_strerror(err));
> -               return 0;
> -       }
> -       ret = 1;
> +       ret = fdt_fixup_kaslr_seed(root, rand, sizeof(rand));
>  #endif
>
>         return ret;
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 5e49078f8c3..52be4375b46 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -631,6 +631,25 @@ void fdt_fixup_ethernet(void *fdt)
>         }
>  }
>
> +int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
> +{
> +       ofnode chosen;
> +       int ret;
> +
> +       /* find or create "/chosen" node. */
> +       ret = ofnode_add_subnode(node, "chosen", &chosen);
> +       if (ret && ret != -EEXIST)
> +               return -ENOENT;
> +
> +       ret = ofnode_write_prop(chosen, "kaslr-seed", seed, len, true);
> +       if (ret) {
> +               printf("WARNING: can't set kaslr-seed\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  int fdt_record_loadable(void *blob, u32 index, const char *name,
>                         uintptr_t load_addr, u32 size, uintptr_t entry_point,
>                         const char *type, const char *os, const char *arch)
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 29a42945102..55291f0202b 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -966,6 +966,23 @@ ofnode oftree_path(oftree tree, const char *path)
>         }
>  }
>
> +int root_ofnode_from_fdt(void *fdt, ofnode *root_node)
> +{
> +       oftree tree;
> +       /* If OFNODE_MULTI_TREE is not set, and if fdt is not the control FDT,
> +        *  oftree_from_fdt() will return NULL
> +        */
> +       tree = oftree_from_fdt(fdt);
> +
> +       if (!oftree_valid(tree)) {
> +               printf("Cannot create oftree\n");
> +               return -EINVAL;
> +       }
> +       *root_node = oftree_root(tree);
> +
> +       return 0;
> +}
> +
>  const void *ofnode_read_chosen_prop(const char *propname, int *sizep)
>  {
>         ofnode chosen_node;
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 19e97a90327..5759cac5b30 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -936,6 +936,18 @@ ofnode oftree_path(oftree tree, const char *path);
>   */
>  ofnode oftree_root(oftree tree);
>
> +/**
> + * root_ofnode_from_fdt() - Gets the root ofnode given an FDT blob.
> + *                          Note, this will fail if OFNODE_MULTI_TREE
> + *                          is not set.
> + *
> + * @fdt: Device tree to use
> + * @root_node : Root ofnode
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int root_ofnode_from_fdt(void *fdt, ofnode *root_node);
> +
>  /**
>   * ofnode_read_chosen_prop() - get the value of a chosen property
>   *
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 2cd83668982..d967118bedf 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -11,6 +11,7 @@
>         !defined(USE_HOSTCC)
>
>  #include <asm/u-boot.h>
> +#include <dm/ofnode.h>

I believe you only need dm/ofnode-decl.h here. That avoids pulling in
ofnode.h which ends up with of.h which includes asm/global_data.h
which causes a warning for qemu_arm64 for me.

Perhaps that last include could be dropped? But in any case, we should
use ofnode-decl.h in preference to ofnode.h if possible

>  #include <linux/libfdt.h>
>  #include <abuf.h>
>
> @@ -121,6 +122,14 @@ static inline int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[],
>  #endif
>
>  void fdt_fixup_ethernet(void *fdt);
> +
> +/*
> + * fdt_fixup_kaslr_seed - Add kaslr-seed node in Device tree
> + * @node:              ofnode
> + * @eret:              0 for success
> + */
> +int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len);
> +
>  int fdt_find_and_setprop(void *fdt, const char *node, const char *prop,
>                          const void *val, int len, int create);
>  void fdt_fixup_qe_firmware(void *fdt);
> --
> 2.42.0
>

Regards,
Simon
