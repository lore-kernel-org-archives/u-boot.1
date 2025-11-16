Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119CCCEACEF
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 13:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F7983A3D;
	Sun, 16 Nov 2025 14:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EiAV8HlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5070B83AA7; Sun, 16 Nov 2025 14:00:08 +0100 (CET)
Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com
 [220.197.31.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62C28398D
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 14:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29bbf213f;
 Sun, 16 Nov 2025 21:00:01 +0800 (GMT+08:00)
Message-ID: <7a7cfd6f-599d-4491-bde6-a84471073ba1@rock-chips.com>
Date: Sun, 16 Nov 2025 21:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rock5b-rk3588: Add support for Radxa ROCK 5T
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 eugen.hristev@linaro.org, jonas@kwiboo.se, heiko@sntech.de,
 cnsztl@gmail.com, xuhui.lin@rock-chips.com
References: <20251107064716.27196-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251107064716.27196-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a8cc0413403afkunmcfb3075b8a3583
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQxlIVh5JTU8eGU4dSEgeQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0hKSkJMVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=EiAV8HlNpAUnScfZttmLc+jFLoUHKdiLMTxuzeW08VgfNOEIhH1ipIA7EVRpMEw+vA7grk7dgS/xFccydJic1Uwrz4dM9GpgjjzlXxkXiaFkcVD/N4+RmormbW+jbGuSWEA4wXIKzyt7+344jUc07dUS+BoE4tXiKAK0O+/c2Mw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=SElMDnaJ42gT2ihUpLgF7n75xpqIyGTqBAUdgmgEM8c=;
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


On 2025/11/7 14:47, FUKAUMI Naoki wrote:
> Include the FDT for Radxa ROCK 5T in the FIT, in addition to those for
> 5B and 5B+, and add board selection code to load the 5T FDT when the
> DRAM type is LPDDR5 and ADC channel 5 value is close to 1016.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This patch depends on the following Jonas's patch series:
>   https://patchwork.ozlabs.org/project/uboot/list/?series=467612
> ---
>   arch/arm/dts/rk3588-rock-5t-u-boot.dtsi   | 3 +++
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c | 1 +
>   configs/rock5b-rk3588_defconfig           | 2 +-
>   doc/board/rockchip/rockchip.rst           | 2 +-
>   4 files changed, 6 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
>
> diff --git a/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
> new file mode 100644
> index 00000000000..c07696c8391
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-rock-5b-u-boot.dtsi"
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> index 6bf4497ce3a..2c172d04499 100644
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -23,6 +23,7 @@ struct board_model {
>   };
>   
>   static const struct board_model board_models[] = {
> +	{ LPDDR5,  926, 1106, "rockchip/rk3588-rock-5t.dtb" },
>   	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
>   };
>   
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 967cebc2054..567f649ea69 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -47,7 +47,7 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus"
> +CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus rockchip/rk3588-rock-5t"
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9af701feb5d..6ae4d4371ff 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -162,7 +162,7 @@ List of mainline supported Rockchip boards:
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
> -     - Radxa ROCK 5B/5B+ (rock5b-rk3588)
> +     - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)
>        - Radxa ROCK 5C (rock-5c-rk3588s)
>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>        - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

