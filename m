Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76602EA4E07
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E54E183F4C;
	Mon,  2 Mar 2026 15:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="m2XSCfo8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m2XSCfo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A745583F4C; Mon,  2 Mar 2026 15:18:55 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AB983F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sBiJhWwkKn0O+4akRNyoyNYBIkWWuJ3glL7BG3nGgBVGqkWg3rCcaaV0iyY1wawDvOeoRkbvLOZ+R4dUMHy9ofULvxoCnaOJ1RjDn+iM46nrF+1KjVPnbqGwF5XpE0qN3Bbvqrwk+s1+UarDscxK/39uxMxefv9XZvx2ZgqMcXRMWhUdrELAZ2oaYGW/j5jHf86ybw7DdSOZrcHf1cTlk0xSGrT2lOezFClC3OK/mRtVzXkiiCdIkfOMhiatBr9oOaymvFGGHi7V2RTEaQA/XvlndQKHjGk6z+9chCa4MYVqXkiW1PmblmG6DcaRkcwMkKPwHAabJegfhrESbOqobQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krSVunAurDXPs7lo5fmCzV+CutEtpPiXtr/gFpk7RtI=;
 b=KDJIAEPpIpr8Ke/xhSB7yL/cmci4dI3x2uHNK8M3/zpDOSjeGCgc7x/SQiBjPSaMbrret2iI+0pFZeoe53mjAepgp8/LCT/1NK7h2AIVoLylOqovrduunUs4++WMlFsk5fD6vDHKc8vE+fvEo2GE69tNU5807m5aF9VPPNlvh+3t5ho0ZKBaSiALAkZPcJEeign72KrIT1Nkyx8MVtOe0nSABFtRF4VeAOaxIfa/yqfmDsAX6KVHIxTWUGWI3/V90Mn5o+wCaqHz/IxEQOPA/UPcVX4ewIOqOVX7ACcC+XhepRXEZqt+J1EXv8VpoUKSEESvxlfLk7r0sG+/V2tlVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krSVunAurDXPs7lo5fmCzV+CutEtpPiXtr/gFpk7RtI=;
 b=m2XSCfo8MID4Yjhl67IWKZNU0qBNh3RLohiPO0ikWgFQSIk0kV03dDBBk1m01whOJDhaVX0t7+gpLizEeosbPrneWMFsGBFS7KpYeRwLK/tONWzMbj2eBwzSwDAHkPlQh2p9Ncc+fyO3uQiNcVTmndWG3HbdQFWPzNYq0zX4QBM=
Received: from DU7P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::21)
 by AMDPR08MB11459.eurprd08.prod.outlook.com (2603:10a6:20b:71a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 14:18:50 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::30) by DU7P189CA0014.outlook.office365.com
 (2603:10a6:10:552::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 14:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Mon, 2 Mar 2026 14:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypUcHE/wAYggwtBGQYQyoaTCvY6zWmabNlG8QxaWYRa0ooRqtRVNnneU/OQHiesHIxdMDkuI9mZSri9TftyfNuh/BsXrPzrlTaRkEG/ZerjUFsZ2tEpz8704anqPmWHl8fwmYvAerk44wLKo1Y2SpRRrESUAkR1EjR1Z7OLXDaMD1KNQRmGHyprfj0g0X+pwGmlH/ZzrVYLQftZNGjIpHJduqDX6vtI69J7r9EYKULko9qTBAb8ZR3xYYY+q6bF5Ry/7p/hjqhrwRblE7I3wEWaA/aJIdfgLrTv1cnUiWsJF/Vzk5h/I7HvhUSQ1uJiddWhkkWrYN9MNvOAkDeEXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krSVunAurDXPs7lo5fmCzV+CutEtpPiXtr/gFpk7RtI=;
 b=dlj2e/B819Gc6j1xqzwfpkaXE1oujB5X5tz2NrIdLvvB17gLP0IP0XAkNK/l8zjxlDZ7Z59+iVL5Xpe6tCZsd50KfgtaA0LvzIetxXPJDcpOG2UD/m93M+o5su+UfHikk4eZikP5HMAa1S5ggPuUS/rMeOdJDxILA3MMe0u0wSHyY8hYmceAp5Dz/kf5JO0hZ/fknFdRWa+KPFgjV/VO4+Sh2BnG3N/pWx5j51kvx7ScPNnOqJSarJPZipLWTBvlIDQWMJhLgQJln3bcx7B1cx/09T5D5q5dZH/o9/6yIRGV+LrSppa0mz9K4i11xfdcBoXqIFSnDW4r0jZRd7wPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krSVunAurDXPs7lo5fmCzV+CutEtpPiXtr/gFpk7RtI=;
 b=m2XSCfo8MID4Yjhl67IWKZNU0qBNh3RLohiPO0ikWgFQSIk0kV03dDBBk1m01whOJDhaVX0t7+gpLizEeosbPrneWMFsGBFS7KpYeRwLK/tONWzMbj2eBwzSwDAHkPlQh2p9Ncc+fyO3uQiNcVTmndWG3HbdQFWPzNYq0zX4QBM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB11625.eurprd08.prod.outlook.com
 (2603:10a6:800:30b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 14:17:40 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:17:40 +0000
Message-ID: <99c81520-9f2f-43b9-81d6-c60fab345533@arm.com>
Date: Mon, 2 Mar 2026 15:17:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, nd@arm.com
References: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
 <45e3b935-6e0a-471f-b87f-6c03edd4f237@arm.com>
 <20260227144909.GR1593142@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260227144909.GR1593142@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0583.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB11625:EE_|DB1PEPF000509E9:EE_|AMDPR08MB11459:EE_
X-MS-Office365-Filtering-Correlation-Id: d474695b-ad45-4c1f-211e-08de7866a067
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: 6hmD93amGIEundSv8eccoHcrwuhydmSaNVMIOKYpj3IQDBFNLTTR4ACLKp8R/amXYwA9NK1pQlyzWYRoYw2zehX8QJ6LdfoedSKIrhxZSdBmUPUUb/fWFEOyZ2sShy9TBu0V42p9wmU5Qk9BwDDTEvyDlETWwyEjno2bGeILjUxPeoGqRABPwnAjHaYM7K194Mt7JAY5eq98NPuHk/1dJxwfcmjHSsNbtW68JxYvR3wv1SAK3lEvXwWxLRc8isZRwOx8C+QlbCbuSoRiPKIgt8DPi/Om8+L18RRf+3Lj3Wa1bVD8gpl4isbmHTWwikLniuTDtjZFhKY1I7ddCXzSwmRITSltdnThOyObAWa7ibQXnX5n0Gbbv7M1aL0MayKrF6IprLU6G1tB41KcaKljsa6fGdaDRSTSgfYEVZizybookNo+8/Jb5pW6pUmZ3HrxIIGye3ojHlg8WOlVIdpMXoEnG58kjPlZcLVlHxB4wVfjNPjlp7u5E54QyQ/MOz/Pd4RmF8KCoIeR7GqHXDn4mdE33GMRJRDr4VnMdJ7So0dCx9VmxmIRyGANtE37lDOE1EUOEW/rYxbWa+keLcRy2Itbot5vEVi6Jc746nl6R9uAz/FxNioG7JgzUmNs4k79lmQYLzDSCyTJNb9YlTbBhzUs2Nqaqm1L9MRXZAJxi/Ex3UYiIEYCi203Cx+aGssharxX5+pVYWEdKi9MMPNQNRoMi1E8+EbG3cN2FbJV6dI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11625
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f01a7cc9-ae6c-4b8f-0052-08de78667660
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|35042699022|36860700013|376014|14060799003;
X-Microsoft-Antispam-Message-Info: KE0ZpiaBFoNUqiy7Y63QO8qrVNGnizYMQn1PF2Huw9BVJNZ4GXStDsP53feLirlAX6jytmAm0+tTEB4gaFf6qCHd6tk8VjPRC1JggAFcxyyyVjhRnMiDHpvXOEfNsQtEsPaRD5wdTqntNB1JVuSN6/1v7SXrtJwjobWyZ9HK0XAwU31iVT/CSkjwC/fuftnPtEznxsoh7V2jzDXt30xezziNQngV3pbaMRhrcK/DxvDlCdpPzky8oEpgEMv1e6WCFfgQhBpH28ie7wsN6Uf5QSkTdh6OlX3irYhJW2pVx4csxphx47Sa1HAzniEhh17RcCmMQbDqUgPn+jaacFJptFVks4G2IxKx8zAHThiYktsJURfAe+253Xgu84NGWcZQ+GWVUmIq4HvSWvHIiipYPV6/d/yCkZbpxTtdUod6v0J2AuqPYOiCgkkhop8tPXBRjlKrrgtUh8NsAfn2dhq5t5K8bVaVJJnQtqXtW2nvihioVQ06+RqGt8UHYCMPEQ755kT7UrKW8ukF4n/mLVCJI/jj4stD+OylbcFL+coklCOhl3OLIOz41OucYzDXK+r98h9KBj4d0IibUQQ4A/HU9q7ki2t2xHRjCr/JuuBSRyBUEMsxTMejtFuFuywmhsxNE5xDDrlFtie7gOqvn3CpSMw3FLMtJ0E669LHn21wF00k6E3uZ2nWsmxpi5IQvtdsp0Z64WVVaUDzbaWlBqL37EGS/oH54d6jWsPNV7+acccEx3lSRs/u2ToSDV0TxM086siYEvrLenFJ8Tj556elR3BqwR906Ke31agdAv/T6rpwdxrhB59jOhvhdBHShlHIB2isXN7su/ZtngU111TSVQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(35042699022)(36860700013)(376014)(14060799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ikHH29JfpXrxayJSUGZ0iY/RfVTwQMgjfecQK5OSpZHXBf9NafZ9VJHdp5drpirtVtoG9iw6oa9a5B+vhB1yb6AkvBWb8EI1RCdLp6a0At4gNicNb4Q1VDvDetgsCKiO+U9MCOps/ADDR7+EaD5vATUphlKcCGwSs6FadLTzRxsE1heRBNlHTvGz0MNQbRH/VYlgLp3EkgStoiMjeCdE8Uu3vg0LfjQk2vPlCWvJs69pA7N3bEdD1E7XHCHEKYBk21JETpACZgC9bNpXrr1uN76ttrsJ7z/ck3d/Rx5PjIsJ4N5bglFs0Umkp3LDHvd/GmqTEU4zjIMh3FhqBlpmRi12lr2YHDhjsAusnGsFLqGgcEQ/gnf/Rg5J9Zqn41CwFJ67w/1RrFbpW2V7YF2S1FNLvAVFL73T70DIxxrhVt7ubMhDAAds3JzqqmeikkRd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:18:50.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d474695b-ad45-4c1f-211e-08de7866a067
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11459
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



On 27/02/2026 15:49, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 11:03:32AM +0100, Jerome Forissier wrote:
>> Hi Heinrich,
>>
>> On 25/02/2026 07:14, Heinrich Schuchardt wrote:
>>> For enabling the clock driver we use symbol CONFIG_CLK.
>>> Select this symbol for the HiSilicon Fast Ethernet Controller driver.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>> @Jerome
>>>
>>> I could not find any usage of the drivers.
>>> Should they be removed?
>>
>> You mean no defconfig enables them? It could be that some project
>> downstream depends on them though. But do we care if we don't build them
>> upstream? Tom, what do you think?
> 
> In this case, there never was a "DM_CLK" symbol, even for driver model
> using CLK, it should just have been CLK to start with.


I think the question is more bout HIFEMAC_ETH and HIFEMAC_MDIO which don't
seem to be used anywhere:

jerome@builder:~/work/u-boot (master)$ git grep HIFEMAC_ETH
drivers/net/Kconfig:config HIFEMAC_ETH
drivers/net/Makefile:obj-$(CONFIG_HIFEMAC_ETH) += hifemac.o
jerome@builder:~/work/u-boot (master)$ git grep HIFEMAC_MDIO
drivers/net/Kconfig:config HIFEMAC_MDIO
drivers/net/Makefile:obj-$(CONFIG_HIFEMAC_MDIO) += hifemac_mdio.o
jerome@builder:~/work/u-boot (master)$

Thanks,
-- 
Jerome
