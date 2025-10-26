Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560A1CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB67838BF;
	Sun, 26 Oct 2025 16:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="V9lPzH7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585A8832AD; Sun, 26 Oct 2025 16:45:07 +0100 (CET)
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com
 [45.254.49.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9E0838CC
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748ff7;
 Sun, 26 Oct 2025 23:45:01 +0800 (GMT+08:00)
Message-ID: <32400e2d-a24e-41da-8827-21a7077cede8@rock-chips.com>
Date: Sun, 26 Oct 2025 23:45:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] rockchip: odroid-go2: Use power off at power
 plug-in event
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2131c5e803afkunm237d9f534d30c5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEJNVk5OSxgYSx9OTE5DSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=V9lPzH7hu0Iee3q4G2SNHSeTdSbTKGTXZ7Rv1P7xrnO5fBRndd0HQVuzx2/uKACYsadFEKKl4dzEZyzzjhrXSTi2oHTfpCtdtYgv5d0X9NzME7gnnoG1YfbqEjhhyA80MXjtcfWk7llJ6Y5ENBdOddkWRbLRyffreahR8TDDML0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=TZdaPlJIKyXoy61/hl8YNU3rfSQW3q0W5g4SbxfuJvY=;
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
> Include the RK817 PMIC in SPL and enable Kconfig options to power off
> the handheld gaming device when it was powered on due to a power cable
> plug-in event:
>
>    DDR3, 333MHz
>    BW=32 Col=10 Bk=8 CS0 Row=15 CS=1 Die BW=16 Size=1024MB
>    out
>    Power Off due to plug-in event
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 18 ++++++++++++++++++
>   configs/odroid-go2_defconfig               |  3 +++
>   2 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> index 6f40654d5e84..6c6efa964d80 100644
> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
> @@ -5,8 +5,26 @@
>   
>   #include "rk3326-u-boot.dtsi"
>   
> +&i2c0_xfer {
> +	bootph-pre-ram;
> +};
> +
> +&i2s1_2ch_mclk {
> +	bootph-pre-ram;
> +};
> +
> +&pcfg_pull_none_smt {
> +	bootph-pre-ram;
> +};
> +
> +&pmic_int {
> +	bootph-pre-ram;
> +};
> +
>   &rk817 {
>   	regulators {
> +		bootph-pre-ram;
> +
>   		vcc_cam: LDO_REG9 {
>   			regulator-name = "vcc_cam";
>   			regulator-min-microvolt = <3000000>;
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index b0947fe2c8b2..a6d02baa520f 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x4000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_PX30=y
> +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
>   CONFIG_TARGET_ODROID_GO2=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -42,6 +43,7 @@ CONFIG_CMD_GPT=y
>   # CONFIG_CMD_LOADB is not set
>   # CONFIG_CMD_LOADS is not set
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_ITEST is not set
> @@ -73,6 +75,7 @@ CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

