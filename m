Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B57CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 10:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F202360A73;
	Fri, 16 Oct 2026 10:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34S44KiDNJ4x; Fri, 16 Oct 2026 10:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5380A60A83
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792146885;
	b=jcWctNVJ5JSQMQynLoeX5LTxdw29K00HkNrC/eUDWIQB9VI2G2YbMk3XKmXDMVyfTfE/
	 mMauiaybq0hX440irJOxpI8n6px633Ztr9TKM96yZTVoQ+01ADBEQR81qdcVCtVrM+iDJ
	 YZe6jZAxWZHZsBlXGP8zsp7hBjarWXl09sD4WanTBulxbqAEDyEzDdw4GcvLFR36QCqVN
	 1f8IGRfjdo2Z/vWiU23S/dTtgZmulzCIfCeKX9jMv9RVYlwq37BPeMGit7abf5fzLXgUA
	 5k10aiBJH4+OfrLKrrbVA33ZG7T37THmU5QHdlIXl0eMSjdVcx5vgkFczxKFgSIzJbw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792146885;
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
	bh=wTNRyP8IgdcQ/GQgZhzgmqgR4vyCYR6/AxVPCvmwzh0=;
	b=nMsbSF/F30sFX+WRQAHMeHnoyI9DYQ1PRV0iQEdkbjY2JTD9sVXQa4/gn7Wp/0SsgWzi
	 wAD7uyepKDUKSiccVE2DN2Rsojh5W8YZoLQLbnTUPwgwH7bZxE+Sh1EEx5RRKJlFE1ImI
	 JK+LBh31j6xdv2a28SlfrkEZdC6WYG1ufBdPQxdW/oeuwa8bZt9587xW6cxrW45PHDN4+
	 nzvNgU01a9SbDe/aOm85YV0hQ33uAQNLazIG2Hli0rSwRQ0KKAdH4HyOPnEGuC0xH9+1i
	 FNXMi2dzhKnPLiN7/6iehvd5J6HaPxPRnSgoP4963BwkC+ncj0DEeITBZZi/yVGNEHw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792146885;
	bh=wTNRyP8IgdcQ/GQgZhzgmqgR4vyCYR6/AxVPCvmwzh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOfnoxjg+OkwY70QR9WZQ+58k2I4VnnzO9BuIhfFpUdNzxSMeQG7T6FYHRF8Ixr2A
	 avc7V/BACZPwHE31eJigiZptF0sSp354u1B95aG4jVjEJBGwXLsedFeD9gDcr+z2Ky
	 vYrswdKdiy6zjaV9ib6QuFoUa+VpdnT9h+zp3/Ca8E9n3TQRMEfQsRcqgCd2Z7/LpE
	 g59h43B+6s4PFaUOV0yza4d/1CDSQWIs+WJISbETiyKNgHBlYqdCQYajUa+7KX1lNA
	 nPbZkkPhKHo10z91yH65SxwBjiYSGJfPpIN4tk8oc6KZr50pIb9IzNXg27dQXgK5q6
	 v5+SSEzD7KeaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5380A60A83;
	Fri, 16 Oct 2026 10:34:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9112C109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E8AA409E3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLKY4u4hySiF for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 10:34:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8847B409DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792146882;
 b=Wpx6L+KvBS4+atsUpaSZN5YPimExzGkyR+kfOEXglZzO32XkoyYWeIezt0ciunhZnIlx
 HGK+OJNFQdFQ7AIucmQKK4kM1HUhnzj8/prmGe8ijqkhINJxdlaWNBoB7NiM7BTEBFXkG
 GzEVAEYR0noaMxk8SiTIHWO7xYdWS1Aspxp5xiiIc2QCREUARD4H/8b88+PZNkSLevNNV
 j//Hj0Rfr975nZnX0N2DuJzT9C1Vo4xXEw67WkM9dMQmBBQBpJeE6WzLwUXYfopIhlHOC
 nXyJvvPJWDAljru9w18PUZV5xZegETR3scODRRycLeXsIyVb3DvYF5Pt+QmRbaXLNuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792146882;
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
 bh=wTNRyP8IgdcQ/GQgZhzgmqgR4vyCYR6/AxVPCvmwzh0=;
 b=AC6W+E14s5tFDbVfEiZM2rhkJsd+BNcMGJUZO6Lpvhv7FqIje1CjFke+cKLx1RHyfSoY
 R/rv0j68f4GgwN1cHeB9P7CgiOykEGtH4/hjqUt5jU9JWwbrOJvvpVc2TSetqIrWDn4I2
 1WsFww3hpQTbWmZRy146gfJctw+HwJo3DG9vztPRjZBKe7BlFGhndaKuUipvXjece3U3Z
 dBxqMM3M0EiSaf9qttoxt/LS8bR8LMBF16Ww8U3iv5/hMMDKviCM85utgCarlX3XvPmt3
 28aAwnvpjSOhJ4zSxU4O64KpbppXyYr/3xMqRSURV6uxt7vBUjO9CadQ7b4noFmrjHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Vrygps6i; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Vrygps6i
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8847B409DF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaJ3O0a9pSb5IEnJ3eYebIi6McTzpYTrWwjGcWHQUoTtkpjjVAUlzEL7jOai+rlPb8F3GBBAGZaU8RZz8wT2xuDbSPGhpSCTTUAMEROihxy4JoYLCTINn/1I+suslnvrwXU3kUQOeZJaDtK7z8wg1jN0ThVU7VaNx59Q8TWbIztmTYiVst6P8OicYVtdk7Yc0qUXVjFu9astC9b8vI9JvR8riyjm9BeZJjY8TH5xOreX3KxRR+cJn/KxlHKSzS4BIRvIdn+2+TK31fkpZZjrWlv1FihZ4C57pkAN6eE8QewLpjHmKmYOd/yh/Y9y8QdacYrFZT+0ujK4vck6FTJi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTNRyP8IgdcQ/GQgZhzgmqgR4vyCYR6/AxVPCvmwzh0=;
 b=hyPSPyB4Rb8l/2qiOeBK3wo44NmtGZzU0Sqn8TwTUm0GVzdEGdwT5Jt93jG46iZVI2C/ih3ERMcJeZxAVy/KP3k5W6zHE49CS7p/BLKpB4wD3hOJxmH9eLvqySopDivFFtw49JePC/Vzf/F7ddJOiw6f1H1ekEIr8RLp2Gcc2TqujfyY9kOnUV6Zk/8rX12PAEMQmTZnu0oG85PwdbmVpilDjMmLTGlCGUXr9m9c7SFIXn8wpE94g5BmFaQcgC7DyIrzRCGMd361kpCq5m1lKC7byrTtByGJileYThRmDzv6Yl8bbN67E664fA9/KQL+kuaVBKaEJ+Sk3TqjBA5Dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTNRyP8IgdcQ/GQgZhzgmqgR4vyCYR6/AxVPCvmwzh0=;
 b=Vrygps6ivQNYwkfSB8cvkoIfwKnWtNRw4ZVbNYj6LlBGk/ml3sXYq2zLguAlQB2qEqCCeqNAhV7YzWoD+tuyiaYN+SxEP7fn08SRaMewS9AQVjxlX75wq+fPiVud/2e1Api7cHGucHGCa5gUvi165s9M7iA2oLuLZwtoS5bnt4o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 10:34:36 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 10:34:36 +0000
Message-ID: <2e0713e5-be67-4c7b-937a-6e937c27d6e8@cherry.de>
Date: Fri, 16 Oct 2026 12:34:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rng: rockchip_rng: Fix wrong TRNG version error
 message
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261004211349.62883-1-jonas@kwiboo.se>
 <20261004211349.62883-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261004211349.62883-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::36) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: a044c676-a9c9-4bb7-93d9-08df2b71134c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jaB7Oi207LG7+u7InaHjQFxPgW/dIBaEuv64VlyeF4ne/rlJ0BBGsrh96Jc+XLePxIJjTswx1Zv9WsSj+s7BFSahtaECXLPIR8Mse1lc37oKNUDqAJF0egavIQI5kTMqozbVU8p9maLQ1vrVT4RcBK9G/n0V0xjelJsnwLBqe94DhLpOgyWNaBiP3rtb5EH6EIPwqYJRMdBSXQKPb6M7wFg//6S7GmONPdbnXDHHV/uQqh6g8g9uKwHxqsFmDQjuFAwcYzBUDMVs0x22+apa6XtM9eXyrHDhMupi+nMBvy2xNfeAvTVFXxZ3pwzvQ5Dgo812kn4Wo1GcgluoyCSQh7jadtPwapYBwRA+6SCKpq+D+itnq3HC6ksh8QNMr1iy+1Qa2Y3M+une23cTg6pKaXYOKr4Xv9ykJ1QNB3mOKISOfg7qYzrjZY4vA7am3Zk409rEI5oDSTyE/MmtRDCx57wnnJBt49TAeWuYiUuWe9TebTTxgpQWutcuvTozELR0GKbqfGRXp04bOVK9pi7b0ggyxh2RyTL+gz5dgKN2fdtCbZlgBSmzjAtZc1AmSoI9FQfBqCcVLn30jvGWWpvLQ/dg2x4rmHGverxZj6FH/bpMTQsG3SAe/6ZrLOjkNn2l2CKIAOciG09psMEHPNf8KHxQFS7gDPmmrGeE705sErg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhXQkQ2Q1lWaldVY2pkK1dNclVURUNUNytmNmI1YXc2NGJSN2dxTnF6VEVP?=
 =?utf-8?B?dHdvd0s5QVRNNWNiRThvY0lDNU93Q1RBK1Z0U29DMU9tQWlEYkc0T2dTZkha?=
 =?utf-8?B?RTd5QnZEZW5hbFR1VlBBallqWlpVbVMrelgrbDRjM2hqVlNDUVhCUUV3NDcw?=
 =?utf-8?B?VGloNk1FK1NUeDZRUDdIY09OTTdhZzlPMnp4cWFCcG92bHplbUcySWhqZGo3?=
 =?utf-8?B?Wi93bEpMamZlWHZCNmNkSlNScGlpVThrUjhOdWgxMkIwZXp3ZmYwQWhuOW5n?=
 =?utf-8?B?bU14K1RWTk9NeFJ0bTBxWStGanRYTElqYVJwR2lrTkNsMlU1Y1RpdWtSQ2h6?=
 =?utf-8?B?Ykl3N05iUm04TzhLZHZxQWJkRURmZSs1TDhVUzBEbkZCaWFwaUpycm41cTdo?=
 =?utf-8?B?VXhlMlgzYy8xNjc1NVNmeUJHM0pSRHpDRlBuQUhWN2N5ZWgxL1VoTTBBOGg2?=
 =?utf-8?B?U2d1b0NXeUlncjc2UTRDYWlPRzh5NzJzTHg0dndVekdMWEVIUjNremhNNW8z?=
 =?utf-8?B?SzhaNUNCRUcrM1IxZFN1ZGttdWR2RFpNZEM0QUVBblVyOFYreDdwRDBwd2U3?=
 =?utf-8?B?WktSeE84akNycWd4QzE4cUZoNm9yY0s1MWVYOXVUbnd5RnZ5MjRSRTlFSTBv?=
 =?utf-8?B?a3BLRnlnZE9VOGl3RVVXWUpZRnV4WHdSQ0djcmY2VnliUmtPRml6amVZZG9w?=
 =?utf-8?B?NzFYWmhqZE9wWExJTE01SFNMeXhmN2UzZ2RDdEtMS3VOcDExaWswSnBNT2NE?=
 =?utf-8?B?VjNyejd6RkpGTDlqYlBjY3U3dkgzZTljenVxbHZvUjVQVDJONUEyaUttWitM?=
 =?utf-8?B?L3BaV0JhNTdvT0VNdEs4TU84Z1MwUk1FR2trc0NTL0JDYnI3ZVJoNTNIWk9L?=
 =?utf-8?B?ME13OTVHOGN0UjB6SHY0RVpVZmdDREt0N1huQmQ4SFplRWlBcmdFaGZHeStV?=
 =?utf-8?B?NCsyVnkxN0pGSjZwWDZRQkN3NGI1aS8zR3lQMG9LZ29oemJwYWxsMDViSzc5?=
 =?utf-8?B?enJXS2tKeHJZemN4TVdkeDQyZVlFV1p1OEYxNkhkUjVEdEJNd1J0NzVlNS80?=
 =?utf-8?B?OXV6T3BodE1VWkI2clo1T2sweFJZbUZvL0I5N0tIZFJNbFVMTDVBSEF0RHVo?=
 =?utf-8?B?eWVMcUhHa1JjbVo1TXdtclQ0MzhWWjRXOHZ6eHI1ZVN1amtpcGdzRjY0YXE3?=
 =?utf-8?B?ZmRvTG1JRXFNMnhKYWd6cis5K0ExbGhCWXVpSGxabmZqZW0zaTJtZFJ1OGtV?=
 =?utf-8?B?c1ZWTHZXLysyc3hKVnkyOERhTTMxM2hwZ3gxNWhUZlhvY3ZHbXpwY3JOT2tO?=
 =?utf-8?B?S3dHTkRlV2FFMG9WWDNtK1VMMkZPYTBwQTZUbEZhRjgzUFRPTnluQ0l5VFdq?=
 =?utf-8?B?ZndiWmMzOTh0TCs2WGd3ak13NjFZQU1XYTd6cGdyVjk4dkFMd0VSeXVhN0Ez?=
 =?utf-8?B?eStYcEgxRjVaZTVUdWtlakxBMXhiWmF0R0JHamFQdmFLMmN0YkRGL1M5MEVU?=
 =?utf-8?B?YTNLSENaZktCRURHTTZpZ24yc0NUZGpleGZZM05RWEJSTnkxRDMxYUhsWUlP?=
 =?utf-8?B?bjg3dHdoMXBlMEQra3BIZlBJRG1HeFFwZGt2bkR3SXRRZ3MraTFTL05WYmdn?=
 =?utf-8?B?UzF0V1lsY2U0dEc3eFVSL2tWM2xSdmVkUElQR3A3dWdJWDYrSjBKM0kxcjZ5?=
 =?utf-8?B?SCtlelgvUHRSSVBqejJYbUNMRzdWdWRFTjhiSmcySE4yN3VlRUs5ekQvWms1?=
 =?utf-8?B?enFXUFE4VFRqMFZ5dnRoUnAxYnNnVVFPSlU0UDdpbzhwYkUrbzBvci8ya3dL?=
 =?utf-8?B?cVRqckxpbHhHc3NFRnVzTGVtdFJGUEE3MytZUFV2MXo2OXFGcitydncrZWVL?=
 =?utf-8?B?eEVBaEhJdEUxTDM5czhhR2pxU1F4aUhReDNGUVVlZlZQQ0JWR0RtWDllQmF2?=
 =?utf-8?B?L0lBVTRRMXJOSmhJNDlSVmE0WVQzUW9OL0VsNmNFbGZ2VXg5S1p5UlJiaGl4?=
 =?utf-8?B?T0FsczcvWTNwSGdRcUZxdmlCSlByZVJ1WWEvYUxCNDJVV2ZjTEx3cDdZWks3?=
 =?utf-8?B?aUp1M3o2emhITmZFdm5rUldtNFBSRlp3ZmVuVjhQNEU2RDRSUzBsYmdCR24v?=
 =?utf-8?B?TVJqYldoNVBpTXlQTUtnZUVSMXFGTlZYUDcySERCUXJ3SW1SZ2RZQUIxRVEv?=
 =?utf-8?B?cmh3TlQ1K1JCQXR4T3IvWk04VmwzM043OHFTMStiY1o3OFBpcWxrMTFURXZp?=
 =?utf-8?B?cDc5SXQ0elNqSnhIb3l6dkZCdXJqajVjelRWWFZrMkN0Wk9FbHYwdkZZaW1t?=
 =?utf-8?B?disxaHhNTW5UNk9tRGU0b0RyU1JYOU1PTUFhTlhyWmt3SDlMdmk0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a044c676-a9c9-4bb7-93d9-08df2b71134c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:34:36.6806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74YU5ARgjeLP4o3qccn3s7arD0D6FXQ5hK3+j+5ih/uCeflvrhiCQZltKFB+ZdvK3Ai1pFCkVO7HlE1L/uJLKlsIExbWZn+SgV9JClVMKIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854
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

On 10/4/26 11:13 PM, Jonas Karlman wrote:
> The error message for unexpected TRNG version print out the reg offset
> instead of the expected reg value.
> 
> Use the TRNG_v1_VERSION_CODE constant to correct the error message, also
> add the missing new line at end of the message.
> 

Fixes: 5891282bf399 ("rockchip: rng: add trngv1 for rk3588")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
