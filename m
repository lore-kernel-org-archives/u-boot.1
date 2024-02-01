Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F57AC47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFD987C28;
	Thu,  1 Feb 2024 03:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O1mPb6qB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5D487C26; Thu,  1 Feb 2024 03:48:07 +0100 (CET)
Received: from mail-m1973199.qiye.163.com (mail-m1973199.qiye.163.com
 [220.197.31.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9960875EB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=O1mPb6qBEswXGBO75WzEfiuHfCXNFapNkFtmvh2XgCTkahrUMUZdLyRsiu100S9sWS5UMn4Akn6UxhdDSzbwBf2yCfmPAKl/VHaFdvzubnuVeiPJ1huVpPa43JcFUJayFUK+v8gkQPiHsWKpRnFgNb+X64ULTkgIgeFj9oZ1r14=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=AcfnewAMobfS04Z1eveImdB49BBSYhemp0Ri/w9JOms=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 398499001D4;
 Thu,  1 Feb 2024 10:47:51 +0800 (CST)
Message-ID: <4ae79365-b900-4d57-a064-fcae5a72fc76@rock-chips.com>
Date: Thu, 1 Feb 2024 10:47:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] rockchip: rk3588: sync rk3588s dtsi from v6.8-rc1
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-2-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-2-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh8YQlZDHUNPTB9CHhhNSRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d6290cc1e03a9kunm398499001d4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6GTo5PjMcIk0ILggMDSlK
 DxAaCj5VSlVKTEtNTE5OTUxITUJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSktOTzcG
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


On 2024/1/23 22:49, Quentin Schulz wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> This brings the real host2_xhci node as well as the pmu1grf node and
> spi0 to spi4 aliases from the next-20240110 Linux kernel. So also
> adapt/remove the nodes and aliases in rk3588s-u-boot.dtsi
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> [sync with v6.8-rc1]
> [remove spi0 to spi4 aliases from rk3588s-u-boot.dtsi]
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi |  36 ++--------
>   arch/arm/dts/rk3588s.dtsi        | 152 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 156 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 9a5ffec926e..960ac4abda3 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -7,11 +7,6 @@
>   
>   / {
>   	aliases {
> -		spi0 = &spi0;
> -		spi1 = &spi1;
> -		spi2 = &spi2;
> -		spi3 = &spi3;
> -		spi4 = &spi4;
>   		spi5 = &sfc;
>   	};
>   
> @@ -43,33 +38,6 @@
>   		status = "disabled";
>   	};
>   
> -	usb_host2_xhci: usb@fcd00000 {
> -		compatible = "rockchip,rk3588-dwc3", "rockchip,rk3568-dwc3", "snps,dwc3";
> -		reg = <0x0 0xfcd00000 0x0 0x400000>;
> -		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
> -			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
> -			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
> -		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
> -		dr_mode = "host";
> -		phys = <&combphy2_psu PHY_TYPE_USB3>;
> -		phy-names = "usb3-phy";
> -		phy_type = "utmi_wide";
> -		resets = <&cru SRST_A_USB3OTG2>;
> -		snps,dis_enblslpm_quirk;
> -		snps,dis-u2-freeclk-exists-quirk;
> -		snps,dis-del-phy-power-chg-quirk;
> -		snps,dis-tx-ipgap-linecheck-quirk;
> -		snps,dis_rxdet_inp3_quirk;
> -		status = "disabled";
> -	};
> -
> -	pmu1_grf: syscon@fd58a000 {
> -		bootph-all;
> -		compatible = "rockchip,rk3588-pmugrf", "syscon";
> -		reg = <0x0 0xfd58a000 0x0 0x2000>;
> -	};
> -
>   	usbdpphy0_grf: syscon@fd5c8000 {
>   		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
>   		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> @@ -201,6 +169,10 @@
>   	status = "okay";
>   };
>   
> +&pmu1grf {
> +	bootph-all;
> +};
> +
>   &sys_grf {
>   	bootph-pre-ram;
>   	status = "okay";
> diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
> index 61a9a11c3bb..36b1b7acfe6 100644
> --- a/arch/arm/dts/rk3588s.dtsi
> +++ b/arch/arm/dts/rk3588s.dtsi
> @@ -18,6 +18,38 @@
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		gpio4 = &gpio4;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +		serial8 = &uart8;
> +		serial9 = &uart9;
> +		spi0 = &spi0;
> +		spi1 = &spi1;
> +		spi2 = &spi2;
> +		spi3 = &spi3;
> +		spi4 = &spi4;
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -362,6 +394,11 @@
>   		#clock-cells = <0>;
>   	};
>   
> +	display_subsystem: display-subsystem {
> +		compatible = "rockchip,display-subsystem";
> +		ports = <&vop_out>;
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> @@ -443,11 +480,47 @@
>   		status = "disabled";
>   	};
>   
> +	usb_host2_xhci: usb@fcd00000 {
> +		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfcd00000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
> +			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
> +			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
> +		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
> +		dr_mode = "host";
> +		phys = <&combphy2_psu PHY_TYPE_USB3>;
> +		phy-names = "usb3-phy";
> +		phy_type = "utmi_wide";
> +		resets = <&cru SRST_A_USB3OTG2>;
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> +		snps,dis_rxdet_inp3_quirk;
> +		status = "disabled";
> +	};
> +
> +	pmu1grf: syscon@fd58a000 {
> +		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
> +		reg = <0x0 0xfd58a000 0x0 0x10000>;
> +	};
> +
>   	sys_grf: syscon@fd58c000 {
>   		compatible = "rockchip,rk3588-sys-grf", "syscon";
>   		reg = <0x0 0xfd58c000 0x0 0x1000>;
>   	};
>   
> +	vop_grf: syscon@fd5a4000 {
> +		compatible = "rockchip,rk3588-vop-grf", "syscon";
> +		reg = <0x0 0xfd5a4000 0x0 0x2000>;
> +	};
> +
> +	vo1_grf: syscon@fd5a8000 {
> +		compatible = "rockchip,rk3588-vo-grf", "syscon";
> +		reg = <0x0 0xfd5a8000 0x0 0x100>;
> +	};
> +
>   	php_grf: syscon@fd5b0000 {
>   		compatible = "rockchip,rk3588-php-grf", "syscon";
>   		reg = <0x0 0xfd5b0000 0x0 0x1000>;
> @@ -567,6 +640,74 @@
>   		status = "disabled";
>   	};
>   
> +	vop: vop@fdd90000 {
> +		compatible = "rockchip,rk3588-vop";
> +		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
> +		reg-names = "vop", "gamma-lut";
> +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru ACLK_VOP>,
> +			 <&cru HCLK_VOP>,
> +			 <&cru DCLK_VOP0>,
> +			 <&cru DCLK_VOP1>,
> +			 <&cru DCLK_VOP2>,
> +			 <&cru DCLK_VOP3>,
> +			 <&cru PCLK_VOP_ROOT>;
> +		clock-names = "aclk",
> +			      "hclk",
> +			      "dclk_vp0",
> +			      "dclk_vp1",
> +			      "dclk_vp2",
> +			      "dclk_vp3",
> +			      "pclk_vop";
> +		iommus = <&vop_mmu>;
> +		power-domains = <&power RK3588_PD_VOP>;
> +		rockchip,grf = <&sys_grf>;
> +		rockchip,vop-grf = <&vop_grf>;
> +		rockchip,vo1-grf = <&vo1_grf>;
> +		rockchip,pmu = <&pmu>;
> +		status = "disabled";
> +
> +		vop_out: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			vp0: port@0 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>;
> +			};
> +
> +			vp1: port@1 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1>;
> +			};
> +
> +			vp2: port@2 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <2>;
> +			};
> +
> +			vp3: port@3 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <3>;
> +			};
> +		};
> +	};
> +
> +	vop_mmu: iommu@fdd97e00 {
> +		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
> +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> +		clock-names = "aclk", "iface";
> +		#iommu-cells = <0>;
> +		power-domains = <&power RK3588_PD_VOP>;
> +		status = "disabled";
> +	};
> +
>   	uart0: serial@fd890000 {
>   		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
>   		reg = <0x0 0xfd890000 0x0 0x100>;
> @@ -890,6 +1031,7 @@
>   				reg = <RK3588_PD_USB>;
>   				clocks = <&cru PCLK_PHP_ROOT>,
>   					 <&cru ACLK_USB_ROOT>,
> +					 <&cru ACLK_USB>,
>   					 <&cru HCLK_USB_ROOT>,
>   					 <&cru HCLK_HOST0>,
>   					 <&cru HCLK_HOST_ARB0>,
> @@ -1329,6 +1471,16 @@
>   		};
>   	};
>   
> +	dfi: dfi@fe060000 {
> +		reg = <0x00 0xfe060000 0x00 0x10000>;
> +		compatible = "rockchip,rk3588-dfi";
> +		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> +		rockchip,pmu = <&pmu1grf>;
> +	};
> +
>   	gmac1: ethernet@fe1c0000 {
>   		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
>   		reg = <0x0 0xfe1c0000 0x0 0x10000>;
>
