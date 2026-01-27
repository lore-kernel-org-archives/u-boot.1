Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7BAD25958
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB9683F9D;
	Tue, 27 Jan 2026 08:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qph/9rK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C8A83FA7; Tue, 27 Jan 2026 08:54:23 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A0F83F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qalcCWapktv2BtwKQY4xnPke/SbvB3a8fdIpq/jylehsZubtqXXDZh1zPpeLr+TW1jsUTidTllwfrjkxoZhC6Zjv6mfxRJdNoZq42TPMMfadi9iAAui7daE0s7anmFSCsuov/h/ZuwMTZbndd1vdrOUbDB5SmwKhQyCi7+cWTl3Qm/jvyTrjhcJ8b9gPHjYuFaHaJWy1AnxJPs5IB+w9SsBlOKJS7tLd+rntaIDGZp7IwcrOrNcyNgSzDmAjgM1l0rmj6UwRgJ4RID1f9Zu38iJeLrQikVYRvN8BnpVxvJKBOMpB2yfrVTjTvTJUtUdqumKufJw5nJPO61H/lzS3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=983UFrrzSHM7mfOfQttYkIyGO2fqPy+SdbVjjJhE42M=;
 b=ZuhL6y9sXmbqv+IpweNV6RiR0R9qwNn1KzUfacHJaV+u+A0ByZllhItsDZXFwTx0vjCkXhBGKMaxj3MqJDJLRiQeM9yPeszQFQ+peAUCrXhUyd7H9FZrk1rvmjlODHNyW5jvJUe2UOYhmw38p9kIlAZONbgwWief0AXSn+ePZy8kUKkjyfSkX/mQP1y1dCtIt6C/pa7d9IHzYrzxul6zE9fz8OG9Tcy18OXduzCT992YAcG/fRJ5HVtlYFOmbMwG/eqRT0Hq8OkMRaYpTY1cg9bCNWXAqF6ld3D8Q/XJzzmPyxHWZxD90/3UiCGAOLB66qUo+YwoZwNnsQ6i+V8VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=983UFrrzSHM7mfOfQttYkIyGO2fqPy+SdbVjjJhE42M=;
 b=qph/9rK9NeaVUwA0/ndwb5FWTrFLGl6kjelSYpHBzC1yb8qG2bYTtM8xyps0XdKmzM6WxV7X63xgt+x+xAFPbNAR08hEgmWTnrrtvmKxI5mWywqjsqruI+uvSXHpjQckJHi/fioMG6FEJDn6jRE5buLtR4gJQzqpyn8PBMpa2m2lkLk6Q/bjN0FVeKZNvnLgHwrR3J+MpZhKDC6flyPyzFFNfUffHF6WVJ+uh+hLRcvtt4I/1lvGwxukPj+Qawj8zgCtIec5uEIb5HzNWlbz6NddXmgr7oAeAJnG4nXVN10Ppv2FAwx7+X0+uAQWHQLKOhOkW/1DZagPZn+VH09feg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA0PR03MB5402.namprd03.prod.outlook.com (2603:10b6:806:b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 07:54:19 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 07:54:19 +0000
Message-ID: <3155f681-f36b-450d-a15d-c65be63d0bcb@altera.com>
Date: Tue, 27 Jan 2026 15:54:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216084623.19589-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA0PR03MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: 325eaea2-5ef5-4e0a-9aaf-08de5d79465a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdnWlNYRC80MW91LzlzTGRXb01uTk51b1BxR3lxeGdvV1EzMnBDTEFqZEpz?=
 =?utf-8?B?T2ZHZUlOQ0N0S2hDcUtaelJ1cmlFZDNDekFUOHA1aFE0S0g4cmV4SnFkUUdu?=
 =?utf-8?B?TmR1cExTQklGVnFpdHozYWlRdXRUeWRSVUw1TFJxSWY2QXNsNzhOOG9adk1P?=
 =?utf-8?B?MWRwbmc5TS9BSktLL05OcHpHdE9IaEZDUTQ1VVFuOExudnNEMHJBZnJDbXkr?=
 =?utf-8?B?dEc2MHc5M3VpRDk2elNoL0lzSEVMc3R0MkZ0VGhRNmZRT0h5b1Mwc3NLT3FU?=
 =?utf-8?B?OG1QQWRiOUpUQkNaampYQWIzTXFTU0lMenF3MnZLWTdnQUtZNHkrU2UwZkVx?=
 =?utf-8?B?N0JERmFZWHhhdzJ1VGVsWW1QUkduTUFBYklHTU84alNDNkRBSGswZmNraktO?=
 =?utf-8?B?UHBxS3hlVFpCUTRxbzRqUUZJOUVzMW45Q1hQdHdFckhMVjlzcWpCY2srQ0J1?=
 =?utf-8?B?bXJYUFZJVkl3SHlSTWhDSDIyZS80V1FrMVR6U2REZkhCWlZCREpvRjhGek5o?=
 =?utf-8?B?OTZMbkprUURSekxMYXZHVDJLUlZHclBpL2w2cWY2bjVvbEpjV0o2SjZOaUxH?=
 =?utf-8?B?Tkg2Ry8ySjRSNndpcmljdldYeVc1bklPQ2V3RFRYMjFoZFcxQ0wrVXI0ekE4?=
 =?utf-8?B?RGtnOUlUZHMwL0JiR3N3RXpad3BzcWkwT256UlUrWnJLaElQem1BaThaczdP?=
 =?utf-8?B?YzRrVXFvSXdaTWllcFM3MWtkZHk2R1FsQzdwZjRHT2EyaXg2WnFiMFVNRXZZ?=
 =?utf-8?B?cnN3VjNPVG9sTEhNVTdpbUhWbkpYY2NJSGRSYlZoSU5qZDQxVG80Nzg3OWFM?=
 =?utf-8?B?VERNYXlCSGdmWVhBTmNTcUFOeVh0MWRpN3RsdmRacEFxZXM0dHVvTkxGb09i?=
 =?utf-8?B?Zmp0UVVWT0RUUVpYYTFVUDBXZjk0T0w4UVJ2RGF2YnRmei9UakJYYmg3blFR?=
 =?utf-8?B?b1loc1Z6dzRHVkVLQUd4cmdhZGxxcjJNa2ZYNWo2QmwzdUFqMDFaaVNzWHF4?=
 =?utf-8?B?SEprT3lkbEdtdCt5TytMRlhoTjJzcVZDTjVOWlA4Tk4xY25Ob1BLOEpTd284?=
 =?utf-8?B?V2x4Nisrd3hlbFFPOC9TaXJEOTBpUGZkaGlneS9taFJ1TDhSditpNGN5dlMv?=
 =?utf-8?B?K1Z3cXhMVnpsQ0tHTUFuYVQyM0lJZ1haRXFoT3VPMFREM3F5T3ZQN0tCeG45?=
 =?utf-8?B?dlVpM05EWHBkeE9TcjBVYk82Uk5Mdm1UY2ljZ3piNEYyS01nbC8wbDJNMmR2?=
 =?utf-8?B?Y1pwWE93NndONk9OanI3bS9ZMTgrR2NRTkNsUDZuNU9WdmpWY0FJWDUzTE14?=
 =?utf-8?B?UXBpYzBhL0duU2JNTkxacVRQRlJFZnJpNDFnRXFGV3JCZnlaMGhNS015Y2lT?=
 =?utf-8?B?NFo3Y1pVMzJyYnVCMlZEd1pWUGYyNkZtbTZvTFRaZDlVNkhWMXdtVFJka3ky?=
 =?utf-8?B?WVl0bVVvVVdPQ0Ewaml6VTM4U3hDbWhoZVlOaTdYZ20yZnZIeDVsQW9BZDFs?=
 =?utf-8?B?S0V4dWFiMGxOS0NYTGVLRVpOVW5GYUZRUHpFVm5VTy8rY3JLMUJXWWh1Sm9w?=
 =?utf-8?B?alQ3QUZUTk94RnN1Q3Rlbk1uU2JBSDJBeklFV0R0L2Vhb2hVYWxpY3JOL2xp?=
 =?utf-8?B?ZytnWGRDa1UvWkN0d2h0S0Z2UnNNSmY4K1dUNEt0NFprbjl1dlQxWS9kRnpt?=
 =?utf-8?B?ajgwVXhnd1F4YkRYQ0Z6L3FYekJSNG5BTGhuM1AwWDVMN290Z2dROGsxT21L?=
 =?utf-8?B?QThxQ0V1ZWlkSEliSFRXcFpFVm9UY1VBMnM5dG9MMlljNGRrWk1qeWJ6MkVQ?=
 =?utf-8?B?Q3NiYWJYTzZ0UkJTYVhPcjQyNUJjVUl6OFZJRDRsYmdXd2NUYlAyMDNwNFhN?=
 =?utf-8?B?aWtMVzU1WjBZNGxUK0N5dnZQNHJET2R4TGQxdGs3VE8rZFpNc3RnS1NEb3ht?=
 =?utf-8?B?MzF3OHNhQUR2MkRGVWkwZmNsNGpHY0tpUlJ0Sm9YMGFIL2N5UFFHalpDalY1?=
 =?utf-8?B?V3A4R3p0dzRZc2lkSEt3L0JVRTZrVGJXOVFyTHB6d0o4SWdpZHQ4T2RiWGVN?=
 =?utf-8?B?UURLejJBaFRoSTVKazh3M2JOUFR5M21LekkwZW1rVzNSV2F0UUd6S0V4MEp2?=
 =?utf-8?Q?5f88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0E4aDVXZVhWTk5lY1FXSUNTbk1nQTFoNFZrWnkrT05YZVdkVDA4dzFrRzBB?=
 =?utf-8?B?K2lTZTVFdWFKWHJoamhaUmt4RzFWSndUcWZaV2xLRHU4c0NEU05vS2x2aGZN?=
 =?utf-8?B?RHNpaENPSkM3MDZqaWVBZHk4RzVoOHhyVXRINXBJL0doQmNBSkNKcmo5STNa?=
 =?utf-8?B?T1c3L3Bmc0dhQ25nNWhpWkRYZEk2WWNZbVFjZncvR0VJYS9yOGNLSnh0R1dU?=
 =?utf-8?B?a05wSUMrbmdhencxM3lUVTUzeU9VQUpSaVFaa1NuekRYOG1idXR4T3A0YUVF?=
 =?utf-8?B?TUhSNW15WkR4L0c1bDlVdVVLT1NFdnhuYkZmUmlmbElEQlVXMEgrUVFhdnFU?=
 =?utf-8?B?L0ZFQjJwOXpXNEdPMW1BVHNVejNtaTBla3U2ekE4bE5aaSsrTFRPRlEveXNv?=
 =?utf-8?B?UXJoc3Z3UTdEaHFBL3A2TFF1WlZENGVIdC9rMXFIMzR0N1VXSW5LanE3ZG8r?=
 =?utf-8?B?NHRLZS9tVTk0aDlueDIyQmpVK2Y1M3dwdFhIZGd6MjNqMERHZkhpTU1lQm9t?=
 =?utf-8?B?QkM1QmtQRFNEdzY1RmRLUGRxajJBNEd6eDZjM2tHUkdRVHJPSVJCUXc2dGl0?=
 =?utf-8?B?MHZjMVdoUURBMGU1VXpTYnRXYzlJN1ZkS2pUVEp3bWdlbUZ4aGVMYWNPODdM?=
 =?utf-8?B?UkZ6cHczS1Z1UDVSazRqbUVsc0NMb0dQZkRZbVMrMzNUSm13UjBWR09rSEY5?=
 =?utf-8?B?SnRGUWpHeEtHaHhNZkQzZXJsa05Db3psOEFRT3RHeDNmSUl2M0pVZmwxcGJF?=
 =?utf-8?B?Qm5XNDlpWFkzNWg5anhnMys5U0lDV3lBSGg1dGcwK3ppOTVaVlN6Vml0WjBo?=
 =?utf-8?B?TndubHlkWFFGMTAwWGsvTERKS2JOZ2VNREpsOGNWQXZWdFBLNVVpZlM3UDRH?=
 =?utf-8?B?UnhYSzhmZmlCMWx4bmhYZDZieWR2a3lGVnhLOFlVM2RlOWx2N1djR3lpWFY4?=
 =?utf-8?B?bktwamtuSjVvdHZHVEFBTDliZWFFc01lWUxwbGh5dzRUYW1aMTdCV0FwQVp3?=
 =?utf-8?B?aXNXMHo1QkltSW82bjB2K3YwaUZkQmhJeHlrdjN1akdRTFVMMGExQzZnNXNY?=
 =?utf-8?B?OWU2djBYcVRVdjlGOVRVeWlFNUdXeVBvZms0R2dJZEhJYldyVzA1bUlxdnRx?=
 =?utf-8?B?cm9RcENrTW1rbCthNXN1Si9TR0lWYkd1Rjh2dlZ2YXFReEhYN0VNUDFKVHJO?=
 =?utf-8?B?ZlBtK1VISW1xbzMzZkcwekVLejdjVlBiYkZrNzhIelIwY3grcTArblJEUDBk?=
 =?utf-8?B?d3pzZGNUeElCOXdVWXgzMlpaczJvczhaWXFlK0ZrYWVwS1hqSCtQRE5Jc0F1?=
 =?utf-8?B?N3lxQVhSSlhXRVEwNFY1OUdKeTl2U21RWnZUai9uUjlsSEpBWU45MSttMlMw?=
 =?utf-8?B?MGdPTzFQWGZrSFN3WjQ3TGpyTU1kSWlmTnVpUzVKMUsxOW1GK3Jkd2NzT2hU?=
 =?utf-8?B?djJTMHN1YzJiSURHMHl6Z255N2lsdnppQk5qc2M3Qlh5Z052empRWmV1blg2?=
 =?utf-8?B?UEJ5MmNFTS9uZmNYcVJPR1Q3N0RYT01iRXI0MDFRazBhSmdLT3dRZ1VkN1FB?=
 =?utf-8?B?SzJucFM2WTloZ2kvcVpQVE0wb1BtS29sbHkzeExLZzlHU2hTTXhQcm1reTFV?=
 =?utf-8?B?OEMza3d1Q0N0V09DV0Z6cDJScE81YjVPM3BpSGxTY3N0VkQwa2xFU2RkTWRP?=
 =?utf-8?B?TU9jQTN0MmF2TVg2QUs1Z2l5aTB1WGVtZTFsM25CRHVEMW9ieEp6Y3ZkejdB?=
 =?utf-8?B?OGFZSG1YY1dLSlN4UTNaTFhzS0pGdzFoNUwxTi9xNnVpeTk2aHJzK3VKamxk?=
 =?utf-8?B?ayt0RXJidmRPcTF2anpkanBKeEcweE0wTWJ3Yk9vd0ErK1NkeVIveTZIN1JK?=
 =?utf-8?B?aW96aUl1Q2tvcmhDR1NjemtzY2lOTmM4NzJ1dmJobkl5ZENPQWhyYmpDT0lj?=
 =?utf-8?B?Y3g5OWpwYnVmV0tPS2xMWTV0eThwbFZPNXlidlo1R2xOcmwyU0E0L3BEaFRU?=
 =?utf-8?B?ZytCL3NNQ0Jxb0pqT01lSGUvSk5QdlBqWFNHOWZ4clpqVC9uUFNFK0IxbjdR?=
 =?utf-8?B?Tk9WcDRKa1RjKzA4RnkweUNycUdQKzZoYll5WVFlaURLeUF1MUZZUnIwbDhu?=
 =?utf-8?B?NTBjbmN1akxzOUNaSEhWUzBuNnU3M2FFSE8raXcyVU11bzBITE15cFpJSVBv?=
 =?utf-8?B?aDRtdVhxN0xiSzV2UVFVdDRES2xNOUlCanRaR1VvTlFaN1ZoWmFKaTE5Njc2?=
 =?utf-8?B?bDBrYlFwVy9EWFBFdzRKSkJVNWhRQ0ExK0xqZDgzY29kRnJjK2tTeHBsUGEz?=
 =?utf-8?B?OTFpbFFmLzF4ek1uWkkxNjFJQkF0a3VCWTNLL0VKWkF3bFBWSEE5TkFpYjJ1?=
 =?utf-8?Q?eElowNDLG0cDrfXE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325eaea2-5ef5-4e0a-9aaf-08de5d79465a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:54:19.0424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ez1ygBwiUUUdbs69nIEB0hK0pBio24R3XAjpeVmpk6SURIsi+ezCU0SrGhBdEC/VNxd/D5/zOvrpZ7DdBSB+vXociOJavo16T86IiR/9nuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5402
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


On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
> the common socfpga misc.c and update the function to correctly handle both
> pre-relocation and post-relocation cases for DRAM cache enabling for
> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>
> These changes help to improve maintainability and consistency of DRAM
> initialization as well as MMU configuration for Arria10 and CycloneV
> platforms.
>
> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relocation")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/mach-socfpga/Kconfig        |  1 +
>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>   arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>   3 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..5b00a101a67 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -118,6 +118,7 @@ config TARGET_SOCFPGA_CYCLONE5
>   config TARGET_SOCFPGA_GEN5
>   	bool
>   	select SPL_ALTERA_SDRAM
> +	select SPL_CACHE if SPL
>   	imply FPGA_SOCFPGA
>   	imply SPL_SIZE_LIMIT_SUBTRACT_GD
>   	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 07694107c8a..2eee6ab3efe 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -318,3 +318,34 @@ phys_addr_t socfpga_get_clkmgr_addr(void)
>   {
>   	return socfpga_clkmgr_base;
>   }
> +
> +#if IS_ENABLED(CONFIG_SYS_ARM_CACHE_CP15)
> +void dram_bank_mmu_setup(int bank)
> +{
> +	struct bd_info *bd = gd->bd;
> +	u32 start, size;
> +	int i;
> +
> +	/* If we're still in OCRAM, don't set the XN bit on it */
> +	if (!(gd->flags & GD_FLG_RELOC)) {
> +		set_section_dcache(CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
> +				   DCACHE_WRITETHROUGH);
> +
> +		/*
> +		 * The default implementation of this function allows the DRAM dcache
> +		 * to be enabled only after relocation. However, to speed up ECC
> +		 * initialization, we want to be able to enable DRAM dcache before
> +		 * relocation.
> +		 */
> +		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
> +		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
> +		for (i = start; i < start + size; i++)
> +			set_section_dcache(i, DCACHE_WRITETHROUGH);
> +	} else {
> +		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
> +		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
> +		for (i = start; i < start + size; i++)
> +			set_section_dcache(i, DCACHE_DEFAULT_OPTION);
> +	}
> +}
> +#endif
> diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
> index 7e0f3875b7c..635fc3568fb 100644
> --- a/arch/arm/mach-socfpga/misc_arria10.c
> +++ b/arch/arm/mach-socfpga/misc_arria10.c
> @@ -243,29 +243,3 @@ int qspi_flash_software_reset(void)
>   	return 0;
>   }
>   #endif
> -
> -void dram_bank_mmu_setup(int bank)
> -{
> -	struct bd_info *bd = gd->bd;
> -	u32 start, size;
> -	int i;
> -
> -	/* If we're still in OCRAM, don't set the XN bit on it */
> -	if (!(gd->flags & GD_FLG_RELOC)) {
> -		set_section_dcache(
> -			CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
> -			DCACHE_WRITETHROUGH);
> -	}
> -
> -	/*
> -	 * The default implementation of this function allows the DRAM dcache
> -	 * to be enabled only after relocation. However, to speed up ECC
> -	 * initialization, we want to be able to enable DRAM dcache before
> -	 * relocation, so we don't check GD_FLG_RELOC (this assumes bd->bi_dram
> -	 * is set first).
> -	 */
> -	start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
> -	size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
> -	for (i = start; i < start + size; i++)
> -		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
> -}


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

