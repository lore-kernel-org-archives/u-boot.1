Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F6FCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B4B801A9;
	Fri, 19 Jun 2026 14:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CItaHzF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01E4849F7; Fri, 19 Jun 2026 14:46:53 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BC48005D
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so1167935a91.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781873209; cv=none;
 d=google.com; s=arc-20240605;
 b=ZALVpz1eOC+a5LGGG7+xTpqI3/LjSpZ2w8RBvdPrVtLjK7FdemCB/I+5h6L9tpCQlN
 uIIOSZkqCG4Vc/pg7//1sKrI20umH68aKGJMiyR6zJJuqUsz3CMOr33cd1Lmu7v3vM4b
 mgHPoMjz6//w9N2wggwZkEo2iZYVw4FvSc17k4MEoDDPXZKNa85w4V8/coyXM85+m+79
 phBgGZIv1iqIurSkOuqTitDJLlTk3cUPEeIuuhipAqBA41a7MoYxeLPHPCkEkyT9HmQI
 JVQW/Ffw88Vq+n+GTIEKdtijvjZFla7oQG25qrgrET8Fs90oiENlQt0ToGUH/y0UyttH
 weWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mBYZAOt06nvm3fMiW35jcE14wse2hQ/qfQv6+g1ZNJk=;
 fh=P5dfihBhuYb6HiPn4TVHGjBYMZhWTgXtL6TF3NUL5Q8=;
 b=MRXHbWaxpwPxROMICEnSGEehCuUx2sMcyS7Tn2Ft2kYlvvXOA3f4VxxP2CQ4jGG+0s
 A2yYb+JHMYjsneKgf12ExE6oX+vznik9NY3M814VGG1dAl+ot3GowQOWWXjlom8sVyr6
 MS49HZi/Yqj3+ISacfoHpL/36t86wIC1VGk8jeILN+ezBkRUyjbS/pSFB5i/hGal3YPh
 7YY+5+RQRduSnmMzO17SYsxHoCwOFbRHfrWDiGnIRe1AX/zaI1K5k+IXlijFNLdZaXVx
 JvxvO18Be/mkzKNp2vi0HCWKJzL0f7vXLfPaI+sak/WT/upvnjProfxglsKdkBcnIrIV
 mZmw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781873209; x=1782478009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mBYZAOt06nvm3fMiW35jcE14wse2hQ/qfQv6+g1ZNJk=;
 b=CItaHzF807Gnam8XJT9T8aIC5txoYBT4wZ+ALwUUQ1kfsfPMhEgQk2MuxVvPz6wntb
 Cnz5ipInwH6iNzRwiruErz4ctZ4bGoiqGHQg+dYe/MxVslh991vOcsR/gOjAO8ju5AQn
 LQH/C67MzCwLNUiBUCO74XsHovnZYBnKT3cIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781873209; x=1782478009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBYZAOt06nvm3fMiW35jcE14wse2hQ/qfQv6+g1ZNJk=;
 b=Ui2jhLWscwSKZ/YDKvfDefUEY7KScbJ63leSD3Q/awRk1oBIP5vFi4MXTk/zuPWG1r
 PhLEvQclMcCkeN1Q5/1VMu4Oxd12gtR8KnQu1TZHJo4Wt8b1MPzd1FvSuYXivKhKLRXC
 qaR6YrmbCDCEnHWrpY8peCUNFwGOL4AP0pYVlrUd2J+HlaaanXtp2xKYTu9KQf3dAhlm
 N0iqvcLb+YlVrMHmrL1u7kbgRM7gILn2NawU2ycUtMJ0yZwamn2Gz1six5sdTpeZNZvI
 C1XyTmv9Vu0i/8R507BVrCntZcUusk6CJo/zc8iNCFp+xuET0vG0r7AvhCc8VL2AwDnc
 vqbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gmiCp27qy7EPwX36/F5Ci4JF7hFXMYG9YmIdxXdns3hHpyQLPrukmzKX0WOHgRD+FCCSWw2w=@lists.denx.de
X-Gm-Message-State: AOJu0YyLdalTm/+4yfQmhSPVkVGswYT68ezg88OygX7+RRdgW6wWw4Do
 wsRy+8A/j1r5IL3yTHlkSzaXwxHFmi5k8LHA6dd2pwkjWjRNbSalhETPhE3NfmPFWg9HSfFX4Tx
 mXhH2UHq8qdkTIjdDsXeOmF79B4n8g+33corUdOdw
X-Gm-Gg: AfdE7ck7exy1N7xF/727i/zNgFbMr5pp7JMcXMafCmYN8ZE4cGOrhFM4oFVrxqkKK6K
 fZ+/9ywjXrT52Iv1cvYHanADCAC6qO1tJo45j1R5Kc/Y/40vCHp5fr1kcIqPiHGZ0ZBohGtIUGY
 TL8HzkIb9YC8a+1WmuPtM37IoLo+7Nd/9NWn8W/BvfXYqPjTdbxh8YRo06Fyzvfpza65idJS4qJ
 wgb2o6+YEv4UbeOaf16GiK5BM3wrAEtGALldsf6GdRkiFinK2JmP1HuwxWDP4MxeRKQ0jiaRaDp
 dwBySfqd
X-Received: by 2002:a17:902:ea08:b0:2c0:a711:539 with SMTP id
 d9443c01a7336-2c718ef88c4mr37792885ad.5.1781873208677; Fri, 19 Jun 2026
 05:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
 <20260616191845.6182-6-ansuelsmth@gmail.com>
In-Reply-To: <20260616191845.6182-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:46:14 +0100
X-Gm-Features: AVVi8CdQrhBZWoClknZoToPpOkRluJM1n6NDp0eO-JKpSdR0j2-0df7dvXoaZwc
Message-ID: <CAFLszTgR3+She6vFe-ji9rEpXShKoYLheDox3iJ22oxUX1MVVg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] misc: fw_loader: introduce FIP loader driver
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
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

Hi Christian,

On 2026-06-16T19:18:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: introduce FIP loader driver
>
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accelerator or PHY firmware blob.
>
> The way FIP handle image type is with the usage of UUID.
>
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
>
> Similar to FS loader, this driver also support both UBI and Block
> devices.
>
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
>
> An example usage of this driver is the following:
>
> [...]
>
> drivers/misc/Kconfig                      |  11 +
>  drivers/misc/fw_loader/Makefile           |   1 +
>  drivers/misc/fw_loader/fip_loader.c       | 544 ++++++++++++++++++++++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c |   3 +
>  drivers/misc/fw_loader/internal.h         |   2 +
>  5 files changed, 561 insertions(+)

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +static int fw_parse_storage_info(struct udevice *dev,
> +                              struct fip_storage_info *info)
> +{
> +     char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
> +     struct device_plat *plat = dev_get_uclass_plat(dev);
> +     int ret;
> +
> +     storage_interface = env_get('storage_interface');
> +     dev_part = env_get('fw_dev_part');
> +     ubi_mtdpart = env_get('fw_ubi_mtdpart');
> +     ubi_volume = env_get('fw_ubi_volume');
> +     info->part_offset = env_get_hex('fw_partoffset', 0);

A large chunk of this - the env lookups, the phandlepart resolution
and the mtdpart/ubivol fallback - duplicates
fw_get_filesystem_prepare()/select_fs_dev() in fs_loader.c almost
line-for-line. Please factor the common storage-selection logic into
the uclass (or into a helper in internal.h) so both drivers share one
implementation.

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +static int blk_parse_fip_firmware(struct firmware *firmwarep,
> +                               struct blk_desc *desc,
> +                               struct disk_partition *part_info,
> +                               unsigned int part_offset,
> +                               struct fip_toc_entry *dent)
> +{
> +     unsigned int offset = part_info->start + part_offset;

part_info->start is lbaint_t, which is 64-bit on most modern targets.
Storing it in unsigned int silently truncates partitions whose start
LBA is beyond 4G blocks; the same applies to blkstart further down and
to part_offset in struct fip_storage_info. Please use lbaint_t for the
on-device block coordinates.

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +#define TOC_HEADER_NAME      0xaa640001
> +
> +struct fip_toc_header {
> +     u32 name;
> +     u32 serial_number;
> +     u64 flags;
> +};
> +
> +struct fip_toc_entry {
> +     struct uuid uuid;
> +     u64 offset_address;
> +     u64 size;
> +     u64 flags;
> +};

These describe an on-disk format that TF-A defines as little-endian,
but the code reads them straight into native u32/u64 and compares with
TOC_HEADER_NAME directly. Do we have to worry about big-endian
targets?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +#ifdef CONFIG_CMD_UBIFS
> +static int ubi_parse_fip_firmware(struct firmware *firmwarep,
> +                               char *ubi_vol,
> +                               struct fip_toc_entry *dent)

The rest of the FW loader code gates UBI support with
CONFIG_IS_ENABLED(CMD_UBIFS) so it works correctly across SPL/VPL
phases. Please use the same idiom here, otherwise an SPL build with
CONFIG_SPL_CMD_UBIFS but no CONFIG_CMD_UBIFS will silently drop the
UBI path.

> diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  obj-y += fw_loader-uclass.o
> +obj-$(CONFIG_FIP_LOADER) += fip_loader.o
>  obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o

FS_LOADER uses the $(PHASE_) prefix so it can be enabled per-phase,
but FIP_LOADER is gated on a single non-phased symbol. Was that
intentional? If FIP is meant to be usable in SPL/TPL/VPL too (the
cover letter suggests it is), this should probably be
CONFIG_$(PHASE_)FIP_LOADER

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
> @@ -87,6 +87,9 @@ static int fw_loader_pre_probe(struct udevice *dev)
>
>               plat->ubivol = (char *)ofnode_read_string(fw_loader_node,
>                                                         'ubivol');
> +
> +             ofnode_read_u32(fw_loader_node, 'partoffset',
> +                             &plat->partoffset);
>       }

partoffset is a FIP-specific concept (a byte offset inside a partition
where the FIP image lives), but it is being parsed in the generic
uclass and stored in the common device_plat - either document it as
applying to every loader and have fs_loader honour it, or move the DT
read into the FIP driver so the uclass stays neutral.

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +static int fw_get_fip_firmware_size(struct udevice *dev)
> +{
> +     struct fip_storage_info info = { };
> +     struct firmware *firmwarep;
> +     struct fip_toc_entry ent;
> +     int ret;
> +
> +     ret = fw_parse_storage_info(dev, &info);
> +     if (ret)
> +             return ret;
> +
> +     firmwarep = dev_get_uclass_priv(dev);
> +     if (!firmwarep)
> +             return -EINVAL;
> +
> +     ret = parse_fip_firmware(firmwarep, &info, &ent);
> +     if (ret)
> +             return ret;
> +
> +     return ent.size;
> +}

get_size() returns ent.size, but the get_firmware() path treats the
usable size as ent.size - firmwarep->offset. A caller using
request_firmware_size() to size a buffer and then passing a non-zero
offset to request_firmware_into_buf() will get an over-large
allocation, or interpret size inconsistently between the two calls.
Please pick one definition (most likely ent.size - firmwarep->offset)
and use it in both ops.

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +#include <dm.h>
> +#include <div64.h>
> +#include <env.h>
> +#include <errno.h>
> +#include <blk.h>
> +#include <fs.h>
> +#include <linux/kernel.h>
> +#include <log.h>
> +#include <mapmem.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <part.h>
> +#include <u-boot/uuid.h>

map_to_sysmem()/memalign() are not used; please drop mapmem.h and
memalign.h. Also please sort the includes properly - e.g. blk.h should
come before dm.h

Regards,
Simon
