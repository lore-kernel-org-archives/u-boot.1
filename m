Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2872C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F34480FF0;
	Thu, 27 Feb 2025 13:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T/rinqQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A713780FF4; Thu, 27 Feb 2025 13:26:36 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE35801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-8671441a730so358716241.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740659193; x=1741263993; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FgNnsIKTjuNh3LPmUyPzGtO22cDrgbi3kXZ64PDyajA=;
 b=T/rinqQ2jOlNJTyM/iDO19EZrHMwe/AuNPUocDU7/Pfg3o+NoaCzwCyey0PgXBPyeo
 Qj38j3KG0rIKam189hWJO1gLX+HWu5Of5bLQJa9YT6Dzjid252BB/wV/iOyjgjwr9gel
 nCM6rsXnyUdnzMf3NnBKgfgk1cR6VYbWz7MVVZXSJX5GNAVM6TyYZGcaoDIzoVs/0W6Z
 zE7CM58fCN65+tFZ4B6OOZHQ/N7eEplZYKFrZULnGOwu9sNb7R6PF2J8o3vuCuuhdM1F
 O5BqsQlEXxZ4ySuLXJI96u+NuM5BdrVGG4Ed4gA/3B/9YoE8x0ApbQ4lI3yWYxDDyRk0
 13Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740659193; x=1741263993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FgNnsIKTjuNh3LPmUyPzGtO22cDrgbi3kXZ64PDyajA=;
 b=PRbbh5GhtlU3VlevSgvs6Xddpe4UWaAYOecU4yeY2YtozYo87Hu2836sSM9nZozBoS
 tmlFAfgof7bfqeXH9hclGOaAe7PXymjNfqx6L6lKSfEoPFtlcsPIhw0ybtdQGfyWkzmx
 kpabFIloYwBqpbAayTy8CBcuMZP1CIPiygwPi/FbwAQUgNi4FMdpt+dspc7ZeXkVYSMH
 yB6K0KTJhVyX4mFk3AJRvOWsXyIa3H0EmysXoe3h52Im1ifqv/SeVZBxrZ9ywjtjrtN6
 C2oH8DLsou7gQwrZmfSySYGOVMN/sDKQ678QEGe5uvtufEZ8dILbmx6KtdclISGVpBuw
 RV4g==
X-Gm-Message-State: AOJu0YwKoK4KDzGUlFDfDAg1+INOkqRYRefmzclfuVOIlY0wUTesJrq6
 VYgniiWgT3T68IvrNRGQaE/lHwTkUOzKIQwbFTK1tx6+cZfAtp+g90n1KgmzeZfprl3b603sgT9
 dX4YI7yzebsF7zo27DBHXnwlsReS6BrAwZ7CvquHEXM7PZcXDK84=
X-Gm-Gg: ASbGncvHTtspEl7HRsIHtrsHewdKF638wDlpU2gOR3fNAcdarT6ui6l2PiomW1QZeEy
 AC2ozbL5cybe1OUa6hrvmHb4by1OESu+pwtgI7u7/IBjwA6xbWB9TJovhaGrPRv0DTuPIUGctRI
 ZxI1eIDINT
X-Google-Smtp-Source: AGHT+IGwxysz3f93EvKep9i0UBRVjTdnj06JzMr0uNLJNcsgSPw3rmU24rV9dAf0P5hsI4DwaPbICgEBY/0VgKM7gNo=
X-Received: by 2002:a05:6102:508a:b0:4bb:dc3c:1b49 with SMTP id
 ada2fe7eead31-4c01e3030aemr3828514137.22.1740659192735; Thu, 27 Feb 2025
 04:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20250227111519.45787-1-sughosh.ganu@linaro.org>
 <20250227111519.45787-7-sughosh.ganu@linaro.org>
In-Reply-To: <20250227111519.45787-7-sughosh.ganu@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 27 Feb 2025 17:56:21 +0530
X-Gm-Features: AQ5f1Jq6LUKtR7O6TS-0R-cE2LY1UNVTDjCqTUBDpdECS6ZSRqg1WyrGdRumQRo
Message-ID: <CADg8p95Cgr279BF_qBJSgDxdCk37FrRnnb7McVZoOCop9NobHA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] blkmap: pass information on ISO image to the OS
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

On Thu, 27 Feb 2025 at 16:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI HTTP boot puts the ISO installer image at some location in
> memory. Information about this image has to be passed on to the OS
> kernel, which is done by adding a persistent memory(pmem) node to the
> devicetree(DT) that is passed to the OS. The OS kernel then gets
> information about the presence of this ISO image and proceeds with the
> installation.
>
> In U-Boot, this ISO image gets mounted as a memory mapped blkmap
> device slice, with the 'preserve' attribute. Add a helper function
> which iterates through all such slices, and invokes a callback. The
> callback adds the pmem node to the DT and removes the corresponding
> memory region from the EFI memory map. Invoke this helper function as
> part of the DT fixup which happens before booting the OS.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V4:
> * Reword the commit message
> * Add a helper function blkmap_get_preserved_pmem_slice()
> * Add a function pmem_node_efi_memmap_setup() for pmem node and EFI
>   memmap related setup
>
>  boot/image-fdt.c            |  7 ++++++
>  drivers/block/blkmap.c      | 43 +++++++++++++++++++++++++++++++++++++
>  include/blkmap.h            | 17 +++++++++++++++
>  include/efi.h               | 13 +++++++++++
>  lib/efi_loader/efi_helper.c | 37 +++++++++++++++++++++++++++++++
>  5 files changed, 117 insertions(+)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 9d1598b1a93..8f718ad29f6 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -11,6 +11,7 @@
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <fdtdec.h>
> +#include <efi.h>
>  #include <env.h>
>  #include <errno.h>
>  #include <image.h>
> @@ -649,6 +650,12 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>         if (!ft_verify_fdt(blob))
>                 goto err;
>
> +       if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> +               fdt_ret = fdt_efi_pmem_setup(blob);
> +               if (fdt_ret)
> +                       goto err;
> +       }
> +
>         /* after here we are using a livetree */
>         if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>                 struct event_ft_fixup fixup;
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index eefed615998..c9e0a3a6eea 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -498,6 +498,49 @@ err:
>         return err;
>  }
>
> +static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
> +{
> +       return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
> +               (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
> +}
> +
> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> +                                             u32 size), void *ctx)
> +{
> +       int ret;
> +       u32 size;
> +       ulong addr;
> +       struct udevice *dev;
> +       struct uclass *uc;
> +       struct blkmap *bm;
> +       struct blkmap_mem *bmm;
> +       struct blkmap_slice *bms;
> +       struct blk_desc *bd;
> +
> +       uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
> +               bm = dev_get_plat(dev);
> +               bd = dev_get_uclass_plat(bm->blk);
> +
> +               list_for_each_entry(bms, &bm->slices, node) {
> +                       if (!blkmap_mem_preserve_slice(bms) || !cb)
> +                               continue;

Realised after sending the patch that the check for the callback
function should be the first thing to happen outside the loops. Will
wait for other review comments, and incorporate this in the next
version.

-sughosh

> +
> +                       bmm = container_of(bms, struct blkmap_mem, slice);
> +                       addr = (ulong)(uintptr_t)bmm->addr;
> +                       size = (u32)bms->blkcnt << bd->log2blksz;
> +                       ret = cb(ctx, addr, size);
> +                       if (ret) {
> +                               log_err("Failed to setup pmem node for addr %#lx, size %#x\n",
> +                                       addr, size);
> +                               return -1;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +
> +}
> +
>  int blkmap_destroy(struct udevice *dev)
>  {
>         int err;
> diff --git a/include/blkmap.h b/include/blkmap.h
> index 754d8671b01..89bd2b65fba 100644
> --- a/include/blkmap.h
> +++ b/include/blkmap.h
> @@ -7,6 +7,7 @@
>  #ifndef _BLKMAP_H
>  #define _BLKMAP_H
>
> +#include <blk.h>
>  #include <dm/lists.h>
>
>  /**
> @@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
>  int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
>                           struct udevice **devp);
>
> +/**
> + * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
> + * @cb: Callback function to call for the blkmap slice
> + * @ctx: Argument to be passed to the callback function
> + *
> + * The function is used to iterate through all the blkmap slices, looking
> + * specifically for memory mapped blkmap mapping which has been
> + * created with the preserve attribute. The function looks for such slices
> + * with the relevant attributes and then calls the callback function which
> + * then does additional configuration as needed.
> + *
> + * Return: 0 on success, -1 on failure
> + */
> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
> +                                             u32 size), void *ctx);
> +
>  #endif /* _BLKMAP_H */
> diff --git a/include/efi.h b/include/efi.h
> index d005cb6181e..f9bbb175c3a 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
>   */
>  int efi_get_pxe_arch(void);
>
> +/**
> + * fdt_efi_pmem_setup() - Pmem setup in DT and EFI memory map
> + * @fdt: Devicetree to add the pmem nodes to
> + *
> + * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
> + * and add pmem nodes corresponding to the blkmap slice to the
> + * devicetree along with removing the corresponding region from the
> + * EFI memory map.
> + *
> + * Returns: 0 on success, negative error on failure
> + */
> +int fdt_efi_pmem_setup(void *fdt);
> +
>  #endif /* _LINUX_EFI_H */
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 04b2efc4a3b..675f3efa79a 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -5,6 +5,7 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> +#include <blkmap.h>
>  #include <bootm.h>
>  #include <env.h>
>  #include <image.h>
> @@ -680,3 +681,39 @@ out:
>
>         return ret;
>  }
> +
> +/**
> + * pmem_node_efi_memmap_setup() - Add pmem node and tweak EFI memmap
> + * @fdt: The devicetree to which pmem node is added
> + * @addr: start address of the pmem node
> + * @size: size of the memory of the pmem node
> + *
> + * The function adds the pmem node to the device-tree along with removing
> + * the corresponding region from the EFI memory map. Used primarily to
> + * pass the information of a RAM based ISO image to the OS.
> + *
> + * Return: 0 on success, -ve value on error
> + */
> +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
> +{
> +       int ret;
> +       efi_status_t status;
> +
> +       ret = fdt_fixup_pmem_region(fdt, addr, size);
> +       if (ret)
> +               return ret;
> +
> +       status = efi_remove_memory_map(addr, size,
> +                                      EFI_CONVENTIONAL_MEMORY);
> +       if (status != EFI_SUCCESS)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +int fdt_efi_pmem_setup(void *fdt)
> +{
> +
> +       return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
> +                                              fdt);
> +}
> --
> 2.34.1
>
