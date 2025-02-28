Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9868C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 06:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159088083E;
	Fri, 28 Feb 2025 07:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rIejowKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B269E80BA4; Fri, 28 Feb 2025 07:25:18 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4549801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 07:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so1559817276.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 22:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740723913; x=1741328713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F6WxbWBra16g22N2uizmoMRelNCp++5BqwoIMQYdBRM=;
 b=rIejowKhWl5ZPX0PVc9dbU6LEGJS/nsoUscR+Y9+eCo98iCscF0OXNasiTaqNXFgxl
 yLCUceliwG+KOuOx4SZtSwuzfHNtRzVIZJIIdRAXg20jtb9Wg6ukeC6aZe1dx+Z7sy26
 QsQSMePQAsUjiFANda8F0+4CFcSf5B1/m/ObrOd5OaqZnDG59oDVc/Yrj3Cba+nqAtvq
 WhbVlk4slypNmIJAsu3QrqSiuTcADIaH2qMCtn/Hk20ArhHX4mSk/6kcndCuTL7eHdVM
 9ah2v+9Aqh67868Yhg9EwBtzfiagGKl/WPoqf5wQFi2emmE0QJWL7nwpMuF7VvTVb+AV
 D/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740723913; x=1741328713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F6WxbWBra16g22N2uizmoMRelNCp++5BqwoIMQYdBRM=;
 b=Dcifg5mNpt8cP0NmV7NtmRrq54/0vcbNi8I0H3EwXbHirGGq/lGmIcgSIC/zP6eE90
 fZR4ykhNt7/AijHyD+f4XiaMi+NjqYBNXw4yuC+wY92WH5LDbvLEy/7tMAY2jL2JUatZ
 Rqk4mrkxZPazWR6KFEJoqGGhKMswESbzNpwfkycgJsR72hECZjwZiUnGNQmbCr0sABn8
 Cgxn5FXL63ySVGzbcKA/qhAU528be21xgQK9ZS3BGLDxREvX9eGbL4Yd+zfEaMBbdKTp
 TVTmr2NpUdJVlbhPAudBQ9XBRkZgFfgxXbmQ1YQhVlOza0MrdYwOK4k9tAWsBLkXFiRv
 9/xw==
X-Gm-Message-State: AOJu0Yx36fM27R4Ov5q6LKhMHf0knXNjpaFg6z7TtOOhU6q9PeQOXxbc
 /t4U3WfA1STzqtIqpdf5390sFbBeGJAj3HrSZWkT/UEA42bA5z4BJ3TQOQ4mnJVXW8IQ2PF675B
 yf7B0y1dyt4HGzm3Zylw2aCHmOaUBDW7mkGk63A==
X-Gm-Gg: ASbGncswMwhSaeCYw0mIYwT6iiCbGjNj8N6m173dJRwd1tdYxeDE21iIQ2JN9b2J7eB
 mQKPr6tRpMIIOSHHT0W3+No2BAFoyqW+WSwActWkAxWYnsH4TdllETFP2UFF8U87YzJvk0W01N/
 KfyD/mgJqa
X-Google-Smtp-Source: AGHT+IEK/46EcMv9RWkb2S3p/253vRZitbCk3n7+LtbKI0wfhlMWm7cKxi5X5ONfFdGOli8mR6U4Q7RqB2kCAZ4fauQ=
X-Received: by 2002:a05:6902:150b:b0:e54:dc5f:3ae8 with SMTP id
 3f1490d57ef6-e60b2f78428mr1932260276.48.1740723913448; Thu, 27 Feb 2025
 22:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20250227111519.45787-1-sughosh.ganu@linaro.org>
 <20250227111519.45787-6-sughosh.ganu@linaro.org>
In-Reply-To: <20250227111519.45787-6-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 08:24:37 +0200
X-Gm-Features: AQ5f1JotZPzl07JXBNHkE9BjSHV_Oy_FcuAVY4gce_26NtiN-TAq6jPgQXfx4h0
Message-ID: <CAC_iWjKVb9VpcfXqM5p+TqspkEfGdNSXT6w7vQnFAWsvRNriVg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] blkmap: add an attribute to preserve the mem
 mapping
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
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

Thanks Sughosh

On Thu, 27 Feb 2025 at 13:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Some blkmap memory mapped devices might have to be be relevant even
> after U-Boot passes control to the next image as part of the platform
> boot. An example of such a mapping would be an OS installer ISO image,
> information for which has to be provided to the OS kernel. Use the
> 'preserve' attribute for such mappings. The code for adding a pmem
> node to the device-tree then checks if this attribute is set, and adds
> a node only for mappings which have this attribute.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V4: New patch
>
>  cmd/blkmap.c                  |  9 +++++++--
>  drivers/block/blkmap.c        | 12 ++++++++----
>  drivers/block/blkmap_helper.c |  2 +-
>  include/blkmap.h              |  4 +++-
>  4 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/blkmap.c b/cmd/blkmap.c
> index 164f80f1387..86a123b1cd3 100644
> --- a/cmd/blkmap.c
> +++ b/cmd/blkmap.c
> @@ -62,13 +62,18 @@ static int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
>  {
>         phys_addr_t addr;
>         int err;
> +       bool preserve = false;
>
>         if (argc < 2)
>                 return CMD_RET_USAGE;
>
>         addr = hextoul(argv[1], NULL);
>
> -       err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr);
> +       if (argc == 3 && !strcmp(argv[2], "preserve"))
> +               preserve = true;
> +
> +       err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr,
> +                             preserve);
>         if (err) {
>                 printf("Unable to map %#llx at block 0x" LBAF ": %d\n",
>                        (unsigned long long)addr, ctx->blknr, err);
> @@ -221,7 +226,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
>         "blkmap create <label> - create device\n"
>         "blkmap destroy <label> - destroy device\n"
>         "blkmap map <label> <blk#> <cnt> linear <interface> <dev> <blk#> - device mapping\n"
> -       "blkmap map <label> <blk#> <cnt> mem <addr> - memory mapping\n",
> +       "blkmap map <label> <blk#> <cnt> mem <addr> [preserve] - memory mapping\n",
>         U_BOOT_SUBCMD_MKENT(info, 2, 1, do_blkmap_common),
>         U_BOOT_SUBCMD_MKENT(part, 2, 1, do_blkmap_common),
>         U_BOOT_SUBCMD_MKENT(dev, 4, 1, do_blkmap_common),
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 453510cca62..eefed615998 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -19,6 +19,7 @@ struct blkmap;
>  /* Attributes of blkmap slice */
>  #define BLKMAP_SLICE_LINEAR    BIT(0)
>  #define BLKMAP_SLICE_MEM       BIT(1)
> +#define BLKMAP_SLICE_PRESERVE  BIT(2)
>
>  /**
>   * struct blkmap_slice - Region mapped to a blkmap
> @@ -241,7 +242,7 @@ static void blkmap_mem_destroy(struct blkmap *bm, struct blkmap_slice *bms)
>  }
>
>  int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> -                    void *addr, bool remapped)
> +                    void *addr, bool remapped, bool preserve)
>  {
>         struct blkmap *bm = dev_get_plat(dev);
>         struct blkmap_mem *bmm;
> @@ -266,6 +267,9 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                 .remapped = remapped,
>         };
>
> +       if (preserve)
> +               bmm->slice.attr |= BLKMAP_SLICE_PRESERVE;
> +
>         err = blkmap_slice_add(bm, &bmm->slice);
>         if (err)
>                 free(bmm);
> @@ -276,11 +280,11 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>  int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                    void *addr)
>  {
> -       return __blkmap_map_mem(dev, blknr, blkcnt, addr, false);
> +       return __blkmap_map_mem(dev, blknr, blkcnt, addr, false, false);
>  }
>
>  int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> -                   phys_addr_t paddr)
> +                   phys_addr_t paddr, bool preserve)
>  {
>         struct blkmap *bm = dev_get_plat(dev);
>         struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
> @@ -291,7 +295,7 @@ int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>         if (!addr)
>                 return -ENOMEM;
>
> -       err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true);
> +       err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true, preserve);
>         if (err)
>                 unmap_sysmem(addr);
>
> diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
> index bfba14110d2..2f1bc28ee5d 100644
> --- a/drivers/block/blkmap_helper.c
> +++ b/drivers/block/blkmap_helper.c
> @@ -28,7 +28,7 @@ int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
>         bm = dev_get_plat(bm_dev);
>         desc = dev_get_uclass_plat(bm->blk);
>         blknum = image_size >> desc->log2blksz;
> -       ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr);
> +       ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr, true);
>         if (ret) {
>                 log_err("Unable to map %#llx at block %d : %d\n",
>                         (unsigned long long)image_addr, 0, ret);
> diff --git a/include/blkmap.h b/include/blkmap.h
> index d53095437fa..754d8671b01 100644
> --- a/include/blkmap.h
> +++ b/include/blkmap.h
> @@ -60,10 +60,12 @@ int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   * @blknr: Start block number of the mapping
>   * @blkcnt: Number of blocks to map
>   * @paddr: The target physical memory address of the mapping
> + * @preserve: Mapping intended to be preserved for subsequent stages,
> + *             like the OS (e.g. ISO installer)
>   * Returns: 0 on success, negative error code on failure
>   */
>  int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> -                   phys_addr_t paddr);
> +                   phys_addr_t paddr, bool preserve);
>
>  /**
>   * blkmap_from_label() - Find blkmap from label
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
