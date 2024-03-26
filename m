Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C14CD11DB
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 09:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A3288005;
	Tue, 26 Mar 2024 10:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fancW6AW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8059087FE3; Tue, 26 Mar 2024 10:17:28 +0100 (CET)
Received: from mail-m127229.xmail.ntesmail.com
 (mail-m127229.xmail.ntesmail.com [115.236.127.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18D387FF2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 10:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fancW6AWtNl4dDeK6KRjJU+ulNprwOdXsq6M6+w8eQLID6wmjaTnY+vku7O4RyAl0onN0ECbhAGS8NxhWRHDTR+KpVtOqZZAk2QbmoHL2jikzOrwrN9TY4xg3hBFQ0zvSrwUs850Hif6rkgcSg6MfGLKWyVf14ouDoy1KZ72Ec0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=+YY2LNoPH/whUb/C7IWsenPafjkAmE3RN62YEMKA0pM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8FD8B90042E;
 Tue, 26 Mar 2024 17:17:09 +0800 (CST)
Message-ID: <0e30aeb8-56ea-4770-975c-85e2827f8fa3@rock-chips.com>
Date: Tue, 26 Mar 2024 17:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ringneck-px30: put STM32_RST line in input mode
 instead of output
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de
References: <20240209-ringneck-stm32-rst-input-v1-1-fa9d23ac8ebe@theobroma-systems.com>
 <03469644-53de-4484-82d7-348531d2148b@rock-chips.com>
 <0b87d8df-9040-432b-8756-17afa0118c40@theobroma-systems.com>
 <0186f16e-ee67-4507-a752-4729bb466a3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <0186f16e-ee67-4507-a752-4729bb466a3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhPTlYZHUpKThkfGBpIGk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e7a0c99e703a9kunm8fd8b90042e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6Vgw4LDMXOFFPSksfQkgs
 PSowCShVSlVKTEpKT09PTUhLSExKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSU1MNwY+
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

Hi Quentin,

On 2024/3/22 17:38, Quentin Schulz wrote:
> Hi Kever,
>
> On 2/19/24 10:50, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 2/18/24 02:14, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/2/9 21:18, Quentin Schulz wrote:
>>>> From: Quentin Schulz<quentin.schulz@theobroma-systems.com>
>>>>
>>>> The STM32_RST line is routed to the ATtiny microcontroller
>>>> PA0/RESET/UPDI pin. By driving the PX30 SoC pin as GPIO output 
>>>> high, we
>>>> prevent external UPDI to be used for flashing without first putting 
>>>> this
>>>> pin as GPIO input, an extra step we could avoid in userspace.
>>>
>>> A little confuse here, this GPIO is an output for PX30, right?So the 
>>> config is:
>>>
>>> 1. the PX30 SPL init STM32_RST as input, with hardware pull-up the 
>>> keep STM32 work;
>>>
>>
>> The pin needs to be high for STM32, and high **but not driven** for 
>> ATtiny in order to allow flashing scripts to work.
>>
>>> 2. when need UPDI for flashing, need to set STM32_RST to output and 
>>> trigger the reset in userspace?
>>>
>>
>> For STM32, STM32_RST needs to be driven low, then STM32_BOOT needs to 
>> be driven high, then STM32_RST needs to be high to deassert reset.
>>
>> For ATtiny, STM32_RST needs to be NOT driven so that UPDI lines can 
>> be used to interact with the MCU. Note that we also have the ability 
>> to do bitbang UPDI on that STM32_RST pin but that's another topic 
>> (just explaining why it is routed while seemingly useless for ATtiny).
>>
>> All the above is for entering the flashing mode.
>>
>> However, in U-Boot we do NOT want to enter flashing mode, we want to 
>> exit it, c.f. 
>> https://lore.kernel.org/u-boot/20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com/
>>
>> An external HW pull-up is required because of glitches on the line 
>> when powering up/down. However, this is only done on newer versions 
>> of the PCB, so we need to tackle old versions.
>>
>> The old versions do not have this external HW pull-up and the glitch 
>> may cause the MCU to enter its flashing mode. Therefore, we force it 
>> to exit the flashing mode by always hard resetting it into the normal 
>> runtime mode. This is what spl_board_init() does. STM32_RST and 
>> STM32_BOOT are controlled by our flashing script for the STM32 
>> variant for the MCU, so the default state when entering the Linux 
>> kernel doesn't matter. For the ATtiny MCU variant, we do not handle 
>> those GPIOs as part of the flashing script, therefore the default 
>> state when entering the Linux kernel should be the expected value for 
>> which we can use UPDI to flash the ATtiny. For ATtiny, the reset line 
>> is shared between STM32_RST that goes to the SoC and the UPDI lines 
>> exposed over the Q7 header. If STM32_RST is driven by the SoC, the 
>> UPDI lines won't be able to interact with the MCU. Therefore it needs 
>> to be put into input mode, whether in U-Boot or in Linux userspace.
>>
>
> Can we have this in the next merge request for next please? Or maybe 
> there's something I need to change here?

I will merge this patch next time when I send the PR.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever


>
> Cheers,
> Quentin
