Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA33FC3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF1B83290;
	Tue,  8 Apr 2025 05:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bUplV0y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69E182F47; Tue,  8 Apr 2025 05:21:23 +0200 (CEST)
Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com
 [220.197.32.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E8F83290
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e8cc9;
 Tue, 8 Apr 2025 11:21:16 +0800 (GMT+08:00)
Message-ID: <35a41740-4cf5-4102-aa46-0d8942722e3e@rock-chips.com>
Date: Tue, 8 Apr 2025 11:21:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/30] arm64: dts: rockchip: Add UART clocks for RK3528
 SoC
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxLTlZMSk5OHkIZGE1OQhpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136a9d7703afkunm1101e8cc9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6TRw5IzIBD0IfERIeMCEt
 Nz0wFCxVSlVKTE9PS0NJT0xMTU9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTE9MNwY+
DKIM-Signature: a=rsa-sha256;
 b=bUplV0y60L73Mc88bNts26UhFQQ3St6gSOVjq3llRECNXG1W0pmBIGpRL1LjfMZIIza3Fi++dYKzIopes76KgNdT3fn8JJdSX7i0DbLCFHiBZ9xqe9Qt9o+L5cAvYaOmTXxL/7oiHCQXD2TxIdzn0BPgPdj9K5NprHKd2pCa3Dk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=QF6v13ez0nReFulKtzOBpP1Xy+EL0oD1nJ3Lh173egc=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> From: Yao Zi <ziyao@disroot.org>
>
> Add missing clocks in UART nodes for RK3528 SoC.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Link: https://lore.kernel.org/r/20250217061142.38480-10-ziyao@disroot.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: b9454434d0349223418f74fbfa7b902104da9bc5 ]
>
> (cherry picked from commit 12f69f638472dc9cf1b62816c7d4407de1846d12)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3528.dtsi | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> index 37fd40377076..5b334690356a 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> @@ -168,7 +168,8 @@
>   		uart0: serial@ff9f0000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xff9f0000 0x0 0x100>;
> -			clock-frequency = <24000000>;
> +			clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -178,6 +179,8 @@
>   		uart1: serial@ff9f8000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xff9f8000 0x0 0x100>;
> +			clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -187,6 +190,8 @@
>   		uart2: serial@ffa00000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xffa00000 0x0 0x100>;
> +			clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -195,6 +200,8 @@
>   
>   		uart3: serial@ffa08000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +			clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
> +			clock-names = "baudclk", "apb_pclk";
>   			reg = <0x0 0xffa08000 0x0 0x100>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -204,6 +211,8 @@
>   		uart4: serial@ffa10000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xffa10000 0x0 0x100>;
> +			clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -213,6 +222,8 @@
>   		uart5: serial@ffa18000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xffa18000 0x0 0x100>;
> +			clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -222,6 +233,8 @@
>   		uart6: serial@ffa20000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xffa20000 0x0 0x100>;
> +			clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
> @@ -231,6 +244,8 @@
>   		uart7: serial@ffa28000 {
>   			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>   			reg = <0x0 0xffa28000 0x0 0x100>;
> +			clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
> +			clock-names = "baudclk", "apb_pclk";
>   			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>   			reg-io-width = <4>;
>   			reg-shift = <2>;
