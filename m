Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C802E6B25E
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 00:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE3383F1F;
	Tue, 23 Dec 2025 01:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="pZZbFGrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B5683F4C; Tue, 23 Dec 2025 01:36:00 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366D383E83
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 01:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9J+rDK/+fHVjS9upDcFqyw+hiSsJsLccVYYpV28R0gH8Py9ODelDSM/rvoY1zmICdVXei2vdpE7HXTkCQnxOLPhjvRPWJ/GB4YGKGLUBduk1307UknO/P/o21R9nuw3d5weP6RJ+83giRlw9ay2jcDE3nMk+elu5a3hsrVQLxUUgydkPKTOtFZwGApmdbQFFeepLcovVpwSA1ccGNEG+qwfJVK5QfuiMCsv7v7X3Jbron73TmVDz+DZWXKQ/bjFhQUILQSeRXXv4yxUFF88GR1eHvYSr1Z0ju/BZa6xDT7WG03oZpsS0NlRp6im9YUuUe5bMsGfD+xAXVRPWbVm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jrq48/BsR4NZDCNhx9u9z1jwhAlCRtYx/hO2rrgjcHg=;
 b=Nb+t8QbTi9e9BGUi3q3UFpo2wmBxdMFBxSBc7I2j6QXTa7y/FGrqC4RbD+c83JVMr5vzNtbKRqIkgx7DtfV3k5KpZ8Oq+6XZw1FvIy7/19LieIShP/HiV667A1Omu98mg6PbMRJCFNemOY/qPIz6/THhsmR62w/U2VIJ1fFlIZyQxwXrAjUJ5P/SNoCKCid0YwMqyg02Yu1BmyjTzPosYCG+UOVPAo/b+AgV0w/b+rZozQTfHGYm4KyLdZgcmwqWnbWPC9rkGZSkjAWJhjP3zaPrylgaP1muQNYxgJyWuGGPPg1o1Upjp/clrdQ9wqZhCzvds52M8QHaqC8IrSa0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrq48/BsR4NZDCNhx9u9z1jwhAlCRtYx/hO2rrgjcHg=;
 b=pZZbFGrwnJU8BFe98PpIiC9vHLmzbWYw/fOi6WJjaUxqYHfqszojvRg/O1VOkGeiqxm12IV7wlZeo89pXI67B4EnmdqRYfW/j5F6330H0Odnl0gOpIymb6CFBKWiebvIwflYE3DeZDaNGDMqlCLE2wM753umS6qBiieT5RQfsQvi0jWHP9TQejwolFKFa4IlobQhFrKnc5sMnUk3pxpU0m+iPfaGUIZ/j2hwutkgaNhG9wsB/DUzGBI6lFhCOQQ7IGUI5YQNZoPT5Q/tLWmjYbnvizSsx/jg1rs/uw96EE4ADdK0MTKKqiun3WOe0ElA5pT7QQpq+KjLT0m5kYq8FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Tue, 23 Dec
 2025 00:35:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 00:35:56 +0000
Message-ID: <c238c6bc-137e-414e-87d9-862e8da20e55@siemens.com>
Date: Tue, 23 Dec 2025 01:35:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add support for BeagleV-Fire
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>, u-boot@lists.denx.de
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Yao Zi <ziyao@disroot.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Cyril Jean
 <cyril.jean@microchip.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <20251209114521.164647-1-jamie.gibbons@microchip.com>
 <8dc60721-bfd3-4421-9b47-956c18314fc3@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8dc60721-bfd3-4421-9b47-956c18314fc3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3477:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c051f98-3387-4570-7825-08de41bb3c8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS9HQWR6NWpGdXJmRC9laUJjaFVzeU9UcXllNm5iQVdyZTEzYWFEZDlFcTgx?=
 =?utf-8?B?M0hZcHBPTm5xUlRLTEl4YjFOZWsvV016TlkrY1hzVG9aaXlJZE5EYnU0T3dX?=
 =?utf-8?B?andLWW1FeE1lNDRoVElCeXR1NWZ5Sm5VZWdGV2ZrcUNES29wMm05Uit1ZVlY?=
 =?utf-8?B?bTZmRG02ZU9OMnZzd25XQkxubFFsM0pmckVxUHpJQjdLZjVEZDVMSlR4WmhL?=
 =?utf-8?B?N0dQRDhXR1VSYXd3MkowSnJUcVpkUk8zMHJpOHh6NmRZcm9zM0JKYUpZTTQy?=
 =?utf-8?B?UUxiV1hkYWQrc2NNM040RzNEeWdPK0Z0Z3VYVmYzaDRveHFQZkY4L0hKWU01?=
 =?utf-8?B?b3Y4Q0w4WUFPcFJNWm1mTG5SN0k0bGhPeVp3TS9Xd2dGbmpvVVQ4UFcvcklo?=
 =?utf-8?B?TVAwbEsrNWlMUlBIeDNDM1loWmFEcVdHSWsvQ01LNXFmU1FkcFdaNi9NMTcv?=
 =?utf-8?B?Y1RpM2JIZ0RrMy9VcFVLYXhZdlRHRDlpcXY2dHpOYnJoVlVPTWpFS0Z1WW5o?=
 =?utf-8?B?S2o2WnNwcnJUNG4xdU50aEUwVTZFL213RG0zUnNwTDdleTFOTUdsLzhUTnVl?=
 =?utf-8?B?L0JNRUZGY1hQSFJVb2hEOVVTV0s3RnZnNTF0NThBNmNHZnQ3ajhmV3c4UFVN?=
 =?utf-8?B?ejVlUDFuNFVKUkpRUlYwUDZHN3dzVFh5dVZCVTUxZGdMeFJ6ZHRtemtFaGxy?=
 =?utf-8?B?M2Z0RFFUNWxiOEdRb0htcndkbXJQeTZXb1NCUEtqTEp1MVNvS2I0Uy9wdUNm?=
 =?utf-8?B?M0hNby9RQnFUT2dRRVdCMFpTbGVjUXJzWHBiNU13K3QxdXlkZUhTcTlZQ1ds?=
 =?utf-8?B?WWhwdVkyU1hGMzdHVDlaenNWSEx2NjlURXh0Z1pNOVU1cFBhZWg0eDR2M1R6?=
 =?utf-8?B?QUNuZGU2eEwwdzNUemZLL05OdXNIUVpHZTZCYmtFUWl2K01ZOCt4MXFEZmtE?=
 =?utf-8?B?UThiUzArNDNyZEl0RmxtOHh6RnBjSU5JUG80NHkwY3ZLTFZEYnVRQ0NVdzNO?=
 =?utf-8?B?QVlhSUozdDNIUUROcHVlR1lGdWE2V1pTT3FCalIvUWR5aWE1Yzk1VVNDQjBC?=
 =?utf-8?B?cE02eFUrYTJXcXpWR0FTbHlUbEZYVlEwajNXUjJTWGRqL1FjeDU3ZXFuMmRF?=
 =?utf-8?B?WkRpbXBoUGhoazUzWmRIWHBVV3hablZSOHlDa0F6WCtTK0VUaHM2N1dObVlq?=
 =?utf-8?B?eGhVRHRpaTNZTlp6WHl4NW05VnFVclMyNVovdGNucDhwR3o5QklLOEJ2U1B1?=
 =?utf-8?B?VUNGUDBmNmlpRk5id3o4K05sUEFYdnpXVnI5QlhSek9lbXNZSXVzNGdFYU5l?=
 =?utf-8?B?d2YzbWUzU0s3c2RTWk4vOW9MSmpobFNzZURLcjVLWDZocHp0SUhZVy92dHlC?=
 =?utf-8?B?YTIzcVV4cTZESVJuZnhQZzZkMkRjdWxJYTFleTVTMGJKUkVrQWVXSFVKZytJ?=
 =?utf-8?B?dThyVXo0WkltVWZsZmd2bnR4Q3NMMUtpVFZKOThvamVFUHByS3NMUlVkZC9B?=
 =?utf-8?B?MnNHcnNiMVdWcEs4NXFWUlBudFZvZ2s2RnVOUllJRUJtK1UvS3dENHJaRk92?=
 =?utf-8?B?dk4wRWJUUzhwUWo2TnFpeUhUS2MwNG12VWVudkJ2eTgwK0xmQ2ZQSVJrVFBy?=
 =?utf-8?B?bVpzQ2t1R2ZKZS9iektxQTAwdjRKUC9DRGlZM3dzMFF0V0I2V1ZzOG1FWmp5?=
 =?utf-8?B?azAzUWJHSEJBZ3Y2bER0bFhQaUxHUCtRbTFRMXhPajNsSXJrRU55Z0dXVWdQ?=
 =?utf-8?B?YUlSQ2VkQ3hNV0NVYjFacS9GelZCemJ1Q3RkVEN2WlU1ZTFCQVY4cEczeGIr?=
 =?utf-8?B?bXlLUlpGS1V1QXRWZjdFcDUxcCtzTy80UTM0U0FpUC9RRnJJc3FrUXp2Vzlw?=
 =?utf-8?B?OHZUck5LbVkwS3VzQWt6Rm54U0pNSTlxaE9SWG9OcUpJTkw1RjBKSmRzN1BD?=
 =?utf-8?Q?55RWve81lpLwbXfbTcQ9WhhzJwfVgYP4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1dlOFMwVFR1WGZTSTV2S25WR0g4WGFpbi9KZHF3Vmx2VEFyQmlRbGtLMUMr?=
 =?utf-8?B?U1J5dHUwTjAxdS9yM09LL3lhWDdCWTJzbTBIQTVFbGR1Q1BVMHNyZG1Dbkts?=
 =?utf-8?B?MldVemg2alZZM1R4QXU2YVhSdXE4VWY4b2Y5eGE1cnVqaDZ6YXB6WWFvWTkr?=
 =?utf-8?B?a0paZ01rZjl1NmtRa2dwaHF6KzBtNCtiajBsYUNMbVBPZUM5VVMrZWFvQTE3?=
 =?utf-8?B?MS90VkhxUjBRdUFhSGlxdjR1bkhGVnEyNkIybE5tczRiTENwSzl6VXFjT0Y1?=
 =?utf-8?B?VkREbVhKaTF6Ymk1aDMvYWlLZDBMdjhuRm96eDNoWDFTbUJ3RFh5d1ROZmxE?=
 =?utf-8?B?OTg0ZitNMU5HMzV5SytWNDVyRThlZzl0eDBuMENFVEFzUE1ObzNJVEx4TTlP?=
 =?utf-8?B?Z2lEWENuMFdPZnJaSEJxWUZGbThFTEE3SnMrQVNtcWdLWlJITkZSQVdGbVlm?=
 =?utf-8?B?Y293bU91T2w4VmxsOS9vOG1sa0YyL3NpSjlVSUZvM3ozazRxSjRSYUgwc2Zx?=
 =?utf-8?B?QlZDTVgvcHJHK1Q3dXo0L0xKUFVzUGFSSk5JLytmaGlBQ2JSSUVHVzI4Rmhh?=
 =?utf-8?B?WURQYWl4L2VrdVAvWHZzL2d6SnVNRCtkcHY2NEdHRTE0L082empqL3AycjJV?=
 =?utf-8?B?RHFUczBOZTNHSHBkSFFMWTFjbkIzcklUQXAzZXg5NlZYeU5IaWNxRnpwaDFr?=
 =?utf-8?B?bFVMb3FpNFRFcXRUMldRMlZTSXorU1BjSUJlS04wcWx0K213VmhVZ0piZkNp?=
 =?utf-8?B?dXZYL2ZTZVZYYjBZWFozbmQrZUlERGdLV1hzTG96N0gwa2RjRUhEY0xkMzc4?=
 =?utf-8?B?UW1WUWMzRUZoTDNwVUFXNHNBV1BaS3ZuZHhBUk1XNU1ITFpGSlo1MDdZaXZS?=
 =?utf-8?B?U0xpOFk1c2h6cjRFV0VXbDBuZkJrUlBnekZTWWVDMUViSmYza1NjUFdwb2RG?=
 =?utf-8?B?aFRSd1VDeEVsbHMrZk9Kb2k3UlZ5RUIvcUl1eU9xQjU4Y2ZUR01TM3JjOE5V?=
 =?utf-8?B?QUZ2bzBiT2lYUzlJa20xbmFibGdmTkRMcDZQMU1WMHVkcElYUDNBL3l5dDFm?=
 =?utf-8?B?cjBTWVlRamtZUWRxNnBwWTY5MkM1Y0xWZ2xlQkYwZzVBaHEvRHhXQnZmazlL?=
 =?utf-8?B?SzZMcGNKVXVWOWpEdUwveWFWb0orQmtKS1dhTnNudDI0N0pDUlJicG1HRTdn?=
 =?utf-8?B?Tll6c3BJcHhZTmk0SlB0eHIzYStEVUh6OXpPblRrcldaQ3JjV2EvUjhkYStH?=
 =?utf-8?B?clJCVnl4S0VKZFhxa2YyZkpzK2Z2cXJlSkdDNGNxZVM4a2Y4NmJWSVdBd0g1?=
 =?utf-8?B?b0tiZ1U5d2ZQYnU1d3lVUzJjOXVQb282ejdPaHpPaUoySUtLVDRwWnFUQ2hW?=
 =?utf-8?B?Wk1peFM2bUZka2s1WFVEeS81T1M0SnF6WGxYZWYyTHQzYlRtOXROZDU2RE1V?=
 =?utf-8?B?NFlDbHNldFBrTTRITjJpQzJhdEtDOUFTMHRVblQraHFFd3lBQzNJblpBQnpo?=
 =?utf-8?B?NkNrU3JPN2MyYnp5dmdSU1Z1TXdyb0gvSTEvYlJtSEFYN3Q2SU52dkNxUERE?=
 =?utf-8?B?bkV4bnR1Y2s4MU1HMHVGa0pMZ3VVUVgxZFZ2K0hWUENLcUY0cU5GZW9yUnl4?=
 =?utf-8?B?WlQzUU11VTBMSjNabmpkbVd2eW8yWjBBRm55TDhNd054Mmp6NWJaZ0hVVTU1?=
 =?utf-8?B?SGN5OWdoYzdnUmZXSVZ5T1FIdU16TUxZc1RPZ1hsTEd6UWVnemRYb2daeWxD?=
 =?utf-8?B?SlpLM0t5Y1FoOWZVQzRsWVhtR2Urdmt5a3g4cmx5QXY4WDZaeXhwd2tnNE1V?=
 =?utf-8?B?TWRlR3dKNm5xTHp3SkhjRyt2bHNOUDZqOE5ydVNNOG5XMUhmOWNrcFZwd0E4?=
 =?utf-8?B?eFNoWCtseE5YYlVDTkVWMHFXNUtVMldDVUFvZ0U1enZBRks0Y3krdS9FNDNx?=
 =?utf-8?B?Q3d1MC85eURsZXd4UENKMDZFYWxaZTA3MmhkQ3lKZ2ltNmJlZ1ZJRUNWTjVO?=
 =?utf-8?B?THBjcExUNmFXZ3M2ZVFLSVcrR2MyWEVsdWE2S1o3cE1FdU1HeEJOTnR4OGNs?=
 =?utf-8?B?bVZYMndkSU9wUGtzVFdYdVpFL0NVOXYvN1VLUTVRZXNHV0gxVFNGNjFnSXU0?=
 =?utf-8?B?WFhhUTZnNUxhUml6WEN0TnJyTkt2cHcxelExQThqZ3lkLzRRa1ZtU3BnL2hp?=
 =?utf-8?B?RXRUL0FMSUpwek5lVmh6VGRBNXJheXdRRDJSdUhvb2NuYlRiQWZiYmhmRTFT?=
 =?utf-8?B?WGVoNU5WN3JJQmxSUExmeUlRY1I2Nk5SMkdNT1poVGY1ZnRkRzJQM3pvZWUw?=
 =?utf-8?B?S01kVkYvdXFnOGpBeWtmMUJvOHJHRnk2dmdxcFFyMjZOWnFLRWRjQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c051f98-3387-4570-7825-08de41bb3c8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 00:35:56.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26PLeCYlnRhB9oMYOW9ydUSS14FwpkuJGDZfgAOVkRtfPBxSIUULh3FZvXg6zp/evVSLwj3A59gTf/APkCtqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3477
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

On 20.12.25 15:56, Jan Kiszka wrote:
> On 09.12.25 12:45, Jamie Gibbons wrote:
>> Bring U-Boot support for the BeagleV-Fire by adding a defconfig and
>> supporting board files etc.
>>
>> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
>> ---
>>  arch/riscv/Kconfig                       |   4 +
>>  board/beagle/beaglev_fire/Kconfig        |  39 ++++++++
>>  board/beagle/beaglev_fire/MAINTAINERS    |   7 ++
>>  board/beagle/beaglev_fire/Makefile       |   6 ++
>>  board/beagle/beaglev_fire/beaglev_fire.c | 117 +++++++++++++++++++++++
>>  configs/beaglev_fire_defconfig           |  29 ++++++
>>  include/configs/beaglev_fire.h           |  57 +++++++++++
>>  7 files changed, 259 insertions(+)
>>  create mode 100644 board/beagle/beaglev_fire/Kconfig
>>  create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
>>  create mode 100644 board/beagle/beaglev_fire/Makefile
>>  create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
>>  create mode 100644 configs/beaglev_fire_defconfig
>>  create mode 100644 include/configs/beaglev_fire.h
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 265b5320777..dd98dee8eab 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -17,6 +17,9 @@ config TARGET_ANDES_VOYAGER
>>  config TARGET_BANANAPI_F3
>>  	bool "Support BananaPi F3 Board"
>>  
>> +config TARGET_BEAGLEBOARD_BEAGLEVFIRE
>> +	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
>> +
>>  config TARGET_K230_CANMV
>>  	bool "Support K230 CanMV Board"
>>  
>> @@ -106,6 +109,7 @@ config SPL_ZERO_MEM_BEFORE_USE
>>  source "board/andestech/ae350/Kconfig"
>>  source "board/andestech/voyager/Kconfig"
>>  source "board/aspeed/ibex_ast2700/Kconfig"
>> +source "board/beagle/beaglev_fire/Kconfig"
>>  source "board/canaan/k230_canmv/Kconfig"
>>  source "board/emulation/qemu-riscv/Kconfig"
>>  source "board/microchip/mpfs_generic/Kconfig"
>> diff --git a/board/beagle/beaglev_fire/Kconfig b/board/beagle/beaglev_fire/Kconfig
>> new file mode 100644
>> index 00000000000..279d38b3aa9
>> --- /dev/null
>> +++ b/board/beagle/beaglev_fire/Kconfig
>> @@ -0,0 +1,39 @@
>> +if TARGET_BEAGLEBOARD_BEAGLEVFIRE
>> +
>> +config SYS_BOARD
>> +	default "beaglev_fire"
>> +
>> +config SYS_VENDOR
>> +	default "beagle"
>> +
>> +config SYS_CPU
>> +	default "mpfs"
>> +
>> +config SYS_CONFIG_NAME
>> +	default "beaglev_fire"
>> +
>> +config TEXT_BASE
>> +	default 0x80000000 if !RISCV_SMODE
>> +	default 0x80200000 if RISCV_SMODE
>> +
>> +config BOARD_SPECIFIC_OPTIONS # dummy
>> +	def_bool y
>> +	select MICROCHIP_MPFS
>> +	select BOARD_EARLY_INIT_F
>> +	select BOARD_LATE_INIT
>> +	imply SMP
>> +	imply CMD_DHCP
>> +	imply CMD_EXT2
>> +	imply CMD_EXT4
>> +	imply CMD_FAT
>> +	imply CMD_FS_GENERIC
>> +	imply CMD_NET
>> +	imply CMD_PING
>> +	imply CMD_MMC
>> +	imply DOS_PARTITION
>> +	imply EFI_PARTITION
>> +	imply IP_DYN
>> +	imply ISO_PARTITION
>> +	imply PHY_LIB
>> +	imply PHY_VITESSE
>> +endif
>> diff --git a/board/beagle/beaglev_fire/MAINTAINERS b/board/beagle/beaglev_fire/MAINTAINERS
>> new file mode 100644
>> index 00000000000..a5dad93ee99
>> --- /dev/null
>> +++ b/board/beagle/beaglev_fire/MAINTAINERS
>> @@ -0,0 +1,7 @@
>> +BeagleBoard MPFS BeagleV-Fire
>> +M:	Cyril Jean <cyril.jean@microchip.com>
>> +M:	Jamie Gibbons <jamie.gibbons@microchip.com>
>> +S:	Maintained
>> +F:	board/beagle/beaglev_fire/
>> +F:	include/configs/beaglev_fire.h
>> +F:	configs/beaglev_fire_defconfig
>> \ No newline at end of file
>> diff --git a/board/beagle/beaglev_fire/Makefile b/board/beagle/beaglev_fire/Makefile
>> new file mode 100644
>> index 00000000000..a4109a8aad4
>> --- /dev/null
>> +++ b/board/beagle/beaglev_fire/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Copyright (C) 2023 Microchip Technology Inc.
>> +#
>> +
>> +obj-y	+= beaglev_fire.o
>> \ No newline at end of file
>> diff --git a/board/beagle/beaglev_fire/beaglev_fire.c b/board/beagle/beaglev_fire/beaglev_fire.c
>> new file mode 100644
>> index 00000000000..b2f18c455b7
>> --- /dev/null
>> +++ b/board/beagle/beaglev_fire/beaglev_fire.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2019-2023 Microchip Technology Inc.
>> + */
>> +
>> +#include <dm.h>
>> +#include <dm/devres.h>
>> +#include <env.h>
>> +#include <asm/global_data.h>
>> +#include <asm/io.h>
>> +#include <linux/compat.h>
>> +#include <mpfs-mailbox.h>
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define MPFS_SYSREG_SOFT_RESET	((unsigned int *)0x20002088)
>> +#define PERIPH_RESET_VALUE		0x800001e8u
>> +
>> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
>> +static unsigned char mac_addr[6];
>> +#endif
>> +
>> +int board_init(void)
>> +{
>> +	/* For now nothing to do here. */
>> +
>> +	return 0;
>> +}
>> +
>> +int board_early_init_f(void)
>> +{
>> +	unsigned int val;
>> +
>> +	/* Reset uart, mmc peripheral */
>> +	val = readl(MPFS_SYSREG_SOFT_RESET);
>> +	val = (val & ~(PERIPH_RESET_VALUE));
>> +	writel(val, MPFS_SYSREG_SOFT_RESET);
>> +
>> +	return 0;
>> +}
>> +
>> +int board_late_init(void)
>> +{
>> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
>> +	u32 ret;
>> +	int node;
>> +	u8 device_serial_number[16] = {0};
>> +	void *blob = (void *)gd->fdt_blob;
>> +	struct udevice *dev;
>> +	struct mpfs_sys_serv *sys_serv_priv;
>> +
>> +	ret = uclass_get_device_by_name(UCLASS_MISC, "syscontroller", &dev);
>> +	if (ret) {
>> +		debug("%s: system controller setup failed\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	sys_serv_priv = devm_kzalloc(dev, sizeof(*sys_serv_priv), GFP_KERNEL);
>> +	if (!sys_serv_priv)
>> +		return -ENOMEM;
>> +
>> +	sys_serv_priv->dev = dev;
>> +
>> +	sys_serv_priv->sys_controller = mpfs_syscontroller_get(dev);
>> +	ret = IS_ERR(sys_serv_priv->sys_controller);
>> +	if (ret) {
>> +		debug("%s:  Failed to register system controller sub device ret=%d\n", __func__, ret);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = mpfs_syscontroller_read_sernum(sys_serv_priv, device_serial_number);
>> +	if (ret) {
>> +		printf("Cannot read device serial number\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Update MAC address with device serial number */
>> +	mac_addr[0] = 0x00;
>> +	mac_addr[1] = 0x04;
>> +	mac_addr[2] = 0xA3;
>> +	mac_addr[3] = device_serial_number[2];
>> +	mac_addr[4] = device_serial_number[1];
>> +	mac_addr[5] = device_serial_number[0];
>> +
>> +	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
>> +	if (node >= 0) {
>> +		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
>> +		if (ret) {
>> +			printf("Error setting local-mac-address property for ethernet@20110000\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	mpfs_syscontroller_process_dtbo(sys_serv_priv);
>> +#endif
>> +
>> +	return 0;
>> +}
>> +
>> +int ft_board_setup(void *blob, struct bd_info *bd)
>> +{
>> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
>> +	u32 ret;
>> +	int node;
>> +
>> +	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
>> +	if (node >= 0) {
>> +		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
>> +		if (ret) {
>> +			printf("Error setting local-mac-address property for ethernet@20110000\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +#endif
>> +
>> +	return 0;
>> +}
>> \ No newline at end of file
>> diff --git a/configs/beaglev_fire_defconfig b/configs/beaglev_fire_defconfig
>> new file mode 100644
>> index 00000000000..c476fb103c5
>> --- /dev/null
>> +++ b/configs/beaglev_fire_defconfig
>> @@ -0,0 +1,29 @@
>> +CONFIG_RISCV=y
>> +CONFIG_SYS_MALLOC_LEN=0x800000
>> +CONFIG_SYS_MALLOC_F_LEN=0x2000
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> +CONFIG_ENV_SIZE=0x2000
>> +CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-beaglev-fire"
>> +CONFIG_SYS_PROMPT="RISC-V # "
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> +CONFIG_SYS_LOAD_ADDR=0x80200000
>> +CONFIG_TARGET_BEAGLEBOARD_BEAGLEVFIRE=y
>> +CONFIG_ARCH_RV64I=y
>> +CONFIG_RISCV_SMODE=y
>> +CONFIG_FIT=y
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_DISPLAY_CPUINFO=y
>> +CONFIG_DISPLAY_BOARDINFO=y
>> +CONFIG_SYS_CBSIZE=256
>> +CONFIG_SYS_PBSIZE=282
>> +CONFIG_SYS_BOOTM_LEN=0x4000000
>> +CONFIG_OVERWRITE_ETHADDR_ONCE=y
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> +CONFIG_BOOTP_SEND_HOSTNAME=y
>> +CONFIG_SYSRESET=y
>> +CONFIG_MPFS_GPIO=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_DM_GPIO=y
>> +CONFIG_MMC_SPI=y
> 
> I think you are missing CONFIG_OF_UPSTREAM=y. I applied this on top of
> next and only got things compiling after turning it manually on.
> 

And another issue: CONFIG_DEFAULT_FDT_FILE is missing, leaving fdtfile
uninitialized which means that distro_boot is incomplete.

>> diff --git a/include/configs/beaglev_fire.h b/include/configs/beaglev_fire.h
>> new file mode 100644
>> index 00000000000..e3ee0f02f2d
>> --- /dev/null
>> +++ b/include/configs/beaglev_fire.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2023 Microchip Technology Inc.
>> + */
>> +
>> +#ifndef __CONFIG_H
>> +#define __CONFIG_H
>> +
>> +#include <linux/sizes.h>
>> +
>> +#define CFG_SYS_SDRAM_BASE       0x80000000
>> +
>> +/* Environment options */
>> +
>> +#if defined(CONFIG_CMD_DHCP)
>> +#define BOOT_TARGET_DEVICES_DHCP(func)	func(DHCP, dhcp, na)
>> +#else
>> +#define BOOT_TARGET_DEVICES_DHCP(func)
>> +#endif
>> +
>> +#if defined(CONFIG_CMD_MMC)
>> +#define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0)
>> +#else
>> +#define BOOT_TARGET_DEVICES_MMC(func)
>> +#endif
>> +
>> +#define BOOT_TARGET_DEVICES(func) \
>> +	BOOT_TARGET_DEVICES_MMC(func)\
>> +	BOOT_TARGET_DEVICES_DHCP(func)
>> +
>> +#define BOOTENV_DESIGN_OVERLAYS \
>> +	"design_overlays=" \
>> +	"if test -n ${no_of_overlays}; then " \
>> +		"setenv inc 1; " \
>> +		"setenv idx 0; " \
>> +		"fdt resize ${dtbo_size}; " \
>> +		"while test $idx -ne ${no_of_overlays}; do " \
>> +			"setenv dtbo_name dtbo_image${idx}; " \
>> +			"setenv fdt_cmd \"fdt apply $\"$dtbo_name; " \
>> +			"run fdt_cmd; " \
>> +			"setexpr idx $inc + $idx; " \
>> +		"done; " \
>> +	"fi;\0 " \
>> +
>> +#include <config_distro_bootcmd.h>
>> +
>> +#define CFG_EXTRA_ENV_SETTINGS \
>> +	"bootm_size=0x10000000\0" \
>> +	"kernel_addr_r=0x80200000\0" \
>> +	"fdt_addr_r=0x8a000000\0" \
>> +	"fdtoverlay_addr_r=0x8a080000\0" \
>> +	"ramdisk_addr_r=0x8aa00000\0" \
>> +	"scriptaddr=0x8e000000\0" \
>> +	BOOTENV_DESIGN_OVERLAYS \
>> +	BOOTENV \
>> +
>> +#endif /* __CONFIG_H */
> 
> No luck with booting next(29ab19c2bead)+this yet, though. No output after
> 
> [9.356454] Boot image set name: "PolarFire-SoC-HSS::U-Boot"
> 

This is probably some regression when using u-boot next.

> Am I missing dependencies?
> 

I have now this queue on top of v2026.01-rc5:

riscv: Add support for BeagleV-Fire
riscv: mpfs: move SoC level options to the CPU Kconfig
riscv: create a custom CPU implementation for PolarFire SoC

With this (and the config fixes above), upstream U-Boot finally starts.
Also UEFI is working while it is broken with downstream
linux4microchip+fpga-2025.10 which caused a lot of confusion to me
regarding the upstream kernel status of the PolarFire.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
