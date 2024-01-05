Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11A8C47074
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 00:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02C087708;
	Fri,  5 Jan 2024 01:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QH7RgLCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154448777D; Fri,  5 Jan 2024 01:30:10 +0100 (CET)
Received: from mail-m17241.xmail.ntesmail.com (mail-m17241.xmail.ntesmail.com
 [45.195.17.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE36876FA
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 01:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QH7RgLCmF2WXGl/RbUOt2bp0J32NcbhuqQxem8xE11QFrUvnP2mAMEn/eZzwoLuvpkO6dpskqPv2PizLEhBVmuzXcZYGi8OpgeCbdiffXXrfmLnbpZOBo0WUZi03Vr27co3kvZy4g62hqjY3tTjc8aZDD22WdGIo9ihNdqlFhxo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=ab/Kub/jaVpoV6YADbwy7Hyi6a1rKrbSfvVnFJ9kIdA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id E18554001A4;
 Fri,  5 Jan 2024 08:29:47 +0800 (CST)
Message-ID: <d970d042-0084-411a-8ead-3738f3e95471@rock-chips.com>
Date: Fri, 5 Jan 2024 08:29:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: px30: add support for iesy PX30 SoM OSM-S
Content-Language: en-US
To: Dominik Poggel <pog@iesy.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu
References: <24ff7347-650e-4b80-ac35-a8c535c76648.51c8ab6f-2707-4fec-b864-8eb3a5aaab63.7a830c6e-7d44-4432-91a3-b946b5cc41bf@emailsignatures365.codetwo.com>
 <24ff7347-650e-4b80-ac35-a8c535c76648.370f0e5d-ced9-4d8d-88a7-90f9b6de22dd.47e95517-6707-42c7-9fe7-6620d853fcf3@emailsignatures365.codetwo.com>
 <20240104155706.3021339-1-pog@iesy.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240104155706.3021339-1-pog@iesy.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwaTVZCGUgaTRpKH0JOTR5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8cd706ac6e2eb3kusne18554001a4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohg6Ajo6ETwiIjkxOAoaMgs1
 NUgwCThVSlVKTEtPT0pPTkNDQ0hLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSEtJTzcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Dominik,

The main dts should come from kernel, does this board available in 
mainline kernel?
If yes, pls add the info in commit message for which tag from kernel.

This is a SoM, then is there a mainboard needed to make it work?

Thanks,
- Kever
On 2024/1/4 23:57, Dominik Poggel wrote:
> This adds support for the iesy SoM iesy-rpx30-osm-sf and the matching
> evalboard iesy-rpx30-eva-mi.
>
> The SoM complies to the Open Standard Module OSM 1.1 spec, size S-F
>
> Signed-off-by: Dominik Poggel <pog@iesy.com>
> ---
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi    |  16 +
>  arch/arm/dts/iesy-rpx30-eva-mi.dts            |  38 ++
>  arch/arm/dts/iesy-rpx30-osm-sf.dtsi           | 369 ++++++++++++++++++
>  arch/arm/mach-rockchip/px30/Kconfig           |   4 +
>  board/iesy/iesy_rpx30_eva_mi/Kconfig          |  16 +
>  board/iesy/iesy_rpx30_eva_mi/MAINTAINERS      |   6 +
>  board/iesy/iesy_rpx30_eva_mi/Makefile         |   7 +
>  .../iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c     |  93 +++++
>  configs/iesy_rpx30_eva_mi_defconfig           | 126 ++++++
>  include/configs/iesy_rpx30_eva_mi.h           |  42 ++
>  11 files changed, 718 insertions(+)
>  create mode 100644 arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi
>  create mode 100644 arch/arm/dts/iesy-rpx30-eva-mi.dts
>  create mode 100644 arch/arm/dts/iesy-rpx30-osm-sf.dtsi
>  create mode 100644 board/iesy/iesy_rpx30_eva_mi/Kconfig
>  create mode 100644 board/iesy/iesy_rpx30_eva_mi/MAINTAINERS
>  create mode 100644 board/iesy/iesy_rpx30_eva_mi/Makefile
>  create mode 100644 board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c
>  create mode 100644 configs/iesy_rpx30_eva_mi_defconfig
>  create mode 100644 include/configs/iesy_rpx30_eva_mi.h
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 9d28a485be..8cf74855ff 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -80,6 +80,7 @@ dtb-$(CONFIG_MACH_S700) += \
>          s700-cubieboard7.dtb
>
>  dtb-$(CONFIG_ROCKCHIP_PX30) += \
> +       iesy-rpx30-eva-mi.dtb \
>          px30-evb.dtb \
>          px30-firefly.dtb \
>          px30-engicam-px30-core-ctouch2.dtb \
> diff --git a/arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi 
> b/arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi
> new file mode 100644
> index 0000000000..f7e8be72d1
> --- /dev/null
> +++ b/arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * (C) Copyright 2024 iesy GmbH
> + */
> +
> +#include "px30-u-boot.dtsi"
> +
> +/ {
> +       chosen {
> +               u-boot,spl-boot-order = "same-as-spl";
> +       };
> +};
> +
> +&rng {
> +       status = "okay";
> +};
> diff --git a/arch/arm/dts/iesy-rpx30-eva-mi.dts 
> b/arch/arm/dts/iesy-rpx30-eva-mi.dts
> new file mode 100644
> index 0000000000..edd75c8b75
> --- /dev/null
> +++ b/arch/arm/dts/iesy-rpx30-eva-mi.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 iesy GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "iesy-rpx30-osm-sf.dtsi"
> +
> +/ {
> +       model = "iesy RPX30 EVA-MI V2";
> +       compatible = "rockchip,px30-evb", "rockchip,px30";
> +
> +       aliases {
> +               mmc0 = &emmc;
> +               mmc1 = &sdmmc;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:115200n8";
> +       };
> +
> +       emmc_pwrseq: emmc-pwrseq {
> +               compatible = "mmc-pwrseq-emmc";
> +               pinctrl-0 = <&emmc_reset>;
> +               pinctrl-names = "default";
> +               reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       vcc5v0_sys: vccsys {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +};
> diff --git a/arch/arm/dts/iesy-rpx30-osm-sf.dtsi 
> b/arch/arm/dts/iesy-rpx30-osm-sf.dtsi
> new file mode 100644
> index 0000000000..65a7c77e9e
> --- /dev/null
> +++ b/arch/arm/dts/iesy-rpx30-osm-sf.dtsi
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 iesy GmbH
> + */
> +
> +#include "px30.dtsi"
> +
> +/{
> +       aliases {
> +               mmc0 = &emmc;
> +               mmc1 = &sdcard;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +       cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +       cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +       cpu-supply = <&vdd_arm>;
> +};
> +
> +&emmc {
> +       cap-mmc-highspeed;
> +       mmc-hs200-1_8v;
> +       non-removable;
> +       mmc-pwrseq = <&emmc_pwrseq>;
> +       vmmc-supply = <&vcc_3v0>;
> +       vqmmc-supply = <&vccio_flash>;
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       rk809: pmic@20 {
> +               compatible = "rockchip,rk809";
> +               reg = <0x20>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pmic_int>;
> +               rockchip,system-power-controller;
> +               wakeup-source;
> +               #clock-cells = <0>;
> +               clock-output-names = "xin32k";
> +               pmic-reset-func = <1>;
> +
> +               vcc1-supply = <&vcc5v0_sys>;
> +               vcc2-supply = <&vcc5v0_sys>;
> +               vcc3-supply = <&vcc5v0_sys>;
> +               vcc4-supply = <&vcc5v0_sys>;
> +               vcc5-supply = <&vcc3v3_sys>;
> +               vcc6-supply = <&vcc3v3_sys>;
> +               vcc7-supply = <&vcc3v3_sys>;
> +               vcc8-supply = <&vcc3v3_sys>;
> +               vcc9-supply = <&vcc5v0_sys>;
> +
> +               regulators {
> +                       vdd_log: DCDC_REG1 {
> +                               regulator-name = "vdd_log";
> +                               regulator-min-microvolt = <950000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <6001>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <950000>;
> +                               };
> +                       };
> +
> +                       vdd_arm: DCDC_REG2 {
> +                               regulator-name = "vdd_arm";
> +                               regulator-min-microvolt = <950000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <6001>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-off-in-suspend;
> + regulator-suspend-microvolt = <950000>;
> +                               };
> +                       };
> +
> +                       vcc_ddr: DCDC_REG3 {
> +                               regulator-name = "vcc_ddr";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v0: vcc_rmii: DCDC_REG4 {
> +                               regulator-name = "vcc_3v0";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <3000000>;
> +                               };
> +                       };
> +
> +                       vcc3v3_sys: DCDC_REG5 {
> +                               regulator-name = "vcc3v3_sys";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <3300000>;
> +                               };
> +                       };
> +
> +                       vcc_1v0: LDO_REG1 {
> +                               regulator-name = "vcc_1v0";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <1000000>;
> +                               };
> +                       };
> +
> +                       vcc_1v8: vccio_flash: vccio_sdio: LDO_REG2 {
> +                               regulator-name = "vcc_1v8";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       vdd_1v0: LDO_REG3 {
> +                               regulator-name = "vdd_1v0";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <1000000>;
> +                               };
> +                       };
> +
> +                       vcc3v0_pmu: LDO_REG4 {
> +                               regulator-name = "vcc3v0_pmu";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <3000000>;
> +                               };
> +                       };
> +
> +                       vccio_sd: LDO_REG5 {
> +                               regulator-name = "vccio_sd";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <3300000>;
> +                               };
> +                       };
> +
> +                       vcc_sd: LDO_REG6 {
> +                               regulator-name = "vcc_sd";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <3300000>;
> +                               };
> +                       };
> +
> +                       vcc2v8_dvp: LDO_REG7 {
> +                               regulator-name = "vcc2v8_dvp";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-off-in-suspend;
> + regulator-suspend-microvolt = <2800000>;
> +                               };
> +                       };
> +
> +                       vcc1v8_dvp: LDO_REG8 {
> +                               regulator-name = "vcc1v8_dvp";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-on-in-suspend;
> + regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       vcc1v5_dvp: LDO_REG9 {
> +                               regulator-name = "vcc1v5_dvp";
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <1500000>;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> + regulator-off-in-suspend;
> + regulator-suspend-microvolt = <1500000>;
> +                               };
> +                       };
> +
> +                       vcc3v3_lcd: SWITCH_REG1 {
> +                               regulator-name = "vcc3v3_lcd";
> +                               regulator-boot-on;
> +                       };
> +
> +                       vcc5v0_host: SWITCH_REG2 {
> +                               regulator-name = "vcc5v0_host";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +               };
> +       };
> +};
> +
> +&io_domains {
> +       status = "okay";
> +
> +       vccio1-supply = <&vccio_sdio>;
> +       vccio2-supply = <&vccio_sd>;
> +       vccio3-supply = <&vcc_3v0>;
> +       vccio4-supply = <&vcc3v0_pmu>;
> +       vccio5-supply = <&vcc_3v0>;
> +       vccio6-supply = <&vccio_flash>;
> +};
> +
> +&pinctrl {
> +       emmc {
> +               emmc_reset: emmc-reset {
> +                       rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO 
> &pcfg_pull_none>;
> +               };
> +       };
> +
> +       pmic {
> +               pmic_int: pmic_int {
> +                       rockchip,pins =
> +                               <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +
> +               soc_slppin_gpio: soc_slppin_gpio {
> +                       rockchip,pins =
> +                               <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
> +               };
> +
> +               soc_slppin_slp: soc_slppin_slp {
> +                       rockchip,pins =
> +                               <0 RK_PA4 1 &pcfg_pull_none>;
> +               };
> +
> +               soc_slppin_rst: soc_slppin_rst {
> +                       rockchip,pins =
> +                               <0 RK_PA4 2 &pcfg_pull_none>;
> +               };
> +       };
> +};
> +
> +&pmu_io_domains {
> +       status = "okay";
> +
> +       pmuio1-supply = <&vcc3v0_pmu>;
> +       pmuio2-supply = <&vcc3v0_pmu>;
> +};
> +
> +&saradc {
> +       vref-supply = <&vcc_1v8>;
> +       status = "okay";
> +};
> +
> +&sdmmc {
> +       cap-mmc-highspeed;
> +       cap-sd-highspeed;
> +       card-detect-delay = <800>;
> +       sd-uhs-sdr12;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
> +       vmmc-supply = <&vcc_sd>;
> +       vqmmc-supply = <&vccio_sd>;
> +       status = "okay";
> +};
> +
> +&tsadc {
> +       rockchip,hw-tshut-mode = <1>;
> +       rockchip,hw-tshut-polarity = <1>;
> +       status = "okay";
> +};
> +
> +&u2phy {
> +       status = "okay";
> +
> +       u2phy_host: host-port {
> +               status = "okay";
> +       };
> +
> +       u2phy_otg: otg-port {
> +               status = "okay";
> +       };
> +};
> +
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart1_xfer &uart1_cts>;
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart2m1_xfer>;
> +       status = "okay";
> +};
> +
> +&uart5 {
> +       status = "okay";
> +};
> +
> +&usb20_otg {
> +       status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +       status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +       status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig 
> b/arch/arm/mach-rockchip/px30/Kconfig
> index 41893920cb..6958d6374f 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -59,6 +59,9 @@ config TARGET_RINGNECK_PX30
>              * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
>              * on-module NXP SE05x Secure Element
>
> +config TARGET_IESY_RPX30_EVA_MI
> +       bool "iesy RPX30 EVA MI"
> +
>  config ROCKCHIP_BOOT_MODE_REG
>          default 0xff010200
>
> @@ -94,6 +97,7 @@ config DEBUG_UART_CHANNEL
>
>  source "board/engicam/px30_core/Kconfig"
>  source "board/hardkernel/odroid_go2/Kconfig"
> +source "board/iesy/iesy_rpx30_eva_mi/Kconfig"
>  source "board/rockchip/evb_px30/Kconfig"
>  source "board/theobroma-systems/ringneck_px30/Kconfig"
>
> diff --git a/board/iesy/iesy_rpx30_eva_mi/Kconfig 
> b/board/iesy/iesy_rpx30_eva_mi/Kconfig
> new file mode 100644
> index 0000000000..d1c157d6c8
> --- /dev/null
> +++ b/board/iesy/iesy_rpx30_eva_mi/Kconfig
> @@ -0,0 +1,16 @@
> +if TARGET_IESY_RPX30_EVA_MI
> +
> +config SYS_BOARD
> +       default "iesy_rpx30_eva_mi"
> +
> +config SYS_VENDOR
> +       default "iesy"
> +
> +config SYS_CONFIG_NAME
> +       default "iesy_rpx30_eva_mi"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +       def_bool y
> +       select RAM_ROCKCHIP_LPDDR3
> +
> +endif
> diff --git a/board/iesy/iesy_rpx30_eva_mi/MAINTAINERS 
> b/board/iesy/iesy_rpx30_eva_mi/MAINTAINERS
> new file mode 100644
> index 0000000000..273668c898
> --- /dev/null
> +++ b/board/iesy/iesy_rpx30_eva_mi/MAINTAINERS
> @@ -0,0 +1,6 @@
> +iesy RPX30 EVA MI
> +M:      Dominik Poggel <pog@iesy.com>
> +S:      Maintained
> +F:      board/iesy/iesy_rpx30_eva_mi
> +F:      include/configs/iesy_rpx30_eva_mi.h
> +F:      configs/iesy_rpx30_eva_mi_defconfig
> diff --git a/board/iesy/iesy_rpx30_eva_mi/Makefile 
> b/board/iesy/iesy_rpx30_eva_mi/Makefile
> new file mode 100644
> index 0000000000..9ad1ba6307
> --- /dev/null
> +++ b/board/iesy/iesy_rpx30_eva_mi/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# (C) Copyright 2024 iesy GmbH
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y  += iesy_rpx30_eva_mi.o
> diff --git a/board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c 
> b/board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c
> new file mode 100644
> index 0000000000..d70a73d7d5
> --- /dev/null
> +++ b/board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 iesy GmbH
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <log.h>
> +#include <asm/io.h>
> +#include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/boot_mode.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <dm/ofnode.h>
> +#include <adc.h>
> +
> +#define KEY_DOWN_MIN_VAL       0
> +#define KEY_DOWN_MAX_VAL       30
> +
> +int rockchip_dnl_key_pressed(void)
> +{
> +       unsigned int val;
> +       struct udevice *dev;
> +       struct uclass *uc;
> +       int ret;
> +
> +       ret = uclass_get(UCLASS_ADC, &uc);
> +       if (ret)
> +               return false;
> +
> +       ret = -ENODEV;
> +       uclass_foreach_dev(dev, uc) {
> +               if (!strncmp(dev->name, "saradc", 6)) {
> +                       ret = adc_channel_single_shot(dev->name, 2, &val);
> +                       break;
> +               }
> +       }
> +
> +       if (ret == -ENODEV) {
> +               pr_warn("%s: no saradc device found\n", __func__);
> +               return false;
> +       } else if (ret) {
> +               pr_err("%s: adc_channel_single_shot fail!\n", __func__);
> +               return false;
> +       }
> +
> +       /*
> +        * As the rockusb download mode doesn't work on the PX30,
> +        * and the maskrom isn't working correctly when triggered
> +        * by the download key, we use the fastboot mode instead.
> +        * To prevent the rockchip code from setting the download
> +        * mode, reset the board immediately.
> +        *
> +        * When the key is still pressed after the reset, the
> +        * board will enter a loop of resetting and rebooting.
> +        * Prevent this by checking the boot mode.
> +        */
> +
> +       int boot_reg = readl(CONFIG_ROCKCHIP_BOOT_MODE_REG);
> +
> +       if (boot_reg == BOOT_FASTBOOT) {
> +               printf("fastboot mode already set, skipping download 
> key check...\n");
> +               return false;
> +       }
> +
> +       if (val >= KEY_DOWN_MIN_VAL && val <= KEY_DOWN_MAX_VAL) {
> +               printf("download key pressed, entering fastboot 
> mode...\n");
> +               writel(BOOT_FASTBOOT, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> +               do_reset(NULL, 0, 0, NULL);
> +       }
> +
> +       return false;
> +}
> +
> +int misc_init_r(void)
> +{
> +       const char *boot_device =
> + ofnode_read_chosen_string("u-boot,spl-boot-device");
> +       if (!boot_device) {
> +               printf("boot device not set\n");
> +               return 0;
> +       }
> +
> +       if (!strcmp(boot_device, "/mmc@ff370000")) {
> +               env_set("mmcdev", "0");
> +               env_set("rootfs", "/dev/mmcblk0p2");
> +       } else {
> +               env_set("mmcdev", "1");
> +               env_set("rootfs", "/dev/mmcblk1p2");
> +       }
> +
> +       return 0;
> +}
> diff --git a/configs/iesy_rpx30_eva_mi_defconfig 
> b/configs/iesy_rpx30_eva_mi_defconfig
> new file mode 100644
> index 0000000000..b380c64b12
> --- /dev/null
> +++ b/configs/iesy_rpx30_eva_mi_defconfig
> @@ -0,0 +1,126 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00200000
> +CONFIG_SYS_MALLOC_F_LEN=0x2000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
> +CONFIG_DEFAULT_DEVICE_TREE="iesy-rpx30-eva-mi"
> +CONFIG_SPL_TEXT_BASE=0x00000000
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_PX30=y
> +CONFIG_TARGET_IESY_RPX30_EVA_MI=y
> +CONFIG_TPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
> +CONFIG_DEBUG_UART_BASE=0xFF160000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART_CHANNEL=1
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_DEFAULT_FDT_FILE="iesy-rpx30-eva-mi-v2.dtb"
> +# CONFIG_CONSOLE_MUX is not set
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_BOARD_LATE_INIT=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_BOOTROM_SUPPORT=y
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_ATF=y
> +# CONFIG_TPL_FRAMEWORK is not set
> +# CONFIG_TPL_BANNER_PRINT is not set
> +# CONFIG_CMD_BOOTD is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_IMI is not set
> +# CONFIG_CMD_XIMG is not set
> +# CONFIG_CMD_LZMADEC is not set
> +# CONFIG_CMD_UNZIP is not set
> +CONFIG_CMD_GPT=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_ITEST is not set
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_SLEEP is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +# CONFIG_ISO_PARTITION is not set
> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent 
> assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x800800
> +CONFIG_FASTBOOT_BUF_SIZE=0x04000000
> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_ROCKCHIP_OTP=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_TPL_RAM=y
> +CONFIG_ROCKCHIP_SDRAM_COMMON=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
> +# CONFIG_SPECIFY_CONSOLE_INDEX is not set
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SOUND=y
> +CONFIG_SYSRESET=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_VIDEO=y
> +CONFIG_DISPLAY=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_LZO=y
> +CONFIG_ERRNO_STR=y
> +# CONFIG_EFI_LOADER is not set
> diff --git a/include/configs/iesy_rpx30_eva_mi.h 
> b/include/configs/iesy_rpx30_eva_mi.h
> new file mode 100644
> index 0000000000..084edc509f
> --- /dev/null
> +++ b/include/configs/iesy_rpx30_eva_mi.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2017 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __IESY_RPX30_EVA_MI_H
> +#define __IESY_RPX30_EVA_MI_H
> +
> +#include "rockchip-common.h"
> +
> +#define CFG_IRAM_BASE          0xff0e0000
> +
> +#define GICD_BASE                      0xff131000
> +#define GICC_BASE                      0xff132000
> +
> +#define CFG_SYS_SDRAM_BASE             0
> +#define SDRAM_MAX_SIZE                 0xff000000
> +
> +#define ENV_MEM_LAYOUT_SETTINGS \
> +       "scriptaddr=0x00500000\0" \
> +       "pxefile_addr_r=0x00600000\0" \
> +       "fdt_addr_r=0x08300000\0" \
> +       "kernel_addr_r=0x00280000\0" \
> +       "ramdisk_addr_r=0x0a200000\0" \
> +       "kernel_comp_addr_r=0x03e80000\0" \
> +       "kernel_comp_size=0x2000000\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +       ENV_MEM_LAYOUT_SETTINGS \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "partitions=" PARTS_DEFAULT \
> +       "mmcdev=1\0" \
> +       "bootcmd=fatload mmc ${mmcdev} ${kernel_addr_r} Image; " \
> +               "fatload mmc ${mmcdev} ${fdt_addr_r} ${fdtfile}; " \
> +               "run setbootargs; " \
> +               "booti ${kernel_addr_r} - ${fdt_addr_r}\0" \
> +       "earlycon=uart8250,mmio32,0xff160000\0" \
> +       "console=ttyFIQ0\0" \
> +       "setbootargs=setenv bootargs ${console} ${optargs} " \
> +               "root=${rootfs} rootwait rw earlycon=${earlycon}\0"
> +
> +#endif
> -- 
> 2.30.2
>
> ---------------------------------------------------------------------------------------------------------------------
>
> Immer gut informiert sein mit dem Product Development Blog (PDB)
>
> Bleiben Sie stets gut informiert über unsere Computermodule der OSM 
> Baureihe und erhalten Sie aktuelle Informationen aus unserer 
> Entwicklungsabteilung.
> Für weitere Informationen, als auch der Möglichkeit zu Registrierung, 
> nutzen Sie den nachfolgenden Link:
> https://news.iesy.com/registrierung-product-development-blog-pdb-iesy-gmbh 
> <https://news.iesy.com/registrierung-product-development-blog-pdb-iesy-gmbh>
>
> *Always be well informed with the Product Development Blog (PDB)
> *Stay well informed about our computer modules of the OSM series and 
> get the latest information from our development department.
> For more information, as well as the possibility to register, please 
> use the following link:
> https://news.iesy.com/en/registration-product-development-blog-pdb-iesy-gmbh 
> <https://news.iesy.com/en/registration-product-development-blog-pdb-iesy-gmbh>
>
> ---------------------------------------------------------------------------------------------------------------------
>
> Die in dieser E-Mail enthaltenen Informationen sind vertraulich und 
> lediglich für den Empfänger bestimmt.
> Sollten Sie nicht der eigentliche Empfänger sein, informieren Sie uns 
> bitte umgehend und löschen diese E-Mail.
>
> The information contained in this message is confidential and is 
> intended for the addressee only.
> If you are not the intended recipient, please inform us immediately 
> and delete this email.
>
