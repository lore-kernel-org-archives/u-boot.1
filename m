Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AEED2E9D0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA3F8932C;
	Mon, 11 Nov 2024 11:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MlCUR1Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA16089342; Mon, 11 Nov 2024 11:09:26 +0100 (CET)
Received: from mail-m121144.qiye.163.com (mail-m121144.qiye.163.com
 [115.236.121.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09B38931A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 267b1cc6;
 Mon, 11 Nov 2024 18:09:18 +0800 (GMT+08:00)
Message-ID: <1438d4a4-fbd8-4b45-a120-b032f07bb82b@rock-chips.com>
Date: Mon, 11 Nov 2024 18:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308: Drop unused rk_board_init()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
References: <20241102204516.3633375-1-jonas@kwiboo.se>
 <0832ba14-20b4-4db4-9e91-e64b0b3a14c7@rock-chips.com>
 <0c14ca7b-f534-49f4-820f-b17ebd3c09d4@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <0c14ca7b-f534-49f4-820f-b17ebd3c09d4@kwiboo.se>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktPTFZMSEpOTh5OQk5PGE5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a931ab2fe8c03afkunm267b1cc6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6KTo5OjIYDiIXNzUcOU0O
 EioKFBRVSlVKTEhKSEpCTE5CSE9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU1CQjcG
DKIM-Signature: a=rsa-sha256;
 b=MlCUR1Uv7apXSD8L95RqXItRhfLdl77yJWmn+sJH5InvGJBtzB083hAoKIhmhdsqXzNyJfLcu+Mble87tGGNCb8WwtPqmZSJG533QMxwAKgzCzOQQRE5QQw5TCMDd+IfQWrNnAdGp2EkklgMI44x4ksTjcEhiKICANdDAIOSXZY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=4EcFeGWoHhEKB4ILsRsSgNnxW81ef+MF0X8Vfz7Wqgo=;
 h=date:mime-version:subject:message-id:from;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Jonas,

On 2024/11/11 17:41, Jonas Karlman wrote:
> Hi Kever,
>
> On 2024-11-07 02:45, Kever Yang wrote:
>> Hi Jonas,
>>
>> On 2024/11/3 04:45, Jonas Karlman wrote:
>>> Nothing is calling the function rk_board_init() and the io-domain driver
>>> can handle the functions intended purpose based on information from DT.
>> Yes, this  should be take care by the new io-domain driver if the dts
>> also has correctly config.
>>
>> The io-domain driver is used for rk3568 firstly, because the IO will
>> broken if the io voltage is not
>>
>> setting correctly(the IO looks working before it's broken).
>>
>> The cleanup is fine because there is no one to use it, and it would be
>> better to make sure the
>>
>> IO voltage of  rk3308 VCCIO3 is also setting correctly for all boards.
> All current supported rk3308 boards in mainline Linux and U-Boot
> correctly signal IO voltage using GPIO0_A4 according to schematics.
>
> rk3308-evb.dts and rk3308-roc-cc.dts is missing the io_domains node in
> Linux, as I only added the node to boards I had (Rock Pi S and ROCK S0).
>
> Is there something more you want me to do in regards to this patch?
I just want to make sure the io-domain driver also works correctly for 
rk3308, because it's
first used for rk3568 and potentially not correctly adapt for rk3308 in 
driver side or dts side.
For this patch itself, it's OK to apply  because the board does not 
really use it.

In some board design, theGPIO0_A4 in rk3308 board is used to signal IO 
voltage at the beginning,
and then this IO can be release to use for other purpose, that's why we 
have to init this in U-Boot
and out of the io-domain frame work which the GPIO0_A4 in dts can only 
used for only one purpose.

Thanks,
- Kever
>
> Can possible add a second/send a separate patch that enable
> ROCKCHIP_IODOMAIN for ROCKCHIP_RK3308, then someone just have to submit
> io_domains patches to Linux and it will eventually be synced to U-Boot
> during a future dts/upstream sync.
>
> Regards,
> Jonas
>
>> Thanks,
>> - Kever
>>> Cleanup by removing the unused rk_board_init() function and re-sort
>>> included headers.
>>>
>>> Signed-off-by: Jonas Karlman<jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/rk3308/rk3308.c | 69 +-------------------------
>>>    1 file changed, 1 insertion(+), 68 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
>>> index 03d97e1d7460..6916f1a24441 100644
>>> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
>>> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
>>> @@ -3,15 +3,12 @@
>>>     *Copyright (c) 2018 Rockchip Electronics Co., Ltd
>>>     */
>>>    #include <init.h>
>>> -#include <malloc.h>
>>> +#include <asm/armv8/mmu.h>
>>>    #include <asm/arch-rockchip/bootrom.h>
>>>    #include <asm/arch-rockchip/grf_rk3308.h>
>>>    #include <asm/arch-rockchip/hardware.h>
>>> -#include <asm/gpio.h>
>>> -#include <debug_uart.h>
>>>    #include <linux/bitops.h>
>>>    
>>> -#include <asm/armv8/mmu.h>
>>>    static struct mm_region rk3308_mem_map[] = {
>>>    	{
>>>    		.virt = 0x0UL,
>>> @@ -38,22 +35,6 @@ struct mm_region *mem_map = rk3308_mem_map;
>>>    #define SGRF_BASE	0xff2b0000
>>>    
>>>    enum {
>>> -	GPIO1C7_SHIFT		= 8,
>>> -	GPIO1C7_MASK		= GENMASK(11, 8),
>>> -	GPIO1C7_GPIO		= 0,
>>> -	GPIO1C7_UART1_RTSN,
>>> -	GPIO1C7_UART2_TX_M0,
>>> -	GPIO1C7_SPI2_MOSI,
>>> -	GPIO1C7_JTAG_TMS,
>>> -
>>> -	GPIO1C6_SHIFT		= 4,
>>> -	GPIO1C6_MASK		= GENMASK(7, 4),
>>> -	GPIO1C6_GPIO		= 0,
>>> -	GPIO1C6_UART1_CTSN,
>>> -	GPIO1C6_UART2_RX_M0,
>>> -	GPIO1C6_SPI2_MISO,
>>> -	GPIO1C6_JTAG_TCLK,
>>> -
>>>    	GPIO4D3_SHIFT           = 6,
>>>    	GPIO4D3_MASK            = GENMASK(7, 6),
>>>    	GPIO4D3_GPIO            = 0,
>>> @@ -116,60 +97,12 @@ enum {
>>>    	GPIO2A2_SEL_SRC_CTRL_SEL_PLUS	= 1,
>>>    };
>>>    
>>> -enum {
>>> -	IOVSEL3_CTRL_SHIFT	= 8,
>>> -	IOVSEL3_CTRL_MASK	= BIT(8),
>>> -	VCCIO3_SEL_BY_GPIO	= 0,
>>> -	VCCIO3_SEL_BY_IOVSEL3,
>>> -
>>> -	IOVSEL3_SHIFT		= 3,
>>> -	IOVSEL3_MASK		= BIT(3),
>>> -	VCCIO3_3V3		= 0,
>>> -	VCCIO3_1V8,
>>> -};
>>> -
>>> -/*
>>> - * The voltage of VCCIO3(which is the voltage domain of emmc/flash/sfc
>>> - * interface) can indicated by GPIO0_A4 or io_vsel3. The SOC defaults
>>> - * use GPIO0_A4 to indicate power supply voltage for VCCIO3 by hardware,
>>> - * then we can switch to io_vsel3 after system power on, and release GPIO0_A4
>>> - * for other usage.
>>> - */
>>> -
>>> -#define GPIO0_A4	4
>>> -
>>>    const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>    	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
>>>    	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",
>>>    	[BROM_BOOTSOURCE_SD] = "/mmc@ff480000",
>>>    };
>>>    
>>> -int rk_board_init(void)
>>> -{
>>> -	static struct rk3308_grf * const grf = (void *)GRF_BASE;
>>> -	u32 val;
>>> -	int ret;
>>> -
>>> -	ret = gpio_request(GPIO0_A4, "gpio0_a4");
>>> -	if (ret < 0) {
>>> -		printf("request for gpio0_a4 failed:%d\n", ret);
>>> -		return 0;
>>> -	}
>>> -
>>> -	gpio_direction_input(GPIO0_A4);
>>> -
>>> -	if (gpio_get_value(GPIO0_A4))
>>> -		val = VCCIO3_SEL_BY_IOVSEL3 << IOVSEL3_CTRL_SHIFT |
>>> -		      VCCIO3_1V8 << IOVSEL3_SHIFT;
>>> -	else
>>> -		val = VCCIO3_SEL_BY_IOVSEL3 << IOVSEL3_CTRL_SHIFT |
>>> -		      VCCIO3_3V3 << IOVSEL3_SHIFT;
>>> -	rk_clrsetreg(&grf->soc_con0, IOVSEL3_CTRL_MASK | IOVSEL3_MASK, val);
>>> -
>>> -	gpio_free(GPIO0_A4);
>>> -	return 0;
>>> -}
>>> -
>>>    #ifdef CONFIG_DEBUG_UART_BOARD_INIT
>>>    __weak void board_debug_uart_init(void)
>>>    {
>
