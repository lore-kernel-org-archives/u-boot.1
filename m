Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B591FD4616
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 04:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4423283C54;
	Thu, 26 Feb 2026 05:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="weB7KwPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A7C83D1A; Thu, 26 Feb 2026 05:50:22 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazhn15011023.outbound.protection.outlook.com [52.102.137.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09DE83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 05:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVuZLBPlW/ORadwSixg4Mhi1T+xngGVDP1bSIdbpzGc2NWklbWoM9C6hJLIQMmkrAzrRcUe6Th+ij7P/nfaBpN5vQi0iHCW8ZTo9Zwx4s9mKX70AkPsNbIVTJD4nUdwUJFS9Td9wJfKxdbG27/VuNrnEafbTKNHcBetsHg5bz2WKAgzgD8sTeGxr41UnhLpGQg0tVlZbi7XpLhqoF8VE9GtXymfUXzUMLt/96QIMp8oELQCdIX0V1KsIGfQvTyxndkwZlvBd/lRd70dk/vEf2nobREG76AMYJKiVnkcAQFKyWceG2+Xlrgqtd8u9t6XIXCC64dpLJL4+sdvxCtnhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Ui9J9HDrQ+x5yMQbehagjaISvd5jssb/wIpQD6LfM=;
 b=CqBz58XtMhf5gVVzmb9NeLz4rYFylgLeJ1VOS8fuIrap+v0T7Xyn3Lk/Ulo7xa29E0fdgZM3C7PVn+hsA2yejLa3l5SSfk/QjB8DDf3+KWdLYJcTlsDUa8K/slccwNSe6XMY2favWNrGqJ9Jafk18Xvnmalc1Si2Cxn5N86STaCahd6ZskMSadSeJEbfB1l/01vqojlMu03y4DALx2kjMw6B6ItGWo0eJx0WbbUQu7KT8y4SgWe2mpB/jOJTE18QTYGuR3C0BZrqBzIsDWK8J10Z1YbdMdTghEHaTvsBEtab61LbF8G8LMjUq3xtMtvOfSgGHnn3GG+uKYcjTW93qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Ui9J9HDrQ+x5yMQbehagjaISvd5jssb/wIpQD6LfM=;
 b=weB7KwPQwx4Lin/JUwAmjNzV9LsIG1w7+uzm5L8kS/J/Zl8xywQmyQsMyx41TcSUCYYcPviSkFsFi+9bUau8cqlGICYnCtiaZhyAApK0dlpXbn6PiB5Y4gPFeKpteIIwNOLD6hu6JsCisAbRuv00ag4zaIOzzgEgJQcAnuq8DaU=
Received: from SJ2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:a03:505::9)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 04:50:17 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::ef) by SJ2PR07CA0023.outlook.office365.com
 (2603:10b6:a03:505::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 04:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 04:50:16 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 22:50:15 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 22:50:15 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 22:50:15 -0600
Received: from [172.24.21.26] (lt5cd2489kgj.dhcp.ti.com [172.24.21.26])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q4oCSj1233508;
 Wed, 25 Feb 2026 22:50:12 -0600
Message-ID: <f21a0fba-0a19-4f95-88c3-41e0728fb888@ti.com>
Date: Thu, 26 Feb 2026 10:20:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mach-k3: Defer CTRL_MMR access until after TIFS
 version response
To: Vignesh Raghavendra <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>,
 <j-keerthy@ti.com>, <n-francis@ti.com>, <bb@ti.com>, Diwakar Dhyani
 <d-dhyani@ti.com>, <u-kumar1@ti.com>
References: <20260225051559.416445-1-u-kumar1@ti.com>
 <50d29e78-1502-4dbd-ad24-a1025142947d@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <50d29e78-1502-4dbd-ad24-a1025142947d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6c05a6-4e97-4d28-e0c4-08de74f2891a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|34020700016|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: hU7HUIDfOmjZ9A9ASQGaS3BCjUlA6M4xHc93+moTd0HjccRyGrv6TMhDlf4+lyHNHV2eTqff6IsObmxlHhttvNLXaqnhFCOtuAACaeyurtm2a8+lyxpWkhEiVoYAPqC5tUfVx9xIR5824JKKLJ8++ySAERlB6Nm6O3DNt+3JyzhejwAc9JoaFyaLh5SPq+m9Im8JEFcjX8eUtRihHXwS5MQ3c3DIYL31cctHDUBM5ZxuknC/ra0kYteR4bs3yT4ixaaivGmkk9DwjTGrDzla4E9R3p2Bnc8WbSh6SJhtc2gzrNOIGP7ywBe8eZHKA1Ji/6o9pYKR/0AK1n7k5j1BFQJSvq6Vlcsz4rFYkimygHTmvc2Kc/f52R0iaxaO+CtMejUodF5kXSMuHGDKgJOw2Og0In0IlJkKQpEqguK2ZS/SQDZlozBUUEOplLxVm2CNvE9bYd79O+chKPTsFi1cyE9ARB6IfFg+3YfvdM65wXmOOobUzFNeJiM21t8pUM98pNcxqZI0WAmquKedEsf0mJer9hQ5dH+RUsJabEK2VNfwhPvliOY25+WwKpgOKmAv+Uz/IfcLLcRyrC7ISg2xoUFwd2OGtFEPjDTpmPUpBAUSXpUf8Asj7R1GiBr8yjrJbQCzOGOwIOhtj4wvSoARG0lC4hoJTp7rl7cjHVg0PaKtTj9aWnjICXjHO2VWU4QsRJ6HlJ1zMQHvfDaJ8DovM9cDMuXxc4ZOgvy4n+shq3rRuzC2kFYOJucnvWS+ykGM0tj7KZuzPdGlXP3Tay61spU5Bijvu4mrSmU0gvDT8p4=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(34020700016)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xplAsbmFbSCKxfpAvPdi0GxOF+M0lZt31hqPsUTdWm8iK+GaBtF6QGB9rAHCSLICcsnx8SezXFYqMPUE1nE5g0xAFyvlr/RPXAX5+FUVIc8B0NK/cyU2FnohBdexZMb6m6LcDGPfl69YsTddVhgKjSzior/JNHZdcDhvc/AoIEUAOvNoT8UUjndrp4KQIf51UR42Uk0Zf/D7dhvLuNo7CpPFxNWTvXs/U2z1Wv/c/agQpARNwZuOvgOTVj86XFbBoshKtBk96emdwEw3V4BMdSwf+G9WjnIwBdM2WklGz7wWu8QrUdZWAgDxKsD7Wkpjk4jhbyEiUg4pl5pRIkWN3eIMnOWHxNVLU8MK5+tF0V/RT3fECOMTCT9KTwERWAjxoVjGgHCb5QP6E8qlgoNQZDNpb5VnzsGUtuNGe0xWp1dpWWxALdpa3+xXQuwc8kxM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 04:50:16.3027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6c05a6-4e97-4d28-e0c4-08de74f2891a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
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



On 2/26/2026 10:04 AM, Vignesh Raghavendra wrote:
> 
> 
> On 25/02/26 10:45, Udit Kumar wrote:
>> The CTRL_MMR registers are firewalled at boot time, and TIFS unlock
>> them as part of the system firmware initialization sequence.
>>
>> Current code assumes the CTRL_MMR space can be accessible at early
>> stage of board_init_f execution by unlocking them.
>>
>> But on HS-SE devices, TIFS takes more time to complete initialization,
>> and CTRL_MMR registers remains firewalled and not getting unlocked.
>> Which results in any write to these registers are ignored.
> 
> Hmm, this looks like something that can happen on other K3 SoCs too.
> Should we update all the other SoCs to follow the same logic?

Yes, we need to update all SOCs,
As Bryan pointed out, this issue is seen on other SOC as well[0].

I will post for other SOCs as different series. 


[0] https://lore.kernel.org/all/20260224143040.b2gvfhcschzznyvt@bryanbrattlof.com/ 
 >>
>> So, move the CTRL_MMR unlock to a point after the TIFS version message is
>> received, ensuring that the firmware initialization has progressed and
>> CTRL_MMR can be unlocked successfully.
>>
>> Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
>> Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Changelog:
>> Changes in v2:
>> - Moved control mmr after tifs version
>> - updated commit msg
>> link
>> v1: https://lore.kernel.org/all/20260223144558.395289-1-u-kumar1@ti.com/
>>
>> Test logs of v2:
>> HS-FS: https://gist.github.com/uditkumarti/c66ecbe800b4b3549fec3e505fe26dbf#file-hs_fs
>> HS-SE: https://gist.github.com/uditkumarti/c66ecbe800b4b3549fec3e505fe26dbf#file-hs_se
>>
>>  arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
>> index 1180c75f551..32a3eed40d4 100644
>> --- a/arch/arm/mach-k3/j722s/j722s_init.c
>> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
>> @@ -84,8 +84,6 @@ static void k3_spl_init(void)
>>  	 */
>>  	store_boot_info_from_rom();
>>  
>> -	ctrl_mmr_unlock();
>> -
>>  	/* Init DM early */
>>  	ret = spl_early_init();
>>  	if (ret)
>> @@ -151,6 +149,8 @@ static void k3_spl_init(void)
>>  	/* Output System Firmware version info */
>>  	k3_sysfw_print_ver();
>>  
>> +	ctrl_mmr_unlock();
>> +
>>  	/* Output DM Firmware version info */
>>  	if (IS_ENABLED(CONFIG_ARM64))
>>  		k3_dm_print_ver();
> 

