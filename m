Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79728C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 959FF8756F;
	Fri, 29 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="uWKcXu6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FD287BA8; Fri, 29 Dec 2023 18:44:20 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC39187B71
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e002d10a-a671-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e002d10a-a671-11ee-91e7-005056994fde;
 Fri, 29 Dec 2023 18:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=u6xvpptSsfw/ovqAr5bLGK5x97YMTcNglkNQuHJa7nA=;
 b=uWKcXu6q5YTZ4x6nFjLNYErFBwDWz3sL3FX2jt6WucC6l0bRDdGAZB2CdyPlau4zM9XuKMU6WyI1G
 pDHKv/3VnnVMF97lZLLwRuedcHqrOMT1vbR7ixVc0KtTq5r5hy9dALLpN2i0QpOaDWKwMeCqyFNahN
 Ix4c9drbH95h4er35SHcU2o9u9gRKvZ0U69Tv68WwfM8l9w1Qqs1ZURpfepN2yQ4nOgVwtYrNfbozL
 WOo5vbblpbbXwk6qPL6KK5qNdWML6WIeMQX32+vmBqLlmyf5SkLtWd6dgCFkLUVlEnrAzYW8CJa0L0
 nwh5ctgvf71YdHd6N2r15eYMBzkC36w==
X-KPN-MID: 33|4SjnS/WvDs60IQmjGxIRP9YBtAz0ALs7dP50TrP+I1hgbCKU492HXJu7t9pmRgH
 xV4bMRAZD2AZ72z8O1xNJh/cpUyGvqWKhbG/asKue7VI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oXigcoL8S2KI7bFuLlvzWiZ4/1JMPPAXzxquKk92gJoZwy08RNA5pWO7Zg41u+l
 XE+7gJa1tXdPzdDuvfxM5iw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e2b7883d-a671-11ee-acaa-00505699d6e5;
 Fri, 29 Dec 2023 18:44:16 +0100 (CET)
Date: Fri, 29 Dec 2023 18:44:15 +0100
Message-Id: <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
In-Reply-To: <20231229161744.GU2652760@bill-the-cat> (message from Tom Rini on
 Fri, 29 Dec 2023 11:17:44 -0500)
Subject: Re: Proposal: U-Boot memory management
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> Date: Fri, 29 Dec 2023 11:17:44 -0500
> From: Tom Rini <trini@konsulko.com>
> 
> On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt wrote:
> > 
> > 
> > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@konsulko.com>:
> > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> > >> Hi,
> > >> 
> > >> On Sat, Dec 16, 2023 at 6:01 PM Simon Glass <sjg@chromium.org> wrote:
> > >> >
> > >> > Hi,
> > >> >
> > >> > This records my thoughts after a discussion with Ilias & Heinrich re
> > >> > memory allocation in U-Boot.
> > >> >
> > >> > 1. malloc()
> > >> >
> > >> > malloc() is used for programmatic memory allocation. It allows memory
> > >> > to be freed. It is not designed for very large allocations (e.g. a
> > >> > 10MB kernel or 100MB ramdisk).
> > >> >
> > >> > 2. lmb
> > >> >
> > >> > lmb is used for large blocks of memory, such as those needed for a
> > >> > kernel or ramdisk. Allocation is only transitory, for the purposes of
> > >> > loading some images and booting. If the boot fails, then all lmb
> > >> > allocations go away.
> > >> >
> > >> > lmb is set up by getting all available memory and then removing what
> > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > >> >
> > >> > lmb reservations have a few flags so that areas of memory can be
> > >> > provided with attributes
> > >> >
> > >> > There are some corner cases...e.g. loading a file does an lmb
> > >> > allocation but only for the purpose of avoiding a file being loaded
> > >> > over U-Boot code/data. The allocation is dropped immediately after the
> > >> > file is loaded. Within the bootm command, or when using standard boot,
> > >> > this would be fairly easy to solve.
> > >> >
> > >> > Linux has renamed lmb to memblock. We should consider doing the same.
> > >> >
> > >> > 3. EFI
> > >> >
> > >> > EFI has its own memory-allocation tables.
> > >> >
> > >> > Like lmb, EFI is able to deal with large allocations. But via a 'pool'
> > >> > function it can also do smaller allocations similar to malloc(),
> > >> > although each one uses at least 4KB at present.
> > >> >
> > >> > EFI allocations do not go away when a boot fails.
> > >> >
> > >> > With EFI it is possible to add allocations post facto, in which case
> > >> > they are added to the allocation table just as if the memory was
> > >> > allocated with EFI to begin with.
> > >> >
> > >> > The EFI allocations and the lmb allocations use the same memory, so in
> > >> > principle could conflict.
> > >> >
> > >> > EFI allocations are sometimes used to allocate internal U-Boot data as
> > >> > well, if needed by the EFI app. For example, while efi_image_parse()
> > >> > uses malloc(), efi_var_mem.c uses EFI allocations since the code runs
> > >> > in the app context and may need to access the memory after U-Boot has
> > >> > exited. Also efi_smbios.c uses allocate_pages() and then adds a new
> > >> > mapping as well.
> > >> >
> > >> > EFI memory has attributes, including what the memory is used for (to
> > >> > some degree of granularity). See enum efi_memory_type and struct
> > >> > efi_mem_desc. In the latter there are also attribute flags - whether
> > >> > memory is cacheable, etc.
> > >> >
> > >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
> > >> > believe) that below 4GB that isn't reserved for the hardware/system.
> > >> > This is meaningless, or at least confusing, on ARM systems.
> > >> >
> > >> > 4. reservations
> > >> >
> > >> > It is perhaps worth mentioning a fourth method of memory management,
> > >> > where U-Boot reserves chunks of memory before relocation (in
> > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the malloc()
> > >> > region, etc.
> > >> >
> > >> >
> > >> > Problems
> > >> > —-------
> > >> >
> > >> > There are no urgent problems, but here are some things that could be improved:
> > >> >
> > >> > 1. EFI should attach most of its data structures to driver model. This
> > >> > work has started, with the partition support, but more effort would
> > >> > help. This would make it easier to see which memory is related to
> > >> > devices and which is separate.
> > >> >
> > >> > 2. Some drivers do EFI reservations today, whether EFI is used for
> > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > >> >
> > >> > 3. U-Boot doesn't really map arch-specific memory attributes (e.g.
> > >> > armv8's struct mm_region) to EFI ones.
> > >> >
> > >> > 4. EFI duplicates some code from bootm, some of which relates to
> > >> > memory allocation (e.g. FDT fixup).
> > >> >
> > >> > 5. EFI code is used even if EFI is never used to boot
> > >> >
> > >> > 6. EFI allocations can result in the same memory being used as has
> > >> > already been allocated by lmb. Users may load files which overwrite
> > >> > memory allocated by EFI.
> > >> 
> > >> 7. We need to support doing an allocation when a file is loaded (to
> > >> ensure files do not overlap), without making it too difficult to load
> > >> multiple files to the same place, if desired.
> > >> 
> > >> >
> > >> >
> > >> > Lifetime
> > >> > --------
> > >> >
> > >> > We have three different memory allocators with different purposes. Can
> > >> > we unify them a little?
> > >> >
> > >> > Within U-Boot:
> > >> > - malloc() space lives forever
> > >> > - lmb lives while setting out images for booting
> > >> > - EFI (mostly) lives while booting an EFI app
> > >> >
> > >> > In practice, EFI is set up early in U-Boot. Some of this is necessary,
> > >> > some not. EFI allocations stay around forever. This works OK since
> > >> > large allocations are normally not done in EFI, so memory isn't really
> > >> > consumed to any great degree by the boot process.
> > >> >
> > >> > What happens to EFI allocations if the app returns? They are still
> > >> > present, in case another app is run. This seems fine.
> > >> >
> > >> > API
> > >> > –--
> > >> > Can we unify some APIs?
> > >> >
> > >> > It should be possible to use lmb for large EFI memory allocations, so
> > >> > long as they are only needed for booting. We effectively do this
> > >> > today, since EFI does not manage the arrangement of loaded images in
> > >> > memory. for the most part.
> > >> >
> > >> > It would not make sense to use EFI allocation to replace lmb and
> > >> > malloc(), of course.
> > >> >
> > >> > Could we use a common (lower-level) API for allocation, used by both
> > >> > lmb and EFI? They do have some similarities. However they have
> > >> > different lifetime constraints (EFI allocations are never dropped,
> > >> > unlikely lmb).
> > >> >
> > >> > ** Overall, it seems that the existence of memory allocation in
> > >> > boot-time services has created confusion. Memory allocation is
> > >> > muddled, with both U-Boot code and boot-time services calling the same
> > >> > memory allocator. This just has not been clearly thought out.
> > >> >
> > >> >
> > >> > Proposal
> > >> > —-------
> > >> >
> > >> > Here are some ideas:
> > >> >
> > >> > 1. For video, use the driver model API to locate the video regions, or
> > >> > block off the entire framebuffer memory, for all devices as a whole.
> > >> > Use efi_add_memory_map()
> > >> >
> > >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, mapping to
> > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > >> >
> > >> > 3. Add all EFI reservations just before booting the app, as we do with
> > >> > devicetree fixup. With this model, malloc() and lmb are used for all
> > >> > allocation. Then efi_add_memory_map() is called for each region in
> > >> > turn just before booting. Memory attributes are dealt with above. The
> > >> > type (enum efi_memory_type) can be determined simply by the data
> > >> > structure stored in it, as is done today. For example, SMBIOS tables
> > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI code
> > >> > understands the meaning of each.
> > >> >
> > >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it only when
> > >> > booting. This looks to require very little effort.
> > >> >
> > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> > >> > boot-time services. This solves the problem 6. If memory is needed by
> > >> > an app, allocate it with malloc() and see 3. There are only two
> > >> > efi_allocate_pages() (smbios and efi_runtime). There are more calls of
> > >> > efi_allocate_pool(), but most of these seem easy to fix up. For
> > >> > example, efi_init_event_log() allocates a buffer, but this can be
> > >> > allocated in normal malloc() space or in a bloblist.
> > >> >
> > >> > 6. Don't worry too much about whether EFI will be used for booting.
> > >> > The cost is likely not that great: use bootstage to measure it as is
> > >> > done for driver model. Try to minmise the cost of its tables,
> > >> > particularly for execution time, but otherwise just rely on the
> > >> > ability to disable EFI_LOADER.
> > >> 
> > >> 7. Add a flag to the 'load' command:
> > >> 
> > >> -m <type> - make an lmb allocation for the file
> > >>    <type> is the image type to use (kernel, ramdisk, flat_dt)
> > >> 
> > >> any existing allocation for that type will be automatically freed
> > >> first. If <type> is "none" then no freeing is possible: any loaded
> > >> images just stack up in lmb.
> > >> 
> > >> Add an 'lmb' (or memblock) command to allow listing and clearing allocations.
> > >
> > >I would really not like to change the user interface and instead simply
> > >handle this with flags to whatever mark/allocation function is called.
> > >You can always overwrite things that are brought in to memory, you
> > >cannot overwrite U-Boot or our internals. Optionally noting that some
> > >previous load to memory has been at least partially overwritten could be
> > >helpful, if it's not too much extra logic.
> > >
> > 
> > In most use cases users load exactly one file at  each address. An
> > unload command would be the cleanest way for a user to indicate that
> > he wants to reuse the memory.
> 
> I very much do not want to change the API. There's untold numbers of
> scripts out there and they should continue to work. I mentioned to Ilias
> off list just now that I'm not against adding a command to add flags to
> these areas, but I don't think it's worthwhile to prevent overwrites the
> user did early. The biggest long running problem in this space was that
> for 32bit ARM we couldn't know where the kernel BSS was going to be and
> so would have ramdisk at the wrong spot and get partially eaten, and
> this was hard to figure out. The current example is "ooops,
> decompression buffer for Image.gz/etc is too close to other things"
> which ends up failing nice and loudly, and in the future once this
> proposal is done we can just dynamically find and use a spot, since
> we'll have that ability finally.

In order to keep the existing interfaces we need lmb to keep track of
(at least ) three different states.  I think of those as "free",
"allocated" and "reserved".  The load command would "reserve" memory
insteaf "allocate".  And it would pass a flag to lmb when reserving
memory to indicate that reserving memory that is already reserved is
ok.  Both "reserved" and "allocated" memory should show up as not free
in the EFI memory map (probably as EfiLoaderData).
