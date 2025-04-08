Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25367C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8340283290;
	Tue,  8 Apr 2025 05:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xd9fu4QQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED5482CE7; Tue,  8 Apr 2025 05:22:00 +0200 (CEST)
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com
 [101.71.155.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53B083290
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 11020894d;
 Tue, 8 Apr 2025 11:21:53 +0800 (GMT+08:00)
Message-ID: <d38aa9fd-e0f7-4186-90db-d10053b74ebb@rock-chips.com>
Date: Tue, 8 Apr 2025 11:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/30] arm64: dts: rockchip: Add SDHCI controller for
 RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRofGlZCHUxDSEpPHU1IGBlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136b2e8803afkunm11020894d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6KBw4CDJCSEI9ARYsTj5D
 NTgaC0pVSlVKTE9PS0NJTkpPQk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0pCNwY+
DKIM-Signature: a=rsa-sha256;
 b=Xd9fu4QQvFOhD6lEZBcB7Y6miRahbrQA9nBcHwckhjNDnKK95abwZKiIEu1HxK88Gdcgk4aJVEMpaYj49YUMrS+1MlQzMAodahTdS6Jcgk1efNlDjSUUJSuTO4XZCdsI5R1grEjAYFcDqdFhESRHCsQP03ojDCCaOi93f0+7QNQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=g1o27uRN8jDNRbVebIgHNMVzFJeSBs6z58IWAm63OZ0=;
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
> The SDHCI controller in Rockchip RK3528 is similar to the one included
> in RK3588.
>
> Add device tree node for the SDHCI controller in RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250305214108.1327208-3-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: a98cc47f79ab5b8059b748bf0bd59335edfff7d9 ]
>
> (cherry picked from commit db7a99c423dea0ead19d6a18053d898a762a3b48)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3528.dtsi | 24 +++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> index c2eaa0c6ea90..26c3559d6a6d 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> @@ -468,6 +468,30 @@
>   			status = "disabled";
>   		};
>   
> +		sdhci: mmc@ffbf0000 {
> +			compatible = "rockchip,rk3528-dwcmshc",
> +				     "rockchip,rk3588-dwcmshc";
> +			reg = <0x0 0xffbf0000 0x0 0x10000>;
> +			assigned-clocks = <&cru BCLK_EMMC>, <&cru TCLK_EMMC>,
> +					  <&cru CCLK_SRC_EMMC>;
> +			assigned-clock-rates = <200000000>, <24000000>,
> +					       <200000000>;
> +			clocks = <&cru CCLK_SRC_EMMC>, <&cru HCLK_EMMC>,
> +				 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
> +				 <&cru TCLK_EMMC>;
> +			clock-names = "core", "bus", "axi", "block", "timer";
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <200000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
> +				    <&emmc_strb>;
> +			resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
> +				 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
> +				 <&cru SRST_T_EMMC>;
> +			reset-names = "core", "bus", "axi", "block", "timer";
> +			status = "disabled";
> +		};
> +
>   		pinctrl: pinctrl {
>   			compatible = "rockchip,rk3528-pinctrl";
>   			rockchip,grf = <&ioc_grf>;
