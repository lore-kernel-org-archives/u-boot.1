Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2ACFD5323
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 09:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15DC783AA9;
	Fri, 27 Feb 2026 10:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DbJiojkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91BF83E76; Fri, 27 Feb 2026 10:50:27 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azhn150110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d91c::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D489083642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 10:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wupjQo9zzWiauvSkmly9JQ3oR/G8/I4CwRPHpK1fSvZTAIugQOyHEesku3RZylPB4QcCy5OZHd5od87R7lUTfgBRuww7dTjn2P/ioiprb/XrLh/AcJwrU/S95kwhammJBZrARGD56ZnT8OddAM8tYZWK26Eh8Yevc2mzooi8tSir8lH1mEOVlN40U9rQZaINfEzEGVYXQV4LjppGeYmQxfVgPlzddOfzSacFcLPTeNU+NgowVJ7yIEA8iUII1utcALFn2CBPALW7yi97aUCLJ8OE11j086lggiQog8TaEuMR9xQegy8P6hGufRwW8T0SAXC9iEMrzUljrqjZA3j5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXBzdXUjpGRfxyyAv54c5oR1sIyXp4E5pXfkHIxMIPU=;
 b=aH2M7qWU4p1N96PQ6oS7e5+o4/bVWgg0YQjqEjpkhVJo7dLs5eFc3riipVSZ1nyf36WoOWmXdOx+J4JOMLrQerl4W+O8DG/CLTlbuSEOwyqgpaSZDt0xFKyenNEIAWA6+MVGUhw8wzvrITaHTRppQjzLXl+zYYmQnfNvUCl8j4Ir6DB9wCeiZu6lSTBa7OheEANTaf2fC1rZygCJ5hYlg/Snj1ANbZbT/gkIUITsmTHOh1tf75R6aCYe+QXVXxFfzdIwA1HZn+e1xYU1uwlJi8y3TLzrpNsP+Yk0wEQP3ZhmjS/9SRwQPRng2uXjvscj6w82Cud2+ZgeWWMxl7O1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXBzdXUjpGRfxyyAv54c5oR1sIyXp4E5pXfkHIxMIPU=;
 b=DbJiojkmHWw/TfKQmzwBwnV9WoDdTA6cGt2WBvSnP/sQuTpBoIASnu9pCnui+mo6xg9CTHjvS9eDtvIg70f6IqzEgRBAEpZrm8KCgjZ11rKpGg5+RKT1kmlbbh6pG6KVD8/xRBQxqOOhKMQvSi5Arhu0Vg4tesPUkmazdaVzoPc=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 09:50:21 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::57) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 09:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 09:50:19 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 03:50:19 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 03:50:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 03:50:19 -0600
Received: from [172.24.18.150] (ltpw0g6znt.dhcp.ti.com [172.24.18.150])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61R9oFpf4023103;
 Fri, 27 Feb 2026 03:50:15 -0600
Message-ID: <345c0abd-c7ac-45db-9b91-2b5270ac2475@ti.com>
Date: Fri, 27 Feb 2026 15:20:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: j722s: unlock mmr after spl_early_init
To: "Kumar, Udit" <u-kumar1@ti.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <heiko.thiery@gmail.com>, <m-shah@ti.com>, <j-keerthy@ti.com>, Diwakar Dhyani
 <d-dhyani@ti.com>
References: <20260223144558.395289-1-u-kumar1@ti.com>
 <23f03e64-71e3-4fcd-a216-fef7de5a37aa@ti.com>
 <20260224143040.b2gvfhcschzznyvt@bryanbrattlof.com>
 <5a979fa0-59bc-4e00-96ef-18992b50512f@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <5a979fa0-59bc-4e00-96ef-18992b50512f@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5879ba-73eb-4886-6f96-08de75e59e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: +jJc4elxGkBAfB81hechK8dg/Lnsh2Doy/ZIlEYaBkY5QDdKHjfwM126MwYgYxx8u0gN9G/GaQr3mJMZa/u7ioo6NSh5ctpV03IX6Nr7YFg1cvaUf6F5K1zoDlzdI3f/3JI8QevfIC58mXophUfR0va+vteUYhNU7yNneoHjxRM7AZl5Dqfp7BFYDZj2ZswEUAHg6I2j40tVarKe+47dBTjKBViLGScUIRGKYDagpDH1A3mogMsjMwm49g+WkWEc6BbPxwZK2lDu2VbjM88OKgLz+Te++9sM0G4cvTwg8Kp+OnZBBpc0Xpmznr4N8564k89kxsh6+LXfo/RgQFXCSDMtdp/2IeYPGFo4dJeRfS259cJ3aYl6NWPAmln8gOEctVj2qvqDHeX0U56GiFWF5tPmmDN8iuvAB5yS3HAUoyeZCiEvHAf+xRdjgqaZQU046bkW8haQoUKPrBjHigIMKDhrONLnrBxsiTrTGD403pn7CqvgJzh60o1M1GGOx3GHKvYGhHjP+q9eT5u2Lz18wSYM5EU7ajhYaeOTHpLEpwWWPmKOJ+Q1RkZdf02gb63vvJvutjJJG0aKBi2MjP86SsS6jNygpUPwWoCLDRsnLZ3nmOm2QThPFcUECD2Wax+YmBmPgC5alsd+8hEl1XOkkm9qRANQLG/WOHEkbGxQqRLaSKEfdaD5F7HihYhGO9T7n+SJv6Zy/rL8/QVt39njAscaBO/n+OnxdvYO/e1M8ciok3xxyEcso8XqUxHWYhpSCsP1RurxDMEyjKjnWCYUJAS1rhkyodlDEDF0bOy5QTY=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OOFPuoBzA0Evlbm/PiR58qeKDDmWpQ0RlQ3FLBvGegPzX7HV6z4Odqnebzx5a6g8K0KXKlhE2ExDfgv2AkPJCj1PbuLCHi6W6LqWV4ZNicImyWA3Tp6H3zXJbOz7G0z2jwFzpRbqOzm4Tf3m10s0juz80mmtWF3UjUS72pwFtpl62wYG3WBjVMhaT0iQeAdEuCCU264VkRF0tCoTHZMJTQ+arv41FxX3gac/qB+iTURdxXKDeB7Ot8bns7rEUlIt1QS7i1wWP4B6ZJeOyqAdFRFLn4sRI/6cJ0HP7RymtUU2QfXWN5rLyzweVe8XtzrQyxV29DvmOdl9BCbhu6mHhgrZLSGxPZvmOVc/Hum7c7t9DPhajcZYT4jral4J+aaAk/5ePaQoR8DfjkKre5Lm8SJh9mRKY3pp6jVJzcLWw9hxOMK1p7fkllD3FxAO2Chg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:50:19.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5879ba-73eb-4886-6f96-08de75e59e86
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
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

On 2/24/2026 10:12 PM, Kumar, Udit wrote:
> 
> 
> On 2/24/2026 8:00 PM, Bryan Brattlof wrote:
>> On February 24, 2026 thus sayeth Vignesh Raghavendra:
>>>
>>>
>>> On 23/02/26 20:15, Udit Kumar wrote:
>>>> unlocking control mmr before spl_early_init leads to
>>>
>>> Nit: capitalize the first letter
>>>
>>>> unpredicable behaviour.
>>>
>>> and run through codespell.
>>>
>>> Commit msg is vague. What unpredictable behavior? How do we know moving
>>> the ctrl_mmr_unlock() to after spl_early_init() really resolves this
>>> unpredictable behavior?
>>
>> This is an issue has been reported by many people using any of our SE 
>> configured reference SoCs which we haven't been able to give an answer 
>> for.[0]
>>
>> The current theory is the CTRL_MMR ranges are firewalled by ROM and TIFS 
>> is unlocking them for us. If that's true then we need to move this until 
>> after the version message is returned to guarantee the range is unlocked 
>> by the time we get to this point.
>>
>> Moving it to after the spl_early_init() adds more time but isn't 
>> guaranteed with many boots.
>>
>> [0]  https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
> 
> 
> Thanks Bryan, 
> Make sense to move unlock of mmr after fw versions are printed. So that we are sure
> tifs and boot-rom are finishing with firewalling.
> 
> FYI, i just did one experiment, put random delay before calls to ctrl_mmr_unlock()
> and wdt seems to be working ok.
> 
> Another option I see, let original code be as is, and add support similar to above patch
> for wdt. 


Unless we somehow know when TIFS is done with unlocking (is the version print
suggested by Bryan a solid yes it's done? if so that's the right solution) I
think unlocking the MCU_ESM for WDT is a better fix. Else we're randomly trying
to estimate when unlocking is over, perhaps there are further CTRL_MMRs in queue
to be unlocked at that point and we'd be doing this again (although this is
unlikely since spl_early_init probably takes a good amount of time)

> 
>>
>> ~Bryan
>>
>>>
>>>> So unlock it after spl_early_init.
>>>>
>>>
>>> Wrap commit msg at 80 char uniformly please.
>>>
>>>> Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
>>>> Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
>>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>>> ---
>>>
>>>> On HS-SE of J722S in particular, enable_mcu_esm_reset function is not able to reset bit-17 of ctrl mmr CTRLMMR_MCU_RST_CTRL.
>>>> Which leads to wdt is not functional. With this change
>>>> bit-17 was getting reset properly on HS-SE and HS-FS devices.
>>>>
>>>
>>> This too needs to go into commit msg if not in $subject as this is what
>>> user actually sees as the issue.
>>>
>>>> HS-FS
>>>> https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-fs
>>>>
>>>> HS-SE
>>>> https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-se
>>>>
>>>>  arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
>>>> index 1180c75f551..a0dab5d7032 100644
>>>> --- a/arch/arm/mach-k3/j722s/j722s_init.c
>>>> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
>>>> @@ -84,13 +84,13 @@ static void k3_spl_init(void)
>>>>  	 */
>>>>  	store_boot_info_from_rom();
>>>>  
>>>> -	ctrl_mmr_unlock();
>>>> -
>>>>  	/* Init DM early */
>>>>  	ret = spl_early_init();
>>>>  	if (ret)
>>>>  		panic("spl_early_init() failed: %d\n", ret);
>>>>  
>>>> +	ctrl_mmr_unlock();
>>>> +
>>>>  	/*
>>>>  	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>>>>  	 * regardless of the result of pinctrl. Do this without probing the
>>>
>>> -- 
>>> Regards
>>> Vignesh
>>> https://ti.com/opensource
>>>
> 

-- 
Thanking You
Neha Malcom Francis

