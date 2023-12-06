Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61644C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC5887630;
	Wed,  6 Dec 2023 06:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ocKrAaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B985087655; Wed,  6 Dec 2023 06:29:54 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A7D87494
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE/GvKM3WRGviYRaMXM7JvVH/yVqEaD8xM6Rtywk3d1Pw3C7KK8nmnKWWKkSKu8NErH7wwFYtQH2tbL5ZALfWvlxti8qWFImGdC5Hx9mFLn9ceD4ylUW45FPIJi/DyYxeKJmu/0tWsgOb4/JWBLNqhAEFOKjQhH/dDQ+87DcxYzFRZsjdbbNAFw5+AMbIv4gbJcKJnSjfS56vZgYz999lgIpObe03A9v+Q5LJEQUHy7EkNNsaMm6kyQl6l0Wj2wrLo79xlT+PWCD0XFS3PH+kxuwXbMyCTQWYzhEK69lP+qCKC7yyg/0QfTmx2hO4k9lgMXpuqiIDGjz4/Igy9ZJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQktOBXApMvtN7i7URHWTj6cOCmsb+sM4fC+LzSSDqY=;
 b=Yx7IrSo661+ISJbiiEAwY8vaE4RoBrSMQMmeXA3SGBcSh0R0ielPjwattQJZdM+GpgWho5stRWgo6jhi0MskQ96BpemkXS3rfl2DYqRDHZM2yi0VcU9qKcyEPfSx3OrU27CtUxeDNCcHhkGcGorfhoC6VFIyNCGurb50b7RXGzShyhFY5faDPUrpNOUc14NEEkKCqvR9VSS4UvfZwSzxsgoFKq39Ml498trEVmfaifZ8ITgnX1rrDNs9Efonq6LdcIGm1YXPkMNuka6D7sOQ9EhnBhtMMzinQLXXgJneCT/q5OZlWzUUyj0EeNbYL1SBhJvZBEBgTNU7KzIiiHLztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQktOBXApMvtN7i7URHWTj6cOCmsb+sM4fC+LzSSDqY=;
 b=2ocKrAaXjezlJO2Dp6s2gGVUEHxKkrZoxvWlgCeaz/xM3ZepuZWRM8zbGUxo8OWUaYS2eHPUoTr6/bJotpDOoYdi94RSgToVLMSQuVkiLYHkikHvzv6cqbsGekX9S6abrM9RoOclKRyv99hfuqWqGAegB/P0TTsHRziedOzBfHs=
Received: from DM6PR05CA0061.namprd05.prod.outlook.com (2603:10b6:5:335::30)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:29:47 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::b0) by DM6PR05CA0061.outlook.office365.com
 (2603:10b6:5:335::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 05:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:29:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:29:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:29:43 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:29:41 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@amd.com>
Subject: [PATCH 01/30] mtd: spi-nor: Add config to enable flash DTR
Date: Wed, 6 Dec 2023 10:59:34 +0530
Message-ID: <20231206052934.3744128-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6628f383-62b9-49e6-f0c3-08dbf61c5c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7pui3OkbR2lwiipzc7u3G8MFZEuCI5orrZSJa98Gb2Jf7yBKilAxa1YvOunkbJbWQhP8aZgEuHj8ErpkMblkvLqTNsbjYdOXz4U0U4UJAiosvww24wnaNbP9anTYgDEDDSZ5HKfvYvWGlLkALKKHMQdZLcM8vE4CXi2SW5RkaCM1hqy8+wMV85K7kNPIa3pilbGaS27QEmOPW6WuPW/cmCweARVdQINX3b9rP6gB6R6gw7ayMRm9WesB7Yi09F2MoRx1h0N2pRT0KbdvUcwa/bNDeQkFj258XARk7B9B7Ivix/GcsXBi/4LauLt9bZoLBZSVfW1OxBTbLMhY4Yex3EBoxbzxGUXplNCOf9/j7IH6O3vjT5Ladd0P6gtFdHMOPipksqSMGfahZS41apzxw+LiCiRGmEl0nDvg3w2FCKP33tjoQwcAiKL/3QErR1d6M3jgCgSxpx7sVnHuWbeQ55YfYzr5Cb7ShiUDRgIDbJMO+QghQHVY5/gVcfUpWrzYt2moCHhegeuSMui1J/07gaQjPw7Vk0rleicWRM6X4Y22U0FPlBG9p9daVbIgJFdF28OTM1lbf8ek9f1QnqHoOOr+luBFsmDRxG4pfWkM5eH2zheJLzZ+QkwRlL++xHjqTocmbMdSeAOuqU1YWWJwpyRO9sSXGPsKKA8ifh9AeeEB+KY2YUlsOA2PMwuVmXm7A05pNKox6BEolVBR9iVlaywxyNPuap5W5o4jLcJj0+hsF3Fll7z+QKt63osKFj57UiWk3SFqQ2ApjZ5Ys3ycw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(426003)(40460700003)(6666004)(1076003)(2616005)(26005)(336012)(316002)(70586007)(70206006)(54906003)(6916009)(40480700001)(5660300002)(103116003)(2906002)(4326008)(86362001)(8676002)(8936002)(36756003)(41300700001)(82740400003)(81166007)(356005)(478600001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:29:46.5832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628f383-62b9-49e6-f0c3-08dbf61c5c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

