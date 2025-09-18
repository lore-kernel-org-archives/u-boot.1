Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8779DCAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 18:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C577C81E13;
	Thu, 18 Sep 2025 20:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bKJmV6HH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F4082C84; Thu, 18 Sep 2025 20:25:19 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3DC880B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 20:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58IIPFS6068751
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 13:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758219915;
 bh=OD7Mn+m+cWzjhLzykSTVzAz6/lNVLVAzaeAY+ujdVjs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bKJmV6HHIOX2kDCo4O8v7VRFe2vHnDX4HJUwfApLxt1vowle1MDcKQhMPCJzECpyU
 jyiWrCmXfMgbxqWwk9WLVWfDHHTMROmV1PbQHt9mKFNRUAm3BOT/vwYeAfR3nFh9ml
 mLYfjmn9zJQaw1ZwnWpdy6D6a3i17vy5tcaFMqB4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58IIPFx01742490
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 13:25:15 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 13:25:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 13:25:15 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58IIPERh1014014;
 Thu, 18 Sep 2025 13:25:14 -0500
Message-ID: <91672e8d-dbf0-455d-8140-fc03c21c0b9b@ti.com>
Date: Thu, 18 Sep 2025 13:25:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/1] Add initial support for AM62D2-EVM
To: Paresh Bhagat <p-bhagat@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <anshuld@ti.com>
References: <20250918173701.138803-1-p-bhagat@ti.com>
 <20250918173701.138803-2-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250918173701.138803-2-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 9/18/25 12:37 PM, Paresh Bhagat wrote:
> Add initial support for AM62D2-EVM, Kconfig entries for binman, spl,
> base dts files for uboot and spl, HS-SE and HS-FS binman support and
> initial configs with SD-MMC, UART, eMMC and OSPI boot providing a
> baseline for further enablement.
> 
> Technical Reference Manual - https://www.ti.com/lit/pdf/sprujd4
> Schematics Link - https://www.ti.com/lit/zip/sprcal5
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>   arch/arm/dts/Makefile                        |    2 +
>   arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
>   arch/arm/dts/k3-am62d-evm-binman.dtsi        |  314 ++
>   arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   13 +
>   arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
>   arch/arm/mach-k3/am62ax/Kconfig              |   21 +
>   board/ti/am62dx/Kconfig                      |   26 +
>   board/ti/am62dx/MAINTAINERS                  |    8 +
>   board/ti/am62dx/Makefile                     |    7 +
>   board/ti/am62dx/am62dx.env                   |   21 +
>   board/ti/am62dx/evm.c                        |   37 +
>   configs/am62dx_evm_a53_defconfig             |   22 +
>   configs/am62dx_evm_r5_defconfig              |   20 +
>   13 files changed, 3375 insertions(+)
>   create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
>   create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
>   create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>   create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
>   create mode 100644 board/ti/am62dx/Kconfig
>   create mode 100644 board/ti/am62dx/MAINTAINERS
>   create mode 100644 board/ti/am62dx/Makefile
>   create mode 100644 board/ti/am62dx/am62dx.env
>   create mode 100644 board/ti/am62dx/evm.c
>   create mode 100644 configs/am62dx_evm_a53_defconfig
>   create mode 100644 configs/am62dx_evm_r5_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index b69eb7cbb94..c98a48c8557 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1109,6 +1109,8 @@ dtb-$(CONFIG_SOC_K3_AM62A7) += \
>   	k3-am62a7-r5-sk.dtb \
>   	k3-am62a7-r5-phycore-som-2gb.dtb
>   
> +dtb-$(CONFIG_SOC_K3_AM62D2) += k3-am62d2-r5-evm.dtb
> +
>   dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb \
>   			       k3-am62p5-verdin-r5.dtb \
>   			       k3-am62p5-verdin-wifi-dev.dtb
> diff --git a/arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi b/arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
> new file mode 100644
> index 00000000000..2493e9bad69
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
> @@ -0,0 +1,2802 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * This file was generated with the
> + * AM62Dx SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax,
> + * AM62Px, AM62Dx, AM62Lx v0.10.32
> + * Tue May 13 2025 19:31:24 GMT+0530 (India Standard Time)
> + * DDR Type: LPDDR4
> + * F0 = 50MHz    F1 = NA     F2 = 1866MHz
> + * Density (per channel): 16Gb
> + * Number of Ranks: 1
> + */
> +

[...]

> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> new file mode 100644
> index 00000000000..5f5c485a298
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-binman.dtsi"
> +
> +#ifdef CONFIG_TARGET_AM62D2_R5_EVM
> +
> +&bcfg_yaml {
> +	config = "board/ti/am62ax/board-cfg.yaml";
> +};
> +
> +&rcfg_yaml {
> +	config = "board/ti/am62ax/rm-cfg.yaml";
> +};
> +
> +&scfg_yaml {
> +	config = "board/ti/am62ax/sec-cfg.yaml";
> +};
> +
> +&pcfg_yaml {
> +	config = "board/ti/am62ax/pm-cfg.yaml";
> +};
> +
> +&bcfg_yaml_tifs {
> +	config = "board/ti/am62ax/board-cfg.yaml";
> +};
> +
> +&scfg_yaml_tifs {
> +	config = "board/ti/am62ax/sec-cfg.yaml";
> +};
> +
> +&pcfg_yaml_tifs {
> +	config = "board/ti/am62ax/pm-cfg.yaml";
> +};
> +
> +&rcfg_yaml_tifs {
> +	config = "board/ti/am62ax/tifs-rm-cfg.yaml";
> +};
> +
> +&pcfg_yaml_dm {
> +	config = "board/ti/am62ax/pm-cfg.yaml";
> +};
> +
> +&rcfg_yaml_dm {
> +	config = "board/ti/am62ax/rm-cfg.yaml";
> +};
> +
> +&bcfg_yaml_sysfw {
> +	config = "board/ti/am62ax/board-cfg.yaml";
> +};
> +
> +&scfg_yaml_sysfw {
> +	config = "board/ti/am62ax/sec-cfg.yaml";
> +};
> +
> +&pcfg_yaml_sysfw {
> +	config = "board/ti/am62ax/pm-cfg.yaml";
> +};
> +
> +&rcfg_yaml_sysfw {
> +	config = "board/ti/am62ax/rm-cfg.yaml";
> +};
> +
> +&binman {
> +	tiboot3-am62dx-hs-evm.bin {
> +		filename = "tiboot3-am62dx-hs-evm.bin";

The name appended to tiboot3 is not the board or the soc, it is
the name of the SYSFW (TIFS and DM) used, and in this case since
you are packaging the "am62ax" TIFS/DM, then the name should be
tiboot3-am62ax-hs-evm.bin. With that change this file would be
near identical to k3-am62a-evm-binman.dtsi, so why not just include
that and override the one or two spots that need changed (default
dts file and description being the only thing I can see).

Andrew

> +		ti-secure-rom {
> +			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
> +				<&combined_dm_cfg>, <&sysfw_inner_cert>;
> +			combined;
> +			dm-data;
> +			sysfw-inner-cert;
> +			keyfile = "custMpk.pem";
> +			sw-rev = <1>;
> +			content-sbl = <&u_boot_spl>;
> +			content-sysfw = <&ti_fs_enc>;
> +			content-sysfw-data = <&combined_tifs_cfg>;
> +			content-sysfw-inner-cert = <&sysfw_inner_cert>;
> +			content-dm-data = <&combined_dm_cfg>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
> +			load-sysfw = <0x40000>;
> +			load-sysfw-data = <0x67000>;
> +			load-dm-data = <0x43c3a800>;
> +		};
> +		u_boot_spl: u-boot-spl {
> +			no-expanded;
> +		};
> +		ti_fs_enc: ti-fs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-enc.bin";
> +			type = "blob-ext";
> +		};
> +		combined_tifs_cfg: combined-tifs-cfg.bin {
> +			filename = "combined-tifs-cfg.bin";
> +			type = "blob-ext";
> +		};
> +		sysfw_inner_cert: sysfw-inner-cert {
> +			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-cert.bin";
> +			type = "blob-ext";
> +		};
> +		combined_dm_cfg: combined-dm-cfg.bin {
> +			filename = "combined-dm-cfg.bin";
> +			type = "blob-ext";
> +		};
> +	};
> +};
> +
> +&binman {
> +	tiboot3-am62dx-hs-fs-evm.bin {
> +		filename = "tiboot3-am62dx-hs-fs-evm.bin";
> +		symlink = "tiboot3.bin";
> +		ti-secure-rom {
> +			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
> +				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
> +			combined;
> +			dm-data;
> +			sysfw-inner-cert;
> +			keyfile = "custMpk.pem";
> +			sw-rev = <1>;
> +			content-sbl = <&u_boot_spl_fs>;
> +			content-sysfw = <&ti_fs_enc_fs>;
> +			content-sysfw-data = <&combined_tifs_cfg_fs>;
> +			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
> +			content-dm-data = <&combined_dm_cfg_fs>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
> +			load-sysfw = <0x40000>;
> +			load-sysfw-data = <0x67000>;
> +			load-dm-data = <0x43c3a800>;
> +		};
> +		u_boot_spl_fs: u-boot-spl {
> +			no-expanded;
> +		};
> +		ti_fs_enc_fs: ti-fs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-enc.bin";
> +			type = "blob-ext";
> +		};
> +		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> +			filename = "combined-tifs-cfg.bin";
> +			type = "blob-ext";
> +		};
> +		sysfw_inner_cert_fs: sysfw-inner-cert {
> +			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-cert.bin";
> +			type = "blob-ext";
> +		};
> +		combined_dm_cfg_fs: combined-dm-cfg.bin {
> +			filename = "combined-dm-cfg.bin";
> +			type = "blob-ext";
> +		};
> +	};
> +};
> +
> +#endif
> +
> +#ifdef CONFIG_TARGET_AM62D2_A53_EVM
> +
> +#define AM62A7_SK_DM "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f"
> +
> +&binman {
> +	tifsstub-hs {
> +		filename = "tifsstub.bin_hs";
> +		ti-secure-rom {
> +			content = <&tifsstub_hs_cert>;
> +			core = "secure";
> +			load = <0x60000>;
> +			sw-rev = <CONFIG_K3_X509_SWRV>;
> +			keyfile = "custMpk.pem";
> +			countersign;
> +			tifsstub;
> +		};
> +		tifsstub_hs_cert: tifsstub-hs-cert.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-cert.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +		tifsstub_hs_enc: tifsstub-hs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-enc.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +	};
> +
> +	tifsstub-fs {
> +		filename = "tifsstub.bin_fs";
> +		tifsstub_fs_cert: tifsstub-fs-cert.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-cert.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +		tifsstub_fs_enc: tifsstub-fs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-enc.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +
> +	};
> +
> +	ti-spl {
> +		insert-template = <&ti_spl_template>;
> +
> +		fit {
> +			images {
> +				tifsstub-hs {
> +					description = "TIFSSTUB";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-hs";
> +					load = <0x9ca00000>;
> +					entry = <0x9ca00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_hs";
> +					};
> +				};
> +
> +				tifsstub-fs {
> +					description = "TIFSSTUB";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-fs";
> +					load = <0x9ca00000>;
> +					entry = <0x9ca00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_fs";
> +					};
> +				};
> +
> +				dm {
> +					ti-secure {
> +						content = <&dm>;
> +						keyfile = "custMpk.pem";
> +					};
> +					dm: ti-dm {
> +						filename = AM62A7_SK_DM;
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "k3-am62d2-evm";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					ti-secure {
> +						content = <&spl_am62d2_evm_dtb>;
> +						keyfile = "custMpk.pem";
> +					};
> +					spl_am62d2_evm_dtb: blob-ext {
> +						filename = "spl/dts/ti/k3-am62d2-evm.dtb";
> +					};
> +
> +				};
> +
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "k3-am62d2-evm";
> +					firmware = "atf";
> +					loadables = "tee", "dm", "spl",
> +					"tifsstub-hs", "tifsstub-fs";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&binman {
> +	u-boot {
> +		insert-template = <&u_boot_template>;
> +
> +		fit {
> +			images {
> +				uboot {
> +					description = "U-Boot for AM62Dx Board";
> +				};
> +
> +				fdt-0 {
> +					description = "k3-am62d2-evm";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					ti-secure {
> +						content = <&am62d2_evm_dtb>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am62d2_evm_dtb: blob-ext {
> +						filename = "u-boot.dtb";
> +					};
> +					hash {
> +						algo = "crc32";
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "k3-am62d2-evm";
> +					firmware = "uboot";
> +					loadables = "uboot";
> +					fdt = "fdt-0";
> +				};
> +
> +			};
> +		};
> +	};
> +};
> +
> +#endif
> diff --git a/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
> new file mode 100644
> index 00000000000..bddcfa6770c
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common AM62D EVM dts file for SPLs
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-am62d-evm-binman.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +};
> diff --git a/arch/arm/dts/k3-am62d2-r5-evm.dts b/arch/arm/dts/k3-am62d2-r5-evm.dts
> new file mode 100644
> index 00000000000..a3213d00145
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d2-r5-evm.dts
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM62D2 EVM dts file for R5 SPL
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-am62d2-evm.dts"
> +#include "k3-am62d-ddr-1866mhz-32bit.dtsi"
> +#include "k3-am62a-ddr.dtsi"
> +
> +#include "k3-am62d2-evm-u-boot.dtsi"
> +
> +/ {
> +	aliases {
> +		tick-timer = &main_timer0;
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 22>,
> +			<&secure_proxy_main 23>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&secure_proxy_sa3 {
> +	/* Needed for initial handshake with ROM */
> +	status = "okay";
> +	bootph-pre-ram;
> +};
> +
> +&cbass_main {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&secure_proxy_sa3 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
> index f8cdcdca57a..6a3969343ec 100644
> --- a/arch/arm/mach-k3/am62ax/Kconfig
> +++ b/arch/arm/mach-k3/am62ax/Kconfig
> @@ -50,9 +50,30 @@ config TARGET_PHYCORE_AM62AX_R5
>   	select BINMAN
>   	imply SYS_K3_SPL_ATF
>   
> +config TARGET_AM62D2_A53_EVM
> +	bool "TI K3 based AM62D2 EVM running on A53"
> +	select ARM64
> +	select BINMAN
> +	imply BOARD
> +	imply SPL_BOARD
> +	imply TI_I2C_BOARD_DETECT
> +
> +config TARGET_AM62D2_R5_EVM
> +	bool "TI K3 based AM62D2 EVM running on R5"
> +	select CPU_V7R
> +	select SYS_THUMB_BUILD
> +	select K3_LOAD_SYSFW
> +	select RAM
> +	select SPL_RAM
> +	select K3_DDRSS
> +	select BINMAN
> +	imply SYS_K3_SPL_ATF
> +	imply TI_I2C_BOARD_DETECT
> +
>   endchoice
>   
>   source "board/ti/am62ax/Kconfig"
>   source "board/phytec/phycore_am62ax/Kconfig"
> +source "board/ti/am62dx/Kconfig"
>   
>   endif
> diff --git a/board/ti/am62dx/Kconfig b/board/ti/am62dx/Kconfig
> new file mode 100644
> index 00000000000..0bdd6a61846
> --- /dev/null
> +++ b/board/ti/am62dx/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +
> +if TARGET_AM62D2_R5_EVM || TARGET_AM62D2_A53_EVM
> +
> +config SYS_BOARD
> +	default "am62dx"
> +
> +config SYS_VENDOR
> +	default "ti"
> +
> +config SYS_CONFIG_NAME
> +	default "am62ax_evm"
> +
> +source "board/ti/common/Kconfig"
> +
> +endif
> +
> +if TARGET_AM62D2_R5_EVM
> +
> +config SPL_LDSCRIPT
> +	default "arch/arm/mach-omap2/u-boot-spl.lds"
> +
> +endif
> diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
> new file mode 100644
> index 00000000000..e7af7be35bc
> --- /dev/null
> +++ b/board/ti/am62dx/MAINTAINERS
> @@ -0,0 +1,8 @@
> +AM62Dx BOARD
> +M:	Vignesh Raghavendra <vigneshr@ti.com>
> +M:	Bryan Brattlof <bb@ti.com>
> +S:	Maintained
> +F:	board/ti/am62dx/
> +F:	include/configs/am62a7_evm.h
> +F:	configs/am62dx_evm_r5_defconfig
> +F:	configs/am62dx_evm_a53_defconfig
> diff --git a/board/ti/am62dx/Makefile b/board/ti/am62dx/Makefile
> new file mode 100644
> index 00000000000..5f247ec1cc2
> --- /dev/null
> +++ b/board/ti/am62dx/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y	+= evm.o
> diff --git a/board/ti/am62dx/am62dx.env b/board/ti/am62dx/am62dx.env
> new file mode 100644
> index 00000000000..6fa80a964c1
> --- /dev/null
> +++ b/board/ti/am62dx/am62dx.env
> @@ -0,0 +1,21 @@
> +#include <env/ti/ti_common.env>
> +#include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
> +#if CONFIG_CMD_REMOTEPROC
> +#include <env/ti/k3_rproc.env>
> +#endif
> +
> +name_kern=Image
> +console=ttyS2,115200n8
> +args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> +	${mtdparts}
> +run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +boot_targets=mmc1 mmc0 usb pxe dhcp
> +boot=mmc
> +mmcdev=1
> +bootpart=1:2
> +bootdir=/boot
> +rd_spec=-
> +
> +rproc_fw_binaries= 0 /lib/firmware/am62d-mcu-r5f0_0-fw 1 /lib/firmware/am62d-c71_0-fw
> diff --git a/board/ti/am62dx/evm.c b/board/ti/am62dx/evm.c
> new file mode 100644
> index 00000000000..1d8216128c9
> --- /dev/null
> +++ b/board/ti/am62dx/evm.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board specific initialization for AM62Dx platforms
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
> +#include <dm/uclass.h>
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <spl.h>
> +#include <asm/arch/k3-ddr.h>
> +
> +#include "../common/fdt_ops.h"
> +
> +#if defined(CONFIG_XPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
> +{
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
> +}
> +#endif
> +
> +#ifdef CONFIG_BOARD_LATE_INIT
> +int board_late_init(void)
> +{
> +	ti_set_fdt_env(NULL, NULL);
> +	return 0;
> +}
> +#endif
> diff --git a/configs/am62dx_evm_a53_defconfig b/configs/am62dx_evm_a53_defconfig
> new file mode 100644
> index 00000000000..302f8c5e936
> --- /dev/null
> +++ b/configs/am62dx_evm_a53_defconfig
> @@ -0,0 +1,22 @@
> +#include <configs/am62ax_evm_a53_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM62A7=y
> +CONFIG_TARGET_AM62D2_A53_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62d2-evm"
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
> +CONFIG_DFU_SF=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> diff --git a/configs/am62dx_evm_r5_defconfig b/configs/am62dx_evm_r5_defconfig
> new file mode 100644
> index 00000000000..7a3ecee7ec1
> --- /dev/null
> +++ b/configs/am62dx_evm_r5_defconfig
> @@ -0,0 +1,20 @@
> +#include <configs/am62ax_evm_r5_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM62A7=y
> +CONFIG_TARGET_AM62D2_R5_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62d2-r5-evm"
> +# CONFIG_SPL_DMA is not set
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_SF_DEFAULT_MODE=0
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y

