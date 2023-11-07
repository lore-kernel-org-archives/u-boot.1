Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CCEC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 04:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256F986DD2;
	Tue,  7 Nov 2023 05:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MUdi2hqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E195987001; Tue,  7 Nov 2023 05:02:37 +0100 (CET)
Received: from mail-m17236.xmail.ntesmail.com (mail-m17236.xmail.ntesmail.com
 [45.195.17.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6236786CB1
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 05:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MUdi2hqvlhZnbguFKU0cLJGP8IC/eBEfuO0y+EMmUtEBziN9dAV4LcCZa9+OwopDFh1EHXeoTDTB+rCVLdVRLEtiznm0kmFxBO1Oz4JdLWPrFwjTF3AGp3KxQpXiaMRN7RvRBMZdmKTvttPkVLjOWrQYLi2HOWOGQw/PVjF5SCU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ByLedIYORPK7dCPMu6JZlmtlKr9FjhX7te10RxMG5Jg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 839AA4002FD;
 Tue,  7 Nov 2023 12:02:12 +0800 (CST)
Message-ID: <8cadd93a-c95f-4f72-901b-f6e8150bb8e0@rock-chips.com>
Date: Tue, 7 Nov 2023 12:02:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rockchip: ringneck-px30: always reset STM32
 companion controller on boot
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
References: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
 <20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkweTVZCTUpPSE0fGEgdSExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8ba7f1f0872eb3kusn839aa4002fd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6Kgw5SjwxFxUIES06MTcY
 FCwaCxJVSlVKTUJCSElCTEhISU1DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSU9LNwY+
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


On 2023/11/3 17:28, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> It's happened that glitches on the STM32_RST and STM32_BOOT lines have
> put the STM32 companion microcontroller into DFU mode making it not boot
> its FW, rendering it useless for the user.
>
> Considering that the STM32 companion microcontroller is always reset on
> a reboot or power cycle, resetting it once again in U-Boot SPL isn't
> going to hurt it any more.
>
> For ATtiny companion microcontroller, the situation is a bit different
> because a reboot or power cycle doesn't reset it. Additionally, since it
> can only be reset with a UPDI reset on the STM32_RST line, and that is
> virtually impossible to mistakenly trigger, the ATtiny is unlikely to be
> in unwanted reset or enter reset because U-Boot toggles STM32_RST line.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../ringneck_px30/ringneck-px30.c                  | 53 ++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> index bb1bb4acf5c..537ce0d1d11 100644
> --- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> +++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> @@ -16,12 +16,14 @@
>   #include <usb.h>
>   #include <dm/pinctrl.h>
>   #include <dm/uclass-internal.h>
> +#include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <asm/setup.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <asm/arch-rockchip/periph.h>
>   #include <asm/arch-rockchip/misc.h>
> +#include <linux/delay.h>
>   #include <power/regulator.h>
>   #include <u-boot/sha256.h>
>   
> @@ -169,3 +171,54 @@ int misc_init_r(void)
>   
>   	return 0;
>   }
> +
> +#define STM32_RST	100 /* GPIO3_A4 */
> +#define STM32_BOOT	101 /* GPIO3_A5 */
> +
> +void spl_board_init(void)
> +{
> +	/*
> +	 * Glitches on STM32_BOOT and STM32_RST lines during poweroff or power
> +	 * on may put the STM32 companion microcontroller into DFU mode, let's
> +	 * always reset it into normal mode instead.
> +	 * Toggling the STM32_RST line is safe to do with the ATtiny companion
> +	 * microcontroller variant because it will not trigger an MCU reset
> +	 * since only a UPDI reset command will. Since a UPDI reset is difficult
> +	 * to mistakenly trigger, glitches to the lines are theoretically also
> +	 * incapable of triggering an actual ATtiny reset.
> +	 */
> +	int ret;
> +
> +	ret = gpio_request(STM32_RST, "STM32_RST");
> +	if (ret) {
> +		debug("Failed to request STM32_RST\n");
> +		return;
> +	}
> +
> +	ret = gpio_request(STM32_BOOT, "STM32_BOOT");
> +	if (ret) {
> +		debug("Failed to request STM32_BOOT\n");
> +		return;
> +	}
> +
> +	/* Rely on HW pull-down for inactive level */
> +	ret = gpio_direction_input(STM32_BOOT);
> +	if (ret) {
> +		debug("Failed to configure STM32_BOOT as input\n");
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(STM32_RST, 0);
> +	if (ret) {
> +		debug("Failed to configure STM32_RST as output low\n");
> +		return;
> +	}
> +
> +	mdelay(1);
> +
> +	ret = gpio_direction_output(STM32_RST, 1);
> +	if (ret) {
> +		debug("Failed to configure STM32_RST as output high\n");
> +		return;
> +	}
> +}
>
