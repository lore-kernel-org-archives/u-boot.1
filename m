Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11ADC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 09:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D0787E8E;
	Thu, 21 Mar 2024 10:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywEjU8FI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6314A87E8E; Thu, 21 Mar 2024 10:26:18 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BEE879F6
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSdSLgUD13BETd7MjvJu9/wEDszvMnfd8mKHUsCFSoTMI11PIcnGxrgL15GN5aGxSnOmzaYqDD6sHaEJCchDmNvYHsf9YEMEsb27l/rRj9K4RUzkyktA5YS8KimfqP/ggJbEbXvsFmqYLqX/ncnhULb8fxAPvzGBlttgI0ZPHk2oco2xPzp8SQowBESA33H0dAbpP21i13U3wE/CtxSiPkd+40xo+KF3desVCeIinnPtG9X4igbWOoLgusRZc43Rg7Vt/pt/7kiasMXrEO1YECcUtaJoIEYyQDAanjxybQ7UlHmIL7FqcaB0+b3Vt2nAtA2PP8TPqiawOpNAE7TT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgtalUM3rZiEQPgCSYYl914PErxM1ocxPAuqkznh0K4=;
 b=Aeg+0iWmvizFnMIXxN/gTGFSFtynpPdY0ljemfNaNQbPSMjwVfwGE3H0Cam8yb4ioUyuwowtfmdevW0IgjxlGySFSIBhWHVN501/VOEh5vYQabZvNOHya4jt5Cj6tLzJS0oNZfTvFE2OZaJS3yI0De/yV05LK/uW/zEBRKdplaaGkfoOULQrtG6arCd/bQIgkMKB7FcB3L9g3Dtq0fk1dzFeC8DGh6fWOesTtHu9EeTbenqvgyIe/E26nloS1dvnb43mVF3lfvWmirufqbi3JPgPiTyItWXCrOe6n3I+D9+M0CRAP0fuSBxTT+jv8AyYCQMH/XL3V5vfDEUXoc3Vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgtalUM3rZiEQPgCSYYl914PErxM1ocxPAuqkznh0K4=;
 b=ywEjU8FIGbBvonqeRKTT+10wtFrxbd5Q5gnBmTn9d1jkOrl4IoYViC7AjlvMKhSbZf2u3zyH7z/02J8vJ46vsdjSePwsB1a1oXG0fYgKSJYfqmCEz3QM8M4FuQkh5zJ9OVzjreuvC2/odbauTngSTtH1i0jWCHK0ufZ9e7sLUXc=
Received: from BY5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:a03:1a0::18)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 09:26:12 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::80) by BY5PR16CA0005.outlook.office365.com
 (2603:10b6:a03:1a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 21 Mar 2024 09:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 09:26:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 04:26:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 02:26:10 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 21 Mar 2024 04:26:09 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>,
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH] configs: zynqmp_kria: Deactivate CONFIG_SPI_FLASH_BAR
Date: Thu, 21 Mar 2024 14:55:57 +0530
Message-ID: <20240321092557.2939231-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: ead366dd-b681-49cb-48ab-08dc4988f321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFbx+eOQkVX3Q1B105+w3AJO9znSO43b6rdGACIfTKsoDyxSKpZBZOHDIlVITFB8LI8pyKsyz7w+RImdBqetYl5F7/Job0iSMeSDscDc5yz14c9Yi6MKNd/J9SIpdQi+vQVh41LnGH95q130XZvmpUyXm6kqMNb2zfP0THwWPPf5YDCD96eGDsgRckILnMudiiyC/19psZSJRCVmobpjEkfb4ebE3XfYgfzhzH5Z91AkRcsntW76Dwz5nxzn5XK1kNMizKMIcX0Mq4muBkltN/yzgDZJ6lUtY2a7An816Wy7Bk+IKptT1mWX9FyjQzjY3AtfjzX7v/qJfdKVPsNav+zYCSyUl8L2w4Du6xfyzXDBnCJZfNq9Zcy9xRKFYwU0ffI0XpIK49kLr/1riY+UTgSFp0xu79awfpcN1KIL6rtHHMcTXqr7BqwijYriaxUsW98fJC0IEFnaQpb3XPQKaZuQdL+CGacAoUHsxXdDV+JIAZ7zWk3UqjkuVhpaXI9+S3B+i28U+DUyjIWfCQtZoMBg8ddKOjPIAuD+JwPQFFY5zaUZKlTER6sBPdq9U1RNllq0NFQBHf1KSJjJxgspgeV5j8YCmFzXVbkwhTIpDMuSc7GM6WL2YX0jyFv5y1YVY63dk9xsMLc/t8hDE8sJEvOxXYSgw2i0lIZgNUrrwh9IT7f7XOZX/h+6W5PHmnV32SxmDGnRrpn43+4SuDFt1lhTlaLR+fR6uBBudR+2RX/zB7Lc5dOIwGLhShcEoUNE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 09:26:12.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead366dd-b681-49cb-48ab-08dc4988f321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

Disable CONFIG_SPI_FLASH_BAR, which activates 4-byte opcodes.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 7cb8b62d32..7af8b27be9 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -155,7 +155,6 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_DM_MTD=y
-CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
-- 
2.37.6

