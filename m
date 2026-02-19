Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E939DE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF58583E23;
	Thu, 19 Feb 2026 14:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cYOCLXig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9269583936; Thu, 19 Feb 2026 14:11:09 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9465E83E21
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b883c8dfb00so179452666b.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506656; cv=none;
 d=google.com; s=arc-20240605;
 b=Bkzcr4b/OMnUXl9M2kBHl638wp3hgcr2PwxV4mwVq8LSogfEW32hgNhGUtHIUF2sra
 672ojYoldPnnHJstAlqDpSv3hmAvEi8tWiUxZYJoIBRS5cHvSi4aZ+Nn/Jy9fVoug8fe
 ooWNz8QIeXQ2vN2I0SDw4mY0soihLjNs9W37841pBQ8s0ramPBRixK/Y8tzpH0hAO/ZO
 sdomyIpCIfQdOKarM78EOU0UwmaGj5ziffkMvpzm9aVPqa/QQGTykzQ1jMPBhEXT7C8g
 xuDBjixTUnda42KP+A6gX5MaGcAWMOOCXo+r47PywN9R/cKoLEWJRaWhWgrbW8u4VQEE
 Y4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LEtdhG8uvf0ZuyCgKL4EEk47SJGG9Z9AfVMF1tyHwdQ=;
 fh=orZP/9a0Sl76UUdnZjcGxQpIGyDZwWsEHTYHCHug5Ns=;
 b=VKZDX05r79O0s5J6mxluc1Z1RfwXARU9UmHzKSp5mhvSgMyaRj/pk2n7idoOD+qGit
 XbrUGelKxHUVvMh8tKO78rW7UzYng0k2l1K2YeIqaeshP6wiUlN6NbzMPd8h8jw+dtXw
 Vj1jeHsNRNemZCqEne/P/lg04adbSt7X7w6Zs0OSuWIFGJ1eusNe6xCBHw3yGjMPhCCw
 eRDC/1CAOc+WGsOOco6vlO4yyU8oNncRPLaWBaQ7UmsmMqZu0vSD7z3JIm+p9garSavi
 hdhYFcPtnZ9CNHulW7NsQhhBs3tZsPgwq+pID4eKdn/2Ii5QrUyUpzlqMCgywtz/0ege
 Llvg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506656; x=1772111456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LEtdhG8uvf0ZuyCgKL4EEk47SJGG9Z9AfVMF1tyHwdQ=;
 b=cYOCLXigWalgp4KUBKWpD65nKfaW3uT/7qiWteDvRkNc7ytkWSU/40B9SfjXiLhcip
 KbBw3Caz+v+mmxQsJtHKGGIGRC8V/eG+YfNCriJwQBKRJh0GXWf3+KqHeVdVk8jT/Msd
 u9dLaMH6L2XltXjXCpnquxobHCW67CrQb2JIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506656; x=1772111456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEtdhG8uvf0ZuyCgKL4EEk47SJGG9Z9AfVMF1tyHwdQ=;
 b=l69BojhU2yZ8ZEoXD1f66zB8sjlu8Oesvigbz668NZ8ivxgIkwfh777FbMiZe+iCvK
 TQZRUfi3Qef1Bg7vHUnd7YBhq8IxFRlax1E3DWSiEfCvRXzvx9Tk1HTbDfEfIpSHaVHB
 3Pf8o3tYRjWnzIJoFZGHBuHZUFhpHjYKdz2M2aT/hi5bfBmOwVE6NCIBm2Np42Mf4d6y
 TMp8urJEVnol0ahb7j1MWxAiBxXzFXwvVutgTzbJz0dVEL+qhVvedT3XSPtHaB7MFLeW
 5o7roeX/pDCSuqh6Sl9+rou+DhqnqHHsUeVOB/aDph4RxPw0k9CWoxsq56LpEuXp3Hg+
 JDsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNclm/1Ra00O86YIzl2+tNWACiB8glvouLBNMrafMs8MsKAlxwmwwM/1VF719P/TORb7AwvRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzCQWodjm/gBCib/zjQIEzxjd5dew3M3yQwQ6uVytnafqawJLV4
 pqpK7twqYZ6cKd25+r7y0+1F4kB94mVF4Yaqxi99ADXeKIrD5i39juxKGIqZGBZW5s3xvd5QOFx
 svrx+odV7IJjCg2ZXJS6C/fBZkaQJ60Y4suXB+qoq
X-Gm-Gg: AZuq6aKS8GPvjjRTAnd0sZ10GQltVG9R869clA/4M4o22ZPUeo32FYCA4Em54h1B2+i
 OaP7vHJ5e7SIK78ZQmTtr7yb83IaimqKXov04Y/xDdki8jSmY1Q687zms8VP5Ojbufrl31kdajt
 MK0xu/O/mGG41CGFCH7W2fD98pHpebXQytlphMkUAUOcbr3W1kj6Z8ohH7wBRXFsLpAxQ1tbmSm
 SFMYKLda7uRQmA0+PHJbxT1cncFKn8NnWauh6lPbuqKFCeKJQK2PekKfa8ozbFe/jTZO2N+OXDS
 RXSGgw==
X-Received: by 2002:a17:906:f5a5:b0:b87:2abc:4a32 with SMTP id
 a640c23a62f3a-b903da926b7mr348612966b.18.1771506656398; Thu, 19 Feb 2026
 05:10:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:27 -0700
X-Gm-Features: AaiRm51wZCILQQpzgbMJoNMLXM8asttk5QYQfdHuJ0BI2wN6ecWIdtq8Hgds_aM
Message-ID: <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
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

On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add a UBI volume storage backend for the image_loader framework.
>
> image_loader_init_ubi() takes a volume name, ensures the UBI device
> is attached (auto-attaching if needed), and installs a .read() callback
> wrapping ubi_volume_read().
>
> Auto-attach works by scanning the device tree for the first MTD
> partition with compatible = "linux,ubi", then calling ubi_part() on
> that partition. The partition name is resolved using the same
> precedence as the MTD partition parser: the "label" property first,
> then "name", then the node name. Since U-Boot only supports a single
> attached UBI device at a time, only the first matching partition is
> used. If a UBI device is already attached, the auto-attach step is
> skipped.
>
> UBI handles bad-block management and wear leveling internally, so the
> read callback is a straightforward passthrough. Note that
> ubi_volume_read() returns positive errno values; the wrapper negates
> them for the image_loader convention.
>
> Gated by CONFIG_IMAGE_LOADER_UBI (depends on CMD_UBI && IMAGE_LOADER).
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig            |   8 +++
>  boot/Makefile           |   1 +
>  boot/image-loader-ubi.c | 112 ++++++++++++++++++++++++++++++++++++++++
>  include/image-loader.h  |  13 +++++
>  4 files changed, 134 insertions(+)
>  create mode 100644 boot/image-loader-ubi.c
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 23848a0f57e..89832014af6 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1203,6 +1203,14 @@ config IMAGE_LOADER_MTD
>           parallel NAND, etc.) using the image_loader framework.
>           NAND bad blocks are skipped transparently.
>
> +config IMAGE_LOADER_UBI
> +       bool "UBI volume backend for image loader"
> +       depends on IMAGE_LOADER && CMD_UBI
> +       help
> +         Allows loading images from UBI volumes using the image_loader
> +         framework. Auto-attaches the UBI device from the device tree
> +         if not already attached.
> +
>  config DISTRO_DEFAULTS
>         bool "(deprecated) Script-based booting of Linux distributions"
>         select CMDLINE
> diff --git a/boot/Makefile b/boot/Makefile
> index 1dde16db694..7d1d4a28106 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
>  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
>  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
>  obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
> +obj-$(CONFIG_IMAGE_LOADER_UBI) += image-loader-ubi.o
>
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
> diff --git a/boot/image-loader-ubi.c b/boot/image-loader-ubi.c
> new file mode 100644
> index 00000000000..64901a13378
> --- /dev/null
> +++ b/boot/image-loader-ubi.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * UBI volume backend for image_loader
> + *
> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <dm/ofnode.h>
> +#include <image-loader.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mtd.h>
> +#include <ubi_uboot.h>
> +
> +struct image_loader_ubi_priv {
> +       char *vol_name;
> +};
> +
> +/**
> + * ubi_auto_attach() - attach UBI if not already attached
> + *
> + * If no UBI device is currently attached, walk the device tree for the
> + * first MTD partition node with compatible = "linux,ubi", find the
> + * corresponding MTD device by matching flash_node, and attach UBI to
> + * it via ubi_part_from_mtd().
> + *
> + * Since U-Boot only supports a single attached UBI device at a time,
> + * only the first matching partition is used.
> + *
> + * Return: 0 on success or if already attached, negative errno on failure
> + */
> +static int ubi_auto_attach(void)
> +{
> +       struct mtd_info *mtd;
> +       ofnode node;
> +
> +       /* Already attached? */
> +       if (ubi_devices[0])
> +               return 0;
> +
> +       mtd_probe_devices();

This should be handled by your new ubi driver for your uclass.

> +
> +       ofnode_for_each_compatible_node(node, "linux,ubi") {
> +               mtd_for_each_device(mtd) {
> +                       if (ofnode_equal(mtd->flash_node, node))
> +                               goto found;
> +               }
> +       }

Eek this is really strange. There should be a device so you can use
uclass_first_device(UCLASS_...).

> +
> +       log_err("image_loader_ubi: no MTD device for \"linux,ubi\" node\n");
> +       return -ENODEV;
> +
> +found:
> +       if (ubi_part_from_mtd(mtd)) {
> +               log_err("image_loader_ubi: failed to attach UBI on \"%s\"\n",
> +                       mtd->name);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int image_loader_ubi_read(struct image_loader *ldr, ulong src,
> +                                ulong size, void *dst)
> +{
> +       struct image_loader_ubi_priv *priv = ldr->priv;
> +       int ret;
> +
> +       ret = ubi_volume_read(priv->vol_name, dst, src, size);
> +       /* ubi_volume_read() returns positive errno values on error */

blank line before final return

> +       return ret ? -ret : 0;
> +}
> +
> +static void image_loader_ubi_cleanup(struct image_loader *ldr)
> +{
> +       struct image_loader_ubi_priv *priv = ldr->priv;
> +
> +       free(priv->vol_name);
> +       free(priv);
> +}
> +
> +int image_loader_init_ubi(struct image_loader *ldr, const char *vol_name)
> +{
> +       struct image_loader_ubi_priv *priv;
> +       int ret;
> +
> +       ret = ubi_auto_attach();
> +       if (ret)
> +               return ret;
> +
> +       if (!ubi_find_volume(vol_name)) {
> +               log_err("image_loader_ubi: volume \"%s\" not found\n",
> +                       vol_name);
> +               return -ENODEV;
> +       }
> +
> +       priv = malloc(sizeof(*priv));
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->vol_name = strdup(vol_name);
> +       if (!priv->vol_name) {
> +               free(priv);
> +               return -ENOMEM;
> +       }
> +
> +       ldr->read = image_loader_ubi_read;
> +       ldr->cleanup = image_loader_ubi_cleanup;
> +       ldr->priv = priv;
> +
> +       return 0;
> +}
> diff --git a/include/image-loader.h b/include/image-loader.h
> index 7ccf901d37d..a036e98982f 100644
> --- a/include/image-loader.h
> +++ b/include/image-loader.h
> @@ -172,4 +172,17 @@ int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
>   */
>  int image_loader_init_mtd(struct image_loader *ldr, const char *name);
>
> +/**
> + * image_loader_init_ubi() - Initialise loader for a UBI volume
> + *
> + * Ensures a UBI device is attached (auto-attaching from the device
> + * tree if needed), verifies the named volume exists, then installs a
> + * .read() callback wrapping ubi_volume_read().
> + *
> + * @ldr:       The image loader to initialise
> + * @vol_name:  UBI volume name
> + * Return: 0 on success, negative errno on failure
> + */
> +int image_loader_init_ubi(struct image_loader *ldr, const char *vol_name);
> +
>  #endif /* __IMAGE_LOADER_H */
> --
> 2.53.0

Regards,
SImon
