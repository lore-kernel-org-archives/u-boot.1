Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBF7C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77BE87B72;
	Thu, 18 Jan 2024 08:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CLwJZ7AK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111B287B82; Thu, 18 Jan 2024 08:21:19 +0100 (CET)
Received: from mail-m1285.netease.com (mail-m1285.netease.com [103.209.128.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC5987A0E
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=CLwJZ7AKPfNVS6XQQWnKqQo0M7Kv6Li2xiaMFCvNoUquAv8iKLG/ZG+Ia0c7W1b2ZN27ResjdD8pQjT9kkxQ7D7Dwd4vv6Lbp/+HPkBGQXmQ7vylspEjZhVM1lynj8tIt6062Noyr9pGloCUgKuKy7tCJ5HmyYq0xHHJLuykFjQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=SK4Gzh/B3C69uifipedBze4lo56aD22OAA0BjBasDJ0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 26ABC9004E9;
 Thu, 18 Jan 2024 15:21:13 +0800 (CST)
Message-ID: <13dcc846-0c9c-4734-ad7f-f5468404351a@rock-chips.com>
Date: Thu, 18 Jan 2024 15:21:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/7] rockchip: board: Add board_rng_seed() for all
 Rockchip devices
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: andre.przywara@arm.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jagan@edgeble.ai, jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-6-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240102154654.191055-6-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoYGFZOHxlMHRodHUpMHk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b7203a52eafkusn26abc9004e9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6TSo*UTwoKhA8Ih4vDRQz
 Fk0KC01VSlVKTEtOTk1JT0xIQkxOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSk5CNwY+
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


On 2024/1/2 23:46, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Allow all rockchip devices to use the hardware RNG to seed Linux
> RNG.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/board.c             | 32 ++++++++++++++++++++++
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 29 --------------------
>   2 files changed, 32 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 57f08e0be0..77145524ea 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -348,3 +348,35 @@ __weak int misc_init_r(void)
>   	return ret;
>   }
>   #endif
> +
> +#if IS_ENABLED(CONFIG_BOARD_RNG_SEED) && IS_ENABLED(CONFIG_RNG_ROCKCHIP)
> +#include <rng.h>
> +
> +/* Use hardware rng to seed Linux random. */
> +__weak int board_rng_seed(struct abuf *buf)
> +{
> +	struct udevice *dev;
> +	size_t len = 0x8;
> +	u64 *data;
> +
> +	data = malloc(len);
> +	if (!data) {
> +		printf("Out of memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> +		printf("No RNG device\n");
> +		return -ENODEV;
> +	}
> +
> +	if (dm_rng_read(dev, data, len)) {
> +		printf("Reading RNG failed\n");
> +		return -EIO;
> +	}
> +
> +	abuf_init_set(buf, data, len);
> +
> +	return 0;
> +}
> +#endif
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index 45854709f5..7bef5a53f0 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -17,7 +17,6 @@
>   #include <mmc.h>
>   #include <panel.h>
>   #include <pwm.h>
> -#include <rng.h>
>   #include <stdlib.h>
>   #include <video_bridge.h>
>   
> @@ -137,34 +136,6 @@ void spl_board_init(void)
>   	       (GPIO0_BASE + GPIO_SWPORT_DR_H));
>   }
>   
> -/* Use hardware rng to seed Linux random. */
> -int board_rng_seed(struct abuf *buf)
> -{
> -	struct udevice *dev;
> -	size_t len = 0x8;
> -	u64 *data;
> -
> -	data = malloc(len);
> -	if (!data) {
> -		printf("Out of memory\n");
> -		return -ENOMEM;
> -	}
> -
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return -ENODEV;
> -	}
> -
> -	if (dm_rng_read(dev, data, len)) {
> -		printf("Reading RNG failed\n");
> -		return -EIO;
> -	}
> -
> -	abuf_init_set(buf, data, len);
> -
> -	return 0;
> -}
> -
>   /*
>    * Buzz the buzzer so the user knows something is going on. Make it
>    * optional in case PWM is disabled.
