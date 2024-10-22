Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A0FD2CE07
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045458925A;
	Tue, 22 Oct 2024 19:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CkWMJb33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B3F89268; Tue, 22 Oct 2024 19:01:25 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB3888FD6
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cb6704ff6bso3683419a12.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616483; x=1730221283; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7mcNUeCvCnyMAxrQgZ+vaenHJhncp+4Zk3M4qbITzvE=;
 b=CkWMJb33W7f1fT6F2WHpU5gA8y415fidfzEt6IQTddKa/yLOfgGtkWhg0n7M4MgEdN
 IcLKpdKw67eRIq0qZ6zazGps0Q/r13BJwO6ONYFXqm1NWdWZKNnE9kvosGuoKwGG23B3
 3SE0IIwMMpyJmv3HK8qeVhFX1wxRp/Gg79Fdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616483; x=1730221283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mcNUeCvCnyMAxrQgZ+vaenHJhncp+4Zk3M4qbITzvE=;
 b=ZYr7mWmegLecWDOi2XDncHj34RanZeECmgHug+b+K5mQFvzugXKhlfX1qLbUiSX0XP
 QHG727+vCsj98XwBuPr5zRWr5MqmEEj2NGAgeH75usqsCXpK83TSNeppQbYot7oM0Zyk
 NxvXvIdyeqnIev6j9sz4SD0/JwSxWPr1vv5+Dt1NSVDWSNSkWaRs48x5dxZcrA+qE3AF
 EUzYgihi0V8LPVY5AcQEvEGS7soS2ci86UrsAnP99B0sU2155krFwi5LG6q+uHEN4Fr9
 PLtogfaGaKThlJx5oNEYSC9HfciwMxcVZssZEXTvwbgFoCwQqbV1m5zyuhM8aM9wbmAU
 7qcA==
X-Gm-Message-State: AOJu0YwxnoOzFvTKbKY6C3rr4zN1ZJyTyFSDwHaPwxHQMzY90GSSgoNz
 DPURX0+yuH6SI9h+Pjlb/rMwvi3bUWob5tuByCfTiIswLIPUGLzwvorzevdzPTapWXE5WSssmVR
 xQ3futIwurchWeJq+23SGcBtzcuiuf6iLxXAZ
X-Google-Smtp-Source: AGHT+IGHhzYfYjgB21LONiAHasHnAPjtV9n8fRrMyiWIEYRoEmHUyLcyTygjE0DkX31bAEe5D5xrRvTd9WLyz9LallQ=
X-Received: by 2002:a17:907:60ca:b0:a9a:82e2:e8ce with SMTP id
 a640c23a62f3a-a9abe099ac1mr2477066b.40.1729616482860; Tue, 22 Oct 2024
 10:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <64b2dae0ae60feded514b774f0e91c303c81a52d.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <64b2dae0ae60feded514b774f0e91c303c81a52d.1729577070.git.jan.kiszka@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:47 +0200
Message-ID: <CAFLszTgYaBh8ccEVoRAhGDAysY=XY=5es1k6TmF=mWBEHyYUAA@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] sysinfo: Add driver for IOT2050 boards
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
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

On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Li Hua Qian <huaqian.li@siemens.com>
>
> This brings a sysinfo driver and DT entry for the IOT2050 board series.
> It translates the board information passed from SE-Boot to SPL into
> values that can be retrieved via the sysinfo API. Will is already used
> to fill the SMBIOS table when booting via EFI.
>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> [Jan: split-off as separate patch, cleanup]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 +++
>  configs/iot2050_defconfig                     |   1 +
>  drivers/sysinfo/Kconfig                       |   7 +
>  drivers/sysinfo/Makefile                      |   1 +
>  drivers/sysinfo/iot2050.c                     | 143 ++++++++++++++++++
>  drivers/sysinfo/iot2050.h                     |  26 ++++
>  6 files changed, 196 insertions(+)
>  create mode 100644 drivers/sysinfo/iot2050.c
>  create mode 100644 drivers/sysinfo/iot2050.h

I think strlcpy() might be better than strncpy() for this case

The idea with sysinfo is that we use the same enum for all boards, so
please add your new things to sysinfo.h

Do you actually want all the sysinfo info in capitals? If so, that's
fine, just checking...

>
> diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> index b6d2c816acc..55337179f9f 100644
> --- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> @@ -14,6 +14,24 @@
>                 spi0 = &ospi0;
>         };
>
> +       sysinfo {
> +               compatible = "siemens,sysinfo-iot2050";
> +               /* TI_SRAM_SCRATCH_BOARD_EEPROM_START */
> +               offset = <0x40280000>;
> +               bootph-all;
> +
> +               smbios {
> +                       system {
> +                               manufacturer = "SIEMENS AG";
> +                               product = "SIMATIC IOT2050";
> +                       };
> +
> +                       baseboard {
> +                               manufacturer = "SIEMENS AG";
> +                       };
> +               };
> +       };
> +
>         leds {
>                 bootph-all;
>                 status-led-red {
> diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
> index 2624f0cb573..574e232d119 100644
> --- a/configs/iot2050_defconfig
> +++ b/configs/iot2050_defconfig
> @@ -141,6 +141,7 @@ CONFIG_SOC_TI=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_CADENCE_QSPI=y
> +CONFIG_SYSINFO=y
>  CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
> diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
> index 2030e4babc9..df83df69ffb 100644
> --- a/drivers/sysinfo/Kconfig
> +++ b/drivers/sysinfo/Kconfig
> @@ -31,6 +31,13 @@ config SYSINFO_RCAR3
>         help
>           Support querying SoC version information for Renesas R-Car Gen3.
>
> +config SYSINFO_IOT2050
> +       bool "Enable sysinfo driver for the Siemens IOT2050"
> +       depends on TARGET_IOT2050_A53
> +       default y if TARGET_IOT2050_A53
> +       help
> +         Support querying device information for Siemens IOT2050.
> +
>  config SYSINFO_SANDBOX
>         bool "Enable sysinfo driver for the Sandbox board"
>         help
> diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
> index 680dde77fe8..26ca3150999 100644
> --- a/drivers/sysinfo/Makefile
> +++ b/drivers/sysinfo/Makefile
> @@ -5,6 +5,7 @@
>  obj-y += sysinfo-uclass.o
>  obj-$(CONFIG_SYSINFO_GAZERBEAM) += gazerbeam.o
>  obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
> +obj-$(CONFIG_SYSINFO_IOT2050) += iot2050.o
>  obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
>  obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
>  obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
> diff --git a/drivers/sysinfo/iot2050.c b/drivers/sysinfo/iot2050.c
> new file mode 100644
> index 00000000000..5359d6b8d62
> --- /dev/null
> +++ b/drivers/sysinfo/iot2050.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Siemens AG, 2024
> + */
> +
> +#include <dm.h>
> +#include <sysinfo.h>
> +#include <net.h>
> +#include <asm/arch/hardware.h>
> +
> +#include "iot2050.h"
> +
> +#define IOT2050_INFO_MAGIC             0x20502050
> +
> +struct iot2050_info {
> +       u32 magic;
> +       u16 size;
> +       char name[20 + 1];
> +       char serial[16 + 1];
> +       char mlfb[18 + 1];
> +       char uuid[32 + 1];
> +       char a5e[18 + 1];
> +       u8 mac_addr_cnt;
> +       u8 mac_addr[8][ARP_HLEN];
> +       char seboot_version[40 + 1];
> +       u8 padding[3];
> +       u32 ddr_size_mb;
> +} __packed;
> +
> +/**
> + * struct sysinfo_iot2050_priv - sysinfo private data
> + * @info: iot2050 board info
> + */
> +struct sysinfo_iot2050_priv {
> +       struct iot2050_info *info;
> +};
> +
> +static int sysinfo_iot2050_detect(struct udevice *dev)
> +{
> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
> +
> +       if (priv->info == NULL || priv->info->magic != IOT2050_INFO_MAGIC)
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int sysinfo_iot2050_get_str(struct udevice *dev, int id, size_t size,
> +                                  char *val)
> +{
> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
> +       char byte_str[3] = {0};
> +       unsigned int n;
> +
> +       switch (id) {
> +       case BOARD_NAME:
> +               strncpy(val, priv->info->name, size);
> +               break;
> +       case BOARD_SERIAL:
> +               strncpy(val, priv->info->serial, size);
> +               break;
> +       case BOARD_MLFB:
> +               strncpy(val, priv->info->mlfb, size);
> +               break;
> +       case BOARD_UUID:
> +               for (n = 0; n < min(size, (size_t)16); n++) {
> +                       memcpy(byte_str, priv->info->uuid + n * 2, 2);
> +                       val[n] = (char)hextoul(byte_str, NULL);
> +               }
> +               break;
> +       case BOARD_A5E:
> +               strncpy(val, priv->info->a5e, size);
> +               break;
> +       case BOARD_SEBOOT_VER:
> +               strncpy(val, priv->info->seboot_version, size);
> +               break;
> +       case BOARD_MAC_ADDR_1:
> +       case BOARD_MAC_ADDR_2:
> +       case BOARD_MAC_ADDR_3:
> +       case BOARD_MAC_ADDR_4:
> +       case BOARD_MAC_ADDR_5:
> +       case BOARD_MAC_ADDR_6:
> +       case BOARD_MAC_ADDR_7:
> +       case BOARD_MAC_ADDR_8:
> +               memcpy(val, priv->info->mac_addr[id - BOARD_MAC_ADDR_START],
> +                      ARP_HLEN);

For this, we really need another parameter to get_str(), i.e. the
index, since we don't know how many MACs there will be. So how about
adding a few new operations?

int (*get_item_count)(struct udevice *dev, int id);
int (*get_str_item)(struct udevice *dev, int id, int index, size_t
size, char *val);

> +               return 0;
> +       case BOARD_DDR_SIZE:
> +               memcpy(val, &priv->info->ddr_size_mb,
> +                      sizeof(priv->info->ddr_size_mb));
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       };
> +
> +       val[size - 1] = '\0';
> +       return 0;
> +}
> +
> +static int sysinfo_iot2050_get_int(struct udevice *dev, int id, int *val)
> +{
> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
> +
> +       switch (id) {
> +       case BOARD_MAC_ADDR_CNT:
> +               *val = priv->info->mac_addr_cnt;
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       };
> +}
> +
> +static const struct sysinfo_ops sysinfo_iot2050_ops = {
> +       .detect = sysinfo_iot2050_detect,
> +       .get_str = sysinfo_iot2050_get_str,
> +       .get_int = sysinfo_iot2050_get_int,
> +};
> +
> +static int sysinfo_iot2050_probe(struct udevice *dev)
> +{
> +       struct sysinfo_iot2050_priv *priv = dev_get_priv(dev);
> +       unsigned long offset;
> +
> +       offset = dev_read_u32_default(dev, "offset",
> +                                     TI_SRAM_SCRATCH_BOARD_EEPROM_START);
> +       priv->info = (struct iot2050_info *)offset;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id sysinfo_iot2050_ids[] = {
> +       { .compatible = "siemens,sysinfo-iot2050" },
> +       { /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(sysinfo_iot2050) = {
> +       .name           = "sysinfo_iot2050",
> +       .id             = UCLASS_SYSINFO,
> +       .of_match       = sysinfo_iot2050_ids,
> +       .ops            = &sysinfo_iot2050_ops,
> +       .priv_auto      = sizeof(struct sysinfo_iot2050_priv),
> +       .probe          = sysinfo_iot2050_probe,
> +};
> diff --git a/drivers/sysinfo/iot2050.h b/drivers/sysinfo/iot2050.h
> new file mode 100644
> index 00000000000..f659a8282b5
> --- /dev/null
> +++ b/drivers/sysinfo/iot2050.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Siemens AG, 2024
> + */
> +
> +#include <sysinfo.h>
> +
> +enum sysinfo_id_iot2050 {
> +       BOARD_MLFB              = SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
> +       BOARD_SERIAL            = SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> +       BOARD_UUID              = SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> +       BOARD_A5E               = SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
> +       BOARD_NAME              = SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,

Do you need to rename these? It seems better to use the standard
names, although I do think they are quite long.

> +       BOARD_SEBOOT_VER        = SYSINFO_ID_USER + 0,
> +       BOARD_MAC_ADDR_CNT      = SYSINFO_ID_USER + 1,
> +       BOARD_MAC_ADDR_1        = SYSINFO_ID_USER + 2,
> +       BOARD_MAC_ADDR_START    = BOARD_MAC_ADDR_1,
> +       BOARD_MAC_ADDR_2        = SYSINFO_ID_USER + 3,
> +       BOARD_MAC_ADDR_3        = SYSINFO_ID_USER + 4,
> +       BOARD_MAC_ADDR_4        = SYSINFO_ID_USER + 5,
> +       BOARD_MAC_ADDR_5        = SYSINFO_ID_USER + 6,
> +       BOARD_MAC_ADDR_6        = SYSINFO_ID_USER + 7,
> +       BOARD_MAC_ADDR_7        = SYSINFO_ID_USER + 8,
> +       BOARD_MAC_ADDR_8        = SYSINFO_ID_USER + 9,
> +       BOARD_DDR_SIZE          = SYSINFO_ID_USER + 10,

These are the ones which should be added as standard. Be sure to
comment them as necessary.

Regards,
Simon
