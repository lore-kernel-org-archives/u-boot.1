Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E635F417EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231DB83A8C;
	Mon,  9 Mar 2026 15:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="anhZ5+tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361ED83F59; Mon,  9 Mar 2026 15:46:34 +0100 (CET)
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com
 [220.197.31.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB63483952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36471864f;
 Mon, 9 Mar 2026 22:46:28 +0800 (GMT+08:00)
Message-ID: <f788bf9e-9cd3-46a4-acb0-bf269ac57aa8@rock-chips.com>
Date: Mon, 9 Mar 2026 22:46:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rockchip: rk3588s-rock-5c: Add support for ROCK 5C
 Lite variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260107230747.3552391-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd31052f603afkunm480c9a7e16bd5e5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQksZVkxNHh5PHx0YTRgeT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=anhZ5+txbpUDAJB9PD+0cF1QtqoohTWDuZ6cThn/fGAmLCeKWB9CZIUb3GxGhGpPCVVgYwkEaH8uRUbP2dt4Xq2swQ/MRFneCmlzfr3n0gqc7iMNOe07G9heSbbtL7KMe1VWZsSRpmzd3Y8QeujwxLBFAhliRAWivJFFVw8SRtw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=BsKGvlnB6D/IYV4mwcubPnxVlE1p28yUw9Ga8x/shfU=;
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
> Add Kconfig option OF_SYSTEM_SETUP=y to support booting ROCK 5C Lite
> boards with a RK3582 SoC. CPU and GPU cores are failed based on ip-state
> and policy.
>
> Tested on a ROCK 5C Lite v1.1:
>
>    cpu-code: 35 82
>    ip-state: 00 80 00 (otp)
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
> v2: New patch
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 9 +++++----
>   configs/rock-5c-rk3588s_defconfig     | 1 +
>   doc/board/rockchip/rockchip.rst       | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 60c16d2f32d2..675f13ab66d7 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -286,14 +286,15 @@ config TARGET_ROCK_5_ITX_RK3588
>   	  Powered by either 12V, ATX power-supply or PoE
>   
>   config TARGET_ROCK_5C_RK3588S
> -	bool "Radxa ROCK 5C RK3588S2 board"
> +	bool "Radxa ROCK 5C/5C Lite"
>   	help
> -	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> +	  Radxa ROCK 5C/5C Lite is a Rockchip RK3588S2/RK3582 based SBC (Single
> +	  Board Computer) by Radxa.
>   
>   	  Specification:
>   
> -	  Quad A76 and Quad A55 CPU
> -	  6 TOPS NPU
> +	  Quad/Dual A76 and Quad A55 CPU
> +	  6/5 TOPS NPU
>   	  up to 32GB LPDDR4x RAM
>   	  eMMC / SPI flash connector
>   	  Micro SD Card slot
> diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
> index 2748fb488c2d..f83d3f6d6c92 100644
> --- a/configs/rock-5c-rk3588s_defconfig
> +++ b/configs/rock-5c-rk3588s_defconfig
> @@ -18,6 +18,7 @@ CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5c.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x40000
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 886df1c39cbc..7a8532b49fc5 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -163,7 +163,7 @@ List of mainline supported Rockchip boards:
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)
> -     - Radxa ROCK 5C (rock-5c-rk3588s)
> +     - Radxa ROCK 5C/5C Lite (rock-5c-rk3588s)
>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>        - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
>        - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
