Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F04CD44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B379F88E63;
	Wed,  6 Nov 2024 11:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PMtEMvsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BC689032; Wed,  6 Nov 2024 11:41:34 +0100 (CET)
Received: from mail-m3280.qiye.163.com (mail-m3280.qiye.163.com
 [220.197.32.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF7788D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f884154;
 Wed, 6 Nov 2024 18:41:27 +0800 (GMT+08:00)
Message-ID: <e5ac0843-f55c-48bd-9a98-b57f89b9d4a6@rock-chips.com>
Date: Wed, 6 Nov 2024 18:41:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] rockchip: rk3288-miqi: Set ethaddr env based on
 cpuid
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpPH1YaT0lPQh1CHUJKSBpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a930110a19d03afkunm1f884154
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Fww4SzIsHjEZTR0tDzYN
 Ck9PCVZVSlVKTEhLQ0NCTUNDTkpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTktMNwY+
DKIM-Signature: a=rsa-sha256;
 b=PMtEMvsbuZQsXbh4vAEagFE5HOINHO0QMXWK9y3C5F80UXOelkj1YTFa2N4+inlFmYQDsw8gnD3Bq8l+r9HXkfvk2Npv8rRUefjcnYPl5+jrHwb7Ako6mNq8hNwAJkyjp5Y7qxNIVpty3hrlK90YTSbxwjoQIRD+4SWoLiFRe/s=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=OtDz9rsHWLl7KeiZqTErY5GnvDhWiiIs7Bbxamw3b5k=;
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


On 2024/11/6 05:51, Jonas Karlman wrote:
> Enable Kconfig options to read cpuid from efuse and set cpuid#, serial#
> and ethaddr env vars based on the value read from efuse.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/miqi-rk3288_defconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index 5595352f03aa..764b4351e94c 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -27,6 +27,7 @@ CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-miqi.dtb"
> +CONFIG_MISC_INIT_R=y
>   CONFIG_SILENT_CONSOLE=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> @@ -50,7 +51,6 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
> @@ -61,6 +61,8 @@ CONFIG_SPL_CLK=y
>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_ETH_DESIGNWARE=y
