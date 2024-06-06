Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E8BC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A36881B8;
	Thu,  6 Jun 2024 08:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PkDIYaxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6132D881B8; Thu,  6 Jun 2024 08:59:21 +0200 (CEST)
Received: from mail-m121151.qiye.163.com (mail-m121151.qiye.163.com
 [115.236.121.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1501487D9B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=PkDIYaxwRItjFlBgNQfqPFRxHx2ZupC7ozAwRyxp1BKk7plJPQ3PIK0+LrNeNwNjCHuQO/UEOStyYq4IyJRRMxHCy7KBxkGBdzewLZ6RsFJpIL2R1M8IAe97orJbq6QS3KZRymv/QFlar4PHvvrUXMZtgWTava88M0Gg8pTbqYU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=5+cfN28kVTrPxuhsHoPY5PFFx5USQyEXLmt5oVzxab4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5AA2490054C;
 Thu,  6 Jun 2024 14:58:51 +0800 (CST)
Message-ID: <b216b37e-a3a8-4fb7-9838-ee2de76d9fd8@rock-chips.com>
Date: Thu, 6 Jun 2024 14:58:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] arm64: dts: rockchip: Add rk3588 GPU node
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Diederik de Haas <didi.debian@cknow.org>,
 Niklas Cassel <cassel@kernel.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-2-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-2-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpIHlZMTk5KQ0NDTkhMH0tVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec57dbed03a9kunm5aa2490054c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBA6TBw*EDNMNDYfDi4wQjoN
 KTVPFDhVSlVKTEpMTU5MSkhJTUxDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOS0hINwY+
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
> From: Boris Brezillon <boris.brezillon@collabora.com>
>
> Add Mali GPU Node to the RK3588 SoC DT including GPU clock
> operating points
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Link: https://lore.kernel.org/r/20240326165232.73585-3-sebastian.reichel@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 6fca4edb93d335f29f81e484936f38a5eed6a9b1 ]
>
> (cherry picked from commit 3cd15354ea0c8668812bc0b3a4136606c10803e9)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 56 ++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index 87b83c87bd5..89d40cff635 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -501,6 +501,62 @@
>   		status = "disabled";
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
>   	pmu1grf: syscon@fd58a000 {
>   		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
>   		reg = <0x0 0xfd58a000 0x0 0x10000>;
