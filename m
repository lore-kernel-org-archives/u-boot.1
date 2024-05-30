Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D408C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 05:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9805886BF;
	Thu, 30 May 2024 07:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rSTuqTae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9361886B3; Thu, 30 May 2024 07:06:51 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3DD88681
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U56h5G056678;
 Thu, 30 May 2024 00:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717045603;
 bh=8NJWzQegxI985LpTHu3iI/LBjOW+/FV7EP7pD7WYExc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=rSTuqTaeYTg9LrLZh52iK5SdnqbaFb54AuVZioKVvDRryFhe2mpA+2U6wecmYDWm9
 2CRc3x3zOTZtlEASDU1YkI28VtcM8HEjvUZwU3dvEA429vO+okl5ttSY15ZJrnnPUI
 p9c73iRDGKwH0VOLhJmnMbgVmjEELmDktPN7b0WQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U56hB2054248
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 May 2024 00:06:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 00:06:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 00:06:42 -0500
Received: from [172.24.227.102]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U56cE8085433;
 Thu, 30 May 2024 00:06:39 -0500
Message-ID: <e8e80169-6069-4f63-939f-4bb181e24a2a@ti.com>
Date: Thu, 30 May 2024 10:36:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arch: mach-k3: Introduce basic files to support
 J722S SoC family
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>, <afd@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-10-j-choudhary@ti.com>
 <7bfd2138-d882-4e07-bdbf-f4fa907600f5@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <7bfd2138-d882-4e07-bdbf-f4fa907600f5@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello Neha,

Thanks for the review.

On 30/05/24 08:15, Neha Malcom Francis wrote:
> Hi Jayesh
> 
> On 29/05/24 18:54, Jayesh Choudhary wrote:
>> Introduce the basic functions and definitions needed to properly
>> initialize TI J722S family of SoCs.
>>
>> Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig                      |   7 +-
>>   arch/arm/mach-k3/Makefile                     |   1 +
>>   arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>>   .../arm/mach-k3/include/mach/j722s_hardware.h |  83 ++++++
>>   arch/arm/mach-k3/include/mach/j722s_spl.h     |  49 ++++
>>   arch/arm/mach-k3/include/mach/spl.h           |   4 +
>>   arch/arm/mach-k3/j722s/Kconfig                |  32 ++
>>   arch/arm/mach-k3/j722s/Makefile               |   6 +
>>   arch/arm/mach-k3/j722s/j722s_init.c           | 277 ++++++++++++++++++
>>   9 files changed, 462 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/mach-k3/include/mach/j722s_hardware.h
>>   create mode 100644 arch/arm/mach-k3/include/mach/j722s_spl.h
>>   create mode 100644 arch/arm/mach-k3/j722s/Kconfig
>>   create mode 100644 arch/arm/mach-k3/j722s/Makefile
>>   create mode 100644 arch/arm/mach-k3/j722s/j722s_init.c
>>
> 
> [...]
> 
>> +
>> +void board_init_f(ulong dummy)
>> +{
> 
> J784S4 went through quite a bit of revisions and I personally would like 
> to use it as an example (for now) for our code layout for all future 
> devices until we cleanup further. See [1] where it was addressed to have 
> board_init_f split up into calling smaller logical functions instead.
> 
> [1] 
> https://lore.kernel.org/u-boot/20240103162504.xgbx73pnmthtzthl@vengeful/
> 

Okay!
I will make the simpler flow for board_init_f similar to maybe j721s2.

Warm Regards,
Jayesh


>> +    struct udevice *dev;
>> +    int ret;
>> +
>> +    if (IS_ENABLED(CONFIG_CPU_V7R))
>> +        setup_k3_mpu_regions();
>> +
>> +    /*
>> +     * Cannot delay this further as there is a chance that
>> +     * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC 
>> section.
>> +     */
>> +    store_boot_info_from_rom();
>> +
>> +    ctrl_mmr_unlock();
>> +
>> +    /* Init DM early */
>> +    ret = spl_early_init();
>> +    if (ret)
>> +        panic("spl_early_init() failed: %d\n", ret);
>> +
>> +    /*
>> +     * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and 
>> continue
> 
> [...]
> 
