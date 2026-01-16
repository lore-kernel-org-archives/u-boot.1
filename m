Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA3D4A603
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 05:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F8480325;
	Fri, 16 Jan 2026 06:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="OACmduJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8F882BF2; Fri, 16 Jan 2026 06:43:40 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B90E80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 06:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.melin@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kortOvtbQnuJzDyVekvniO0sTrT4J0yyfASrvHfTAlo7ywHuW6X4PLeIivpqbFOmjuAHvPBCZH6lw0uER8sHdiqgkCY5CMn2Mt9kU33vtgprGgJ8Lf/9zkhf2Q4KZ++H6KepymcYgn6EFCY79KymnoJThIq89+rABDXzOXCHUSNJITIFcDBJ3oduNQUXsd0KVmp19KP4zf5vYypGYJWXMnz6nZoK8wi9njI5lwzkCvY/iVV465LRb/gyurjO3VIRLvCd72uVvNsTnMzOepJxc3kcNuoQyPw5WA3dkP6+jmWBryTpK3VvynlA3ItBLzZpQ0h1M60vQ9TXV3ZjBq/y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2wUiuZlCyQqdd3vv4O+e+ACKwucmH0PT7a+wYdM0mM=;
 b=hUrvMZPZFCWBwjFDW3HJlh44tSiFirxqoWBiay6NpJEpmhmkTAyL5TglID9nGl4DkJWjXvm1tVXSBFjgVFtJEl3FSfLAt5/NAM9IFGWurxfbgJvnxvaZqU2d9YpgQ3+eOs9F6zlCfzVEpFC1XcCuMfRGGBotDW1T76S6mxOaOivCKnzv3zrmLsYGrQx/wNmNP6KMDNV1zu/0Ufz0BqdjqGcqT9hfwKY8Mr/CYmWWSTCej7In6sY56onfboHUQhmsnVeK31Ga7fhzC/aHxH+Wk2iKZUj1Hgs2bl2txCB6r0/kMP1jmHp4lqkXGcUtBMkHEIM4c22pCQcoAH8rR3HVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2wUiuZlCyQqdd3vv4O+e+ACKwucmH0PT7a+wYdM0mM=;
 b=OACmduJDJRppntUTuX93mF8rjBt7hQDiu9P+zGneRrSPtXDJGSMw7F2VY33VPsLRaAgR8gb3780h+1gOLVqZ0yeH5ns6/u+NYZB/M6MruKQcbKy70QVxJMn9iwV/HNgUwSKtTmRIU8E8N8gXbmPBxHugwfAmq3vuTLbfaiUqoMWCGOP+F0RSwGKYiSBVVjy74IwikI5fBJ/p3GBH/n8inztAKPpyRflLdD2QQu2+LY2NE/buVDIgJeQlKKjeHdggpf/YAiRrxXbaRvO/xJvLJzCbi/SM2laIWWU5459IJsetaWMMi8mxUlNss4HZzEVlr6gFU8+NNNeuEK+GN6X0FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM9PR06MB7345.eurprd06.prod.outlook.com (2603:10a6:20b:2d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 05:43:35 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 05:43:34 +0000
Message-ID: <058a381f-4fc5-49b6-a999-67d67a54d571@vaisala.com>
Date: Fri, 16 Jan 2026 07:42:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rtc: zynqmp: Add clock framework support with
 calibration fallback
To: u-boot@lists.denx.de, Pranav Tilak <pranav.vinaytilak@amd.com>
References: <20260114112505.2851622-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
Cc: git@amd.com, Michal Simek <michal.simek@amd.com>, Padmarao.Begari@amd.com
In-Reply-To: <20260114112505.2851622-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::33) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM9PR06MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a958ad-4809-44a3-8220-08de54c23074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OElBUUF0L3JKOTZLNkZ3UnRWa1NlU205QUF6TXQvTnJhbml3ckVUeXNlK3JP?=
 =?utf-8?B?OE5HYzdvOHYvUC9OM0tSNHU3Q09zcnFmZzVFMUd5RkZib2JIWG1QbFVDMERt?=
 =?utf-8?B?eWZJN3NDaU5YNW43ZkpUYXcwZ3U5bFZicGxJeTFrd2hGbmJwUVFtVlprYXFZ?=
 =?utf-8?B?Q2pWeDVyVEFJbkRBRGJwQ0thNFNqRzJRanV4eEREZHE4WHhuUGJzNmxmOUdQ?=
 =?utf-8?B?N2U2aUtwak9jV3RJK3dadWFUcllTTm9pdFYwdjhwTFk4Z2Q3Wlpzdno1SnRp?=
 =?utf-8?B?N0svMVFXKzA5Sm94RUpJdFM3VnAwT2I4Tkl3c2xwNUZpOWhpL2NVTkZKNkR3?=
 =?utf-8?B?dXl1Mkk3NnMzTFFPTVVaT1Y3c3IwbWVtWm5wOGoxVEtzQmZQYjl4Q05zb0pU?=
 =?utf-8?B?ckpGNzlBaDVCR2NyaEhwTVlaTVlBV1REMEVmVjFaNEVtZTdTNEQ2amEwVHEw?=
 =?utf-8?B?a2NvQnc1REhlcFg4UFZhaFZsMDFvRmdrelB2OUMzU3VvVTA3bkMrSGxhWXdO?=
 =?utf-8?B?UlpCZHZXZ1VVMWJHS2FYcURVYXczUGYvc0FqZG5EMzJ1c1FEY2w5NE45ZTky?=
 =?utf-8?B?Sm02b0lEaVVRQnl3c05FZ1EydldOSHRsY2NpNURiNVh5UG5SakVBSk03dXla?=
 =?utf-8?B?RkcyZFQ4cDRJcVBsVjBjeXNscEdrVU9NNlR6bmpoMXJhUHM5VjdFWVlPY29K?=
 =?utf-8?B?dXNEamxZc3doc0hHamFQaHE2YWU4aG9WbWc2TDBTZThIRy9XUWRHbVJ1cFdV?=
 =?utf-8?B?eUJwSG1PNDFJVGh1SFp3bUdsVG1ySXd6MUJmWVB1eE1IUm5MWHlRZEc3RGhH?=
 =?utf-8?B?LzUzNitEdmltQlNhNVg4aVYrejUyaWRYMlppTDFYNjdLeXdJYWw0c2FuOU9i?=
 =?utf-8?B?YWl5NTFQelRmMXE1c2h3SFgrM2Y1SS9jaWlZL3poWWplY0lLUVp5ckJXdmpE?=
 =?utf-8?B?bzNoUTdyTklCZHVGREZQSDBmY1RjRjRTbWNzbm5aSzNWNzA1Mm4xSkdsdEZE?=
 =?utf-8?B?Z2RkdlhBakRtdEFhS1VYNUdlMWxvOUNtNFhSY0FId3BwVHRndWVldXl2S3Yy?=
 =?utf-8?B?SHErYndKL0QyUGZGY1FFVjRTTnNnU2N5SUh6djVtdHZJUkhlSUk4UmJSOGlY?=
 =?utf-8?B?Z3FuTXNwNy92WXorMDR6Nlo1TC9Kc2hPY2gwTDRDU1pwckRvb0xnSzhmSW9O?=
 =?utf-8?B?ditMSS85MTV5V2ZiQ05WYWFoWFF6UUgwRFAwbmhhZTZYUTBxc294SHlwdjRj?=
 =?utf-8?B?eGkzWHNkbEU0eDJyOHdZcTllMEtZb3l2cWZXQXBIYjA3WVlRSDBTQVFycXk5?=
 =?utf-8?B?QkxOdDBYU3pNZUh1T0FHNS9FUGMzcUplZUNDSlR1OWxqUlpvbUpwUjk1R2g4?=
 =?utf-8?B?amsxUy9SN3YxTlIzS0FvbE1PQmN3MzRvMEdqVXFQYmVsVFpkbWFKMGdSUWdO?=
 =?utf-8?B?ejA4bllydEtUemREa0VmWlZYZ1UrQVl4TnFRazZwL3Q2eCtyYWd4YXhOUVVZ?=
 =?utf-8?B?U2lHOTBzUy9FZ25ZSytQNDJUNGlpOVZrVlR1S0MraTVEOEhlN3oweDBlTDlk?=
 =?utf-8?B?SVlBQml0Y2p0akpldU04ZUlTaHExbERnK2FxR010a3h4NHVBNnNJV3F1aWJi?=
 =?utf-8?B?WjVTWjdzTlM1NEpuUFpPNExnWWlseFFaSFpKKzVHb3Fic0N1c3luZXdTejZN?=
 =?utf-8?B?bWxURDRDKzZHQmRWM2QxaFVUQmhBZlExWXNydW1xUWY2a201aHB0SlZ4VjdQ?=
 =?utf-8?B?SDVmRFFuQ0lhNzd1SjFjNlBuUFNGMVMreG9aMUlwNE1BajlMUWE0blg1aDcz?=
 =?utf-8?B?WXFhY3R2WW5lV0dRYU5WeWN6VHdmMjBSanJiL3pSN1NObzRXdXhZcFNMdVpK?=
 =?utf-8?B?dERBWnBNQjJ1Vnc1Sno3bHhZT2x1R1FDVGJONFFnSGc0ajlpYjc5djZTZElw?=
 =?utf-8?B?SCtyVm5VcVRVYUhJNDZNK3loSmRpdWR5QnpiT01JUTUra24zMG1KdXQ0YUFs?=
 =?utf-8?B?SjdXWTJldE5Sb3J2T1E0K1ZsMFp2QlJ2RlZScjJMRzZXbkF2ZTVGaVpkY1cx?=
 =?utf-8?B?M29SLy9lc2gvZmh0RHM1VGpmY3FWa1ZJajc5Qm9KVnZ0TlJRekZNNWtQbDRi?=
 =?utf-8?Q?KsmI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR06MB10365.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZhaUZUNVJSbUNwMXcvSFVZakpuamNML3NGK1ZleGUrWDJ2S3c2bEdoZC9l?=
 =?utf-8?B?R1FSQ2FXdXR1SWlVOUdLc285aHM4NVlRRW55QkhYenZHajJDeVFtL0pTSWd5?=
 =?utf-8?B?MEZxUDFITmVGU0d6N1BxaCtYU3dBMlk0S0NLWHhJc2FpRlB1NkhPVUNocU9D?=
 =?utf-8?B?TUVVMXQ1a0dEbVZCUndjaDE2dEVId2J3REdBbWZ0TlJtaUhPc3dCUlFhMm5v?=
 =?utf-8?B?Wk5oSHFaY1pXNlJSbVRldVdGbW5WcE8xTktwYzdrbFRRVkd6aEJURGpTMTM5?=
 =?utf-8?B?Y3pJRm1ETC8razUxSzJnRFpkcnBKYTlBK2FTYU5zcW1xcjNjTlRIUXpJNW1a?=
 =?utf-8?B?YVEzZDFqeEZOOFNzT09UV2pNUjZZUFJmMThJTENVYnpUL3RMQWtaR0ZsRHZH?=
 =?utf-8?B?NnZIdVJrSmNyU0gxZFk5NzdOR056b2VGR1VvekF5T2JyRlBqQzB3eTYxRngy?=
 =?utf-8?B?MklzMGVXV0l5ak80YW5YRFBwVm9QQ2FyWmxvQmNWeS9uQnFHbWlTdWpTSFFK?=
 =?utf-8?B?UVpnaTAzTTNtSG5xeHEzWTM5bjh0Q3EzOS9DZ1kzR1RtS0crNWRPOHphZHQy?=
 =?utf-8?B?UEM1MDZOUGJBcjdtVU9RS3NmNjFrWUY0UHpUbnZpaFM0eUpkazdlaTRYSUVp?=
 =?utf-8?B?d2RabittZlRCWEhNME1tN2NnTU9qaUh4dWhOL2wvczF4YldJV0pPRDJoYzg4?=
 =?utf-8?B?VlJqdjJNV1BlOFJOOUE3QndweFNCUHpmZ1pGRVZDSW03eEtPTlhhQVU0QkJF?=
 =?utf-8?B?N3lQQ1BTSkUyakIvMVlKMnErcjY0WkxxSkFhbDEvNWxHZ3RPOXEwdysvNjZE?=
 =?utf-8?B?OFgvRjFpd0l0RkNHeEErTngzUm1rQTVsTWpUaVpwYnJJYVhaZ1BFdGhieGYw?=
 =?utf-8?B?R01LMW4vYmFXY212M2dNTEkzS1JnVUZURkxlV2pTQ3hXVjR1ZFA1WFBIL2ZP?=
 =?utf-8?B?WEpEcXlaaENyd3dLTjhvdGNIS3JGNUZxcmptdGFVSmM1YVY1aXlQZHdkdkNI?=
 =?utf-8?B?b3ZiVXBhR0ZQemtuOTVCS1U0Qnl6WU5GTjAwVWVPZXFvSnZIakVPWlBGTGho?=
 =?utf-8?B?ZTJCWDFOSEFQTEM1M3FkN3BHY3JQSkY4aG4zVmZoSUMwZXlWVXFIYTNLSVl3?=
 =?utf-8?B?QVUxV2tMS1h3Z0lZYnlFbFcvOC9iam9kaEdDalVEa1NLbFU5MlNLTU5oR3Fi?=
 =?utf-8?B?QktkaWRERi83eFliNXFXYUpiRFMwUGJ3QU9CNGVFVDhra2hScjk2eEd5eDRr?=
 =?utf-8?B?NFAxWXRWa0Q0dTZsakpselh4YkM2SDJ3dEZIdnNoQVhtR25PMlNCemtQMkt3?=
 =?utf-8?B?amp0RXJyVXd2T0xaaUxOeHpsdWpvVkxTVHpDRDAvM2l4c09EY2RUa2gzeGdP?=
 =?utf-8?B?c0dEVFRBcHhHZ2g3MGlCaFpndnJQM3k3NDFqWjY3Qitma091S1p5QXVlU0N5?=
 =?utf-8?B?Ym9YRWFFcXhOZDdJbXh2a1lSemQzRERyRHFRMHpoVTlmaGNyc2c1Z0lFRlpE?=
 =?utf-8?B?NXB2Y3JnczV1blE5L1hVUVo3K1ptQkNmdWZLYnlqdVYzRkJKQmRhbnlRUjVl?=
 =?utf-8?B?cmpNSW5zMWFMeXVhYTlzYU93eG40UktUazB1VlRsdVplYjdvSzRpbVFpQUs5?=
 =?utf-8?B?WnNuRDJHTkpxMlpLNmVJWWd2NGFnUFVWaVRaRzlFM3JBZ05LNFB1Y3IxKzFv?=
 =?utf-8?B?cmo2a3RqUXNZc0FJV0ROU0R0SkxLS0NKc1AyYVZ4RkFBeWFydFJlR1ZlQS9j?=
 =?utf-8?B?ZmdTeGhBMkxHNUlTeVYycEJRSzk3YW5mWTBTUmJqQk1PZXZXdUxKWDdBcWpL?=
 =?utf-8?B?YjBvV0NyM3lqTGNhQ2tjTGprY3QzYmpOaTZDd0k3OFNRVVJCR2kvVHZITFZC?=
 =?utf-8?B?UTR2WTBsQnc3QW04QWJodTNwd1BLUkJTNEZtU0NzQThXaGNFZkhMT0ZJYzl3?=
 =?utf-8?B?RXJpS2tvRmsyRTlWLy81eDR3ZHdxaFNJLzRtdFZLRHpEOXl2NkJ2ZFlPZ21E?=
 =?utf-8?B?eEk3b0JmekVqU0dPM0tvdnpnZFBsYjFoMVhhc3VVVDA2VlhYRlpESlBha2o4?=
 =?utf-8?B?VnQ3WHVoRUxRNHBySHNIWWN2NjhXck4wS056dndHSEtUQnFzUVIxZHAwK1BD?=
 =?utf-8?B?Yk5oWHFCSFJ3K2JBdVlmREdVMDdIQ3FkNHBWcCtLSm1ubXliUGhjUGxvN21S?=
 =?utf-8?B?RlVRRm5Bc2hHOWhVUlRHV3lXWTRxdnpZNWl3VnZIaDdrK1BCaW16ZUgzdmNC?=
 =?utf-8?B?VnlYcy9jSkpKQ1dvTmYrbHVNR1U2TXlSb0J0WFgzY3VrbTVOYWNITXExNGZC?=
 =?utf-8?B?R2lMVFhOUWhXRW9kT3g5SjNOS2xkOEYxdkEreWVSQTVGc1JRdmh4ZkdqVU5m?=
 =?utf-8?Q?15gDwQ8ub+jspXg8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a958ad-4809-44a3-8220-08de54c23074
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 05:43:34.7666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGUuhel5eEUOwP3k0myjmuDpZdt+J2mXL4PIIhuU+HeKNNn+qkuCPuEutcY8lfDYHbMDJRWzrA4ZD2hhSsTHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7345
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

Hi,


On 14/01/2026 13:25, Pranav Tilak wrote:
> [Some people who received this message don't often get email from pranav.vinaytilak@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add support for reading RTC clock from device tree using clock
> framework also update the default calibration value to 0x7FFF
> as per RTC specifications.
> Falls back to 'calibration' property if clock unavailable, and uses
> default calibration if neither is present. Only writes calibration when
> hardware register reads zero.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
> Changes in v2:
> - Rename variable from clk_freq to calibval
> - Handle case where clock node exists but has no clock-frequency
>   property
> - Treat invalid clock frequency as error instead of warning
> - Move calibration validation outside if-else to apply to all code paths
> 
>  drivers/rtc/zynqmp_rtc.c | 64 +++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
> index 15122a04838..938da4c0569 100644
> --- a/drivers/rtc/zynqmp_rtc.c
> +++ b/drivers/rtc/zynqmp_rtc.c
> @@ -8,23 +8,27 @@
>  #include <dm.h>
>  #include <rtc.h>
>  #include <asm/io.h>
> +#include <clk.h>
> +#include <dm/device_compat.h>
Please keep include statements alpanumerically sorted.

> 
>  /* RTC Registers */
>  #define RTC_SET_TM_WR          0x00
>  #define RTC_SET_TM_RD          0x04
>  #define RTC_CALIB_WR           0x08
> +#define RTC_CALIB_RD           0x0C
>  #define RTC_CUR_TM             0x10
>  #define RTC_INT_STS            0x20
>  #define RTC_CTRL               0x40
> 
>  #define RTC_INT_SEC            BIT(0)
>  #define RTC_BATT_EN            BIT(31)
> -#define RTC_CALIB_DEF          0x198233
> +#define RTC_CALIB_DEF          0x7FFF
> +#define RTC_FREQ_MAX           0x10000
>  #define RTC_CALIB_MASK         0x1FFFFF
> 
>  struct zynqmp_rtc_priv {
>         fdt_addr_t      base;
> -       unsigned int    calibval;
> +       unsigned long   calibval;
>  };
> 
>  static int zynqmp_rtc_get(struct udevice *dev, struct rtc_time *tm)
> @@ -70,13 +74,6 @@ static int zynqmp_rtc_set(struct udevice *dev, const struct rtc_time *tm)
>                  */
>                 new_time = rtc_mktime(tm) + 1;
> 
> -       /*
> -        * Writing into calibration register will clear the Tick Counter and
> -        * force the next second to be signaled exactly in 1 second period
> -        */
> -       priv->calibval &= RTC_CALIB_MASK;
> -       writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
Is this change directly related to adding clock framework support or
should it be split to separate patch? Atleast needs mention in commit
message why this change is done, looking at the comment it looks like it
has handled special case.

Thanks,
Tomas

>         writel(new_time, priv->base + RTC_SET_TM_WR);
> 
>         /*
> @@ -107,15 +104,6 @@ static int zynqmp_rtc_init(struct udevice *dev)
>         rtc_ctrl |= RTC_BATT_EN;
>         writel(rtc_ctrl, priv->base + RTC_CTRL);
> 
> -       /*
> -        * Based on crystal freq of 33.330 KHz
> -        * set the seconds counter and enable, set fractions counter
> -        * to default value suggested as per design spec
> -        * to correct RTC delay in frequency over period of time.
> -        */
> -       priv->calibval &= RTC_CALIB_MASK;
> -       writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>         return 0;
>  }
> 
> @@ -128,8 +116,44 @@ static int zynqmp_rtc_probe(struct udevice *dev)
>         if (priv->base == FDT_ADDR_T_NONE)
>                 return -EINVAL;
> 
> -       priv->calibval = dev_read_u32_default(dev, "calibration",
> -                                             RTC_CALIB_DEF);
> +       ret = readl(priv->base + RTC_CALIB_RD);
> +       if (!ret) {
> +               struct clk rtc_clk;
> +               unsigned long clk_rate;
> +
> +               /* Get the RTC clock rate */
> +               ret = clk_get_by_name_optional(dev, "rtc", &rtc_clk);
> +               if (!ret) {
> +                       clk_rate = clk_get_rate(&rtc_clk);
> +                       /* Use clock frequency if valid, fallback to calibration value */
> +                       if (clk_rate > 0 && clk_rate <= RTC_FREQ_MAX) {
> +                               /* Valid clock frequency */
> +                               priv->calibval = clk_rate - 1;
> +                       } else if (clk_rate == 0) {
> +                               priv->calibval = dev_read_u32_default(dev, "calibration",
> +                                                                     RTC_CALIB_DEF);
> +                       } else {
> +                               dev_err(dev, "Invalid clock frequency 0x%lx\n",
> +                                       clk_rate);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       /* Clock framework unavailable, use DT calibration */
> +                       priv->calibval = dev_read_u32_default(dev, "calibration",
> +                                                             RTC_CALIB_DEF);
> +               }
> +
> +               /* Validate final calibration value */
> +               if (priv->calibval > RTC_FREQ_MAX) {
> +                       dev_err(dev, "Invalid calibration 0x%lx\n",
> +                               priv->calibval);
> +                       return -EINVAL;
> +               }
> +
> +               writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> +       } else {
> +               priv->calibval = ret & RTC_CALIB_MASK;
> +       }
> 
>         ret = zynqmp_rtc_init(dev);
> 
> --
> 2.34.1
> 

