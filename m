Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49E9E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 07:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0F3800C2;
	Fri, 10 Jan 2025 08:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GyMMeEHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EC3801F5; Fri, 10 Jan 2025 08:05:07 +0100 (CET)
Received: from mail-m12749.qiye.163.com (mail-m12749.qiye.163.com
 [115.236.127.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9202C80027
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 84ff7ee6;
 Fri, 10 Jan 2025 15:04:58 +0800 (GMT+08:00)
Message-ID: <bf9657cd-0310-4f8c-9705-522274da7440@rock-chips.com>
Date: Fri, 10 Jan 2025 15:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw
 revision
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241203214711.1011176-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241203214711.1011176-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUpOVh9DQ00ZTh5OGEwfS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a944f07cc7503afkunm84ff7ee6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46ASo4HTIOLQ8*EQ9CNQwX
 PilPChBVSlVKTEhNT0JJTEtLSktDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhPSEw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=GyMMeEHpClVg7+5Ek/6ehaVZb0+lvIGInzl1sS9xJj+KobsdQcE6L7S2JeZToolouj6IB74adyEOEinkzEimANWxIG49+fYX4tRM/DBNfFC8iBbaLeE+UVTiULWyWjCnSEiToA2XDrS6dNU8rdq/BANoPLDbn2MccxBUdcNmmwI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=UtALmKP5x8M8/dSSdn0oGJl72SapB+RWrXCeGSx7XZk=;
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

Hi Jonas,

     This patch can not be applied due to conflict, please help to 
rebase and resend the patch.


Thanks,

- Kever

On 2024/12/4 05:47, Jonas Karlman wrote:
> BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MMC
> driver set PWREN high in dwmci_init().
>
> However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
> sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.
>
> Upstream linux-rockchip maintainer tree has merged a patch "arm64: dts:
> rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards" for v6.14 to
> fix this issue.
>
> Add the upstream vmmc-supply regulator in board u-boot.dtsi and enable
> required Kconfig options to set GPIO4_D6 low to fix reading sdmmc on
> v1.1 hw revision.
>
> The regulator-3v3-vcc-sd and sdmmc-2030 nodes along with the vmmc-supply
> prop can be dropped once dts/upstream sync v6.14 DTs.
>
> Fixes: 25438c40a007 ("board: rockchip: Add Radxa ROCK S0")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3308-rock-s0-u-boot.dtsi | 43 +++++++++++++++++++++++++
>   configs/rock-s0-rk3308_defconfig        |  2 ++
>   2 files changed, 45 insertions(+)
>
> diff --git a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
> index dd4cb8660b8d..3b849280c4ad 100644
> --- a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
> @@ -2,11 +2,50 @@
>   
>   #include "rk3308-u-boot.dtsi"
>   
> +/ {
> +	/*
> +	 * HW revision prior to v1.2 must pull GPIO4_D6 low to access sdmmc.
> +	 * This is modeled as an always-on active low fixed regulator.
> +	 */
> +	vcc_sd: regulator-3v3-vcc-sd {
> +		compatible = "regulator-fixed";
> +		gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_2030>;
> +		regulator-name = "vcc_sd";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_io>;
> +	};
> +};
> +
>   &emmc_pwren {
>   	bootph-pre-ram;
>   	bootph-some-ram;
>   };
>   
> +&gpio4 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl {
> +	sdmmc {
> +		sdmmc_2030: sdmmc-2030 {
> +			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc {
> +	vmmc-supply = <&vcc_sd>;
> +};
> +
> +&sdmmc_2030 {
> +	bootph-pre-ram;
> +};
> +
>   &uart0 {
>   	bootph-all;
>   	clock-frequency = <24000000>;
> @@ -17,6 +56,10 @@
>   	bootph-pre-ram;
>   };
>   
> +&vcc_sd {
> +	bootph-pre-ram;
> +};
> +
>   &vdd_core {
>   	regulator-init-microvolt = <1015000>;
>   };
> diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
> index 0a46e7bb1871..063e0b921d73 100644
> --- a/configs/rock-s0-rk3308_defconfig
> +++ b/configs/rock-s0-rk3308_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-s0"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
> @@ -53,6 +54,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PINCTRL=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM=y
>   CONFIG_BAUDRATE=1500000
