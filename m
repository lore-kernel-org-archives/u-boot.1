Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C2ACD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 04:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA7E846CA;
	Mon, 11 May 2026 06:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="THWGmrep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA75D846CB; Mon, 11 May 2026 06:50:17 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E63846C7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnLh4Njd7n20yUFODYLhNKGKhA9cDLm9TMXbzwZlES/eRMG+3R+l7+JrSnB/zenDcmdCDSvPBEi/e2fYi1ZZ+l9rBwXM3aeir/JUxADGUInQABZPpuVEyonvpCUNg5AHsNrG+Yaj3uk9cg8CX2oXDjEBgtM3peqWB4wGiHBkvDDwRL7BAo0wUe+tieUW/b/OgE/6Re7xul8hbrai8tHbG4pup0msHeG/J2S0XTEHW1o5UlEaGSoUrjpaVf0g5zQ84ZYugwmXlhqCcU7Liefjy1LHPxHemTc2MCTv0UI+j/kKnjC9Lqhd9X1BSh6wUVySjwcvl3x+DZ64fVheciAweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqRAAPtUpgETnRsSCFwIXBgY4cJiU/RAxEG7KiyHwog=;
 b=H3j0DPGBDFZlaa265+20aZ1Lyuu8n4wdSU08GfDPtyr5+NoA5W43Y2h3nc7lrMFEvOvkWsz8zmg0rdMaPyPk6AcKBuNbt7nkLFeELIxWMuL2ysXqBXM+zXb2M6vlYdukvpkXiRklNP5LS8Tvqin8g/CtoL3E4gKUtaE2ja5+p5vTlwKZ9pqvGZZNfiIQ0DR0bOGdEP7QsR08JvnMYb+7jGqPkQPOnri3mpYuaBCddBP4h6/KdF9leUCcB5ZWc8M+BcWOSR6NNgSJWC7GRyDziYXHHXnHfhssqJ95qDQ+Sz2QARVNL3nvgnxXzCcNEI8OAYMWGj3ai4vcUQzVOqkFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqRAAPtUpgETnRsSCFwIXBgY4cJiU/RAxEG7KiyHwog=;
 b=THWGmrepaIqs+6SHTTzVQ+oYeAxz6HNfPY6DcYF+oRvr81ZdiJsNk++Oz7t8TZzT7VKqWFprEa8aEe8AblXL4FJ8+jmK+UpPh5IOI629rlHgB+PqdYuLxMnDdq9u/+v8CLLcIFnPN4w2dbwGLcCpE72LGwTe3/QMGP+wUow1x5s=
Received: from BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18)
 by SA1PR10MB997678.namprd10.prod.outlook.com (2603:10b6:806:4b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 04:50:12 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::77) by BY5PR13CA0005.outlook.office365.com
 (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 04:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 04:50:11 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:50:10 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:50:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 10 May 2026 23:50:10 -0500
Received: from [172.24.20.81] (ltpw0g6znt.dhcp.ti.com [172.24.20.81])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B4o8Pm2939831;
 Sun, 10 May 2026 23:50:08 -0500
Message-ID: <dd7aad86-aa6c-4153-8b60-e98c51b57fee@ti.com>
Date: Mon, 11 May 2026 10:20:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: j721s2: j784s4: Add errata i2378 workaround
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <b-padhi@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>
References: <20260508142507.1386946-1-n-francis@ti.com>
 <b515a248-9a40-466b-a45f-e363465193e1@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <b515a248-9a40-466b-a45f-e363465193e1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA1PR10MB997678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6859e463-b7c0-4991-5db0-08deaf18c8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1mtyUmEjWgro2HumvI9bBqVpOq3fwIwfD/WV4ChBZdZiGQccrWCQilsq5mcpnyy5tMn8izaXElXjhilYmzVQwTOfR4qPQREthHaZc1W7vR76O5U4QCmuuPyIWyWvao2sifv+SCjqTXeeDChC1A76jMSAz7pIBrKSXFS7UyU+2pyRcp9dVsHH1d09l4siOP3VzogN/9QnebdRgLS6PCmXMinVjhsmn5ReMJ7HPe2Zj7u+JgmPNBbWKMJBrE0g9NUj4rRsEb79wWYwDkCv2tREqyIEcTL/nuUXKWzqkIWJT0m1mJQIpPbmT0a1cBYDrW9DpAOsVj0FJ/zNGPC2KmwudIAs56vULeVwRHCmoBNZNf6dQeS6vW63TgZKtwyuJoBYvNm9WXW9SFXs1O21Oy1JNu9KdXM4N5QPN5j8mEvYtd77Ur1bXRCxjfR+PAzbZ6XAFNMYpmlnxcwyftP+k1sUSearI52BskCOFNwwxv/xgEP/EVnxwk6N9Ef7Gd6PDcEGDOn4slgvb7sZSwVLTbVGjHdmCnLhf4AxYtcuS2TGmD5VKufQlkug+gkTFUunzT1tuDW4jgMl3N5grbKrtQTVSfUcXtCo5BpaZAQdlz6Dj/eAvilDnT7MFkNUSg8Jnls9i2bMGODgS92x5jy1tpYLeFlIKc3RpvtRu4X+90JmuHmIdMO35Bh4iUAYxc15eNuAx3YiYfHYyjF/TIeTlGh51lQid9t0F3D4Qym6NLhZpHM=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 71S+TqPz+97W3TzlLOjYnkYpEAu0iREVfmOHGyuDABfCRi0WdkeZaFG4HE2cXmr/WlR/94vTpAum7DyRl5XFmiJ4q4ngE9p8zAr0K35mt7G17wgIh1kvG0ooMGxd7YBJyIEeZbtaw04bXD3J+5Rg1GmKzjp1IOIpuAkJy1x9sb49z5cLsil27BPEzYCx5F/20NurK6zYBc+ozq2qTbjPL/9B2hWKHS3qnKmWK2qbprkIIBXtSwJNisWYctaMrngJJv+n6z4CGCpnrb1ZzCH67aUBOh6wAYZ6q9KGE1GidsUrIT3tgwWM2wybx8pjrmvCQb7Ro9m6ykmBo5b7q6r60l+nhzLQoTquWvFHhycerki0xJU3bUVMOynRe3DHEL57tplv+pYFrq0zjHvXtQHOc5z3dZ1OlTv1pZkUM/ab5fmQ8Fzq6Q1LmukRyQIiMYvk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 04:50:11.3249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6859e463-b7c0-4991-5db0-08deaf18c8b4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997678
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

Hi Udit

On 5/9/2026 7:15 AM, Kumar, Udit wrote:
> 
> 
> On 5/8/2026 7:55 PM, Neha Malcom Francis wrote:
>> The shadow copies of WAY_SELECT MSMC MMRs have incorrect reset values.
>> The main copy has the correct reset value but MSMC functionality uses
>> the shadow copy values. This incorrect reset value results in
>> under-utilization of MSMC L3 data cache and snoop filter for DDR
>> accesses.
>>
> 
> Thanks Neha for rolling this out. Wondering if L3 set to zero then
> will this hardcoded write will impact in some way ?

I don't think it will, but I will confirm with the h/w team to make sure.

> 
>> The workaround is to write 0x00000303 to both MSMC MMRs after reset.
>> This ensures that their shadow copies get the correct post-reset value.
>>
>> Link: https://www.ti.com/lit/er/sprz530c/sprz530c.pdf
>> Link: https://www.ti.com/lit/er/sprz536b/sprz536b.pdf
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>  arch/arm/mach-k3/include/mach/j721s2_hardware.h |  4 ++++
>>  arch/arm/mach-k3/include/mach/j784s4_hardware.h |  4 ++++
>>  arch/arm/mach-k3/j721s2/j721s2_init.c           | 11 +++++++++++
>>  arch/arm/mach-k3/j784s4/j784s4_init.c           | 11 +++++++++++
>>  4 files changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
>> index 82f076a45e0..a4d7fe48662 100644
>> --- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
>> @@ -37,6 +37,10 @@
>>  /* MCU SCRATCHPAD usage */
>>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>>  
>> +/* MSMC RT_WAY MMR addresses */
>> +#define K3_MSMC_RT_WAY_SELECT		0x6E008000
>> +#define K3_MSMC_NRT_WAY_SELECT		0x6E008008
>> +
>>  #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>>  
>>  #define J721S2_DEV_MCU_RTI0			295
>> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> index 29a894baed3..bb5c58d00e4 100644
>> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> @@ -37,6 +37,10 @@
>>  /* MCU SCRATCHPAD usage */
>>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>>  
>> +/* MSMC RT_WAY MMR addresses */
>> +#define K3_MSMC_RT_WAY_SELECT		0x6E008000
>> +#define K3_MSMC_NRT_WAY_SELECT		0x6E008008
>> +
>>  #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>>  
>>  #define J784S4_DEV_MCU_RTI0			367
>> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
>> index b5453d8895d..d996dfcc332 100644
>> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
>> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
>> @@ -163,6 +163,14 @@ static void store_boot_info_from_rom(void)
>>  	       sizeof(struct rom_extended_boot_data));
>>  }
>>  
>> +void apply_msmc_shadow_copy_errata(void)
>> +{
>> +	/* Errata i2378: Write 0x00000303 to MSMC shadow copy MMRs */
>> +	writel(0x00000303, K3_MSMC_RT_WAY_SELECT);
>> +	writel(0x00000303, K3_MSMC_NRT_WAY_SELECT);
>> +	debug("%s: Applied errata i2378\n", __func__);
>> +}
>> +
>>  void k3_spl_init(void)
>>  {
>>  	struct udevice *dev;
>> @@ -176,6 +184,9 @@ void k3_spl_init(void)
>>  	/* Make all control module registers accessible */
>>  	ctrl_mmr_unlock();
>>  
>> +	/* Apply MSMC shadow copy errata workaround */
>> +	apply_msmc_shadow_copy_errata();
>> +
>>  	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>>  		disable_linefill_optimization();
>>  		setup_k3_mpu_regions();
>> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> index 53f152ccd9c..48b52fcb333 100644
>> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
>> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> @@ -180,6 +180,14 @@ static void store_boot_info_from_rom(void)
>>  	       sizeof(struct rom_extended_boot_data));
>>  }
>>  
>> +void apply_msmc_shadow_copy_errata(void)
>> +{
>> +	/* Errata i2378: Write 0x00000303 to MSMC shadow copy MMRs */
>> +	writel(0x00000303, K3_MSMC_RT_WAY_SELECT);
>> +	writel(0x00000303, K3_MSMC_NRT_WAY_SELECT);
>> +	debug("%s: Applied errata i2378\n", __func__);	
>> +}
>> +
>>  void k3_spl_init(void)
>>  {
>>  	struct udevice *dev;
>> @@ -194,6 +202,9 @@ void k3_spl_init(void)
>>  	/* Make all control module registers accessible */
>>  	ctrl_mmr_unlock();
>>  
>> +	/* Apply MSMC shadow copy errata workaround */
>> +	apply_msmc_shadow_copy_errata();
>> +
>>  	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>>  		disable_linefill_optimization();
>>  		setup_k3_mpu_regions();
> 

-- 
Thanking You
Neha Malcom Francis

