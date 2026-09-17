Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED9AC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 11:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8289980F11;
	Thu, 17 Sep 2026 11:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMC_CksfDnb1; Thu, 17 Sep 2026 11:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 90EB580E2A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789643050;
	b=ZbO2CmFM3K5vFaMv7N9ZKbI1itfO9lcu14yOrT6GDSnjyHx61wUJlia/RqeK3dlBdcQw
	 PYnm4ZF2SgPgQeeYZYiDUiXvcsr96SjPht6iwxnlgSasclSs8RHRzpIB/kPcjZ/LpDQKq
	 fZF5rygSiKA1QyIJD/61wwQLO/T6U0S+VJEMhmoFvV8Q0jywPhH+3E+6nlwS1qXAlKXIY
	 vNWTYmqpjgJrzoEJpdwGZD4S8j8HSL5LcnV3jwLQtCQN+UK5lPnRbGpe09e+alEwKxccS
	 k0Xkd50irl+xlrXgmIIgjnE3g+rRONs+n74PxvrblA0uc0mzfF/+OLBxy5RbDFr4/qQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789643050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/PTAVgTU47V69PgCLixEfxQD8p6mmzwMtgCh5vFoe1k=;
	b=GRornOvvMF0GMtxuSCY1DKj+sWj9A06rdqM0APVGUApjgyGiK+d+Vc6Wju76caTIi/mV
	 R4gJfGy33v+Gy3+mHYhoonooarBFFfGFUsQIPjOjsY3AC/I6VQ78Zu46FKa85fTA4m7J7
	 0zAQ//af61DkZ2Ta2gRQo4ep3SbV8bQpiDIIyK1ytlucgRPfCY8O/LxZq+IHkqa9J1G3+
	 1Mf/+DhVYE4qlOs+YqcVu0mAc8OzCdLnIXYiuu/aPeibhIO/UAdRI4CqInEy9TODBTDyT
	 PBMXi6jJ1nLs+0NV84d2LRokixWOn8drOHrjF5aL3aMP6vnMAwEbi/nUDEmViiT7TUw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789643050;
	bh=/PTAVgTU47V69PgCLixEfxQD8p6mmzwMtgCh5vFoe1k=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EiF7PleVREAVTsSLYdowJWjPnxwNUUP+hIaFxM3C68JALdAEnz6X5SDPCXpvr9S3N
	 4+gkc89nu9rdXapEzgCF6IxyT/0uSKRZmPuG58AjkIgSnYgCOvL4jZ7fjA0FBvSa3p
	 RRm9KvTyfGL2oQLTmIuuV8txhcgkXa+M8R1DkMH3WM+hlNVvdGr9AJMgZ9ZnkQe8vw
	 hnATdnw0rWwwe4Kei35PvIXDH1lKjbSJMwMP9VDRoG3qlQnkJwH/CJFm56XJgP97OD
	 wLnOignRyrLGxZ5yj83CeNyqgUVv5i6W/cjT73r+nqIpcdzUinU44ZzpDE65AHspq5
	 ffcBVAZrxtHUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90EB580E2A;
	Thu, 17 Sep 2026 11:04:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4485A42D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 365ED40050
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7qRnpUATyV2 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 11:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 335BC400B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789643048;
 b=fSGvKUKSgM05IPjiGp1XpsQA/pxkr9QUFApPm9OLJJFdvx/AT8L1XcHpmQDQmgIIr7w8
 xMYQrVi/f52ibJruM3NlQqbeaGIjUUptUNeSNG+C4Jxm6BN0PKVbfs8vplBpqCpQhRvvz
 BTK1J+fbfvif9/ynx7YEAXjQo6ChMIfo6J4zEkPm/90B2RdHtdvx2Y2AUIsgYEuZ2Vtqr
 gZA/eyopZXnpf3WwQF/jlu9SVxpcoPAyH2Bh95T8pnh0aJdy3Y/dvsumYQHikYZLEZMCZ
 wxu2gSv6CS9uN009TKQE43Vgoi2XsNXfekQGnqvb//RD/w68blOq1pD76jhFYpjtWtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643048;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=/PTAVgTU47V69PgCLixEfxQD8p6mmzwMtgCh5vFoe1k=;
 b=SKZ16IRh1nEl2jZJ+TlSmBUeNrDsRyIGLWdTZhims4drEYXcwLE2NGui1x8NRDVfsG3g
 7jXum0xc1k6GdfTFltCAUH+CdP78EiGBdUnBVOnT5Rq+/Unz2y3yX7A/7PANxXY9eXKi7
 SPys99AEUCWhBkPpJzi2IvsfZQCz7UKlBJKrJjXHZeQbXikIzEhLqz2oTo9JXnRr7CCpK
 a+avHpGWZl07o9cGvddjAKW0Dq0YmzjeLakFb037FB7vovDvh+l3WDdNS/t3wTv+ZIagv
 pXiptsVJ4+OIy6kRbN9BzmWLOQi6/GSHDfegEp5SeHysvguof1SBEbsN5wbTj4Nu48w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sKbsiXR5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=pranav.vinaytilak@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sKbsiXR5
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 335BC400B0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHFKehs6Yi1yAmRuMWRFNJqOBk1+cvGBS3Ni9rmMifPP4fxmwzdhGxDfWzCctTQF5pw6/tZHG5xpF6ZTkEiJCLHsGF0ba7kfrkdlKZ7WZfd5MuUYGgWBUkmCYBepWq8QVNnUfy9ikypfJsoyUw3bTyLv+zIh2h6SpVt7tDKG2sOeoXh3JlWA8TWLThduLTPD+AXC9Q6DnEVeLL2W/0IWks06X+rzPpWfSAXhEbITcOK4Mnjx019juplWuZLZt4J3FxXaaTSoH9iWfbKULJ9dNgpIB1LrKoOySYdHyM2FziZ2N1BNttXKNlzOnbZASjI19g/gUv5rDQma1Tt5zhO3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PTAVgTU47V69PgCLixEfxQD8p6mmzwMtgCh5vFoe1k=;
 b=CLOF1B6bRK7FzuIfWIRYFDqvYG1ugg02oba1j28Ss9SprLBCF+tkYUplR0yxm6YzNc5kVyW9CG6KD48dmhiY3pkNoyBK5r6xec2TpnGc5Cmj9eD689BvC8DC+hJeUIg+mj+kT0fx0XldGZL6e18902WNDR7Iqr0U1ZyCOgi2+dwuKNK+orkzfplAI6gh/7nnSeUqSEYiRPyghFMwP+2qhPfW1Snii/TxK5Omt7EeaGzoS2jvk/6+QEaNDYtMf9gxCgSjHLV1FfCH8cUoZ+G1P1jTHmWJLH0kErzhxVjS0Sm5b3/5COSRVQ8xD6QHCqxhq+6qM+re2qgjkKqDzkDthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PTAVgTU47V69PgCLixEfxQD8p6mmzwMtgCh5vFoe1k=;
 b=sKbsiXR5YARYk/KMzVTbI5CrtF9qz49hj3ORbhABeDZ+HUGHFODewBkLoZJgoG/d81pBgeMV33XINM91mme/IOf3SLcNXXS1A0dR4MNqySWD+XCPlilsln0HXLs7JgWIKlMWATr9Nq452jp6fXgjhaaJ2rfelnxD5BVCyAJHQco=
Received: from BN9PR03CA0893.namprd03.prod.outlook.com (2603:10b6:408:13c::28)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 11:03:59 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::55) by BN9PR03CA0893.outlook.office365.com
 (2603:10b6:408:13c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 11:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 06:03:55 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 17 Sep 2026 06:03:53 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>,
 <sriramsriram@linux.microsoft.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: xilinx: Fix heap buffer overflow in board_name_decode()
Date: Thu, 17 Sep 2026 16:32:58 +0530
Message-ID: <20260917110330.3152816-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: fae28005-2c6f-4b46-9f21-08df14ab5f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: vRAme/vc4NLgn4T8t7qdxDkWmFX211OkJaFT96F+2VxqSIf3U1TG10lxV6ke1EnupbXnd61JSLSqqOHthG2/swKrVLMIZ/1nKa9GHB5Dn7zycZL/Vlk1yUMoFVbw5LMR09rYyHeZf614Qqx50OMoP6QS/zr1GYqsiXFYnaWl8gAagfnqnSQL7QjLMvSPTNLX8jEyODHDBRRZrcjF8jfMXVNCHj96XBxmz7BgQpJPHP7Zlkr3+iJp2DhqNkXUY8ZJ/TPmLIAZG5BvJXHU+7idvLpPArulJZ8HXoYUtTTXQcNVgeRv6wBwhuZ+cRrOGaxhkYtswEELtRgvvPc0IXG7GhKpmpYuv70qliZkEM/8w6OiYUnRR0DRKdbXQ343l+IBYM+iNTlu1y5dCL8E93yMNcLl3V61X0RGomvQlAQgTNRkkYdXEaOEfqCoKdRyqLqBCyH4j9F3rZ1PTq9eRaaUbePe7hZ/VbkK+zbIq9trr4ZDJAY/Myj1ztMKFu1UcPD1VJSGCVBUbkxQcO2Ltwd0am6kkBxY7qrWSVoQ8yP7pTJaaQ8qbhCAc7V1QCkKbNS2Cds1Ithe+42j6qOSEaUuYjVOxq0RyqH9Xdet/EXE70QnZztP0zYE4FpMj2SxJiBG2Pu8ije1MtMG77uBJmHMd13ssOz8DFQgaMpMeTUBOFHxZjYtncLwKyKVNRXO+cEYh5snOIP95sTPsBJqKlBlVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2UVRpDObesQ2BRCTYlhyBaIyO85j4YLDD4CQbXN/AxB9PWaFGxGrFbtbW2LCfsne6ZtXb1QKcAaa4QvJIIkEjQFvtlGGuEnU0SnPG/kEXG3TnuoTGIi04570DISczaSd2p9iww1152dBbQcrH1DFjkLTyC4vycFaguU1rorq4jrc2h9is2CpcPEV5tPcj5svXtEUoG38PvF8weWc7naljqVn2WqBjocXaEMb3wry7KAooEKYBfYCQWhHfGPjQ+vFf3WGT1PtHlDcftRH6BiFpMKdlTWGFubsARpgQjjpRHiL9BlTN9SaHdjWCgdcDGebJ0hzbN9JA3mgU70VdgXLLfpLF23Of37l0U+tT1sXtE51BLHl0iDaq+OjrZEuNlmqDCdK9gvZ3Pv8cGHw2EYzQlipT5sBLz7aMf4pn3XEHyl4kSNgCEJiO2NoXGn+ffU+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:57.8887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae28005-2c6f-4b46-9f21-08df14ab5f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758
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

board_name_decode() builds the board name by repeatedly appending
to a fixed MAX_NAME_LENGTH (50-byte) buffer with strcat(), and only
checks for overflow once, after the entire loop over all detected
nvmemX EEPROM devices has completed. If enough devices are present
and their name/revision fields are long enough, strcat() can write
past the end of the buffer before the overflow check is reached,
resulting in heap memory corruption.

Fix this by using strlcat() instead, which bounds every write to
the destination buffer size and prevents overrunning the allocation.
Use its return value to detect truncation during board name
construction instead of relying on a single length check after all
EEPROM devices have been processed.

Fixes: 52ff1626cf4c ("xilinx: common: Enabling generic function for DT reselection")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 board/xilinx/common/board.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index f45b879736e..503d2da0d03 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -569,8 +569,9 @@ int __maybe_unused board_fit_config_name_match(const char *name)
 
 char * __maybe_unused __weak board_name_decode(void)
 {
-	char *board_local_name;
 	struct xilinx_board_description *desc;
+	char *board_local_name;
+	size_t len = 0;
 	int i, id;
 
 	board_local_name = calloc(1, MAX_NAME_LENGTH);
@@ -590,39 +591,36 @@ char * __maybe_unused __weak board_name_decode(void)
 
 		/* The first string should be soc name */
 		if (!id)
-			strcat(board_local_name, CONFIG_SYS_BOARD);
+			len = strlcat(board_local_name, CONFIG_SYS_BOARD, MAX_NAME_LENGTH);
 
 		/*
 		 * For two purpose here:
 		 * soc_name- eg: zynqmp-
 		 * and between base board and CC eg: ..revA-sck...
 		 */
-		strcat(board_local_name, "-");
+		len = strlcat(board_local_name, "-", MAX_NAME_LENGTH);
 
 		if (desc->name[0]) {
 			/* For DT composition name needs to be lowercase */
 			for (i = 0; i < sizeof(desc->name); i++)
 				desc->name[i] = tolower(desc->name[i]);
 
-			strcat(board_local_name, desc->name);
+			len = strlcat(board_local_name, desc->name, MAX_NAME_LENGTH);
 		}
 		if (desc->revision[0]) {
-			strcat(board_local_name, "-rev");
+			len = strlcat(board_local_name, "-rev", MAX_NAME_LENGTH);
 
 			/* And revision needs to be uppercase */
 			for (i = 0; i < sizeof(desc->revision); i++)
 				desc->revision[i] = toupper(desc->revision[i]);
 
-			strcat(board_local_name, desc->revision);
+			len = strlcat(board_local_name, desc->revision, MAX_NAME_LENGTH);
 		}
-	}
 
-	/*
-	 * Longer strings will end up with buffer overflow and potential
-	 * attacks that's why check it
-	 */
-	if (strlen(board_local_name) >= MAX_NAME_LENGTH)
-		panic("Board name can't be determined\n");
+		/* Reject truncated board names. */
+		if (len >= MAX_NAME_LENGTH)
+			panic("Board name can't be determined\n");
+	}
 
 	if (strlen(board_local_name))
 		return board_local_name;
-- 
2.43.0

