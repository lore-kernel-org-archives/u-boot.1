Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B301CE9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69E683D0F;
	Thu, 19 Feb 2026 14:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mdw7RT4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D878366F; Thu, 19 Feb 2026 14:09:37 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A330B83D0F
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so1670001a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506575; cv=none;
 d=google.com; s=arc-20240605;
 b=dtizaXlJJlxuM5Qcmn+x0OZWELsaBVkdu1zT0EjPqkB3/E9HnGzFxdg9hP6Xr41i9y
 LAPHNZ12RG8mRuOihRzhQNXbKUA4ItBfmOtuPIobeD2UFPNQUSwR8wwu2u5z+cfkRTSB
 2S0Rw6cB8J79JTWHB+/o65wE4DHVJ5K5ifPqN91ao7g48xGbxYxV2I5tHF7/R7pNLG+N
 C/hYOT0TUDfbCWeTzHYnXSjHPuFDDrO6tfhXqg8Z2H5MY3gII9BZOfdc2UUMQB+ZjoeJ
 xbF8KGxdkxnBbV3Ewc/aJuVhDYYB+JwTrVtDqTJjOFjDmOmBD1F/l1726b0hyPe2+xAT
 qjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CtTC1ViSGWQSfVbBqRhNADnJDSjISApxVBW1WKgGbJw=;
 fh=afMamCyVH4nn/9Q6+cNwe8tBeIS7yQah2kEnMcw7z8c=;
 b=iAzA2fRhA6SIPJPdOdCqg5t/fYBn560jzFWYIQd0gXYvIVlqXVXZO5T2Xqi5lThfUy
 0Gpg71HBM4PCFfQDAvfTqElAl3wSUdZhdk2Dco9Df0AVwyYh0cXqfA0DhJo9/gAPqpqT
 qSYawbPQC5eKa8DsNxw8u0p/eDfyGF7SFGfXHgpgyVymySu86zLlQJvNMKWOymbO5NYC
 J+FQx3XRT2jGi7lxRub9xL/3ZbJqBv7RlfY9G6OowsJMv7GTIqIj1KeQrJf/4un+40b7
 2QT+Q5lTe8BT+JHg0R5rxPAJHtrie02qOX4aaFP5lpbWUlb3wi/A9UZI9pioABioiNMW
 qIoA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506575; x=1772111375; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtTC1ViSGWQSfVbBqRhNADnJDSjISApxVBW1WKgGbJw=;
 b=mdw7RT4aC9NT/FoBLkEyoxTK5kCn2/c98P0NN7fjEod6lS4skUCjmeipH8i7HYzVM4
 Pc28Q03UOtQYUXpwyhBtlG6NWmDJSQg1F1ZmzT20KT5i4fjY/W/kKe/uv1T5XfZsyM1R
 r0RZQXBViVF4S2UXxJwGJQzuOy7z6RDp2uriI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506575; x=1772111375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CtTC1ViSGWQSfVbBqRhNADnJDSjISApxVBW1WKgGbJw=;
 b=eW5h7uobCO+C9p6dm+p+gZpcGrx0IXdNa7EXHFknxJy5Jfjca5yeI2aqZo75lzYOkH
 oENDCPjDs1rJnBTOEwsu6wcSRYwF+JrGUgSvbxWy/gVcjd7M607MKQl0octq1KFGFYDH
 DrzT8xh0N0Rr1sMXxnBLtftthIRuY3TFrsPY+YaFGRt6wzACiUhYRSGmNQ+B2xCsb9xo
 LRes2KfSLjFTxvQMep0srMt5XicXVCGGqbWOtaLer4mplXeoY1/RR+1ea5pTpZHNH5Nr
 27OPL2kTcgBjkNb4SjB9Tcbj0sitQ7rRmcRUiQzCq+uwTm0y4M4b26KPagJ9sAcnK18e
 CHzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjk19fgJudUQ5EbseX6PwXFm8R12FetxlpldDRTn0OSu7UXWwQG3cbM0mE3lLi9g+sPUzU48w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0gMcRSOLquZPmiGI4AtZBdHd8fG2WeTXFfLNrFFvSTEc8YfoS
 I4tfzXIq5caVVqSAjJst9GBp2sz8nOJJlOoRNIseuffmXjXOBAwsp98PV+nrDOqDmJJEpH+3wXe
 2kSn6eAuwtM8+S25eyNMxLg2VX2+Ht7Uj643sL4z/
X-Gm-Gg: AZuq6aJezlrecXqmNh9/RhAZOe2XyP2AKsd8eUn4qn07CjA3t//kdDzLBxRPWy1xxgw
 i9E77QZhE0SG2p05IzzLcDfnFGVH5E9NxkBdZkDQMidDjyyXh62IGhpab2fI34wUYMBY+Gclhvm
 awVCK/d9Z+sNMTj3wEfuyhAG5sQrHxn7OkCD0RPPsFLSS9rT0Lm2i8+lzh4Y9YKUuP+/8THKP1L
 mj0F0SDDDPEh77BXXwM5IcHWS8xEdewj6A0PgYV1qOCPdmRzJVNLHFvy8vATrN07mzvOLfnfSsT
 kcn0Nua69A+m4oCd
X-Received: by 2002:a05:6402:1468:b0:64d:2889:cf42 with SMTP id
 4fb4d7f45d1cf-65bc784b143mr8986911a12.2.1771506574971; Thu, 19 Feb 2026
 05:09:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <9b0880ae234d8244f032eac6cee32a1031de26a3.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <9b0880ae234d8244f032eac6cee32a1031de26a3.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:22 -0700
X-Gm-Features: AaiRm53WaM569OhTr_EsvsYhnheUS9ODMgHznMaRMXHtZlnHKFa1Qb5-OakcG1U
Message-ID: <CAFLszTjq8CGAQkDOmr0k55Pek4E59L=GfJbGbLZ0ij4M+0AY6A@mail.gmail.com>
Subject: Re: [RFC PATCH 02/20] boot: image-loader: add block device backend
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:21, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add a block device storage backend for the image_loader framework.
>
> image_loader_init_blk() takes a device and partition specification
> string, resolves the partition, and installs a .read() callback that
> translates byte-offset reads into blk_dread() calls with proper
> sector alignment.
>
> Partitions can be identified by number or by name, following the
> syntax of part_get_info_by_dev_and_name_or_num():
>   "0:4"        partition 4 on device 0
>   "0#kernel"   partition named "kernel" on device 0
>
> This is important for systems where partition numbers are not stable
> across firmware updates.
>
> Sub-sector reads (offset or size not aligned to blk_desc->blksz) use
> a single-sector bounce buffer to avoid overreading into adjacent RAM.
>
> The .cleanup callback frees the allocated private context.
>
> Gated by CONFIG_IMAGE_LOADER_BLK (depends on BLK && PARTITIONS &&
> IMAGE_LOADER).
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig            |   8 +++
>  boot/Makefile           |   1 +
>  boot/image-loader-blk.c | 133 ++++++++++++++++++++++++++++++++++++++++
>  include/image-loader.h  |  20 ++++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 boot/image-loader-blk.c
>

Yes, this should be a driver, a child of the device that provides its
media, in this case a UCLASS_BLK. You can see a similar pattern with
UCLASS_BOOTDEV

You can use probe() and remove() to set up and clean up.

> diff --git a/boot/Kconfig b/boot/Kconfig
> index f6908e04a51..e94b52288a3 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1187,6 +1187,14 @@ config IMAGE_LOADER_MAX_REGIONS
>           images (FDT structure + kernel + device tree + ramdisk +
>           a few loadable sub-images).
>
> +config IMAGE_LOADER_BLK
> +       bool "Block device backend for image loader"
> +       depends on IMAGE_LOADER && BLK && PARTITIONS
> +       help
> +         Allows loading images from block device partitions (MMC, SATA,
> +         USB, etc.) using the image_loader framework. Partitions can
> +         be identified by number or name.
> +
>  config DISTRO_DEFAULTS
>         bool "(deprecated) Script-based booting of Linux distributions"
>         select CMDLINE
> diff --git a/boot/Makefile b/boot/Makefile
> index 1dbc285dad8..ac006bbaa82 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) +=3D vbe_=
simple_os.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) +=3D bootmeth_android.o
>
>  obj-$(CONFIG_IMAGE_LOADER) +=3D image-loader.o
> +obj-$(CONFIG_IMAGE_LOADER_BLK) +=3D image-loader-blk.o
>
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) +=3D vbe_abrec.o vbe_common.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) +=3D vbe_abrec_fw.o
> diff --git a/boot/image-loader-blk.c b/boot/image-loader-blk.c
> new file mode 100644
> index 00000000000..3f9a309a60c
> --- /dev/null
> +++ b/boot/image-loader-blk.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Block device backend for image_loader
> + *
> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <blk.h>
> +#include <image-loader.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <part.h>
> +#include <log.h>
> +
> +struct image_loader_blk_priv {
> +       struct blk_desc *desc;
> +       lbaint_t part_start;
> +       lbaint_t part_size;
> +};

Needs a comment. The 'desc' won't be needed when this is a driver
since you can use dev_get_parent(your_dev) which will be a block
device.

> +
> +/**
> + * blk_read_partial() - Read a partial sector via bounce buffer
> + *
> + * Reads one full sector into a stack-allocated bounce buffer, then
> + * copies @len bytes starting at byte offset @skip within that sector
> + * into @dst.
> + *
> + * @desc:      Block device descriptor
> + * @lba:       Absolute LBA of the sector to read
> + * @skip:      Byte offset within the sector

So maybe call it 'offset' ?

> + * @len:       Number of bytes to copy
> + * @dst:       Destination buffer
> + * Return: 0 on success, -EIO on read failure
> + */
> +static int blk_read_partial(struct blk_desc *desc, lbaint_t lba,
> +                           ulong skip, ulong len, void *dst)
> +{
> +       ALLOC_CACHE_ALIGN_BUFFER(u8, sec, desc->blksz);
> +
> +       if (blk_dread(desc, lba, 1, sec) !=3D 1)
> +               return -EIO;
> +
> +       memcpy(dst, sec + skip, len);
> +
> +       return 0;
> +}
> +
> +static int image_loader_blk_read(struct image_loader *ldr, ulong src,
> +                                ulong size, void *dst)
> +{
> +       struct image_loader_blk_priv *priv =3D ldr->priv;
> +       struct blk_desc *desc =3D priv->desc;
> +       unsigned long blksz =3D desc->blksz;

ulong

> +       lbaint_t lba =3D priv->part_start + src / blksz;
> +       ulong head =3D src % blksz;
> +       u8 *out =3D dst;
> +       lbaint_t n;
> +       int ret;
> +
> +       /* Bounds check */
> +       if (src + size > (ulong)priv->part_size * blksz) {
> +               log_err("image_loader_blk: read at 0x%lx+0x%lx exceeds pa=
rtition size\n",
> +                       src, size);
> +               return -EINVAL;
> +       }
> +
> +       /* Handle unaligned head */
> +       if (head) {
> +               ulong chunk =3D min(size, blksz - head);
> +
> +               ret =3D blk_read_partial(desc, lba, head, chunk, out);
> +               if (ret)
> +                       return ret;
> +
> +               out +=3D chunk;
> +               size -=3D chunk;
> +               lba++;
> +       }
> +
> +       /* Aligned middle =E2=80=94 read whole sectors directly into dst =
*/
> +       if (size >=3D blksz) {
> +               n =3D size / blksz;
> +
> +               if (blk_dread(desc, lba, n, out) !=3D n)
> +                       return -EIO;
> +
> +               out +=3D n * blksz;
> +               size -=3D n * blksz;
> +               lba +=3D n;
> +       }
> +
> +       /* Handle unaligned tail */
> +       if (size) {
> +               ret =3D blk_read_partial(desc, lba, 0, size, out);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void image_loader_blk_cleanup(struct image_loader *ldr)
> +{
> +       free(ldr->priv);

This is handled automatically by driver model.

> +}
> +
> +int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
> +                         const char *dev_part_str)
> +{
> +       struct image_loader_blk_priv *priv;
> +       struct blk_desc *desc;
> +       struct disk_partition info;
> +       int ret;
> +
> +       ret =3D part_get_info_by_dev_and_name_or_num(ifname, dev_part_str=
,
> +                                                  &desc, &info, 0);
> +       if (ret < 0)
> +               return ret;
> +
> +       priv =3D malloc(sizeof(*priv));
> +       if (!priv)
> +               return -ENOMEM;

and this

> +
> +       priv->desc =3D desc;
> +       priv->part_start =3D info.start;
> +       priv->part_size =3D info.size;
> +
> +       ldr->read =3D image_loader_blk_read;
> +       ldr->cleanup =3D image_loader_blk_cleanup;
> +       ldr->priv =3D priv;
> +
> +       return 0;
> +}
> diff --git a/include/image-loader.h b/include/image-loader.h
> index e273b1ca50f..1a9048ba482 100644
> --- a/include/image-loader.h
> +++ b/include/image-loader.h
> @@ -138,4 +138,24 @@ void *image_loader_map(struct image_loader *ldr, ulo=
ng img_offset,
>  void *image_loader_map_to(struct image_loader *ldr, ulong img_offset,
>                           ulong size, void *dst);
>
> +/**
> + * image_loader_init_blk() - Initialise loader for a block device partit=
ion
> + *
> + * Resolves the partition using @ifname and @dev_part_str, then installs
> + * a .read() callback that translates byte-offset reads into blk_dread()
> + * calls. The dev_part_str accepts the same formats as
> + * part_get_info_by_dev_and_name_or_num():
> + *
> + *   "0:4"        partition 4 on device 0
> + *   "0#kernel"   partition named "kernel" on device 0
> + *   "0:1"        partition 1 on device 0
> + *
> + * @ldr:               The image loader to initialise
> + * @ifname:            Block interface name (e.g. "mmc", "scsi")
> + * @dev_part_str:      Device and partition specification
> + * Return: 0 on success, negative errno on failure
> + */
> +int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
> +                         const char *dev_part_str);
> +
>  #endif /* __IMAGE_LOADER_H */
> --
> 2.53.0

Regards,
Simon
