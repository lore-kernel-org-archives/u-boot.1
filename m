Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52000C47DDB
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 05:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334C4880E1;
	Sun, 28 Jan 2024 06:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="faW23muy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25997880E5; Sun, 28 Jan 2024 06:16:41 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D77788093
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 06:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW6KOwhrENaMDRBJqcIuOyiaO+PPcR53gEkeyBQd68Xv9y/Uz5Z0iSdIv77aaU05L5kH2w5OmGAydZGmgCRp8dVNyOjEB2tbUyP66byKzvCaSvlZbYV4XLEDfqKdoapT22BtubjcTYhxalFoEVYnb6qyVAa1yv6kY30DKj6K3RVs2c582UvvsFScssz0UINsNOGBFARFLxzenusXocePiL/F+74Bu5rf5cHO1kSc0YMxKywywt8Smk6Kb+ewmbkbcEx2iBxMAX0WS3wXzTGnIa6XUPD3aSxpfrlT198ovX8QPxHYfXXiZ1pi6so+LahwQTSQRB8TsdQmVSjub8DQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDAJJXHXsK3X4+DeFYsaX1JH2Umjs/mvRvMiyKPunaU=;
 b=EGhyaX+EKRq9EmB3iWZDcc0KCkYWpvsVuOXRLKtmcfwvZuEhXoF3EI87Ih/gTp5Ies/pQoTwZzbDPmdIRTrGdQrjjVTm7liIWcmJSH30vSeg2eXUpRYVp4eyI84N8OCEPYkP4UQ4Qfs+UjMzBOON0KqJZ63XF5l2Md9lNjyXA+WzYlETYENNf2i8e92i2roAi8jWDlAP+Gi+lK0HYEgsruolR1cXkxlZX2LMKMZaoA5NsQWdWKoj9WVPw0rgPjag5qCrARytLOooTqeAD+NXTorDi0+BDSA76IYLaASq7P9k7tkFcc7VDDN7ENhesTJcjVGtF2slXsXKaHdKWSCEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDAJJXHXsK3X4+DeFYsaX1JH2Umjs/mvRvMiyKPunaU=;
 b=faW23muywWzqoOZWFWBb48+twPFRQvbglp4T9U7PysnCpkoas7qK0slY3LnPXjp9MZcb1jGHFfZni3zxwAOxDTbUw6jVMrk44lMLL0EuUi0Vm+OG8F7SiSGHZLwCcDSMP/DbIiwrpm1OSlGcLmA/LoRpg41vuwcow4vmzdkTUoA=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 05:16:34 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::eb) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31 via Frontend
 Transport; Sun, 28 Jan 2024 05:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 28 Jan 2024 05:16:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 27 Jan
 2024 23:16:26 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Sat, 27 Jan 2024 23:16:24 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>,
 <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH] spi: cadence_qspi: Address the comparison failure for 0-8
 bytes of data
Date: Sun, 28 Jan 2024 10:46:17 +0530
Message-ID: <20240128051617.1538326-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1f71d6-2d8e-4d8f-2bb9-08dc1fc04b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLIHG1cyf1x/IcDbkzSTsc7YwCPHxnidLn7ltVs4W31eToCXNx1g7lTNFfj8oXr/mtGwXzoCwZd6RC696CuZDGMXq4hpOohwo0V9xtOplacIx0wf93ulC1fjsW+QjzkIwcsUlzeFLqhwzWnXF8/DUXPyyKXyhSjyqP7QlOPn0sbE9LvjqlZwD0FJIde89vhi4lzpFnizlnd7MfN230indcQ/q3oZJtWh8Xho4ghldZ/kknvUm2WnUKTjC+66xgwIqWiz2qVD4t88HQmfsUPVna3PJa/S/B0V7wZZEeFyb2BFl1QOkeEQTYEuIBgkXN04p8S7CgckLUY+GYIwRTi9hColTzj5X4n+UCS7LyFc3x5R0/HDXQPXN7F/kOmxBPzdGZFFfx7bzLQdFNkbL2jSqj2IYArZqpia4u2RhgCY3jF1iPxDIWwdZHJGVFPu+MieCbaLeH4T0u/Nbd2M8oXbIQPmROMLCWVsbcNaOrDQzkEbJbCOeW2lzcOvbvZNHcUBRFCmss5AeCY9s/58OnrZnn14Ag5bxg4OScS7ZPa8Qvut1NgQs+oUF7ziUBMOZzdhUgziAVE2LTUCGeNoEtL9yQZ/FwT2FGNcFNpsvngBmCaj0FdMXoGq2WVzSgW+bcu0DczmS10DuYu2gfcxG33pQUMARk4neEbmU0AFQed4FmOhWvdeDOrJU2yuIoF9SaJOojcfaQWgNgRdpoJaHfHdMSbMu5yIdsbi63QjuxsrgTGMSKI14BuB3SQDOSzjsM6Hy2da1F5zCOvNhp6PGSc8FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(8936002)(8676002)(4326008)(103116003)(2906002)(5660300002)(86362001)(70586007)(70206006)(54906003)(6916009)(316002)(36756003)(36860700001)(47076005)(82740400003)(356005)(81166007)(478600001)(6666004)(83380400001)(26005)(1076003)(107886003)(2616005)(426003)(336012)(41300700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 05:16:33.4798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1f71d6-2d8e-4d8f-2bb9-08dc1fc04b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487
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

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi.h     | 3 +++
 drivers/spi/cadence_qspi_apb.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 12825f8911..3b9cee25fa 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -33,6 +33,9 @@
 #define CQSPI_DUMMY_BYTES_MAX                   4
 #define CQSPI_DUMMY_CLKS_MAX                    31
 
+#define CMD_4BYTE_FAST_READ			0x0C
+#define CMD_4BYTE_OCTAL_READ			0x7c
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

