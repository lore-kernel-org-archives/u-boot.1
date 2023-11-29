Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE25C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4CA87766;
	Wed, 29 Nov 2023 18:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YRqjnQ2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5BD87788; Wed, 29 Nov 2023 18:47:50 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADA987773
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a02d91ab199so5897466b.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280065; x=1701884865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dC+zlIAOUfE8m8iNDcFpliNJDBDGaih7zKYPxZzdiSs=;
 b=YRqjnQ2Fv1jea4ZYbW7Jg8lBYWKEAwxm5oRYjyrHuPjh9nn01P4OiYxGBt2GOBYNhp
 5R3ytyr4nmgaoMpUUxXa28+aTsSpZRnh+y5QvGscIGLRIX6VZVopCZnPY9M4ivXxnv66
 F/4uCfp5kc3yegRE/AKdHJrPGVT/LGma5N2PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280065; x=1701884865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dC+zlIAOUfE8m8iNDcFpliNJDBDGaih7zKYPxZzdiSs=;
 b=pqiR+IxVN+Datlq5KKnozKwwPCf2okc9RxihyNZK9MhBBM9+HPv9xPa8o6zwL6P1BO
 VPtI7gn7K3sE/zVZNtE2rKaVuw63vFaEjJiDnWHYQbQO3YQnLkU+3fz1PASmrQE9GTGQ
 a3cM8VcGsd2XAynAFMmpZY4T+7nWrsiJVT24PDrVxkUHWmgTzrE0+nETjljmotqyosuE
 g11aLkRjAtIc9oy0IXzh04XEED2CsxTxpSKmLnGo6es4/H3lvibnmp5vkGh83s45zx6v
 dUulYwnqCTbqvUxfW0TK7uNBMDXzYzXJVGDkrblVmFHz+RCBYFLcKvfHPTG3UqCsd0OK
 HGMA==
X-Gm-Message-State: AOJu0YxxFem6ZtJfZODyQgMfQQG3iMg0jK0NP0H8WT0ZvCAuLHl2aJ9b
 imLSSm0NdGr/7GdW7YIh8zWlSsRlGaTvzvvtTVKgPg==
X-Google-Smtp-Source: AGHT+IEDuSHb6SjGQjzy4XY5iy97pzDLdHSYnvxshw9NbJ2LqVgn2ASljT+bCCwdzzybFjBQZib2OZkvm37hyzQECGw=
X-Received: by 2002:a17:907:2993:b0:a00:185a:a150 with SMTP id
 eu19-20020a170907299300b00a00185aa150mr10280876ejc.38.1701280064977; Wed, 29
 Nov 2023 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20231117020207.948636-2-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 10:47:29 -0700
Message-ID: <CAPnjgZ3X80-PnLf7x_hK7rrFangOxG5yjm=CtMSU9O3+Jtmkww@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] fdt: common API to populate kaslr seed
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

On Thu, 16 Nov 2023 at 19:02, <seanedmond@linux.microsoft.com> wrote:
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

Please can you put the core changes in their own patch?

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
> index b15d07765fe..49d14a949be 100644
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
> index f72ea416cf1..6ce468d9cac 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -966,6 +966,23 @@ ofnode oftree_path(oftree tree, const char *path)
>         }
>  }
>
> +int root_ofnode_from_fdt(void *fdt, ofnode *root_node)

Can you use ofnode_root_from_fdt() so that ofnode is first?


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
> index 5795115c490..3e0bbd0c33e 100644
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
> index 2cd83668982..0624650dcee 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -11,6 +11,7 @@
>         !defined(USE_HOSTCC)
>
>  #include <asm/u-boot.h>
> +#include <dm/ofnode_decl.h>
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
