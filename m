Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB31C52D70
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB1B8874E;
	Fri,  2 Aug 2024 08:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sa7MzFZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2AB88B70; Fri,  2 Aug 2024 08:21:05 +0200 (CEST)
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com
 [220.197.31.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728D287C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Sa7MzFZpeXPDIJ8gJCrWaQiw2uDSC/TmVTCh/SvYwsqtlhCC3cjzGR7U1+23ZdeTfJD21dxEMFWdaF4bQuy/miplvK5sMkCDLvP3Na5ZgSULWZTKbNyj4bPGY0fX4HOdr9HSOdxZsePkVSKRB6B9nyzJ6h6LCNzvorD8E6C6pyQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=fJVlK8uqGCslzPqUJpXRkgFGPYHVcfEq2w5A9qAXDX4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DB25B9004A7;
 Fri,  2 Aug 2024 14:20:37 +0800 (CST)
Message-ID: <3bc0f24f-41d2-4a7c-8f2a-bfdabe138d8f@rock-chips.com>
Date: Fri, 2 Aug 2024 14:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: add thermal zones information
 on RK3588
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: dsimic@manjaro.org, u-boot@lists.denx.de,
 Alexey Charkov <alchark@gmail.com>
References: <20240731102624.2541989-1-heiko@sntech.de>
 <20240731102624.2541989-3-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240731102624.2541989-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktKTFYZSU0fT04eQ0NOTUhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bf586703a9kunmdb25b9004a7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N006Vhw5CzI6SCIROE1NIgEq
 CAkwCxhVSlVKTElJTkxCTUhDQkhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNQk1INwY+
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


On 2024/7/31 18:26, Heiko Stuebner wrote:
> From: Alexey Charkov <alchark@gmail.com>
>
> This includes the necessary device tree data to allow thermal
> monitoring on RK3588(s) using the on-chip TSADC device, along with
> trip points for automatic thermal management.
>
> Each of the CPU clusters (one for the little cores and two for
> the big cores) get a passive cooling trip point at 85C, which
> will trigger DVFS throttling of the respective cluster upon
> reaching a high temperature condition.
>
> All zones also have a critical trip point at 115C, which will
> trigger a reset.
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> Link: https://lore.kernel.org/r/20240617-rk-dts-additions-v5-1-c1f5f3267f1e@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 510cd9e688453166b2bff3999ed21cac97385bb5 ]
>
> (cherry picked from commit 33e7079543d5eee1415b937054e8634000d1bde4)
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3588-base.dtsi       | 153 ++++++++++++++++++
>   1 file changed, 153 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> index 629049f3dc1..78bc9dc9704 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/ata/ahci.h>
> +#include <dt-bindings/thermal/thermal.h>
>   
>   / {
>   	compatible = "rockchip,rk3588";
> @@ -2368,6 +2369,158 @@
>   		status = "disabled";
>   	};
>   
> +	thermal_zones: thermal-zones {
> +		/* sensor near the center of the SoC */
> +		package_thermal: package-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				package_crit: package-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 0 and 1 */
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				bigcore0_alert: bigcore0-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				bigcore0_crit: bigcore0-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore0_alert>;
> +					cooling-device =
> +						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 2 and 3 */
> +		bigcore2_thermal: bigcore2-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				bigcore2_alert: bigcore2-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				bigcore2_crit: bigcore2-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore2_alert>;
> +					cooling-device =
> +						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between the four A55 cores */
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				littlecore_alert: littlecore-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				littlecore_crit: littlecore-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&littlecore_alert>;
> +					cooling-device =
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor near the PD_CENTER power domain */
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>   	tsadc: tsadc@fec00000 {
>   		compatible = "rockchip,rk3588-tsadc";
>   		reg = <0x0 0xfec00000 0x0 0x400>;
