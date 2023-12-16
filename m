Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9285FC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8710A876E4;
	Sat, 16 Dec 2023 19:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/b6kBJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A309287714; Sat, 16 Dec 2023 19:02:06 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEB0876D5
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67f16446498so13786636d6.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702749723; x=1703354523; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6LDvGUO26yUlT/OHvDVhRsqmsmXBuwBe2wBgioCGBM=;
 b=S/b6kBJZ6lB1BECI0xxwEpvMIgMCj474pRKD3Z12XSff77n2EK2zm5uWhoCxYB7iGq
 0LmqMbYr/to09ymq6Cv8ESFFFgpoWAs3KM3f5XL/UELisrq13G1QoRQ2ChLqnf/X35/O
 PG+g5Ru7KixFXNAHuz55s1ZxoP4mW9BYG1nJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702749723; x=1703354523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6LDvGUO26yUlT/OHvDVhRsqmsmXBuwBe2wBgioCGBM=;
 b=cK7OvjMbeCU7vYuxNwomRSl4/V5cESGdlJ2sN4iApo9B48fRQRFMftYq6DoPLkk6X2
 9AQ0BVjoeumGmxy4zlKDLQ0YU6d/DlUL62nP7NzDyxuvQ/cQT3t9pEHFtiVVg4PsBO4x
 IBXGPhrDw120Al0OGA5PHTohKLiud4xkYw0lDtti5xavrI2sStrkXfCKPETfa71US9vz
 CPDtKu+IVgUCK7S8U+ZucGfsJxg+H5AfAneQYzW8BtAXF7FkWrXh2MwKiwjbT4C3f+gO
 yW4Y95UbMN9+GFOyZqdPBw6Eupw/UMZXyqmfpIhfzblzpAKzEueL2Slqu4/yT93icWoM
 0KrQ==
X-Gm-Message-State: AOJu0YxLAsb+DmKGz9dPjvx2ZzpVrxNxEDo+cG2jNkIHXUcJS5x7sGoY
 UhXzbZhg7WpiXDiXrFk7OX9DnjRxfjLf091o1s2PRhz6jIiLXzkx2V0=
X-Google-Smtp-Source: AGHT+IH8k5mS+MxJfDESxVsckxGmrp700sfR42SGPbc2JUEBhhsGccCeBCjWnGqR4WlAVbYViw32qUykE8Hm2VMWJso=
X-Received: by 2002:a0c:fb09:0:b0:67e:fa34:42db with SMTP id
 c9-20020a0cfb09000000b0067efa3442dbmr7013623qvp.85.1702749722691; Sat, 16 Dec
 2023 10:02:02 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:01:52 -0700
Message-ID: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
Subject: Proposal: U-Boot memory management
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

This records my thoughts after a discussion with Ilias & Heinrich re
memory allocation in U-Boot.

1. malloc()

malloc() is used for programmatic memory allocation. It allows memory
to be freed. It is not designed for very large allocations (e.g. a
10MB kernel or 100MB ramdisk).

2. lmb

lmb is used for large blocks of memory, such as those needed for a
kernel or ramdisk. Allocation is only transitory, for the purposes of
loading some images and booting. If the boot fails, then all lmb
allocations go away.

lmb is set up by getting all available memory and then removing what
is used by U-Boot (code, data, malloc() space, etc.)

lmb reservations have a few flags so that areas of memory can be
provided with attributes

There are some corner cases...e.g. loading a file does an lmb
allocation but only for the purpose of avoiding a file being loaded
over U-Boot code/data. The allocation is dropped immediately after the
file is loaded. Within the bootm command, or when using standard boot,
this would be fairly easy to solve.

Linux has renamed lmb to memblock. We should consider doing the same.

3. EFI

EFI has its own memory-allocation tables.

Like lmb, EFI is able to deal with large allocations. But via a 'pool'
function it can also do smaller allocations similar to malloc(),
although each one uses at least 4KB at present.

EFI allocations do not go away when a boot fails.

With EFI it is possible to add allocations post facto, in which case
they are added to the allocation table just as if the memory was
allocated with EFI to begin with.

The EFI allocations and the lmb allocations use the same memory, so in
principle could conflict.

EFI allocations are sometimes used to allocate internal U-Boot data as
well, if needed by the EFI app. For example, while efi_image_parse()
uses malloc(), efi_var_mem.c uses EFI allocations since the code runs
in the app context and may need to access the memory after U-Boot has
exited. Also efi_smbios.c uses allocate_pages() and then adds a new
mapping as well.

EFI memory has attributes, including what the memory is used for (to
some degree of granularity). See enum efi_memory_type and struct
efi_mem_desc. In the latter there are also attribute flags - whether
memory is cacheable, etc.

EFI also has the x86 idea of 'conventional' memory, meaning (I
believe) that below 4GB that isn't reserved for the hardware/system.
This is meaningless, or at least confusing, on ARM systems.

4. reservations

It is perhaps worth mentioning a fourth method of memory management,
where U-Boot reserves chunks of memory before relocation (in
board_init_f.c), e.g. for the framebuffer, U-Boot code, the malloc()
region, etc.


Problems
=E2=80=94-------

There are no urgent problems, but here are some things that could be improv=
ed:

1. EFI should attach most of its data structures to driver model. This
work has started, with the partition support, but more effort would
help. This would make it easier to see which memory is related to
devices and which is separate.

2. Some drivers do EFI reservations today, whether EFI is used for
booting or not (e.g. rockchip video rk_vop_probe()).

3. U-Boot doesn't really map arch-specific memory attributes (e.g.
armv8's struct mm_region) to EFI ones.

4. EFI duplicates some code from bootm, some of which relates to
memory allocation (e.g. FDT fixup).

5. EFI code is used even if EFI is never used to boot

6. EFI allocations can result in the same memory being used as has
already been allocated by lmb. Users may load files which overwrite
memory allocated by EFI.


Lifetime
--------

We have three different memory allocators with different purposes. Can
we unify them a little?

Within U-Boot:
- malloc() space lives forever
- lmb lives while setting out images for booting
- EFI (mostly) lives while booting an EFI app

In practice, EFI is set up early in U-Boot. Some of this is necessary,
some not. EFI allocations stay around forever. This works OK since
large allocations are normally not done in EFI, so memory isn't really
consumed to any great degree by the boot process.

What happens to EFI allocations if the app returns? They are still
present, in case another app is run. This seems fine.

API
=E2=80=93--
Can we unify some APIs?

It should be possible to use lmb for large EFI memory allocations, so
long as they are only needed for booting. We effectively do this
today, since EFI does not manage the arrangement of loaded images in
memory. for the most part.

It would not make sense to use EFI allocation to replace lmb and
malloc(), of course.

Could we use a common (lower-level) API for allocation, used by both
lmb and EFI? They do have some similarities. However they have
different lifetime constraints (EFI allocations are never dropped,
unlikely lmb).

** Overall, it seems that the existence of memory allocation in
boot-time services has created confusion. Memory allocation is
muddled, with both U-Boot code and boot-time services calling the same
memory allocator. This just has not been clearly thought out.


Proposal
=E2=80=94-------

Here are some ideas:

1. For video, use the driver model API to locate the video regions, or
block off the entire framebuffer memory, for all devices as a whole.
Use efi_add_memory_map()

2. Add memory attributes to UCLASS_RAM and use them in EFI, mapping to
the EFI_MEMORY_... attributes in struct efi_mem_desc.

3. Add all EFI reservations just before booting the app, as we do with
devicetree fixup. With this model, malloc() and lmb are used for all
allocation. Then efi_add_memory_map() is called for each region in
turn just before booting. Memory attributes are dealt with above. The
type (enum efi_memory_type) can be determined simply by the data
structure stored in it, as is done today. For example, SMBIOS tables
can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI code
understands the meaning of each.

4. Avoid setting up EFI memory at the start of U-Boot. Do it only when
booting. This looks to require very little effort.

5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
boot-time services. This solves the problem 6. If memory is needed by
an app, allocate it with malloc() and see 3. There are only two
efi_allocate_pages() (smbios and efi_runtime). There are more calls of
efi_allocate_pool(), but most of these seem easy to fix up. For
example, efi_init_event_log() allocates a buffer, but this can be
allocated in normal malloc() space or in a bloblist.

6. Don't worry too much about whether EFI will be used for booting.
The cost is likely not that great: use bootstage to measure it as is
done for driver model. Try to minmise the cost of its tables,
particularly for execution time, but otherwise just rely on the
ability to disable EFI_LOADER.

=E2=80=93

Regards,
Simon
