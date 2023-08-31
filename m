Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B8BC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 08:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA69C8656B;
	Thu, 31 Aug 2023 10:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHiZKWNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23AD08656D; Thu, 31 Aug 2023 10:24:17 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18AC381FA8
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLgUglf+m9kwwSqL/C/jAV63pW9Q/ckl+xuDfSLGEXwjfNl67I6u5Ien+TBLJ5Pl/o8I45vHLq6Ba0nC/C/B2EYoD4DmAtBZQzoyid0SJRgPU6bpTQdAENxiiUXPNjVm4xdIA+b5zK28Tmk4oo/bgprnrEkBkVd/bXeyOUOAJqasExvP6Q/Ls4pkAOEjuj4+kfgDbZohPdx/BtSw75t0H9GlpDTD5gi/UyDDLXvxEAgfnH2GROksJylHP/Rr0WXPBpykLe74bN8QgzNGWqQ+1pi9QKaVcH2nXs1cp2/dzpOzpKTKG5bt25H5U06a57bKlZm+w9A88C1CDh0MlFH9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhpebBUUWEuoF4Ny+hDD/MKhBv5GnK0DevNs7XXWt2c=;
 b=UsZ30O7FcCxt4BdJdEMYBtSeLjc9BwiFgzpYbRMpIrtFCQPGuiTF8xLnIhosyuwrP1egqNukkdMPwiEnoAtO+IgxjZy0aBAZzxtgmxJmDtB/oINXdJPD1uqml5yVr4N5jwNWvWqjQXzLJSYHLnt8861C1t92GMDGnd4/kPMe528kQJ2FOyJtqYDDOyOKCxvDcVhDkcsrU59/B75BleXlhbiDtvqzsHiAMnibPab6G8mkqq//IQOw5FMqFyEH8bQrupKMOVr77UH+nIsc3eZLpQn9HKqtbBGF9+Mjr8ir/Luh9pyuxQpXTk7FZLAcBZp/o5WG7q45BQi96hCqB+Yi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhpebBUUWEuoF4Ny+hDD/MKhBv5GnK0DevNs7XXWt2c=;
 b=tHiZKWNFbUEAIHSiDQ/WecuV93d/XmldqtPO9zGqDC+u8ZGyUiLfU9yYD9hYZumimg1G1iHC95sKLSxdq5Up5aWn6cvtPJZQ85CGRsnwyotEFGu8fJvVKloDXOilijKbRZl/x5ptapzHNc9dRZlEeCBgObXHytIW8KmyLqnNt4o=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 08:24:10 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::a) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 08:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 08:24:09 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 03:24:07 -0500
Message-ID: <0de1f4aa-a8be-805e-8260-6178b1368ab4@amd.com>
Date: Thu, 31 Aug 2023 10:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC: <u-boot@lists.denx.de>, <sjg@chromium.org>, <bhupesh.linux@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-3-bhupesh.sharma@linaro.org>
 <20230830185205.GA1149416@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 2/2] armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF for
 ARM64
In-Reply-To: <20230830185205.GA1149416@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 792abb64-1444-4836-b646-08dba9fba67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMFIo4zGciA6dz6YLe9urSmtyw4eaFaTP20RwpPE6ZTQzPR3zgWUTxKwT0xcv9WUo6/LOuefYS6xk1lC1B3bznzweymq7oAr5u21AWvKgjKp6fkcHtPJyijOzVfAtcds0s1Vae6SqNtSSYQNuQS2tP+J2wnVQqBlUrfB2dkmDUx5IPAEgxW8A5M9GrDvmOGKE2j3TroBh5xSUQJK5Uzo9IhucbIGfxaxO8sZcOLYoKENE97Xp8JmAomjOXkKnOrB2DDq1ubl00HtLqZfcLjFdAXv9Tqa6B4MVpa4lU2vbdBmP49LiiBRuDPNENBmDf9qOXgg9oiCnJr7a3F3oGKJ3WaHld3u1FFcQtj+mW5TmXBJm2uLSkKbgiPvzOJ4pGbg7U/gV3JgNeRpazgNY2K7FvUc+Gc9VpqSS6yBy6sn31TpZ9xpdLkLMHbAQBWJaXU+C5SOh9bldbErqtQ6wmg8Z4frt12w95DDz/I28nTc+C/05oQTKYNj9anfSuiPh1mpYayK4ax4fjxbGTrg7G9OlFn9pNZPR1oAANOcPaU39YB0wVelJ2hAIUkiuUWE7UjzI5PWPVnuTzcPkfuq/5EVen1SfufxWo353hlcpE5YzPLf0oq8KD2dGPkbZDWR5xEthS0C0y+6xfoJZsS4/XTSiYZLm0Ci1/c5SrHJxHodzR3UL/NeK5t9Jcvp3NPj3Z2kdlQ7mjo6n5qt9LaTNHwqBaVMUfYcGr17SpmgBRUI4s2bX8y/XAloyT3g9CTaPhKIZhB8VMBuYXdus93Rp+NW2rfeVAQnxa/AExLHwBrLARW3t8d117/h3oP8ul7G0fe1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(26005)(40460700003)(16576012)(316002)(66899024)(41300700001)(44832011)(4326008)(336012)(426003)(47076005)(5660300002)(2906002)(31696002)(86362001)(2616005)(36756003)(16526019)(8676002)(83380400001)(36860700001)(40480700001)(8936002)(356005)(82740400003)(81166007)(70586007)(54906003)(70206006)(110136005)(478600001)(31686004)(53546011)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:24:09.6908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792abb64-1444-4836-b646-08dba9fba67a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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



On 8/30/23 20:52, Tom Rini wrote:
> On Tue, Aug 22, 2023 at 01:21:12PM +0530, Bhupesh Sharma wrote:
> 
>> Ideally SYS_ICACHE_OFF and SYS_DCACHE_OFF should never be set for
>> ARM64 (ARMv8) platforms, as it makes booting u-boot slower on these
>> platforms.
>>
>> However, if some platforms require ICACHE or DCACHE  to be disabled
>> only for the smaller SPL stage, we should support such configurations
>> in u-boot as well.

I am missing the reason why this change should be accepted.

>>
>> Compile-tested for:
>> - qemu arm64

qemu doesn't model caches that's why I don't think it is relevant here.

>> - imx8
>> - stm32
>>
>> and run-tested on:
>> - Qualcomm RB3 platform
>>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> ---
>>   arch/arm/Kconfig            | 2 ++
>>   arch/arm/cpu/armv8/Makefile | 4 ++--
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 36ee1e9a3c..92bff715e3 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -141,6 +141,7 @@ config THUMB2_KERNEL
>>   
>>   config SYS_ICACHE_OFF
>>   	bool "Do not enable icache"
>> +	depends on !ARM64
>>   	help
>>   	  Do not enable instruction cache in U-Boot.
>>   
>> @@ -153,6 +154,7 @@ config SPL_SYS_ICACHE_OFF
>>   
>>   config SYS_DCACHE_OFF
>>   	bool "Do not enable dcache"
>> +	depends on !ARM64
>>   	help
>>   	  Do not enable data cache in U-Boot.
>>   
>> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
>> index bba4f570db..0d0c1728e4 100644
>> --- a/arch/arm/cpu/armv8/Makefile
>> +++ b/arch/arm/cpu/armv8/Makefile
>> @@ -5,13 +5,13 @@
>>   
>>   extra-y	:= start.o
>>   
>> +obj-y	+= cache_v8.o
>>   obj-y	+= cpu.o
>>   ifndef CONFIG_$(SPL_TPL_)TIMER
>>   obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
>>   endif
>>   ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
>> -obj-y	+= cache_v8.o
>> -obj-y	+= cache.o
>> +obj-y  += cache.o
>>   endif
>>   ifdef CONFIG_SPL_BUILD
>>   obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
> 
> I'm adding Michal here because this changes the behavior on xilinx
> platforms that had the icache off.  I was under the impression that at
> the levels U-Boot runs at on aarch64, we just couldn't have
> icache/dcache off, but I guess that's wrong?
> 

yes. We are using icache off for mini u-boot configurations for quite a long 
time. I tried to find out any commit why we started to use it but didn't find 
any record. But will ask team to retest that use cases to see if that is working 
or not.
In our case we are using small full U-Boot not any SPL variant.

My biggest issue with the patch is that it is not clear what issue it is trying 
to solve as I have mentioned above.
It just says that ideally icache/dcache should be on. If you want to enforce it 
on your platform you can select it when that platform is selected and don't need 
enforce it for other platforms.

Thanks,
Michal

