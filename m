Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8CDC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6AF88804;
	Sat, 13 Jul 2024 17:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CUadOuH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6748887DDF; Sat, 13 Jul 2024 17:15:50 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C481888FC
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c9a8313984so2383284a91.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883746; x=1721488546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jawvNGfNYmIgcvXAVnLHGSsvEgHjAp8LJhh2VgtL6hE=;
 b=CUadOuH2va/2bX+wnmRgaKNASi3vea+3YWSjErHTGAhELf1yZRP8ys/6oFPM9vKuyV
 uaRXE1qER2DmNNfp1sGKpB3HAG1y034+tU+fPtrohZzZ8+LNctpW8gBuRnS2wkud73qc
 xN/cTd/MplyPKIAzVSWcahgpxO9NkGpgNtqVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883746; x=1721488546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jawvNGfNYmIgcvXAVnLHGSsvEgHjAp8LJhh2VgtL6hE=;
 b=JxOqorBS3je0bHmbTCzdka7/w9SIyZogJwxYNiq1z03aJXuZX8r4b5NhKOPYTqxnKc
 TfbfhRse9Id+MtuqKSOfuIN6X/agEQfeLRRNcuZSpqFeW2kkMRren/BhQsMjghe7cksk
 wo8CvVk0jFh+UPDsOt+xZrrIrVSIFt5xlrHFe65krMAZwTrUifBrSeb25ldIoPMKVW4z
 rXD5MSQYa2ZyXQzhc7QudGuQsVwruJs5dCv1EKKnxWraaNuHzyGp/nq9j/Y9Q8jwoPKD
 RjJABNEJzGqwsPYmOzQUd/oP3QdBNvvYHIPF5GU5iCzMsUYhNk+jXw1HkYJBRB6hI1z3
 OC1g==
X-Gm-Message-State: AOJu0Yx1MAFByQWmHYoOzIUGA3WPOv4QaSrPRJ1HS14jl8JOi3+TG/Oa
 iCkBjL4RPPiHRUkhB//hxf5+hk3OIFrq1OMMR4cwQBb3VLClpPRw2w8aZT3njNn71nwZtiQWyPA
 fZTDdJG8s5ofv2u+dgopLFIMCMksa10ujk07R
X-Google-Smtp-Source: AGHT+IFW/9iWAYxkoboP9MeIBgaWpZtEKXDMEkeJFU9o69ofEp1aUBLCF/RU/SLS5osPF8QaeCIfWNwXD6KAFVMh7Mo=
X-Received: by 2002:a17:90a:bf0f:b0:2c9:84f9:a321 with SMTP id
 98e67ed59e1d1-2ca35c6894amr13622777a91.23.1720883746629; Sat, 13 Jul 2024
 08:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-18-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-18-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:30 +0100
Message-ID: <CAFLszTiaskAronpTqPEeTcizbOj6YoPi0WZsVT29ZwH09iuP_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/48] lmb: allow lmb module to be used in SPL
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sughosh,

On Thu, 4 Jul 2024 at 08:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the introduction of separate config symbols for the SPL phase of
> U-Boot, the condition checks need to be tweaked so that platforms that
> enable the LMB module in SPL are also able to call the LMB API's. Use
> the appropriate condition checks to achieve this.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  board/xilinx/common/board.c | 2 +-
>  boot/bootm.c                | 4 ++--
>  boot/image-board.c          | 2 +-
>  fs/fs.c                     | 4 ++--
>  lib/Makefile                | 2 +-
>  net/tftp.c                  | 6 +++---
>  net/wget.c                  | 4 ++--
>  7 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 4056884400..f04c92a70f 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -665,7 +665,7 @@ int embedded_dtb_select(void)
>  }
>  #endif
>
> -#if defined(CONFIG_LMB)
> +#if IS_ENABLED(CONFIG_LMB)
>
>  #ifndef MMU_SECTION_SIZE
>  #define MMU_SECTION_SIZE        (1 * 1024 * 1024)
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 7b3fe551de..5ce84b73b5 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -239,7 +239,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
>         return 0;
>  }
>
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)

Can you avoid #ifdefs where possible?

>  static void boot_start_lmb(void)
>  {
>         phys_addr_t     mem_start;
> @@ -1048,7 +1048,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
>                 }
>         }
>  #endif
> -#if CONFIG_IS_ENABLED(OF_LIBFDT) && defined(CONFIG_LMB)
> +#if CONFIG_IS_ENABLED(OF_LIBFDT) && CONFIG_IS_ENABLED(LMB)
>         if (!ret && (states & BOOTM_STATE_FDT)) {
>                 boot_fdt_add_mem_rsv_regions(images->ft_addr);
>                 ret = boot_relocate_fdt(&images->ft_addr, &images->ft_len);
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 1f8c1ac69f..99ee7968ba 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -883,7 +883,7 @@ int image_setup_linux(struct bootm_headers *images)
>         int ret;
>
>         /* This function cannot be called without lmb support */
> -       if (!IS_ENABLED(CONFIG_LMB))
> +       if (!CONFIG_IS_ENABLED(LMB))
>                 return -EFAULT;
>         if (CONFIG_IS_ENABLED(OF_LIBFDT))
>                 boot_fdt_add_mem_rsv_regions(*of_flat_tree);
> diff --git a/fs/fs.c b/fs/fs.c
> index 2c835eef86..3fb00590be 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -526,7 +526,7 @@ int fs_size(const char *filename, loff_t *size)
>         return ret;
>  }
>
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)
>  /* Check if a file may be read to the given address */
>  static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
>                              loff_t len, struct fstype_info *info)
> @@ -567,7 +567,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>         void *buf;
>         int ret;
>
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)
>         if (do_lmb_check) {
>                 ret = fs_read_lmb_check(filename, addr, offset, len, info);
>                 if (ret)
> diff --git a/lib/Makefile b/lib/Makefile
> index 81b503ab52..398c11726e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -118,7 +118,7 @@ obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdtdec.o fdtdec_common.o
>  obj-y += hang.o
>  obj-y += linux_compat.o
>  obj-y += linux_string.o
> -obj-$(CONFIG_LMB) += lmb.o
> +obj-$(CONFIG_$(SPL_)LMB) += lmb.o
>  obj-y += membuff.o
>  obj-$(CONFIG_REGEX) += slre.o
>  obj-y += string.o
> diff --git a/net/tftp.c b/net/tftp.c
> index 5e27fd4aa9..5c75d9d04f 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -82,7 +82,7 @@ static ulong  tftp_block_wrap;
>  static ulong   tftp_block_wrap_offset;
>  static int     tftp_state;
>  static ulong   tftp_load_addr;
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)
>  static ulong   tftp_load_size;
>  #endif
>  #ifdef CONFIG_TFTP_TSIZE
> @@ -160,7 +160,7 @@ static inline int store_block(int block, uchar *src, unsigned int len)
>         ulong store_addr = tftp_load_addr + offset;
>         void *ptr;
>
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)
>         ulong end_addr = tftp_load_addr + tftp_load_size;
>
>         if (!end_addr)
> @@ -710,7 +710,7 @@ static void tftp_timeout_handler(void)
>  /* Initialize tftp_load_addr and tftp_load_size from image_load_addr and lmb */
>  static int tftp_init_load_addr(void)
>  {
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)

here too

>         phys_size_t max_size;
>
>         lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> diff --git a/net/wget.c b/net/wget.c
> index 7cf809a8ef..b8ea43e7f0 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -98,7 +98,7 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>         ulong newsize = offset + len;
>         uchar *ptr;
>
> -       if (IS_ENABLED(CONFIG_LMB)) {
> +       if (CONFIG_IS_ENABLED(LMB)) {
>                 ulong end_addr = image_load_addr + wget_load_size;
>
>                 if (!end_addr)
> @@ -496,7 +496,7 @@ void wget_start(void)
>         debug_cond(DEBUG_WGET,
>                    "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
>
> -       if (IS_ENABLED(CONFIG_LMB)) {
> +       if (CONFIG_IS_ENABLED(LMB)) {
>                 if (wget_init_load_size()) {
>                         printf("\nwget error: ");
>                         printf("trying to overwrite reserved memory...\n");
> --
> 2.34.1
>

Regards,
Simon
