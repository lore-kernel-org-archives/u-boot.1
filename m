Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A524CC47DB7
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 09:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280D787BB4;
	Fri, 19 Jan 2024 10:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AYp/y/uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B98B87BBD; Fri, 19 Jan 2024 10:01:49 +0100 (CET)
Received: from mail-m127160.xmail.ntesmail.com
 (mail-m127160.xmail.ntesmail.com [115.236.127.160])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56C187B8E
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 10:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=AYp/y/uqNcDwVuEi/Y6uGRqv2wqFIN9wdrPJ3UQpHm8HnfAQtb+SQJXAJNpk1TmOwYWFnYipPaDyFBS0xeJ0XJxirk+36oe0ohSEAxK/LbIlEKHRlN9GpSZ12okXZtPV60A80Ds7AB9z63j3qJFG7Fyvz8hPY3h2XXsoW2/Crjc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=RJnHDT/v4JNW+k4qmILWEQzQqEaoKyX4CupZ0mNB4IQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m12758.qiye.163.com (Hmail) with ESMTPA id 9C118AE302F;
 Fri, 19 Jan 2024 17:01:38 +0800 (CST)
Message-ID: <706a4a06-51ad-421a-ac58-621ce85062f6@rock-chips.com>
Date: Fri, 19 Jan 2024 17:01:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/7] rockchip: boot_mode: Allow
 rockchip_dnl_key_pressed() in SPL
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, jagan@edgeble.ai, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-4-macroalpha82@gmail.com>
 <9aae0791-84a5-42b4-b76d-2a89040b23d0@rock-chips.com>
 <65a93e77.9d0a0220.46f34.1553@mx.google.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <65a93e77.9d0a0220.46f34.1553@mx.google.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NCT1ZJTxodT05OHx9MHUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d20f4509fb225kuuu9c118ae302f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6DAw5HzwjLhQsAhU3Hwo8
 GA4aCjNVSlVKTEtOTU5PQ0JCT0JCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT01PTDcG
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

Hi Chris,

On 2024/1/18 23:06, Chris Morgan wrote:
> On Thu, Jan 18, 2024 at 03:20:52PM +0800, Kever Yang wrote:
>> Hi Chris,
>>
>> On 2024/1/2 23:46, Chris Morgan wrote:
>>> From: Chris Morgan<macromorgan@hotmail.com>
>>>
>>> Update the rockchip_dnl_key_pressed() so that it can run in
>>> SPL. Also change the ADC channel to a define that can be
>>> overridden by a board specific option.
>> I should ask this earlier.
>>
>> Why you have to enable the download key in SPL?
>>
>> This works for a long time in U-Boot proper, both mainline and downstream
>> vendor U-Boot,
>>
>> no one is detect this download key in SPL.
>>
>> In theory the SPL can implement all the feature which is available in U-Boot
>> proper,
>>
>> but it would be better to make the SPL focus on the job it should be done
>> and keep as small as possible.
>>
> I wanted this code to run as soon as possible in the event of a bad
> write. I have some devices which lack a way to bypass the eMMC in the
> boot path; the fear is that if an SPL stage is written with a good
> header but a bad payload (or if the A-TF does something wrong) the
> device will become unbootable. If we can't do it this way for
> all Rockchip boards that's fine, but I REALLY want to at least do
> it this way for the Powkiddy X55 board and the Anbernic RGxx3 board.

That's why rockchip platform has two download mode, loader mode(in U-Boot)

and maskRom mode, any error happen before U-Boot should get into maksRom 
mode.

Most of user/developer only use loader mode because the modules before 
U-Boot should

be more stable and have very little chance to update, for the module 
owners before U-Boot,

they are the users of maskRom mode.

If you enable this feature in SPL, the error still have chance to happen 
during dram init to SPL key detect.

Does these two board has no way to get into eMMC event with hardware 
rework? any hardware

signal of eMMC CMD/CLK/DATA is OK.

And another way to bypass eMMC is to use SDcard which has higher 
priority then eMMC in BootRom.

For SPL itself debug, I would suggest to RESET into bootrom download 
mode if any error happen

and a reset will need.

I pick up patches other than 2,3,4 in this patchset for now.

> While I have you, I have a related question I hope you can help with.
> Is there any way to utilize the boot partitions of an eMMC device? I
> don't know if the BROM of an RK3568 or RK3588 is capable, but I'd love
> to have the SPL and U-Boot stages written to the eMMC boot partitions
> instead of the user partition if I can.

No, Rockchip SoCs does not use the boot partitions of eMMC, only use the 
user data partition.


Thanks,

- Kever

>
> Thank you.
>
>> Thanks,
>>
>> - Kever
>>
>>> Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
>>> ---
>>>    arch/arm/mach-rockchip/Makefile    |  4 ++--
>>>    arch/arm/mach-rockchip/boot_mode.c | 11 ++++++++++-
>>>    2 files changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
>>> index 1dc92066bb..ff089ae949 100644
>>> --- a/arch/arm/mach-rockchip/Makefile
>>> +++ b/arch/arm/mach-rockchip/Makefile
>>> @@ -15,13 +15,13 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
>>>    obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
>>> -ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
>>> -
>>>    # Always include boot_mode.o, as we bypass it (i.e. turn it off)
>>>    # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
>>>    # we can have the preprocessor correctly recognise both 0x0 and 0
>>>    # meaning "turn it off".
>>>    obj-y += boot_mode.o
>>> +
>>> +ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
>>>    obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
>>>    obj-$(CONFIG_MISC_INIT_R) += misc.o
>>>    endif
>>> diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
>>> index eb8f65ae4e..d2308768be 100644
>>> --- a/arch/arm/mach-rockchip/boot_mode.c
>>> +++ b/arch/arm/mach-rockchip/boot_mode.c
>>> @@ -38,6 +38,10 @@ void set_back_to_bootrom_dnl_flag(void)
>>>    #define KEY_DOWN_MIN_VAL	0
>>>    #define KEY_DOWN_MAX_VAL	30
>>> +#ifndef RK_DNL_ADC_CHAN
>>> +#define RK_DNL_ADC_CHAN		1
>>> +#endif
>>> +
>>>    __weak int rockchip_dnl_key_pressed(void)
>>>    {
>>>    	unsigned int val;
>>> @@ -52,7 +56,8 @@ __weak int rockchip_dnl_key_pressed(void)
>>>    	ret = -ENODEV;
>>>    	uclass_foreach_dev(dev, uc) {
>>>    		if (!strncmp(dev->name, "saradc", 6)) {
>>> -			ret = adc_channel_single_shot(dev->name, 1, &val);
>>> +			ret = adc_channel_single_shot(dev->name,
>>> +						      RK_DNL_ADC_CHAN, &val);
>>>    			break;
>>>    		}
>>>    	}
>>> @@ -73,11 +78,13 @@ __weak int rockchip_dnl_key_pressed(void)
>>>    void rockchip_dnl_mode_check(void)
>>>    {
>>> +#if CONFIG_IS_ENABLED(ADC)
>>>    	if (rockchip_dnl_key_pressed()) {
>>>    		printf("download key pressed, entering download mode...");
>>>    		set_back_to_bootrom_dnl_flag();
>>>    		do_reset(NULL, 0, 0, NULL);
>>>    	}
>>> +#endif
>>>    }
>>>    int setup_boot_mode(void)
>>> @@ -90,6 +97,7 @@ int setup_boot_mode(void)
>>>    	boot_mode = readl(reg);
>>>    	debug("%s: boot mode 0x%08x\n", __func__, boot_mode);
>>> +#if !defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
>>>    	/* Clear boot mode */
>>>    	writel(BOOT_NORMAL, reg);
>>> @@ -103,6 +111,7 @@ int setup_boot_mode(void)
>>>    		env_set("preboot", "setenv preboot; ums mmc 0");
>>>    		break;
>>>    	}
>>> +#endif
>>>    	return 0;
>>>    }
