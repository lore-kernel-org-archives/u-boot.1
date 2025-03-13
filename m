Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE1C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA1280756;
	Thu, 13 Mar 2025 08:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sYgu5TsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1743F810F4; Thu, 13 Mar 2025 08:38:09 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8261480548
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86d6ac4d5a9so323490241.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741851478; x=1742456278; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=76q6f41WzNI1FUDsJ16uhLOnRS6rY20gWc6jtLpnLhg=;
 b=sYgu5TsNsVygevCRvQl6k27sGFinJhgLrkwwO1O5gXnyKnj30O1xLiLHqD1kywCAzB
 58LxyIZt79aFLuvXGstrmVHWLa8ygOwQjk/6Pi1iT6M6yMuxHkD1FjGTCUK/FjQaG3dZ
 syfrveB384FMBL9E6RjOlc/oahXmLK4FmLJqK6N+lFqOBFvP/lK65JlHlMpex7PNkdr1
 LHajTKTgwtliJFpbX8aC9HvGvUeUSLeK4Ebc8rwathPxbO/D7vBtMssS8HQflqA7S/8b
 Y3atuN22iYg9qGuzlYW0fACQlmI2YNZ6aKlCjJQWsWbnQOwZjTSXmm5/R+0S4GZhH0uT
 puWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741851478; x=1742456278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76q6f41WzNI1FUDsJ16uhLOnRS6rY20gWc6jtLpnLhg=;
 b=wpXWlZVqH3p8ZViUv5n0ONMFA8F7L8gnoBTLq6lajYqeh4b8c2jHZC0SpTct9WPkHV
 i+QVlMZU6by2eMxJ8WkSgK2y56QG3qbKEGkd2OoGqJuRD+iR4M0+DJs5YjFnNK8RrJqO
 yeBw7pxb3b/jD3bbaHQDFcwGxU4VnhiegACZeUbWl5WQG1ydnCu8egpfjwbnzRQmGcWV
 8Kleb7VC6D8IeaZYaUFCSXlpIcXsehIuGK4KYTlIF2LmuOc5n2l5DGYbTmojxdE4ExZg
 8Kt+UuZfam8FoThLmt2d/2zOd+Lk7vkbTu2ojymhDEMjzseA97XylgO2Ec9qwXy7J3ea
 gvEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS46eBcFn7dKQQPOix+ianCexHyrGK6gpIrbMCf/bdxrDlB4iJovcfwgTEffdSFykaS7Hm8iw=@lists.denx.de
X-Gm-Message-State: AOJu0YwtkzP44EqkSgPzUGaPyR4J6WwOp1ciV6AC6HTiGd52pHJgoc4O
 c55TyiYq4WGMsEhMZCXL1QEwIpXnKTioMWixcP837s62/1apijKjuLeuEtXGOceNNaZvnHOavak
 XXm75Zp3ji9fRE/oPXLuAvnrlrirXNo2z9BK/Rw==
X-Gm-Gg: ASbGncsCWQ9BoUX1KAiq7ONd5fANmntFBw3LBmO2V/tamVCxRohHut1QVmexMjKdapM
 D16dez4aHp0ZJkbkdKXPwcYjkU0xm3k+y2vSrDT3ApqMBHbQ5qcu1GimCEXkt6UaKY4xwSWsFKv
 6Tcebd866xOvc71Jo5yWl6lpGvyE4=
X-Google-Smtp-Source: AGHT+IGmJx6PgtPH/7qGniT+1cRsOFnKbT3T/qFYJskVUx8mWj4pXVE05JKgbo3oosjqD433h7jGWqVDt0ARQhJu3hw=
X-Received: by 2002:a05:6102:41a4:b0:4c3:6546:5456 with SMTP id
 ada2fe7eead31-4c365465d5bmr6436866137.3.1741851478104; Thu, 13 Mar 2025
 00:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-8-sughosh.ganu@linaro.org>
 <32b11359-c517-4556-a24d-f4cb2c5c60f1@canonical.com>
In-Reply-To: <32b11359-c517-4556-a24d-f4cb2c5c60f1@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 13:07:47 +0530
X-Gm-Features: AQ5f1JrgonPKSBXPxQMpOru4jvbdgrJiMXYQMNstcfEbKVYb38Jz2RFIIfxeYWY
Message-ID: <CADg8p95XMj+Ti58Nw0dRPEMH1EzbPcOUadgVa+QJy1fpxp7fEQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] blkmap: add an attribute to preserve the mem
 mapping
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

On Thu, 13 Mar 2025 at 02:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > Some blkmap memory mapped devices might have to be relevant even after
> > U-Boot passes control to the next image as part of the platform
> > boot. An example of such a mapping would be an OS installer ISO image,
> > information for which has to be provided to the OS kernel. Use the
> > 'preserve' attribute for such mappings. The code for adding a pmem
> > node to the device-tree then checks if this attribute is set, and adds
> > a node only for mappings which have this attribute.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since V7:
> > * Fix repeated word in the commit message
> >
> >   cmd/blkmap.c                  |  9 +++++++--
> >   drivers/block/blkmap.c        | 12 ++++++++----
> >   drivers/block/blkmap_helper.c |  2 +-
> >   include/blkmap.h              |  4 +++-
> >   4 files changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/cmd/blkmap.c b/cmd/blkmap.c
> > index 164f80f1387..86a123b1cd3 100644
> > --- a/cmd/blkmap.c
> > +++ b/cmd/blkmap.c
> > @@ -62,13 +62,18 @@ static int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
> >   {
> >       phys_addr_t addr;
> >       int err;
> > +     bool preserve = false;
> >
> >       if (argc < 2)
> >               return CMD_RET_USAGE;
> >
> >       addr = hextoul(argv[1], NULL);
> >
> > -     err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr);
> > +     if (argc == 3 && !strcmp(argv[2], "preserve"))
> > +             preserve = true;
> > +
> > +     err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr,
> > +                           preserve);
> >       if (err) {
> >               printf("Unable to map %#llx at block 0x" LBAF ": %d\n",
> >                      (unsigned long long)addr, ctx->blknr, err);
> > @@ -221,7 +226,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
> >       "blkmap create <label> - create device\n"
> >       "blkmap destroy <label> - destroy device\n"
> >       "blkmap map <label> <blk#> <cnt> linear <interface> <dev> <blk#> - device mapping\n"
> > -     "blkmap map <label> <blk#> <cnt> mem <addr> - memory mapping\n",
> > +     "blkmap map <label> <blk#> <cnt> mem <addr> [preserve] - memory mapping\n",
> >       U_BOOT_SUBCMD_MKENT(info, 2, 1, do_blkmap_common),
> >       U_BOOT_SUBCMD_MKENT(part, 2, 1, do_blkmap_common),
> >       U_BOOT_SUBCMD_MKENT(dev, 4, 1, do_blkmap_common),
> > diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> > index 453510cca62..eefed615998 100644
> > --- a/drivers/block/blkmap.c
> > +++ b/drivers/block/blkmap.c
> > @@ -19,6 +19,7 @@ struct blkmap;
> >   /* Attributes of blkmap slice */
> >   #define BLKMAP_SLICE_LINEAR BIT(0)
> >   #define BLKMAP_SLICE_MEM    BIT(1)
>
> Documentation is missing here.

Yeah you mentioned this in the earlier commit where this was added. I
will add the documentation for this.

-sughosh

>
> Cf.
> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation
>
> > +#define BLKMAP_SLICE_PRESERVE        BIT(2)
> >
> >   /**
> >    * struct blkmap_slice - Region mapped to a blkmap
> > @@ -241,7 +242,7 @@ static void blkmap_mem_destroy(struct blkmap *bm, struct blkmap_slice *bms)
> >   }
> >
> >   int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> > -                  void *addr, bool remapped)
> > +                  void *addr, bool remapped, bool preserve)
> >   {
> >       struct blkmap *bm = dev_get_plat(dev);
> >       struct blkmap_mem *bmm;
> > @@ -266,6 +267,9 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >               .remapped = remapped,
> >       };
> >
> > +     if (preserve)
> > +             bmm->slice.attr |= BLKMAP_SLICE_PRESERVE;
> > +
> >       err = blkmap_slice_add(bm, &bmm->slice);
> >       if (err)
> >               free(bmm);
> > @@ -276,11 +280,11 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >   int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >                  void *addr)
> >   {
> > -     return __blkmap_map_mem(dev, blknr, blkcnt, addr, false);
> > +     return __blkmap_map_mem(dev, blknr, blkcnt, addr, false, false);
> >   }
> >
> >   int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> > -                 phys_addr_t paddr)
> > +                 phys_addr_t paddr, bool preserve)
> >   {
> >       struct blkmap *bm = dev_get_plat(dev);
> >       struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
> > @@ -291,7 +295,7 @@ int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >       if (!addr)
> >               return -ENOMEM;
> >
> > -     err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true);
> > +     err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true, preserve);
> >       if (err)
> >               unmap_sysmem(addr);
> >
> > diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
> > index bfba14110d2..2f1bc28ee5d 100644
> > --- a/drivers/block/blkmap_helper.c
> > +++ b/drivers/block/blkmap_helper.c
> > @@ -28,7 +28,7 @@ int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
> >       bm = dev_get_plat(bm_dev);
> >       desc = dev_get_uclass_plat(bm->blk);
> >       blknum = image_size >> desc->log2blksz;
> > -     ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr);
> > +     ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr, true);
> >       if (ret) {
> >               log_err("Unable to map %#llx at block %d : %d\n",
> >                       (unsigned long long)image_addr, 0, ret);
> > diff --git a/include/blkmap.h b/include/blkmap.h
> > index d53095437fa..754d8671b01 100644
> > --- a/include/blkmap.h
> > +++ b/include/blkmap.h
> > @@ -60,10 +60,12 @@ int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >    * @blknr: Start block number of the mapping
> >    * @blkcnt: Number of blocks to map
> >    * @paddr: The target physical memory address of the mapping
> > + * @preserve: Mapping intended to be preserved for subsequent stages,
> > + *           like the OS (e.g. ISO installer)
> >    * Returns: 0 on success, negative error code on failure
> >    */
> >   int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> > -                 phys_addr_t paddr);
> > +                 phys_addr_t paddr, bool preserve);
> >
> >   /**
> >    * blkmap_from_label() - Find blkmap from label
>
