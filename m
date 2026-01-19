Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24601CCF2D2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605EC83966;
	Mon, 19 Jan 2026 10:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HQs4y0rk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HQs4y0rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3508397A; Mon, 19 Jan 2026 10:29:50 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8440D80B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QwqMON19ZK2oPFPZtsi8NJaLAUcTmJRFU9pk8P/PqpYnVGSg3cKAPlDpojntLyz/TfUjogEZ4HjdauyxhTvr+uy9TdFOsFRA7CQwwjAfaxetLiQq3s1KxEiwyDYXP5KRO/EjlPctQz/NXEgPVBLqmL61dk1R6+IGMiPoTSfYw8+CsoxjVUYb4PXT5DMMobcyl843q8DwJBI8tI2HDhC2PJ5lLnVwGPzDRawsBQvGTlMOdyn5tlwOIBH6P7zYFPoTHIWdz+Me4/yxgk2+l7DBJv5EeuPqO5cDtVPqMZbfnUI7srzLvhgclQk195bEf9ncsw/VTFw/EKZtagZt35hicw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQbASbhYhRkjHWqDv771kWN1CH8eXlrsGyD9i58wLa4=;
 b=m7Qw6oM2zWtoElFf20vz15fA7pIve8Y7MBpCEy/sQalyMBr0MVsvvH1trhYRDGiHCuK5Ij1i67NteQ3B6wx7a/3VxlmXEjJF2zvooLLEk0djF8jc/1/35k1CZp7OMH+u1fkuMbOHMtPUKBpkyNBXRlmIeQMeupwZ2bXzEUZg1knHKEWw9TG5UOE+uA8HHBUS0HN/qVK0tx0CE0yFHc4ouTcrFgGqgBpyuFC9FeRzxnww9EorgwGrMWbRSV7EcfBXlV5QTEaC+Q2Ftfr80cM0ulaioORUxVl5nGk6tLr1nao37oRvR3sRvmmGJiEx8/wAjU+4swaqwYzP1DwDVR8ADw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=bestguesspass action=none header.from=arm.com; dkim=pass (signature was
 verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQbASbhYhRkjHWqDv771kWN1CH8eXlrsGyD9i58wLa4=;
 b=HQs4y0rkgOP1+OD21g6vScUL0yib9nFDw5O0Q7KxL7MaoDYTIYyKCMOZBAXSccIduiSPUg/Nay25LXTfjxj5nZ6N27bqJoMT/ACPIHTHSiQxM7r73W8hIaNuNj2eIkNlmkCwcBc+WMwM91JAiYYeu4v5u7srFAiwHrVLllCsVI0=
Received: from AS4P195CA0044.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::7)
 by DU0PR08MB9227.eurprd08.prod.outlook.com (2603:10a6:10:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 09:29:28 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::b5) by AS4P195CA0044.outlook.office365.com
 (2603:10a6:20b:65a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=bestguesspass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6QM8OR0nODH0P+GVeg/F6PplkxEqg9mRAgBBLDf4bjUSB+ttdA9a2W4AwQjvWAtIG0cf3libFGWY+wa3hXg4C470cmM0MtNnAZyl6UwKX3s3LimLJJJkV8klWrAz0oFMm65OA6XxfZiLxhJPuHTxOEJVmPLrSpZnvQaW5bT4YybYObidNfPkgLK0VYF2lJkcZ6pzn2xIXvrUtHciSkxaV2ThfbNY0pHny+HugbTkxuzZTsNm0BR0Oqjh75hk/kwwtdA8KSa4cRv31N9P4GczL1JdmSqvTAjiZe9aY4PgJGyVQl29NQV/CZE6pfCjRfwTAlh68vQZhHTdq+g+dZ6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQbASbhYhRkjHWqDv771kWN1CH8eXlrsGyD9i58wLa4=;
 b=OeW5scL5jmjNqHwBya2QBFEmOu60EpNJ+ogvw5w8FKa2q+2PSWgNuJbiwalJGBwoGhFoc37Fa803AxY7o7b0YZo4jrkYRWmuIPhRjoa7IlfirJrtq7OeApBbv4gIL+ts+22H6+TU9/XjHQebkthmOojieUNj0RUU1TItBuP0/kZC1ax0QrZAeNZ7R+NDqmzTNvIou8rOy/X88YhNJ14Ro6TUfoxZqhDbCxVS2nP+V5AVkRCJsXtt55LFFvFSGPn7VFvW4u+59LDjgsFE4k2Hq14q69WpKkVB1aWrDx4xAQrSN5lJgEJx/s8zZnX78+aisjtERY9IgMvZ6h3KkmRDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQbASbhYhRkjHWqDv771kWN1CH8eXlrsGyD9i58wLa4=;
 b=HQs4y0rkgOP1+OD21g6vScUL0yib9nFDw5O0Q7KxL7MaoDYTIYyKCMOZBAXSccIduiSPUg/Nay25LXTfjxj5nZ6N27bqJoMT/ACPIHTHSiQxM7r73W8hIaNuNj2eIkNlmkCwcBc+WMwM91JAiYYeu4v5u7srFAiwHrVLllCsVI0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA4PR08MB6302.eurprd08.prod.outlook.com
 (2603:10a6:102:ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:13:19 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:13:19 +0000
Message-ID: <7f5e37db-f0ef-4d5b-95b7-c62be5b1ccb9@arm.com>
Date: Mon, 19 Jan 2026 10:12:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: lwip: dns: Fix print of resolved IP address
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
 <20260117002452.1026310-2-jonas@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260117002452.1026310-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA4PR08MB6302:EE_|AMS0EPF000001B7:EE_|DU0PR08MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 674ca04d-41f7-42db-e5d5-08de573d3dae
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Z2ZGaTNRdmVJMk9UcHptQ3dPZmd0eXUwZ2FBc2ptcDlqQ0RxTDhSQlJIMTB4?=
 =?utf-8?B?dW8yWnYvcDV6bG5tYXZycHFySnZCVTZPZERMNTVsd2orNzdDYWswMEZtUWR6?=
 =?utf-8?B?WUNHTy9UcEVKNHRlSmw4alVENjZsSWJJR1piWnlJSzJiejRrMEszL3dYUDhR?=
 =?utf-8?B?dVdrWS9WbjJ2MTNBYkVibnJTT1RIZ29wQWFEbkU4N2V6Qml4bXlLVFpsUE5q?=
 =?utf-8?B?WkFLNS85N0d1TUR0WDlBVDYzNFlEZHJrVWN2SENtWXVQOHdvcmxvakJFQ2lI?=
 =?utf-8?B?WjNxYWxuSGtNR2hjNHoyc2t3ZDRoVU9zNmhuSHptdUNCdlRpdVkza1BBcCtT?=
 =?utf-8?B?MURObEZ1NllmMFVnMFdkKzVEMi9iUE9VajI0MkxRdVN6OWJPcU1XTXQ0OHhE?=
 =?utf-8?B?MXhOamRnNk9GNFFNb0NQcXVwYjAwTFIreHRHNU01d21WbGNpQzdqWHVQWHdi?=
 =?utf-8?B?ejR4R01aZHM4N0JGSmFUQndkWGQwQ1c2d0RNQytWMjQ2cTZwK0g1aitBWG0r?=
 =?utf-8?B?c2N5M25qbVNlMjRnVk1ycS9rSHlXN0d0Myt1SXJqSHJLZDVHYURsTmp0WXMw?=
 =?utf-8?B?ckpPWmgzbWR0SzhPY1NTNHZTWG1wZUo5a1M4bkxDeXlXQ2dxZ0lzRnIyMzJ5?=
 =?utf-8?B?WVBCVTZZazdmMDRYV1pPMDFIMTNXK1g1bkRHWkorOFVRNlVXZFlnOGluT0xG?=
 =?utf-8?B?ZGh1OFpNSlBPazBuaWZmeFRyM1FtU2NlRytaVkVLbWIxbXRwU0NEMkgybjE2?=
 =?utf-8?B?ZENXVWVGTE9NSTc5TU1sRTF0MFJtTDJvWDFudlZlTVcrVmthbXBEaVZuemtN?=
 =?utf-8?B?Qzd3MEQ5WTl3TGI4Q1pzM2Vlb1djcWJFQXpna1RRZDhXWmRyRFdwb2tQVFQ2?=
 =?utf-8?B?dFJVUC9pVmMxUlJxRDE5ZGdsTzcvUVFiVVRBZ25CUUVCRmozRTR1RmpDVit6?=
 =?utf-8?B?QUxqdDdQSC91UUErRlNjMUo4MExtYTRjMmlRb0doek1MTjhzcmdoYlUxc0g2?=
 =?utf-8?B?TlNya1RaNVRHZmZVYzdIamt4ZXlUSWt5bVEyUXoyc3FsRXdjQkxaTWZJL0tW?=
 =?utf-8?B?azEreXA4QVZTY05wck9uajdjMDZ5S0ZNQUFDOTdrUG9ZTFQrVFVZSTdoT0RQ?=
 =?utf-8?B?RE9zdC9YWjFvZDJJc2ttUXFqQm1WWFVqaS9vRlNWQStjVHU2b0dEZk5abHBw?=
 =?utf-8?B?S3R5M1JYNGFIa1RBTkRRYXArbDNwclRtYmZ5M3VZdnBUNWh3YkZvbnIrSkht?=
 =?utf-8?B?OStKWFNkRWlkR2dqcUc4UkprWElyTFFFZGV3ODBpUFB2L1JhYkV3YzdFazFa?=
 =?utf-8?B?V2Z5c2ZFRjd6U3pNMFFzZGM5MlNVa3pCeHRpUitVWHF5QzdxaWJSck1xU2dF?=
 =?utf-8?B?REVEYWZqRTNHSm1VVWJhV1FoK2YvVFdoMGFFZ1RJTXl2YkxtUkZIcWtFcGlm?=
 =?utf-8?B?VVJpeXpyekdTWlcyVExwQ0FqTVZHbHpYemluQndMaHRjRG5LdlZvZWp1SG5G?=
 =?utf-8?B?MDZaZitwc2I3M2tVSStXNDdGNDkxbXNoVGkwNTRvRkYwUmlKbEU3amxpT3lN?=
 =?utf-8?B?Qkh4aDcySHYyUEVscm1LOE1rT0o2MWRyL3RiWjZzd3c4ektEMHpWMEJCcHZF?=
 =?utf-8?B?WTRIOFA2c0VCRXlobFEycVF1Q1Q4Y2NBd09EamZGdDBSak84cDRRU1VSbDli?=
 =?utf-8?B?eFUrVnllNXd0MUdRMmZYNUEzeWlrSFBFdDI4UUwvR0s5bzB3SFp5LzdqZmVt?=
 =?utf-8?B?bytSRDhURzdHY1hMbVlSbndCbnBOeWxza0MwRVpDSXhPVXFMdi82bmNRd3Q2?=
 =?utf-8?B?cGR5TEhITklubFRhcHBFOWprbkZmRDNnUkJna09sYXpOZ1lmU05EZ2hVVFdq?=
 =?utf-8?B?VEJPRzJKK3N3bmxxemdJZTkzNldFNEMvamlxN0t2OCtweG9MN1Z4ckt4anFs?=
 =?utf-8?B?dDlabHZxVXplcmp2RWEzcWhPSzFsOE9lOXp1L2huTU1wNE1xMG81NGRVMGty?=
 =?utf-8?B?dXZndHcwYU90anBPUlArSVV2VldQN25sMUdiRWdQTXlNQ0JXSy9rMDVtVVpm?=
 =?utf-8?B?VmlVRHROUVIwVnRLck5sMFJla3RrYko1bVBlT3AzcVh4aW1IRFhEdVFvemh1?=
 =?utf-8?Q?a7cM=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fd358afc-7026-4ec6-47d6-08de573afcb5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|35042699022|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXVUcTk0NE1IUXlPbkhqZHV2TzU4RWFzZFNFOWxXQ1pwWUdIVy92WW4zWVhm?=
 =?utf-8?B?NkdqQTRJQVdHVExxSkdIYnBnWmRaemRtUHpNL0Evb2VndEs4Y0hLZTc3ZmNE?=
 =?utf-8?B?MjdJMS9hWmQzUUpMbXY1aVJjMnFPdERySzVMYUZBZHBZSjdFVGxlY0xmSHR2?=
 =?utf-8?B?bFc5czZvYmRXSnoyVTlQVzlucmQ5Y1dGZ093bjNDd1MyM0lRNU1ienFrZDEw?=
 =?utf-8?B?UmIzU2xLdGZSOHpjbi9SWW0rL1R5ckw1RUR4KzBjcnFybWExanp0NlMvNmls?=
 =?utf-8?B?bGxtSTlWaS9HZkU3bHVhMnlCTncyNENNK3htSnR4SFFoSllWUzJwbUpPVkk4?=
 =?utf-8?B?aHhRUEtYTUUrbkhJZHRqNlRlQ0ZKV0pQaDFyZlF6Q3UvejN2YkFzZjJMTUR5?=
 =?utf-8?B?Ty8xdkYxWUpXN3RRRnJyci9IaTJENlQwVm1aOW5QM2p3eUNZRmt3a05xY2lX?=
 =?utf-8?B?MlBWWFZ6aUs2YlRZNEM3dGFhRTQvYmt3SzZvUytpNkNtOW5xUVRpY0oxTG9J?=
 =?utf-8?B?R2h6clJNUVlTa3pmZGdFUGhPa2Y3Q0lNRzJQVFVlVmZkWlEyaFdZMVRDek5h?=
 =?utf-8?B?ckFlUk50YlBvN3JoOTNCWnJ5VjVZL3M2WDRROWRBSUZNZFVaOFBCUHV1YXRR?=
 =?utf-8?B?MTkvK2VockFCaElNUXJiRnRSZU9udmZ4TWsvZXpsUDM0MXNzMk9mQmllaHYw?=
 =?utf-8?B?ekFFTkVNdXJoYkZtWTIzREpZZkN1Mkc2NFN0b25aVTE3QWFpRmVmWGZqYUlG?=
 =?utf-8?B?NVptbVVDdlRGQmtOYU1BTkJSbWh1Z1NIdkdKQjNkZkJnTEwzOGNKOStNMkJS?=
 =?utf-8?B?RzJ2a1RyaW9pYXVNVDFJWlpKeHQwSkdWelA1K2VmNTh4RHNTRllpRnJtQlRM?=
 =?utf-8?B?Y08va1JaRlJ0WEszSXVEZ1JqU2xmbzZqeDVhWnVwYlVhcHZIU2R4OXBBRUlL?=
 =?utf-8?B?NFhLMkMrWnpBK1Q0NmR0SzhFZUNCbUhUWEJiL0xUOHNqdlFBQVpENTA2UmxR?=
 =?utf-8?B?WW1Zcy9uN0ExdVRiQzFYVkpzS2tRTW53SHpub3lhUWpsYzV6T1ZkNi92dlQ1?=
 =?utf-8?B?YS9WWFRMbTZ6S1l3eEl3dWhKbEJCSWZMTDZDMVY1QzZNMXErcEM1ekQ4aGpC?=
 =?utf-8?B?Y0JyZnBGd1NscnlWMUM2eUx6bUJiNTJPS3FJQTRaLzNGZnJDaEM4MzEvajBn?=
 =?utf-8?B?S3J2eGdOanNnUmN6Tm42R0Z5VmlhVG5aTzVMNG5JOE1hRkNscTcwMFVXQkJF?=
 =?utf-8?B?RTEwdm5xZTVjWnBIcEdkVEhKYmJWOXFjajZTTkR6cjFIZGlHQ1ppc1I0UGp6?=
 =?utf-8?B?K3J2Mno2dXErMEgxZFowS2ZKQ1c0UVUwYWxLS2pyb0d6VUx6N0lmWC91aGV2?=
 =?utf-8?B?M2JpK1dxMlM5NTNCQ0k2TEhyMFQ5RmtsNmNNa3U0YjNlYzdaWWN5RDdTbWJK?=
 =?utf-8?B?UnJrSEVTU3ZUTjNIUE1nYnJzWGc3a29YTFVyTWtpUVhFSzVqS0kwTWFzZ2l0?=
 =?utf-8?B?VWtFRGdobEhtMUVrQ0dpT2dwS1h3ZUE4MlhqTFBkS2RkVFNDY1JZbWFZYml2?=
 =?utf-8?B?Vlh6MXpSb012UEppM2ZLVDA4emtKTXBqZ3YyVitheWlzMWpQQjlBU1luSkp4?=
 =?utf-8?B?NVV1YTdVdlhidHhORUppYUlKcUwvbTdaaGJuV291Zk9NMkRMeGd2ZDFFa2pX?=
 =?utf-8?B?VmdCWGlwb2ZpSXFjbzFUandGVTNiNkswN0Z1K25nZTIyYWFrMUJvU0FpSUs2?=
 =?utf-8?B?cXRnOGxyVWVna2d3L0p3d0pxYkI1WE5Hc09pUnMxeGhkTXBTdENlMjRhVVpS?=
 =?utf-8?B?MzNxeVdQdmtDQmhPUFdaUG5sVHNCMCt0RlpGNTFaVnMxSVJUNFpyV1p2dTM1?=
 =?utf-8?B?ejdDNHJnZUFQTUVmQlc0c21VMmtaWHRoeXo4R0NYajNhOWlOc1NjYytEQlFO?=
 =?utf-8?B?bjlyRittc2ZCMkN2cHBOSkZKQkJkamJFQ2NSWkVjUjlNWU53RGk5VGEvN0tQ?=
 =?utf-8?B?NFRrVDNFOHJvYklNWENLK05NYzlOVkZMTHhGc2JMUWJwZzduZWRjWVIyQ1ky?=
 =?utf-8?B?N05Vb1JpVE9nbXVKYklsSVdxVjN0eEhpeElEMzhRVVBSaTYyaVZLM1VyY3FI?=
 =?utf-8?B?YXdKMm0yVjZTdnFoVGlWRkpnaWpHU1cwek53Si9UYWNjdVcyV1p6OVVMdnFv?=
 =?utf-8?Q?LAs3LVarGpLJGqz5YYC0WDdLdnHett1ZOVh9c4FEqipn?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(14060799003)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:29:27.1735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674ca04d-41f7-42db-e5d5-08de573d3dae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9227
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

On 17/01/2026 01:24, Jonas Karlman wrote:
> The lwIP dns command only prints out cached resolved IP addresses.
> 
> When a hostname is first resolved and ERR_INPROGRESS is returned the
> dns command prints out 0.0.0.0 instead of the resolved IP address.
> 
> Fix this by printing out host_ipaddr instead of the temporary ipaddr
> that only is valid when ERR_OK is returned.
> 
> Fixes: 1361d9f4f00a ("lwip: dns: do not print IP address when a variable is specified")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  net/lwip/dns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 9964003195f8..2b2a5947a2b8 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -86,7 +86,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  
>  	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
>  		if (!var)
> -			printf("%s\n", ipaddr_ntoa(&ipaddr));
> +			printf("%s\n", ipaddr_ntoa(&dns_cb_arg.host_ipaddr));
>  		return CMD_RET_SUCCESS;
>  	}

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
