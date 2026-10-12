Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87770CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 471704059A;
	Mon, 12 Oct 2026 14:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhh9AoiiQA8N; Mon, 12 Oct 2026 14:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 232D24055F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791813641;
	b=WsXKNEKD6UIrz8vzUzBLi0dReUwoH80lNl2F4XXwzgnIP1DUkO8cStgdDBVviJlApCks
	 uVqIV48JD9IpHDDpnn28L6BqvFGwCJTtfZxTIy3jAN0s1wZguykBWMf5I8b9vu6cK6lSN
	 4+wPVPg/blyQi2QOAcnddAeock91ynAiqA1kDKf3nTnNo2O0LNm9tLQinUyJENPL3X7Po
	 OpDd/n68Wew6iMeM2CX5pxwXn8XKfxw/p0Ueu1d0TbWuLgMn70k65O8u6rvBYL10b/4np
	 Ojsz+NL9tQUstcrTpWo3E74uaR4flILx0wGZvH8tm51LdSFyp9cCQlhLQ4OpgUZAKPw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813641;
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
	bh=0OfdeMMDK0lr26mN100qNU7oqMt2ZZrijGJFvm6C/H4=;
	b=Q3ZJd0dzKjdqzMRZYsI3H3gPRhD5hPhq5TN+KH+qcOFvXi9ZSmpwMRjSlqDwbnx/0f1w
	 rgrMg8Rtu0N/ztYP0tNJUKyyntaXUs5/UzBx3g62Air96sks4wr0dcIIkSL3uB4GA95WX
	 eDpjKZ8DtwEqEUU7yydt2B6SNvh1WFd/gx6Ue8n4OIDOC2aHQHdassn/5h1uNiz23dhQH
	 ZAaz37S47EKVvoa2c9XJ9HrTWyDrpTOvgyrHr//pCTC9+hFWYVS0TXMosoh0eEPPqUGOZ
	 tAYOvOD5/EHxVNbNc7v4Kun+DEoOM4thVAlJHAyxBoAFaLqLsURoO0XOtoxdZlSocJA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813641;
	bh=0OfdeMMDK0lr26mN100qNU7oqMt2ZZrijGJFvm6C/H4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gRrthbS//FHen4/iIK5FYWYy3t4uedSQ3pei77zOfJgGcaVfn3wuNUnNhCd7VeRil
	 gAEAoK2NIGKL0a9qrbMHve/4cvy5byeYwsUvJJsTGzKlIWQBG9X35YT53Xc1NnbIEz
	 RQnMfz1pR6386XvQ5Sfecu/nwSVlEd8rpp4d/CcRagtEPKF2vA/EHghJFmDAcVT7V5
	 J3KCBOYxmAt4vd2H31X4dHfUnrqmq1CkmRW0UisaBWTpbho1t9tcVhPujf5A8Pn2fF
	 nNJ2DYd5fiyw5j+wZmR+5WiJjDJplHb9dRYuvK6NTj7Xx321hutU6b9I6kphqFOckW
	 DxVz51bksqVsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 232D24055F;
	Mon, 12 Oct 2026 14:00:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52533179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37CBB80DA5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:00:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJdrnEHojq4r for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:00:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB0FB80CDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813638;
 b=PdrIpVnnCNKCjjdT6jBuLfCj1YFJGPoTJQDlY2BLJQspjkzNApcSGUMz6OpHmhYEgXxZ
 2f8UT07lAl5QavzwQIDseRKuk25CpqnqkwQpoX2tdnd6g7CBl1Z9PsWTc17zgDiXAw9Ut
 6peKJBnCXcZdZFmPvcOYHMfbhIAJAMU0QVNT66nVhVtnEKQyKwxpm0fd5pvMBSQ8G1zM7
 AKvWEfJG73MISJKown2BheMI8WzAWf5NbyuztM+NNOej6NIOJpClPytvFOMnT0JWIl4I/
 +60kkW2I4oF5oe1L8WBUjVg16gFtZ73rb9nzD4K05H7AbvKBaFoJNakD5to5M5SWaFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813638;
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
 bh=0OfdeMMDK0lr26mN100qNU7oqMt2ZZrijGJFvm6C/H4=;
 b=cneqbyK/d1ENJ8cMNTNDD68xGgarc9r5ZIZLZnYweIuMTWDSJmYFV1ThrzSmxkXr3CGi
 XFcYjloBnPXIFTS2w1loqGxDrMMvuPezDU48K3UY9S96svMlHgdm2ZgnxbyBmNpRa6K1w
 O/Pr9NhPYjF5LvXaUEHHiGw2ifYOpkLi9Xn4odH+rEuZXb1ctY8+334ovry6fW2wQP0Jv
 c8LoCfoCPAEqrCQkM1NY92ftuyI+jgB51iY2/QUvnOg9HmRUANfq/fhOoFJ38W2AMCtUf
 hwE/1wq3byNUtSj+j6I0zDm2+Mu6nOVjKkm/Tc88IYnq7/yAzL3ecNwk9VaSwj/ja2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=snCvDbHN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=snCvDbHN
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB0FB80CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBk6SZ0o2JKKuviTilfRXY29SfHNale5/w/6yfX4q9wj7GApyZhLrUYMeF/JWVTkcf4kGeXyUsxg5FTpewk7MAWAGPepQfvAuN+CGFEXi52HhQEnp3/ggV46SFhr0sbBcy2I+JYJnrAQc3mnQaCYqawnKWQpbUZpKV0GTbLgpqGwV0+vIbvUcUYKlEZz4tDqgjF+vcktelPgsoOa6Jdv99McULPsjtabO6VKVYtgNnSGVtj9iT1aSEFzYoUrBGWTYFEOa3FVbtch/ZYdXuXDyn+tEh367avyIZHeFYEwjWywteE6sS7nmXcwM2J27Q1MDGellCeKH1KWTiUUDzQ0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OfdeMMDK0lr26mN100qNU7oqMt2ZZrijGJFvm6C/H4=;
 b=TvwhICi40S21F/BdJHZFn0kz6CYLjFTvzkpOlIqUle4H+tykBLIfF1wMOdVHqYTC+e4ZcmektJQvv6oeOzYaCkdZex31ODfVV66pSLQGejAj39sAqks2pqYiF++R1w6gf+gJT+w6fM3cmQWKs0oRwGvlzrrOj89PPrh9YfznXx4VE2gn3e2+LhgR6P2Ek/r/IQyaGLvHak5jBvpXIk7VCurz4iOrxmuFZD+lKm42XXlb4bPtoTd6GI1n0PbcJv+BbVfbr8Kez7/dykrymjYC49u/z/CC7fp4YpeK4zM2HBNRoK+bO1fnZ2LsvQltADEcWqafZW7M7w+2HmHXpZHmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OfdeMMDK0lr26mN100qNU7oqMt2ZZrijGJFvm6C/H4=;
 b=snCvDbHNCddtaYy8PTCMnr8CSKoOQ9Q5aG1TlmHP3A0BemiAWuEs0k+BeafOH7iq1X4x1jsfUtkXlXgOeYRhJWaHsUvWsSnmeUEmXLv2ykuZ2YCHqtcrSLzgu7Xq4DB3YyzYbcx8SQYlyvzzALZd5QyqGbG1rMxH5FP7A3VO8azAaFlMj2l5nTZF7KReCeJfJFZ/VIb5svrnvDZAydhd5IZB4Eg1MfLDK31P1/sGZNh5n/t1uGiiIPMbQhAH1KDEEQtWXEtfYvC/I2Lt1ciPP7pcc+YPNOxTOTHpbcCFdXbssdpTtgmKNoTrbX1lP/AdAFJqcZzkNeCqKjOIYaNrQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DSM1PF48E7BCB27.namprd03.prod.outlook.com (2603:10b6:f:fc02::549) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 14:00:33 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:00:33 +0000
Message-ID: <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
Date: Mon, 12 Oct 2026 19:30:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0074.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DSM1PF48E7BCB27:EE_
X-MS-Office365-Filtering-Correlation-Id: 37421011-5e87-4f8d-df41-08df28692e9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009223027099003|4143699003|11063799006|6133799003|56012099006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 45QoLsI1OnF1GjmgtanhJFXpGx8FwtG9KQReniUzONp/Wo8ZISM2m+G51sx0XCXCgKdGyzQ7QkA6eMJFgaY9HKOnNyt09DdI1I0ZYPRns+vAaZUfm6I2OPQyqyWvqyj/6dOl2sSMKv0s2cckJ1DwZyJTpS2ZeZdJcWKOYSbFKPExm74t6y4Jt8ttpg3WMlBJuSaM2npUxNersMpVi9x4qN2INezw7vGUxpdo9MylSNTrxJakMB3gzaCJD96bsBxLB6HpuGVbGuOc1CWG1eAPnbt3HG2GWfA2g8obGAfvP/DVaq83a7AIJUHxg599fdcEupeyrqhI2QF/GBsze3bhFIa4nI/v+tI5incGObyXSn7A1Pl6FWfHbNR/1HJjjfjSoHj2iBzo2FGCJDvWLpIOTob/jHp28ANaJ96njBMJi+hwuK6rddB3Y9UFvZDyKD2C/6aClJw6JjO66w8ru1nqejLzTmNpfyiRcUwg6ldypB6XKctUXuSOKlfkxxKhGSH5whJVqEyv6tV0QBJ0ngD6WbZ9UBtV+mkpj7aY8QT/26flRGcU0GO7JQER8xvT1pD9MxClzP/ClDUASxdrH5sKFZ1x8xG+RB5YuOyBALSzE4wBD26bgid5+kHw1DHhgtOZc6wqn2ZImGKLxM8KA7ricUB7Y2WYOP3hibuIgGUdTkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009223027099003)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU45Y1FtUy90eFBFTDZubDUxUlFvS1ArZlEzZDZ5V09FakFyRkFjUXZYVUNn?=
 =?utf-8?B?Qlo1bFp5N1ZCUk1sdGZNbnRURE5IeUhBNnBPSHJsM1hJSHFvbWdNZmYvalkw?=
 =?utf-8?B?WEhPNHNLMm4zT29ENytiNm4rTWUwcEpIVktNM0xyaHFXdjEyWGlXRE5VWk9o?=
 =?utf-8?B?Y2RXZFhJNHgrSnNGRzVjZzh6b3lXYW1wN3VhRnBlSERqTlo0ZG10Ym0zM0tq?=
 =?utf-8?B?cnlCTU9xQVlSY0RwamNHN0R2TzRvS3U0S0JnR1hSTjVQUVY4bGRWWHV0UjNF?=
 =?utf-8?B?aU5hckkyclNWN2JmVDFhSEpyY0kyak0vbXI3MVBkaVMraG9CWUQwM0ppekdm?=
 =?utf-8?B?d3hIUG43SWlQODVNVE5SOXVGQ0UxSXc3NlhYbld2bW0rYzgzWDZDMGJyZnV2?=
 =?utf-8?B?d2NuUi9Nc0JvNGdTTGx2RWFjUFc5TTBGTiszKytQczM1bGwvMTU3K1ZRRFhN?=
 =?utf-8?B?SHFXdDhoQldxWm1VNE5YdS9TdkdYMnVYeTcxQlloMXNqOHdQbWgzWWNOMFVw?=
 =?utf-8?B?YXRaeFR6Yk5vUm1TSkpDSmVWbUhsZGcrQVJaQXRsU05EZUYzWG5YYjEvZjRn?=
 =?utf-8?B?YWJIWVA5YWpFcGFnSzVLQ1NJWUd1TSswYTQ5cjZwcy9Eb2FqVFhLQzIzck5k?=
 =?utf-8?B?VlUweWpuSGpIV3Y4QVBhMklZTklRRzdPWUNWdVVXVWwxakt0clUxWTJ3akdX?=
 =?utf-8?B?SkNuM2RLVit3bmdmWGY2bXZOTW9pVC8xcHpCNmhTaEVta1BTL24rcEcvRnN3?=
 =?utf-8?B?bTNIekdDNG13SW1JN0pTeUtBUVFTNlRXM0NvRG5IMFFMelpqVVBpNmVNTjRC?=
 =?utf-8?B?KzJIYnFmUGlWMEhNaitVM08wbm42T0NBOWw4bEZ4QXUyR1NlemxrNndDQnRl?=
 =?utf-8?B?K05KRU1CK0tSOTUvZGFCbHNjQU1KYlA1K3pja1BxTTMySENQbVFIT1dLb1JS?=
 =?utf-8?B?RVlRcDZaemxVV0tYTEdxcnNrR3BmM3c5aEJNcS84OHJVbk8vUGtuNUJWc1Qz?=
 =?utf-8?B?UUxlNm12Y2hXby84cytZdEk3Wk5jMDdKRENBMkRyOVVFTHVTT2JqY1BBcjB4?=
 =?utf-8?B?cGtNQ2lqQnFzYVRXZmRQeGNDSEdPQmt4cmNlS216WGhwSE4zVnJrOUVoSjVX?=
 =?utf-8?B?dEtlLzB1akp0emlFMHl6VkE0S1BsdzZSNE04NjdGVk5PTk5hc1IxN1BabUtI?=
 =?utf-8?B?bWNGeG5mMjk5VlpKK1UvN0RiQzlnUXNMK2wxa3g0SlJHS3IwRHJQWGVlVE9Y?=
 =?utf-8?B?SDNEejFLQTJLM3crSHpidXBpbW1NTEhad2dmSkhmKzd5UGNqZVpTWFN5bHI1?=
 =?utf-8?B?cXlhdGxhUUNlZ1lHem12UWxXelllRkVyK3dISGMreUpxTkxUYlRHaVUyZVpx?=
 =?utf-8?B?Zml1V3c3VmVnWkF3YkNscXpvallZOGkvd3BzWW9JeVFPN0owbVBZakNSNGR0?=
 =?utf-8?B?Tml5eVBwY3ZUNWNzaTlCSzNidXFrME1sYnZ4ckpwZVJMcnNWM0NFUGp1eVZB?=
 =?utf-8?B?dEhPbzlOYkhybktDTFpXUU5DU1RROXlmNkIrUGFqbHIxdmowb0NURDJFVDNh?=
 =?utf-8?B?dHplZmduN0Y2S0tFT3hNb2J1bHdEdWpVSnZwdzhCeEJqbG1QaitCTFNKWURl?=
 =?utf-8?B?TG1LelBwWHVpSE5OdW5iYi83ckFpd3JiUGp5aFFDaHRQTzJrZ3RoM2s1NWxH?=
 =?utf-8?B?cnprYWVxSzVBTlpUa2FjeC80ZzdHYmZCVmdwTXhpS0VwWnJZNWx5S1JPeHF0?=
 =?utf-8?B?V3BDc3dTMi8xR2pPTklabEZvUzZhWDk1VWthU21CWklSek9vMHBxNEdCN2hh?=
 =?utf-8?B?Ym81VXZGcnpkTEIrdi90RmdUU3VMTHp4L1BjMDJqdW1uNlMyOWpEZzY1U21i?=
 =?utf-8?B?VlAwRVRrdUhFNlZGejBHbk80cmg1dllPQ3A1bUN4bkMydTRPSVNXYnhaNVB1?=
 =?utf-8?B?TnhJK1hZd25QU2t3cCsxUHZkZEhzcDNUK0xmY1h1bjJLRjJ1STlzdDJUNmFs?=
 =?utf-8?B?Q0lNTE0waFVsZDd2eVl3RHplQ0xHZHBqa1lrQ3lkY3JENzJkaWI1VTdjbFVG?=
 =?utf-8?B?cHRBM1pHNEJpei8rZzhJMS9kQUx4ZHhQaW9zblJPaU5ieERjRDNYTHJ1Ykts?=
 =?utf-8?B?ZjFGN2hDZ2RXcWp3Z05YZ21QdHphT2JJd2F1Y2x6Z1hoSW1wbC8vdFY3QW9Z?=
 =?utf-8?B?d2kxVDE4QXFXT3N5SDBIVDZ0LzV3UklBRDZmd3EyRjhXbjBRenNKODJ4RHNM?=
 =?utf-8?B?ODN1MnNXUURNdFZLYksxemkwWEVmWGwxdklUb3BEOXhSaTBrQUIrd05iREpE?=
 =?utf-8?B?TERnUVZUTXNYSXFyNFVGUitmeHZDaXg2aUNwclA1dmJsaFkrdW5WM0xUcTl2?=
 =?utf-8?Q?wl8QcSz+jcyNin9w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37421011-5e87-4f8d-df41-08df28692e9e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:00:32.9953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gv8E+Gsm9lA1sN5DdL/r6WkECpaEy572HTV3vBqFbSCUJE+8d8jZY8g0n7vmbBH1LauMoQ6UDXHw4N8HNnRWOm/8xNCvpxQecB27GgubR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF48E7BCB27
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


On 12-10-2026 18:45, Zixian Zeng wrote:
> On 2026/10/11 22:31, Kathpalia, Tanmay wrote:
>> Hi Zixian,
>>
>> Thanks for the logs.
>>
>> I hit the same pattern while testing the Cadence SD6HC driver.
>> Multi-block reads failed and single-block reads worked. On that board
>> the host and the card were in 1.8 V mode, but the I/O supply had been
>> left at 3.3 V. A short transfer got through; a longer one failed on the
>> data lines.
>> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
>> than the card delivers would show up in U-Boot proper as well. Your
>> SPL/proper split fits an electrical setup difference.
>>
>> The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
>> SD mode only): the controller detected 0 at the end-bit position of
>> read data on DAT, or of the write CRC status. That is a bad edge on
>> the data line during the transfer.
>>
>> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
>> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
>> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
>> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
>> 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
>> only after a UHS switch. mmc1_cfg is power-source 3300, and
>> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
>>
>> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
>> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
>> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
>> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
>> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
>> that succeeds.
>>
>> CONFIG_SPL_PINCTRL is not set either. The driver calls
>> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
>> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
>> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
>> SD_HS, which is that state.
>>
>> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
>> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
>> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
>> succeed, this is the F3 failure.
>>
>> Regards,
>> Tanmay
>
> Hi Tanmay,
>
> Your diagnosis was right - it is the I/O voltage.
> Enabling CONFIG_SPL_MMC_IO_VOLTAGE makes
> the multi-block read work on the Banana Pi-F3:
>
> Based on previous commit, I patched the following changes:
>
> diff --git a/configs/spacemit_k1_defconfig 
> b/configs/spacemit_k1_defconfig
> index 9c15d96eae2..f5c717e5965 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -95,6 +95,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SPACEMIT=y
>  CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
>  CONFIG_MMC_HS200_SUPPORT=y
>  CONFIG_MMC_HS400_SUPPORT=y
>  CONFIG_MMC_HS400_ES_SUPPORT=y
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index 23c655c6def..58374c482b3 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -251,6 +251,10 @@ static void spacemit_sdhci_set_voltage(struct 
> sdhci_host *host)
>                         bool ok;
>                         int voltage_mv = to_180 ? 1800000 : 3300000;
>
> +                       printf("sdhci: voltage signal_voltage=%u 
> vqmmc=%s -> %dmV\n",
> +                              mmc->signal_voltage,
> +                              mmc->vqmmc_supply ? 
> mmc->vqmmc_supply->name : "none",
> +                              voltage_mv);
>                         if (spacemit_sdhci_set_vqmmc_voltage(mmc, 
> voltage_mv))
>                                 return;
>                         if (!IS_SD(mmc))
> @@ -274,7 +278,8 @@ static void spacemit_sdhci_set_voltage(struct 
> sdhci_host *host)
>                         break;
>                 }
>                 default:
> -                       /* No signal voltage switch required */
> +                       printf("sdhci: voltage signal_voltage=%u -> no 
> switch\n",
> +                              mmc->signal_voltage);
>                         return;
>                 }
>         }
>
> Booting logs as follows:
>
> U-Boot SPL 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
> Fail to detect board:-2
> vdd_core, value:900000
> vdd_1v8, value:1800000
> vdd_1v8_mmc, value:1800000
> DDR firmware: [0xc081d880]:0xf0227179, size:0x8d98
> DDR is ready
> No SPI controller (-19)
> Trying to boot from MMC2
> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
> max_clk=204800000
> sdhci: voltage signal_voltage=0 -> no switch
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef 
> cmd23_host=1 scr0=2358043 cmd23_card=1
> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
> mmc: multi-blk blkcnt=1956 clk=50000000 mode=2 width=4 caps=300207ef 
> cmd23_host=1 scr0=2358043 cmd23_card=1
> sdhci: multi cmd18 arg=1000 blks=1956 blksz=512 mode=32 dma=0
>
> <debug_uart>
>
>
> U-Boot 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
>
> DRAM:  4 GiB
> Core:  338 devices, 22 uclasses, devicetree: separate
> MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
> max_clk=204800000
> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
> max_clk=204800000
> mmc@d4280000: 1, mmc@d4281000: 0
> Loading Environment from nowhere... OK
> In:    serial@d4017000
> Out:   serial@d4017000
> Err:   serial@d4017000
> Net:   No ethernet found.
> =>
>
> With the voltage corrected, a single 1956 block PIO CMD18 loads
> the whole FIT,so the controller is fine with the FIFO back pressure,
> the slow SPL drain was a symptom, not the cause :-).
>
> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> "sdhci: voltage signal_voltage=0 -> no switch".
> Since mmc_set_signWith the voltage corrected, a single 1956 block PIO 
> CMD18 loads
> the whole FIT,so the controller is fine with the FIFO back pressure,
> the slow SPL drain was a symptom, not the cause :-).
>
> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> "sdhci: voltage signal_voltage=0 -> no switch".
> Since mmc_set_signal_voltage() is a stub in SPL, so mmc->signal_voltage
> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> "no switch required" path, and aldo1 stayed at the initial 1800000 that
> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is 
> what hid it.
>
> On the pinctrl side I had already run the SPL with standalone
> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> mmc1_uhs_cfg plus their pin groups. I confirmed that
> pinctrl_select_state() return successfully. The multi-block read still
> failed the same way with the rail at 1.8V.
>
> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> in pmic_init() may need to be modified.
>
> Thanks for your suggestions and guidance.
>
> Best regards,
> Zixianal_voltage() is a stub in SPL, so mmc->signal_voltage
> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> "no switch required" path, and aldo1 stayed at the initial 1800000 that
> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed 
> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is 
> what hid it.
>
> On the pinctrl side I had already run the SPL with standalone
> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> mmc1_uhs_cfg plus their pin groups. I confirmed that
> pinctrl_select_state() return successfully. The multi-block read still
> failed the same way with the rail at 1.8V.
>
> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> in pmic_init() may need to be modified.
>
> Thanks for your suggestions and guidance.
>
>

Hi Zixian,

Thank you for the quick testing and for posting detailed results. Your
patience with the suggested tests helped us reach the root cause
within two days.

With CONFIG_SPL_MMC_IO_VOLTAGE enabled, aldo1 is changed from its
initial 1.8 V to 3.3 V and both the 32-block and 1956-block reads
succeed.

I am still unsure why set_vdd_mmc() initializes this rail to 1.8 V.
Since we do not know the original hardware requirement, any change to
that default should be reviewed by the code owner.

I suggest enabling both CONFIG_SPL_MMC_IO_VOLTAGE and
CONFIG_SPL_PINCTRL. The former fixes the voltage issue, while the
latter ensures SPL applies the defined MMC pad configuration instead
of relying on the Boot ROM state.

Dave, I hope you are aligned with the changes discussed and tested.
Could you please post a new version incorporating them?

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Regards,
Tanmay

