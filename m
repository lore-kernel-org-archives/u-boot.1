Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E016EC04A6A
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 18:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6006F869AE;
	Tue, 15 Aug 2023 20:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ls66/0xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC64869A7; Tue, 15 Aug 2023 20:39:54 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00532869AC
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 20:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9b50be31aso85973601fa.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692124791; x=1692729591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iVID/2+RpqGdkSICI3jM8clbukBS/b+kxnO4ZQiBVc4=;
 b=Ls66/0xsgZI5SLJY2gpEnCkrD/13C+Gh+tGs27P4sP2llpJfoyEMzTvuOv1Ce/kzkQ
 XI7Bs4KqmViuPFAU7Mxw+pXtiG2lGOj1P7/8D115Nf1Q9yIcVnfClHJ66yBkqqauYHEk
 eKphyBWRFkKd9oqqen5ge/v7abzpAawIu5lYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692124791; x=1692729591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iVID/2+RpqGdkSICI3jM8clbukBS/b+kxnO4ZQiBVc4=;
 b=FN1Lt+cdB8FHOOgokRBrIYP3RcYctmK3KbN2DIl9nZLrLXe/LUK+lK2VCAZPT8QZEE
 wssJ5e7XMMhsrZYiBHFvMgjFX7D3EPLWx/31kRWbJ1LelTN8IShqFwVEWp56jtZgdU3i
 ttm52e7qMkYFMReg+Mx/KBcHalfl3K7RGdvIWBt382jWnFvT1thF9R4zhJi9kxonBOd0
 fQCbuiz+ged+clRGiCPUqtJjHn07xmCE5XxcP2DPkRHq8RTYMdvPYnm5QyXzXjXgd+YY
 SqQg8WxvPXTmlTzUp1bpGfQMuDfGMjI72Xzmb40yeOgEdENakOfNkotdILyQawsqSsKA
 uDFw==
X-Gm-Message-State: AOJu0YxT7PO3fqa37XgWaPrWTGl0bKcS5QWS/QvjKPw2LN8qgDWkDEIR
 H22seO8tgsppsH2yrR6Gh9HFAVI+bfd3FYNUvPddGULEP3qMHxfEa2c=
X-Google-Smtp-Source: AGHT+IEr5isFHcn050tT7SHx8QMVWkuW8bjSPbnCx85iG23xBqFtl8KqOPXmW3p7rDP3wJh9JVWh5Eefb7oqqDTWnL4=
X-Received: by 2002:a2e:9157:0:b0:2b9:e93e:65d9 with SMTP id
 q23-20020a2e9157000000b002b9e93e65d9mr9672370ljg.40.1692124791154; Tue, 15
 Aug 2023 11:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <85390ee0-acf3-8e39-1074-250e07bf5e5f@mailbox.org>
 <20230815164300.444701-1-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20230815164300.444701-1-abdellatif.elkhlifi@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 12:39:39 -0600
Message-ID: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
Subject: Re: [PATCH] nvmxip: add sandbox support
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: marek.vasut@mailbox.org, marek.vasut+renesas@mailbox.org, 
 u-boot@lists.denx.de, nd@arm.com, Tom Rini <trini@konsulko.com>
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

On Tue, 15 Aug 2023 at 10:43, Abdellatif El Khlifi
<abdellatif.elkhlifi@arm.com> wrote:
>
> enable the 32-bit version of sandbox
>
> Initially NVMXIP came with sandbox64 support.
> Let's enable sandbox support as well.
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/sandbox/dts/sandbox.dts       | 14 ++++++++++++++
>  configs/sandbox_defconfig          |  4 ++--
>  drivers/mtd/nvmxip/nvmxip-uclass.c |  6 +++---
>  drivers/mtd/nvmxip/nvmxip.c        | 13 +++++++++++--
>  drivers/mtd/nvmxip/nvmxip_qspi.c   | 10 +++++++++-
>  test/dm/Makefile                   |  2 +-
>  6 files changed, 40 insertions(+), 9 deletions(-)


Reviewed-by: Simon Glass <sjg@chromium.org>
>
> diff --git a/arch/sandbox/dts/sandbox.dts b/arch/sandbox/dts/sandbox.dts
> index 12d3eff5fa..1d38a939c4 100644
> --- a/arch/sandbox/dts/sandbox.dts
> +++ b/arch/sandbox/dts/sandbox.dts
> @@ -97,6 +97,20 @@
>                 compatible = "sandbox,spi";
>                 cs-gpios = <0>, <&gpio_a 0>;
>         };
> +
> +       nvmxip-qspi1@08000000 {
> +               compatible = "nvmxip,qspi";
> +               reg = <0x08000000 0x00200000>;
> +               lba_shift = <9>;
> +               lba = <4096>;
> +       };
> +
> +       nvmxip-qspi2@08200000 {
> +               compatible = "nvmxip,qspi";
> +               reg = <0x08200000 0x00100000>;
> +               lba_shift = <9>;
> +               lba = <2048>;
> +       };
>  };
>
>  #include "sandbox.dtsi"
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 1cd1c2ed7c..296f9d7326 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -145,7 +145,6 @@ CONFIG_IP_DEFRAG=y
>  CONFIG_BOOTP_SERVERIP=y
>  CONFIG_IPV6=y
>  CONFIG_DM_DMA=y
> -CONFIG_DEVRES=y
>  CONFIG_DEBUG_DEVRES=y
>  CONFIG_SIMPLE_PM_BUS=y
>  CONFIG_ADC=y
> @@ -184,6 +183,7 @@ CONFIG_DMA_CHANNELS=y
>  CONFIG_SANDBOX_DMA=y
>  CONFIG_FASTBOOT_FLASH=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_ARM_FFA_TRANSPORT=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_GPIO_LOOKUP_LABEL=y
>  CONFIG_QCOM_PMIC_GPIO=y
> @@ -227,6 +227,7 @@ CONFIG_SPI_FLASH_SPANSION=y
>  CONFIG_SPI_FLASH_STMICRO=y
>  CONFIG_SPI_FLASH_SST=y
>  CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_NVMXIP_QSPI=y
>  CONFIG_MULTIPLEXER=y
>  CONFIG_MUX_MMIO=y
>  CONFIG_NVME_PCI=y
> @@ -345,4 +346,3 @@ CONFIG_TEST_FDTDEC=y
>  CONFIG_UNIT_TEST=y
>  CONFIG_UT_TIME=y
>  CONFIG_UT_DM=y
> -CONFIG_ARM_FFA_TRANSPORT=y
> diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
> index 6d8eb177b5..7177f8f314 100644
> --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> @@ -9,7 +9,7 @@
>  #include <common.h>
>  #include <dm.h>
>  #include <log.h>
> -#if CONFIG_IS_ENABLED(SANDBOX64)
> +#if CONFIG_IS_ENABLED(SANDBOX)
>  #include <asm/test.h>
>  #endif
>  #include <linux/bitops.h>
> @@ -39,7 +39,7 @@ static int nvmxip_post_bind(struct udevice *udev)
>         char bdev_name[NVMXIP_BLKDEV_NAME_SZ + 1];
>         int devnum;
>
> -#if CONFIG_IS_ENABLED(SANDBOX64)
> +#if CONFIG_IS_ENABLED(SANDBOX)
>         sandbox_set_enable_memio(true);
>  #endif
>
> @@ -62,7 +62,7 @@ static int nvmxip_post_bind(struct udevice *udev)
>                 return ret;
>         }
>
> -       log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
> +       log_debug("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
>
>         return 0;
>  }
> diff --git a/drivers/mtd/nvmxip/nvmxip.c b/drivers/mtd/nvmxip/nvmxip.c
> index a359e3b482..9191e69a40 100644
> --- a/drivers/mtd/nvmxip/nvmxip.c
> +++ b/drivers/mtd/nvmxip/nvmxip.c
> @@ -11,6 +11,7 @@
>  #include <log.h>
>  #include <mapmem.h>
>  #include <asm/io.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
>  #include "nvmxip.h"
> @@ -26,9 +27,17 @@
>   *
>   * Always return 0.
>   */
> -static int nvmxip_mmio_rawread(const phys_addr_t address, u64 *value)
> +static int nvmxip_mmio_rawread(const u64 *address, u64 *value)
>  {
> +#if CONFIG_IS_ENABLED(PHYS_64BIT)
>         *value = readq(address);
> +#else
> +       u32 h_word, l_word;
> +
> +       l_word = readl(address);
> +       h_word = readl((u8 *)address + sizeof(u32));
> +       *value = FIELD_PREP(GENMASK_ULL(63, 32), h_word) | l_word;
> +#endif
>         return 0;
>  }
>
> @@ -67,7 +76,7 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
>         /* assumption: the data is virtually contiguous */
>
>         for (qdata_idx = 0 ; qdata_idx < qwords ; qdata_idx++)
> -               nvmxip_mmio_rawread((phys_addr_t)(virt_blkaddr + qdata_idx), pdst++);
> +               nvmxip_mmio_rawread(virt_blkaddr + qdata_idx, pdst++);
>
>         log_debug("[%s]:     src[0]: 0x%llx , dst[0]: 0x%llx , src[-1]: 0x%llx , dst[-1]: 0x%llx\n",
>                   dev->name,
> diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
> index 7221fd1cb4..b6b94ca57f 100644
> --- a/drivers/mtd/nvmxip/nvmxip_qspi.c
> +++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
> @@ -17,6 +17,14 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  #define NVMXIP_QSPI_DRV_NAME "nvmxip_qspi"
>
> +/* Select the right physical address formatting according to the platform */
> +#ifdef CONFIG_PHYS_64BIT
> +#define PhysAddrLength "ll"
> +#else
> +#define PhysAddrLength ""
> +#endif
> +#define PHYS_ADDR_LN "%" PhysAddrLength "x"

Could this go in a standard header?

> +
>  /**
>   * nvmxip_qspi_of_to_plat() -read from DT
>   * @dev:       the NVMXIP device
> @@ -50,7 +58,7 @@ static int nvmxip_qspi_of_to_plat(struct udevice *dev)
>                 return -EINVAL;
>         }
>
> -       log_debug("[%s]: XIP device base addr: 0x%llx , lba_shift: %d , lbas: %lu\n",
> +       log_debug("[%s]: XIP device base addr: " PHYS_ADDR_LN " , lba_shift: %d , lbas: %lu\n",
>                   dev->name, plat->phys_base, plat->lba_shift, plat->lba);
>
>         return 0;
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 7ed00733c1..77172d9012 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_UT_DM) += test-uclass.o
>  obj-$(CONFIG_UT_DM) += core.o
>  obj-$(CONFIG_UT_DM) += read.o
>  obj-$(CONFIG_UT_DM) += phys2bus.o
> -ifeq ($(CONFIG_NVMXIP_QSPI)$(CONFIG_SANDBOX64),yy)
> +ifeq ($(CONFIG_NVMXIP_QSPI),y)
>  obj-y += nvmxip.o
>  endif
>
> --
> 2.25.1
>

Regars,
Simon
