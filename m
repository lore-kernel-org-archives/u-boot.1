Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA6BC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 18:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B93E88E7A;
	Mon, 16 Sep 2024 20:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xo10Ezfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBA688F15; Mon, 16 Sep 2024 20:11:15 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F74D88E7A
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 20:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406fa5so1488181a12.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726510272; x=1727115072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbuV108AcrM4tn6A0WZzybjIG/pnv6i/U6F46tC03FY=;
 b=xo10EzfbO/zcYcJ9tLh3mJCI1byip080XFhFOk9iqpbHyWExVXCHASls40sP7sXEkg
 x/szz6YWAWusan9tRVKkhlgAGqudC0FDZGDdPsEoccTNO8Q6nKe666KhpANU1J8SnyA3
 x+O6HXU7Os17OXQsEJZmvgbeb8UFi2WNpnXwsZoftVUKmbFyzs+KAtZvHh1OSiY0w7KV
 /nc26TMaoI0IjITWusuExg4Cr8ZzstTFPKVJxUbe4/X6I9pGe6qHY6gs+Sa2w65sN04e
 SHhcw68+cakq0rgWjAuBGwWIaYitT8DpsHSvonMDoxQIPHeTkhVEnS9V9GNy7/bwaseJ
 JhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726510272; x=1727115072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbuV108AcrM4tn6A0WZzybjIG/pnv6i/U6F46tC03FY=;
 b=Ryf36591+3McVLJtoZfaxEg9T5r7PInVuOjyWBHUQeVeTvw31o5J5I5TgHrb/0WuZ8
 u9gMAgCUCXbnDD+AV5w2QVIY8w1yKelrlpRKI2qhWBTgfVUm1G3lHD3zboVIGx56lRMD
 lXXKfXRKMh+zv1O7aQmAn6zzjfj3105Gi4o4tX1ecrcywZPKfWoTREdbFKgG/E8FVnhe
 zKI0Uw2KothesC+AJpaygSf+ltKsgD0w11aZ4lMHkiubbUtImls2zxhX001e3XprN0Mh
 I1RcCVOvpbjcoW1BJ/07TLXNhMAB5rBPjXQlZTKv5N15p1CKkb4ScJXYJchbENi1iGW5
 xHQA==
X-Gm-Message-State: AOJu0Yz2XF34xeuKfiSLoS6Z0ZbdFpiCb/l11x/qbmsP6JWbBWFtERAl
 +25A8iBvpmMuJlHFFqOlauV3zk1jcWkHxzmfEIY78NQdOqedyaUAYU75I+k41TyCzrVqnplaEFC
 E/8MnqNhjf5Gz0KWZHiDNjEnramyTE3GpFbZ+Eg==
X-Google-Smtp-Source: AGHT+IGXeeNh7egEm9KENbogZt5u92kiNFCmtxAmETQbklZhk7f2FsBQcNIlT+IH+MtKyn2xUPAGcW1vrichxDFi5ug=
X-Received: by 2002:a05:6402:3607:b0:5c2:6bb8:1859 with SMTP id
 4fb4d7f45d1cf-5c41e193913mr18227531a12.19.1726510271424; Mon, 16 Sep 2024
 11:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org>
 <65996987-dda0-4396-8624-1fbe1307facf@ti.com>
 <CADg8p94_sZcvNdJbKkzvb-NWyrAghsPEDdmac-0+K_gPdM6-CQ@mail.gmail.com>
 <cf5284c4-fb79-46cf-ae3d-52624e054e49@ti.com>
 <CADg8p95dt6k1etOXmsjorbs_YDu1wB1z7M4oFBhWBfTwqFuomw@mail.gmail.com>
 <f3046c90-036e-4baf-96e3-9f47ded0e933@ti.com>
In-Reply-To: <f3046c90-036e-4baf-96e3-9f47ded0e933@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 16 Sep 2024 23:41:00 +0530
Message-ID: <CADg8p97ddyOkA343sZ5w=YCu0wpuODSs7SC-8fJcPtAt4xmhnQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/27] lmb: make LMB memory map persistent and global
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, "Kumar,
 Udit" <u-kumar1@ti.com>
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

On Mon, 16 Sept 2024 at 22:19, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Sughosh,
>
> Requesting clarification for one more point,
>
> On 16/09/24 14:46, Sughosh Ganu wrote:
> > On Mon, 16 Sept 2024 at 14:09, Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >>
> >> Hi Sughosh,
> >>
> >> On 16/09/24 11:59, Sughosh Ganu wrote:
> >>> On Mon, 16 Sept 2024 at 11:22, Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >>>>
> >>>> Hi Sughosh,
> >>>>
> >>>> On 26/08/24 17:29, Sughosh Ganu wrote:
> >>>>> The current LMB API's for allocating and reserving memory use a
> >>>>> per-caller based memory view. Memory allocated by a caller can then be
> >>>>> overwritten by another caller. Make these allocations and reservations
> >>>>> persistent using the alloced list data structure.
> >>>>>
> >>>>> Two alloced lists are declared -- one for the available(free) memory,
> >>>>> and one for the used memory. Once full, the list can then be extended
> >>>>> at runtime.
> >>>>>
> >>>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> >>>>> [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> >>>>> ---
> >>>>> Changes since V3:
> >>>>> * Fix checkpatch warnings of spaces between function name and
> >>>>>      open parantheses.
> >>>>> * s/uint64_t/u64 as suggested by checkpatch.
> >>>>> * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> >>>>> * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
> >>>>>
> >>>>>     arch/arc/lib/cache.c                 |   4 +-
> >>>>>     arch/arm/lib/stack.c                 |   4 +-
> >>>>>     arch/arm/mach-apple/board.c          |  17 +-
> >>>>>     arch/arm/mach-snapdragon/board.c     |  17 +-
> >>>>>     arch/arm/mach-stm32mp/dram_init.c    |   8 +-
> >>>>>     arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >>>>>     arch/m68k/lib/bootm.c                |   7 +-
> >>>>>     arch/microblaze/lib/bootm.c          |   4 +-
> >>>>>     arch/mips/lib/bootm.c                |  11 +-
> >>>>>     arch/nios2/lib/bootm.c               |   4 +-
> >>>>>     arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >>>>>     arch/powerpc/include/asm/mp.h        |   4 +-
> >>>>>     arch/powerpc/lib/bootm.c             |  14 +-
> >>>>>     arch/riscv/lib/bootm.c               |   4 +-
> >>>>>     arch/sh/lib/bootm.c                  |   4 +-
> >>>>>     arch/x86/lib/bootm.c                 |   4 +-
> >>>>>     arch/xtensa/lib/bootm.c              |   4 +-
> >>>>>     board/xilinx/common/board.c          |   8 +-
> >>>>>     boot/bootm.c                         |  26 +-
> >>>>>     boot/bootm_os.c                      |   5 +-
> >>>>>     boot/image-board.c                   |  34 +-
> >>>>>     boot/image-fdt.c                     |  35 +-
> >>>>>     cmd/bdinfo.c                         |   6 +-
> >>>>>     cmd/booti.c                          |   2 +-
> >>>>>     cmd/bootz.c                          |   2 +-
> >>>>>     cmd/elf.c                            |   2 +-
> >>>>>     cmd/load.c                           |   7 +-
> >>>>>     drivers/iommu/apple_dart.c           |   8 +-
> >>>>>     drivers/iommu/sandbox_iommu.c        |  16 +-
> >>>>>     fs/fs.c                              |   7 +-
> >>>>
> >>>> In fs the reserved region is not being freed after read, while
> >>>> other loaders free them (cmd/load.c), this patch uncovers the issue
> >>>> since now other loaders cannot use the same memory location for load.
> >>>
> >>> The idea with the LMB memory is that it is not really an allocation,
> >>> but setting aside memory for use. Now there was a discussion earlier
> >>> on the mailing list if this is actually an allocation or not, but this
> >>> is what the functions have been called from it's early days. But the
> >>> way the code is designed now, even with the global and persistent
> >>> memory map, we have the LMB_NONE flag which is used to allow for the
> >>> same memory region to be re-allocated/re-reserved.
> >>>
> >>
> >> Understood, thanks for explaining, since the LMB memory map is now
> >> global, anytime you run these commands a region is marked reserved and
> >> it shows up in lmb_dump_all(), while it is not necessary to free them,
> >> there are callers which may error out without reclaiming the region,
> >> as long as these callers exist systems can break due to this change so a
> >> cleanup is needed.
> >>
> >>>> For example now someone cannot do:
> >>>>
> >>>> mmc load .. $loadaddr ...
> >>>> <do something with above contents>
> >>>> tftp $loadaddr ..
> >>>
> >>> The issue above is what I mentioned to Prasad in one of my earlier
> >>> replies to the patch that he had sent [1]. What can be done is to
> >>> unify the manner in which callers ask for LMB memory -- that would
> >>> mean changing the behaviour of the tftp code to use the logic used in
> >>> the fs_read_lmb_check() function. I believe this method of loading to
> >>> an address is more beneficial as it allows memory re-use.
> >>>
> >>
> >> As per my understanding, these checks were added in tftp/wget/fs loaders
> >> due to CVE-2018-18440, the intent is to only ensure that there is no
> >> overwrite to existing reserved regions, there is no need to reserve the
> >> current load buffer region, what fs_read_lmb_check() does not seem to be
> >> the right approach and scaling that does not seem right even though it
> >> fixes the problem being discussed.
> >
> > The approach taken by fs_read_lmb_check() is inline with the current
> > expectation of how a memory region for loading an image is supposed to
> > behave. There was a long discussion on the mailing list [1] about
> > whether the LMB memory allocations are to be perceived as actual
> > allocations (one where an alloc is supposed to have a corresponding
> > free), and it was pointed out [2] that historically, that is not how a
> > LMB memory behaves. Hence this needs to be looked at a little
> > differently than the usual construct of "an allocation needs to have a
> > corresponding free".
> >
>
> Generally for the reserved memory allocations coming from device tree
> the no-overwrite flag is not present, but the expectation is that these
> are important regions that are expected to be reserved (Example ATF,
> OPTEE, Remote core FW regions in DDR), but now each consumer is able to
> rewrite/re-allocate the region again by these loaders (previously most
> could not rewrite since they used lmb_get_free_size() which only
> performs a check), isn't this a valid case where all the consumers
> should not have privilege to overwrite these allocations? Or should all
> regions from DT be marked as no-overwrite?

Yes, these regions need to be marked as no-overwrite to ensure that we
get an error if an address in that region is being used as a
load-address. Do you want to send a patch ?

-sughosh

>
>
> Thanks and Regards,
> Vaishnav
>
> > -sughosh
> >
> > [1] - https://lore.kernel.org/u-boot/CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com/
> > [2] - https://lore.kernel.org/u-boot/20231229154307.GS2652760@bill-the-cat/
> >
> >
