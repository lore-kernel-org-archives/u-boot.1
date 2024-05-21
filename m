Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C6BC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD2988722;
	Tue, 21 May 2024 14:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aBkrpIxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3EB8873C; Tue, 21 May 2024 14:05:09 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8F288722
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52327368e59so5977787e87.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716293106; x=1716897906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wf5iiSGYNU2DzGPbpIPerEtxV9NeqXlZyTeBcFZzC3Q=;
 b=aBkrpIxXt6rdSsU0SSk0ciZwk+r2pjX7I786puSEWKJI6Pp7lcNNXhmMOPM82jhaqe
 rPadvZw3mv0SUg0+YN8oNNYVXnCZctVWJ1xLvc4EJgPtFHK+G98R0w7ptRbKDkpPUYaz
 HqD7bMj0DYZiK2iGNovkRdU4yZkJWJh/Mh6tVqi3d5z5S52t1XicM2x8/L9RtM3rFYSQ
 EqCuwFd51N6EDA/N1tQ3+iTLXT+oCwrfexgOX47bTizHtX/i4vCBgK4IBNhNn7vAz09X
 z4JL9YFRgYgpGhvFLnfRrNrAtJu2ibJsToFPaxV8tMDvbRb5RineenoFACtR3jyu53hg
 5Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716293106; x=1716897906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wf5iiSGYNU2DzGPbpIPerEtxV9NeqXlZyTeBcFZzC3Q=;
 b=DY+vVONr/eTarCYA7xe8OnLbHbJWBTgyrWrvW+VZ47PA051MWUCcKSWzo6RpNOxcCq
 VRzw7I2dgdyOqmUOMIJVabuqt5m/oEwrnEE0jAJ1pEBjEklJUMB7DuLhTVA5qG4ZnzSd
 XydPKobLQ0xYF7fS3B5MsKgjAc1xadhmj+pnrGkB7D9fTgUGqoGbtbttlKKt3rxhgN3L
 oGjGr+6WxISo1ytLomA4hCvwFuyIW3cblwNrg1aT+UbM+SoPRB681fKV460r84NO1iVo
 RYTm81r94y2X5jwJVmdLbWnwFr50wVSc475QCIs/68N1AW8pZhciJwrJ6TR9ymCysZl+
 ZTrg==
X-Gm-Message-State: AOJu0YyGt4kb73B7D++/mqnRR0dX7x6bfCrASwaRUNPjPidWRD7xTpLc
 lmW/5/ao3ob+PUyvYAm9ktaeGSYXddCHVlpKPQ9aDbQdYOAqaPXFeSUEfJ9XEBIO043zR+HRXFb
 hfT7qoVMNt4KF+MGbLNIJ8ZAbFwgGDcRDs7YObg==
X-Google-Smtp-Source: AGHT+IH/ghsbkJtS5eubFnVa/mleQzguC53ch7I9tq260pjCiL6aH+a6lBQQf4kzdiyPgUrjzJ3gWygd+wvNL44csbk=
X-Received: by 2002:a05:6512:280c:b0:51f:53e0:1bc3 with SMTP id
 2adb3069b0e04-5220fc7af9amr25303500e87.25.1716293106455; Tue, 21 May 2024
 05:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240515205049.3005256-1-tharvey@gateworks.com>
In-Reply-To: <20240515205049.3005256-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 15:04:29 +0300
Message-ID: <CAC_iWjL2LwY7V4SbwRqsgjnYqnLEU1curr7ZXLLQWWmrTX=nTQ@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
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

Hi Tim

On Wed, 15 May 2024 at 23:50, Tim Harvey <tharvey@gateworks.com> wrote:
>
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.

Since you'll send a v2, mind adding some description for UEFI on the
commit message?
efi_try_purge_kaslr_seed() has a comment of the behaviour

Thanks
/Ilias
>
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
> it's implementation uses a different source of entropy.
>
> As this fdt node is added elsewhere create a library function and
> use it to deduplicate code.
>
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>  - fix typo in commit msg
>  - use stack for seed to avoid unecessary malloc/free
>  - move to a library function and deduplicate code by using it elsewhere
> ---
>  board/xilinx/common/board.c | 35 -----------------------------
>  boot/fdt_support.c          | 10 +++++++++
>  boot/pxe_utils.c            | 35 +++--------------------------
>  cmd/kaslrseed.c             | 45 ++++++-------------------------------
>  include/kaslrseed.h         | 17 ++++++++++++++
>  lib/Makefile                |  1 +
>  lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
>  7 files changed, 72 insertions(+), 105 deletions(-)
>  create mode 100644 include/kaslrseed.h
>  create mode 100644 lib/kaslrseed.c
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 30a81376ac41..f741e8957818 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>         if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>                 fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>
> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -               debug("No RNG device\n");
> -               return 0;
> -       }
> -
> -       if (dm_rng_read(dev, buf, n)) {
> -               debug("Reading RNG failed\n");
> -               return 0;
> -       }
> -
> -       if (!blob) {
> -               debug("No FDT memory address configured. Please configure\n"
> -                     "the FDT address via \"fdt addr <address>\" command.\n"
> -                     "Aborting!\n");
> -               return 0;
> -       }
> -
> -       ret = fdt_check_header(blob);
> -       if (ret < 0) {
> -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
> -               return ret;
> -       }
> -
> -       nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               debug("Reading chosen node failed\n");
> -               return nodeoffset;
> -       }
> -
> -       ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -       if (ret < 0) {
> -               debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -               return ret;
> -       }
> -
>         return 0;
>  }
>  #endif
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 874ca4d6f5af..3455d60d69dc 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -8,6 +8,7 @@
>
>  #include <abuf.h>
>  #include <env.h>
> +#include <kaslrseed.h>
>  #include <log.h>
>  #include <mapmem.h>
>  #include <net.h>
> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
>         if (nodeoffset < 0)
>                 return nodeoffset;
>
> +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
> +               err = fdt_kaslrseed(fdt);
> +               if (err) {
> +                       printf("WARNING: could not set kaslr-seed %s.\n",
> +                              fdt_strerror(err));
> +                       return err;
> +               }
> +       }
> +
>         if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>                 err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>                                   abuf_data(&buf), abuf_size(&buf));
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 4b22bb6f525a..8d70233fc08d 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -8,6 +8,7 @@
>  #include <dm.h>
>  #include <env.h>
>  #include <image.h>
> +#include <kaslrseed.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <mapmem.h>
> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
>  #if CONFIG_IS_ENABLED(DM_RNG)
>         ulong fdt_addr;
>         struct fdt_header *working_fdt;
> -       size_t n = 0x8;
> -       struct udevice *dev;
> -       u64 *buf;
> -       int nodeoffset;
>         int err;
>
>         /* Get the main fdt and map it */
> @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
>         if (err <= 0)
>                 return;
>
> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -               printf("No RNG device\n");
> -               return;
> -       }
> -
> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               printf("Reading chosen node failed\n");
> -               return;
> -       }
> -
> -       buf = malloc(n);
> -       if (!buf) {
> -               printf("Out of memory\n");
> -               return;
> -       }
> -
> -       if (dm_rng_read(dev, buf, n)) {
> -               printf("Reading RNG failed\n");
> -               goto err;
> -       }
> -
> -       err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -       if (err < 0) {
> +       err = fdt_kaslrseed(working_fdt);
> +       if (err < 0)
>                 printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
> -               goto err;
> -       }
> -err:
> -       free(buf);
>  #endif
>         return;
>  }
> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index e0d3c7fe7489..ea5c07d729cf 100644
> --- a/cmd/kaslrseed.c
> +++ b/cmd/kaslrseed.c
> @@ -9,33 +9,16 @@
>  #include <command.h>
>  #include <dm.h>
>  #include <hexdump.h>
> +#include <kaslrseed.h>
>  #include <malloc.h>
>  #include <rng.h>
>  #include <fdt_support.h>
>
>  static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> -       size_t n = 0x8;
> -       struct udevice *dev;
> -       u64 *buf;
> -       int nodeoffset;
> -       int ret = CMD_RET_SUCCESS;
> +       int err;
>
> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -               printf("No RNG device\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       buf = malloc(n);
> -       if (!buf) {
> -               printf("Out of memory\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       if (dm_rng_read(dev, buf, n)) {
> -               printf("Reading RNG failed\n");
> -               return CMD_RET_FAILURE;
> -       }
> +       printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed");
>
>         if (!working_fdt) {
>                 printf("No FDT memory address configured. Please configure\n"
> @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>                 return CMD_RET_FAILURE;
>         }
>
> -       ret = fdt_check_header(working_fdt);
> -       if (ret < 0) {
> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> +       err = fdt_kaslrseed(working_fdt);
> +       if (err < 0) {
> +               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
>                 return CMD_RET_FAILURE;
>         }
>
> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               printf("Reading chosen node failed\n");
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -       if (ret < 0) {
> -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       free(buf);
> -
> -       return ret;
> +       return CMD_RET_SUCCESS;
>  }
>
>  U_BOOT_LONGHELP(kaslrseed,
> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> new file mode 100644
> index 000000000000..3fe82f418acf
> --- /dev/null
> +++ b/include/kaslrseed.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> + */
> +
> +#if !defined _KASLRSEED_H_
> +#define _KASLRSEED_H_
> +
> +/**
> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> + *
> + * @blob:      fdt blob
> + * Return:     0 if OK, -ve on error
> + */
> +int fdt_kaslrseed(void *blob);
> +
> +#endif /* _KASLRSEED_H_ */
> diff --git a/lib/Makefile b/lib/Makefile
> index 2a76acf100d0..20a0242055fa 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -149,6 +149,7 @@ obj-y += date.o
>  obj-y += rtc-lib.o
>  obj-$(CONFIG_LIB_ELF) += elf.o
>
> +obj-$(CONFIG_DM_RNG) += kaslrseed.o
>  obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
>
>  #
> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> new file mode 100644
> index 000000000000..ad06bee2b88d
> --- /dev/null
> +++ b/lib/kaslrseed.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> + */
> +#include <dm.h>
> +#include <rng.h>
> +#include <fdt_support.h>
> +
> +int fdt_kaslrseed(void *fdt)
> +{
> +       struct udevice *dev;
> +       int nodeoffset;
> +       u64 data;
> +       int err;
> +
> +       err = fdt_check_header(fdt);
> +       if (err < 0)
> +               return err;
> +
> +       /* find or create "/chosen" node. */
> +       nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
> +       if (nodeoffset < 0)
> +               return nodeoffset;
> +
> +       err = uclass_get_device(UCLASS_RNG, 0, &dev);
> +       if (!err)
> +               err = dm_rng_read(dev, &data, sizeof(data));
> +       if (!err)
> +               err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
> +       if (err < 0)
> +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
> +
> +       return err;
> +}
> --
> 2.25.1
>
