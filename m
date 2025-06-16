Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E70C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 10:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E4B182063;
	Mon, 16 Jun 2025 12:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J7tx5PNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00F78210D; Mon, 16 Jun 2025 12:18:33 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE6081760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 12:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e40e3f316so30946867b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750069110; x=1750673910; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1DLi6vp5y8h6K2KWNhVdnWG7ljY4swPvyYxCwuC3OY=;
 b=J7tx5PNCqjMi3ADYru0yQ3TTtx3e7M3KSO5Ea0qC+Fs8eaJ6nMxI6H61WxRyajSTq2
 do5o8Zxn3FEGCzxxnvPmA6YbogbIYJ1jh3wJjDJUiTRipSNsFCuSJH1KFNh06aCKVA6E
 lkSyr1Tj4uzHbDgDKutTeEGh8weaQAabz1AV8ABD87CJl655C7qK1ur+5Xr52mqWu4QG
 vGN+46xW71+aD+tTVQYt1dll9KX0xmSmLr9uW7h+aHpFcNfladCWcRL94wRTJq9vas7j
 tvnAfNayVWJs0EucfX54lvlgmk7i6vzpXrN726alMrRPA3cifCeCKD8WuQmMYr2hbGys
 0B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750069110; x=1750673910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1DLi6vp5y8h6K2KWNhVdnWG7ljY4swPvyYxCwuC3OY=;
 b=rg+1AbiP1gm7OcpaxHr3TIoNI5ofpMGJki5TPMSJ9Tl+Tm7mQGtfI94xMkbxm9IjeH
 nDZE9qvhHwh7fgkmWf51Piele9928nEeXofpxlxXcGOHU7WykUARDXX0heR7GGGCDJSt
 PbqO2GtOK2zZqXUCNsYTniA7t4QtbmJX0gY94OqU58JnifcmUf1qjgFGq/RKUlG/xZSn
 mnJdt4QnZatTFTyYJM6in+5r0wvisRc0gwOMU0ho2AgFVxr34Xm04+wkM878gQfUTZag
 y0MFMEyYUOHhgytltKtGFpJm0B6BjxSRhFyFBqdv1e0DA185/dQjyWgo1Dnrd74Mjgwn
 2uIg==
X-Gm-Message-State: AOJu0YygxwCXkz2/OUVQL6fwFtJa7ulb1Ej9Ypu9oPM0wdTevWZFlBE1
 Jq0ZG7A8OHc0+/VPkYNl+63axhJlrL3kum1ec4lpvbjuIX2SXYdlyeptxv0tcqzHJ1PdkTTbonp
 FSRueQmsqdNFAyWZv53KI6cWgY6MUZwkiLyDD+sWV5g==
X-Gm-Gg: ASbGncs44iV1TYkJcYHJ3li0OvZOl967qT4Wtwkzh3uwuV17khOZo0BtfJBr2U+m0Nx
 RCaLcXo1RyfeQuZt/pl3j7mnVdD+cNXRXBmZbb2heKHV6ZnuyAqUBkb6yckiXiT9UQ6WVcUXVfa
 dGqd355sY0ZqSaALkO6ZC7leNtE02lGxzmM4Lm2/1Dm9wK1KsrrXJn5Ig=
X-Google-Smtp-Source: AGHT+IEiG200rSFByo9g8Xe8M0bktoWDvHjMXGe7x09AjiP3xgkuoHidz5cjNcNz7PIw2Td5GgnWE2WGsaBndqXhoi0=
X-Received: by 2002:a05:690c:4d84:b0:70f:83ef:de07 with SMTP id
 00721157ae682-711754772abmr118538337b3.33.1750069109695; Mon, 16 Jun 2025
 03:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250612065624.751014-1-sughosh.ganu@linaro.org>
 <20250612065624.751014-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250612065624.751014-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 13:17:53 +0300
X-Gm-Features: AX0GCFuyObCAO9qrN6MBqZ_B-ofSE3Zo-tKpmNnN46YOnCHeSXDPlLzSOyhqPZE
Message-ID: <CAC_iWjL4=Lgwg9bvMdhet59w59M1ZxJ3TnaEuq8Kh7EaAv1MRA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

Thanks Sughosh

This is a nice cleanup, we only have lmb_alloc_mem() now right? (Apart
from the io_xxx versions)


On Thu, 12 Jun 2025 at 09:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> There currently are two API's for requesting memory from the LMB
> module, lmb_alloc() and lmb_alloc_base(). The function which does the
> actual allocation is the same. Use the earlier introduced API
> lmb_alloc_mem() for both types of allocation requests.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Cheers
/Ilias
> ---
> Changes since V3:
> * mach-apple: Check the return value of the lmb allocation API, and
>   set the env variables only when the API returns success
> * mach-snapdragon: Check the return value of the lmb allocation API,
>   and set the env variables only when the API returns success
>
>  arch/arm/mach-apple/board.c      | 27 ++++++++++++------
>  arch/arm/mach-snapdragon/board.c | 30 ++++++++++++-------
>  boot/bootm.c                     | 12 +++++---
>  boot/image-board.c               | 49 +++++++++++++++++---------------
>  boot/image-fdt.c                 | 35 +++++++++++++----------
>  include/lmb.h                    | 22 +++-----------
>  lib/efi_loader/efi_memory.c      | 14 +++++----
>  lib/lmb.c                        | 28 ++++++++----------
>  test/lib/lmb.c                   | 26 +++++++++++++++++
>  9 files changed, 141 insertions(+), 102 deletions(-)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 2604c5a710e..4cd8979bdc2 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -773,22 +773,31 @@ u64 get_page_table_size(void)
>
>  #define KERNEL_COMP_SIZE       SZ_128M
>
> +#define lmb_alloc(size, addr) lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
> +
>  int board_late_init(void)
>  {
>         u32 status = 0;
> +       phys_addr_t addr;
>
>         /* somewhat based on the Linux Kernel boot requirements:
>          * align by 2M and maximal FDT size 2M
>          */
> -       status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M));
> -       status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> -       status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M));
> -       status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M));
> -       status |= env_set_hex("kernel_comp_addr_r",
> -                             lmb_alloc(KERNEL_COMP_SIZE, SZ_2M));
> -       status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> -       status |= env_set_hex("scriptaddr", lmb_alloc(SZ_4M, SZ_2M));
> -       status |= env_set_hex("pxefile_addr_r", lmb_alloc(SZ_4M, SZ_2M));
> +       status |= !lmb_alloc(SZ_1G, &addr) ? env_set_hex("loadaddr", addr) : 1;
> +       status |= !lmb_alloc(SZ_2M, &addr) ?
> +               env_set_hex("fdt_addr_r", addr) : 1;
> +       status |= !lmb_alloc(SZ_128M, &addr) ?
> +               env_set_hex("kernel_addr_r", addr) : 1;
> +       status |= !lmb_alloc(SZ_1G, &addr) ?
> +               env_set_hex("ramdisk_addr_r", addr) : 1;
> +       status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
> +               env_set_hex("kernel_comp_addr_r", addr) : 1;
> +       status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
> +               env_set_hex("kernel_comp_size", addr) : 1;
> +       status |= !lmb_alloc(SZ_4M, &addr) ?
> +               env_set_hex("scriptaddr", addr) : 1;
> +       status |= !lmb_alloc(SZ_4M, &addr) ?
> +               env_set_hex("pxefile_addr_r", addr) : 1;
>
>         if (status)
>                 log_warning("late_init: Failed to set run time variables\n");
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5547d6d054f..87a173e0acb 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -492,7 +492,7 @@ void __weak qcom_late_init(void)
>  #define FASTBOOT_BUF_SIZE 0
>  #endif
>
> -#define addr_alloc(size) lmb_alloc(size, SZ_2M)
> +#define lmb_alloc(size, addr) lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
>
>  /* Stolen from arch/arm/mach-apple/board.c */
>  int board_late_init(void)
> @@ -502,18 +502,26 @@ int board_late_init(void)
>         struct fdt_header *fdt_blob = (struct fdt_header *)gd->fdt_blob;
>
>         /* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
> -       addr = addr_alloc(SZ_128M);
> +       status |= !lmb_alloc(SZ_128M, &addr) ?
> +               env_set_hex("loadaddr", addr) : 1;
>         status |= env_set_hex("kernel_addr_r", addr);
> -       status |= env_set_hex("loadaddr", addr);
> -       status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
> -       status |= env_set_hex("kernel_comp_addr_r", addr_alloc(KERNEL_COMP_SIZE));
> -       status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> +       status |= !lmb_alloc(SZ_128M, &addr) ?
> +               env_set_hex("ramdisk_addr_r", addr) : 1;
> +       status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
> +               env_set_hex("kernel_comp_addr_r", addr) : 1;
> +       status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
> +               env_set_hex("kernel_comp_size", addr) : 1;
> +       status |= !lmb_alloc(SZ_4M, &addr) ?
> +               env_set_hex("scriptaddr", addr) : 1;
> +       status |= !lmb_alloc(SZ_4M, &addr) ?
> +               env_set_hex("pxefile_addr_r", addr) : 1;
> +
>         if (IS_ENABLED(CONFIG_FASTBOOT))
> -               status |= env_set_hex("fastboot_addr_r", addr_alloc(FASTBOOT_BUF_SIZE));
> -       status |= env_set_hex("scriptaddr", addr_alloc(SZ_4M));
> -       status |= env_set_hex("pxefile_addr_r", addr_alloc(SZ_4M));
> -       addr = addr_alloc(SZ_2M);
> -       status |= env_set_hex("fdt_addr_r", addr);
> +               status |= !lmb_alloc(FASTBOOT_BUF_SIZE, &addr) ?
> +                       env_set_hex("fastboot_addr_r", addr) : 1;
> +
> +       status |= !lmb_alloc(SZ_2M, &addr) ?
> +               env_set_hex("fdt_addr_r", addr) : 1;
>
>         if (status)
>                 log_warning("%s: Failed to set run time variables\n", __func__);
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 3282bfc0b4b..4bdca22ea8c 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -623,12 +623,16 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>          */
>         if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
>                 ulong req_size = ALIGN(image_len * 4, SZ_1M);
> +               phys_addr_t addr;
>
> -               load = lmb_alloc(req_size, SZ_2M);
> -               if (!load)
> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
> +                                   req_size, LMB_NONE);
> +               if (err)
>                         return 1;
> -               os.load = load;
> -               images->ep = load;
> +
> +               load = (ulong)addr;
> +               os.load = (ulong)addr;
> +               images->ep = (ulong)addr;
>                 debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
>                       req_size, load, image_len);
>         }
> diff --git a/boot/image-board.c b/boot/image-board.c
> index b0fa028ceac..005d60caf5c 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -16,6 +16,7 @@
>  #include <fpga.h>
>  #include <image.h>
>  #include <init.h>
> +#include <lmb.h>
>  #include <log.h>
>  #include <mapmem.h>
>  #include <rtc.h>
> @@ -566,27 +567,24 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
>                         *initrd_start = rd_data;
>                         *initrd_end = rd_data + rd_len;
>                         initrd_addr = (phys_addr_t)rd_data;
> -                       err = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0,
> -                                           &initrd_addr, rd_len, LMB_NONE);
> +                       err = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &initrd_addr,
> +                                           rd_len, LMB_NONE);
>                         if (err) {
>                                 puts("in-place initrd alloc failed\n");
>                                 goto error;
>                         }
>                 } else {
> -                       if (initrd_high)
> -                               *initrd_start =
> -                                       (ulong)lmb_alloc_base(rd_len,
> -                                                                   0x1000,
> -                                                                   initrd_high,
> -                                                                   LMB_NONE);
> -                       else
> -                               *initrd_start = (ulong)lmb_alloc(rd_len,
> -                                                                0x1000);
> +                       enum lmb_mem_type type = initrd_high ?
> +                               LMB_MEM_ALLOC_MAX : LMB_MEM_ALLOC_ANY;
>
> -                       if (*initrd_start == 0) {
> +                       err = lmb_alloc_mem(type, 0x1000, &initrd_high, rd_len,
> +                                           LMB_NONE);
> +                       if (err) {
>                                 puts("ramdisk - allocation error\n");
>                                 goto error;
>                         }
> +
> +                       *initrd_start = (ulong)initrd_high;
>                         bootstage_mark(BOOTSTAGE_ID_COPY_RAMDISK);
>
>                         *initrd_end = *initrd_start + rd_len;
> @@ -837,9 +835,10 @@ int boot_get_loadable(struct bootm_headers *images)
>   */
>  int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
>  {
> -       int barg;
> +       int barg, err;
>         char *cmdline;
>         char *s;
> +       phys_addr_t addr;
>
>         /*
>          * Help the compiler detect that this function is only called when
> @@ -849,12 +848,14 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
>                 return 0;
>
>         barg = IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_BARGSIZE);
> -       cmdline = (char *)(ulong)lmb_alloc_base(barg, 0xf,
> -                               env_get_bootm_mapsize() + env_get_bootm_low(),
> -                               LMB_NONE);
> -       if (!cmdline)
> +       addr = env_get_bootm_mapsize() + env_get_bootm_low();
> +
> +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, 0xf, &addr, barg, LMB_NONE);
> +       if (err)
>                 return -1;
>
> +       cmdline = (char *)(uintptr_t)addr;
> +
>         s = env_get("bootargs");
>         if (!s)
>                 s = "";
> @@ -883,14 +884,16 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
>   */
>  int boot_get_kbd(struct bd_info **kbd)
>  {
> -       *kbd = (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd_info),
> -                                                            0xf,
> -                                                            env_get_bootm_mapsize() +
> -                                                            env_get_bootm_low(),
> -                                                            LMB_NONE);
> -       if (!*kbd)
> +       int err;
> +       phys_addr_t addr;
> +
> +       addr = env_get_bootm_mapsize() + env_get_bootm_low();
> +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, 0xf, &addr,
> +                           sizeof(struct bd_info), LMB_NONE);
> +       if (err)
>                 return -1;
>
> +       *kbd = (struct bd_info *)(uintptr_t)addr;
>         **kbd = *gd->bd;
>
>         debug("## kernel board info at 0x%08lx\n", (ulong)*kbd);
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index bd5a6231140..2720ce6f6f3 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -183,9 +183,9 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
>         /* If fdt_high is set use it to select the relocation address */
>         fdt_high = env_get("fdt_high");
>         if (fdt_high) {
> -               ulong desired_addr = hextoul(fdt_high, NULL);
> +               ulong high_addr = hextoul(fdt_high, NULL);
>
> -               if (desired_addr == ~0UL) {
> +               if (high_addr == ~0UL) {
>                         /* All ones means use fdt in place */
>                         of_start = fdt_blob;
>                         addr = map_to_sysmem(fdt_blob);
> @@ -198,16 +198,17 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
>                         }
>
>                         disable_relocation = 1;
> -               } else if (desired_addr) {
> -                       addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
> -                                             LMB_NONE);
> -                       of_start = map_sysmem(addr, of_len);
> -                       if (of_start == NULL) {
> -                               puts("Failed using fdt_high value for Device Tree");
> +               } else {
> +                       enum lmb_mem_type type = high_addr ?
> +                               LMB_MEM_ALLOC_MAX : LMB_MEM_ALLOC_ANY;
> +
> +                       addr = high_addr;
> +                       err = lmb_alloc_mem(type, 0x1000, &addr, of_len,
> +                                           LMB_NONE);
> +                       if (err) {
> +                               puts("Failed to allocate memory for Device Tree relocation\n");
>                                 goto error;
>                         }
> -               } else {
> -                       addr = lmb_alloc(of_len, 0x1000);
>                         of_start = map_sysmem(addr, of_len);
>                 }
>         } else {
> @@ -229,11 +230,15 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
>                          * for LMB allocation.
>                          */
>                         usable = min(start + size, low + mapsize);
> -                       addr = lmb_alloc_base(of_len, 0x1000, usable, LMB_NONE);
> -                       of_start = map_sysmem(addr, of_len);
> -                       /* Allocation succeeded, use this block. */
> -                       if (of_start != NULL)
> -                               break;
> +                       addr = usable;
> +                       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, 0x1000,
> +                                           &addr, of_len, LMB_NONE);
> +                       if (!err) {
> +                               of_start = map_sysmem(addr, of_len);
> +                               /* Allocation succeeded, use this block. */
> +                               if (of_start)
> +                                       break;
> +                       }
>
>                         /*
>                          * Reduce the mapping size in the next bank
> diff --git a/include/lmb.h b/include/lmb.h
> index 8906b42181f..34dbc25759d 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -34,9 +34,13 @@
>  /**
>   * enum lmb_mem_type - type of memory allocation request
>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> + * @LMB_MEM_ALLOC_ANY: allocate any available memory region
> + * @LMB_MEM_ALLOC_MAX: allocate memory below a particular address
>   */
>  enum lmb_mem_type {
>         LMB_MEM_ALLOC_ADDR = 1,
> +       LMB_MEM_ALLOC_ANY,
> +       LMB_MEM_ALLOC_MAX,
>  };
>
>  /**
> @@ -130,26 +134,8 @@ void lmb_add_memory(void);
>
>  long lmb_add(phys_addr_t base, phys_size_t size);
>
> -phys_addr_t lmb_alloc(phys_size_t size, ulong align);
>  phys_size_t lmb_get_free_size(phys_addr_t addr);
>
> -/**
> - * lmb_alloc_base() - Allocate specified memory region with specified
> - *                         attributes
> - * @size: Size of the region requested
> - * @align: Alignment of the memory region requested
> - * @max_addr: Maximum address of the requested region
> - * @flags: Memory region attributes to be set
> - *
> - * Allocate a region of memory with the attributes specified through the
> - * parameter. The max_addr parameter is used to specify the maximum address
> - * below which the requested region should be allocated.
> - *
> - * Return: Base address on success, 0 on error.
> - */
> -phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
> -                          uint flags);
> -
>  /**
>   * lmb_is_reserved_flags() - Test if address is in reserved region with flag
>   *                          bits set
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 77950a267cc..466f45c98b1 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -454,6 +454,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>                                 enum efi_memory_type memory_type,
>                                 efi_uintn_t pages, uint64_t *memory)
>  {
> +       int err;
>         u64 efi_addr, len;
>         uint flags;
>         efi_status_t ret;
> @@ -475,17 +476,18 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>         switch (type) {
>         case EFI_ALLOCATE_ANY_PAGES:
>                 /* Any page */
> -               addr = (u64)lmb_alloc_base(len, EFI_PAGE_SIZE,
> -                                                LMB_ALLOC_ANYWHERE, flags);
> -               if (!addr)
> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
> +                                   len, flags);
> +               if (err)
>                         return EFI_OUT_OF_RESOURCES;
>                 break;
>         case EFI_ALLOCATE_MAX_ADDRESS:
>                 /* Max address */
>                 addr = map_to_sysmem((void *)(uintptr_t)*memory);
> -               addr = (u64)lmb_alloc_base(len, EFI_PAGE_SIZE, addr,
> -                                                flags);
> -               if (!addr)
> +
> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
> +                                   len, flags);
> +               if (err)
>                         return EFI_OUT_OF_RESOURCES;
>                 break;
>         case EFI_ALLOCATE_ADDRESS:
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 72d4edacff0..29603335f66 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -672,16 +672,18 @@ long lmb_free(phys_addr_t base, phys_size_t size)
>         return lmb_free_flags(base, size, LMB_NONE);
>  }
>
> -static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
> -                                  phys_addr_t max_addr, u32 flags)
> +static int _lmb_alloc_base(phys_size_t size, ulong align,
> +                          phys_addr_t *addr, u32 flags)
>  {
>         int ret;
>         long i, rgn;
> +       phys_addr_t max_addr;
>         phys_addr_t base = 0;
>         phys_addr_t res_base;
>         struct lmb_region *lmb_used = lmb.used_mem.data;
>         struct lmb_region *lmb_memory = lmb.available_mem.data;
>
> +       max_addr = *addr;
>         for (i = lmb.available_mem.count - 1; i >= 0; i--) {
>                 phys_addr_t lmbbase = lmb_memory[i].base;
>                 phys_size_t lmbsize = lmb_memory[i].size;
> @@ -714,8 +716,8 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>                                                             flags);
>                                 if (ret)
>                                         return ret;
> -
> -                               return base;
> +                               *addr = base;
> +                               return 0;
>                         }
>
>                         res_base = lmb_used[rgn].base;
> @@ -728,18 +730,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>         log_debug("%s: Failed to allocate 0x%lx bytes below 0x%lx\n",
>                   __func__, (ulong)size, (ulong)max_addr);
>
> -       return 0;
> -}
> -
> -phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> -{
> -       return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
> -}
> -
> -phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
> -                          uint flags)
> -{
> -       return _lmb_alloc_base(size, align, max_addr, flags);
> +       return -1;
>  }
>
>  static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
> @@ -778,6 +769,11 @@ int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
>                 return -EINVAL;
>
>         switch (type) {
> +       case LMB_MEM_ALLOC_ANY:
> +               *addr = LMB_ALLOC_ANYWHERE;
> +       case LMB_MEM_ALLOC_MAX:
> +               ret = _lmb_alloc_base(size, align, addr, flags);
> +               break;
>         case LMB_MEM_ALLOC_ADDR:
>                 ret = _lmb_alloc_addr(*addr, size, flags);
>                 break;
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 751909fc2cf..d8eab96527a 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -82,6 +82,32 @@ static int lmb_reserve(phys_addr_t addr, phys_size_t size, u32 flags)
>         return 0;
>  }
>
> +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> +{
> +       int err;
> +       phys_addr_t addr;
> +
> +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> +       if (err)
> +               return 0;
> +
> +       return addr;
> +}
> +
> +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> +                                 phys_addr_t max_addr, u32 flags)
> +{
> +       int err;
> +       phys_addr_t addr;
> +
> +       addr = max_addr;
> +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> +       if (err)
> +               return 0;
> +
> +       return addr;
> +}
> +
>  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
>
>  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> --
> 2.34.1
>
