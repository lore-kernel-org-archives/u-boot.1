Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D04CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 13:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8612832DD;
	Tue,  2 Sep 2025 15:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G5unaVr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE98983303; Tue,  2 Sep 2025 15:45:54 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CC3832BC
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 15:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582DjpuW2596938
 for <u-boot@lists.denx.de>; Tue, 2 Sep 2025 08:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756820751;
 bh=+Mo5OofarU0jS8rd0yw0FFVVTuKoFjUAIbS1MWZwTao=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=G5unaVr4TfozISodLxZ0SIa0HMkboTrUM8mFZcHCDhQBC6y9dyCUhwddHYQ796qo1
 2FM3KiQHLtclO2brdqI4GYfEaVerim+U3f3008LWLFz9xLlSIbm3GJdXPOkHmZegkR
 DjwC1885qPz1AbRPm/zuzfshqEvhbYxW+HA2IZ+Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582DjpjU2311275
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 2 Sep 2025 08:45:51 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 08:45:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 08:45:50 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582Djo4E4155143;
 Tue, 2 Sep 2025 08:45:50 -0500
Message-ID: <14674941-7e52-4c58-b756-b8769b13d4fd@ti.com>
Date: Tue, 2 Sep 2025 08:45:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] arm: dts: Introduce AM62D2-EVM dtbs
To: Paresh Bhagat <p-bhagat@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <anshuld@ti.com>
References: <20250902060703.191688-1-p-bhagat@ti.com>
 <20250902060703.191688-6-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250902060703.191688-6-p-bhagat@ti.com>
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

On 9/2/25 1:07 AM, Paresh Bhagat wrote:
> Introduce the base dts files needed for u-boot or to augment the
> linux dtbs for use in the u-boot-spl and u-boot binaries.
> Support added for HS-SE and HS-FS boot binaries for AM62dx via
> binman.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>   arch/arm/dts/Makefile                        |    2 +
>   arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
>   arch/arm/dts/k3-am62d-evm-binman.dtsi        |  359 +++
>   arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   14 +
>   arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
>   5 files changed, 3259 insertions(+)
>   create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
>   create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
>   create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>   create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index ff8f1ed1ac0..99c37b9c02a 100644
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

[...]

> +&binman {
> +	ti-spl_unsigned {

Why do we need these unsigned versions of tispl.bin and u-boot.img if we only support HS?

Andrew

> +		insert-template = <&ti_spl_unsigned_template>;
> +
> +		fit {
> +			images {
> +				tifsstub-hs {
> +					description = "tifsstub";
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
> +					description = "tifsstub";
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
> +					ti-dm {
> +						filename = AM62A7_SK_DM;
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "k3-am62d2-evm";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					blob {
> +						filename = "spl/dts/ti/k3-am62d2-evm.dtb";
> +					};
> +				};
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
> +	u-boot_unsigned {
> +		insert-template = <&u_boot_unsigned_template>;
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
> +					blob {
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
> +			};
> +		};
> +	};
> +};
> +#endif
> diff --git a/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
> new file mode 100644
> index 00000000000..d1b17e8f83f
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
> @@ -0,0 +1,14 @@
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
> +		tick-timer = &main_timer0;
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

