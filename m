Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0D8C25B47
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1830487243;
	Mon, 23 Oct 2023 19:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wEC+AN8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C609887243; Mon, 23 Oct 2023 19:12:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E383E86F48
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f498=GG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1698081139;
 bh=JQH2vuhjyMyBh4sXu/goY2NVCXhsAt9TQJYmhzwTl6Q=;
 b=wEC+AN8ogHZ2sPlx62XmfS6VBgvWwIsYF9qwtQvp+LZqbG89JRL/kdF7HoCFZuBKUpY1trmKS
 7P1UioLsUK8oC13QOHcKNnNq4XTmwWwlLgmG28qbDjf3SUHeuyWqHZu5sTp/ACLl+UqtSB63NDN
 p2iIPsGTAnFaBwk8JevHZHJ1o+TQYpzw8d1ZwG6aUw5GUC1Qq08ohMElWXgBqD4ljZvG887liq+
 lLdAKsKQYSrYliWZ0KVOa1WkvrQ1a9hzoFIF8hQFCpq0UUoSaSbwZUErOGh21Bdmf+K09+2wwcd
 Uc5MBlraZsRYbqjcFGOwm52obpUwGG7AcuGbBlpbA84w==
Message-ID: <f6247d64-78ea-477c-a877-aa591cd3508a@kwiboo.se>
Date: Mon, 23 Oct 2023 19:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] board: rockchip: Add Maskrom Mode for Anbernic RGxx3
To: Chris Morgan <macromorgan@hotmail.com>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
References: <20231017182414.321411-1-macroalpha82@gmail.com>
 <20231017182414.321411-3-macroalpha82@gmail.com>
 <3ea38028-1ab1-4dfd-8b5e-eb6eb79dd0eb@rock-chips.com>
 <SN6PR06MB5342813C5A872A749D01A588A5D8A@SN6PR06MB5342.namprd06.prod.outlook.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <SN6PR06MB5342813C5A872A749D01A588A5D8A@SN6PR06MB5342.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6536a9739229513836a9bb91
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

Hi Chris,

On 2023-10-23 17:18, Chris Morgan wrote:
> On Mon, Oct 23, 2023 at 06:10:07PM +0800, Kever Yang wrote:
>> Hi Chris,
>>
>> On 2023/10/18 02:24, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Add support for users to enter maskrom mode by holding the function
>>> button when they power up the device.
>>>
>>> Since the device has soldered eMMC and sometimes does not expose a clk
>>> pin on the mainboard
>>
>> This board already available, so does this clk pin available?
>>
>> Not only clk, other cmd/data pin is also OK to make the soc get into maskrom
>> mode.
> 
> No, as near as I can tell some boards (such as the 353P and 353V) don't
> expose a clk, cmd, or data pin. The 353M does expose a clk pin though.
> 
>>
>>> there is a small chance that a user who flashes a
>>> bad bootloader may not be able to recover if the headers themselves
>>> are valid. As a result this check is done during spl_early_init() to
>>> ensure that it runs as early as possible, and it does so by directly
>>> manipulating the ADC hardware in lieu of loading the ADC driver.
>>
>> This key seems like a "recovery" adc key instead of "maskrom" key, right?
>>
>> I think we don't need to add this patch if the hardware does not really have
>> a "maskrom" key.
>>
>> Basically the "maskrom" key should not depends on any software.
> 
> Okay, so should I rename it as a "recovery" key? Basically it's just
> a button hooked up to ADC channel 0. I'm trying to make as simple a
> failsafe as possible, because for the boards without the clk/cmd pads
> I want to make it easy to debrick in the event of something like a
> bad U-Boot stage or a bad A-TF stage.

Isn't this very similar to what arch/arm/mach-rockchip/boot_mode.c and
rockchip_dnl_key_pressed() already does, or is supposed to do?

Maybe this existing code can be changed/fixed to work earlier in SPL and
possible also read recovery button information from DT or Kconfig to
work with more rockchip boards?

Would be nice if a hang/panic in SPL make rk devices reset into maskrom
usb mode. Maybe even the watchdog can be of some use here.

Btw, you could probably also enable CONFIG_SPL_FIT_SIGNATURE for added
protection against starting corrupt/bitrot FIT images. To speed up boot
after adding a sha256 checksum test, you can use following rfc/patch:

[RFC] rockchip: spl: Enable caches to speed up checksum validation
https://patchwork.ozlabs.org/patch/1802303/

Regards,
Jonas

> 
> Thank you.
> 
>>
>>
>> Thanks,
>>
>> - Kever
>>
>>>
>>> Ideally, once we have an open source TPL stage we can move this to
>>> the TPL stage, so it will run even earlier.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
>>>   1 file changed, 64 insertions(+)
>>>
>>> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
>>> index 3d0c614623..a93b11cd47 100644
>>> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
>>> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
>>> @@ -6,12 +6,14 @@
>>>   #include <abuf.h>
>>>   #include <adc.h>
>>>   #include <asm/io.h>
>>> +#include <command.h>
>>>   #include <display.h>
>>>   #include <dm.h>
>>>   #include <dm/lists.h>
>>>   #include <env.h>
>>>   #include <fdt_support.h>
>>>   #include <linux/delay.h>
>>> +#include <linux/iopoll.h>
>>>   #include <mipi_dsi.h>
>>>   #include <mmc.h>
>>>   #include <panel.h>
>>> @@ -20,6 +22,8 @@
>>>   #include <stdlib.h>
>>>   #include <video_bridge.h>
>>> +#define BOOT_BROM_DOWNLOAD	0xef08a53c
>>> +
>>>   #define GPIO0_BASE		0xfdd60000
>>>   #define GPIO4_BASE		0xfe770000
>>>   #define GPIO_SWPORT_DR_L	0x0000
>>> @@ -33,6 +37,14 @@
>>>   #define GPIO_WRITEMASK(bits)	((bits) << 16)
>>> +#define SARADC_BASE		0xfe720000
>>> +#define SARADC_DATA		0x0000
>>> +#define SARADC_STAS		0x0004
>>> +#define SARADC_ADC_STATUS	BIT(0)
>>> +#define SARADC_CTRL		0x0008
>>> +#define SARADC_INPUT_SRC_MSK	0x7
>>> +#define SARADC_POWER_CTRL	BIT(3)
>>> +
>>>   #define DTB_DIR			"rockchip/"
>>>   struct rg3xx_model {
>>> @@ -118,12 +130,64 @@ static const struct rg353_panel rg353_panel_details[] = {
>>>   	},
>>>   };
>>> +/*
>>> + * The device has internal eMMC, and while some devices have an exposed
>>> + * clk pin you can ground to force a bypass not all devices do. As a
>>> + * result it may be possible for some devices to become a perma-brick
>>> + * if a corrupted TPL or SPL stage with a valid header is flashed to
>>> + * the internal eMMC. Add functionality to read ADC channel 0 (the func
>>> + * button) as early as possible in the boot process to provide some
>>> + * protection against this. If we ever get an open TPL stage, we should
>>> + * consider moving this function there.
>>> + */
>>> +void read_func_button(void)
>>> +{
>>> +	int ret;
>>> +	u32 reg;
>>> +
>>> +	/* Turn off SARADC to reset it. */
>>> +	writel(0, (SARADC_BASE + SARADC_CTRL));
>>> +
>>> +	/* Enable channel 0 and power on SARADC. */
>>> +	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
>>> +	       (SARADC_BASE + SARADC_CTRL));
>>> +
>>> +	/*
>>> +	 * Wait for data to be ready. Use timeout of 20000us from
>>> +	 * rockchip_saradc driver.
>>> +	 */
>>> +	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
>>> +				 !(reg & SARADC_ADC_STATUS), 20000);
>>> +	if (ret) {
>>> +		printf("ADC Timeout");
>>> +		return;
>>> +	}
>>> +
>>> +	/* Read the data from the SARADC. */
>>> +	reg = readl((SARADC_BASE + SARADC_DATA));
>>> +
>>> +	/* Turn the SARADC back off so it's ready to be used again. */
>>> +	writel(0, (SARADC_BASE + SARADC_CTRL));
>>> +
>>> +	/*
>>> +	 * If the value is less than 30 the button is being pressed.
>>> +	 * Reset the device back into Rockchip download mode.
>>> +	 */
>>> +	if (reg <= 30) {
>>> +		printf("download key pressed, entering download mode...");
>>> +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
>>> +		do_reset(NULL, 0, 0, NULL);
>>> +	}
>>> +};
>>> +
>>>   /*
>>>    * Start LED very early so user knows device is on. Set color
>>>    * to red.
>>>    */
>>>   void spl_board_init(void)
>>>   {
>>> +	read_func_button();
>>> +
>>>   	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
>>>   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
>>>   	       (GPIO_C7 | GPIO_C6 | GPIO_C5),

