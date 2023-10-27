Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1929AC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 03:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64E48762A;
	Fri, 27 Oct 2023 05:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CwEiNSkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EF98767C; Fri, 27 Oct 2023 05:05:04 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6148762A
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 05:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBDSNI/6oqZ6fG2WWALJFxTLU7+OHOPUZaYpOtFH3OKw5wQthuK47wvlX1mH2Nk7Mqx/EvcCF38kY1dX6ijRE9nCG+FCEO3nytqUPtH0Ymsax5hJejn2nSWl+ygRvUyedqye0BXYLvXTw/aQZV6cGMwXkMHdNNcmuxfir73IqSW5yLX4iUFlkDflqXHIVEwQ6W98Ewmvp64bHFr9n4gyOfk7YJNelToUg5+Iv2jdsFeo6BpoAaFrYUhQtaa7Z1VMHmtBqty7coWAgxV2QESaqlQH4XtkvidTL06RQI9/HZ/ADJiJi8UTk3vH1/pCjLiXq7r82lIfBeZSK1bKtCPbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anQ8CVZhJtXMm5vbSHCZnYYIe80oLEgcFCTTcLuS1uI=;
 b=IAsCZ/EkXP0e018Zicj4fooPaNMacbOMaMri8Sphr4Fr6Lcwy96dwPjqkDKEZ2pgXDJ3rl/h+vbn/HavvfMlyVi3Q2Q9HC4Rd6LrhQjl9WWyy4/gBAdsyGjymw8tp2B6e5L+bQSe8nAZPZDq6W+5/Tm2S8ZCjd7aeJFXJ8Eb4sFy0p1XivpTubW5yBuuVWGaNEdgXGlu3CYp/4Csrnb5C17In6OT7tADyOEW6dzCqTtsgoCTgYk41sLACDcptVX/KT9yS/RvSEoAQjUttZQQLh0ye1Ce7i77YyYubkaTaErHXgXL8SpFSgwlrwshqBWdyWKuJ2u9E/MoYHPcLbkQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anQ8CVZhJtXMm5vbSHCZnYYIe80oLEgcFCTTcLuS1uI=;
 b=CwEiNSkFWBnX9Iq08NPqzKvHBX2lZFcmmWBQ+Z9EiMnednTPAqq1N+f42vi6VRkJFxC/mWfqp1XDjK7MIBVekVQNLrb2633YdDRPFxprpkw4IMpudUux6/c3hlXEsPjK4uiQIb7a/B1ot4gJMTEXJd3WcOxKeKftOWqjUgCM4bI=
Received: from SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::17)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 03:04:56 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::9) by SA9P221CA0012.outlook.office365.com
 (2603:10b6:806:25::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Fri, 27 Oct 2023 03:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 03:04:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 22:04:54 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 22:04:53 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] arm64: versal-net: enable CONFIG_MMC_SDHCI_ADMA
Date: Fri, 27 Oct 2023 08:34:46 +0530
Message-ID: <20231027030446.4009-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: c61c9c52-fa03-41bc-33e5-08dbd6997f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZebdAMRiOoVFF9KWtbn4mh8rBe8+9vfXygDMLL7mG+08OmORU6QHAYnNC7B/eG9PzsgDPMI2XQS2NkxIt9uFaS0m3dGwHK5AmBtmiTimPgB/fZErpC5uHAbkNPaihzbqGQ3+RiIGzscNAP8D1g71Fe+jWWDa3DUSrjC1cwxoEwWUODPvH7P9Hp0rItqFEYrRlUawti9H7c7bm0/4dY76RClqE/ucOL1HEB1LRRcRPPjVKGpS4RcPXYEmta4F/0XptF7Oab4Jf5dZagKX4NZSmoKgE64aKgM9AbjsRACWmGq1MDXA+4eD+eQn4LMyzpfdSnlq5HC+wfUDKUROTOiljoQbJKQ3FYRH/74yowzuRaoRn1Fe2pbfiaHNslLkGOGtW5PDHjtzIYvw2eIBFr4OPd+BF1YlL/dQLkhgc1zk4d9NTCrcKLr0idgvoooU3ikzedYBfzWOBZGcF+ToO43XTX1SjBSjWeFXLVF/MDMDl4PlhX7oMw3UNaLqbTixjwLOfrp/3w8IeKVySzgLsZvV69XwM4ly8IA2v92ylDlv2Rn3X8lqQi0zXdOjJ8rcGQ8ikxb9H1qLki+6xp4GHsAHdBdi8tUngBjD0LDSQZfBaVY6n27dagsSRHs+nXoa16ndB4Y3r3tYEyS4oKrwfAbSZrNUrdy5hAUITVkuMu7LWSkGCtux/o0PHGc9lIIzq9NZQUhM+kHCZsLQ+YuuH2g7fO8RFtq2UfUlPK56LhnTXcZxAsYGmVc40xkg4r/6rfA6Jd/sLvF1Xk+DtsaPsHoAXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(40460700003)(2906002)(86362001)(4744005)(4326008)(6666004)(26005)(478600001)(426003)(356005)(316002)(107886003)(81166007)(336012)(82740400003)(1076003)(54906003)(2616005)(6916009)(36860700001)(47076005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 03:04:55.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61c9c52-fa03-41bc-33e5-08dbd6997f19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The Standard Host Controller Interface (SDHCI) specification version
3.00 adds support for Advanced DMA (ADMA) for both 64 and 32 bit
widths of DMA. This significantly improves read and write throughput.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index ccc9431ca8..0553ac6b17 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -85,6 +85,7 @@ CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
-- 
2.17.1

