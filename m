Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2855C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 09:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B95B88971;
	Tue, 13 Aug 2024 11:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="D2zGsiYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D3288975; Tue, 13 Aug 2024 11:16:41 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC8788966
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 11:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJM8E1OZVkaWvkckgRkYsF0t0CsaIb7Sr+vTvWoPgTd99848fxowAIskMuUoMCeAUyXjoe1/ZCANycFIhywUPp4M4TEa2NfwPkWyPCbhEQojXs2DMbdzD5tvFObMqR+6X8Afjmh0eE7x+UtrS/keCZXxpBQWZwHGvtkL8Y4R9gFkFvuCqmvxXX1mJ8LZ9OVZOMkHTx9VWsT2KQktp0SKZnHrSInxyJ4C+fh+rr+pCRZRQ93plFfJ4DZ7inqq4fBNBfS9U2LfqCQmDiI4/2dfj4gmMEHPBfIyri8mcANhS7cnIApYl5P/U60EMtwpgYsWLYGrMiBn8ePLwefZ7rsytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRmK2u7n97zZ5iXsaYbBzgrwMbAZskUuukZizxOlrbs=;
 b=GsMxIt7dZRS4RoUgMoWhn7bNDtb+JbdqMfo2PGxm6NNjLQCbJ9rYiRumEawI3B2t3jI7AVV+E1wpanhaKPRCH8DbDLUbaESWgcV8rv9YR7YiFKXbN+XxwbtvRKRo42m8DSDpT4zTg+TpXsH0aBorhQcWB2mu02f5PkXl9Es/2U5p6OCLhYFxfdZj8LockJrRgoxPlS3XTJ6uRK36a3a0QyZhH539PXFowBoKL/tuJVgOD4yEmgK6M0CnEFtqfLvl0pNrhLT1TDQoZ21w7KQuf8mwECIfs3rkgpoGeb9lp+0lPortho4mygBeNA349owQj6MPwkbpXByIT/IVTlGilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRmK2u7n97zZ5iXsaYbBzgrwMbAZskUuukZizxOlrbs=;
 b=D2zGsiYe2uLnhg6RSKphM8/ov14eGP6qwWfJemUYepVGlQsC5raW+s+dsEnkBNqTXitsNzbBoSmj3j/xX5hliIxzMq1y0AIDBETpHu4x7T7hIIE+w2hI2HBnymctcZPVTyoPR8wOexHOgoe1hPhCSGUaSfadAvdOmup7oAIHsqBP1ePm9PxAymXHjsP7Xh52lyeXVgdeoPktx5O+11l/Xhl//3nhZiK9BxUZpSsCdLnmGRTXg0rTOSGompgTZwDqvfUqhclgr0d2JIaU7QoS2Osa2O+8ovCA3yT83yqD7vkk5dFbIxfQcfs4pNiVAnLaL9UAnvkuBhSqiwbZ1OzPdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:412::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 09:16:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 09:16:36 +0000
Message-ID: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
Date: Tue, 13 Aug 2024 11:16:32 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>
Subject: OF_UPSTREAM vs. additional dtbs
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fc63ad-b86f-49b2-bd46-08dcbb78a1a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkFud2o5bW1pN3RZaDlEQ1RObnBCSmpOeE1WT2Q5N2haOXZoQ201NTQ3T2tv?=
 =?utf-8?B?M0grU3dyZGtlczJCVmprUTZOOElHRWlPazI2dWhqK3E1TGM5ZFF6Nmx5VmlM?=
 =?utf-8?B?YU9VaFpXc1BqRC9oQTdWSy9JQ04zaGdLVGFlMXhHRjFBS2N6bzMvSkU0cGRs?=
 =?utf-8?B?ZlR0OEp4UFozUnFhTHFRVXlwWlloQ2FSOUN2alJPeGNHY01BU1JrQUg3bkpq?=
 =?utf-8?B?YnkzaVp5R1FGZXRtMThmdSttcWY5a2lnMG9iMkdMbEY4UG9VUDV4bU1lQ0xI?=
 =?utf-8?B?NitSb3VDKzA5R2NPaDYyMEFCd3Q3RnBNcTFDTW5WM2x4T2dzYjN5YVNnR0lj?=
 =?utf-8?B?VE0rK2RWZEpCMXhndU16ZXFXa09aTzU3QlZJYzVOb2QxallodFh4ZlliV3Y4?=
 =?utf-8?B?SGVuWUExc0dOditqUDVKcXZ3NjVscUo4MldxclMwL3dHSU05c29aQVIxWjJH?=
 =?utf-8?B?eGdpcmljME1UWEdJNTFvS1VTdWQyY0dQdTZvYlpnMGgzdjZBU1RHMVRxOHFn?=
 =?utf-8?B?V0JJRlhqYk9temFaeDNsM0pJQjE4WE40ZWl0eG5hSmFiSE1iUlpLQW1meTEz?=
 =?utf-8?B?ZEFJdUc0VHNWTTZNWGJJcGg5QjU0b2JlRFdBL2Q0WWxiMGpnc0l2UXg4VVlo?=
 =?utf-8?B?VHIwUzBtV0V5eGpURElYRmwwa3JvZjdNWHNrUVdmS0pYZnI2RmtxOXcrUERB?=
 =?utf-8?B?UEh2ZDZEcHJHNzN4Y3BEVG82Z2JVZmowMkowSlVmNEFpQmxhaXpDUVptRmpr?=
 =?utf-8?B?cjdlWnFmK09za1c1WFk4VWZoMCtRbFBjS3ZMZFkxUzF4bExWTHF6SjhXTWov?=
 =?utf-8?B?NmtQUnBvVWVBTm13N0UwL2t3NElBUE9hWjdlRjFaSDZSWGRid3dqTjZYT2E5?=
 =?utf-8?B?V1hQb2RnTlNFRWIvS3FrQ2JCS2ZIQVFZTWQxUzlGeW4yU0M3OVZqT25vazhJ?=
 =?utf-8?B?Uk56SUNHVjJYNkQzZG1NTkxsRWR5SkNncTUzNHVBRGRvR0ZKK0hSaU5pbkhF?=
 =?utf-8?B?cldMbjhBaVpqRlhNSlBaSmNWbXE1R0NlT2pTRFhMUjNPaGJuaUJnT21pMkQ3?=
 =?utf-8?B?dzNndWtadzloa0dzVVpzeEhFaXBEdkZ0M3JiNDNmb3RCYXUrb2RFeWVGNU91?=
 =?utf-8?B?ZElpUGJVRzI3YkFDMWRZZCtGbmpXbUNTOS9wMGZRWlRrdW4ycDF5dkRTZ3NQ?=
 =?utf-8?B?allOWXZIY1lRZC9ZVW5tRzUrRVV4OW8zL3E1V1V1cXhmN2FuUmJPNXcrejlY?=
 =?utf-8?B?Nk9KdGFYamUzTlJFdlF0d01Nc3pSSGozYUM0VUZnaWIvMzZub0NyNEJyRi84?=
 =?utf-8?B?bGJDdUU0UFlqaDNXUFBxenVlOXdqVXNJbjJ2RU55Sk9XOUN4V0k1OW92OVhK?=
 =?utf-8?B?TC93S2duM2Y4ZDZvS295OXBQNjZNMGwweVdvUlVDRVhDOUJTYVpIZ0w3bGZS?=
 =?utf-8?B?OW04TDZEaWhRbU9KOEs3Smx5SlFqejk4eXR6d0pTQ0ZXRVRpQUxsbnc4ZTE2?=
 =?utf-8?B?b3E3TUdGTG50V2QzRG95VngyWndNcUM1Q1pKWjl5aGR1eFVQeXdQb09lVmpk?=
 =?utf-8?B?dE5HMjhsZDdwOEhVNzJBSkU3THVTOWhmdkhPMG9QRm9Ua1NXRFF4OXpZYWZT?=
 =?utf-8?B?akRyT2dnSlRBcEFyd3J4WTlCNUNrTVh1SHliNmo5bVJlZ09ERjFCQlZoK1Q4?=
 =?utf-8?B?QktaQmlDQlM4cER2RGRxQ0tmd2JuWU1EU00vWFhGNTA4NEd5NHRsV1VVcHhK?=
 =?utf-8?B?OFRqeDIzQVF0QldIOTZlYmthYjJ1VnBaWU1wUm05M3UxQUxTRDR0eXFia2o3?=
 =?utf-8?B?RVVkZ2RUK3ZuRjNOT1FYdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtjakJPNW9DUk1UWlNFN2gvbVd3enFiSXR6dlpZSExoYTY0SmlJOFhyNVVY?=
 =?utf-8?B?bVY1MnFJNE5uODM5REltY2RzL2VKMkVRWldEMXN1UlNSc3Jqb1k5VXB4NEhE?=
 =?utf-8?B?YkJwb3lhb1FiRW0yUWRWOW05VDZDS2hXdmE5Ym9XWVdtTGhEQ2FYTlRlK0xq?=
 =?utf-8?B?M2pRdTNLMGU2ZGVmVCtjN1oxL1dkaEQ1ODlnVzdVS3FRVWsycDhRS1FhYWNo?=
 =?utf-8?B?cmRyRHJ1VjFxSC9lME42OTh1MFVFamdVaU1Lc2F5WkI1MUtKTkZiZ1RKY3Rh?=
 =?utf-8?B?NkFRdVoxRDVHTnZkYXBOcTFuMFZoMXl2NmJCRUZwSVVYQnFmK1ptcFYyRWZG?=
 =?utf-8?B?SDh4RmFrLzJQVzVQU3lRSm1aY0ZrT1NtZ01WSXFldFl2QzhMak1OaTUraUpK?=
 =?utf-8?B?Ynp4M1g5ZVlGWVFtSmkyQjY3SFZFbG1KSU9xa3pTNEhWdEdJRmxQeXllNFBF?=
 =?utf-8?B?NEFHd2VyUlpMUlpZMGF5L3p2blRaYUhLT1FhZWwzKzRTeFBJbElSOFhaNG9T?=
 =?utf-8?B?SDdEKzRiWTVtQWIzS3hON1JBWHJzZDJqZWhES0V6bzc2NWJvL2VTMlFjc0Jk?=
 =?utf-8?B?SEVINDJEczRLOVdaaElQc0krd2xrU25aK0x2NmNhaWZPeTlzRGNVTzhWNmFO?=
 =?utf-8?B?d1I0cU9OaTYwTWRwNmI1MHcvREZVbFN1L3d0NlFaMFMxWDhqcGN3S1I5VHFj?=
 =?utf-8?B?b3RiNHdjUERKYk15blBqcUhrWXRtSEZneGEyRDBTM1M5ejFKaHlVNVVINEJx?=
 =?utf-8?B?OUpsRG9EaC92OElpWk1CTk5ZT2pLd3RJakE0QmV3blV6blJVUW1idHdjSlZZ?=
 =?utf-8?B?WmNnWUVia1grNk1pdjVVdkpzK25qTVVoU3AyWkRmVGd5WUtrUTQ1by8weGd2?=
 =?utf-8?B?VUJZZmZKTkE1ZFZ4MmZwcHNDcGl5QUJJMW9EV1FOMlJSR0NiZWVjczhkRFI3?=
 =?utf-8?B?WFpKM0E1WnpBdlNjSXVKeDNubG9yTVUveFk1MDdCUkhwN09nZ3RGU1I1cFRL?=
 =?utf-8?B?M21yeEpZYThoejZTaytIMnRjaVR5SlZLMTEvSzNNQWhTOE93VWNjWlJtcnRz?=
 =?utf-8?B?VitleU1UT3lNckJBbzZ0K1o4R1dRZDNiNVFmZCtoS0RrSXpwQlhVL0FpMjZj?=
 =?utf-8?B?dFkyVkRQS1ZVMkluUmJKYk1EdEd5SDh4ZUZ2TUZrcjhxVzIzRmFGZkFScVJS?=
 =?utf-8?B?YXNLRGpwaGQ0RTJWNU02SGMwb25MMWJIQUxEWDc2akZMSTJIQXZ3WXI1ZGVN?=
 =?utf-8?B?aVBLN3JmRHoyR0dPQzdoK1BmeHFYUGxoNUxOQ3IrOURNdWdUN05iOXg1bXZn?=
 =?utf-8?B?UnpxTjBVZjJFbm9rVk9YOWlxeEF4SU5hbEFFK2RSVHBMeXRhZWRMTkYrNVFy?=
 =?utf-8?B?enRDOUYzSXd2em91YnphUXk3c2hNRlc4WjlUc3owNXl4M1NZc1RqbGpSeVkv?=
 =?utf-8?B?c0RkQmdFcWNCcHNBVVY0NVluL0U4S2pJRjM5Y3R5M2FQbnFGbzFYUGhwUzRX?=
 =?utf-8?B?OE1sUXg0TCtIZFdxNmM3NWZ2ZWl3ZnZlMk1VbnBFZHlJYTVoVFF6TmFQb1BG?=
 =?utf-8?B?eXRTbVFybVpuRkV6SnhOdGh5TmFsTGpLaEdXd3NsdGd3dnZjWGw2a3VTbmtS?=
 =?utf-8?B?NmR5UEJ6aWdVQXdkcEMxaGlnbHdFOEVLZ0FNMXBjS0U5ZXYxSm5aM01oc3la?=
 =?utf-8?B?RFB5TUREdFNJSmNiSFM3TENXekpCME1jZUdsQlIxa2R0YmNYU1ViTUZ2RlVP?=
 =?utf-8?B?NzdNSnUwYWh1MCtBcEdReGR1K211c2FMTEhTOFZHYU1Sci9ndlhlalBaM0NB?=
 =?utf-8?B?b0M5SWVJNXhFeEFqYWlUR2JxUE9hV3hRUG5CeUVwUGM1MGdOdjdVUWY1TmVE?=
 =?utf-8?B?OUgxcjFNYktlcU9LSTJrclJvMjMxY1B4YUxMTUxySnRTMkhnQ1BJNjFmV2Jj?=
 =?utf-8?B?UStDRSs0QVY5VDQ4UXZuaWN0dG9ZeW9oNmcyZEw1WEYrVWR4Y0RuMm4yaDQv?=
 =?utf-8?B?YWc4dGg2OXNseHFkeHYvQ3duZHk2TTRWeno2enFrVU1NbWhOQ04rbVNuNjJY?=
 =?utf-8?B?RTlOb0lkQ3pKN0lqMXNZeVFzOGdLNlRNQzc3K1dhVWFMWVZvOGhXUHRUUUND?=
 =?utf-8?B?ejJPWmVwZzgvaEJvOElKTTduYXIvRU5BRWhwNFRVaVhjcERWbjVzR2NqTEVl?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fc63ad-b86f-49b2-bd46-08dcbb78a1a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 09:16:36.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMT6a0evgEksPqGK8aSOL7LjfxfQ6oApoS9Bdy0qKlepivLLUKBsdZVJI/IgH5HPtIMFFaRceun1Ab8S3gcHSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6342
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

Hi all,

I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
facing issues because I need to still build the u-boot-only overlays. It
is also a bit weird (but works) having to specify

CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"

for our spl dtb.

Are there means to still build certain dtb[o] files in arch/<arch>/dts?
I'm a bit lost in the Makefile forest.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
