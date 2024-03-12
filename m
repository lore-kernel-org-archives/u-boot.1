Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C17C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 03:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3840D87F3F;
	Tue, 12 Mar 2024 04:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bXcx9OEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC62987F16; Tue, 12 Mar 2024 04:50:23 +0100 (CET)
Received: from mail-m6015.netease.com (mail-m6015.netease.com [210.79.60.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB8A87CF2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 04:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=bXcx9OEtbsCrTfCdFWtEMjn/XHY6Ad2kVU3/X+H65zVb74zPNPNj+4nF88areTZeovL3jz0/wsDh8gfM9p0Dd0+XmfJt830Hc1DeWRdej6h7DrbpCMmT9hNV/Wy3OANttxaeELqqarEEtHufffyR/WdW4QysuqHeTV2g2UJMf9M=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=fVAiIWb87WXe0RWhffDnbN+E4zQAbbmuIjfvCFQoZHw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9471B90010C;
 Tue, 12 Mar 2024 11:50:09 +0800 (CST)
Message-ID: <971a4a1c-a7b9-4301-9c13-8bd1a4b78184@rock-chips.com>
Date: Tue, 12 Mar 2024 11:50:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/16] rockchip: jaguar-rk3588: enable SARADC and
 derivatives
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-13-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-13-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpDQlZCTUwfT0tKTEtNTxhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e30c833bf03a9kunm9471b90010c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06HRw5LzMJSzYKSTQ4Dw0h
 DQJPFAJVSlVKTEpLSUpOT0pKSE9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ01MNwY+
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


On 2024/3/4 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The SARADC is used on Jaguar for multiple things:
> - channel 0 is used (at runtime) as a BIOS button,
> - channel 2 is exposed on the Mezzanine connector for customer specific
>    logic,
> - channel 5 and 6 are used for identification,
>
> Since the SARADC requires a vref-supply provided by the RK806 PMIC, its
> support and the support for its regulators are also enabled.
>
> The button, adc, pmic and regulator commands are also enabled for CLI
> use in U-Boot for debugging and scripting purposes.
>
> The RK806 PMIC on Jaguar being routed on the SPI bus, let's enable
> Rockchip SPI controller driver.
>
> Finally, the SARADC channel 1 on Jaguar is hardwired so will never
> change in the lifetime of a unit, for that reason, disable the Rockchip
> Download Mode check by setting ROCKCHIP_BOOT_MODE_REG symbol to 0.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/jaguar-rk3588_defconfig | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
> index f55bfb1c82b..275d70ae008 100644
> --- a/configs/jaguar-rk3588_defconfig
> +++ b/configs/jaguar-rk3588_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ENV_SIZE=0x1f000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-jaguar"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
>   CONFIG_SPL_SERIAL=y
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_JAGUAR_RK3588=y
> @@ -47,6 +48,7 @@ CONFIG_SPL_ATF=y
>   # CONFIG_BOOTM_RTEMS is not set
>   # CONFIG_BOOTM_VXWORKS is not set
>   # CONFIG_CMD_ELF is not set
> +CONFIG_CMD_ADC=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -59,6 +61,7 @@ CONFIG_CMD_USB=y
>   # CONFIG_CMD_MII is not set
>   # CONFIG_CMD_BLOCK_CACHE is not set
>   # CONFIG_CMD_EFICONFIG is not set
> +CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_EROFS=y
>   CONFIG_CMD_SQUASHFS=y
> @@ -73,7 +76,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> -# CONFIG_SARADC_ROCKCHIP is not set
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
>   CONFIG_SPL_CLK=y
>   CONFIG_CLK_GPIO=y
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -101,10 +105,14 @@ CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
>   CONFIG_SPL_RAM=y
>   CONFIG_SCSI=y
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
>
