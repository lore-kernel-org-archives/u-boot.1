Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EBEE9B260
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51BE983E85;
	Tue, 24 Feb 2026 14:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Y2h6+mt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE89683E9F; Tue, 24 Feb 2026 14:23:22 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6ED482BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRR8FPry1J8SmX+Ad5Bf2UrikEeuj8EK2m28QZh4mxWuGkl8Va/FpoCJv9vgR5K7CPyv2dw8uFNts8YFMLfqLImvXZAzGIqV1diCudIVbslvnP4MtN4eZTK+CwI51+mSAzXjQ4py8g2LsRSYqNJ/dqUGTiIlopX2T9wQVaSGNe80XpsWA860jfq21ebE1kj7EIIbIo4/vxV/0AWWN6N27UAx/dbPGrJ+isArRb81sdsCq08YSu1z/YlR0s+Xr5DeetATICiMjJ6CIRg9aVxMs/eiE6HSar3mi9l7cfKt9ZPIiQeHYRO7RNRt5amclDg9CJ/CX0NEW08RBnN9OqBpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUkC9nP59IbjyavUTe/FqKV1oCk3x3AeIJKqBFlGBHk=;
 b=cRLiPnv1JApVGaU8dts23BYu+jvcyMz44HMXniiSiTywqDhFoaDheYHMU/zOCYThSSJ+bDEOgpq2ZqQcHczu68kvyjV8uJZveV2hyuoi4Zs8LkDBSuZClMuMv99gpD2tGs3+EHgzGSTDz5CYs8QNymAWvaEB1e/5JA4BabGfan3xZoCCnIguC2k/wIa3ALtgSftAO5tKCNI7nfI3dijSrmTPA4+xuBQubewLyJLlfa7CcQB2Ki+aawBgrcYCFQMjK0DBeJoIIezBahNmxlPe0SNm9FT5HKjE/fCRa0CLedY3Sg02JUdmyUcQos1YCWMfo4FvtUsNzUQxu9PcRaG/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUkC9nP59IbjyavUTe/FqKV1oCk3x3AeIJKqBFlGBHk=;
 b=Y2h6+mt/jLPjEmRZQ0ukYrbBGVm8A0ciSscNqRMDmM4+kctWC4CKhZ3ALsyJnbSojpuaPj4oXndkWN/tj+NcYtZtnfSOJ6LlWhgaZe1W8Ms6/yX54VMrComPiWhk2N4zMAF3uxcpK2pt2pSTQvafnyfJ6NcTsPj8sVNV/+YmEx4nvvoU5e9Ve4hVXndEY94pZALlZbjyxwTnoZpQXdCRT94SCIzDvuQ2aJF1hdp8ZieUXIWEeSdHPwV6+3he/hXhxkt1ryGrf71paiuki22aM76XMaFnyC6TyGzm5teu/3ef1jrowLNSjqYcbqyd00jOYexiBIy/IRqWO+ERas5Aqg==
Received: from AS4P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::18)
 by DB9PR10MB5164.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:326::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:23:16 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::a7) by AS4P191CA0003.outlook.office365.com
 (2603:10a6:20b:5d5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 13:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:23:16 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:25:23 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:23:15 +0100
Message-ID: <6c355ae6-f952-40c4-9ee2-f2d6f7613a9b@foss.st.com>
Date: Tue, 24 Feb 2026 14:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: fix array bounds checks
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
References: <20260210-upstream_stm32mp2_cpu_fix-v1-1-f37c509d79da@foss.st.com>
 <d97423f5-ed08-4c70-8061-686a8effc97e@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <d97423f5-ed08-4c70-8061-686a8effc97e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|DB9PR10MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2deb50-1396-496a-d05e-08de73a7deaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODdPVDJsb3dXOEtRaWJyeEJXM09VbnFzMTVxYXRxTFhQekZPRWRjclhqNUd1?=
 =?utf-8?B?cEg0cUFUdURQWFRNUW9KVldoSzBRS0tGdEhzUEpDd2lvZldTWUxZSWRZK01q?=
 =?utf-8?B?QWZvOXo2VUowQmVSUUM4ZHRRSGM3MXVFaXZLaGMyWjFpNlFMMjhFUjBtNEh0?=
 =?utf-8?B?aFZKcWIwL0hjeUppOWkxUW52cjI1L3ZPTUZvVDlDODg1ejZUNjd1cnFWd3VN?=
 =?utf-8?B?Qi94NFhrQ2VvNy93UktUM0tvdU9SZit2UnJoMjJPcVZuQVp6NlQ0T3YzMnlC?=
 =?utf-8?B?T1hqWFJLc3kxdHl5bTVic3pnaG5qeGFoc3NET3h3SW9NODZGbVMxc2pXVkFV?=
 =?utf-8?B?OU83dFB2VzlVdkFua0ZnbjkweSs4K1kza2tRMkIyemdYT2lqUHBhL1QxOG54?=
 =?utf-8?B?NXkra1dvN01WelhvVjVSMFYrYm1LKzZ1R1Evcld4TTNJT3lYNlY0MHJUNDlH?=
 =?utf-8?B?VFFmZFVJckpjcmRZQ29INDhnTHRWU3JBRW0wQkZueXJ4b0QveldHOWxqRjlZ?=
 =?utf-8?B?c1FHcmZYbHZnWlRUY3pCRnFLUUFybVY0ZDR3QitHTzhac2tsaDU3WnZnZnhR?=
 =?utf-8?B?S3E2ZCtKZVZRR2poOEc4L3A2YUIxdEJFMTM4b2Y5cjU2OExRWGFrNGRtalh6?=
 =?utf-8?B?Q3ovdldHQXRQYW5SVitpSnB0MlAvSlFxeWpQM2RJUUpyMHJQb0d2RjJneG1m?=
 =?utf-8?B?TmFvNFIvZDVmTzkzL2sraHh6WmZKSnlhblVLUjltQWVaKzB5OWdSOVJwT1l1?=
 =?utf-8?B?SjBlbUVNd2Njang1SVFMWmV2VmdaK1FYc2o2Z0UrWVdqanI1Z0tlMEoyTGhu?=
 =?utf-8?B?LzV1blQwUTJleWFzVWdHR2FZakltMjkzZmRyTnAzQ2NyR1B6b1UwM1BsUlgw?=
 =?utf-8?B?SnpxZlBWOFo0L2xDWW1EaXFXUUh6dVFlZDFXV1A3dFFmb0tkM3RYemEwQlFr?=
 =?utf-8?B?dlFGWXpvTVlaTm40bFdQSDNNT3BjMzZnQzhQWDJNM0pnWm8zWndxckZOWjc5?=
 =?utf-8?B?NDNBZXNaV3BTWldmVzYrblEvdURmYWV2eDFnU1NqMG1nY3lYRkNnWG9pYW1T?=
 =?utf-8?B?akFxc1dsUWV5bHpaaVZ6VFU4RU15ZkQ3NUg2cmNibzlRaVJjQURqNXBkQS9h?=
 =?utf-8?B?MzNlS29MME5ROU9oVVRzZ3hDVHBJRWpGaXowYS9aME5TNmdhU1QrWnVUaGhi?=
 =?utf-8?B?dDN1dURPZDNpZWxxRzVLSjB0eDNHeE9RNlBMRFdYRHdCeUN5UldsQ05DQThk?=
 =?utf-8?B?TUdrYVovc1F4MXd2VTM1b0ljbnlXNmVoV2dBcGV0dTlWMmszUTZxYU45WThm?=
 =?utf-8?B?aWNmVzdPUk50U0VObnFjeHplajhQTHk2OWt6WStieXIwOTlKdUxIL0EwVldq?=
 =?utf-8?B?UUdsVU1TNFVUZTU4OEFlM0JsSk5NMXl6VjV2VkpQUysvY0t5REJBUEFtTWNK?=
 =?utf-8?B?UlgxS2pYbDhGOXFmTHlUNWdIVStEVllwdzBlMkUrcDQxMmk0U29zUzhkZ0l5?=
 =?utf-8?B?L3h2ZnVvQU05dW5OVVVCdURwV1NXK2VTVmYrcVZoWXlYNVNiaXlha0ltUGF4?=
 =?utf-8?B?d0tTSnJjTmpOSkRZWGZoeGI1TFoxeUYyMlJtdmJocEMwa3NDenA5VmhLZXNM?=
 =?utf-8?B?QUd3NFg3VDJ3bTZxSGFRUWdwdjlUSFJuSUxKYkdSRE9wWENPVVMzbHFreGpp?=
 =?utf-8?B?SHhQUG15UDZOZUxPQVUzeml4SVVUMzJKTnhFVkVDYjlqVXR0eC9NclczdHVa?=
 =?utf-8?B?am0xdXEvenV0SG5YUFRKV0Z2dGxGSzlaa2xyUFYwSktWNTdXbW5FYmd4M29U?=
 =?utf-8?B?T1dJTEhYMjBMVHhham4ydFZFREIzWGhGQU93TnBQKzBMc0FEdGt6WFRDckEv?=
 =?utf-8?B?UE9qc1hHeVJabzZ1M25BRU91THRLRXFIV1JNa3REeTBhRWM3bFl0VG42eWs2?=
 =?utf-8?B?SzNvcXg1clJCMTkwQ3hQcWdwdmZBWWRLVElZOGY5OEdtS21PU0R6OEVSOWpQ?=
 =?utf-8?B?WC81RHl5VUdxNXh5Z3pKaDJpWVFkRitWdi9lakNNVjhZcmJ6RzVVYVFZM0JZ?=
 =?utf-8?B?eDBYU2xsYmN1bzBaVEl4RlBkYXlUT3lLd2xPWlUzVml3Z1d0VUlZdlg2K3dO?=
 =?utf-8?B?LzQraFR1Vm5SMXZsZ1ZUVHlYRGo3d09yczgwTE01TjY3OHdUMnoxTEtpTHpv?=
 =?utf-8?B?WDVsRGlEODB3R2hWNHZrM0NURGVVSWV5bjJhWUd0VkZSZUxQa2dBaW9vMkRM?=
 =?utf-8?B?WjQyK3Z4ekRVeXU5YTZEMjNwZm5BPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wp9C/fcxnpXpHfVdcy+MOPfCa1+GhtcRbTFOd+Ee1dtzGksuyxzbkQvCs40pzynFVapPzuogAeU+GSekt48mCwA6rYzvJUvyfqX2wOi91bECMBbPksZDufopQmiL8sOsCEz0DQa5ygfvil3Eg0tD8PVaf8uAyHUSBF71EzPJaLOlQ8vY7Mr1lfsfGlX2RXC/9wzNI7BIYaFmEnbQfTbiSYZOS4ivm4TppgzMIL/FsM0/ZzduI4pEIsXPrakUYod5KrSW8cqnN1OwWwTYuNnb97YBogMXWZd8/HMPWVOgMH2FpqI75lt0Il/8bpCgzj2xprRhC3aARjLGaqDwx1kW7LnPD0vc+ZjfHEzlKjeC5axF3raIw7BJbAal7LJ4U3pbFPX3DOnYIbYhkDSkShtqTD+xQ0dbRasyrlx2yWeppwVE9EfECHnCcDAPWpp4gqBx
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:23:16.5140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2deb50-1396-496a-d05e-08de73a7deaf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5164
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



On 2/24/26 11:34, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/10/26 15:57, Patrice Chotard wrote:
>> Fix index check against array size. If that index is equal
>> to the array size, we'll access one-past-the-end of the array.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/cpu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> index e081dc605b8..a8a6bcf8ab4 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> @@ -148,7 +148,7 @@ static void setup_boot_mode(void)
>>             __func__, boot_ctx, boot_mode, instance, forced_mode);
>>       switch (boot_mode & TAMP_BOOT_DEVICE_MASK) {
>>       case BOOT_SERIAL_UART:
>> -        if (instance > ARRAY_SIZE(serial_addr))
>> +        if (instance >= ARRAY_SIZE(serial_addr))
>>               break;
>>           /* serial : search associated node in devicetree */
>>           sprintf(cmd, "serial@%x", serial_addr[instance]);
>> @@ -178,7 +178,7 @@ static void setup_boot_mode(void)
>>           break;
>>       case BOOT_FLASH_SD:
>>       case BOOT_FLASH_EMMC:
>> -        if (instance > ARRAY_SIZE(sdmmc_addr))
>> +        if (instance >= ARRAY_SIZE(sdmmc_addr))
>>               break;
>>           /* search associated sdmmc node in devicetree */
>>           sprintf(cmd, "mmc@%x", sdmmc_addr[instance]);
>>
>> ---
>> base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
>> change-id: 20260210-upstream_stm32mp2_cpu_fix-bbbd24ba4f99
>>
>> Best regards,
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice

