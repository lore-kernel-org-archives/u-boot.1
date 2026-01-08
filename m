Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB91D148BF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 07:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB9183BE1;
	Thu,  8 Jan 2026 08:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="K2f1va2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E548405C; Thu,  8 Jan 2026 08:55:54 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9990839DE
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 08:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.melin@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3i4WwKrU5zPSzw6WcLisMxKESltG4SlU/LLhbEpchIYwIGhqGdeyizQl/rf3SaWVn5IO9cftrFCHckb7czaN2Z7j4104Vp9jQT6W0ynABnuGw7Wlwjiellx+5e/XMKj81GR5t1zD8GEWlGnneWV9sjCxyGGZXt+gx9GAMs+BdLA1f5QHeEhIWTOpVc52GNPFsBL3oHkYTvNG8+0mHcmURan/td+MIILD/mK8Err0fWTyNGwuG7ji4MHr2YwvYSuPC5pweuytSYJkhbHn4BWJ1nrlJXGhruo25qwMpI+FSIc0qxLri/NUFV9FJGESioPIQ6/rALM7e0iIgowoVoWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMpIsX4CVCDSq+vkbERudPxLeDxnCnDDazLgbTuBwyk=;
 b=nLp/LHvZG/g9SQXMg3XDrMhpYxxfVb8ZdXuoRnUaYjjMl2fL+pdE0rFAUY3hpu64MDRck+mLR9iXdB1JI7Vvoq7D2NeVDuxCLEGVSIKjdkbfh5Gxb/Z3v/IFS5ldHks7+s1VFJFG/z5fpWEXY7oIhEmwFcV4Gvw4ZcAX2NS9SqorunlKJ4Rl9DkRwNOMfsw7xGmWYVi9/NrLYJ6rDxIUQo4wYM8/Fu8uOzUTYu99ktMJOs+ZEB6woR0qguSVmMnqBaEOYpQWm6JSBH0IzjIgYBdBTIZTd6eTSFPKlEmkNX8hx9ea/gMsNtof6JRYmHGHmNJ4txCyJAwr4WkU8hkYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMpIsX4CVCDSq+vkbERudPxLeDxnCnDDazLgbTuBwyk=;
 b=K2f1va2ZYHzEA0KpUY7bnQoqgSCjzBJH5zNVC3Pfrps2Lux06AdiQLPfhwIGbEMXqA3X5zzY6F82LFP54C3jVuM1QWGcs6T/qyR53m+U8b6F4RTFaDIW2WKg/TSy46gh2VZAjGiT8bEAQk9UBKrS3hsDnBbGRsRcemCiVc5ExSXWCZdxdmYzDkpdkVuMG1mDTQP5uJHT+zP4or32kMeNZcS2Y1o177OnKoI3gV2pwkYdmGmc717lMx32XjDfgwFlmoIMrysGCghzxwxNbHiVlnPUGd3LQESjkmXO2o0F2cnEtyd0vkYcik9HW77u1b/fxlIMN9No522GOrsns9INYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV1PR06MB9194.eurprd06.prod.outlook.com (2603:10a6:150:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:55:47 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 07:55:47 +0000
Message-ID: <2683445d-4eeb-4b97-a3fe-32468c831bd6@vaisala.com>
Date: Thu, 8 Jan 2026 09:55:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] board: zynqmp: add cmd for getting boot auth state
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, igor.opaniuk@foundries.io
References: <20260108074601.491837-1-neal.frager@amd.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260108074601.491837-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0023.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::26) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV1PR06MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d41d88-968e-479f-ce8b-08de4e8b5564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjUzZzR5UDFyL0NOWW5YZ0FKVnJtV3VWbWRGeHlzbG1uL1djbVg4SDF3OFR4?=
 =?utf-8?B?d3AzaEVja0U2a3YzVGJacmU4NTVkdEJvYjVYVHlzWnZrRFJXMVpNSG5JRS91?=
 =?utf-8?B?SjZrZXhTRHlkenUyUzJRTUg2dlRUb2pINDFxMjNOUS92TXBhU1ZMcVZzTWUz?=
 =?utf-8?B?NTRXd2FOMUl0M3IxYnZFR2ZFR0lpU21PelVwOHZCaHJ5TU13ampZZFZZbXNk?=
 =?utf-8?B?dzU2SGdqNnlBRkptTG5MM3VkL2R0TEkxejlWYllJMUczdWpqZ0R2RDE4SnVj?=
 =?utf-8?B?Sy9reUZxUGllTFNNK1EvYTlnR2R4RU9LWkg5by9qUFdzMW1TQXM5dGo5Tkw1?=
 =?utf-8?B?L2VZOVpqREVMS1RvNGlWQTlIWWNZTjRLZDJQb3hiSnR1SElDN1pOa1JlTUow?=
 =?utf-8?B?SURkejBXaEI0OEsweS80SU1ORkJXcERrZjIxYkdBMDI2MGlscEl1LzRPL080?=
 =?utf-8?B?cTdZdUFVa01NamZuVSs5MVF5c09HTG9hOEYxd1ZrVHRRd2cxaVVtNHFpSHBw?=
 =?utf-8?B?V2hYMDZ3OXh1ZWxNZlNmTTB2b2tyNTRPU3FuNDFmTGZ0a2lpbGlGY2lSNHR3?=
 =?utf-8?B?UVU1aG91YUVKVlpTT01XVnJOYzZ6Ylg0TEJNUk5jOGhVSmx3NWtwbmd3bnJX?=
 =?utf-8?B?T1N5T0p2V0QvaDVLNDZGV2JpZXhnQUgxTjlBYWoxNmRlck5EUjZpTGpZT0hZ?=
 =?utf-8?B?Y2Q5ck1tOG5DbVVsZnhyRFBKZDFQRGM2bnJka0RFVjJtYUxjTFVuazlucFBB?=
 =?utf-8?B?aVhGaDQ3ZEE0akk4VGVnUDZVcVhJNjlQYURWK1k5Zy9ENXpwbVMzUFlBZTVy?=
 =?utf-8?B?cmg2TUtjdyszaklabGtGRWhzQVR6V3lBK1RwcDloSGxtaXNTanlOMmtIV0Rk?=
 =?utf-8?B?QkVEOXRMaEZaRHd1L1ZFVzdjTEQvTFpWc3hSOGw0d0I5TTNRUFExdFBpVkhP?=
 =?utf-8?B?N3RSTklKNWtrWDdtdm1rdDRHSTR3cDJUSm94SVZqRVB0RDUwZ3RxWmtTVnJm?=
 =?utf-8?B?eHcwYTFqZmJEQmxzQVdIWGhiSkxaWVA3azU0bHdjRERBcHRVb0YzNitTdFk3?=
 =?utf-8?B?VDhMRnQ3M1RxTkNWUmdxK1BMLytKWC9TZktFTERhNHB1SFNWczNybURZMGpn?=
 =?utf-8?B?dUZrQXJSRmFadWdtZ3hsaWljcERKRnVuY1lYOUhkWjVZVVJpeHo4N3Z4MllQ?=
 =?utf-8?B?SFpTTjhCRTZVdGQzakhMQTkxYWZJaDFVTEY1MFRRalQwK054OEVQbnFQZEZ6?=
 =?utf-8?B?bmgrbEVId0RyVm8rUVRMNzJaUW12eFJ0Zlc2Ukd1S2hSWlFzUVVab2U5ZUY5?=
 =?utf-8?B?ZnNHek5udTVjZzZVT3c3blVrSGgvNTZ6bVVKM04yZDN6OHY1Y3dDa3RVQWtH?=
 =?utf-8?B?UVk4UzVhekt4ZytseWxFSElMdmFQWkg2KzZnY01vNzg5c1pCTXVrNkpvTHYy?=
 =?utf-8?B?NnZFNzMxR3FvUnVyNTdFWmZNb05mWGdPVGZuWVc5dFpkTVFiMUJsNENzUjVr?=
 =?utf-8?B?Vk9qbzRTdU5rWFBZQUVkbGVLcTk0L3hjSkVTNm0vYXowRDBBT3VmNXdGNmYw?=
 =?utf-8?B?NmJXQWVzV0NCL0Z0bU1zdmhMMVMwdk1ZSFJjQW5XaUE3RFkvc05mQ1ZzVjRI?=
 =?utf-8?B?YnVLdXdwb0hrM2FOUWFkUmZxcFlicW9lS2pBQ2ZTK3BFcHJucEdyUXViUjJP?=
 =?utf-8?B?TDVmYzVidGdqUitRYlpvSXJIZnM1ekVuRnZrY0c2UkFITFlnY01xcjBZNWE4?=
 =?utf-8?B?Smw3MHNMd24ycHhqY00wQzRKOWxoSlJIaWlFekNYMVI5cFFYM2ZOSDNXemVB?=
 =?utf-8?B?aWZMZEZkdXhjTTdNVy9BQ1ptcG1VUEN6eTVIQkxLc1lpdmM0Z1o5UVZhT005?=
 =?utf-8?B?c1pwenh0ei9zUi9TYUhJbGRmczZhUll3THd0ZzFTNzg1V3hjdlhXeXRtOGYw?=
 =?utf-8?Q?VCo3q4i0rjmmZJh4hcmc405gqCfI8xt2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR06MB10365.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NXQTRaS1JwdkN2QWI4YlRuQk12Q3lKeGdkcFVzTDJpYkg3aVNzL0psMDdB?=
 =?utf-8?B?S0dESE1lSWhSZndObGppNzBGdlh0WVU5Q1ppdVZFc05icTNmMjF6ZEV5N3pG?=
 =?utf-8?B?Y0h3UVhDZGg3QkhGb1lkRDZFcVBvWnpIQzU5Z1RIdUo4dFNYQzFKTDFRbXN6?=
 =?utf-8?B?OXZSOW1hMnhIV3EyUmgvWDBzSnJBR214UFVxWkM3NUVPQmhqc1QweUU1aTdH?=
 =?utf-8?B?S2FBVWZnRDhIUi9oa21jQUZQaTl0cHZiWWIyUUhGV2hsWE5YK011dmRTOGNZ?=
 =?utf-8?B?bERLSmVvNHpkTHhSaFowUHJ3SThxWkpKK3VKaXZ5ajNpQ0gvdm92OVoyL1kv?=
 =?utf-8?B?Ky9vRS9xMDJRL21sNTZYQzd5VHJVTnF5a0VHMjEyYUNzcGZ0Mkl2ZnY0OTkw?=
 =?utf-8?B?cFZLYjlSeTF1ME54UmViQ3hpL0hlSXNkUk9KMS9Dakc0RlNLMlcxd3FRL1VC?=
 =?utf-8?B?NkxpdzUwWWRTWWRxMWpzMy96TEJ5UlNFaUYvTndJTTIvclRKb3hiUVhCSFdl?=
 =?utf-8?B?ME1aNm9aVlc2dzkzOTBEOE5rOGJaQmNidjM1ejYyc2FZQWNQU042RW9JalNS?=
 =?utf-8?B?Rk5mM0c4ZFd3eTRiZU8xTTFIMDlSSWt1bHVpNlJpVnUzRVNXb1h4dHNqVjI4?=
 =?utf-8?B?eml1S0l3MWlML1d5bDdPaitER1piYkFEckE3K0ZtTmg2a1JPbS9WMGhTandz?=
 =?utf-8?B?MDRjMFVjQjhFL1hockV5dHY0SWw0SjFkK1UrQTkvZmp0ekdQeGFmR1V6MDB3?=
 =?utf-8?B?TGRmYWZhUklFWmdydE5maFc2QkhNdTlNVlJVZDJmVzRxQkQrNUtlNGRub3BM?=
 =?utf-8?B?cFFFdTF5Sy9OdlFrVEhCN3VmMU9hOWQ0OGNsSDNOYTJ3MWlKRFRnNmhpZ0Jj?=
 =?utf-8?B?Y2lzd1gvcUtzYzNyMGd2TXBGU256WktwbHc2VVRLdWVQMWR1T1dMaURHZkwv?=
 =?utf-8?B?MEt1TmhpbzR3OE5ZTm9zdW5FU2pRZmxWNUhCRkhQUTV5LzIzcHczUDFHK3gv?=
 =?utf-8?B?NDdFcG1nWEVHZndaOEd5d3Q2bzRSR3dWNlFUTXMxKzRnZ1R3aVhLV1NWY2pB?=
 =?utf-8?B?YklrbVVSMGZNeWRHbjZkbTN0S1VpYnZ0dHVTS0RaUVhjOGZKaWxJMlVpRngz?=
 =?utf-8?B?K2RhSzI0VUtPM2Q5TXB3eHMyQnVkZFJDUzBJSTNlbldaRjd0QXVRbmFoNTVq?=
 =?utf-8?B?Tm91bjg2bEs2emYvMjhxMHV2dUNYT09CMFVJMDErWWh5SE5DNUkzQ0VZTXNo?=
 =?utf-8?B?Und4bmRjM203aTJEMGpMTHFyMzJZakpmYkx3dHNnd1JtclVKcTJ3SGF5cUdL?=
 =?utf-8?B?T0ZicU16ekc4YTdMQXk0R3RhQ0VLU2pxN1dBMDlPcUNrbUo0UUpFdEsvNFlH?=
 =?utf-8?B?WmNaazhhK0gvMDJwRERzVmNaeHI5RTJTTVlJaWN5bjVFTUUyWFVSaUxVUEdy?=
 =?utf-8?B?aTAxZnlHdW5MTnJHT1ZSTjFhaC90YlRRVlBpL2dVZnl0SGVwV3ZaQkxxZFdH?=
 =?utf-8?B?enBFTFFCMmx3RXlMbm9iaUY3N2E4L1lGZGdVSWNuYXFoRTl0SUNwbGJ3SURx?=
 =?utf-8?B?QmloZnZXd1RKQmUwNEpuME9CcmNnejFsdDk4RjdRSld1eDJRdWxNWUVMOEZY?=
 =?utf-8?B?Mzc1emFodWlnbGJuNzNSNk5JV2RCWEtZbC9sZWlDdUlEMWo1aWJUbXZhVXpD?=
 =?utf-8?B?bGtwM2oxYXdPb0hTSy85Um9SN1Zmb1VGQUNYV2VFZ2VnR2FoZ3NTQk9YWDJp?=
 =?utf-8?B?ZnhsbHhzbk1obk55bTBZUWRhdGxjNVM1aGNudlFJQ3BIVU9FMG9scFlSNy8z?=
 =?utf-8?B?YWgxQVl1NzN0WFVwaW5iWVNNQnpHYlcrNUF3S1VIZ2FCMTJ6Z1lKRXRiU3B2?=
 =?utf-8?B?M0hxK2piZnY3QnpHSGFuaEhlTlIwZFlwVXltaTJ5RXJVaDl4Tjg2Q0pyZG4r?=
 =?utf-8?B?OVV3c2FrRW1nNFIwZDN3YkNOT3ZFY2xqWGhXQUc5UkFtTExQbmlhVGtsdHlj?=
 =?utf-8?B?UEJXSkVWanpuUVQva2JnMmljZXU2TUIyMHRkWXpOZG9EYTYzcWd6ZTdycVdj?=
 =?utf-8?B?ejRoa2dnR05ueElVVEFHUHN0VVhVWXNudnRxSENQV3NNTW1WUXllTzU0UU9Q?=
 =?utf-8?B?VEk4U3g3ZkE4aHIyamVsKzkrRUFLYW9VVjFhWVYrWG94czYrNjhwejh0bytE?=
 =?utf-8?B?Z1RVdDM0TGtGK2J3eHNtZDFjd3B2WDAzWXVSQ2tLRmZ3Mzk3Z1hDM2hmQVgr?=
 =?utf-8?B?b0JUQ284QWdFdnV0NHg0R3VEdVpyUlpIYUFVcS9tbjZTSG42L0todjVRRlo3?=
 =?utf-8?B?V2diVXE2WHNaZS9yTDEydUMvR29zMTA5TXdDV1A2bTFvK25STnViQjExeHBP?=
 =?utf-8?Q?uf74nz96XdWszpgw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d41d88-968e-479f-ce8b-08de4e8b5564
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:55:47.4707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN8aXWHhTjAIrrw3P5ObMW4hSALGoJfxZPG3hzmZXY6Eu+8RRpmKAOe8JifBOq0+iaOj7MtlEJHZ2Pse9P1hRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9194
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

Hi Neal,

Few comments below for consideration, apart from that:

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>

On 08/01/2026 09:46, Neal Frager wrote:
> Add command for checking if boot was authenticated.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> V1->V2:
> - extended zynqmp command with verify_auth sub-command
> - changed return value, so it can be used with scripts
> V2->V3:
> - separated status and ret values
> - replaced BIT(0) with ZYNQMP_CSU_STATUS_AUTHENTICATED
> - changed env variable name to "boot_auth"
> V3->V4:
> - removed unnecessary zynqmp_verify_auth function
> V4->V5:
> - added newline to zynqmp_mmio_read error msg
> ---
>  arch/arm/mach-zynqmp/zynqmp.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index c0398a466ff..bcfbe229148 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -362,6 +362,36 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
> +				 int argc, char * const argv[])
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
> +	if (ret) {
> +		printf("Can't obtain boot auth state\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	status &= ZYNQMP_CSU_STATUS_AUTHENTICATED;
> +	if (status) {
Even cleaner could simply be
        if (status & ZYNQMP_CSU_STATUS_AUTHENTICATED) {


> +		printf("Boot is authenticated\n");
These prints (is/is not) seem redundant to me as the env is populated
with the required boot_auth value. Perhaps change to debug statements or
remove?

Thanks,
Tomas

> +
> +		ret = env_set("boot_auth", "1");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	} else {
> +		printf("Boot is not authenticated\n");
> +
> +		ret = env_set("boot_auth", "0");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>  static struct cmd_tbl cmd_zynqmp_sub[] = {
>  	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
>  	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
> @@ -371,6 +401,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
>  	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
>  	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
>  	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
> +	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
>  #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
>  	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
>  #endif
> @@ -446,10 +477,12 @@ U_BOOT_LONGHELP(zynqmp,
>  	"	48 bytes hash value into srcaddr\n"
>  	"	Optional key_addr can be specified for saving sha3 hash value\n"
>  	"	Note: srcaddr/srclen should not be 0\n"
> +	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
> +	"	Returns boot_auth : 0 not authenticated, 1 authenticated\n"
>  	);
>  
>  U_BOOT_CMD(
> -	zynqmp, 9, 1, do_zynqmp,
> +	zynqmp, 10, 1, do_zynqmp,
>  	"ZynqMP sub-system",
>  	zynqmp_help_text
>  );

