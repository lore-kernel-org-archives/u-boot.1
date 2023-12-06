Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60890C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC95886EEE;
	Wed,  6 Dec 2023 10:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z7/hcXFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6325086FB0; Wed,  6 Dec 2023 10:32:06 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E53486CF4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q75+0/zoy8Fi/dbbTYCnBIKEKmGXBFy4nMfhgZGJTpnE/JvER8JUnETsZKv1d0hRZdHAHaOjtEugsMzzclvHKk5/9/hQQmEc0A/F0dnOQQNIbRUw0ZlygyHGR8ElCf5m3vefQNwnG2KSgyQBT5NxSC13oi8dpNvbtDHxeY7po8ASbOgGwj/fFQOMg/Kf9p5XwM4Ojd+oJyHEU1VXUC3KJQxflrtiNiqslwJaJ2WYfOHgNyt7XEolUduRELxjRCH5si48I3F+KcRSZkd7hoEDY1+rmGCAaESg0rZISrBEvV7ruVAgXoJ2rtl1rOPf/z0wd180yLGMV7hN+RdoQ+WQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQktOBXApMvtN7i7URHWTj6cOCmsb+sM4fC+LzSSDqY=;
 b=iXpmBy6aYyCUmxeM08OrCtbwwjXb5cp6VVgi4KuTQd0CrYLtgCcL+0XRIK70vjwJZ+5N39oGhBeREttezfEuRAEQ+WgMSz8QOIwQK5SFrNVb+WuUi+mIuL0bmpsnChGZhhPAvARIVtruonHK+TXkMXAUC8U0vZrdMtqPQCNTGUCtyy09wB87yb+AmOxHlGRw/x9RHwOstnDkzrSQKagRZNYldLi/UtBAWjEdZxun1t97ZsHSczg9wVVMysj0CufVGbbf1/IIL8sX5PXkuNs0b/4ug6jCeaLqda3a95bDp1v3aQlA9r6CnRVOS9TaykIHvBdEGSgNtmt/BpgtmH/fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQktOBXApMvtN7i7URHWTj6cOCmsb+sM4fC+LzSSDqY=;
 b=Z7/hcXFvluknIhlCE1S/FRAZCyxTqIETENK0tLjzV41bdDpM1a7AlIOULhsOPWmhSj1x159sr+ZyFuEkTwmGx4WTzC/54q4yyKetXtGQ0T/JLmT+ouRCBdMgkhVR+InWRKocxbxF4bHDRQP4K/QUUez3FV6m31yl+2YcaUTbDjs=
Received: from BLAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:32b::19)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:31:59 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::a2) by BLAPR03CA0014.outlook.office365.com
 (2603:10b6:208:32b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.22 via Frontend
 Transport; Wed, 6 Dec 2023 09:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:31:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:31:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:31:58 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:31:56 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@amd.com>
Subject: [PATCH v2 01/30] mtd: spi-nor: Add config to enable flash DTR
Date: Wed, 6 Dec 2023 15:01:12 +0530
Message-ID: <86732ea5dfb703525e50bfbfbdeea188832611c1.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1fa56b-5736-4f9d-5233-08dbf63e320c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+kENnNhsYGA11wG1STo8/IPe8z4NrQuIMIvJRr38iev2MO0l87d63zHC+HM3sUGeNDOSMsCuXhG++BqH4q6IaZEhAv1gmlzHbcND+LU0s9+BaSG48BG+g2ictJeykNE3zMiUYS6gMsXLpFKVV/E9aU6hPB/VMQzxBEH1p3Uar4DvtqagkAsiqkVslmWeI1LYqSYGNlNy1OaUZ/BLcAmf6SsVfB66pXSncclwKXLnYfGqbu20DTKKnmvvTmi0WXcUTmdHlXgdhrFDgBnpqTU9o9hj6w4jvPFGK1R24Vb8xvbACeHV9nhbxeuDwlqFGDYJbl9V9gTtRrXcDE7qJYbarc1frSPhi5jYq2sUTbcXm0QNb9F9tldHo3XDjx5JwSzplh6CkSVj64ylw1Fcuqb3Uh7Rhomlvrs6og2ACpaQiSy+x62zB/d+z9frvlM0gTXT9HFJexGa6oqQYcD6FHeZl/jtZhns8l/WAuHFwntYUUjkAWGxEaz81mCQhdqEyDrFOC3XT7M0TwL0DSkH4xSadsTL+VB8yvoJzb46E8gwwHN0fHg+ZLc5JOeXh2ugJ1r/XiKobtlor5mSgHTmH2VFoLHZ41XARtGIdbX5pSLJGiT0N22XhU56gSFgDro1fMNTZiF8BVYi00mgchIyWZtcBC4qHfx0Yjqkx+/TV0V3/x6cvCLJAzI9qgYZRDp4DT3mI7pi8Xq6AxOZwmyLPrd1u4i32m/NoysAbGa7gy3/gHcWvIICYryrvb+Re20iLGwxd6BppCHOL1SguPqBK5DMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(2906002)(5660300002)(82740400003)(83380400001)(336012)(426003)(6666004)(26005)(2616005)(70586007)(70206006)(478600001)(36756003)(41300700001)(54906003)(6916009)(4326008)(316002)(8676002)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:31:59.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1fa56b-5736-4f9d-5233-08dbf63e320c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

From: T Karthik Reddy <t.karthik.reddy@amd.com>

The spi-nor framework will set up the flash parameters by
reading the flash id table flags, which include cmd opcodes,
address width, dummy bytes, and bus width. In case, flash
supports octal DTR mode and the controller does not support
the DTR. There is no process to switch back to SDR mode.
To avoid this issue, create a Kconfig option SPI_FLASH_DTR_ENABLE
to explicitly specify to enable/disable flash DTR support.
This config is disabled by default.
Do not initialize the mt35xu512aba post sfdp fixups unless
SPI_FLASH_DTR_ENABLE is enabled to avoid configuring DTR.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@amd.com>
Co-developed-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/Kconfig        |  7 +++++++
 drivers/mtd/spi/spi-nor-core.c | 12 +++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index 732b076045..e0898074a2 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -202,6 +202,13 @@ config SPI_FLASH_MT35XU
 	 because the fixup hooks for this flash add extra size overhead. Boards
 	 that don't use the flash can disable this to save space.
 
+config SPI_FLASH_DTR_ENABLE
+	bool "Enable Flash DTR support"
+	help
+	  Select this config to enable DTR mode by spi-nor framework.
+	  This config provides an option to explicitly enable/disable the DTR
+	  support even though the flash id flags specify flash supports DTR mode.
+
 config SPI_FLASH_SST
 	bool "SST SPI flash support"
 	help
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 5c3ffc80eb..473d9f41f3 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -2962,7 +2962,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
 					  SNOR_PROTO_1_1_8);
 	}
 
-	if (info->flags & SPI_NOR_OCTAL_DTR_READ) {
+	if (CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE) &&
+	    info->flags & SPI_NOR_OCTAL_DTR_READ) {
 		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
 		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
 					  0, 20, SPINOR_OP_READ_FAST,
@@ -2978,8 +2979,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	 * Since xSPI Page Program opcode is backward compatible with
 	 * Legacy SPI, use Legacy SPI opcode there as well.
 	 */
-	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
-				SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
+	if (CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE)) {
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
+	}
 
 	if (info->flags & SPI_NOR_QUAD_READ) {
 		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
@@ -4011,6 +4014,9 @@ static void mt35xu512aba_default_init(struct spi_nor *nor)
 static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
 					 struct spi_nor_flash_parameter *params)
 {
+	if (!CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE))
+		return;
+
 	/* Set the Fast Read settings. */
 	params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
 	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
-- 
2.27.0

