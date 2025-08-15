Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46202CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 08:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD31083938;
	Fri, 15 Aug 2025 10:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Wvjflh/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24E7839AF; Fri, 15 Aug 2025 10:57:31 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C7A838C7
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 10:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt9ZekxhgdzS2UR44j/qpyZOpZoDr1lyjaTmMGoT+wCOtHaM2qEArd97lUiUfSgeg0eOgcVheFQqELtKWDqDKh8wmY+19uyshdkLPP7wfbN0TSMkXmLD12PZbexCCsrjc3hFKAl6Q0ZwDutjrJeJPfST5KlwO15nEs/C1eUy+acxoibzEnWTasZOpYvphyL8HfwuSe7hVsRIVSgJZ58wzbjwUIe0QC46mQ7a++Am31J+ER9BoU1MzuysIvMeh9f8pR4EghHqwM190eK/7xUivK0IpLWkHfisKskEmoCM3wdxe/DLW/N213OqgZ4RQBvbbFpEaUYS0RRIXPyVDFaeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV7Z4cixxbRU/zub4AfPeTa4Zkn7uIckDzof+foGa5I=;
 b=ymvePmvGyvrgFwYNqQ0+musWzNw1x37wTt0pwskbWmpU1oU+P5u92bSzEjuUwaxey66StwN7OKLld7yJobgakzqltcTt3FCsOZ+41ooCNKK0wkknhuy4EIHSm+Z8HU9+y0n3oppPsfL+V61QuOrLl6Og9vJ7xeWo5HYGntjiDU95gZZ6YCP6fUiQTrqXhV2GkzQt1JejJLbVrjgnGFhv1krMU4RVgT2hUlswmK94mAZ5udcsXovmtaXARl5TAulSg681DF3VOshtIyQo3eyjPZxEBPUL1B+uMU8ZNIxQVjvA33Meu83jtB/I3sK91+OPVFKrtFzCrcEXy+L5pH/agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV7Z4cixxbRU/zub4AfPeTa4Zkn7uIckDzof+foGa5I=;
 b=Wvjflh/zcTVHFcMxQxx5yUhLacUK6BVLiIqh/vWVYVjmObOt4iWLpI0BGjJiSSmHquRF9CZNQ3zxxnR0EirV4s9WMdZxN02qqm66er7Bw69QGPGiQgRobwNld9UhfcyEybpOt5rtmoeWjP1EifGqSMGiDSsqAH/NFU9qEms9jzw9Uun80Yoecp2CO/WbWQ9S2MY3uyxDeHsSiSUc/bySsvDLeqeHoYY3HN4eeFUxQ4A4/7cYK0lzv5f0kzrydvcwXf4GZEHKzDX+ydSBQiBcALHo05zA21ZW4fKnR20NBQpi8A+Iv+1rKMh6gUgC2LE20A4poPCp53UQJl8C1/JUUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8568.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 08:57:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:57:27 +0000
Message-ID: <eaac5ba5-32af-4516-9d3d-8271b708ca4d@siemens.com>
Date: Fri, 15 Aug 2025 10:57:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
To: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl
References: <20250814181436.1598067-1-festevam@gmail.com>
 <20250814181436.1598067-2-festevam@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <20250814181436.1598067-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 630fa2ef-20c0-4b49-fce3-08dddbd9c2bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnFSSldXbGoyRHNwU1Y5OWM3ZzJkQXJFWEZqa2o3ZXB4THhyR0M0cGZDc2xB?=
 =?utf-8?B?SFB4aHVtcVlWSmR0M29vY0dEOHNxSDRpS0EreHU1ZWJuOENWdGRDRS9BVzMr?=
 =?utf-8?B?TW1FRHh1OWg4MG5rTFR6QnByRXE5Y2l2SzZjOHNwK2hEQkNqM2pxUWJ1MlZN?=
 =?utf-8?B?TUswdExIdzg0QzNZdWw4VHhHeG02WWx6VkVhS2U2YXZNeXE1czVHOTczUkRa?=
 =?utf-8?B?VHY0QzI1VlI1WWFYWGtKVjJLcW15dkZNeGhQK3RjYkpCRDZpNWROdmhoNTVB?=
 =?utf-8?B?b3pvOWI2UUdQU2ptM0dTRnkrWTRzTk50bFErZjgydVVBWkpkYWFYNmdBQW10?=
 =?utf-8?B?Y21aZGxkL2h2ZVo2eHZYODUwL1ZETkJVUDU3ZkdMYm95Q0plN1ZCZnZsMkFs?=
 =?utf-8?B?NnBNQ29iWEdwVXBzVE50a0EwL3l6MWMxWjBueHlHRG0vNmgvS0FEUi9NNHFM?=
 =?utf-8?B?MlhKMGJScjlnbjBXa3B2dWE4YjBMeEJ6VkdCcmRiV25UZWZPTXowU1MzcllK?=
 =?utf-8?B?UnQ5M0JuaTZUNGdCTzlDaGcveEdTMGZHYXVyd1NMQVp1OUd5OEFDVmxlVG1F?=
 =?utf-8?B?R3cramQ5RzlmVkMrMGl5RmsveEFYOEkzY0FkcmVIK01QbkJJTHArSkdQem5E?=
 =?utf-8?B?ejBwdUZRRXNURnAxbnpmMFBNMkF3L09PVFQwWHlyTnl1eFBtcTZMdWxES1ho?=
 =?utf-8?B?bWVBVXNoOFhlbnlSbWVzcDNwU0VTSU9WcEtLQlovM0JxNWdtLzdzVXluTERq?=
 =?utf-8?B?amFVNzRkaDE3Q293M005UU5GNmpidTFhK3pycGt1cmQ0bVd3dVBlRUhWZXZn?=
 =?utf-8?B?SlBJN1hMOXJlK1BIZXBsSERRYWplcCsyOXIwQjVGc0JYSENUK1pwNmhINXpS?=
 =?utf-8?B?VW85enRZazF2SEhTNjh1SnI3OXJWTVlOZnVGMm9xNGJmanE1Q2t6Y1JWbXM1?=
 =?utf-8?B?aW1SWGxMSXZ4cVdaZG1Dc09EZFhjZWFPRG13NVd1QXFyd1M5WWhQNGpYdWtz?=
 =?utf-8?B?bHNYS0UyZFFQTE9vZ3ZvS3Zxc2N2bmJuUFZiSnZ6U3Rnbk9DWUh6NVpOTDVi?=
 =?utf-8?B?c2NBWXE4eEJFQXo2ZWR3cDZjKzc1Y1FwbzRWb2lOUWFLVUlZcGVPK1liTFEx?=
 =?utf-8?B?UUFtZktpT3Fic3hGT3hPRmw1SEpUV05VRnM0RGRwUzR3TXJGY3VtdDloSmhn?=
 =?utf-8?B?ZXFRYWMra0JoY0luQ2xiNDdRcmhFTmFJblFpb0tnQmRRR2NRVVpYalI3eklo?=
 =?utf-8?B?L3JZYmNEcUNkQWpCazJaNU9uRzE3OTVVc3VTckZJcGRNc1NGWndsVXEwbWtV?=
 =?utf-8?B?NzF3Yk1LRFpYQ3FJN1NyZWhJTXZaSW04dSs3MUJTK1dtemZ5NTNmSVZaMlVG?=
 =?utf-8?B?RkhtVEtrUkxHcjg1T25vSUQwbHR6MHFOVjhiVGFyNGlxakJtbFdvQ05xa1kw?=
 =?utf-8?B?b2RRanNpUThkMkJWR2ZueDVzRTROKzgrbFBEb3ZKZXJJVEVIWk54UTUvUzBv?=
 =?utf-8?B?V21iY2Z3NW9EZ3RlQUt4NzVzMVlIWVJNcGpNU1VqRHJrN2Zma0h5OEdDcnJ3?=
 =?utf-8?B?UjQ4c0ZTZ1JUQlBZSFozZVd3MnpZT01OUlJOQ09LTk4wYlQ3Y3hFNUFVS04y?=
 =?utf-8?B?aGtCUlc2YlBIZDZIWGlubGYzdzdGNkp0ek9aSDRpQXdibDhpek9zSU02YmRw?=
 =?utf-8?B?Vy9udWtmZkR3RzdteFRIaUpsVDBYNjMwenNuN1JrMzJnWndYaExaOW1tcjM3?=
 =?utf-8?B?VGdMUjVzVlZ5bE9vZnBVbjZCRHJ4YUltMzBGOTdKenZXaVVHMVU5T3BjYmpx?=
 =?utf-8?B?dkpNOVFrTThLOHdmazZUcTBaZzc5YUFjK3BrMDZibExrMEJVVzdXQlZicTRz?=
 =?utf-8?B?YUdZa3VMamFvMjIrK0VFZDZzaHRrRUkrZFpaLzdJMzc0U2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk12VFhCeXFQRzNaNmVRVnYwMHd1T2swQmY5SXVHalRwQ0tmaFVteTM4czJS?=
 =?utf-8?B?Vkx0MG81aE5JeTVMMHB3dnN3V253Wi9walBDK2VWSGJCVkNadi9SVW5ScENz?=
 =?utf-8?B?cjkxQ0VsM2lFdlNLTE9jenpsK0x1dlhaYXJCMUhlYmEvbVZiM2tMbWh0TzdX?=
 =?utf-8?B?SmtHQTd0RW9WVTg3RCtXaDQvK0c4L1hJVWQ5SzE0U1dJTjBmR1FSOHE0VnJU?=
 =?utf-8?B?aktoTnJMSWhKeFBNcnhsbkdqT1M0bzl6QlFnTkcxNHA5dFpGUHRqOEUyVCt3?=
 =?utf-8?B?ZkFBcnpScjZIU092T1ppY2ovclUzckthVmluaU5DK3psVkQydnFUTUM0ZVE0?=
 =?utf-8?B?NG1ERjRBOFhVRXFHVDVPTWFSdEx6VWFHS29SMXh6MERKOEJlSW5nMXBDY3U4?=
 =?utf-8?B?c1IwVDBxbWIvSjYwMWNYR3NCTWhOaHc3Z2xYWVdXU1VJcnJyQU5GYzI5R2Fj?=
 =?utf-8?B?Zjl5K2tQSE14TWdPcEhhQ29iTXJtUmxEWWwyV2ZRT3Z6MDBIVXVrdXJEL05n?=
 =?utf-8?B?RjJZRmNXdk1oZTdvNGFzUUgvVFVTYmFXb1Q5bFFnelJKaU00U3BxazA5dm04?=
 =?utf-8?B?UUhzT1FBQk9lWlB4SWZ3UGRjQWgzVTQ4QlNncDRzdWVNRzNCZ0hFNzJTQ1BZ?=
 =?utf-8?B?eGlmNi9ZVTJ2WlVGVldPTWc3QkhndHBKa0tlVVo4YmErekJtT3F4RjhGUGZC?=
 =?utf-8?B?VkVFSjBOWEhyMG5sTlA3encxc1AwVHBMVmxUVkNEYklJSVROc3dKSlVDWXAy?=
 =?utf-8?B?L2NFVm1TSzlFWHNvN0FqNENrYklJY1ZxOVBtYldFTlNQMm5YZjVDM25qMWxW?=
 =?utf-8?B?WkJ6bk41WWJ3RkhwNUlucnVKbnpjT0hBT2xMNXpya044V2pHaUtwMG5SMUxG?=
 =?utf-8?B?Qm00dkpTV3JKeDM2NWtoSWpOL0NJb3NxRDMrdkllNVpQZWhSYTFvSERmVWRX?=
 =?utf-8?B?L3Jsb0RrNEJxVXJjTUIvVWdFUkh2eGd0VDdaQzZIMXEwemh1Z2FTWlMyUDdx?=
 =?utf-8?B?ZjFKTUVvZVZLSncrTzdUK3pHNUhRYjdNcENRdjhaVk4xSDAzY01nZldWa1Rn?=
 =?utf-8?B?ZmM4c2ZpUmRKelk2bTZBaXN6ZmF0Z2tTYTlhNXQ1a3BwY3Q3dGN5NHJlTmxP?=
 =?utf-8?B?VlUxY1BlMTZoUE8xMERJVEpONXR4blp1Z2o5b3NnRlQxSnd2dkFxTWNXT3lO?=
 =?utf-8?B?aEtta1A3aWpZR29PQzBMWVFuK09WVHBXY3NudTZOaGRBdzJxUGtFajZXeDZY?=
 =?utf-8?B?SkFKdUxGdW1aZDVla2U2VGRoVWV2bDd4b3hCZlQ1WXhmeUZWODhOcWxWNXlH?=
 =?utf-8?B?THdiSFA4TnNURlUwZkF6S3ZIdjBEZk5sL2hkTURSWWQ0d2kzbEdDUE0zeVp5?=
 =?utf-8?B?K3U0bTRIR2l3ODJYR3AxQ0g3a0pLUlNPZmJaK1U5dm1ERFpIeldJSGExUUpz?=
 =?utf-8?B?SVlWMTVaRndWU29mS0ZVaXF1RWR3S1ZaUmtzTVkyT1Fkd0NoQWphRkMrdllE?=
 =?utf-8?B?bHNBZ2J3UVpqaDh1RklVUWYxWFpWeFVWTGZPU2NudTVoUTU4MElDSTFoL0Iz?=
 =?utf-8?B?enJ1aktCQk1PQTJiekhGSkw2RDR0aUl1WVhaeU1zMkxEVkNLbHhxRE5iQUNp?=
 =?utf-8?B?WllBRnp4aDJZU1Avb2FZalVZNkNqSVgrOGxpc3NkRjhncEQ5QXBUaWFKRStM?=
 =?utf-8?B?Ukt3OXZjd3hQTU0zUHY2TjJLYUE3a1NxdHd0cEpFdmZFZ3VxYkVKQlRzQTVF?=
 =?utf-8?B?WkExWkV0QmVhcHd6ZUFHSG53Zng1b0VjMUFZYkoweTREUjlVQ3dsaC84ZFAz?=
 =?utf-8?B?djRTOGJkbHNLN0RiNytBUjI2UzdkUnhQbXlDcFRoc2RZMWhiOXkrQmNMVVRZ?=
 =?utf-8?B?Z1ZiYUFybjE5aXRFam1iTW9RR2FyS0xHZXRzVDFmd083bTF1SFlqKzExZENE?=
 =?utf-8?B?MnNVSDcyZHFPNE5yT2dSV1M2UW1ydXlaU2JtZXpmNEVMSzA4aExjdE5oWGU3?=
 =?utf-8?B?SmE5RHlLTEJZWi9TaVZiaVkwYk9SVWQ5L0h3RXIzclFyMjhSQVNjWWlRRUh4?=
 =?utf-8?B?TzFPYkhIMGdVdGNKcm5kZ2VvR2YyeWdudFREWWNaY3JLZWwvTnBiSGdicWVS?=
 =?utf-8?Q?uFv3qMoxFKt/nGalSZGHTvhIh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630fa2ef-20c0-4b49-fce3-08dddbd9c2bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:57:27.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itrSoCoPNo833IGLxl4N2sZvSyPrrfY0jzGqIadCUyXZzdmz7hVIjOL1LZewpHOANe87dcNnIdeoxgt63WRcDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8568
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

On 14.08.25 20:14, Fabio Estevam wrote:
> Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
> work.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Select via imply in board/emulation/qemu-arm/Kconfig. (Tom)
> 
>  board/emulation/qemu-arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
> index 80ab9d8e1c3f..447061b25cd8 100644
> --- a/board/emulation/qemu-arm/Kconfig
> +++ b/board/emulation/qemu-arm/Kconfig
> @@ -8,6 +8,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>  	select HAS_CUSTOM_SYS_INIT_SP_ADDR
>  	select QFW if ACPI
>  	select QFW_MMIO if CMD_QFW
> +	imply SYS_EARLY_PCI_INIT
>  	imply VIRTIO_MMIO
>  	imply VIRTIO_PCI
>  	imply VIRTIO_NET

For both:

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
