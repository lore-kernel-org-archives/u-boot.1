Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BD9C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A549280DC8;
	Mon, 28 Sep 2026 09:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8dYSIvfjFot; Mon, 28 Sep 2026 09:10:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9839580D49
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790586652;
	b=l/Kmsyl12dprnxemZ/mMJjcHvjBJGnchDl5GX5RmN3sHQxV9peYIMQ4PdJjhHjHywOjU
	 LglFJX7tIaaEaxSRo+5OR61FG9xerJDA+Eo3ju3Tb4yyq1cOEcxFjeqWKPmyu7YiQ82KL
	 yRbdImx5GbHwnI9B5Osik0LApriOM5vA4EwDurIaBOwcQVSvmer9DIqM2Fv2B6KgoW35L
	 8/tFNAzpmMruJP4klztqZyAWLBeSUHWo2GAj82r8OI17ULFnF4Fu7yM4O0z0HTA8KetUN
	 WWGtoJ02if1bRfwS32crKZeGyj4u3GeA0vQ9KNnqD+qKGdj7RHxPPQJYbwkmtSn+KIw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790586652;
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
	bh=3U1PFTxWW1y+XtMSHu89ZQtGl49td3BjnAfQZGrDpyo=;
	b=r16jHIUqzRwCQ92TRAItA0AlncSh5rnZ7gAySh1/5sy3qZaagh2m/lAtkCoSAx/0wHOk
	 R//oiMARV3XCI1BWAIxEy80TDXQXLJQpRlxOYy6jll2ey+CNe++mGLKiFZpDzM81ruA21
	 0DKmum25mllOrlcdYsJGzg5I8xst+1o5dfA3MBGPnNFTNVe7ZicJfhKqD3p8Hcj4pAqtn
	 tI4usc4tnRV4FvUa1MYMfrHdDGaYdiViCvHiVTK1VYYIfQa2LjDcpVPUBo6IT/z2ctnzk
	 nYPpIHtS8mB23Rs/Ku8/A94mKbEcWAVmpj1PEeDNnnRzOt70Es1EGJcO+jzjbQSCxaw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=cvJQkRWl;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790586652;
	bh=3U1PFTxWW1y+XtMSHu89ZQtGl49td3BjnAfQZGrDpyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aM3pCve0haJP+pwq48BiD5ZURHPqYjglHBVrN9qPRe4dYkrhE+GaeKAsEx/98BlGl
	 UNwzG4QzZKsTIQ1KDtEM1rYtfPRCMy7amQWZr3y2xssEqEeu/QvFwukLotzs2bvtDV
	 jUUwknlGdQ5v7ME+VT2HAI1Z+g8rQgEJd66OmqGU/EeNNIECLcgnCXU+HLs30x1GMd
	 1FcL0p1UCWNdR+iT7NZPKKP9VHMpSuSflNed6uzcGfHtIuPV/SrnAtSuOMtZlkojrp
	 slS8Dc/K+Xy+Vu20P3Qvm1Y7hu/OIn2HhHVvqAt4EeVU0F0RssyqoajCAKNXcrrwFE
	 eKKfNbJA5/4zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9839580D49;
	Mon, 28 Sep 2026 09:10:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 001A124E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0E3980DBA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HwwI1Zs1eLEC for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:10:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F1A2980D49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790586649;
 b=OFXTc6rkkzM8IQeyF/Iu0iNp+jreDrNIqgQin3th54/UMuNsW4isiLE4OuNMneZUr4FU
 z2VY0OmYAdZn628hrTf9p4Zd9PAF0QtpTiG9E3sAHbuBWzuMjI/DiY+HenIs/XtEhppnJ
 aTKSrlWhZTiSGUwgsX6wO9KH0a9PFMI5AkY3uekFqcwrxz0w8SNUbL7f+SqdesA2vWmvr
 QwBvDW+tSIWURl//q2cl2100U3XpKzkrPEGftffZ7fiyZvDMtBQ+5wGZsy4bqWZJPlL3s
 oZZz/MCRqkvRI1RuvES4yhUBUvLgo/t8boHR0mulmWkCtpDIJUGKWo+rxCEM6+Rn1aA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790586649;
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
 bh=3U1PFTxWW1y+XtMSHu89ZQtGl49td3BjnAfQZGrDpyo=;
 b=h9PypumHhFF1gOfoWvspKD/X+0JMEOnGqUXHJjZEpJJR60X141+wIANhVz5JmT2hJKqV
 wHplFXih6lyQZz9dTfzTV5x+srEtZERj/z+qzCngv06qdZuCjlXW5UZPNzLyX6CEFmX6N
 smL4GQx1537msVIx6xqb4RYfKEvpb/+4vF1ebzmP7yFWGWlQr7iYk3qBA5/z8Py9RuUxU
 1/ni7f9FynBZMeWbb7BjieCFjkwJdaeEk14NVjPls4GzZT/d1ENwM1ro5Z9q2jej5mgf1
 /AZg7rz7ec5nKCUMXRm40Ap0AouL1EaD26adiPY9ls7aLY0n/jxSvDT+24TVkA2wDlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cvJQkRWl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cvJQkRWl
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1A2980D49
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDbFGyjLm1DZCSpMGWBzSvrWUBPBcy2furOPGEM3IlEJxAH4dgRNWANnj/oHXkbjkWhb+RMGgPFgr12+nJLUavQDKwVq1ZPmNBID7hSSa9ZlpzJgEKaKF7vaG7PGaLgPevix55zuZVu92XpflRpiE0RnNa4BVQfEjoGptQYCU7jHivvNYjJ4FRluFE0tPgqUofwNczjf9CHBmU+m+hJxw3AOrxFHrysZ3U+cZnAOhmVCLrbiemctVf3ia/0LR05O+1nMKBK2a8KOYRCpUjRUIV+tUMwUW12j5HmM2/J5+IMs5CK3f6mG5HGtcoRmSGvtz1EAnaM+kdK3Nr1Sh6jDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U1PFTxWW1y+XtMSHu89ZQtGl49td3BjnAfQZGrDpyo=;
 b=CPhnndYfc5QRsLTcTBy1OuQNQL3RoiBtRC6GAVEewh8CjHzr9jKOVDM51t5m14cEdeu0t4n08xuCXgznvV8YthB5JbwZryuwbe7i6AdlAVVIoW4SN4LIHaO4QPQQKIPq94RcoY37K38ziyqCbjInbArlMVqcH6W55I5R9SKbNfpO1EaU4bcKCiXhJ2jIgRqID6iARgMjh5t2v9BvOhbLX/I3FUMJLoqbQpAaXdVLHrNkTXdwAwgCuO6VexbsS+kSQTW0A+XmZXt7vlZthZRbiwCcDSQ3GlFFoqS96QFSDasWVsYxtkeyEEEJJUPnHY0MeCg5ybol+0L+zOQhbhy59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U1PFTxWW1y+XtMSHu89ZQtGl49td3BjnAfQZGrDpyo=;
 b=cvJQkRWlqloLZsAtC97vlzUgpdFYbrE/pWkUULCishh/CxRNKEy5epOb00B5GnP+DKwaLBEYPCSiigcArwk5d3Voh9IqHnf1dEYz7bjFBzMw64hKdbPrgeM8BuN7C5gnPaSNLM5Mqm0z6+YCvI9dxubcRhi4roE87Or/nKhzSA4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMZPR04MB417958.eurprd04.prod.outlook.com (2603:10a6:20b:7c8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 09:10:42 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:10:42 +0000
Message-ID: <269fbd75-55ed-4051-b4ae-ed136dc36af1@cherry.de>
Date: Mon, 28 Sep 2026 11:10:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260920161930.1880133-1-jonas@kwiboo.se>
 <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
 <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
 <CAC928Hb4GK3y4NXt0tEo8U=QF57WeuhCZ=77mvc0t2=6iSpZZg@mail.gmail.com>
 <d96f1848-bc26-454b-8bc1-4cd5f8994e57@cherry.de>
 <CAC928HYf7zobjKPt+qQA3=fQSzuvfKqM7LvD-kG5tPBM=+Y1Gw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928HYf7zobjKPt+qQA3=fQSzuvfKqM7LvD-kG5tPBM=+Y1Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMZPR04MB417958:EE_
X-MS-Office365-Filtering-Correlation-Id: e47d1eab-1c47-4690-8173-08df1d405f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2bKcWVF0eeBOzCsqRSoYbX9arOiwOuZME54F00BmjgYnAn4qfuoOzOE5DWW/y6HeOg7A+VIK7XRywn9RRur7RY70xnA3+JELBm6nKPQ8fHLpFqiHgJYHk7A4qNYp0dbT9/REOmQD7iaqUYkJVEqObhqMws2y0HXS0PyzMNybi8SnRTh2G74QwVnRByocp1joW5yCZWQbYJSYLjVoDKLcqgwV97TNCbPv/ngFAOL2bxc96Kgn53o49f3Cz78Ke8J4y8YinV21tMu+vP9Y8IOIy86H9b+BaRmEY/jNHBsiXKUWJ4Cf7fJVyPNWtCR5HP+a1BU9qn98Jr5yMh+t2VXZ5KORGD2OGT7fQuXmfzY/b+8sveMvx7XQes+YayMXi1e+n4AbKRMQD1vdrOk/29ueA0giHzz1U7AcRuD8dNnFESgZHujt/igYuPY2PLamM9clsrFOzUtG0DAiXpC7APQ81FQpsPD1ev68U0rV1pHO3ZSQ5b5JYHu6MHceNZeAEcYaY6AKlD33wKw7n2cIzdYPXRedkUkpNZ/zsxSZD02cPGTL4rcOmpXOGuZcnZJ9uxxhEatVm2Vg4SzoK5Hzu8BeLU2hzWEoYu7DjNTRE/QFmxhNJTfZvsxn6dugDLPUcaTIUyiu+i//FqQ3Yy3GfJslRtvzFf0ujLHkx2wsu8xzR/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVXMFFHNmJDS20zWSt6VVZ6T2kzNFN0cExRT0N4bmlmTnZTbFB4RGpPeUg3?=
 =?utf-8?B?Tmw2cWwrTDBpOGtqVHpwcW8vbHJmRDNGVktkd3VEMFNSazcxVEdDSSsvY3M0?=
 =?utf-8?B?NVpycXgxZTFERitBOW1FU1JLT0xDeWdWN2l2a01uVjVqZ2RiSjRzYkd3Um80?=
 =?utf-8?B?Y2ZPRW9KV0kwNndGZ2VTZEpta3djb1BDa1YxU2tSNVNhRFkzbW9xMjVWUWlE?=
 =?utf-8?B?YW5zZzBEbTVnZVllUCs5QmEvdTNQZ3FUNlZ4SlVwWGFjUFpGRzVYaDJzQkpY?=
 =?utf-8?B?QitoWGQxWEtWMVMzc2pzbXMrQWNNeDN5TUgxb0h2a0NvaDVIWnlKTlJvTlJ0?=
 =?utf-8?B?OUhlUm4xM0ZySEhSb3J6K0dqK0U3eHZmNGJmdWIySThEVDBpY1dLb0pEWUky?=
 =?utf-8?B?YUJheUxrU3R4RGphT1ZTWE9uTFVwOUZWc3M4cGRmSHFLemFBMk4vN21WdmRY?=
 =?utf-8?B?RnlGb1pIamJPODUxenAyVHpmVVk3QXJLbGROVnRlSDdiRW1ZNmNhT2V4cjFM?=
 =?utf-8?B?Y3NHbFMxMG1pNjRsbExRR3h4Y3RJem5kOHlERVE4NWdRbFltYUFWeG96UXU0?=
 =?utf-8?B?WUEzckR0WjY0WGdkZUdRcnZaa2piQXQ2VmhXRjFIUHEyUGVYTkF6NDlLS3lO?=
 =?utf-8?B?cit3R1dyVEQydmkxcUZISGNEUy9mTGJaV21JQkpDeHNWVC9Ha3dHTjMxWEFM?=
 =?utf-8?B?Z1VkQlBpTTVmSVFEUmxxYmNXQlRWYXJRL0xYaFJIRlhJeVFpaGRXMnMyQnRH?=
 =?utf-8?B?NmJSRm1LZ0RvamlUci9EYStCWVA0c0VuR0Vla3VGZkEzY05CT1BpM1hBWkY0?=
 =?utf-8?B?UGhpWUp0NXA0eFZTWGZ5TG9DNEZkU25hSlloWE1zSGN2UE5PTDNxeEExaWg4?=
 =?utf-8?B?UnlCNThvdlp1b2REY0hHVTM0a2tGSjlNTUxLSFgxVlhRMFVubG16NllNMC9E?=
 =?utf-8?B?Ukh5TkxFd0xOMW56cThnQW5oOXFhd1kvMkpxVSsyWmNON1ZrRm5aLzh4REwy?=
 =?utf-8?B?dkErNVJCVWhTM29RMGd3eG1xdHJkUHh1Wm50aFRTYmI1OHYvem9CWnJCTURC?=
 =?utf-8?B?SEdDOHV4cTFneFNyUGpGVUJhTi9TZGhsejJMYm9mR2hjOTF2RFlvbU1NWjNG?=
 =?utf-8?B?dVd1RkpqL0JHUklCT1VIYWZHWG10cVh2K0tBdTFhZm9obGw3QnpwbWUxdHpL?=
 =?utf-8?B?VjNObm1zamhGeVV2UlZQUzhrTk1sSzZQWktpMG5IUW5Mb28yTExTdXYxMGdR?=
 =?utf-8?B?UW05SDNoOXh4SDI3ZVVRd3JPelpYSlU1djQyNTFBMGt6eDMyTkp5anFUZ05s?=
 =?utf-8?B?cFlpaktNbU5JdSs2NDdrREJOMUVPaVhoRlB5TmltZTdyWjJmVmJZamt2NU51?=
 =?utf-8?B?MktMYTAvaXhyV0dPL2g1dWNXU0t4MENVWURzb01YOVByYktnMnF3K3IwWFJi?=
 =?utf-8?B?NUFEYjFqWXhmZ1d4Q3VmeDZXOTZVcmtDSkFmY1RTOVBhbHFUcXNLWVZibGk2?=
 =?utf-8?B?eHZNa3BzK3p4OC9uaFNZV1JJdGIyVFp0ZjFZT2RzVkd3ZEdYTmpTS1NrU3dq?=
 =?utf-8?B?c3ZZcU9DbEVyVkd5TVptcTcyYzJsZTBYS3FiSitJLzYwK0FRSHQwNDFHaEVi?=
 =?utf-8?B?YVd1WG1ZZVZodS9CM3ExeHp0Z3NaNVFsK1dFenpZeTJ0eFUyUjM4TEVhM0Nh?=
 =?utf-8?B?WHFCcnk2SjNUTVJCSVBKZEVSK1dHZkJXUW9nOTZhakhlaDhiMFhwbDFldWJB?=
 =?utf-8?B?a1JSQndIdVRzbTN1cEJnYncrdzY4Z3piM2FrajNmZTEzREQ3eTJYRDB1T0FY?=
 =?utf-8?B?TUJRckgzczRiOTk2aG8rbi9jdUhJbDFhSDVqTzI1ZXF6eTJSblFtb1lSdW8w?=
 =?utf-8?B?TEVqUmFUNGJJaVMybDNmai9jUXFadVRIQWlJUk4rOUxBSWJMR2NoelhXSFRs?=
 =?utf-8?B?Rkc2bENzdEhsZzduNmIwcnZxV0F6alk0cXZrcmUyNWExTWlmb0dlN0xQVGlJ?=
 =?utf-8?B?UVBQeUhoN0JaYmxTM3Y0MXE4SFQzeUJGeWQxVS80VFhwczI3UlBVRjJxUk9n?=
 =?utf-8?B?SitYakJBcWVCbDFVd0dlK0xNQk1INFF0bHA1bEJjcFZrc085cU1BUGp3YTVX?=
 =?utf-8?B?dDhpV1BYYnM0UW0zMW5lenN1WG83b01vWUpuRnVYWmxWc2lFMFJlTnBtR2F3?=
 =?utf-8?B?VlgyTU9wR2h4NzlSbmhDY3Z2YjM0SnQxcHZocER6N0h0Qys0Q0xaUTAzODNt?=
 =?utf-8?B?TW4yb1VQMUhBaEV4NjZxZFptTElxTDE1UEoyRy9JVzlVWVJXbkVnR1JPb0g5?=
 =?utf-8?B?VTlNeisvVGhnRms5Y25kUTJCZ3UyOTR5enZobVAyWmpzOW5rWCtJdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e47d1eab-1c47-4690-8173-08df1d405f45
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:10:42.5247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qgf/woL9nm/XHnH0k/amN/Y1L2SonSkJwHVo4xf3G8IYphwB2ev0WilIyBd8GTZrn8vBOtrvGwuHaDowfpfSPyiZjj5nYZoPt+/JA8OKTrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMZPR04MB417958
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

Hi Massimo,

On 9/28/26 8:42 AM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> On 9/24/26 12:03 PM, Quentin Schulz wrote:
>> Hi Massimo,
>>
>> On 9/23/26 7:52 PM, Massimo Pegorer wrote:
>>> Hi Jonas,
>>>
>>> Il giorno mar 22 set 2026 alle ore 15:28 Jonas Karlman ha scritto:
>>>>
>>>> Hi Massimo,
>>>>
>>>> On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
>>>>> <jonas@kwiboo.se> ha scritto:
>>>>>>
>>>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>>>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>>>>>
>>>>>> SRAM addressing only seems to use 14 bits, meaning that reading from
>>>>>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>>>>>
>>>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>>>>>> reserved region for its global data, malloc area and runtime stack.
>>>>>>
>>>>>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>>>>>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>>>>>
>>>>>> Current memory layout possibly looks something like:
>>>>>>
>>>>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>>>>         [..., 0xff0e08c0)                       stack area
>>>>>>           [0xff0e08c0]                           stack pointer
>>>>>>         [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>>>>>>         [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>>>>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>>>>         [0xff0e1000, 0xff0e3800)      10 KiB    code
>>>>>>         [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>>>>>
>>>>>> TPL currently does not touch the malloc area, instead the reserved
>>>>>> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
>>>>>> the TPL stack addresses deeper into the BootROM reserved area.
>>>>>>
>>>>>> Using current offsets for global data and stack does not seem to cause
>>>>>> any known issue for BootROM after TPL returns to BootROM to load SPL
>>>>>> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
>>>>>> could theoretically change this and cause issues for BootROM.
>>>>>
>>>>> Here with "any change to [...] code" I suppose you mean any change of global
>>>>> data and/or BSS sizes, correct?
>>>>
>>>> Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
>>>> global_data' would affect where the TPL stack ends up. However, and any
>>>> change to the code may change how the stack is used and thus possible
>>>> write to more/less/other data inside the BootROM area.
>>>>
>>>>> As code size itself is checked against
>>>>> TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
>>>>> of doubts about [1]:
>>>>> - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
>>>>>     strictly less than?
>>>>> - shouldn't be more correct to check the TPL "footprint" size against the 10
>>>>>     (or 11 or 12) KiB limit, instead only the code size?
>>>>
>>>> Correct, this was also briefly discussed/mentioned in the v2 thread. However,
>>>> this patch only tries to address the issue with TPL stack being placed inside
>>>> BootROM reserved area.
>>>
>>> Indeed. I was just wondering if in a future patch we should avoid TPL_MAX_SIZE
>>> configuration, and instead have just TPL_MAX_FOOTPRINT configured to 0x3000
>>> adding GD_SIZE and TPL_SYS_MALLOC_F_LEN in the linker check.
>>>
>>
>> I had never heard of that symbol before and went checking. It has never
>> been used (there isn't even a Kconfig symbol for it!) so we would need a
>> bit of work to make this work (probably not a crazy amount though :) ).
>>
>> I'm not sure we still need arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>> though. It's only used for evb-px5_defconfig, all PX30, all RK3328, all
>> RK3399 and RV1126.
>> I think it was necessary when added back in 2019 because
>> arch/arm/cpu/armv8/u-boot-spl.lds didn't allow yet to remove the SDRAM
>> part in it (c.f. 3cbec0ad090f ("rockchip: add u-boot-tpl-v8.lds") which
>> claims "we don't have both SRAM and SDRAM in TPL" but we have SRAM
>> access in TPL, don't we?), but that has changed since 2024. They are a
>> bit different though and I have no experience with linker scripts so no
>> clue if it makes sense to merge them (if at all possible). I'm guessing
>> the additional asserts would make sense for everybody anyway.
> 
> Me too, almost no experience with linker scripts. Anyway, I had a quick look
> at arch/arm/cpu/armv8/u-boot-spl.lds for TPL building purpose, and IMO it's
> broken by design because of SPL specific configuration options dependencies:
> SPL_SEPARATE_BSS and SPL_RECOVER_DATA_SECTION. I will check more in depth.
> 

We can always migrate those to CONFIG_IS_ENABLED(SEPARATE_BSS), 
CONFIG_IS_ENABLED(RECOVER_DATA_SECTION), CONFIG_VAL(BSS_START_ADDR), 
CONFIG_VAL(BSS_MAX_SIZE), etc., if needed.

> BTW, the .sram MEMORY segment definition in the script would do the game: here
> the size that linker would check against TPL_MAX_SIZE includes BSS (consider
> the case SPL_SEPARATE_BSS not defined, of course), while u-boot-tpl-v8.lds
> checks size without BSS against TPL_MAX_SIZE.
> 

We would have the same behavior of size checking if we had 
TPL_SEPARATE_BSS enabled I believe. But if we had TPL_SEPARATE_BSS 
enabled, then we would have an .sdram section too, which is the reason 
for having a separate linker script in the first place.

I'm also not sure about IMAGE_TEXT_BASE (set by CONFIG_TEXT_BASE) only 
used in the armv8 linker script and the first

. = 0x00000000;

in Rockchip's TPL linker script.

But maybe we should really have BSS part of the size check.

I'm out of my depth here though, no clue what would be proper.

Cheers,
Quentin
