Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC88C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 23:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A234E84A92;
	Sat, 11 Jul 2026 01:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VB0damsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7657D84A9E; Sat, 11 Jul 2026 01:52:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C274984A90
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 01:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d8f4=FF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783727549;
 bh=dAACeSh+btwi8TqUqFToInzE/UwTzVkzK4hndZewJMw=;
 b=VB0damsjcdgl2s0LqArgR//DDEX5TMbNGyCDIqBvjpgsYszlQZMI9ElnG+Vtn73bFa+gMrlJB
 LFV3UUBP1RXYZs61H/RQ/LQj82/hCgEipFKi+r2n0P7Xwncw9hYdmjRhhgyyrGv8/5RyJxpVNko
 9XdV57A1BXum0bsixe5sJaJait7YtMtY3kt9u6gBcFTmzC+aNvS+gv6JnY5gxjwTawXOVibaqP5
 9RVA/UrcHKJo/TZslbD6D7jQb2EJVBC4HMDMv75C08yoO6uptuA+kDzeX/Qus5+9zHt+dMBnVW2
 j20qehU7CG4NmpqEHifD8PcFgFJkLP7TXTnKhIhm9ZOQ==
X-Forward-Email-ID: 6a5185bc780742a887931695
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <975a650f-88cf-4b2d-8f83-2df3f93ab25d@kwiboo.se>
Date: Sat, 11 Jul 2026 01:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
To: Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <20260709015247.GR749385@bill-the-cat>
 <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
 <20260710135030.GI749385@bill-the-cat>
 <ec6db006-bd05-4621-a9e6-cba6dd9690bd@kwiboo.se>
 <20260710155636.GL749385@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260710155636.GL749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 7/10/2026 5:56 PM, Tom Rini wrote:
> On Fri, Jul 10, 2026 at 05:39:08PM +0200, Jonas Karlman wrote:
>> Hi Tom,
>>
>> On 7/10/2026 3:50 PM, Tom Rini wrote:
>>> On Thu, Jul 09, 2026 at 09:12:24AM +0200, Jonas Karlman wrote:
>>>> Hi Tom,
>>>>
>>>> On 7/9/2026 3:52 AM, Tom Rini wrote:
>>>>> On Wed, Jul 08, 2026 at 10:05:34PM +0000, Jonas Karlman wrote:
>>>>>
>>>>>> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
>>>>>> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
>>>>>>
>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>> ---
>>>>>>  drivers/i2c/Kconfig | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>>>>>> index ab5af17858c8..125dc84819e6 100644
>>>>>> --- a/drivers/i2c/Kconfig
>>>>>> +++ b/drivers/i2c/Kconfig
>>>>>> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
>>>>>>  
>>>>>>  config SPL_SYS_I2C_LEGACY
>>>>>>  	bool "Enable legacy I2C subsystem and drivers in SPL"
>>>>>> -	depends on SUPPORT_SPL && !SPL_DM_I2C
>>>>>> +	depends on SPL && !SPL_DM_I2C
>>>>>>  	help
>>>>>>  	  Enable the legacy I2C subsystem and drivers in SPL.  This is useful
>>>>>>  	  in some size constrained situations.
>>>>>>  
>>>>>>  config TPL_SYS_I2C_LEGACY
>>>>>>  	bool "Enable legacy I2C subsystem and drivers in TPL"
>>>>>> -	depends on SUPPORT_TPL && !SPL_DM_I2C
>>>>>> +	depends on TPL && !TPL_DM_I2C
>>>>>>  	help
>>>>>>  	  Enable the legacy I2C subsystem and drivers in TPL.  This is useful
>>>>>>  	  in some size constrained situations.
>>>>>
>>>>> Building on the last email, I think these might need to be
>>>>> [ST]PL_FRAMEWORK not [ST]PL.
>>>>>
>>>>
>>>> I have mostly tested this series with additional changes that alias
>>>> putc()/puts() to printch()/printascii() in xPL builds when
>>>> common/console.o is unavailable and DEBUG_UART=y, patches that will
>>>> be sent as a separate series.
>>>>
>>>> It is possible such change may have hidden some latent issues, now
>>>> trying to push a branch that contains changes that ends at the patches
>>>> included in this series, but due to timeouts it was not possible prior
>>>> to sending this reply.
>>>>
>>>> This patch can also be dropped if it causes any issues, I only added it
>>>> after a search for SUPPORT_xPL and noticed that these depends seem to be
>>>> incorrect. SUPPORT_xPL is used to tell if xPL can be enabled or not,
>>>> not if xPL is enabled/disabled.
>>>
>>> I don't want to drop this, but there are a handful of platforms that
>>> change:
>>> 10: Kconfig: i2c: Depend on correct xPL symbol
>>>    aarch64: (for 1/1 boards) all -60.0 text -60.0
>>>             ls1043aqds_tfa : all -60 text -60
>>>                u-boot: add: 0/-1, grow: 0/-1 bytes: 0/-60 (-60)
>>>                  function                                   old     new   delta
>>>                  board_early_init_f                          68      64      -4
>>>                  i2c_early_init_f                            56       -     -56
>>>
>>> Can you please look in to it and see what needs to be changed? Thanks.
>>
>> From a quick look this size change may be caused due to use of an
>> 'imply SPL_SYS_I2C_LEGACY' instead of using an 'imply SYS_I2C_LEGACY'
>> in arch/arm/cpu/armv8/fsl-layerscape/Kconfig.
>>
>> 'config MACH_SUN8I_R40' is another platform that also possible miss
>> an 'imply SYS_I2C_LEGACY' to match other similar sunxi platforms.

I have now done some more digging and it looks like SYS_I2C_EARLY_INIT
is the culprit.

  config SYS_I2C_EARLY_INIT
	bool "Enable legacy I2C subsystem early in boot"
	depends on BOARD_EARLY_INIT_F && SPL_SYS_I2C_LEGACY && SYS_I2C_MXC
	help
	  Add the function prototype for i2c_early_init_f which is called in
	  board_early_init_f.

Not sure what to do here, it is possible that just dropping
SPL_SYS_I2C_LEGACY from depends would ensure the code is restored.

However, that also feels strange as the intent of i2c_early_init_f() is
to initialize I2C_LEGACY, and most of the affected boards use DM_I2C:

  > tools/qconfig.py -f ~SPL SYS_I2C_EARLY_INIT
  5 matches
  ls1043aqds_tfa_SECURE_BOOT ls1043aqds_tfa ls1046aqds_tfa_SECURE_BOOT ls1046aqds_tfa ls2080aqds_qspi

  > tools/qconfig.py -f ~SPL SYS_I2C_EARLY_INIT ~DM_I2C
  1 matches
  ls2080aqds_qspi

(Please note that my qconfig.db does not cover 100% of all defconfigs.)

All other code seem to be protected by CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
so I am not expecting any other change for targets that use xPL=n.

Regards,
Jonas

>>
>> Building this target I also noticed some more SPL_<name> symbols that
>> may be missing a 'depends on SPL':
>>
>>   > grep CONFIG_SPL .config
>>   # CONFIG_SPL_SYS_L2_PL310 is not set
>>   # CONFIG_SPL is not set
>>   # CONFIG_SPL_SYS_STDIO_DEREGISTER is not set
>>   # CONFIG_SPL_NVMEM is not set
>>   CONFIG_SPL_SYS_NAND_SELF_INIT=y
>>   # CONFIG_SPL_PHY_ATHEROS is not set
>>   # CONFIG_SPL_PHY_TI_DP83867 is not set
>>   # CONFIG_SPL_LZMA_SIZE_OPTIMIZATION is not set
>>
>> Should possible add 'depends on' to some of them in a v2.
> 
> Great, thanks!
> 

