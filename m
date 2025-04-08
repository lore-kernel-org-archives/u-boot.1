Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58418C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C8A82CEA;
	Tue,  8 Apr 2025 05:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LzER8FAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A674B832A4; Tue,  8 Apr 2025 05:21:47 +0200 (CEST)
Received: from mail-m49212.qiye.163.com (mail-m49212.qiye.163.com
 [45.254.49.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD3182CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e8d3b;
 Tue, 8 Apr 2025 11:21:40 +0800 (GMT+08:00)
Message-ID: <2f8e4181-941d-4e92-ae83-26a2a68cef0b@rock-chips.com>
Date: Tue, 8 Apr 2025 11:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/30] arm64: dts: rockchip: enable SCMI clk for RK3528
 SoC
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5OT1ZMTElCSE4ZH0pISU1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136afc5d03afkunm1101e8d3b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Hxw6TjJKSEJOPxUdT0w8
 HBwwCS9VSlVKTE9PS0NJTktJSkpDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISE9LNwY+
DKIM-Signature: a=rsa-sha256;
 b=LzER8FAgVv1IKpJ3QdORwvWWO0auO0AZc79EFZ+zhssXXzx+gJ48w575hdgmppM9DCU/ZE1w8GdEOiMbb6yV5t0F8fgC3w03zEww6H8AYfWeDgdAmsR8WN9EtYx2p0Yo7QCzyBnqWOwdxaiUwliLaVWVJsoAK0N9ETK6T6+WbAw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=bVQL3wjNZzvQ9TU/cAtHuCHMVeQhz0TTQqYxsSCrbZY=;
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
> From: Chukun Pan <amadeus@jmu.edu.cn>
>
> Same as RK3568, RK3528 uses SCMI clk instead of ARMCLK.
> Add SCMI clk for CPU, GPU and RNG will also use it.
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> Link: https://lore.kernel.org/r/20250307100008.789129-2-amadeus@jmu.edu.cn
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: fbcbc1fb93e14729bd87ab386b7f62694dcc8b51 ]
>
> (cherry picked from commit 6e03c7e28e2d929a420809a24b0379305a9fb86a)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3528.dtsi | 31 +++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> index 0c0e7f151462..4be53868f324 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> @@ -59,6 +59,7 @@
>   			reg = <0x0>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -66,6 +67,7 @@
>   			reg = <0x1>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -73,6 +75,7 @@
>   			reg = <0x2>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -80,6 +83,22 @@
>   			reg = <0x3>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0x82000010>;
> +			shmem = <&scmi_shmem>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
>   		};
>   	};
>   
> @@ -88,6 +107,18 @@
>   		method = "smc";
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_shmem: shmem@10f000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x0010f000 0x0 0x100>;
> +			no-map;
> +		};
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
