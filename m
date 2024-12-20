Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01959E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F35803EE;
	Fri, 20 Dec 2024 18:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H50olU4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C8C803DC; Fri, 20 Dec 2024 18:37:06 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96587803B9
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so396816066b.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716223; x=1735321023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oIro4+Uluqs2cIrQWIO2S/KYQEhaz1+dclR0A65+dDE=;
 b=H50olU4uxNX3aiWQDYEQESkAzUHypYLBVrufotsMB2lmC89o2E/fG43kJQH5oOLDPf
 4QarLzOLT422mY6j2w8X7N6YVYu2CVUGd86R9cu7iWlpguO8rb8kR3nMJmHzZFaHcxBH
 td4bGYcdflArBYSAJyJ3o3dfJ01bfj7+bmP4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716223; x=1735321023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oIro4+Uluqs2cIrQWIO2S/KYQEhaz1+dclR0A65+dDE=;
 b=g67LIB9wL3ZbqqhWgxt/5VCz8CfboKPSHsyv4wnjf/8mTvg7Ohs2GLgQRvT9StT5W7
 NRzNDUN3xG66yaTTEPBpobtU82Un/KCkTFZYtAkBQh+jaobqs/iTxbZzgnYeTj4n2QLW
 nKkBLHOQGvGhCh9wwhy9+eIfwWFW1IPRms+IejpSIeGrCtq3jIlQpVL1Z6YUI6E0bCFN
 dhSTiU7hYGgxBYU0n8j3DkRQf+jgHTP+pQQfgvE22D5ye+wPM3VWUpO44XPKFlxVLP5x
 5myz4t/9IheeVrvfZAQbn1KodtlAeieb/CCMguaUzrDZgwHXlFNh4znJFfEevxbQ0eB8
 YaWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVitWW5w6B6N/37lZn88nEd9j8vEehCjj3VKSb2XY+lHpfxwBjJFi/gks03eItnM2mPUigxbLY=@lists.denx.de
X-Gm-Message-State: AOJu0YxtmsVkXzSmqMo0zhLPpq/FBxkxO5vIiZIiYtMxSuJPh5EkFr/u
 qflRrazTUrZFr6pfVlbZB3ZbU1B46jQt6Sn6THmoBq66uGDS+Ka8Mi9iszcKZeiG6faf1gSEY24
 pKV25LaxEq7d+NCcnQPYld4ldg++rZ9uVjPdi
X-Gm-Gg: ASbGncubDXo7LKNm0f/gR0ZXPvPvdsz+kPgHFNfdWayzLof01AbgHqBZ1rAMIHuXevS
 inXzwQF8Zz83bDvN01oZoMptXneyq5yoY+5mOI1M=
X-Google-Smtp-Source: AGHT+IGZ83kX8Y2mTrWBIXI+o7iaSj3PK1aFfZwUDO5VR2kJgIQsyuJYwzfWRnbbe/BU8FDr5Q9fYKSrOmYaO/J8O7U=
X-Received: by 2002:a17:907:708:b0:aa6:c161:9935 with SMTP id
 a640c23a62f3a-aac334f61f8mr312796266b.44.1734716222992; Fri, 20 Dec 2024
 09:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:36:50 -0700
Message-ID: <CAFLszThYc3=cT73xbX4oRYRJ5SdcMJntNYwCkB4t+yKEsuaJyw@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, 
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
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

Hi Alice,

On Thu, 19 Dec 2024 at 19:56, Alice Guo <alice.guo@oss.nxp.com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      | 224 ++++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/Kconfig                |   6 +
>  arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 ++
>  arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
>  board/freescale/imx95_evk/Kconfig             |  12 ++
>  board/freescale/imx95_evk/MAINTAINERS         |   6 +
>  board/freescale/imx95_evk/Makefile            |  11 ++
>  board/freescale/imx95_evk/imx95_19x19_evk.env |  95 +++++++++++
>  board/freescale/imx95_evk/imx95_evk.c         |  54 +++++++
>  board/freescale/imx95_evk/spl.c               | 117 ++++++++++++++
>  configs/imx95_19x19_evk_defconfig             | 178 ++++++++++++++++++++
>  doc/board/nxp/imx95_evk.rst                   | 109 +++++++++++++
>  doc/board/nxp/index.rst                       |   1 +
>  include/configs/imx95_evk.h                   |  36 +++++
>  15 files changed, 875 insertions(+)
>
> diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..5c891518448d24204f5ca2a00957b47a0a24bd70
> --- /dev/null
> +++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifdef CONFIG_BINMAN
> +/ {
> +       binman {
> +               multiple-images;
> +
> +               m33-oei-ddrfw {
> +                       filename = "m33-oei-ddrfw.bin";
> +
> +                       nxp-append-ddrfw {
> +                               oei_m33_ddr_image = "oei-m33-ddr.bin";
> +                               lpddr_imem = "lpddr5_imem_v202311.bin";
> +                               lpddr_dmem = "lpddr5_dmem_v202311.bin";
> +                               lpddr_imem_qb = "lpddr5_imem_qb_v202311.bin";
> +                               lpddr_dmem_qb = "lpddr5_dmem_qb_v202311.bin";
> +                       };
> +               };
> +
> +               spl {
> +                       filename = "spl.bin";
> +
> +                       mkimage {
> +                               args = "-n spl/u-boot-spl.cfgout -T imx8image";
> +                       };
> +               };
> +
> +               u-boot {
> +                       filename = "uboot.bin";
> +
> +                       mkimage {
> +                               args = "-n u-boot-container.cfgout -T imx8image";
> +                       };
> +               };
> +
> +               imx-boot {
> +                       filename = "imx-boot-imx95.bin";
> +                       pad-byte = <0x00>;
> +
> +                       blob-ext@1 {
> +                               align = <0x400>;
> +                               align-size = <0x400>;
> +                               offset = <0x0>;
> +                               filename = "spl.bin";
> +                       };

For this node you should just be able to do something like:

imx-boot {
   filename = "imx-boot-imx95.bin";
   pad-byte = <0x00>;
   spl {
      type = "mkimage";
      args = "-n spl/u-boot-spl.cfgout -T imx8image";
      align = <0x400>;
      align-size = <0x400>;
   };

You don't need to create intermediate files for all this stuff, so
drop your 'filename' properties.

> +                       blob-ext@2 {
> +                               filename = "uboot.bin";
> +                       };

similar for this one

[..]

> diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..27e09d3d70a068efb97d69b27089d1f213f39ee9
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
> @@ -0,0 +1,95 @@
> +sec_boot=no
> +initrd_addr=0x93800000
> +emmc_dev=0
> +sd_dev=1
> +prepare_mcore=setenv mcore_clk clk-imx95.mcore_booted
> +scriptaddr=0x93500000
> +kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "
> +image=Image
> +splashimage=0xA0000000
> +console=ttyLP0,115200 earlycon
> +fdt_addr_r=0x93000000
> +fdt_addr=0x93000000
> +cntr_addr=0xA8000000
> +cntr_file=os_cntr_signed.bin
> +boot_fit=no
> +fdtfile=" CONFIG_DEFAULT_FDT_FILE "
> +bootm_size=0x10000000
> +mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV)"
> +mmcpart=1
> +mmcroot=/dev/mmcblk1p2 rootwait rw
> +mmcautodetect=yes
> +mmcargs=setenv bootargs ${mcore_clk} console=${console} root=${mmcroot}
> +loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
> +bootscript=echo Running bootscript from mmc ...; source
> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> +loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
> +auth_os=auth_cntr ${cntr_addr}
> +boot_os=booti ${loadaddr} - ${fdt_addr_r};
> +mmcboot=echo Booting from mmc ...;
> +               run mmcargs;
> +               if test ${sec_boot} = yes; then
> +                       if run auth_os; then
> +                               run boot_os;
> +                       else
> +                               echo ERR: failed to authenticate;
> +                       fi;
> +               else
> +                       if test ${boot_fit} = yes || test ${boot_fit} = try; then
> +                               bootm ${loadaddr};
> +                       else
> +                               if run loadfdt; then
> +                                       run boot_os;
> +                               else
> +                                       echo WARN: Cannot load the DT;
> +                               fi;
> +                       fi;
> +               fi;
> +netargs=setenv bootargs ${mcore_clk} console=${console}
> +               root=/dev/nfs
> +               ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
> +netboot=echo Booting from net ...;
> +               run netargs;
> +               if test ${ip_dyn} = yes; then
> +                       setenv get_cmd dhcp;
> +               else
> +                       setenv get_cmd tftp;
> +               fi;
> +               if test ${sec_boot} = yes; then
> +                       ${get_cmd} ${cntr_addr} ${cntr_file};
> +                       if run auth_os; then
> +                               run boot_os;
> +                       else
> +                               echo ERR: failed to authenticate;
> +                       fi;
> +               else
> +                       ${get_cmd} ${loadaddr} ${image};
> +                       if test ${boot_fit} = yes || test ${boot_fit} = try; then
> +                               bootm ${loadaddr};
> +                       else
> +                               if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
> +                                       run boot_os;
> +                               else
> +                                       echo WARN: Cannot load the DT;
> +                               fi;
> +                       fi;
> +               fi;
> +bsp_bootcmd=echo Running BSP bootcmd ...;
> +                       mmc dev ${mmcdev}; if mmc rescan; then
> +                       if run loadbootscript; then
> +                               run bootscript;
> +                       else
> +                               if test ${sec_boot} = yes; then
> +                                       if run loadcntr; then
> +                                               run mmcboot;
> +                                       else run netboot;
> +                                       fi;
> +                               else
> +                                       if run loadimage; then
> +                                               run mmcboot;
> +                                       else run netboot;
> +                                       fi;
> +                               fi;
> +                       fi;
> +               fi;
> \ No newline at end of file

Could this be moved to use standard boot?

> diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c75a8f2450288a34cfc01150d3c42b07f2215491
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_evk.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/clock.h>
> +#include <fdt_support.h>
> +#include <asm/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/gpio.h>
> +#include <asm/mach-imx/sys_proto.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_early_init_f(void)
> +{
> +       /* UART1: A55, UART2: M33, UART3: M7 */
> +       init_uart_clk(0);
> +
> +       return 0;

[..]

> +void board_init_f(ulong dummy)
> +{
> +       int ret;
> +       bool ddrmix_power = false;
> +
> +       /* Clear the BSS. */
> +       memset(__bss_start, 0, __bss_end - __bss_start);
> +
> +#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
> +       if (IS_ENABLED(CONFIG_SPL_BUILD))
> +               spl_save_restore_data();
> +#endif
> +
> +       timer_init();
> +
> +       /* Need dm_init() to run before any SCMI calls can be made. */
> +       spl_early_init();
> +
> +       /* Need enable SCMI drivers and ELE driver before enabling console */
> +       ret = imx9_probe_mu();
> +       if (ret)
> +               hang(); /* if MU not probed, nothing can output, just hang here */
> +
> +       arch_cpu_init();
> +
> +       board_early_init_f();
> +
> +       preloader_console_init();
> +
> +       debug("SOC: 0x%x\n", gd->arch.soc_rev);
> +       debug("LC: 0x%x\n", gd->arch.lifecycle);
> +
> +       /* Will set ARM freq to max rate */
> +       clock_init_late();
> +
> +       /* Check is DDR MIX is already powered up. */
> +       u32 state = 0;
> +       struct udevice *dev;
> +
> +       ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
> +       if (ret)
> +               printf("%s: %d\n", __func__, ret);
> +
> +       ret = scmi_pwd_state_get(dev, IMX95_PD_DDR, &state);
> +       if (ret) {
> +               printf("scmi_pwd_state_get Failed %d for DDRMIX\n", ret);
> +       } else {
> +               if (state == BIT(30)) {
> +                       panic("DDRMIX is powered OFF, Please initialize DDR with OEI \n");
> +               } else {
> +                       printf("DDRMIX is powered UP \n");
> +                       ddrmix_power = true;
> +               }
> +       }

How about putting this code in a separate function (called from
board_init_f()) so you can check errors consistently, and always hang
or panic in that situation?

> +
> +       board_init_r(NULL, 0);
> +}

[..]

> diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2be474aa71f0f8d934f956c8840d330fbee98df
> --- /dev/null
> +++ b/doc/board/nxp/imx95_evk.rst
> @@ -0,0 +1,109 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx95_evk
> +=======================
> +
> +U-Boot for the NXP i.MX95 19x19 EVK board
> +
> +Quick Start
> +-----------
> +
> +- Get ahab-container.img
> +- Get the DDR PHY Firmware Images
> +- Get and Build OEI Images
> +- Get and Build System Manager Image
> +- Get and Build the ARM Trusted Firmware
> +- Build the Bootloader Image
> +- Boot
> +
> +Get ahab-container.img
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
> +   $ chmod +x firmware-ele-imx-1.3.0-17945fc.bin
> +   $ ./firmware-ele-imx-1.3.0-17945fc.bin
> +   $ cp firmware-ele-imx-1.3.0-17945fc.bin/mx95a0-ahab-container.img $(srctree)
> +
> +Get the DDR PHY Firmware Images
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
> +   $ chmod +x firmware-imx-8.26-d4c33ab.bin
> +   $ ./firmware-imx-8.26-d4c33ab.bin
> +   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
> +
> +Get and Build OEI Images
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get OEI from: https://github.com/nxp-imx/imx-oei
> +branch: master
> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=$PWD
> +   $ make board=mx95lp5 oei=ddr DEBUG=1
> +   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
> +
> +   $ make board=mx95lp5 oei=tcm DEBUG=1
> +   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)

Blobs should be accessed via environment variables (like TEE, BL31) or
using the binman input path. How about creating an IMX_BLOBS variable
and adding to Makefile like '-a imx-blobs=$(IMX_BLOBS)'  - see
ti-dm-path for an example.

> +
> +Get and Build System Manager Image
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get System Manager from: https://github.com/nxp-imx/imx-sm
> +branch: master
> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=$PWD
> +   $ make config=mx95evk all
> +   $ cp build/mx95evk/m33_image.bin $(srctree)
> +
> +Get and Build the ARM Trusted Firmware
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get ATF from: https://github.com/nxp-imx/imx-atf/
> +branch: lf_v2.10
> +
> +.. code-block:: bash
> +
> +   $ unset LDFLAGS
> +   $ make PLAT=imx95 bl31
> +   $ cp build/imx95/release/bl31.bin $(srctree)
> +
> +Build the Bootloader Image
> +------------
> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=aarch64-poky-linux-
> +   $ make imx95_19x19_evk_defconfig
> +   $ make
> +
> +Copy imx-boot-imx95.bin to the MicroSD card:
> +
> +.. code-block:: bash
> +
> +   $ sudo dd if=imx-boot-imx95.bin of=/dev/sdb bs=1k seek=32 conv=fsync

Good instructions.

Regards,
Simon
