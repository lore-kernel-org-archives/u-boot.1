Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83893CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C888C836D1;
	Thu, 16 Oct 2025 17:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30DA836EE; Thu, 16 Oct 2025 17:15:45 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D09B836C1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1v9Phf-0000N2-6x; Thu, 16 Oct 2025 17:15:43 +0200
Message-ID: <1b8fbd3c-bce0-47e6-9b7d-72ecd2b67946@pengutronix.de>
Date: Thu, 16 Oct 2025 17:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] armv8: implement workaround for broken CNTFRQ_EL0 value
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20251014-armv8-broken-cntfrq-v1-1-b63f9c69ffcb@disroot.org>
 <e05ec920-c5cc-49b2-9cb5-8444bac84bd9@pengutronix.de>
 <fcc3e6280e222229d2bea42c1402da99@disroot.org>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <fcc3e6280e222229d2bea42c1402da99@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello Kaustabh,

On 10/16/25 4:59 PM, Kaustabh Chakraborty wrote:
> On 2025-10-15 07:48, Ahmad Fatoum wrote:
>>> Thus, the only solution is to add a config option which, when enabled,
>>> returns a hard coded value (CONFIG_COUNTER_FREQUENCY) instead of
>>> querying
>>> CNTFRQ_EL0.
>>
>> Why not read it from the clock-frequency property in the device tree?
>>
>> This is what barebox is now doing, incidentally also for Samsung
>> support, see:
>> https://lore.kernel.org/barebox/20250729203659.1858575-3-
>> ivo.ivanov.ivanov1@gmail.com/
> 
> In barebox, the timer is a device driver, like in linux. In U-Boot
> however, it is
> instead part of the ARM architecture specific code. And it is being
> accessed by
> a single function, not dependent on others.

Ah, I wasn't aware of this.

> However, in U-Boot i found gd->arch.timer_rate_hz, which can be used,
> like so:
> 
>     if (gd->arch.timer_rate_hz)
>         return gd->arch.timer_rate_hz;
> 
> This property needs to be set in board file – in timer_init(). So I will do
> that instead.

:)

Cheers,
Ahmad


> 
>>
>> Cheers,
>> Ahmad
>>
>>>
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>>> ---
>>>  arch/arm/cpu/armv8/Kconfig         | 9 +++++++++
>>>  arch/arm/cpu/armv8/generic_timer.c | 4 ++++
>>>  2 files changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
>>> index
>>> 199335cd6040d30a355a7fd5448a449fa7f550fb..d54d874b7caea200e1c05f522d8affe6d239a102 100644
>>> --- a/arch/arm/cpu/armv8/Kconfig
>>> +++ b/arch/arm/cpu/armv8/Kconfig
>>> @@ -4,6 +4,15 @@ config CMO_BY_VA_ONLY
>>>      bool "Force cache maintenance to be exclusively by VA"
>>>      depends on !SYS_DISABLE_DCACHE_OPS
>>>
>>> +config ARMV8_CNTFRQ_BROKEN
>>> +    bool "Fix broken ARMv8 generic timer"
>>> +    depends on COUNTER_FREQUENCY > 0
>>> +    depends on SYS_ARCH_TIMER
>>> +    help
>>> +      Say Y here if there is no trustable firmware present which sets
>>> +      CNTFRQ_EL0 frequency before U-Boot. U-Boot will use the
>>> +      CONFIG_COUNTER_FREQUENCY value as the reported frequency.
>>> +
>>>  config ARMV8_SPL_EXCEPTION_VECTORS
>>>      bool "Install crash dump exception vectors"
>>>      depends on SPL
>>> diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/
>>> generic_timer.c
>>> index
>>> 1de7ec596fc7cbbc3e78a241f163bc0a4fcad6b6..409570cf6fda79527e296b958368b552900524b1 100644
>>> --- a/arch/arm/cpu/armv8/generic_timer.c
>>> +++ b/arch/arm/cpu/armv8/generic_timer.c
>>> @@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
>>>  unsigned long notrace get_tbclk(void)
>>>  {
>>>      unsigned long cntfrq;
>>> +
>>> +    if (IS_ENABLED(CONFIG_ARMV8_CNTFRQ_BROKEN))
>>> +        return CONFIG_COUNTER_FREQUENCY;
>>> +
>>>      asm volatile("mrs %0, cntfrq_el0" : "=r" (cntfrq));
>>>      return cntfrq;
>>>  }
>>>
>>> ---
>>> base-commit: a5b3be1a37e19646b9d36c91f11b23f568be4f21
>>> change-id: 20251014-armv8-broken-cntfrq-f350f68fbf6e
>>>
>>> Best regards,
>>
>>
>> -- 
>> Pengutronix e.K.                           |
>>                              |
>> Steuerwalder Str. 21                       | http://
>> www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone:
>> +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:  
>> +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

