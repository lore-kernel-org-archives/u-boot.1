Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2E6CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7442083903;
	Sat, 30 Aug 2025 17:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OKg22+AL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C13838E7; Sat, 30 Aug 2025 17:27:47 +0200 (CEST)
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com
 [220.197.32.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4907836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f98f7;
 Sat, 30 Aug 2025 23:27:41 +0800 (GMT+08:00)
Message-ID: <737bbaf9-8d2f-4a6b-8564-82eb1f7c0dda@rock-chips.com>
Date: Sat, 30 Aug 2025 23:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: force PMIC reset behavior to
 restart PMU on RK3588 Tiger
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
 <20250813-rk8xx-rst-fun-v2-4-a2223e17cb2c@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250813-rk8xx-rst-fun-v2-4-a2223e17cb2c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb976b9f03afkunm3ce7e664416393
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx9KVk5PSkofH0xLSx8ZHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=OKg22+ALQs4eho94mrPpoc/G31/5gycpl/28+yMPLrXRkSvIQhF5s7apgqBxUx/nQK3lIyVk298+NwDg95Xx3jdAZZEyF3QsV132Ft4PBpHMaszoiCgIjClpXl/ejr1JAdKanrJfajRDIOJKAtvJuKtlS9oaB8CjvXO5y7rTrJs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=aNZBluzzxRdupHoJPmYT0/hYEZ1dEwy4YUDJUh1fLsk=;
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


On 2025/8/13 22:07, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The bootloader for RK3588 Tiger currently forces the PMIC reset behavior
> (stored in RST_FUN bitfield in register SYS_CFG3 of the PMIC) to 0b1X
> which is incorrect for our devices.
>
> It is required to restart the PMU as otherwise the companion
> microcontroller cannot detect the PMIC (and by extension the full
> product and main SoC) being rebooted which is an issue as that is used
> to reset a few things like the PWM beeper and watchdogs.
>
> Let's add the new rockchip,reset-mode property to make sure the PMIC
> reset behavior is the expected one.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Link: https://lore.kernel.org/r/20250627-rk8xx-rst-fun-v4-5-ce05d041b45f@cherry.de
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: e82f642b9821384045915dc30e73df7de8424827 ]
>
> (cherry picked from commit d9c568906be166834f4f977bc7f704176bac5b8a)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
> index c4933a08dd1e3c92f3e0747135faf97c5eeca906..b44e89e1bb1599ee70b921598c2eb6fd54614f55 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
> @@ -6,6 +6,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk8xx.h"
>   #include "rk3588.dtsi"
>   
>   / {
> @@ -440,6 +441,7 @@
>   		vcc13-supply = <&vcc_1v1_nldo_s3>;
>   		vcc14-supply = <&vcc_1v1_nldo_s3>;
>   		vcca-supply = <&vcc5v0_sys>;
> +		rockchip,reset-mode = <RK806_RESTART>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
>   			pins = "gpio_pwrctrl1";
>
