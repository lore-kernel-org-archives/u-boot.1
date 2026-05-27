Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A43CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC9683FB0;
	Wed, 27 May 2026 07:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="M2T5H/i4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA4C83FB0; Wed, 27 May 2026 07:52:45 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FED18341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooyo2LJXK0v0siQjnXhHs9kTWGVHMo4EjlesivAMEgWfItOj63bMzaMRvW0uQsIhd60X3/Aaog0gCSLeuJ9PdZEP8F1patInYu4GDxeICDOSmCa/4/QPtiKbvGFRVsasJjMU3vUo8up1/I82W9gtymnEahaEJAAs6eykBa4T6dwmWlUt1PMPR7vjdOL19LO65jyEpahgtVXEy3PkTBdqqzGHRVhTvxEGZY1LjMSWENE3mdUj4N9PH2iK/NrlZTGkbQpBpvQNd3E3qd7JgtMXrRWDFg/FF0A+o/1QeaNW+BTB04xOqnTe/i/L4Ccr1odLFRZCLdXLpx4a8AwHAp5I9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTmw79UT3JKFQ1sItPISxSYDD4NNO9g1RcAWqF3whrs=;
 b=TW2M3PlZzi37/+TKMKwgaHF7nWU4Q1Ierl+4vkUa8G/fbCQeAPQ93wFSGoUXLP0gSacQlmH7ZlktwJ509OZ8IrkkVIG0kCd1KQWPX3I594CNYAr2qs0A8vG5fBoHEMRxSevSb0MK2TP9NNLxsbxKFDgiGxFTF06MmZuW7kq1hg8jLXXpY3+asA66ZL9NfQOVYpcYamvhqTkUew8dWUUN7qLAAbwuWggq5A1UjHWWQcj0bwEfUP+XvvxMM+OMBK3aL6memLsvP845TuFjc5IawuF9s1wxGbXfwwIhf6PxfIuv7MQVOWvyyLFL7pUmfD/+NcfZCxzsP8clcpe9PQxjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTmw79UT3JKFQ1sItPISxSYDD4NNO9g1RcAWqF3whrs=;
 b=M2T5H/i4kYoM9VuDL/1ZR29usw3UD6Y+LgQlqtHEc2SbUSWu2z09jEW7nGUKOUEjo+xu1dAv+xC3V7wpUgAX8ONuif2NJD7TwH1iXBO81BBBfNgC3EU+7DzPRrg4Labic4JyPg4LhR0CCDm+f+Za9t8uuOGMKnD78oxCTZ6OXXkRMize2flolJFchNKrQKrjkRa9sGrR1OWmraL8Gp94LIN+N/VFgcxWtOhMfKDdvdkdF1CEZrQPNx2NEl1cAhwMHqC+IuN9YEWDPU38xHS0q/RvWP2rENzRvZYp+ut2mIe8k8/d4aK2FQT+yoXE/4k7ofsLkVBECVYrWsHI4OTetg==
Received: from DUZPR01CA0238.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::9) by AM7PR10MB3937.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:170::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 05:52:41 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::44) by DUZPR01CA0238.outlook.office365.com
 (2603:10a6:10:4b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 05:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 27 May 2026 05:52:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 27 May
 2026 07:56:22 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 27 May
 2026 07:52:40 +0200
Message-ID: <a1046652-e8ec-4188-ab2c-c44ac52ea495@foss.st.com>
Date: Wed, 27 May 2026 07:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: stm32mp15: Increase SYS_MALLOC_F_LEN
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Anshul Dalal
 <anshuld@ti.com>, Michal Simek <michal.simek@amd.com>, Yann Gautier
 <yann.gautier@foss.st.com>
References: <20260518-master-v1-1-37fd4df56609@foss.st.com>
 <47740fa7-a75c-497d-9982-4292ef5764a9@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <47740fa7-a75c-497d-9982-4292ef5764a9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|AM7PR10MB3937:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ac3723-1443-4279-4518-08debbb42a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 6+w8u6XrvqWenGka3Hg+8FC++D1xjon/GYJSkm/AcBuxYD34n8aFLG+8mdkChe8/VZGphmqsQGN+FQ09U0d2xndTRhWgeLCsodkRCZJ62WEV8gAjPWd2aSq7YeEZPNisksgCwl2tUJja86vvfrUngjviCawJCMjHscOD7uVXxUOVcJbixQKJ9w9dC6fg1cJpcj35lT1Zb7/UqHUfZolx5xUTD1El0CMn9OYirZUbn3JrnWy28ohMTNWC7eHpTYuVlpc2Ly169XCdgTL393ekf+xB+46iWiw7CXPf5pq11wUP3KlQdGXYAlPIz9b2tPJxSpqxkCYEHTjfuAclVjWQ8SAOGrad+Ofh844mIRPonpp+PX86Fahgg6V9jYJRHB7RqX9YiO7r+Y4+JUMokfotSgsX0mAbonKUxYTzKuPsgwxvm/uiF32yJ771Wtf/NS/LMKEShwTI9bqdS9nqeaxJ9UCHGXjypBzb4+wuxHx3edQIvWC1vGIO8jp9mZU4DuQCK4W/yUFNK03Pn/A9yZq1HTfo5n4tsv1LH6m5yadJfYgrqGx+4O1ZcFtfFTg7J4vvFcXenB4/rc3RS+CVki6Lg/6brRmYuuCdiwu0pTg3OegV5eulpwxDKGDVXv5KKCUkqzhTgZ6Rc+J5nwWlO9IQdgErKByuojt7cXrJBaJ+QM1o8lO+R24E571MFUDAe8lXg02aeEsXETabTxArULSoLwYPKzvt0W2JBdea/0GkXc8=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uOqjE9lFs+ga09TMAT8x3q+6rLN//4oa6IGmleR/PK/jUycPhi/tppv1FCNKLx1PExvYbKs0ak01Im7Nvr5oJkUTcLRPrUZ20FVdbHVrod8j28PvOsyA+MAeGlvfjx+BEPjAfFbCxIC/gbJaxA7utLmAz/4yuWun0HpiXNfz37LjV2dophzgZuqlgn3fUDQkE+gRKbBY8tFIcuqGGZU1+h6xZck1GNU67feiz6YROn55XhMsu6+txOvaQHCilj1C+m1pPWrIeozYQfZO9/kxDpju2OAVj1fUyzfwY/Pe/npj36ZMqaXkc0/sl1tvR12P0p+rcFhV0LlkWmwnuHiZ4mxcP6CKmVhW8yScsp1Gas53bCYCF9+VCClWctcTSOaBGK1wlepQJbiza+slBcM1Xg6ZDFzO5jbXboGhAmBzqoBi9028zD5NNa9XZoTOCON4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 05:52:41.1163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ac3723-1443-4279-4518-08debbb42a5a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3937
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



On 5/22/26 10:10, Patrick DELAUNAY wrote:
> Hi,
> 
> On 5/18/26 15:28, Patrice Chotard wrote:
>> Using stm32mp15_defconfig with stm32mp157c-dk2-scmi.dtsi device tree
>> with optee-4.10.0, we got:
>>
>> U-Boot 2026.07-rc2-00052-g215496fec59b (May 18 2026 - 15:05:34 +0200)
>>
>> CPU: STM32MP157CAC Rev.B
>> Model: STMicroelectronics STM32MP157C-DK2 SCMI Discovery Board
>> Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2-scmi)
>> alloc space exhausted ptr 80060 limit 80000
>> optee optee: PTA_BSEC invoke failed TEE err: 0, err:fffffff4
>> alloc space exhausted ptr 80040 limit 80000
>> alloc space exhausted ptr 80020 limit 80000
>> DRAM:  alloc space exhausted ptr 80040 limit 80000
>> RAM init failed: -12
>> initcall_run_f(): initcall dram_init() failed
>>
>> CONFIG_SYS_MALLOC_F_LEN need to be increased to fix this issue
>>
>> Reported-by: Yann Gautier <yann.gautier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   configs/stm32mp15_defconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
>> index b9e44254087..cc4dfd9af70 100644
>> --- a/configs/stm32mp15_defconfig
>> +++ b/configs/stm32mp15_defconfig
>> @@ -1,7 +1,7 @@
>>   CONFIG_ARM=y
>>   CONFIG_ARCH_STM32MP=y
>>   CONFIG_TFABOOT=y
>> -CONFIG_SYS_MALLOC_F_LEN=0x80000
>> +CONFIG_SYS_MALLOC_F_LEN=0x90000
>>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
>>   CONFIG_ENV_OFFSET=0x900000
>>   CONFIG_ENV_SECT_SIZE=0x40000
>>
>> ---
>> base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
>> change-id: 20260518-master-059c3c757a19
>>
>> Best regards,
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/master

Thanks
Patrice
