Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B3DC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70C187717;
	Wed,  6 Dec 2023 06:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Bj+D+G1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EE4876E9; Wed,  6 Dec 2023 06:34:34 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF0F87683
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7gaoUgosnoxNEFFwxnH8NaPcWAJPWxsHsPt71a8CcyrmEha40I+a+jvurshkZTRSZEN0/XLCo2thiHBSnNtiqqZe9XN6ajHNe7yo0JQ77NqUk1Kyvn4yTFfLYnjOGuSwzaRaEfwB8uyCS3UQx5Ot+pAXq5TIBMZEKuM3hew1aliHFKVmSf92hnPfVXG12U7DQ9yAJ2Y16T7LrdFiP92BhzT6CDWMqzQ2DggC0fe3VSSUZ9ndaBlbYWYbL7d32V0x8PIIJxQ0PUdCD36Uk5F9W8qIlv/yI9KLmA7NMzXd1Q3hC61+z3KmsSRoVGiHPNjciOW9Yw8tJ7krWmKI8txgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F85zAwA1eTOPtdt9kHZ45TxpQnMiT1siy0sAX0OPlhE=;
 b=f7731TN1xjG+v7teO1GvjFe0YzKz91ygCjItsF4XKHylojKBU4q9p8BkAYIPrRZZFdbxnwUIk/ezN0jm702DdOM0WvvAsXXYBOg0Gg/1f36OpwRZ/DWVICspb4BT8GMwfWOrYS5mf/IXka1Z4ipKY3Eq74sKyqGvUvkwPzo2y2SzTZQGtzzl8pjLmjZqfT+nON25KkNS8zzM53tE7S8jeyb90PG2+dQi21PfUSymMClxDOqs9odJd4x2jpScw0ddpESF1Lz0lkQt2rggAV3182u/SeSXCgYOeT2nIt+Ynh2c3zF9wjtsml4dbOgNr8r5pdryoz2fHsf8r5MDIDE9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F85zAwA1eTOPtdt9kHZ45TxpQnMiT1siy0sAX0OPlhE=;
 b=2Bj+D+G1/IgfRqn2TnkT3k+/FwcMYok0ZzZfv4o/f3yj+ygnQRjG3K/UAwFoGPwf2gaxzO05rZhEslAoQZQ23PRZsa2iyYag/0lthRoF5ZIxzEBufWF1I0r2FpvGH/Lru4MlfIrlsAbtTh6B/5Qwq67JVMAkqbsTJW7HYeIYgPA=
Received: from BL1PR13CA0187.namprd13.prod.outlook.com (2603:10b6:208:2be::12)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 05:34:25 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::10) by BL1PR13CA0187.outlook.office365.com
 (2603:10b6:208:2be::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:24 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:23 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:22 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH 17/30] spi: cadence_qspi: Fix versal ospi indirect write timed
 out issue
Date: Wed, 6 Dec 2023 11:03:51 +0530
Message-ID: <20231206053353.3745918-8-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6c3bb4-5f91-4edb-a8ea-08dbf61d01d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zY8H7G9BQuGFLHuFUl3IwY6M/LiVy0vzRcF8sBxLXyRUBOYbzGs+h7u8MxMGNstVHnkX/+wtJa0pc8bq2zYDjU+1qwAgw7ujnMV/oH/e7SZu73jPLPjQCa+5LnSabk1KK1to8uxwQlD4N2lwfSoBrI9PTxIhK+0i82HOJZPhzNxKvXylBmTacqimfLJFhIR3pujjr68ceF9/kg5KGl0XdXMJIbx72lIPAJ9AXpEjYVJTBezOrGBuSGgklyu6nggkHQku2jNFi8FwBOB1QEl1hOJ/Z5Pa2WT8T17C9anBWydHAKzkH/ZiredRsj9qLyOMjHX0UoWLIU5nEfmvLJmZNuufkJ0YtihFmjtP4W3x1jpaF0w2oAZPBhWkdDw1txiAv3knTLP7A0N7jUg3ZQpbCLKvSu3CR379SH0Ld0jlq+k6KTK4FRtUgXEkZZ79fGFm/zemrxYVR9YZ8x7MG4LCtFtdfJqjOlGw4U6m8NeWCycj+qk2LItQvXG7wT/IXgzW2p5m7bJ6pKHru7XHLp+ZK2ADuN1W1IqjHEeD+uWjKU6/PkhQhu98FY2CY9/K66vZfoUnPmb9U3vixuaXNmD3A5YJm4W4ljPPVEY0EWhfmyeXFBZeiqCCUUsFjoRffkfGpmpoPC3zf6PatGcv8HeL6NWUu5JCNQKZS8lEpoNPGQOY4eqlREWTtBqJ7OUCFTprUQal/BddxrnIgAedcC/Jh5mJ1BPEroxMe+8ImYpd1ZdeUVbvaEnDbj80nkejqjiyu+UEjVE+DzabJXpwxYgd8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(83380400001)(478600001)(2616005)(26005)(1076003)(336012)(6666004)(107886003)(316002)(54906003)(6916009)(86362001)(36756003)(41300700001)(8936002)(70206006)(70586007)(8676002)(4326008)(36860700001)(40480700001)(103116003)(2906002)(5660300002)(356005)(82740400003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:24.7590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6c3bb4-5f91-4edb-a8ea-08dbf61d01d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

