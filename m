Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD06D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40ED88DF5;
	Fri,  8 Nov 2024 14:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="STUy3To1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75CB088D70; Fri,  8 Nov 2024 14:12:49 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882EF8900E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baXXpNjp2jUG1jcrRl6M9/i9FciPr9mrJCbzL+Ykls9+gm2/147vj06+/7HV8z6mvBI6uaVXdIlEHAs4JGGU750FwX46I2K2WLL13nujv/IHQHxnTtOo1MSUEMqRuD+Z2wPpP9SPZ9/ipbAIE7HEki0V+AZqbV1HxrRf9HX+sB+Vcgj1D4p6d2OYYadmy6b3DE6gjl+FvHBlh0K/qECcc9JStVUeDaVAqF/1apjLX8Kz2XDQoiieGISrVOPG9M5LTUMRQexG0JVok1yBFiArDtiWE8gJKso3SCg0UKG9pdrsrTV72se9+HP6ph4/4ne5nrcvGX7bPp0BURSd99UzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5pByIo+35pVuEKQhfhNog+mC8ZfqWZjTRjixSu0y8g=;
 b=LxeVwCAjGw6p3okCw+LeGisfPUyacowPfkRMFN+G9/ACcCud3IabMp/nOAOiGVVjnPULX+f2ZXCJhEv9kZc4hTt2X2KT6S6hPIUe4Yh7w8KF/LNlUrHlHPUP0n/nqBCol8/OeKrPRpj8oLmIZkTyWr99lcKsBAsPjEr6u4gikoVDnAuA0OnpjjKIC9FNo4JICrWd1GL77f95/yMvnGdasxuAZke1jJ/fYYD95JJ+xIk6tsj3kXaqFaYOcjMr1Q62xYZO7Xk2h5KBDJ3+ox+0PO3kzv00U+S8DGadBgk5gUAvVMAsNh90jycbMwBzdTJEqmZCFyKqIn4RdD/d/LbPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5pByIo+35pVuEKQhfhNog+mC8ZfqWZjTRjixSu0y8g=;
 b=STUy3To18Rg4QIYw092Vt8b87AEgjs3ZNrXzdf8YeqDzVsdA9rmZrCKvne6o92TX2AQS2b/Q9YmvxvwNMM/N7REXcfhzDoZfntDYCz3AXkE+JZhW1t/7tbLyrH4Hzm0zcEsxCsEVCEWRZYxKeKvDIPJQQ2DOlOhd7R4u1W3+30Y=
Received: from DU2PR04CA0347.eurprd04.prod.outlook.com (2603:10a6:10:2b4::27)
 by AM8P195MB0866.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 13:12:45 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::2) by DU2PR04CA0347.outlook.office365.com
 (2603:10a6:10:2b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 13:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 13:12:44 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 14:12:44 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 14:12:43 +0100
Message-ID: <fd6491a8-e76b-479c-b57f-7fb5662f3759@phytec.de>
Date: Fri, 8 Nov 2024 14:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 2/6] phycore-imx8mp_defconfig: add optee
 load address
To: Yannic Moog <Y.Moog@phytec.de>
CC: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "manut@mecka.net"
 <manut@mecka.net>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, PHYTEC Upstream <upstream@lists.phytec.de>,
 "sbabic@denx.de" <sbabic@denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-2-bbc3747a60e8@phytec.de>
 <34054407-c686-4ebc-bd38-77ddc0e89625@phytec.de>
 <98dc43a41ed8f8051b6f33761208766d448bc7b2.camel@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <98dc43a41ed8f8051b6f33761208766d448bc7b2.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AM8P195MB0866:EE_
X-MS-Office365-Filtering-Correlation-Id: d08fd680-c622-406e-b36b-08dcfff708a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm1GTTRVVkJwOUNOQzlJRzlJNCtDWk90cDQ2bVlEb0l1KzlBUlJlT0RBcC9Y?=
 =?utf-8?B?ZTVrYTF4b25yU0hMLzVVUHpmazJEV1BGY29LbWw1UlVqcnFhUzZ2dVZPT25K?=
 =?utf-8?B?V1V1ZnYyYU1DbWk4MEZZOG05R2lqZjVyS3hQS1BEazNUN3dndW1zQlcrZzlE?=
 =?utf-8?B?MUtKZlAxTEVRd2U4L3l0RlZ5c2t2ZzFhOXdqcHVCek9ka3E3dkdrbit5cUZ0?=
 =?utf-8?B?cFRlaFBwc2ZxQmJGWCtOL1BDY2NqMDVPSjJqTW5wcFhEa2M1NWNrRkFwc0hw?=
 =?utf-8?B?NnU5STA3MC81UDBDbmlZcjBMZTRqaXBiUHU3Nm42SlByQ1dueXI4dnJURUFw?=
 =?utf-8?B?WTRzYytuTnZtaE9oSXNtanZ4cnRTSDdmeG9VelFXenlsY2RxcWlubkw5Ny81?=
 =?utf-8?B?ODBCL0daVTRPZDdKMU5ZYjFxK0ZQSTRrNnNaK3dTaXpaNWU4ZnkxSEI2TTRz?=
 =?utf-8?B?SlkzQlhPcnBGR2c2OGU2alk4TVdMOGE4NnNaOVBYM1VPZXJLL3AwSys3YTB2?=
 =?utf-8?B?aUh6QlhTRkRFSTdLdnlLdVVJeTFEWm5kZTYrRkhrNDg1eG8yZFlPeFZONjlk?=
 =?utf-8?B?RGprdUpkQk9HeWV5OVYvWFJQVnhEN1lpaHBMZzZIWHRXMlNUQTJ4STVobURQ?=
 =?utf-8?B?dTdsMEtPWUlxMGxjckVDa0xwRlpLeVhPZ0RHOCtjVFFxdHhPeG53VmNaWGZK?=
 =?utf-8?B?NEhuYUw0bVVjYityZHlKR2NUSTRBUVhnOFRaN1pnNVNSZWtaWmIwR2x3aWJq?=
 =?utf-8?B?RmdVOVNXUWZ1T1RyZVpxdDJwUzdFZ2QyRTZCYTljTXJMZGl5U1liWVdWOWk5?=
 =?utf-8?B?aXA2T3k2UTNOTmV0Q3QvOVJJVERERE0zdW9KZmJNcGVORktZem5GVW1xNytY?=
 =?utf-8?B?Z0MrUHFZU3hINFc5NWcyMEJDeVRRbGI5WllEd1JiV0w3RmwvbWRFcUEwaTdO?=
 =?utf-8?B?bFBOK1BTR09EbEpXM2NHUVVadk9GdGZCRXBLZVgrSDY5S1ZEZkROMHZvQjcz?=
 =?utf-8?B?bHlQUzRrVFZTUVhjVDZ0TEVNV3hhdWYvY3Y3YnlHdUZ4WEJKNXRqT1gvVU5G?=
 =?utf-8?B?WTNERzFRQjlEdkVYYTA0R2QxeDkrcUNxTld1Nmx3NWZzQWthV05QL25zZ2F4?=
 =?utf-8?B?QXpaMXA2YzE2R0FUNDhpSEZ3UG91Ulp3dGtEZEpGWGJTYmU5RU5oMFE3Tmth?=
 =?utf-8?B?N25aaXRGVlo3ZHpmRnRiZE9icGRlS3N4NUJpOVhsUVNObnpRWEJNTy9yQW1E?=
 =?utf-8?B?NE5HUlB2b3RQSitFVXd5MnoxTzFwVFR0SzhnVU5jalEwWVVraEFOSTViSnVl?=
 =?utf-8?B?NVR1ek5kbHBDQUU5NGNlMFVhMkJTalp4WTVRTmlPclhkZ2hidHN4MEdpZy8w?=
 =?utf-8?B?Smd6WHNRZndyL2QzRTNGRnIrMStMUHlpcHFidGM0eUQ0UWhRV01HMVpjTWla?=
 =?utf-8?B?WC9wc2xLaS9WcWV2M2VZQnBOMjZTeW1acjJvOGlnSVdLS1phait3SE01NGxp?=
 =?utf-8?B?disvNk1pZm5zQmx1T1BRWHhjdy9qU1F0K2k1dWJuenJqbUNUaGd2Y3NlNHgw?=
 =?utf-8?B?RFhqbWYydklXWk1Gc2JzOGZHTlA1Si9YYWEzUlZvNnFTQjRtSEpvMC9xSTdH?=
 =?utf-8?B?NlhpVmRhbkxScGdLMHpiYTM0alNwSnZLaXJnWEFQWHVLdjN4endvcUJ1RjJY?=
 =?utf-8?B?MkZlRE8wNjVpRFl0TlM4MWJVM1hMMFRMTGo1bVNsWG42T3h2SWh5dWd3aUpz?=
 =?utf-8?B?cWZJOFZITDlrOTF4YnRibDNLZDZQZTMyOE9zajRGOXF6M00yTVl5Q1VxTWto?=
 =?utf-8?B?K0JCOURVRUtXNncxb0JYeFdacEFLeGlhUTZ1ZFZPTzFhWTBiRmF5eFgvMTFn?=
 =?utf-8?B?SU1Dbmc4ejMwVmNIQ3VIT1FWOUNSUVRtQ3NuYjhPZWVaOVE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 13:12:44.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08fd680-c622-406e-b36b-08dcfff708a2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0866
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



Am 08.11.24 um 13:55 schrieb Yannic Moog:
> Hi Wadim,
> 
> On Thu, 2024-11-07 at 09:52 +0100, Wadim Egorov wrote:
>> Hi Yannic,
>>
>> Am 07.11.24 um 09:23 schrieb Yannic Moog:
>>> The phyBOARD-Pollux expects 0x56000000 address to load optee.
>>
>> You are already defining a default for IMX8M_OPTEE_LOAD_ADDR in the
>> mach-imx Kconf. You can drop the patches touching the defconfigs.
> 
> I would like to keep these patches as the default value is "only" there to get a functioning build.
> To me it would seem there has been no thought put in to what the actual correct value would be if
> left as default. Does that make sense?

Yes, this makes sense. Up to you, it was just a hint.

Well, it will become de facto standard if you put a default value into 
the Kconfig regardless if there has been no thoughts on the best 
location for it. Other boards will probably just follow and reuse it anyway.


> 
> Yannic
> 
>>
>> Regards,
>> Wadim
>>
>>>
>>> Signed-off-by: Yannic Moog <y.moog@phytec.de>
>>> ---
>>>    configs/phycore-imx8mp_defconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
>>> index 1240c7fcbd0..910109afd80 100644
>>> --- a/configs/phycore-imx8mp_defconfig
>>> +++ b/configs/phycore-imx8mp_defconfig
>>> @@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
>>>    CONFIG_SPL_GPIO=y
>>>    CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>>    CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>> +CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
>>>    CONFIG_PHYTEC_SOM_DETECTION=y
>>>    CONFIG_SF_DEFAULT_SPEED=80000000
>>>    CONFIG_ENV_SIZE=0x10000
>>>
>>
> 

