Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1FCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 08:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE24283B7F;
	Mon, 17 Nov 2025 09:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R5JEEtKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1268E83AEF; Mon, 17 Nov 2025 09:47:16 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2052083AEF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojh97p2rB3acOH4/TIwyuZmvmFGOprDrTSE21QgFsu10fHOUdR+hMQ26BeEw+OWvRmfpUkgTnTzMOR1s7XSZRI57RMKvvretepZphJk1m52VDDhZd3tD8ZwbV2mb7THvvm7PB4dk1XOQmdFrNArmuzaZ6rrbZm/PEcfmItJ341S9NcerWGJXMWtDOGxDuj5UMAnDgEDV3FiXeY92YWIv1vSyOASjJH7ngDxBhBeBQ24RXs/DV7/VYGcEOpcKaQHoQVl1USUlv8yKWpJYn8g/3xosCm9eXNCF5lByb0S44fxp5II7Nhzmh4nrbnTzMqYYKdDocwu7RoZHdBEULhzNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19iYPSZJTYoUDuo/ogPzegiK/itiSgsXu7YVo9M5vho=;
 b=U/a1x64yB3INjLUEjWdXQCpJbSkrlH6YdhBswil2k6kGgUlrh6AAc7M1C5zdwgVoXGrPcaSsqL5G2054TkcX+wMMJbgPsqA9FE6rBnCFgRnlXiBVj7NaRZlh1gE9SUPam6MEfeRLwrZMBUIRXOZNvPN6lvJVbHr+pJN2fcYu/c4KVSC/qE0bg95gZp9KZsvrLZo+A2ld3SvVIdc9Rd4Hc04Z5YCqSPPGVsxnT2T/ezYw9nkup2ICIYB44ULmvbELaNH7Mpt9UCFPjTozgYwkMTfrimq67RDL8kUB14rTdDsyzrCNIAmD5XgV27/lg46FhYWy5BR9Jg1MpXuvaLhnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19iYPSZJTYoUDuo/ogPzegiK/itiSgsXu7YVo9M5vho=;
 b=R5JEEtKYnzM4AWRLWnApDz/OdlJwOHPHSVp5UYgAvFCfhOH1J0XjO8OAIKU0md7mmH7Kp8+Da/WS8J7zw8jth9cIcVRVYGqSAvAdwHGG8v3bgv7QQWoXh/UfBdXR4nI508fNa5X/TRDiXeet1Vu+B7YBOY3iKSiav16X2sb+eWd4XWUA/Ey8gytCsYac1Jz+FX0uG+QkFJQ2PS8hySwfPqZXXWhZjHqfypK5eqtazJSsUS+IV+fFDjdXTl30dM1YDrSAW9JA02Z9dOX7yQF0oDqMlStl2Gr0v1S/pTC5hqzuOPM+lpFJDVoXckq+NWd5IDZggZPSpxE9XCPyAOG09Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SN7PR03MB7260.namprd03.prod.outlook.com (2603:10b6:806:2dd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 08:47:09 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 08:47:09 +0000
Message-ID: <8007b7fa-0797-4e2d-8217-7e50897bc54d@altera.com>
Date: Mon, 17 Nov 2025 16:47:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
To: Nikunj Kela <nikunj.kela@sima.ai>, joe.hershberger@ni.com,
 rfried.dev@gmail.com
Cc: boon.khai.ng@altera.com, u-boot@lists.denx.de
References: <20250829041232.1160655-1-nikunj.kela@sima.ai>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20250829041232.1160655-1-nikunj.kela@sima.ai>
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SN7PR03MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 99398292-1856-409d-409c-08de25b5e47a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWFDWTRXZms5TWJyVXkxOFRMNmRDZ2tqck9pc0FKVzc2ZUJlYkhndmpSYmZ4?=
 =?utf-8?B?Z3pDODJINjVuc3hYTmI5QnZPVEVhQzVzWVl0RUFDTHlId1dicG9oYU1VV3Ni?=
 =?utf-8?B?UXl3ZUxaSzl5aHJENHFhSE9ZN1VWa0ZTYWk0TFlmOVJQRDNyeU8xbWl0c3V1?=
 =?utf-8?B?Y0g5c3R2b3FsQ2Z6cVdiNVl3NVVyMGxaQnlxa3JFUXdvSUhNZnRHWUNWdnVW?=
 =?utf-8?B?NUExb1cyakN3ZGdRWU9nT3BOVTdVS0ROMlN4V3VTMEZ6N09pbUVpRkpHMDZE?=
 =?utf-8?B?d0JkSTdoZ243V3FZb2ljQkFlaWZaVzNFMDF6Z3RYbnVCMG9NTm5lejVnSENJ?=
 =?utf-8?B?dmhDSE5YTDFXekFVY1g2UlkyREcwREhZMTB0U0h5cVhzVDdxQjJaSjdTN2My?=
 =?utf-8?B?V1VqekFBQXpCdGZqYnZjWEJFbmRSNWxvWUZjdVFxYVRWc01mdkFuSVhDWUgw?=
 =?utf-8?B?aHZZYVNXaWVWWTZ5TUFudUExYUlxcjRyc080V01McjRsWkRrSDBSTlFWZzJF?=
 =?utf-8?B?cHVucFlsUUc5N3BTR2JoWlIya1FTYXlKRXFvZjhCZm9ndlZKWDJEanVIbXUz?=
 =?utf-8?B?Y1pJY0crZUYzTllxTTVXSHVIV3JmRStvTk9NUDdrMmpLK1FwTUxKYXhuZEVX?=
 =?utf-8?B?ZWN1WFZ5cWRUalpHY05xOWtGSk13VTVjLy9vL2x5VHg2T20yQ0FUWUM1ZkFw?=
 =?utf-8?B?MDVIaXdGdmp1ZCtyUzluZEEvaWtsZEpQYWc4MWd6SUxhZ0JhU0x5K1FoMXEz?=
 =?utf-8?B?VDdoZjRWTTB0TnY4YlRWUGlQWTZLaFNpR0ZTb2tmYzlXMVlXaVE0cjV4V1ZQ?=
 =?utf-8?B?d3RCbW5MV0x5T2UweVJoMVowL2JXRW0zN0xidHpRb0UvalZQdkZuZ1haRmZT?=
 =?utf-8?B?QWJ3dk5DSHJRVnFFNC9qdmJ4WURCUXpsZDNSdjArNjVlTm9HeGwwazRjTmx5?=
 =?utf-8?B?Q2ZlSnlvdFBPNERwV1kwMkJuZkdEcGZRK0RuV1AxUXJQWEl4R3VOSFFTWGdC?=
 =?utf-8?B?NFhtK0pkc0FUZ0NCeWNWYjBzeXpGbDVRSWE5MTREMEdEQzA4T1VHNlVXa0tq?=
 =?utf-8?B?blhFUVZSZzM2Vi9TZ0N2WmxJbGllY0RVWFR2RVgwVUlhbjUvWVFJTlBIR0Fn?=
 =?utf-8?B?MDM4S256YndBcFMrZ1c0ZkFhMFphc08zWUJHejlpcjdVdnJSdHdEUHJQc0RT?=
 =?utf-8?B?TFlzTXl3MzF4OUg3ajBNY05WanFlOEZuZndmVkdrOHNSVWlUeUUrZFJZemlX?=
 =?utf-8?B?WWZIdU9aSlNJbHhWVjMwSlRmdWZ1YTBEbjR5anQwQ09XSlZ5Yk15Z3NHemZX?=
 =?utf-8?B?SkR1cXhFV0Q3cUxXREdIbzNXbERDY1NWWWpSOUdFOE1oT3E5VHNRTGdVd3pu?=
 =?utf-8?B?dVIrUXNESGd4OTJoYURzL0Rxcmc2dVdsaGdjYWJCZkFJNHFZaDRWNTFUcjFi?=
 =?utf-8?B?U3J6ZDdOV2MwUm9WUlRJM1FsbDQ0eHFOOEtDbG1Nb1NVRzJpcys0U1RtOGpF?=
 =?utf-8?B?MitCYTA0azVOM3pjMHA3OFlwSUd0NGU2bTlTWmdpT3IyZHplQmhJOEY3V25w?=
 =?utf-8?B?dS8zaTN1Zmd3TVdIS1NJRzd3YnlOSjhNd25GWFVrTm5aQmkvVHAyU1dXcmor?=
 =?utf-8?B?cnE4MzhEUHRUVnBwa011aWE4VWt3dlJLTkorNUlMSnN0T1ZoSy9rRjlBSTB5?=
 =?utf-8?B?YThmZnM2WXVreDBFa1l5VFRpNTg4RWo3QnFtM1c3RGpQMmtzYmpmZkVtMWli?=
 =?utf-8?B?MytBaEtMd1EzZS9jTkFYSUFjTndiMlNYdCtUWUlTR2VyNTU0MWl2dmpnbjJJ?=
 =?utf-8?B?aDN1V0xoSkR6SHU5dGtDOVY2VlRuUDlBRUNKQVdLbTNDRmZhZjZGWTNPOXFB?=
 =?utf-8?B?c3RGYis1SXNwTVcweW5DODNjeU9iMUI1WDFFWStUVEYza3pwbk5DNU5zVCtx?=
 =?utf-8?B?cDBzd05JNlJhWHIvSHBTWVJOZ1B1UEdVcVFEWmFTbnZ3UVRzUnUwQnBGNjJa?=
 =?utf-8?B?aVlmNHpTUnF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFjbmFvbmVqdHdpQnJRLzdudjlwUFZnSU9uNERxY2RUdm5wcloxN3gvQWFP?=
 =?utf-8?B?QzQ5UEdwTFdhdnJRUm9VWjN5eUdQclc0VTZwOFFid0o4aWQ5VHB1Y0g1MFls?=
 =?utf-8?B?TitEWWsyQ2pVTzN0ZFcwY3htZGI1aWphMFg5aTU4RHU3c3FCT3QyQTZ3NkxQ?=
 =?utf-8?B?dnQzNTc1Q3FwQ0F4YnNTVWw4NnIyU2Ricm1hbSttRVB6bEJ0TmQyQzBseVFS?=
 =?utf-8?B?NWxzekFpTzRBOW9TRTdKVmZhZzhQVmo3c1RvMG9lbndSYzRncmxWYmc2M28x?=
 =?utf-8?B?VWc1emJubFlaa1h3SSt4clMxOVNweDhVbnF5c05JV2xSR1Y1L2tiTkVVTnVN?=
 =?utf-8?B?VmJwMTJGZFZ3amx5ajZSaDlOdkI5V0ZxUWNieXlab2trWmVENkdhdmlaSE1q?=
 =?utf-8?B?bXU4VWRwV0xkSkE4eEJQblNNKzlMcm9TTDAyU1JtUWdhTGg3SmNUL0hTcUJP?=
 =?utf-8?B?Rys1ME9tMUZMVmNoa2RydDJudVZZTkI2VmM4aHRldWRQaGFBdDZxRDY4TVBB?=
 =?utf-8?B?VU9pa2RUNlE2RjRiUTFUbFB3Ujl1S1h4aWhOellTc0xyOXAveUxoU3FZSU8y?=
 =?utf-8?B?b0FGRUxQanBHbzRrSHl3UnFGc1JBMExJSTNBYlpkYk9lQXMzcDNSRlJlY05I?=
 =?utf-8?B?NDBRODYzaFRJTDdubEszcU9TNnpXWW9GMGJ4WC9IdkswMWhESUU1R1lvTXd3?=
 =?utf-8?B?Q3gxREZjVlB1bG9MSUkxQXR1OEplU2ZwbUIvNnNveUFXRWNnTVBHZFdGYWYz?=
 =?utf-8?B?SWpTdnRzekxSdDhqZFBzTUZjdmkyMThYSitFVkorOEtoS0I1K0kySTlvam9L?=
 =?utf-8?B?cStIbFIzTmtvR0xLOTB2NFJjTlo5S2VGVVpjSG96QUJlemJ3d0tiYk5UUUdV?=
 =?utf-8?B?M2JvSGxUcW9ubGhIMG8wdEZ2RG5nS3lIRGtTTVM3cHk1Z2h2emlaOXByekpT?=
 =?utf-8?B?dmpabnFRQlBwMWFGSjVva0JPb0ZqMEhHWUcvL2Znenl5WVIwYnc0b3FuWUlR?=
 =?utf-8?B?MHV4R2M4d2xjcHdndjgySG1xYkRjZTBkc3I0VnhiUUU4MDg5WVlROE9wRnRC?=
 =?utf-8?B?L2tNRVBDSEx3czBkVlJiMFZBQlB6Ty9EMWNSRUdVazltclhDWno3d0k2ZVAx?=
 =?utf-8?B?RkJSalU4OU5kLzBwTXFqS3hnWGVyd0lWQmRqMFczS2ZBd0VlaHNLWTdBK2hy?=
 =?utf-8?B?L0pqb25mSXdJWTJ1bXI5dE5WcVpIZ2hmbFg3UlZqUy9nMW9jRDVKREFoSjZ5?=
 =?utf-8?B?c3pEYVN1ZVI5MkRnV0ZPT3h2d1FiQTVoWS9sM2JTWFVHVVRqRnFLTm5KTlBG?=
 =?utf-8?B?T1liNndHbTYvN2RLZWNoYUFvWUFvdXRuSDFLa2xjUHhZQVR6M3lTYm5NR3JK?=
 =?utf-8?B?OWNraXYyakNPOEpNOWl5WFI2clN5UG1aVTkwdXMrSDRKbk9TVEdqNkZpd01q?=
 =?utf-8?B?LzdWVERHL3FDakRHMkZuTmJUemJjVEdONFhCdHppZkR4RXluM1JEaXQ3c0NO?=
 =?utf-8?B?ZTRhdmhuN0U0NkNyNjFmcnU5cE9OVmYraDBtUUV2d1d2TW1jUXZ3ZWNHT0Yz?=
 =?utf-8?B?YW5LSCtlRFRSSnFvaUhHa0J0U09qd1RJeUNtM0s5cHNHelBMNWhMTU5qNnZJ?=
 =?utf-8?B?L0FqZ2R1bndPT05Md1YwVkJ3V3BWeEEra3V1V0NZSFhTQkU3ZVppRHlvcUVI?=
 =?utf-8?B?VG93NFpFQWpWQXpiKytydHp5Wko3UnpFcHJtYmpqbys0OE52NlpyaVltMDJn?=
 =?utf-8?B?Y0tWN0x4OHF0aldiMitoQ0RWRU1JODlpMDVRRWdSUDg5d0VOVFlQY25Ed1lI?=
 =?utf-8?B?UE1WMHE3M3RNeXV5aGNPVUlmVlllMmZqNjV2dWJ1U2l6cDFsU0pWZzRDeU8z?=
 =?utf-8?B?eHdaR25lRnEzUzNISjdIQ2VmNUw5aCt0SkVjNEN0WTF6cGQxUk1ZSmhhY3Jv?=
 =?utf-8?B?T0NTaUxyaFZIVHFSc0x0R3F6QnNPVlFOT3NUK0RhVXVOWEpZaTM5b2RrVFdZ?=
 =?utf-8?B?RlA2RktwaDFaa3Y5KzFNblRObUJLcDVtcDJ1dmxQQlRhSHg5L0pRVVg2aWds?=
 =?utf-8?B?R0JVUVJSVFhmd3dXYkhkQi82ZGVldjZ4RjlFaDJzcmdJR1pnVFJOTXp3R3Vj?=
 =?utf-8?B?bEdWUTQ5YVZWRVg5QXBaODczUVZVSi9MUGNZUzFwSXVMYTFrdUNtcC9rT01s?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99398292-1856-409d-409c-08de25b5e47a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:47:09.0284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WE89xyo0s9ermXMhicabTynBXvg6XHElUsVq4ukLudYg/KRvM1JzH2Oii6mUrppAeJyzJWw4iVXteYBCPWoQJH/yjFErXmYCgvaWJQ5X8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7260
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 29/8/2025 12:12 pm, Nikunj Kela wrote:
> Currently, clause-22 format is supported. This change adds
> support for clause-45 format.
>
> Signed-off-by: Nikunj Kela<nikunj.kela@sima.ai>
> Reviewed-by: Boon Khai Ng<boon.khai.ng@altera.com>
> Tested-by: Boon Khai Ng<boon.khai.ng@altera.com>
> ---
> Changes in v3:
> 	- replaced tab with space
>
> Changes in v2:
> 	- Created separate function for configuring clause format
>
> [2]:https://patchwork.ozlabs.org/project/uboot/patch/20250828225532.1147284-1-nikunj.kela@sima.ai/
> [1]:https://patchwork.ozlabs.org/project/uboot/patch/20250510041200.2552981-1-nikunj.kela@sima.ai/
> ---
>   drivers/net/dwc_eth_xgmac.c | 60 ++++++++++++++++++++++++-------------
>   drivers/net/dwc_eth_xgmac.h |  1 +
>   2 files changed, 41 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
> index d29d871ea8c..458b87af7a2 100644
> --- a/drivers/net/dwc_eth_xgmac.c
> +++ b/drivers/net/dwc_eth_xgmac.c
> @@ -140,9 +140,34 @@ static int xgmac_mdio_wait_idle(struct xgmac_priv *xgmac)
>   				 XGMAC_TIMEOUT_100MS, true);
>   }
>   
> +static u32 xgmac_set_clause(struct xgmac_priv *xgmac, int mdio_addr, int mdio_devad,
> +			    int mdio_reg, bool is_c45)
> +{
> +	u32 hw_addr;
> +	u32 val;
> +
> +	if (is_c45) {
> +		val = readl(&xgmac->mac_regs->mdio_clause_22_port);
> +		val &= ~BIT(mdio_addr);
> +		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> +			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C45P_MASK);
> +		hw_addr |= mdio_devad << XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +	} else {
> +		/* Set clause 22 format */
> +		val = BIT(mdio_addr);
> +		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> +		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> +			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> +	}
> +
> +	return hw_addr;
> +}
> +
>   static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   			   int mdio_reg)
>   {
> +	bool is_c45 = (mdio_devad != MDIO_DEVAD_NONE);
>   	struct xgmac_priv *xgmac = bus->priv;
>   	u32 val;
>   	u32 hw_addr;
> @@ -159,19 +184,16 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   		return ret;
>   	}
>   
> -	/* Set clause 22 format */
> -	val = BIT(mdio_addr);
> -	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> -
> -	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> -		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> +	hw_addr = xgmac_set_clause(xgmac, mdio_addr, mdio_devad, mdio_reg, is_c45);
>   
>   	val = xgmac->config->config_mac_mdio <<
>   	      XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT;
>   
> -	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
> -	       XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
> -	       XGMAC_MAC_MDIO_ADDRESS_SBUSY;
> +	if (!is_c45)
> +		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
> +
> +	val |= XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
> +		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
>   
>   	ret = xgmac_mdio_wait_idle(xgmac);
>   	if (ret) {
> @@ -203,6 +225,7 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   			    int mdio_reg, u16 mdio_val)
>   {
> +	bool is_c45 = (mdio_devad != MDIO_DEVAD_NONE);
>   	struct xgmac_priv *xgmac = bus->priv;
>   	u32 val;
>   	u32 hw_addr;
> @@ -219,21 +242,18 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   		return ret;
>   	}
>   
> -	/* Set clause 22 format */
> -	val = BIT(mdio_addr);
> -	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
> -
> -	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
> -		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
> -
> -	hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
> -		    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +	hw_addr = xgmac_set_clause(xgmac, mdio_addr, mdio_devad, mdio_reg, is_c45);
>   
>   	val = (xgmac->config->config_mac_mdio <<
>   	       XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT);
>   
> -	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
> -		mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
> +	if (!is_c45) {
> +		hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
> +			    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
> +		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
> +	}
> +
> +	val |= mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
>   		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
>   
>   	ret = xgmac_mdio_wait_idle(xgmac);
> diff --git a/drivers/net/dwc_eth_xgmac.h b/drivers/net/dwc_eth_xgmac.h
> index 259f815f3f2..90c2e22997c 100644
> --- a/drivers/net/dwc_eth_xgmac.h
> +++ b/drivers/net/dwc_eth_xgmac.h
> @@ -109,6 +109,7 @@ struct xgmac_mac_regs {
>   #define XGMAC_MAC_MDIO_ADDRESS_SBUSY		BIT(22)
>   #define XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK	GENMASK(4, 0)
>   #define XGMAC_MAC_MDIO_DATA_GD_MASK		GENMASK(15, 0)
> +#define XGMAC_MAC_MDIO_REG_ADDR_C45P_MASK	GENMASK(15, 0)
>   
>   /* MTL Registers */


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


>   
