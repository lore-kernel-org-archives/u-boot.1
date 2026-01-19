Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B87CCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5804800AE;
	Mon, 19 Jan 2026 12:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JiWBUqf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466F280B98; Mon, 19 Jan 2026 12:08:53 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9FF8004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlQoKk78FwusyoU6A86BwzGzN2tlquwssjDMtWB/a2a3yYxrTGgs9TOJ3b7rDI4AqQGu9RjieeOapN8dWOjBlYSg1tYurne6WFZghAQr6jLToSLlbDESlguM0rflqQtE0lZZtadqZMpUs8GCzILCshjEuGp3KLEUQA7pyA4Garf7UBdrkBp2M4XHu8ImP7IGh7hraV4e4oIf6TGyCVn7tLS533VHSb7E8KkHkgFfVXNXQ9T6Hs1spEloHA3JT5cXWrD0jmYBhpjecvdq+u3PPKjIqAGNbdAEOewu8hJQmxlq8pyl6m43CHuv/vhN8/sfDEE+auOKMNIRQh49QciPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fEgfwn4BNxaeOELQLpUTLuRTnMQx5K9HG8d18v6UDA=;
 b=f8STpFZ9yRC4eKNOHeFB6XjH/0RlDBbP6ruPE7XAueIRbQgOAlY1S0G1lb9/KWyVx73AsNabmZaz8CZJlsqGsdYjJqb9SEIADKv3Tnm7k3r0KT1yLZAGxljxAQO/zQcIaRjZcj3VJlC+DHpq6mj4/AzFbfboM4XqSeIXeP/k/iuKq0HHiqlidY0otkRs2dzHTVO/OBC9Zln0SemHokIWryPbd4qTQLX4gMCN070YBasvTj/Go7RrH7tOk1WbFnlHRFf/Q+zGYpVgCsyeyi9tMaen5AEZZoMuTvcvxcG/kPOzLKnUzIEvpe2RsI5c5DyIYBvIQDZPYnaAWej9vFNtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fEgfwn4BNxaeOELQLpUTLuRTnMQx5K9HG8d18v6UDA=;
 b=JiWBUqf3++jmEBPPmCd77LzIsSwMzh/zY9xPIghW/EVCUG6kuEunBsChKzgUOJs8JSe2bd9jpCTipw3E9e+0ZlypofoZafKpjymO2ntPPsRMxXaOhw0BcPXKv7uqw9E5sAd04BFJesFiv903Rji/MXw7olIK4/TRFbwrk3SL1xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB9518.eurprd04.prod.outlook.com (2603:10a6:102:22d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:08:49 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 11:08:49 +0000
Message-ID: <4975793d-627d-4097-9a5d-6fb9f810aae0@cherry.de>
Date: Mon, 19 Jan 2026 12:08:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/clk/Kconfig: fix "related" typo in help text
To: Peter Korsgaard <peter@korsgaard.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, lukma@denx.de
References: <20260119095437.2775081-1-peter@korsgaard.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119095437.2775081-1-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 223a8f14-e67a-43bf-6373-08de574b1f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUdJdWcza0U5K1h0VitPNzkvcnNrK1NEM0RSaUM5NEFUN3JsUUJKQkNHZDh3?=
 =?utf-8?B?aEVrQzlkTHBDbHJRT1Y0Ti9hK3FoZi9wSVV6TWdWcWkyUWtpMlRnZDNJcW5X?=
 =?utf-8?B?My96WFVZczdzVG5XRGM1eVNpTWNVLzdiV05LZVB3aitVczRaUlF4QnZqSElu?=
 =?utf-8?B?bjV4VUVpZjZBZGZoUzJyQ3J3Sk8vWjJFOW9hUzVxY3FvWFpSMXRwV0lMYXBN?=
 =?utf-8?B?RFVPd0VIa2ZwcXIxaHJoSTdGWS9uRVdPRHMxOThNaFY5NDQ3aGtrb29PbjJs?=
 =?utf-8?B?S3BzMDNtc2pYNkE5V3RGQi8zMHhORkdoeVVrVkFGbmppWWlnRGdwdkRFUUNU?=
 =?utf-8?B?eHlWVHdQV3puczhMV0Z4YWhsWWpwSWNKUmFiWkVuUVpoemxlaDNEZXJLVUlH?=
 =?utf-8?B?aW42RitROEx3dW42NE1MMzhpZm9jRDBwcTlmcDdBenBOTy9vRk12bnA3cnhq?=
 =?utf-8?B?Q1FFbVM0d0RxTDk1dVZPWlRvSU9pODlXUURVbk43MEMvVHNpcUdsekcwTUVT?=
 =?utf-8?B?WkQ1WmdneEpSLzlWNkU0ZDN4T3U3OERmelhJdkY1Y1o5ekViN0ZOR3hJdFRv?=
 =?utf-8?B?TVZWQjBVVXRKZnpUUmxXenZKQTQvM0RnZG5kN3BpcGZScEd6ZjNTdUk5QU9Y?=
 =?utf-8?B?dW9DK3l6SEt6UHdDWHVsejZQaHg4QjRvMHhXYmFsOERyeXBXZ3BuL0EyY0JP?=
 =?utf-8?B?VlpON0xySDlDWHd5Z3dHN0pnNXV1R3FoZUhOVVQxYlg3a0ViRjdrK01PMEIx?=
 =?utf-8?B?WXE0aVY4cTNiVkZYMGlIc05CM1J0V3VleHdFaVBPVzliRjhlT3RMYTNjMi93?=
 =?utf-8?B?emFsMjMrcDFDOHdtdUY0aUJBOFpwemNQeEVOOVpGWDZpS25VcVFTQk4xejBk?=
 =?utf-8?B?WjlCL1Y5a3BUTThqLzlVWTJmVVlZbVRSS2pPUjJEVmhmQmpmaW5yY2NnNVJx?=
 =?utf-8?B?QlU1WUhSaWRsWGN4NVI4NjkxVHczNnowYWhOSzJxMFBxRDdnRWlGYW0wTExL?=
 =?utf-8?B?eWRGelloTWlMeXdTSkRHWlZ6YkVkcG02SXBFNC9rbGxqbzhPODZUdzBqSTN4?=
 =?utf-8?B?eTFNbzlaUU5kQ1FBR1FnVjQ4RmtmVU1jaDNRMFVFUEd6MnlQSHJXNnRLZDJw?=
 =?utf-8?B?dmVnekxobnkwV0tkdW5uV2M3bnhLTkVYUnJLNGIvV1VqZk8zeDF4OFFZc1lF?=
 =?utf-8?B?ZUZudWJZRm96Vm91QmtOSldUMi96OG9lcVB5cDh5c3BvbHJ6b1VidHFSamRq?=
 =?utf-8?B?d3dvb0NrWjhFMUxlYmpWaDFhZVhjRXZiS1ZXRE1VYllnaU5CbXZUVGJveUdy?=
 =?utf-8?B?aWVrakdJaUNHRGhlT3Z0ZzQvV1ozT2pzR2lJSWNSZ29jVWZTR2tZWFBZdjZK?=
 =?utf-8?B?WUg3dTJDSkpKRk14T1oycHVpQ1ZFUXBPZkhtdjUxaC9tUDJsb3o5SW9vcXhS?=
 =?utf-8?B?M1BrMldQTkw4WS9rYXFQTUs2MUJXNG1lRHZXVHd5YnRQbk5RbndwZlZHZ2JU?=
 =?utf-8?B?WlI1ZUl4c2JjZ3ZWMHhVeGRzc1FXb3pERXBHcDJPbGw4YWhoRzRDZ0ZOMGsz?=
 =?utf-8?B?R20xS0NvQTQxR09PUFdEaDlQeEhaaE85bFN1SUJDbzVEVVM0K2V4aUtreXJD?=
 =?utf-8?B?U2hQRWtFVnZhMkVRYlAva2U3Q2pIRjFuaDlnRTFuV3JMRU9vcVBBTHhNODlI?=
 =?utf-8?B?Z3g4L0JiUTNabUhpRGlHb0tUY3ZDelVWUWJaUS9wbVlRL3JtbE56RjlNSlhC?=
 =?utf-8?B?Q3NNOGpiWVVSWkgxMUtzcjVsck9zUUZBNmozdUFDeVhibjhCT29sRHNjcVln?=
 =?utf-8?B?N0NrcHdyY1hsWFA0T3dyd3lqNkZXU3dncmt1K2E4cDNvV2doaHNrVkF4UjVY?=
 =?utf-8?B?SVhvbWdyMXNEN0p5WTNmaENlUitnTWdZUkxCckY0TDJOVGlzeE5hVkx4bDlM?=
 =?utf-8?B?L2V3cXNVSUp4M09IeUZxT0JkdDJpWlVwOEc2YlRnajdLU3pLTWF1cTM3Z2xx?=
 =?utf-8?B?dUsvTUc0KzR1WlBELzRsZVlqaDVwcEhCam43STZVWnZnUTREcnM4Qkc4UDFO?=
 =?utf-8?B?endNdkFrQzIzazBkbHZObG9Ock1aUDIvZExMekIwRzFBMi9IK3Ywc2J1Z2ps?=
 =?utf-8?Q?J4/c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3MwYjAwUjh0bnB5WURXRjBuenREa3ZrdWhLOHFGMTRwTFo4OW1FL2VyTjRC?=
 =?utf-8?B?OXozc2xVVW5zMkd1V2EwZ3JlVWRWMStoNklpUU1oY2xNd2RrUnQwYTE3U3ZJ?=
 =?utf-8?B?Vk56SFBUZy9icjdaaTdIcWh2UTR2Z2R6QWF3aDNnYUozVFpaeVVscWFGY2p2?=
 =?utf-8?B?T2pmWG9zN1V2N0M0MHVDc0lYOUNiSVR2VlNaS3lZV0FYbWhoQ0ZQZnhGT3hD?=
 =?utf-8?B?RENGMmZlbDRUVjhjN1Y5TEozMjJBd1FxZjA1cXhrbnZhYms1QkRnd1YzQ3BM?=
 =?utf-8?B?Z0piR1VvWTEvemdFbGFpZVIrRnRTRjAxMkpQOS84c3Z2TVlhb1FqNVNkNndP?=
 =?utf-8?B?WjBnN2J6QmVXaldPVDBOYVFzZ09ESUZKUGJ5ZFNJSlI0cFZVRW14YUtFQlJr?=
 =?utf-8?B?OEtrM3Q3d09NTldlY0RtbmlrWmhldCtDN09wMjZoWUFaQ0oyTGhsOGFQbTN3?=
 =?utf-8?B?WEcwU1QrQXlhSDJwNFc2dTlXV3dnV1hWdWsvYmVRaXBDa1FzT0pZRm8vNjBN?=
 =?utf-8?B?dmk2bVZRcENPS0NSVEJYZHBVRVlrT0xLaG9QTlZOcXNRQTZSVEhmWDJ4NHVP?=
 =?utf-8?B?MzcxQkhCUFh2Q3k3K01Qd3dFNUd4VmYvZ3FJMlJkQW53RENsaWdqcFRPRm5B?=
 =?utf-8?B?QkFuQ3doOFlXU0I0aFZwVTErUjZlNHhVYUg1SWhGb0tlRm1aUXRDZkI4cGwv?=
 =?utf-8?B?TnhpRHVDWXU0OVVmN2c0RTJScG1Zekl5UThNbTRGUWlNS090aG5vMVY2NElC?=
 =?utf-8?B?NUpLSVlQZ2VJejlPM0g3aWloRDZOMmRPL0dNSG12VzdtMmxYSG1ZcEllTUFR?=
 =?utf-8?B?OVVQSHdkTFByY3ZUOG9yY1krY3h3NlowSENlTEQ1Q3E1eU1rem1LQ2Y4VXBC?=
 =?utf-8?B?RkQ1VDFkTWN3dy85VmpLdVVZR3FoQWtSSXo0aTd3QkVwK0dYcHM0UVNCNkpG?=
 =?utf-8?B?RjhleGtCYXdpbU13TnRmYnc2YmFXS0hNYVh3NmFqd2FZN3lIV3Z0cVpPWjhw?=
 =?utf-8?B?djV3SHR3NFBsT294d1hzUW4yTVRaT04ybndsVW5tOWZZS3lCcVVoUXlIVTZI?=
 =?utf-8?B?a0o0cnlHZ0svbWZDSTI0Qm1jb1pucG1LUlVzaGdudUtKVEhyY1pIdXkvVktO?=
 =?utf-8?B?K252eERUTmQzbGQvcG9sZ0RKNXlWNmNTTUFSb3hDYUZEUzZkZ29wbzFlWVlR?=
 =?utf-8?B?bktkQk9OMHoza053bDBMMlFOS1pLbDBEdG1iUUQ1VFpOU0pzTndMOXY5cTdm?=
 =?utf-8?B?d3UzNkZYWDZjR1lXa3NBOWk0ZjVKaUVJOXZQWVppaE50NVZiWndwSUFQcVRs?=
 =?utf-8?B?TFZWbmNLejRZd2JEbTJWWTd5WW1PNnZJVVJZdGwvV0JaYmtvd2RjT2wybXFZ?=
 =?utf-8?B?MVZHU2F6QXNpQXFKWUt6aDhuMm9OV05zRHhKb2NqV3hJV2ZPVHcrazFsQmxz?=
 =?utf-8?B?b1padEcwbHdGK01EU2M1dndRcVZGZ0lhNXZETUhWcHBSWkwwNTJ6aG5oakVS?=
 =?utf-8?B?Sml5dm4xTXIrV2pKSE5sSFB4dHU5ZXlsbjE4Rk9LOHlSM1pieGZEKzRuZFpv?=
 =?utf-8?B?N0JtMWRDSHpLd3JrdUl5RjBKcTlVSkxTNlJ0c3lkN3VRaGhVc3c4UVIveG1n?=
 =?utf-8?B?VTlqVDJ1UHNpR1RmUjdvNytHWkx5QTBIMHdVcHpZclVrT01NRFM3TDRWR1pZ?=
 =?utf-8?B?ZlR3K0FJeVhqSTYzVzJPa1VjWjFwZWxFRHZTVFlWVmx3aGZWVHlOY0tkNWFj?=
 =?utf-8?B?dlFiUWpxMnIwbndoWUlTNG85NytqVVgvVXNNMEdkZDFxbGo5a1VSZGhhajlB?=
 =?utf-8?B?WXhFKzFSVkFaVjZpSFRPZThZWXo1WmxVWVdlTWZ1aCs2QXNWUGo5N0RTVWZ4?=
 =?utf-8?B?QmhsWFBJMnpyczZ4NWFnRWZCN3k2VXFsZFZTUGJyZkdMRnNmRHJJQW5RQWps?=
 =?utf-8?B?NzdsMDNTQXhoNWJzaEpuZ1dmemY2dVM5UUVFbUZGOVphVnd1TVhNR1RhVU9y?=
 =?utf-8?B?ZjF1VGJFeU5jY25EZDdSdHNIWVhRRTBpeVZCNzR2bkpQdFpwdHVLNHBaVzFP?=
 =?utf-8?B?Uk55REhSNE9lUDNNelYzaXJyS1lJRjU2ejdra0VtK3kvZ0RJWExYdkhyM0dX?=
 =?utf-8?B?emhITmhKcmp3bkJjcHJtRTA1WWlpNEVKd0JITW9CeUZIakl5RVJMcTNwT3dh?=
 =?utf-8?B?RGxDL3loUVNvRmxDb01pSTRYTDUzYkJINEhlS0tyZUJBV1lrZE0yQ3A0U1Vv?=
 =?utf-8?B?cHB4S0VpcmdmZWZ5MkxoVExRc3lVUXRCVVl5NXdFTFhIZ2syZWNBWmdFcjA3?=
 =?utf-8?B?clRrUS9URFRxUDF0S29JcjY5S0NaMzNVeHAxZWpmL2JOSFJleVlVQVpWMEh5?=
 =?utf-8?Q?7gl+WERmYtd17SArJGS1k05KbC4s6bAfa8DhX?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 223a8f14-e67a-43bf-6373-08de574b1f18
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:08:49.0611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7fYCiFrLo7hVIydAFfxbI2P4O5/V0Qz51NdGZ49jGaDuo2nWgzSi78siEFJoFhwG8IxGQ9CksxXYwov2oXX+ZpBONDrZ/BerJ5U3YjJpO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9518
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

Hi Peter,

On 1/19/26 10:54 AM, Peter Korsgaard wrote:
> It looks like the original zynqmp typo was copied to versal as well.  Fix
> both.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
