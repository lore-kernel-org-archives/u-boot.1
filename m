Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C342C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 13:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4690780CA7;
	Tue, 15 Sep 2026 13:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wRgKTdx5r_Fc; Tue, 15 Sep 2026 13:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 92BC580C6F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789479753;
	b=o565HJEMNN0AuKhE15nj91Cad2/ifB211LoMARA68dZAZ4s7RKk3WT3jzLlEEw390acK
	 9QG/TgBGu2jQ+YzS9N+5hqEkXSj/FIpTdvUGdYkRMej7NrtKby3glnKvAVDOpavj48H3L
	 gOndKZo0cxpsD9X5myQYXNAAPmGRNZKCqkreR1A4Tvwh13m4KZHJ73rFoLj7Pdr7N+nHi
	 T4n4RZi8w8sxPAJ2ZViHPpS59j7d9Y8ZhuHtGQpfgJ13J9rybdBf6WCRLf7q0MzoFfN+8
	 xNEXv+jRY0a3AyocebTuahiGpOL3ezWpoPsYi3EKIRklmRvTc2HmelVSs1wqLFi1LNw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789479753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=iDuScJmjUzrQwz3v/NizI2n7FScHCtcu3QeOywXFBPU=;
	b=heJdsLFwYKmy09BfPSsRjN6ONIoBUsRS+sL1WBkUaLVUEhQ7fFDY1kMjW8rTb8orUYkn
	 0nboHmvwodivr2YtcVwE50pl693iPRDPD0yl6dtApWhEO3rMnrvnUfi17DQQq7lzHpaQP
	 KbsNW0jyNs/BhIf8U+kqApWPqor8Dwgq6Dc1rpRTT2fsn6XuUesmHyG5MdnJJNtJ2PNWQ
	 QeiqpqoxsQbCxG9tKX+G8NTxjOO1lze8xH+rluDHdkNkFtrJAvGLjqFJl21HiEOGESrbQ
	 ICJqHuOSMKxSKSoWdgwl/GpGwq4RJ5Go6VnBzouwWg0nFN/SQngfDLozkAFNDR0wXYA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="kgXYRv/L";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789479753;
	bh=iDuScJmjUzrQwz3v/NizI2n7FScHCtcu3QeOywXFBPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kzGYBDrrQWBEiVSH7L66ECBSuHf40EnwUIw2e/27FBNh+mQareP2Rqz1d13xzGwfB
	 +ao19L/PImhufOZMh2OfDu/qj+Vbur7LmLzCadOKxTDbzKBjXQpH1zSRkrkeJBpy+f
	 QXWSQWQFnxJ4ukk6TWH/T0HyKYRfn6Hn6vbSPQBlPDxMKZPv3gmL3Q07Vu1eBfYGHJ
	 0i7qBKkmP+7JiRokNstK++i2hl5Aj2JixHLSUtcO1NERQbIq6fQqJF3hciI+wUIwsa
	 d0NuUg6fuxWgccWUxXMcvK4ko041jo5ajXPs5NJsYy10oBkWzFzJK7WBDRb6GPxbc/
	 z5kweFp2y2TDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92BC580C6F;
	Tue, 15 Sep 2026 13:42:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAC41224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC2B080C6F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIpfhGrWLKax for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 13:42:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F2F9480C68
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789479752;
 b=h6jPnH2IaYIC7ODnAxCV30Y1e+1XTpLEKrWJPiG+ugr3lxTQFauuZrs9rms94VRz0gOC
 O4jUn7OyP4pkToTsOCZbjqWLo/E4njyeWyLRidJ9LCHg0iBbKcoRPRY+fr+FSitqKPjt6
 +s3zIr1nO1pE1FgkzM40iXbV325UV8or767KazxLCekY0z4sQnWe5YYvE+JvZrRZ4tCPK
 BxZM2T7fpq4CoRBguUeyBbCBnk49/LMagX+Kjj3uT8LM1T1ZN8K9OmCr/BPbyVRuc/DTs
 zMpMmaTRr2znWBUeuXu5dhvsGMy09mMVZQyIXC/rS/bV4x4JqBnxY5e+L6C0kR4JKbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789479752;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=iDuScJmjUzrQwz3v/NizI2n7FScHCtcu3QeOywXFBPU=;
 b=Evb2840iQwYseObRB8IyfWP69dEIPf2DioG2Xf4Sq/qDAEgI2cmThnwchf3Eh44wbTAt
 ix1eOQ1FvIgcAn1Zc04M3ZT9WQ4ZB4WETOk0EER8oQMwJfH7Pzgn6IB7DES3oOM5SSWiP
 pgx5MHaF4i5lLkI3tlXioIFljbPm3s29tAKoE/v7E8BXkSC3oMUqSN2EKeYp6FMBFBqVc
 MRxkX4S3nYKNgrN3xVzxNSHGW8VveoatIJbkvoJhwGCtFR/8HUCPVhxRsw4gQG6nNRcAO
 4mBX6Dip6Q2B2GKzXV1djVH+ipcLZ5hZ+WmXEMSVyscWwiUYB46dP1RzAG/QRznExKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="kgXYRv/L"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=kgXYRv/L
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2F9480C68
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIYuc0G/TDK1Bru8WKoKtEmBxuQjpH+8ogYN76KzBesz89eZ++/W/58N40/jybylXGBDxyB0J6S1JAojszWtidzH0l9DysTVekR5Fq+gZs/O9JIan4fpZIKuqSPA6wdCJvaS/G2zgdHMCucwUyvnPsxDezXsSYNyTX7fQX+jiHDyISF1DtMs0wXUENZVS5bEfUrvdCvk8jNTjNvu6Edzg3MlR/SBZQIv3rxTIKD14w4QRkDEX32yEI6eGBc+iAdWwQUMfeTu5NA14/e1+r4hT/2Rkx85or6oyG+jQRKx+FIfc2y9uUtuWjrqat5/BzHANJ5bVlVF2hF9EJpUR+xn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDuScJmjUzrQwz3v/NizI2n7FScHCtcu3QeOywXFBPU=;
 b=snv6Bfa1Z6movLjxI61wG6nISu/eJilscnhviCt7bca6YAVzeMGemhtACllQ/nvC0evMXQ+8znRqbPF7YwRK9LjsM1pw9E2fNxr3sZNdAjCYcBV9giFDPeKgXY7CDVlUyQKbmmd94PSD9OHY4gcoziMVHu5UKECQ/pHMv1DddXZVIT8T5yAFH2nANGyh8HvyuIxFl/kB2kDrk24TicTvGKdFDpIe31HYRUJ9aLKoP0JozDjSNYe0nAljBd7rycrxx1d4YF+Hyamz0R2arixr8CMPG4qqV4bFupZHZJKlBsyQ40tS0NFtS7ALcb8SH4TfUqWFTk8iVTpK4URaurtbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDuScJmjUzrQwz3v/NizI2n7FScHCtcu3QeOywXFBPU=;
 b=kgXYRv/LMMeHrHXMxIMMGgeXqi0kbHf+HyW5gEGmU9ZSrMckS1RI4r8l7BkJqsuZotr9dWFeDkzBkpr4AFyzSEsErQY1/NByPTAyKOUlBUEfgqWPtcqXvDc/GqIXxV91km6e2TAJCCdxOj6wkHEJAbF0rFSvEqS9vZ9LgxXKhLlMqo5kdB5FDhXKMyD3cfaZ2Epm13XGlNQ5bKXYuXQBGd29GCBZWwTnEes+jnenCInRAtKkSfXOIGDiQO7OheOpHsdSPC1IlermUo79R7I0sUXOHs+P6lXOYi/918ZF/r7EjG7K6kpao8HlCp/Y7aNFDdJfXd373frvVmBYUSd50Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DB3PR10MB6858.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 13:42:23 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:42:23 +0000
Message-ID: <e0f71d5c-3c2b-4ce0-b5eb-9f3707d6c2d0@siemens.com>
Date: Tue, 15 Sep 2026 15:42:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] image-fit-sig: Optionally require signatures
To: Leonard Anderweit <l.anderweit@phytec.de>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "anshuld@ti.com"
 <anshuld@ti.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
 <20260915145217.v9.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
 <5b8121f3987581350bce23e171d8b32a1cc586bb.camel@phytec.de>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <5b8121f3987581350bce23e171d8b32a1cc586bb.camel@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DB3PR10MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1cb07c-4710-4bd9-61e4-08df132f2c24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|4143699003|11063799006|56012099006|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1O6NFjNy5t7grW1dPzfa6uTKVzlkt4a776OrUtpJwWrxQJq6aKKWG8cBd6u2fgj0vs0O1yKiLocfqxrlssPGruDkArVKNhG4hy18Pcqwb3kmeVDGnEZ7a6pq5uD1gNe+AH/pa+A9o8JwgzLRYMaO9as7fn4IOpZuhjUctD7pKBof2N2Scp0wI1lF4OXhXoGfp7ZZuKvVkZrtqe8yR70uoDNA4ha6US/JehSJJVZ93MXkeF0MKIlHfNEAs0HktzIZmxYjZTh+s6P29GfHvR2pkeYpzOD72CXblyGH4AUZvm9DxU7MqTV+xrEQRMSjWzERGzrSAEYyhudXCpfMydyXGYLBcM5BvPQYm49Eaax5zpG5OO4s78XAk5T3c5Mpq3wz6xy8pm/WXF2hj51gJIF6/OMrmED35xaLO1nUrHEjmXM/j/oBfy/HqEEFaRLkAX2McaL1wv2JU4Yizz7QoCXJx1cVtqzX82lSGxPq86yVFQh6Qe8jy44/jgRXxAOew7JM5xjlUjH4prVwn/4EMMx5BxZCClQuRV+HD/BaBnWxsyzwKuUBVjx8wbmRoV3VAhnzFBLKo6HfcVo/Okk3+G737bVDjGwoB9jpu4pqyLJJBs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlLcTQ4STJHMzdVV2szRy9RaGdUTWJRNTMwZ2twMnI0V1pQOWNCTmk1cWNx?=
 =?utf-8?B?QkNnREs3WEc4bjlCZmxVc2xEaWIrWFo4d3hFNldqZk9Uek5nSjhaVVBTK1hu?=
 =?utf-8?B?WU15TU5WY08vbTYxalE5YXpUOFJKblFmUjg2VzdMM1NpZUE3SHlTckp1OWN0?=
 =?utf-8?B?SVp1dWFMUTBBRG1ObExjMExIVnJ4eGtlTU8zd2xOTnVCOE1PYzJkL0ovS2s0?=
 =?utf-8?B?dTBjSnlIVnZLOGw0Z1QyUEJkMlVLbkl6aGlaNVVoUWlMRFhXRm50RjlrK0dn?=
 =?utf-8?B?WjYrRm80VG1VM1JobXhLVTZ1b2ZKTHk3SnJLTzR2a04rcCswci9zQTA5Q3ZE?=
 =?utf-8?B?MEIzeElFTWZoYmxnekZPVStHR1hBMzFmbjRCUkh6cE9ZMW5keDVqb1BObjRW?=
 =?utf-8?B?RG83aEJKR3dRb2JIdlk0dE0rbGpnOHN4MFRsODdCYVQ0QzN4NTBRQjFpdzYx?=
 =?utf-8?B?VkpJVXNPSi9FZnBEbFFKcWJJaDF4MCsrMnVTL3AyQmp2SU5mYU5hOCtIN3RX?=
 =?utf-8?B?VHprSnp6OHZ5UWM2bm5uV09jV2llRlhlMkIxT0wxOUUyYjlvSG9qd0lOYUwr?=
 =?utf-8?B?bzA1clBLUHNkQ2FxVk1IS2JacFFWL0loYW9kWDIwYzFTdTdpQStMamJoRlNr?=
 =?utf-8?B?UVhYWEFmVGZMY2VkYVJCOE9PM09GeEZhbXRLOHB3QnpYVVA4UUNPeU1GL3pC?=
 =?utf-8?B?MzE2NnRZQUdTQWhjaldNYXZIUU81VGhoTzFVUjg0ME5MM0lxQlhUdlVYa3Yv?=
 =?utf-8?B?MkR2bVlwcVJFamFTV0d3MUQ0eFI1SGFCWW0rQTRrUXBPWWFzZHYxMnRsbExh?=
 =?utf-8?B?ZHBqZVo3YTg0enVsUVk2Wm95ZHp6eGRkNVR1dURkZy9CdlVEejhKZ2dkMkw2?=
 =?utf-8?B?WHZrbW9TTFZRLzNWN3hxbC92c1VWbExRM3B6RVp2YzJ2NDhDdXk4UmdTOGY3?=
 =?utf-8?B?RnhXRFkyQzM0eHdzUUJWbC85WCtTY08ySWVGVDJFNU13emVScEdVQzB2ZS9Q?=
 =?utf-8?B?UnZVbkNXc2JNSzZzV21jd2lkZS83c0ZWQXM1Z0NyRFZCRFlsL2J1Y2tSVzRM?=
 =?utf-8?B?WkVuWFZ3cGZ3aG9oRU14WEY3RS9WWDJUd0d5Q1Q4eWZqT3oyZEQyamZPTm50?=
 =?utf-8?B?MHdjNGk1dzIzNlJXL2s3V3lFNnFtdVNTa1g5VUdxZFdCUDVZcHF3UStZbW5h?=
 =?utf-8?B?eW45UlBtQTVaNUhMa3BtT1BjeTdicmZ1QmNPRlM5VWJLUUsxZUZPRjJBVnBB?=
 =?utf-8?B?RUpyY0Zyak5ocnplZ1RDazMyODREQVAwenRWMzB1V1E3MXdCNnVyejE2MGwx?=
 =?utf-8?B?b0hEZ0NrUE8ySDRtSjltSzF0U2FFWmVGUzhYdEU1Rmw2QmZBT21KbGhGcSti?=
 =?utf-8?B?UEtyOGVHVWFhREs1WlZwNVpqdk1vaVhzYXFJWTFYRTRjTUFIZThCTE5PL3JO?=
 =?utf-8?B?MGNydkxJR0ZJRmR3N1NRRWFlSkM0dkU3NkN5NUNmUnQvUm82L3NCZ0poS1Y0?=
 =?utf-8?B?bytoRHJOd3ZsejUzVjEydHJiM1MyVHVIZ1RITlVnbzFWK3lDS2xmQjh5RW1x?=
 =?utf-8?B?d3hrQVJmM0xueENkUWw3cUtTSHU1NllzRkYvN010L2R1aGxMbkJaMVh6QmNM?=
 =?utf-8?B?N20vbWVFanBBL0lYNVNNVjF3djNPZkdOY2xybFVzcWVhRnJSM2Y2NXdBcVox?=
 =?utf-8?B?ampHdG5tMktoWjJ3RWFaNlVtZFVUdFA3RlRER1NoZEduMXhHZnVtYVpNNWVE?=
 =?utf-8?B?RlNHaUpDWHRFTFFYbWVUUnRLWmFKSXdYRms1emM4NEt4QWY3dWU1K216WGtm?=
 =?utf-8?B?MmlRMC84d1hQT3RqV0F1YzMxYzdZOFFzblFnY2tsbm5ac3lLQVU5bmNZaW9G?=
 =?utf-8?B?ckRTOW9XOHNPZ2kwYlhMM0hlbldEVVJnUzcwdXRnNzZNMyt6QloxR1ZXQzlP?=
 =?utf-8?B?TnlwRFhsR1BKOHNCRFFsRUFBd1dwejk4NUN3emtvWk5SVFhpSWVFTnFiU2tu?=
 =?utf-8?B?WlNXVG1PVU1ZTndyUnk0dVh5QVZkRy9lQnpOb0kyL0VGdGNlS09ZaUEwVXBY?=
 =?utf-8?B?aXBwWW9jNFhkMGxNUnRFT2xyZmdmdER2OHgyNkhBT21ZOUJuaEhwb2xjQ3h1?=
 =?utf-8?B?OVRrc2F2K1liSGxXVWY1S0Mrd0ZuU0gyNmoxU1NVNzNhQWlnYjlJU1lVVjF4?=
 =?utf-8?B?QXpmVDBVdlpuM0lMeXhSWVRkdDlJU2tIVHl4cVM1STdodktTbDUvVlR1V2Ux?=
 =?utf-8?B?V2kva0tKbSttRnBKSk0yV0dGcTNOOUZLcnJxajBRY3ZGT0plKzBKVUMvc0V0?=
 =?utf-8?B?MC9FNEVqM1pkTVUzKzAyMm94ZHpQZWJaQzlRYXBkVklMKzQ2RlprQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1cb07c-4710-4bd9-61e4-08df132f2c24
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:42:23.6090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLL2rHUUZW3ZGhWnk0BpoqrxMtUPv7byQqri27XKyizs8jbPXGQnvG26SnvS/Supb5K6qxTELtJJ4VT7HtxJnRFUwswYleM7+tXXNSiO5jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6858
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

On 9/15/26 15:03, Leonard Anderweit wrote:

> Am Dienstag, dem 15.09.2026 um 14:52 +0200 schrieb Ludwig Nussel:
>> If U-Boot is built with signature verification but no keys are
>> included in the device tree, the boot would still continue.
>> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
> you are still using the old name of the new option here.

Good catch! I'll prepare for v10 :-)

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
