Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BFCC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771DD8844E;
	Thu,  6 Jun 2024 09:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zvd3/NmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C35488291; Thu,  6 Jun 2024 09:00:17 +0200 (CEST)
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com
 [220.197.32.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746D88844E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Zvd3/NmUW7HUQKCpjnbGzWYhSf18d4I1zrsDX/t2sDNYIjd25SbFhkCCZIp6K//TDU4zIr6tSMWso5C7nwQ0wpLgIg640D9HNzZd6QSNAxSUlNKv6axT9kv1kqzqS2VnPGx8Ve5k7EWZa6jC3JMEm9XZEP0rWEvLj+8zvjRyziI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=8Z8YYvaUPWpjmCu1oHPZL5QZvdrSRE97l+VRu66VJoc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DE83B90057C;
 Thu,  6 Jun 2024 15:00:02 +0800 (CST)
Message-ID: <5a550ddb-da32-4fce-a322-d1651666d569@rock-chips.com>
Date: Thu, 6 Jun 2024 15:00:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] rockchip: rk3588: Remove USB3 DRD nodes in
 u-boot.dtsi
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Christopher Obbard <chris.obbard@collabora.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-10-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-10-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh8eTVYZHk1PHxkZTxpNQklVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec58f30903a9kunmde83b90057c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Okk6Pww4UTNCQzYpDh0xEEsy
 NQIaCUxVSlVKTEpMTU5MSUtPS01CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTk9PNwY+
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


On 2024/5/29 01:04, Jianfeng Liu wrote:
> After we sync USB3 DRD nodes from v6.10-rc1, these obsolete nodes
> can be removed.
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   arch/arm/dts/rk3588-u-boot.dtsi  | 74 ---------------------------
>   arch/arm/dts/rk3588s-u-boot.dtsi | 85 --------------------------------
>   2 files changed, 159 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot.dtsi
> index 4623580c610..bfe6645c30e 100644
> --- a/arch/arm/dts/rk3588-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-u-boot.dtsi
> @@ -4,77 +4,3 @@
>    */
>   
>   #include "rk3588s-u-boot.dtsi"
> -
> -/ {
> -	usb_host1_xhci: usb@fc400000 {
> -		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
> -		reg = <0x0 0xfc400000 0x0 0x400000>;
> -		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
> -			 <&cru ACLK_USB3OTG1>;
> -		clock-names = "ref_clk", "suspend_clk", "bus_clk";
> -		dr_mode = "otg";
> -		phys = <&u2phy1_otg>, <&usbdp_phy1 PHY_TYPE_USB3>;
> -		phy-names = "usb2-phy", "usb3-phy";
> -		phy_type = "utmi_wide";
> -		power-domains = <&power RK3588_PD_USB>;
> -		resets = <&cru SRST_A_USB3OTG1>;
> -		snps,dis_enblslpm_quirk;
> -		snps,dis-u2-freeclk-exists-quirk;
> -		snps,dis-del-phy-power-chg-quirk;
> -		snps,dis-tx-ipgap-linecheck-quirk;
> -		status = "disabled";
> -	};
> -
> -	usbdpphy1_grf: syscon@fd5cc000 {
> -		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
> -		reg = <0x0 0xfd5cc000 0x0 0x4000>;
> -	};
> -
> -	usb2phy1_grf: syscon@fd5d4000 {
> -		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
> -		reg = <0x0 0xfd5d4000 0x0 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		u2phy1: usb2phy@4000 {
> -			compatible = "rockchip,rk3588-usb2phy";
> -			reg = <0x4000 0x10>;
> -			#clock-cells = <0>;
> -			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> -			clock-names = "phyclk";
> -			clock-output-names = "usb480m_phy1";
> -			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
> -			reset-names = "phy", "apb";
> -			status = "disabled";
> -
> -			u2phy1_otg: otg-port {
> -				#phy-cells = <0>;
> -				status = "disabled";
> -			};
> -		};
> -	};
> -
> -	usbdp_phy1: phy@fed90000 {
> -		compatible = "rockchip,rk3588-usbdp-phy";
> -		reg = <0x0 0xfed90000 0x0 0x10000>;
> -		#phy-cells = <1>;
> -		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
> -			 <&cru CLK_USBDP_PHY1_IMMORTAL>,
> -			 <&cru PCLK_USBDPPHY1>,
> -			 <&u2phy1>;
> -		clock-names = "refclk", "immortal", "pclk", "utmi";
> -		resets = <&cru SRST_USBDP_COMBO_PHY1_INIT>,
> -			 <&cru SRST_USBDP_COMBO_PHY1_CMN>,
> -			 <&cru SRST_USBDP_COMBO_PHY1_LANE>,
> -			 <&cru SRST_USBDP_COMBO_PHY1_PCS>,
> -			 <&cru SRST_P_USBDPPHY1>;
> -		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> -		rockchip,u2phy-grf = <&usb2phy1_grf>;
> -		rockchip,usb-grf = <&usb_grf>;
> -		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
> -		rockchip,vo-grf = <&vo0_grf>;
> -		status = "disabled";
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index e9d38d5c83b..09d8b311cec 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -19,95 +19,10 @@
>   		bootph-all;
>   	};
>   
> -	usb_host0_xhci: usb@fc000000 {
> -		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
> -		reg = <0x0 0xfc000000 0x0 0x400000>;
> -		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
> -			 <&cru ACLK_USB3OTG0>;
> -		clock-names = "ref_clk", "suspend_clk", "bus_clk";
> -		dr_mode = "otg";
> -		phys = <&u2phy0_otg>, <&usbdp_phy0 PHY_TYPE_USB3>;
> -		phy-names = "usb2-phy", "usb3-phy";
> -		phy_type = "utmi_wide";
> -		power-domains = <&power RK3588_PD_USB>;
> -		resets = <&cru SRST_A_USB3OTG0>;
> -		snps,dis_enblslpm_quirk;
> -		snps,dis-u1-entry-quirk;
> -		snps,dis-u2-entry-quirk;
> -		snps,dis-u2-freeclk-exists-quirk;
> -		snps,dis-del-phy-power-chg-quirk;
> -		snps,dis-tx-ipgap-linecheck-quirk;
> -		status = "disabled";
> -	};
> -
> -	vo0_grf: syscon@fd5a6000 {
> -		compatible = "rockchip,rk3588-vo-grf", "syscon";
> -		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> -		clocks = <&cru PCLK_VO0GRF>;
> -	};
> -
> -	usb_grf: syscon@fd5ac000 {
> -		compatible = "rockchip,rk3588-usb-grf", "syscon";
> -		reg = <0x0 0xfd5ac000 0x0 0x4000>;
> -	};
> -
> -	usbdpphy0_grf: syscon@fd5c8000 {
> -		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
> -		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> -	};
> -
> -	usb2phy0_grf: syscon@fd5d0000 {
> -		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
> -		reg = <0x0 0xfd5d0000 0x0 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		u2phy0: usb2phy@0 {
> -			compatible = "rockchip,rk3588-usb2phy";
> -			reg = <0x0 0x10>;
> -			#clock-cells = <0>;
> -			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> -			clock-names = "phyclk";
> -			clock-output-names = "usb480m_phy0";
> -			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
> -			reset-names = "phy", "apb";
> -			status = "disabled";
> -
> -			u2phy0_otg: otg-port {
> -				#phy-cells = <0>;
> -				status = "disabled";
> -			};
> -		};
> -	};
> -
>   	rng: rng@fe378000 {
>   		compatible = "rockchip,trngv1";
>   		reg = <0x0 0xfe378000 0x0 0x200>;
>   	};
> -
> -	usbdp_phy0: phy@fed80000 {
> -		compatible = "rockchip,rk3588-usbdp-phy";
> -		reg = <0x0 0xfed80000 0x0 0x10000>;
> -		#phy-cells = <1>;
> -		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
> -			 <&cru CLK_USBDP_PHY0_IMMORTAL>,
> -			 <&cru PCLK_USBDPPHY0>,
> -			 <&u2phy0>;
> -		clock-names = "refclk", "immortal", "pclk", "utmi";
> -		resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
> -			 <&cru SRST_USBDP_COMBO_PHY0_CMN>,
> -			 <&cru SRST_USBDP_COMBO_PHY0_LANE>,
> -			 <&cru SRST_USBDP_COMBO_PHY0_PCS>,
> -			 <&cru SRST_P_USBDPPHY0>;
> -		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> -		rockchip,u2phy-grf = <&usb2phy0_grf>;
> -		rockchip,usb-grf = <&usb_grf>;
> -		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
> -		rockchip,vo-grf = <&vo0_grf>;
> -		status = "disabled";
> -	};
>   };
>   
>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
