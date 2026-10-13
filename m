Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D81CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC0974052B;
	Tue, 13 Oct 2026 14:42:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsKMpqdvK2Wp; Tue, 13 Oct 2026 14:42:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B73944051D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791902526;
	b=NiEsmnCBDldzc7617MQya9VXOBeQrjEjQ1RFAQ8xJfIPo+DuZmlVCWsPJXbctSYsHGjf
	 GKJt66llsSkDgT74U+3uBtVUUV7M5i4FEE8qQilWe4L7tKwib6HqpCaR2Ar290roZd2Al
	 TnkViRm3Ph+G2BzQuD7RL1SYjgIoUJOME3B1GuOUHD3FgX3ZcMfc3aS7xnSSizS8ibCBo
	 Hes/PMQIR1UkQXl/l/Cb47EK+/5AtOihdikBX6a4rnTnsiiIuy/uFtO0q3ZAAiqK4JTwv
	 3Vl1IgaYrcha0W2Wm21SsEjL9RQhfLFqjqGpbfruwZnR+Xk12x+flIuebr9sQ7OKDIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791902526;
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
	bh=EWpCYhf/XJ09YpNKrze00cNcpmNXPJKNy90s/vig9RE=;
	b=SVtgtXgFWh60+9dWyTQeyCyjUheow3IMrRZrnnX2MuERp4WeImvfZQZgdmtBm0qH867N
	 tpmRGRIARKIX142Fxhw/FSmDbS/3kw/MBhXz3niSMwsltrmgPAXjmX0RXk+4vbNRngIpq
	 2Ub4W21tDFVtbPGEN7nvgRlH4tBWQS5Y/kqOcCFmq4SXj0GM6rF1B9NX1RQ72Y7sukhPT
	 AALRX0l8oOCeCTCZQoea4XMuXDZxIawDy5rBTJxkncvO69op+viXKQgM8vLiYa5gUdtuV
	 dp5L8vfJojysXSW/NJnZsl2pHvmc10Qa3Hp404x13YWFV7iZd8htXhQH9cE1jWxIuTw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791902526;
	bh=EWpCYhf/XJ09YpNKrze00cNcpmNXPJKNy90s/vig9RE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JKimsOZFqmwUtIMpK4PA4tiC0gRxW7GN6kMMY5UAprT4K7e0WKnqX3WVIeKa6ooFf
	 UaVD2iIibUff2/NYaXLpenYzvMFpWraexkC2zdbDQG2BD6/5Qv5IqYKmvKO4u40T1m
	 xIhRGhvYGYlr/Mg3z40Zv7sGxhf5ACjkc0BJ+3kJMcfCKL0JG4oAzjf/BsOLmEoVgv
	 99wdkPv1vTZ1b7qs5GUVlF92upkdLJQ76OS6zWYilJKIQ85B8LOwig7PMpttsO88RP
	 cKxlT/ALBHD5bF70owavU8/PaqS80HjeLoqKI2goT/D4+0c6sJ7DbEwM96JS/C+dA4
	 JapFSUo3QK81Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B73944051D;
	Tue, 13 Oct 2026 14:42:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04A6B235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA3DE80A56
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcaMpyCqQlxE for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A209809EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791902524;
 b=GzzKzRzAnuGs8CE/rs3qJlMWHqopqjThKQ9p+JrDQpWOatOjC0whc5RZK2KY10bN2fKw
 rNMb/v9NkyINz6IWeL1SNuBLejSW23od11uHym3f+tdw+tObVpK5UogoeiMdiEukLxpRK
 6BD7k8Iox7CHfY+PNlvs/EM1Es7NXWoWdua4fOhZMVx7nBJuYtG22dpyxMdPUsGfW+ptm
 dXByk/3efCfq27rYq2CW+qVw7CHb+SBSIeY1x2Utai0rkMoeqvc5VfrIgg1g6JnJ64M8/
 P2S2D1SDBhEdm5fIUZ+LBoujdK9RPX/NvoJkt07FY8xmq541fRmgy6flAdJmRwBxlTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791902524;
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
 bh=EWpCYhf/XJ09YpNKrze00cNcpmNXPJKNy90s/vig9RE=;
 b=F80YCSP5TRzsQdhKYPOvNK/i5k1WIsMkOqKhcBB6e74lfp6j8a+QcCusk/FyxDjWEyU9
 GAWOPSpsUY0wvKN2T5Ej4khqf9oVpFxo6/V0PLzY9vTP/hoRRpkHir0m/4UD9Bm4Qc0kr
 esHAgIeMzDGyMhKW0/NyBMEgfORQcUtRIL022Yf0Yq2d2GchvLTY4Zry/B+YEvScWgv3Z
 QCKcWCbFbIngCCuSTRwTShbWvyK0IkiPeYEgfUmpkpAzNl+UcxAqo1PAyl3OWwr1JiGNX
 YkVxgfb+WQPOE4opye2VVkL9xg+BmKIe/QuDsr5eYC4jMP/fX9M/2CQAxFGClBJwYTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=n7k8YbC0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=n7k8YbC0
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A209809EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vh4TroOqTDCWTNrR7T1+OYXm0CMnl/EV1D97KFg9N6LxQGAdtyczanQUc968RTRBgfgED5JCmwM5KKJuV06mjkT3OlQ9+4BQAwiM4DLqkQHZde/4qJpOZ5F9K72mbQW2XIFmDp5CbeNmpd8k1MDmYXIlRxXwLRbIdsRxTPA8T7etYg2fwxq9WAcmTCD2XJRI39WqZJ6OcLz+n++fVK0Dc002/rYxgh4qnb1gBHRRWStTNl0M0/X/h+/6u+T3whrNtpwfLoHqNa1p/LgBtnJKvAHtc/9ZiTnP1WujQOI8WplZAKoE1bPiyE7cVrYWfSXIqRprmukbRQQft3ITnmgL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWpCYhf/XJ09YpNKrze00cNcpmNXPJKNy90s/vig9RE=;
 b=p7rHEIB4Uo48DiaryNmq7DhwgflBJVt8OKJoy12ojPkE/8rYg9JyozRcyh+R8dKdhZKHAzC3ncBqtEfJx5foiD7KlRZ46aVOXXgLShiUdgMVckKWV7SmUILMop2L7NEA2FuXKOn+la9gXEQpsl9xJk0FA/5nJfXFsbF4SeWttuZJsyVBMHcqJizgk1Zi8BuhzJdevzbM3Ok7QeFRnGuYkw/wS8IexvhfxGAfyhOmVMhCuXYCc6q9srtgVxI46NKMVgN74Rs65p0+OXluAJi/NKd8jVU3twmzzcpz7A8+ZTzeUU0IjHlfBCBmmOLS4MeZ/Nx054MtQpAmNcp4DmT8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWpCYhf/XJ09YpNKrze00cNcpmNXPJKNy90s/vig9RE=;
 b=n7k8YbC07aiCEFK1WsuINsqTqSUTqewbKHkHMZl+6tDEiBtWLv+xKfkiNiCg3Dade0a3Ac5H567SPMb7S93X8SmOZxz/yE07GuUOP+7/WwxL/KLViDNbJ/8skK/3MszU7tByUZQf38RA6Re2EUhLKeGCk+5cGsqco1GPFsCIgpn60BD0j8vXu1mh7f74oJfOHtYGL58AYYAJHII9gOANCjMAhtsT3iFsFyIGXfS8MlwuGfFBPBss4isHDxeYXKJyhwfqmKjHvfxZNSlfF1nqdlq9GgdLzJUcIHnwXoPjEuKszaCPQLJ5UX5SGNB+liBzTjkadc91V2LBwEkJN3vvhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by BY5PR03MB5219.namprd03.prod.outlook.com (2603:10b6:a03:221::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 14:41:55 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:41:55 +0000
Message-ID: <7d72598a-0124-4406-8696-bccfde1971d3@altera.com>
Date: Tue, 13 Oct 2026 22:41:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: socfpga: Add QSPI support for Cyclone 5
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Chin-Liang See <clsee@altera.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260817073322.26993-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260817073322.26993-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|BY5PR03MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f9b23b-6cea-4c7e-0f76-08df29382083
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Win85u+fflq+mi1B2TogKnmXzAc9tb2ZLpkhYsSKuQYm6G5IO1FvQwYsapJK+ekBKEYHwIPf2Y84Edw6mwdfQ4/z8EF4z9ngByN39zjW4jzxIzF+OwelJtQHrx1URRNuv29o0elQSVltrX+uvXCXAeFGv2NKC5UQiGKJNmwr3xUDv5ATT8YQ9hUa5mi/Z1QGzIQpAwlqcl5uQY1+o2JLXtkfS/vX4gPLLKHCwRSHx8TOj/ggFCHODOgG8dGXjlHAdbzjtLaxO1nswJDx/pbgCX+5WKIcG7IeuyhC1g+v+zIhp9Mt8mE4a7vtT0fyEsPitIeL9IhH4LaOD3Znk+ghVVsnY1nk1RfzJ2+pyTwfFuMjOVcSNh0WL3TxbdxdinotQ1Ks9B8ELBRBS3SleYy0UAHXd5IKdE8RtU40E1CNORrD36tgTve89eC4xAG5UECL8mWwvlEbyonykbkg1uLtowIETKiggHIPp3Q9u//BSQ37qDCItyHU9hxTPoGd+/XPbbYIkQJvJRewxS96RGSSCTrtfGXusBmb84Giascns1wa04t5K6/IDiNXmwIddpKy0FASmz4qiu2HXWBotozgXnN3pAb+/PUOTwgplYSQOLfdN7WLeYeeaqnw4j5Pe6LQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJGelRlQmlCVEFYbWFsb25GZUhqbjVRVUZ0TW1hUkhNTTkvSldTd09zU1Y0?=
 =?utf-8?B?U3o1eWZnZ2lxUzRCVVMwMi9kalhUWTVrZlZ4U0s0MkFTY2NiTytPRWtiUTdJ?=
 =?utf-8?B?ZmxWYkt1RDROd1JyeGJpL0N5eDdFVjQvMEdqRlRoZzhVVkxMSjlHanhlWTJL?=
 =?utf-8?B?dG1lNkFQcGc3NnpEcmY2NUE4bXlOcFlNYTlpdWVBa3BiOGxYUDUvVGpZYkNK?=
 =?utf-8?B?VWc3dlgrc00wYmRvdUhVZXBZZFZpcUxXYzFLVGN6MFRGbTR0d2FpVm1zbDJo?=
 =?utf-8?B?T29MOEtPWXpNQVk3UEh1ZEVuQzRZVGlPZkhvckxWSFE1N2NQSElhSEJDYjB2?=
 =?utf-8?B?NHdmRTYwVEprbTBpdFNmODZyb1VlT2NoSXNiNFd6MXM3a3VWdFlVOHVBN3RV?=
 =?utf-8?B?ZjgzaDhwTnNpejVIdTh4Z2JCUUtPNGdkemtObUVQLzdHN2ZDeC93Q0tTQmNU?=
 =?utf-8?B?NHFjMm0rc0ttRVg4OWE5MVlvekI5MWlZNnZtTGVVZW9zODRnOW5wY29TZFdr?=
 =?utf-8?B?eDBRY0wwbS82eTJ3clE0OU0vQkdWamFXVE83U2Y3cW1XY1VoTk5rdE5YZDdt?=
 =?utf-8?B?aFVxSjRlMWsrL2tNT3VwbytkdWRlMkZOT3RRRnIvOS8rYXhDaHNTZFJGRTV5?=
 =?utf-8?B?dFBJZnN6RnFET1NSNURZMFZHOFprSVEyekN0blhVbktENDVZcGI3Mi9UMlhE?=
 =?utf-8?B?NDJSQ3Y3d2pSZ0o1eGFiLzBiTU5RS2tsdVpEcC82d1dXbWMwRE0zZ3BLTDZs?=
 =?utf-8?B?cEhNUG43NlNwYzdqYmpLNnRUTzhLdkZobDFNc1ljQTR1ODdZVkUwNzRYVXBx?=
 =?utf-8?B?YnE0alQwOC9yeEhuWWZ1dllFLzl4cnZhUm1RQm5RWlYwVTRlRkRMN0dwOVJx?=
 =?utf-8?B?UVB6NnBGYm9jZUt3QXZoQXRTbjkvR2pHcmpjYmZuTHFhWUJXcEk2aHhiSXRJ?=
 =?utf-8?B?RW5rV2dORjhWZ2JOaVh6bWlCbnNieXhXV3c3WitZNTVPMy9HK3doZlMzR2o2?=
 =?utf-8?B?dVdONXlnOERQNitMQmdTU0Z2TlFnZGhvODVtNW5HZnFlSTZidVVOdXF3OUcx?=
 =?utf-8?B?dnpSYXFuTzZVUE9QSDlUSjdzV2xhQVdKUkpqMk9QZUxDd2czT0l3dUpSUVdo?=
 =?utf-8?B?RXBsS1EwS2diTWRXSmxUeGpHdk9QemM4K2JDSDZtb28wTHhxdzhDTUpFbDFn?=
 =?utf-8?B?ZUhRTFlDdjhjR0VYSUpmdTg2YXp3NC9kbW5XSi8yVG9tYkVrRmZCaE8wZ0o0?=
 =?utf-8?B?SGJ3Tm5nTFROMUNFSy95MGFoOFJsVDJhdVJjQUdkcnIyV2hyWWN4S1AvclJ0?=
 =?utf-8?B?ZFQvbjB6SUtnaXM4eTFqb0hhZ0ZXMU9aMGcyM0NDUEVDbm11ak1EVmhXczFL?=
 =?utf-8?B?WHMxNUNFaVJ4bS9qZDV4dlp1MWdlVnlhVnVjQytGK0xSaitzT0hxazQraG1K?=
 =?utf-8?B?VEU4L0JWSkRTOG9mRHVJYWVwUTc0WDdJam8yNWV5bGZtK29rQitRdDNYaldv?=
 =?utf-8?B?cERGeXJMZk5uWkpmRTQzUnNCRDRLN20zNlpkcEs5TEJ3dkxJSlE3amErUm95?=
 =?utf-8?B?UDFkeWh3NWtSVlVJRnloQU5SSiswVG5SRFZ6L1VHSUVjL29NRXZSQnhyMjVJ?=
 =?utf-8?B?UUsxY0kvVUpWdFMyL0pVck5Bb2ZOS21sdWhJRDFtNHhxU0VhUVkyRzF5NFV6?=
 =?utf-8?B?ZStjT1RMTVI0SkZzYzRZRkNWQThpRmtpTldUeThPMUQvVDE5R1c5NHlxckh0?=
 =?utf-8?B?ekNSb1QrNlh2eTQxZS9qV0hZZHB1U0x5blpTSkZsaklESmhuOWZHNU00L0Q2?=
 =?utf-8?B?ZWdaL3lPeittdkxlWUpDSitRZHk3VmoxVGdybjhKdTkramRUY2dnZm9JK0xx?=
 =?utf-8?B?empFRTJqdHJkL2FPL2ZYZkppNy8xMnZhaTBMYTh4NzBoSWdNRXFPaXRyZnBJ?=
 =?utf-8?B?eXFLZlNuS1dvV1IrRmE4VGhDWFZTNnVrdFR0WFdFYWtTaXdLQ28ya2VHYm1K?=
 =?utf-8?B?bGozS0ZKRGhxWGNYTWp4L3F2Y01yZUl0bnhIU01Zczc3dHRWeVo2NzA4bDVY?=
 =?utf-8?B?QlorOUxtNzhTVUVYUVppbXdURUx3SmZ0SHZPZkI1TGJHYUJXK2xCS1BJS3lV?=
 =?utf-8?B?d01rTC92U0t5cTBKWENSUC96Y1FCOGlVWENyelN3TWlJK3hUVmwzQnQ3ZmdK?=
 =?utf-8?B?S1NKRjF6R2p3L3owOHRsa0xHZjIwN3RCUG9FN1Z5cWF3aWozSTZLZGduUVhY?=
 =?utf-8?B?MnFpTFFKUExNZHhtcElaY2dUVTFjV2Q4U01CLzAvMnVwMnN3R2JiOVBxZ0d1?=
 =?utf-8?B?S09STXZpaktmdk9Jb0lqL21YNU1UVTlLWXBaQ1pJUFJqcDh0U003dz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f9b23b-6cea-4c7e-0f76-08df29382083
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:41:55.1493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z16yfF/3OcXXMIjrkaWQFBvfRMV/zaKDvNaRABQ1ZKdz9iaPCw8Olhh+siQ8b4yTXk3LAUeXA5CUGt3FWWf7+Uv+aBF2312NvZw6TNEQ+cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5219
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

On 17/8/2026 3:33 pm, Boon Khai Ng wrote:
> Add QSPI boot support to boot target devices list.
> Platform can provide their own boot settings through
> SOCFPGA_BOOT_SETTINGS macro if needed.
>
> Add SOCFPGA_BOOT_SETTINGS for Cyclone 5.
>
> Guard QSPI boot-target integration with a new Kconfig option,
> SOCFPGA_DISTRO_BOOT_QSPI, so that only boards which actually define
> qspiload/qspiboot get "qspi" appended to boot_targets. Without this,
> any SoCFPGA board enabling CONFIG_CMD_SF (e.g. Arria V, DE10, SoCKit)
> for an unrelated SPI flash use-case would also pick up bootcmd_qspi
> and could fail during distro autoboot
>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
> v2:
> - Fix commit message typo: OCFPGA_BOOT_SETTINGS -> SOCFPGA_BOOT_SETTINGS.
> - Add new Kconfig option SOCFPGA_DISTRO_BOOT_QSPI, depends on CMD_SF,
>    default y only for TARGET_SOCFPGA_CYCLONE5_SOCDK, so QSPI is only
>    added to boot_targets on boards that opt in and provide
>    qspiload/qspiboot. Per review comment from Tien Fong.
>
> v1: https://patchwork.ozlabs.org/project/uboot/patch/20260318104018.2261-1-boon.khai.ng@altera.com/
> - Added QSPI to BOOT_TARGET_DEVICES unconditionally whenever
>    CONFIG_CMD_SF is enabled, plus bootcmd_qspi/qspiload/qspiboot
>    helper commands.
> - Added SOCFPGA_BOOT_SETTINGS definition for Cyclone 5 SoCDK (fdt_size,
>    kernel_size, qspi_fdt_addr, qspi_kernel_addr, qspiboot, qspiload) so
>    the board can boot kernel + FDT from QSPI flash.
> ---
>   arch/arm/mach-socfpga/Kconfig            | 12 ++++++++++++
>   include/configs/socfpga_common.h         | 18 ++++++++++++++++++
>   include/configs/socfpga_cyclone5_socdk.h | 18 ++++++++++++++++++
>   3 files changed, 48 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index a9b639a5ed9..56aac117c1b 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -22,6 +22,18 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
>   	bool "Allow non-FIT VAB signed images"
>   	depends on SOCFPGA_SECURE_VAB_AUTH
>   
> +config SOCFPGA_DISTRO_BOOT_QSPI
> +	bool "Append QSPI to distro boot targets (boot_targets)"
> +	depends on CMD_SF
> +	default y if TARGET_SOCFPGA_CYCLONE5_SOCDK
> +	help
> +	  When enabled, socfpga_common.h adds QSPI to the distro boot
> +	  device list and defines bootcmd_qspi (run qspiload; run
> +	  qspiboot). The board header must supply qspiload and qspiboot
> +	  in the default environment (for example via
> +	  SOCFPGA_BOOT_SETTINGS). Disable on boards that enable CMD_SF
> +	  for a small SPI flash or a layout incompatible with that flow.
> +
>   config SPL_SIZE_LIMIT
>   	default 0x10000 if ARCH_SOCFPGA_GEN5
>   
> diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
> index 36d6bfb3d03..910cd2648f7 100644
> --- a/include/configs/socfpga_common.h
> +++ b/include/configs/socfpga_common.h
> @@ -137,11 +137,28 @@
>   #define BOOT_TARGET_DEVICES_MMC(func)
>   #endif
>   
> +#if IS_ENABLED(CONFIG_CMD_SF) && IS_ENABLED(CONFIG_SOCFPGA_DISTRO_BOOT_QSPI)
> +#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)
> +#else
> +#define BOOT_TARGET_DEVICES_QSPI(func)
> +#endif
> +
> +#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
> +	"bootcmd_qspi=run qspiload; run qspiboot\0"
> +
> +#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
> +	"qspi "
> +
>   #define BOOT_TARGET_DEVICES(func) \
>   	BOOT_TARGET_DEVICES_MMC(func) \
> +	BOOT_TARGET_DEVICES_QSPI(func) \
>   	BOOT_TARGET_DEVICES_PXE(func) \
>   	BOOT_TARGET_DEVICES_DHCP(func)
>   
> +#ifndef SOCFPGA_BOOT_SETTINGS
> +#define SOCFPGA_BOOT_SETTINGS
> +#endif
> +
>   #include <config_distro_bootcmd.h>
>   
>   #ifndef CFG_EXTRA_ENV_SETTINGS
> @@ -154,6 +171,7 @@
>   	"pxefile_addr_r=0x02200000\0" \
>   	"ramdisk_addr_r=0x02300000\0" \
>   	"socfpga_legacy_reset_compat=1\0" \
> +	SOCFPGA_BOOT_SETTINGS \
>   	BOOTENV
>   
>   #endif
> diff --git a/include/configs/socfpga_cyclone5_socdk.h b/include/configs/socfpga_cyclone5_socdk.h
> index c23ba2325b8..3ebb7b18020 100644
> --- a/include/configs/socfpga_cyclone5_socdk.h
> +++ b/include/configs/socfpga_cyclone5_socdk.h
> @@ -10,6 +10,24 @@
>   /* Memory configurations */
>   #define PHYS_SDRAM_1_SIZE		0x40000000	/* 1GiB on SoCDK */
>   
> +/* QSPI boot */
> +#define FDT_SIZE		__stringify(0x00010000)
> +#define KERNEL_SIZE		__stringify(0x005d0000)
> +#define QSPI_FDT_ADDR		__stringify(0x00220000)
> +#define QSPI_KERNEL_ADDR	__stringify(0x00230000)
> +
> +#define SOCFPGA_BOOT_SETTINGS \
> +	"fdt_size=" FDT_SIZE "\0" \
> +	"kernel_size=" KERNEL_SIZE "\0" \
> +	"qspi_fdt_addr=" QSPI_FDT_ADDR "\0" \
> +	"qspi_kernel_addr=" QSPI_KERNEL_ADDR "\0" \
> +	"qspiboot=setenv bootargs earlycon " \
> +		"root=/dev/mtdblock1 rw rootfstype=jffs2; " \
> +		"bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
> +	"qspiload=sf probe; " \
> +		"sf read ${kernel_addr_r} ${qspi_kernel_addr} ${kernel_size}; " \
> +		"sf read ${fdt_addr_r} ${qspi_fdt_addr} ${fdt_size}\0"
> +
>   /* The rest of the configuration is shared */
>   #include <configs/socfpga_common.h>
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

