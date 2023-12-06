Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51146C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C507876F0;
	Wed,  6 Dec 2023 10:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p845QCe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBEB08784C; Wed,  6 Dec 2023 10:33:36 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530C08764D
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgoYu4ds1wjYZPWR1s6NFw2wSYjWq0qgSPRQx+sNBxoswy4se5ESsU8Hs2ciA+CCtZGy1N0eh5TITYh8oAo2NYEVPAQ1ms2nWLTKhGgRw3xfGqdCOgq5LX3fh2vk+c14tPfSgGSp3MsK2aHESLsHJsE/Nx7P3NLn9ZRO7/Yhg+OENCrKvQYINf7mqh3pqBH8RPBV5gI3EzugtFHnbpfihaGumhJf34i4zjdqZ0WP2pgYk5m13fJWsYUQfMX1fV0p2hc1JEy4SU8dWc/wVqL1Lgdc8Pd8adYS+YPado6oeLow36jAMYWi17EXd+4eFld3aP/6mBnDJ5YSVrvW2+2Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F85zAwA1eTOPtdt9kHZ45TxpQnMiT1siy0sAX0OPlhE=;
 b=dhTxt3TL1q3zyG6SUg1JNkOe4vxl85+zCGOliskhGPFQ72kIQ827xqUHSDmNI5EGolDW+/YSFbI/MwqaeEo2P+9tgysa6P6W4Y/q+U4BXU7MdobCROTa72vJwQvWjl0FPE6QYLlRUFulF0XyPAJuYC76tlCYpMemn6lP2x+pthptiUaHYqQVOdsGMUjh60PqKkw6gNJWN7vFmhnA0E9/BWihIqZ+IND4RPOxrpTf7w9uJX+hlj56hYWI4fyhFPh6isMO7UXcIiNQWjQoS3q9IX8tl73IflY6au1/yQVI5GFaytN0oAsUhKBY0rssR9BOLaBMUKb+6YynUZn4l0SMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F85zAwA1eTOPtdt9kHZ45TxpQnMiT1siy0sAX0OPlhE=;
 b=p845QCe3d3ldlPTh/s7+kTSPu8E4qAKowO7suqFtkA+TpxHLgSQt6rqQ49V/XueZirIrC3s1u/zPIhM530Dl11m8Es45Q78nrVZbCNint2ikw+J3pfm5VDRO5uywVD45pGO/EfwCl1vMEPwCQ+AEiJFM+5BLl0UVSMqXeZBh10M=
Received: from DM5PR07CA0083.namprd07.prod.outlook.com (2603:10b6:4:ad::48) by
 DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 09:33:29 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::26) by DM5PR07CA0083.outlook.office365.com
 (2603:10b6:4:ad::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:43 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:41 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH v2 17/30] spi: cadence_qspi: Fix versal ospi indirect write
 timed out issue
Date: Wed, 6 Dec 2023 15:01:28 +0530
Message-ID: <9cd21aabccc87850290009a4feb0db0fbcb46ace.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: d82ae59f-e7f4-4daa-5d41-08dbf63e680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq43+Zjodx28sEFj5YlKaw1ZuZrW46eYRyEiBwTBf9cr1ASZ7dVfDTdCLsml7zzA5Vje9JL0nEVjhT4IAjKANmnXJDueycmSlcXtGYLgQefvAvbn23p24r4b3sMQ/a9URb+QNbUSJOHZZT4yG5wBOcuowYeZdRZ2Xdr0Xj8abI4/x32mBHl1y47D1FJs0hHSX24GcwiQNpOv4aszS3nFGzeqkqsun7TD6TpJh40TNOltx3IW4kS3Z/YChhNP4THx7UYI38CLpddm0j8GgMnsY2AjbxZV/bhdhA89fGjRsZ/2M0z0/XzrZXrrzypZsB6/pF0ENFhPZlpJI8mTsU5qflXErOhr1NucxqOIVqSk1PBGkWPaocCrkdP1/4MoaX+QmeERdGikuWKxinA6Mqff9FxB/rrspNJOZVazW3h+dh296xUHgPgDidI+Docwe4KdwZqQn3d00EbhJXNYsc4bf3OM10me2FVSD4uqpOKXFXUuLn7CB49ieKfVqiWHOLVz/jhU354dnykjFAhBvvDaM+RQsWD/zpiKEjUo7vuGO2cf52q+XrAM7DDoqN8uj1esJZCL4nzLM5QwyZOT8OP3Mdf5vKmXKbgLLa9REvoDZ4WxZWyDzAy9H83Pzvzs15ptVINirPxR2hywupDbdSbNZ1Pi1tXFFMgwXt3og8kNIySddwe6HQ35hbJO4ZTRYWuC1E/jlObHc2YAzeUtrmPzQMQECl3sMdURsvNxnq2Xzi5DGJPY1nxnQ1qLFpEOuZ3XpHIMaMnRbMGJVRnQzIrprQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(356005)(47076005)(81166007)(82740400003)(2906002)(36860700001)(83380400001)(336012)(2616005)(426003)(41300700001)(26005)(107886003)(5660300002)(6666004)(86362001)(40460700003)(478600001)(8936002)(4326008)(6916009)(316002)(54906003)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:29.6034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82ae59f-e7f4-4daa-5d41-08dbf63e680a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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
---
 drivers/spi/cadence_qspi.h     | 11 +++++++++++
 drivers/spi/cadence_qspi_apb.c | 24 +++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 505f59bed9..73ef44fc1c 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -252,6 +252,17 @@
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
index d1a5a4c679..1b649abf21 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -32,6 +32,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <wait_bit.h>
 #include <spi.h>
 #include <spi-mem.h>
@@ -855,7 +856,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	const u8 *bb_txbuf = txbuf;
 	void *bounce_buf = NULL;
 	unsigned int write_bytes;
-	int ret;
+	int ret, cr;
 
 	if (priv->edge_mode == CQSPI_EDGE_MODE_DDR && (n_tx % 2) != 0)
 		n_tx++;
@@ -873,9 +874,15 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
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
@@ -894,9 +901,10 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
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
@@ -914,6 +922,9 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 		goto failwr;
 	}
 
+	/* Disable interrupt. */
+	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Clear indirect completion status */
 	writel(CQSPI_REG_INDIRECTWR_DONE,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
@@ -931,6 +942,9 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	return 0;
 
 failwr:
+	/* Disable interrupt. */
+	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
+
 	/* Cancel the indirect write */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL,
 	       priv->regbase + CQSPI_REG_INDIRECTWR);
-- 
2.27.0

