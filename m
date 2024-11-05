Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE9DD1CA3A
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 07:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1209A88EDE;
	Tue,  5 Nov 2024 08:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XiqvabH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA4188F68; Tue,  5 Nov 2024 08:11:39 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A08888EDD
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 08:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUINyNwKAM/ZNxGuEjeORjQHcAxTS2qxk+bGNJ+Zz/bHIAlXGbZj9PGhXSTyfMFZADJ6RaH3/si6qX310GUfOaFuojuawo7fciw/l6FZkfA7weAFf4vDQxmyPBiRTcYZ8NAtspOGxHE1Xjp1VUwP+xmwnk2ZvtVxPQii0lH+IZwyzeSmj9/dWm/+mNWReKkorTKg5XXqCpYUIxq8IU+7nDAa7LS+V84QAAz36Zgnb4s8mqDVeywIeNK1WX/MJJVtGBjeb6cCFjpA/faeHPujRYnDc6B6pEz7YcH194x72T939K0EmKBP/vwN2uq5BCq77/bKOTcb8mOYNvzswJfYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKFfMZmBhoXFK1piQYIwgRSujpn78f0oeR0qPri/qOY=;
 b=D5raOSCY4UB6D6a1Set/z9BQSe4BH1/hK9OAVnjuDPK1eFtZ6vry5uCbdrKKDi4r3jhpG+XfXs6EDU6k00slC+U6JGrgr4USWZlOWDuVU85YGOomsuVK028DnmjY2Y32x3ZPhqGWkVMtOf+NBJDckRFfCb1UFuNHJ/WxSMyhhAJCpZjQUN1M7JJ7IxMzFJIqVwlfDhwM3Gz1FT+Kd8c4B1r3aMGZ8eAAuqVEtZSKNjrH/Z8+xl4A+Qh7DFZts0A/5ghs6kstn1dDL+h0UNOas6Tzm0j0hVNtZhPf3nTOqHr00pdjPWRKuC3jKzZaVOIFfyXGITIU83c8SbqelGBauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKFfMZmBhoXFK1piQYIwgRSujpn78f0oeR0qPri/qOY=;
 b=XiqvabH4VEj/1RV7pc3fjy53+GqgbJwPX5qZeDxpdy/JOALY7wA74chMmw+bYJFsXFTw5g6f8lHRT7PmuP1x3XyGUgZUatuL0POHzFvKjSPYa3dtS7YTzuCBcMlZ8Jiyztt2RcAhL4XF7x+197PgnfOQOe3HthPBjF+0mYZ0DjM=
Received: from CH5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:1f1::20)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:11:33 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b3) by CH5PR03CA0010.outlook.office365.com
 (2603:10b6:610:1f1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 07:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 07:11:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 01:11:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 01:11:31 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Nov 2024 01:11:28 -0600
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] cadence_qspi: fix odd byte read issue in STIG mode
Date: Tue, 5 Nov 2024 12:40:14 +0530
Message-ID: <20241105071014.188568-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 375fa52d-ce8d-40d3-f5ec-08dcfd69144f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SQJtL25Jt8ywQcRXXl14izEN6KlkKW84rcdNxIbPepc1SyS+If5VCG7elynm?=
 =?us-ascii?Q?aBuQx4jnGUf40yEcu8hv5HK2IrS4llETYFxpBsIa3FTeWXQ0fz15KRfOGPlH?=
 =?us-ascii?Q?Ku1mavCfRtsSYFjkYXXvT5beGD/vdVkic1bJQCvR0zT54qxEpsc19Z8jVxd4?=
 =?us-ascii?Q?eslMsj+4DGfnT4rJJh4oOCppGGq67APDXO4h4GmuccZvQ/FQRajCPrnVQd+b?=
 =?us-ascii?Q?K/TuwbZBGlWPjgrYHyRnrO21cQz2tA4SsDCRag6I7+7acyvJ5Q1RMD8ZTrVs?=
 =?us-ascii?Q?K2leJzfJyhwsjVfRszUiTlHJSdmr90+Dl4M515Qds8DZ3JSL7aFCUL3OmJ8l?=
 =?us-ascii?Q?Cpvy3wf64qMzwjiDNP19hffl8atkzfgxaiwdIfPDy2a4b3HRljuqYVd05BSW?=
 =?us-ascii?Q?GGXmT0wZJQA5euqwdZuTLMTjEOwkcy39ikUpwfIUSJOgNRKjLQ647rS0dooz?=
 =?us-ascii?Q?tFh8OuX72uzQQBW0scaJ9UvjJg79X/QqjtpIT/XKh+aGRL/fVOYdpENhqUbT?=
 =?us-ascii?Q?vbxfQ+4Ay9xMj6W2R9HlJkNzRy5C3yVkmoApXPy4njtDv1Tz9PTtWanNlhdu?=
 =?us-ascii?Q?/L0Hz8xTb6pf3euJmCVOeHujTSiiF2lfDpEMfUbm8spOsPoahTzPcuNY5u+I?=
 =?us-ascii?Q?mRKS4cDoDz4T2PaHnGuI4Sx/X/bTetGHT5YzZe4AYqEljx0CNpqWnh7jJihr?=
 =?us-ascii?Q?Zh8kHXPaOaKJuMi9uAfFcV3JuJnwI/Fbk6NjFG8Sq5BMVe6pFqTj3Th6wbd3?=
 =?us-ascii?Q?GVRlSDD7Upj2nnW/T121zrwPt+mNsq82MfXdf0pusv37PdAQGpFY1MVZyGxN?=
 =?us-ascii?Q?nlbbIKQ6g2LBYFRFxKNUNKVMFV0OgN8+pW9zFvnxgmRSHHGzgwRQ4MdClA2O?=
 =?us-ascii?Q?bRkCAXY1oFgcmDPh2FYAcz6EnT0lBlRxGEngQtv+isFGrmbVjw4P4vupO6pN?=
 =?us-ascii?Q?nX4Axphh7HQg7aoHmQ7QSMIxQlujrRKYD6waEcsyzQWCB/R3EyuVo6mI4m4w?=
 =?us-ascii?Q?HMYFShyS4t9EgmPcFv3V7Tew6lrxB8El6BuFDhalj3GOSzaIDUO1rst7E83h?=
 =?us-ascii?Q?1kVr65M/B6sn1nY775bCqeh+0Gq+4h+G/eCkt28qZN6CuI/KnpnGiM0kWYbT?=
 =?us-ascii?Q?JF/tt7b3R5uV7FC6WzereK1bLfG5YL9dnnraOfy2ePJ+uz4Nlq/06M1Ldw61?=
 =?us-ascii?Q?gQRR3/PNMX2Di+OvdDbhJumqJuMIzcjb/7cDqL1LfNZoKBmJmEDSGE3bHC6W?=
 =?us-ascii?Q?FXRi9Ac4a54pLMFQIHmh155fXlD51E3r/Y2nnT8t/f2tyhq6FoZ3AHFsO3OZ?=
 =?us-ascii?Q?kiS1c4xQA8T/E4maJrss4DT2Pr79mA4YKd928PXGs8g8jLNEPtN919EC83/0?=
 =?us-ascii?Q?PwecHE9PBeznws7sSdTOPo7NjcC1sXVzBcn8EzTODxtFY4U9ZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:11:33.3164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375fa52d-ce8d-40d3-f5ec-08dcfd69144f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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
Extension Register (Lower).

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 12 +++++++++++-
 drivers/spi/cadence_qspi.h        |  3 +++
 drivers/spi/cadence_qspi_apb.c    |  6 +++---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 222f828f54..b9b312d550 100644
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
@@ -80,6 +80,16 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
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
index 693474a287..cc7947435c 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -310,5 +310,8 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_versal_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
+int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
+				  const struct spi_mem_op *op,
+				  unsigned int shift);
 
 #endif /* __CADENCE_QSPI_H__ */
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 93ab2b5635..6a289cba96 100644
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
2.44.1

