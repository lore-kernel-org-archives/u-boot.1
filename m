Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D4D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 04:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD6883CEA;
	Mon, 29 Dec 2025 05:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxL1gFF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E22C83D07; Mon, 29 Dec 2025 05:33:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF7783C39
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 05:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 239BE6000A;
 Mon, 29 Dec 2025 04:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB35C4CEF7;
 Mon, 29 Dec 2025 04:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766982782;
 bh=jkLkaJYgIfWx/AzKxEaAs9hWk2edBLJzdiCoKyHF1UU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lxL1gFF1lBPLfB+4CpRlDLkzIfTUcjptk8pp21l1dZWlDnMHu0dhMkKMDRxBrreiv
 LgCLCxLG9e5BaLiYLrtS0s/RgQKzNPsyG4UaPyqjxDM/o+j5aSZYxLxtZ4mgRkXNc2
 cK6NBBWRbXumT8/bKW8CBBcEDFadfuF4CNigFQyES4iXSRI4/RkwfPStBQvKBIVfuJ
 Odrq7k1h0sSIB70ySXUdarcW9GwNw9tPpRnM/r8UhrueqH2jJn3pVhZ6/y8hTRdDyh
 9asWOQRZQTXuYUCqGggohYuHr9gbLPhcJlUw2rJURzVBntNS0oy+QSqLZBtTGVbE29
 O23X36s5WevYA==
Date: Mon, 29 Dec 2025 10:02:56 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/5] riscv: dts: starfive: add Orange Pi RV
Message-ID: <aVIEePlOcMizj0CS@sumit-xelite>
References: <20251226193034.181659-1-e@freeshell.de>
 <20251226193034.181659-3-e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226193034.181659-3-e@freeshell.de>
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

On Fri, Dec 26, 2025 at 11:30:03AM -0800, E Shattow wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> Orange Pi RV is a SBC based on the StarFive VisionFive 2 board.
> 
> Orange Pi RV features:
> 
> - StarFive JH7110 SoC
> - GbE port connected to JH7110 GMAC0 via YT8531 PHY
> - 4x USB ports via VL805 PCIe USB controller connected to JH7110 pcie0
> - M.2 M-key slot connected to JH7110 pcie1
> - HDMI video output
> - 3.5mm audio output
> - Ampak AP6256 SDIO Wi-Fi/Bluetooth module on mmc0
> - microSD slot on mmc1
> - SPI NOR flash memory
> - 24c02 EEPROM (read only by default)
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: E Shattow <e@freeshell.de>
> [conor: amend comment to say what's missing]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [ upstream commit: 5b70764e10190d57e6cd3287d3a3b06f8c89f69c ]
> 
> (cherry picked from commit ca39a8e36acbe7d258cadee4ae703fbaac60e18b)
> ---
>  .../src/riscv/starfive/jh7110-orangepi-rv.dts | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts b/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts
> new file mode 100644
> index 00000000000..053c35992ec
> --- /dev/null
> +++ b/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "Xunlong Orange Pi RV";
> +	compatible = "xunlong,orangepi-rv", "starfive,jh7110";
> +
> +	/* This regulator is always on by hardware */
> +	reg_vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3-pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&sysgpio 62 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&gmac0 {
> +	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> +	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	starfive,tx-use-rgmii-clk;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	cap-sd-highspeed;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	vmmc-supply = <&reg_vcc3v3_pcie>;
> +	vqmmc-supply = <&vcc_3v3>;
> +	status = "okay";
> +
> +	ap6256: wifi@1 {
> +		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		/* TODO: out-of-band IRQ on GPIO21, lacking pinctrl support */
> +	};
> +};
> +
> +&mmc1 {
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	status = "okay";
> +};
> +
> +&phy0 {
> +	rx-internal-delay-ps = <1500>;
> +	tx-internal-delay-ps = <1500>;
> +	motorcomm,rx-clk-drv-microamp = <3970>;
> +	motorcomm,rx-data-drv-microamp = <2910>;
> +	motorcomm,tx-clk-adj-enabled;
> +	motorcomm,tx-clk-10-inverted;
> +	motorcomm,tx-clk-100-inverted;
> +	motorcomm,tx-clk-1000-inverted;
> +};
> +
> +&pwmdac {
> +	status = "okay";
> +};
> -- 
> 2.50.0
> 
