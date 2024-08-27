Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE4CC5320E
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 06:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69EE8891B;
	Tue, 27 Aug 2024 08:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mL/3bmqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CB187C80; Tue, 27 Aug 2024 08:26:55 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0A9887F3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-202318c4f45so52363545ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724740012; x=1725344812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kT3FW5S0qGxL46Aq6SUXImxuiMgzskTRGcAnZFUqEm0=;
 b=mL/3bmqsSmRq0+D0ez0Sqq2QGb21WLNh6dp3EadALG0Zz1/ioWcAynVXfhyJsw78MX
 J3v9fr7gUoPnCgIPjbRwHN+WIph9xhVHQvlki2Kv5SlcFxyWce/JwtaC5DqnDos1TdK3
 FiipgvSnWUoQcQot6mQdqejKjOGc5qGvFfR6QxpCsT9m62mFMcCswzTp4m7dgi91XR/u
 DWgHd1fWE0aWVNZiwkQuT8lkAoau9I83BsmieS8zVKSVgqmEQmI6NjiWx76Y1DJnNrrr
 fGkbU2WG0Xipk4Ij2/T+dfsJMqVetuBvWO14f3tvoeKSRrW/9lH/WjAVQv/L/vd4ZvvQ
 nwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724740012; x=1725344812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kT3FW5S0qGxL46Aq6SUXImxuiMgzskTRGcAnZFUqEm0=;
 b=Rmf65RfG9qY5eqyKJdrq5aUZPLJju60Aw6zp/ClqcfplzEJnHTTUiOgx+cOKL5s8YD
 Ih6UEfhdVVJtaghME1ZZLbqyR4/C5ZtBePv7oQKhnmF1mqliocyqOxpXhU/UF9Rph+7g
 8sY8G7w2C6ivgoiBWpShcMkyc90QcsGE1xMRZAUbEsL0WhwOaiT1EvIKpUNWUGuGot8M
 xM7ygLRbgQyRJuDQILdQ2+ugLegqWh8EzeOH4ZSJ6iIxa4jF0FKqKI2QRtnCITme+7OW
 osR6fNirX9hXEzPJllQmH+dG3dtV36fwjaMxATQ9s9C6d03i8/tB2Z/stpMvWw/hcx6a
 MbvA==
X-Gm-Message-State: AOJu0YyEI0ruhfUn/0sPgXXbJcMnlRCgyWywITik6bOmu6CXdbz8N/oi
 k6CHoB/PDIf/uBBFhlzVVPwhU1vmcHLMI3ZgnAERDSuW0pWn0UWik6nO2gNncg5Ah7shIo6QMYP
 Kod3Milhb/dooeTCC+2szPd6TcWzFbwfWAxRcKA==
X-Google-Smtp-Source: AGHT+IHzbZsMMmPbYlzZ7cNOYYa/1Tb+nfKSrLwXqbGjpUvoS8206RQEcJp5JfOEiOj0Cg5hbrGChcDPTpem4q9reko=
X-Received: by 2002:a17:903:1cc:b0:202:2d03:b699 with SMTP id
 d9443c01a7336-204df45e130mr16095485ad.26.1724740011916; Mon, 26 Aug 2024
 23:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-13-sughosh.ganu@linaro.org>
In-Reply-To: <20240826115940.3233167-13-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Aug 2024 09:26:15 +0300
Message-ID: <CAC_iWjKCdDpeURp2NsqA0r-WVG-otW7c7FpfeQJsX-pSS_VodQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/27] lmb: remove the lmb_init_and_reserve() function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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

On Mon, 26 Aug 2024 at 15:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the changes to make the LMB reservations persistent, the common
> memory regions are being added during board init. Remove the
> now superfluous lmb_init_and_reserve() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since V3: None
>
>  arch/arm/mach-apple/board.c          |  2 --
>  arch/arm/mach-snapdragon/board.c     |  2 --
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |  3 ---
>  cmd/bdinfo.c                         |  1 -
>  cmd/load.c                           |  2 --
>  fs/fs.c                              |  1 -
>  include/lmb.h                        |  1 -
>  lib/lmb.c                            | 13 -------------
>  net/tftp.c                           |  2 --
>  net/wget.c                           |  2 --
>  10 files changed, 29 deletions(-)
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
> index 56da3a4c5d..20d802502a 100644
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
> diff --git a/include/lmb.h b/include/lmb.h
> index 70191456e5..04558724a7 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -63,7 +63,6 @@ struct lmb {
>   */
>  int lmb_init(void);
>
> -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
>  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
>                                 void *fdt_blob);
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 9b1854223d..de4d0d1803 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -227,19 +227,6 @@ static void lmb_reserve_common(void *fdt_blob)
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
>  /* Initialize the struct, add memory and call arch/board reserve functions */
>  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
>                                 void *fdt_blob)
> diff --git a/net/tftp.c b/net/tftp.c
> index 99b2ab9fca..b5d227d8bc 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -718,8 +718,6 @@ static int tftp_init_load_addr(void)
>         if (CONFIG_IS_ENABLED(LMB)) {
>                 phys_size_t max_size;
>
> -               lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> -
>                 max_size = lmb_get_free_size(image_load_addr);
>                 if (!max_size)
>                         return -1;
> diff --git a/net/wget.c b/net/wget.c
> index 241465b9b4..4a168641c6 100644
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
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
