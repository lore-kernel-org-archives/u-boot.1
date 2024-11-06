Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E0BD44D43
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4267D891E9;
	Wed,  6 Nov 2024 11:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="U10bV8DZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A860891F1; Wed,  6 Nov 2024 11:23:13 +0100 (CET)
Received: from ec2-44-216-146-172.compute-1.amazonaws.com
 (ec2-44-216-146-172.compute-1.amazonaws.com [44.216.146.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC35888FE5
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f81e331;
 Wed, 6 Nov 2024 18:23:06 +0800 (GMT+08:00)
Message-ID: <2cb7a3fb-adca-4249-ada8-699d7afeae92@rock-chips.com>
Date: Wed, 6 Nov 2024 18:23:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] rockchip: rk3288-tinker: Change to use FIT
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlMQlYZQhlLHx8fGB1IQ05WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300ffd3d703afkunm1f81e331
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6Pgw6ETItKDE#Nw4PTE4d
 SS8wCVZVSlVKTEhLQ0NDTkNMSEJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISE9KNwY+
DKIM-Signature: a=rsa-sha256;
 b=U10bV8DZd8rnx375UbHOKcJ9WP+WwJoItq1u/Er0KbllAyqTeXKilbMMISvRECuE3t3O8ROEKM6u4VdWWDSYzWh2oUQ1qK8xjI+51WxTA3IUDniFe7xoPZOnnLhIsLeUFvFVRkkRZk57bYs4P3chYDtiZCEv8iPspGOiK+AmHfA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nc/xo9mLQJAQHN1OEjovrVf7C0zDnlKHlRiv/kmA2mk=;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> Change to use FIT and FIT_SIGNATURE when loading U-Boot proper in SPL to
> allow checksum validation and fallback loading of FIT from a different
> mmc device.
>
> Checksum validation of FIT adds around 140 ms to boot time:
>
> Before:
>
>         Mark    Elapsed  Stage
>            0          0  reset
>           13         13  TPL
>        6,957      6,944  end tpl
>       25,102     18,145  SPL
>      131,932    106,830  end phase
>      132,137        205  board_init_f
>      444,277    312,140  board_init_r
>    1,404,987    960,710  eth_common_init
>    1,519,110    114,123  eth_initialize
>    1,524,734      5,624  main_loop
>    1,525,452        718  cli_loop
>
> After:
>
>         Mark    Elapsed  Stage
>            0          0  reset
>           13         13  TPL
>        6,957      6,944  end tpl
>       35,744     28,787  SPL
>      271,220    235,476  end phase
>      271,420        200  board_init_f
>      588,474    317,054  board_init_r
>    1,548,950    960,476  eth_common_init
>    1,663,105    114,155  eth_initialize
>    1,668,734      5,629  main_loop
>    1,669,417        683  cli_loop
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/tinker-rk3288_defconfig   | 7 +++++++
>   configs/tinker-s-rk3288_defconfig | 7 +++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index 05dca105d609..bc5379d43430 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -17,9 +17,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -91,4 +97,5 @@ CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>   CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_CMD_DHRYSTONE=y
> +CONFIG_SPL_CRC32=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index 1bee0d094c8d..f0c8cc5bbc1b 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -17,9 +17,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker-s.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -91,4 +97,5 @@ CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>   CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_CMD_DHRYSTONE=y
> +CONFIG_SPL_CRC32=y
>   CONFIG_ERRNO_STR=y
