Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD67F417EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A8A83F14;
	Mon,  9 Mar 2026 15:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SPglFmkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95D083F20; Mon,  9 Mar 2026 15:46:22 +0100 (CET)
Received: from mail-m158244.netease.com (mail-m158244.netease.com
 [47.251.158.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B05483952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36471863f;
 Mon, 9 Mar 2026 22:46:14 +0800 (GMT+08:00)
Message-ID: <5496127a-2bb2-4c6d-b91b-e6cbcb148319@rock-chips.com>
Date: Mon, 9 Mar 2026 22:46:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] rockchip: rk3588-generic: Enable support for RK3582
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260107230747.3552391-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd3101df403afkunm85ac39b916bd56a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEtKVh0YSEhIQ08ZQk1DQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=SPglFmkbexepUGlK2xdowkCSWFCRioo4YjEdw82gmxj5k4SVxwBX7RayWSDDTp6ispbjBLwX3hKjiLzHG6wA3gq/IsdLYar0wpksa/PyrOlgj/5j+e5xwHYMOg6ig6GmesyGNhI4nZpCYUx6TzfZppY7ITvOLiw4+ZbxKgR+Z3A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=U1S95rcdW0QHZwovdI/oTjP9NSATr0ix9qHVKtYckOE=;
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


On 2026/1/8 07:07, Jonas Karlman wrote:
> Add Kconfig option OF_SYSTEM_SETUP=y to support booting boards with a
> RK3582 SoC. CPU and GPU cores are failed based on ip-state and policy.
>
> Tested on a ROCK 5C Lite v1.1:
>
>    cpu-code: 35 82
>    ip-state: 10 00 00 (otp)
>    ip-state: 30 9e 04 (policy)
>    remove cpu-map cluster1
>    rename cpu-map cluster2
>    fail gpu
>    fail rkvdec1
>    fail rkvenc1
>    fail cpu cpu@400
>    fail cpu cpu@500
>
> and on a Radxa E52C:
>
>    cpu-code: 35 82
>    ip-state: 00 04 00 (otp)
>    ip-state: c0 9e 04 (policy)
>    remove cpu-map cluster2
>    fail gpu
>    fail rkvdec1
>    fail rkvenc1
>    fail cpu cpu@600
>    fail cpu cpu@700
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v4: Update commit message to reflect updated policy
> v3: Update commit message to reflect updated policy
> v2: Mention RK3582 in generic board device tree and documentation
> ---
>   arch/arm/dts/rk3588-generic.dts  | 4 ++--
>   configs/generic-rk3588_defconfig | 1 +
>   doc/board/rockchip/rockchip.rst  | 2 +-
>   3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
> index 6740f9866f17..04144e2ad128 100644
> --- a/arch/arm/dts/rk3588-generic.dts
> +++ b/arch/arm/dts/rk3588-generic.dts
> @@ -1,13 +1,13 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   /*
> - * Minimal generic DT for RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
> + * Minimal generic DT for RK3582/RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
>    */
>   
>   /dts-v1/;
>   #include "rk3588s.dtsi"
>   
>   / {
> -	model = "Generic RK3588S/RK3588";
> +	model = "Generic RK3582/RK3588S/RK3588";
>   	compatible = "rockchip,rk3588";
>   
>   	aliases {
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index dfa8efabe6be..7a8c176912e1 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -16,6 +16,7 @@ CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   # CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x40000
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 6ae4d4371ff6..886df1c39cbc 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -154,7 +154,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
>        - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
>        - GameForce Ace (gameforce-ace-rk3588s)
> -     - Generic RK3588S/RK3588 (generic-rk3588)
> +     - Generic RK3582/RK3588S/RK3588 (generic-rk3588)
>        - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>        - Indiedroid Nova (nova-rk3588s)
>        - Khadas Edge2 (khadas-edge2-rk3588s)
