Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F49C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 10:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8D488915;
	Fri, 16 Aug 2024 12:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yw0hzDqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08D887C38; Fri, 16 Aug 2024 12:28:54 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502A788A77
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 12:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5b7b6a30454so2313537a12.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723804121; x=1724408921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8tv4d/+RejskuwGSa5sGO6IPVkSU49l+FVNAZ+tg8oU=;
 b=Yw0hzDqGaeUpEh9So+xIBBy76dqg5Lsc8uW09WrDzGS4wbnp9KlyXwneZ3J+5xCcRC
 NHaSVwkgHf/00t/Gjm2a9LZrVkK61SIx51V8YO97grVbRjMw08lkChGSFXkPs5YPy+QA
 eikXxIwC3mJqZqyIdQ5ndSx3xfZASrZ3FHxxno7peH11uKAhI6YFoh+IlN+HnqhdqIsP
 X/c3q8qP3puNZLvLODCQKrJo4+uLqz7TOQ+TRAUOtdw5vLaA2PTx83QnFMknkYrf+NOW
 GDN4vCkvIEH/BMHKhHHSbKgtpzvuNF59BmfOmZ27etOZnDTR32eUk6QbVx+LUqeia1CZ
 53fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723804121; x=1724408921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tv4d/+RejskuwGSa5sGO6IPVkSU49l+FVNAZ+tg8oU=;
 b=dE9A3OokUfexamR0oBhvK0cxBYg4OE5LiRojb873I2S93MhfkJ/xslRUWSno2+JWj7
 /f6cRUhR5nwYEYyFAiM3UQSQ6SSpt1LzNI7h9c1W/iIH9iViF6HhhUd1aCtzCLb9svbE
 +u4D1L82RTWCoAYT7W6LtdJ0rECMH8CZ33Pos3akjrR7smWjVB4L0pPYK6oVf/nwXKsk
 ANOOUmxxGjxSJUkiMItxYCgoqgkPrax+uckHUdG7rSvnKda5qj+kdysOaszo5rSwHYdL
 h6GPnt2qZPlLcl+JJQT3BELgXtFsSFuJtV0qzUioMTbGAIcOXCFZeQwoxT2C8zbE4VR7
 Rd9g==
X-Gm-Message-State: AOJu0YybLgInBSyjGSf3s376X3iI3b4XKLPILcV6vZmhK5ul6M1LnRNE
 ED2UcXLuUBuExTQcUocnxpssFX+xFHujCUz/g5HI8iuq8OFqWV+8Iddtlr7YbyLAfuww0mwkUeh
 A9mk1s/RkguUdu1kSbKROgRl9EFWBj/V0WlB45Q==
X-Google-Smtp-Source: AGHT+IFk3EmVNQMgmWFz/IWd2QItDujM0EioZ1vqeBbU+EBuegYHqaMlgg5pWsgz1KPrfWt0AeyC4xUyj9vnAt4j+AU=
X-Received: by 2002:a05:6402:524d:b0:58c:eee0:48f4 with SMTP id
 4fb4d7f45d1cf-5beca78d2d0mr1444223a12.31.1723804121368; Fri, 16 Aug 2024
 03:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-19-sughosh.ganu@linaro.org>
 <dfd4ae50-9916-434e-8373-21ef79d89a08@linaro.org>
In-Reply-To: <dfd4ae50-9916-434e-8373-21ef79d89a08@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 16 Aug 2024 15:58:30 +0530
Message-ID: <CADg8p94CYLvs2=_rpagCSFcMeS8LwrU9X4OLUJx6Mvr=y1EUUA@mail.gmail.com>
Subject: Re: [PATCH 18/40] lmb: remove the lmb_init_and_reserve() function
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
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

On Thu, 15 Aug 2024 at 22:14, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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

Yes, I will flip the order of the patches such that the patches remain
bisectable. Thanks.

-sughosh

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
