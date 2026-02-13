Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B621EEF48CC
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 07:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA6B82BF2;
	Fri, 13 Feb 2026 08:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aS/hl3rB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E5583A47; Fri, 13 Feb 2026 08:18:08 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE28780FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECxzVXhnoDeQAEbQQ0xa1Py3Rz1DaO9dkCwwlKAnp+r4upWu6DoihOQdWn2YLEKUIQoFmnwylrWSncV4Mpyqe6qqqz5D+RKs70DMaI3NA20SN429oG0Wfep8wjmqAcDs3UIYErtpZOZOzFGQ2VFUv4sRdunDnXY/eJTOhofca/JWDWgG4rAsZQnd0baxuLZ2Rhum2R5wzBIFy2k/rCC6+Vt+TFShMLE+LmC8gbvOoBMp/MwQ0ppzQG6iGPTIoHSlhrp/iTgJG0aLvfd8vqN0i6d3GLVdXsg+6DO/SPBIwVszjbfWEUH8Ey0e5up1MYeAl2NiLdTP92NQ+1yLnC1lXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbYwRoyrZX+CiaW7A0v6HU54owWKfGWYicCLTUdPfs8=;
 b=NnkokjU3VpNzjB8uRFZjOMqh6gRUO2Lxxfn3DE3/E3l88SaBaKStN/JpeoMFU/3Uh13N6JuLFpRGHHtyMSNJsP3/v4ftppHNhXuD4XJPPd4u0wQTy1rIZVbUG6OJugFFDD1GCmt+X24KiXIr2/f5gqo5psppcjYQ+MJQhSUjDIrX0jZAQi9QRG9lQcOUabF06q36Zq1xXe1RWCoARfT3xkq6qJ7KLMQllPhCp1oMrUQmDals9hdNacoKVNtJoDXx/yxpQSvPgBTajGxTcFS7a78hkLz/7ZSpd4bm2KVqmVoQHPGQm6LFkvbh5GW3SrgASJHeIU5GIpKv9xJ+m1m0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbYwRoyrZX+CiaW7A0v6HU54owWKfGWYicCLTUdPfs8=;
 b=aS/hl3rBp9SxP7w1ix443jWwpoiLE1GhRxIiwAneBwcvmXv4sm88ZqfE98JUxYrgJSD5fR+cb6PWnHnZN9CbebJhZf6p61an5jzuX9NLmsKu6Ou42Tc1UvArgmVm0nunSfH8wI6qNtVHrFqOP+oqQQo+u6M72kbqFFgwd1c4i2tWYyRUk1Z4E7PqVGk1b0DTR1DafAtJ1EDsL3IiKFHIT0JqqELHMgMylPGTIA5v+Qbsni70qIEz8BgB2TdU0DboAHydVOq4CCGAaPrrBNm2jAyEz01N+CUbEf22nueYfLTsL1816JCGfUcLBIGeqnSV+b1ixdVxVTXNjhYDlUZPeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by MW4PR03MB6443.namprd03.prod.outlook.com (2603:10b6:303:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 07:18:01 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 07:18:00 +0000
Message-ID: <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
Date: Fri, 13 Feb 2026 15:17:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: Sune Brian <briansune@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::19) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|MW4PR03MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 373240fe-2927-48b9-e9f2-08de6ad004fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEM5ajJrMUlHdUJla2lnbXhCQnhjd1VRNWZCeHE3TzUxM0V3VW0rNlZRREdz?=
 =?utf-8?B?SE9IcDVkODFlRGtvQ2dGRmNXZk5hUlpjNmpndUhXVFNsQ3RpNUxhQ3phNkZ3?=
 =?utf-8?B?RVVSWVhuTEhhUmJlbnJIbXM0cGdrQTdMSlA5S3h0bUtjcGZ6Zi9TQTdYMDcy?=
 =?utf-8?B?NytSaC9NeWN2T0g1MzVxWm1BK1c2SVJJak1PWFNZWmR0eEpQUzVscWlFaGdO?=
 =?utf-8?B?TkY5NG9DK3BraGJmV1hIUDhjS2lDd09hMmRYRFlOK1ZLQkpJZmdMUmQveUVU?=
 =?utf-8?B?RU9Rb3kyVHhTWE4xaWc2akZucXd4T2JTUWlWaWN2V2hGdHo5cllXYmlGcU80?=
 =?utf-8?B?alFqZ2pSMVJNRDFtNTlkeWpIS1d6bG1RczFjYXdGOGhtUVBGOXFBMXRUQjli?=
 =?utf-8?B?OG1uQ3Z6NThCRmVJK05XejR1aW40cXZBcDdQUUsyMkJWclpBL1B1YmhXVXRK?=
 =?utf-8?B?RXk1dnptRkVwbG9iZ09ZdnhSV0NDb05uTENuTHhZTTl1UEZpaEk4WW9uT2RE?=
 =?utf-8?B?L0tTRkZySENKSDVjaVFhd2tLQlVraThodDFDSEJyN1k5S3ZpRWpkVDhNZkpP?=
 =?utf-8?B?TWRPSWhjTXRwcTNyZy9zZ1Y5bFpxMkFIQ3o5WCtjdzZGek04OWtqZTZXc2pU?=
 =?utf-8?B?aXppY2krL24wTUdlTDFwVzR0WlhoMk82SE4wdm41ZHN5NmVtQ1VGd0VEVzdO?=
 =?utf-8?B?TGhBa3JYT1JLaWd3Z25VM2xDYjYrSnkzaHlCS2dodngvRzBNNG5KNmRoNkhZ?=
 =?utf-8?B?UVV1UUZJTXZtNUJoMzFqUDFDZmNpMEZBNFBvQ0lORDI2Qmh4VndUbS9jbnpm?=
 =?utf-8?B?NWtCWTlGVmE3MTNabC93YWdyczNrK2V1aHkxcEZ6US9ZRVMvelQ1MWpDSWw3?=
 =?utf-8?B?UERXeUtBamd1WDZ4NTl2bnpSd1laa2t2OU1ubmVYVS85ajMzNmRoeFJtWmZt?=
 =?utf-8?B?TUYxelFIMExpUE01Z0NUcDZUSFlqeFBMd3AwVStweEkyNHZXNVdJNFM3TUo0?=
 =?utf-8?B?QW5BSTIyNlJBM3F3TjdFKzA5ckFSTzZ5NVVHQ0dVT3VteEFUbFJPcjIrUWRM?=
 =?utf-8?B?NWFkeW9Od3l0WHZENzRrS0VrVkUvS2NsRzd3Y29oYU9wQmYraDBqbWZPWWll?=
 =?utf-8?B?MDRMU0xHSmpDdGRGaXBpNFVYL1J0WVoxWFFUZm12eG41bTVNd1BtbEp4S0M1?=
 =?utf-8?B?Nm5zVE1mWnR1bm5oTy9NbzNtNTV4NXdvZzFXQm5heUEzMUtXOTFQVEh6ZUpS?=
 =?utf-8?B?Nk1wb1NNdUNTUjJyS2l3amRRLzdFdHVTZVkxbHhEZVNsTW0walR2Q2J0U3Vz?=
 =?utf-8?B?dUFYcmZ3OUYzU0VWNDdaNHluaW1FbjJCbGhmRzkxSysyZGI3WHZQeXpURHpw?=
 =?utf-8?B?dWk3aS81QXVaSVQ5ZmFMdWRMaGRIWjVmUlpsTHlGWk1RbzF5OTNhaEJoVmNM?=
 =?utf-8?B?Z242OElHRTl0dkVLR3UzZ1d5dStndW9ZWXEyYm81cTFYSWJITG9RVDFlc2h4?=
 =?utf-8?B?UVZBVS8ybVZPTHFvOXppUzNiczNIbXRYR2NEa0RDNDFPYSs3ZjEyVnBLYzJY?=
 =?utf-8?B?LzNTcE9VMnBoNmFHZ3JheThiOHV4TDJycHZGUTNwd2xrNGM2bTZCeXRzUWpo?=
 =?utf-8?B?VmpreU1zM1prb2VXeWxSTGhaTUZBcHBCcnRGMnVDL25GVEhmNys4dlhzVFZ4?=
 =?utf-8?B?cTFVeUt1cXlzc1djSXdkTThRZzlzcFJOTllFM3pEQ3RUa242T3ZJTUpuby85?=
 =?utf-8?B?eWVIU1NoZDZvay8xNnZhOFBHQkU5SXpTZGpaY04yV1hLcDVRQkJqQ2FjQVE4?=
 =?utf-8?B?Q1BlbnVPNGF2ZWs0dWhrYWNFMld3OEVXVXozbURycE1JQnFVZjdnaml2T1Fo?=
 =?utf-8?B?dUN2ayt4d3NSSlpkc29lZktNT3E2SVNUc2YxUnArZnpla0R0Umh0WXRPL1JH?=
 =?utf-8?B?MGE5Tnc0cmJNMGlTbW93RWRtWi9NRlVSR293WVZYWWd5OFhBSE95VU93ZnFS?=
 =?utf-8?B?Vlp6b08wRWdZNDVmQlNJUTZDTnVCT0cyak5FNmJQVnY0Tm9LVG9rTlNQL3lK?=
 =?utf-8?B?Rk5yemRJRW15MVhKMCtUeTVzQ200OHFPNHdhUVhGTU1Nd012UHFmUXJqOWFN?=
 =?utf-8?Q?VaEY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZoMDdWcURKOXpubXo3Z1kvMDZUZm41Z3RLNTZHQWdYdDVkdFptVHIzc0s2?=
 =?utf-8?B?NnVZSnRjbmlMYU9uNW9tM3Y3emhiWlFacmhQQXZ3Z2pHRHZXTnEvYmpOMjh2?=
 =?utf-8?B?aXQvamtGWXU2emVNLzJrQW5YU1RwN28vQ21OSDlISjU4L0g5b09mcUwyaUlo?=
 =?utf-8?B?c3oraWdiUWgzVmpoRzRRWXBUR2hJbHV3QkxYQ01RTzU4UFRVTURnRUo2NGFj?=
 =?utf-8?B?Y0I4UjZyamJnUUt5S2tvUm9hSExmeVA0ZTk5eklWVi91UG8vZVQvUUpadDlv?=
 =?utf-8?B?NnpmeHVVWWNpZi9nSXJkYmtPZElockxxeTRBNmdnejFtMFJvM1Z5ZkV2SStJ?=
 =?utf-8?B?YnJiNkpjb1dHTjlCOFRjK1l6US9pdWdERU8yZitkakVFT1FNM0JncGU5N28x?=
 =?utf-8?B?SzVYeFpYUkZjWFcyanJWMkh5bTZDeUhiMjdBRjMydk5paWlMaUxTVG0ycUtI?=
 =?utf-8?B?ZVZ6ZkVoK09kSGdmNDkyOWNWQURWb2p1cnAySkZmZE0wNStEbFZlL0owTnZh?=
 =?utf-8?B?NEZvOThTUW02eTZLNG9yMkpiTkpqWktENHowcURVREovcGJTbHQza3VBWFlz?=
 =?utf-8?B?dTNzVWZORHQ1cVlZSlozUEZoUTRRU3Q0ZWcwK2FrUTR4Mkp2dnM4WjJVeVMr?=
 =?utf-8?B?d21DTmUvVlVJUmd0NHdHRk5kMnVmZ1lacVZldStxZHNxVnJJbDlBajZRelV1?=
 =?utf-8?B?RE94VkRZVzlvdkIzS1RoenRwZWFqYi90VnNGM0g5cmFMcW9iVElLdnk3MTVF?=
 =?utf-8?B?L3MwcjFkcUx0Yk96eTdyMWpmU1orNkFtbVduZ2tXK3FYVUFVaEpJcFAwcDNB?=
 =?utf-8?B?SWVFdUpGVkhFckJIcnJMQzFSY25FMkFZVFlQUkpmekhhUDE4MjFvRno2eXg3?=
 =?utf-8?B?aXVoMVRrNjVoZXZmNGdOQmgxeldYLzhoTkRwYlBEa1hYRDJScERna3hiV01Q?=
 =?utf-8?B?Q3pHZUt4MDYyTmNBeEVKQi82ZnZ3SHpuWXAwMFVTN3I3WFF4NGljaVhJQ0FS?=
 =?utf-8?B?TFR3cHVGRHI3MlVZQnE2L1diUE9ydERxNy9lajJIdUwzNW51TmxNNXVqck1R?=
 =?utf-8?B?WDZUTk85Q2JIUFpLeHpXN3h2WGFyelNxa0FGYzY0SDJjVnBpMk1kMVRjN2Vv?=
 =?utf-8?B?RWhWTmNOYStnOUo0a3pUdnB0NTN6N0E3b21FeDRTMDV0OHhtbk5WcitGT2Jj?=
 =?utf-8?B?YytLUzVvb2VUV0dCQTJwc0g0Sy9Cc0ZEZ3BNV1NFWEdVcm5xWjJ6bzd5Si90?=
 =?utf-8?B?L2hHcXNDWlFHZVdkWkxkZGN1YWFmNWlTaWYvWWtDNGNMU3g1WnRLMGdHaWc2?=
 =?utf-8?B?RmJRUDFzUDFSaWhGczZyMUo3QnBMc0pweFI3SzZEeEpibzFHU1ZySFVpTnBW?=
 =?utf-8?B?azZuT3JKTjBrU3dMNUZxMkh5K3JIcStEL1BIT0ZZUi9lL1daYjUxcXhhMytK?=
 =?utf-8?B?MStQTTBOZ3hYZ1NoTEtLN1hhWTZMc2swb0JKZ2JYbWxlaXRXUExXWTVwWW9P?=
 =?utf-8?B?MTYvMUREOUx1U2VKY1F0VTRXZGZKTVdlTnZSN29BMFV6VzBUejRoSjJpVWc5?=
 =?utf-8?B?SE9NUjlvRGVXaGFVNEs4VlpwTmJrV25yb1dldmlMZlAwVm00aURUMzJxdUlD?=
 =?utf-8?B?OFhqdXNkczRpckUrM2lHbTM5Z1NEZk9Xb0Z5Zi9iTjhzcjF4eFJaMXNzcjAy?=
 =?utf-8?B?MHFKcmlqdUFkUjQ5WHh5RmlFNmhBVDRRZ1NuSWJvSnVVR25vSzdReDlBZk1x?=
 =?utf-8?B?ME94dmVXN3VuRmQ1Z1JPUVlHbjNGYUgrWHQ1MTNMSm1NL0E4cTZ6VzdCK1Zt?=
 =?utf-8?B?dm1PcTlXRlFRT1YreXRNWVZ2b3o1aGhvU2xRRllYb2kyVzNSUVZCRmw2T0hO?=
 =?utf-8?B?dHd0Z0h6VDV0QjZQU1RVVWkrQThFQXdqOUF4VEk5N1FjeVk3NFUvUUVZWjdo?=
 =?utf-8?B?dTZNbEpMbzJKOFMyUFFLSXZtN25lcGtFRGhZV3ZVd2xEK0FWTzA2YUdrMEI5?=
 =?utf-8?B?MklHenFycDhrZXlSR0JjUTRhVUw0NUE5MERaTXlSN016RHNmS1ZNczBhWU9H?=
 =?utf-8?B?dU00TEc0NHU0cWdPQzBlMTMydTF3QW1nS3k3VTE3bjlJb2trMTl2L1lPMmhj?=
 =?utf-8?B?NFEvM1BhNms5Wm1RM0tPU2xrWjJjY0luakZ6QWRrdDBSTkovUlVBeU8zZHNM?=
 =?utf-8?B?ekhIMEdKcjdSeElBUUg4bWVPUmF0UW0zM2huOVFyT28rbjFXL3FKemNJU0x4?=
 =?utf-8?B?RGRFbFB5RWJCcmdwTThqUkRmbGt5KzJGMWhaQmNmZERCck82Y1QvU2Vadit0?=
 =?utf-8?B?U1Fvd1dwTWF2Y2xoWUc3ZFRzS0xZdkhQdFlXRDA5ZFBlSmViYU1hdGVvUnVy?=
 =?utf-8?Q?xwENXTdbQoqB2zns=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373240fe-2927-48b9-e9f2-08de6ad004fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:18:00.8393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBJCS/RVVxsymmAZe950I6suhyjfEAPPNTMW0jtjkr+7A0BUZgy9E9i6F2SoWdbLIjcpvwXd+c8fDML8zY2uOjcqKCSaHZQInbGNTAhpjrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6443
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

Hi Brian,

On 6/2/2026 11:09 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi Alif,
> 
> Since 2025.05 to the latest master.
> I do not have any issue as you mentioned in this patch.
> Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
> I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
> that GEN5 Cyclone can support.
> 
> Not too sure what is missing from first place?
> 
> Thanks,
> Brian

Based on the CycloneV address map which can be found here - 
https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.html#sfo1411577374877.html.

Bit 3 of staticcfg register has to be set to apply all the settings 
loaded in SDR registers to the memory interface, in this case the patch 
ensures the SDRAM controller applies the latest configuration after 
disabling FPGA SDRAM access.

This is a safety and correctness fix for re-initializing the memory 
controller in the proper sequence during FPGA reconfiguration.

If you have the time, can you help to test this patch with your setup? 
Although unlikely, we want to be sure that this patch will not break any 
existing GEN5 boards out there.

Thanks,
Alif



