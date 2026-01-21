Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D10BC44503
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3015A8341A;
	Wed, 21 Jan 2026 11:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZyFMfPQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB69839D5; Wed, 21 Jan 2026 11:53:45 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B218382A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWgLHjZXs/sQ6sRDPgB4vcChs/Rv+DvJ6E1LBwa77IoPQm0hZJFXwRASzMy9iBSw4zXNE6ZW/ZJcHArEGcook9ZosEe6zXWTndj39BmOLqaIgLLbAzx3QInO+GQDMDVVFetpRDrwU2Nl+7g8BtB/6wvz7AN40rbQ8H7MmmDFhxK3FhWeYr66anqMHr+nElj9bNXvYQM/Pw89OIfogwpXhSCnakAZ+MMOqGi40JkSKepqapkF9uTVXkGotNUiU3aGswVUmxAZNNJPoCCAa3Izm/odgZqCMpxhfD3XZpIDmHn8Hl3ERN1VDwUaiYMtWlLSJqNSlEyP+1wsy0LSWhza0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/WMzsZfy0js2iw2GvoIcu1bAV4LszveWypvFk8zf/4=;
 b=hYYNhlBNQ9HNlrtg15yAQKspKijBsm3I0RhvntWJ7JAcNSp6n0DoAYpqxgV4+3jCQp5l7++wcL2whAmdj12Am/Ny0gtk9U5BvOiO2BwIK1oXl34WUYVxfm8AxBuYzps9vfeXvrQUEur1CZ3RvPy5GZJFz3ZUD2SHXn5j1G55GUUAFcczLNQDTVBbW4HX6Pl6oqX7J9MOAY2gYnUmoz2qOse5ElaJ6OOosH8+abc7mkTt1QlwcVlAAEPsOOMKHNX+FZAE6a46rMWOCQWMGRX47k1jWZUk8PHRSDE09PdohcHU4PrCOR0KXY4mFbTmrgpJKD4qKJX5iVTau9IAZxVEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/WMzsZfy0js2iw2GvoIcu1bAV4LszveWypvFk8zf/4=;
 b=ZyFMfPQFl66AF81aHYV83gi/VV55sy8RVfWewXocm8RdBCFG9Fn74KUn9OMI/4OmjF1sMW/KQsM8fYBaW1h4pZDe6khTanBe489e1CEPgjhUrI30trxJneDExkhG6MOdof7VYwKlsmyhDMN52U3d5+DhxN23hm5ZTeToaGvrrFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:53:41 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:53:41 +0000
Message-ID: <b19e16e9-89d7-48b1-af99-85e405892cb9@cherry.de>
Date: Wed, 21 Jan 2026 11:53:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc: develop: process: Explain when/how Custodians
 may edit patches
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260120201327.451872-1-trini@konsulko.com>
 <20260120201327.451872-4-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120201327.451872-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f75f2d-6c6e-4f15-11cb-08de58db5708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU5NNGs3RUNsYkhlK1F5bHZHY01obFBLUER4R2NVVlFqdGJkcTJNbEQzTGV4?=
 =?utf-8?B?bnlQNmNNZW1kQXVaTDZMTlNXbWZFL0ZZNnJEVmtkYloyTDhvcnBMZFZFNVJi?=
 =?utf-8?B?TC95eTcydG5aZUVDS1JYZ1JrOHQvc2xvTnFKZzBNZGVQdEFvaDh4TFBwb2l6?=
 =?utf-8?B?OVBSUkRaak1ra2MyclQyTFM1TitmYzFCdURIS2lYV0ZrMlZwSldGSWY4VUJj?=
 =?utf-8?B?KzlPNm1kdHNKZmluTUNoRzRycnFIRzYySjBESy95Qm1lQkdPSElMNXpsaWFT?=
 =?utf-8?B?NXB4YXZHc1MyMXRQbjNSa1FVRkNlSVM1L2RDVjAxc2M1VnNMZWJoWWlZSkV1?=
 =?utf-8?B?cnVmT2llVUFqem9lOFUzZTcwZk5tR3hyMnB2d3FqNDNaZ1NMcUxNSkJmMmNo?=
 =?utf-8?B?VnBrNWhCYkw4WWl4cTJsWm01Zk5yWitBeVFDVkJFcWZ3ZjRYMEM2b1dzeFRT?=
 =?utf-8?B?bWxVakpsZUtiU1ZkNXlzWjB4MG9RamxiNFNzT0c3NzhmSDE5ODVPaTg3U1F5?=
 =?utf-8?B?UWxacXN5aWlRWE84Q0VEcm1tVHpVNm1NS0dGQjN1QjNlTjVoS0NqcWszSDRp?=
 =?utf-8?B?UkhzdHRBODluVEl2OHUwRzJadVdvTHFTa0dram01ME1IMWRpU1c3SUdVejR3?=
 =?utf-8?B?RzVRYnROSVdYbTRiVnF2d0JBbmgvMEEwNTZEd0srdnJRbFE2NEN2Skppc2dT?=
 =?utf-8?B?a3FSMGQyZzY0WndDNis5ajhZRmpJN1RTdVhJOWQ5NTN5d2htK2JIc1dpM3d6?=
 =?utf-8?B?R2VTNDhLQTJSWXdFYVV5c0FYQWFaS0NQQmdINnN0emwybWdrbHJEYTlxeDM1?=
 =?utf-8?B?RzRzdFUxaGxzc2M0UVIzeldZcEFYa0NhNnRXVFhEK2ZjMHFKU2lidk5GYnky?=
 =?utf-8?B?OGdUTTJrcUFvWmZweHFCRVBXa29UYU5TS2IyNXZnNlBqaGlRWFZnaUYrNGZ2?=
 =?utf-8?B?bVBHekRPTlJManhBMjdzdXIxME4yQVJhbmJzRUFWa1pCdHUxT1pQMFpkTDdB?=
 =?utf-8?B?SFYzTS9HdnJORkNoZ0RSU2JZdmdya1RJN21wZkkzMVRYaFdpNXRlcG0wRHhR?=
 =?utf-8?B?bngvREt1ZnhpcTlkZmZRZWs0MHVMb2l6NnRSZ3JmcHBIYysvTXVsM3EwNWF0?=
 =?utf-8?B?dzZQb3BNZzNKcXYxNk43QVJXTDJUVUxOaFVjanEzMjA1S1JSMlMvSDNZNm9H?=
 =?utf-8?B?a3B6dk9uM0FqenRnRGw0S0J1TUpCaytCZmhYdFdyNUpnSnhQdDYzbFlRY1hY?=
 =?utf-8?B?QjJSeTZVNzZFbldhajBqVWZMV01icjN2TE1IWjRNWlhwTWNndnlMcGN4RzBs?=
 =?utf-8?B?akl6T2VMQXpqeTZ1eVZ1aVpUTTg3Vi9ad1lodzdhTk5UbmtwekNVM0xGcDRp?=
 =?utf-8?B?TElZdFIrcUczbWpaZWR6Z3RIWnhEMjJnS3JBV2JOc3NROUg2RldreG5IVWoz?=
 =?utf-8?B?NHl5K2VjYXFpdFdUWTJVR2xBNUVrM0pEL29VOWkwTmVlMU01TW5RMUc5Yk9a?=
 =?utf-8?B?NFI5ZG5xcjl5NWZVNHA5K3FOTlo1bEZlZmt5ZnBZZlhWYkVqUm9TT0pvM1ky?=
 =?utf-8?B?bzQzUDhzM2hsTU9jNitOL0JHMUk5T1B5ZTNIRE9kZW5BM0xWb2VsNVZYeU5i?=
 =?utf-8?B?L1V5a3BUOGYxdi92U2ZYaFBLblA0Z1dnWFN6SjlmZFRtT291K3NSMVZ4Qy8z?=
 =?utf-8?B?Z2tLMmg1QXNTSW1kdExHNHd0Z0dnWk5LWm93dW5YbE1SQVNuRTQzNndadUQ3?=
 =?utf-8?B?K0J4d2hvWU9xcEYwcFZCTUJaWWVlYklXdEdXYS8xd0FyMDlFY1FZQ016SkNI?=
 =?utf-8?B?R01jWFhEcC96OWZnVnRmU1ZzNG1ISVI4ci9yaDJvUWZZN0FKYW00NVU0ekhN?=
 =?utf-8?B?MXROODVibnlXMzJmNG1sdjI4QlpzdTd4QnVvc0FQL0FCVUdkUTJNelg2ZC83?=
 =?utf-8?B?U3NvUnlWZUx0VnJVNFlmYzhxTUU2S1laMkIwR3lpQnJ0K1pINmxnODJEMnRI?=
 =?utf-8?B?dWZUaWJqL2pqV3VCMC9MaFdubUREYTJmOW5oQ2VBclBDMmJvNzQ5TmVDZllm?=
 =?utf-8?B?YVdaZEYyaEtKYzUwTUZqVjFram5XSzQ0SmhSTFFROHhQTmo3R1hmczUvcm15?=
 =?utf-8?Q?55AU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlpS0FVVmtUMWZHTHN3eWt2U3U2emxPeTNxbEcyL29aT2U2UHhxTjJ2RGRy?=
 =?utf-8?B?bGpoNEh5UjRhY3R5dFp4YWw2ZTFqaFc5UGovUkdybVJOZEJxV3ZBU1ZaT2Ew?=
 =?utf-8?B?YkVmWElvVzlUNzVGY0p3Q0FLMjFQdzM1UG0wb2lKUnM5dm9ralZKQ1VkSzJY?=
 =?utf-8?B?L3JybENzbHBJWFdSaDJhaVlISi9hdjJiODE5dDhUV1N4UTJOaDh0Mjk3bCtv?=
 =?utf-8?B?STVQSmltOUdYWUV6MktKVnhISUxyREwzNE91c1lTWXdGaTl2d2JYVEhzN3k0?=
 =?utf-8?B?MFhObUFIYXBYUm5SRFBibDdoeFZoTFVMVlhkL1l5bElKTW5vUzcyVDArMHg3?=
 =?utf-8?B?MlhkN09Gem5UNEFhYlVyQ0JTQSt4ZEFhNm55MnMyQUN4MGszMWlIeTFNUzE1?=
 =?utf-8?B?SWpheVQ5MEE3aWE0cElvY25qd0pJZWNFUTRiOG1JQXZEbzZRNVpCSldBdyta?=
 =?utf-8?B?TFRVMHdVRGRtSElMQklHRk1DVTRNQ3pBZnhZbTlobU1qZEt0a3JIc1ByT2lC?=
 =?utf-8?B?bTlUakhqQlRuSk53eFhQMjFtUC9QcmlEVlZvbUZxSW1mTytTZW13SUdScGFy?=
 =?utf-8?B?QTFic3lrT1U4RmVHdld0VHZHbGZyUDFJWVlkV0g1Z0xPS2E3QnhiNTZWOTNZ?=
 =?utf-8?B?Z3RteHVEMy85dEFsUWZDc1FpS3FrSjVIdEFpcmdzRjFuVEFMZEhIYjZiYUZX?=
 =?utf-8?B?Z2JQSGZ1L3NCWkVKZDhPLy94SmVhU1h3dDZweHV1MUNKRDRKc2d3TFd3a0da?=
 =?utf-8?B?a2ZtbjVpVFF6cjhaTGx4UVFRVXVTWHAxUGFWZ0lsTGpUd0R3NEJZQjdnczdx?=
 =?utf-8?B?SnZ3dy9kQjhUVkJDMWtqQXpqeVJDU0ZMb3M1MUtYVXNiakpHTXJTbENQa3lj?=
 =?utf-8?B?QlhSUlI1Yng2VDlxWE52RUJPUnVLVVpsekVHRUloYnl6Q1dFaFMvT3ZUa3JC?=
 =?utf-8?B?U3hCNUl4UXU2NStLbmpPZC90cEU5L2c3NEZjQUFNcW5keUtpSnZoVEdaZmZp?=
 =?utf-8?B?NXZTQ0tVdnBVZHd1ajNHbE8vZDdHNW82bTdyN0lueWhEbEhLdlZGTjNNTWN6?=
 =?utf-8?B?U1BVbDdvaGY3OEp0eWhXTWJSZjBJT1MvOTJ0OEpSS1h4MmpCT0lKd3VwYXZV?=
 =?utf-8?B?YlJ1YmFaajNaK3hzYmMzZTZBUE9yNGtpVDdUcHBjdHpQT1IrUmt0MzQxbndT?=
 =?utf-8?B?b3Y2QzlFWVZ0T0Rja2FLS0MweENXN0NvTisxaG1IcCtCaTVRYUdlZ2lpWW9H?=
 =?utf-8?B?V0RBdWtQSFdyWVpzVlYxZGM5aDF6aXFBK2pYZHZtZ3EyYjdjSTRaOWhmejdi?=
 =?utf-8?B?emRoclBDSzFLeHJ3S215YWY2UzlZbUFWTDczMFhKd0xkb3dsb0twQjhNdHRH?=
 =?utf-8?B?N0M5T2ZsN3JYd3RjdU5valVMQXVYUUlYYkx0YmN0K3pKRmFyeGlOekJxYjI1?=
 =?utf-8?B?ZEEvTS96Q1lWNEM1NkdwdVlRSjFTbWVYSFNYeGtxaE1QaEdFbENUOXFnN051?=
 =?utf-8?B?U1BQcFhQVFZ1TlNsK0tnamtpdkhPQmJUSTl1ak5KT1RPTkhINzd2RE9iT1pP?=
 =?utf-8?B?M24yVU9abURYT0RYNWZNU21STGZMWmRVZkRVRjlaTUhBSG51TGlBbnNkNjk4?=
 =?utf-8?B?eml4aEFXckxQSmxhaE1FZzhEWkdoR2RYSU56cDJ0bjdlb2tOcFp4RS9kZWFP?=
 =?utf-8?B?NzRoZUtFNi80ODY3bGM2NFY3RjBlR2I1UDk0OENEanJ2OW5CQk43SVBLcFBD?=
 =?utf-8?B?Q1pwUGtLMUo1LzMxV2ozMmltQmxlUldLMVNoY0lDUzlsQTBXVENZZlF6UUE5?=
 =?utf-8?B?YStrN3Y3U0d5V1o5elIxeW4zdWMzVzdIVitlNnF1VGdFQ2hkZlI3aG9nQjVE?=
 =?utf-8?B?THBqWi9pcGo5WTZxVW9maVl2eHNJeVVGTnpmTHdCUGlwa3FsUCtPdmNMTkRr?=
 =?utf-8?B?dFViM1JuRFpheFFZcVhZdnR0dTJZYkRkQlhVTmJreFhQQ0pGNEdjeXhidVIr?=
 =?utf-8?B?UkJMNmFVNzd1emdEL2pLei9NdlFmOXBvb3BjS25zMmFQa2dQYzl6U2MrTXRi?=
 =?utf-8?B?a3h3UFFnSVN0ZmVUTllOQlAvMlRBVVRNb2dNVG1NbWQya3d3TENyN0Y0NkJC?=
 =?utf-8?B?K3NERUZqSm1MaHRRQmhYZEFTcTRxaGI2YW1URnBiamZHVGR0VmdiWDQ3UFZC?=
 =?utf-8?B?dmk2UWdDUEovZGZXRlE4SUxnNWxCTlArZUN5NUVxekM0UTVBV1oweENZYnU4?=
 =?utf-8?B?LzIrRHhBRVVxOU9Rc2pUNi9oNkFnOUdyWVIrRHhQQ3ZGSk1KR3duYVNIOWFS?=
 =?utf-8?B?ZWpuOGtmcnhydS80UUFDVmNrME02VlhCUUEwNUVaVUk1eSs2QUVQT2VhSTE1?=
 =?utf-8?Q?CVVbkwQX6IkzRv6rNRoag6F7T07TQoKZlZHB+?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f75f2d-6c6e-4f15-11cb-08de58db5708
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:53:41.6154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XadpQ3lN95bvxZlQC/y98hfpayYq6eMY21ZSSIb8WSktNWuoaHCqZwGX6itlYW8JeyYU3Li7Oh6uDnfItkh9aWej5vhoX/CUQ+l3ZAj/JXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
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

Hi Tom,

On 1/20/26 9:11 PM, Tom Rini wrote:
> As seen with commit d503633a3676 ("Revert "doc: board: starfive: update
> jh7110 common description""), it has not always been clear what is and
> isn't allowed by custodians, and what the expectations are. To prevent
> further unintentional conflicts, document the limited cases where
> custodians are allowed to modify patches directly, and how to do that.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
