Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB665C47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 05:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D6387732;
	Fri, 29 Dec 2023 06:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z+pvfBhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6665E8753D; Fri, 29 Dec 2023 06:36:25 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437BE87732
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 06:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-68083a0889dso5020636d6.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703828180; x=1704432980; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eh8XXFYvHFnWxXOT8JfZFO5KXBQDzhAv6PHKiZNjzXM=;
 b=Z+pvfBhjSnPcLTOZwpzaBLn5h/SPw9eEzfRGtw9CXbZhDJ0dNiFOPzNa9XR4Q4r4JF
 zWZhgCbayobJK3RrYjEKur8ggOad7gyO7u8O19jrYq5TLIStF24hHmXbSjAOtnOvLDJv
 EDlBn9rrBU+Sca+Z3vDaD5RmLJ8E5lyxKzGss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703828180; x=1704432980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eh8XXFYvHFnWxXOT8JfZFO5KXBQDzhAv6PHKiZNjzXM=;
 b=DVYSh4u8sQJDrDmU8YcqRhTv6S+yHXoEVt9hnPAKLw/Wg9VZ3c6Q/XGXK9N/gTsKAc
 bDKOb1U6nJaZep9Wkr5EkOx8D/1UctJ20kwQxF5H5R0Ka5aXLZodubHmMVuxAr4jliyF
 p/TEjGNLLdvDeDZBGTYFGyAaUV8GuMC9WTXmvD+fQ4e23ru2Avr+ZFzDWOuN+ULovE5h
 JsWJ1ooTyekCwSK6sGvgxEsGlmVAnF9VhI6DgulWcvF0mRzSJojnwH74pEJOkE/oLnjI
 LR3AKDh27StpF2sImJTodSl9L1zwyt+5l79x9NNXl09ROYIdaxKLei6iwwzXup7e2rD7
 8GBA==
X-Gm-Message-State: AOJu0YzdGaf//p9/3WkquEQRI63sBNr2p/9cd0o2PRgcZxeWto5kZxCr
 Jifu5S0tYAHYACwDf3+mip01k59VVHF4jr3T/ugyuSD+RGnfl+3KvUF1i7qbqw==
X-Google-Smtp-Source: AGHT+IE62XVf3TqYYl9za1aAmaAx/BU2YO8Y51MKBBYzm6Vq/0thfne6Kj3IPuflwLzjLB5t9NJ5OM01kxXDnrINhlg=
X-Received: by 2002:a05:6214:62a:b0:67f:5784:bf24 with SMTP id
 a10-20020a056214062a00b0067f5784bf24mr15986670qvx.48.1703828179936; Thu, 28
 Dec 2023 21:36:19 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
In-Reply-To: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Dec 2023 05:36:09 +0000
Message-ID: <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> This records my thoughts after a discussion with Ilias & Heinrich re
> memory allocation in U-Boot.
>
> 1. malloc()
>
> malloc() is used for programmatic memory allocation. It allows memory
> to be freed. It is not designed for very large allocations (e.g. a
> 10MB kernel or 100MB ramdisk).
>
> 2. lmb
>
> lmb is used for large blocks of memory, such as those needed for a
> kernel or ramdisk. Allocation is only transitory, for the purposes of
> loading some images and booting. If the boot fails, then all lmb
> allocations go away.
>
> lmb is set up by getting all available memory and then removing what
> is used by U-Boot (code, data, malloc() space, etc.)
>
> lmb reservations have a few flags so that areas of memory can be
> provided with attributes
>
> There are some corner cases...e.g. loading a file does an lmb
> allocation but only for the purpose of avoiding a file being loaded
> over U-Boot code/data. The allocation is dropped immediately after the
> file is loaded. Within the bootm command, or when using standard boot,
> this would be fairly easy to solve.
>
> Linux has renamed lmb to memblock. We should consider doing the same.
>
> 3. EFI
>
> EFI has its own memory-allocation tables.
>
> Like lmb, EFI is able to deal with large allocations. But via a 'pool'
> function it can also do smaller allocations similar to malloc(),
> although each one uses at least 4KB at present.
>
> EFI allocations do not go away when a boot fails.
>
> With EFI it is possible to add allocations post facto, in which case
> they are added to the allocation table just as if the memory was
> allocated with EFI to begin with.
>
> The EFI allocations and the lmb allocations use the same memory, so in
> principle could conflict.
>
> EFI allocations are sometimes used to allocate internal U-Boot data as
> well, if needed by the EFI app. For example, while efi_image_parse()
> uses malloc(), efi_var_mem.c uses EFI allocations since the code runs
> in the app context and may need to access the memory after U-Boot has
> exited. Also efi_smbios.c uses allocate_pages() and then adds a new
> mapping as well.
>
> EFI memory has attributes, including what the memory is used for (to
> some degree of granularity). See enum efi_memory_type and struct
> efi_mem_desc. In the latter there are also attribute flags - whether
> memory is cacheable, etc.
>
> EFI also has the x86 idea of 'conventional' memory, meaning (I
> believe) that below 4GB that isn't reserved for the hardware/system.
> This is meaningless, or at least confusing, on ARM systems.
>
> 4. reservations
>
> It is perhaps worth mentioning a fourth method of memory management,
> where U-Boot reserves chunks of memory before relocation (in
> board_init_f.c), e.g. for the framebuffer, U-Boot code, the malloc()
> region, etc.
>
>
> Problems
> =E2=80=94-------
>
> There are no urgent problems, but here are some things that could be impr=
oved:
>
> 1. EFI should attach most of its data structures to driver model. This
> work has started, with the partition support, but more effort would
> help. This would make it easier to see which memory is related to
> devices and which is separate.
>
> 2. Some drivers do EFI reservations today, whether EFI is used for
> booting or not (e.g. rockchip video rk_vop_probe()).
>
> 3. U-Boot doesn't really map arch-specific memory attributes (e.g.
> armv8's struct mm_region) to EFI ones.
>
> 4. EFI duplicates some code from bootm, some of which relates to
> memory allocation (e.g. FDT fixup).
>
> 5. EFI code is used even if EFI is never used to boot
>
> 6. EFI allocations can result in the same memory being used as has
> already been allocated by lmb. Users may load files which overwrite
> memory allocated by EFI.

7. We need to support doing an allocation when a file is loaded (to
ensure files do not overlap), without making it too difficult to load
multiple files to the same place, if desired.

>
>
> Lifetime
> --------
>
> We have three different memory allocators with different purposes. Can
> we unify them a little?
>
> Within U-Boot:
> - malloc() space lives forever
> - lmb lives while setting out images for booting
> - EFI (mostly) lives while booting an EFI app
>
> In practice, EFI is set up early in U-Boot. Some of this is necessary,
> some not. EFI allocations stay around forever. This works OK since
> large allocations are normally not done in EFI, so memory isn't really
> consumed to any great degree by the boot process.
>
> What happens to EFI allocations if the app returns? They are still
> present, in case another app is run. This seems fine.
>
> API
> =E2=80=93--
> Can we unify some APIs?
>
> It should be possible to use lmb for large EFI memory allocations, so
> long as they are only needed for booting. We effectively do this
> today, since EFI does not manage the arrangement of loaded images in
> memory. for the most part.
>
> It would not make sense to use EFI allocation to replace lmb and
> malloc(), of course.
>
> Could we use a common (lower-level) API for allocation, used by both
> lmb and EFI? They do have some similarities. However they have
> different lifetime constraints (EFI allocations are never dropped,
> unlikely lmb).
>
> ** Overall, it seems that the existence of memory allocation in
> boot-time services has created confusion. Memory allocation is
> muddled, with both U-Boot code and boot-time services calling the same
> memory allocator. This just has not been clearly thought out.
>
>
> Proposal
> =E2=80=94-------
>
> Here are some ideas:
>
> 1. For video, use the driver model API to locate the video regions, or
> block off the entire framebuffer memory, for all devices as a whole.
> Use efi_add_memory_map()
>
> 2. Add memory attributes to UCLASS_RAM and use them in EFI, mapping to
> the EFI_MEMORY_... attributes in struct efi_mem_desc.
>
> 3. Add all EFI reservations just before booting the app, as we do with
> devicetree fixup. With this model, malloc() and lmb are used for all
> allocation. Then efi_add_memory_map() is called for each region in
> turn just before booting. Memory attributes are dealt with above. The
> type (enum efi_memory_type) can be determined simply by the data
> structure stored in it, as is done today. For example, SMBIOS tables
> can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI code
> understands the meaning of each.
>
> 4. Avoid setting up EFI memory at the start of U-Boot. Do it only when
> booting. This looks to require very little effort.
>
> 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> boot-time services. This solves the problem 6. If memory is needed by
> an app, allocate it with malloc() and see 3. There are only two
> efi_allocate_pages() (smbios and efi_runtime). There are more calls of
> efi_allocate_pool(), but most of these seem easy to fix up. For
> example, efi_init_event_log() allocates a buffer, but this can be
> allocated in normal malloc() space or in a bloblist.
>
> 6. Don't worry too much about whether EFI will be used for booting.
> The cost is likely not that great: use bootstage to measure it as is
> done for driver model. Try to minmise the cost of its tables,
> particularly for execution time, but otherwise just rely on the
> ability to disable EFI_LOADER.

7. Add a flag to the 'load' command:

-m <type> - make an lmb allocation for the file
   <type> is the image type to use (kernel, ramdisk, flat_dt)

any existing allocation for that type will be automatically freed
first. If <type> is "none" then no freeing is possible: any loaded
images just stack up in lmb.

Add an 'lmb' (or memblock) command to allow listing and clearing allocation=
s.

Regards,
Simon
