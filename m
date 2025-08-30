Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03908CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326CC83887;
	Sat, 30 Aug 2025 17:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ck/4GyDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8407B8386F; Sat, 30 Aug 2025 17:14:23 +0200 (CEST)
Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com
 [220.197.31.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEFAD838A5
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4f23;
 Sat, 30 Aug 2025 23:14:15 +0800 (GMT+08:00)
Message-ID: <4d7fe0ba-85ab-49ed-94c6-ca5a5dd17020@rock-chips.com>
Date: Sat, 30 Aug 2025 23:14:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] rockchip: odroid-go2: Remove unsupported Kconfig
 options
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250713233429.1376172-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb8b1dee03afkunmced0cf0a41256b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ09JVh0eTEkfGElKThkYSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=ck/4GyDBWzTBxvn47W+y5BI0kS0WviPtzhnJPCdXLBw//4DjqFGhcZYruLTwsvvT2Inl13zQu22X2KpUcD8EK+HtB9s5LA2UMFqknJPTKTGjt0MXO3s6zzxtfKgmYsNnDX9NMzPBKJKG7cuXTdnkRpOvwvsNeDWYHxoIwZpKhAo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=/bBBRsFP/G0UUepVPFw/2QPdd8bW0f5DRPWIT9crKZ4=;
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


On 2025/7/14 07:33, Jonas Karlman wrote:
> The handheld gaming devices that this defconfig tagets does not contain
> an Ethernet port, remove Ethernet related Kconfig options.
>
> They also do not contain any pwm-regulator in their DTs, remove the
> PWM regulator related Kconfig option.
>
> Display/video is not supported in U-Boot, remove all display/video
> related Kconfig options.
>
> There is no real functional change expected with these options removed.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/odroid-go2_defconfig | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 698aad59dec8..d6a63bd3a4cd 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -21,9 +21,7 @@ CONFIG_FIT_VERBOSE=y
>   CONFIG_FIT_BEST_MATCH=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3326-odroid-go2.dtb"
> -# CONFIG_CONSOLE_MUX is not set
>   # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_BOARD_LATE_INIT=y
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_MAX_SIZE=0x20000
> @@ -69,15 +67,11 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_OTP=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> -CONFIG_PHY_REALTEK=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_SPL_PMIC_RK8XX=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
> @@ -96,10 +90,7 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
> -CONFIG_VIDEO=y
> -CONFIG_DISPLAY=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_LZO=y
>   CONFIG_ERRNO_STR=y
> -CONFIG_OPTEE_LIB=y
