Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA5BC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 06:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F87E87B6B;
	Sun, 28 Jan 2024 07:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lMym/DdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186DB87B77; Sun, 28 Jan 2024 07:38:05 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368CF879A0
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 07:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1LF/XMYX0fm9wuzz5H8iP/Cdd3eRVu6HqTs6F5c8oKesu8nN2BsCvCM+ytd2e1D155s/jkxliN0MIGltCgF6C7WltNeK5F8nhUUl3FQDwoCdkzrrqhOe4OqVeVgUUeE5Q4UTajJZh07U2bTSYofHpq2WZ2d/5RFPhv7KjezW2s9m46YKN+uR4Cc6WNTLpZykvrlmW1XKCqbLadf/jJCRwBC+zKGcrKWxm5dSujrQdvpxRMPG/p24MAgN1mT/FP76D7pasLgDtSPe0NtCpH1CwForLfPRxURfJVcVAA+ii/PeTD9+G9B0ln9GsuF6A4jG7RHSwFN4WnTQsMFHWwssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjTqPUpUp1NX6XSZx0fwy8bfiTgUm27T5G4eAj4xHZA=;
 b=TvEXh5GmaggF9gmah7n1HbSuY5KzL/9Df7MiZFZNQP3AseAc75lgsGe6mZJ59MOavUDiw+Ahua2dc1NrjpT3YARRdH60McgiUWb0Z3yMRPnE/LKwoD7z73KJ2MYUt6VRfGLDZZ+8icC+ihUjSzAmrKdtuvBqUa8kGQ8lUKNDGRFJrjavF0Ab/tvlez4OxEDvdMbOECanzoI9xy36sSqx9PY/HxP0Oij0tRmIGPVXA1if0ddFhQTZuoVN4VbVJD3g8JBpF/ORQEuCey/bvhDG6BWVB/Z+lEgwV5LldMFvIcGtT4nxevuCHZyqteBrILegyMP2YZxSr6fiy8nuQ/J+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjTqPUpUp1NX6XSZx0fwy8bfiTgUm27T5G4eAj4xHZA=;
 b=lMym/DdPXXfqtraN1NS+yrnahMpBU2aymRf6+mjTU+cPLm3hXL4gM69Vxxt4FDJv07IJ4zKnwAtz/lg2pG2O4BB9nXS7OlBaYUaUvuK0K6OYQFOzNZTqy0Iiau6HTWvz6+0ZLdWn7YADYisdk7W9MQMWIqlneBkikJ3Eq3+IfCU=
Received: from MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 06:37:56 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::69) by MN2PR14CA0001.outlook.office365.com
 (2603:10b6:208:23e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31 via Frontend
 Transport; Sun, 28 Jan 2024 06:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Sun, 28 Jan 2024 06:37:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 00:37:54 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Sun, 28 Jan 2024 00:37:52 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>,
 <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] spi: cadence_qspi: Address the comparison failure for 0-8
 bytes of data
Date: Sun, 28 Jan 2024 12:07:46 +0530
Message-ID: <20240128063746.1552081-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdde448-566d-49bd-eb96-08dc1fcba90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7PlXh0Hx12jKYogZjkIBPgBjedyIC1hLPFNudcmaAWKoJEYNOv4x0+tc9YRkHozPHKkP5OUFwtRyBWb2jMuMFr0k4lfFGVvEldgaN9Uu5NvqlAFzxyy/nGNWQgORkOxgj3015qmOpnuJvIgPPypyyTuTKj3XPkhYCu64m5Tgt0nDUTYfS1vMle17f78Adz67BOwcAGLMfobrxB3nq8QOamcQe+NVzyGrp3WYTq7ShUkAkX0Lz3omhjQXc5wSERYlgUzQIjXHgEInbs76CfDBPdIzz9BUb5ZUkgRfBi5zivGTrnEj2C6ANcfOdI4k4D5iHg3sYKHzey0N2Iv76FfmT5H3xDyHoFEmrpkFTetqxg2Yizmwa1Zg89B9s97u3D6KhGH9AcIuQPExQMxGfOvlVrGsLtNOqSQD117uCcfsNVfWEC1MmgU1M4iiQ3qyQ+Mu+Bh/5aLdE5g9/16mahyyL8YKvraDLreMok5JPCo0TPsTYnN4SgIVWSWYSBVwUSZ6VBR8orVEjli0RqP+FcMPUw2FGw6Jr4bQ4RyADdPz5PpO/f9wukrSR9vSgLnQ+lG/aAoa6SUlx+BPtm4k33TxjY4NEtoH8YjoNCeMvzlq2TtVIbJJ6hrf4Jd/je1ge7ottRI/XxB/NIkPstM9WFwNy7jByjzwpdV6T2pbVxtZ51yNrbGgIiC1wPUsF0uJfK8Bu0ZrMBOJW0B/W2wF0PtwCNvGeFo5NHPCu0IgIvt+iPSKvYrFjKmMzk3lPjCX1CrBBPKW1tfB1I35iitEhhVjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(2616005)(478600001)(6666004)(83380400001)(1076003)(26005)(107886003)(336012)(426003)(4326008)(8676002)(8936002)(5660300002)(2906002)(103116003)(966005)(6916009)(54906003)(316002)(70206006)(70586007)(86362001)(36860700001)(356005)(81166007)(82740400003)(47076005)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 06:37:55.4251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdde448-566d-49bd-eb96-08dc1fcba90b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

The current implementation encounters issues when testing data ranging
from 0 to 8 bytes. This was confirmed through testing with both ISSI
(IS25WX256) and Micron (MT35XU02G) Flash exclusively in SDR mode.

Upon investigation, it was observed that utilizing the
"SPI_NOR_OCTAL_READ" flag and attempting to read less than 8 bytes in
STIG mode results in a read failure, leading to a compare test failure.

To resolve this issue, the CMD_4BYTE_FAST_READ opcode is now utilized
instead of CMD_4BYTE_OCTAL_READ, specifically in SDR mode.

This is based on patch series:
https://lore.kernel.org/all/cover.1701853668.git.tejas.arvind.bhumkar@amd.com/

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
Changes in v2:
	- Resolve the duplication in the usage of the macro definition.

 drivers/spi/cadence_ospi_versal.c | 3 ---
 drivers/spi/cadence_qspi.h        | 4 ++++
 drivers/spi/cadence_qspi_apb.c    | 3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index e02a3b3de3..c2be307f1d 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -18,9 +18,6 @@
 #include "cadence_qspi.h"
 #include <dt-bindings/power/xlnx-versal-power.h>
 
-#define CMD_4BYTE_READ  0x13
-#define CMD_4BYTE_FAST_READ  0x0C
-
 int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op)
 {
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 12825f8911..693474a287 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -33,6 +33,10 @@
 #define CQSPI_DUMMY_BYTES_MAX                   4
 #define CQSPI_DUMMY_CLKS_MAX                    31
 
+#define CMD_4BYTE_FAST_READ			0x0C
+#define CMD_4BYTE_OCTAL_READ			0x7c
+#define CMD_4BYTE_READ				0x13
+
 /****************************************************************************
  * Controller's configuration and status register (offset from QSPI_BASE)
  ****************************************************************************/
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index d033184aa4..fb90532217 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -469,6 +469,9 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 	else
 		opcode = op->cmd.opcode;
 
+	if (opcode == CMD_4BYTE_OCTAL_READ && !priv->dtr)
+		opcode = CMD_4BYTE_FAST_READ;
+
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
 	/* Set up dummy cycles. */
-- 
2.27.0

