Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B739C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3E087FAD;
	Mon, 11 Mar 2024 18:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmkS5sTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D42987EFF; Mon, 11 Mar 2024 18:23:45 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F0C87ECC
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUMBnfU5tBd3iih02c4mj6QU46DTqdsq79/ytcAdrihkHixT3DcZBvNTc7NUwxMScuT4nS77lLYWxEcoFnak3I4Zz0G+LjgSYmeqyI9zdBcJzWmM8Ms6ImR/GAoygs5mgRLRmrkaZxE2UnqfUctobU3hBBITk0dKWV1m3S8feNW397jBikqoG+8UNb7IwM9dWOognoHN3HDDl6KpUxhKyZCm6iG7WA8ClLSa1ajDYyvyGHx51OypysSAupTZ8F3itFi4RHdaHVBdV79YuT7wbX+PaIw0UBqOOZBII8CIFn52sMLDnuPzZz2D5shvO5FPl8pl5fmG9om/ewJgvHNrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMmdtpb0UkgC2YpoLdIbkruh/gkC+F9eYv7WKtval/g=;
 b=FOJvucjG/M5kXhjmcTf+Re1r8SIdzZqxfb+jA4SwTc9hYGAkI1YJQCTfhfoUgUNWrmUNsRUYpNdIofhR/qjcIn7JuCxyVnWDV+5r/FyWAYL2IfGZHScrgek1fyVoTLESITmtRLdP8ZKroJWyPGRFsuGhPDcbmEpXN9UxXgncNUioLDk4ZpnZxJ2E8m1oTX825jzi7qk9YfxOztaDhxNkldf44qtXqHWPu6mlo//co4MqgJt/+GCvS4yiMCnyqhA1VzKPBinJd//wfg+L02eYJjXmYXzbGjHHA6hB0RGNX0FAbzCTCc1zMSmlyKnyhWSCbRz+IbwDHMca2uMmwF7rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMmdtpb0UkgC2YpoLdIbkruh/gkC+F9eYv7WKtval/g=;
 b=qmkS5sTjZZFEzyAocZ7xh7Hlnr9h2jr7J0qf5qVQWTGP4iCyIc2nRQk9fx2Vy8ImCqTaiUh5kyvkmfwUr4CkN3fqedhhCC0sk6NdH/ys87UXewPLXv1Vanr6I9TcpdxCAHeN4dgD5oAvWfz+6c6bTG/qcAkPmpBZ6t3e+t/hKL0=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:39 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::5d) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:38 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:36 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>
Subject: [PATCH 16/19] arm64: versal: Enable soft reset support for xspi
 flashes
Date: Mon, 11 Mar 2024 22:52:46 +0530
Message-ID: <f9a665e922393c39ba77ebb50d26d34803602004.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 232b9e09-660b-48a7-f031-08dc41effdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyGVWT5mpoHtP4XgJfqUMYBk6nLI7hYUn2prjvmkWXVNMndJk3KJ6FJPXI9gssRWrDkiI7pPDtoSdduywpqCuXichN2kBENxZvTNtGgN5ZpvzMaTzmmYzFeC2/ORsd2u+gLZBAYI5Pk2UNsGLGOS7SZCOyc+hoWAgn2ry9bNU7ULc21NGvmiWJPpykhXXhEvGo+zN9Jmv+i5w7D67KZGRVRy0eSrl8gBZlcUyPRsVkfujJJaS3buN4X9SJ9ZrJZ3h9lNZcPYK/U7u9mIuIwSKNe7gR5wYsAidw3nBEw61vn856eshUgDc5kPvRPeO900sHssyFAglMAtRBxaw1z9VKqxU1mBS+HYBE2lS9iW6urVZhXIlotMZGFtIxRgqMiDxI1IpZOwZGHVjF83zEI+vaaR3o67wcXXCf7XnLMnkf6tCowMGYX75NSwD4S5IwcaIWkLH2vSyzgXQfEndk7lYb6LYY4zRvGipqJakSq6H/ArBVoc8W2bKevf61yc4ZPBJuvQBBWQyhiM8p/5o8C/+Ys28525PsSJxXd4NwPNLZspZv3zNwruEBw3pBSyjkCmijOoSazPqu4uXoYJZ1IrMrcVBwClgEZ7WjuHmXuf3lkba9AtnEnK8DGXFTqYCIb9wXAsuohXQ3V1lPtw1qZLdnM4+Dzna98tiDqvBzA2tJ17pWpocXaZGXQ7d3hb/IPOzJyV0i+oz7j3yYXAC4MCAiq4+Ho/pzB6d1EkKvACFzwS/vAXvGDms6erJW+m0GaE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:39.2598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232b9e09-660b-48a7-f031-08dc41effdf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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

Activate the xSPI Software Reset support, which will be
utilized to transition from octal DTR mode to legacy
mode during shutdown and boot (if enabled).

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 78141bd45f..92c95e6b5d 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -93,6 +93,8 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
-- 
2.27.0

