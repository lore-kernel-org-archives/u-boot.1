Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC08DE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3CD800D7;
	Fri,  3 Jan 2025 07:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ue7kAGVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9367080107; Fri,  3 Jan 2025 07:42:06 +0100 (CET)
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com
 [220.197.31.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042D28007D
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79772c26;
 Fri, 3 Jan 2025 14:41:58 +0800 (GMT+08:00)
Message-ID: <fcff6905-e528-4dad-9142-bc1f7f47e33a@rock-chips.com>
Date: Fri, 3 Jan 2025 14:41:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] rockchip: rk3288-firefly: Change to use FIT
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsdGFZJTEIfHUofSk5LTUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae6398c03afkunm79772c26
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6UTo*TjISCywVKh04MQ4c
 NhMaChBVSlVKTEhOQ0NNTklKSk9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSE1KNwY+
DKIM-Signature: a=rsa-sha256;
 b=Ue7kAGVGm5CtD0wIuxpEtE4dtV8vrbQPBLZxdwS+qUiREqAfHlI0klIJnF7cprSahhEstGuSyPQH9LbogcPs/10A6l26EVJAVuw+t1V2UtcwAW1KU5Hztb9v60CWnxuzMb5I6eiPcGeeyXA8hn/9HgHCkQbgxssnr0TdjdI69gA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=rvJA5XKIWCi8qMvYlWrjoiNjbyU4bQu9FMtFNJ6gNk0=;
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


On 2024/12/13 06:09, Jonas Karlman wrote:
> Change to use FIT and FIT_SIGNATURE when loading U-Boot proper in SPL to
> allow checksum validation and fallback loading of FIT from a different
> mmc device.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/firefly-rk3288_defconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index 95fb20b8b24c..d8a671b7a8a4 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -18,9 +18,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-firefly.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -92,4 +98,5 @@ CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>   CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_CMD_DHRYSTONE=y
> +CONFIG_SPL_CRC32=y
>   CONFIG_ERRNO_STR=y
