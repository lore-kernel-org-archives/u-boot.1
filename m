Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80028C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 05:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9A7806FC;
	Thu, 24 Apr 2025 07:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BKajcWVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0B480944; Thu, 24 Apr 2025 07:40:28 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3948056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 07:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5eOVf2406738
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 00:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745473224;
 bh=tsaA9fhriBa7RZtWsSbFv/qfbEQ5LTeDcsUjrZu2L50=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BKajcWVH+bRe/sD8KcvuEAVl1kZMb89BTnDtEKXX1cBppEVVRK51o/5Dvbj2bbTyH
 EjDAwCDefHoM4LAszveCLIH6wtJlQhtfQ3vpOQOO19zwtQp2Z7hXearhHqmXY2GftM
 JWky/4oR9CYtR8CMZ1bgY+zQ5nul2Z9YFHQzJfiA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5eOOM028792
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Apr 2025 00:40:24 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 00:40:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 00:40:23 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O5eLO8098505;
 Thu, 24 Apr 2025 00:40:21 -0500
Message-ID: <9621a0fd-d988-4885-8fd6-ea8826380e5e@ti.com>
Date: Thu, 24 Apr 2025 11:10:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Add config option for booting HSM core
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-2-b-padhi@ti.com>
 <4917db59-9533-4540-a1d5-e648e4a0b5f3@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <4917db59-9533-4540-a1d5-e648e4a0b5f3@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Udit,

On 22/04/25 20:07, Kumar, Udit wrote:
>
> On 4/22/2025 3:24 PM, Beleswar Padhi wrote:
>> Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
>> M4F core in the Wakeup Voltage Domain which could be used to run secure
>> services like Authentication. Add a config option which indicates that
>> the SoC has a HSM core and the firmware for the core is available.
>
> Config option can not indicate firmware is available for core.


Correct. But since we don't have 'optional' property working in the expected way, enabling this CONFIG can lead to build failures when firmware is not available in correct path.

So, the idea of this CONFIG was to let the developers decide at build-time that: they want to boot the core as well as the firmware is available for this core.

Thanks,
Beleswar

>
> Thic could be
>
> Add a config option which allows load of HSM firmware and booting of HSM core.
>
>
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 1b8c0b1eb96..b787d2da244 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -181,6 +181,14 @@ config K3_REMOTEPROC_PRU
>>       imply REMOTEPROC_TI_PRU
>>       default y if (SOC_K3_AM642 || SOC_K3_AM654)
>>   +config K3_HSM_FW
>> +    bool "Load and Boot HSM core"
>> +    default n
>> +    help
>> +      Enabling this will indicate that the system has a HSM (High Security
>> +      Module) M4 Core and the firmware for the core is present. When
>> +      enabled, HSM core will be booted at R5 SPL execution time.
>> +
>>   if CPU_V7R
>>   source "arch/arm/mach-k3/r5/Kconfig"
>>   endif
