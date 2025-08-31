Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB334CA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 08:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D952483487;
	Sun, 31 Aug 2025 10:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hubHu3rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DE8838AA; Sun, 31 Aug 2025 10:46:45 +0200 (CEST)
Received: from mail-m81108.xmail.ntesmail.com (mail-m81108.xmail.ntesmail.com
 [156.224.81.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C21833E9
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 10:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 212c38954;
 Sun, 31 Aug 2025 16:46:35 +0800 (GMT+08:00)
Message-ID: <16931794-9556-476d-9143-f396e4e7c678@rock-chips.com>
Date: Sun, 31 Aug 2025 16:46:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] rockchip: odroid-go2: Include pinctrl for sdmmc,
 sfc and uart in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250713233429.1376172-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98ff4e8eba03afkunmf1183d8255db46
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh8dVk1LGR9OShlDQ09JQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=hubHu3rkeFy4RDJZq1v/qCtEFEr1lJl61AaGJemBq3HGI9+q5nJ/XicCS8sNnT8BDzHjnebGIbdrnoJKOLRcFb72u+7ErLTo8peY3Rb+wL8ZtbKSzfjRM7DXJWubovS8auSI70x/ip0TNcKpuxFFSeu4FFOJacdDPAfjtvCe4so=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=maan5010nEo9ERGoix5KbrlxG5d0ZU0QXJd9KzIqYwE=;
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

On 2025/7/14 07:33, Jonas Karlman wrote:
> Include pinctrl nodes and props for sdmmc, sfc and uart in SPL to ensure
> pins are configured according to the device tree.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ++++
>   arch/arm/dts/rk3326-u-boot.dtsi            | 58 ++++++++++++++++++++++
>   configs/odroid-go2_defconfig               |  2 +-


In this Series, you update the dtsi and defconfig.

For board level dtsi update with the board defconfig, it's OK to go 
together for me,

but for soc level dtsi, it would be better not go with defconfig because 
it may affect other boards.

You can update dtsi first, and then update/cleanup the board level 
defconfig with correct commit message.


Thanks,

- Kever

>   3 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> index 06e2c190b1f9..6f40654d5e84 100644
> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> @@ -35,3 +35,13 @@
>   	bootph-all;
>   	clock-frequency = <24000000>;
>   };
> +
> +&uart1_cts {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> +
> +&uart1_xfer {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
> index 2894133cfe6d..196604a9987c 100644
> --- a/arch/arm/dts/rk3326-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-u-boot.dtsi
> @@ -46,6 +46,24 @@
>   	bootph-all;
>   };
>   
> +&pcfg_pull_none {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_none_8ma {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pcfg_pull_up {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up_8ma {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &pmucru {
>   	bootph-all;
>   };
> @@ -62,15 +80,55 @@
>   	u-boot,spl-fifo-mode;
>   };
>   
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
>   &sfc {
>   	bootph-some-ram;
>   };
>   
> +&sfc_bus2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sfc_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sfc_cs0 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &uart2 {
>   	bootph-all;
>   	clock-frequency = <24000000>;
>   };
>   
> +&uart2m1_xfer {
> +	bootph-pre-sram;
> +	bootph-pre-ram;
> +};
> +
>   &xin24m {
>   	bootph-all;
>   };
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 6bc0d12440c9..b0947fe2c8b2 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -51,7 +51,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
