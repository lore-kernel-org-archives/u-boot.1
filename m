Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A60C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 21:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3A6E86501;
	Sat,  2 Dec 2023 22:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X41k4GsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D22987878; Sat,  2 Dec 2023 22:16:41 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D9887873
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 22:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a184d717de1so455354966b.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701551798; x=1702156598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5P0qcxPCqmbfQm8nJqzNOJF6VdeyHmPLZLlzwMLlxc=;
 b=X41k4GsZBqyPmCHp/6POoezqwaMQPOpVg2wqQUwtxQpps5vog0tvu8BVW+giLDechK
 D7FefNKPlkMES3nVuz3zHdJsFGXz/O56tBnYBWfqAjaKVdohdwg3JDYlO8wv/160CMAD
 E7cemz/euUSX/Q7JlLTJHZVBwXx4qkdIfopVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701551798; x=1702156598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5P0qcxPCqmbfQm8nJqzNOJF6VdeyHmPLZLlzwMLlxc=;
 b=krirFgB5/BWaCG43aUgk2136v0lDpq90/kH6LjU8ii3s8Tn2NJUyvEbNVa26u1vfXn
 ywT+f6AflbGYkueGoSi+FsmC5P3yCr3uRiWyyjW014G4ISDqm1V2IpcndGGgX1x3KXNY
 MgNkjonOTy/9kUcOKzf0GLAANmY9THY8MU73agGiMQxf7nNf1eIC0+lL6REmmYOP0kr2
 21t/vnoHo6h0Yim1G2cZbZsXBspC9eYXIeSuXfzmlVfL8zrSPAH8dzwNZhGY7qgmS2xE
 vgTjCK/bvZA+9rG8RAI9LHd1CIc1pbMbT38se9wtl0oqNrmkOKqcxt80nuGWB7RarLCT
 YFUA==
X-Gm-Message-State: AOJu0Yy5uJFXlKNRsYC2BNmRraCCYVJSACJMU+lHzscfp0LI1VTereYR
 ztc9TLMCQ509MrCOGzghYV/CFyQcGqHq8kq0PdoDKQ==
X-Google-Smtp-Source: AGHT+IGdeHgAPOCtciJtWZVNVR2b/DXnU9Rfy390GM9iBHav1nmJHG8JUzOzlmjGD7FPv7FzqGvmxEa7RvOmQI6suB4=
X-Received: by 2002:a17:906:2555:b0:a19:a19b:4256 with SMTP id
 j21-20020a170906255500b00a19a19b4256mr1591869ejb.193.1701551798190; Sat, 02
 Dec 2023 13:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-18-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-18-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 14:16:26 -0700
Message-ID: <CAPnjgZ16Cv5r6GB0j_WXTPTsASGj=Hi5Cdytyo-K7a-c73AeoA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] qemu-arm: Get bloblist from boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add platform custom function to get bloblist from boot arguments.

This should be the same for all ARM platforms. The ultimate goal is
something like [1]

> Check whether boot arguments aligns with the register conventions
> defined in FW Handoff spec v0.9.
> Add bloblist related options into qemu default config.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
>
>  board/emulation/qemu-arm/Makefile        |  1 +
>  board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
>  board/emulation/qemu-arm/qemu-arm.c      | 54 ++++++++++++++++++++++++
>  configs/qemu_arm64_defconfig             |  3 ++
>  configs/qemu_arm_defconfig               |  3 ++
>  5 files changed, 80 insertions(+)
>  create mode 100644 board/emulation/qemu-arm/lowlevel_init.S
>
> diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
> index a22d1237ff..12821e7083 100644
> --- a/board/emulation/qemu-arm/Makefile
> +++ b/board/emulation/qemu-arm/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  obj-y  += qemu-arm.o
> +obj-$(CONFIG_OF_BOARD) += lowlevel_init.o
> diff --git a/board/emulation/qemu-arm/lowlevel_init.S b/board/emulation/qemu-arm/lowlevel_init.S
> new file mode 100644
> index 0000000000..d72d7c938a
> --- /dev/null
> +++ b/board/emulation/qemu-arm/lowlevel_init.S
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <config.h>
> +
> +.global save_boot_params
> +save_boot_params:
> +#ifdef CONFIG_ARM64
> +       adr x9, qemu_saved_args
> +       stp x0, x1, [x9]
> +       /* Increment the address by 16 bytes for the next pair of values */
> +       stp x2, x3, [x9, #16]
> +#else
> +       ldr r12, =qemu_saved_args
> +       stm r12, {r0, r1, r2, r3}
> +#endif
> +       b       save_boot_params_ret
> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> index 942f1fff57..a3892630d8 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -4,6 +4,9 @@
>   */
>
>  #include <common.h>
> +#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
> +#include <bloblist.h>
> +#endif
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <efi.h>
> @@ -102,6 +105,16 @@ static struct mm_region qemu_arm64_mem_map[] = {
>  struct mm_region *mem_map = qemu_arm64_mem_map;
>  #endif
>
> +#if IS_ENABLED(CONFIG_OF_BOARD)

OF_BLOBLIST and please avoid #if

> +/* Boot parameters saved from lowlevel_init.S */
> +struct {
> +       unsigned long arg0;
> +       unsigned long arg1;
> +       unsigned long arg2;
> +       unsigned long arg3;
> +} qemu_saved_args __section(".data");
> +#endif
> +
>  int board_init(void)
>  {
>         return 0;
> @@ -144,6 +157,47 @@ void *board_fdt_blob_setup(int *err)
>         return (void *)CFG_SYS_SDRAM_BASE;
>  }
>
> +int board_bloblist_from_boot_arg(unsigned long __maybe_unused addr,
> +                                unsigned long __maybe_unused size)
> +{
> +       int ret = -ENOENT;
> +
> +#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
> +       unsigned long fdt;
> +
> +       ret = bloblist_check(qemu_saved_args.arg3, 0);
> +       if (ret)
> +               return ret;
> +
> +       bloblist_show_stats();
> +       bloblist_show_list();
> +       if (gd->bloblist->total_size > size) {
> +               gd->bloblist = NULL; /* Reset the gd bloblist pointer */
> +               log_err("Bloblist total size:%d, board reserved size:%ld\n",
> +                       gd->bloblist->total_size, size);
> +               return -ENOSPC;
> +       }
> +
> +       /* Check the register conventions */
> +       fdt = (unsigned long)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);

This should happen in fdtdec.c automatically. See [2]

> +       if (IS_ENABLED(CONFIG_ARM64)) {
> +               if (fdt != qemu_saved_args.arg0 || qemu_saved_args.arg2 != 0)
> +                       ret = -EIO;
> +       } else {
> +               if (fdt != qemu_saved_args.arg2 || qemu_saved_args.arg0 != 0)
> +                       ret = -EIO;
> +       }
> +
> +       if (ret)
> +               gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
> +       else
> +               memmove((void *)addr,  (void *)qemu_saved_args.arg3,
> +                       gd->bloblist->total_size);
> +#endif
> +
> +       return ret;
> +}
> +
>  void enable_caches(void)
>  {
>          icache_enable();
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 5fdf496a45..60fabb5db7 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -71,3 +71,6 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_TPM=y
> +CONFIG_BLOBLIST=y
> +CONFIG_BLOBLIST_ADDR=0x40004000
> +CONFIG_BLOBLIST_SIZE=0x4000
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index 1347b86f34..d8a94ad038 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -71,3 +71,6 @@ CONFIG_TPM2_MMIO=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
>  CONFIG_TPM=y
> +CONFIG_BLOBLIST=y
> +CONFIG_BLOBLIST_ADDR=0x40004000
> +CONFIG_BLOBLIST_SIZE=0x4000
> --
> 2.25.1
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
[2] https://patchwork.ozlabs.org/project/uboot/patch/20230926141514.2101787-40-sjg@chromium.org/
