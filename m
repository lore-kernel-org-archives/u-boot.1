Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E912DC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70BA487FC7;
	Thu, 23 May 2024 05:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZPV2UJFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3D7884EA; Thu, 23 May 2024 05:48:12 +0200 (CEST)
Received: from mail-m3282.qiye.163.com (mail-m3282.qiye.163.com
 [220.197.32.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D84D87F65
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ZPV2UJFYGEC3vqDuTYB7fIKA/KKr411eUCBQ7pzNb/IQkNzzAuglNgoz9hn0Tpz1qdAeRs0cwHNauCg6d5qdS91OQp/tZX60aUo2d1KyYeeum4gw8cE1JUhZWjzSANgQkZMVdimz5R2JjXW91d2oYxltfXqKwRVWPLLIdU/SUCA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=6dinWK6JTWTjvn1NyfNPTqYfXdV5tekMpyylOWvChLc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0147F9002C6;
 Thu, 23 May 2024 11:47:41 +0800 (CST)
Message-ID: <d16dfbc4-a1fe-45fe-b0ee-2b3117704fc2@rock-chips.com>
Date: Thu, 23 May 2024 11:47:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 V2] Revert "board: rockchip: Add early ADC button
 detect for RGxx3"
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Chris Morgan <macromorgan@hotmail.com>
References: <20240521154549.255607-1-macroalpha82@gmail.com>
 <20240521154549.255607-2-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521154549.255607-2-macroalpha82@gmail.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4YSlZPGU5OHk8eTEsZGBhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8fa38fd09003a9kunm0147f9002c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6GDo4GTNIDxwVAQMvSy0h
 LxwKCSxVSlVKTEpNT0hNS01JQ0pNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0NLTDcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2024/5/21 23:45, Chris Morgan wrote:
> From: Chris Morgan<macromorgan@hotmail.com>
>
> This reverts commit 41a60d0e5cef54a59596a58940fa7c9cf071034b.
>
> On some of the supported devices the adc detect code always returns
> that the button has been pushed, and as a result the device will
> not boot normally.

Have you check the key input voltage with voltameter which can identify 
is hardware issue or software issue.


Thanks,

- Kever

>
> Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ----------------------
>   1 file changed, 64 deletions(-)
>
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index 099eea60c3..5c57b902d1 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -6,14 +6,12 @@
>   #include <abuf.h>
>   #include <adc.h>
>   #include <asm/io.h>
> -#include <command.h>
>   #include <display.h>
>   #include <dm.h>
>   #include <dm/lists.h>
>   #include <env.h>
>   #include <fdt_support.h>
>   #include <linux/delay.h>
> -#include <linux/iopoll.h>
>   #include <mipi_dsi.h>
>   #include <mmc.h>
>   #include <panel.h>
> @@ -21,8 +19,6 @@
>   #include <stdlib.h>
>   #include <video_bridge.h>
>   
> -#define BOOT_BROM_DOWNLOAD	0xef08a53c
> -
>   #define GPIO0_BASE		0xfdd60000
>   #define GPIO4_BASE		0xfe770000
>   #define GPIO_SWPORT_DR_L	0x0000
> @@ -36,14 +32,6 @@
>   
>   #define GPIO_WRITEMASK(bits)	((bits) << 16)
>   
> -#define SARADC_BASE		0xfe720000
> -#define SARADC_DATA		0x0000
> -#define SARADC_STAS		0x0004
> -#define SARADC_ADC_STATUS	BIT(0)
> -#define SARADC_CTRL		0x0008
> -#define SARADC_INPUT_SRC_MSK	0x7
> -#define SARADC_POWER_CTRL	BIT(3)
> -
>   #define DTB_DIR			"rockchip/"
>   
>   struct rg3xx_model {
> @@ -169,64 +157,12 @@ static const struct rg353_panel rg353_panel_details[] = {
>   	},
>   };
>   
> -/*
> - * The device has internal eMMC, and while some devices have an exposed
> - * clk pin you can ground to force a bypass not all devices do. As a
> - * result it may be possible for some devices to become a perma-brick
> - * if a corrupted TPL or SPL stage with a valid header is flashed to
> - * the internal eMMC. Add functionality to read ADC channel 0 (the func
> - * button) as early as possible in the boot process to provide some
> - * protection against this. If we ever get an open TPL stage, we should
> - * consider moving this function there.
> - */
> -void read_func_button(void)
> -{
> -	int ret;
> -	u32 reg;
> -
> -	/* Turn off SARADC to reset it. */
> -	writel(0, (SARADC_BASE + SARADC_CTRL));
> -
> -	/* Enable channel 0 and power on SARADC. */
> -	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> -	       (SARADC_BASE + SARADC_CTRL));
> -
> -	/*
> -	 * Wait for data to be ready. Use timeout of 20000us from
> -	 * rockchip_saradc driver.
> -	 */
> -	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> -				 !(reg & SARADC_ADC_STATUS), 20000);
> -	if (ret) {
> -		printf("ADC Timeout");
> -		return;
> -	}
> -
> -	/* Read the data from the SARADC. */
> -	reg = readl((SARADC_BASE + SARADC_DATA));
> -
> -	/* Turn the SARADC back off so it's ready to be used again. */
> -	writel(0, (SARADC_BASE + SARADC_CTRL));
> -
> -	/*
> -	 * If the value is less than 30 the button is being pressed.
> -	 * Reset the device back into Rockchip download mode.
> -	 */
> -	if (reg <= 30) {
> -		printf("download key pressed, entering download mode...");
> -		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> -		do_reset(NULL, 0, 0, NULL);
> -	}
> -};
> -
>   /*
>    * Start LED very early so user knows device is on. Set color
>    * to red.
>    */
>   void spl_board_init(void)
>   {
> -	read_func_button();
> -
>   	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
>   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
>   	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
