Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 18:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579F58780C;
	Wed, 13 Dec 2023 19:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kDUOayPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C359877F8; Wed, 13 Dec 2023 19:22:32 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED39874CC
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 19:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so1775548a91.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702491748; x=1703096548; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Uvsy/urngXQa7MZNQLaairor5srydK33+yC8kzH0Sg=;
 b=kDUOayPGjJeoPOIpznrqbbfkmiSG1Y0HmLffYdMnDjgFxMtCGp8RPyeb94YChqNNFB
 KkPgOXMMuJab5avs3xiQvElm8Q3TbMh6rvIIiRBIM/qE9FTgQli9nM+fCgU1q6qAZiQW
 helfkKjJdqCVc00aMUdNB4H/UmDPYPGTFGR7GhDR+8GLV5dpJHz8K8d1uqLbYbEz+4Gp
 XNsMvaTN12Pndm6pYn0YXzzbeBb1yQdbPB9rmhHxUQXyZ/NrLdwrD6CPh0YVAQPCkgjY
 6kQNFa792K2r98nvYTn5zqD7TToqRV3qBC7xtqfPXmlVCILIF4WWNzgCTqTfgLJ2X5Yi
 1+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702491748; x=1703096548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Uvsy/urngXQa7MZNQLaairor5srydK33+yC8kzH0Sg=;
 b=Z723hAYVpXIwctan/9rgQMq/zx3NppleyzxeTJFuKoYGuDKSIDUz9cDKvm3l9H0tuv
 djy510vmTp4WeLq8TnVYgk5dJQ4UVzcKUsjSYS5/A+0bbJlPBHDgN83vVy072uxG4DDS
 wfhb5lE3++aNRlPOxvIGpTR3VtqknTpcGHwcQ3qqPm/1sIebUf4H3VT0SQHv/66mHaDP
 k8xsN3Vi/JZi9RI00uXOWcbrCq+ZBtyn1GBwcM/ofMElhoihF5A0Uqb9GUxKZMkwf40x
 XzOZMm8Kq+HNRTGr1PQxN+Nb/clsT8Js7Difikrvz19yHy7WWL7oO4a1S/KDiiEclGit
 xTjA==
X-Gm-Message-State: AOJu0YwNcz0LkzOJ+K5UDSNs47YvDmF1BJxcCouODfdHzdQrCgy224uU
 d5hQbgENVsMvEIG8jLJzHVv8ePatPCDh6SPO2P7Tcy12Jnc=
X-Google-Smtp-Source: AGHT+IG5raQSt8x70huRuFLrv8UP+sxBmeW/2EE4IGgtlqAPIeu3w1z56QA1O4wpX2WSYsitBjXA+FCDmxfEVePCgAI=
X-Received: by 2002:a17:90a:6345:b0:286:4055:63e0 with SMTP id
 v5-20020a17090a634500b00286405563e0mr14573942pjs.0.1702491748189; Wed, 13 Dec
 2023 10:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20231209114555.16951-1-m.othacehe@gmail.com>
In-Reply-To: <20231209114555.16951-1-m.othacehe@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 15:22:12 -0300
Message-ID: <CAOMZO5DEwTgffO6RZz8BaFq+bmxM170mz6wWN+MQ76ss7r8O2g@mail.gmail.com>
Subject: Re: [PATCH] Add imx93-var-som support
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Mathieu,

On Sat, Dec 9, 2023 at 9:57=E2=80=AFAM Mathieu Othacehe <m.othacehe@gmail.c=
om> wrote:
>
> Add support for the Variscite VAR-SOM-IMX93 evaluation kit. The SoM
> consists of an NXP iMX93 dual A55 CPU. The SoM is mounted on a Variscite
> Symphony SBC.
>
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  arch/arm/dts/Makefile                         |    3 +-
>  .../dts/imx93-var-som-symphony-u-boot.dtsi    |  152 ++
>  arch/arm/dts/imx93-var-som-symphony.dts       |  223 +++
>  arch/arm/dts/imx93-var-som.dtsi               |  205 +++
>  arch/arm/include/asm/arch-imx9/clock.h        |    1 +
>  arch/arm/mach-imx/imx9/Kconfig                |    6 +
>  board/variscite/common/Kconfig                |    6 +
>  board/variscite/common/eth.c                  |   59 +
>  board/variscite/common/eth.h                  |   12 +
>  board/variscite/common/extcon-ptn5150.c       |  137 ++
>  board/variscite/common/extcon-ptn5150.h       |   40 +
>  board/variscite/common/imx9_eeprom.c          |  188 +++
>  board/variscite/common/imx9_eeprom.h          |   83 +
>  board/variscite/common/mmc.c                  |   47 +
>  board/variscite/imx93_var_som/Kconfig         |   14 +
>  board/variscite/imx93_var_som/Makefile        |   18 +
>  board/variscite/imx93_var_som/imx93_var_som.c |  147 ++
>  .../variscite/imx93_var_som/lpddr4x_timing.c  | 1489 +++++++++++++++++
>  board/variscite/imx93_var_som/spl.c           |  146 ++
>  configs/imx93_var_som_defconfig               |  161 ++
>  include/configs/imx93_var_som.h               |  175 ++
>  21 files changed, 3311 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
>  create mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
>  create mode 100644 arch/arm/dts/imx93-var-som.dtsi
>  create mode 100644 board/variscite/common/Kconfig
>  create mode 100644 board/variscite/common/eth.c
>  create mode 100644 board/variscite/common/eth.h
>  create mode 100644 board/variscite/common/extcon-ptn5150.c
>  create mode 100644 board/variscite/common/extcon-ptn5150.h
>  create mode 100644 board/variscite/common/imx9_eeprom.c
>  create mode 100644 board/variscite/common/imx9_eeprom.h
>  create mode 100644 board/variscite/common/mmc.c
>  create mode 100644 board/variscite/imx93_var_som/Kconfig
>  create mode 100644 board/variscite/imx93_var_som/Makefile
>  create mode 100644 board/variscite/imx93_var_som/imx93_var_som.c
>  create mode 100644 board/variscite/imx93_var_som/lpddr4x_timing.c
>  create mode 100644 board/variscite/imx93_var_som/spl.c
>  create mode 100644 configs/imx93_var_som_defconfig
>  create mode 100644 include/configs/imx93_var_som.h

Please add a MAINTAINERS file for this board.

It would also be helpful to add doc/board/variscite/imx93_var_som.rst
that explains
how to build U-Boot for this board, how to get the firmware, ATF,
binaries, etc, and how to flash it to the boot medium.

> --- /dev/null
> +++ b/arch/arm/dts/imx93-var-som-symphony.dts

Please also submit the imx93-var-som-symphony.dts support to Linux so that
it can get reviewed by the DT folks.

> +++ b/board/variscite/common/Kconfig
> @@ -0,0 +1,6 @@
> +config EXTCON_PTN5150
> +       bool "NXP PTN5150 CC LOGIC USB EXTCON support"

This should be converted to a proper driver.

To not block the board support, I suggest sending a v2 without PTN5150
support for now.

> +       default n

'default n' is already the default. Please drop it.

> --- /dev/null
> +++ b/board/variscite/common/eth.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 Variscite Ltd.
> + */
> +#include <common.h>
> +#include <net.h>
> +#include <miiphy.h>
> +#include <env.h>
> +#include "../common/imx9_eeprom.h"
> +
> +#define CHAR_BIT 8
> +       if (!is_valid_ethaddr(enetaddr))
> +               return -1;

return -EINVAL;

> +/* Returns carrier board revision string via 'rev' argument.
> + * For legacy carrier board revisions the "legacy" string is returned.
> + * For new carrier board revisions the actual carrier revision is return=
ed.
> + * Symphony-Board 1.4 and below are legacy, 1.4a and above are new.
> + * DT8MCustomBoard 1.4 and below are legacy, 2.0 and above are new.
> + */

The correct style for multi-line comment is:

/*
 * Line 1 bla bla
 * line 2
 *
 */

> +
> +               /* 0.9v
> +                */

Same here. Either remove or provide a better comment.

> +               pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
> +               pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
> +
> +               /* set standby voltage to 0.65v */

0.65V, not v.


> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       BOOTENV \
> +       AHAB_ENV \
> +       "initrd_addr=3D0x83800000\0" \
> +       "emmc_dev=3D0\0"\
> +       "sd_dev=3D1\0" \
> +       "scriptaddr=3D0x83500000\0" \
> +       "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +       "image=3DImage.gz\0" \
> +       "img_addr=3D0x82000000\0" \
> +       "splashimage=3D0x90000000\0" \
> +       "console=3DttyLP0,115200 earlycon\0" \
> +       "fdt_addr_r=3D0x83000000\0"                       \
> +       "fdt_addr=3D0x83000000\0"                 \
...

The recommendation for the new boards is to add the environment to an env f=
ile.
In this case, it would be board/variscite/imx93_var_som/imx93_var_som.env.

See board/cloos/imx8mm_phg/imx8mm_phg.env as reference.

> +
> +/* Link Definitions */

Maybe just drop this comment.

> +#define CFG_SYS_INIT_RAM_ADDR        0x80000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x80000000
> +#define PHYS_SDRAM                      0x80000000
> +#define PHYS_SDRAM_SIZE                        0x80000000 /* 2GB DDR */
> +
> +#define DEFAULT_SDRAM_SIZE             (512 * SZ_1M) /* 512MB Minimum DD=
R4, see get_dram_size */
> +#define VAR_EEPROM_DRAM_START           (PHYS_SDRAM + (DEFAULT_SDRAM_SIZ=
E >> 1))
> +#define VAR_SOM_EEPROM_I2C_NAME "i2c@42530000"
> +#define VAR_CARRIER_EEPROM_I2C_NAME "i2c@44340000"
> +
> +#define CFG_SYS_FSL_USDHC_NUM  2
> +
> +/* Using ULP WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR

Is this needed now that we use DM?

> +
> +#if defined(CONFIG_CMD_NET)
> +#define CFG_FEC_XCV_TYPE             RGMII
> +#define CFG_FEC_MXC_PHYADDR          5

Same here.

> +#define DWC_NET_PHYADDR                        0

Is this needed?
