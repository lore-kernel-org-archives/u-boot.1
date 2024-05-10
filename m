Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C64DC10F1A
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A291188854;
	Fri, 10 May 2024 02:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O9EwSyWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089EF88856; Fri, 10 May 2024 02:44:30 +0200 (CEST)
Received: from mail-m12829.netease.com (mail-m12829.netease.com
 [103.209.128.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0489388853
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=O9EwSyWHB+d9gCX6jdsNxroBE1G0ocYipsEe3useJjNE4AYIBVXKJYJexbVovjxBrIwcHyfwPWnxAgn76+5hU8zhf3hd3iwS95CGoXtz+7R8VEP/J6OA368qfi54zgKnboGDkBhd5FN2TC2vJg0/UvgEhqFUeLoxXwzKJUS6Xq4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=AmzVaaNwaSlHvaxEL3PIQNGjGDFKxCi5yxMT/F4gSDQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4D8859001C3;
 Fri, 10 May 2024 08:44:10 +0800 (CST)
Message-ID: <ba3bb5b3-389d-4086-83cd-3937f4d5c46d@rock-chips.com>
Date: Fri, 10 May 2024 08:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 64/81] sound: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-64-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-64-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1LSFYZSh1CQ0tMSBofTU9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff51e3d03a9kunm4d8859001c3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Tww5DzNKNgIKNyMYSR0y
 KxYaCiFVSlVKTEpOSEtKQ05KSUpMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU9LSTcG
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


On 2024/5/2 09:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/sound/broadwell_i2s.c   | 1 -
>   drivers/sound/broadwell_sound.c | 1 -
>   drivers/sound/codec-uclass.c    | 1 -
>   drivers/sound/da7219.c          | 1 -
>   drivers/sound/hda_codec.c       | 1 -
>   drivers/sound/i2s-uclass.c      | 1 -
>   drivers/sound/i8254_beep.c      | 1 -
>   drivers/sound/ivybridge_sound.c | 1 -
>   drivers/sound/max98088.c        | 1 -
>   drivers/sound/max98090.c        | 1 -
>   drivers/sound/max98095.c        | 1 -
>   drivers/sound/max98357a.c       | 1 -
>   drivers/sound/maxim_codec.c     | 1 -
>   drivers/sound/rockchip_i2s.c    | 1 -
>   drivers/sound/rockchip_sound.c  | 1 -
>   drivers/sound/rt5677.c          | 1 -
>   drivers/sound/samsung-i2s.c     | 2 +-
>   drivers/sound/samsung_sound.c   | 1 -
>   drivers/sound/sandbox.c         | 1 -
>   drivers/sound/sound-uclass.c    | 1 -
>   drivers/sound/sound.c           | 2 +-
>   drivers/sound/tegra_ahub.c      | 2 +-
>   drivers/sound/tegra_i2s.c       | 1 -
>   drivers/sound/tegra_sound.c     | 1 -
>   drivers/sound/wm8994.c          | 1 -
>   25 files changed, 3 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/sound/broadwell_i2s.c b/drivers/sound/broadwell_i2s.c
> index 7f754e656761..bc44b5ec7e1f 100644
> --- a/drivers/sound/broadwell_i2s.c
> +++ b/drivers/sound/broadwell_i2s.c
> @@ -9,7 +9,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2S
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   #include <log.h>
> diff --git a/drivers/sound/broadwell_sound.c b/drivers/sound/broadwell_sound.c
> index 6e083fe1f696..473f8d8f9771 100644
> --- a/drivers/sound/broadwell_sound.c
> +++ b/drivers/sound/broadwell_sound.c
> @@ -8,7 +8,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SOUND
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <i2s.h>
> diff --git a/drivers/sound/codec-uclass.c b/drivers/sound/codec-uclass.c
> index 2cb233bd3060..1c1560619ea5 100644
> --- a/drivers/sound/codec-uclass.c
> +++ b/drivers/sound/codec-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_AUDIO_CODEC
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <audio_codec.h>
>   
> diff --git a/drivers/sound/da7219.c b/drivers/sound/da7219.c
> index c1edef443608..5b9b3f65263f 100644
> --- a/drivers/sound/da7219.c
> +++ b/drivers/sound/da7219.c
> @@ -6,7 +6,6 @@
>    * Parts taken from coreboot
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <irq.h>
> diff --git a/drivers/sound/hda_codec.c b/drivers/sound/hda_codec.c
> index af6148ef7240..da8bde67de65 100644
> --- a/drivers/sound/hda_codec.c
> +++ b/drivers/sound/hda_codec.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY	UCLASS_SOUND
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <hda_codec.h>
>   #include <log.h>
> diff --git a/drivers/sound/i2s-uclass.c b/drivers/sound/i2s-uclass.c
> index fc4f686b516d..6263c4d70719 100644
> --- a/drivers/sound/i2s-uclass.c
> +++ b/drivers/sound/i2s-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2S
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   
> diff --git a/drivers/sound/i8254_beep.c b/drivers/sound/i8254_beep.c
> index 5572dc4d265d..7234ad4a07e5 100644
> --- a/drivers/sound/i8254_beep.c
> +++ b/drivers/sound/i8254_beep.c
> @@ -3,7 +3,6 @@
>    * Copyright 2018 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <sound.h>
>   #include <asm/i8254.h>
> diff --git a/drivers/sound/ivybridge_sound.c b/drivers/sound/ivybridge_sound.c
> index d982219e06de..aeeba1d267ec 100644
> --- a/drivers/sound/ivybridge_sound.c
> +++ b/drivers/sound/ivybridge_sound.c
> @@ -12,7 +12,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SOUND
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <hda_codec.h>
>   #include <log.h>
> diff --git a/drivers/sound/max98088.c b/drivers/sound/max98088.c
> index c0463b8e8a62..d9037641ca46 100644
> --- a/drivers/sound/max98088.c
> +++ b/drivers/sound/max98088.c
> @@ -8,7 +8,6 @@
>    * following the changes made in max98095.c
>    */
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/sound/max98090.c b/drivers/sound/max98090.c
> index a798762f1ee7..18a3ffa85c8e 100644
> --- a/drivers/sound/max98090.c
> +++ b/drivers/sound/max98090.c
> @@ -5,7 +5,6 @@
>    * Copyright 2011 Maxim Integrated Products
>    */
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/sound/max98095.c b/drivers/sound/max98095.c
> index d0f701aaf105..96e772cff21b 100644
> --- a/drivers/sound/max98095.c
> +++ b/drivers/sound/max98095.c
> @@ -7,7 +7,6 @@
>    * Modified for U-Boot by R. Chandrasekar (rcsekar@samsung.com)
>    */
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <div64.h>
> diff --git a/drivers/sound/max98357a.c b/drivers/sound/max98357a.c
> index bdf6dc236ec3..da56ffdd6bb4 100644
> --- a/drivers/sound/max98357a.c
> +++ b/drivers/sound/max98357a.c
> @@ -6,7 +6,6 @@
>    * Parts taken from coreboot
>    */
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/sound/maxim_codec.c b/drivers/sound/maxim_codec.c
> index 6553d9590472..98f094c0e9ad 100644
> --- a/drivers/sound/maxim_codec.c
> +++ b/drivers/sound/maxim_codec.c
> @@ -5,7 +5,6 @@
>    * Copyright 2011 Maxim Integrated Products
>    */
>   
> -#include <common.h>
>   #include <div64.h>
>   #include <i2c.h>
>   #include <i2s.h>
> diff --git a/drivers/sound/rockchip_i2s.c b/drivers/sound/rockchip_i2s.c
> index 4e9e68aaac81..5078dfbed07d 100644
> --- a/drivers/sound/rockchip_i2s.c
> +++ b/drivers/sound/rockchip_i2s.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2S
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   #include <log.h>
> diff --git a/drivers/sound/rockchip_sound.c b/drivers/sound/rockchip_sound.c
> index 94058e603d7d..418d2efd4526 100644
> --- a/drivers/sound/rockchip_sound.c
> +++ b/drivers/sound/rockchip_sound.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SOUND
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <clk.h>
>   #include <dm.h>
> diff --git a/drivers/sound/rt5677.c b/drivers/sound/rt5677.c
> index b655bb40b642..b5c997c6dd53 100644
> --- a/drivers/sound/rt5677.c
> +++ b/drivers/sound/rt5677.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SOUND
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/sound/samsung-i2s.c b/drivers/sound/samsung-i2s.c
> index dc5a2789aeed..42175fd7d28b 100644
> --- a/drivers/sound/samsung-i2s.c
> +++ b/drivers/sound/samsung-i2s.c
> @@ -4,11 +4,11 @@
>    * R. Chandrasekar <rcsekar@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   #include <log.h>
>   #include <sound.h>
> +#include <time.h>
>   #include <asm/arch/clk.h>
>   #include <asm/arch/pinmux.h>
>   #include <asm/arch/i2s-regs.h>
> diff --git a/drivers/sound/samsung_sound.c b/drivers/sound/samsung_sound.c
> index 473cedf7e974..9150ad4a63ba 100644
> --- a/drivers/sound/samsung_sound.c
> +++ b/drivers/sound/samsung_sound.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <i2s.h>
> diff --git a/drivers/sound/sandbox.c b/drivers/sound/sandbox.c
> index c6cbd81fdbce..31ae153530e8 100644
> --- a/drivers/sound/sandbox.c
> +++ b/drivers/sound/sandbox.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SOUND
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <i2s.h>
> diff --git a/drivers/sound/sound-uclass.c b/drivers/sound/sound-uclass.c
> index 2ffc4fc7c1db..b8a3dab447d9 100644
> --- a/drivers/sound/sound-uclass.c
> +++ b/drivers/sound/sound-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_SOUND
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   #include <log.h>
> diff --git a/drivers/sound/sound.c b/drivers/sound/sound.c
> index c0fc50c99dac..4fde2989e04f 100644
> --- a/drivers/sound/sound.c
> +++ b/drivers/sound/sound.c
> @@ -4,9 +4,9 @@
>    * R. Chandrasekar <rcsekar@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <sound.h>
> +#include <linux/string.h>
>   
>   void sound_create_square_wave(uint sample_rate, unsigned short *data, int size,
>   			      uint freq, uint channels)
> diff --git a/drivers/sound/tegra_ahub.c b/drivers/sound/tegra_ahub.c
> index 495a29c5137c..8f1b0c009a88 100644
> --- a/drivers/sound/tegra_ahub.c
> +++ b/drivers/sound/tegra_ahub.c
> @@ -7,11 +7,11 @@
>   
>   #define LOG_CATEGORY UCLASS_MISC
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   #include <log.h>
>   #include <misc.h>
> +#include <time.h>
>   #include <asm/io.h>
>   #include <asm/arch-tegra/tegra_ahub.h>
>   #include <asm/arch-tegra/tegra_i2s.h>
> diff --git a/drivers/sound/tegra_i2s.c b/drivers/sound/tegra_i2s.c
> index 932f737900e4..357aac36ceaa 100644
> --- a/drivers/sound/tegra_i2s.c
> +++ b/drivers/sound/tegra_i2s.c
> @@ -5,7 +5,6 @@
>    */
>   #define LOG_CATEGORY UCLASS_I2S
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2s.h>
>   #include <log.h>
> diff --git a/drivers/sound/tegra_sound.c b/drivers/sound/tegra_sound.c
> index aef6a2eb1475..152c929146f5 100644
> --- a/drivers/sound/tegra_sound.c
> +++ b/drivers/sound/tegra_sound.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2S
>   
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <i2s.h>
> diff --git a/drivers/sound/wm8994.c b/drivers/sound/wm8994.c
> index fd646479b315..6b3091aa5de1 100644
> --- a/drivers/sound/wm8994.c
> +++ b/drivers/sound/wm8994.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2012 Samsung Electronics
>    * R. Chandrasekar <rcsekar@samsung.com>
>    */
> -#include <common.h>
>   #include <audio_codec.h>
>   #include <dm.h>
>   #include <div64.h>
