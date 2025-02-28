Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1CEC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 06:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C34380FF4;
	Fri, 28 Feb 2025 07:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xVNnnoKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA1D80FF2; Fri, 28 Feb 2025 07:54:31 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C060181101
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 07:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-869440f201eso1494056241.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 22:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740725664; x=1741330464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t83u9x2AmWlO1cJmOLro9t6NOCrOcsYjbKFVPP/1WnA=;
 b=xVNnnoKFwcbOROA9TB0SmYZXyhM5NkWFxeHdZ4RCYGQAACdDDYau2MyLDE41xa+J1S
 vGWiJ+afimbrBCqhvPUhUrYp2RnpuDMZ+AkxROzLiYudmqG1SxsGkCH18ixxGnAD9+fM
 zNTEE+lyemsM64l+ZK+iiFAOPdnr7CrbJbPKvvo8Z28TMHgdr0rtDx174AkcFq8eZXxL
 vFxK48mc3WiLkgBra/xeIC8V12ECxzf51rzB2oGnzMoWQLDUEaomj4R8JmdQmLZnVqt/
 xBm6FMiXFFDv8oatF2+YOTyC/BC4CAJluqIYUL2u4cbuHGfi0piRlBTe1I/HYn9Lv33h
 2EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740725664; x=1741330464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t83u9x2AmWlO1cJmOLro9t6NOCrOcsYjbKFVPP/1WnA=;
 b=Urnn0XYNIsosRcDq/bwaBfMZw00nzmuRSUWBXtFIvw10WZPZabMf3Oj4926PeRYyNz
 CIS+vPXi5pOYw7wmrPVWRpe64rmA71rrewhBKRpLbau//ersrnHuUDO4/Jtf9DSWbkwJ
 So8nD93nYhVZNjhse7kI2U+NQ0X5kZz24zn17zPq460VoLrsFRFURONLCL3P8T6EaTK4
 cNDN0nU4Jgz+dpf/5K2WKEFM5H/ihFfaBvT4bGSifaidTjLNMcD+TMcVji/iVoS8izZ7
 O13mNLJs0yVBLDLyvMivyMNzQY2FikyzSRCnW1Q/k6qZdTJu7Zc049wyNS1tmNTQWSUL
 I4KA==
X-Gm-Message-State: AOJu0YyxhbUsO9NS9FlgQRFmCV8LGuSyAFB4pvgwTguGgjncZa21KxMD
 Kj3dSCttmhYreCwTHcKX0Va8zCXVtrx1wuwQG65ZtVUiAJMGOSCS5cFa4KBKnW4m/b3w2rQ7W7R
 /CXZImGakJupudyqZNAYMToGFsP0YMT3f+hF1kg==
X-Gm-Gg: ASbGnctkgQbOzPEwlDn69n7kFkyBchiPWMT3cX3HIy5dmavfJ06xQ+NPsJB34jdPJKp
 nA8tqcQ++CFNxBOHUU49PX095sELgr1nISRSvJneP+IffQ0Cb93ez/nAlhQ03xNoCwjgK60JPA2
 eUJP+z6cPT
X-Google-Smtp-Source: AGHT+IEETqNaO6HowU9CkoSeiMND4OjE7+Dl1+E85YsYv44nPy+Uq3dEQvXD1zxmBKJ+TwJCF0InA6GrVvnRbkRZc5k=
X-Received: by 2002:a05:6102:3583:b0:4bf:fb80:9429 with SMTP id
 ada2fe7eead31-4c04488311bmr1993555137.4.1740725664567; Thu, 27 Feb 2025
 22:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20250227111519.45787-1-sughosh.ganu@linaro.org>
 <20250227111519.45787-7-sughosh.ganu@linaro.org>
 <87bjunb1jm.fsf@waldekranz.com>
In-Reply-To: <87bjunb1jm.fsf@waldekranz.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 28 Feb 2025 12:24:13 +0530
X-Gm-Features: AQ5f1JpVzahAQY6Vr1yN-XrvlPL6kPEnjgvL_KDcEVXaYLX6q1dcekh0wimGgtA
Message-ID: <CADg8p95COxvYVD48bR-RHKdMnw3Y6igZE749oAiKoojriZ6xzg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] blkmap: pass information on ISO image to the OS
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Bin Meng <bmeng@tinylab.org>
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

On Fri, 28 Feb 2025 at 01:30, Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
> On tor, feb 27, 2025 at 16:45, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
> > ---
>
> If a v6 is needed for some other reason (you seemed to indicate that),
> then see my small comments below. Either way:
>
> Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> > Changes since V4:
> > * Reword the commit message
> > * Add a helper function blkmap_get_preserved_pmem_slice()
> > * Add a function pmem_node_efi_memmap_setup() for pmem node and EFI
> >   memmap related setup
> >
> >  boot/image-fdt.c            |  7 ++++++
> >  drivers/block/blkmap.c      | 43 +++++++++++++++++++++++++++++++++++++
> >  include/blkmap.h            | 17 +++++++++++++++
> >  include/efi.h               | 13 +++++++++++
> >  lib/efi_loader/efi_helper.c | 37 +++++++++++++++++++++++++++++++
> >  5 files changed, 117 insertions(+)
> >
> > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > index 9d1598b1a93..8f718ad29f6 100644
> > --- a/boot/image-fdt.c
> > +++ b/boot/image-fdt.c
> > @@ -11,6 +11,7 @@
> >  #include <command.h>
> >  #include <fdt_support.h>
> >  #include <fdtdec.h>
> > +#include <efi.h>
> >  #include <env.h>
> >  #include <errno.h>
> >  #include <image.h>
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
> > index eefed615998..c9e0a3a6eea 100644
> > --- a/drivers/block/blkmap.c
> > +++ b/drivers/block/blkmap.c
> > @@ -498,6 +498,49 @@ err:
> >       return err;
> >  }
> >
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
> > +     uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
> > +             bm = dev_get_plat(dev);
> > +             bd = dev_get_uclass_plat(bm->blk);
> > +
> > +             list_for_each_entry(bms, &bm->slices, node) {
> > +                     if (!blkmap_mem_preserve_slice(bms) || !cb)
> > +                             continue;
> > +
> > +                     bmm = container_of(bms, struct blkmap_mem, slice);
> > +                     addr = (ulong)(uintptr_t)bmm->addr;
> > +                     size = (u32)bms->blkcnt << bd->log2blksz;
> > +                     ret = cb(ctx, addr, size);
> > +                     if (ret) {
> > +                             log_err("Failed to setup pmem node for addr %#lx, size %#x\n",
> > +                                     addr, size);
>
> IMO, this function should not make any assumptions about what the
> callback is doing. If an error is encountered, then the callback should
> decide if it warrants an entry in the log or not.

Yes, the right place for this log message is in the callback function.

>
> > +                             return -1;
>
> And the non-zero return value (`err`) of the callback should be passed
> verbatim back to our caller here, in case it wants to discriminate
> between different kinds of errors.

Okay, will change.

-sughosh

>
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +}
> > +
> >  int blkmap_destroy(struct udevice *dev)
> >  {
> >       int err;
> > diff --git a/include/blkmap.h b/include/blkmap.h
> > index 754d8671b01..89bd2b65fba 100644
> > --- a/include/blkmap.h
> > +++ b/include/blkmap.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _BLKMAP_H
> >  #define _BLKMAP_H
> >
> > +#include <blk.h>
> >  #include <dm/lists.h>
> >
> >  /**
> > @@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
> >  int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
> >                         struct udevice **devp);
> >
> > +/**
> > + * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
> > + * @cb: Callback function to call for the blkmap slice
> > + * @ctx: Argument to be passed to the callback function
> > + *
> > + * The function is used to iterate through all the blkmap slices, looking
> > + * specifically for memory mapped blkmap mapping which has been
> > + * created with the preserve attribute. The function looks for such slices
> > + * with the relevant attributes and then calls the callback function which
> > + * then does additional configuration as needed.
> > + *
> > + * Return: 0 on success, -1 on failure
> > + */
> > +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> > +                                           u32 size), void *ctx);
> > +
> >  #endif       /* _BLKMAP_H */
> > diff --git a/include/efi.h b/include/efi.h
> > index d005cb6181e..f9bbb175c3a 100644
> > --- a/include/efi.h
> > +++ b/include/efi.h
> > @@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
> >   */
> >  int efi_get_pxe_arch(void);
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
> >  #endif /* _LINUX_EFI_H */
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 04b2efc4a3b..675f3efa79a 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -5,6 +5,7 @@
> >
> >  #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <blkmap.h>
> >  #include <bootm.h>
> >  #include <env.h>
> >  #include <image.h>
> > @@ -680,3 +681,39 @@ out:
> >
> >       return ret;
> >  }
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
> > +     if (ret)
> > +             return ret;
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
> > +
> > +     return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
> > +                                            fdt);
>
> ...i.e. here is the code that knows what the callback is doing, so it
> can choose to emit the log message - without imposing that behavior on
> any other users of the iterator.
>
> > +}
> > --
> > 2.34.1
