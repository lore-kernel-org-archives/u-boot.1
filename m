Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DEFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD6588189;
	Mon, 15 Apr 2024 15:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713189575;
	bh=AkLaxEQ40bXSLAy8Wh8a9xLKYnY6eQAsBH2Mmk7rUUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DkrXjgE9hOqoQg7bf6D9i58nL1lXJbytBUKs1+wbLIJQ1sCB4vcCSNVHcRhtTB05Q
	 jNYV5cGYpThcLwSI1h6c62TKC65nRJ+WHdETyAPzznaoJr1JmvoI9h4lhdtOGLqIml
	 L8OaTSuK0onXO8ym2LicdbYD/j15jZFghpC1AL87hwa2eDahf/Du9F0A9pZ/1gisrW
	 7+r6+5fVUArWvRxdnoLRABGqNoMeXPHYmZ8WMW+J6tfu9FXRVllUwQCsEnGOUci357
	 1J/m+qa0HK2b9IrsROTwsx1hzF4yeYw+6M5mM7oSTJbaT2KS+uUtLrjnruJ6DO67Tq
	 NR9d8C/aO1vIQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5B6288818C;
 Mon, 15 Apr 2024 15:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713189573;
 bh=AkLaxEQ40bXSLAy8Wh8a9xLKYnY6eQAsBH2Mmk7rUUg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MKxvCkbzhI1X+B/miDnC0OsB6YECL8kUPFgBP5zkHu2X0XWCU36LaPfUKhv9Bcx0i
 jwfEokUBfXSHr+PUA9dpyMz8bx3Xzyg+39WljQBTHFjsXd71K9TpOhk0swMwlt0TiG
 TT3bhnHeuNzjlS1EA7UejGlg5AxbaMhV3FkUWxYULe2YrkYrTmvl3eqGPIj7wX0byN
 SHJIU1byjrQ7dV0cRB8i8jLCwFJ/GCe8eNLWU6xtsbY78ztilgZB8isCFA1JKDw0ty
 qnWIdIoxX8K/9rFzFC/IkVjYEhL3IaFawXKJtVX8dnRjVwmfO36wYfWzh5VFM2pdRw
 QmQSxeOfy4q2Q==
Message-ID: <604d605d-b3a7-4bd7-adce-381ea68e6d60@denx.de>
Date: Mon, 15 Apr 2024 14:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on
 STM32MP15xx
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
References: <20240414184028.147067-1-marex@denx.de>
 <f808ec3d-966c-43e6-87be-18e742f976b3@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <f808ec3d-966c-43e6-87be-18e742f976b3@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/15/24 11:48 AM, Patrice CHOTARD wrote:
> 
> 
> On 4/14/24 20:39, Marek Vasut wrote:
>> In case of an OTP-CLOSED STM32MP15xx system, the CPU core 1 cannot be
>> released from endless loop in BootROM only by populating TAMP BKPxR 4
>> and 5 with magic and branch address and sending SGI0 interrupt from
>> core 0 to core 1 twice. TAMP_SMCR BKP..PROT fields must be initialized
>> as well to release the core 1 from endless loop during the second SGI0
>> handling on core 1. Initialize TAMP_SMCR to protect the first 16 backup
>> registers, the ones which contain the core 1 magic, branch address and
>> boot information.
>>
>> This requirement seems to be undocumented, therefore it was necessary
>> to trace and analyze the STM32MP15xx BootROM using OpenOCD and objdump.
>> Ultimately, it turns out that a certain BootROM function reads out the
>> TAMP_SMCR register and tests whether the BKP..PROT fields are non-zero.
>> If they are zero, the BootROM code again waits for SGI0 using WFI, else
>> the execution moves forward until it reaches handoff to the TAMP BKPxR 5
>> branch address.
>>
>> This fixes CPU core 1 release using U-Boot PSCI implementation on an
>> OTP-CLOSED system, i.e. system with fuse 0 bit 6 set.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> index dd99150fbc2..138a6d6b614 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> @@ -14,6 +14,7 @@
>>   #include <asm/arch/sys_proto.h>
>>   #include <dm/device.h>
>>   #include <dm/uclass.h>
>> +#include <linux/bitfield.h>
>>   
>>   /* RCC register */
>>   #define RCC_TZCR		(STM32_RCC_BASE + 0x00)
>> @@ -41,6 +42,9 @@
>>   #define TZC_REGION_ID_ACCESS0	(STM32_TZC_BASE + 0x114)
>>   
>>   #define TAMP_CR1		(STM32_TAMP_BASE + 0x00)
>> +#define TAMP_SMCR		(STM32_TAMP_BASE + 0x20)
>> +#define TAMP_SMCR_BKPRWDPROT	GENMASK(7, 0)
>> +#define TAMP_SMCR_BKPWDPROT	GENMASK(23, 16)
>>   
>>   #define PWR_CR1			(STM32_PWR_BASE + 0x00)
>>   #define PWR_MCUCR		(STM32_PWR_BASE + 0x14)
>> @@ -136,6 +140,18 @@ static void security_init(void)
>>   	 */
>>   	writel(0x0, TAMP_CR1);
>>   
>> +	/*
>> +	 * TAMP: Configure non-zero secure protection settings. This is
>> +	 * checked by BootROM function 35ac on OTP-CLOSED device during
>> +	 * CPU core 1 release from endless loop. If secure protection
>> +	 * fields are zero, the core 1 is not released from endless
>> +	 * loop on second SGI0.
>> +	 */
>> +	clrsetbits_le32(TAMP_SMCR,
>> +			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPRWDPROT,
> 
> Hi Marek
> 
> there is a typo, you used twice TAMP_SMCR_BKPRWDPROT :
> 
> TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPRWDPROT  => TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT
>                                      ^~~~~

Fixed in V2, thanks.

btw are there any other such undocumented surprises in the BootROM ?
