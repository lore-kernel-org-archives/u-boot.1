Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEF8CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C274D608C2;
	Fri,  9 Oct 2026 09:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tspy5kC8rio5; Fri,  9 Oct 2026 09:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C0FE6084A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791539866;
	b=X9pVDi1YH1hjdXP1xoCQycNpbz7e2UepSZ/zeKVAPEu1d15XQS5X4HtiMoiJ/Y9iFaeM
	 /68R86TwSgJnwlzLW8oreuUYc0rKzsAMfso/yG3raSNtclJVlOUya3vxL+3cAzC7DskKx
	 q4B9/vYRh3se8HmauYcS+5EYnU2TEtGICNjNzRsRmbtweE+kqYNq4Icg5mnnW+BoFVLHw
	 ejAEstjkDTLQ//q0NEakK1/gBAAZRXZO8WTxzPGr4U8vpZs31xH8uMLn4SbA829Q6Rbou
	 epg1Ob2DdBUwG1QV6HwO/AV8G4xEZ8X0GF0R6fQ37ZKFCnDeVhs18x+2/5lEkbY0oqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791539866;
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
	bh=ZajwXTP9KmMNLSpLpqGOxNq8+4oGEEf8Ro8LG/2KmAY=;
	b=rRV5Xbg2Oo+okspVcfjsgs94n7q0ckN+2F+Zu+R8L+telVyr8mvawjlQ9oGst8WJYtyG
	 7PRjYLi4v0tSJzoiOU1m3+LcMGngfc5cbPpzhq46UctzLm0o3UmY0JVeOVeyb7gS3G8qb
	 wHkC9dCW89M0ofcHYIAH3A3juUgrxVEgYWpSm7AG97lwqHsgKMITwu6ADWsgVfhT1xAeA
	 WFcrGVYlzACGoN3oguaIKKMtPerv6zbvFigzU2VRg45S59/b4lScDEju8dEECTMcG9lBQ
	 mMcOj4lgY1TNmgCB2SepdgqeLMT4vmTUp4Ix9WR79ZFyAXdpqtOCxlh9L3v+5uogIXw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TilMdbiM;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791539866;
	bh=ZajwXTP9KmMNLSpLpqGOxNq8+4oGEEf8Ro8LG/2KmAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IEefw1flCcPNugFU0ND2kvI0JqoeEt+N6i95RmvnoVqkHKJkZ0TsJDt0cgWHXK8XF
	 D/Lvvvs2l+IXIT8A85+/7Y0U4Ng2szyfqOxP/6w5l9Z8rcF8BXQy4hV+B4xaHEYkwL
	 3hfeNEfbSnNtmeYI1sLJg2+4E9TUlXyF5Vx55CBSX6fOOX7oCStWSxybexuHkwASpe
	 N96t5znTuBiMKBXtDsHyIWPy60bFDdtVvmbumv2PNNXLBbuvKtnH/ZoEVa2qk/10Pk
	 PZmuexmppciOK7onwqIRTdfH7nvAJwhwho8ju/1lNcMSOBBHHNjESBMZYkSxMYSNFk
	 E1KCshduujzMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0FE6084A;
	Fri,  9 Oct 2026 09:57:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E24A6184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D47A7607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auXLwAhO-ccC for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1575E608B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791539863;
 b=cUVj3Q7G3beBPX2XwmPOZaPXvLS1pbGEqtGx70LzehFkx2pXAas+Zd00IKc5iaNAKSmB
 OW7NULhPoB09dcIj2/d4/9ubBhfFrnnZuJeTuJKpZEv/xoVKA+u4MqU00ikqvNdOzPDL5
 5z7tIulARZiyU4w4Tj07WyabJ6cgAVzHat4KMBkpVHoDqQWlfIUqvtVtAQYKPVqfzUHqa
 p1QI9sVJrHwesNA0jS/DMNNaLodlshv2AgZVjr+vR9CNd0cZv/mXh+8dpFJfuIgj8WhvJ
 EKBh1Hhhr4grKRLzSzET65PtKTSq/dzp9bdk1Hpma/Tun1wRfkE8rrP6JHHPt8ij6iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791539863;
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
 bh=ZajwXTP9KmMNLSpLpqGOxNq8+4oGEEf8Ro8LG/2KmAY=;
 b=qXuSNoMc84g3YIKAKPOQmNnpCmblon1l008aDoa2AjR+rTZx7N4HXHGHdwk6O9GQbHKC
 ZfafluITk0VATqadlQpOLOCSRLHm9X3pBMuGCi1hQ2GNusUEH00wsXIgLEtzh4IGrOm5z
 765pvb6p64l0c7ebOz/pZKuUq3ShAjqtuB1Ga5E9SYGio5Bv+7VymoZ02z5Pt9ckEQy6l
 Q5YvP/TM1XYDD09iHsPfV+JBV6eqJm/7d288p9Hsn/GKea3q/9GXtFc8kTPXCiJBMTsWi
 r2w9HQ8bsNvWbcr+v45z8/4g2FsknHMbBcLHN/fhnVUz1XZXmryoPTHGUc2skfpxsiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TilMdbiM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TilMdbiM
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1575E608B7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4Dfb5qow1zSlNyKjwThlIEPUlnr1/8kK/RDV+E7QE/Bd1ibAE+JEEBB04ar+DpZk2nCfzRvbNao70aQx3I3fnwjwOk8e8gGT/duVqziHZe5QhOB/fXKp1Rue6PtpZQorQ1BC9JcJQvhw3ebaG4OFRGMZSUV9gt+YMvJpr9NRt3sW6pPqjH3lQVH28lz4jbL6lwEBKLQEbgf1iURTrHdzFAtUnh98ExwPz6HnWKg2Zic4Jqu0U6QifSXcNdy+bj0bE9vyGNlTvejFXDclc4Lp9QYjz9f3cARyiZECtF4xE+Q+HVzufl6C9DYLrvtYRbCN+zr43q6x8F0FK2Zeci9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZajwXTP9KmMNLSpLpqGOxNq8+4oGEEf8Ro8LG/2KmAY=;
 b=yrk/elPArm3y0EnvoEhkbUW7LXzlmC4t+0Fu91oeDRdlhHKmyoTpAvZ61WFGJfJBhYdfwjaiOLpVVxVOeazHBEATiVAgxCYnCvFPTe32LAG/NTaiIaUhSIhqVvJXrEWY3G90nMM/g2htNj8VO61kf7tqyejw7CVm9Ylk0nY0Fw8BD7pZp8qlxW7fjKLNw1+R8txPR4w0jhOr0V+RFXo+GdgvtAjkvbtFzfUsqlWY/nNvF9olUKUXprouawk3IzoXYkDnlpWdlYdZbrsg4rZiw/53Q0Z6/v4LQt//6B2TGi832KprYMLxhMoMLnADziPT7HzG1ym/+0gAhgwnTdPKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZajwXTP9KmMNLSpLpqGOxNq8+4oGEEf8Ro8LG/2KmAY=;
 b=TilMdbiMLtv3S1SVApzHKByJhgZQTHJYWcDcWJAKMNBpiO8VwquHud4YiNfp39afC2YnaHbFsipj8EdHPsejRb5DRv+tMW4Bp7Kqy2Yx+NpUjR0XQ8/zWmRaHiDtYcu/VCDxiHUpJDFx5MY7Mf4JljAioK43mHqZI+PjVFoWVik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11589.eurprd04.prod.outlook.com (2603:10a6:150:2b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:57:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:57:40 +0000
Message-ID: <71f2e618-7ed5-4790-863a-97318e051201@cherry.de>
Date: Fri, 9 Oct 2026 11:51:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] rockchip: rk3568: Remove unused
 rockchip_get_pmucru() helper
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260804214442.2592597-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11589:EE_
X-MS-Office365-Filtering-Correlation-Id: 954576fa-467a-44e0-b097-08df25ebc152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: mQp3tPWKgxm4zIRHnA+oiQq2Yt9IG0DVNIJC/p/Cv5BHZWjuZ5KlN/kBBwPNyHjilGTwTyrsiS3RqoAN77zVoDU7k9VDnAVtTXJBOYxjGmDLdSiFIo9yI58IfDPVCFzrqI6tIRw5+hSDjlbnR/V7NuuqKej9OgkE/L0a/MPWrSKy5pWD0yiHVRnvrM1aR4qwfS7rvxxSdXDWGj2LxLxneOO8t+BTC/RQF9KQk4lqCxeA2skX6zNNB+wSeJSL0Yh/AAWpByGOT926WS4/vry9skDmgHdkf8rnAbEO695s+vDGUVXoXqoTOUVhe89cFibgG8THeSVhdWKmFw3oD8pRFdP6cqw6Bezafs7SXZ6LxMZogNdz+dsXEnS77gLJg3ok4QKaAqC4BzFQCtnEJw1F5xRm/DygEGsfEOwDsIH7hB9VCmfo/81RgE8lwIBS09hv/AkklRpgGuqbH9sNHpambcnYVw7LWWPkWGZ4ciuWUjlkQU80C+f27gK0MyKoREQR2kad3CwkEA5b+3944djjoJi+gCAkrVGqrQ3MQ2AEOChUAL+s8jXcy7hGBORc9Vl1wrqmQfv/LtBcKVWj9vqhpKhkapcYRHiol8oC/WjiiFBsVaqsCa50Z9Atu1PzUVyBKNhIjolBjrE3KdLokiV+Gv+tpuaPzOz+ZxG7tRyH9WI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlk0Sk1FVm5YdGRIdzd6ZEVvNDRGbm16TThiZXVncWpLNTRCYnJGN2VnWTJW?=
 =?utf-8?B?cXdzdXd5ajExVGNxMlR3NUVmMm53b2pSM0JYbGQ4Z1U4TXpPMDJEVEFka1BC?=
 =?utf-8?B?VHk2Y21pc003ZGlBQzZqeHdKalB5VGcrb0tILytYWWpRcjFoZkhoN2JuZURq?=
 =?utf-8?B?VGlLYkJVWElhQmNSY1JSODBjb09nTnNEOURxNnlrR3QrY3ZaUDE3VDZJQnh1?=
 =?utf-8?B?dTBJZHlpTWw1cWhWdW4vL05rRFZpQ29KdTlpQ0UrSGdUN3JyMXc5QnhxVlc3?=
 =?utf-8?B?b2RtNWl3TnJZdU5hR1hSOVJzck5WWUhWMEZGa0xlbE9UV2Z1Uld2a1JwcUxX?=
 =?utf-8?B?bFJFeGJmT2ltb29CTWZXU0JDZ3EvbDcwWlN0ZlgzM2pkVDJzcTI5VUZGb1hq?=
 =?utf-8?B?ZjY0KzRhVjdhWUE2bE8rekxoSVliMksyT0RXOXNlQWttTTk5NWtPWkcyV0h3?=
 =?utf-8?B?TDF5aXdZSUJxRWNDaEp4aGNCSFFwb1c5empxMnBiS0xGODU5bDZwcWQ4UkVw?=
 =?utf-8?B?Q3UwaUg5Y2RBNUpiS1FoZE9PWjFjeThMSWNDdmlscDBocDZDbDdQTjdLQUpn?=
 =?utf-8?B?N1lISVNBQy9kM1ZybHNhQ3JJWkxQYnZHL2UwMHBXa1J1YTluKzZtMHdSYjlC?=
 =?utf-8?B?RXFTc3ZJb1BrWC9IL2RXY2tBUVBCcmh6NWNhZnJxQXk1aTM3MzdtSmZXZlZY?=
 =?utf-8?B?SEtmTHVRTWNBWlUwNFovQVJyNFF6TDN5eDVBZ3FNTmNkMzVsTW55UUNCT25I?=
 =?utf-8?B?OU12MlFWbDJQczhqQUY1cWFlekV4T0VPN1RvdEN4UWwrZzBZaS9NWUU1cnoz?=
 =?utf-8?B?bW5TNERxZlZmTEgwa0Y4c2orcUZ1b3RBMFM4cUhoclFwekVGQ2p5YVh0aVR3?=
 =?utf-8?B?eFpnZVVML3RkSHZIMC9WQnR2ZDRxQWE4cG1rUkF0OHRnSzdNNUhWaENtUEE4?=
 =?utf-8?B?dnphL3JNaGxNZVhEVnJvOCtsOVg5VUx5SlQ0blJ2d1lPT1dHTklGZSsyWXVz?=
 =?utf-8?B?U2NhamNURXlQYVBaQzVJTHFqdFpXMWpmWU8yMkZuUjVOOVpBRzIyT1RzVmpj?=
 =?utf-8?B?WUdWOXJraTBKY1ZTVmZoNExCVHQvSTh1akhTdE4wSldBWXBiQmc5QjUrMEZq?=
 =?utf-8?B?RTJheTh3MlVjR2FxRnV1MFVKSUVqYkViZk1zemloWWw5dHEvWDFTZ05vOVJO?=
 =?utf-8?B?aUwvOUFRVDA5QVFmN01ncmFLaU1leXlkY21GcUs2N1Z4RFpRYWJheVM0UTZ2?=
 =?utf-8?B?YjE3aEdWOUQ0ZDB1T1BuN0c2QW43WUg1b3V5MTdYeTJodExMejIrMjF1V1Vw?=
 =?utf-8?B?bWV1QTZiYUhJNHptMXg4OXdRa2FtM3l5ekF4SjhoL1UrN2hoMXUyUzFhNW1O?=
 =?utf-8?B?ZE45M2pMaDBHVU05NlVYenlhUFdQRTZXRTNVNHpzdTRUWmxOVTZKckk0aDhu?=
 =?utf-8?B?bTRWNE9CeDVXbENqMWhJdHJ6RnNTQ3lWOTlxWkJWRlJ2TXQrZjlhaFIxUzlp?=
 =?utf-8?B?WWFWSnQ4eHFGamlsajZkNjZmQllFYkFibGtHemN1ZHd6WXdTSW9VMkNpcUwz?=
 =?utf-8?B?L3RtMlFWbjN5eFllRDVBNHhYTXQ1UnhyaldYNFY5VXk3eGxjMk9YZ1VwUFlh?=
 =?utf-8?B?UHBYUlhnQndZU1MwTis5OWRpOUFjU1lUN1BMOURESTlNdjdaNE5hK1JCWVhS?=
 =?utf-8?B?Z3hSSk1WMFRTb3VvS2Z2dFordlM1UkNhUDVTMFhJNm9vVk1Sc0JQVTVBSVlG?=
 =?utf-8?B?YmJaSU5NaG9MdU40b0NPTlZNTEFjdWlQb05NTzVLWkhISitFQXhwOHMzaUZQ?=
 =?utf-8?B?bFJTUFE0dHJrN2RaOEsyRmtWUWRzQjBNQ2t4Sy9qaUdrRmloR3hhcDk4WFRN?=
 =?utf-8?B?SFNGUCtDM1lERGJLVUxyNExrbXMvMStTdFh6czJLLzI0aVpKYUdxOUFmOUNY?=
 =?utf-8?B?VkN1T01JUE5JTmttLzJWZWx2WW9ScVB3UTdMejRNN3pTYmhpT1ErTTF1SnRz?=
 =?utf-8?B?OGJrTFhBNERQQjJtVldTNHFNTjFmbVpMNnp6S2lKbEc0YU1LLzJtZnYxRmpm?=
 =?utf-8?B?c1RqSzY1NUxXZk5PalR0VTJIZ28vcVdVY1BtaXVpR3RVK0xpakRJbytGdFFm?=
 =?utf-8?B?NFJtMWZxQ0FHQ1M1VkthS1lNYnZRYXBDdXFsSEF3alVBcTlzTm9jM3dJYkJo?=
 =?utf-8?B?WmxlZlpEVXl3TUI5a2NLYjdGTmszSnNpdzhFeFFWU0U3Z2g3OFF1Y0s4VDVU?=
 =?utf-8?B?akMvUDIvVDI0eG9WM2pDQUtSU1ZmUFVDWDlkZ1RiWkVCNk1LL3kxeG5qeHZI?=
 =?utf-8?B?OUdRQVVYTTVYeExsS2Y4NEFSUjFsNEVoZ3NyMEUxSUdHNmQ0bEg5UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 954576fa-467a-44e0-b097-08df25ebc152
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:57:40.2280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b44GeGFhNCMZxiJx86EOb/XmwIuVeKHrNySI6z7XWjK2r7EAfrQx1NdxoujQummqL6SniVrlmzX+NENwXw8DA5EjErWk7Z8zo3ZyMJils8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11589
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

Hi Jonas,

On 8/4/26 11:44 PM, Jonas Karlman wrote:
> The rockchip_get_pmucru() helper is only used by RK3399 SDRAM init code
> to help get the PMU CRU base address from the clock driver private data.
> 
> RK3568 has no uses for the rockchip_get_pmucru() helper, let's drop it.
> 

Maybe move this patch before the one where you switch to use hardcoded 
register address to make the diff smaller?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
