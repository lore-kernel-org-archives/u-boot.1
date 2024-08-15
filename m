Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36EEC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BB288C3E;
	Thu, 15 Aug 2024 22:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nvOmF3ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BB388C4E; Thu, 15 Aug 2024 22:33:39 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B837988C3D
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo1761728a12.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754014; x=1724358814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/krMaE/FrBSIxifIVo3sbk33sfPlbVeva+NHHI64RU4=;
 b=nvOmF3ue9kBW0eZzeMM2513y652SzxzxHPi/5pj0cwYGaFHIevsgKOzFxGG8GXQrZo
 gR0LlLm4G8ih6JKT67/DiqLmEnOHZGVaDQXp13LBMGax/edasoEn3DxWoEJYG+0z0muP
 8gGzivOeT8uue11dWvE/t1VHLmhvqdzYF8QH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754014; x=1724358814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/krMaE/FrBSIxifIVo3sbk33sfPlbVeva+NHHI64RU4=;
 b=N8huE6vUfQVFy4kQLSy6dhmuMZa6xi6zo2a74WYd8y1oKuT0X/EITzUC6cSNjZJcoU
 LtekNHf7qt+2c/0SqaohtQnRkXoRZ0b8AKQrHnBv6pHC/owbMwSIM2KVIBeJFW0xwMWj
 8cPY6tky2akU1C+uzQei+0+eAnVqPQaLaetXFwg4tMdMnZTrQ84MbV4TrtjTO8gM0LcI
 pmnNAPeMyHtjZLKviGZE3uOm+Uw2GX78NYXQfv+vzEgdtQ4HRrLAwkt2f5lPzCGaRndc
 HkiIS2CDFuh0DDzItYls0IxBSCrUKhgmlQwbgkDm6X/9V9ZhPDcp3q9xDCVV2AiqvY3s
 lg9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm+vVw92EwsrWrZ1ychZNg/HxtSwtFwl0FGZ0CpX6W3kY5f3LIoCLkriInj65NE2P0jOpnmmzGQKhg9EXUL94IIs9EnA==
X-Gm-Message-State: AOJu0YzIuq/PgNUq+9G8Ll277rmP23b2a05zrZSbx6gmvVHaEE0OzWFW
 OTi2NALwASVn6ShVp27GIRcqpbOota+WmDQ9eGfPiN12zwNymZAbhSn2LFtR6PfxW0P4ZnKYatE
 eC6TvvTbbIk8isS8IrFYgib0/FrguKLZYZbuN
X-Google-Smtp-Source: AGHT+IEoI8/cywB6fFQX3QMVSyb1FfBX51UZZzqUdWQnAUBBaKaF6UberQh5dlv4DIvGnO/9NrNOnyUTe+ZXhfBiODA=
X-Received: by 2002:a17:90a:67ce:b0:2c8:2cd1:881b with SMTP id
 98e67ed59e1d1-2d3c3a8acefmr5958921a91.20.1723754014162; Thu, 15 Aug 2024
 13:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-19-sughosh.ganu@linaro.org>
 <dfd4ae50-9916-434e-8373-21ef79d89a08@linaro.org>
In-Reply-To: <dfd4ae50-9916-434e-8373-21ef79d89a08@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:22 +0100
Message-ID: <CAFLszTiu_p3TgbXA1hQ68jZ8_9yQXKhKy8suyjX88NqgZQ5OSg@mail.gmail.com>
Subject: Re: [PATCH 18/40] lmb: remove the lmb_init_and_reserve() function
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
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

On Thu, 15 Aug 2024 at 17:44, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi,
>
> On 24/07/2024 08:02, Sughosh Ganu wrote:
> > With the changes to make the LMB reservations persistent, the common
> > memory regions are being added during board init. Remove the
> > now superfluous lmb_init_and_reserve() function.
>
> This patch comes before the patches doing these reservations in generic
> code. I think this could break bisecting.
>
> Could you instead make the switch over to the generic code atomic?

+1


>
> Kind regards,
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >   arch/arm/mach-apple/board.c          |  2 --
> >   arch/arm/mach-snapdragon/board.c     |  2 --
> >   arch/arm/mach-stm32mp/stm32mp1/cpu.c |  3 ---
> >   cmd/bdinfo.c                         |  1 -
> >   cmd/load.c                           |  2 --
> >   fs/fs.c                              |  1 -
> >   include/lmb.h                        |  1 -
> >   lib/lmb.c                            | 13 -------------
> >   net/tftp.c                           |  2 --
> >   net/wget.c                           |  2 --
> >   test/cmd/bdinfo.c                    |  9 ---------
> >   11 files changed, 38 deletions(-)
> >
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index 213390d6e8..0b6d290b8a 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -775,8 +775,6 @@ int board_late_init(void)
> >   {
> >       u32 status = 0;
> >
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > -
> >       /* somewhat based on the Linux Kernel boot requirements:
> >        * align by 2M and maximal FDT size 2M
> >        */
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > index a63c8bec45..22a7d2a637 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -282,8 +282,6 @@ int board_late_init(void)
> >   {
> >       u32 status = 0;
> >
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > -
> >       /* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
> >       status |= env_set_hex("kernel_addr_r", addr_alloc(SZ_128M));
> >       status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
> > diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> > index a913737342..64480da9f8 100644
> > --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> > +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> > @@ -141,9 +141,6 @@ int mach_cpu_init(void)
> >
> >   void enable_caches(void)
> >   {
> > -     /* parse device tree when data cache is still activated */
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > -
> >       /* I-cache is already enabled in start.S: icache_enable() not needed */
> >
> >       /* deactivate the data cache, early enabled in arch_cpu_init() */
> > diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> > index b31e0208df..3c40dee143 100644
> > --- a/cmd/bdinfo.c
> > +++ b/cmd/bdinfo.c
> > @@ -162,7 +162,6 @@ static int bdinfo_print_all(struct bd_info *bd)
> >       bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
> >   #endif
> >       if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
> > -             lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> >               lmb_dump_all_force();
> >               if (IS_ENABLED(CONFIG_OF_REAL))
> >                       printf("devicetree  = %s\n", fdtdec_get_srcname());
> > diff --git a/cmd/load.c b/cmd/load.c
> > index 56da3a4c5d..20d802502a 100644
> > --- a/cmd/load.c
> > +++ b/cmd/load.c
> > @@ -153,8 +153,6 @@ static ulong load_serial(long offset)
> >       int     line_count =  0;
> >       long ret;
> >
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > -
> >       while (read_record(record, SREC_MAXRECLEN + 1) >= 0) {
> >               type = srec_decode(record, &binlen, &addr, binbuf);
> >
> > diff --git a/fs/fs.c b/fs/fs.c
> > index 3fb00590be..4bc28d1dff 100644
> > --- a/fs/fs.c
> > +++ b/fs/fs.c
> > @@ -549,7 +549,6 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
> >       if (len && len < read_len)
> >               read_len = len;
> >
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> >       lmb_dump_all();
> >
> >       if (lmb_alloc_addr(addr, read_len) == addr)
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 77e2a23c0d..50977e6561 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -37,7 +37,6 @@ struct lmb_region {
> >       enum lmb_flags flags;
> >   };
> >
> > -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> >   void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> >                               void *fdt_blob);
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index db0874371a..f1142033ef 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -226,19 +226,6 @@ static void lmb_reserve_common(void *fdt_blob)
> >               efi_lmb_reserve();
> >   }
> >
> > -/* Initialize the struct, add memory and call arch/board reserve functions */
> > -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
> > -{
> > -     int i;
> > -
> > -     for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > -             if (bd->bi_dram[i].size)
> > -                     lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
> > -     }
> > -
> > -     lmb_reserve_common(fdt_blob);
> > -}
> > -
> >   /**
> >    * lmb_add_memory() - Add memory range for LMB allocations
> >    *
> > diff --git a/net/tftp.c b/net/tftp.c
> > index f841f6b701..9b1f06ba8e 100644
> > --- a/net/tftp.c
> > +++ b/net/tftp.c
> > @@ -711,8 +711,6 @@ static int tftp_init_load_addr(void)
> >       if (CONFIG_IS_ENABLED(LMB)) {
> >               phys_size_t max_size;
> >
> > -             lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > -
> >               max_size = lmb_get_free_size(image_load_addr);
> >               if (!max_size)
> >                       return -1;
> > diff --git a/net/wget.c b/net/wget.c
> > index b8ea43e7f0..82a7e30ea7 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -75,8 +75,6 @@ static int wget_init_load_size(void)
> >   {
> >       phys_size_t max_size;
> >
> > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > -
> >       max_size = lmb_get_free_size(image_load_addr);
> >       if (!max_size)
> >               return -1;
> > diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> > index 34d2b141d8..1cd81a195b 100644
> > --- a/test/cmd/bdinfo.c
> > +++ b/test/cmd/bdinfo.c
> > @@ -113,14 +113,6 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
> >               end = base + size - 1;
> >               flags = rgn->region[i].flags;
> >
> > -             /*
> > -              * this entry includes the stack (get_sp()) on many platforms
> > -              * so will different each time lmb_init_and_reserve() is called.
> > -              * We could instead have the bdinfo command put its lmb region
> > -              * in a known location, so we can check it directly, rather than
> > -              * calling lmb_init_and_reserve() to create a new (and hopefully
> > -              * identical one). But for now this seems good enough.
> > -              */
> >               if (!IS_ENABLED(CONFIG_SANDBOX) && i == 3) {
> >                       ut_assert_nextlinen(" %s[%d]\t[", name, i);
> >                       continue;
> > @@ -200,7 +192,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
> >       if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
> >               struct lmb lmb;
> >
> > -             lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> >               ut_assertok(lmb_test_dump_all(uts, &lmb));
> >               if (IS_ENABLED(CONFIG_OF_REAL))
> >                       ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
>
> --
> // Caleb (they/them)
