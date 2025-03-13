Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0565C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 09:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5A880756;
	Thu, 13 Mar 2025 10:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NIJSRgWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B1D80F9C; Thu, 13 Mar 2025 10:07:03 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB3F80540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 10:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86d377306ddso326990241.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741856812; x=1742461612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WT45L1W2QjWy98q3gTQIRYQLDoMkDJhozt8LPU7vZgw=;
 b=NIJSRgWra5gekYsiGtGJvZG+1UuTVJOh3bNr4dXpswu/lqEnPg/iuSrVGC0G/ln6eC
 59l1gSDH2vmOoi8rjWHIi8uodkGUdvKwPXeQzRn/DrdFzA3nSsyafAzKKMSJVMsJasfl
 w+3daWS39jElTQeYOqmyDQVZA93MX4JusETajWVrKbYtdv664W9Ent6HvkT99VOY1UiP
 hYMI5TxJpDDBvHdCvPHw+oBo8J84xYbUHO9JGWpAWHx8nPvi5f2OLiAUgaN9YRXWo/7r
 w8bdwZBYi1bvocZhp/Z9SSzqMzfBsoXIGPuNV5TfkKZhpirotbLT64quRz4vZw2Lkbx/
 syjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741856812; x=1742461612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WT45L1W2QjWy98q3gTQIRYQLDoMkDJhozt8LPU7vZgw=;
 b=hhCD7X61qAaWPdgIm3SNGPA/MW/hLycHVqUx9S5kq4j5goMyDcgs9iD0fBEWCCHnDR
 zfcF/KYZ0/b2jwYZxWf06pnesDFNzcVftSEjBjZZ9jTO7VNHZECi5U94b1HHD5UhThRb
 S/S7M2g8NWl3WATO61s7p+3I9emimh8IvnKbD3W+5AWtBG3FsUb1QWhfbfTbrpoKJRPK
 QVw0VnXwmf7uDXnXhk96VsE9ypbxPnzBO4V8f4U5KFO7ZKT7Air/lfTui/77XH9fVEBJ
 K4aQQYzaAei9rEwBCqciUw8f4J9CNmFycSlxM86BRI1c4eP6MeweJPPhK47zcAMaKIfi
 MijA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD0l2+Pz9kV2KjPdgmVLBd7unM7HLywhBImcEhgYY7ipdm8qOmahYtk7Y9+mc9ank7Uj9gUsY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzesxk5yyaZMA2auj6p6KkOmpomESvhvev9Aje+hbiUxCC3pDnF
 qawxRRAKDIv9bvwe+Z7c7J5BDTdepeP2rf5hL2Ukp6MIJHzqSgEUtOV/R1MbyLCPKv/voAXtM1N
 1+1Cly2JrlD0DCNTyilY7rK4ZoquFuH5+6ZBNvw==
X-Gm-Gg: ASbGnctbNct5Yx39f6zt+FqMvbdB21ekZDsfZzYjt4k5gJeGT7ZfPC2+lYRF0zT+1G6
 rc3gRTBrIGwB2kkbnGjEpb+PBGvsbhM1cI4S25WexG6f6VNogeiBfm4CLYNZpQrM48B0eZ6XNDb
 6SBi9dSkNWLPXTpi7+MhUVDuvYpxQ=
X-Google-Smtp-Source: AGHT+IGEdz80MecLuTNjG7Nt5an/tQcXZj+9XQqBNl1RDi4Zur2axTmHLSj3dCVyMylDDBdWqn4vnc1v7PDzjuaXH5I=
X-Received: by 2002:a05:6102:f8b:b0:4c1:903e:7bed with SMTP id
 ada2fe7eead31-4c30a35d93fmr21319613137.0.1741856811853; Thu, 13 Mar 2025
 02:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-9-sughosh.ganu@linaro.org>
 <ab576278-e196-4def-8cd4-5c828259cbc5@canonical.com>
 <CADg8p97hJLu0zKAOL-J3FkTbgBrKGZ+FRvYAJ8se0MOs94VoJw@mail.gmail.com>
 <b9cdc226-9703-4c16-af0a-eb4894bc9445@canonical.com>
In-Reply-To: <b9cdc226-9703-4c16-af0a-eb4894bc9445@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 14:36:41 +0530
X-Gm-Features: AQ5f1JqesGkuKA17y-bWDjTvvJJcIG3eOXk1ZK70nLR2el4sUDqkTNnWmJvO2q0
Message-ID: <CADg8p95_e6AZPMw+SsgkDQF1dYp1+G3Wg0nPNbp6yap6XCL7uQ@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] blkmap: pass information on ISO image to the OS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
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

On Thu, 13 Mar 2025 at 14:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 13.03.25 08:46, Sughosh Ganu wrote:
> > On Thu, 13 Mar 2025 at 02:38, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 12.03.25 09:54, Sughosh Ganu wrote:
> >>> The EFI HTTP boot puts the ISO installer image at some location in
> >>> memory. Information about this image has to be passed on to the OS
> >>> kernel, which is done by adding a persistent memory(pmem) node to the
> >>> devicetree(DT) that is passed to the OS. The OS kernel then gets
> >>> information about the presence of this ISO image and proceeds with the
> >>> installation.
> >>>
> >>> In U-Boot, this ISO image gets mounted as a memory mapped blkmap
> >>> device slice, with the 'preserve' attribute. Add a helper function
> >>> which iterates through all such slices, and invokes a callback. The
> >>> callback adds the pmem node to the DT and removes the corresponding
> >>> memory region from the EFI memory map. Invoke this helper function as
> >>> part of the DT fixup which happens before booting the OS.
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> >>> ---
> >>> Changes since V7:
> >>> * Fix checkpatch errors in blkmap.c and efi_helper.c
> >>>
> >>>    boot/image-fdt.c            |  7 ++++++
> >>>    drivers/block/blkmap.c      | 44 +++++++++++++++++++++++++++++++++++++
> >>>    include/blkmap.h            | 17 ++++++++++++++
> >>>    include/efi.h               | 13 +++++++++++
> >>>    lib/efi_loader/efi_helper.c | 39 ++++++++++++++++++++++++++++++++
> >>>    5 files changed, 120 insertions(+)
> >>>
> >>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >>> index 9d1598b1a93..8f718ad29f6 100644
> >>> --- a/boot/image-fdt.c
> >>> +++ b/boot/image-fdt.c
> >>> @@ -11,6 +11,7 @@
> >>>    #include <command.h>
> >>>    #include <fdt_support.h>
> >>>    #include <fdtdec.h>
> >>> +#include <efi.h>
> >>>    #include <env.h>
> >>>    #include <errno.h>
> >>>    #include <image.h>
> >>> @@ -649,6 +650,12 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
> >>>        if (!ft_verify_fdt(blob))
> >>>                goto err;
> >>>
> >>> +     if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> >>> +             fdt_ret = fdt_efi_pmem_setup(blob);
> >>> +             if (fdt_ret)
> >>> +                     goto err;
> >>> +     }
> >>> +
> >>>        /* after here we are using a livetree */
> >>>        if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
> >>>                struct event_ft_fixup fixup;
> >>> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> >>> index eefed615998..5f7602d0405 100644
> >>> --- a/drivers/block/blkmap.c
> >>> +++ b/drivers/block/blkmap.c
> >>> @@ -498,6 +498,50 @@ err:
> >>>        return err;
> >>>    }
> >>>
> >>
> >> Please, add the missing documentation.
> >> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> >
> > Sorry, I do not understand. Which function do you need documentation for?
>
> blkmap_mem_preserve_slice() is not documented. See line below.

blkmap_mem_preserve_slice() is a static function and not an API. Are
we supposed to document minor helper functions as well. Yes, I can
understand needing to document a static function which is providing an
important functionality in a module, e.g. lmb_add_region_flags(), but
I don't think this qualifies.

>
> >
> >>
> >>> +static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
> >>> +{
> >>> +     return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
> >>> +             (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
> >>> +}
> >>> +
> >>> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> >>> +                                           u32 size), void *ctx)
> >>> +{
> >>> +     int ret;
> >>> +     u32 size;
> >>> +     ulong addr;
> >>> +     struct udevice *dev;
> >>> +     struct uclass *uc;
> >>> +     struct blkmap *bm;
> >>> +     struct blkmap_mem *bmm;
> >>> +     struct blkmap_slice *bms;
> >>> +     struct blk_desc *bd;
> >>> +
> >>> +     if (!cb) {
> >>> +             log_debug("%s: No callback passed to the function\n", __func__);
> >>> +             return 0;
> >>> +     }
> >>> +
> >>> +     uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
> >>> +             bm = dev_get_plat(dev);
> >>> +             bd = dev_get_uclass_plat(bm->blk);
> >>> +
> >>> +             list_for_each_entry(bms, &bm->slices, node) {
> >>> +                     if (!blkmap_mem_preserve_slice(bms))
> >>> +                             continue;
> >>> +
> >>> +                     bmm = container_of(bms, struct blkmap_mem, slice);
> >>> +                     addr = (ulong)(uintptr_t)bmm->addr;
> >>> +                     size = (u32)bms->blkcnt << bd->log2blksz;
> >>> +                     ret = cb(ctx, addr, size);
> >>> +                     if (ret)
> >>> +                             return ret;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>>    int blkmap_destroy(struct udevice *dev)
> >>>    {
> >>>        int err;
> >>> diff --git a/include/blkmap.h b/include/blkmap.h
> >>> index 754d8671b01..30ce80c0ad1 100644
> >>> --- a/include/blkmap.h
> >>> +++ b/include/blkmap.h
> >>> @@ -7,6 +7,7 @@
> >>>    #ifndef _BLKMAP_H
> >>>    #define _BLKMAP_H
> >>>
> >>> +#include <blk.h>
> >>>    #include <dm/lists.h>
> >>>
> >>>    /**
> >>> @@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
> >>>    int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
> >>>                          struct udevice **devp);
> >>>
> >>> +/**
> >>> + * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
> >>> + * @cb: Callback function to call for the blkmap slice
> >>
> >> Please, describe in sufficient detail for a developer who has to
> >> implement such a callback function what information should be provided
> >> by the function.
> >>
> >> All arguments of cb and its return value need to be described.
> >
> > Shouldn't the callback be an abstract interface which allows the
> > caller of this function to do whatever configuration that the caller
> > wants to do. Which is why I have framed it as such in the function's
> > comments.
>
> The description should provide all information that is needed to use
> function without reading its implementation.
>
> The existing documentation does not describe:
>
> * What information ctx, addr, size will contain.

Okay, I can add this information. But again, I think 'ctx' is supposed
to be an opaque object. Maybe I can give an example.

> * When the callback function will be invoked. Is it just once or for
> every matching slice?

Okay

> * Does the callback function have to fill some data structure that
> blkmap_get_preserved_pmem_slice() needs to do its job.

The function description says that the callback is to be called for
additional configuration that might be needed. Since there is no
mention of this fact(filling any data structure), does it not imply
that.

>
> It is unclear what values the return value should take and if it has any
> influence on the output of blkmap_get_preserved_pmem_slice(). Will
> iterating stop at the first error reported by the callback? Or will all
> iterations be executed?

Okay, I will add this information.

-sughosh

>
> >
> > -sughosh
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>> + * @ctx: Argument to be passed to the callback function
> >>> + *
> >>> + * The function is used to iterate through all the blkmap slices, looking
> >>> + * specifically for memory mapped blkmap mapping which has been
>
> %s/mapping which has been/mappings which have been/
>
> >>> + * created with the preserve attribute. The function looks for such slices
> >>> + * with the relevant attributes and then calls the callback function which
> >>> + * then does additional configuration as needed.
> >>> + *
> >>> + * Return: 0 on success, negative error on failure
> >>> + */
> >>> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> >>> +                                           u32 size), void *ctx);
> >>> +
> >>>    #endif      /* _BLKMAP_H */
> >>> diff --git a/include/efi.h b/include/efi.h
> >>> index d005cb6181e..f9bbb175c3a 100644
> >>> --- a/include/efi.h
> >>> +++ b/include/efi.h
> >>> @@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
> >>>     */
> >>>    int efi_get_pxe_arch(void);
> >>>
> >>> +/**
> >>> + * fdt_efi_pmem_setup() - Pmem setup in DT and EFI memory map
> >>> + * @fdt: Devicetree to add the pmem nodes to
> >>> + *
> >>> + * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
> >>> + * and add pmem nodes corresponding to the blkmap slice to the
> >>> + * devicetree along with removing the corresponding region from the
> >>> + * EFI memory map.
> >>> + *
> >>> + * Returns: 0 on success, negative error on failure
> >>> + */
> >>> +int fdt_efi_pmem_setup(void *fdt);
> >>> +
> >>>    #endif /* _LINUX_EFI_H */
> >>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> >>> index 37e5859741f..62772a0d747 100644
> >>> --- a/lib/efi_loader/efi_helper.c
> >>> +++ b/lib/efi_loader/efi_helper.c
> >>> @@ -5,6 +5,7 @@
> >>>
> >>>    #define LOG_CATEGORY LOGC_EFI
> >>>
> >>> +#include <blkmap.h>
> >>>    #include <bootm.h>
> >>>    #include <env.h>
> >>>    #include <image.h>
> >>> @@ -680,3 +681,41 @@ out:
> >>>
> >>>        return ret;
> >>>    }
> >>> +
> >>> +/**
> >>> + * pmem_node_efi_memmap_setup() - Add pmem node and tweak EFI memmap
> >>> + * @fdt: The devicetree to which pmem node is added
> >>> + * @addr: start address of the pmem node
> >>> + * @size: size of the memory of the pmem node
> >>> + *
> >>> + * The function adds the pmem node to the device-tree along with removing
>
> %s/along with removing/and removes/
>
> Best regards
>
> Heinrich
>
> >>> + * the corresponding region from the EFI memory map. Used primarily to
> >>> + * pass the information of a RAM based ISO image to the OS.
> >>> + *
> >>> + * Return: 0 on success, -ve value on error
> >>> + */
> >>> +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
> >>> +{
> >>> +     int ret;
> >>> +     efi_status_t status;
> >>> +
> >>> +     ret = fdt_fixup_pmem_region(fdt, addr, size);
> >>> +     if (ret) {
> >>> +             log_err("Failed to setup pmem node for addr %#lx, size %#x, err %d\n",
> >>> +                     addr, size, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     status = efi_remove_memory_map(addr, size,
> >>> +                                    EFI_CONVENTIONAL_MEMORY);
> >>> +     if (status != EFI_SUCCESS)
> >>> +             return -1;
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +int fdt_efi_pmem_setup(void *fdt)
> >>> +{
> >>> +     return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
> >>> +                                            fdt);
> >>> +}
> >>
>
