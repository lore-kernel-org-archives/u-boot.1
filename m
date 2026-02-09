Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAE9EF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19C583D8B;
	Mon,  9 Feb 2026 02:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RANPxASD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F200805D7; Mon,  9 Feb 2026 02:29:16 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC7B83D17
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvieYwC5M8hJfnqfRzgw/PfFnfGmVMt+bsvgQ6tC2K5UNgOe8cIAzzmQ3r9CqV5XlicssqFIOzKb3PkF5ttxwBeJHHXzTuEaSMQV8GLbTftP2+M9EftyCpruTfBzgWYHmrm6pZ9TChF7qenUlu5JUCj20mJSCJUGMdYNtHm7RGiWWhjyu1RISVO8B0FJJ6mTBrwxtj5CGGBdp+Zt372nTjNOQP+A62mCNxGLH3IDAzMryBqzTX/2vP2xI6MyJlM2kuSihN1+zmMCxCIl/h4mRoeKEI9QhHJjWFjOPNjwx7Sqm0kdrwApdYlc/Scvnz5Oxho8q7DzjPV7h2eYkvzB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl+Uj1K48vUj4yxZKuP6zOWmIwhFmSeOCZJI8Wb8I3M=;
 b=nXPa4K/FfamtzlMnkt+uat1Ex1gHPDUTBI+ifB1h5A0Hzpp6+e1cyQCo2P5TwgyzXiFwh5lId8jHouUbQWYqAmip3flGlt/9xDztdRlAq8NTswaU5DrkBrmT6YZo3UQkKEa1q6T3WWV50m2t4T46ALBUTkHgTbBc1hru0U43+9PWhHZQOG5Daa5ngWDyNE+KqmqLPZEeFYzOK7qi9LDxA7RDGul0ogUBxwwGIXKVdGkZbG+X8Xsa1DBb5qnTePORigg/5IQKiboem6u2H8hzPIJELt40CFKBqJUQ6fDRGr9TgPZvQ49nurBGqUemhwwHp0wquiguji1cjt3QV2oDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl+Uj1K48vUj4yxZKuP6zOWmIwhFmSeOCZJI8Wb8I3M=;
 b=RANPxASDrxGgUplrAGoGskUAgTL/E1MEXUy5eeeYfJLP4/23/8kCrEUVl+8pwvKN2eLBlZ9Sg2DN6gKH2xT6ZwA9OXsscmNdqksdAWHPCfMxMWwKoWK3sgl6xYaQi1Ql7usmKsNsrwVw8M547JgGIW68Tm4wgyF85ASF9xjKXFU2O1FPvGtfBfK5pZLhr/4aNF4u6uyLJIug4mzPkhjeTIxGgBSVVOsXf8/AAp9/Mg3i8u7oklThoiSqef4fQwugEHnnWSDKIWMKrDqAqrI6OhMkOuC+mCDEmFYG6eMBMntu/bvZEH7hxlVxYPkSK52YFhCCMvPJveLKTlGTjRHyKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 01:29:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:15 +0800
Subject: [PATCH v2 11/14] pci: layerspace: Add missing header files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-11-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf75da6-9162-499d-b86c-08de677aa193
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0tOelJqR3F2SlZpSlZEWFg4Y09sQnZ0VFhxQVRhTlI3OTJ3bGVQbU1xQjB3?=
 =?utf-8?B?UnBUOW1HV2lud0RFZ3lwV1VGT0tOOFFvTnAyUnQ5WG9CRHF5OUlLc1FsU2xy?=
 =?utf-8?B?RHIvc24zU2RESHNEQ3M5eU9sUWxIVCs3T1FwVkRsZjVmS01jQ0hFYkhlVUQ0?=
 =?utf-8?B?RnBVY0hDUW95aUtnWVQ5c3B1R081MGJOMGpTWUJIb0tidWo2ZVF2WkxkQ25R?=
 =?utf-8?B?MTJXZGs3TzYzTUxwYXBmSE5LMktDaWxPVnNuZUtNaWtOeHZJc1V2RHI4aFpD?=
 =?utf-8?B?Vk5JdksxOFFLL2cwN0tlaHNqR2hySGJXbzFnTmsyYWpQb2FIRDgzUFV1eWVj?=
 =?utf-8?B?ZFRCWHZBa2hVcC9mRmZYcE9vbW1qc05SUHplN0VveWZYVUhyUDRPRU5uUXZq?=
 =?utf-8?B?M1VIblVuOEw0Wi81U3U4T1phUWpnODlJYit0Y2xJUUQ5TnJGU1hQZWNWbkJT?=
 =?utf-8?B?WHlyT0ZTZGRmY0U0UWFidG9NRWRrVEE2SG1seFFWeTVZVEpoM2JRa3JzTjNF?=
 =?utf-8?B?d0U4Rks2ZXplcDJDcGk0b1ZTbEUxOWRsUkwxcnRIOVRva1Niall2R1FkL2Vw?=
 =?utf-8?B?T0ZCNFprSkJJMmxHWkJ5MktYTnByWTJ0RkRjNGRRajlHWmdZZHJKZ2tSOGxI?=
 =?utf-8?B?T090a2xqaG45c3ZKeUVuRlR5VFRkRTN1NFZsMFZuVXNvSjgwQUowUEZDWTJ1?=
 =?utf-8?B?VUlWbVdhUDFwWjV1cGhkakdZMmxMVGdlNnRpNUNzakVlemxjQzFnS25uODlH?=
 =?utf-8?B?MDd6ZjIzcGJ4Q3RIeVZhSFR6MVNhMWpkanYxZy8wNk1uclJQWnI3bzhQSDE5?=
 =?utf-8?B?Y3dxbGFXVzRVSklCSmRlMTZFb0UySDRUSHAvdjZHcGNuWDNqTGVMSzZTUk1a?=
 =?utf-8?B?cFpZTG93M2JSRVU0Rk0ySUhiUzFETnAvd0tWaExNQXhPYXdUNUtxR29TUWJZ?=
 =?utf-8?B?VWErSllMcFdWUThGVW54QUEzaFJ0ampkcE41Uit6d3ZZM3dJSE1PLzlGdEo1?=
 =?utf-8?B?NUVqWTBhQ1FHZTlMTkRtQSthb3hNVDBZZ1JOaThmbWRDZ1NsamlwS0NFUUFU?=
 =?utf-8?B?SjgxdFhtaTF3QW5IV2xraThOTG9RdVZXcHdFRlVKZ0JpRG5sVXVGeXErOU9G?=
 =?utf-8?B?V3Jibk9XUEdMdlpqUlIySTNFV2FvV3NvUnRBcjh6Sytiby9uSVZsd3RKK3RQ?=
 =?utf-8?B?MmZBWjlVT3UrTmV6NjhMd2Q3VmxNbmhRSG5wTlNMMTU0cGFPNTM2WmtGbktS?=
 =?utf-8?B?MGU0bFh3Uno5d1pDWVdlTEZyTFpGdDhZTUVsdVZrV3phTXFHNHRpS3hvN0FD?=
 =?utf-8?B?TVVtY1NBdTRETHd6bDJqMmhqb1Q0RWZaMk1sbnEvUGpIRVNtSUlJc2o0ZCty?=
 =?utf-8?B?Nm9rWi9RQ1Fkc21YSGJuellMeTM5MFRQWjdDMHRRU1EzYlJKM2xSSzM1MlhQ?=
 =?utf-8?B?RG9zeGVrUkxnY1hxY0FrWlE1REFkK0ZmaXZGSkhoYnByczc1ckE0MXNvRGp0?=
 =?utf-8?B?M2pCT0RZd2lzMDNBUWJtem01aUFqa2xkbFZvSHc2L1F0cExVSzBOVUdFMFZG?=
 =?utf-8?B?ZE5Wd3U2RE02eEhFQXVvd0dGNFI0bnRqRGkwZytLMEdySHo1amd4cExWcjE0?=
 =?utf-8?B?L05Xa0txS25LNDliZjdmbXVzZ3I5UlBQN3FkSy93b3BQNE05VTJiSXlKWnJp?=
 =?utf-8?B?aE5SNS9jeU4yT2Nob2M3N005VTI2UW1NNm9iNEhzNTNMVkFJRjd1WWdSNHlx?=
 =?utf-8?B?YmtTTDc2YnhhdFVCVTVjcENmQmVlTDNKWmNnVlh0M2RmTlVBbFR1N1hKR3pu?=
 =?utf-8?B?c3liN0tueVFxV3FVdjVLQ0lPUjNlalFROFUxTzhWQThVQTVUN1dpOW1qZEFM?=
 =?utf-8?B?YUNpcnp5S1FjZTZ3R2N4SzlIL3dhWE00K3JmcXFuU3RrRUZJbWRvVFdEZHRh?=
 =?utf-8?B?Q08rcmpRaEwvQVphZ1pCSFc3MjhEY080WkdZOUtKalNzVmMyUkxZQzFCa1Zv?=
 =?utf-8?B?M0h5clpEejJzV2F5Y2cycUtQenpvQnFyOC9rQ2xWUkRoN3pYd2RMSVNPcW1k?=
 =?utf-8?B?N0duZ0NSeFU3NjZLS1djS3c0YTJLRkI1QUxoblFMbGZITzMxeWRkT2duSVlJ?=
 =?utf-8?B?KzdsRDhQaHNoZnFjZE41dXV5OEFQc3FNR0dRYVBJMHlDc01INEdYNUN1a05s?=
 =?utf-8?Q?UipPl4zYY48kddDg9JzDKC4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3IvUVZXTzE5QktBMDkwNlQwLy9HUm1teWJLQVRvM0s0MUFUM1RJSXR3QXQz?=
 =?utf-8?B?OFc3Y0p4UWJoSWQvbnlIWjA1bmQvK28vMnkyVUQxZUdHWVJncVVBTnVJcXdt?=
 =?utf-8?B?ejkzeENHV0Vub2NUODJya2pCbEVUM3hLaHdHdTZUUkZpWG5vbzhDSm5ybDBw?=
 =?utf-8?B?VTU5M2FkeVF4SmJXc3dxR2J6UjVHUGZWblBCbnB2NWJ1c05ycmdvZjY5QW10?=
 =?utf-8?B?dk1HajNmSHFqM0poTHhjRXRQOWJsc1JaL0phZnVENzJ1U2tEa240S0N4eEtK?=
 =?utf-8?B?dmQ3QjlFWFhFb2N6T2piWkgrSUswMDJQYTBVbDBVRlZRMkdveUxQd0hzSmxN?=
 =?utf-8?B?eERpeWdNWjA1aWV3U2wyZVBpckdVVHFSbk9IOXAzalRjTFFqOHFIcS8reXZo?=
 =?utf-8?B?WlJPS2xCcTRiZEh6bm5IclNVMTRaWXAxWFlwbDF0TWNKZVVSTCtmVXZrd2lU?=
 =?utf-8?B?ZjFVbGtCMWNEU1l2R1RWWEdxSS9GSnRpaWVyTUVXSkk1dnR1Vi9nSGZad3h5?=
 =?utf-8?B?S1luWU13UFhnWmlmSzhaMHlTaEU3UXlEdzdseHVZYWJoemVqSjFvZ0dFb1Br?=
 =?utf-8?B?c3FrVzFYTjBCVU5PdjB3eFRCdXZ2NnhqSkVQZERJYWY5TmtXZjZmMTBoWllY?=
 =?utf-8?B?cEFtcHJJcHZOZC9tOUVGMmRWdHdEUjZOS01rVEtkSitDdXRNRzlXQWgyZ3Z4?=
 =?utf-8?B?eVFaM25OL0g5ZGh5djdvOStQbzFYR1h5WHBJT0U0d0VNSHRhTUNOR3hBZGds?=
 =?utf-8?B?NjN3UEluQkV4OW8vZ3NZSFZiVFJvVzJZanY0YmhQdTc4YnptUi9URVU0UkRw?=
 =?utf-8?B?TDVpbStFYnZtZld2NVRtT2pqMnpEb0p4TWZoVUZmN2VWOTIrSXlRTktOVmcx?=
 =?utf-8?B?bEt5YXFtSG54VzVMa2tZb3RPYXB2NTRVbW91SnRKZUJvczh2NGx1MVliOE9r?=
 =?utf-8?B?Rit0alBzaHF3M05oSFRNemcxaS91WW5rMUw1ektWc1prZXIrY0l0eDlNMXJT?=
 =?utf-8?B?SGdheFBOVmZpc3YvdlRLRXp2THlYdmtHd1pwdzZiNU9YSGFLL1RTblAxOXVK?=
 =?utf-8?B?OWdxR2drMVd0blFYWlBJUklYNlpUNitQUHh6dnVlWHBKc3F0Q01vcy9NcjNk?=
 =?utf-8?B?S0p2M1FEQUg3TTBESHpSQW5xcC9SM3I0eG5jTFZhRHJGc2IyZDRLcWlnaUJM?=
 =?utf-8?B?bFdUWVYwakZnZ205ckFDbnVSVEkzVlpVMkczNFhWeG5VR2JSY1BkSzN1MlR3?=
 =?utf-8?B?aGtnd2UwcUpnQ2RXNE5QZVlEbklTcUxnTlA3RlRaTHFoRnRmdWcrOXlRTGZU?=
 =?utf-8?B?OUdCQkdEaXVEb0ZFSmg4SVdFd1cyMkhkYi85czBvU2dNRXkyYWFHR3dZdDNo?=
 =?utf-8?B?ME9Ca1ZucVpTSVRNWUxXcHdxWEdvOW9Ha1NwajhyTGM0UC90cG5TRkcvMUl4?=
 =?utf-8?B?dHJvMVBMSkdhU0JuNWFadllqU0psc0dOZU1FU0RMYVFybU9zRWF0MmVuRDVw?=
 =?utf-8?B?VGJlSU85d2J1Q0hnUEluazlHaXc4SXovTnhlRHAwWFVoNnBZd1V6Q0c2ZHEw?=
 =?utf-8?B?SlQyL1pHRUxHY1FLUTRNdkF4ZGpVaHE3c1UwbUpyMmhyZjVINTBGYjFaRnAy?=
 =?utf-8?B?TW1VYUVwNVZySlVYWktMWG9CcHVCTGFNS2NkczBnQmNlRW1JQTJyaERQQXpZ?=
 =?utf-8?B?allsNktwTmlPczlrVGV6MEN2L0g2VWl4QW4zdjJmOG92Mmw3WC9keEQwT2R0?=
 =?utf-8?B?R25TMVBxbzJ3aFNHRjV0QTRuS2JPMmQyVk9iLzlueUVHcC9xTk9FTGZZU1lC?=
 =?utf-8?B?SUdkcVJxcHNiSnhvOUlpSVVrZXYvd1NEait0N2VXdWNyUGV2S1U2em80cGx4?=
 =?utf-8?B?Q1kxVXE1QUI0YVN0cW5ZQU1uVkY3SHdqemdyN2YvYVYzRzB4ajJIcFVGbjdM?=
 =?utf-8?B?L3hMdDcxOVJueDNTZGZwU1pSaCttdkc2U3Z5VmJ2Zkl2VU5lL0UxdHA2S2hU?=
 =?utf-8?B?UlFwcHVsU3NoYXE2RCt6ZlNqdWZkTVVnUjlNcThSWTdXbVV5eldxTXoyUnFZ?=
 =?utf-8?B?dU5rczhGT25sYjlqeWllSWlkL2Rua3NTeHNpRnJvdjVwNTFTall6eG5XSG4y?=
 =?utf-8?B?eDFxN1owTXRiY3IwcEZOVWFtM0Q1T1ZCQTlvaW91ODRibHFmZi8vUzZIQ1Za?=
 =?utf-8?B?L2FQWlh5aXMyTVh3SmJyd25mdFFsVXZmSytmOGhOM2ZNRTdUcE1iM2lHS3ZD?=
 =?utf-8?B?OUYweFdjWHlUL2sxUlpKWkQwMnlYaXhOVUpTRWNRaVcwT0hWT2dMSFVFS05T?=
 =?utf-8?B?d3Z3dXNKNGtUM2w5N1lkY05oNTFQYkQraXJBb1FUeDdLc0lxeXl6UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf75da6-9162-499d-b86c-08de677aa193
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:12.8898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwQLeVs7bVgItuZ58WtZ5YhzvgqFL5Uz308AUaQBKjspUn382tct9wOyiQxiKhNzKHg/Q8irT+MgZ0GsyLYlzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
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

From: Peng Fan <peng.fan@nxp.com>

struct fdt_resource, u32 and bool types are used in this header, add
missing header files following "include what you use".

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pcie_layerscape.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie_layerscape.h b/drivers/pci/pcie_layerscape.h
index b7f692f645070ad594585dd177df9c66a55e80d2..d5f4930e1813bd570a6d5106c11f2ceaa74bac2f 100644
--- a/drivers/pci/pcie_layerscape.h
+++ b/drivers/pci/pcie_layerscape.h
@@ -7,9 +7,11 @@
 
 #ifndef _PCIE_LAYERSCAPE_H_
 #define _PCIE_LAYERSCAPE_H_
-#include <pci.h>
 
+#include <fdtdec.h>
+#include <pci.h>
 #include <linux/sizes.h>
+#include <linux/types.h>
 #include <asm/arch-fsl-layerscape/svr.h>
 #include <asm/arch-ls102xa/svr.h>
 

-- 
2.37.1

