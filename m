Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D0ECCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 19:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24C6960656;
	Sun, 18 Oct 2026 19:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YL_MzvYz98Iw; Sun, 18 Oct 2026 19:52:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3579260613
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792353172;
	b=FYwNZpwndfy93WDw655U4MJezKIRnhLWv9kIylcyWaDIViRr+Po5UFA0Z33jB65Uhf7G
	 OK0mLRaBTWtox07iIFdXdxftTOeITUdvlp2yrqibEeL+WvajWPVWUC4Im2WDa+EjLFCbk
	 crB1Lwu/hxsrdqal6c4LlIbEfmihMA4oeeQ+5hwZqBBTFG3byZCKwNx6TMi3dpzW9l6Yz
	 grlITjSwLYWZ3+lTYUTPGanIcB482bEkFAaN6NtfkBQBiZjbuFtMPJaWv7H8mbPM+IZaP
	 RBYk1eHVRMFChjnoCuVQSWFYGR3PHlhGDHWQYILg5GTsgmrE3Y8iXggAD1e4mU141NQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792353172;
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
	bh=H6up+RWYZth1VbTet/Q1nLY8sl6WbkO4PJaKaBLZ4Bs=;
	b=oOeJThG/0xGCQB30dZ5CU/m0hcUG1fv5fBJKimQsGntPtdB0cddG/2AHTIMDeSu40YBl
	 2tQhoZpE2s0aoj64lcaHuVEBpvhCkNQYq1xcV9mD3tOA5ISQbLwGWS4IJdMvoSnUHiuJb
	 1gVhlDprGGJvuVkcxm2SucdFjfQlOp3m7RgGOKdDk1nGUq8PKOSh1OkUdR1LO5QmjGbip
	 JgzblomQDhH97PkX2j4GzPJhXs+yLPBr1vUS6Fye4cs7zqaBh/8lyAixYNiN8QuhFyGNQ
	 a8zikaQADPvhiRsb5kHPGhLFsGCrUgC6twgHJeey6W7PWXLRtT0K5qOV0G3RqHIhtQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792353172;
	bh=H6up+RWYZth1VbTet/Q1nLY8sl6WbkO4PJaKaBLZ4Bs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gPmnlCsVd9znnsRwH7ZacQM/WZB6qlGDvRnq+Gz3MvTeKpomjGbB481qjVUsjqeu1
	 H1o8mJTvC5SGeiPME4/JxDvKZ6zQQHi/epwzwpZTFSZD+U8SGAUzLMkO05lLfNiH3l
	 xkZNe7wdW4eqcpxbXNKRcsRspTkmb2JDe0uaVFWvHEiOrk5cfZyAuv3jLVJNkV+50O
	 zvKJGI2+mwBVPo2/wF/8Ggd4RMkoZNb8aynZL9kSXSPbWHaOxycdKvTocjwIQkcW9k
	 X0Qc6HvvGfj8TwCYKc0xjFON9Pegh66uRfeVRUDRW7ddygUYyqfzhn0JutFTu1RaHo
	 4eIlDYjTY2xVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3579260613;
	Sun, 18 Oct 2026 19:52:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2DA12A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8929C406D4
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v3qS30_UsECR for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 19:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B419540680
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792353169;
 b=DZwzKvcLhZckxx/voE/298lX3uC1fon3qGNzxTCpGwjGLw8GlmFjOFAeol4BLqePR+L1
 W4fCOwcGDLBL2ue4PzI8eCt9pg2IZ6MD740DwZwxqWu0sgMVoeEsScu+uezBduco63FuF
 NL1xKrbaMWjgRxaSDAL8TO9HmQeA2bLY/7PlTXtvkxnRKN2gi8HMrGTeama47Pk0IsZ50
 Kp5AIJ5UKYtbxAGH0Io/viDnBq2gEG7XMImqRvciyVStpahBcy0UVdcTzbL9pdv1V42NI
 EDsbotCtNVPLdWb1BbPzRGC0TSW9a/ZeTXcFr9OU1P0uZCObZoMcbCIfbT0Kr2BHBYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792353169;
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
 bh=H6up+RWYZth1VbTet/Q1nLY8sl6WbkO4PJaKaBLZ4Bs=;
 b=mSgOEf2Us8akR3+7ByiGiVX9TZeH852W1TQ+FAkkAEVv155JfpgCQksqeYl6mN/L/gpA
 y74PvlkZUK5Z1Pjaxh//4fAN3VVta4syqAW1KwZGt8g2eBY65MCPmRyFJnMxI9sYLCq9P
 4/j23mi1ojUmBYu6YbxPP9Q5TLrufr8Z1p6pW/6q1PV3n85QmTvfzZLtlAqL3jHYjo0fA
 uWkM8ASnqEsd8eSuM/OK5ebIwvx30DVdYRQhQxxwmMYR4ZBww5/TI0NwSrSw9Yj1x6BL3
 2rB95znNUMRyBn0aeXrVU+CuGPZD4kmGFPruJ4KDqD/YdKknHBJ3jnHAIEGYNPeuFLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="emUKr/du"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=emUKr/du
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B419540680
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNbjxafG/mrx/Cy0vu0Tapu0VyUG0pivnLivPIZFrp89q4/vuXNyWOOKHrKzhc9ouyexlrhcnDgcajc9sCwRDUL2UwzWVfl03LjJ8h8H5Cqe58FPot9zGoOR4wWZ2lhW2YUJBu/XO/7p99S8vZocKk3hF1vaptHWmYH78AFo1fiCKzMs8/zqcy4fcVV0hFpQ/rASPDGhvTkBmsr5/vNj82notP6/p+IfmZnZdMfeY+JViJRs58T1nF2sJhzsvZFqk5pVjLq4LNpmvH/dtDtZi8wqJ7DpiNwKerTLwfs7tASWVGaG8mjkeTubWad9I/JsyGOM69xWoBOtYKvFpYK8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6up+RWYZth1VbTet/Q1nLY8sl6WbkO4PJaKaBLZ4Bs=;
 b=QK0vAUXAeRUOlULkrfZx2dTuix7KcpY4pqvM4mJTunoPV58qPDkzoqtqwOVLj3bpwnGR7fTyYpdjCxcyAoeqH4EoheNPuQ4iz6Fo4XfjlDHws9WKYMIj+yDnFDlPi5CBvXFqbo9PlXHJKexrb9M6eSq5Chvs72NnLLgdfq56FvD9F5Nrp0bES4ifhkyhEuyTIA9hFDRknvFxgZEGsx/g8ybloyP3/oEoktoaDR7S08ggESuBncaWt5FhtDILhfiLPP5UNlhCgIr4TFOP9btcHvsdYAA8Xo6/UWMEgmajiGiNlNUKtbGZsphWO4ZpWkHiOA6we+hZerRrb+FW0SeCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6up+RWYZth1VbTet/Q1nLY8sl6WbkO4PJaKaBLZ4Bs=;
 b=emUKr/dui+Uukx8MLdVG+Dew3QfneLPf6kfHRrigkzZ7yjG83vZEkIND6o4NZWmjFIRZ0/Fr/k09KyjD6l6ixspbwYffRpMJNnlkarpx6NGr9FKiW10lrnu2rcuq6/6IwfUCtbeEFapEfsIljFe3ZcP5VEd4omAO2X9+IXUSo6NdBuIwocnWnWeBGOiYAv0MPQy/DY51tlAhDS/7AMf2j5UbeKVBmE3WqVFWuFaFmHIpN0ZmwCJ32anRrhR6EdY2NFBL5ANCStQ0OP0J4zgqFckzMnRbG4vtkRJdNb450ayxS9lSZlKMqec35cgeVpOkP/QD7P1OciPutYohNC+9Tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM6PR03MB4953.namprd03.prod.outlook.com (2603:10b6:5:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 19:52:44 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 19:52:43 +0000
Message-ID: <b1c80ed0-7c02-4c83-ac31-4861dab64e9a@altera.com>
Date: Mon, 19 Oct 2026 01:22:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
To: "NG, TZE YEE" <tze.yee.ng@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
 <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
 <c97dd7b2-4375-4352-86ab-8870a1dfea4d@altera.com>
 <081f83da-8d7c-4cdf-8c6c-151e0372a5a1@altera.com>
 <5a6c71d7-e7a2-488e-920d-0f1bce3a8d6c@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <5a6c71d7-e7a2-488e-920d-0f1bce3a8d6c@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0348.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM6PR03MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b24916f-53bf-4bce-2280-08df2d515cee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: yt9HbdHRMVBYsZwdQ4NJQ55Ed0D2+NS1zj2NPJ4hz7GqGTOsnSayEb50uw/FppX6IfcnTLBlOANBO17SqOsGoHkVZQP/yLbXYm+YWDl7xu9vpzeIZknneIce5uBJ/7VAoZYOj75ND4harfkThnuUXe4r92crth56ycBxTH56LMiJbPhpBfJTsMRi6kzzRbjbZCrEj/WLU3V2N0/t3emjh4raRkUN8ddWaydG6cxjIv+eicuDVP/cx6UEtsNU7XJQITazFX3AOBSG3QFwSV3axHgJ8x0DeLNihCPU6Zk+O1H9QaWgZNPRXKosuL4pT02ZtoyHjuwanTJTIXv5bjFlNIsD/jWri172fYbTBmJGROkPQAJQrm/gkLMAVN/rHesB7GzuI4tEIE840VUczIn7cNvC6rfkYDvfzXZf0ZJI7U0Tyq6K0vu+lqLyJ12y3xXJ57IRbPaBDlVtbHUHwpjtXRlimtvO0mwwq9YBePsNhABx0BRIl9NXeYhJ3ekI/HowMqzGpwgz04N/2Y22G4USK5AIU2n7uEj+E1y7ixKktfbLqC6UZdX7U9ll94s9lmALvF80JSymp0IBBPODp0PkZ8ZuCGiKakSBWBj6aY1ansITbs82y5KoDRrQyrAWriz7zzMfdEaHpvzVMpOBRvhEK4KQlL6r3JGmpm7GS2zvFvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVqNWswSmFIYTc1VVBvKzlOMmJIdm5tRTVZbjQ4K1VHcElIMlBZY0gyQnlN?=
 =?utf-8?B?RUlxVEZhMFpndnFmK1F6M0xvMnVLL0hZaGF6UlpVVm4rZi9oWnQzWDgrOTJZ?=
 =?utf-8?B?bnk2YWNXTndYWG9JOWduODhIZHUraW1XRGZhNnBaQS9lbWZsK25NOW9FaENS?=
 =?utf-8?B?blpFWENIZTM3SmFaclZYcGoyQm1MaHhvZUR5cmo4TktnUUllenVWZDNHS3Nh?=
 =?utf-8?B?M21DZFdHc0VCVzJIK21SbGRKV3hWQndxMkJtVFpqU1VUNjFtUXJqVS9Qb0FC?=
 =?utf-8?B?VVR1c1B3VlhnOWtETTA2RWZ4cDdzZzY0VDVvZlYrR3dMbVVxV0RNVFBlVVNY?=
 =?utf-8?B?M005ZVhWR29aTFhxOWQyM29uTk4yS0hpZkVlSWh2dDBOeE1zbzRtVXBoOW45?=
 =?utf-8?B?MVlCZ0tBWFZYUVFZb2Q5THdkYjQ1YmcxUVhKWlVOSHpqajJIdzU1dUJlYlZl?=
 =?utf-8?B?ZHFVd2V3OHlVUTBQK2lrQ29LMjZ0cmhRODJOTEJHTEprbytPbFk2cWpCaFRY?=
 =?utf-8?B?Qzd1TFpwNm5TLzB6ZDluYmNEdHNiYjRielNWZnU5cGl6NW8wMUZoTFplQUhG?=
 =?utf-8?B?ZW9HTWZWTEdTR2c1bm9IUXlxbU9kWWV6bklQZVJLN0IraGRRMVZVUnM4cjVL?=
 =?utf-8?B?SFNwYzFVanAwQW9UYWx5Mm42ZEROOXVSdVhnYmJFNm9tL2xQY3ZGdEtPQmpu?=
 =?utf-8?B?Z3M1VHZZcm9VajFmQ0xFbURaamxjOGpSVFpoT0ViMFFjUEtaNXphVDBKVFFO?=
 =?utf-8?B?MkZTS0NqRTdCMi9SSmpRMWh0a1l3ZFc1cVdmV01ISExNb0F4SVh5b2JqalJD?=
 =?utf-8?B?aklYVkVUbm9ZR1FUNmRGbDVpcWRVVVVnRytIMHQ3bm80QVJBMTY0MkFkUktU?=
 =?utf-8?B?OXlyYlN1RkdWcUdoTHRwVGFvaWRORDQwRWlpclhuejVGSWs2anpOaW9BU3RM?=
 =?utf-8?B?Q0RKTkNCUlowTFZCZ25LYWdxaTdLb0dqM0dlaXVWMDllZ2dselRJTzdYN2VC?=
 =?utf-8?B?ZTJ4bDNManNvbWdUK2FCVXdTdUdsOUtWQ1YzQ2FwWTU5ZktsMXdtR0VYNXNL?=
 =?utf-8?B?QjA2dmNVeFM0bmpNdTB3TktTOStkUGMwUDhTSG1GTmFpaExCSnRrd3NkUFpW?=
 =?utf-8?B?czJoeklmZVA4eGExZFJjNUFkQ01LUFFaZmJXdVloMHNmaHFEaGd3NGRCTXNv?=
 =?utf-8?B?YmVUTS9QaHMvMjFNUHdsNG80UEJNbjh3SmNNeDZmbFFpalNUa3d2YUt3cDRm?=
 =?utf-8?B?WkY4Nkh5eHFTN2hIZGVxUFZtcDVaSlNxWFpyMm9RazU5Ly9FeTNYUGZNN2hs?=
 =?utf-8?B?N0dBdW5COFI1YW8wVjh0Nm11ZHQ1VHNMTEh2bzJWbzQzdFEweTdpTEN0a3VG?=
 =?utf-8?B?empOSWE5OXIxanlDK1FzK1JhN2ZtUXZGWCtHVUNwNmhJV1g0eUFONWlCOU5M?=
 =?utf-8?B?VSszeXVQcXVzdW01MWFEeDFFeWlmOFlvOXVGTEtteVlxQ2J1SzB5a01HcS96?=
 =?utf-8?B?VXMrRG9lWHBOcXlZa3dnMDF5NURUaEJXcjRNWU9NUDY3RG1jWENSYmw1QkZo?=
 =?utf-8?B?ekpEWW1zZFZnRDNFNjJqWExFc3ZRN3MvUmJqZzRIMzRSMDNQaTZiRXdacncv?=
 =?utf-8?B?UFZrWDZ3aW1WRlgreDVPTEU5WEthR1NBeFd6dlNhcElGcUhaZmpnemhXSUg5?=
 =?utf-8?B?WUhzZ1dxRmZMLzRhUGk1Q3NGeTB2RG1iYVpLSEpDeFJ0MGs5T09oZk1uclpu?=
 =?utf-8?B?ek1OMG95V3NwZE0rbWJoZStTRnFpdkFtNko5TW53NktTZ1h4QkZjY2hqWDZz?=
 =?utf-8?B?VCtCeWlpblZ3RVVlckEwUVFPallLNGs1RW9mWnVYenpTZXFvR3A0NnIwT1Jh?=
 =?utf-8?B?OXc2K2M1VjhmL2k5MVF4a29nMFYvVElZbmNtRHVFZEdXZWpJNmtUSnZ4dWFD?=
 =?utf-8?B?ZGpTRGk1ZUhrcVFwVC9zWDFQUEdIY2xaWnhYL25ESkNFMTA0Nk5oamRxU1lW?=
 =?utf-8?B?NE5SbWFDQmRVaHhmNFR3ZTl3VVJBVC9LejRSRnRNUjh6ZHEvWmVDVWY4VU1K?=
 =?utf-8?B?SXNFS0lNQ0xvTCthbHRIWmd4MUJpckJCVGxaUzhHY3dqUG5xME05Vm9EeFo5?=
 =?utf-8?B?MDQ1YnpzUUEwRVZCQUhrbmtPVGxTY2tMTnRHWmFzelJLT3U1Q0luK2hHRXVF?=
 =?utf-8?B?Qk1wd1FNT2ltVDhMK2c5TjBaeVJQUUxCYzZvNHV1dVpMbjRFWmNKdGx3aUdk?=
 =?utf-8?B?bGlUejR4bXpQTHMvcnpPWEo5dmlxTGFScjlMZ0REdFhrNXpHQzdzSEZrbDVR?=
 =?utf-8?B?TTBtZDB6dTQ0aGkzVm9MTXY4OE1IK1FsS1h4MUtLSE1sSjNST3lTa3ZoSXJS?=
 =?utf-8?Q?rplwt/tlyl7RAqOU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b24916f-53bf-4bce-2280-08df2d515cee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 19:52:43.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGwBwctSKMFAbnm+MYxRUb73bYVuAYYz+2gNJ4ERnRk714cZq5UNOndsklfYRsRaqywOdd/kutSdKDG4Wu+B9WICwGbEFrWV9LWcjGgn+GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4953
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

Hi Tze,

Thanks for your patience. It took me a while to go through the Cadence
PHY and host-controller documentation to brush up the register
semantics before replying.

On 05-10-2026 13:36, NG, TZE YEE wrote:
>
>
> On 4/10/2026 2:53 am, Kathpalia, Tanmay wrote:
>>
>> On 21-09-2026 09:20, NG, TZE YEE wrote:
>>>
>>>
>>> On 13/9/2026 5:06 am, Kathpalia, Tanmay wrote:
>>>> Hi Tze,
>>>>
>>>> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>>>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>>>
>>>>> The PHY control register (0x2080) holds phony_dqs_timing (bits 
>>>>> [9:4]),
>>>>> which shifts the read-capture strobe relative to the data slices.
>>>>>
>>>>> Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
>>>>> entry (default 0x41F0) and program register 0x2080 during PHY
>>>>> adjustment. This lets each speed mode - and each board via device 
>>>>> tree -
>>>>> select an appropriate value.
>>>>>
>>>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>>>> ---
>>>>
>>>> The PHY_CTRL default needs to be corrected. All six tables also use 
>>>> the
>>>> same 0x41F0, so this is not actually per-mode.
>>>>
>>>> Please fix the defaults.
>>>>
>>>> Regards,
>>>> Tanmay
>>>
>>> Hi Tanmay,
>>>
>>> 0x41F0 is the PHY_CTRL (0x2080) reset value from the PHY spec. The 
>>> driver never wrote this register before, so the PHY already ran at 
>>> 0x41F0 in every mode. Using it as the default in all six tables just 
>>> preserves that (the write is a no-op unless overridden), while 
>>> making the register tunable per mode/board via cdns,phy-ctrl-<mode> 
>>> in DT, e.g. on Agilex5:
>>>
>>>   013b:    cdns,phy-ctrl-emmc-ddr = <0x4010>; (phony_dqs_timing = 1)
>>>   modular: cdns,phy-ctrl-emmc-ddr = <0x4000>; (phony_dqs_timing = 0)
>>>
>>>
>>> So the defaults match only because the reset value is mode-independent;
>>> the real tuning lives in DT. You're right that six bare 0x41F0 
>>> literals are misleading. For v3 I'll add a named constant 
>>> (SDHCI_CDNS6_PHY_CTRL_REG_DEFAULT = 0x000041F0) for the default and 
>>> reword the commit to say the register is made programmable with the 
>>> reset value as default (no functional change), overridable per mode/ 
>>> board via DT.
>>>
>>> Does that work for you, or did you expect distinct per-mode defaults? I
>>> don't have validated per-mode values, that tuning is meant to live 
>>> in DT.
>>>
>>>
>>
>> I expect mode-specific, validated defaults, consistent with the other
>> PHY configuration values in each mode table.
>> Please determine the appropriate default for each speed mode rather
>> than using 0x41F0 universally. Board-specific DT values may still
>> override those defaults where required.
>
> Hi Tanmay,
>
> For v3, I'll drop the universal 0x41F0 and the per-mode cdns,phy-ctrl 
> table entirely. The PHY_CTRL reset value already works for the SD/eMMC
> SDR and HS modes, so there are no per-mode defaults to validate there,
> the driver simply leaves PHY_CTRL untouched in those modes.
>

I think the per-mode programming should remain, with corrected and
validated defaults. PHY_CTRL is not reset on each timing-mode
transition, so leaving it untouched can carry the previous mode’s
phony_dqs_timing into the next mode. Section 9.1 also requires
programming this field during every speed-mode update.

> Only the DDR read path is sensitive to phony_dqs_timing, so the driver
> programs it just for DDR50/DDR52 via a single mode-neutral property,
> cdns,ddr-phony-dqs-timing (shared by SD DDR50 and eMMC DDR52). It
> defaults to 0 (the neutral assertion timing) 

I do not see this supported by the PHY guide. It defines the value
from extended_read_mode: zero when disabled, and RE# pulse width in
PHY-clock cycles minus one when enabled. DDR50/DDR52 enable
extended read, so zero is not documented as a neutral default.
Please provide the documented RE# pulse width before selecting a
default.

> and a board whose DDR read
> path needs tuning sets it explicitly: SoCDK, eMMC and 013B use 1, while
> the modular SoM's longer SD path uses the default 0.

The guide does not define this field from PCB path length; board
delay is handled by the IO timing parameters.

