Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBBD12D62
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 13:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B831F83B63;
	Wed,  3 Dec 2025 14:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="z3z7eJsd";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="GYqQU46K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E30383F24; Wed,  3 Dec 2025 14:53:21 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC6F83B48
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 14:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-vhs9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1764769998; 
 b=H/hX6HwEoGch1pZtISjW+qDSxp4BQqVcfPq6mCAWYxJqNCJsYjnIJpPlrNEstxbHuIkGmQnq1Q
 OxCWMdu14nNlv/4jexCfPElrxsclFeEBQ2GOuY8zyUrBcUiYHRKQCk0JX/5wKoaXAIE4KmbPfq
 iFC0+EZTR2Hax+1ladsr+BbiFMcHNnBA9oaoXJc+pPvps+o9pYvNbHIPoFYda2V3ggI4SD2+in
 qScz6wI8XlrEYJgNkQq42lnWnzMc4DF7tEgEkYENKT4rj1p7iEQWKb7Kdt4tE+67g3eMgXRW1J
 JUA3TO0pSVH8tEiMFtMu4uNyZeHCssoNOn12L/OSgAdZFw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-vhs9.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-vhs9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1764769998; 
 bh=yaDgebwwparI+W9C5Knykdf+0Ct43reo7h5iicndWzY=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=Y9mAo5sq4aqPwjZ4nz0+ro7WJR+Y8zj/XvtmFTjnBQtnfiZuyHt7aaaGD1E/Tn4chlt2UUi95K
 0ScqJfJWSqcwEG/Nvilf5h6L8AvaBWGEbp/KcRzwiRNWM9VSCNoJbgw+vG5nIuVCcu+KVOmEHj
 6ZfZRGNvNNQ/JqUB5NS/55Vmfvc/GTsWTS5jV/kHK0m9qLDeKA5Uu8YIaeYABlPQyBAbFeHT7+
 73bLHKY6DR+Q+HMczJ6XPO+qcoZLyo/W6mrBD6GtAG8tBdgu7U3L9TXupoI5cHPwj+RyZPRZAB
 tImldX83bIPVtdnS3qDGIp2C9SSpSwmHlQmtvSPPYJzLJw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=xzJflR+qqPS8kINMEJXcY04FJXG4qcO+YHcJgic9JQw=; b=z3z7eJsd3m5oJy3f1JBcwlJHrx
 ZwreBCJ/Kdb5ru1bMCaib4a+gENzdaHCrTynK2qhLYQDBdELpwg4MtzG46Bb+2mYmdWKO3NxIMGL5
 cGJFgC2PFGAN9sfpxTIyN4XA1IBnTQaAVAyU2TKbGM+oi+056ndvy/YMj/GdsZskqS1s=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-vhs9.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vQnIA-0000000B4TJ-3RJg
 for u-boot@lists.denx.de; Wed, 03 Dec 2025 13:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=xzJflR+qqPS8kINMEJXcY04FJXG4qcO+YHcJgic9JQw=; b=GYqQU46KrVE+XGGSBzgL/GnCTs
 YA4Q+ObtA7k8EO9QU/NK57jStXvnihzsk8PbV5ylHVMyfTd+uB5GTb+NyVDRXbAti+sfDc2IFUUgl
 08shE8x59xK+E2DMbzLFCsUiFSlmA9qLXdJX2RRTKP3CV1GUu4Iaa0Q40nEc7B0sVy+U=;
Received: from [82.59.186.57] (port=60149 helo=bywater)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vQnI4-000000005SG-1R3v; Wed, 03 Dec 2025 13:53:08 +0000
Date: Wed, 3 Dec 2025 14:53:06 +0100
From: Francesco Valla <francesco@valla.it>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
Subject: Re: [PATCH v2 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <aTBAwmWQJ3LfQYCw@bywater>
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9cd97cb2b0e2aa6f7f926db1417b720d
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vQnIA-0000000B4TJ-3RJg-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-vhs9.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hello Joseph,

On Tue, Dec 02, 2025 at 07:05:03PM +0900, Joseph Guo wrote:
> Add i.MX91 11x11 FRDM Board support.
>  - Four ddr scripts included w/o inline ecc feature. Support
>    both 1gb and 2gb DDR
>  - SDHC/EQOS/I2C/UART supported
>  - PCA9451 supported, default nominal drive mode
>  - Documentation added.
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
> Changes in v2:
> - correct commit message 'EVK' to 'FRDM'
> - use #include in ecc config file
> - add ecc description in README
> - drop extraneous includes
> - rename 'imx91_frdm.rst' to 'imx91_11x11_frdm.rst'
> - drop IMX91_FRDM_LPDDR4 symbol
> - drop bootph- property
> ---
>  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |   51 +
>  arch/arm/mach-imx/imx9/Kconfig                     |    9 +
>  board/freescale/imx91_frdm/Kconfig                 |   12 +
>  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
>  board/freescale/imx91_frdm/Makefile                |   16 +
>  board/freescale/imx91_frdm/imx91_frdm.c            |   25 +
>  board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
>  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
>  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
>  board/freescale/imx91_frdm/spl.c                   |  193 ++
>  configs/imx91_11x11_frdm_defconfig                 |  143 ++
>  configs/imx91_11x11_frdm_inline_ecc_defconfig      |    3 +
>  doc/board/nxp/imx91_11x11_frdm.rst                 |  100 +
>  doc/board/nxp/index.rst                            |    1 +
>  include/configs/imx91_frdm.h                       |   25 +
>  18 files changed, 8669 insertions(+)
> 
> diff --git a/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..2541d808aa084fb68a047c74b21daf8af044cc84
> --- /dev/null
> +++ b/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include "imx91-u-boot.dtsi"
> +
> +/ {
> +	wdt-reboot {
> +		compatible = "wdt-reboot";
> +		wdt = <&wdog3>;
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +};
> +
> +&usdhc2 {
> +	fsl,signal-voltage-switch-extra-delay-ms = <8>;
> +};
> +
> +&fec {
> +	compatible = "fsl,imx91-fec", "fsl,imx93-fec", "fsl,imx8mq-fec";
> +	phy-reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <15>;
> +	phy-reset-post-delay = <100>;
> +};
> +
> +&ethphy1 {
> +	reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
> +	reset-assert-us = <15000>;
> +	reset-deassert-us = <100000>;
> +};
> +
> +&s4muap {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	status = "okay";
> +};
> +
> +&clk {
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-rates;
> +	/delete-property/ assigned-clock-parents;
> +};
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index d9725a96043657768af424ffe8efed7155c78f69..1ac3e583068bc14444e5f68c3a79b21ddbfc24a0 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -61,6 +61,14 @@ config TARGET_IMX91_11X11_EVK
>  	imply BOOTSTD_FULL
>  	imply BOOTSTD_BOOTCOMMAND
>  
> +config TARGET_IMX91_11X11_FRDM
> +	bool "imx91_11x11_frdm"
> +	select OF_BOARD_FIXUP
> +	select IMX91
> +	select IMX9_LPDDR4X
> +	imply BOOTSTD_FULL
> +	imply BOOTSTD_BOOTCOMMAND
> +
>  config TARGET_IMX93_9X9_QSB
>  	bool "imx93_qsb"
>  	select OF_BOARD_FIXUP
> @@ -139,6 +147,7 @@ config TARGET_TORADEX_SMARC_IMX95
>  endchoice
>  
>  source "board/freescale/imx91_evk/Kconfig"
> +source "board/freescale/imx91_frdm/Kconfig"
>  source "board/freescale/imx93_evk/Kconfig"
>  source "board/freescale/imx93_frdm/Kconfig"
>  source "board/freescale/imx93_qsb/Kconfig"
> diff --git a/board/freescale/imx91_frdm/Kconfig b/board/freescale/imx91_frdm/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..68f4bb5c7ecda2b0847ecfd10f954283c4068960
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_IMX91_11X11_FRDM
> +
> +config SYS_BOARD
> +	default "imx91_frdm"
> +
> +config SYS_VENDOR
> +	default "freescale"
> +
> +config SYS_CONFIG_NAME
> +	default "imx91_frdm"
> +
> +endif
> diff --git a/board/freescale/imx91_frdm/MAINTAINERS b/board/freescale/imx91_frdm/MAINTAINERS
> new file mode 100644
> index 0000000000000000000000000000000000000000..bf5320f03dbb78e97e1e990408d43dc89054e397
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/MAINTAINERS
> @@ -0,0 +1,7 @@
> +FRDM-IMX91 BOARD
> +M:	Joseph Guo <qijian.guo@nxp.com>
> +S:	Maintained
> +F:	board/freescale/imx91_frdm/
> +F:	include/configs/imx91_frdm.h
> +F:	configs/imx91_11x11_frdm_defconfig
> +F:	configs/imx91_11x11_frdm_inline_ecc_defconfig
> diff --git a/board/freescale/imx91_frdm/Makefile b/board/freescale/imx91_frdm/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..75510b13b44ead742b5c463ba5e520e0d33a64f7
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/Makefile
> @@ -0,0 +1,16 @@
> +#
> +# Copyright 2025 NXP
> +#
> +# SPDX-License-Identifier:      GPL-2.0+
> +#
> +
> +obj-y += imx91_frdm.o
> +
> +ifdef CONFIG_SPL_BUILD
> +obj-y += spl.o
> +ifdef CONFIG_IMX9_DRAM_INLINE_ECC
> +obj-y += lpddr4_2400mts_ecc_1gb_timing.o lpddr4_2400mts_ecc_2gb_timing.o
> +else
> +obj-y += lpddr4_2400mts_1gb_timing.o lpddr4_2400mts_2gb_timing.o
> +endif
> +endif
> diff --git a/board/freescale/imx91_frdm/imx91_frdm.c b/board/freescale/imx91_frdm/imx91_frdm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f32310e4a9df87e5d876cfa50e4ff38c31f887d7
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/imx91_frdm.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <env.h>
> +#include <asm/arch/sys_proto.h>
> +
> +int board_late_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +		board_late_mmc_env_init();
> +

This should probably depend on CONFIG_ENV_IS_IN_MMC, not
CONFIG_EFI_HAVE_CAPSULE_SUPPORT.

> +	env_set("sec_boot", "no");
> +
> +	if (IS_ENABLED(CONFIG_AHAB_BOOT))
> +		env_set("sec_boot", "yes");
> +
> +	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
> +		env_set("board_name", "11X11_FRDM");
> +		env_set("board_rev", "iMX91");
> +	}
> +
> +	return 0;
> +}
> diff --git a/board/freescale/imx91_frdm/imx91_frdm.env b/board/freescale/imx91_frdm/imx91_frdm.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..6c10784cf61a9a6ee29f4c5e9c4cc41b6c8ef4dc
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/imx91_frdm.env
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +boot_targets=mmc0 mmc1
> +boot_fit=no
> +bootm_size=0x10000000
> +cntr_addr=0x98000000
> +cntr_file=os_cntr_signed.bin
> +console=ttyLP0,115200 earlycon
> +fdt_addr_r=0x83000000
> +fdt_addr=0x83000000
> +fdtfile=CONFIG_DEFAULT_FDT_FILE
> +image=Image
> +mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
> +mmcpart=1
> +mmcroot=/dev/mmcblk1p2 rootwait rw
> +mmcautodetect=yes
> +mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
> +prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted

There isn't a Cortex-M core in i.MX91.

> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> +loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
> +auth_os=auth_cntr ${cntr_addr}
> +sec_boot=no
> +boot_os=booti ${loadaddr} - ${fdt_addr_r}
> +mmcboot=
> +	echo Booting from mmc ...;
> +	run mmcargs;
> +	if test ${sec_boot} = yes; then
> +		if run true; then
> +			run boot_os;
> +		else
> +			echo ERR: failed to authenticate;
> +		fi;
> +	else
> +		if run loadfdt; then
> +			run boot_os;
> +		else
> +			echo WARN: Cannot load the DT;
> +		fi;
> +	fi;
> +netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
> +	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
> +netboot=
> +	echo Booting from net ...;
> +	run netargs;
> +	if test ${ip_dyn} = yes; then
> +		setenv get_cmd dhcp;
> +	else
> +		setenv get_cmd tftp;
> +	fi;
> +	if test ${sec_boot} = yes; then
> +		${get_cmd} ${cntr_addr} ${cntr_file};
> +		if true; then
> +			run boot_os;
> +		else
> +			echo ERR: failed to authenticate;
> +		fi;
> +	else
> +		${get_cmd} ${loadaddr} ${image};
> +		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
> +			run boot_os;
> +		else
> +			echo WARN: Cannot load the DT;
> +		fi;
> +	fi;
> +bsp_bootcmd=
> +	echo Running BSP bootcmd ...;
> +	mmc dev ${mmcdev};
> +	if mmc rescan; then
> +		if run loadbootscript; then
> +			run bootscript;
> +		else
> +			if test ${sec_boot} = yes; then
> +				if run loadcntr; then
> +					run mmcboot;
> +				else
> +					run netboot;
> +				fi;
> +			else
> +				if run loadimage; then
> +					run mmcboot;
> +				else
> +					run netboot;
> +				fi;
> +			fi;
> +		fi;
> +	fi;
> +scriptaddr=0x83500000

[snip]

> diff --git a/configs/imx91_11x11_frdm_defconfig b/configs/imx91_11x11_frdm_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..f87f3bf5ef797816843398dceedd873b7acbb7ad
> --- /dev/null
> +++ b/configs/imx91_11x11_frdm_defconfig
> @@ -0,0 +1,143 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_IMX9=y
> +CONFIG_TEXT_BASE=0x80200000
> +CONFIG_SYS_MALLOC_LEN=0x2000000
> +CONFIG_SYS_MALLOC_F_LEN=0x18000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SF_DEFAULT_SPEED=40000000
> +CONFIG_ENV_SIZE=0x4000
> +CONFIG_ENV_OFFSET=0x700000
> +CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-frdm"
> +CONFIG_TARGET_IMX91_11X11_FRDM=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SYS_MONITOR_LEN=524288
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK=0x204E0000
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
> +CONFIG_SPL_TEXT_BASE=0x204A0000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20498000
> +CONFIG_SPL_BSS_MAX_SIZE=0x2000
> +CONFIG_SYS_LOAD_ADDR=0x80400000
> +CONFIG_SPL=y
> +CONFIG_CMD_DEKBLOB=y
> +CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
> +CONFIG_SYS_MEMTEST_START=0x80000000
> +CONFIG_SYS_MEMTEST_END=0x90000000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
> +CONFIG_DEFAULT_FDT_FILE="imx91-11x11-frdm.dtb"
> +CONFIG_SYS_CBSIZE=2048
> +CONFIG_SYS_PBSIZE=2074
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_BOARD_LATE_INIT=y
> +CONFIG_SPL_MAX_SIZE=0x26000
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_BOOTROM_SUPPORT=y
> +CONFIG_SPL_LOAD_IMX_CONTAINER=y
> +CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_WATCHDOG=y
> +CONFIG_SYS_PROMPT="u-boot=> "
> +CONFIG_CMD_CPU=y
> +CONFIG_CMD_ERASEENV=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CRC32_VERIFY=y
> +CONFIG_CMD_MEMTEST=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_FUSE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_SNTP=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_RTC=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_GETTIME=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_HASH=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_MMC_DEVICE_INDEX=1
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="eth1"
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_ADC=y
> +CONFIG_ADC_IMX93=y
> +CONFIG_CLK_IMX93=y
> +CONFIG_SAVED_DRAM_TIMING_BASE=0x2049C000
> +CONFIG_IMX_RGPIO2P=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_ADP5585_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_IMX_LPI2C=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_FSL_USDHC=y
> +CONFIG_MTD=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_STMICRO=y

Why is SPI flash support required here?

> +CONFIG_PHY_ANEG_TIMEOUT=20000
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_IMX=y
> +CONFIG_MII=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PINCTRL_IMX93=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_PCA9450=y
> +CONFIG_SPL_DM_PMIC_PCA9450=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_PCA9450=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_EMULATION=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_FSL_LPUART=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_NXP_FSPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_CMD_POWEROFF=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_ULP_WATCHDOG=y
> +CONFIG_WDT=y
> +CONFIG_SHA384=y
> +CONFIG_LZO=y
> +CONFIG_BZIP2=y

[snip]


Regards,
Francesco

