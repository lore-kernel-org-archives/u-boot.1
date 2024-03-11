Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227AEC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9DF87F3F;
	Mon, 11 Mar 2024 18:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iVZu8An9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B873087F04; Mon, 11 Mar 2024 18:23:28 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9822F87F46
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWV5HZbXoF/W28kgDsHbM8FIaNYpSrvpabNOmOaRufXBf26+yvP6ugYBE5WORM+G6bOUJlVB3Vk8X1qK00NnBvUpkAKadmpB1/jP4PX9caRJGWtQizCJJisyMHG/otJt/KkfeAdzNlnu2DkiBzMQoT1f4pQkMVhZ4d0nyfFepua4HIm1zQZRmEbydN35yyR+kc5rjcuVKFyp6vmVm78KSsFTvh9Iv3T4gy6Rz5Zvtq0hz6h5XqL0EJAzgutnsXWXelC1pBJUZ8MFi6kapkRHh6n+gFr+sRBzfKJBtr406dyWzYpMAdYNxlxPxDSJRPHo4sh7MSC5taDGGgj+uyXUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEkJ5g02+3NW3rK/rCaxKd9y7LmeMJn2nGZooIA7LD8=;
 b=bS5lxNh4M7pxAYfxhwmX+BJIP+vSyxrDTvq51abPV2rXR0EMKSFF/CMFxEak/eVJYpSLvLUoFYwkvmMJ2tRApDYdhMIly5284iKnapUbNoCHRP9knd8vXcvCABWUmIu/crFePkFh47NowiBf9nBa3dQ5/xx/7IFR4G/lldRm9TbUIrYtwzBHpEMXWpDjA+4V2un52ErU6zBaZQJPS+B7kp9qPJ+P8K4Mm1BrmgsxVCA2GSep+JvWymMwODeBP9KlXVil0SpCs1A0diSVq0NWE7OrJyVrXxjU5GzLI2kBbV5KWPHDg/KP4KbxdiX4b5z87HCL07ReCYcWZZMeanZovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEkJ5g02+3NW3rK/rCaxKd9y7LmeMJn2nGZooIA7LD8=;
 b=iVZu8An9NQR2Rma9T21NdVAF8n0k/bb6pjCpFBhZDP/Tvp6C0nk2xKOY68VVnXQtwZkMkYIrAVkEESqDbSARoyclONZpXoQkovWi1XV+F33ZWnxniXzZScuMqazUPkXqVabBqzttTZeFi0gH+xI8nrN7kbaYtN2PtPxEQAdKOwg=
Received: from CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:14 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::33) by CH0PR03CA0312.outlook.office365.com
 (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:13 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:11 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 06/19] spi: cadence_qspi: Initialize read and write watermark
 registers
Date: Mon, 11 Mar 2024 22:52:36 +0530
Message-ID: <3c2f5ec9cb90b50b5c6c6ae960dd0e062d62dd58.1710098033.git.tejas.arvind.bhumkar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: bd045210-4afe-4ccc-9a4d-08dc41efef32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFeBlMJdGrMGy2u0OAIZtpRf88SC6qNkeHBFxr07YLCtWYg6sJ6H6OrCT2l7UOqpOOF3w6HuM2Vw7uJokGfk1VOESSe0O3aMPp+0YNkWFoghWtJP9ykMig7DuYpd8JDZe4/Y4dznNtt5EXSBMYCBZQb+sz+c2Wb2SIQK6k/MUwzn3CbaQeR5lWRSHI2CtGwKaL/pX2peUEMnNNcY5nCcD/orW68rmchYgF1HxEBg1jnS9kv7yWfCRyuugtsrpvVOM7x6KbiDX2fxRWrBgdTapUyw0Xzf/rVBE3/flZEq6yeBwUsOSAOuJGmhlDw4Jw6EB22ycDOMWBgdhimWtKKx0u5BIFxgc4unK/bVgZZf4DKyJQVoZu4TDi8NfT9VqqpgJPhhHTUoVPZp4AMKAM8Q6ekWFcptvfTmDFcBhInbhTX3rbEf65oUOG0XaC4tiAVT/FXgPOsCsuJtLUihYSOoo3up/aeJvtQmrIOPgYQYEOS+zEJKFWZEHNtHSmopDF1mbZ4iv0GEkCc6SDnMzh8R4IosBDZUD8optGVPawobYBPfp8I2x2HvnQV8IVzRnFZOBj8jQX21lXuPZTwc4ie6d6hssWN1q7Pe5uzThx7XGDFx8t3o+sQj6RRl4eP62rNsBgHn8ClTdSB91itZqDWNEcd8bAolG5sj0HG7PRtXpjCUR52VSRKYs6wySY0sz7Zu/rVe5n210dOhHiRBS36Kr8mUuB7r9KKg5U+glhM1mehW8UV7TtpQ7Rcoej7j+5Vs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:14.5046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd045210-4afe-4ccc-9a4d-08dc41efef32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Read and Write watermark registers are not initialized. Set read
watermark to half of the FIFO and write watermark to 1/8 of the
FIFO size.

Read watermark indicates if SRAM fill level is above this watermark,
interrupt will be generated and read or DMA can be performed.

Write watermark indicates the maximum fill level of SRAM when write is
performed to device.

These values of 1/2 for read and 1/8 for write are chosen similar to
Linux driver.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 35a21a2727..8ea40551c1 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -356,6 +356,14 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
+	/* Program read watermark -- 1/2 of the FIFO. */
+	writel(priv->fifo_depth * priv->fifo_width / 2,
+	       priv->regbase + CQSPI_REG_INDIRECTRDWATERMARK);
+
+	/* Program write watermark -- 1/8 of the FIFO. */
+	writel(priv->fifo_depth * priv->fifo_width / 8,
+	       priv->regbase + CQSPI_REG_INDIRECTWRWATERMARK);
+
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
-- 
2.27.0

