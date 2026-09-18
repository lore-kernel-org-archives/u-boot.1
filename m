Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5AFC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 05:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E47F60BC6;
	Fri, 18 Sep 2026 05:50:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-6-5xEVk-Db; Fri, 18 Sep 2026 05:50:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A0E7260BB7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789710622;
	b=fSGTv06J4lNj8xUlqzW+eeGBAG6wTXe98vQoKPYNts4aBgtfKfDnUxGOCXLxOi6nk82w
	 yVjwiZStRQ+kXFOX6kSIZG5wkOjQ4wW0pfp8nKbh6ro882oMYy1a+j5Ir6eslJJ2BdgUe
	 5MeCuqyKCFA/N6LgmDMjz/vAlyJ8pp6COnRcCJzEo8mjhIQz/MNxHBOzTr0cqADa3EL9T
	 0dSPKi0xWbndgqWIgn0vJuyM3TIbEVAgBtGtLaIlCwoW+R+CVtosYANcTo9chskSLBpFB
	 FSY9FNK9KjxoUkP/uP8jPq9RLwySu3gsR+I3Fkr8QI8NSUBDSYHgcTLs67KXdKcRPBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789710622;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=gir4cEFE1LF1XyP7Fc/T7BzAl7c7/6IqfMUywErFPHs=;
	b=SP7hWDB2biyHFcee/JqqQWDALz4fD4lQncYu2ifuhdSzaaXkYEJq2HoWuPgeo1cx+3sz
	 zWggh+RwHjiUuXodpf8g8j5HGR6R4/PxDASwe2edocmNjOotGafkoyKycMLk82PZLmSlX
	 YtPLT7XyDlXjjPN8yI/opppPQxe1Ei5CybXYzWL0AadfGalsxChx8OHif3UiQPs9atksi
	 BcvUO2SJ98eSD85kBGXlmY3+SjBG7l5rBUkIce5Rf8s+LQSMlCpRhxf35mCzBmlFwfs+b
	 rMKSuBXtO0Vy5JRAZedkTvzaECjPZGB+9xLkCTJmnjGlNw0Fc+QxWb5RgfXAMTeBKCg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789710622;
	bh=gir4cEFE1LF1XyP7Fc/T7BzAl7c7/6IqfMUywErFPHs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dh1hcOWkhZQgykXe3cUJnrUHb6W0tGLQ2Ql+RAytRU1GejRn8W0E/GOzemy47Fmrv
	 C6tKCINM+31AXx9KTJ2yfErDJSOuLTEUmgq9p1Dkdw18xHtzownDsWjtmYizd5TMNK
	 ZGqzHnoPWeOPsGmg7+bFxLZGK429rUUTTebG+cTbejPCgLWLkpPWdlJDKHAK8Q3YhA
	 tmt+bk2EUzYqg3Mj4cXk38EBsASestw/IFmfXSs8fY4l5HFeUxn/4rEmpiagTKbiX1
	 YC3EhaEAVi9+46ukuYrM768lwfKRTjweTsGK+u9pR2o3OcjgDrxP+HF1KCVa+jA7el
	 IchWcgGlk/kKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0E7260BB7;
	Fri, 18 Sep 2026 05:50:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01CA33B6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E731C811B4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FZtBnZI5gHWg for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 05:50:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 44AD6811AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789710621;
 b=RvwOcUJC4ScldOlKALSKnhssxCAA8UrtNCzSnLHQBwso0lDCqXUtxjIQHvCESq/205Gn
 4k+JYk8pJASe7/o8xmpDPUpaWA+SKTJ+4snrG9gqHRVj6Z6m+6wTXRtkVeKWvD2Sok/ex
 D/ehJOmQXb2mxWp2VKT/CryMbOB113pSjntB1EjPS7C/x9sZh4cunPFXdNU4xh99gxxtL
 hDNqFaLgTEmy80lNOYUrWT9z2CyqVmSr3uCku2r1FbtRwoX0BEB0TxpxSW537fNdRvV1+
 iwKIFBcgQ8any+OrnGSvk9hhkL8UFuvRwF5MErIb7nBy1QXIkIlvWmwdu98IK7/XOUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789710621;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=gir4cEFE1LF1XyP7Fc/T7BzAl7c7/6IqfMUywErFPHs=;
 b=ZQ9/1UQqo2K7YzmAjKw6V71c6wr+R3lkssG8E8FePOrtUzVsIUYKkWqs9bDJuXp/HFML
 3p2fpMf1/hckMEB/AnaVzE0mj29uRA1Cj3AgxmvZQ+9wE1DrYhbFhXzZqTOgza4w9JDrp
 2RseQumAA4LyrmOr2IWKLMvp4lraD414PNVk/Qjk2EQ2kzQiesSZylhO6+mq/5RsTzHGw
 gQRLWjrJA3lH8fxq+n0mY2oc3XOpUzcXVTA/sZeByhm7Tl9z5kWZfServQUAZCuVHaChu
 Mbjv2WyJpUOsJDml+SfUeFyIJj2fmk03dJ76otMgAh2dUDUK+4oBtfmjDvJ9980arag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Q+YcKjh7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Q+YcKjh7
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44AD6811AC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMJwp5ilLbFNk9L0Xd+BeHy8LRuLu/9Y0wqY26kD6H4PoaGsrDP2TJL3wqvmlfAikLIJc7Ozm9qDQZfVkLvL7IA3udG55SLhtRX1kyeuojPyMmp9KPjd8OpfZ3ZK1SRME9uCkkbOvOcbRSAcL4k7d05TLDJdJFm/xdbRu49Xx9kbuKiiyUFS4lpZmM2hZEol31dHb3YBrp1pwQ3KJltYlMSyY5B374Cf24d57J/FWZcDRz+BzQMfCJnuZPj6VZzJ5RjaHrIK/idlrHNxgvYDa0UwGSjAkzQXYolzZDU4tYeswS6wT6JMauQE4UpqsuS0RpF9iHJQdSA5C9VJk/hooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gir4cEFE1LF1XyP7Fc/T7BzAl7c7/6IqfMUywErFPHs=;
 b=zKUJ7qFaVPl1TmTHsnMyOGeKtrukGqSXoDX2EmItf1V/Re0S2V1uGLPQ1h5WGVKlTVgkoGw9fXDGcAsPv7ZCaAgJ0cqqfCqiCNl/Cc4GSvLpyYPzhvnaOBN1r3+xguvOscN1QdqxeHxKAB0OGLDfYe4B2QF1ZA8Cr1Kyof5FFO2PlqywBiaZVj9Hss+xUTcsmkALQm/JPaShcP5rvYG+xPGmQrteT0QDM6C22wEq1Co+r/arceVOCZhS3CQpmosBEkJ98PPMSQRZqSR9zX4oBuzjJvuLfBFsmp3NLrGFlLq3iN/4a3Ud9T2xGq14TRWbaQUkMCzhdU3U+BCmy5IHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gir4cEFE1LF1XyP7Fc/T7BzAl7c7/6IqfMUywErFPHs=;
 b=Q+YcKjh7XUQUO4Ib8VrbxmQXNC0lnu3s/o7sFqoK73HIZdQO1bpT+ycUd3iXrerJo+Q3y0gJePkhWkwSl/UofZoypbGbBLt5Rf+KAXw/uFK1UOD/qS6BRcLO6epa7pJdBHwRZzYnnGiXSiIzE0jC0/7uVw8mv/1Ua5XMEQLx84vJPvwgCk9Hl5E5GJlCLMY0kXm1qLqkhkiQTiJOWGSSVp3hXK06L+I3ZacLDvoky2VmR6fqIGwt/VGDAkEgSrR9An0iMU9KMVhYzZ0w1qvjAHQqEdeEuh/3ZwEtWUkWW+DU3HcTaFAUBVmJcxiFtcWqrMV/5qTXbPXwj/zv4oeYYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by SA1PR03MB6594.namprd03.prod.outlook.com (2603:10b6:806:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 05:50:15 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 05:50:15 +0000
Message-ID: <9f2963f6-8a3b-4ea1-a9cd-41cf8fd6f345@altera.com>
Date: Fri, 18 Sep 2026 13:50:07 +0800
User-Agent: Mozilla Thunderbird
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH v2] arm: dts: socfpga: Add MDK support with external GPIO
 expander
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Tze Yee Ng <tze.yee.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
References: <20260609014817.16401-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
In-Reply-To: <20260609014817.16401-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|SA1PR03MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c427d68-2d42-42e2-7ea8-08df1548b663
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|55112099003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1GaKgYFc9AU7MNpluCYexm4ETmDHjsqRURuQJbV1+AYeoT/tYsECdxgKw2nwaFn9f79M1Cmqv39B1XV9RtEyV4f60sDW3rYVkY+PtoVm84QK66zQf8iVQ1WLpib3XeHzyBBKZdFC2GnATMLJkve7VQW7fREiIWRzCEVU+ooNHvRCPSouR159GfydslhAbEHXjBvIBjjP/ap8mAD7lN4kStpZZOmdHnF4kbXWgFyMRXmykEyv4SLA2n4GwCvxqkgXnm9lHByjTOOlwrUL7xRFWNgqke6dtTGxL254pp+fyVWbNNacoypPWY/diaHHkQow8OhxFiPJUdLHEQCGv6+Nslgx9FAUMHG8aYxr7/KfCZegCVf4bSBUJAUg5Gq19Ww8oLTQbKyCDSS+N82EOP3hjt+ETlGFeeIjN84KxbuGox9pvF5azRpSC7dx6FLPWLNq2OmVpG1TDLq4OB5PNr/TJGzNgBUrl+l1+oeIftrK0ofDOHrbhhkpWSVtu/BteAXsJS+KpvVUitVOGT72HAdPJKJhNEq1fZ0HoPtKknn0X8oujmqzfsmgnBf3NkviboSwZ39hYquj5OMnku80nBsZKn9S4C2UzHakhziRAdA7rS5IoKMfMrhDgCpM8YzRS/WCy7E/iwoKaFrj6QoS6rePtlcNWDx9zE3pVQRF1ByH0hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(55112099003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWI4NHl5TkNYL0tsaWNGdjI4TVJNSUQ4T015OS9ZL3BpVUhqVVpLSCtRWDFF?=
 =?utf-8?B?cHMwbDNjdVR3T05mK2lGdTdVWkV6bnNnc0R6L3dFRmhJaGkvUGxiWk1pcHRJ?=
 =?utf-8?B?NkpiWjlhWXZBUlVYNTY2WEdPVkZzOG1LWmpKSHMzWERXalRSUDA2bUc4ZUhB?=
 =?utf-8?B?WVE5NmhsNGdUWFZMcFgrai8zckE2UEpwbzl5Y2lHTVZDTldmS1F5d01IRjNv?=
 =?utf-8?B?cUFzb3JwNUJmQzBrU1A1akRsaXNDYWIwVVc0K3JRczJrYlBQbTdzMzR4T2Ux?=
 =?utf-8?B?N0w2bENZUVI1b1pTLzN5bEJhNlFteTB5ZStpemlOZXd2cU5Td0EzTzBUc3VP?=
 =?utf-8?B?RTFRbkd4aFJpVDhBM3FoL2Z6L0JnM29uL2o3LzRETGdJOEZuWHd4MmZOeTBX?=
 =?utf-8?B?dXAySjlCU0YyS3hwNFBrdVJmblNoTCt0QUJUMlNmTCtjeXc0dnF3YVRYcjk0?=
 =?utf-8?B?OU02TFdxZDk0N2R2elE0cmd6Mkx4Z2dPL0JyTS84M0lsNGozWGJ1dHAzakx0?=
 =?utf-8?B?YWdvNTAxZFgxaGJ5RGQ0ckg1MmlGOEJ5ZFlkVmRzUFpNMXZVOWZ2Q3ZUSFYx?=
 =?utf-8?B?SFphRUFtaysrVFhrQ29mV2lJYUhkM2ZzbWUzcTdscXhydEVqR25Na296MGo5?=
 =?utf-8?B?UHZwTEUwT1pObEYrNXZkcVJEU25GdDk0dUF2c21IeTQwZzRIcFNpRWpUaEU0?=
 =?utf-8?B?dnNCdVN2RFlvNjdZcmJ4U0o1S0V3ZU44Q3BJejEvSnFwak54Y2VKcmMvMDUr?=
 =?utf-8?B?anZLNFV1TUVndyt4WXVqeVNHL3ZkbXNNejh2dDNLMFRqK1hGWEM1RWphbCtU?=
 =?utf-8?B?YUUwZ1czOFBjWVlrd3FKZnpuTnJySjBQMCtUT3ZodmRZaFFOZVJuUEtpaC9X?=
 =?utf-8?B?WWVMZmFlZk13Q0tGMHo5eUw3em1DT2grY0k2cGNEZzhMRUpBeWNTVEpBZHpX?=
 =?utf-8?B?SVJRR2JXbEFMaGh4eHNWN2dqa0tmNUJDYk9ub0o4YldlK0Nsb3dCMzRYUnkz?=
 =?utf-8?B?YXZHeDA3c2RVazdmdFhHeXNPRmFvekVlTkg5YXFQS21icmZyL3VXdGE2SjRt?=
 =?utf-8?B?SWR3ajBCSUhhTE1uOUN3Z2FrQUF5ZnA4WndBbEY5Q09hZUdJTUNYY2VUNDcz?=
 =?utf-8?B?YzI4ZU5IaDFZQzBVK1JRc3YxamU3OVYyelJuc3E5djR4c2R5aVpUcEZwQ0Jw?=
 =?utf-8?B?YkRYSmpLK1YzWkpMWXhMenpVUk9TdllUSGx1ckkvSHBqczBSRUs2WnBCNDdX?=
 =?utf-8?B?TXFMazJPekhJczc3a1FjaVRNT0dNNzk1VHJ6emdUaE05MU53TFdZU2ZwRWFq?=
 =?utf-8?B?akd1NDd2aEZLM2pvMXJNajBMQkdrZU5raG5lVE9xQm9kZUhienpqS2lIQUF3?=
 =?utf-8?B?RTZKWmVpcEV4dyszdnRBMUtHWVFsQUVzRWpjQ0EzdzAxaFNNdEp5b0ppZ01Q?=
 =?utf-8?B?SUtFOWRIZUhzdFZXYjdSU25iZHlwSk5FRTlOdUkwVDBPV3hkVi82L2Z6M1ZU?=
 =?utf-8?B?RTQwRWJlSGhtaVJESHZZRGxqa3MxQTJjc3ErckVTOGQ1Z1BMci96N0krazZw?=
 =?utf-8?B?aWhpQS9TajVibjVLWVN5bFlVVWNTVGowQVRiTXQ0QXJJRENZa1BsS1JqV1Vu?=
 =?utf-8?B?dXhSOFJUelE1VXBRQ05iWEdrcVNIMWFXNXdqaXR0Ulh0bC9vTlI3dFJXSlA4?=
 =?utf-8?B?Q3dLU1B3ejAvYXRvTk5sVTR1ck5zRU04U0hKOUtDMkx1YmhmUGRNOUNLZGxn?=
 =?utf-8?B?VGJidE5QalVMWWFvSm5YTm8wb2wzeUwwamZ6ODdHaGw5VGNDYmphV3huZERE?=
 =?utf-8?B?Znl0ckl6VWRaa1NuMDFqQ3RBYnZ0R0VOakorOXRzby8ya1BMckhsMitIMFNN?=
 =?utf-8?B?WU42VmdYY3VHc2xNWSs4c0hGeGVUWjNHZnVwb3AwL3ZaQ0JucmoxMHRESFcw?=
 =?utf-8?B?NVplL1YxZGMyVE5SYjlXd2hNTFhWOEtOcW9IaTNkMWhmcHdIVnBJZWJqSzQ0?=
 =?utf-8?B?WmFJYUNlSVBkakRIWEdKMWZqeGJHQithSjJud1RaeGZmdUlZSHZpT1FiY1kv?=
 =?utf-8?B?UVh3UHAzdXA0WGFxMTZ3MmlGQi9Pak1XVzlYdGxLUlQ0clRHbnhFemZiajRi?=
 =?utf-8?B?a1dSV0NoWk5iQjJYMDRZM2xqQnhhT3pqRGZUWENwb0toZXNDb1RyTWk2Y1J2?=
 =?utf-8?B?NEFvMHRsdS93d3h2MWo0M3QvbGNaWnVNUUE2M1JTblhzaWpSOHZmNUFLazQz?=
 =?utf-8?B?dFVZVzBJL21PRURwcWlFeUhSaGEzQ21BRExyZ1Q3eDJuNUFYN2FVZEpHNklK?=
 =?utf-8?B?V08xWHZFVDJaenhQeDJCMjJpZjdSYVEwRXd3MFVtVjh4cm9lZ3JmWVVtc2VY?=
 =?utf-8?Q?ZF5x9RaCB9RKodP8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c427d68-2d42-42e2-7ea8-08df1548b663
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:50:15.4457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg91wWlUR1UXHYCJML7OGQqrGVqdxx2iyWMYo2IrWPsHU4sAlDIxG0CWoLlgpG4bOZBBFR5qt4S04swNlR/wtqyCpQKKbAIlW6+s7UQZZrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6594
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

Hi Alif,

On Tue, 09 Jun 2026 09:48:17 +0800, alif.zakuan.yuslaimi@altera.com wrote:

> +&mmc {
> +	status = "okay";
> +
> +	no-mmc;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&sd_emmc_power>;
> +	vqmmc-supply = <&sd_io_1v8_reg>;
> +	max-frequency = <200000000>;
> +	sdhci-caps = <0x00000000 0x0000c800>;

Please also add the Premium SoCDK UHS capability flags next to
cap-sd-highspeed, matching socfpga_agilex5_socdk-u-boot.dtsi:

	sd-uhs-sdr50;
	sd-uhs-sdr104;
	sdhci-caps-mask = <0x00002000 0x0000ff00>;

The Cadence PHY timing properties alone do not advertise UHS modes to
the MMC stack. Without these, MDK will not match the Premium UHS path
despite the commit claiming the same SD timing / UHS-I support. Please
re-test SD UHS on MDK after the change.


> +#include "socfpga_agilex5_socdk.dts"
> +
> +&i2c3 {

Please override the board model in the leaf DTS. As written it still
inherits "SoCFPGA Agilex5 SoCDK" from the Premium include, which is
confusing for UART/boot triage. Something like:

/ {
	model = "SoCFPGA Agilex5 Modular DevKit";
};


> New files added:
> - socfpga_agilex5_socdk_modular.dts: Main device tree for modular board
> - socfpga_agilex5_socdk_modular-u-boot.dtsi: U-Boot specific additions
> - configs/socfpga_agilex5_modular_defconfig: Modular board configuration

checkpatch warns that new files may need a MAINTAINERS update. If the
existing Agilex5 SoCDK wildcards already cover these paths, a short note
in the cover is enough; otherwise please add F: entries.

Please send a v3 with the UHS flags(and preferably the model string) 
addressed.

Best regards,
Tien Fong
