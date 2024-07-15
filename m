Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A00BC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9891D87F9F;
	Mon, 15 Jul 2024 11:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q8xNdRNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88B6887CB; Mon, 15 Jul 2024 11:24:17 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7D787F9F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6c4so5224120a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721035455; x=1721640255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NX2W7wEPMNfBBH23mRlOdu7CHF1NBNsM76Xxr3p+Wow=;
 b=q8xNdRNfQUfIgnWn35ZTx4slTNreo4Oo15HlkQDbPexZyJfhrviXea1E6eKlYpuOvh
 0IfjLEczZ/EBqroiEqJjMrLCx6EiXiuYSxAcHD9OaS1axfB7gfdC+SVFlySaZNKhKlEQ
 suPZ8JnMqiJ/6J5oue0jmfd3ru5cibklQrtYNN4KIgWFtFAZsPjWs2fK24X619d5iwYf
 E7dVLGccGD/rgX1mEPWVt1oeTc3aAhajlGY/2WgaLE7uirUUwhOtebyba/UZkYw9SuUX
 VjyZ4CkF0oxAli2FxsP8GHMTcRnzTXweWDuJ3A/mFEZ0VXvINTzxqd596vJ1ry+HRiRk
 +INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721035455; x=1721640255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NX2W7wEPMNfBBH23mRlOdu7CHF1NBNsM76Xxr3p+Wow=;
 b=lJMLWhR9Dl3WcrgsePDCS3VYbY0eWz6sxc/dC/an2w4LDHj2SeDppIAmGaqYHs/h4M
 E+eD9U88d9kbtaLS33pTvoswbopIkthW10P61R9WhH9B7EaiqVzTk8aExSPlOK4MAEPN
 mj5IMjYIItNSA4pYiA1xCIRGvlnIgYrQFrZZlWrr3IcKZspHqmiQRE5I7FBi5ZUlj0s8
 JBIB7jKKkTdXfkWzhXOBkvlXTJADgHd4Zi/Us+/Oprm7l+8x/izrz5VdWxwxgVoXosYh
 CIVYM8+riChvmer7svSyddblzYEv0i9rjX7wMuP7WeENR16Vi6EqQn2smC6aIsSD0eol
 VzDw==
X-Gm-Message-State: AOJu0YyqNLmHwK5wupH41NEXbGUTLBmLQVUDifvig9Rzs5Q4ALkQ44yS
 3YemSLq2YB6RHRHfcoxFdwGUS+uG1RhSjI7fHo371jIX4eSnJcCZRN36Pl26PrPUI1BgWRslTmW
 KqZcsrW8ab+EZdXeU7D8kRiFR0vWBzLwMb7sKCg==
X-Google-Smtp-Source: AGHT+IEk3/bsIIzbY5V97fPAjW8IXUZq2BSAHOAyah13FFEhKb2zNspTfxfeQpBL0j6FkJjECYhSUgQefDwGX1m9RgI=
X-Received: by 2002:a50:9f0d:0:b0:586:f49:1762 with SMTP id
 4fb4d7f45d1cf-594bc7c819cmr10498214a12.26.1721035454854; Mon, 15 Jul 2024
 02:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-18-sughosh.ganu@linaro.org>
 <CAFLszTiaskAronpTqPEeTcizbOj6YoPi0WZsVT29ZwH09iuP_g@mail.gmail.com>
In-Reply-To: <CAFLszTiaskAronpTqPEeTcizbOj6YoPi0WZsVT29ZwH09iuP_g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 14:54:03 +0530
Message-ID: <CADg8p95of+Tk1wXSkWQ1SFtyyWYXVtU0Ct7zmc1OFGVKdTi=-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/48] lmb: allow lmb module to be used in SPL
To: Simon Glass <sjg@chromium.org>
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

hi Simon,

On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > With the introduction of separate config symbols for the SPL phase of
> > U-Boot, the condition checks need to be tweaked so that platforms that
> > enable the LMB module in SPL are also able to call the LMB API's. Use
> > the appropriate condition checks to achieve this.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >  board/xilinx/common/board.c | 2 +-
> >  boot/bootm.c                | 4 ++--
> >  boot/image-board.c          | 2 +-
> >  fs/fs.c                     | 4 ++--
> >  lib/Makefile                | 2 +-
> >  net/tftp.c                  | 6 +++---
> >  net/wget.c                  | 4 ++--
> >  7 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > index 4056884400..f04c92a70f 100644
> > --- a/board/xilinx/common/board.c
> > +++ b/board/xilinx/common/board.c
> > @@ -665,7 +665,7 @@ int embedded_dtb_select(void)
> >  }
> >  #endif
> >
> > -#if defined(CONFIG_LMB)
> > +#if IS_ENABLED(CONFIG_LMB)
> >
> >  #ifndef MMU_SECTION_SIZE
> >  #define MMU_SECTION_SIZE        (1 * 1024 * 1024)
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 7b3fe551de..5ce84b73b5 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -239,7 +239,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_LMB
> > +#if CONFIG_IS_ENABLED(LMB)
>
> Can you avoid #ifdefs where possible?

Okay

>
> >  static void boot_start_lmb(void)
> >  {
> >         phys_addr_t     mem_start;
> > @@ -1048,7 +1048,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
> >                 }
> >         }
> >  #endif
> > -#if CONFIG_IS_ENABLED(OF_LIBFDT) && defined(CONFIG_LMB)
> > +#if CONFIG_IS_ENABLED(OF_LIBFDT) && CONFIG_IS_ENABLED(LMB)
> >         if (!ret && (states & BOOTM_STATE_FDT)) {
> >                 boot_fdt_add_mem_rsv_regions(images->ft_addr);
> >                 ret = boot_relocate_fdt(&images->ft_addr, &images->ft_len);
> > diff --git a/boot/image-board.c b/boot/image-board.c
> > index 1f8c1ac69f..99ee7968ba 100644
> > --- a/boot/image-board.c
> > +++ b/boot/image-board.c
> > @@ -883,7 +883,7 @@ int image_setup_linux(struct bootm_headers *images)
> >         int ret;
> >
> >         /* This function cannot be called without lmb support */
> > -       if (!IS_ENABLED(CONFIG_LMB))
> > +       if (!CONFIG_IS_ENABLED(LMB))
> >                 return -EFAULT;
> >         if (CONFIG_IS_ENABLED(OF_LIBFDT))
> >                 boot_fdt_add_mem_rsv_regions(*of_flat_tree);
> > diff --git a/fs/fs.c b/fs/fs.c
> > index 2c835eef86..3fb00590be 100644
> > --- a/fs/fs.c
> > +++ b/fs/fs.c
> > @@ -526,7 +526,7 @@ int fs_size(const char *filename, loff_t *size)
> >         return ret;
> >  }
> >
> > -#ifdef CONFIG_LMB
> > +#if CONFIG_IS_ENABLED(LMB)
> >  /* Check if a file may be read to the given address */
> >  static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
> >                              loff_t len, struct fstype_info *info)
> > @@ -567,7 +567,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
> >         void *buf;
> >         int ret;
> >
> > -#ifdef CONFIG_LMB
> > +#if CONFIG_IS_ENABLED(LMB)
> >         if (do_lmb_check) {
> >                 ret = fs_read_lmb_check(filename, addr, offset, len, info);
> >                 if (ret)
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 81b503ab52..398c11726e 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -118,7 +118,7 @@ obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdtdec.o fdtdec_common.o
> >  obj-y += hang.o
> >  obj-y += linux_compat.o
> >  obj-y += linux_string.o
> > -obj-$(CONFIG_LMB) += lmb.o
> > +obj-$(CONFIG_$(SPL_)LMB) += lmb.o
> >  obj-y += membuff.o
> >  obj-$(CONFIG_REGEX) += slre.o
> >  obj-y += string.o
> > diff --git a/net/tftp.c b/net/tftp.c
> > index 5e27fd4aa9..5c75d9d04f 100644
> > --- a/net/tftp.c
> > +++ b/net/tftp.c
> > @@ -82,7 +82,7 @@ static ulong  tftp_block_wrap;
> >  static ulong   tftp_block_wrap_offset;
> >  static int     tftp_state;
> >  static ulong   tftp_load_addr;
> > -#ifdef CONFIG_LMB
> > +#if CONFIG_IS_ENABLED(LMB)
> >  static ulong   tftp_load_size;
> >  #endif
> >  #ifdef CONFIG_TFTP_TSIZE
> > @@ -160,7 +160,7 @@ static inline int store_block(int block, uchar *src, unsigned int len)
> >         ulong store_addr = tftp_load_addr + offset;
> >         void *ptr;
> >
> > -#ifdef CONFIG_LMB
> > +#if CONFIG_IS_ENABLED(LMB)
> >         ulong end_addr = tftp_load_addr + tftp_load_size;
> >
> >         if (!end_addr)
> > @@ -710,7 +710,7 @@ static void tftp_timeout_handler(void)
> >  /* Initialize tftp_load_addr and tftp_load_size from image_load_addr and lmb */
> >  static int tftp_init_load_addr(void)
> >  {
> > -#ifdef CONFIG_LMB
> > +#if CONFIG_IS_ENABLED(LMB)
>
> here too

Okay

-sughosh

>
> >         phys_size_t max_size;
> >
> >         lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > diff --git a/net/wget.c b/net/wget.c
> > index 7cf809a8ef..b8ea43e7f0 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -98,7 +98,7 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
> >         ulong newsize = offset + len;
> >         uchar *ptr;
> >
> > -       if (IS_ENABLED(CONFIG_LMB)) {
> > +       if (CONFIG_IS_ENABLED(LMB)) {
> >                 ulong end_addr = image_load_addr + wget_load_size;
> >
> >                 if (!end_addr)
> > @@ -496,7 +496,7 @@ void wget_start(void)
> >         debug_cond(DEBUG_WGET,
> >                    "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
> >
> > -       if (IS_ENABLED(CONFIG_LMB)) {
> > +       if (CONFIG_IS_ENABLED(LMB)) {
> >                 if (wget_init_load_size()) {
> >                         printf("\nwget error: ");
> >                         printf("trying to overwrite reserved memory...\n");
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
