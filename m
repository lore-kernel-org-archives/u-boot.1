Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC13C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A09D44067C;
	Mon, 24 Aug 2026 07:19:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6f1e8yiAW6Q; Mon, 24 Aug 2026 07:19:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787555965;
	bh=zFm0v9TQf1PoWWpnmp+S0LJaT/QRGZiBf57yaa6SjIc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XimIb5Zxdq5mkLVjCxUh1nTXEAS2E8mtxVoLDoZLUrRhhHDbdTSfokwJ+lU6I6GtN
	 AcMNn0A3lgLAQPaw+A13teBr0ssEncTP9JmZWMM6FPni0mXmzECaMfiPkl7S7k1Hlx
	 F7uqjQfq21Ym9zGhqXgKeJR++OeqKvu0Ye24LFW0bsGkGo2CrHLxRVDnrbRspwRBRs
	 rzXOubivUM6PZtCmUq60N9pB39YTHQf9o/mrP0l08qNKjZa8UyPxzvq26rmBjUeTbs
	 hobGSROvoY5QLBcj618gZPjpd3Lelt59HhAWVYIsRipOF8nj5026BZ+R9wtYGJpyMT
	 tZwUvw1SN4VVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EAFD403E4;
	Mon, 24 Aug 2026 07:19:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2000441A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11FC960612
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ob3Q0bS4b_Jn for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:19:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IB8S3RHS
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5376A60622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipEuY0WXk4bXf2E15v6fnZ57FQYzJoq9GNHWeoooTFKK9XkFaaUbgEj0nPKNXAoHL3EmERJAwVCZQOpdhfUpfbIC879XYhYvupKBgLj377+iTmTUvfq8Y7bm+PA1xfzl6wR9RhWhaJ5fDDtOP3qJ5z5FPo9FjCDKkpiuRU6sjK41s7FXTnYvvkHlstYfFufw4ZZE0WJ6b9w1e0Htb8Ljt/ryREBZB18FylWRENYOFyJPKcWH95cDZUVL12JlJGY/Swgq6qJF+LXs6BvdrtUsapAbtoNAN/oVEzFofPN3q8+GMH62QrQQB2TM9ffedgzNYYMpof7TDVZBRvDZ5dzQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFm0v9TQf1PoWWpnmp+S0LJaT/QRGZiBf57yaa6SjIc=;
 b=lX9ESuo7NuXGBmHV2zBw7GaHC67S+qjGjzBdDM1meT8knJ20nOjMA4qiBcK9Rq3LyY3WbAGQssr8UiNM1fF3IVZW3AJLBtX9Dzw7W3tpVoZvisUNjBkP3P/ySUYLIIwQQzBQThMtlcFhv4YTV7lqxRXIzFQYoWWR/Tqpw08rDr4QenZ0VnlOKJiSyXqqoVlqdUtft7QMnbQoLANSw/rxzEWpFildNH9QMHSAUeR9rhTUWi1HeYeCJ8kqrxpYlClsI8Ioshb8CV8QOalCy92BKG1O+CEz+GXs2T+aoRjJbrymcc6YxMmRI8GowQJcQsY+gucxd/EllYQJ02u8uGWhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFm0v9TQf1PoWWpnmp+S0LJaT/QRGZiBf57yaa6SjIc=;
 b=IB8S3RHSV9J6gtDRbMf21ElhLeLBUamdbHLCHIRUmykcGW00a+bu/O9S5uUN1P5Fu9XsYRJqd2m8wKOkfZP1cJydg5sKiZSEOLCx5qoRFC8b+AGQCwpNT9YmCKM1R0i3xzdq+YFPif6Nn09hsOJKCwY9m3OZGTKSa5uYmZTzL4M=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:19:16 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9a) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:19:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:19:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:19:13 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:19:13 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/3] xilinx: Correct zynqmp_r5 MAINTAINERS fragment
Date: Mon, 24 Aug 2026 09:18:46 +0200
Message-ID: <cb5da32e93f48ec7c13e3dd1618e711c0359aa17.1787555916.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787555916.git.michal.simek@amd.com>
References: <cover.1787555916.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=656; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1rNeQOAC3EMlwI0ACEq97kFu76p7vo1eK2xxHdtT5pM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR1f0hxtbgru19OXTBM6ZZi82OF6vQuM5Zoi7MWRzT/r
 xN4tzq4o5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACYyW4vhr3xx4I+59RKrPC3e
 pn7hLN/L67y0oWb2sa6Tp92fP+Rgy2Rk6JmavyKkWlv+IVPK9t3HH/6fNXP/lpuprHnrrMWFYj/
 +YgEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8bb028-06c0-416c-d46a-08df01b0011f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xvNMuJJ8uiycWKtvueeKsj25b6Ax7LtoBJvl96aKfxHiy2rprY0WzIqskINI1aVZ4/FnnuYcMFrjRqtcGaQTDgE3whfxdjAn+F9EIFJRrU/cGM4Q/u+aebQkBM7oPBfvpJGDLGoUbbSeNjDMJP5ij8S4fMBxBl4+t3w7uoy+fvB+YIJJ+3PEfJ0XzeR5O5bDmDA23DhrniJHLvTOjAGitOlN7jPhRGuw3cWmffeoY87XA0jyhzC29j8fvyu4ut0I9hyyVdfDRp7pVVIEnNtprJtKv4waRsWmgC9jbvxJdTkRJEAXGCYQVOKYLB9Q88+nbBxjcrDHNoaO1BXg0GRwOrXLgCagHR/aXCEUqrBOnxlzQ4dVDwNz4NCq2hZPZ5YCRUdXkFlZcyAXptIG65S7qT1+ejQhhOPlw0V16A5Z+TG/gJe75eNuDe5IYeJl7OoDufH0MsG5+OddB9+a/C5bfcxGLRxbBN3jGTOMlr4gZtFyMFmJvRRAoVhu/Jq+vPAtheKL9EnsvFbv3rr3t7WsZSSKCiNrllCh133RFJdpzltkTg/5jUQY8GYAvIPdXIABCO0O5bFJ/WEiGocaS3UXVdpGiJB1oLczTRXYaNE4sCvzQaxS3xkFa8V33VVFhCaZ+pK7dMJ8OP+w2k4d+DvIzKL9QkLTUVrCWT2bq1W1fuF3ulnKlQ60K1/hyvWNogejAejn1Cgknac9WQaEahu1lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W4mLtWysyZx7xP/Hk1UMDGHOo2LbTJ2PyxqXE6ZDKtDfiZPyppZ4hKx/eYuhgYHBUBIKJp+Lz6IRvPNzYV5qD3lunaRrlzJK+WIQkuO9h/hPPoBPDsUdfqhHwVtcIGRHUw7/hU/BG7Q/3bzS8IyKdAdIwlXs8vtF4Jm7y1/BO2Es3xlXrCC606w8FGeD2YiUGgK5EQa3/RWv5JZEauUjnQBYqikshZuoLu98ZJ1+f5h0QlYWdK/uPokNg84cLCPh3uuSpsQCYuPxxvE3frS1GP1YdAIJdB75gqadIda9wHh8nO7ErtAXy5wMSF1QvXokH+g2dfkIqksprkC4m5B0dK8N8m1gjw1ZiLI+rPq+mDZaXbno/csWaX1AdPN7ljQuWcB4BfUMsd9MLGDtfMz4WzY2UdGucYzwrhUIkFUlMaCcgRxNZEC1InvE4qQbozPi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:19:15.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8bb028-06c0-416c-d46a-08df01b0011f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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

Point to correct file without '_'.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp_r5/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp_r5/MAINTAINERS b/board/xilinx/zynqmp_r5/MAINTAINERS
index aa50e6dae5f5..0f096d2e71f1 100644
--- a/board/xilinx/zynqmp_r5/MAINTAINERS
+++ b/board/xilinx/zynqmp_r5/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	arch/arm/dts/zynqmp-r5*
 F:	board/xilinx/zynqmp_r5/
-F:	include/configs/xilinx_zynqmp_r5_*
+F:	include/configs/xilinx_zynqmp_r5*
 F:	configs/xilinx_zynqmp_r5_*
-- 
2.43.0

