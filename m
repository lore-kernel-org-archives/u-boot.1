Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7195BC3DA45
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 07:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11BB88669;
	Mon, 15 Jul 2024 09:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kp+BxM53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B515788671; Mon, 15 Jul 2024 09:23:24 +0200 (CEST)
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com
 [45.254.49.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB14885EE
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 09:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kp+BxM537fasC5gb3CV/p4gsbUEsQFwxOGcDdjx5KDTNkcOhAQNC0IbdzE4ufMfsSfmLE/7RFuCu2ksW5gOQe/0/7Qq4SUOs2hzKWi65B7Yr7W48G7SWyclEplPurN0/MXLTr+ILwo3Iw3r1Hib8n3dY9SlrSmbxSiQ5w42i2NE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=DFTVPZ+CiinFIwQmLc73vP0h/P1gUH7W40k1y+Q5xsw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1C95A9005B3;
 Mon, 15 Jul 2024 15:22:52 +0800 (CST)
Message-ID: <45161301-19a7-4b29-ac86-69dd66c5b032@rock-chips.com>
Date: Mon, 15 Jul 2024 15:22:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add PCIe3 support on
 rk3588-jaguar
To: Quentin Schulz <foss+uboot@0leil.net>, Sumit Garg
 <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
 <20240704-tsd-rk3588-nvme-v1-1-fb9e8dde9570@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240704-tsd-rk3588-nvme-v1-1-fb9e8dde9570@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0eTFZKTB1NGR4aQ0xMTklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b545db4c03a9kunm1c95a9005b3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6Qyo6HzIrPiEMTDAtKRYr
 SwkKCyFVSlVKTElKS0lDSkxISkpOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSUpCNwY+
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


On 2024/7/4 20:53, Quentin Schulz wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> The Jaguar SBC provides an M.2 slot connected to the pcie3 controller.
> In contrast to a number of other boards the pcie-refclk is gpio-controlled,
> so the necessary clock and is added to the list of pcie3 clocks.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Link: https://lore.kernel.org/r/20240423074956.2622318-1-heiko@sntech.de
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> [ upstream commit: 0ec7e1096332bc2b9bc881c21cfd234058f747b3 ]
>
> (cherry picked from commit 76a89655ae740dddb57187b5b52071ed99187452)
> ---
>   dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts | 59 +++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> index 7d7303f8ecb..678ed8b4dcc 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> @@ -72,6 +72,27 @@
>   		};
>   	};
>   
> +	/*
> +	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
> +	 * clock generator.
> +	 * The clock output is gated via the OE pin on the clock generator.
> +	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
> +	 */
> +	pcie_refclk_gen: pcie-refclk-gen-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	pcie_refclk: pcie-refclk-clock {
> +		compatible = "gpio-gate-clock";
> +		clocks = <&pcie_refclk_gen>;
> +		#clock-cells = <0>;
> +		enable-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>; /* PCIE30X4_CLKREQN_M0 */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie30x4_clkreqn_m0>;
> +	};
> +
>   	pps {
>   		compatible = "pps-gpio";
>   		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> @@ -353,6 +374,30 @@
>   	status = "okay";
>   };
>   
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie3x4 {
> +	/*
> +	 * The board has a gpio-controlled "pcie_refclk" generator,
> +	 * so add it to the list of clocks.
> +	 */
> +	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
> +		 <&pcie_refclk>;
> +	clock-names = "aclk_mst", "aclk_slv",
> +		      "aclk_dbi", "pclk",
> +		      "aux", "pipe",
> +		      "ref";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x4_waken_m0 &pcie30x4_perstn_m0>;
> +	reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTN_M0 */
> +	vpcie3v3-supply = <&vcc3v3_mdot2>;
> +	status = "okay";
> +};
> +
>   &pinctrl {
>   	emmc {
>   		emmc_reset: emmc-reset {
> @@ -371,6 +416,20 @@
>   			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
> +
> +	pcie30x4 {
> +		pcie30x4_clkreqn_m0: pcie30x4-clkreqn-m0 {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x4_perstn_m0: pcie30x4-perstn-m0 {
> +			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x4_waken_m0: pcie30x4-waken-m0 {
> +			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
> +		};
> +	};
>   };
>   
>   &saradc {
>
