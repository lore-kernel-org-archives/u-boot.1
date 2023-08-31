Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5310C83F3C
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207ED867D0;
	Thu, 31 Aug 2023 21:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GTIRzQtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC6586523; Thu, 31 Aug 2023 21:03:08 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E50866DC
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5711f6dff8cso664921eaf.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508582; x=1694113382; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXXIbfs79p+6oy7B4B9IIc4rZGQG7TNknvy4LICuYBk=;
 b=GTIRzQtZX9+aj2j7y20ajEuBrFp5dkoMqIQ6YrAmxGqDFvqi6ZB5/vwjKxX92W2qAO
 VPEZ8XBm9z7PY9992arR5/Sv4ySILg7aUqgf38sBX/IwOErxR7I0PfZqpzBYPsBbEacD
 XlIkSbr3MzJHV+KFddS4X24fxgv98UOhUGu4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508582; x=1694113382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXXIbfs79p+6oy7B4B9IIc4rZGQG7TNknvy4LICuYBk=;
 b=XX5s6VTm28On4YwhjINw9RjZwuAGr39o2nRmwNFhKXTz8Yva2KMKC990aZ2RduS56d
 TPoU3lpL3zLUhzZOfJsLJSXkj7GzniZEZCfaes9DduoYuvDK5Hcc75/zhK3iPrNSndqF
 C4SLSdnuER0ijetSUF6ls9zpMTbkvO5LUqkk8rcSYB2baX2IWfHZjKm9DOPD72pwO/Fk
 QHSwM9cPbsVM4xe6msRCE0z3s9UyDMEM0d2z3Ppl8UP+9DUL6xlDpyfRSpuCPk0ZouZa
 bdN/yOVizB5qFDPVhCXyzhbVap+faeOWRQujn/Mq5u1EQczYFOc4ITJI55WP5uQjE0Bk
 J+Dw==
X-Gm-Message-State: AOJu0YzQx1+E0oWy0cSAAcTuHIOan634YRmleV+/DYUqRqkcViZ6j3pJ
 4HUFwl+kurV7mVmiiv4lvnQNCdbN5/S2kj1nfDNVvQ==
X-Google-Smtp-Source: AGHT+IHgBzS5eSRFzVZ5LFODz9h708t5n71Q/JndFyG9LHSGwQHKCZezj+zmziQwkQU3wY4G35uQCYNiN3Pgi5AR4qo=
X-Received: by 2002:a05:6358:5283:b0:129:c9c0:ca64 with SMTP id
 g3-20020a056358528300b00129c9c0ca64mr217011rwa.15.1693508581420; Thu, 31 Aug
 2023 12:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230829203710.84201-1-seanedmond@linux.microsoft.com>
 <20230829203710.84201-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20230829203710.84201-2-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:02:00 -0600
Message-ID: <CAPnjgZ0aEmKe0codStO568LChErKkXMVLosN5YqqAH-tD4LBsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fdt: common API to populate kaslr seed
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
> fdt_fixup_kaslr_seed() will update given ofnode with random seed value.
> Source for random seed can be TPM or RNG driver in u-boot or sec
> firmware (ARM).
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Sean Edmond <senaedmond@microsoft.com>
> ---
>  arch/arm/cpu/armv8/sec_firmware.c | 39 +++++++++++--------------------
>  common/fdt_support.c              | 19 +++++++++++++++
>  drivers/core/ofnode.c             | 17 ++++++++++++++
>  include/dm/ofnode.h               | 12 ++++++++++
>  include/fdt_support.h             |  9 +++++++
>  5 files changed, 71 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
> index c0e8726346..5f04cd8aec 100644
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

Is it possible to put this code in an EVT_FT_FIXUP spy? I was rather
hoping not to add new fixup functions.

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
> diff --git a/common/fdt_support.c b/common/fdt_support.c
> index 5e49078f8c..52be4375b4 100644
> --- a/common/fdt_support.c
> +++ b/common/fdt_support.c
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
> index 8df16e56af..4be21133b8 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -870,6 +870,23 @@ ofnode oftree_path(oftree tree, const char *path)
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
> index 0f38b3e736..e79bb62be8 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -901,6 +901,18 @@ ofnode oftree_path(oftree tree, const char *path);
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
> index 2cd8366898..d967118bed 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -11,6 +11,7 @@
>         !defined(USE_HOSTCC)
>
>  #include <asm/u-boot.h>
> +#include <dm/ofnode.h>
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
> 2.40.0
>

Regards,
Simon
