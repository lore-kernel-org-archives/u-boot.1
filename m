Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3FCCCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DB983849;
	Sun, 26 Oct 2025 16:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Tg+UzKMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70198390D; Sun, 26 Oct 2025 16:46:10 +0100 (CET)
Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com
 [117.135.214.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B1C832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273749038;
 Sun, 26 Oct 2025 23:46:03 +0800 (GMT+08:00)
Message-ID: <545ab504-f958-41fd-aa1e-7b9419eef520@rock-chips.com>
Date: Sun, 26 Oct 2025 23:46:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] rockchip: odroid-go2: Enable RockUSB, button,
 LED and RNG support
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-15-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2132b87103afkunm6eac2de04d34a5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx8ZVk4dSU1IQhgfTRpJQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Tg+UzKMwG7rmEEueYfpay/wDtYrIv9TMQeUt4MLameYbfRr6T0ciXqnl3Fm+/L2qq68l6n8HMPQFdcOCWjz/8Sfa+v2sK02M735bjCsxYEQqxZelKcTjIZiAPZzNsI4pEkwrs+ZY5BQwq6NNVkl+01W1vvtQoVsTWA5JNlLx+Cw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XN5RjLJ7f/C429P9M2tGV7CT480HISidkn9WK/7xmDo=;
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
> Enable Kconfig options to support RockUSB, buttons, LEDs and RNG
> featured on the board or SoC.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   configs/odroid-go2_defconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 185d0f1d7c5f..70d74c65a2f3 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -54,6 +54,7 @@ CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_ITEST is not set
>   # CONFIG_CMD_SLEEP is not set
> @@ -72,12 +73,17 @@ CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
>   CONFIG_SPL_SYSCON=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
>   CONFIG_FASTBOOT_BUF_ADDR=0x800800
>   CONFIG_FASTBOOT_BUF_SIZE=0x04000000
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_PWM=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_ROCKCHIP_OTP=y
>   CONFIG_MMC_DW=y
> @@ -97,6 +103,8 @@ CONFIG_RAM=y
>   CONFIG_SPL_RAM=y
>   CONFIG_TPL_RAM=y
>   CONFIG_ROCKCHIP_SDRAM_COMMON=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
>   # CONFIG_SPECIFY_CONSOLE_INDEX is not set
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> @@ -109,6 +117,7 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_LZO=y
>   CONFIG_ERRNO_STR=y

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

