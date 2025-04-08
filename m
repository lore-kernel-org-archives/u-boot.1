Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853E5C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA4083314;
	Tue,  8 Apr 2025 05:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QZr92drt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38986832FE; Tue,  8 Apr 2025 05:21:39 +0200 (CEST)
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com
 [101.71.155.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FB4832BC
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e8d16;
 Tue, 8 Apr 2025 11:21:32 +0800 (GMT+08:00)
Message-ID: <daeb79f3-914c-40c8-a7bf-6c7fa0bd6359@rock-chips.com>
Date: Tue, 8 Apr 2025 11:21:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/30] arm64: dts: rockchip: Add rk3528 QoS register
 node
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8aGVYeGkwfTh4dTklPHRpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136adaba03afkunm1101e8d16
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSo6MCo4NjJIH0IaPxFRMAlJ
 IxBPCjBVSlVKTE9PS0NJT0JISExLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTUpMNwY+
DKIM-Signature: a=rsa-sha256;
 b=QZr92drtKivdYlNtcN01qEd90fM/nFlNfOLTuLAZNpJUroUqJa4nvkQuVHILvo5+NUIH/IkvvAg2j+mFp4j8VFrB8x6BZgnAEqnchR7F5tRnQL73j4nGZguyThIHFbPUYTAIHNNhd4tIdkxI5Z15K/KDXWfQv8/mQUCS0OwPHsE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=3STLPQUJNIzBlH+PDwq8XbDAOnJxcxLbSK+YS+czv4Q=;
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
> The Quality-of-Service (QsS) node stores/restores specific
> register contents when the power domains is turned off/on.
> Add QoS node so that they can connect to the power domain.
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> Link: https://lore.kernel.org/r/20250306123809.273655-3-amadeus@jmu.edu.cn
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 61a05d8ca3030a544175671f5fab7a8f29c24085 ]
>
> (cherry picked from commit 9ee90dfd6957fcc42ea94c43d195b01d1b286713)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3528.dtsi | 160 ++++++++++++++++++++
>   1 file changed, 160 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> index b1713ed4d7e2..0c0e7f151462 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
> @@ -129,6 +129,166 @@
>   			#interrupt-cells = <3>;
>   		};
>   
> +		qos_crypto_a: qos@ff200000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200000 0x0 0x20>;
> +		};
> +
> +		qos_crypto_p: qos@ff200080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200080 0x0 0x20>;
> +		};
> +
> +		qos_dcf: qos@ff200100 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200100 0x0 0x20>;
> +		};
> +
> +		qos_dft2apb: qos@ff200200 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200200 0x0 0x20>;
> +		};
> +
> +		qos_dma2ddr: qos@ff200280 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200280 0x0 0x20>;
> +		};
> +
> +		qos_dmac: qos@ff200300 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200300 0x0 0x20>;
> +		};
> +
> +		qos_keyreader: qos@ff200380 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200380 0x0 0x20>;
> +		};
> +
> +		qos_cpu: qos@ff210000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff210000 0x0 0x20>;
> +		};
> +
> +		qos_debug: qos@ff210080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff210080 0x0 0x20>;
> +		};
> +
> +		qos_gpu_m0: qos@ff220000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff220000 0x0 0x20>;
> +		};
> +
> +		qos_gpu_m1: qos@ff220080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff220080 0x0 0x20>;
> +		};
> +
> +		qos_pmu_mcu: qos@ff240000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff240000 0x0 0x20>;
> +		};
> +
> +		qos_rkvdec: qos@ff250000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff250000 0x0 0x20>;
> +		};
> +
> +		qos_rkvenc: qos@ff260000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff260000 0x0 0x20>;
> +		};
> +
> +		qos_gmac0: qos@ff270000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270000 0x0 0x20>;
> +		};
> +
> +		qos_hdcp: qos@ff270080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270080 0x0 0x20>;
> +		};
> +
> +		qos_jpegdec: qos@ff270100 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270100 0x0 0x20>;
> +		};
> +
> +		qos_rga2_m0ro: qos@ff270200 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270200 0x0 0x20>;
> +		};
> +
> +		qos_rga2_m0wo: qos@ff270280 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270280 0x0 0x20>;
> +		};
> +
> +		qos_sdmmc0: qos@ff270300 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270300 0x0 0x20>;
> +		};
> +
> +		qos_usb2host: qos@ff270380 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270380 0x0 0x20>;
> +		};
> +
> +		qos_vdpp: qos@ff270480 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270480 0x0 0x20>;
> +		};
> +
> +		qos_vop: qos@ff270500 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270500 0x0 0x20>;
> +		};
> +
> +		qos_emmc: qos@ff280000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280000 0x0 0x20>;
> +		};
> +
> +		qos_fspi: qos@ff280080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280080 0x0 0x20>;
> +		};
> +
> +		qos_gmac1: qos@ff280100 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280100 0x0 0x20>;
> +		};
> +
> +		qos_pcie: qos@ff280180 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280180 0x0 0x20>;
> +		};
> +
> +		qos_sdio0: qos@ff280200 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280200 0x0 0x20>;
> +		};
> +
> +		qos_sdio1: qos@ff280280 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280280 0x0 0x20>;
> +		};
> +
> +		qos_tsp: qos@ff280300 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280300 0x0 0x20>;
> +		};
> +
> +		qos_usb3otg: qos@ff280380 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280380 0x0 0x20>;
> +		};
> +
> +		qos_vpu: qos@ff280400 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280400 0x0 0x20>;
> +		};
> +
>   		cru: clock-controller@ff4a0000 {
>   			compatible = "rockchip,rk3528-cru";
>   			reg = <0x0 0xff4a0000 0x0 0x30000>;
