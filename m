Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C559EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B847885A4;
	Tue, 23 Apr 2024 13:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NvIFjlgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43DC8854A; Tue, 23 Apr 2024 13:02:46 +0200 (CEST)
Received: from mail-m32109.qiye.163.com (mail-m32109.qiye.163.com
 [220.197.32.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CFC885A2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NvIFjlgIBIhJgMcfWkNZfPir2kdAFWNMwkFDNCxzpqtEkkbj9WSaDBLCxaw8Ht7cmZynM7iP2bTgSp6yzB6LRJ2j4aT+QaK7bfw9QguoaT8BUben5EfDoYF+C2Vy1YXeg27wdQYNQq2u8D7fQj7vDAKY5Sj/xMYrUXXsoMg/8eU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=xp01f+ZmfaI/H4KV51PodVNDLsM/60I1dE/5Xalx8JE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DAA6F90034E;
 Tue, 23 Apr 2024 19:02:27 +0800 (CST)
Message-ID: <45d5b004-de1d-4cfa-a412-3b796255a10e@rock-chips.com>
Date: Tue, 23 Apr 2024 19:02:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/31] rockchip: rk3399: Add a default spl-boot-order prop
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Peter Robinson <pbrobinson@gmail.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4YSVYYTEtCGkkfTR9JTR9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0a9f148403a9kunmdaa6f90034e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6Gio4PTNMNj02OUgTGTwC
 OAswCzhVSlVKTEpIQ0xLSk9CSkxLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0JJTjcG
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> A lot of RK3399 boards use a u-boot,spl-boot-order of "same-as-spl",
> &sdhci and &sdmmc.
>
> Move this to rk3399-u-boot.dtsi and make this default for boards
> currently missing a u-boot,spl-boot-order prop.
>
> The &spi_flash reference has been dropped from spl-boot-order now that
> boot source id is cached and "same-as-spl" can be resolved into the SPI
> flash node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi      | 1 -
>   arch/arm/dts/rk3399-evb-u-boot.dtsi            | 1 -
>   arch/arm/dts/rk3399-ficus-u-boot.dtsi          | 6 ------
>   arch/arm/dts/rk3399-firefly-u-boot.dtsi        | 6 ------
>   arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi    | 6 ------
>   arch/arm/dts/rk3399-leez-p710-u-boot.dtsi      | 6 ------
>   arch/arm/dts/rk3399-nanopi4-u-boot.dtsi        | 6 ------
>   arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi   | 6 ------
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi  | 6 ------
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi         | 4 ----
>   arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi      | 6 ------
>   arch/arm/dts/rk3399-rock960-u-boot.dtsi        | 5 -----
>   arch/arm/dts/rk3399-rockpro64-u-boot.dtsi      | 5 +----
>   arch/arm/dts/rk3399-u-boot.dtsi                | 4 ++++
>   arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi | 6 ------
>   15 files changed, 5 insertions(+), 69 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi b/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> index a3f27566e438..6c07de98fa01 100644
> --- a/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> @@ -9,7 +9,6 @@
>   / {
>   	chosen {
>   		stdout-path = "serial2:1500000n8";
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> index dfce63e4d428..796ac9642399 100644
> --- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> @@ -9,7 +9,6 @@
>   / {
>   	chosen {
>   		stdout-path = "serial2:1500000n8";
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3399-ficus-u-boot.dtsi b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> index 38e0897db91d..67b63a835238 100644
> --- a/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> @@ -5,9 +5,3 @@
>   
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-ddr3-1600.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-firefly-u-boot.dtsi b/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> index c58ad95d120a..1f5fda1d0f1d 100644
> --- a/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-ddr3-1600.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>   &vdd_log {
>   	regulator-init-microvolt = <950000>;
>   };
> diff --git a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> index a7039d74a016..4a3b23e48313 100644
> --- a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>   &vdd_log {
>   	regulator-init-microvolt = <950000>;
>   };
> diff --git a/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi b/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> index c638ce259731..03b596850635 100644
> --- a/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>   &vdd_log {
>   	regulator-init-microvolt = <950000>;
>   };
> diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> index a9d10592d573..a126bbaf086f 100644
> --- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> @@ -5,12 +5,6 @@
>   
>   #include "rk3399-u-boot.dtsi"
>   
> -/{
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>   &sdmmc {
>   	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
>   };
> diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> index 88a77cad8d43..83b0c44e9ec5 100644
> --- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &spiflash, &sdmmc;
> -	};
> -};
> -
>   &edp {
>   	rockchip,panel = <&edp_panel>;
>   };
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index cabf0a9dae89..e29757590611 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>   &rng {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index c8f4418a7389..e390cf3abab5 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -7,10 +7,6 @@
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
>   / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdhci, &sdmmc;
> -	};
> -
>   	vcc_hub_en: vcc_hub_en-regulator {
>   		compatible = "regulator-fixed";
>   		enable-active-high;
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> index 60122f3bcd6c..b3bfc77f7569 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3399-rock960-u-boot.dtsi b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> index c190089e2643..55716ba4df73 100644
> --- a/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> @@ -7,10 +7,6 @@
>   #include "rk3399-sdram-lpddr3-2GB-1600.dtsi"
>   
>   / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -
>   	vdd_log: vdd-log {
>   		compatible = "pwm-regulator";
>   		pwms = <&pwm2 0 25000 1>;
> @@ -22,5 +18,4 @@
>   		regulator-init-microvolt = <950000>;
>   		vin-supply = <&vcc5v0_sys>;
>   	};
> -
>   };
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index 089732524a76..b15e5392c3cf 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -5,11 +5,8 @@
>   
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
> +
>   / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
> -	};
> -
>           smbios {
>                   compatible = "u-boot,sysinfo-smbios";
>                   smbios {
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 87b173e59579..fe045ca81749 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -14,6 +14,10 @@
>   		spi1 = &spi1;
>   	};
>   
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> +	};
> +
>   	cic: syscon@ff620000 {
>   		bootph-all;
>   		compatible = "rockchip,rk3399-cic", "syscon";
> diff --git a/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi b/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> index 7c66e1145a50..946a0230dbb4 100644
> --- a/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> @@ -5,9 +5,3 @@
>   
>   #include "rk3399pro-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr3-4GB-1600.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
