Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2250FC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64007877F4;
	Mon, 22 Jan 2024 12:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPc4cuoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33B08780E; Mon, 22 Jan 2024 12:14:03 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC83876E4
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GODuMlBWcEt5KYKwvJvB180p3uwa29l6+QBMhBpYbTwkTuTrsK4iZYb+9fMINprvDvD8A9H5gZUvY42vwRFRKStY35MrpyLwnIiC1HFcBdnP73Hu/amJfYQPiHovBzp2s4Y8QnvR4s1f2cLU/D7eUPav1cEEwJ45gp1i4+3BeJZMm1qhJxpJUoxK9q86VnHLIiofGHrTi8dH5Xsnsdfw9LAG6Bn1+esqmfcZGCaT+8YBJ6QBu6KJRgi+Kx21A5TPlt2CGIJ+ohCxOlfAqFToSdq5ZLkDqleR4ilmP92ADETyXEWjXmwYhGE3lp6vL5WKHw8tZRXcvHdmudpduY0bHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6oDtFrktw/Ux9osWuXLEFwZ8lZiMK1n1nfLkGTdmmM=;
 b=I0MgdAbC0EkkIaKFIg0aqanQwDXADLYBOGAPLN6nC04O+lCf7scGgonORGH0Va5VgGt3PfPx9z7jY3OH4Cf8lA+kr9zjsAK+AEcGwdkkEJ+00JzoMuBbPlNhvS32qJwXa8FPSLZYkRgZwiWYqoFMoABn/l4TUdVkTgYF46P+pFAhR1Db0ZVbctmjC4CmFth4wreFhSGXdXBRpKmXBUD0iiPB28f9NB6Nq1oSSLUt+bi8P/0QTUmFMuNV8Lu64AIBqPMYTMCp7T9qSshgpFhXqx/qDJz3RtXU/ifTMP5QjPmgsqSy7U9zw8KSFqo0Gh2ackkfvM1V3DC/9y6c+uzOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6oDtFrktw/Ux9osWuXLEFwZ8lZiMK1n1nfLkGTdmmM=;
 b=tPc4cuoaRQ3ju6VwY1CMa/VSK5dXbU/qMnyNqSM6KAZMPPAZIg9FiCD6ypjMEffkxQ2UfPgZpRmhzAziXmutb/GRUnuVfiAsPY0GazdXZ+Aqa/0gKUhqRbHepGuynm53XzblhovpFsA3G2dHz7O96ZX/I4fZf2dJyXKxVxEiIeQ=
Received: from CY5PR19CA0080.namprd19.prod.outlook.com (2603:10b6:930:69::29)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 11:13:56 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::63) by CY5PR19CA0080.outlook.office365.com
 (2603:10b6:930:69::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Mon, 22 Jan 2024 11:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 11:13:55 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 05:13:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 22 Jan
 2024 03:13:54 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 22 Jan 2024 05:13:52 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <a-nandan@ti.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <git@xilinx.com>
Subject: [PATCH RFC] spi: cadence_qspi: Address the comparison failure for 0-8
Date: Mon, 22 Jan 2024 16:43:45 +0530
Message-ID: <20240122111345.2383833-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: f873316f-2c42-4b24-0c2c-08dc1b3b3920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQJbVx2jQhG0ukwpKcQkUFOfUOP359DcxT3RFpXomVCsSJJRyUOUcEBULMFHNwEyYkzXaAK5VlgifOGgp1E/1coO+8aRSVSBNCfpAmExIdt1ZhKj/VOmQzeWufonzA3B5X7lbeIzU2eeiMVmirf6icAYKS1F95W55i/L+wMeZ/Ew7SUi7nshhOdUq3TQubQ2W/LqNAP/9F3O2BPPugrBqfyOh+wbuavdBgHp7jOdVqPdZrUFK3dJfAIv9H7j5RVV/T66sTpSzqLX7MqyQUbrCjGSkBta6jUWMXFHZFDX/PydLw0q6VG267xVJS+LDvvZphZjkuxihFeKl5sQbpfGdGXUizrnN8davponV5PnlAy/hdD5KxERBdmQjvLGKCcwAqQEpt/4/D0pnsZ+amfHx5gsEiLh553+Fa94xh3m1NCtLYPD+edYyEzJL1LG6nqxLULyU3WfU70pGw6F5s5swASQtomAFbUysqd0USVqSv+Xgvj8kiPEWeO2mbqtjU+iWYJqrZqdZrr+jlGslRbWNgFQ9YwkJs6K3VhsU5ix/xaqkiLRjiPUmvL8Sp9LRaHNhuIDvBT4ZxdEku+lQD/3RU+H4/D8jDBk+M2Vjxk/PeCaFVJ0uvrgWIuEUolJh3XdUbwl71ofJljYWTgSloTmL9oUP075GcjPFKRxSVNsoU1JLe1YYV/Tug3EXZ+SQ3ujYE6+tIQz8J4j3l6CROD0Lt8+O0ugSfomb9BcDQ84rg6xF9+EUQKB+20kpYIb/Kf1sllEo7ZJIPRQIMjw7h7atg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(8936002)(8676002)(4326008)(54906003)(6916009)(316002)(86362001)(478600001)(70586007)(70206006)(2616005)(107886003)(1076003)(36756003)(336012)(426003)(4743002)(26005)(6666004)(5660300002)(2906002)(103116003)(41300700001)(47076005)(40480700001)(40460700003)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 11:13:55.3939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f873316f-2c42-4b24-0c2c-08dc1b3b3920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

In the current implementation, the test for data ranging from 0 to 8 bytes 
is encountering failures. This has been confirmed through testing with both
ISSI (IS25WX256) and Micron (MT35XU02G) Flash in SDR mode exclusively.

Upon analysis, it was observed that utilizing the "SPI_NOR_OCTAL_READ" 
flag and attempting to read less than 8 bytes in STIG mode results in a 
failure to read, leading to a failure in the compare test.

Upon reviewing the Micron OSPI flash data sheet, it was noted that for 
protocol 1-1-8, 8 dummy clock cycles are required. While the current 
implementation achieves this, it still results in a compare test failure.

Therefore, the code has been revised to include DMA read for operations 
involving less than 8 bytes as well.

Fixes: 53f4ef0 ("spi: cadence_qspi: use STIG mode for small reads")

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com> 
---
 drivers/spi/cadence_qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index dfc74c882d..a6477dbfcf 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -313,7 +313,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		 * which is unsupported on some flash devices during register
 		 * reads, prefer STIG mode for such small reads.
 		 */
-		if (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		if (!op->addr.nbytes)
 			mode = CQSPI_STIG_READ;
 		else
 			mode = CQSPI_READ;
-- 
2.27.0

