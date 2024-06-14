Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CF6C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17589889ED;
	Fri, 14 Jun 2024 16:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718373638;
	bh=gGdoFSOWi/ZD8wwPN09pkI1El/Edww9RyaOk5FlLEhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=son0Iac8Sb85OLnxg26lOE2H9QY4yZBNKKvi+Gly9giwELmPBhK6vD9L/EFcX8I6D
	 hxQH2YH3SdwECYtnj2eU9CwMXY7LQbRw1Q75tt8+gv+NK90t8wDu2hFF6vkgKsVVZ9
	 nIZ8p9Z2Vd2lw/jaAva8LgFomQgHI8jROo1phhznIaaUOHVkvLKUiw1RutCJViGY4X
	 +6oPrPNkkrLkE5qjH8X9DKlVoWCY+NpFJI09OPJyAMw+hyyVYRXADnMexF1FBtI7r9
	 EKwpO6PFA7CN75S9o0TlD6neVw5nik4kHkX5pSB7nARrfNiRPtuTH25gVys79rJXOI
	 ccz2ZJbUP2+Fw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CB5D9889E1;
 Fri, 14 Jun 2024 16:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718373636;
 bh=gGdoFSOWi/ZD8wwPN09pkI1El/Edww9RyaOk5FlLEhw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BDbV2XCQJ7kPwInzNY7RWkq1tfF/YEmlt5j++3YzdU4GluyCQBcv9DRSvVQ21BPER
 kw9uD5dUxgjPVqfv1CfCKNzMkThDouwuWHYlR9mBwEvNyUJW1NXyarhU3UBPaRCgz+
 x3kLqDNMqTGL3GrbZcNcMx2D+zdEURL23zMuPaqYCa7UVaG5UMXn+M8tKYEMizqeyF
 Ukc0oNH/vZdPsYc0Op2mjWnwfD+GoUD3F5oNgEAYFzcaKUCSS7C1Rf3dnvLE/qeOG4
 PqUy81CTonSpxJem7jfTAaiLtyF4nBkhY230xT0Oztx6rHzcjp7G+9gD1RAKzb9fK1
 uPasCbtSkVgXw==
Message-ID: <ca3c6071-2adf-452b-b4af-574fa57443f9@denx.de>
Date: Fri, 14 Jun 2024 15:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Ping IWDG on exit from PSCI suspend code
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
References: <20240419220331.277574-1-marex@denx.de>
 <433560cb-8d8a-4db4-bc9b-d49a05da127b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <433560cb-8d8a-4db4-bc9b-d49a05da127b@foss.st.com>
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

On 6/14/24 2:00 PM, Patrice CHOTARD wrote:
> 
> 
> On 4/20/24 00:03, Marek Vasut wrote:
>> Make sure the OS would not get any spurious IWDG pretimeout IRQ
>> right after the system wakes up. This may happen in case the SoC
>> got woken up by another source than the IWDG pretimeout and the
>> pretimeout IRQ arrived immediately afterward, but too late to be
>> handled by the suspend main loop. In case either of the IWDG is
>> enabled, ping it first and then return to the OS.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/mach-stm32mp/stm32mp1/psci.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> index 4f2379df45f..e99103910d9 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> @@ -808,6 +808,27 @@ void __secure psci_system_suspend(u32 __always_unused function_id,
>>   	writel(SYSCFG_CMPENR_MPUEN, STM32_SYSCFG_BASE + SYSCFG_CMPENSETR);
>>   	clrbits_le32(STM32_SYSCFG_BASE + SYSCFG_CMPCR, SYSCFG_CMPCR_SW_CTRL);
>>   
>> +	/*
>> +	 * Make sure the OS would not get any spurious IWDG pretimeout IRQ
>> +	 * right after the system wakes up. This may happen in case the SoC
>> +	 * got woken up by another source than the IWDG pretimeout and the
>> +	 * pretimeout IRQ arrived immediately afterward, but too late to be
>> +	 * handled by the main loop above. In case either of the IWDG is
>> +	 * enabled, ping it first and then return to the OS.
>> +	 */
>> +
>> +	/* Ping IWDG1 and ACK pretimer IRQ */
>> +	if (gic_enabled[4] & BIT(22)) {
>> +		writel(IWDG_KR_RELOAD_KEY, STM32_IWDG1_BASE + IWDG_KR);
>> +		writel(IWDG_EWCR_EWIC, STM32_IWDG1_BASE + IWDG_EWCR);
>> +	}
>> +
>> +	/* Ping IWDG2 and ACK pretimer IRQ */
>> +	if (gic_enabled[4] & BIT(23)) {
>> +		writel(IWDG_KR_RELOAD_KEY, STM32_IWDG2_BASE + IWDG_KR);
>> +		writel(IWDG_EWCR_EWIC, STM32_IWDG2_BASE + IWDG_EWCR);
>> +	}
>> +
>>   	/*
>>   	 * The system has resumed successfully. Rewrite LR register stored
>>   	 * on stack with 'ep' value, so that on return from this PSCI call,
> Applied to u-boot-stm32/next

This is a fix, should go into /master .
