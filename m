Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28294E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01F783DBF;
	Thu, 19 Feb 2026 14:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b095nnn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CC383936; Thu, 19 Feb 2026 14:10:44 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A4583DBF
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-824ba8f0acaso597192b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:10:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506641; cv=none;
 d=google.com; s=arc-20240605;
 b=In7ndIs+xxSv1FKIG1tssg7cH2WFTVA3dxYxObpSx+I9UbC/MfGDUzhMNGrHUlVU+t
 mOn31/GMyo98fY6NEmtg+eFcaygSlRUwuysqhdzo6Wv46LXBG8ldzG5Lx0B082ZrB7/G
 Jzcs5+dITxbSZ2/X/yBB9KkAaW/XaCbU5yRQeN1VNCHQ4Riq0VenyOwdUro4lRF+Aot1
 UjPupIE9W8OVCT79NvfLUCfWqaSa6nqqKatGMXGdr5D80oxEDXEngnhqU+rEoE3gUVDC
 sM2v+o1URN/ollcuZaDFdGBJuICRpr2NbhXJrHwX5oPcU6rP1MbIqTOwvAj7iGhRhjFD
 aKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tlUjeHHHz1VjhFkCqtM4Y+oKR6qkpqiVKP+mR8Y016E=;
 fh=4HrCD9V8guY9p+UMQgDhJFKyhBBfxhzODOj5mEVDnOE=;
 b=QyP8Y6t8BCpauBW6i9NuD6OMkcsSPhEWkcD2qJ/iWzzF11unY1KNzVpxRFyRTtsIO4
 VYN9RLF08ag6W58qdEbepwohuWT1vYNPsbVoU1LtvHh8qny5SqyhtRt7DmA14weqgAic
 y1d4xlFMQgxhqE5DUYOlwPzlEwHVDiPfPP01p9mCiXKX4xisTRdTs35RragjOJgyKmr9
 5lS0k4n0qRoFcVOwCs/lGI3Hik+tvRdsy4Zj57/wb738QYC8nRcKUytQDCR9GXxq5P64
 hntLm6tdSl1CEPCdXuCpvgjjx/K4NbXtxKUKVWnMXF7jvlc5hJdw8wybULOtkwmqMhg4
 oR3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506641; x=1772111441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tlUjeHHHz1VjhFkCqtM4Y+oKR6qkpqiVKP+mR8Y016E=;
 b=b095nnn50SYONJUcyxMqOcGSXIGMDh48J4y9cUHrDFQMGF1YwWdwmbKZIM+65N37R8
 aAuCdXWQJFdz0cMdHR/4vkyzmOC7N3dw3i1KR2YxdUgeYecMcMrt4yhrXd4QdMINWfw9
 5t3DU8Ib28UGkQcs+2Tl6vOXiLqGQ6Rv9V1d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506641; x=1772111441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlUjeHHHz1VjhFkCqtM4Y+oKR6qkpqiVKP+mR8Y016E=;
 b=WSbf+yU9pUCE7ueLVlOBWCG3Wjk3WJOrj7FOZePtYaZ2Oihop1t3kUF5n2o8d965xi
 BE3jNQ7wQVblP23h7clEXxTAqJ3QBusMDqt6ZaD8d8yqa358F+Qe/VQt5Eze5LwkJppr
 2hfm9NTFG6+kLMu9MAitBEEv0EKAAl+SUSjTbSpB+dhcNli1CyjT/jcglDsoV0WXa4L0
 Jy51C7VIIVU9FWsfjgJRFJJ9WezWA/gFUJvbcDjvYmcUtQREJSPkB8dpF+1UOlrESbDi
 mBy0+cknZmtIToOPyw+lNSBL1BjgcJ+PyY+2PVacc1+cKRKDiS8QA9NitZQ/8gEECzS8
 RNOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnfpapUIsgto11+9ACVqezMTgOsKR/bxfCdERA0E0Aq7uHt5HvhgPCtO1SXi07u4GAD3O6EmE=@lists.denx.de
X-Gm-Message-State: AOJu0YxKQzckmXbaTXw/Y7CZoaHQ2zuPFSyexxPXe2jwKNLsdFa26FWn
 jGyDTPdx1ls6BmBN3y+SdYq0fwYHCwNywWAQdcvOnRh4akxljgmCoJPnJ6c0AtrcPLE1O/pPcBB
 cX5g/UbvqomhVNCBayETFqIm90W2oQF42oyiXS5i9
X-Gm-Gg: AZuq6aJ0FoKpwoByM5ni/EFCjqX+IN1tBbuXTm5jEF5H6KMbvRJ7IOlj5JQwByStlCU
 Nc6GaZRjwG4CuvOJfL8bc8LeBZND9R5NM1VyMN7TmL8SPBOzhpXTPSbZlEGv+PTHkDQoVAu2vjX
 tnyvrFoRCF8sv7txK5Vht57MWl50BuCMv86hTlmIcE+szA3r25pNYpluiP+k/2shHl5I9rtWZ7o
 RZFMCzdjpPKYtFcx18ZwceoNHzH6eIAgAMW4J1iz48A2Kj+piRhDNooXvFuMMje/VSvQJ9pj/iR
 7nUlKg==
X-Received: by 2002:a05:6a20:2452:b0:366:5bda:1e87 with SMTP id
 adf61e73a8af0-3946c9c4e21mr16871380637.80.1771506640911; Thu, 19 Feb 2026
 05:10:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <46dcab5fc58e9116ca017a63ed07922ae3093913.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <46dcab5fc58e9116ca017a63ed07922ae3093913.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:28 -0700
X-Gm-Features: AaiRm50QhR3Ugky99KWwSHAU9UZP2NwOMMhhBpHYoWukqlz43La2xCOpQCffaFo
Message-ID: <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/20] boot: bootmeth: add OpenWrt boot method skeleton
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

On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add the initial bootmeth_openwrt driver with:
>
> - UCLASS_BOOTMETH driver, compatible "u-boot,openwrt"
> - check(): accept block devices via bootflow_iter_check_blk()
> - bind(): set BOOTMETHF_ANY_PART so bootstd iterates all partitions
>   without requiring a filesystem
> - read_bootflow(): stub returning -ENOENT
> - boot(): stub returning -ENOSYS
> - Kconfig: CONFIG_BOOTMETH_OPENWRT depending on FIT, BOOTSTD,
>   BOOTM_STORAGE

We don't normally write out this much detail in the code

>
> This is the foundation for booting OpenWrt-style uImage.FIT firmware
> images stored directly on raw storage partitions. The bootmeth will
> delegate actual image loading to the existing bootm storage path via
> image_loader.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig            | 13 +++++++++
>  boot/Makefile           |  1 +
>  boot/bootmeth_openwrt.c | 65 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 boot/bootmeth_openwrt.c

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index efc06f3cd1a..d8c7b8360ac 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -585,6 +585,19 @@ config BOOTMETH_CROS
>
>           Note that only x86 devices are supported at present.
>
> +config BOOTMETH_OPENWRT
> +       bool "Bootdev support for OpenWrt"
> +       depends on FIT
> +       depends on BOOTSTD
> +       depends on BOOTM_STORAGE
> +       help
> +         Enables support for booting OpenWrt-style uImage.FIT firmware
> +         images stored directly on raw storage (block device partitions,
> +         MTD partitions, or UBI volumes). The boot method loads the FIT
> +         metadata, selectively reads only the kernel and FDT sub-images
> +         from storage, and skips filesystem sub-images that Linux maps
> +         directly from flash.
> +
>  config BOOTMETH_EXTLINUX
>         bool "Bootdev support for extlinux boot"
>         select PXE_UTILS
> diff --git a/boot/Makefile b/boot/Makefile
> index 7d1d4a28106..7b42358eb0c 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
>
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_OPENWRT) += bootmeth_openwrt.o
>
>  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
>  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
> diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> new file mode 100644
> index 00000000000..02bf543031b
> --- /dev/null
> +++ b/boot/bootmeth_openwrt.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for OpenWrt
> + *
> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <blk.h>
> +#include <bootdev.h>
> +#include <bootflow.h>
> +#include <bootm.h>
> +#include <bootmeth.h>
> +#include <dm.h>
> +#include <image-loader.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +
> +static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +       if (bootflow_iter_check_blk(iter))
> +               return log_msg_ret("blk", -EOPNOTSUPP);
> +
> +       return 0;
> +}
> +
> +static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +       return log_msg_ret("nyi", -ENOENT);
> +}
> +
> +static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +       return log_msg_ret("nyi", -ENOSYS);
> +}
> +
> +static int openwrt_bootmeth_bind(struct udevice *dev)
> +{
> +       struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +       plat->desc = "OpenWrt";
> +       plat->flags = BOOTMETHF_ANY_PART;
> +
> +       return 0;
> +}
> +
> +static struct bootmeth_ops openwrt_bootmeth_ops = {
> +       .check          = openwrt_check,
> +       .read_bootflow  = openwrt_read_bootflow,
> +       .boot           = openwrt_boot,
> +};
> +
> +static const struct udevice_id openwrt_bootmeth_ids[] = {
> +       { .compatible = "u-boot,openwrt" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_openwrt) = {
> +       .name           = "bootmeth_openwrt",
> +       .id             = UCLASS_BOOTMETH,
> +       .of_match       = openwrt_bootmeth_ids,
> +       .ops            = &openwrt_bootmeth_ops,
> +       .bind           = openwrt_bootmeth_bind,
> +};
> --
> 2.53.0
