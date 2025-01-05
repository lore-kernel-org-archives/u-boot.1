Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CC3E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06A0805FD;
	Sun,  5 Jan 2025 23:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115157;
	bh=3vXcRrHZa8nhISf6LqEnxeMrZzJFjpKyrDgExtjEvdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+UBaoRogv4O+3Slo7eeO7nxSFxwCypFPmFkQzJ+Qr29zLXmSGgtH5wQoVQMEBGv7
	 6yYgyY8D7oY1qnDYyM9JDxIGzzAUTSl+JxOlYCEvvIqXlFR4QwvU/Y/B96LN8HXz9s
	 OpEr3dCEpXFOWdzPVwmHM0zxZveaHXJl2QnWbQq5lhCFE9WPDd6yGPloWn46OkJ44w
	 cV1fv94JDBjyhJlm4Z0l/2O51X7xtvhLQbNms8HXtvlsBmwIX0kIysJD+kwI0nfeDv
	 Dqs++NO6708WihysegVeWmpHYU5NDmRiQdjmj0+3it7w/HAIJ0rZF97TelzT7g4KyT
	 9lvB6LqDDm6HA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912CD805FA; Sun,  5 Jan 2025 23:12:35 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D468805ED
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="O8cviZkd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C3F61104839FE; Sun,  5 Jan 2025 23:12:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vXcRrHZa8nhISf6LqEnxeMrZzJFjpKyrDgExtjEvdc=;
 b=O8cviZkdTqjjCUtQp2sOCjaPIcMvb7eeWhBHO+W428i42pRKVhYo8nGOjn9UBPPZ6vSeDs
 9YbaDpUmhA9UpFUJU82yOiiuC60+0IxQai5bDXqsCbtDpTVUZ54hi1Gj7OAm3fRXaKoXVo
 sXsomHnGUycinnmiLm9cDlxOLh96W4wvLn8VJ6a3cYYtGO/DohGhNprqiK0L5UeculeZ3Q
 ty7IVAg2zJuAoYc/GTJuxpN+6YKsfbaSOHb4j+XC3vG+noL5o2sALSiEpSpRgpczCG5c1+
 bD+4ezWd81U+FvEmRkiJ/0Dd4yRz49JE+zQHXR8WsI0pcwKoyPvGTcmbWssXcQ==
Message-ID: <a7bb6fe2-8f97-4519-8979-339c8c4f6f93@denx.de>
Date: Sun, 5 Jan 2025 23:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> This patch adds i.MX95 19x19 EVK board basic support.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>


[...]

> diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..36169b56ef3075a5c243f7fb1afd6399b0df77ad
> --- /dev/null
> +++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "imx95-u-boot.dtsi"
> +
> +&gpio1 {
> +	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
> +};
> +
> +&lpuart1 {
> +	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
> +	clock-names = "ipg", "per";
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_uart1 {
> +	bootph-pre-ram;
> +};
> +
> +&usdhc1 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1 {
> +	bootph-pre-ram;
> +};

Keep this DT sorted alphabetically .

[...]

> +++ b/arch/arm/dts/imx95-u-boot.dtsi
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/ {
> +    binman {
> +        multiple-images;

Indent with tabs, consistently.

> +        m33-oei-ddrfw {
> +            pad-byte = <0x00>;
> +            align-size = <0x8>;
> +            filename = "m33-oei-ddrfw.bin";
> +
> +            oei-m33-ddr {
> +                align-size = <0x4>;
> +                filename = "oei-m33-ddr.bin";
> +                type = "blob-ext";
> +            };
> +
> +            imx-lpddr {
> +                type = "nxp-header-ddrfw";
> +
> +                imx-lpddr-imem {
> +                    filename = "lpddr5_imem_v202311.bin";
> +                    type = "blob-ext";
> +                };
> +
> +                imx-lpddr-dmem {
> +                    filename = "lpddr5_dmem_v202311.bin";
> +                    type = "blob-ext";
> +                };
> +            };
> +
> +            imx-lpddr-qb {
> +                type = "nxp-header-ddrfw";
> +
> +                imx-lpddr-imem-qb {
> +                    filename = "lpddr5_imem_qb_v202311.bin";
> +                    type = "blob-ext";
> +                };
> +
> +                imx-lpddr-dmem-qb {
> +                    filename = "lpddr5_dmem_qb_v202311.bin";
> +                    type = "blob-ext";
> +                };
> +            };
> +        };


Can you include a totem-pole illustration of the firmware format in the 
docs ? Like the one in doc/imx/habv4/guides/mx8m_spl_secure_boot.txt , 
search for 'Image Vector Table' .

> +		imx-boot {
> +			filename = "flash.bin";
> +			pad-byte = <0x00>;
> +
> +            spl {
> +                align = <0x400>;
> +                align-size = <0x400>;
> +                type = "mkimage";
> +                args = "-n spl/u-boot-spl.cfgout -T imx8image";
> +            };
> +
> +            u-boot {
> +                type = "mkimage";
> +                args = "-n u-boot-container.cfgout -T imx8image";
> +            };
> +		};

I have a feeling this will have to be restructured to assemble the image 
correctly .

> +	};
> +};
> +
> +&{/soc} {
> +	bootph-all;
> +	bootph-pre-ram;

Are both bootph-all and bootph-pre-ram needed ?

[...]

> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index 8a7df24afecc1d6d77b7162be639b56af95fd975..38ade99964b64512ba93423efcaa0cfb58094b00 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -43,6 +43,7 @@
>   #endif
>   #include <spl.h>
>   #include <mmc.h>
> +#include <asm/arch/mu.h>

Should this change be part of this patch ?

>   DECLARE_GLOBAL_DATA_PTR;
>   

[...]

> diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d2b5dfcf07d251c77440bae44d62bff6253dfc7
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
> @@ -0,0 +1,90 @@
> +sec_boot=no
> +initrd_addr=0x93800000
> +emmc_dev=0
> +sd_dev=1
> +scriptaddr=0x93500000
> +kernel_addr_r=CONFIG_SYS_LOAD_ADDR
> +image=Image
> +splashimage=0xA0000000
> +console=ttyLP0,115200 earlycon
> +fdt_addr_r=0x93000000
> +fdt_addr=0x93000000
> +cntr_addr=0xA8000000
> +cntr_file=os_cntr_signed.bin
> +boot_fit=no
> +fdtfile=CONFIG_DEFAULT_FDT_FILE
> +bootm_size=0x10000000
> +mmcautodetect=yes
> +mmcargs=setenv bootargs console=${console} root=${mmcroot}
> +loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
> +bootscript=echo Running bootscript from mmc ...; source
> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> +loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
> +auth_os=auth_cntr ${cntr_addr}
> +boot_os=booti ${loadaddr} - ${fdt_addr_r};
> +mmcboot=echo Booting from mmc ...;

Why not use bootmethod ?

[...]

> diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..54f56c8049876fde335485a5c3bd54dff6e4f730
> --- /dev/null
> +++ b/board/freescale/imx95_evk/spl.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <command.h>
> +#include <cpu_func.h>
> +#include <clk.h>
> +#include <hang.h>
> +#include <image.h>
> +#include <init.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/mach-imx/syscounter.h>
> +#include <asm/mach-imx/ele_api.h>
> +#include <asm/sections.h>

Are all these headers really needed ?

Remove the unneeded ones .

> +#include <dm/uclass.h>
> +#include <dm/device.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/device-internal.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/ccm_regs.h>
> +#ifdef CONFIG_SCMI_FIRMWARE
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
> +#endif
> +#include <asm/arch/mu.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int spl_board_boot_device(enum boot_device boot_dev_spl)
> +{
> +	switch (boot_dev_spl) {
> +	case SD1_BOOT:
> +	case MMC1_BOOT:
> +		return BOOT_DEVICE_MMC1;
> +	case SD2_BOOT:
> +	case MMC2_BOOT:
> +		return BOOT_DEVICE_MMC2;
> +	case USB_BOOT:
> +		return BOOT_DEVICE_BOARD;
> +	default:
> +		return BOOT_DEVICE_NONE;
> +	}
> +}
> +
> +void spl_board_init(void)
> +{
> +	puts("Normal Boot\n");
> +}
> +
> +void board_init_f(ulong dummy)
> +{
> +	int ret;
> +
> +	/* Clear the BSS. */
> +	memset(__bss_start, 0, __bss_end - __bss_start);

Is memset this necessary ? I don't think it is.

[...]

> diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..132c45ed485148366533ee31485a4d5a41556eb0
> --- /dev/null
> +++ b/doc/board/nxp/imx95_evk.rst
> @@ -0,0 +1,116 @@
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
> +- Get DDR PHY Firmware Images
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

It is possible to somehow only download and extract the file, without 
running script that was downloaded from the internet, without any 
validation ?

[...]

> +++ b/include/configs/imx95_evk.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __IMX95_EVK_H
> +#define __IMX95_EVK_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>
> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE	\
> +	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
> +
> +#define CFG_SYS_INIT_RAM_ADDR        0x90000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x90000000
> +#define PHYS_SDRAM                      0x90000000
> +/* Totally 16GB */
> +#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB  - 256MB DDR */
> +#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
> +
> +#define CFG_SYS_FSL_USDHC_NUM	2

Is this still needed ?

> +/* Using ULP WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
Is this still needed ? DM WDT should be able to look up the address from 
DT .
