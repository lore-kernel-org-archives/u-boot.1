Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95224CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26230838F0;
	Sat, 30 Aug 2025 17:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XaSFICKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8517E838FA; Sat, 30 Aug 2025 17:27:37 +0200 (CEST)
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com
 [220.197.32.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD24E8341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f98f2;
 Sat, 30 Aug 2025 23:27:31 +0800 (GMT+08:00)
Message-ID: <884d0a37-7aa0-4041-bab9-5959166c5659@rock-chips.com>
Date: Sat, 30 Aug 2025 23:27:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: rockchip: force PMIC reset behavior to
 restart PMU on RK3588 Jaguar
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
 <20250813-rk8xx-rst-fun-v2-3-a2223e17cb2c@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250813-rk8xx-rst-fun-v2-3-a2223e17cb2c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb97435103afkunme969694c4162c1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCThhMVkxPHk5NSU1MH0lIQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=XaSFICKOdSTERndOP47u5fDeWi+7avUgtTwBKPdUhILtDL7iGAdfc46tl+y5yons/lP4Xo2B4prqr+u54mWbqkXHu3RCXj9jduciqlHYUv+MtB6RpgRqjqlDe7mKeIakXPkOpSJssVbpt+Bz/jQUuK7TUP5TXSkWArL1JyaVdaU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=vjfIn0BrHDfEB/FD7dXCh1GIfKisVvxNvvNyZIbzze8=;
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
> The bootloader for RK3588 Jaguar currently forces the PMIC reset
> behavior (stored in RST_FUN bitfield in register SYS_CFG3 of the PMIC)
> to 0b1X which is incorrect for our devices.
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
> Link: https://lore.kernel.org/r/20250627-rk8xx-rst-fun-v4-4-ce05d041b45f@cherry.de
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: ee907113430aa02a8202c91bb574c385ecc28aa2 ]
>
> (cherry picked from commit 8bd14566b75f9409de703a0d2f9a0704b71a7ebe)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> index ebe77cdd24e803b00fb848dc81258909472290f1..176925d0a1a809d1e2500f5e5efbbfa6a6d0bd42 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/pinctrl/rockchip.h>
>   #include <dt-bindings/soc/rockchip,vop2.h>
>   #include <dt-bindings/usb/pd.h>
> +#include "rk8xx.h"
>   #include "rk3588.dtsi"
>   
>   / {
> @@ -693,6 +694,7 @@
>   		vcc13-supply = <&vcc_1v1_nldo_s3>;
>   		vcc14-supply = <&vcc_1v1_nldo_s3>;
>   		vcca-supply = <&vcc5v0_sys>;
> +		rockchip,reset-mode = <RK806_RESTART>;
>   
>   		rk806_dvs1_null: dvs1-null-pins {
>   			pins = "gpio_pwrctrl1";
>
