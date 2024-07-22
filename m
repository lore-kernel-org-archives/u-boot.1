Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC9C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D8E88005;
	Mon, 22 Jul 2024 14:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FHuvN8jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29F687EFA; Mon, 22 Jul 2024 14:28:04 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF5A88005
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb6662ba3aso2449616a91.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721651280; x=1722256080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4YK+pKD083tx6ByAaphhGeoeWbTylc7H1V6pxt29Tg4=;
 b=FHuvN8jzyFZ3hhprh0Y0qfly4DFf/Qh3+VtpLsm/+of/YcZJL8D2mvvoPM4dUp3hfY
 MJLYyxA6JznSS0omWOcRhD/9Tn5EkmQUG37eISMcBkEBd0fcjkt6/JrjyV/acTO+mlej
 4Lehvn1A0v6EgpKhjoQ8uZ2D/dyD1NQCKXSD2wY8m60czvOkQdjcc26zpfFI4sFeIez5
 8A4qWr/1Aj30bfKvq8NVoNNEHwbpONlFD7ue7KU033nTZ4eUU6vsau3jqyStiaiksB7+
 U5GdL2zfLkdZaVL+w3LJANMsxBcc3vJlwWy3FQuNYRjiutek6NYkSpsvLTv7qlZGB8l/
 VgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721651280; x=1722256080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YK+pKD083tx6ByAaphhGeoeWbTylc7H1V6pxt29Tg4=;
 b=ojhckYEjOWPnb7Qyb2ckBHlTvFMMmyv3P5Ev2fC8gcX3S1zX2MUF/sPCOMOrEhnTNe
 SXJNQODgy4EAMD62gVdRTWMzzNCsxhOKTBnT+YgVdw7FfgALB1jwY7XF5irqjxjn2o3g
 naSwlsfVyOXYvMgh0fDNLe/F9Zbgb92WBeC/FBNkBy3An7AgHdlLSgQgFBxK2lz18wd4
 jh5Jw69UQQNYJffcBC2srmI5aDV+sXgk/Vq2Rlq/dvhf0SeasA3bJlgFGn0MjKv7fmxp
 rr0Q7LUjK9oHXlitKaVR9+JPRDpMDSw++zBkJqi6aNjvxBGMz2mIlMCmXDUmSjQfGH97
 slCw==
X-Gm-Message-State: AOJu0YznMmHyhrN4MVnxLlGGXCQJA6MuMYFUqxEF0C17X5tfoCIIAbPg
 4hADw6BOdF/vebK2Zvw2wSkJS/K5yHGn4LnfFpFPFZdJ0sIiQ9e/KhYWqDJYKD7G4uezgnOWsZf
 4cbFzjYoGAo3LiMAHo7/d1z4xZz7JduWIuvyMcg==
X-Google-Smtp-Source: AGHT+IHX5tQQBFT+yij4MEO1UY9iuXwHS3gyrGjBSa6nD2hfjNmhJprL5d+QU7w74+rWLyevMmX8YK8cGvlVNlHN9gc=
X-Received: by 2002:a17:90a:e997:b0:2c9:35a6:e185 with SMTP id
 98e67ed59e1d1-2cb76b8789bmr18702296a91.0.1721651279930; Mon, 22 Jul 2024
 05:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-20-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-20-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 15:27:23 +0300
Message-ID: <CAC_iWjJurcnQ_N8f364TCNg9TMJDMUv5NazcOk3ShUpZpeai6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 19/48] lmb: remove the lmb_init_and_reserve()
 function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 10:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the changes to make the LMB reservations persistent, the common
> memory regions are being added during board init. Remove the
> now superfluous lmb_init_and_reserve() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Removed the replacement of lmb_init_and_reserve() with
>   lmb_add_memory(), as memory gets added during board init.
>
>  arch/arm/mach-apple/board.c          |  2 --
>  arch/arm/mach-snapdragon/board.c     |  2 --
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |  3 ---
>  cmd/bdinfo.c                         |  1 -
>  cmd/load.c                           |  2 --
>  fs/fs.c                              |  1 -
>  lib/lmb.c                            | 13 -------------
>  net/tftp.c                           |  2 --
>  net/wget.c                           |  2 --
>  test/cmd/bdinfo.c                    |  9 ---------
>  10 files changed, 37 deletions(-)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 213390d6e8..0b6d290b8a 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -775,8 +775,6 @@ int board_late_init(void)
>  {
>         u32 status = 0;
>
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>         /* somewhat based on the Linux Kernel boot requirements:
>          * align by 2M and maximal FDT size 2M
>          */
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index a63c8bec45..22a7d2a637 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -282,8 +282,6 @@ int board_late_init(void)
>  {
>         u32 status = 0;
>
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>         /* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
>         status |= env_set_hex("kernel_addr_r", addr_alloc(SZ_128M));
>         status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> index a913737342..64480da9f8 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> @@ -141,9 +141,6 @@ int mach_cpu_init(void)
>
>  void enable_caches(void)
>  {
> -       /* parse device tree when data cache is still activated */
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>         /* I-cache is already enabled in start.S: icache_enable() not needed */
>
>         /* deactivate the data cache, early enabled in arch_cpu_init() */
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index b31e0208df..3c40dee143 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -162,7 +162,6 @@ static int bdinfo_print_all(struct bd_info *bd)
>         bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
>  #endif
>         if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
> -               lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
>                 lmb_dump_all_force();
>                 if (IS_ENABLED(CONFIG_OF_REAL))
>                         printf("devicetree  = %s\n", fdtdec_get_srcname());
> diff --git a/cmd/load.c b/cmd/load.c
> index b4e747f966..29cc98ff37 100644
> --- a/cmd/load.c
> +++ b/cmd/load.c
> @@ -153,8 +153,6 @@ static ulong load_serial(long offset)
>         int     line_count =  0;
>         long ret;
>
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>         while (read_record(record, SREC_MAXRECLEN + 1) >= 0) {
>                 type = srec_decode(record, &binlen, &addr, binbuf);
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 3fb00590be..4bc28d1dff 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -549,7 +549,6 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
>         if (len && len < read_len)
>                 read_len = len;
>
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
>         lmb_dump_all();
>
>         if (lmb_alloc_addr(addr, read_len) == addr)
> diff --git a/lib/lmb.c b/lib/lmb.c
> index e4733b82ac..e1dde14a3c 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -226,19 +226,6 @@ static void lmb_reserve_common(void *fdt_blob)
>                 efi_lmb_reserve();
>  }
>
> -/* Initialize the struct, add memory and call arch/board reserve functions */
> -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
> -{
> -       int i;
> -
> -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -               if (bd->bi_dram[i].size)
> -                       lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
> -       }
> -
> -       lmb_reserve_common(fdt_blob);
> -}
> -
>  /**
>   * lmb_add_memory() - Add memory range for LMB allocations
>   *
> diff --git a/net/tftp.c b/net/tftp.c
> index 5c75d9d04f..dfbc620c73 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -713,8 +713,6 @@ static int tftp_init_load_addr(void)
>  #if CONFIG_IS_ENABLED(LMB)
>         phys_size_t max_size;
>
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>         max_size = lmb_get_free_size(image_load_addr);
>         if (!max_size)
>                 return -1;
> diff --git a/net/wget.c b/net/wget.c
> index b8ea43e7f0..82a7e30ea7 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -75,8 +75,6 @@ static int wget_init_load_size(void)
>  {
>         phys_size_t max_size;
>
> -       lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>         max_size = lmb_get_free_size(image_load_addr);
>         if (!max_size)
>                 return -1;
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 34d2b141d8..1cd81a195b 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -113,14 +113,6 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
>                 end = base + size - 1;
>                 flags = rgn->region[i].flags;
>
> -               /*
> -                * this entry includes the stack (get_sp()) on many platforms
> -                * so will different each time lmb_init_and_reserve() is called.
> -                * We could instead have the bdinfo command put its lmb region
> -                * in a known location, so we can check it directly, rather than
> -                * calling lmb_init_and_reserve() to create a new (and hopefully
> -                * identical one). But for now this seems good enough.
> -                */
>                 if (!IS_ENABLED(CONFIG_SANDBOX) && i == 3) {
>                         ut_assert_nextlinen(" %s[%d]\t[", name, i);
>                         continue;
> @@ -200,7 +192,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
>         if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
>                 struct lmb lmb;
>
> -               lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
>                 ut_assertok(lmb_test_dump_all(uts, &lmb));
>                 if (IS_ENABLED(CONFIG_OF_REAL))
>                         ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
