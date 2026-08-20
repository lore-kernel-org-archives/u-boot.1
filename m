Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD48C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD5E980C16;
	Thu, 20 Aug 2026 03:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6T2zPJOpl1M; Thu, 20 Aug 2026 03:35:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787196901;
	bh=oDBmNY/6yyBcj82exMSgJ9pKiFXozHOIc7POwNoAvD4=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PGVav/ICtSAPG68J+p8DnwrKNzOJ3V9lqKZ9E48sdVvxYc5aofxuw/T2+lXg20dNS
	 blbe/77bQ8ig9SSSqPDXBhnIyOoX5J88TBADD+m97RzCC/SYMPRosxxxP5+VYaixcS
	 9Iz4cmy0wQ0dJ1+YMQ4ltDrrW7JFrb6ewiCVTFwg9zS0xIm0FLrFC1wcJehixkkPcR
	 JBOr6LT1prrWkIUwiwx2tdbmVDepOErs1BvIm1cz4/mgkiZIPj/LUjQRU1dReyLF1M
	 vbQ1agUSA7dgbQEtyUG6KVIbvXNHbs8dVF2+zdRdeqNp7/eAjh0HTJPKkyiC3yofqK
	 bqT0dbVArh9iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3041380BF1;
	Thu, 20 Aug 2026 03:35:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 611AE1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A07280C09
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tTGN16dG1leg for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 03:34:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=pranav.vinaytilak@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=B4YzeMlc
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B17A80BDF
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDJui6+4r/fGCjhNqljhbG6L71nelIAMLIRc7HSegw5HJg4C3S7HswWtxIGR9y7op3jXn5NC+74E9eWCXiQyhDUjj3Zl+tsgn3M02dE9NFzyQJtuuKp1qJP/CiiQ5oWKVmvWzXM7acjCKyEl7VRvevgmxCAVmq4JYlsKale25J0Y+k+2MU0aGWYF6gaIo/ig4nWC2dgQJ6Fs73Jt/W1Dzbr5DMyfy7KwMRxs8MMyvZpKSSpTJ6Cz46TxBmOFjyJ2oz3fA7rWI4UrQFZyp0bxz46ajKwAsK5/fqTBGvKLNI3vHOj10LGb2uMqoKrhlRnm60PMXCOpGt0pJuUGXmTkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDBmNY/6yyBcj82exMSgJ9pKiFXozHOIc7POwNoAvD4=;
 b=eod+zaDT7MS+qhITj6YPQCX28AoKsuGJ6Y94slfJL5t4OgFmHNUqL82WAY7utqALFwO2D2PAgYRrymRgafvgMQcYHb5K7WEh6+nmuIWS2R6zJ7DmJM/dz6ZkL3J3FUiNJjrNPhjJgkLwvw/6VFlFZkgqPIh+BUCkItqxJ9V6xjl89XLGgBTwgC4+9Dirk/lNBgEH9HHxbN1EAcCg9mBeTbG8DpIP8Cj4QhBmRw2Sc1g3qcyaAlykA/kNm6Cv2Hy1kWL3eowXpj4M0YbovoYNW7xCqm6oj3pM8vv33OyuhER+6m9brRUqrZf1LVX6OIuKLjtFKtZR6P1HKYDlGUsQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDBmNY/6yyBcj82exMSgJ9pKiFXozHOIc7POwNoAvD4=;
 b=B4YzeMlcyP03Q+eXZ5lhb2Ll6E6No7fykZNxlr/Y3AvscjrScSZ2adLe9BM1gdqz6cZPlVlz8UFqUV+bPn/c46i4sKgSR+hzsB2bv2EZjdPYc1Wibg1Ics13g5wgwF+9rGRAR2jh2DZYUiog8L8LpSQmA1VRzTGvn3T2kQfpd6Q=
Received: from CH5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610:1f0::27)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 03:34:53 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6e) by CH5PR05CA0019.outlook.office365.com
 (2603:10b6:610:1f0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.0 via Frontend Transport; Thu, 20
 Aug 2026 03:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 03:34:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 22:34:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 22:34:48 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 22:34:46 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>
Subject: [PATCH] arm64: versal2: Initialize num_banks variable in dram_init()
Date: Thu, 20 Aug 2026 09:04:16 +0530
Message-ID: <20260820033422.2967698-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d647ee2-b5e0-42f1-0af7-08defe6bff2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ysEQD8e0GMOG4Fkv6xUypKKj5l2C9P63Rmdc+em0pgkxkzwYnf7hLPxMSRDVtpkFe/jIqlDqIq2cuIDOoNbwi72t4OR2ZaZ9ONa8cMSzSQoW6B7zI0suQ6260wYkwE2TYvDVnfJtZk2nhfxe0OFlyPth/U/gmu4ckML/33x4qFo2do8ay04Qclt0t/ghPEyo2oN4Fh54B+cl4pHsurlqTczQ6lW4Ecq8RPAojyaY2VtsXtHp3HYAnX9Rf2pLCwVX2sTGMoOPDM/U6rkomYjRLv6P0VGf58eddVNr5Sf1dxDQR482flJzI1mRbuM0YrIkpbuEsh5PwtzGRRxCN6kR3huWVDjIoXHspNAhX+dcfGhnkXuV/76sQJWw9xjCnkL5MNt6LjphYInKyzgpbzDs1VPXXxk72qfxJTb0lpTOH2wjFRZAGHHdxWoVBzkVqQFfNjk0E9Kib9eklBZDk3N5OyipLcqr//Ivhyf3iv/GeE1Nw/4dnbwTFsl0GMMUcap+2L893GL9vujHvlMc2Gfvnfs4VkRFyGe1psTbX+zGpwUt4swNwxhvL0aXlyqsZO10SgSx/y8ju5RuyfIR9mJznp8jKw8pKYjBt6RNIeOv3h6cCAEhH+nnpSoLgQnHinIJ4GSxH2ns5toF4ydagr3vjwOB63uXRhiqbMdk1hA5tac0YHRgbm86vPl7xNlggFGadxvbrj5+8dLJgiUe4y1hTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PArC497A2NY9r+RIte3tQt37h3gml9nr9l6q7e6DqbyLp3rQZ+xf146gHvFHxYqa2Mh/z7yWrcUR1zL+ORU6Vb3OtCjm2HD3e4iBXKSpJJjQuXxzjoseGxgxN6FDjVi0QXqZ39G0aQGBw72SIFxSFjLkra3kCOdOr6BHJ+QPZtWZSgT3Hnpn7c9/C+tuTvveMJtLfrXbYTCRnSoXNhY2amAeTLv275KBuhsRriFWduCB+MMCOYSRc1wq51YWgmhqX7nfWvE3iPPYjfapZwNvwBZT97gyX++B4HBd2yCByO24d53BqY74HB0NozCZBgvfvz459M7onyjvbnCfaVLL/QdtCd9NF3sXQAH2BAWdb1FVu1pKSTnTT9opdhLIvgQqGgCDPpCrGrCYzx9zZanYtVwNJZwukD5560fErL9Km59qExsdERI4VqFX+4UNHaSZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:34:52.8808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d647ee2-b5e0-42f1-0af7-08defe6bff2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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

In dram_init() num_banks is incremented for every detected DRAM bank
and passed to mem_map_fill() without being initialized, which can add
invalid entries to versal2_mem_map[], so initialize it to zero.

Fixes: 3aebac5a759b ("arm64: versal2: Populate DRAM banks before page table size calculation")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 board/amd/versal2/board.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 15b79bbea69..ef6eb1af482 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -262,7 +262,8 @@ int dram_init(void)
 	ofnode mem = ofnode_null();
 	struct resource res;
 	int ret, i, reg = 0;
-	u32 num_banks, reloc_use = 0;
+	u32 num_banks = 0;
+	u32 reloc_use = 0;
 	u64 text = (u64)_start;
 
 	gd->ram_base = (unsigned long)~0;
-- 
2.43.0

