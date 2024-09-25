Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31B8CCF9E8
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13CC088995;
	Wed, 25 Sep 2024 19:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727283912;
	bh=CXIkLZIfmA65XiHglJ7v1Go+31HcR8kuKw34+s9j4Bk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=du0yGGgnR+btl4+YJepoBVGd/oVScxETWXppbo/6tls8A9dc4W49h+aaQI8Kkv+IV
	 /5XnhzdKSQLsvfwOsbvz7Q04K7YZv9ywWlX0rAy/F74eeOotRGKcjIcJtO6WNYCkg7
	 McZJsee2aWH1IOa/634YmcI14Uy1eDR0mv+U571WIkwz1+0TXS+exTUTffuTnsiNMw
	 Aw5okufjJoeenXY6y8Y4f17EK8arZ0d7r3ze8otx9vvUbGpdKPY6iV4cDeuhtRdEzB
	 UL3+TZxrV3JQGslotgn4O3rpwMaGECVs+1EtAAP6wa9FO+VIB/ShXoPRBos+uznxvz
	 dRxYXzkgbwunQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C025588B11;
 Wed, 25 Sep 2024 19:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727283911;
 bh=CXIkLZIfmA65XiHglJ7v1Go+31HcR8kuKw34+s9j4Bk=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=UN792QB+AmmTB6mCnl4TvW6LX1qhWwrqmcRchWOUEw5te9kiinWGdTAbw7czMmWqF
 aT5jPhX7PzdikUfj+HedI02ci19LySe/87W3iruSd7q8SF6QL7+Z4BM8fFIydC7M+F
 mYjLBKudSs9rZ2ffdcprsEtvkp73MBujIA7mrexpEBSUBvmdBfgDJ4VKgZD321dDwg
 W3lAkcTviFXyEItwg0yIUA9A1A/J6Lt9AVhdrZbMcMzJY1BLFZfYg/hzz1DEAk8t2H
 tJeEq6bG+NQp+4TI6zVuowLG3pRZqbLQW7JrFok3cCJjTZd+8KN1wjIzo1tth1tB2T
 agK/m3+2u25Rw==
Message-ID: <6957bfce-21c5-4996-9e3f-a43f6243fa49@denx.de>
Date: Wed, 25 Sep 2024 19:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ARM: stm32: Fix TAMP_SMCR BKP..PROT fields on STM32MP15xx
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
References: <20240618225736.154959-1-marex@denx.de>
 <2fd69224-c299-4b43-9078-07e06cc345f5@foss.st.com>
Content-Language: en-US
In-Reply-To: <2fd69224-c299-4b43-9078-07e06cc345f5@foss.st.com>
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

On 6/19/24 8:35 AM, Patrice CHOTARD wrote:
> 
> 
> On 6/19/24 00:57, Marek Vasut wrote:
>> Update the TAMP_SMCR BKP..PROT fields to put first 10 registers
>> into protection zone 1 and next 5 into zone 2. This fixes use of
>> boot counter which is often in zone 3 and has to be updated from
>> Linux, which runs in NS.
>>
>> Fixes: 73f7fc944cf6 ("ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on STM32MP15xx")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> index f096fe538d8..ca202bec8ee 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>> @@ -148,8 +148,8 @@ static void security_init(void)
>>   	 */
>>   	clrsetbits_le32(TAMP_SMCR,
>>   			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
>> -			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
>> -			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
>> +			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x0A) |
>> +			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x0F));
>>   
>>   	/* GPIOZ: deactivate the security */
>>   	writel(BIT(0), RCC_MP_AHB5ENSETR);
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

I hope this bugfix will make it into 2024.10 , can you prepare a bugfix 
PR for 2024.10 ?
