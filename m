Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44D7C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E253886E5;
	Wed, 17 Jul 2024 10:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="k3MWQGv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FD7886E5; Wed, 17 Jul 2024 10:25:41 +0200 (CEST)
Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com
 [45.254.49.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA279885E7
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=k3MWQGv4wkqby1UG+EOlWH14I7nqHTnQ+CcDzfDpexKaXXM+mMpJidwaXZ9eLr93dXxs8/xWrRQaQpinLMlCeu2Ggj1wVQPbGAlRsu8Yui6DkhX78X4wKIKWmU8vBgtNrquC4kTAB2JSNw6weWYkha+FjjhDxzljGmJ34onfLFE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=yWgGMWS3T+3lDV3irJE75I0DbZCiFgfqEyQ094AN4Ao=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 77CBA9006F3;
 Wed, 17 Jul 2024 16:25:21 +0800 (CST)
Message-ID: <ef198f74-36b6-4736-9259-fcab39917a9a@rock-chips.com>
Date: Wed, 17 Jul 2024 16:25:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] configs: rockchip: imply OF_LIBFDT_OVERLAY for
 rk3308 and rk3328
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, andy.yan@rock-chips.com,
 gajjar04akash@gmail.com, jonas@kwiboo.se
References: <20240717044726.59721-1-naoki@radxa.com>
 <20240717044726.59721-3-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240717044726.59721-3-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxMQlZJQ0keGEpCGk5JGEhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bfcbc8b103a9kunm77cba9006f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBQ6HRw6LDI5KhI2T01REVYf
 MSowCTBVSlVKTElKSUtPTElJSUNLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSk1KNwY+
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


On 2024/7/17 12:47, FUKAUMI Naoki wrote:
> for rk3308, all defconfigs have CONFIG_OF_LIBFDT_OVERLAY=y, so enable it
> by default.
>
> for rk3328, any defconfig doesn't have it. but there is no strong reason
> not to enable it. at least it's required for ROCK Pi E.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v3:
> - add missing separator in commit message
> Changes in v2:
> - none
> ---
>   arch/arm/mach-rockchip/Kconfig     | 2 ++
>   configs/evb-rk3308_defconfig       | 1 -
>   configs/roc-cc-rk3308_defconfig    | 1 -
>   configs/rock-pi-s-rk3308_defconfig | 1 -
>   4 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 661e7fd1c9..5f6a4dd24a 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -166,6 +166,7 @@ config ROCKCHIP_RK3308
>   	imply LEGACY_IMAGE_FORMAT
>   	imply MISC
>   	imply MISC_INIT_R
> +	imply OF_LIBFDT_OVERLAY
>   	imply OF_UPSTREAM
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
> @@ -196,6 +197,7 @@ config ROCKCHIP_RK3328
>   	imply ARMV8_SET_SMPEN
>   	imply MISC
>   	imply MISC_INIT_R
> +	imply OF_LIBFDT_OVERLAY
>   	imply OF_LIVE
>   	imply OF_UPSTREAM
>   	imply PRE_CONSOLE_BUFFER
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index f4c2ea12ad..6d090dba30 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-evb"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_TARGET_EVB_RK3308=y
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> index 862ea4301f..b1b59d9cb5 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-roc-cc"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_TARGET_ROC_RK3308_CC=y
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index c15ba3d8a4..e450a06180 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-pi-s"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_TARGET_EVB_RK3308=y
