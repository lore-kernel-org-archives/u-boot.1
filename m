Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83BD1AD48
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 11:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD2288C98;
	Wed, 16 Oct 2024 13:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCUZZ0WM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B323F88C7E; Wed, 16 Oct 2024 13:36:28 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD0488C98
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb5f647538so9297521fa.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729078585; x=1729683385; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceiv9zrcE55EZcomQiLYKxcBnJ1I0S0oRzeAnRlCWWw=;
 b=iCUZZ0WMRZ1HZ8Pe0r6Yj4A4yhkEw2g2E82Vbbi1gOtT7Ty5rqXK+GwJiE/rkwWTMC
 I54dHO/N+pbfuU1lY0wmsgC4bK8JkkADOfHRVocRvK0JSL+83CY/ySZH3KAK0owdSHQ3
 yP4DZcvFtL+vPwdo5aDcrF4EnDGYNynD2tsAOUyH8vEX9LGwcjMW7wJH7LqP5QFa+nzY
 mvsFdnrYIkAOIcnIapHAlzGJdL3bPXx7QG7aWjGeQF5BYEHy1eFZl98C4YFGXijCs1yH
 FaCgX3//d6afuJ+Cgw93dRjjbjQ5OV9bXQlXJ6W6k9N4rEvQETu/mSQ0Ot/1vo+bYA7o
 maqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729078585; x=1729683385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ceiv9zrcE55EZcomQiLYKxcBnJ1I0S0oRzeAnRlCWWw=;
 b=bUGzb7I9qrEG9jG7r9CbSziaJOw7lxmKnI2HWZhZYGKgO8S/HsCZAywwpEd+prxRNQ
 1vW/txpVFUCrFuPcTB1IAZ5MkhAwXj9zzM19UT2PsD7lcPJZsVYf+jq2KVhvu3f2nk1/
 ZJj7o1zneafqcox01n9OhFmSLqLpA2rVUjgEkn1posniB9BAcnLoJ7g9dODMMoFqqFRs
 05QP+6PPyrTTToIIBoodN8VUY6zsqgCLEQJHWrzVz2Srz9BTY7sc+dKDBVLiVjKvRILf
 x4Rjl1CrAzLzJecFUYdzqc0Ejvzrl69IUeigq06Epzd62s7otj7zLZUkD0I9KDjVloya
 XNUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlX2QDYDJRc9d38Z9Jm/GZ7p1xF5phI+0CqkqJeHW9CxDGiZk/Fsyj9otb+QPHjfO0HOnqxG4=@lists.denx.de
X-Gm-Message-State: AOJu0YzmbmxP83pQQwZF/P5BlYMtZ5KA/Mub8Bq1aWvS7zV/8WaFJEEz
 u54a5DXzw+xWC5qpd+x/lhS4Ki0qGC2vzktDhIyGHyU9kzf02PxISKrUAZfRok3Syo+IWVUIFOO
 vtYzpDR1tw7OYr6pS39WZBEWwxSA=
X-Google-Smtp-Source: AGHT+IF128u7P8y+4pgI20opkyG1ESTuA3KRdX6aG/iOlXovlTmKu2iJMXjJjnn4L56/fxslGgNJt5s2X1TJPsoXOhI=
X-Received: by 2002:a2e:9a13:0:b0:2fa:d086:bca0 with SMTP id
 38308e7fff4ca-2fb61b4e6e0mr12368251fa.10.1729078584269; Wed, 16 Oct 2024
 04:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 08:36:12 -0300
Message-ID: <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] imx95_evk: add i.MX95 19x19 EVK board basic support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Marek Vasut <marex@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Alice,

On Wed, Oct 16, 2024 at 4:19=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.com> w=
rote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

A MAINTAINERS file is missing. CI flags this as an error.

Please make sure to run the series through CI before posting v2.

A general question: how is the flash.bin generated?

I don't see binman support here. Why?

We also need a doc/board/nxp/imx95_evk.rts file that explains how to
build and boot the board,
the firmware files it needs, etc.

> +++ b/board/freescale/imx95_evk/imx95_evk.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/clock.h>
> +#include <fdt_support.h>
> +#include <usb.h>
> +#include <dwc3-uboot.h>

Why do you add USB headers if there is no USB support?

> +#ifdef CONFIG_SCMI_FIRMWARE

Remove the ifdef and include the headers unconditionally.

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_early_init_f(void)
> +{
> +       /* UART1: A55, UART2: M33, UART3: M7 */
> +       init_uart_clk(0);

Shouldn't DM_SERIAL enable the UART clock?

> +#if CONFIG_IS_ENABLED(NET)
> +int board_phy_config(struct phy_device *phydev)
> +{
> +       if (phydev->drv->config)
> +               phydev->drv->config(phydev);
> +       return 0;

Is this needed?

> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +       return 0;

This function is not useful and can be removed.
> +extern int imx9_probe_mu(void);

No extern in C files, please.

> +       printf("SOC: 0x%x\n", gd->arch.soc_rev);
> +       printf("LC: 0x%x\n", gd->arch.lifecycle);

Make this debug() instead.

> +CONFIG_SPL_POWER=3Dy
> +CONFIG_SDP_LOADADDR=3D0x90400000
> +

No blank lines in defconfig, please.

Generate the defconfig via 'make savedefconfig'


> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       BOOTENV \
> +       AHAB_ENV \
> +       "initrd_addr=3D0x93800000\0" \
> +       "initrd_high=3D0xffffffffffffffff\0" \
> +       "emmc_dev=3D0\0"\
> +       "sd_dev=3D1\0" \
> +       "prepare_mcore=3Dsetenv mcore_clk clk-imx95.mcore_booted;\0" \
> +       "scriptaddr=3D0x93500000\0" \
> +       "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +       "image=3DImage\0" \
> +       "splashimage=3D0xA0000000\0" \
> +       "console=3DttyLP0,115200 earlycon\0" \
> +       "fdt_addr_r=3D0x93000000\0"                       \
> +       "fdt_addr=3D0x93000000\0"                 \
> +       "fdt_high=3D0xffffffffffffffff\0"         \
> +       "cntr_addr=3D0xA8000000\0"                        \
> +       "cntr_file=3Dos_cntr_signed.bin\0" \
> +       "boot_fit=3Dno\0" \
> +       "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "bootm_size=3D0x10000000\0" \
> +       "mmcdev=3D" __stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
> +       "mmcpart=3D1\0" \
> +       "mmcroot=3D/dev/mmcblk1p2 rootwait rw\0" \
> +       "mmcautodetect=3Dyes\0" \
> +       "mmcargs=3Dsetenv bootargs ${mcore_clk} console=3D${console} root=
=3D${mmcroot}\0 " \
> +       "loadbootscript=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${=
script};\0" \
> +       "bootscript=3Decho Running bootscript from mmc ...; " \
> +               "source\0" \
> +       "loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image=
}\0" \
> +       "loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfi=
le}\0" \
> +       "loadcntr=3Dfatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_=
file}\0" \
> +       "auth_os=3Dauth_cntr ${cntr_addr}\0" \
> +       "boot_os=3Dbooti ${loadaddr} - ${fdt_addr_r};\0" \
> +       "mmcboot=3Decho Booting from mmc ...; " \
> +               "run mmcargs; " \
> +               "if test ${sec_boot} =3D yes; then " \
> +                       "if run auth_os; then " \
> +                               "run boot_os; " \
> +                       "else " \
> +                               "echo ERR: failed to authenticate; " \
> +                       "fi; " \
> +               "else " \
> +                       "if test ${boot_fit} =3D yes || test ${boot_fit} =
=3D try; then " \
> +                               "bootm ${loadaddr}; " \
> +                       "else " \
> +                               "if run loadfdt; then " \
> +                                       "run boot_os; " \
> +                               "else " \
> +                                       "echo WARN: Cannot load the DT; "=
 \
> +                               "fi; " \
> +                       "fi;" \
> +               "fi;\0" \
> +       "netargs=3Dsetenv bootargs ${mcore_clk} console=3D${console} " \
> +               "root=3D/dev/nfs " \
> +               "ip=3Ddhcp nfsroot=3D${serverip}:${nfsroot},v3,tcp\0" \
> +       "netboot=3Decho Booting from net ...; " \
> +               "run netargs;  " \
> +               "if test ${ip_dyn} =3D yes; then " \
> +                       "setenv get_cmd dhcp; " \
> +               "else " \
> +                       "setenv get_cmd tftp; " \
> +               "fi; " \
> +               "if test ${sec_boot} =3D yes; then " \
> +                       "${get_cmd} ${cntr_addr} ${cntr_file}; " \
> +                       "if run auth_os; then " \
> +                               "run boot_os; " \
> +                       "else " \
> +                               "echo ERR: failed to authenticate; " \
> +                       "fi; " \
> +               "else " \
> +                       "${get_cmd} ${loadaddr} ${image}; " \
> +                       "if test ${boot_fit} =3D yes || test ${boot_fit} =
=3D try; then " \
> +                               "bootm ${loadaddr}; " \
> +                       "else " \
> +                               "if ${get_cmd} ${fdt_addr_r} ${fdtfile}; =
then " \
> +                                       "run boot_os; " \
> +                               "else " \
> +                                       "echo WARN: Cannot load the DT; "=
 \
> +                               "fi; " \
> +                       "fi;" \
> +               "fi;\0" \
> +       "bsp_bootcmd=3Decho Running BSP bootcmd ...; " \
> +               "mmc dev ${mmcdev}; if mmc rescan; then " \
> +                  "if run loadbootscript; then " \
> +                          "run bootscript; " \
> +                  "else " \
> +                          "if test ${sec_boot} =3D yes; then " \
> +                                  "if run loadcntr; then " \
> +                                          "run mmcboot; " \
> +                                  "else run netboot; " \
> +                                  "fi; " \
> +                           "else " \
> +                                  "if run loadimage; then " \
> +                                          "run mmcboot; " \
> +                                  "else run netboot; " \
> +                                  "fi; " \
> +                               "fi; " \
> +                  "fi; " \
> +          "fi;"

Move this to board/freescale/imx95_evk/imx95_evk.env
