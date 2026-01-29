Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E90D358F1
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86BF83F4D;
	Thu, 29 Jan 2026 11:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Z7bxt0b0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A40D83F59; Thu, 29 Jan 2026 11:33:34 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E873783AEE
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8w3vErVhPt9vAu1DUE4o++0h25Ak7Qi8IVWucx2ge+qzsnO3XrjKCTC5xHiluFje3EYTRfLtjDDXIrBl6dG2PylZlaPxuhmYcgfZ3dgy18WndUob0zxkVeBgWPUWQlQw4sGiU3f8PuMmg46y/4dfjEolW1ncpEOegPLLdjD5Zd8lSSkfMFcBjk/Jc9W0wzxwgTv3k2+Bs2Zr2HO/2jADel1BNyUJeOIUyLCgCB41Hq4Yefoo684qimwxKBb9df84t14bBJESQvkJZ+E1h5fhvZakQsMtX6/yGKXvm3nHJ5EGTng7ZkX1QDOht988cEt0AIUqMg0RCcWYlHBz5CBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg9rualm6I+4sqpZOuDOZOgvuag1k8VyV9Fu6s4Om6Q=;
 b=fm81yqX32T6IE+9+TsQfvVdJ8q+k+DMZmh3Yeq5Fk3JLUwPY4JC/I5bSUewj148rSHfaO3cCcTC54/7FbYqS1a4ku13Z6ruSyNuawr4IHYgYiR3Fk7bKN2lwLcwe2SCWk0AxIBxevGygpWKDHhSbUng3DVB90G+3e7X1lnBUJWSa4WJ0b1Ii2Fdgc58FUfzKK7KlyepC1pvv8KRJlBP48X4dDplwtpsSrVrztOuMpNhPV7+mPpG8qxxYqsaXkyhY7vtaZhKzp7PGTaFejLBEEwbCIx+0HqH0ip6BU9fpxXNoCfWV/WyHzxOzuyz8uZLisfhSmUUNANjXRyfT7ffj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg9rualm6I+4sqpZOuDOZOgvuag1k8VyV9Fu6s4Om6Q=;
 b=Z7bxt0b0z7OWZmdG3NY/YiGy5BKa/H2gHQvzQqepvYAaOKvQNtaTqcGe5n3kNZRHPxfzh4kruI6+pYOgepqyuHp4jbOISlYgbihBFGn9jHAuHJkK4fETz1+H7c4P4gZzuFLvBbKpYA/z+kuzLQgnMa28FuVM6qqhYZ1Wd84NY75MN51OM94zYDXF5F3OeYcE5xmqKxTlZmh5ZWg5zcJHpWvX1iqMa4eGkIqp21WC3VniUNK+wX7btMmbkG2aaTnCcw3N8Qd2/TREUFGcVJf0H8se0h6hXdz94D16xuIK43bLJeYrS/jti4bFh+YQbFnbwzQn4QCCixePrMNh8+9vvw==
Received: from DU7P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::14)
 by DUZPR10MB8233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:33:27 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::a) by DU7P190CA0028.outlook.office365.com
 (2603:10a6:10:550::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 10:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:33:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 11:35:09 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 11:33:25 +0100
Message-ID: <c32a978c-17eb-423b-b2a3-5b2253c2bb53@foss.st.com>
Date: Thu, 29 Jan 2026 11:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] video: simple_panel: add support for
 "rocktech,rk043fn48h" display
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>, <u-boot@lists.denx.de>
CC: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, "Raphael
 Gallais-Pou" <raphael.gallais-pou@foss.st.com>, Philippe Cornu
 <philippe.cornu@foss.st.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Fabio Estevam <festevam@gmail.com>
References: <20260127-simple_panel-v2-1-c50d5b23881e@gmail.com>
 <9b46b3fc-e46f-4f85-9053-2537920f6db7@foss.st.com>
Content-Language: en-US
In-Reply-To: <9b46b3fc-e46f-4f85-9053-2537920f6db7@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.129]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|DUZPR10MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef6a8c5-9bea-4b94-b019-08de5f21d684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVRydzlxbkMzdGRhTE10YjJCOERZTVNJNjdnWXpPSjVZVHo3S2FJVVZhZFd2?=
 =?utf-8?B?N0lXbUhFSVhJMjRIWEF4MExzNml2TFVMZ2dkKzVmbExHcFEwWnVqVkxGWjZj?=
 =?utf-8?B?dm1ZMzNVOUdCcG83eG4rbk5NYVlPamVEdThPc2RKK2h2R3hxV3Nqdm5jSk5w?=
 =?utf-8?B?aWdMdDI3N0VoVmtOYlBFb2ZWaEpEQ0tqa29CVFM0ek95by9wQkhrWHVZNG45?=
 =?utf-8?B?RHBoV3dTVTkrbHMvVjhZS1JDUm94WllOZzVieEdPR2F1OXNnYnpaV2dTbU5X?=
 =?utf-8?B?OXNVUHpMYTFJMCsvUWsxM2E1OGRTbERLMlI2M0xYSnlyN1pDZjhpSHhaSXFK?=
 =?utf-8?B?d0s3RGhKa1JkbVErRXZXMWZibUlibDljV1F4UFIxaUp5N1hMRmNOeUM0RWF3?=
 =?utf-8?B?YVlPNVZtTUc4TFcvR3JnbHIxSldmUm9USXdOQmU3S09YZ1FKb1RKRHJHMnV1?=
 =?utf-8?B?NHVBWWw4dW1NdXVyWHltV1BmeDVpaTR1cjFSbHJMSW1FS3VWWklpcWp2UjZT?=
 =?utf-8?B?cTAwV3MwNkVjYktRRUVmTFpDVnZNd21nSTVkS3RoR1MyWHlzSXNvTjNsQThq?=
 =?utf-8?B?VHcrVkFSenQwYUVEeDVKY2tQZVJyZUIzOXBJdnJOZWpnTHdrdEk2a0IrZmVW?=
 =?utf-8?B?WGlSZW81SzAzUlV0YWdvaU5ITjAzU0RPS0pBbDFVM3FWd3hJOEFYendwKy9D?=
 =?utf-8?B?MlhFUTl4K3BSNEN6cWpJOXFJYTBVQUFRdFNQUVZRYXo2Wi9XY3BEdmR1VlVY?=
 =?utf-8?B?bDJCb0VqcTJDenhmWFBmRUdoK3NlaGh5NVVTOUFlUXBNSmVRVUtGVS9XUnJs?=
 =?utf-8?B?K05BaStOVTRtK3JCWnNGbHhxTDVoSDQrSHR3bVFXazhNUmJxbisxd0FtUGo2?=
 =?utf-8?B?anpDaDg0T1RCN0tyckZCWWdZTmpZZmtJSTNNZm9qeUR4RGNabDIwNCtqQ0xo?=
 =?utf-8?B?WHQ0MzE3Qk1HcFhSaXVrNEdtdGtlV3NTZVdwUGJIRllvSDFRNkF2bSszaTFt?=
 =?utf-8?B?T2MwQVhwdGQ1blBIMlVvUHcwbStVM21mU1JlMHovYUpGKzFlcnRWY0dnQjJD?=
 =?utf-8?B?cTczMHltTzBVMVpjZ3V1cjBzYkhtdnpidDVlVThmTzdFaGE2M3VERnZsTFE2?=
 =?utf-8?B?a2E5QW1xdzFWUVRjVGxsSkx5dXVmbWlHaElXeVIzWmlpSkNoTVQ1UEhPaHBv?=
 =?utf-8?B?dWFmNEE2dGtVcWRONE9rZ0RYcGt3REIwbHk3aDAzd0ZJTExVZHRqUE1pRElm?=
 =?utf-8?B?R2liSHdmaDZMS3pidWN1dU94NllPbWxRY0lVYzFKQjRJdE44WXdpNTN2WEU1?=
 =?utf-8?B?aGlMamZXMHk4YzhTNC9lYi92blA5VHFJb2svcDNJTWV6bUNhdldwdzdYRE9J?=
 =?utf-8?B?aEVUTEthVXpUblAzZ0lhSmdnRE0xY29LVVd2R1dpZElhR2N0L0VZMHhPVDFH?=
 =?utf-8?B?d0JPR0N1ajhsUGlLeEl4MmpEbkovS3VwTGI4N2RtM0g2UngzSUJNOE44M1BC?=
 =?utf-8?B?RlpXNEhJL09lSWlYS3daNUZBZEJmZm1pOHVxcndYWTZIZHJaNlNJdGlHSE9D?=
 =?utf-8?B?WWU5NFczNC81Q0NhN0c0Q29vQjlhZWRoc2xVUWlIejMxa0J0Wnh4VVBVU2k2?=
 =?utf-8?B?NFp1VDVFZ3NRZ3NPR1lVTnMweEJFUnduN1Azd1crb2kxSWR5WHk5SzdFMm5L?=
 =?utf-8?B?NmlNVzlSbHBVVDYxRHpQYmxqOUJELzl6d2JOSmNkcUl6UXRRUkJSREFUTXJu?=
 =?utf-8?B?dkFCZUtNMHNodDVLRWhRMWxwZDczNFJMQWl4cUR2ZVhvdGdoQnIxQzJINU9Q?=
 =?utf-8?B?ZklLNTEwYmVudlRqbHlDNFJwcWxxOXhjanU0TTlXZjBucTFPVnVqemliTndP?=
 =?utf-8?B?QWYydUlUaWhlK3JPV0Y2ZzdBNUZqSy9WcEI4UHplQUNXbWtRWEdtYi83MElh?=
 =?utf-8?B?U0lxS1RKRkUzeDJBTldGblFHNHRwRGJFekl6aFp0RkdnTTVIZjh0eTVLRDFL?=
 =?utf-8?B?aDMvTVhXZmRPVzVoa0UxbURzNVZqcDAyclMxUytLR1F6SE5vL0NDZzR2QUJt?=
 =?utf-8?B?Y2J2RUJubUU2aVJJcmpwRWd2WnhyU0pOT1VRRzJoa0xJV3oxYzQrN3o5MytN?=
 =?utf-8?B?Q2dEdG5RTEtCU2lGSWRUSlp3VmRxMXQzVHpqUGdJaldJV281cFpEWlVWQ2No?=
 =?utf-8?B?dFEzRkJuOURSMzA4TTRwNGpnMDlwbGd2a2NHelUya3lscC9WYWVKNFpwZ3dK?=
 =?utf-8?B?TitzQmx3QytmWEh3Q0lnVzRJbVJBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jfRl6FNKp93LGwSQxQQDr6i5vI63EaGCUnbPcMQqGsffm9BPW6fvo58IPWzlgkp7k8TtQgV/Z5Clf77IuAGyyMHPqHdn/JYr6phy22gpH+IDr9bSXg8rK9Ek6ZLYSDmPLqPRQcYOVqZ3JcoBznUmphesJhsYuRb+dZRjEV8FmNUZWuAq/e3kaWbbppIbGnG9y9IPnNfxNCQPzmpMN+ts5vz/o292Y0aP1UQ8Sw5WAdbo2/nboZsHmecDv510MG3DaLj5/V+lLDoBBcOu0paEuAMcrF76BVuB9MmVlDWNCQssCgdCrtlgB2KsbSiKP+F+kF+mw0QRtfX5855Xc7W8C5vi8LN5+9BZyWZvP1aAsiqP/MA8oYljv6g2KU9sdHYa+GZLDu3SYHIhWC5zc/zAv4aGfe90ULhEoFhtwgaqbMxVuI8OshM6cTi70vtMGFrRTEY4WqWxEKpghYXkr3B/ylTT1WfODdOoIt/6itxmU7hcgccE5yUgYrXOtj/K6d1nesMmoIp2f0VfnIbrRqfx/1ZeYgH57ICX+Nr29lCfMEQfqL+ozbNIWMaXn9wrNdbhIITFPee52s513WN3E1qjHErpBEE6idmu8ZGVquN6AGdUZBJ6Wh+vSEpsWgGxNEWoTCNg7J6L97iKZ9JnaPzPXCDFb7WmsgDNTBreG5NvhcBnBmbdYkw74Sg0yMlShmCc4j9/6moUmMgdtb5okRTmow==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:33:26.9661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef6a8c5-9bea-4b94-b019-08de5f21d684
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8233
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



On 1/28/26 08:04, Patrice CHOTARD wrote:
> 
> 
> On 1/27/26 12:11, Raphael Gallais-Pou wrote:
>> Add the compatible "rocktech,rk043fn48h" for simple-panel driver.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>> This patch has been tested on stm32mp135f-dk board.
>> ---
>> Changes in v2:
>> - Rebased onto latest origin/master
>> - Removed unneeded blank line
>> - Link to v1: https://lore.kernel.org/r/20251207-simple_panel-v1-1-8688d221aacd@gmail.com
>> ---
>>  drivers/video/simple_panel.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
>> index 8fa7ea4e87c4..1cf587f973be 100644
>> --- a/drivers/video/simple_panel.c
>> +++ b/drivers/video/simple_panel.c
>> @@ -251,6 +251,7 @@ static const struct udevice_id simple_panel_ids[] = {
>>  	  .data = (ulong)&panasonic_vvx10f004b00_data },
>>  	{ .compatible = "tfc,s9700rtwv43tr-01b",
>>  	  .data = (ulong)&tfc_s9700rtwv43tr_01b_data },
>> +	{ .compatible = "rocktech,rk043fn48h" },
>>  	{ }
>>  };
>>  
>>
>> ---
>> base-commit: aa4f687977a449686498236722ee5e93d8b39918
>> change-id: 20251207-simple_panel-1a910ee5175d
>>
>> Best regards,
> Hi Raphael
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Applied to u-boot-stm32/master

Thanks
Patrice
