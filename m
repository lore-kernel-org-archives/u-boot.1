Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306B4F3C9BC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F7583E63;
	Tue, 24 Feb 2026 17:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Rr3OTwYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9EC83E76; Tue, 24 Feb 2026 17:44:58 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1355383E13
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vm1G9wIBy5rsMCeOO3jxz0m2d/SyLZU6pKRz1r1W5CjXnKj7C/Q8Kt2vV5m2wp0bQkThcU+dhcAU7b/ryQB8CuFX+egCFNjlLmAVDrflBLtNEQwD/XqdhKjsvHH64nYPEveUM9aJ2bvOYvXxR59v8c6a6ixB4efpxAQWvP9XJFSqFP5z9tHAVlJbs6LKXIYTbiyC7OsryK4YjtY1XHhsWLLepeWlr3R5CSj25dV2L4coOcgrTHRZc4ZOr77qEg/YNkxiz9vL2QZgWZLWa1nlwqU7h73jKoh7XUK9hNq1xfCUkGhPgt7LenffpStPKhVGwKFAjJlbWFGuhw/mYX8pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOTu51gG0jOGACzTJ+j+g8KxaGp6h9N1MkKDm0/Wih4=;
 b=IzbElNXqYNqLMBVCnptq1otyEXoI1epW9lHjnzDt7RFwqyK6ZYIEdTU4NJp4+xwXxCb1eegOJVgEXy4EK0K08EsbXiOu1D8cN2JJYYP3ripa/I3v4T8o2tHUGTaY8/udmlVPMLzWK+0l2UpEFl5rrF1rqK29jHDaM8vwRP1BpFpySP6Es1olg7l6JjM7x8pCsnwPcEamROJDOX0Gu9r2LyVQ+VNEujbCEQytQHB+mMFA4zAwovKGLLcYNpyGJh6nBdPL+kC7FpulMkXf1a/vg0niyxS2sgB3si1qUVvNGrFPsPaaKPOt6M9zhGw58AfjebHay0zPLtvripqR97WKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOTu51gG0jOGACzTJ+j+g8KxaGp6h9N1MkKDm0/Wih4=;
 b=Rr3OTwYfQhua6nQJa5PGg+Uncsnf2YRUbBb6SIXjleSdazd0o5CdTFM0WXc+qSkT+q5KLoGljYg4/4AbF0gRhAhP4jg0+SpWJx04OviQ3O5hFXuGzhm6vwGmVgIHw2suN9+FXcXvY8+LoFZEYoVJguw6t+J6VbP9d6yrMQC7Nor5ol792HJ1aOiBli57Wq+Pf8eam2AQ/MaofmSzfkZPfXz8zQewu1ZcZpKTWnC/puZ0sPcgYC9+YDa6c40SCLUJZ2efmiaqt1TzYp6heroypNrr8c8iZI3c+glkQFBlHMJLp2NU4rD5IyWGIu2ceKcH8PyG/bRxMAwTGMSVSMYVpQ==
Received: from AM6P194CA0044.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::21)
 by DU4PR10MB8576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:44:52 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:209:84:cafe::c9) by AM6P194CA0044.outlook.office365.com
 (2603:10a6:209:84::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 16:44:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:46:50 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:44:43 +0100
Message-ID: <6f9717af-390c-4bc9-a585-69622b67b072@foss.st.com>
Date: Tue, 24 Feb 2026 17:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] stm32mp2: Add check on syscon_get_first_range()
 return value
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Asadeds <md.asadullah@eds-india.com>, "Marek
 Vasut" <marek.vasut@mailbox.org>
References: <20260204-upstream_factorize_and_update_read_idc-v2-0-7f0baa41d2f1@foss.st.com>
 <20260204-upstream_factorize_and_update_read_idc-v2-2-7f0baa41d2f1@foss.st.com>
 <15be74ae-0ff1-4117-870c-87ad6201a5f6@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <15be74ae-0ff1-4117-870c-87ad6201a5f6@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|DU4PR10MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 80881a12-0567-4e54-103d-08de73c40804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTRCSklZc3hhZHppZ293MUlodlpVNTRnYjkxMUNWV3ozWmtBK3d2NGI3OHFk?=
 =?utf-8?B?TElVdk5OMzltRVd3N0htZWUvTk1JdGdzUlNQdm1WY3NaeUhzNGFTMTNjTFFv?=
 =?utf-8?B?bjkrWjZxc1VtRFg1ejd4Y2dGc0t6S3NTbTdJdGRGTWtZQmRXUnFTUlB4UHN6?=
 =?utf-8?B?K3hDOW5RU2p1UFVaRGc4MnhQdzNhTWhja3hZVW44NGFxamhmUWdlMkpHQnZi?=
 =?utf-8?B?aWFqTFRPZXJkeFF3S0FvLzNPM2FHWFJ3ZzRUS0FPeExMMThjdTFmVEVZdHhv?=
 =?utf-8?B?MXcwb3UrZTBhSnNLY0EwZVUvY3FCbVFjanFHVlNtd1VzcERGcnA1NFdNajhP?=
 =?utf-8?B?NkV0Ym82OW1URlhucDU3aWlSakRMdVBrd0N1a2JvSU5EVEdQRHJIZ1g5MG1W?=
 =?utf-8?B?WG5ROFZNS1VSUFN5SEx2RnhCRkxiNHNNN0xLYnV3TVVNMmpYdmpuWUdualZ5?=
 =?utf-8?B?Z0JMN0dTT25nMVJLMFJkQXpPdmYvaitoaS9vcUNpR3k0Rk0yelY2eXRxaXZ4?=
 =?utf-8?B?ckx2akhtUG5jdkxYTzl4cmdXMUZwS3ZMZ0xOSFJQNldZQkZ2bG4vOStLOUNt?=
 =?utf-8?B?ZHlXQ3lKRlIvOW5tUE1wNEhtOGlpaVBKcHMyN1lZaHNRcVp6UHZFeENWaFpq?=
 =?utf-8?B?RGMvQzg4M1c0RVhUQ0tYMGhBS2IzbmMvQ3NkTnNkNXJLb1RsQzZHMDdZOTJK?=
 =?utf-8?B?NFprNWhzQ2p2SzNtRzdRQnFZNjhqczJwdWRIeDVNcjh0SXk4NlJRVWtRUHRX?=
 =?utf-8?B?RGtIdFlxYUs2TzhrNHBMYmtoMjU2NUpvMzgyOVNCckhDZTZEdEJKRUtEazNj?=
 =?utf-8?B?bjlpR2Mxa3dRNnVGNmJLdFpiVEEwU211V2tGUFFCNUlySEx2b3pKU1ZhRHcx?=
 =?utf-8?B?ZUx5N0hGUTljT01aN3pLUVNwU21YY1NFZmREaVlQTnlXRyt3STlmeDZ5dnZr?=
 =?utf-8?B?QlZsYW5QdmJub25Ya1V4UG9ya1Q5WS84a2M5ZGpwenlPZnBuRHdTdithOWRo?=
 =?utf-8?B?VzYwOC9TaC9TMVh1UVBneTJqZmx1R1dlbTFTRTI4VlBDbWFPellXRGdZVWts?=
 =?utf-8?B?Vjl1cU5Zc2VWSTJBM3djZnNwTFUxWlRWdW5lMlVTeDBDM25QbmZCYzQ0TGJG?=
 =?utf-8?B?amFtTEhoYlFKNGdIYTN3cTdWTkdYSDFnWGl6N3NIcjhwZEZRNE9EeTQ2a01X?=
 =?utf-8?B?em1mdWpPOW9XSTRRVXVIY3phMmNPZEEzVDJVeHhzeTB0Zzk0VWJIQXV4T0Mr?=
 =?utf-8?B?NG1QUURSOWJxSDlqMVdkT0tzblUwNG5QaXVCcjlXaE9xYVkzeS91Z0RqTlUv?=
 =?utf-8?B?L1RQdEY1UzJNUi9HNXp1Qk9HZGFWOURPMUttTFlHSkdqR28vZjVMcVRuZm1B?=
 =?utf-8?B?Q2RDZ1ZUcXJJRG45NkZrY09WZFNwaFZudEZlMFI2N3pkN2M1Z1UrMkRTOTA0?=
 =?utf-8?B?R2h0QVV4SGlTUjYzVm1aRjFEbGJ4akNtNzVpMWdGVzlwejVrZTFNSHJaZ3Iw?=
 =?utf-8?B?eENaMFM5Z0hDK1dHVkRucU8yV3kyUytZOVV6TUpoeFJRSkZ5WTVSWElKWlEr?=
 =?utf-8?B?MW5ZNlpRRDh5dENHNDE0SWUwbWNWY0lzNExxNVB6NVpVL21ZWnFuVTFVcGpQ?=
 =?utf-8?B?aE1LcXlWOHlkdXYxakc3U0NGTFRWUVk0YkhKa04xQ2pHMU5uWDg5SVEwZGdZ?=
 =?utf-8?B?bWRwSUJURUhDNGZyVHc2V0dKVExib0xjQVFaL3BoaGd6cjY2YjNncWVkcmJt?=
 =?utf-8?B?MlpiVFhvRTM3d3lYQTFBSlNuUWVQWFNpazFaclZ4RW1IT1dqRHNIRzcyQnJs?=
 =?utf-8?B?NW9MTmZaL0RKbS9MU2Y0SlJaaGwyMHBGeU1EVUp1TTcrVExhV2FMWjBYZGpG?=
 =?utf-8?B?Ty9Xc2dJT1dxQlJTWnhGNDB2RHk4ZW8zSFJ5aTkwQ1dCMzFJRmV2QzdWRlBE?=
 =?utf-8?B?NVYwU1VBb0hjeklLVG5XMjMyWGY3TXBmcEJLUWdyMlVMUnhFVnhSZCtaVmh4?=
 =?utf-8?B?WW9ZUitoQ3pBaTJxd0lMNWErZ2tYem94dWNya2tkZjl2eHBBMmYxSGlwVno0?=
 =?utf-8?B?SS9lRFR6Q2srY1l4U1o3Vm1UMllobituRnd0Y3JCczZObElTSis1c05nZllZ?=
 =?utf-8?B?aW5DK2tjTUc1QzJjV25pU0NrL3JOTktmR2Y1SFN0THhQSkZFS3FWMmVWWXBY?=
 =?utf-8?B?YWdRR1gzN2dwUUhLSDlRRlQvamZsS0dsbytDcnhOTWQyQjUvRVFHQXc2QWZ5?=
 =?utf-8?B?OFFZRHVOWXFLZnhsWkdDd0toQUV3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3q6QXhkRMWEadQ+VW7P5O/UE4XumIIe/u/z61pY2clYsKs/XQZr+ldAmKDYzsdoZdYI93JdTVJ11+BTtLmTN+EFpJT+6AVc/LaoZvP8vIh7YC+3crfWcF06adxGeWG7Hjpj21UTt9BzJ5U7FK8BJSizcTPzOGAWzBS2FxkDgFrWAW9cppQyoIUT//M0vztuPtFYNQCjOcNn35IsVt/kNIKwpoOCfhTlDZtLid7HhoIw4dZL9kRS56ZULe7c7q3YQUXBtFtDwfXfLD/LD4LMrwCHEWpJPtgU461nn8GgIuIfWVNP2U5xB+9s2m4eRS8QHUdOHfv+6q17rLUIsNooo1jScbfEu4CHeQ05UkJj+3N2sv95IXy/sfq0j4yL/lSglmr33WTLMN8jX5nTzNHuDiRwbJXFSr6QaV4ZFA3UAeHq47mX6zfE7K8/XmMLqrGXK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:44:51.7605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80881a12-0567-4e54-103d-08de73c40804
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8576
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



On 2/24/26 13:56, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/4/26 11:16, Patrice Chotard wrote:
>> syscon_get_first_range()'s return value is used as base address to perform
>> a read, without any checks.
>> In case stmp32mp_syscon is not binded, syscon_get_first_range() returns
>> -ENODEV which leads to a "Synchronous abort".
>>
>> Add syscon_get_first_range() check on return value.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
>> index 551601a12a9..40fceac402c 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
>> @@ -9,6 +9,7 @@
>>   #include <syscon.h>
>>   #include <asm/io.h>
>>   #include <asm/arch/sys_proto.h>
>> +#include <linux/err.h>
>>     /* SYSCFG register */
>>   #define SYSCFG_DEVICEID_OFFSET        0x6400
>> @@ -30,6 +31,12 @@ static u32 read_deviceid(void)
>>   {
>>       void *syscfg = syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
>>   +    if (IS_ERR(syscfg)) {
>> +        pr_err("Error, can't get SYSCON range (%ld)\n", PTR_ERR(syscfg));
>> +
>> +        return PTR_ERR(syscfg);
>> +    }
>> +
>>       return readl(syscfg + SYSCFG_DEVICEID_OFFSET);
>>   }
>>  
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
