Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF63C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 05:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A19381FEE;
	Wed,  2 Jul 2025 07:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bYOd/JzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743698206E; Wed,  2 Jul 2025 07:40:21 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 275D681E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 07:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLVoqmU9+9sG0YgGYg9izP0Ue7G2L38F5JkO0WrGGq9jM/M0eAw+NYK5r2DCgUpoDHdDWNFM+Wg2xL9V8ukKm6ufxoVFXa03YT+7HGmpJeWL1EH035VLr39Yt243TWHsxpTQPt8Zw+3LJETtn6H7sa/GI77HJ25FOhXgx3QpLlH81NjNn0DJXGJHWIxvN2Tcv+TEiio1unezNiGhIT+sghkmmlfKBf+22C8qiEItQzTuaAoRaiQDSYtVtfYNAq6TXyauWbnER4SXe6+1PeJsIGK68k7A7DOr2zUy1N0yedtlus0QukG2pViGwHmnhgUmVpwNYKOvwdhhz3fgD/+hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xm2+jbIb04WHxZX4EOZgKt+7Ln8EkNiMtIpp6QBWbM=;
 b=bmhnvGh71L/UG6YqNc6SeQdO1USYM9RqevXI/Ckijnq80gnxguMUphZ8hQNuxUeSm7qeThGky5gwxrzbpeVQimy2Xe89TF7MLTtmhcNWWYrrR9fRJW993XChysjR7e9jrtU4GMAneyk/bAmNcUKWKPbvpFv/2y5szrapqjhPvIu4Ej6xXb82Bd93j6isX1xf62trvaivS3Clq+hRQdws00VxXuIHWtdalkOvdQtsX25Bvfrtw5xgOVzKyoh82v5GHFDTYRh396ylDgz04w2cGE+NtVW0xL/y3JC+fIfV5YMVy8Bhq+Na87QwskAUWcCHHSpIto7TFhE5B21QmgxiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xm2+jbIb04WHxZX4EOZgKt+7Ln8EkNiMtIpp6QBWbM=;
 b=bYOd/JzH2epEQ6lVAq03ofWeq4a2YVI8AgYTE5YIfNIXrEKnSyW0XtOiIXUJL+dESj5FoeYZ5GOA4IeQgqx7fv92/hVPdqBUmVwXBZ6wjM08RPv4dnOAYtrZRduJtGVNt70ZwrVoEzv8mHYn1QxsH5KoqSLeut8FK0h5IRHiMAo=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 2 Jul
 2025 05:40:15 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::20) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 05:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Wed, 2 Jul 2025 05:40:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 00:40:05 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Jul 2025 00:40:00 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, <marex@denx.de>,
 <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] cadence_qspi: fix odd byte read issue in STIG mode
Date: Wed, 2 Jul 2025 11:09:53 +0530
Message-ID: <20250702053953.640046-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 59323a1d-469f-4d45-00a7-08ddb92aeb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?noeiwyj9Z48HGc9d422uKKxgZJuOp9WTj/39pG4Nmw9RkOk75zHoRi7YakKv?=
 =?us-ascii?Q?m22EV5S1/FZ0uPFOUFJH11u9SbCdEVU2J/NDeWIjaMGH4RLbyUC7wkOZ6H+/?=
 =?us-ascii?Q?aUEvnwxElR8Kg6gPf3d8gnTthtxY4bBxj+B1Fc6W28gHidBZXZ9G0A4lyJcp?=
 =?us-ascii?Q?bixhNIOx4TqYZUxO1Sw7wJjfiQFpzKNg6NJ54yA7F9XaH18YOlqPTRbIEL5l?=
 =?us-ascii?Q?Iy0oMxCfMHQTSQP4Z6UGzsSWCb3YZwaFCFmDJJ/mwo9wVCw2mQXVg2bMP6jS?=
 =?us-ascii?Q?Gslc8pLewd++oOm3GR5PSzAhMRyB7EDW++3q0gYd1zbbpGQM2VVFixTZxDW7?=
 =?us-ascii?Q?wZXgdZnvXXFUVK0+plpGnesPRUmQaS8DqjG1hxfHZWYBQ8J0QbDrBTxsKzdv?=
 =?us-ascii?Q?tX1eAnvFmaVjytkBU76DWP2CsAuiqog2pxHpBgnLSkxWWKKfqc0bMoFXir9/?=
 =?us-ascii?Q?4vxD1obUqxxQThklGi4ShWWmHJDbC9ww92hJVVzSHicDZU2oj85ZwhK77QQs?=
 =?us-ascii?Q?EM7rFyN2aPtEZIGnEo2mqCRqpmRQGSBdb/3s7RXjdgH1LOwo7miexHT7GF0x?=
 =?us-ascii?Q?3sZ8NYKzQ1A7ioxZmlYoWothO2Lyx4FrnzRC1bOQ7r7AnU9sPxJrbaPTE0jw?=
 =?us-ascii?Q?2QHO6QdwaNBY7oMAML6D8KzWnSBftaBx1/CM+LhBdtQxyZ3h7n0pzKQwkQh6?=
 =?us-ascii?Q?BlJR09OQj/HUCEYSAuHccC31cj95aRALSm7g3SZG5EwpPq7Q54wPUJkh1Uut?=
 =?us-ascii?Q?oXKUYyYPQ6NzGETwMUgXqWvmZa949X7hs9ImSClBf+EAvWa3q0Eik2qpBoMC?=
 =?us-ascii?Q?bXH6HYGBqeZTT3wByp9QfRNVVb4IkGknz3hxdvIA5GWknFMlikAXOPAkgbjC?=
 =?us-ascii?Q?YseVjeddf+uxsbcZYPxp3oaT4ejF5kNV7Ufy7aTW9rfLcfVkaTWxnL74VTA8?=
 =?us-ascii?Q?iGFLaeqbkwkMW9vGkTkTiKRU+iau5Vy0aAzngsn3KgeDqTXDtN4M13VZA0vh?=
 =?us-ascii?Q?xvt/DMpo0XkQuw6W05A7Dz7Dr5dvOsHR1Loc2OJLKu3rw00WHuk1IlZCbYwO?=
 =?us-ascii?Q?3488z2TeaUzFtvMUbXjtylAiViWtLlRJOqW2bUHbdTzh0qs7X0f63LaZXmYD?=
 =?us-ascii?Q?QBzwUyy+1+ffQ4t7d9BVumGE2qFiw4iI8UZS3vtAUXtL33wiVxyI2E9zha4A?=
 =?us-ascii?Q?aAeoFFH2EMoRcmut/JXXhNdjsBZjXYbPSBIIdEKRX2gw6coJQyxHacBh0yyX?=
 =?us-ascii?Q?U6IGbvPhKUU1tzHmZXtWowAOB/846u1Ndz7bWnbYOBnEzLBDhqJZjjnco5ob?=
 =?us-ascii?Q?iAV8WFtwt3rGrZEXJhEWlHrf6TR4r5uqPD6tEHXXHhEVML4sXyN2A93x6EBN?=
 =?us-ascii?Q?J6NxJsq1dcXmYj0NFFvKFznkldm3U23G9JWJBkVz1XRxx7nWmRPMV3JbClpt?=
 =?us-ascii?Q?pWbWtJKKdunyj58+sAwnRjlDmt81/i7h/zs/wSI7ltxNvMmo/JhdvEAAKqb+?=
 =?us-ascii?Q?OaHMgJvZWlsV33O8qZyKZfm2STFNTdwqTcea?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 05:40:14.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59323a1d-469f-4d45-00a7-08ddb92aeb3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

In DDR mode, even bytes are read using DMA, while the remaining odd
bytes are read using STIG mode. However, the data is not correctly
transferred into the flash read data lower register because the
supplementary byte of the STIG opcode is not being written to the
opcode extension register, resulting in incorrect data being read.

To resolve this issue, when using STIG transactions, the corresponding
supplementary byte of any STIG opcode must be defined in the Opcode
Extension Register (Lower). Issue has been observed on the Macronix
MX66UM2G45G flashes.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 12 +++++++++++-
 drivers/spi/cadence_qspi.h        |  4 +++-
 drivers/spi/cadence_qspi_apb.c    |  6 +++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index fbeb0c6a85c..6dc6fbe5a5b 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -20,7 +20,7 @@
 int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op)
 {
-	u32 reg, ret, rx_rem, n_rx, bytes_to_dma, data;
+	u32 reg, ret, rx_rem, n_rx, bytes_to_dma, data, status;
 	u8 opcode, addr_bytes, *rxbuf, dummy_cycles;
 
 	n_rx = op->data.nbytes;
@@ -87,6 +87,16 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				   CQSPI_REG_SIZE_ADDRESS_MASK;
 
 		opcode = CMD_4BYTE_FAST_READ;
+
+		/* Set up command opcode extension. */
+		status = readl(priv->regbase + CQSPI_REG_CONFIG);
+		if (status & CQSPI_REG_CONFIG_DTR_PROTO) {
+			ret = cadence_qspi_setup_opcode_ext(priv, op,
+							    CQSPI_REG_OP_EXT_STIG_LSB);
+			if (ret)
+				return ret;
+		}
+
 		dummy_cycles = 8;
 		writel((dummy_cycles << CQSPI_REG_RD_INSTR_DUMMY_LSB) | opcode,
 		       priv->regbase + CQSPI_REG_RD_INSTR);
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 80510f2542b..879e7f8dbfb 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -320,5 +320,7 @@ int cadence_qspi_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
 int cadence_device_reset(struct udevice *dev);
-
+int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
+				  const struct spi_mem_op *op,
+				  unsigned int shift);
 #endif /* __CADENCE_QSPI_H__ */
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index c38bb523806..ecfa4ca222c 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -380,9 +380,9 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg)
 	return 0;
 }
 
-static int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
-					 const struct spi_mem_op *op,
-					 unsigned int shift)
+int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
+				  const struct spi_mem_op *op,
+				  unsigned int shift)
 {
 	unsigned int reg;
 	u8 ext;
-- 
2.34.1

