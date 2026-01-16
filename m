Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDC1D4A609
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E3783015;
	Fri, 16 Jan 2026 09:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUB1RSvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F042583623; Fri, 16 Jan 2026 09:19:14 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A8B80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuY22xMZmOVkKeD542RHqcO84TX778hn3mn9K00zPkh8ifPD31d3U3OzFfo/V6+pmAkI23+9vjmtW2pGnPewVavB6M0IaTh9VFyMEE4gzvqj7GFNXawMewEgreSERLr6FxCyLtYlROaJLwhyGCtT5d3oDd+cafD2sEM+Is+Egdqx802S3WMzBhlW7TjgIf5TUZMiG7O415ZclzX2JUw3HVuwJz3KUN4ocbqFGFk6v4eq0tcqliyfTAVylXn20XGVgBfpBBzX8HlvdZfDlqsmZgRlJUP8BJ0twLPZ5lZwVwhGh70mYGj3KhaAUD8PKmcBDgppNMCs0crqeRftGEoLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q54wZm6hekhKU1gXeL3syz4H66ePh6L8EOJYVXVJyPo=;
 b=ZNxMy7h7FLkAdAK2YYXkFTxQrCxWp4jXFN64YFVvgBdSDUogs057kg2w4XEOr+aHYuWEyMdYWUYgqCOJcJUGQWufftZBO/xP1uq2SWm21X3nhR3IDsH38XGxpBCQ6J79VqB9TOWuxPpI65N/XH7nrYA67ptRI2DQhWup4O/KGppgykL12glHoXvbcRyIrlKTbZMz7W4yDHLj+M/VfybrU6g31NtJVk9cBGWUqzQb9IZM1chmH+hR1j1llGp7uvKVwX5nI+YtCB/pnBss8GjsKp+LfGNU9lwNgGweXUuFjuyt/vHN0Jyv+H8iijvROB/2y5/pw2OjZbxsU9Lp28FTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q54wZm6hekhKU1gXeL3syz4H66ePh6L8EOJYVXVJyPo=;
 b=dUB1RSvcFpk1h6AbrwiixyaadZPdDYgf+yp4ErvTFOILqS1L1sJ6j7k5C6vK14x4cF1sSuF0fYCAOh1n8XL6tr6YY7hCGKoHGU4tFv1u9gOhZJMHskTCEzZJe5aVFe1DKdcPEevvg1pJZvq0cbNeUASBpiw7k92pRhS1Jylep2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:19:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:19:09 +0000
Message-ID: <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
Date: Fri, 16 Jan 2026 09:19:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Initialize Xilinx glue registers
To: Sean Anderson <sean.anderson@linux.dev>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20260106221728.738219-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260106221728.738219-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 7754ef52-b431-4221-e9f7-08de54d7ec19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkNlZ1BybUFQQlBTeEp6dXBoSnc2UkRiS3ZsTlhoNnprZzgwZk5mdjE3QmIr?=
 =?utf-8?B?cmRYR0xIci9WTWl4MVE3TlpWK0xvQlR3UEZ5WEJDR05KWXM1QUVEMFRkNGNJ?=
 =?utf-8?B?blFlaVFOZFpES1FZOGhhTGVnamk5cCs3bytVaklVNTBQVGhSSituNitHUzRK?=
 =?utf-8?B?Zi9MNTR3U2hYNHFncXlaTVlIL0lQMGlGK2M2RHErTXloYmJwVnhmZEZIYmYz?=
 =?utf-8?B?WU5lNlJRSy9FNlZaSDcvMG9vL0pGc1prakw5SXl1YkIwanlpQ2tqdWR0STc0?=
 =?utf-8?B?VjBNK1VsL2VEZ3owNE54TGJ2ZmhDSWZTUTdBR3ovRVlyOXNvNnJqNUsvR0R3?=
 =?utf-8?B?ZS91ekx0Uk1MUVhHVzBscmpJSzhBNkI1RXFORTdWN3V5VHZpWUlLM1VkaVpx?=
 =?utf-8?B?OGh1dXVwaUhyNEZsSDFhTHNtbHhUMnVqYUZKcjlnczZ5dWFqdmIzckZ6bHVT?=
 =?utf-8?B?eGUrb0NSLzlVanFqNjAydDZGdXNzN2FOVkJqRHkyV3VmVXVWMS90UmVMRHQ1?=
 =?utf-8?B?Z0FrTnBYdHd4TDR2YWJGYitEd2N2c1IyRnhEWGRCTzVPMysrbDZlL1hmZnND?=
 =?utf-8?B?dGFCVVRFTjVIdXFYaEtRY3NsZWNNMklRQmZqNEtkVHJnMU50Q2hOUEZmOU4r?=
 =?utf-8?B?NzREUmxycEhrWGFPREdwVnNsSDl3dTVrUklBWnJoWkpmTk5TK2ZkVURKZTBo?=
 =?utf-8?B?TlFsdHdPejZIaXMwNUJURkMzc05BSnFYdUtlWDdLa292OHpBL3I4UDZyRVoy?=
 =?utf-8?B?NTBoWTUrMlk4SjZtekptNUNWNCtDTWxiUkUxMEFRYU1EWlRERGJDVVpFNTVS?=
 =?utf-8?B?WU1yUGpBVEFXL01NOEVlSXhiMk9NMmZIc1pkWEFUbGxqTHVoVlFYbGtVbVJD?=
 =?utf-8?B?amVLSnQvRFY5TER1TmxONHpscUdqT3JHeDZzNnord0w1UUlSbVV5MGZGcDFp?=
 =?utf-8?B?eGZwY1ZMNTJZeVFsb0s3a0lTZ1BOMHpLbHpsT0FnS29iMzR4YTMrWGpsS25Y?=
 =?utf-8?B?NTRFRFMrSXMxSWV2bU5YQjM0Z2E1emxyQlhlMm5CU1pWMm5ranlBY1gzM1hj?=
 =?utf-8?B?dVRGeDI1QmpueDIzYmdUZWlCU1B0aFVNL0dVUkpMT0JpY1VVV3NhT0pndWZY?=
 =?utf-8?B?aXROVUhBeVNSNlBING5MaVEvKzlRR2lCQWsvVmptM1JoRGhXQnFkaXBGVFFK?=
 =?utf-8?B?M1RCSGFidlo2SWlmVXV4UlhkMTJBRzNOT2ZwR0M0RkxndDVJakhkK2VqVGtR?=
 =?utf-8?B?c21waFhsKzJ0R3VISnNsdkpJVWtudjFHU2NnaTBKTElORkFSdlN4emhZc09D?=
 =?utf-8?B?T2dENU15K0NhWFdXamdQajd3ODZaZ3pEd1N6cjZPVkVINlJKdnR0TkNaTDZY?=
 =?utf-8?B?UDR2cXIyNXpnNHR1dU8zS1pZUGhPQjg5dk1wbElQd2prWUFHMHdUc2w2TnZo?=
 =?utf-8?B?M3BoVW9FUTdxd3ZhelJoc1gxdzhPRU10RUFqQ2lDdDZ4YkN5M3JDelBXWmFC?=
 =?utf-8?B?RzFxSmhRUHpQZXllMzFhdndadDhOamFjL2JJblE3MEYwQnF5eU5EUEJodzRR?=
 =?utf-8?B?aTIxQ0xORkFzczdlOGVYenBJZnM5cHVHdkFiSno4R3Q3OXprNWVuWTZqNW5N?=
 =?utf-8?B?SnBUMW42MG4vbWFPWmNzRUtYbm9IejBvdXNmZjJiUm84R0NBeUxaUGJaM2VV?=
 =?utf-8?B?ZFdvRGlwdXVtbFgxdHQ0Wk1uSFZVVFRLU3JSUGttUEw0YStMQkZCczZGR2pH?=
 =?utf-8?B?ZFhlWHZIYUllWlJlejdJSndmNHViVUpSd1c2U2tmbnNPOGRxMXNjZi9xOGlI?=
 =?utf-8?B?MG1sVkR4eHZNRFhrN2tzQS85K0VBRFV6WVlXYzNobCsrdlVsZW5Idkx1Z3hh?=
 =?utf-8?B?cWUrMllham8yd0ZNQ1FYb3VuK1BMNXJrNDVQU0UrYitVMjZBVTdSaXRXMXJK?=
 =?utf-8?B?SjRRSU5QNjFJQnBobnNzRDJEQ0FGaEJEbzdwR2szKzM3VFB0YUFKU3hvbEtn?=
 =?utf-8?B?VDlJT1VWMjNQbGo1Q2tKRm5FUElYSkJCOVdjcVpTOXVSTHlTdy8wRDdBSWZm?=
 =?utf-8?B?MlVLVHdIRGU3amdqbFdlcExkZUxBbDhkRG9UWC9HZHVra2NqdjU0ZHlSMnIv?=
 =?utf-8?Q?sNrE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHowcUR6OTRGeVZqcUJxQ1k4cERQMWNBRENnbHFERkVBbDQ3ZlBWVVJ2MUF6?=
 =?utf-8?B?OVBHTXo3dkxJZFQvb3ZIZmZKVHlQZkFCaFVlU0FtYlZRWEJsMTJaQTBkSGxn?=
 =?utf-8?B?RE1vMm1rbHBMTkQrd0pGM0s0MHFCUmJrdVRNOThRT1JITGZrdUZxenZIMXM1?=
 =?utf-8?B?UkN6Z3BxYzBSSFFTY29VZ0k0TkQrRkQyOGg4NDNpK0FFZFpibXZRY3pqa1lF?=
 =?utf-8?B?WjBGNG01c1JwenBUWWlmelVCcW1nT1YvaERqdnlBd3JzMWNUbW4rN0U0T2xZ?=
 =?utf-8?B?dVdwNGdleEp3WEppRVdsK0ZKUlh3UEY1ZWtCbUFxNjd3cXVSRDRvNDVQZElC?=
 =?utf-8?B?TG1oSDhmMFhGY0FDendKaVU2dWNwNFdQcmVqc001UHFVOXdIazNaT3psZ29B?=
 =?utf-8?B?U3lzY09HVDlGS0lxaGpjRTI2TWJHc2Mydng2aVJjN21OQm1hN3pHVEI5UzBw?=
 =?utf-8?B?MVBiWTRsaHBWWDBjMENGb1F6TndEb3M0NnVSYm5qMTVLbjBzd3U4MWlKdFF3?=
 =?utf-8?B?eHdDdzVoaHZYWXhNRzlsRStjaWd6elFpcTMvSVpMZ3BkaUxoTXpGYkthUnBn?=
 =?utf-8?B?RnpUSms4RWxVc0JqVzkzbUd0c1BTamFCR0NPcUZ1VXB2b2RCNHFIZTlNSTdG?=
 =?utf-8?B?Z2NsbExqK1g1enZoVndvVkdjTlBqY2lWcUMvUjRvR2h2Um44Q0ZjeFJVRG5y?=
 =?utf-8?B?OTNIUHRyV0Z1U240V1lUVWJOcklSSlpJZlBhYStTOFlEU3VNTE1uWFJNYllV?=
 =?utf-8?B?cXMrRGxaTXh1SjNOTnRYN0YvcDdoUDBvWDAvbEhwMmE2WncrQW1IS3ZvN0hs?=
 =?utf-8?B?RjE4NWxFOFVjNDY1OGVDbVFxQUFGNWpHRnMzTjZ1NDVPUGVVS3RleTdaQ25x?=
 =?utf-8?B?VTZMelZMWE5KMjVVR1o5dVdRajBPOE96Mi9BZis0Q2dseHVCN2NGTGZLWDdv?=
 =?utf-8?B?RE1rN3F3RmFFUGg3VWZNUC9CV2hSLzY2V1Vic3NxWk1QQjYxWDhoRjMvdHox?=
 =?utf-8?B?aGVzRjZQRVhudVpWMUZiTEJINTZsV0VmQkp2L1BuS3pkNkdvYUw4MGRVKzI5?=
 =?utf-8?B?NzMvMzNFb3crQ1pVR1BOL2xNL2tTKzl4c2FoQW1GYVJNM1RYT1FtNHFvMWxF?=
 =?utf-8?B?RVpzNlFUT3V2Y3F5M3p4Y2d6bm1vaTgrNmRFSXVYd254bHF5Y1BYU0FGQUQ0?=
 =?utf-8?B?emVBV2FLU2FyYTc1MHczTTNrU1dDNTl3VUdNaGtNSjQwWjAzVmRnWlEwMmVn?=
 =?utf-8?B?MUVuRGVxaFdaQ014Z2FUTVdCQ2dWVVhMMHVXYUtkK2FBZGFiVGtQMnV6WjVy?=
 =?utf-8?B?NzdmZnZkd0FjVFZtNWNnY29VKzZvWnJ4akgxdHliU2djMktYRlhjL0QrQURH?=
 =?utf-8?B?ajE5VzlMMG9TVldqTUp0b3E4L1JnYVF0OXNFUTdlSHhiVDZ0dS9FZEIrRTBV?=
 =?utf-8?B?Z1ZTcUlYMkNJQi9qWEtndjd2aytKbzRNZU5rTFo2RSt1U1NJUlRtWVJXYk40?=
 =?utf-8?B?MUxsT3VVWTZhUXUwMk4vWjdVTE45VEtLSktMWERzTS9DR294TWZYcGgrZm9P?=
 =?utf-8?B?bHgyVjJaTnNmcEppbWdNYmxXbytCd3J5RklxYmhtOFpTSzQ0TnJkeC94Kzh3?=
 =?utf-8?B?TXBXRy9ZZ25Zd0g4bjRoTHI1d082bS9jSGw5aEZpU2FMUTY3RU45akMyMDIy?=
 =?utf-8?B?OGtRVlFvZ210UUlpNDljYmtxNTUzR0RrTVVDY2NCZUovRjFzNXFobzMydzJG?=
 =?utf-8?B?djBGZTBTT2tIN3lWRTJFbUQ2TUtoZCtVRTUxdDFoMGdWYWw3bnJZamI3bThn?=
 =?utf-8?B?UG14bTNka0x4S1J3WXBBZE9VRXo2ZDJJaGQxRUd5MVF3RkM2UkZxejZoQ2Iz?=
 =?utf-8?B?SHhSekVIWExpeWdZck41eUZDNnpWbm5FR0hiWUxDSWUzTUN4cXRHU0hwRDdD?=
 =?utf-8?B?TU92bitHemRBNHpVcVcvT20wRlNDTXp5TDhtMkkrREI5UzA2bDNQQnp4V0tW?=
 =?utf-8?B?STZxcG1ETWMwbHlsSDhNeWN3ZVRpcW5vUm9WYkRsQUNnR1dUMkk1TExMZUdi?=
 =?utf-8?B?YmRPc1hvYVFJMUFzVGlVSmFUYkg4ai95cHc5cU1hRklUcnFDb29JbGpLcDdG?=
 =?utf-8?B?aVBWT0xBV0x2RE5mMjdYTFh2TVhiL0pnS29FZldXME9Md0x4OXByZDZtQWhB?=
 =?utf-8?B?ZExEV2hBbVFtcGFxbi9IdWhSTDVNY3NTSnBVQnRmMm13R1BYeVZldENqVzIv?=
 =?utf-8?B?MU1HU3BSN2dJb1I1V25GeEgyejNSTVpwTERGUTEwS2VvNVVxeHU0Ky90QlVG?=
 =?utf-8?B?SFlTT0Z1c0hGWWlVMWF6dHlsWis3ejNQUGNMZWtLZm1sMEJPTWtOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7754ef52-b431-4221-e9f7-08de54d7ec19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:19:09.0266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD8KkjixiAZVXHDHUEae0uIGmL6avwLHsqA04Qps3TqEIvqL1Z1vxcbHSATOpGJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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



On 1/6/26 23:17, Sean Anderson wrote:
> These registers may have been initialized by SPL/FSBL, but program them
> in case they have not. If they are left at their default values, the
> controller will never exit reset.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> ---
> 
>   drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
>   drivers/usb/dwc3/dwc3-generic.h |  2 ++
>   2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index c09014aec60..ce896db9532 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
>   	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>   };
>   
> +void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
> +			      enum usb_dr_mode mode)
> +{
> +/* USB glue registers */
> +#define USB3_FPD_PIPE_CLK	0x7c
> +#define USB3_FPD_POWER_PRSNT	0x80
> +	struct dwc3_glue_data *glue = dev_get_plat(dev);
> +	void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
> +
> +	if (generic_phy_valid(&glue->phy)) {
> +		writel(0, base + USB3_FPD_PIPE_CLK);
> +		writel(1, base + USB3_FPD_POWER_PRSNT);
> +	} else {
> +		writel(1, base + USB3_FPD_PIPE_CLK);
> +	}
> +}
> +
> +struct dwc3_glue_ops xlnx_ops = {
> +	.glue_configure = dwc3_xlnx_glue_configure,
> +};
> +
>   static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   {
>   	const char *name = ofnode_get_name(node);
> @@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
>   	struct udevice *child = NULL;
>   	int index = 0;
>   	int ret;
> -	struct phy phy;
>   
> -	ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
> +	ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
>   	if (!ret) {
> -		ret = generic_phy_init(&phy);
> +		ret = generic_phy_init(&glue->phy);
>   		if (ret)
>   			return ret;
>   	} else if (ret != -ENOENT && ret != -ENODATA) {
> @@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	if (generic_phy_valid(&phy)) {
> -		ret = generic_phy_power_on(&phy);
> +	if (generic_phy_valid(&glue->phy)) {
> +		ret = generic_phy_power_on(&glue->phy);
>   		if (ret)
>   			return ret;
>   	}
> @@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
>   }
>   
>   static const struct udevice_id dwc3_glue_ids[] = {
> -	{ .compatible = "xlnx,zynqmp-dwc3" },
> +	{ .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
>   	{ .compatible = "xlnx,versal-dwc3" },
>   	{ .compatible = "ti,keystone-dwc3"},
>   	{ .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
> diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3-generic.h
> index 40902c8923f..13f6391cae8 100644
> --- a/drivers/usb/dwc3/dwc3-generic.h
> +++ b/drivers/usb/dwc3/dwc3-generic.h
> @@ -10,12 +10,14 @@
>   #define __DRIVERS_USB_DWC3_GENERIC_H
>   
>   #include <clk.h>
> +#include <generic-phy.h>
>   #include <reset.h>
>   #include <dwc3-uboot.h>
>   
>   struct dwc3_glue_data {
>   	struct clk_bulk		clks;
>   	struct reset_ctl_bulk	resets;
> +	struct phy phy;
>   	fdt_addr_t regs;
>   	fdt_size_t size;
>   };

I will let Marek to handle this. From my perspective we should take Jerome's 
patchset to update usb stack and then add this on the top.

Thanks,
Michal
