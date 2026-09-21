Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB34BC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54AD280DBD;
	Mon, 21 Sep 2026 18:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auxFc9HdOBMN; Mon, 21 Sep 2026 18:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6976580DB4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016976;
	b=h/kKCFmgPQ01U5JQ2Pn+211+oJ8rw/CJcXz6XIzPK+Jt0f/EcfNAU6/tRShYVX6zZbrI
	 z+AePhtDe16b4LOhBUO734posWsefKAJVZUEr+DQqUmC6TiUH9x0/07FWnKwEJOxy4hXP
	 8WsmQ98x19FR68RavC/6YT/06FIL0ZShGYqwUS3VqHxdBWayk/b+EFKYxUAkkSTtKN5Ya
	 zB/woVSKK2nLmobl3yM+ZpTZk2jsH/p6xyzetOy1utYyyIXoUs193snDu0qETwNYCPXub
	 lxK0cqvdULoOSpS95rGPS1cODdM/SXy9UcyP21crXyjQhT9J0rjepYSz11uwhpa4zZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o3W5L8az1v0b1TKOLftXdF+bSiQ7lswlBgSyp4eYZgg=;
	b=QeOJtm4qSsX9nXSLTsFvx+k++jalkpjt97KCxsuI9i0KFyOvQHTXlMMA86zDnTIlnbW8
	 nRPi3qkdbwTlGdU9rt+YObZQbXC6YT/ivEj3GNXrLFzkPZAS6VxH16KLOKPPbRpzK7wHB
	 xxBaRjGL9cQn8RhlA9Vcjei5lnugBJuO8t0egWS/W3+/wluDFwLvJHn2Sjg2uIyARFuC1
	 TV4kyoHERnoXtTfZI8s2c8GQiuc2DAJRl04GQE855Btn8wA4sl3JJD+DTYeWD3PG9I2XE
	 A+jWEisIp7pPgTVpinXdrTXbW8+Fcdxtk3rhzYiSG0swZ5jLpILobcsZFQ0yEu9Fjvw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016976;
	bh=o3W5L8az1v0b1TKOLftXdF+bSiQ7lswlBgSyp4eYZgg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cF8qGSNYIZswbMdrNHhoR4xwG9yZyTCjF3DOyrh05aivvnKGMUG9Ld+E58MDql8ib
	 HXgB4Fiv5gHZXp8NBW1XR1DIajg3T8SvIxricRo+T3g7ZPV5q0/AphWNM/rXivUafK
	 VDYBTUcRBhLZiKEoyN8XuAAfgyaQS/qCalltgBeB5aA19LQRkiYpl3JTjRAjby6AM9
	 1I/aEizEjOEiAg9BRcsbRZLXP7viVEZ+ZUXTg1pNIVigNzTfZTnfzJ5ED3CZ41A0Pt
	 5+0VOekmrnpGdFlDB0dWLM8cym7U9M4V0FI84UfD+THB13VwOuP7IOW2mlB05HV+WP
	 /Cx/3ktqXXF3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6976580DB4;
	Mon, 21 Sep 2026 18:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B4E134F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 417DC400D2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pWUUR2IvIP7 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EBE11401DF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016973;
 b=bV9NLYvwQCS7GZdcBbgCgmqBvUdw2a2IIVEqDkXuHZp5ffFwFZ3nnN7IWcl1oaX4SksT
 XQb/UYO/XManXAxA/k3vkCasfRhwz82jcL4pTZAxKy1UTqa6M+hodgU+zHjH/Y30YFUxP
 3HRjIaCIxSNZt++G722ll8PNNpodoT1qSc6gXh8hMqQSyr56qNVgmgbVnPgbpubcdMQnO
 pDUT+7cH3btPebC5qnj+3HIH9bfmi6bAQD9gOBqmEhP//I3+a72PXN/FkzclU2XI71M6X
 vpw/wJqxIHDAwTvi/yoTm+DCAxkgSPKnWBHQj2ZEBycM5X0IUImIQBHMf3qi+AEGAiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016973;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=o3W5L8az1v0b1TKOLftXdF+bSiQ7lswlBgSyp4eYZgg=;
 b=EVlBqO4MmgKUBEQLT2Q4LD9xoUkeXUK3pWBoE8c3yS0ZftB9iKDuqCvalFjZoOdRBuLq
 z+DY5EzYoYWGeiJsBMhVq+F/NrYTiuXvk7o2JK2MKlHDhwYwyfMzn8IC/h36+6XFMdd+f
 V7DTwkb15bhY+RbZtCwMXvgUg3r7X/ALaEGu5+SasZ7GlbLQ9xYCXWJG4Ud5ZJ0NOEjP4
 gOvOQX8FvDoNdbHpWcHaAJERZ9D/9wP6UO9JRbC8l7mbEjP+KYJiiLa23T9Imix0NW5hr
 4GKChoW66g5Ib76xewEaPK/nRUB/mDDGFapUp5h/wyDJpozu/lzJ/C5mLdlHp/JomCw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OZZUzgpC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OZZUzgpC
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBE11401DF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBaXVWlOdwyV5eAOVIYDRQ/QASgdxfqkEkS6MpCEtwCw2aqIuPiNrCU8TTPzbLjI9mvF8gEXGX+CQkyccdhN4ipKMlNbYkhMlO0xTlGnuBuuYwSlrKzoNBssJGM/VzfmyBmENRTztnG9+vICl82CfgqKIWv1TYQSO/09pOs7gcA+7IRB0a0rC+5kPmj+rbp74XdcxnQjsrIpKGIO7kpn1HTI/WmT7dMv5T04L8gpZqqf5fVzhM0KgUtBJCrZSpqCPvfp0ilD6CR0YeX/g7Cxu1QsF0krHwPr2sOy5FPLCBeEHESCZsJGRLuQuyu7417Qov/Z4zh2Ywu2TybYN2Crdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3W5L8az1v0b1TKOLftXdF+bSiQ7lswlBgSyp4eYZgg=;
 b=TzRPl0lUh4Seu3KM4l/vd+rMVKnag+f7UGITe/d1bqvIB2Oxf44ftQHou9QXdjpfsUxBDhnIVUXJe93cTg4scPPgqjGhoqhvmatqYGncyj/bScMARNQnK1GMMRdByH5ih5J97NUTbhe/WAOXBkAFlF6JVM+ZB+j7fPdGUHaDegnXeJz7SJP4aCydVilIKfO592tNdin/uhSbs/6BTXCT23DnOKZh1w+U46xpuc7SHN9Ko4oabW9mVYAKFNlMTxyD/I7xX/vW3f3yQPG5vzwFmaw94MJFaoJDrGRmYP79oxGjNFVQBpZZOaFEgMXhjKU6w7uB2mBxuUVt0kxQnS/LSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3W5L8az1v0b1TKOLftXdF+bSiQ7lswlBgSyp4eYZgg=;
 b=OZZUzgpCUJPHa1qsWZLktCmCxslmJizJmnVb/Mit8TYWNJWlKfuWA1n0zKr/KpruT1kMYbgyfxVRyDGs/ipylzgdbLszZDYtgHZ71mhKwYyEVPJ599Q/FDEqiQXzWETRhMu5hy/L+bb3VArwwOUODzVGR56DtMnxy4C1a5WLOKw=
Received: from SJ0PR13CA0090.namprd13.prod.outlook.com (2603:10b6:a03:2c4::35)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 18:56:05 +0000
Received: from SJ1PEPF000037A4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::99) by SJ0PR13CA0090.outlook.office365.com
 (2603:10b6:a03:2c4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Mon,
 21 Sep 2026 18:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A4.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:56:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:56:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:56:03 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:56:01 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] spi: cadence_qspi: propagate mux-select failure instead
 of only logging it
Date: Tue, 22 Sep 2026 00:24:13 +0530
Message-ID: <20260921185430.3491195-5-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A4:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: e56e9f9d-ea8a-4099-9eb6-08df1811fd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|11063799006|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yXJgWlsVewSLz/H3IEMoRIZ6+BTBKJ//078OZ1SlR3+6/f1KJ9TD5467uqDi/CotXN/ZeoBsni3kxORYneR645dFgExsT+/Cu9t33DdeOcGeB6EBOxHhQrUfBMFwF6lRG6j6lFgWo+NoYl7U+/Ir8Xwy1GbXCwxNiR2xTZyQbhM6MW7Y+z5r7EoiDax8jr22VJtl02f3KBCQIq6fwgFAufA7h2KDsWzYHpwaEKI7Gb+VfrEPfiKnDoDk0XrvkjbXvcusFcdWhZ/zlCAWNBQPUbJLe5Z5hFBvn4Cf5PihtXNF6CHxAlRn6QWORfWLQujCL80WMid+ORWAiZnuym2KnrrxNCEcq2l/NY+oN/bJMNbSq/3YKKnLi2LD7e3QwdlpTdddkqqp0kTkdUOcjnHYqD3nm9ujMmwmPw/+ufUhXyrDwtCyznvieOscC4DKLc7aJzfXr631O1avmQs/8JbmsI1RgoJv4I7eu9OcGXuOJci0WROMnP3lroNW1fT/dsNn/G0skUHq8qKijCJAZaH8q0XivzjiY1M5UvTE1pv2Y3OllcB1tgP5aPyk6GdjmZHK37acS4+1PgrVctbLRNBYqyuf58OlUfqFPnhdDI/l3gxzib/MDXGuZOzojUbfCctjW0Blm+xJ8R32FJgJzNouD6tnt9kR6ii9M0VCt1dVqCXrdX3M9v0mwbKogANB6EuUSaJ4CO/YanlP7kCVFNCAzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MjP8GLPLN6O/JMLA/hiKKKyEWbMAhDoXb5YMaa4JqVaIM07fJEN7exymRQW5VLPk7/sHtuqLsnFLMy5mSucmhG1MjUJQgkR9YPH3m428AHKSHal3fp7XDvzcvIZEB+iydZ6dAk8Tn2HGWp5oFQSfLkbJRmkIlhKWNS/LuFeyTsVpmuFqZy4hoqkAP4s7XQrSXuiBQFWMmOuMSUmeu1HYXpcUR4ho/gNxSJ08KtIN0qg70ZwEM3BUeYpJ0QlY3gV7IfP2Nl++E82SK+F2Msf1kkdLzEzqroOqBj6pzshVdpvOfZxd1MIhGARne6RS4sWXf5Ne4aTol+1+AkuinXqfCEQgNhsH3ADsaBHBWvLtiaOSz9tek0qUegguvaBIuCTtAV9DhLHv0kHymnLFMSexI98SiVUKa4lgOE0FGivHwUBcx8iU4FhcDLZ34f81N7kr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:56:04.9610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56e9f9d-ea8a-4099-9eb6-08df1811fd2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

Change cadence_qspi_apb_enable_linear_mode() to return int and
propagate the mux-select failure instead of only logging it, since
continuing in the wrong AHB read/DMA mode should not be a silent
fallback. This also updates the weak default and its two generic call
sites in cadence_qspi_apb.c - every reference to this function is
confined to cadence_qspi.h, cadence_qspi_apb.c, and
cadence_ospi_versal.c, so the signature change stays within the
Cadence QSPI driver and touches no other vendor's code.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 drivers/spi/cadence_ospi_versal.c |  9 +++++++--
 drivers/spi/cadence_qspi.h        |  2 +-
 drivers/spi/cadence_qspi_apb.c    | 15 +++++++++++----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 602a7f4884c..6c388ab8208 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -39,7 +39,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			clrbits_le32(priv->regbase + CQSPI_REG_CONFIG,
 				     CQSPI_REG_CONFIG_DIRECT);
 
-		cadence_qspi_apb_enable_linear_mode(false);
+		ret = cadence_qspi_apb_enable_linear_mode(false);
+		if (ret)
+			return ret;
+
 		reg = readl(priv->regbase + CQSPI_REG_CONFIG);
 		reg |= CQSPI_REG_CONFIG_ENBL_DMA;
 		writel(reg, priv->regbase + CQSPI_REG_CONFIG);
@@ -198,7 +201,7 @@ int cadence_qspi_flash_reset(struct udevice *dev)
 }
 #endif
 
-void cadence_qspi_apb_enable_linear_mode(bool enable)
+int cadence_qspi_apb_enable_linear_mode(bool enable)
 {
 	int ret;
 
@@ -206,6 +209,8 @@ void cadence_qspi_apb_enable_linear_mode(bool enable)
 	ret = zynqmp_pm_ospi_enable_linear_mode(enable);
 	if (ret)
 		printf("%s: failed to select OSPI mux mode: %d\n", __func__, ret);
+
+	return ret;
 }
 
 int cadence_device_reset(struct udevice *bus)
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index f8716aa8c7d..6a8f9c58e4e 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -316,7 +316,7 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
 int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
-void cadence_qspi_apb_enable_linear_mode(bool enable);
+int cadence_qspi_apb_enable_linear_mode(bool enable);
 int zynqmp_pm_ospi_init(void);
 int cadence_device_reset(struct udevice *dev);
 int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 0d4bc685f5d..dbfb7c1f592 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -37,9 +37,9 @@
 #include <malloc.h>
 #include "cadence_qspi.h"
 
-__weak void cadence_qspi_apb_enable_linear_mode(bool enable)
+__weak int cadence_qspi_apb_enable_linear_mode(bool enable)
 {
-	return;
+	return 0;
 }
 
 void cadence_qspi_apb_controller_enable(void *reg_base)
@@ -770,8 +770,11 @@ int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
 	u64 from = op->addr.val;
 	void *buf = op->data.buf.in;
 	size_t len = op->data.nbytes;
+	int ret;
 
-	cadence_qspi_apb_enable_linear_mode(true);
+	ret = cadence_qspi_apb_enable_linear_mode(true);
+	if (ret)
+		return ret;
 
 	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
 		if (len < 256 ||
@@ -944,6 +947,7 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	u32 to = op->addr.val;
 	const void *buf = op->data.buf.out;
 	size_t len = op->data.nbytes;
+	int ret;
 
 	/*
 	 * Some flashes like the Cypress Semper flash expect a dummy 4-byte
@@ -953,7 +957,10 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	 * mode. So, we can not use direct mode when in DTR mode for writing
 	 * data.
 	 */
-	cadence_qspi_apb_enable_linear_mode(true);
+	ret = cadence_qspi_apb_enable_linear_mode(true);
+	if (ret)
+		return ret;
+
 	if (!priv->dtr && priv->use_dac_mode && (to + len < priv->ahbsize)) {
 		memcpy_toio(priv->ahbbase + to, buf, len);
 		if (!cadence_qspi_wait_idle(priv->regbase))
-- 
2.25.1

