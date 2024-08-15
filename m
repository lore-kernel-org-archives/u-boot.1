Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A6C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1478588A54;
	Thu, 15 Aug 2024 22:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E3RLGGva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C99B88A54; Thu, 15 Aug 2024 22:34:03 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3607C88107
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d3da94f059so393506a91.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754039; x=1724358839; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rEguaZwMVzWxttRDTmEofjHBs07oPOTVCrwxRfm6GAw=;
 b=E3RLGGvaoG3vrwxtR2kKD5KkTdh1VyIJ5jz3q6ES22on5fhX1oFbdnzzbc0/TgkANB
 N6yj6d1dGOTD8sE+P8jvVyxAgdocpXbKVaxIA3fEPlBOmqE3U7bttCYbatRULvHvSX0P
 YTRK6W1iMJ3q4/FiO8iPBhH/+4pE7QUGe65hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754039; x=1724358839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rEguaZwMVzWxttRDTmEofjHBs07oPOTVCrwxRfm6GAw=;
 b=dnjAIo/TZN5EWJsIUKsdiQYXzsJiGJm7Oc7uOgCN0xS4LqKO7GoDuWsXq1X4FSA3UY
 I+l6lbAqrOBF2M8dM8jMW/eKiQYWLBWaXyoTmLpBnitAOYNhvKagh6O2VMSqOFbLKCE1
 iVR6hq0Bm3TVCmma4UIwpy+p4a/VH/W/8bDDrD+1cYWFjIQa/btD0gNMdhllZixxoH40
 z7biYwQzsG+ENNdt7qCxQjG19iMnNht0UV5O53BDGH+Az5/pZ406uJrI1CcoVcnEo1a4
 1m6LxeqUSFs8a/8XnJJ4OTS/Pdz8tpmPHt/0kmsrGVqNfazvsSCMvO14wbNKXu+c6tLt
 p8rw==
X-Gm-Message-State: AOJu0YyiNZWxntNERxnla9MGUgwAS5EdVxjbWqMeBYXgQSww97dWw/RO
 xLVDSu7VgsHO7xsrylJ1Fw9oDVAGvzfZBi4WfCpx9m68K4qaOOo8nrKX6r+Tvk5I4anAhaKmAQ2
 ImipttMO604dADfR3wwIAgljuQMP6KSFwi7I7
X-Google-Smtp-Source: AGHT+IFlFN/lQ9nSjkK+k5RqU0vrPhhkXPF0J8CYRf5tM6hNIk+FT3oCredkR1jvFW+BNP2KRJUb0ziuvRXka09NFlQ=
X-Received: by 2002:a17:90a:ce11:b0:2d1:b36c:6bc1 with SMTP id
 98e67ed59e1d1-2d3dfdaaed9mr893013a91.2.1723754039512; Thu, 15 Aug 2024
 13:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-12-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-12-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:48 +0100
Message-ID: <CAFLszTha3Wo7O4=e+pLz5BtosCUai2+DKRfJNQTMUdPO97v1Rw@mail.gmail.com>
Subject: Re: [PATCH v2 11/32] lmb: allow lmb module to be used in SPL
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the introduction of separate config symbols for the SPL phase of
> U-Boot, the condition checks need to be tweaked so that platforms that
> enable the LMB module in SPL are also able to call the LMB API's. Use
> the appropriate condition checks to achieve this.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  board/xilinx/common/board.c |  2 +-
>  boot/bootm.c                |  4 ++--
>  boot/image-board.c          |  2 +-
>  fs/fs.c                     |  4 ++--
>  lib/Makefile                |  2 +-
>  net/tftp.c                  | 40 ++++++++++++++++++-------------------
>  net/wget.c                  |  4 ++--
>  7 files changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

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
> index d47feddb9b..e244b9b410 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -239,7 +239,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
>         return 0;
>  }
>
> -#ifdef CONFIG_LMB
> +#if CONFIG_IS_ENABLED(LMB)
>  static void boot_start_lmb(void)
>  {
>         phys_addr_t     mem_start;
> @@ -1036,7 +1036,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
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

This needs to be $(SPL_TPL_) so that it doesn't accidentally get enabled in TPL.

>  obj-y += membuff.o
>  obj-$(CONFIG_REGEX) += slre.o
>  obj-y += string.o
> diff --git a/net/tftp.c b/net/tftp.c
> index c0a6210b9d..99b2ab9fca 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -82,9 +82,7 @@ static ulong  tftp_block_wrap;
>  static ulong   tftp_block_wrap_offset;
>  static int     tftp_state;
>  static ulong   tftp_load_addr;
> -#ifdef CONFIG_LMB
>  static ulong   tftp_load_size;
> -#endif
>  #ifdef CONFIG_TFTP_TSIZE
>  /* The file size reported by the server */
>  static int     tftp_tsize;
> @@ -160,19 +158,20 @@ static inline int store_block(int block, uchar *src, unsigned int len)
>         ulong store_addr = tftp_load_addr + offset;
>         void *ptr;
>

[..]

Regards,
Simon
