Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0937CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 08:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35DB780F16;
	Wed,  7 Oct 2026 08:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErTPttl0A4k2; Wed,  7 Oct 2026 08:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C8BB80F0D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791360283;
	b=aHatssy9Bpq5CCqRMcejrVEu1Eiun43cGbcV/1l/FmLgJjYPWMw+NhEpF2ScZC3UD8Wq
	 A3zbh2ZqGcER5Th+QDhFWQcFclpwYJsHtRf8rflCba+PofxbmM5KD3TXiy4CB2EpvO75G
	 0mRMk/+6m69KVeHdwXSrq9YCe6qnnsvOMROFew95M0sxw8o+bGW7nV70zrrPGZtcDqL+7
	 +aQOojLLQCrFBeQWKs2lTOW0dVzZTQGPyDppmfwNRKI98B3UlkUNpWSG20XHQTlAzb+LR
	 wnKbpA6bUPM1Zxy2P5YfzUmCqzs1NeZ8bFev7Jnp2eQevo2FlZiuNb7nGeNClx9J4Hg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791360283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=5CJQut+Pqe3Lal0doWFgxn3HaPiHV0JhM/rV/MostEo=;
	b=rJSGqRWDgYuPp/N2cf4hmPdqbJHJmExBW8v6oBXSlK11f5rqnTwPcnzCFTHUFzMnXtaF
	 CtOhGHqVh0WLqK7cYuFXperO4kh71r/0Vd+3uw6vrbnd0DlEUJZp0Bpf8lgr3SiRrduaE
	 zvWLmekyAdWl5oQ2utQNIHip7RQh/z/R0KHgIol02J5msyVuEYHZgm6BsoLxBkJSUFgWA
	 bQCdvuD9s66VKulZE0lt+MJEJ9A63d5nzb1FxNrrOe4zjvnIzfT2ilZpoE7gSZqGv5BgI
	 L3EPrc5zHW/0xhX95XRODgpcCsP2RHPxdsgtJUxANLvBYJNef7nsO0a+xhBcQnmX4aw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791360283;
	bh=5CJQut+Pqe3Lal0doWFgxn3HaPiHV0JhM/rV/MostEo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXfpW5dw4/4lww+dHnfIrFxxSFGN2vL3qT1tGlq2XjZruCDNnI5kuf1+CUp7eQ91c
	 FUJUxy+/c9bX/aDYAdxh1+BVXNoaHJpG67A6pROwh1UKEJMmbBlCyp/MDvEU85iEU9
	 +qCUo+yPjEga35LiNA82dyRb9MfdB3Pz27N3vtr7f5J4jqkvb0blV7QzF6cDWIpSpm
	 9OeDke4QHrXy+g8SwHkTzEHIB8s69NZR9EwdEeEpkh+vG8KmhGTKGOXYgp1L4yyXwe
	 10lK2a1mvc/eWwoflmFP0F2Wq/xA6zyvVnr2LncPXx10N9J/mxTIkKeSgSq6LRt6sm
	 f2YOmImY5EKBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C8BB80F0D;
	Wed,  7 Oct 2026 08:04:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4F31341
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9029340070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELw9RAzODvhz for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B5D5E40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791359659;
 b=PguWBiulU66UB4TQ/HpoQRpT9iVaiXHsEHhugYnVnJNVlyYfus18Qr5gb9k3m0JmYEE+
 CvEgju3YLz1UK4pynEp5v8DTJ2rzJSrnKy3/470FigJw8GoyB6uPEWdJBB5q+SjUt3jyz
 sl7fXKfWb5ywLI4Io9WQwZPfV8jo6eH+ilqIZ6kGFl9YckuEfaSkKzhhGHoZGvCwdwMbz
 jTbSqjr4bx31rUwI1rEq+0yuk/rfuj/9Q3sR0aRxvjOBh3pA2A9c22VnrOuBzJpH+iNDD
 A1+NaU+vICC/nnIcYL1T0HZhF5NiGKXp6ANtAsYJf5g1H3iWDrKVx42Q2lxYxflsXNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791359659;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
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
 bh=5CJQut+Pqe3Lal0doWFgxn3HaPiHV0JhM/rV/MostEo=;
 b=tfwEnoVBJIfBSwAUYWoqLgwR1sXYkwoo0waCH618ZW5e3haI/o78GIvtEgTfYeJQJfq/
 tecLECSDgBTWelK0XePS4/8nvrhZmYGyvAKmVtPWm7pE4depDk3N0lNSIFiorwdexfijj
 /JTZT5X4NuFCWtHWwngDVlfun/DuGLjHkXCe3BeGXLuucNCkKXZphys88jOAiRGMQVGje
 kfCJSext3dKLzOTTwwyR+Mt0xJxwJLbjwB93ibHGcQJMRYl99VRMgDl/7hCkvI1vFZWDf
 imZ691V54qYMTwP20RkAB9YY4PPVbhg+p4xf5WAz6ZkFD3rAfYMfB/Zmk9hcij42QaQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=tNMdzzAf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=tNMdzzAf
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5D5E40062
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9x9sFFOh0aj8fs6RYv+3HsnwKYS6s/wUHr9+JazMlolbYuP7mTv0/K6OG0juF5qRGguNhrUv8nDZ9/TR5x49wAmD4K++EIL5dOdIjZ7LLpnsEThiZICnFPeJ5IG2xoLk+sbMupVyPmiIwP2g5zoahFTz6g2dPkx0Xu7o0c9ixhAa44eK2CR6alaDbhXdzdpzEBSytMsTBqIC49/6i9vP9razL8u4Ap2jYThODFasrSRYd2XihNpIL89IsOWFowBwfR9DOvUUOYq58R8bZQdTfSw1KFSDuhbdiEbpKUslE+scb6KJr/F1tkW57Y5765n/0L1gbi/ta2W27WvOsj2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CJQut+Pqe3Lal0doWFgxn3HaPiHV0JhM/rV/MostEo=;
 b=EoSpJ3ZLTViP00ck08Mb409DwM9QrXpvYsnRMI+CctVzSLQ/DbNf99TWoqJjHwfdvBBPkrGPYfQYnIaX4cgelwjwaHmF8TY6+bm6Stxf1fjVnZeSMHZ5r3oZCVjlTz6mLPf8++FFYc0cJKh8cF5W6yJduFRj5wBlgqEiQljLmkdpvVsfN+UTrrI80UvbEg9/7vRp7ZuTaOnwQsqLMxRe8h22rjmr7qUpb/c+8r2I9BrThc9w+iBW7wJgHQL0QUMT3yKHkQGoe70U4P5ofwL9lwbZxmJlOK+AeaBDUCf8Cz0NycZFs+mLgO/dg3kv4HJ9hG3a701heInF57zdd8zEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CJQut+Pqe3Lal0doWFgxn3HaPiHV0JhM/rV/MostEo=;
 b=tNMdzzAf2BkMCqf6hryUkiTDmSNx1sBXyXbWMYsddTG2RQI8b4Y+QWONVX/1arEu6QP+Qq1mqbIdxqDnZilOsTh7qOHKfLST+8xyxi7T8kMuSkoEDKVb9mwyCWcFgQ5mYfbiTuSxM6/DdlqcLuxnd5FEdGpdJeAYqHi6P31tKSe1jtr4vmQ/1973kcfzrdpdXa8eYvoBGTZn45dsOomOCX9H7sE+0GRduqITMHNSXoMP4LGRNcLpEHNVw6/NyqmirEVYNa7Nydqmn0a0OJKIFPiej1IIk3ItGqIH2GLDLypF7UsG1iAxLtGp4LqvMSbH3I/lM0AxcESNSIViIIoTyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::18)
 by AS8PR10MB5808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:523::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:54:08 +0000
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536]) by AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:54:08 +0000
Message-ID: <8c5b4eee-daca-4f64-bf55-d740f3417b36@kontron.de>
Date: Wed, 7 Oct 2026 09:54:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mtd: spinand: sync with linux-7.3
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e4::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR10MB4273:EE_|AS8PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 7618a425-56ec-48c4-232d-08df24482a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|921020|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4aRIvnIwU8k2u8wA4D1jxMKTIcNYr04NKf8UYWfOzOtzc+MRo7Hd4HF0KrciEchBAkhkPnUssraFK16kqojI+mKx+6QY5nW7qNHFDQFd43Sd1/8VO+2LopCIfoOy/CjDQetjNf38ZgN2bZM4X/exfyi4HD6Ere6VddYQrxIxYkO1qPOwHb+akPp5VM0ZdNg8CqUI6Fccch7psZDfUTRfDKHOC9LOASMRi7IX1b2jEQ91l9jzYWjzzI26pfWCUsPn8BEKUhcF3YI2+QSW3MGv+hi5bpQik9JhrHlAyDcNw0ANjWC25ETEr1ZC589xgItZRWCN3Bw5X+kT7x2Fwj2DD5BFsSUlSkVt7swkdzrZZdLRL1eANGqMSvLeZZzTz51ZeTOakzajJPDfjEOvPg3AdK5sfSIw+6tNRQeEcB8z4Otki3Sd363lwZJVlKybKyU+c/+pP5zQlgm+mODeQCtoh3uF00bMSJL05eXWnCf18dYPllWZLkhSOx0iMP8vCx7eIB1UzcXEXVCW6vLuSpe72eNaX+6Wv7MvUKYtgls02n3GkCu8Bw+l6TMBn9dqgF4bKQDhVzjQZXU+fYAp8SwyJDcztC8nGmfgDvz01Z4cocsZ/kVBdjL64SBPmMB02fO0LRlDzXemFkGDA6oT4mBn6M2YeBF2vismGZD7m+aSrCg+Qz0YbWvt1nZiOcCORZ7gJmH+wiuXocQBW6LPA+zJTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRCU29BdXFWUU1vUmErdnU3YzkwSGYyZkJ1QkY0OG9OQ2tpU3A4TkE2TnBw?=
 =?utf-8?B?MHBOcmZhUWY2Z2VtYzJmY1V2cld2V2MzQ3dpRmJBM1dJN25IeGY4OFF1QytX?=
 =?utf-8?B?eE8rYVBQMWtwbzlhMGsvUVpPR0dPMHhrZkF1cmhCV1gwZ2s0cHJzVUZkUWdW?=
 =?utf-8?B?cmRUR0FZeE9Fc09RVmttZFBhU0hpOXY2L2M1Sm1FL2tIeHhSTGNhK3BJUmxX?=
 =?utf-8?B?SDRZYmpFaExuaUJISVhOajl4MmpjcDNUTk1RK210TG5zOUNxNVBnQ2RBNmpj?=
 =?utf-8?B?K3NRL0h4TnVKL1RYZnltdGxrVXVLeDJPNmFDRmFuTnRPbWRJb0VkV3ZVSlk0?=
 =?utf-8?B?VUhQdXhaQXk4Vkh0cWZmdnZnbTdjVmcyc3I0T1d6Mm9PVHphQjFobWNVeGdZ?=
 =?utf-8?B?T3hBbEpzQ0dFMDdXMkNGc0U0S0Z0YlQyZWliczNIbFdVdjFBS2RkSUNQRC9s?=
 =?utf-8?B?M2tJTGl0RzJNUDRJUVArMkI1ckFXN0sxM1R6TzM1QURrZnZFSk1ieURpQ0tG?=
 =?utf-8?B?aGdzSXFHYndEbFdoQUxKYStlOW1md2VycXYvZzF3Tkx1YjhJYmdlZVpHY2Fk?=
 =?utf-8?B?bmtwWUswbDgwN2I2THBsYmhLcXdDN2ZBN0V3RVZUUk50bHBFQlRqcjIzenF6?=
 =?utf-8?B?aE1iM0tmaFVDcldvS0xnTHJkYVFlU1hmWWNlVXdSTkt1UjVhRFdjQ2dicUJZ?=
 =?utf-8?B?dFZITkhxelQvb3EyY3hvajFaZmZCd05ZaUxjNFErSUNPYlNUaTA5T3ppTmxX?=
 =?utf-8?B?TStweUxucTBkUEI5ZWJKT0V0ckJCUWQ3WThjVHZjUVF6Qkd1VEtCcDc0L1Rh?=
 =?utf-8?B?bGJqUE0yV01TdFY4K0FOZjRPMkh3UDlueG5vR1d2bmY4TXBwTEMrOUtsTmtm?=
 =?utf-8?B?ZTE0Vi9sa0EzMmRwKzUvaUhPNDRKc0pZVXNDU0xYRzVjWk4xZi9adGt1STNJ?=
 =?utf-8?B?b0YxOGZMcEZ0aDdqN2VuaGN4SXNyemNMRUNqY3hLQmZPUnp2QmxqNExxQjdW?=
 =?utf-8?B?d0IzNjAwUTlSK0pid25VMWdLNjIwUm0zN0RPNmtJYkMxVWFPYmsvR3BHTkhi?=
 =?utf-8?B?bXpRUG8rVSs0WGp3VkYzREtHZXhoY0JFZ0dMOTFCZ2cxMHgwUmFjM0VFa0t4?=
 =?utf-8?B?QjRFeUFaNStscisyMHh3azZRd1Jjc3VnYmlQTmV4TVRZUjNoWEdpMVFSOXUy?=
 =?utf-8?B?Z3c3aEVNajRWQUZIblk3Mnh3Nk9pRVNGdW02ZEN5a1VkVjJBN3plY2NMUU9j?=
 =?utf-8?B?Y2dmaU9tQ3ZScWtqQWswMXhoZDdqQjI0a1dnMXJuY1pZM3ZleWw5Ykw5WEZG?=
 =?utf-8?B?NjRXOEc0UjgxNXVnaVgvd294MDF0aFFKcGNYQVJjTDQvK1RHYjJXQi9KVnEy?=
 =?utf-8?B?MFpIcFRycUYrSCtVYWw3emxxc0U1R3FDbk5PdkJmazdnVlhXZ3NvNTd3VDl5?=
 =?utf-8?B?TURIMjJXMk14TXo5K20rNmdVVkI4K2JKM2RmZkpGdWVtVDJpN3FmalJXeWlB?=
 =?utf-8?B?SVhuQ0hsd3ZyNEFaakJDTU90bStJVU5PYmZ1SkN2Z1Rrc1RMWnIySnVxNzAx?=
 =?utf-8?B?OE81d0xRYlNKazF6NkM5eldmSWNyanlaeVdtODlmNlhPY3NwaGFmV21ra2E4?=
 =?utf-8?B?OWU2cDFIaG5ka2IreHVjUEY2alJ6MnlZMEsxejdjZlhYN2RaNDVab3E4a0hN?=
 =?utf-8?B?Wm43NURQdGt6TTlyNFpqN1J4OUVhK0JpazVMakpsS2FON25kNGFGTzQxYUUy?=
 =?utf-8?B?b21NV1hxWC84cVhNbG5LRjRVMzFZck8xYTIzdTIzbFJDRkZTZzNuSE4xYUMz?=
 =?utf-8?B?Qk5ZcnBDQ0lNc3BGNWRCUkhYcDJzQUZpTE5ucmJnREltYkl4Mk8ybkJBU1Ur?=
 =?utf-8?B?cEQyejZFTkxlVHo0cFpORVgwY3k1d2hLbkM4NWNaR2lLaGR0K1FFMmVuc1Ur?=
 =?utf-8?B?bE0xRWp1YXVTMDQ1eUIvYzZHcmI2dDVDU2RtTGZXQ0R0Z3JYaU1ObXIzZWFD?=
 =?utf-8?B?YU9xenlmdXF3S2hhQzNRY0FNY1c5bmlmQ1lqL0R3UGlicHpwdXFIZmt4RlVs?=
 =?utf-8?B?UjFseGFSUkEzbFlyc2NNaVY5Y2g2RmQ5UlhJUGQvZEI2UmgwU1BhbHhrZFdQ?=
 =?utf-8?B?RjZaR2dNUEw3bi9iZ0lPSGYwSEE5dXpMZ21TWHBoZVZ6a2xPR3gwN1pTWXhC?=
 =?utf-8?B?Z1FjcG9kS1RaQ1IvTUlzeU1aS3pnMW4zcnUzYklMcDZRQnNwcDhLRHhzR1NB?=
 =?utf-8?B?OEVvYkpKZkJ4cXhuL1ViTXRIWDBvQnFOQXd3WVRvM1k3VHRIZk1Dd1pzUTdE?=
 =?utf-8?B?azVZUnpRdmM2WmhjMzVsemd2YjVKbEpzaC91UVZXY0NycGhwOXRzK28xQXJF?=
 =?utf-8?Q?I36O+mF+32s505LA=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7618a425-56ec-48c4-232d-08df24482a41
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:54:08.5961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o462a9yCfEwiY+BgzhilCRgqhRK+tfZ9v9bOqaB4JDsHt+PAkgyy+N0tbdE9BS5neVC75j7SzrW0PhUy2vk75ijwOcXK7KdSkf4omPNoy4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5808
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

Hi Mikhail,

On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
> This patch sync spinand & spi-mem code with linux-7.3. Here is a list of
> major changes:
>  * spi-mem: capabilities were added, so spi-mem or spinand drivers could check
>             spi-controller for support of specific features
>  * spinand: continuous mode improvements
>  * spinand: octal DTR support
>  * spinand: many flashes were supported

Thanks a lot for the sync. I have some comments and found some issues,
some of them with the help of an LLM reviewing the code. Please see the
comments for the individual patches.

Best regards
Frieder

> 
> Mikhail Kshevetskiy (3):
>   spi: spi-mem: add spi-mem caps support
>   spi: spi-mem: sync code and behavior with linux
>   mtd: nand: spi: sync spinand code with linux-7.3
> 
> Miquel Raynal (2):
>   spi: spi-mem: Transform the read operation template
>   spi: spi-mem: Create a secondary read operation
> 
>  drivers/mtd/nand/spi/Makefile     |   5 +-
>  drivers/mtd/nand/spi/core.c       | 504 +++++++++++++++++++++++++-----
>  drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
>  drivers/mtd/nand/spi/esmt.c       |  30 +-
>  drivers/mtd/nand/spi/fmsh.c       | 175 +++++++++++
>  drivers/mtd/nand/spi/foresee.c    |  34 ++
>  drivers/mtd/nand/spi/gigadevice.c | 117 ++++++-
>  drivers/mtd/nand/spi/heyangtek.c  | 132 ++++++++
>  drivers/mtd/nand/spi/macronix.c   |  87 +++++-
>  drivers/mtd/nand/spi/micron.c     |   8 +-
>  drivers/mtd/nand/spi/toshiba.c    |   3 +-
>  drivers/mtd/nand/spi/winbond.c    | 466 +++++++++++++++++++++------
>  drivers/mtd/spi/sf_probe.c        |  22 +-
>  drivers/mtd/spi/spi-nor-core.c    |  20 +-
>  drivers/spi/airoha_snfi_spi.c     |  10 +-
>  drivers/spi/atmel-quadspi.c       |   5 +
>  drivers/spi/cadence_qspi.c        |  10 +-
>  drivers/spi/nxp_xspi.c            |  12 +-
>  drivers/spi/spi-aspeed-smc.c      |   8 +-
>  drivers/spi/spi-mem.c             | 150 ++++++---
>  include/linux/mtd/spinand.h       | 198 ++++++++++--
>  include/spi-mem.h                 |  53 +++-
>  include/spi.h                     |   1 +
>  23 files changed, 1845 insertions(+), 298 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/dosilicon.c
>  create mode 100644 drivers/mtd/nand/spi/heyangtek.c
> 

