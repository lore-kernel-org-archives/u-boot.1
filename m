Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F95CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 14:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED2A880AFE;
	Wed, 30 Sep 2026 14:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwUxcnuNjD5P; Wed, 30 Sep 2026 14:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2852A80BB6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790779669;
	b=iX/uWbRz8WHM7e4FEtUChc1bKOkRBXvHJ4FWW0ppxCwe7KHcenjB15RcUkhQZ6TF+lml
	 dKyeHeS8uEe7fx0vqPc6xGQqWuRkjjiiCvPI+8FrOnrflnz4UjBtwB0mJtAQOMisvu6uq
	 FcCOx1YKi5zXpyd1uuaxL+GdpTOE+TphXvfFYys+UO6UJpDn4eSWfoZcuSr5CpRukzGuD
	 aS3hG2LiK/FpReEtazn/Z7rFLyCoOoqzuP/WKstC3bJc3/cWipDihYolKSMeM6WClDh0f
	 GTcj/xzY7rOTXbkS66y/5nK2c+xjXDaSudEvd4z9TjrH9LXRD6SDKWpph+7GdDbsrOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790779669;
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
	bh=dnMteGO56BWJfoTet38ut1idYDyQqm/lNwY+55LRz2s=;
	b=MFLu74zFuPwbJOwNHGs3EINFsukJUuwWYEAB8uUsr3gt6v5usF/EHEwTeVf7BD0amGQI
	 0khw50re9+SnSPMsxQPgsLCbieSSx+8T1IYePdHVmp8kBJMz1oCeZynt01q1bB1NF34hP
	 DkygCJGBw6zyZJpSoG/38Y0JAF3Yu+aPmKooigI5akhcBdeVIqgMXkxnBybLgyeQw7ACb
	 TEQoSFAPFlDSgLaJnMywypb0vU4DgXLqCx6RN0GMastevp1I8NIfOnz/Mzt316r2cQCZV
	 +q+jcjUjrLncWNv2C5m2rIwV3qfzH6eaRWQJfp/gbqhegGwZFR02PoZ465tJJdFiGsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790779669;
	bh=dnMteGO56BWJfoTet38ut1idYDyQqm/lNwY+55LRz2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iDSxq5/Fjn8mbSEVEQP73X/0pEC0E4BqeWASiI37evoRP5ZytERVYm7gm9pGkDbAo
	 yjBRIzT9+2Kz5B+zZje33W3kZGXbjKF3DhTMa0tlZiEfbrdQwaOaOXaGSvIq0nuUB/
	 9nM0dAkfiHax34aLZzYHycpf/EiZmpLheFJxH3p32JLoJwKpYscUfFKKVXCA7cMZSp
	 9B1S4I6o3Mv6KR2MCK2kUJ7hCrMKq1lGMNKwS693tVvdApHLknmEuIVnBkVBfZx0+R
	 E83Fkq16ZWOmss35F2nUk2Eo9izWLNb8eqxjnPdQu+cC4pbraWD+rMpnhS4UzJSkPA
	 c5AGmGdPZlsPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2852A80BB6;
	Wed, 30 Sep 2026 14:47:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BC854C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D96A404F6
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quFD7VSeXjia for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 14:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E9830404F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790779666;
 b=Q6DQosNZFk+hoAITuSk0zg0+4NWcsOrb9/Ke/k82d/JkPweFK1A6Cz8WnhgkUWzfAJhQ
 QrQEToOZ6N+q5mnyujnbLgOJ9MlDMkI+Bd+0Kb/5NuUFwB7vEdrR75qtJLcgusl7dw4WT
 MUPLyj08Vx1hwX19VUOk2q52+sKbdU1BgXC6lyhUjqW3cDh2h31+Uk394TC6g24/MgcTA
 h2A/ITyP1My+6Ny0nMiKoStM+wa0GDlhs9pGvRzq7cMonLHVT0GU8tw+HDwB092N4pq/w
 QReJqwr7nEfkOSlDKUFD3jVhzd0FnHSRg0HG7urfwrzfDX9ZHA3sQeL3dNGgLkiaRvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790779666;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dnMteGO56BWJfoTet38ut1idYDyQqm/lNwY+55LRz2s=;
 b=CWYJDig7/HPKP2vdYWzNDrdHztQZVNniyIHT2n77yuqMafnr7N3A8yVXj1vYJWK5TBsP
 CexiRdjWb6CNwHauH+6StEZy10R29rD6uwtVKqUIroeTXgJhkAGDKIlXNC9ewQcP12/iY
 AYV4dgf4vG3SIDCh+KQOIo1oBsJmh8Sajd9npSdB7541lA9+IYE5RDw+5umYMfykv5vBJ
 yut1Bu8R3wLfC7Eyy9UKt6BIpFpDMgyrfoYxNHqsfFlKjbPXVKClidiMB+2qmP5NJ8sSU
 E97KR1fFVR7bv6T6YyrRlU1HBMjXeuX2wK6jHFpHwmt3FggnO8Rh9e0eqz5rVKP2sFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=F0hnKqpb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=F0hnKqpb
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9830404F5
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnCzEkEDfiB/9j4fLBg5aeD+kLd+0/Ahgw/jtzTuzSbv4PxeeojvJtci1N/Bxj6ycsyJc1aK+P47lrLkZLhgSmIxpSgbtSYZCFsGlMGZplmpkZXd/zC61NWPzDWorD6DdHdlwbCWh1r6apVEyLPGjBqL920BeeNsGKRI7djbST//ToNrkh2lvAGm8PIIXEDsnptCuqkl1CVckw1gIzJrZtZBzxeuo9R/X4aCDJxK/lo+7ktkMHFd5w57IrZD+rtFik8uHTYVMHzBW50XF8sOtg5uXPYcfY/YRBzAJVGK+Uph9uWq9HV4dwGU5Aeqe5wnuXI7/Fi5Y+UCc5eKj4qmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnMteGO56BWJfoTet38ut1idYDyQqm/lNwY+55LRz2s=;
 b=V2xjWQpe2jj2YxpJEzqcA7d5gdvSJq4m3t0rSpobUd6vkx3zQHPw7o/jiGX0DRq4GPLybZMRXIxgHQDuYRHVnPOCTOyorVD2mz//mKUrGL48yUg4ap+Rr2O/rq0f3Umqw1AXhxRHeGd3qGxuD6AHL9ZScuuUx6GL4R+i6w3DwUOxS9dq6xvvsf55sv0jWlxg53WVqCqoaC8WzXKnTzKisUF9MkXMYZxS2W8giFAGA9QFiSzQR2H+UiaFMcEUd9a4pf6yqjlrSHqh01U2gR9snZjt/eId+rAccQytTEHvwavekLnxuxiyOpnWv/6+KUzFG7N6cLZmNRcVzIkDTD6oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnMteGO56BWJfoTet38ut1idYDyQqm/lNwY+55LRz2s=;
 b=F0hnKqpbZ6gtwvJSvWzLEE4i9wpFyW8IGyofWf2WOhlriMj1yydoLjgwAbMxBOChACIu+RYLS6d8niHqGGYoRv0x7kLTGHYDBWp6Id14pj/dGCanOUyrmdQ0jGDAJzHEtvo4bJvVUCxZF8w5rnw5fZmdUG6Nn3+X+YxDRvpV+yA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB10439.eurprd04.prod.outlook.com (2603:10a6:800:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:47:35 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:47:35 +0000
Message-ID: <267d5e88-808b-4b6c-b5d7-40097be1c170@cherry.de>
Date: Wed, 30 Sep 2026 16:47:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add Genio 510 and 700 BootROM download agents
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Johan Jonker <jbx6244@gmail.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB10439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c893b46-6917-4e2c-4179-08df1f01c3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|5023799004|3023799007|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 250CF98qpmnW3Krp35tZ1iimAud/izjDnSwxRE57M/FAoY465ZHquV9yRtxQahPFmuYDt3THQKVwegHSikWgAYMy1eLuI2XKC600dNr+iRz7zgZQisQExNQk6fDPY6KJRY0kRngjCLdRlAT+vN9Ejio59JDoShjqChz34+z4xTxaGvXGGkXpFL1MidvPAysQ8ilyFNAUrNkf67a72YR72F6M2UuhHgqQ/wKdgU2ezX+Ouuu5XUHThxtwVDtixuZji/XhbKrA57FQcQgjejn29Gc0RauNPqryfCKycvG9gg042eNWcx5mvqzMjD0mOU0pRwEKNQsch0z+vxr8hTVlfSW/1VmN4M5xchJ3uX5OY2sIMhD0EFxkzce2ZD98nx++qfUaQks/fpmrtACy1QRIKQ7r38EOvzDU9TA5wjdx07MeWnnr40lMAqfqZurqTNwIkFQb1S1/khW9HautlQIRUX7/0RhtE7fTP0bPOGdADhF507Iw+p9oWErEgz+6MhU5qFss0WO4umXs/fpc0b3q9xDy8BQri26D3HCaRE4uYRk6CC0TGo++IVBFnJi7lUKVwN0Op8O47HZACnR1KIESLcypb/HevRb2lnmMqlYI+eWxqwWhGz6J9xnAxIg3ctal2fbGZwhc7weefZFIF/w3KidwTsZtxdtLSXgdUVukMJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(5023799004)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkR5Wks0NU1EcE0zcTU3Z2ZWMmVnVjMxbGU3RFBuSzhXMGZoSU9qTHV4bVB6?=
 =?utf-8?B?S0taNHpoL29IZU9aNnhJc1VwOGRURENsNGVuWVl4OUUwMG5FYTNaVG5sVy9j?=
 =?utf-8?B?d2cyZzhrQnZCQVliVXBOY3ZqaC9GdkZxa0hwK0JYV1lkemtEeWRqUVZrYlJU?=
 =?utf-8?B?MWEvRHQ2Q3o1aFlkbnRKRGNuR2d2RXU5ZVhSOEsrWFZwdnJYK1EwQ0dNZUJQ?=
 =?utf-8?B?eEtJcS95bzhTRmphT1pzNzR5bEp0NDA4YlBNOUg1T1JHTUQrT2N2ZjJPcEZq?=
 =?utf-8?B?NEYzcU93a0xqVk5mKytYNWZYZlFqUzZVQmxSVkpkRVhnWFlwZG9lY1krWU1Z?=
 =?utf-8?B?anE3dnJYckR0Z0VhYTl0aXpjRG5RSGF5a1RoYUI2czN3czdQbE9PVzdLREw1?=
 =?utf-8?B?NmNKSU9nbEFTb3JCTkdXUGw2Z0RQcXV6WDBoazFCQXVvODZiSDNla1IrNlFF?=
 =?utf-8?B?TDdidEpick5IT29TcENuUDVmL3NwMFF1NmNGOWFDL3dOSTlCNjdvQUMwczZQ?=
 =?utf-8?B?NytJS2RncTZ6Y1hzZ20zeWNwRFY5WHM2cTIzMDViL2ZkbWE2OXB0M0ZnZkcz?=
 =?utf-8?B?akhYdmpoMEdHSWp0aWZJN0R6cWJPME5Oc1BYSDVjNm56MmlLTWpaWHRxZW5x?=
 =?utf-8?B?QUo4VkRVWE5jL0FEQmVkRzRycU1PRFFjUUExT2ZnZjJIeDBOSnlDWmRCd3hE?=
 =?utf-8?B?V28rdFZOaUFpSVp5Z0ZSYWdXaXkvejlCYzZQUVVjNzNwUzhaN3kvNUc2eHg3?=
 =?utf-8?B?N25mcnI5NXM2UCtCNkdFN2dwQm1jUlptVTJVSTVMaWMwcWh3MmdXYjlrbUJK?=
 =?utf-8?B?VWg4c1ViaTc3S2N1VXBKY04vaXZxYU5pcjZQMng1T01ENEhpeklLemJlOXR2?=
 =?utf-8?B?R3V0WDhkZnF3blFSNEVUQXNwTys0M1c1TG1Wc1dGd3ZiYytXSE9TWXRSbTk1?=
 =?utf-8?B?YjRxL0M4M2pTNFZjOVp1SHAwZnlmK1psV3JhVGltV0s5NUNobG1Qd2FwYXpM?=
 =?utf-8?B?anpPYU9tbHVMQ3RlRkExZUIyeXo3Z3FmMTRNK1EwNjdPekF3UzRZL0p4NjBH?=
 =?utf-8?B?KzIyTVl3d2JUMkRnK2FqQ21sUzFjUXppRDhubWp0ZEZrOTd1NnhKVmdMOS9h?=
 =?utf-8?B?d0FQMk03bFNCSHhIMDJXaFY5akcrd0FqVDVGMEJKampUUFB1clRkRlZYZlZi?=
 =?utf-8?B?Yy9pc3ZJbEJ4QkN0SG41bWgyWHBOdGViU1FDNDVJNVB1ZmZPWEVObXA5Y2dG?=
 =?utf-8?B?MldpVlJJa1hyVU8zcWErMndHTlhqYzAwWGwwYUxzUmY1VjF4bTVWZms3N2Jz?=
 =?utf-8?B?ZlQ0VFlGdFpNRXpjZE41RXRyYWNWZ3NxdTE4UVZsZy9TRFd2aHpOZXVMenln?=
 =?utf-8?B?dU96bk1aNkpncDJIM2o3cHhrWGVJK2pnaXE3ckxOeTlRT0d0c0JBVzduNElv?=
 =?utf-8?B?Q3Q5UUhDSlBLZU9qTm9PUzY5T21ySkJnSTJMdTUzd0Q4QUlkRXprRzk2NDRy?=
 =?utf-8?B?NEwvZU9JTlRjV25LNm9HeGJJT2RLTXB2dFNYaEwxMzRUYmFJd2RLa3psNVRL?=
 =?utf-8?B?T2ZmaWg2UlBCR25jUUg1YXJTK2UzL3o0V3lvZU8vMFJrczNJWmEvaTNHem9y?=
 =?utf-8?B?b0NHcGlTRURYWG1NVk82M1VydGR5YWtGamZUWFFhZUNBUzhaUHBGUXkyL1Jl?=
 =?utf-8?B?b2oyRStIMFFRVXh1WXdTRXQzZnBCTUtWYUdOUWFQM1V2Q0h0Q3B5ZlJ2QlhO?=
 =?utf-8?B?WDl0dzZJaWNMSEFuUFV5L0diZ0JoajltZVZZYktyKzJFN3NVQVcyMm1TbWo2?=
 =?utf-8?B?T2RKQlJHc2NPSjIzWXZwazVQdjNLZi90MWFGZ05aT3FFZmVSNWN2RW5sS2RG?=
 =?utf-8?B?U1ZFeGJvR1BrTFR3aXFxdFQrV1NvUENJbG5GbXYzbTlOeGpSaEYzUG9PQ20x?=
 =?utf-8?B?bjJWWXJTemZVY0Ztb3ZDTnhiZVpOQy9NLzhSVWJycHZzbk0za1ZnUm42cHMr?=
 =?utf-8?B?eGN2VUxDNE1kOXJHazM1L2pOSlUwRE5RdmpqN2pNaFhaZXI1S2pkaGRZcUpj?=
 =?utf-8?B?R2h5SUJYeGlJZmJla2NIcU05T3d0M2Jidm5QTVJLZXpDazNzOU1MNENIbE02?=
 =?utf-8?B?VkpWRGFMS0dqUTJjcUloMTNEN0ExRjlNNkhWbGNjRTk5RTlGdFRlSHAwZFRY?=
 =?utf-8?B?ZVBldDZvemo3Y3gzaFFEVjRnWnpteEJsS3VzV3dsOTBxdEh4Ykc1Znl2Sjkx?=
 =?utf-8?B?OHpEU3lGUXBHa0RwOUdaSTczOVVBN25ua1Z4VUtxNE40bHBYbWRUWTlUMy93?=
 =?utf-8?B?K3JDRTVWNURNcEVWa1oxTXJMUVJHcXl5TENtN2kwR2hQQUhsNUlKUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c893b46-6917-4e2c-4179-08df1f01c3a3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:47:35.0069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bknghaBmwIca3ZeCE7l8NicoGkVZ90UySxunRbhxdPV40dWFxg5YORpkPSxbVoyrTI9XQynC5bELdmpOV2AG1tR9Rf61Yzmo7+kChl3vGeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10439
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Carlo,

On 9/30/26 2:51 PM, Carlo Caione wrote:
> Genio 510 and 700 need a way to provision blank eMMC and recover boards
> with unusable boot firmware. Add RAM-based fastboot download agents that
> can be loaded through the MediaTek BootROM download protocol without
> relying on the installed bootloader.
> 
> Fastboot in U-Boot proper is preferred when the complete download agent
> fits the platform's BootROM payload limit. It provides U-Boot's shell and
> boot facilities as well as flashing. The SPL variant offers a smaller
> executable payload when including BL31 and U-Boot proper would exceed
> that limit. Both require an external DDR loader and run fastboot from
> DRAM after DDR initialization.
> 
> The two paths start USB fastboot at different stages:
> 
>     Fastboot in SPL                   Fastboot in U-Boot proper
>     ---------------                  -------------------------
>     BootROM USB download             BootROM USB download
>     (host -> SRAM)                   (host -> SRAM)
>       |                                |
>       v                                v
>     DDR loader                       DDR loader
>       | Initialize DRAM                | Initialize DRAM
>       | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
>       v                                v
>     SPL                              SPL
>       | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
>       v                                v
>     eMMC provisioning                BL31
>                                        |
>                                        v
>                                      U-Boot proper
>                                        | USB fastboot <-> host
>                                        v
>                                      eMMC provisioning
> 
> This series is based on upstream/next. Generic SPL fastboot V6, applied
> to u-boot-dfu-next [1], remains a prerequisite.
> 

Had a glance at this (am not really interested in Mediatek :) ), and the 
single question I would have is:

why have SPL_ in the middle of the Kconfig symbol?

Can't you just have

SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT for SPL
MTK_BROM_DOWNLOAD_AGENT_FASTBOOT for proper

so you can use CONFIG_IS_ENABLED(MTK_BROM_DOWNLOAD_AGENT_FASTBOOT)? You 
can always use IS_ENABLED(CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) 
if you want to check the symbol for a specific stage.

Cheers,
Quentin
