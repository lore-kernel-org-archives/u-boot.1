Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D79FC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFBC8697B;
	Wed, 16 Aug 2023 17:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="V9GIUvHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7EF8697B; Wed, 16 Aug 2023 17:02:33 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97CD1868B6
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [172.20.10.2] (unknown [109.166.130.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FD9F6607208;
 Wed, 16 Aug 2023 16:02:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692198150;
 bh=mtEsRyma/FuThrFZlwNFKekF6EvE6bdVSExy3qNgWJw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=V9GIUvHpGWO4XF3dSUYh1tZHO+O7Cd6/bErLUbylKuotXiF0EFNDnxnadlccnnMF9
 3OmncKY69Kz3NTjGbKo/jXYUoT3vD4U5ZIbl1lCCcDp1YHwlqPb/8GGyoG09xY2K2v
 xqgRFmpqJGFinCs35WOOHWvC7XHU8yfQ1E+orZDsHVTGvtjAJQrlbHGbscKl/BoC1c
 g7QdBSbTjv/KdkR78m/fedLrItIudG+hjLEn1Niny7InQqJBn9EICWdvivzxqxMklo
 I4c2lLb+nBrczmyXAw2hCJeMrB2ntyGUrPMXGXCZyc2TUU4quR3JBjCQqDtoikNrCe
 U9wg/KV5NBwNQ==
Message-ID: <baf45414-a81e-06df-6727-9b7a0976f8d4@collabora.com>
Date: Wed, 16 Aug 2023 18:02:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] configs: at91: sam9x60: Switch to new reset driver
Content-Language: en-US
To: Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>, u-boot@lists.denx.de,
 Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-3-ada@thorsis.com>
 <b3185256-aff2-eb6e-eae3-7ce9fe2ddd87@collabora.com>
 <20230816-onscreen-detective-13352326d0df@ifak-system.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230816-onscreen-detective-13352326d0df@ifak-system.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/16/23 16:42, Alexander Dahl wrote:
> Hei hei,
> 
> Am Wed, Aug 16, 2023 at 03:48:25PM +0300 schrieb Eugen Hristev:
>>
>> Hi Alexander,
>>
>> On 8/9/23 17:16, Alexander Dahl wrote:
>>> Since commit 61040097a9d1 ("reset: at91: Add reset driver for basic
>>> assert/deassert operations") the compatible "microchip,sam9x60-rstc" for
>>> the sam9x60 reset controller in sam9x60.dtsi is not handled by
>>> CONFIG_SYSRESET_AT91 anymore, but by CONFIG_RESET_AT91 now.  This
>>> resulted in the following error message, when trying to reset from
>>> U-Boot shell:
>>>
>>>       U-Boot> reset
>>>       resetting ...
>>>       System reset not supported on this platform
>>>       ### ERROR ### Please RESET the board ###
>>>
>>> Fixed with the switch to the new driver.  Tested on sam9x60-curiosity
>>> board.  Defconfigs for sam9x60ek adapted in the same way, but without
>>> testing.  These should be all sam9x60 boards affected in U-Boot here.
>>
>>  From what I remember from the top of my head, it makes sense to use the new
>> reset driver, however, you should not remove the old SYSRESET driver,
>> because that driver handles different kind of resets on the SoC and PHYs.
>> Can you double check that?
> 
> Had a look into it and TBH it's very confusing to me.  I found no help
> in documentation.  There are two different uclass which from the
> outside seem to do the same thing.  The Kconfig help texts do not
> explain what the purpose is of one over the other.  As a user this
> creates very bad user experience: Do I need one or the other or both?

Maybe I can shed some light into it.
U-boot, unlike Linux, is a bit more modular in a few aspects, as in this 
RESET vs SYSRESET case.
 From my understanding, RESET is used to reset the board and SYSRESET 
for general reset purposes: reset a PHY, reset something else, etc.
DT-bindings are done by Linux guys, and in Linux, we have a single 
driver for all above (it's similar with PINCTRL and GPIO, one linux 
driver, but two different u-boot UCLASS), so we have just one 
compatible, but U-boot needs to probe two drivers to achieve all the 
wanted functionality !
And we are forced to use the bindings from Linux (little rant), so just 
one U-boot driver is bound to the compatible at boot time. Then, the 
second driver, has to be manually bound by the first driver, and it does 
not have a compatible into it.

I think some of the stuff I explained(poorly) should be readable from 
this patch https://lists.denx.de/pipermail/u-boot/2022-December/501618.html

To simply answer your question, you would need both.

> 
> Then there's CONFIG_SYSRESET_CMD_RESET which implicates there are more
> than one possible implementations for cmd 'reset' … but which is the
> right one.  The help text does not explain.
> 
> I though sysreset is old and reset is new and assumed things get
> migrated like in other subsystems.  But here it seems we have two
> entangled subsystems where one hooks into the other (as reset_at91
> does).
> 
> So, I can of course _just_ enable CONFIG_RESET_AT91 and hope for the
> best here, keeping SYSRESET_CMD_RESET as is … but it would be very
> nice if someone else could explain the what and why in help texts and
> documentation!
> 
> Greets
> Alex
> 
> P.S.: I would have added sysreset or reset subsystem maintainer to Cc,
> but according to MAINTAINERS there is none.
> 
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>    configs/sam9x60_curiosity_mmc1_defconfig | 4 ++--
>>>    configs/sam9x60_curiosity_mmc_defconfig  | 4 ++--
>>>    configs/sam9x60ek_mmc_defconfig          | 4 ++--
>>>    configs/sam9x60ek_nandflash_defconfig    | 4 ++--
>>>    configs/sam9x60ek_qspiflash_defconfig    | 4 ++--
>>>    5 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/configs/sam9x60_curiosity_mmc1_defconfig b/configs/sam9x60_curiosity_mmc1_defconfig
>>> index 21b2cc2edd..e8781b363b 100644
>>> --- a/configs/sam9x60_curiosity_mmc1_defconfig
>>> +++ b/configs/sam9x60_curiosity_mmc1_defconfig
>>> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>>>    CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
>>>    CONFIG_SYS_PROMPT="U-Boot> "
>>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>> +CONFIG_DM_RESET=y
>>>    CONFIG_DEBUG_UART_BASE=0xfffff200
>>>    CONFIG_DEBUG_UART_CLOCK=200000000
>>>    CONFIG_DEBUG_UART_BOARD_INIT=y
>>> @@ -79,11 +80,10 @@ CONFIG_PHY_MICREL=y
>>>    CONFIG_MACB=y
>>>    CONFIG_PINCTRL=y
>>>    CONFIG_PINCTRL_AT91=y
>>> +CONFIG_RESET_AT91=y
>>>    CONFIG_DM_SERIAL=y
>>>    CONFIG_DEBUG_UART_ANNOUNCE=y
>>>    CONFIG_ATMEL_USART=y
>>> -CONFIG_SYSRESET=y
>>> -CONFIG_SYSRESET_AT91=y
>>>    CONFIG_TIMER=y
>>>    CONFIG_MCHP_PIT64B_TIMER=y
>>>    CONFIG_W1=y
>>> diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
>>> index 269f015989..0f57588d8b 100644
>>> --- a/configs/sam9x60_curiosity_mmc_defconfig
>>> +++ b/configs/sam9x60_curiosity_mmc_defconfig
>>> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>>>    CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
>>>    CONFIG_SYS_PROMPT="U-Boot> "
>>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>> +CONFIG_DM_RESET=y
>>>    CONFIG_DEBUG_UART_BASE=0xfffff200
>>>    CONFIG_DEBUG_UART_CLOCK=200000000
>>>    CONFIG_DEBUG_UART_BOARD_INIT=y
>>> @@ -79,11 +80,10 @@ CONFIG_PHY_MICREL=y
>>>    CONFIG_MACB=y
>>>    CONFIG_PINCTRL=y
>>>    CONFIG_PINCTRL_AT91=y
>>> +CONFIG_RESET_AT91=y
>>>    CONFIG_DM_SERIAL=y
>>>    CONFIG_DEBUG_UART_ANNOUNCE=y
>>>    CONFIG_ATMEL_USART=y
>>> -CONFIG_SYSRESET=y
>>> -CONFIG_SYSRESET_AT91=y
>>>    CONFIG_TIMER=y
>>>    CONFIG_MCHP_PIT64B_TIMER=y
>>>    CONFIG_W1=y
>>> diff --git a/configs/sam9x60ek_mmc_defconfig b/configs/sam9x60ek_mmc_defconfig
>>> index 2a1399748c..446caceba0 100644
>>> --- a/configs/sam9x60ek_mmc_defconfig
>>> +++ b/configs/sam9x60ek_mmc_defconfig
>>> @@ -15,6 +15,7 @@ CONFIG_DM_GPIO=y
>>>    CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
>>>    CONFIG_SYS_PROMPT="U-Boot> "
>>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>> +CONFIG_DM_RESET=y
>>>    CONFIG_DEBUG_UART_BASE=0xfffff200
>>>    CONFIG_DEBUG_UART_CLOCK=200000000
>>>    CONFIG_DEBUG_UART_BOARD_INIT=y
>>> @@ -87,14 +88,13 @@ CONFIG_PHY_MICREL=y
>>>    CONFIG_MACB=y
>>>    CONFIG_PINCTRL=y
>>>    CONFIG_PINCTRL_AT91=y
>>> +CONFIG_RESET_AT91=y
>>>    CONFIG_DM_SERIAL=y
>>>    CONFIG_DEBUG_UART_ANNOUNCE=y
>>>    CONFIG_ATMEL_USART=y
>>>    CONFIG_SPI=y
>>>    CONFIG_DM_SPI=y
>>>    CONFIG_ATMEL_QSPI=y
>>> -CONFIG_SYSRESET=y
>>> -CONFIG_SYSRESET_AT91=y
>>>    CONFIG_TIMER=y
>>>    CONFIG_ATMEL_PIT_TIMER=y
>>>    CONFIG_W1=y
>>> diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
>>> index c6c4686658..acaa16ee49 100644
>>> --- a/configs/sam9x60ek_nandflash_defconfig
>>> +++ b/configs/sam9x60ek_nandflash_defconfig
>>> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>>>    CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
>>>    CONFIG_SYS_PROMPT="U-Boot> "
>>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>> +CONFIG_DM_RESET=y
>>>    CONFIG_DEBUG_UART_BASE=0xfffff200
>>>    CONFIG_DEBUG_UART_CLOCK=200000000
>>>    CONFIG_DEBUG_UART_BOARD_INIT=y
>>> @@ -89,14 +90,13 @@ CONFIG_PHY_MICREL=y
>>>    CONFIG_MACB=y
>>>    CONFIG_PINCTRL=y
>>>    CONFIG_PINCTRL_AT91=y
>>> +CONFIG_RESET_AT91=y
>>>    CONFIG_DM_SERIAL=y
>>>    CONFIG_DEBUG_UART_ANNOUNCE=y
>>>    CONFIG_ATMEL_USART=y
>>>    CONFIG_SPI=y
>>>    CONFIG_DM_SPI=y
>>>    CONFIG_ATMEL_QSPI=y
>>> -CONFIG_SYSRESET=y
>>> -CONFIG_SYSRESET_AT91=y
>>>    CONFIG_TIMER=y
>>>    CONFIG_ATMEL_PIT_TIMER=y
>>>    CONFIG_W1=y
>>> diff --git a/configs/sam9x60ek_qspiflash_defconfig b/configs/sam9x60ek_qspiflash_defconfig
>>> index ef2e2db8b8..6fb79214e5 100644
>>> --- a/configs/sam9x60ek_qspiflash_defconfig
>>> +++ b/configs/sam9x60ek_qspiflash_defconfig
>>> @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
>>>    CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
>>>    CONFIG_SYS_PROMPT="U-Boot> "
>>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>> +CONFIG_DM_RESET=y
>>>    CONFIG_DEBUG_UART_BASE=0xfffff200
>>>    CONFIG_DEBUG_UART_CLOCK=200000000
>>>    CONFIG_DEBUG_UART_BOARD_INIT=y
>>> @@ -88,14 +89,13 @@ CONFIG_PHY_MICREL=y
>>>    CONFIG_MACB=y
>>>    CONFIG_PINCTRL=y
>>>    CONFIG_PINCTRL_AT91=y
>>> +CONFIG_RESET_AT91=y
>>>    CONFIG_DM_SERIAL=y
>>>    CONFIG_DEBUG_UART_ANNOUNCE=y
>>>    CONFIG_ATMEL_USART=y
>>>    CONFIG_SPI=y
>>>    CONFIG_DM_SPI=y
>>>    CONFIG_ATMEL_QSPI=y
>>> -CONFIG_SYSRESET=y
>>> -CONFIG_SYSRESET_AT91=y
>>>    CONFIG_TIMER=y
>>>    CONFIG_ATMEL_PIT_TIMER=y
>>>    CONFIG_W1=y
>>

