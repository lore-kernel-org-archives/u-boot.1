Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA3C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8EE832A4;
	Tue,  8 Apr 2025 05:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="c/EwZBGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB72583290; Tue,  8 Apr 2025 05:21:55 +0200 (CEST)
Received: from mail-m49237.qiye.163.com (mail-m49237.qiye.163.com
 [45.254.49.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1638331B
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208933;
 Tue, 8 Apr 2025 11:21:47 +0800 (GMT+08:00)
Message-ID: <0c850348-9380-4340-9e26-9f79989e6289@rock-chips.com>
Date: Tue, 8 Apr 2025 11:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/30] arm64: dts: rockchip: Add SARADC node for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk8fHlYfSk5PS0lPHx4ZSE1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136b17a303afkunm110208933
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6KBw*FDJWVkISARUOTj4I
 STQwFC9VSlVKTE9PS0NJTktDTExDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTU5KNwY+
DKIM-Signature: a=rsa-sha256;
 b=c/EwZBGJtSvfRscUafNCG6TvianuxsvGzVLGAtjttMbNbZSDr1q96not6MPQbvUJd+A8ICmg1mvOGeJ6f9xfbDGmxpsT2XqULmfyoHtGcq3Baqsevh4Yeg4Z72ZIIIvRG7B34vYg667O66f4E4k9ceiABTAHIcX2WowMWVZvN1Q=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=EG+pHULhwsVTFTY+mCeuByTHm3jdjfm5ixOGh7j3erU=;
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
> Add a device tree node for the SARADC controller used by RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250304201642.831218-4-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 6e58302c84ce90aadbecd41efe1f69098a6f91e5 ]
>
> (cherry picked from commit 8ba64ba5cb301bca777ba7f0d2a2a72f49af5ff2)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3528.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> index 4be53868f324..c2eaa0c6ea90 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> @@ -9,6 +9,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
>   #include <dt-bindings/clock/rockchip,rk3528-cru.h>
> +#include <dt-bindings/reset/rockchip,rk3528-cru.h>
>   
>   / {
>   	compatible = "rockchip,rk3528";
> @@ -455,6 +456,18 @@
>   			status = "disabled";
>   		};
>   
> +		saradc: adc@ffae0000 {
> +			compatible = "rockchip,rk3528-saradc";
> +			reg = <0x0 0xffae0000 0x0 0x10000>;
> +			clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
> +			clock-names = "saradc", "apb_pclk";
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&cru SRST_P_SARADC>;
> +			reset-names = "saradc-apb";
> +			#io-channel-cells = <1>;
> +			status = "disabled";
> +		};
> +
>   		pinctrl: pinctrl {
>   			compatible = "rockchip,rk3528-pinctrl";
>   			rockchip,grf = <&ioc_grf>;
