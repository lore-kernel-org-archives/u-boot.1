Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AED606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x97NR6OQ;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=trHtPndb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3E6260816;
	Wed,  4 Nov 2026 10:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XjT6ae3nPs1q; Wed,  4 Nov 2026 10:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04D6F606DE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786635;
	b=jm2m8bWcbvCSHwdnfQCdt+xZ24ZraISQWB0OrMjvIKGTMPxuMeG40lwhweIaRx9jkiEP
	 aWA9op2EAZ6aE8NVrlGbcVO5gpi8J3SGAmywkcxrZyMmJwVAgXJNfE1TLRHzKEES39n7h
	 +pkogT5nsOLXrBAGvdg0CufDLuOtzd1/nSjeo5rLU6Vitqax5nbHrbfJrHVygD8TaUs82
	 Rh8jhjjXNC++WkmYmtdLSld3H9VP1w/gTA9ZGM9bUJVssEbOVuaFpUyvmD0gv5C74NcXy
	 ULvilPcoH2Jfd8q4prAlU9O4jyCQRNBWGGQso0LriOBqvwv1Ls+K7hI059xz5y+4KfQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786635;
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
	bh=0dI3oqGwohvcqBcjw8N/YlmOc2gPaaW1yj/shSqR1bQ=;
	b=GG5AOfc6kl+RCsZB4HbeYgbtBl1kP8yPRDjGJbJLyC8v1bJIjwapIvsRAJuW5qNwfV15
	 THvPnKYmtqdr2LQwx8fKSOwqfXmvngvNZcImklcJcdwXn95u7h5URSU/EoUXHVjtBZ72/
	 JLA//S81e9XDqjUfvTNgOb/CbIgrBbMHlZdqRCx6P6Wg2BEgrOaA7kWiJCvmh8MN/QkL8
	 rVRhzb8Zv3DNedakr0gzwNGXszlce4zqhzkpN7bT4usu59rRCRu6mgQ6aiMZzbil7ihYQ
	 SUPFbiHoiGslL2towT/ub/uM/jxHcdNijJUsXHAJsFssK3EuLF0TAOy8fuzBDgZ8ZXg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786635;
	bh=0dI3oqGwohvcqBcjw8N/YlmOc2gPaaW1yj/shSqR1bQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x97NR6OQwLKvk/x1xi70VWUomr7lZeYtFR3iClnKI6mm2gEmD/RnV84EmRgXGWpFd
	 eeOwCnPNnc8p0WSdN6W2st4hXsnZNsT9j9n7WMDpKzUJBEy4mpW4frSTJLPvP9EquJ
	 g1ysRcdOac05K8WBw43XND3DyOVcwyJPSYVoPTNLTFriERg7XP2kNth3kcaRLrAIQK
	 wBXjkYclDwMMoIfK0POIiDRMZY394u2dW+zXRDYUDZBvNvjWzgHnwr8e8DKCzYeq1o
	 rK82Ts2ORBeGWVfAYmCGCVl6QA4L2KU5FTYvwI5Gs3JXTtMTAhEwt82M8lcuF6aEDF
	 98h/j+XA9Qx2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04D6F606DE;
	Wed,  4 Nov 2026 10:03:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 975E537B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79473809CE
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMoUSuxlrN-S for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B404A809C4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.62.48
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786632;
 b=BY16/n0Rp48FOQZYuS5vllb6xa2QKmTGbgYSDkefWYiMbx/V/Bw1/vljlqXGnIbOkRXb
 itZIAyE3zfuNZn+apkdQH73yGEkPGEECo+sw/kz6jFqDys+yVZQSjo01+4FQQIm9xMozf
 hIrz9UEIMvu8cpEGAsJt+CH7fSPCZ7HMoKXdITSE7DF/Ng7tWu8esiRKo9eLfFm8rqvsW
 nBaNACIG1E/N6YkU12UixV7K5PDNsXFhOLfLx3EOzd5wvvmIqwVJm7b/lDR6BllXeBdGT
 bJKMVK5ZbtsBSXHkPKTPW8nS0C23fv7LUczD50l2GGmxer50CC9q3ZWFCPjDgg1gFwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786632;
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
 bh=0dI3oqGwohvcqBcjw8N/YlmOc2gPaaW1yj/shSqR1bQ=;
 b=ZVVnjyYd2JiKvGqKQAc/8Qe633FDBNNIsv+kIZKD6w7UpmKdbtfK6YrGeNK4AwfolJLw
 h2x5wYdGOFT7u777sGPUkJVEn55sfH6B2ltW2TMqFPRMbl38qLIAGksLmHeIyxVUYFkFO
 +dsXnqYP8yqn/goVYyK6fKYHiP8xoHQXkOxAC6GE0yl/T9UG57xoTPz6V2W3gocsad3z4
 MvtgAUviZiiQHTMG9qLSUaHJxpatnTlX3DaXv/CRhM7G/B/i5D8B933lMAVGFGRoKrzAF
 9Q9GizPoddxBGDhqkKq+YUiTbXEbcgFzmXF+JFVRv4BGhdAgNSygypzd8iRSv9NpoKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=trHtPndb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.48
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.62.48;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=trHtPndb
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B404A809C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+6ftaVT+xuFublpf0WE9wCIOfA26Zk0usjC599Qk10sI7FlYq81yHzNFBLjIr2mEDFZEpO3F8aunqJA2ejOfaPSmrttY2tvvu4LpEfgYaCJbys8H8vSJNsBSORujD/AVYTYGS5JXjjwWRJnjwPVOBXeEf+8R3VbO3QIK7hgdW0KUheMR5CKvdxPG2QQf4kWf524cyibSUYmzB+fOnsa86Y4qx6OCD4IJd1pZ8UnBDYkZxjef8tga7CSSfNjQwjIvOy2zvx5GRZLs0RvNFSNvwvEDxEqNoQa9cXkrbWTDC5SHxLvY73a0NHTB4YLHz3oMMCaWLAzrixJL+0OTkAtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dI3oqGwohvcqBcjw8N/YlmOc2gPaaW1yj/shSqR1bQ=;
 b=oKe/ADEA5j1nnv4sOi4bx2CDIFrVhlgXgL1Mih9O+g4xFXwY8oedidFQ0Wz/AsxQqeaQLb3+VKCpLRs201COPA/IBlUbsJJlvAXgq6lHBw89H2N1OCOppC+0AdUWd/+tGnLw0hsXDv0NhTiyXTlU7eZHYOdXv0MI8ViMSFCJTtN8ssASPxUXj5MEN2mNzx1wtzYOnCOBlFGUgcoycsR+/rAZYknn1lrtTyPVC/V1ZEei1Sh+DnYx8eFd06UgU+1R9Hm3MwTpTFLf7bJefI5Pj0JuS1ZRFdKiOzVp8Ysdnbr1/IJwDrhxBfGKfyhLFF9TivbEtTbFBNtY+cZHSLJgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dI3oqGwohvcqBcjw8N/YlmOc2gPaaW1yj/shSqR1bQ=;
 b=trHtPndbQsuh2NaBRpnOUrZV/+MF3HAPTd9v2o4v0H4QyPz8fyK0gX7yZoc7tXf/HTAMTuyc2YCix92M+Js6ZcLrjm8KU2djonCZtrOKQdlVyPU0SYxqKyaFhXcRpGMaZbD2dFPyiuQfO/lTwu67eiP/2O/QOD+W+Nf5A52u3oA=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by DS4PR12MB910612.namprd12.prod.outlook.com (2603:10b6:8:506::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 10:00:46 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::16) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 10:00:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:33 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:32 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v2 4/7] mtd: concat: Fix the lengths in the concat OOB
 functions
Date: Wed, 4 Nov 2026 15:29:38 +0530
Message-ID: <20261104100005.4104985-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|DS4PR12MB910612:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8e7ff1-12fa-4a7e-6a8e-08df3a5a7e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: yyRCXG1qXA1iKw/t71HSBEbSBo18FJNXapDFJo2pVAhxFl4Gz13bwFpWBHmIvQfJhgGvBr3Nf/zVrmia2kklzp/9i7ws0Yd0/eulBPbkCaUH+eO95R78LMtuGv69RK2q1p6VIg9y9GSiMwN49gLq/Iv7bY+A60+dgOsNZCtQ7yIFNs7//B9L8UVucps/Xhii4v/kFwScqBs5gn2JLWV0YIRXt8IbF+7ABl+zCVmwEsGMHhrYFpYZ4wKcF6EYLF9levEdCJ/JoL2yKukFSojWheNip1eiBgSjANOyVcBvVXywutsj5a5xFqUhGklyNJAjXFHzQgzNp4ZHksa34YtFnM5jyUxEDipTVmJJJuAx13JmGFhM4VytQjvjyN+joZiuWbQIMJ3u2kcUZ/9Dj9pR7qOLysX3HFA+hE/hhyLM6BLm0qdGHjJXqMZM0LWEHBafO3ou306BbxQqMQiMUKTvjc37ttX3GavWFJQZ1whr+ucAPdDC5YTSUxI5XuE0D4H9njHw+DB46wZWQA52XMKFh0Z+eQN869bETqgxt48TIAj4pEQrEzB1l4GJbvImWJlSq5NL/rG3fXCl86+2ce7y05ShIMcHZ53HvuPoVktI/gz+a5BIBqDDVlMz8GJ8cMCHcyM5DeQF/qPLVl6VExWKdIlq1DYrzK4KhvTBwd1Ds+JaEoRiDY9AuQhH0atnhZxXktWw5uiWAPY+8Kb/k9+r1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Axsq7w6x4kwusq7S/OmPqWQWXlNND5caQQ3dMVAV+iK6TCXkEsNTU3AhfHPWSfO6lBnapL1oJYtbP1MlNFntvA2iPqKpxOQA1lOvHGrnqTfg1g4yusQ1EpHnL/Ey0k8RqapzbNrEl0DKHjSS8vXNt8C1bGAM2w1bNfMlK9dRidvvgcIJtwq6t7Ito0fesTyVU+qHQ4OS8TS5GQ/Gj9kC+HC3WIp4D+KgLlq65zILSVAeDxvkGEGN0PXg/SUpMmXEYAO8ZGcyutEYeimEu4LlK+AWIEpCSYufh4zNc/g1SisKwJ7J+YRJaLNDzE9mDpxh+i+My51Y5YGjp2Zb5hHY3daK7Kd51ZOc5PDcLSkRW84CCcHzstrA02Azf+hHJxaI61QIn8Dv+aD8nvyRwz4bJYnOS9zFEdmFxifN59xa6m9sTHmRgFmiuHNC4RbPrbGB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:45.3073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e7ff1-12fa-4a7e-6a8e-08df3a5a7e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB910612
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

concat_write_oob() adds the OOB length written to a sub-device to the
data length that it returns, instead of the data length, and never
counts the OOB length. A write of data which fits in the first
sub-device is then reported as not written at all, so the whole length
is written again to the next sub-device, from a position past the end
of the caller's buffer, and -EINVAL is returned.

Count both lengths, as concat_read_oob() does.

concat_read_oob() also moves the OOB buffer on by the total OOB length
read so far, rather than by what the last sub-device read, so it reads
into the wrong place when it needs a third sub-device. Fix that too.

Fixes: ff94bc40af34 ("mtd, ubi, ubifs: resync with Linux-3.14")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- New patch: fix concat_write_oob() and concat_read_oob(), which made a
  write to a concatenated NAND device fail

 drivers/mtd/mtdconcat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 51232581d96..3c79a54a659 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -285,7 +285,7 @@ concat_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 			devops.ooblen = ops->ooblen - ops->oobretlen;
 			if (!devops.ooblen)
 				return ret;
-			devops.oobbuf += ops->oobretlen;
+			devops.oobbuf += devops.oobretlen;
 		}
 
 		from = 0;
@@ -318,7 +318,8 @@ concat_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops)
 			devops.len = subdev->size - to;
 
 		err = mtd_write_oob(subdev, to, &devops);
-		ops->retlen += devops.oobretlen;
+		ops->retlen += devops.retlen;
+		ops->oobretlen += devops.oobretlen;
 		if (err)
 			return err;
 
-- 
2.34.1

