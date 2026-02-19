Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B04E9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 16:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77C983946;
	Thu, 19 Feb 2026 17:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sUKZhFX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1F983CD3; Thu, 19 Feb 2026 17:08:05 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402A383936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 17:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNdSOCga7ahO7MlECZtqV3i/ws5wD8E5oropUzsQeWY51tbTFKxAA7ABMOQKd+GU248HpJAX+O/GF/ksqu6ZSIaUJqrIk8nnZXAJws5aWnAaHSidBnIoAaadtoV2601sL6t8kqT6s76i9mXDdv8RS/fJL9yPo8Gj6L0IfjrqxgQJg8tRfdYc1pfv/GSm96lhKSZTzbcxLfeUTxHzHhNFaH+3Va6Nx+fvnClIlaP9l3eugO5te1QWzVKPZTFd5jsG0vZMHPrT9KsRmWT3v2Ni3c0h8uUtAzk0hIhTdcakKFkcWeTnM6CK8Phnw4MRkzOP5wdLJ/wRbTwtdiuAIAoVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO/nB0EQQCNhhdGdwKDbwUK42S6rtZAc+gI3ue9U4U4=;
 b=fl8YeNSxbAsCseNhDtFdPSO2OgY6iYde5yNwgscVXXfpUP0IdOi02mSUDpQS9OuJ24jKKFDW2o5D2WrK8k+Rx7KdS31rW1BWG0ArEn6W8Cgf50EE+AAAXVfX51rU8fzHpc1yNLYw8AJtgIBQWH0gTdX9dwwwm+rHwzp0yoa+Z5EDnGMJPTXl118K3aDuj3J2T1EbVjJb3YRNA7YVsHr+663o0nLfTtuiBstKMIOBhJuEi53fz19h2zWpOdsvQnbSPsPIt7bdV1eDTaQs6PR1Dt2mMJjuwM+qxFeDN76pfsgRDeGBOdrf2kVKxcw9zHgd/kgY5QXbdQ0Xxdhak2AGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO/nB0EQQCNhhdGdwKDbwUK42S6rtZAc+gI3ue9U4U4=;
 b=sUKZhFX+KV5let9YYzkdjiPSyl/na5+4FVCKd4dxLpGL+CZVH7iEXXFW7g6VAWzq7FWmeVq7lSl3WayizMqasroEawWTiM1CI207enIfTwelcQffPz/LeFlF2ZfHYvbx74LkvqorWXArOrk9xT1R9OCb8NBEZ3g0kTvRTc0aXDqApILQ6/Snb37J95RH8XB36Zoqu8m/uswJ23Xh4LbOOn94HRAcxMlv4uiFMqj/r0pY+eiWC5pg7uY8T7bZKxAbjzRA32YB30NkpvQo6veV2lKKhDf/GdGaRAcPINPhfuuVFEKNVWG/tX6GVzD/peugGxt0BDB0DngSmK+CLpMY8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by MATP195MB3339.EURP195.PROD.OUTLOOK.COM (2603:10a6:250:4d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 16:07:58 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 16:07:58 +0000
Message-ID: <ca9672e8-12de-4545-918d-79f3b171e863@phytec.de>
Date: Thu, 19 Feb 2026 18:07:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] board: ti: am62 family: Sync rm-cfg and tifs-rm-cfg
 with TIFS firmware
To: Sparsh Kumar <sparsh-kumar@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de
Cc: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Akashdeep Kaur <a-kaur@ti.com>
References: <20260219115837.965532-1-sparsh-kumar@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260219115837.965532-1-sparsh-kumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::41) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|MATP195MB3339:EE_
X-MS-Office365-Filtering-Correlation-Id: 60657680-c8b2-4774-1ad5-08de6fd10cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWRjWjFGc21hK1p2UWo1cENkbk95dGFIVFNaRGQvbDhlbG5mR1dzU3Bpdnow?=
 =?utf-8?B?MHFUVnhkSzM4ZnRoUTZxR2tHZ0N2VjE1bWhmVnJtZjk5TWt1UHVncSsvQTVm?=
 =?utf-8?B?Vy9NRHJMOW9neUpIdVRoUmJxcVJNZGZBOVlrOTRYQ05xMlJjdCsvZFRzNWtG?=
 =?utf-8?B?VUZEd3ljb2MwK2dYRC8vdk8wTy9tREgyT0ZyS0tLY3A4aWV6c2MrL1BpaDdK?=
 =?utf-8?B?Q0hOQ0haYmRpL080eUdGdVNsQkhtQ2pnN29PTUNaTDc0M09HdmRWb29Vc1Zo?=
 =?utf-8?B?M0NKVGV4RWVuZy9sUll2WXpvYk9UQTFINFNVdUI5eXYxNUJTTDZEZmpMeG9O?=
 =?utf-8?B?MHVPbjhReEhFUy9Cb09kK296NHdZWWtlT3RMQSthYWlndFduckQrUyt1eU8y?=
 =?utf-8?B?SVZRZnNucmpDQjBSMC9Gc0VjNHdiZDRnMzdWbkhranY4V1B4dENDcWdZa3BJ?=
 =?utf-8?B?NnpzU2lLMGdNR1JFMGRWT0NOalBLQ0NIVDV0S3FMRjRqZ3A5azdESEM0aThC?=
 =?utf-8?B?YlJDbTZLZitQcFRHOGZSSHBuOTVvVGFKNGpNaUoxS04wY1FsdWIrUnNuaHdp?=
 =?utf-8?B?dUI4K3h3a0w5L3kyV05NU280ZDlKVTVpTEhqOGtaNTJLTVRmVWNoREMwRENq?=
 =?utf-8?B?Vm1VdGdPdGZINDdPUnpJYXB4S3MybmJmbEtFcVpJKy8wZTRSVktUY2JaR1E4?=
 =?utf-8?B?dVVSbVBqeHBtTEE0b2NsSmxMbVNsWTFSQlg5ZW9BckdlY2FYc1pLK1VndWZm?=
 =?utf-8?B?amRFUHNzbzYwSHNlbFBHSmdnU1dWWUordDREbVhKZXdmemJlQ2d0Und6Z2kr?=
 =?utf-8?B?MUprb2VsWG5Jd3VaQVdqa0xJTyt6MmlheEVtVzJsc0lyYXl6OElFZzNRekoz?=
 =?utf-8?B?NHkwVERrZnRHREdOVjRFTisxR3dNT05LRDFSQ3ZsK0hjMjFTNkhXWktGSTZ0?=
 =?utf-8?B?bzB1Tk5HNjRyQ1BJaGJLY05oVDN1Q2NJMENIR2lOMmpydWVGZU5TaXBXeWtU?=
 =?utf-8?B?QWxJMThoQlhwSzl2a3pUclYrKzV1RFZ3aXpzekdyNnMxR2NWUFhkVUlMK3JL?=
 =?utf-8?B?NU1nYk1EbjljUkx5RWYwb2N5RzZEcFFGYU9DT3NaMElQZjlsWWV1VnJGMGYz?=
 =?utf-8?B?VnJzSDdNZ2gyM0hRSlVpbGVYbDM2TTM0MFAydE1wdk1VYjJYd3d2RTNLaUto?=
 =?utf-8?B?ZS9UamxvTG9KWDg4TFpqM0J1RGFzaVZFQWMyL1FHKy9oZVYySmFaTGhLajdS?=
 =?utf-8?B?VkI1N3JVL3hJTzUyTnFacjZOdzVHN0hPNVd3d3pWSFBTcU15R0dsV2hpVG1h?=
 =?utf-8?B?cGZsa2hyclhXWDY0TmZUc0hsT2dFdnMzQWZXSm1DY1RtZG9LRWthT3FWRk1x?=
 =?utf-8?B?c05JZUhwLzdWeTB3eHpyaVhkV3JBSjAwb1hFTThvRElWd0phRlkrVzdKMnFu?=
 =?utf-8?B?Szd0WlRUZzVGQm9hNktKc3A5a2F0enRaV0lmdHNGLytpdURQd2Q1NklVMFhk?=
 =?utf-8?B?YzBIV1lMZSs3VW5BMWdCcURrQnpRdldrVGlILytHWU16WVNMbFoyWnRRVTVl?=
 =?utf-8?B?UENYdDN5N3ZDeGd2OSs1VUhFdzNuRjhoYmV0Ump6YWU5bWoyd0xsM0tXWjdk?=
 =?utf-8?B?WVROTkZJQ0p1Wm9Vcnp1TVhrRWRoNUpuLzBWRURvRFlwRG8zaEYrdTlDY3g2?=
 =?utf-8?B?OFRiekQ4OWFPNkJnN2FYS0xUenEzc2RvL2FZazNXRzVKMC92NVBKWEo4VVNO?=
 =?utf-8?B?L3ZSK3JYWG1SL256Q1RyN09KaXFHd1JhVjB4ZHRndFlyUmprVlJrKzkyMlhD?=
 =?utf-8?B?amkvdHoweEJOdVlFazhCRGFBL3JSRi9YV0U3ZlgzRnBxZjIzWXJieWV5RUpY?=
 =?utf-8?B?c0FQU2t0T1ZFOFVNRHZQQVVTaVpYRGF5WGpjVHEyTDdCTTByRG8veWh0TWk0?=
 =?utf-8?B?bWtRaHNvSndaN3BCWVVkd2JxaXI4U3F5YmRPNnoyekk5c2hvTHQ2ZjVWSFBy?=
 =?utf-8?B?NExJUlVQR21BVVJFczQwcWJVWG1nd3ZZdm9tV3pwR3ozeXpiWktmUVNMZU9x?=
 =?utf-8?B?TlpqYkkzSTR0eGZYdmxiVFdxZDNqRVhuZU5EUnU5L0szWTNjckMxaUZ4Y0kx?=
 =?utf-8?Q?UYjI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEQvSmx2WDNqdkxQakd6QjVHakU0SnFmNXJYSklEQ2JNRHRNSUp1VnZYMHNV?=
 =?utf-8?B?ZStZUTgxdjM3YmZVYm81TUxleVhiTERiQ3Vic2VvQ0FPQzlvUHRNcVdXckQx?=
 =?utf-8?B?Z3VnSTdIM2x6SGpjSi8vcWJlU1NFZFBlaHNqcGF1d3laN3VhcERYTW5CUmRQ?=
 =?utf-8?B?YUsyL3Aybk9vcEtyRWJXY2pFUzgzSVBhcFFnQlJEUmZHekowYko0c3BmZjY5?=
 =?utf-8?B?V0lWVVlyUWV3WHcweTJUOTFsVllTSnNkMVJidzQ3RG9QYi9IZGc4Um1Odm5h?=
 =?utf-8?B?SDBXTWJEWWc2clhrRXZFa3ZMdnpYeFpjTHlCdENqdmdST2Y5d3d3Uk9kZ215?=
 =?utf-8?B?WEpJOUFJTnpNQTh0TmVHNk5nUnIyL1AvcUIvUUhNR3ZGRTJsR3VLUFJJYUVa?=
 =?utf-8?B?UWtrZTJ5M1BGT2Rvcm9TbVYyUFJBNkFkRWFObkF4NlJBb1MrVDlmWjZJdFpI?=
 =?utf-8?B?eFlseVlrcFg2aXFiVW5NZnB5cmVhMUpWZEFqRkJQQVo2M0hTOGxXQkpEYWtC?=
 =?utf-8?B?N25sL1l6K2FDbDFKbHZ0S0pVUjgyODZIaXVndUdEcDBvaDZJM1ZLY2NsOVlj?=
 =?utf-8?B?SnMwQ1I3cUR0NHFZV1pmL2VhSTNiNzVaV2UzREJnOUE3eUZZQnVZaTFtVWlE?=
 =?utf-8?B?Ynh6ekhPckRqb3BTVUd1UHVkT3p3Um9wb1JPaG1zQXFjOTRXbU45WVZOZlBB?=
 =?utf-8?B?RmpVdU81cENQblR6cEhYQWNjaTl1MzN1R3NQNll2SC9PT1ZKTTdFVFI5Z2dC?=
 =?utf-8?B?MFdEVXFxRkEwUUlwTnB2bTlKaVVDWVVoeEpQSmM5VlB6ZWRkT2VXR0swaFd1?=
 =?utf-8?B?WE9mcFJVRGgyYm5WZ0NlOTdDZWtja1VOZlpwQUwzS09zTWE4eW1xMkw3RVZz?=
 =?utf-8?B?aXU5NndFT2dyWXpSVlB2bENLMUpkenRLZzh0d2RZZVlNa0Zka3NzNnZjTnRy?=
 =?utf-8?B?QnhjY1Jab2VKMk5rdFNtay9CQThHL214QUFmMVZQVlJCdG5kTUxjN0tzM0h1?=
 =?utf-8?B?TU5sTWFFSExiTE1WYTZYRVRHRWplQkZrbW0zQTdMaDJRV3c4RkhyWVZYeUpF?=
 =?utf-8?B?ZENkMDFBblBiQU9sVnliUW5qaDFxQkswNEpabmdPcnNIR1FBdEZ3cGFvank5?=
 =?utf-8?B?S3ZMWUhsRDRlelVBWmYxaDUrVVRkQm9GTlh0ek02V1dBeXFWcTdoNXRIWGJ4?=
 =?utf-8?B?NXJmOEJNbTRTQnZ2UjdUVFJ0V0V4NTQ5OXlUcXpsdEMzb3Y0MXdLZmF6Nnhm?=
 =?utf-8?B?dWVUZ3ZtdUlCWGFlcklVK3N4WUpCbGlRKytHMmdWWGhFNlVQeENQamZzc2Nw?=
 =?utf-8?B?UnZSdjczSlZmWndIR3Q1a1FleEEzUTJoWVdqcGdYczdMd3RQMjdDa1NENHpy?=
 =?utf-8?B?T2diRUFZSk0yRGtCYmQ3TWtab1NoU3A5R3RreC9NVkxHUElBdjZaZit6bUd4?=
 =?utf-8?B?Z1hQYWxaTERTMlExbGY1dHpzL3JZdm9UTUgrY0QzS1c1dmNKeGlaSVhGSUwx?=
 =?utf-8?B?L2hHSWhJZHBxU1J5UW40d3Y3ZGQ0S0RscHBJbGQ2QXhHazBaYXFvYXY1OXJX?=
 =?utf-8?B?eFZvUzVCUTFxM0lHOVFBUjRSOENuMElHNXppZmlacFQycmw5YmhZK295ZzNL?=
 =?utf-8?B?ZUVJWEh1c0NyajhVek8rOStEYlRFN2ZMdWQyOVNVUnZvN0dpYmlZSEZiVG9V?=
 =?utf-8?B?K0w3bGRKVCtDall3dk5JWGV0NjFRdmRRbkVIeURXNnhDSytjS2xlU3NlRHVy?=
 =?utf-8?B?NDRVanhhbkN2VEZ2MDVHYlA0Qisrdm5Kd09hdFg1cjFYeEZSWXZzWUJzbitl?=
 =?utf-8?B?T09wZnBoQWhEbTF1MWQ3N3YwK0l2ZEp5VXFXMTFyL1VOejJPcDhIa2ZtdS9p?=
 =?utf-8?B?TEJEN0ROWGRZWWFYdXQzMUFOK0xnZ0VHMG03TmcxQTJ1V3lTY1RxUUFSWi9v?=
 =?utf-8?B?eVpxZy9jSmtEMTJyWlFnMndSMi81bDhUUDJLaStWZUJHTFE3b1NkbktUWFgx?=
 =?utf-8?B?ZXh3WldkWlJOeUkwamd2YlJ1QzB3LzY0RFFJOU9ldzlBZU0yVWJnWkFFU2R1?=
 =?utf-8?B?VXlJTFc0MnlNam9ZUnNGa1hUMHBXT0g3ZytadnZpMU8yRng4SzZoMFhpSW5i?=
 =?utf-8?B?RjdqZm9CK25xbTgzWGJmb0U4NTR0bGtkbExZMDJSaExnL0VQUzJLcnFhVnAr?=
 =?utf-8?B?eTRxdm82UEdVamxWbU4wc0QxWUhPZ0RCNUlOd2ZUSFoxSDUyM2NLdFhYV2Ur?=
 =?utf-8?B?U3dIZEJSVE56aVVyMy9OemZTY3ZTQS9UbXZpbnFTZjFDWnFxaUd3SkdHSnFk?=
 =?utf-8?B?OFZuV3M1bHZLUHF3S24zYUxmdndDeWdacjhsVUV4QXhyaDk4M3p1QT09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60657680-c8b2-4774-1ad5-08de6fd10cc2
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:07:58.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiP/6DiAXq1ptNMrBag7SgrWWGzvRUtg9g9vWsK6V9DiHz8UybBOQGNsJzMYtZTaDrfzi540ynJGCe1ZzJc/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MATP195MB3339
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

Hi Sparsh,

On 2/19/26 1:58 PM, Sparsh Kumar wrote:
> This patch series updates the Resource Management (RM) configuration
> files for the AM62 family of devices (am62x, am62ax, am62px) to align
> with the latest TIFS firmware changes.

I guess we have to update all non TI boards aswell?

> 
> Background:
> -----------
> With the latest TIFS firmware, an additional virtual interrupt and event
> is reserved for MCU cores to DM usage. This series brings the rm-cfg and
> tifs-rm-cfg files in sync with these firmware changes.
> 
> Additionally, the am62x platform was originally introduced without a
> tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family. This
> series addresses that gap.

Is there a specific TIFS version we need to use with the changes you are 
introducing here? Your other patches mentioning 11.02.09.

Regards,
Wadim

> 
> Dependencies:
> -------------
> This series depends on the following patch for am62ax tifs-rm-cfg updates:
>    https://lore.kernel.org/u-boot/20260130143339.1401600-1-p-bhagat@ti.com/
> 
> That patch adds C7x core resource allocations to am62ax tifs-rm-cfg:
> - Shared split BCDMA tx/rx channels between DM R5 and C7x
> - Shared rings for split BCDMA tx/rx channels
> - Global events and virtual interrupts for C7x
> 
> ---
> 
> Sparsh Kumar (4):
>    board: ti: rm-cfg: Update rm-cfg to reflect new resource reservation
>    board: ti: am62px: tifs-rm-cfg: Sync tifs-rm-cfg with TIFS firmware
>      updates
>    board: ti: am62x: tifs-rm-cfg: Add the missing tifs-rm-cfg:
>    arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in binman
> 
>   arch/arm/dts/k3-am625-sk-binman.dtsi |    4 +
>   arch/arm/dts/k3-am62p-sk-binman.dtsi |    4 +
>   board/ti/am62ax/rm-cfg.yaml          |    8 +-
>   board/ti/am62px/rm-cfg.yaml          |    4 +-
>   board/ti/am62px/tifs-rm-cfg.yaml     | 1476 +++++++++++++-------------
>   board/ti/am62x/rm-cfg.yaml           |    6 +-
>   board/ti/am62x/tifs-rm-cfg.yaml      |  867 +++++++++++++++
>   7 files changed, 1646 insertions(+), 723 deletions(-)
>   create mode 100644 board/ti/am62x/tifs-rm-cfg.yaml
> 

