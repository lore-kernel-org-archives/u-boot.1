Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE841D43352
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A09198929F;
	Thu,  7 Nov 2024 13:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KksMVbWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A86D88FBB; Thu,  7 Nov 2024 13:48:18 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AC78926F
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFMWMrUftlFRwt/EPiWFlXQHyx4ZIrG0uEWYLETugEXHuflK6mMKcRH5+Bie7rsq6602+jBlKWkcc/5fKPrPFaJf4Dl+fZLhqeJ8cAQvxYPMXEJKt9Q/LGdajMxe5XwJvSfmEkhcFVmK6xg9pDRnARrKea3mrUYm5mQ2UDqs7zmNtOfUu6KFaQymFwAf9rYRwluc2v4I7mhsV98wt6yFHVpyNEmNder8PgCVRVZdLRtEEwCJxJ7I0fjcR/m0gCp42EZ2IPJVlYuA8x4TZBy4fNBcAbfJo7pWkJ7PgZgmnZGmc5vIEmzr0Xapg6VnMH5D8+0PM0Edq8SzRL3j0T67IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuL0teFaiCW9/fGSw7OQtniif+f7zRow1/Cym5ylWiw=;
 b=jnNFJto537hU0S2ngM/dNF4QupfSN0jr04KpjQ5O8aIYaTme9nS0V43CXGZEoXsS/YrjN74UGDj3ml+CBhn5rM6NYjjaUBM6MR19TZdu6MxgDxi6YTRTVruTt2PUGvTV69trFjgby3jQJ+0cV0MqZw6JajgLMnV7Mn85eMu9YnA/cCNAeyDjScQNKLD+YydzztjC8klpV5jxcFSXlp2gtWkNcYJZQl/c9dLA/HEVbXUy43xXzJpaGOX5IrfghLdUyWFdmOCl0hVWdheJx1Lr9EYsaMdsh1r9zD3MvASF1uEAWzh9mymV1WQE5YC/fbCLAC4sHx1TTQDaE3v0JjlNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuL0teFaiCW9/fGSw7OQtniif+f7zRow1/Cym5ylWiw=;
 b=KksMVbWRcNZMuFR/qc+GTwsAYpRsCb6sVKZxU2LsuBNvO9byox65IidjZvDImmqa8ygHVzp+BdNq8ByvFpJ5Flm93GXwU6pmyqjCdoPjRe2PpmqamZOefJHfa613gtoWAdAKiulYlgsAuQQzo8oDqD4c4C7KxwB9a71hi1mQkJk=
Received: from CH2PR14CA0037.namprd14.prod.outlook.com (2603:10b6:610:56::17)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:48:10 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::79) by CH2PR14CA0037.outlook.office365.com
 (2603:10b6:610:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 12:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 12:48:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 06:48:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 06:48:08 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 06:48:05 -0600
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, "Tejas
 Bhumkar" <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH 1/2] spi: cadence_qspi: Fix versal ospi indirect write timed
 out issue
Date: Thu, 7 Nov 2024 18:17:06 +0530
Message-ID: <20241107124708.383695-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241107124708.383695-1-prasad.kummari@amd.com>
References: <20241107124708.383695-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7eb3ac-1cba-417e-94af-08dcff2a6f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rcqXk9+0IJYpO0lBnjopbXc2K1Ee1ICEG3aFJXOwYbb51u6Lv1aE/fs9pnQi?=
 =?us-ascii?Q?/95LqlmMuSNY82UNgEGD8eTGjLmPRyA5rdhCTtrKyLjJ7lM5EUUaFEjRQKew?=
 =?us-ascii?Q?TEoE060gcSyrhITWqUYkuu+VWB2lH/pYCSEsJyMziYCZZmKtGIEfFIdhX7o/?=
 =?us-ascii?Q?dmj9DaLe6aZLLGfPDPVU+4AoTze8EvnoNDZdpcVgppQAFbgLGZqwqYvQnEvr?=
 =?us-ascii?Q?JxRtbkMBtH3vnXvOcVJnYRST21dFEVOiceKi8vcJPgrQ+8ZC0xkP4XQ35jlZ?=
 =?us-ascii?Q?CAKoZEaViUIxFms3I3E3bqTMJtJnPMBgHfS/cDTNcAQI5zCKCvro2uli738s?=
 =?us-ascii?Q?JMosBtuSlsoObryM7Q1gUieF0qFAMUDKqIgP+yfLghf+UKLTa0CDVG0BPDK4?=
 =?us-ascii?Q?N2fjCacBSL9w14286JvtEOmQrzXlOCM8+Umw699QuBmPGzvNpFaktVHhovgI?=
 =?us-ascii?Q?x8eLt/u6Q284n69kQefJDMQKae/VhnPr2TARhR7DPmUJx5BW53CYEnO778pi?=
 =?us-ascii?Q?38ZBGQSqDCxZqDlaIv5EUnfQOW2ovMjmCJYpem/UU3xH14RbZdbpwWJCkEaG?=
 =?us-ascii?Q?enyuWKOVhiNLSjA7k7YWWOlLvbDspp3R3OAWicdZaAKzjNmXuzUrpRGp7CCF?=
 =?us-ascii?Q?Zg5uDJXSKkh+m3VcnnWP5JWumthbuskEclUZB/0AGRVd4+0kv58PgnEgJtLU?=
 =?us-ascii?Q?DA0Sf0kZFoeZzzqSMmrGYIhv3ywhLLeoF+Hkn4hZO5vfNX+il6FT+qFZrVWX?=
 =?us-ascii?Q?rp+hoFtceYCMZjOi5PQYkfcFqQMdVoYN7HYk6vlV0g9dV++3udA/tHoE8f0f?=
 =?us-ascii?Q?ExAzNUkKtUsEXyiO71ESlCZD39mQ85ptg5xy+pfYCIaWlQZn57Il6MmDEJfy?=
 =?us-ascii?Q?5z3QhIXJFhC/0VyLEsg5Pn2XLO69xO8BOfDP711x/q3QabyT69iHk0Kw3WdW?=
 =?us-ascii?Q?gagNsRH+DXclL/mlgfsWqRXwuVxQqi2HKsLVH4BkE8qSja1J9Bnv8ao5VGRG?=
 =?us-ascii?Q?fLOTqYR0VbHLfi4y5HwfK4Bf+QcCvtRzf/7cX4e2dCHqVqLKIZinu3DXc27V?=
 =?us-ascii?Q?HzBX+SsUMpdr5t0KM+iNfgM2pKkTFyuS2ztLL40uOULmtZ4CI3yEBd5yAzvw?=
 =?us-ascii?Q?sybl4StO8o4zPChhlqPP+yWQAW6+OcuT//QO4M+yeCUIevEmTdpkS9UuhsLt?=
 =?us-ascii?Q?8AYf7kBqo0CO9yMsJPC1pq9/UdcJ5FfC6bcupp6+q3oy1qhUwFA75f69ynA5?=
 =?us-ascii?Q?aK213wG1Nc2b5gwWiaF5nKz0Bu8bei86MOznZj0aHX2nr3YoeKetckFsKRNJ?=
 =?us-ascii?Q?u5pgn2E3Y5ggRjLE7EqhriZKw0d9QMG5tISBL3j/iibzJGTOnMC18FykWBr5?=
 =?us-ascii?Q?QYUSvwNufNDG2B5pKHH9xP6BVWFI6YhN/+xxeJ+Rmh53gaIujw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:48:10.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7eb3ac-1cba-417e-94af-08dcff2a6f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>

To reduce the CPU load in waiting for the OSPI internal SRAM to
clear in indirect mode, it's better to use the
CQSPI_REG_IRQSTATUS register to check for indirect operation to complete.
Enabled interrupt for Indirect Complete and Transfer Watermark
Breach interrupt status register bits and using readl_poll_timeout
function to poll for Indirect Operation Complete bit gets set.

Here not enabling IRQ coming to GIC, only IRQ from IP itself is able
to poll bits.

It is observed that the Indirect Operation Complete bit is getting
set at an average time of 0.172 usec.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Link: https://lore.kernel.org/r/9cd21aabccc87850290009a4feb0db0fbcb46ace.1701853668.git.tejas.arvind.bhumkar@amd.com
State: waiting
---
 drivers/spi/cadence_qspi.h     | 11 +++++++++++
 drivers/spi/cadence_qspi_apb.c | 24 +++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 693474a287..a48d77a154 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -201,6 +201,17 @@
 	(((readl((reg_base) + CQSPI_REG_SDRAMLEVEL)) >>	\
 	CQSPI_REG_SDRAMLEVEL_WR_LSB) & CQSPI_REG_SDRAMLEVEL_WR_MASK)
 
+/* Interrupt status bits */
+#define CQSPI_REG_IRQ_UNDERFLOW                 BIT(1)
+#define CQSPI_REG_IRQ_IND_COMP                  BIT(2)
+#define CQSPI_REG_IRQ_WATERMARK                 BIT(6)
+
+#define CQSPI_IRQ_MASK_WR			(CQSPI_REG_IRQ_IND_COMP        | \
+						CQSPI_REG_IRQ_WATERMARK        | \
+						CQSPI_REG_IRQ_UNDERFLOW)
+
+#define CQSPI_IRQ_STATUS_MASK			GENMASK(16, 0)
+
 struct cadence_spi_plat {
 	unsigned int	max_hz;
 	void		*regbase;
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 93ab2b5635..3c71a5effc 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <wait_bit.h>
 #include <spi.h>
 #include <spi-mem.h>
@@ -845,7 +846,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	const u8 *bb_txbuf = txbuf;
 	void *bounce_buf = NULL;
 	unsigned int write_bytes;
-	int ret;
+	int ret, cr;
 
 	/*
 	 * Use bounce buffer for non 32 bit aligned txbuf to avoid data
@@ -859,9 +860,15 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 		bb_txbuf = bounce_buf;
 	}
 
-	/* Configure the indirect read transfer bytes */
+	/* Configure the indirect write transfer bytes */
 	writel(n_tx, priv->regbase + CQSPI_REG_INDIRECTWRBYTES);
 
+	/* Clear all interrupts */
+	writel(CQSPI_IRQ_STATUS_MASK, priv->regbase + CQSPI_REG_IRQSTATUS);
+
+	/* Enable interrupt for corresponding interrupt status register bit's */
+	writel(CQSPI_IRQ_MASK_WR, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Start the indirect write transfer */
 	writel(CQSPI_REG_INDIRECTWR_START,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
@@ -880,9 +887,10 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 				bb_txbuf + rounddown(write_bytes, 4),
 				write_bytes % 4);
 
-		ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_SDRAMLEVEL,
-					CQSPI_REG_SDRAMLEVEL_WR_MASK <<
-					CQSPI_REG_SDRAMLEVEL_WR_LSB, 0, 10, 0);
+		/* Wait up to Indirect Operation Complete bit to set */
+		ret = readl_poll_timeout(priv->regbase + CQSPI_REG_IRQSTATUS, cr,
+					 cr & CQSPI_REG_IRQ_IND_COMP, 10);
+
 		if (ret) {
 			printf("Indirect write timed out (%i)\n", ret);
 			goto failwr;
@@ -900,6 +908,9 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 		goto failwr;
 	}
 
+	/* Disable interrupt. */
+	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Clear indirect completion status */
 	writel(CQSPI_REG_INDIRECTWR_DONE,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
@@ -917,6 +928,9 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	return 0;
 
 failwr:
+	/* Disable interrupt. */
+	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Cancel the indirect write */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
-- 
2.44.1

