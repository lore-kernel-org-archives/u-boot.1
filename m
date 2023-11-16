Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5435BC5ACB3
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8033886564;
	Thu, 16 Nov 2023 17:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4BOpDdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9FF86F7C; Thu, 16 Nov 2023 17:16:35 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A328E8269F
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6d645cfd238so542709a34.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700151382; x=1700756182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AZbX7Xn361FJoSKPUr6On+uCCL+BfXFBkpSMaChmWzQ=;
 b=S4BOpDdlCB9CAonhAqdDkQIaW/Z+z9wG4m2EYHGb3rGU71QB8CGyrosQZF+fFdHUt5
 QgzIyjcs14hXrazlMgTZpGeW77aeSJKEkS/UnOPSsKvqXse2AQOlsttbED7ASBTWZ03k
 ncHmllIqFbRXe/LBwWvSi3oPz5xHnilvGr6ZHK3BwjcCjS8uPddOcC29GUcFMXjQItdX
 LPWfvEJdA+a0GYZLFEOSHryWT+xIRcE42WJv30EhywwDU95wyFn4LzJaxdUKwPAqY1hm
 xVIpWv5KD5ov+iLsA7Wqoy0eeFciaE6TtZamfgVerwXSnaQ9dA3sPB+WvFIg1CuxXwjM
 7XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700151382; x=1700756182;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZbX7Xn361FJoSKPUr6On+uCCL+BfXFBkpSMaChmWzQ=;
 b=QMob2fJ6D5v2UcWcmq68HZ37UbNmM0T06YYtCSpVo/+NGKXkqh+7qU+0WnTnek9Qfk
 GYrB13PyGuSR9MlqnlkxVcxwvBl07dMzTCKZFsh99OF38W92AGhSLUpebx0b5ngZ06V6
 nRHm0b5yWCy/HS3BmRtd2hQ5dpKduf1cbIMk+YuLLQ6rd4fvEF/U7VTijbMbl6Q/3bzt
 1CA55xbUB7X+CLJAPWuU9csc2c957JnuD1aHtkcPooIRiBL8Or6IMBXW0CI4G/lcjv6h
 AvvEUm9jebYn65mHKWqwKd6uKmeCSKSlh4fctbkppvbXuPuL4nHKtLHx4IVjzU4kJtD4
 1B9Q==
X-Gm-Message-State: AOJu0YzlMA4hgtP8AuJdLEMb0hBY5HlRyDYRIwXCNCGjzx6Zw6CehyHb
 IEi2KTaoSeo6dBB7QthxCt8=
X-Google-Smtp-Source: AGHT+IE1wvpwWdz4OI51RFS0OVt2BeSJIebB8k8nz8pfERNQytKPwQfWhd3dgEgoeikyoRZ2Z9XeCg==
X-Received: by 2002:a05:6830:14f:b0:6cd:4358:1f02 with SMTP id
 j15-20020a056830014f00b006cd43581f02mr9847942otp.34.1700151382180; 
 Thu, 16 Nov 2023 08:16:22 -0800 (PST)
Received: from neuromancer. ([75.28.21.198]) by smtp.gmail.com with ESMTPSA id
 g6-20020a0568300a4600b006ce28044207sm949074otu.58.2023.11.16.08.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:16:21 -0800 (PST)
Message-ID: <65564055.050a0220.31791.7a2e@mx.google.com>
X-Google-Original-Message-ID: <ZVZAUt6uf4wLAVdO@neuromancer.>
Date: Thu, 16 Nov 2023 10:16:18 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de, philipp.tomsich@vrull.eu, sjg@chromium.org
Subject: Re: [PATCH 2/3] board: rockchip: Add Maskrom Mode for Anbernic RGxx3
References: <20231017182414.321411-1-macroalpha82@gmail.com>
 <20231017182414.321411-3-macroalpha82@gmail.com>
 <3ea38028-1ab1-4dfd-8b5e-eb6eb79dd0eb@rock-chips.com>
 <SN6PR06MB5342813C5A872A749D01A588A5D8A@SN6PR06MB5342.namprd06.prod.outlook.com>
 <f6247d64-78ea-477c-a877-aa591cd3508a@kwiboo.se>
 <SN6PR06MB53425F96974335DCD143BEC0A5DEA@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR06MB53425F96974335DCD143BEC0A5DEA@SN6PR06MB5342.namprd06.prod.outlook.com>
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

On Wed, Oct 25, 2023 at 02:15:57PM -0500, Chris Morgan wrote:
> On Mon, Oct 23, 2023 at 07:12:14PM +0200, Jonas Karlman wrote:
> > Hi Chris,
> > 
> > On 2023-10-23 17:18, Chris Morgan wrote:
> > > On Mon, Oct 23, 2023 at 06:10:07PM +0800, Kever Yang wrote:
> > >> Hi Chris,
> > >>
> > >> On 2023/10/18 02:24, Chris Morgan wrote:
> > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > >>>
> > >>> Add support for users to enter maskrom mode by holding the function
> > >>> button when they power up the device.
> > >>>
> > >>> Since the device has soldered eMMC and sometimes does not expose a clk
> > >>> pin on the mainboard
> > >>
> > >> This board already available, so does this clk pin available?
> > >>
> > >> Not only clk, other cmd/data pin is also OK to make the soc get into maskrom
> > >> mode.
> > > 
> > > No, as near as I can tell some boards (such as the 353P and 353V) don't
> > > expose a clk, cmd, or data pin. The 353M does expose a clk pin though.
> > > 
> > >>
> > >>> there is a small chance that a user who flashes a
> > >>> bad bootloader may not be able to recover if the headers themselves
> > >>> are valid. As a result this check is done during spl_early_init() to
> > >>> ensure that it runs as early as possible, and it does so by directly
> > >>> manipulating the ADC hardware in lieu of loading the ADC driver.
> > >>
> > >> This key seems like a "recovery" adc key instead of "maskrom" key, right?
> > >>
> > >> I think we don't need to add this patch if the hardware does not really have
> > >> a "maskrom" key.
> > >>
> > >> Basically the "maskrom" key should not depends on any software.
> > > 
> > > Okay, so should I rename it as a "recovery" key? Basically it's just
> > > a button hooked up to ADC channel 0. I'm trying to make as simple a
> > > failsafe as possible, because for the boards without the clk/cmd pads
> > > I want to make it easy to debrick in the event of something like a
> > > bad U-Boot stage or a bad A-TF stage.
> > 
> > Isn't this very similar to what arch/arm/mach-rockchip/boot_mode.c and
> > rockchip_dnl_key_pressed() already does, or is supposed to do?
> > 
> > Maybe this existing code can be changed/fixed to work earlier in SPL and
> > possible also read recovery button information from DT or Kconfig to
> > work with more rockchip boards?
> > 
> > Would be nice if a hang/panic in SPL make rk devices reset into maskrom
> > usb mode. Maybe even the watchdog can be of some use here.
> > 
> > Btw, you could probably also enable CONFIG_SPL_FIT_SIGNATURE for added
> > protection against starting corrupt/bitrot FIT images. To speed up boot
> > after adding a sha256 checksum test, you can use following rfc/patch:
> > 
> > [RFC] rockchip: spl: Enable caches to speed up checksum validation
> > https://patchwork.ozlabs.org/patch/1802303/
> > 
> > Regards,
> > Jonas
> 
> Thank you, yes I will look into that. That said even if we detect a
> corrupt SPL stage we're still stuck unless we add the additional
> reset stuff like you mention.
> 
> Yes, this is more or less identical to the rockchip_dnl_key_pressed()
> function with 2 distinct differences; one this doesn't require the ADC
> driver since we're manipulating the controller directly (this makes it
> easier to support in SPL or maybe even one day TPL), and two the
> existing function has hard-coded checks for channel 1 whereas the board
> here uses channel 0 for the function button. The comments for the
> existing function suggest that it's meant to be "generic" and boards
> are welcome to override with their own function, which is what I'm
> doing though at an earlier stage in the boot process.
> 
> Thank you,
> Chris

Just wanted to dig this one back up. If I refer to this as "recovery"
instead of "maskrom", are we okay to go?

Thank you.

> 
> > 
> > > 
> > > Thank you.
> > > 
> > >>
> > >>
> > >> Thanks,
> > >>
> > >> - Kever
> > >>
> > >>>
> > >>> Ideally, once we have an open source TPL stage we can move this to
> > >>> the TPL stage, so it will run even earlier.
> > >>>
> > >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > >>> ---
> > >>>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
> > >>>   1 file changed, 64 insertions(+)
> > >>>
> > >>> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > >>> index 3d0c614623..a93b11cd47 100644
> > >>> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > >>> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > >>> @@ -6,12 +6,14 @@
> > >>>   #include <abuf.h>
> > >>>   #include <adc.h>
> > >>>   #include <asm/io.h>
> > >>> +#include <command.h>
> > >>>   #include <display.h>
> > >>>   #include <dm.h>
> > >>>   #include <dm/lists.h>
> > >>>   #include <env.h>
> > >>>   #include <fdt_support.h>
> > >>>   #include <linux/delay.h>
> > >>> +#include <linux/iopoll.h>
> > >>>   #include <mipi_dsi.h>
> > >>>   #include <mmc.h>
> > >>>   #include <panel.h>
> > >>> @@ -20,6 +22,8 @@
> > >>>   #include <stdlib.h>
> > >>>   #include <video_bridge.h>
> > >>> +#define BOOT_BROM_DOWNLOAD	0xef08a53c
> > >>> +
> > >>>   #define GPIO0_BASE		0xfdd60000
> > >>>   #define GPIO4_BASE		0xfe770000
> > >>>   #define GPIO_SWPORT_DR_L	0x0000
> > >>> @@ -33,6 +37,14 @@
> > >>>   #define GPIO_WRITEMASK(bits)	((bits) << 16)
> > >>> +#define SARADC_BASE		0xfe720000
> > >>> +#define SARADC_DATA		0x0000
> > >>> +#define SARADC_STAS		0x0004
> > >>> +#define SARADC_ADC_STATUS	BIT(0)
> > >>> +#define SARADC_CTRL		0x0008
> > >>> +#define SARADC_INPUT_SRC_MSK	0x7
> > >>> +#define SARADC_POWER_CTRL	BIT(3)
> > >>> +
> > >>>   #define DTB_DIR			"rockchip/"
> > >>>   struct rg3xx_model {
> > >>> @@ -118,12 +130,64 @@ static const struct rg353_panel rg353_panel_details[] = {
> > >>>   	},
> > >>>   };
> > >>> +/*
> > >>> + * The device has internal eMMC, and while some devices have an exposed
> > >>> + * clk pin you can ground to force a bypass not all devices do. As a
> > >>> + * result it may be possible for some devices to become a perma-brick
> > >>> + * if a corrupted TPL or SPL stage with a valid header is flashed to
> > >>> + * the internal eMMC. Add functionality to read ADC channel 0 (the func
> > >>> + * button) as early as possible in the boot process to provide some
> > >>> + * protection against this. If we ever get an open TPL stage, we should
> > >>> + * consider moving this function there.
> > >>> + */
> > >>> +void read_func_button(void)
> > >>> +{
> > >>> +	int ret;
> > >>> +	u32 reg;
> > >>> +
> > >>> +	/* Turn off SARADC to reset it. */
> > >>> +	writel(0, (SARADC_BASE + SARADC_CTRL));
> > >>> +
> > >>> +	/* Enable channel 0 and power on SARADC. */
> > >>> +	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> > >>> +	       (SARADC_BASE + SARADC_CTRL));
> > >>> +
> > >>> +	/*
> > >>> +	 * Wait for data to be ready. Use timeout of 20000us from
> > >>> +	 * rockchip_saradc driver.
> > >>> +	 */
> > >>> +	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> > >>> +				 !(reg & SARADC_ADC_STATUS), 20000);
> > >>> +	if (ret) {
> > >>> +		printf("ADC Timeout");
> > >>> +		return;
> > >>> +	}
> > >>> +
> > >>> +	/* Read the data from the SARADC. */
> > >>> +	reg = readl((SARADC_BASE + SARADC_DATA));
> > >>> +
> > >>> +	/* Turn the SARADC back off so it's ready to be used again. */
> > >>> +	writel(0, (SARADC_BASE + SARADC_CTRL));
> > >>> +
> > >>> +	/*
> > >>> +	 * If the value is less than 30 the button is being pressed.
> > >>> +	 * Reset the device back into Rockchip download mode.
> > >>> +	 */
> > >>> +	if (reg <= 30) {
> > >>> +		printf("download key pressed, entering download mode...");
> > >>> +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> > >>> +		do_reset(NULL, 0, 0, NULL);
> > >>> +	}
> > >>> +};
> > >>> +
> > >>>   /*
> > >>>    * Start LED very early so user knows device is on. Set color
> > >>>    * to red.
> > >>>    */
> > >>>   void spl_board_init(void)
> > >>>   {
> > >>> +	read_func_button();
> > >>> +
> > >>>   	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
> > >>>   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
> > >>>   	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
> > 
