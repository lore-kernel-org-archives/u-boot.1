Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3B0C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD5283290;
	Tue,  8 Apr 2025 05:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZkindHog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5465A8339C; Tue,  8 Apr 2025 05:23:32 +0200 (CEST)
Received: from mail-m10102.netease.com (mail-m10102.netease.com
 [154.81.10.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEA6832FE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208b0d;
 Tue, 8 Apr 2025 11:23:23 +0800 (GMT+08:00)
Message-ID: <fc53a618-b19d-4334-b274-491c089a7b38@rock-chips.com>
Date: Tue, 8 Apr 2025 11:23:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/30] arm: dts: rockchip: Add rk3528-u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-19-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-19-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0sYSVYdHhpITkpJS0JPThpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
 NVSktLVUpCWQY+
X-HM-Tid: 0a96136c8f5003afkunm110208b0d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6OQw*SDJLH0JDAQ4xTi5R
 KkoaFD5VSlVKTE9PS0NJTUtPQk5MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSU9JNwY+
DKIM-Signature: a=rsa-sha256;
 b=ZkindHogakSJQbn6o6f6ohv6QKwC5wVs0uKGH+NRw0mqckQQ3bo+FKydjvIyH+2K1YXyPR1pMLigExS4lJXZ3TSstP+ZnVNuhf+Yve38c+EVL9T5tPZjNA5j3W1nI1gw7CmqI7PREpM8n8FJcRG9QWy1UOzO0qjw9cbvHxelc/s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=yQUHiRRbmzjHyRThmX/5mmmp4nyhSGW+Rnfq18J9fy4=;
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
> Add a rk3528-u-boot.dtsi extending the basic dts/upstream rk3528.dtsi
> with bare minimum nodes to have a booting system from eMMC and SD-card.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Use more nodes from dts/upstream rk3528.dtsi
> - Use sdmmc node from latest mainline Linux patch
> ---
>   arch/arm/dts/rk3528-u-boot.dtsi | 148 ++++++++++++++++++++++++++++++++
>   1 file changed, 148 insertions(+)
>   create mode 100644 arch/arm/dts/rk3528-u-boot.dtsi
>
> diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
> new file mode 100644
> index 000000000000..eb6a55cd5c93
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-u-boot.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rockchip-u-boot.dtsi"
> +
> +/ {
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +	};
> +
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +	};
> +
> +	dmc {
> +		compatible = "rockchip,rk3528-dmc";
> +		bootph-all;
> +	};
> +
> +	soc {
> +		rng: rng@ffc50000 {
> +			compatible = "rockchip,rkrng";
> +			reg = <0x0 0xffc50000 0x0 0x200>;
> +		};
> +
> +		otp: nvmem@ffce0000 {
> +			compatible = "rockchip,rk3528-otp";
> +			reg = <0x0 0xffce0000 0x0 0x4000>;
> +		};
> +
> +		sdmmc: mmc@ffc30000 {
> +			compatible = "rockchip,rk3528-dw-mshc",
> +				     "rockchip,rk3288-dw-mshc";
> +			reg = <0x0 0xffc30000 0x0 0x4000>;
> +			clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SRC_SDMMC0>;
> +			clock-names = "biu", "ciu";
> +			fifo-depth = <0x100>;
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
> +				    <&sdmmc_det>;
> +			resets = <&cru SRST_H_SDMMC0>;
> +			reset-names = "reset";
> +			rockchip,default-sample-phase = <90>;
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&cru {
> +	bootph-all;
> +};
> +
> +&emmc_bus8 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_strb {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gmac0_clk {
> +	bootph-all;
> +};
> +
> +&ioc_grf {
> +	bootph-all;
> +};
> +
> +&otp {
> +	bootph-some-ram;
> +};
> +
> +&pcfg_pull_none {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up_drv_level_2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl {
> +	bootph-all;
> +};
> +
> +&sdhci {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&sdmmc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&sdmmc_bus4 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc_det {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart0m0_xfer {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> +
> +&xin24m {
> +	bootph-all;
> +};
