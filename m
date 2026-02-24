Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628CCEF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8633283EB3;
	Tue, 24 Feb 2026 17:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IfSUXN8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8576183642; Tue, 24 Feb 2026 17:49:01 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7817883EA6
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhkphL9Gym16QPZvJnyi5JBMLRX7FkFLUpGWEQoV1rr4TK+tRkHyHrjly+OXA7wTfXU+0ZXf1b5y5Kp+UrIU+71ILQjQ47Ade2dbdgOoeVyGFpuBfse2EzHLoh5qoyDDXHUSzul/6rXnDAP3y9aaSsHUIxqqXpLBqUN0Dn8hy/RrTz3wsBsTdIpt5J1EL5zkU3/DdVd4S0a3ovD5tIDaXFeGgQoxiTWMvG3bQksoDrdzP73osbKgFeIrWlhiDj0vSOE6yWBfI56o2WhH21z+ebWl0De3sysTmpLCZClBXJh1l1WT44yYbgu52A23i0YbEc92RkNq//3d4bEfDldK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkIsyEbfMNyVpi5HIx+GujtGAF8yWsKS6bUDfODAjFg=;
 b=s+OfyG0mWPyfBejPnLdjhADB9V+bVXl/JVCnvQXURHNUXU36vWVmqPZmmrd+hu2p5PnT5/J0AE3hVIsK/IXNZ3WkoGxLU/W/PH4M3tj2PwWJQYH3fbWej9A+RcDL8/jPAwu+PkmlocOiGn5pG4Ezl+/Mh+L9z1wVF9CNQMDbPzSbTsv6iEojlOfXx6wn657gm0iXSXWzWaauCe684nii4h/hattVVAzvMA+vEZxMSwSo0ZeaPRhsx5P8FQuWBBV8gWDqaDypeVndxUwrgyuFidvcYoiuWNZr29buaTjoQsjUBohcg/uciXIQTinY+WTahPQkms3fNIwHv2JwFkKErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkIsyEbfMNyVpi5HIx+GujtGAF8yWsKS6bUDfODAjFg=;
 b=IfSUXN8LeEMzcsNvIw4HD8rvQiCRYLT6ijCr0HfCH3AUVp6IYjSUeRmnJojHnfcNDX+/XpLN/xqKlqXlRxuYO5/3R/2CZBd23nUbPQrg5RD6RewcNhhn4P9zcEn9OykrFhQKC3DYrxotDgPuH9FxQ+vEr6WWocnWQyWzccaiv6S/4CKuZ4N1Vz9DxOoFG57LQ6FzcDUnr4PUZV4qANwd++Dh09TVUbr0Qsc/1jcK24Rh0+wJr8ESwt6L0uRlymS+INm6k9CeHNrOFadm+6dn4iK1+GOQq0RSmUSuNN1fa/J3yTumTBSEpAT9RGkCt7z9KJoXA5MPVCHoYbijh11cLw==
Received: from DB9PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:10:1da::14)
 by DB9PR10MB6523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:48:57 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::46) by DB9PR05CA0009.outlook.office365.com
 (2603:10a6:10:1da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:48:57 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:51:13 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:48:55 +0100
Message-ID: <1f53acf3-e4e1-4025-a93d-9fd074049fe4@foss.st.com>
Date: Tue, 24 Feb 2026 17:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] configs: stm32mp25: Enable CMD_STM32KEY
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Thomas Bourgoin
 <thomas.bourgoin@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
 <20260204-upstream_update_stm32_cmdkey-c-v1-6-d95374395840@foss.st.com>
 <49814c80-1331-4af3-b270-0a9662cd139b@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <49814c80-1331-4af3-b270-0a9662cd139b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|DB9PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: c156b770-1293-47d4-d60b-08de73c49a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mmc3NXdwUTB4cHRMRktFalhmL1FRK3dPWVdPWDdIM2YvWG1QSHpGaTNuWE5B?=
 =?utf-8?B?VlVGRjh6MXVDOXRSZ0NjaE1PblpJckpray9ESm9CdHRRUVBlQStFMU9yOVVR?=
 =?utf-8?B?ZWRmbFJXRVI1OHZ2YmxPblZzRG04aVkwdmIwaHlSdTRDNkpzQURGeXgzMVlC?=
 =?utf-8?B?NFJ2QTlNOGdTcHAzSzdwbDNRS0VrMEh2Uy9oMjdkcHVZRVBlQjhSemlqMjhM?=
 =?utf-8?B?UTRDbmo4bTllMlhjNk04dW9Ld0FHdEE2VE1JNE13amxNSXJoVnRJR3AyWFJt?=
 =?utf-8?B?dG1LNFozOFEwbzR2ZnBZdlhWOUxsTlNGSzU3L3pCQ0dTaEdjdnJvcmVVMmx3?=
 =?utf-8?B?Umd0T2dZTHY5THJoaXJpazNzMDF3WEZ3SkZhdk1JTGwyUkt3UU1rdXluTmpS?=
 =?utf-8?B?ZHd1VEI0cXZnNS9qZHlUV3ZaOGkrRnlpd3lEQmk2a0ZRdW1idHBFM2MvTFFI?=
 =?utf-8?B?Yi94ZkQrM3gvMHZjSE5ZVEgwZ1ZPbnFiYURFcnpCemprVklyaCtNcVlqbzdl?=
 =?utf-8?B?dEFGTlg1eWVaQlFOZ0VXT0ZTYXI4UXpJcUxvNDZRTTRUelVUelNSYklheExB?=
 =?utf-8?B?eE9PczVycHc4T1hrdkYzckpLK1pxQ09iY0tNQnFCM1hXSHNRaUJHZ3ZBZkxR?=
 =?utf-8?B?N0tmMm9RWlRyMnlkeUY1V3JWeWZ2eEFJamxBVzI3SjZOK25HSzBieXJXdlJh?=
 =?utf-8?B?UGtHZ2NVdVdMS0ZkSGZ2MHZ1VzNhTDVtVXJhbW91VnJ6anF4Y1FBbVZJZTJQ?=
 =?utf-8?B?aktxMzdIajFsVU4yc1h3S1p1N2pGSXI2K1UzT2RLMHlMcEdGVUkwY2FLbzR4?=
 =?utf-8?B?THpETzBEZ251bDhEY281L3htRzkycFRaV0NURkdpd2JJak5hMXdtZDQ0bFht?=
 =?utf-8?B?ai9zdjhWa3NmcEdveDM2SG5xbUlEbkYzRVlZS0FidTZjUm8rNVpLdTlJMU9E?=
 =?utf-8?B?VHkranpqMVkxazFUUjdYWlhTL1FDYVF4TytzUjNpeW5xQjZwTGdsdFVlTk1w?=
 =?utf-8?B?MVlsZHdGRlp4cHMybzRWeWhpUE50TWswNTFldFEzSWdDQXJvc1dUZGpvdmdG?=
 =?utf-8?B?ZnR4OHZtbC9MQThPNVFMd1NQQk5VTjlBMDgyUDdMUDY2L3BJcnFFTTduOTk0?=
 =?utf-8?B?NWJJOCtUd01HcmdMR050d0d4b3hoaTl0V0xwUVRUV3oyMHUxV0EraS9LZEZ6?=
 =?utf-8?B?QW8xV0Q3VzlDRVhCVWZucGFwTVBJV05LYndDcytmUGVaSzNFYStHUWZFWGo1?=
 =?utf-8?B?b3NSTjlqYStzTS9MNWxkbm5jRFYyVnhJUDdneUkwRmdCL09EZ0tqRGl3ejZI?=
 =?utf-8?B?dFc4WHF2VmI1ZkdhOFFPWHlQS24zdVRRZkRXZ3JCNUh5M05hT2hSSnRVNmVh?=
 =?utf-8?B?ZXJvS0VEaEN5ZHJvUmdJdlpTMzI2TE1qeHFxa21BYlI4TXBrWE9YWXYwcWVl?=
 =?utf-8?B?VHIzNERQcmVpTytIbnFLWXcvT2JSU0ZseXdycy9BejhKSU9Kd0VaaHFoUEMv?=
 =?utf-8?B?Vk9EQ0owQ0JvcjRscHhEc1d4dVo3TkF1elBZTjh3eTNLSWNmMVNaK1NJZlds?=
 =?utf-8?B?ckJNMjVSOFlVQXVQb0xJc1lDZ0xKL2tVZjZZVVhDdDU1Q3dScWtsQXRjOVJw?=
 =?utf-8?B?TFBQNTZjRXNjSVJSM3k3amY2djdVVllKOElKVVUrQnFIcUZTVHNyZzZzTnJY?=
 =?utf-8?B?cXhtc0JMakh2OGRvQVIwK0g3U1dBOVRvejZ6TXZyTVVUb3c0Ym01UUxWN3Vj?=
 =?utf-8?B?TGkwNmplQmE3SUJsaGVWdHo5RC9TZk9UNVcwMktqK1h4QnNXcU5IOGNjUy9u?=
 =?utf-8?B?UEltV1hsZjdkL3BYdlM0N0xvL2E3RGtFY0JOTzAxSThVU1VRNEdYMXVJNlc1?=
 =?utf-8?B?ZUlJeWp1dUJYT1hGZytjYjAzMVg1bzZyWnZEdm9FQ0dqRjlTVVpveklnQlhj?=
 =?utf-8?B?dFpWblR5ZitrcDJWWVlhNk80TENEYVpxR2hBeC9IRUkzdHJpZy9aOTFKZ3l5?=
 =?utf-8?B?alByQjBKRlNLV0tJVU5WR0x2TGZYYmY3NjNyV3dZNWl0cmFnb2c1TUhHM25O?=
 =?utf-8?B?VlZ5ellQcThTVFRUY2lpZGJGM2ltdkZUbkk2QzhGd2lFUFNxaVhPUFJjLzFn?=
 =?utf-8?B?T1hEa1pORUszQnA5ZTZvL3dncWpzTXhQcDVpVUkyUUo1QTErelhGcDJkdHpu?=
 =?utf-8?B?Yk80S1NmL1NWeDUwQmJsc05nRWkxc2t5UkhyK295NzVLT0UwWGxLTlF5SDFp?=
 =?utf-8?B?c0U1TmNJNmpCWi9EMVZMRlFMWmRRPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: llwgI3ZAGLkbfnB4Icjs4zhFwZR6dEyJUOq82K73ILs+ep18E1b02++A0bfxmZ+MtFFgxc+q/ouHbtv65xDiZRaI9ndUXSODvteaPS8D4zSeW1QHNCYWbsHkoSqzsjWEfPIUrSdU5TPDaKswyEi61khKqr7Lf3S0vV5oErQ67bdjlJ8IZLF7Fiyyc961OH/ZfwDy/pvj/1lii27e4kp6lzz2vhjifC0Hq0FF4d6QuoqmYQtiW4r1ZTyLdsu1+dU2f3jhmGAuI0DYr4dSOg4D7yJOv5IyTJfanTsX/rnVOIoghDSqLvN7GkzlWwv1+c1/SreX18k9FF5n/Ej33x6qTeMp71ajjtbWexBzGHWCleeEYWdd3FLsKJE1weYVzYHWfnPwcyvwQKpewh0MQkyk3qaOzXJTIiUZv+HspOewA83SbCsQUvrg6PsxHWAVj35g
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:48:57.0912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c156b770-1293-47d4-d60b-08de73c49a41
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6523
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



On 2/24/26 10:18, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/4/26 11:20, Patrice Chotard wrote:
>> Enable CONFIG_CMD_STM32KEY flag to enable usage of command
>> stm32key.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   configs/stm32mp25_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
>> index 234a6a8abdc..99b22a68fda 100644
>> --- a/configs/stm32mp25_defconfig
>> +++ b/configs/stm32mp25_defconfig
>> @@ -9,6 +9,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
>>   CONFIG_SYS_LOAD_ADDR=0x84000000
>>   CONFIG_STM32MP25X=y
>>   CONFIG_DDR_CACHEABLE_SIZE=0x10000000
>> +CONFIG_CMD_STM32KEY=y
>>   CONFIG_MFD_STM32_TIMERS=y
>>   CONFIG_ENV_OFFSET_REDUND=0x940000
>>   CONFIG_TARGET_ST_STM32MP25X=y
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied to u-boot-stm32/master

Thanks
Patrice
