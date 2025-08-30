Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A18CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2086A83855;
	Sat, 30 Aug 2025 16:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CIJl3HaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E7C48388B; Sat, 30 Aug 2025 16:45:34 +0200 (CEST)
Received: from mail-m49213.qiye.163.com (mail-m49213.qiye.163.com
 [45.254.49.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB838341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 212398799;
 Sat, 30 Aug 2025 22:45:29 +0800 (GMT+08:00)
Message-ID: <df48c31c-443e-44f7-80f7-d3e868cdd108@rock-chips.com>
Date: Sat, 30 Aug 2025 22:45:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: rockchip: enable pcie on Sige5
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250711224446.211511-1-jonas@kwiboo.se>
 <20250711224446.211511-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250711224446.211511-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb70c7a003afkunm3c0ddcf040a08c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDThgaVh0YSU5JGktJQ00eT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=CIJl3HaFn/zrOSp7btzYlvaJptOzFkcsxB0oXNoieNGPONM/2IiN/lwemg7FnyFHhbck1yUGGlPLZ7wha4zyFNmFnOyEvULgKeLMAA7OCg9N1HrNw6p/hMThXcs6Zc+iEFz3fMXVWXqAs+GhegIBm3ppTATPlO9tAtv7HoW7BK4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=cmlRbgqta//TV+AJodyyg9apDpkXslMZYzksUAS5zcQ=;
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


On 2025/7/12 06:44, Jonas Karlman wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
> The ArmSoM Sige5 board exposes PCIe controller 0 on its M.2 slot on the
> bottom of the board. Enable the necessary nodes for it, and also add the
> correct pins for both the power enable GPIO and the PCIe reset GPIO.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Link: https://lore.kernel.org/r/20250414-rk3576-sige5-pcie-v1-1-0e950a96f392@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 34b69113ab975e8718b24b9b2cd4b1ea8dc107d8 ]
>
> (cherry picked from commit c88c9d3b42f790289d95ecfa73d196e641de30bd)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   .../arm64/rockchip/rk3576-armsom-sige5.dts    | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts b/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts
> index 314067ba6f3c..570252c4c0bf 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts
> @@ -117,6 +117,8 @@
>   
>   	vcc_3v3_pcie: regulator-vcc-3v3-pcie {
>   		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_pwr_en>;
>   		regulator-name = "vcc_3v3_pcie";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
> @@ -177,6 +179,10 @@
>   	};
>   };
>   
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
>   &cpu_l0 {
>   	cpu-supply = <&vdd_cpu_lit_s0>;
>   };
> @@ -634,6 +640,14 @@
>   	};
>   };
>   
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_reset>;
> +	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc_3v3_pcie>;
> +	status = "okay";
> +};
> +
>   &pinctrl {
>   	headphone {
>   		hp_det: hp-det {
> @@ -655,6 +669,15 @@
>   			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
> +
> +	pcie {
> +		pcie_pwr_en: pcie-pwr-en {
> +			rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +		pcie_reset: pcie-reset {
> +			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
>   };
>   
>   &sdhci {
