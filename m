Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03360A2615
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UgETiywR;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=lXj+SfbM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E21160760;
	Fri, 20 Nov 2026 18:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlRZGTp507Ij; Fri, 20 Nov 2026 18:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27A59606F2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795197633;
	b=AiInzJ2URNmUruJBO6DNLFdQXt2PWNiwp0/TLhzV5ny0EKwgszGqLZc7lxRGE/8HDQoh
	 se/ntYWEmD2tbY70oqRxZu195Xcl30Ts+rSN3BEJZLvK+Pc+xzyvRR2Ltg8P3QCBn5h0w
	 wFkusAfzO2NcNUsbsaSnL6ooqL35RWdMtg+mIq9N0pJ+l67Lq54gmIzGSerIXcJv4JDe1
	 eMjOG6y7D2Dc/YNZ3kmLscBoPmhVgm90Slj2PUOe2/769j1kPBdz6Oiu/IgkLDrcoMify
	 +bpdpVdlP/9V8Zrwzh1Cd+QP2gUPSO3/k96/IuBYEoTO8pSp2MWWGGFu0bJ5472CZTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795197633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RGOpaR1k+rE+REXUA1QjQI6IAiDr5o5m3+6Rt6ridwA=;
	b=CN7YbMnzIForyTHcS2iy2yBiaKpbuXaVjS+1ZUSKp9texLCN92Vc1uWHO5bry0bkvOmk
	 IIbjKAeGhI2MpoHpiM3wRCv/wt6eJtkZBDTALjjDuImYfilGsnCCHmDJEmZ/8H9DVHKfn
	 kefyRA+lHwwGAQpB8kFHLzgBauIfHjc3le3VI8t6npBdsGMCKpUTW7oM2gX0/NI+jH6Vb
	 RJ8yJfR3BqHYLgi4C2MsgVE16oC3KRhqNWQIRRlGDaSayNs2S9KXlJc6J8M1hxuZrPyRM
	 F64sL4zAw3J6rEo94fuC2JTRNIzQHWqYB6BAdRAA6GV8VRXyF1gOoUFdQSbmxhGfSuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795197633;
	bh=RGOpaR1k+rE+REXUA1QjQI6IAiDr5o5m3+6Rt6ridwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UgETiywRTj/wcRGpF1xM8U5Oh6Snp4kX6rf73yKjoRRuYGGmreXFKQKLi2PKiPIO3
	 nef/DAFx8AdgAq9oY21/GO2QUEbnsUJp+LHasOrBEM31fzPVzRQzPyoBTgvCL1wOtp
	 E5g4Uhrf2/eUVTFsnObWPwNS6FZKevlRCHI/lOQ9+E/HlIJ12NT1EMt8o8gh7aFpfI
	 Frt+6+NaHC8VGf/YoeNasGoVVGapk6BgIpaxPfjBnEWzbDpwVY5yhiMFouVYbXV0q/
	 +EmBnqkQ8X2QMHDHMDjCE2S1znjxnmb+KaUfLFiTR/478UWoqmRNny3DNB36DH4g06
	 lTVPoWl+TN+ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27A59606F2;
	Fri, 20 Nov 2026 18:00:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A0F270B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F40CF4022E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OrlZ6vbodL_7 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70C79400A2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=lXj+SfbM
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70C79400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGOpaR1k+rE+REXUA1QjQI6IAiDr5o5m3+6Rt6ridwA=;
 b=lXj+SfbMPgGJyNqQB2DJkx/b2E7Vy86nXk804RFogNeMQ/+wSLQD/6WQy9w9koMVPVaFIu2jHYrCIrdFvf3A586blqOm+zhCM88NH1WXFu/wR3DcktjGgiT4gk9kT39cr56uZA0vZS5oMDkehqDWTOrXoaMj2wcS0FwEZ0YSWNE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AMDPR04MB11678.eurprd04.prod.outlook.com
 (2603:10a6:20b:71f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 18:00:26 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 18:00:26 +0000
Message-ID: <1a3cfbda-3f31-48a3-931a-1b4609011ef4@cherry.de>
Date: Fri, 20 Nov 2026 19:00:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-2-jonas@kwiboo.se>
 <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
 <6a5e35fb-2bfb-4551-a9a4-2f51a1cbdaad@kwiboo.se>
 <179e0a6f-0dd9-48f1-a79a-3611ddb30cd8@cherry.de>
 <c5cf9db7-7d54-47b7-8cc0-2b677d17fbfc@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c5cf9db7-7d54-47b7-8cc0-2b677d17fbfc@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::17) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|AMDPR04MB11678:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cf2d8c-68f4-425c-0646-08df473027d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|4143699003|5023799004|11063799006|10067099003|261026140227099003|56012099006|261026121527099003|261102123227099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: xGslw9CNvl3p/4U0Sqs427rKIc+Cgy5FP2Lkz9QPDlQ7/msTor8z1mmmhcVBQ3Oy/07aaLVoCYIZWGYgwDahzOSt8FtqF3TOwAVg7V39kXn0ReldCj01dDtwAt5goiVzvBc7AcztdEBCWZoK38TKTDZTqXP24+8swTVVkQpcT3A8PvyRieV8cAZTfZ3uxtmxNtO3DdrEU2nTCYKWWM3lUa4uDcMmgCPgUXGjJm3u+aXNPab1y5t5jDMoneYoslkZEX2VnmR021QG8w7NlHLmpW1iZ0TLfY2r9cD/2e1mnXxrvJ7vKKWG8q0gJxWsnsdoGtB6jzSSoKXW9sFCWjRpDhD3MebHGrj2LSLagvxfYfJEIVgvkPV8uHBE1iY/bmDdjeeJqTlcqe46lOMin0PmUmGRv3A101xph2lUaqKHgxV9NAKzHgtXhXeYfch0VCigZqi1r1eBvUhG6mUApPADSVfRRwPYMHriBwVhQnwK8zhnt2p1swrEXmMtCSFzRQbcalGnIN24H0B2bTiYxJjk4gqJHKA1b0GUWZ8SrPl5ARXj6ud/ApqrVU9wHd+Gkz+zTmTIrTKExLoLKk4N1p9U1Ri8uQNDp17a74m5UzrTGZfj54YAjrqUhR5A7RDBit+ZJVnscOU5K2Jush8YQRS66CYDbjdvX9BTUpQ36NpUhy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2PR04MB11147.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(10067099003)(261026140227099003)(56012099006)(261026121527099003)(261102123227099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGphdUdCTGU1bnlsZmlES1FVZ0E3REpKYkFIQldmNUM3SXJGWk1zWjZ3OGJP?=
 =?utf-8?B?Vkh5NHlQYVVwZFNISGIrK0RBcWJBS0tFTTVCdUZkcDdoQlI0N1N4SzFJNzNy?=
 =?utf-8?B?cDZJc2pnUjl5SVBOSWlkU0w2T0ZzUTFnZ1E5cllDajZtQ25jWXhPSjdJK3NT?=
 =?utf-8?B?cUFiUHVNMFJ4UTJPTDVLZk11THZOUGt4VWxSRThERGs0SHY0clZraWhBRXoy?=
 =?utf-8?B?Z0U5UGFHUEVlYkp3RFhHaWREOHBmdHBnZ2IrV3ZNb1ZvVThmcjcxMTZKNG9q?=
 =?utf-8?B?V0J5eks3KytlcGFZSDJ6VEM4bjNRb21GV3gvWG9UY2NKOXVlcy80Uk1rd29V?=
 =?utf-8?B?MDVrQS9mby9YNFhBQVFkRUovWm1aYXBFL2NyYkh1VjVWU1NjZTFHQkVUbHVU?=
 =?utf-8?B?QXlLYUplUUpkQXYxTU9YeDIwanEvcytOMkRRSVBLMWNTN1JuNUs0Q1NWMmw1?=
 =?utf-8?B?R0R2eEp4UHRhWHhHVDJXK2U3TENsZHVxSnNjcGw2dGNkM0x0YkpVRXNpKzdH?=
 =?utf-8?B?VmRRa2FmQWhCeHFNMm9LR2Y0MnpBOVNySUNCczZSWFFYWUw4QjJVVVZhWitx?=
 =?utf-8?B?UTc0ZVgxaU1IYldTeTNqUmZ6V1BHWU5hUW1vY3VmNGd4RnV5M21XcU9GWHFK?=
 =?utf-8?B?NU52K3FycTYybU9WK0xLaUZ0TFgyZFQ3bm5BUXhvV0szUnFHVHgyeVQxU2Zy?=
 =?utf-8?B?RDVhWWV6MEszTGs2RW16a2RwZ0xYVW9uUitKeE9RcVNRSmVVZnBWbDJHRlFp?=
 =?utf-8?B?alVwZzRHUm5HcGtsWFRFYTB0cmNJMWFnbmhmK0RENWdTS3BQTHFocEhRS2Yy?=
 =?utf-8?B?alU2SFdyQXpMZ2Q0RVdxeTYrcUgzSWdxNGhaNmx2cG5TRlZRR1UzNlpGYkdJ?=
 =?utf-8?B?eGRHc3h1ditQcDBWcmQwa1RnTEZNM21XZFZnNisyMm1FWDZ3bDlka1Z5Y2tV?=
 =?utf-8?B?dTh1ZFdyYmFOanhWQVQ3RWhNc2tTeU9DMXoxUU9qdWRzZDVyWmN1QkF0WmVj?=
 =?utf-8?B?citaVUFVV09wUVRRQ1JXd0xVZDJjRzRYSHJpVTJvOThTWDhpbG9pTk4yVHhF?=
 =?utf-8?B?eFJHeGZpanlhNzBJNnB5NEtzZFM4VXVxc05zTk0rNDA0M25obkh1bmtQRWVl?=
 =?utf-8?B?WmJhMmJkdWRsUzBRanBwQUFrdTJuN1Y5dFQ5RzcyeTNzaTRuWmxWM0lZcUlO?=
 =?utf-8?B?cnNmbUFuVDNVVDhFN2Z6MDgxb3pkU013aUpPYkhCSlUwTG8wL0Z5dlpNbEs0?=
 =?utf-8?B?RHFSRWJVWXVFMm9JOUZMUU9sTDlNWWFjMXVHK2RhTURpNVZobVhMejFrb1RI?=
 =?utf-8?B?TXdPZDVzZ2lzVm9RSnllNXM3U1pSczNOSFV1YVUzMFNoOW5ieURYZkFVMksy?=
 =?utf-8?B?amV5Z0RSd05ZSjU0K0s4NmZNOFpweDZhWVV5OEo2eWErcWhCdnY2dXJXUWlQ?=
 =?utf-8?B?V1czWXc5ejlaVEluRm9HODl2Z2RGcmp2d25jOWVPclJDUXdzZ0RDL0JCbHE2?=
 =?utf-8?B?UE5HT0sydWZhckxSUHZlRGNTMWU2bkRpUjVTT283SUdJY2JlVjhtc2FSK0FO?=
 =?utf-8?B?Skl4OTRkME01QnFJcDl6QjBYQVVleVZPNUEwaTZzUDl0b0Q4eStVdHkzSnNU?=
 =?utf-8?B?U210NlgvTkZDY3RWZVFtMWpkbm85N1lXN1J1blJBRE5TblNGbE9FVzBQUFlt?=
 =?utf-8?B?bTRJVVNtZVpKNmRhaTBqcWdqcmxjTWFrMEdHQlRnWWlqQTVSZmNZTStxNjZ3?=
 =?utf-8?B?blg5d1BOejBTRmhkS2VUU3Z5U0xsblBmK1luK0NWYjF3R21UMnJuR0tsdVJn?=
 =?utf-8?B?d1lUVnRNT2p5Sm5xQjdLWlpMeXpzT200WGVaUDl2V1Z5R3BoY0hFVVAwdGJS?=
 =?utf-8?B?cjVYR0FRWWxOaGU0aWFYdTI0Q0VKVGhUOGF5YytXcDAzaTBQczEzbEdGeENp?=
 =?utf-8?B?eHBDUDBCZ3c1MnQ2Zm94bkVZS0IxZ2F4UEpsVmN4aHNkMGpjOXZ2OGRpMlZ6?=
 =?utf-8?B?MjVMZU0xUGl5NEFKZ1hwNHNYaUFBZXJDc0RFTkU2bHJzdHJNcXE0a0p5WFU2?=
 =?utf-8?B?dkx0WDlzWGJXY09nNkhzdTRPcDA2dmo1bXU3c2k1MWlvZU90dkdHWUFXU3NR?=
 =?utf-8?B?cVJNcUtwZmNlNVMrRG9POWx0RWwva1V0VDI5clN0WG96TTNyc0JyWk5sVnZU?=
 =?utf-8?B?UkhGTUZRQWl6VnRab0pEcEhKVERtZVVrSlN6MDMwSm9mMUphcEgycXloS09B?=
 =?utf-8?B?Nkl6WGdPTFQ0WU5aOVgzN0I4MEhaVlRDR2JVWDYrcm0vQ0l2UW9QK1kvWm02?=
 =?utf-8?B?bFNZMmRIYlA0RTlIS3licjlrOTVEM2VWaUgzZTViaExMaFlTTXZJQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cf2d8c-68f4-425c-0646-08df473027d7
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 18:00:26.3236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY3NcN8medlXZUl0+lptRcBjzA+lp/nBOZWWzbZtBxPdGLGH4KOlvQRDLpeqOrYfpS3XOjA0BtvSOQ5fxf570S2B/cpMlqOYNxDK0CA7csU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11678
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/28/26 11:53 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/28/2026 7:23 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/28/26 5:57 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 10/28/2026 1:41 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 10/16/26 12:42 AM, Jonas Karlman wrote:
>>>>> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
>>>>> gated coming out from system reset. The probe() ops of the PMUCRU driver
>>>>
>>>> Are they? I don't have an RK3568 board so cannot test this, but the TRM
>>>> says the bitfields are 0 at reset with "When high, disable clock", so I
>>>> am not sure what exactly this is for (except after a reboot where the
>>>> Linux kernel has disabled the PCIe clocks maybe?).
>>>
>>> I guess the TRM is incorrect, because as I mention in my commit message
>>> these clocks comes gated out from system reset, or I would never have
>>> phrased the commit message as such.
>>>
>>
>> Well, it could also be inferred from the fact Rockchip enabled it in the
>> CRU driver unconditionally. So I wanted to make sure it was indeed
>> checked rather than simply inferred. Thank you for the confirmation.
> 
> I would most likely have phrased the message very differently if the out
> of system reset state was not tested, or at least mention that it would
> have been a refactor based on current code if that was the case.
> 
> My expectation (and practice) are that when something is definitively
> worded in commit message it has been verified to be true, else there is
> a note and/or the wording is much more relaxed.
> 

Those expectations have been heavily tested in the last few months (not 
by you) and proven multiple times wrong, unfortunately. In many cases, 
words don't mean much anymore and they just make plausible sentences. 
Such is the state of the industry in the last couple of years and 
especially more in the last few months. I used to be skeptical but I'm 
near paranoid nowadays. Please rest assured it's not personal, though I 
understand the frustration of having to justify something you've spent 
time debugging and investigating yourself. It sucks for you, it sucks 
for me, it sucks for everybody. I wish it wasn't like that. I'll try to 
be more mindful in my future interactions with you.

[...]

>> You could have just said that it doesn't match the TRM, that would have
>> told me that it was checked IRL.
> 
> I did not even notice that the reset state in TRM was different, all my
> changes are typically confirmed using runtime testing ;-)
> 

I unfortunately own very few devices, so I don't have much except the 
TRM to help me review code :) Hopefully, this should change soon as I'm 
slowly building my own labgrid lab and collecting boards, but nothing 
will happen quickly, I'm pretty slow :)

>>
>> I can reword the first sentence to
>>
>> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
>> gated coming out from system reset unlike stated in the TRM.
>>
>> when applying, does that work for you?
> 
> Sure, please feel free to make any change you see fit to any of my
> patches :-)
> 

I value your input on my suggestions and I am capable of making 
mistakes, so I'll keep asking for confirmation for changes I'm planning 
to make when applying, thanks for the cart blanche though :)

Cheers,
Quentin
