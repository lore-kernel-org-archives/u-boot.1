Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63938C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CCE8070C;
	Thu, 27 Mar 2025 08:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZ+W9ZNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E057E81273; Thu, 27 Mar 2025 08:05:07 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6EDA806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afns8n7ODCgfYPdVJtc3Mlwtrsax+b9F49xXd+47IZ1OEPwppkjfC0QIfHYDP4ScZrVM49nJgAl+gmVcut6bQqFvxOzuUXtXAAATxdGEcBD+rLDIonB1g+qYB3GDEBvSanY2ZbpKEtY5OHb4lYDg0M3KomcmS++3J4t95zMza9EfMsOQMc8CkXFaEHCsF7DxywGVvvNMo2jzntn7mbShzHYBndWNKOSP9l2gkHVNAkyHnRXoVRdiQ2yZI0ZqFsouoTlXLBT7fIY/Lmp21TBr5BAAKlpLCkXamskY8bBWNzDJwXWxLJ4J0InKQkBEkXJSf3sXOXrPVSeFYNCXT5a/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqebKDcnWOHSms5MMNT4PhVRCIE4VVxWoeBwXjWuwQY=;
 b=h5hMvoo4b6X9nPTpx3w09LcB//3Depdqtar1SAB9s5NGj2YPjd8DZ2XbWTB6kjIsOHdrGI9A71eGQNO/uWQKhURrkIe9SOxTBTyKwAVDqumpjvgdBrrPhyGZF3HRw8wAR1gWlTgKZXhgLokJXgDp4jNCNskthLQM5BFPKtWJgImh6zt9DpPiKTXu1CYE8ysE+6+8GBfqaRYRBKdUSFfwGODzVwZgzJw1xdEeUuSW5fdvUhZbWWFrzTw/O6gHU6hteVF47fgxmYief1G0OILzGkhmrE1faNnFkQCcdppVpnI4T2RiAvBOyP0zWaM4S9c5JkYGDiXpjs1KXZS3Y/iEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqebKDcnWOHSms5MMNT4PhVRCIE4VVxWoeBwXjWuwQY=;
 b=aZ+W9ZNkRJEkqES+cV8b46ttwUUxDZOJce1Sf1XuXjw7WNXoNM+F5NVROAejLW3bUyrU9n7ecSeag12lCvSf9QMNSRfMQQWEOHA12dTtK0TVtUJqgYnJAZ6fKEfMycOdid8NYKUQu+oXgckgd46wMQFO1WjiakbKciUwBiGYgCE=
Received: from SA0PR11CA0090.namprd11.prod.outlook.com (2603:10b6:806:d2::35)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 07:04:58 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::47) by SA0PR11CA0090.outlook.office365.com
 (2603:10b6:806:d2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 07:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 07:04:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 02:04:54 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Mar 2025 02:04:50 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH] mtd: spi-nor: Add NO_CHIP_ERASE flag for mt35xu01g/2g
Date: Thu, 27 Mar 2025 12:34:43 +0530
Message-ID: <20250327070443.680972-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4410e83f-0981-46c2-100a-08dd6cfdae4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9g/IdJjB8n9aaoZaFB7/x1roYFNpSHwInv4hAEnJ3uJpLkxFtm71YeBeputv?=
 =?us-ascii?Q?wcgQ+Rw53HD/HYihEbdYhboiYOzwNoGAF6vj7bWcgSV95nJ8SynJwxd9xxlQ?=
 =?us-ascii?Q?zkrei4RGpKHtsuKe+N9fyC3lC85mJqE+wPx2JdJhklutc8jR0Fv90uKbH5Rg?=
 =?us-ascii?Q?YtRLE149KTlM3PlNA64O10u9x6C1tus/z9uloKKXCgWRMhENpXbeE4e1hsLb?=
 =?us-ascii?Q?kRgOSrSBwwCMRYJsahY3/yCXlIUbiq3JsAT4WDzD++U/ln+cR+gPC8YIVNf9?=
 =?us-ascii?Q?SE2fPH5iINlbEck2JFwq7f1ENX04Jjjrt2haLkyvctmptrOpp63L/+IgCIM2?=
 =?us-ascii?Q?bC4JYl0EnTrAfTC3SxUi+Z04PooCwlglHTDQE/stJ+CMVNpe/pk4wagmgk7e?=
 =?us-ascii?Q?NK5glq26lIUefF0lYljnZH8pthQgPL91fdSPcSs2K9hAoQ+16XQJKqWKMuPh?=
 =?us-ascii?Q?kcjjNYkKGRZoEfjoSUt2JBEWNzcqPdDUEpz7KjishOjA+dQbNdLO4AIZpv3g?=
 =?us-ascii?Q?5F4STS22D5qu0yRhxYUFnHjeRx0fWyzGk4gjCyX3sBptxDcpcmHj6gPA0sXU?=
 =?us-ascii?Q?xemJrE6aZykO6vHx8K+AyQANHcVjZ0VJnzrJNkfLGIIXqsh/ylPt6zu7wFZD?=
 =?us-ascii?Q?zIKRrCJLzerK8Mms36I+bSuPDpEARq+cedh55pR4CnuDj99NCd92pKCgRQws?=
 =?us-ascii?Q?DF+Dx0OIiMLqJ5HOZ5FvZfCJPP4NzAm8XfC+aq8pUHHhen8MGi8ZHC/AGrkf?=
 =?us-ascii?Q?EGJB6vFkbvXGxUJJEWN7SvTgWOSH0lnxYiimMgrAYyQGt0CbRQbHhg0fGJJH?=
 =?us-ascii?Q?xpUqTv7z7NN2SZBJyNUjicDGqzk0vf6Qvqmu62MKk4zEKO76yjLk+wKe+CIH?=
 =?us-ascii?Q?UkYeehIfDMiRh6yDioOD3YQcQ/pq2k7xJR7njcmui7fQ2nRpaTiuWiiVhbaZ?=
 =?us-ascii?Q?jj6FqAOucYd5Xs5F0ypJDSyQ4NzwZMTeTfwmiuae3Adox4Y8RtWDSLmqifZ5?=
 =?us-ascii?Q?9XVIynotVjugFqWKyQ8hvlUmSbKiUryNlJcG3p4uq4sSJ8POXUKcu3s2i2JQ?=
 =?us-ascii?Q?F/p23TPtLVltdW4PlEMvXlLMFJy/u6qF7NBnNqR6e+AH1fRJbrp1l+sJ+qk/?=
 =?us-ascii?Q?tko0G+IPaQXcaouI7F2HcE8wWOTch6wmsihej+zuPkuOa8V/1j5IAdpjWwri?=
 =?us-ascii?Q?UIIDRsSL8FXtfoZ46FtHzgW75grJCzfqw5EliE4+eGeyZxXssDvH2KBIh9N5?=
 =?us-ascii?Q?LifxtL2PUFDLFSc3+h3G2o8A8Dr//sd0R9YLx2M6jzgJZXaAxUDy/EZxwEvg?=
 =?us-ascii?Q?cjOW52TG0sEzvNZzcfcuvAwU93kuQaUxxsLtlU3/nu4IMfXCLhCDVyJRTAQx?=
 =?us-ascii?Q?kfnX4qKrCtu7mJ7TFGAq0hZ/OErBbY5vB+wYylhG47rz8f6ZQnG/aSoHrKLy?=
 =?us-ascii?Q?aHbpjyrweVb0c1QS+ndfv6q5yLUeOerJhJ/sTZQbWvpWu4jk2oItFO3TYXgk?=
 =?us-ascii?Q?WUNsNkuRgEsFTFHwumKrv2UHjxszTl2iRMFk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 07:04:56.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4410e83f-0981-46c2-100a-08dd6cfdae4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

Since the opcode SPINOR_OP_CHIP_ERASE (0xc7) is not supported
for the mt35xu01g/2g flashes, the NO_CHIP_ERASE flag has been added
to enable sector erase functionality instead.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c9484..44d08752011 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -358,10 +358,13 @@ const struct flash_info spi_nor_ids[] = {
 #ifdef CONFIG_SPI_FLASH_MT35XU
 	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
-	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
+	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 #endif
 #ifdef CONFIG_SPI_FLASH_SPANSION	/* SPANSION */
 	/* Spansion/Cypress -- single (large) sector size only, at least
-- 
2.25.1

