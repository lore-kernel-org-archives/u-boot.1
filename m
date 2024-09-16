Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B051EC3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FF788EB2;
	Mon, 16 Sep 2024 11:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="phdb8u55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2575888EA4; Mon, 16 Sep 2024 11:29:26 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A7788EB2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209db94so5249149a12.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726478961; x=1727083761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUUQy5MKgPpVlVGrKvsRx681veJfHkhbfrHQW8N+BA8=;
 b=phdb8u55XAPQQWxas/JrV2A9rfiQQxHRqzpM6L4VbDutVTfrOr52+XQcCf/0QqfDYk
 C8zlTiuTgQrzxxFCNlsy6KHmyL+XcV/ArNsqmwT1G8eglQ3EiyuEgj2hA3KORsRBlTHb
 hsXHe4o4KyxLEzluP2OJ/T3vKCjAv7vPijg09XonerZ8wZC1ZuFyXmqfAW/SU6h/s9Iy
 yU1H9V89hlQgxxzMZtVc9vYqOUKhT2HaxaWRDpgrTGQjgIzqvJ/UrerYCZvdUrdasJMN
 ZUseFxgvayvqb/2YJve6TfRHFh9kB0hIoVzt9tK+RuARQcmT017H9FG1R+Mb3SH+kelz
 QyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726478961; x=1727083761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUUQy5MKgPpVlVGrKvsRx681veJfHkhbfrHQW8N+BA8=;
 b=xTqNyew7y/LcY6YGvpU45JkBhsw0tQEYozKRyDxUn6yzTyfXKtdfuEIzQlvKLp35bB
 MuZFRzKGEesffwDjeW0FFZ2qUidF582aKYUSy8nXgHcgGpPMPftmSK3id+QGtNFZ0F85
 F42jKZrWZGHYNFpoyochf+CXlJ+Us7NK3wS3W012T8BkH/tIw1xCVKxBrH8VH+baAfaL
 q5dyBEkZlWNSptamUjb8PKgf/C/VHXJ20943Gj8xMMIuwdQh7Q0FolnJYFKkad5M1cP6
 nOfohSFICgt9uPf23I0fhVJkBNSnEdWpCaeOy7eSlAVD7d5Iia0mjw6uOShqx8ireQ+V
 U/7w==
X-Gm-Message-State: AOJu0YwOm0iQr/kFDurifHjb98IDkz97NLThd1BU0bstnWHOVzKQHAdw
 DHYMUtUTkIV09kwBqSbNkIRKNM55pm8ExoXHymQ3nZQXdgo//VJcgpOHIlxAMVdqSqPb26wH/yM
 XEfpQy3TBFp2vKEgyYOoBQpPgiopNLl6LoupyNw==
X-Google-Smtp-Source: AGHT+IF0lfQ1o0Sq9WRQzpothKn9Iz5LVU+LVntlhrb3+h2lViJ1Fj9kQ3IHZa/6knhKbk0WRQmpGFWxV06Sol+BDrk=
X-Received: by 2002:a05:6402:2108:b0:5c4:2396:d990 with SMTP id
 4fb4d7f45d1cf-5c42396da70mr8137826a12.17.1726478961422; Mon, 16 Sep 2024
 02:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org>
 <65996987-dda0-4396-8624-1fbe1307facf@ti.com>
 <CADg8p94_sZcvNdJbKkzvb-NWyrAghsPEDdmac-0+K_gPdM6-CQ@mail.gmail.com>
 <cf5284c4-fb79-46cf-ae3d-52624e054e49@ti.com>
In-Reply-To: <cf5284c4-fb79-46cf-ae3d-52624e054e49@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 16 Sep 2024 14:59:10 +0530
Message-ID: <CADg8p95NbtGgRu5JazAyAEjDoS6G3-UPK=ABQyTt9RGnsAiCWg@mail.gmail.com>
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

On Mon, 16 Sept 2024 at 14:09, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Sughosh,
>
> On 16/09/24 11:59, Sughosh Ganu wrote:
> > On Mon, 16 Sept 2024 at 11:22, Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >>
> >> Hi Sughosh,
> >>
> >> On 26/08/24 17:29, Sughosh Ganu wrote:
> >>> The current LMB API's for allocating and reserving memory use a
> >>> per-caller based memory view. Memory allocated by a caller can then be
> >>> overwritten by another caller. Make these allocations and reservations
> >>> persistent using the alloced list data structure.
> >>>
> >>> Two alloced lists are declared -- one for the available(free) memory,
> >>> and one for the used memory. Once full, the list can then be extended
> >>> at runtime.
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> >>> [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> >>> ---
> >>> Changes since V3:
> >>> * Fix checkpatch warnings of spaces between function name and
> >>>     open parantheses.
> >>> * s/uint64_t/u64 as suggested by checkpatch.
> >>> * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> >>> * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
> >>>
> >>>    arch/arc/lib/cache.c                 |   4 +-
> >>>    arch/arm/lib/stack.c                 |   4 +-
> >>>    arch/arm/mach-apple/board.c          |  17 +-
> >>>    arch/arm/mach-snapdragon/board.c     |  17 +-
> >>>    arch/arm/mach-stm32mp/dram_init.c    |   8 +-
> >>>    arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >>>    arch/m68k/lib/bootm.c                |   7 +-
> >>>    arch/microblaze/lib/bootm.c          |   4 +-
> >>>    arch/mips/lib/bootm.c                |  11 +-
> >>>    arch/nios2/lib/bootm.c               |   4 +-
> >>>    arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >>>    arch/powerpc/include/asm/mp.h        |   4 +-
> >>>    arch/powerpc/lib/bootm.c             |  14 +-
> >>>    arch/riscv/lib/bootm.c               |   4 +-
> >>>    arch/sh/lib/bootm.c                  |   4 +-
> >>>    arch/x86/lib/bootm.c                 |   4 +-
> >>>    arch/xtensa/lib/bootm.c              |   4 +-
> >>>    board/xilinx/common/board.c          |   8 +-
> >>>    boot/bootm.c                         |  26 +-
> >>>    boot/bootm_os.c                      |   5 +-
> >>>    boot/image-board.c                   |  34 +-
> >>>    boot/image-fdt.c                     |  35 +-
> >>>    cmd/bdinfo.c                         |   6 +-
> >>>    cmd/booti.c                          |   2 +-
> >>>    cmd/bootz.c                          |   2 +-
> >>>    cmd/elf.c                            |   2 +-
> >>>    cmd/load.c                           |   7 +-
> >>>    drivers/iommu/apple_dart.c           |   8 +-
> >>>    drivers/iommu/sandbox_iommu.c        |  16 +-
> >>>    fs/fs.c                              |   7 +-
> >>
> >> In fs the reserved region is not being freed after read, while
> >> other loaders free them (cmd/load.c), this patch uncovers the issue
> >> since now other loaders cannot use the same memory location for load.
> >
> > The idea with the LMB memory is that it is not really an allocation,
> > but setting aside memory for use. Now there was a discussion earlier
> > on the mailing list if this is actually an allocation or not, but this
> > is what the functions have been called from it's early days. But the
> > way the code is designed now, even with the global and persistent
> > memory map, we have the LMB_NONE flag which is used to allow for the
> > same memory region to be re-allocated/re-reserved.
> >
>
> Understood, thanks for explaining, since the LMB memory map is now
> global, anytime you run these commands a region is marked reserved and
> it shows up in lmb_dump_all(), while it is not necessary to free them,
> there are callers which may error out without reclaiming the region,
> as long as these callers exist systems can break due to this change so a
> cleanup is needed.
>
> >> For example now someone cannot do:
> >>
> >> mmc load .. $loadaddr ...
> >> <do something with above contents>
> >> tftp $loadaddr ..
> >
> > The issue above is what I mentioned to Prasad in one of my earlier
> > replies to the patch that he had sent [1]. What can be done is to
> > unify the manner in which callers ask for LMB memory -- that would
> > mean changing the behaviour of the tftp code to use the logic used in
> > the fs_read_lmb_check() function. I believe this method of loading to
> > an address is more beneficial as it allows memory re-use.
> >
>
> As per my understanding, these checks were added in tftp/wget/fs loaders
> due to CVE-2018-18440, the intent is to only ensure that there is no
> overwrite to existing reserved regions, there is no need to reserve the
> current load buffer region, what fs_read_lmb_check() does not seem to be
> the right approach and scaling that does not seem right even though it
> fixes the problem being discussed.

The approach taken by fs_read_lmb_check() is inline with the current
expectation of how a memory region for loading an image is supposed to
behave. There was a long discussion on the mailing list [1] about
whether the LMB memory allocations are to be perceived as actual
allocations (one where an alloc is supposed to have a corresponding
free), and it was pointed out [2] that historically, that is not how a
LMB memory behaves. Hence this needs to be looked at a little
differently than the usual construct of "an allocation needs to have a
corresponding free".

-sughosh

[1] - https://lore.kernel.org/u-boot/CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com/
[2] - https://lore.kernel.org/u-boot/20231229154307.GS2652760@bill-the-cat/
