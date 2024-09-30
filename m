Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5850CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 08:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F099882EF;
	Mon, 30 Sep 2024 10:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="REo6N7QB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BAB88BE4; Mon, 30 Sep 2024 10:38:41 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0130882EF
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 10:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj1u/im3jEBM8PcDtapWyO7id7r8JfmJh/LZ0SwtuJE9i13ezjHJzMSUUDBE12JpwmJT9yxNKrtfHVBHrTVXJ/y7nC2Z6389TusunI1Jm3xAyNZkOUbUZhZjKli8xYtkpq5x5FQ5hbpynTGnnmoDalWmxFoxOcTvDhPoNXL1uCwlGyz9XmX8wUY+HKOaGLpT45i2+k8kMd9+5+XuNovOPYSWYIDWdTNM76zxxZvFZXyD0nDTtyC879dUTQHKuHK/+bm58TmQOD+dK3R0FzfPxGDV7ER4R2cVgU4vNYEpkLdj6T197ZKQb9ljaeOcvC/fP1CRPvPOvPdPjKPaJu6XhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4OCzR0nMdMKFJBar4oxBHJ7kfQfh9Ccx5IEVRTtwLw=;
 b=PhFpveeIgqADxUUxDSMRR4mMh2V9Mq+kIcBkR0w5yAX6kJ09Klofr/qWWxpkgkVJzAWRnS6lePKO48CVzGWNP+tV4DVBc4KCLgLE+7M+SLoiO1OrS9hh/dpnr6Kr3elNOaJIfGBvA0iA4eH1uFpgSRpBwTjHnsKYazl40lmFi7vgb/+R49fqF44QI3D3HyA86y+sTqa2WH+ct7OUfaGnnIiQChbxLY835gIgtNDotJTzVQplO6qWX8vF5GCQDmbLXJwSAci8xk1Px+dR1pSWutKE4O7AoVufyRsAauXbnsyrI5gweYSSivZKAzRu+3optHhmCslx90xr+pSv2t7h2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4OCzR0nMdMKFJBar4oxBHJ7kfQfh9Ccx5IEVRTtwLw=;
 b=REo6N7QBVv7cJTl22XsEaXBqqNEfPEhZtldcWlGZdVMgoOoTvccGz/CZ2KV4df5KNJeFvWE7Qr29DWjGFUoxH79qkVMmGFUqYfpn0vCrPmbki1tE9L4lWT2X5wi/diTb7JIjizIpy3jjPwql9jTSH/EPuyveZgf9pdxVARYfUhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA2PR04MB10129.eurprd04.prod.outlook.com (2603:10a6:102:3ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:38:36 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 30 Sep 2024
 08:38:36 +0000
Message-ID: <73723830-60be-4968-bb88-f518e493361f@cherry.de>
Date: Mon, 30 Sep 2024 10:38:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/mem.c: fix undefined behavior in mem cmp
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240927-cmd-mem-undefined-v1-1-56fa57d0927b@cherry.de>
 <87bk09kjsd.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87bk09kjsd.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: a99b1a1e-21d1-4e6b-193f-08dce12b46a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2hGZDRyZU5WQmNocDVyVmRYNENXRC8vRzZvVFVUU3NHVzNXUHpDQXVvRmZF?=
 =?utf-8?B?WjVicUxJNjhFM2JSWTBIUFcrM3lzUm42SXNIQzN3S2RUTzIvWnNNb0o0cXBV?=
 =?utf-8?B?VWVpRnk0L0wram5wNS9RN1QvSTFZNUFHL3pLc2JtNk9Xd3l5SW5YVENkUzVC?=
 =?utf-8?B?Sll1eDlaWmpzdkROSW1iRk40ZjFIZXJyK3RwY1NTMkhzLzBzQU5LVzRaVGcz?=
 =?utf-8?B?Ri9ieWcva2ROek1OU2QyVGdMS1ExTTltdUx6Mm9nWFJJVkIrK3VnM3BtV0Nz?=
 =?utf-8?B?a0xLcnJjUDJPRWlkcFBkcXRsL0Z6ZzVITW5oQWJ5Nmk5QmphdEZIb1I2OUJL?=
 =?utf-8?B?VWt3NDd6a0JzcW1NWDI1dVRJUGhCOWdMZkpKcFQyTWVYbDd2M0tzbEhteTNY?=
 =?utf-8?B?S0hFcG5TVnFPYXRwem9hcDQyUTQ2OTdlN3NObHZ1Qy9KTWFPbWsvNEY2c3NT?=
 =?utf-8?B?SDR2b0F6NCtXalFWbEtVTVgwOGRSSm42Z3VGdGErYjhNRk9nenJIK0cxaEc3?=
 =?utf-8?B?OXFvbThPQTEydEdIREhIK3RtWEJQQ0lCbDY3VlB3bnRhYTV1d2Q3a0ptRW1o?=
 =?utf-8?B?LzNBczdPRUpqTGVNdjlQNm1hYlovM2FlclNBcVJodHJUMVd2MUJDWXNScmg1?=
 =?utf-8?B?R051anZGbEl5dkxSb2RNbjFkeUpqRXA4ajRycWFCQU5WUXpBNzdHanpDdUNo?=
 =?utf-8?B?cFJ4S3NseGlUQTdUWW84YnpPZkc2VmRDWmNXVDhwa28rSThxNzdCUm85Ykhi?=
 =?utf-8?B?Q3VlaCtmbUxvem0wa0lldFJXZ2ZkQTFGVnFKM2JETFFxWXU2cVhLaFZYVjFt?=
 =?utf-8?B?NjJhb1NjK1dQbEhrU2ROQWFCWkVRTnJNUTFJUjBxQlhpMG80TzQxNTJxVGM5?=
 =?utf-8?B?WEZsTUZWYzhBaHVpcFNxZDlsOXJzNmJsUGN4bHVML0FneE1kcXRjMGc0MXBB?=
 =?utf-8?B?K2NLNnJqVFB5M2RYZ2VsUmNQUEQ4VTRJTjVRU1NsVDhEM0J4R1V5SnBmaXVw?=
 =?utf-8?B?MlZsYVhETmp0N1pCc0ovWHBDQ3J1aFVWWjZKdXhncTRONkFzT0M1dHRZVjhq?=
 =?utf-8?B?WEFkS2lhaXBMWGNpNTRFOE8rTWtPRWdkb29mYlpIeEFQNkNkSHY5YzhrQXpP?=
 =?utf-8?B?MUZmNGJ1WGhXQzAvRVRUbFArSnlQUW56aC9PL21uaHBPL2xjZjRmK1FiSDZj?=
 =?utf-8?B?RnZFckFmSUZ0dU84RTF0d2pNK20rVzlST2NGd2dDMWlMZ2VuY2xCTDBMaEox?=
 =?utf-8?B?K0hSbTI0VXNzUXhrMU1qMSsvNGRSRU56a3B0RkFtWXk1MktpdG4xS3ZGbEkz?=
 =?utf-8?B?cHFNOUl4VVZKWEVyZytTZ2JaN3M5a2MxOHJPZUE3WGR6UjVDdGFVaWcyVDlw?=
 =?utf-8?B?VkptR05QME4xcDRiVXE4SWJKeGVkUmhMNTlLMVgraXExcXg4Z3UyODBlWjFY?=
 =?utf-8?B?N3FDWVE5RXliWTJ4Zzg3VHBLRjQ5dyszRmx6dStMSEpESWU5cWZZK1hySXJm?=
 =?utf-8?B?b0V3NjhLeWF5Smd0TWd1WlV0dzVTbGhXc1FDSEJyM0xFSiswcTNla3Bsemdo?=
 =?utf-8?B?cXFPeHU0UGp3VGpTVFlZZHRsaitNRHlxSzV6bVhFOG5QZHZGMXRyQk1pY1NU?=
 =?utf-8?B?OG9hczNFSGh3TnRrcGJvVkI1bkR1VzFkVkJmU3I1bklyblNxVDY3QnVuZ1VJ?=
 =?utf-8?B?eGRkZlhJMEwybi9hOFB2YlQ5WmlzUDhxVVlXSG1uYnJ2UUI0elhkazNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNLUHZVNkhwWmt2d2VycFJmaU5VbVpKNFM5YUFobXczUnF3T0Fza1FWNkgx?=
 =?utf-8?B?Ny9ZS21XdmJYL3lqMmFEL3hiUDJqYUQ5TUREc0tlMkdxMlZCbmtSWFAzT09u?=
 =?utf-8?B?UE5nbG9HZHRQbnNxZGVNM3dnelNrSmxCcnI0VCt2Zk5JUm9JdUZ5Nkd6VmJy?=
 =?utf-8?B?cmZMNEFrd2R1ZWQzbTl5Y1FGTG96RzlRWmU0YjdiMk42OEZvVitKMkk0MEdP?=
 =?utf-8?B?ejF5YThrTWhhSzQyaWpBN29IbEUrcUNNM3ZJR1YzL0NLYTNOZG9VMGFUTUVq?=
 =?utf-8?B?UVhqUHpjTVpIV3FsWjB6MG1qNkFRVk92SVJ3M2VMOTFaZi9KWU85cVB3UUZj?=
 =?utf-8?B?ZUxtdkRMcFV1UTlSWTdNTVN3VkI4NUFGZGVhNk85UjM4QkN6aDdIci9qRUts?=
 =?utf-8?B?bW8ySjdxeG1uVjhuVEJvNFo4SFlxeUFEOFJUeGlFWnE0RXNNNm4rTG1WK1RI?=
 =?utf-8?B?cU1RNU0zbXNBRnYwVVY1TURpS3VtZjlEejFpSjdLb2JHZ09NL3dxWkJvMlJn?=
 =?utf-8?B?R2ljTUVwWW1taGR4RWdBb1VxSzhZa3ErTUJlTTlIWXFLWUpoZGN6bVN0U25k?=
 =?utf-8?B?UkxCY0JmaElkTzZ3RkpMSFNMTmQxSlhMNU90SVdpKzBYTTdTbENQNzdEOUo4?=
 =?utf-8?B?VkFEVkU5NUlXam5FRXloN2pTS01qY2tDVkxRTFlrRldUSXdFdXBMekE4aHhx?=
 =?utf-8?B?ZTdPalVGN2pvT1ZiZTFPdGVvVU9KMzBzMnFuREtVbERKVWNwRjd2QzFFNENF?=
 =?utf-8?B?dXNLWDJSSXN3d2JGRjZTVkhGdk94VXJzbDdpdThwWEIxNldOYW50eFJ2RHZX?=
 =?utf-8?B?bm5OclNycy9lWFFwd0h6WFJtZXdzeWs3c2xLTWYzMDkzd09zYjc2WnRnWm9E?=
 =?utf-8?B?T3FnZEI5enpBOTJieGRPcC9ha0tNcUFIN0w4ZlNvK2RNQ3Yxei9iMnlSa3dP?=
 =?utf-8?B?SXFOUC9WbXMvczRIRDZRaENjNS9Ic0RsMFI5UHA1Tm1QUGtPbDdJRVczc3pI?=
 =?utf-8?B?Ry9haXRwS0VRZTFKZzFpNXN2NzBVNEVEVnFtRTRQLzREMmczWkpmckZ4VVpK?=
 =?utf-8?B?SEhRVkpuRlUrck1QajBWUm9lVGNaU0VNZEJxMHBqTG1SQytTeTJka21NeWdG?=
 =?utf-8?B?Zzc4azY1VE5Oa0IwYXdFcGxlNW1EUXJDRXVVdGJNNGpjcXM0eDVVdko3bnR0?=
 =?utf-8?B?dUU2N2J3VG0ybkNScU1pVEdtQ3orZVdETkM2QVlFM1FEL2U4cEMrNndYeU0y?=
 =?utf-8?B?Y3ppdXFqcjU0Uk93NEdmei9lZ1pnaWtPMHVGcmk4Rm42SzU3SnFoKzVObHd2?=
 =?utf-8?B?K2RYT29oVkJzM0NXczNJWk9XVmRvR0xnSzVaSVBRWHlnbVlsQjJUSisrdmdk?=
 =?utf-8?B?Tm1Wb29uamdQcHh3YjRqc3NZaG1NYVEyUHVUTzJSUmJ5bmFVSDQ4aDcyTFJV?=
 =?utf-8?B?NXBFQWZGV0ZYZVlISWROaUpBTHpSNFJObW45Z2tnYzNSSGg0dFNoYkNwMFF1?=
 =?utf-8?B?Mk8xOTZKS3ViMFBWR3VsdnI2STBNSU1kTThaMTlmc1BUT1JNdzlIeE52Wisr?=
 =?utf-8?B?TUpsaWZVdGxmK3prQ2FHWHdKZDVvRkJJN1FHSkF6QmtoNVBmL292TlEzVFh4?=
 =?utf-8?B?dFl6bjNib2JWUEwxNHBhazE1NDJYSE9td21vV3ZHdGpYWWVmVEd1L09tYWx1?=
 =?utf-8?B?K1BTT2VoeVcwNVNpL2h2VE5LRzQ0QVo5ajB2TzlPUm4vektQOUl6eE9UeENk?=
 =?utf-8?B?L0xZVEhENm0zOVN6RGlHa20zTVV1SFp4RVdZVWszZlNLSUdJaWZzSklGaXF1?=
 =?utf-8?B?VGFIVGl1REZEOUZWc1IwRmt3SDkzL2tXMnd6Z0NIM2NiSHJLUGIxSm9ZaVdi?=
 =?utf-8?B?bWgzUlNxUjl0S2M5WlRrbk1PMTJndEhDTXhFVWhudTFDS0U0WnByQWQ1Y2pJ?=
 =?utf-8?B?dmc0Njd3M09SdlhCckFGSTZUTzF3LzIwVXAwY0wrL2YrUkE0dngySEJOR3Bu?=
 =?utf-8?B?NmF1MUtFdzhMRTg2SVIyb1E0d2xqSWZHK3VTUlhuamgyQXNBRDFxeDhaNXll?=
 =?utf-8?B?SkQxUyt2WThyWDlrRVVjd1hhSngvZW9vM0c5ZFZ2aGUrSGlCc3J4b3FnZUxQ?=
 =?utf-8?B?dmJPL3dHaW5xVnY1Wk91MjZHd0dCcVRkblY4ekphNlh3ek94WW43UGhwQ0dr?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a99b1a1e-21d1-4e6b-193f-08dce12b46a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:38:36.6246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MECaUI8ohjABazxdpi7yvrEDwH0CppKbSkFxvfA6M8vSLpKYfoTVclhwo0EOqPSvQRMpAcUZqhrlXvw/T0g6wxSarKFdNkizyQ6/VoGUawU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129
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

Hi Rasmus,

On 9/27/24 8:56 PM, Rasmus Villemoes wrote:
> Quentin Schulz <foss+uboot@0leil.net> writes:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> My linter complains that "When using void pointers in calculations, the
>> behaviour is undefined".
>>
>> GCC does say that "In GNU C, addition and subtraction operations are
>> supported on pointers to void"[1] but this hints at this only being
>> supported in the GNU flavor of C. And I assume U-Boot may want to be
>> compiled with clang/llvm?
>>
>> Let's fix that warning by casting the void pointer to a u8 pointer since
>> the size variable unit is byte.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
>>
> 
> No, let's please not. Try enabling -Wpointer-arith and see how much
> churn that would require all over the tree (doing it in this one place
> would be pointless), and all the casts would make the code much much
> harder to read.
> 

That alone is not a justification.

> We do rely on lots of gcc extensions, and Clang has documented that it
> "aims to support a broad range of GCC extensions". Arithmetic on void is
> one of them, and that's not going to go away.
> 

But this very well could/is.

1) is there a way to tell Clang that we want to follow this GNU 
extension for that case? Is that the default? I can see there are 
warnings for something seemingly related in llvm 
(gnu-null-pointer-arithmetic, gnu-pointer-arith, ...?).

2) do we document somewhere the GNU C extensions we use on the whole tree?

3) is anyone aware of a way to silence some specific warnings at the 
project level so that clang takes care of it so that linters use those 
settings so we avoid people sending more commits for that "issue"?

Cheers,
Quentin
