Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA7C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78BCC88027;
	Thu,  6 Jun 2024 08:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="C7/SVR2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1ACE88027; Thu,  6 Jun 2024 08:59:18 +0200 (CEST)
Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com
 [117.135.214.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B540787947
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=C7/SVR2Zi9hwdNisEMj7nYvnDc1VfJzXNzmX0FQWfAkd6K+Lck5yUZOBk9L8jsU3Jbi5EtRIiW32LZXmmMFXawzpC3V3rIT9CHxZAUERFI8HrVejVqhCxhCmLJSmn+Stoc0GJ58rneGdiga87W2z+ryXF0G6TgAafkQgcJ59BXY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=qZqHK5MwasUhYoVKYUSJzQLA1pfamhPteLEGSh95NDo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 164E490050E;
 Thu,  6 Jun 2024 14:58:59 +0800 (CST)
Message-ID: <d671d4f6-4014-45a7-a4fc-152b8c1f1f7e@rock-chips.com>
Date: Thu, 6 Jun 2024 14:58:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] arm64: dts: rockchip: Fix ordering of nodes on
 rk3588s
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Diederik de Haas <didi.debian@cknow.org>, Heiko Stuebner
 <heiko@sntech.de>, Boris Brezillon <boris.brezillon@collabora.com>,
 Niklas Cassel <cassel@kernel.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-3-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-3-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9IQlZNHhgaTklPGBhMSk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec57ff4c03a9kunm164e490050e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxw6KTo5TTNJTzY3HiMMQhgf
 HwkaFFZVSlVKTEpMTU5MSk9KQ05MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEJCTzcG
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


On 2024/5/29 01:03, Jianfeng Liu wrote:
> From: Diederik de Haas <didi.debian@cknow.org>
>
> Fix the ordering of the main nodes by sorting them alphabetically and
> then the ones with a memory address sequentially by that address.
>
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> Link: https://lore.kernel.org/r/20240406172821.34173-1-didi.debian@cknow.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: cbb97fe18e299ece1c0074924c630de6a19b320f ]
>
> (cherry picked from commit bbf7c16f2f1208b96349f6f6648b69cfaa1a482b)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 304 +++++++++----------
>   1 file changed, 152 insertions(+), 152 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index 89d40cff635..ac5bd630f15 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -347,6 +347,11 @@
>   		};
>   	};
>   
> +	display_subsystem: display-subsystem {
> +		compatible = "rockchip,display-subsystem";
> +		ports = <&vop_out>;
> +	};
> +
>   	firmware {
>   		optee: optee {
>   			compatible = "linaro,optee-tz";
> @@ -394,11 +399,6 @@
>   		#clock-cells = <0>;
>   	};
>   
> -	display_subsystem: display-subsystem {
> -		compatible = "rockchip,display-subsystem";
> -		ports = <&vop_out>;
> -	};
> -
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> @@ -436,6 +436,62 @@
>   		};
>   	};
>   
> +	gpu: gpu@fb000000 {
> +		compatible = "rockchip,rk3588-mali", "arm,mali-valhall-csf";
> +		reg = <0x0 0xfb000000 0x0 0x200000>;
> +		#cooling-cells = <2>;
> +		assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
> +		assigned-clock-rates = <200000000>;
> +		clocks = <&cru CLK_GPU>, <&cru CLK_GPU_COREGROUP>,
> +			 <&cru CLK_GPU_STACKS>;
> +		clock-names = "core", "coregroup", "stacks";
> +		dynamic-power-coefficient = <2982>;
> +		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "job", "mmu", "gpu";
> +		operating-points-v2 = <&gpu_opp_table>;
> +		power-domains = <&power RK3588_PD_GPU>;
> +		status = "disabled";
> +
> +		gpu_opp_table: opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-300000000 {
> +				opp-hz = /bits/ 64 <300000000>;
> +				opp-microvolt = <675000 675000 850000>;
> +			};
> +			opp-400000000 {
> +				opp-hz = /bits/ 64 <400000000>;
> +				opp-microvolt = <675000 675000 850000>;
> +			};
> +			opp-500000000 {
> +				opp-hz = /bits/ 64 <500000000>;
> +				opp-microvolt = <675000 675000 850000>;
> +			};
> +			opp-600000000 {
> +				opp-hz = /bits/ 64 <600000000>;
> +				opp-microvolt = <675000 675000 850000>;
> +			};
> +			opp-700000000 {
> +				opp-hz = /bits/ 64 <700000000>;
> +				opp-microvolt = <700000 700000 850000>;
> +			};
> +			opp-800000000 {
> +				opp-hz = /bits/ 64 <800000000>;
> +				opp-microvolt = <750000 750000 850000>;
> +			};
> +			opp-900000000 {
> +				opp-hz = /bits/ 64 <900000000>;
> +				opp-microvolt = <800000 800000 850000>;
> +			};
> +			opp-1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-microvolt = <850000 850000 850000>;
> +			};
> +		};
> +	};
> +
>   	usb_host0_ehci: usb@fc800000 {
>   		compatible = "rockchip,rk3588-ehci", "generic-ehci";
>   		reg = <0x0 0xfc800000 0x0 0x40000>;
> @@ -501,62 +557,6 @@
>   		status = "disabled";
>   	};
>   
> -	gpu: gpu@fb000000 {
> -		compatible = "rockchip,rk3588-mali", "arm,mali-valhall-csf";
> -		reg = <0x0 0xfb000000 0x0 0x200000>;
> -		#cooling-cells = <2>;
> -		assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
> -		assigned-clock-rates = <200000000>;
> -		clocks = <&cru CLK_GPU>, <&cru CLK_GPU_COREGROUP>,
> -			 <&cru CLK_GPU_STACKS>;
> -		clock-names = "core", "coregroup", "stacks";
> -		dynamic-power-coefficient = <2982>;
> -		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "job", "mmu", "gpu";
> -		operating-points-v2 = <&gpu_opp_table>;
> -		power-domains = <&power RK3588_PD_GPU>;
> -		status = "disabled";
> -
> -		gpu_opp_table: opp-table {
> -			compatible = "operating-points-v2";
> -
> -			opp-300000000 {
> -				opp-hz = /bits/ 64 <300000000>;
> -				opp-microvolt = <675000 675000 850000>;
> -			};
> -			opp-400000000 {
> -				opp-hz = /bits/ 64 <400000000>;
> -				opp-microvolt = <675000 675000 850000>;
> -			};
> -			opp-500000000 {
> -				opp-hz = /bits/ 64 <500000000>;
> -				opp-microvolt = <675000 675000 850000>;
> -			};
> -			opp-600000000 {
> -				opp-hz = /bits/ 64 <600000000>;
> -				opp-microvolt = <675000 675000 850000>;
> -			};
> -			opp-700000000 {
> -				opp-hz = /bits/ 64 <700000000>;
> -				opp-microvolt = <700000 700000 850000>;
> -			};
> -			opp-800000000 {
> -				opp-hz = /bits/ 64 <800000000>;
> -				opp-microvolt = <750000 750000 850000>;
> -			};
> -			opp-900000000 {
> -				opp-hz = /bits/ 64 <900000000>;
> -				opp-microvolt = <800000 800000 850000>;
> -			};
> -			opp-1000000000 {
> -				opp-hz = /bits/ 64 <1000000000>;
> -				opp-microvolt = <850000 850000 850000>;
> -			};
> -		};
> -	};
> -
>   	pmu1grf: syscon@fd58a000 {
>   		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
>   		reg = <0x0 0xfd58a000 0x0 0x10000>;
> @@ -702,74 +702,6 @@
>   		status = "disabled";
>   	};
>   
> -	vop: vop@fdd90000 {
> -		compatible = "rockchip,rk3588-vop";
> -		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
> -		reg-names = "vop", "gamma-lut";
> -		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VOP>,
> -			 <&cru HCLK_VOP>,
> -			 <&cru DCLK_VOP0>,
> -			 <&cru DCLK_VOP1>,
> -			 <&cru DCLK_VOP2>,
> -			 <&cru DCLK_VOP3>,
> -			 <&cru PCLK_VOP_ROOT>;
> -		clock-names = "aclk",
> -			      "hclk",
> -			      "dclk_vp0",
> -			      "dclk_vp1",
> -			      "dclk_vp2",
> -			      "dclk_vp3",
> -			      "pclk_vop";
> -		iommus = <&vop_mmu>;
> -		power-domains = <&power RK3588_PD_VOP>;
> -		rockchip,grf = <&sys_grf>;
> -		rockchip,vop-grf = <&vop_grf>;
> -		rockchip,vo1-grf = <&vo1_grf>;
> -		rockchip,pmu = <&pmu>;
> -		status = "disabled";
> -
> -		vop_out: ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			vp0: port@0 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <0>;
> -			};
> -
> -			vp1: port@1 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <1>;
> -			};
> -
> -			vp2: port@2 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <2>;
> -			};
> -
> -			vp3: port@3 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <3>;
> -			};
> -		};
> -	};
> -
> -	vop_mmu: iommu@fdd97e00 {
> -		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> -		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
> -		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -		power-domains = <&power RK3588_PD_VOP>;
> -		status = "disabled";
> -	};
> -
>   	uart0: serial@fd890000 {
>   		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
>   		reg = <0x0 0xfd890000 0x0 0x100>;
> @@ -1140,6 +1072,87 @@
>   		};
>   	};
>   
> +	av1d: video-codec@fdc70000 {
> +		compatible = "rockchip,rk3588-av1-vpu";
> +		reg = <0x0 0xfdc70000 0x0 0x800>;
> +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "vdpu";
> +		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> +		assigned-clock-rates = <400000000>, <400000000>;
> +		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> +		clock-names = "aclk", "hclk";
> +		power-domains = <&power RK3588_PD_AV1>;
> +		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
> +	};
> +
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
>   	i2s4_8ch: i2s@fddc0000 {
>   		compatible = "rockchip,rk3588-i2s-tdm";
>   		reg = <0x0 0xfddc0000 0x0 0x1000>;
> @@ -1431,6 +1444,16 @@
>   		reg = <0x0 0xfdf82200 0x0 0x20>;
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
>   	pcie2x1l1: pcie@fe180000 {
>   		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
>   		bus-range = <0x30 0x3f>;
> @@ -1533,16 +1556,6 @@
>   		};
>   	};
>   
> -	dfi: dfi@fe060000 {
> -		reg = <0x00 0xfe060000 0x00 0x10000>;
> -		compatible = "rockchip,rk3588-dfi";
> -		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> -		rockchip,pmu = <&pmu1grf>;
> -	};
> -
>   	gmac1: ethernet@fe1c0000 {
>   		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
>   		reg = <0x0 0xfe1c0000 0x0 0x10000>;
> @@ -2543,19 +2556,6 @@
>   			#interrupt-cells = <2>;
>   		};
>   	};
> -
> -	av1d: video-codec@fdc70000 {
> -		compatible = "rockchip,rk3588-av1-vpu";
> -		reg = <0x0 0xfdc70000 0x0 0x800>;
> -		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "vdpu";
> -		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> -		assigned-clock-rates = <400000000>, <400000000>;
> -		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> -		clock-names = "aclk", "hclk";
> -		power-domains = <&power RK3588_PD_AV1>;
> -		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
> -	};
>   };
>   
>   #include "rk3588s-pinctrl.dtsi"
