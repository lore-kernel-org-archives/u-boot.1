Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEA4D44D46
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5262891F1;
	Wed,  6 Nov 2024 11:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AvXl7UMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1428891F4; Wed,  6 Nov 2024 11:47:03 +0100 (CET)
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com
 [101.71.155.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E0F88D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8a3d44;
 Wed, 6 Nov 2024 18:46:53 +0800 (GMT+08:00)
Message-ID: <67bd57bd-717a-4647-9d49-3c3478eeb613@rock-chips.com>
Date: Wed, 6 Nov 2024 18:46:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] rockchip: rk3288-miqi: Change to use FIT
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJJSVZDSEodTRoaSkJMQx1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9301159d1c03afkunm1f8a3d44
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6FRw4MTIoKDEcCEouHAoK
 SgEwFFZVSlVKTEhLQ0JLS0pPTEpIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSE9JNwY+
DKIM-Signature: a=rsa-sha256;
 b=AvXl7UMm56a2gxb+T3+uhBKwBt+xAuMsrFkh446hvqsmWS+7GrYnl2Rwj4jxlSAB89SudsLflN3/cJjlUMWQbC2UYVXCtrbxUd4NxuzUFsHuk07rNec0hdDofqwsIGyd+IoHpxJLDujeiiHUqupipRhIeKpan7/BEYezk/v8qXc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=qSNKdKjKWifjh9fdTcckCK4gTAgrz7gKkR/zLdua9iI=;
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
> Change to use FIT and FIT_SIGNATURE when loading U-Boot proper in SPL to
> allow checksum validation and fallback loading of FIT from a different
> mmc device.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/miqi-rk3288_defconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index 55e8d30f675f..166468fd4e72 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -17,9 +17,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-miqi.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -89,4 +95,5 @@ CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>   CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_CMD_DHRYSTONE=y
> +CONFIG_SPL_CRC32=y
>   CONFIG_ERRNO_STR=y
