Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC9BC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 06:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7AE8091A;
	Thu,  5 Jun 2025 08:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ri9QbLsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB8881E25; Thu,  5 Jun 2025 08:11:53 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1AC8003E
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 08:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5556BhfY1027106;
 Thu, 5 Jun 2025 01:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749103903;
 bh=OzqxXAM+BLw7C05KuKPej9QJGvy8Wk6RWs64v03gbwU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ri9QbLsYmwIxmps7UKr0cwzFCLlOYoLms1no18g0w4g/mv2GhLg/z7cgbOPUUkjKU
 pi9EZrPY8uUqKBX7F9HMi6hqBa3eiCn30LAUn3G4aKZRcUD4znevpAXS58TAqsX2XQ
 ZGc0cX2zg5utbOLBMvng18Zm2FWmGuy25vF6eivw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5556BgZV610096
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 5 Jun 2025 01:11:43 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Jun 2025 01:11:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Jun 2025 01:11:42 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5556Bd873142415;
 Thu, 5 Jun 2025 01:11:40 -0500
Message-ID: <6945b450-dce4-49af-a7ad-eeaf5d6e1fac@ti.com>
Date: Thu, 5 Jun 2025 11:41:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: mach-k3: Print version of DM firmware during
 boot process
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-7-m-shah@ti.com>
 <ea157631-8855-423a-9fee-7b46a1edd330@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <ea157631-8855-423a-9fee-7b46a1edd330@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hey Neha,

On 03/06/25 11:34, Neha Malcom Francis wrote:
> On 28/05/25 13:35, Moteen Shah wrote:
>> Print DM firmware's version in the boot up process of K3 devices.
>>
>> Signed-off-by: Moteen Shah <m-shah@ti.com>
> This patch does not apply cleanly on the latest master, you may have to
> rebase.

I will do a rebase and send a revision for this.
Thanks for the review.

Regards,
Moteen

>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ++++
>>   arch/arm/mach-k3/am62px/am62p5_init.c | 4 ++++
>>   arch/arm/mach-k3/am62x/am625_init.c   | 4 ++++
>>   arch/arm/mach-k3/am64x/am642_init.c   | 4 ++++
>>   arch/arm/mach-k3/am65x/am654_init.c   | 4 ++++
>>   arch/arm/mach-k3/j721e/j721e_init.c   | 4 ++++
>>   arch/arm/mach-k3/j721s2/j721s2_init.c | 4 ++++
>>   arch/arm/mach-k3/j722s/j722s_init.c   | 4 ++++
>>   arch/arm/mach-k3/j784s4/j784s4_init.c | 4 ++++
>>   9 files changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> index 52a21277227..5bee04c5c31 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -172,6 +172,10 @@ void board_init_f(ulong dummy)
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>>   
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>> +
>>   	if (IS_ENABLED(CONFIG_ESM_K3)) {
>>   		/* Probe/configure ESM0 */
>>   		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);
>> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
>> index 01e47deca94..304fdc75736 100644
>> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
>> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
>> @@ -224,6 +224,10 @@ void board_init_f(ulong dummy)
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>>   
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>> +
>>   	if (IS_ENABLED(CONFIG_K3_AM62A_DDRSS)) {
>>   		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>   		if (ret)
>> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
>> index 595fc391ac5..5bcce365790 100644
>> --- a/arch/arm/mach-k3/am62x/am625_init.c
>> +++ b/arch/arm/mach-k3/am62x/am625_init.c
>> @@ -261,6 +261,10 @@ void board_init_f(ulong dummy)
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>>   
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>> +
>>   	if (IS_ENABLED(CONFIG_ESM_K3)) {
>>   		/* Probe/configure ESM0 */
>>   		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);
>> diff --git a/arch/arm/mach-k3/am64x/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
>> index 41812b7dbf7..7a317632e5b 100644
>> --- a/arch/arm/mach-k3/am64x/am642_init.c
>> +++ b/arch/arm/mach-k3/am64x/am642_init.c
>> @@ -242,6 +242,10 @@ void board_init_f(ulong dummy)
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>>   
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>> +
>>   	do_dt_magic();
>>   
>>   #if defined(CONFIG_ESM_K3)
>> diff --git a/arch/arm/mach-k3/am65x/am654_init.c b/arch/arm/mach-k3/am65x/am654_init.c
>> index a4f038029d7..774ad7feb1d 100644
>> --- a/arch/arm/mach-k3/am65x/am654_init.c
>> +++ b/arch/arm/mach-k3/am65x/am654_init.c
>> @@ -244,6 +244,10 @@ void board_init_f(ulong dummy)
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>>   
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>> +
>>   	/* Perform board detection */
>>   	do_board_detect();
>>   
>> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
>> index f31c20f7ed6..498243485f5 100644
>> --- a/arch/arm/mach-k3/j721e/j721e_init.c
>> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
>> @@ -374,6 +374,10 @@ void board_init_f(ulong dummy)
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>>   
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>> +
>>   	/* Perform board detection */
>>   	do_board_detect();
>>   
>> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
>> index 5941fa26a95..528590f0434 100644
>> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
>> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
>> @@ -232,6 +232,10 @@ void k3_spl_init(void)
>>   
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>> +
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>>   }
>>   
>>   bool check_rom_loaded_sysfw(void)
>> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
>> index af211377e7c..d8123f282ee 100644
>> --- a/arch/arm/mach-k3/j722s/j722s_init.c
>> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
>> @@ -150,6 +150,10 @@ static void k3_spl_init(void)
>>   
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>> +
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>>   }
>>   
>>   static void k3_mem_init(void)
>> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> index 787cf6261e4..ccf29810849 100644
>> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
>> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> @@ -208,6 +208,10 @@ void k3_spl_init(void)
>>   
>>   	/* Output System Firmware version info */
>>   	k3_sysfw_print_ver();
>> +
>> +	/* Output DM Firmware version info */
>> +	if (IS_ENABLED(CONFIG_ARM64))
>> +		k3_dm_print_ver();
>>   }
>>   
>>   void k3_mem_init(void)
