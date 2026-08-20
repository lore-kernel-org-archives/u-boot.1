Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C430C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8154607DE;
	Thu, 20 Aug 2026 15:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1PQRXdx32N8; Thu, 20 Aug 2026 15:38:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787240287;
	bh=Df1CGWfEM5m+rPCRcHeqZjnL1YmcWYUK6aXfVTMk4FA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cc5M1IJj1C3RyN8jvWDpqBi+evhhV5BPzLX1e35shT7gEiJd4jSqAaQoRtJB+ucaG
	 j0yb6X6zB61pp3sbRZUqAhLeY750PwsJdWUSvkm723ZL0uRj1MWlefWlBt1/xKHVzx
	 PJhnoL7/CQUnroXLo4Zhl0EWsv/Ikbz7P0KNTIYIXBpRMc9JjrApwxlLxTj3JEesaV
	 gkym6p4hAMcs6YqzpmQtdS7M74lD0x8mS6LDZ+MR7JwFEuYL4ak3fNB1FlvAXrAFCL
	 SsMaBQERyzrghyv/VD3G9+DjkxQQtQcNOA8mAA+/0Kv6T6kvk+pV9DgDTHOip10fnn
	 1JIRY7+OT3/0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E962D607D9;
	Thu, 20 Aug 2026 15:38:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BD532FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 118A2607D5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQ8sKLn_IENo for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:38:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::190f; helo=smtp-190f.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Yh89RD2F
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::190f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A007060739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:38:03 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hQndP17S8zQXk;
 Thu, 20 Aug 2026 17:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787240280;
 bh=Df1CGWfEM5m+rPCRcHeqZjnL1YmcWYUK6aXfVTMk4FA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Yh89RD2Fnz3kN5F08BofCHFcQJaF70K9/GEvDbshxDOqlgzFbu2Ym3uR9Xrz0aYmK
 7NUUgUKQxtXG6Sle16b+Y6twB7GObHihQbLuxiDWCbIUjIj1e0/tt5kBGPXEWGLzNZ
 70Ln/XM9oc4568qjfF3KI5J1J9OmQVfmyIksfRd11vdh02ZbbnnAW4rmr3Nk2peTcT
 Q6c2TLHh8wiOWBAOqsU0pR2fGDnNK56o+inTn2Y7Pj3RJWuU8HSEdRLnC25QaADttQ
 I/dFBRCkWYtUwIeRlfxQn7dT0t/2a8upD8X9xpEtbgrgA7NOaDxRieZGwEuv5GGjhv
 8IbrHcr3eXAPA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hQndM4kQGzMX4; Thu, 20 Aug 2026 17:37:59 +0200 (CEST)
Message-ID: <ca2da16f-1c21-4c39-b1da-03ed30e9a0de@0leil.net>
Date: Thu, 20 Aug 2026 17:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: rockchip: spl: Add hotkey detection support.
To: Valentin Liu <valentinliu@icloud.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 kever.yang@rock-chips.com, sjg@chromium.org, jbx6244@gmail.com,
 jonas@kwiboo.se
References: <20260815183437.7387-1-valentinliu@icloud.com>
 <20260818165526.764686-1-valentinliu@icloud.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260818165526.764686-1-valentinliu@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Valentin,

On 8/18/26 6:55 PM, Valentin Liu wrote:
> Add a configurable Rockchip SPL hotkey feature that checks the
> serial console during SPL startup.
> 
> Ctrl+B can be used to enter BootROM download (MASKROM) mode and
> be widely used. We can add more boot mode support in future.
> 
> Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
> the serial port to be ready to receive input before checking for
> hotkeys.
> 
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
> ---
> Changes for v2:
> - Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.
> - Remove the conditions for the newly added includes.
> ---
> Changes for v3:
> - Add a dummy spl_hotkey_init() to avoid undefined reference errors
>    when building without CONFIG_SPL_ROCKCHIP_HOTKEY.
> 
>   arch/arm/mach-rockchip/Kconfig | 13 ++++++++++
>   arch/arm/mach-rockchip/spl.c   | 44 ++++++++++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e..f2d2b5520ef 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -743,6 +743,19 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
>   config SPL_MMC
>   	default y if !SPL_ROCKCHIP_BACK_TO_BROM
>   
> +config SPL_ROCKCHIP_HOTKEY
> +	bool "SPL hotkey support"

The symbol name and prompt is not clear enough on what it does.

config SPL_ROCKCHIP_ENTER_MASKROM_ON_KEY
     bool "Enter MaskROM on key press during SPL"

maybe?

> +	depends on SPL_DM_RESET && SPL_SERIAL
> +	help
> +	  Enable hotkey detection during SPL booting stage.
> +
> +	  When enabled, SPL checks the serial console for a control
> +	  character and can execute Rockchip-specific hotkey actions,
> +	  such as entering BootROM download mode (MASKROM) with Ctrl+B.
> +
> +	  The hotkey is checked after the SPL console has been
> +	  initialized.
> +

Simplify to:

"""
When enabled, the SPL will check whether Ctrl+B is pressed and enter 
MaskROM in that case.
"""

>   config ROCKCHIP_SPI_IMAGE
>   	bool "Build a SPI image for rockchip"
>   	help
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index e989c148079..0bcfb42c306 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -13,11 +13,14 @@
>   #include <log.h>
>   #include <mapmem.h>
>   #include <ram.h>
> +#include <serial.h>
>   #include <spl.h>
> +#include <asm/arch-rockchip/boot_mode.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/timer.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> +#include <linux/delay.h>
>   #include <linux/bitops.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -107,6 +110,44 @@ __weak int arch_cpu_init(void)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY)

Please use CONFIG_IS_ENABLED() instead.

> +static void rockchip_reset_from_hotkey(const int code)
> +{
> +	switch (code) {
> +	case 0x02:

Please add a small comment after 0x02: to specify which key combination 
triggers this code. E.g.:

case 0x02: /* Ctrl+B */

> +		printf("SPL Hotkey: Ctrl+B: BootROM download!\n");

Please be consistent with what we have in 
arch/arm/mach-rockchip/boot_mode.c, that is:

"Ctrl+B pressed, entering download mode..."

I don't like it, as it's typically called MaskROM, but it's something we 
can fix later on and I prefer being consistent with what we currently have.

> +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);

We *really* shouldn't be doing this if CONFIG_ROCKCHIP_BOOT_MODE_REG is 
0 (the case for most boards).

> +		do_reset(NULL, 0, 0, NULL);
> +		/*NOTREACHED*/
> +	default:
> +		if (code <= 0x1a) /* 'z' */
> +			printf("SPL Hotkey: Ctrl+%c\n", code + 'A' - 1);
> +		else
> +			printf("SPL Hotkey: Unknown code: 0x%x, ignore\n", code);> +	}> +}
> +
> +static void spl_hotkey_init(void)
> +{
> +	if (!gd || !(gd->flags & GD_FLG_HAVE_CONSOLE))
> +		return;
> +	if (gd->flags & GD_FLG_DISABLE_CONSOLE)
> +		return;
> +
> +	/* Wait for the serial port to be ready to receive data. */
> +	mdelay(100);
> +

Is it not ready by the time we call this function? How did you come up 
with 100ms?

> +	if (serial_tstc())
> +		rockchip_reset_from_hotkey(serial_getc());
> +	else
> +		printf("SPL Hotkey: No key pressed, continue\n");

We don't need to print on the standard path. If you reaaaaaaally want to 
have something, then use log_debug/debug instead so it isn't printed by 
default except if you build with debug logging enabled.

> +}
> +#else
> +static void spl_hotkey_init(void)
> +{
> +}
> +#endif
> +
>   void board_init_f(ulong dummy)
>   {
>   	int ret;
> @@ -143,6 +184,9 @@ void board_init_f(ulong dummy)
>   	}
>   #endif
>   	preloader_console_init();
> +
> +	if (IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY))
> +		spl_hotkey_init();

Can we merge with the very similar logic we have for an ADC button in 
arch/arm/mach-rockchip/boot_mode.c instead? I believe it makes more 
sense to have everything capable of entering MaskROM mode in the same 
place, with the same logic. I could see an else if() block in 
rockchip_dnl_mode_check() for example.

Cheers,
Quentin
