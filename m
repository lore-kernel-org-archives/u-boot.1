Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAF606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=itwQGAky;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rvsbIwzr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41947405C4;
	Wed, 28 Oct 2026 11:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4g9kqROJdto; Wed, 28 Oct 2026 11:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B4AD405B3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185940;
	b=eYl/ML+S3oC6mpupHU8aHb3zLgUyGNu/q+e1slwTPNeuNV/l2OgpVoYyKv2YvZxwtUQk
	 OQVdT2vD1U8qPlrUP0feZRnXDgHpoTsfU4tqbFgfpKbHKvSXpLrGHWDZyhlxEsNiPe8Mx
	 NC6b7xpV7wBci9IQ55TroovRUsoroaBLIhIqQJfrDP1U8Mp6QNzNWO0FNXZc7/XvqFsY+
	 ttuL9wsVTyLVMLuyO7WanYJq4nU/sAwkwofi6wE8tfSPfnBUk4b0X8l9KlLxtvB+4Iy9Q
	 MT5AWcgBaAxClxtGyChjOWSsdIW729RqOdY7mvKz/p+iCuPNJaJB/baQKlZT8s3lGew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185940;
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
	bh=5InSbN+ZpIgiUlloGpc4CnfH5bD4U8tKh2J47l/gXUI=;
	b=HqR28+vSUeO1MNnaSV5HbYQw0xC2Qb1mlVbxGPBrz+q+pMrt8wFY9Umnzmup9XnoLxJY
	 EGjJO4lmcss/R4p0tdqmHIpVFv5zD9EGsJIFTymE8fQbz3FgOv18u5zq1gLbOC4M4pROC
	 RABTAOPolxLFrPnHpdLupz4P2EkTZxDaDz3Vc+7deZRqEIuKtF2BS8Zz7mdlEEffWn84o
	 /sRtlFJcb/wQA3sR/VXqczU2bekrdR/2J8G6sjFbWiCZtGt4CoBXMV1XVS3gRe9AAuhP3
	 jJhc+fPiN2BJMFKJNsAW1PScj3HmiiaMlUKuu1U/bm2+wQTPEnPjqrkTtC6UbeaG8nw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rvsbIwzr;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185940;
	bh=5InSbN+ZpIgiUlloGpc4CnfH5bD4U8tKh2J47l/gXUI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=itwQGAky7l1cmdzp94P0NUVp9C5YWsDaCURY7ODYcVL3/fAtQ6Vss5kK00Osc6HMr
	 XfcUyLqbo7BE05nyxAlcwoPgdfs8SEpNNhQItdTT67FZCBFh9K+XxWUsxZZGH4f8dp
	 1P/SQaL2oS3MuoeGUBhYVjjhkrmXsYCmoRRMK4Vf+NXnJ1TP2apNA4bXIq0hsFFqHj
	 bsdsQ8KrnTHwIHr8bYrW2XENvZUxnq0PWma6T/gTBPcmVZcJ6vjmAT6P3PsTKLgwik
	 +mRcbM/PFRMDm+vtwK2Rg+sKhPAIXmWQk3Ow7mdo4nx6JpktkCC57bDsmoqm9vF4t7
	 gRzGhn73JO7rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B4AD405B3;
	Wed, 28 Oct 2026 11:12:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85B7A1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BD6C405AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VazAzsjY72Cl for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:12:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05CBE405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185937;
 b=IX9mmr2ECIcTFOwczGL29KgirUowGzNODkIQwq/MbLC1nF39ydfch+c88xnDhNjLmd83
 nQKylzcYWsJhzODXTq7k5pazXjUDrXSRdO2u1IYKSHJLupxgko373ZviCg0GFgzxYkmYF
 HQ/uFllYAedDhr0J4gwgb/UHkbN+fkaYidtpb5a0F2yfqB2hXNYr9JeBOxWutD0s34QhX
 1Rc7S+sV0BlS38KHFxvegecebA8B5eoClAm3YKLq+X1Q7c8+EbCMEQFyPhkuE/FEahDxg
 3pi6riSGTwLqb7OM4BEov5tqGF02p+TflPh9+94fFIP/sMFlR65EoCyuYh15/U14JxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185937;
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
 bh=5InSbN+ZpIgiUlloGpc4CnfH5bD4U8tKh2J47l/gXUI=;
 b=m6Z+xMp4Eqc0snuxET3r0YFFvQD+gn2R7LDGo6J0j5gxV3OT7BrGKQr1UkXSfpBYdvru
 op4WMKO1GDyHq4lM/Jof0sU3vCJ/AsJC4V/kFsZ1OSBezHMqYnO/ki5Au8WAbX1EGhU/g
 6uep6X4FfE0cSNRQj6emYDR31jmqNID+6tUb4G2agLjPWv9U8vMbnNalLf0/Rtx1UUi7C
 Uc7v3IHZUkbK18BtJ+JuURB/CEGkYcxSKVRgJpebno4NzgYpVGi8N9XTa7RqXbyHF3H22
 ZwB/mLVyHrcKWwXOkNu8UTZhAMRz10hOp7dPf6aIS5YIhVjpLGYfLyDzyUGxAIEhHAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rvsbIwzr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rvsbIwzr
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05CBE405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpRKy0yb4hB/FGVA13nWA/QHFjwoL41RPffbCZt0RKQpd3nmUw/JM5h79c3GU/yQ0YMXJNcQzOO6mmS2IcSyNlehqEB9hytx4+b8CuT20Dvxkd+iFDbKQ5mpFak2TDdSNfegwuCSUAZIW8z+Qby+FgBKNZZLFBRxKfFxiPhNHuHhTAbLnOAhwTj9Tr3F3kP5z9J/teRhglMQ4FYa7pIdHjkJQPs+uANt/mZmzeDuaMvIgYY9UR+mLa1AAQgid0AsJSPUQ1rv4FIYv3M/AFPviStIrzTj0h/tSZO1f4ls8zs4DvxHQGD3TeXPjhpbbmH2yuYRICQnFURXBL74aF6h2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5InSbN+ZpIgiUlloGpc4CnfH5bD4U8tKh2J47l/gXUI=;
 b=PjSaoZy96LL8X7Dm7IJ/KiDwowGZ8HszSx/bOAq8zHkJ63ofbosCXgPhEXRIwdsjeA6ArCBocy9Rxogdoiq/4aD7tvBN0v/zEWQpAcNyhsbEaTA+VCyy7/6DLWBL1Dkrc85oNWxHET+7mXfry48hIG7xWKDARqeqFlp9a+tPt64JcOf6y562/GLDeZ7B3VBEvw1pOwfGmTNN2i+T+YRLvHrKZIbHPvKdv3wUQQyY4o7GG1HMeEeFiIPhIHCXutYxd78jMuQTeM03tC15OESxesZwE0dU2DVyNj6GK8wBG8QcLJPD+9p8szF9Yn8/4zmg9ssOjNyt74ubYjVGgFOjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5InSbN+ZpIgiUlloGpc4CnfH5bD4U8tKh2J47l/gXUI=;
 b=rvsbIwzrpUF8gUjUrq4YL/AAhNUqSq2pVrRiSglX8P1FWCXeW8A1o9n60evnuPTdKC2/MZzCDtzjQqr3Z4exZxWlb4DS0zaRU+cDxWXRD/7TBDF57CbQ8di9ulKDTDY9FWymDkFSRCCSbBW/Gd3h1K3Y/LebVzfR0FAFfhD/K6M=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by PH6PR12MB354726.namprd12.prod.outlook.com (2603:10b6:510:3f7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:12:10 +0000
Received: from CH2PEPF000166C6.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::8a) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 28 Oct 2026 11:12:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C6.mail.protection.outlook.com (10.167.244.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:01 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:11:59 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Tom Rini
 <trini@konsulko.com>, Akshay Belsare <akshay.belsare@amd.com>, Marek Vasut
 <marex@nabladev.com>
Subject: [PATCH 1/7] spi: cadence_qspi: Fix indirect write timeout
Date: Wed, 28 Oct 2026 16:41:08 +0530
Message-ID: <20261028111123.1198451-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C6:EE_|PH6PR12MB354726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf0dfb5-a7d6-4d8d-9f95-08df34e44f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|18002099003|6133799003|22082099003|261026140227099003|56012099006|11063799006|10067099003|261022105027099003|261021121427099003|261009220027099003|261009223027099003|261022075727099003|261009221227099003|261009223327099003|261009221727099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: AvTD1+vf+uB2IKo47ly8uSwEFEiS+t7HpfZIU/dUs0KBvnzjcj+/zmKIWF8NIydmSgYBO5AqbuXdl4Uooy5wA8bwtdZcSWOlq+zpwNn6tBcC9OqcrqsdV/sGawOrT6CJLqFQIfKDEZSCri//WL9aeVvu7hoLgC57PM7Cac0URNJhckL1F2DcD57oPBIcR97OnUQNc+7WKyUt/jL2+eO35EUiY+kLVZn7saCg/CfuRX3h+xjylfuhYLQNHNWPezj2w5imNuoC0NSD/YCF3JpJfcPIH3oapdAprrV1Ii//RqLPcbrZ5g0lDsRZyr/Ln4H9U9UIJzasiVAlTP6Gfgrcp9Bcdl6n/RMZpiVyLsgQYECumHIwd/VIE+HSR6dzcUwtT74F4itlAiTd0IhHZaKNF/WKWYVuWjdDqZUSV13K3px48NkUmj/RDIB/kgVyJBF3S6X4C21rtawI1bCNX+69NJfBKAzsU8lqKqqS/XX2jFrBeTtal/3whfFb4cR8tjWi8GmpguF7GgUpALsX837z2QMAA4tJt9YMyPIGjcFPp0SgehtG6r37WwlxEI2E8dp66YHYhbat50oWOAirBuQH/f+XSmIWjAovEm4CFRShvDz7sFRUUhBVMs2UNUU7TUxbNkm0Q+Ll7bJkAeM28hzZB5MG75HOhJ1koUoaOth1/0st3elSt7EtEKvAuDzors2NO2t9z/pLFxiBFDFrqxWKDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(6133799003)(22082099003)(261026140227099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261021121427099003)(261009220027099003)(261009223027099003)(261022075727099003)(261009221227099003)(261009223327099003)(261009221727099003)(261021123027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F85xOU3paYR8et0w9ViRL2hVckeYTPGJY6w2ccA1Ve7JdhcjqfCE5ebBtUeAl/qKsUlestbKs8YlwayEdDZTPYGlBboUzPZgLajka8fpH3VuCwBZkZjsn2NhQo3EEW7qMu/7uvXn6GXk4Dtf3w/dcTjoZn1cjFK/ibs9ON15S1fR6sEr71d5L+Qm0I3tsjfbCp0EYoB/ieqnGUVxmv7CjuJZTtLVSdaSShy6AlfsQL0ZY0feITkO85eVUt9goRgbjn6k7wD8uJJpifAqJ1bkWTHR6xZdkfA148jJGehBctxx86GzZAWrhufbi5SIcnK5uv5I6n2cIxQH8Jj3qFzVEUj/+/UUAQVbMzLdm4orVTN6k5E4CYCQrwKDoTanW94t8f7yuWgEI8AbAARhENdGhUL9BEMploeznScIc+uEt5BvJ0MWecxFEvsybq0Z9AA7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:09.5310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf0dfb5-a7d6-4d8d-9f95-08df34e44f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB354726
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To reduce the CPU load in waiting for the OSPI internal SRAM to clear in
indirect mode, use the CQSPI_REG_IRQSTATUS register to check for the
indirect operation to complete. Enable the Indirect Operation Complete,
Transfer Watermark Breach and Underflow interrupt status bits and use
readl_poll_timeout() to poll for the Indirect Operation Complete bit to
get set.

The IRQ is not routed to the GIC, only the interrupt status bits of
the IP are polled.

The indirect operation completion and the indirect done status were
polled with a 10 ms timeout, which triggers "Indirect write timed out"
and "Indirect write clear completion error" errors on Versal NET.
Increase these timeouts to 500 ms, taking reference from the Linux
driver.

Fixes: 26da6353e171 ("mtd: cqspi: Simplify indirect write code")
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_qspi.h     | 14 ++++++++++++++
 drivers/spi/cadence_qspi_apb.c | 28 ++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 6a8f9c58e4e..d97a4cbe9c1 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -203,6 +203,20 @@
 	(((readl((reg_base) + CQSPI_REG_SDRAMLEVEL)) >>	\
 	CQSPI_REG_SDRAMLEVEL_WR_LSB) & CQSPI_REG_SDRAMLEVEL_WR_MASK)
 
+/* Interrupt status bits */
+#define CQSPI_REG_IRQ_UNDERFLOW                 BIT(1)
+#define CQSPI_REG_IRQ_IND_COMP                  BIT(2)
+#define CQSPI_REG_IRQ_WATERMARK                 BIT(6)
+
+#define CQSPI_IRQ_MASK_WR			(CQSPI_REG_IRQ_IND_COMP        | \
+						CQSPI_REG_IRQ_WATERMARK        | \
+						CQSPI_REG_IRQ_UNDERFLOW)
+
+#define CQSPI_IRQ_STATUS_MASK			GENMASK(16, 0)
+
+/* Indirect write timeout, same as CQSPI_TIMEOUT_MS in Linux */
+#define CQSPI_IND_WR_TIMEOUT_MS			500
+
 struct cadence_spi_plat {
 	unsigned int	max_hz;
 	void		*regbase;
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index dbfb7c1f592..e2a3ed3e018 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <wait_bit.h>
 #include <spi.h>
 #include <spi-mem.h>
@@ -857,6 +858,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	void *bounce_buf = NULL;
 	unsigned int write_bytes;
 	int ret;
+	u32 cr;
 
 	/*
 	 * Use bounce buffer for non 32 bit aligned txbuf to avoid data
@@ -870,9 +872,15 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 		bb_txbuf = bounce_buf;
 	}
 
-	/* Configure the indirect read transfer bytes */
+	/* Configure the indirect write transfer bytes */
 	writel(n_tx, priv->regbase + CQSPI_REG_INDIRECTWRBYTES);
 
+	/* Clear all interrupts */
+	writel(CQSPI_IRQ_STATUS_MASK, priv->regbase + CQSPI_REG_IRQSTATUS);
+
+	/* Enable the write related interrupt status bits */
+	writel(CQSPI_IRQ_MASK_WR, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Start the indirect write transfer */
 	writel(CQSPI_REG_INDIRECTWR_START,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
@@ -891,9 +899,9 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 				bb_txbuf + rounddown(write_bytes, 4),
 				write_bytes % 4);
 
-		ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_SDRAMLEVEL,
-					CQSPI_REG_SDRAMLEVEL_WR_MASK <<
-					CQSPI_REG_SDRAMLEVEL_WR_LSB, 0, 10, 0);
+		ret = readl_poll_timeout(priv->regbase + CQSPI_REG_IRQSTATUS,
+					 cr, cr & CQSPI_REG_IRQ_IND_COMP,
+					 CQSPI_IND_WR_TIMEOUT_MS * 1000);
 		if (ret) {
 			printf("Indirect write timed out (%i)\n", ret);
 			goto failwr;
@@ -905,19 +913,24 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 
 	/* Check indirect done status */
 	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTWR,
-				CQSPI_REG_INDIRECTWR_DONE, 1, 10, 0);
+				CQSPI_REG_INDIRECTWR_DONE, 1,
+				CQSPI_IND_WR_TIMEOUT_MS, 0);
 	if (ret) {
 		printf("Indirect write completion error (%i)\n", ret);
 		goto failwr;
 	}
 
+	/* Disable the interrupt status bits */
+	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Clear indirect completion status */
 	writel(CQSPI_REG_INDIRECTWR_DONE,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
 
 	/* Check indirect done status */
 	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTWR,
-				CQSPI_REG_INDIRECTWR_DONE, 0, 10, 0);
+				CQSPI_REG_INDIRECTWR_DONE, 0,
+				CQSPI_IND_WR_TIMEOUT_MS, 0);
 	if (ret) {
 		printf("Indirect write clear completion error (%i)\n", ret);
 		goto failwr;
@@ -933,6 +946,9 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	return 0;
 
 failwr:
+	/* Disable the interrupt status bits */
+	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Cancel the indirect write */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
-- 
2.34.1

