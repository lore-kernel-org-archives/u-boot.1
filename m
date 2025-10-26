Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F906CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A08D283849;
	Sun, 26 Oct 2025 16:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GquaXeHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B5A838D5; Sun, 26 Oct 2025 16:44:55 +0100 (CET)
Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com
 [45.254.49.227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38517832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748fe6;
 Sun, 26 Oct 2025 23:44:49 +0800 (GMT+08:00)
Message-ID: <d232eaa1-f1fe-4197-8ac6-406541b080bd@rock-chips.com>
Date: Sun, 26 Oct 2025 23:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] rockchip: odroid-go2: Include pinctrl for sdmmc, 
 sfc and uart in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2131964d03afkunm20e9b28c4d3013
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0lPVkNMQk4ZGhlDHh9MTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=GquaXeHLN81u7nUAZ8SVq93Nw/rpK/Dq1DRA4jZOkgRcnPTxJYxYK+rtmXnpGTCLEQcTH2Wvhln1HnHimf+KZbBj1LmUE6L9QqXgTBIXUghqEr681jCBCz28gaQyAycZapZVYI0bfCbSTwDbK73LX9nXBNciVTgt3sFQRb2OsJo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=jfJ/ZTh36oDlyaC7c3Ezk6vqUMec2Ptd+cT2XntImK4=;
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


On 2025/9/1 00:49, Jonas Karlman wrote:
> Include pinctrl nodes and props for sdmmc, sfc and uart in SPL to ensure
> pins are configured according to the device tree.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ++++
>   arch/arm/dts/rk3326-u-boot.dtsi            | 58 ++++++++++++++++++++++
>   configs/odroid-go2_defconfig               |  2 +-
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

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

