Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668ADD38FF2
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 17:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EB6803F5;
	Wed, 14 Jan 2026 18:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="a7jZ+DVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01108063E; Wed, 14 Jan 2026 18:30:04 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D525B80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 18:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwMno6gPRbyN6n52QSbkMnt+BWPAhV6Dy/PO3Rk1ib64BET6d2UkAfp4lRyZOmyccx4+ZnKz1fyLBhd1LAp+C1T/5KhSlHDUiCS1MwsapdB5iZ+L1BKxFWCYq+I+yX68U/JEL1OuQfyLUkWmV2/imUEaVrEmXeIZojGC6ArpZM0+ulKSbflq663FdI0uvoFMeAfOUUjwZHCeDf85IASHaVUHuVXEDF2x6BVrOo/PnBSezRdQ3pHvlOxBXBEpsicLwjuZgOIhabMyEiaw9mgCXrJJM77lSJ3pHFzdYiGR4EhXxxkGKBYcIaoyT+ZN+XUacDUTHB4qNg15F3/xwpHWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdQwPdEWCR7o+I8O9OjBpDPnmEPKxTfNI2ONiUXP76k=;
 b=KOtxew5er1Dt+fILe0m/nYP4SKYgokoX0VQRlDeYEdQSY2OiTiZ02jWhBlGQMLyquDB4vhHDGNmNSonl6rS4ghRE1kRM8YziDLKOeTgDffVWDEZb34EtpXd/2yYZlY0y8cxA32tpLcNfG52vVcqXEf+F9wMz0jIoB6rprWnzwt4Tig1IvFWNqSsHq7lyfBUdn2jX7D6GVS5ynRYvaB8caTHFwrybFJonnhRnF0yyWiU+onDbYUwsqrEmvdLzyB4ZoAoRGSeRhY9lwaFf6D+N1QRbQaSmlJt5CcqAyznGo/O68U8AFInS0+YMYof5rkrs1x8qEUy/L5rQ27GfB58alA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdQwPdEWCR7o+I8O9OjBpDPnmEPKxTfNI2ONiUXP76k=;
 b=a7jZ+DVvhiswmtsEhHr+xSxaYqtEHNcrf2lAt7YL09nvRV67qx4k9XuqjIgoFT7S0Sc0IdyTVGSfgDA6Cpuy5bcyhG0FGiKXN6/7ryzHh298gky8QT/BmCs7D03lCt9Rm+nMIJnmUQL67OUJpuvaE2OtutnNidAwyo27Fq2ly9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 17:29:59 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:29:59 +0000
Message-ID: <6037846c-ca4d-4927-a6c0-f8f0cfb96f80@cherry.de>
Date: Wed, 14 Jan 2026 18:29:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable
 all drivers by default
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, alexeymin@minlexx.ru, danila@jiaxyga.com,
 david.wronek@mainlining.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
 <20260107154745.571319-2-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260107154745.571319-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: d45e5f83-4cd0-4044-7c4e-08de53928ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVV2VXVwR05QcU05cGF3QS9ORlRWdnpuSks4N09FWUFFUzFqd3UvL2ZQRnRG?=
 =?utf-8?B?dldJbjBoVmxmcnNhdElzalA3clNzSXNVbXkvNHoyNHpvbTdBT0F3bWpRR21y?=
 =?utf-8?B?YWY3T0tFaHZGSFB6dzdOTzNaeDB4TUJuM2Rkblh4VG9HS2cweitBL2M1K29o?=
 =?utf-8?B?QnY4V0tQNWhGT3pyd1VrdldzY3pNbHBZdjVvZ2orUGdSVERLQW9IdG5KZnBY?=
 =?utf-8?B?QlN5Y1dlTU1qaGpCK1RWSjUzbmpZMGxIUUh1cVhhOXdVTUpNblI3emxxbFk0?=
 =?utf-8?B?S1N2L0tsRG1pTFNPVzBTVFJSVG1acGRQTndTUmk2RWVvbmIya2Q0Q01hcWpu?=
 =?utf-8?B?REtaUFUvZVhpY3h6VjhscldQVU1PVWYzKzZXUkRJU3oySTYybXFGTFRmMFl1?=
 =?utf-8?B?bi9ab0xwYlA5NkxwS3p6bm9hWUhIbjY2YWNiYzlPbHU4VUd6Mit6YU9SWnRi?=
 =?utf-8?B?Zjhzb3dvTCtoL3hvUk92MjBNWGRUOU1ManhLK3dOT2pxbU9EUUttemZDY3pY?=
 =?utf-8?B?cnVtLzZ5Yk5TaURoVVBZYklmMzJ4cjFSeVNMcno1Uks3VmdqTmI0TFFraGtM?=
 =?utf-8?B?Mm4vQzlXNzNNbUxKY2RpQm4wOVErWWs1KzFxc0tjTndyN3hLcm1uVDZkMllO?=
 =?utf-8?B?cDJnVVB3N1lCTDZjYXhHVVZ0dldycWo2UWgwdmZpRnBkcysvSWZ1MXlGQys5?=
 =?utf-8?B?NVN5WUNxSXhlNGZEMHliNXJFa29wR3BYN3d0MngzSnM0VnlJU25QeURuT1lX?=
 =?utf-8?B?Mmw1ZFFvZ2FQSHFyYll5eUhOc056NnNWdUlnenNSV1QwSjVsc0xlVlBiMms1?=
 =?utf-8?B?UlByWVppMjM0M1ZiRUQxOUpwcEpINVBLdXhSNTdjU3VaNFcybDBNN2g0RXNI?=
 =?utf-8?B?cE5qcVhmNENhLzZaNUE5VnpEYm9Ed1FYQUIwTENEOUxxL1cxQ0czNVhkZ1Z3?=
 =?utf-8?B?VHluQm9IZGtoY3haVXp6blZuWW1wVURVSzRTejE3TEhLeDlzQkFRYUN2Uzlu?=
 =?utf-8?B?RHVzTXdPdE9lZXM0aXZlYm5mYnFTMFN5a0ljNFpsZk1qYnB3NW9NSXNpMnI2?=
 =?utf-8?B?U1ErZTFJbHkxN0VBNnZISzFVMldTT09HUGRpemx0OVRYQk1VTmNRV3dmWmRI?=
 =?utf-8?B?bmF4N09DNEh6bFBwQlR2WEVna2RUSEZSSjQ3d0RMZ2xUenlqd3p1TXdNMTMr?=
 =?utf-8?B?WU5HQythU0kyVUZMblNUM0RxenhTWlBGQUZwc2NSNzNMWkFDb0Yzejh6WnJa?=
 =?utf-8?B?SmU0UUNpZ3V2Q2g2dHc4cjVxeEdCbWhhdlNOYWZmRlRQbC84QzJzd1dTWXdQ?=
 =?utf-8?B?cXRyK281THhWVnFNMDNCRE5xTWlBRndEaVJ6cGJvWjBTMVlnZDRteWlPeFhC?=
 =?utf-8?B?OTRuRndjV2pzczBuM2NWRzVYRWRhR3BITVlSeWVVQUo2QXBaWWtTVkpaUjYr?=
 =?utf-8?B?UncwV3MyRkF0MTR2U3hCWDh6Z2Nxa2FGZFJvaEhpUzdvQjJqQjNCRFdOaDdD?=
 =?utf-8?B?T3hvK3VpNFpCK2xkZDdJQjVRKzVxUlBIMGJweFhyckRIUWpnMDludEJadnJw?=
 =?utf-8?B?dm0yNldBZTRvNkFoYVpZSy9KMlErOHU1d3NUY3hPdzBYTUFMNkZSb1JqWFZG?=
 =?utf-8?B?UnZkR0srSXZMNGswNWJUbkI3Uk5UWC94ZmkwZWJPcnRvQksvTnJWQm9HZ1Fo?=
 =?utf-8?B?SFpSL3dXVlNSRWRVQzVVWkFBKzZBL3lMUlhwS29KOWtoSWRiZTgveXhxT0VS?=
 =?utf-8?B?WGt4RS95RzE4SHRWdmszSC92cWdIZmZsMkVIKzhSdkE5SlBSUTlJbFMxN3Rn?=
 =?utf-8?B?aE12Zm5TZWtDQnZuVE9PSU1RZzFKbVVnMUl1SEhJd0FpTW8vczhaZTkrekNM?=
 =?utf-8?B?UXFyWndDellVUEVjdHJtNkZuNnJzdDk2dTVqM1c4Zkc1ZGpFS2xaZ2lvVkI4?=
 =?utf-8?B?MzFObEd0MG9wWXcyenB0bFRlUFFPSW9nNWdMYlcyMGVMb2xXUVBZNlAySCt3?=
 =?utf-8?B?SjlLYWtLbG8vSWk4ckh0QTczL1ptcHNFSFdLMTFsdkJtWlVQcmlwOUVjd1Jm?=
 =?utf-8?B?MW4wSXVldnpnTFRXS2tZZ0NFanBQK2R5MnlIZ1lIMnVNVXpXZm9WSG1GYnVH?=
 =?utf-8?B?NmVDNVp1SE02UkU3ekk4bWJTd1R2bHJibldUSGhjVmJqRGV4Q2czMHErNVNS?=
 =?utf-8?B?eUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlObHk2YXVUdlN2M2U3c1kyamtpT3BCNWduWDMzKzVPRUxwSExxTk5rWC9L?=
 =?utf-8?B?aTZIUjliOHFjTHVLY1EwV2ZsTkdxN3AzbmFGdFlMSkN3L0l6aGpPQjVWMkpy?=
 =?utf-8?B?VVgySlY2eWxFOWVoNmg0K1NPTnlnbENwNk1SaFY4NWZxbUtaMXdSdWdZUkZj?=
 =?utf-8?B?K1hOQldYYlg4WTZ2M0NKMHFMUzZLMjZCSzA3VEs5TFlvdlRxWTQxaGh1Njh2?=
 =?utf-8?B?OTJhc0pNZjBPdXl2bFRjUVFrWkxsdlRsNUJITUl4TFJCbkVWeHBEdVM4ZWtx?=
 =?utf-8?B?c1JIUm5lRGp5TGM3S2tJMU9TQWJGVWk3OFV0MmFsdmVsOVJMMmMyRzhlaENB?=
 =?utf-8?B?R0RWVGtLS2JYb3kyUUhkeGJmeTlTcFlTQVYxQm8vcjFFZG5lN0xlM2E5M0ty?=
 =?utf-8?B?dDdSUlhDSmtXU1RTbHRNN215MVVQN1FlOHdvaG5pcG4rbnNxa2JCZFd0Y044?=
 =?utf-8?B?RlhIV0w5MTk1VStLcnRSbDkvdzZ0blhyTVYvb1pkSjFBSER1aTcyWUZFZUg0?=
 =?utf-8?B?Q0dnd0pPOElwWS91bDMxc0o3TkR2ZlQ2Vithb2VoYzI5K05uZEd5bk9hckpm?=
 =?utf-8?B?ZU8zejNxYVBGYy91MHg3T1ZDZWFOc2NNWlZzcFJEZ3ZhaHNZZmt1WXYvZmR2?=
 =?utf-8?B?UW83dGJ1Sy8zbUl6NW5QMlcrV25RRXRnOTRKSlhZWGFSSUhianVGL2xTL2hy?=
 =?utf-8?B?aHM1UkJrVHA4QVhicWd2b3VYQ2szQlNHTlRYWTZRRXl6QjVXM3VwRDNLM1VH?=
 =?utf-8?B?emVRUk4wdmxiSk5WK2NZSUxaRTJHaWFTZzRmWVRtRnZHNlZrWnVhcG1ZWUhu?=
 =?utf-8?B?eEpuQnBCT3hpaHhXZFFSZWl5N0dKblZjQ2d1RDNiT3g5ZnlZa05HUmZWaGwy?=
 =?utf-8?B?RDN1ZFZuaVhpSkZ0L3ViUVJJOFBBRFdVdHZVWW0vcWMvSzhUZHVEdXpFRlhq?=
 =?utf-8?B?UVE5Q1FVcjBKU0FGUDRiZHNZVE5nM2VwVit4TFV1R3dyOHhhci9Tdko4Y3N3?=
 =?utf-8?B?VXEwYUdoQlRwcTAzNm1NcmNEdHcxUE4yR0oxYUR2S1dJMm11WGxRZ2lRRXQz?=
 =?utf-8?B?SHBZb1pKYWlIK2hSaVZyczZCZlBydk5yQkhFQWJIeU1xT2VUeHJ5TUMvbk9Q?=
 =?utf-8?B?N2E4S0JZNXROblBSc2h2d2JVVTBIRWZpWTRtMG5VaXI0SkgyUkxtN0RJZkhE?=
 =?utf-8?B?alNhL0NRTVNVakJKcTlrZ3NTTnBGOE8wL0wxNDVRWG44Y1AwUlNhdlMxVkNB?=
 =?utf-8?B?N3JQeTFvYW5Gcnh5dHNsOVk0bHArYi9vWnRoMW9oNDdHb0xwVi9JME5HL1lF?=
 =?utf-8?B?dmNOMDBzM3pPNUpwejV6Tmpac1AzVnhoM0JmdWVuSUFmTGVCWjFhZ3dUVDV6?=
 =?utf-8?B?SllHL0xQenRVNFJtL2Fycm91RGFwaENQWnJ0KytBVGJlcUVOZm1CanV4WmxJ?=
 =?utf-8?B?ekRVL0pXM2I3aU1JZFlWdUtObUZibjI5K3d0TWJTQVJFWWlYVUFvWmNyR3kw?=
 =?utf-8?B?OWxtRlIrOStvd3g1RHU2SWJtbTZheE0yeTNHbHhlVDd4OVMyWFh5NlEzS3lr?=
 =?utf-8?B?R1pTUWMwS0lBSkFxREVwZ0xlYVRJSW1vcWMxR1M5MFhsQ3dDMXhWdGRrZTh1?=
 =?utf-8?B?UGdhYThVNDd1ZUY3a2lwTmxKSzBYZWVTK1cwaVcrNGFzV0Z2L3NpWkErbFBF?=
 =?utf-8?B?MTNJUGFKdEdFT250QTJweFMxNXV2dVQ5ZnprT1dKTStLdEs0L3pZSDc0Mk9L?=
 =?utf-8?B?bUxEajMyOGJKTDFaZzltRjgvMkZkZHJrZXJWQnZjeGw1ZFdHeHp5ZkJja0xo?=
 =?utf-8?B?YVQ1ZFdobHBpcWNKdnYydmFoV1o0elUvQlA1dEVEdFI5eTlMYjRtMSs3aS9E?=
 =?utf-8?B?NEFVRnNoZ29MS2V2M0Z2ZWcvalFjNWZMVWpaUTdkSFpvN0pDRFhadXZlVWl0?=
 =?utf-8?B?emdybzVGZXg0cjdVTUhPNXFGUEFhb3dWQ1NsV0NBQStyNFlpSmJtdmxvbEY4?=
 =?utf-8?B?UHlWL3dLR0xzbi9CNThMZk9BY1BQZjcrUHlId0xsR0N6c1hkYmp0bWRMdzhx?=
 =?utf-8?B?bm81ekVocS9NT2ptTmJqcmNFMWxlZzhpdDBYcklrOWwvOHZmTE5kVXFGYmxI?=
 =?utf-8?B?WFZidmx6YmdzdEFobXJTM0pOV1FmVVI5VzFsKy9RSUNKTkh5ZjEzSWJMVVdJ?=
 =?utf-8?B?YmNVc28weEZtV2k4eitCOFpPVWduRUJrRmd1bEZxeXhhNWlTTkxzUHh3cTY2?=
 =?utf-8?B?blVwRzduQVhmYUh6eWl0alRLbG45MzJpYVlPUllZNjFIVlA3NklWSHdaWE80?=
 =?utf-8?B?Uk11STZoRGJRR2Y4TUVwNmFVcHJ0T3AxSjRmbzJEYkh3a09VM3JOdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d45e5f83-4cd0-4044-7c4e-08de53928ad3
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:29:59.3492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WfSR9E8BPkQiBZajHG/MBGc7djPpu6uSlMlI+5r4rqxQki0JwPPMzlkCD68JpoOMucO5ZMSwUtkl++KlAVJt0fr/aVpTSvCZauzOmg3cIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663
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

Hi Aswin,

On 1/7/26 4:47 PM, Aswin Murugan wrote:
> Introduce a new Kconfig option PINCTRL_QCOM_GENERIC that, when selected,
> enables all Qualcomm pinctrl drivers by default. This simplifies defconfigs
> for platforms supporting multiple SoCs and avoids manual driver selection.
> Individual drivers can still be disabled if required.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - As per review comments made default y for pinctrl drivers
>    based on PINCTRL_QCOM_GENERIC config 'default y if PINCTRL_QCOM_GENERIC'
> ---
>   drivers/pinctrl/qcom/Kconfig | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 725200d94c8..580308621b1 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -6,8 +6,17 @@ config PINCTRL_QCOM
>   
>   menu "Qualcomm pinctrl drivers"
>   
> +config PINCTRL_QCOM_GENERIC
> +	bool "Enable all Qualcomm pinctrl drivers by default"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable all Qualcomm pinctrl drivers by default.
> +	  This is useful for generic Qualcomm defconfigs that support
> +	  multiple SoCs. Individual drivers can still be disabled if needed.
> +
>   config PINCTRL_QCOM_APQ8016
>   	bool "Qualcomm APQ8016 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
> @@ -15,6 +24,7 @@ config PINCTRL_QCOM_APQ8016
>   
>   config PINCTRL_QCOM_APQ8096
>   	bool "Qualcomm APQ8096 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
> @@ -22,6 +32,7 @@ config PINCTRL_QCOM_APQ8096
>   
>   config PINCTRL_QCOM_IPQ4019
>   	bool "Qualcomm IPQ4019 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
> @@ -29,6 +40,7 @@ config PINCTRL_QCOM_IPQ4019
>   
>   config PINCTRL_QCOM_IPQ5424
>   	bool "Qualcomm IPQ5424 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the IPQ5424 SoC,
> @@ -36,6 +48,7 @@ config PINCTRL_QCOM_IPQ5424
>   
>   config PINCTRL_QCOM_IPQ9574
>   	bool "Qualcomm IPQ9574 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
> @@ -43,6 +56,7 @@ config PINCTRL_QCOM_IPQ9574
>   
>   config PINCTRL_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
> @@ -50,6 +64,7 @@ config PINCTRL_QCOM_QCM2290
>   
>   config PINCTRL_QCOM_QCS404
>   	bool "Qualcomm QCS404 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
> @@ -57,6 +72,7 @@ config PINCTRL_QCOM_QCS404
>   
>   config PINCTRL_QCOM_QCS615
>           bool "Qualcomm QCS615 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC

Indentation seems incorrect here?

b4 doesn't want to pick up the patch from lore so cannot check if it's 
an actual problem or not. See:

$ b4 shazam --add-my-sob --add-link 
https://lore.kernel.org/u-boot/67140dbd-1b93-43d1-b218-0b57a762ce1a@linaro.org/
[...]
Applying: pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all drivers 
by default
Patch failed at 0001 pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable 
all drivers by default
error: sha1 information is lacking or useless 
(drivers/pinctrl/qcom/Kconfig).
error: could not build fake ancestor
[...]

Cheers,
Quentin
