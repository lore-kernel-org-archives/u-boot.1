Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B9EC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1B081335;
	Thu, 13 Mar 2025 08:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HRGh3lW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3F581671; Thu, 13 Mar 2025 08:46:55 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDCE811C1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-86112ab1ad4so269221241.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741852009; x=1742456809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FRM8u9r8be1O6crkysvfiQ0YqLHePDlI5Wx8ebSs3ho=;
 b=HRGh3lW+Y+Ue0t+jrUQdG6VxLTECDkFaeqVskZwy96lFM+BxF59T1cWTNU1hx4kAyV
 W0RAuRvPfiunF/k5lHQUKjYBUeGzEzAHavFMUShk9Dkyk+ksdK0JJC79iVrAqQfOFMeX
 nz4vCyAhQatMfqjXUqpCwF6FXp73zRBe0q4FwhaMeBgbiIktsdfg/WoNGHDbuKSYf6N8
 J6R++Rhb151mLy+lXH5M4C7d8QDA9F6VaCW2rQjAexc/WgJHH5/rAbE8t/gRkHu2kwDg
 Z52J61bakFH3OExfklkYY/heZikgUILYXDwBPXdTp7FQEK54XEqDx7kR7dZORAJs2n1T
 HpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741852009; x=1742456809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRM8u9r8be1O6crkysvfiQ0YqLHePDlI5Wx8ebSs3ho=;
 b=fUdFPgEdrWgPtfDzhK86ZfCmCWlSeDEZPUxBNiWpdTs0u6NrOhJJEii7ULVWyXo0wH
 hUu37Thhr6TX1HQlpawpP9L4MDuYymGCEIswqGSFBKJtr/unREXzLebyDfCRPS3SFe0x
 hDkbVf5mBT030mfq6y4rJQszRnOYKfYYGqZCLr+J2CqYX9LVSyo05P7z7Ocegd2aWSvQ
 wgdWLrjCi4Gxz4YQKQlbS9v83Aw08e3p1mEQAiCPvfbHDGxZ6nSLK3bn4Mr+am1hCEZZ
 SEwLYPrAsnq8pccAnm9A0VsU+5g9iJRcpqS8RkYd+ZLa2mLkjSl/7vHARqASO1W6zmDD
 FTSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwUm3qFH0gq7voMlLkW88RtO9Ik0TgaekB5hbWwu3u6p1RXOnINV7ER5PO6tjE7+RNNNs6r4g=@lists.denx.de
X-Gm-Message-State: AOJu0YworEi3nXrC2tgGfN+Aa0JHcF4jQ1sXgljsRFlRpBssmdZZRJ70
 32UZ2ohcTbMcbXVQAv51Cx69UBRN/XLYukxLJzzytnnj+5UJeB2Y41AQ/danDTEHLMk9l9+U1ko
 CU2SueVTNRZGU5Fsi+lY3349Zmlz7XKh2bjfxgA==
X-Gm-Gg: ASbGncsr0uc58EKNXvcbkPJe439KUnyK292lgez+d4u2kK1dmlPSjO4inhr5a9EDbdg
 zTuPcmVT3RClBk1QmlIH7JkS1Vdez1Xf+1SJiVX63WyQZklK2AL+9J/ryI2HSMPbS8ijJF8H3dl
 M0yCpCkSkxzhdUS5b521Nhx+87QG8=
X-Google-Smtp-Source: AGHT+IEMz+U7gXtL76e0PhK/Py0rXJt/9PZ9tGkBt2okmynyl65wbthxspNh5JvI641iEsTKeuJcpKPuYVoGYc2SH+M=
X-Received: by 2002:a05:6102:2d09:b0:4bb:e1c9:80c6 with SMTP id
 ada2fe7eead31-4c30a344411mr22495887137.0.1741852008939; Thu, 13 Mar 2025
 00:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-9-sughosh.ganu@linaro.org>
 <ab576278-e196-4def-8cd4-5c828259cbc5@canonical.com>
In-Reply-To: <ab576278-e196-4def-8cd4-5c828259cbc5@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 13:16:37 +0530
X-Gm-Features: AQ5f1JrR191XEEdBXH4u54hlqTRuwRLg-5H8wbieDVIM1Ko0SJ3q-49jROF-l5Y
Message-ID: <CADg8p97hJLu0zKAOL-J3FkTbgBrKGZ+FRvYAJ8se0MOs94VoJw@mail.gmail.com>
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

On Thu, 13 Mar 2025 at 02:38, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > The EFI HTTP boot puts the ISO installer image at some location in
> > memory. Information about this image has to be passed on to the OS
> > kernel, which is done by adding a persistent memory(pmem) node to the
> > devicetree(DT) that is passed to the OS. The OS kernel then gets
> > information about the presence of this ISO image and proceeds with the
> > installation.
> >
> > In U-Boot, this ISO image gets mounted as a memory mapped blkmap
> > device slice, with the 'preserve' attribute. Add a helper function
> > which iterates through all such slices, and invokes a callback. The
> > callback adds the pmem node to the DT and removes the corresponding
> > memory region from the EFI memory map. Invoke this helper function as
> > part of the DT fixup which happens before booting the OS.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> > ---
> > Changes since V7:
> > * Fix checkpatch errors in blkmap.c and efi_helper.c
> >
> >   boot/image-fdt.c            |  7 ++++++
> >   drivers/block/blkmap.c      | 44 +++++++++++++++++++++++++++++++++++++
> >   include/blkmap.h            | 17 ++++++++++++++
> >   include/efi.h               | 13 +++++++++++
> >   lib/efi_loader/efi_helper.c | 39 ++++++++++++++++++++++++++++++++
> >   5 files changed, 120 insertions(+)
> >
> > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > index 9d1598b1a93..8f718ad29f6 100644
> > --- a/boot/image-fdt.c
> > +++ b/boot/image-fdt.c
> > @@ -11,6 +11,7 @@
> >   #include <command.h>
> >   #include <fdt_support.h>
> >   #include <fdtdec.h>
> > +#include <efi.h>
> >   #include <env.h>
> >   #include <errno.h>
> >   #include <image.h>
> > @@ -649,6 +650,12 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
> >       if (!ft_verify_fdt(blob))
> >               goto err;
> >
> > +     if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> > +             fdt_ret = fdt_efi_pmem_setup(blob);
> > +             if (fdt_ret)
> > +                     goto err;
> > +     }
> > +
> >       /* after here we are using a livetree */
> >       if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
> >               struct event_ft_fixup fixup;
> > diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> > index eefed615998..5f7602d0405 100644
> > --- a/drivers/block/blkmap.c
> > +++ b/drivers/block/blkmap.c
> > @@ -498,6 +498,50 @@ err:
> >       return err;
> >   }
> >
>
> Please, add the missing documentation.
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

Sorry, I do not understand. Which function do you need documentation for?

>
> > +static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
> > +{
> > +     return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
> > +             (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
> > +}
> > +
> > +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> > +                                           u32 size), void *ctx)
> > +{
> > +     int ret;
> > +     u32 size;
> > +     ulong addr;
> > +     struct udevice *dev;
> > +     struct uclass *uc;
> > +     struct blkmap *bm;
> > +     struct blkmap_mem *bmm;
> > +     struct blkmap_slice *bms;
> > +     struct blk_desc *bd;
> > +
> > +     if (!cb) {
> > +             log_debug("%s: No callback passed to the function\n", __func__);
> > +             return 0;
> > +     }
> > +
> > +     uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
> > +             bm = dev_get_plat(dev);
> > +             bd = dev_get_uclass_plat(bm->blk);
> > +
> > +             list_for_each_entry(bms, &bm->slices, node) {
> > +                     if (!blkmap_mem_preserve_slice(bms))
> > +                             continue;
> > +
> > +                     bmm = container_of(bms, struct blkmap_mem, slice);
> > +                     addr = (ulong)(uintptr_t)bmm->addr;
> > +                     size = (u32)bms->blkcnt << bd->log2blksz;
> > +                     ret = cb(ctx, addr, size);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   int blkmap_destroy(struct udevice *dev)
> >   {
> >       int err;
> > diff --git a/include/blkmap.h b/include/blkmap.h
> > index 754d8671b01..30ce80c0ad1 100644
> > --- a/include/blkmap.h
> > +++ b/include/blkmap.h
> > @@ -7,6 +7,7 @@
> >   #ifndef _BLKMAP_H
> >   #define _BLKMAP_H
> >
> > +#include <blk.h>
> >   #include <dm/lists.h>
> >
> >   /**
> > @@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
> >   int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
> >                         struct udevice **devp);
> >
> > +/**
> > + * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
> > + * @cb: Callback function to call for the blkmap slice
>
> Please, describe in sufficient detail for a developer who has to
> implement such a callback function what information should be provided
> by the function.
>
> All arguments of cb and its return value need to be described.

Shouldn't the callback be an abstract interface which allows the
caller of this function to do whatever configuration that the caller
wants to do. Which is why I have framed it as such in the function's
comments.

-sughosh

>
> Best regards
>
> Heinrich
>
> > + * @ctx: Argument to be passed to the callback function
> > + *
> > + * The function is used to iterate through all the blkmap slices, looking
> > + * specifically for memory mapped blkmap mapping which has been
> > + * created with the preserve attribute. The function looks for such slices
> > + * with the relevant attributes and then calls the callback function which
> > + * then does additional configuration as needed.
> > + *
> > + * Return: 0 on success, negative error on failure
> > + */
> > +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> > +                                           u32 size), void *ctx);
> > +
> >   #endif      /* _BLKMAP_H */
> > diff --git a/include/efi.h b/include/efi.h
> > index d005cb6181e..f9bbb175c3a 100644
> > --- a/include/efi.h
> > +++ b/include/efi.h
> > @@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
> >    */
> >   int efi_get_pxe_arch(void);
> >
> > +/**
> > + * fdt_efi_pmem_setup() - Pmem setup in DT and EFI memory map
> > + * @fdt: Devicetree to add the pmem nodes to
> > + *
> > + * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
> > + * and add pmem nodes corresponding to the blkmap slice to the
> > + * devicetree along with removing the corresponding region from the
> > + * EFI memory map.
> > + *
> > + * Returns: 0 on success, negative error on failure
> > + */
> > +int fdt_efi_pmem_setup(void *fdt);
> > +
> >   #endif /* _LINUX_EFI_H */
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 37e5859741f..62772a0d747 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -5,6 +5,7 @@
> >
> >   #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <blkmap.h>
> >   #include <bootm.h>
> >   #include <env.h>
> >   #include <image.h>
> > @@ -680,3 +681,41 @@ out:
> >
> >       return ret;
> >   }
> > +
> > +/**
> > + * pmem_node_efi_memmap_setup() - Add pmem node and tweak EFI memmap
> > + * @fdt: The devicetree to which pmem node is added
> > + * @addr: start address of the pmem node
> > + * @size: size of the memory of the pmem node
> > + *
> > + * The function adds the pmem node to the device-tree along with removing
> > + * the corresponding region from the EFI memory map. Used primarily to
> > + * pass the information of a RAM based ISO image to the OS.
> > + *
> > + * Return: 0 on success, -ve value on error
> > + */
> > +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
> > +{
> > +     int ret;
> > +     efi_status_t status;
> > +
> > +     ret = fdt_fixup_pmem_region(fdt, addr, size);
> > +     if (ret) {
> > +             log_err("Failed to setup pmem node for addr %#lx, size %#x, err %d\n",
> > +                     addr, size, ret);
> > +             return ret;
> > +     }
> > +
> > +     status = efi_remove_memory_map(addr, size,
> > +                                    EFI_CONVENTIONAL_MEMORY);
> > +     if (status != EFI_SUCCESS)
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +int fdt_efi_pmem_setup(void *fdt)
> > +{
> > +     return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
> > +                                            fdt);
> > +}
>
