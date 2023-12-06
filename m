Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4726EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60064876D3;
	Wed,  6 Dec 2023 10:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0Mu3yzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933D7876D3; Wed,  6 Dec 2023 10:32:31 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600CB86CF4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQSqSj+1XldTRlVknB30M29uu8YicKDw86dhvQcodpGeV8WAFxtEFrLhpKB9yi8lt/7kRr7bmKkUy6p65qApsJrixHTnLcd2ALoPQ3m35wXEqJ1scL9aI8iOZagxvddWgNa6WFcRBTqAgnDXRWy+OAzMNTdAGVY89PcYhwsYWIq3IB6e/ngF+cmuWu2Ea1jF44Ut1lSP1inqT7Biuo0hkSDqA71JpyifvFe71Hc8xeMPSNeGAHTrzaMRSJ2J4sqSieMerLVsSOnWV8ZYtR2jQhW9rLRbXShDJrcu4EFtZGJYgbvGbpHan/AMqYRvGZS9jU2wRClQ9d9GSTzobnVm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0To8FOLfmZ6HSpwWfS6IxGRqt7AdfIWbOOTiZ67/Jco=;
 b=OUUL6vVNAET4HYCyN1BAFc04KoRB8wId/UV4/X7IzPv122aDtsWqgFAsfYkEAUwGcz0RcpxSwvPghpTiLkcp7V7dOQFKsOAJLODBht6z+1b1Vi2xG42uRBcipGA1Ak3kMeil54oTjyceNNKiQs9jn41Ny61e+QWk7L71/ZxfEVXQj/+O6ZS1/guQYU26yJw+Xl2uL0upts4bLnkCldnDHzQie4IG6UY4EednKLDsIryrrrUg67lDl0twi3GT0QugUUqkCF7vIR6hU1adhQP+r2y1v1KjL3E0vOqjpvBAOWXiUORODyU1ejx8jVQYTxFWMWQoz2kyMUyaDbvjiU2zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0To8FOLfmZ6HSpwWfS6IxGRqt7AdfIWbOOTiZ67/Jco=;
 b=o0Mu3yzJJ9uMoYBeCfPwSOLuX8nKz5nA/eUFHFVayDUgLm17u1106szYIezfmiLcV9/NYBF0A15N7rcCKYR078ASbLbXt0N6IdICH7Z8xRZ3uW+WjxcFdk+4TTexGn0yTuscPuucxtICGwJnFEbg83dvNHXzW/sEr/Z+bvPNZ0M=
Received: from DM6PR18CA0032.namprd18.prod.outlook.com (2603:10b6:5:15b::45)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:32:24 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::b7) by DM6PR18CA0032.outlook.office365.com
 (2603:10b6:5:15b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:23 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:21 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH v2 10/30] mtd: spi-nor: program quad enable bit for winbond
 flashes
Date: Wed, 6 Dec 2023 15:01:21 +0530
Message-ID: <d773587de9807051a933b7ec37f4c687641521d7.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 1383e13c-163b-4e7f-a7f1-08dbf63e412c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0tNtJpBlS9u8dC2BIOSkdiLTx610qzo0xeovXrixWG0l1v7CSMz7qYtpQkhD7uPB2bOU1iPFKWT3/sS4NyZsGSTVCFH4sVP/U/H8X4QYV7SRKKidwC5PD+eKN5TWP2JVaPggbC8xUcKQjGR28JdG9MYIVUycaTpaTCFXL55KqTbLXoCagfKpaBB5dzmDH6Qj+hOHzdTJHUZA8k7RAwqK8/JjnOy4DIMnwFJtCDvVIt7EG/o8dKEw5HxL6S1gGa5d7IYOkxcwpZJrXhQDEtCUIgHtebBNTiagdo5sdtZzUzCXvZcERbAvPHp6ADm3SAkuvZD4hUoC1v6KLKUxFOlHkWxBSN1638X5B/7Rxys/P3dCrWW24fHn6QNumOp+zZB7wXg83yB6OwAmeLKV0SD3KMP93371XE1JuHG/FrT2vgqLh/OTJRb0f3NvoAbR/u4ajJzbAhsJFWdoYxOVv/Ub6jfPGRaHhDO5lSnr/BKM1efzz6QLidWNH7NQHJb0V4bnUsXia1bF+Q9euoscVtXR2kehgxqKmyTifvOCXmlSp2jjfJT08J6dL5szLaxwr3NaEkWFaehkbb0RpHoTH86kyZoeiiEj6vccfmm+q9ym3RcR/tEeIMWpe8mUkwBHQeoTfWtpLw1QaPdDPiQ2tPUDoUtqM7jKaUAhYLi6b0O4C8VGZFZkiawkpTMLjQr2KfOb1NzrUVuTCARTX2awKtXxwLFMWbZeLeka5STvR9sYXIfzKah8iwOP+1gBsMLiutUEz+92EZEBm4fSoxM6EWUsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(82740400003)(2906002)(36860700001)(36756003)(86362001)(356005)(41300700001)(47076005)(2616005)(4326008)(8676002)(26005)(81166007)(478600001)(70586007)(70206006)(336012)(426003)(6916009)(54906003)(316002)(8936002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:24.3657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1383e13c-163b-4e7f-a7f1-08dbf63e412c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

Added support to program quad enable bit for Winbond flash memory.
Previously, the quad enable function from Spansion was used for
this purpose. However, for Winbond flash memory, the quad
enable bit is configured by programming the Write Status Register-2
(SR-2) rather than the Configuration Register (CR).

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Co-developed-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 48 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ace5da9591..454ae6cd4e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -2141,6 +2141,49 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 	return 0;
 }
 
+/**
+ * winbond_quad_enable() - Set QE bit in status register-2
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int winbond_quad_enable(struct spi_nor *nor)
+{
+	int ret;
+	u8 cr = 0;
+
+	/* Check current Quad Enable bit value. */
+	cr = read_cr(nor);
+	if (cr < 0) {
+		dev_dbg(nor->dev,
+			"error while reading configuration register\n");
+		return -EINVAL;
+	}
+
+	if (cr & SR2_QUAD_EN_BIT1)
+		return 0;
+
+	cr |= SR2_QUAD_EN_BIT1;
+
+	write_enable(nor);
+
+	ret = nor->write_reg(nor, SPINOR_OP_WIN_WRSR2, &cr, 1);
+	if (ret < 0) {
+		dev_dbg(nor->dev,
+			"error while writing configuration register\n");
+		return -EINVAL;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret) {
+		dev_dbg(nor->dev,
+			"timeout while writing configuration register\n");
+		return ret;
+	}
+
+	return write_disable(nor);
+}
+
 /**
  * spansion_read_cr_quad_enable() - set QE bit in Configuration Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -3052,6 +3095,11 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		case SNOR_MFR_MICRON:
 			break;
 
+#if defined(CONFIG_SPI_FLASH_WINBOND)
+		case SNOR_MFR_WINBOND:
+			params->quad_enable = winbond_quad_enable;
+			break;
+#endif
 		default:
 #if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
 			/* Kept only for backward compatibility purpose. */
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 72206f51ad..34e0aedc24 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -48,6 +48,7 @@
 #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
 #define SPINOR_OP_RDSR2		0x3f	/* Read status register 2 */
 #define SPINOR_OP_WRSR2		0x3e	/* Write status register 2 */
+#define SPINOR_OP_WIN_WRSR2	0x31	/* Winbond Write status register 2 */
 #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual Output SPI) */
@@ -187,6 +188,7 @@
 
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
+#define SR2_QUAD_EN_BIT1	BIT(1)	/* Winbond Quad I/O */
 
 /*
  * Maximum number of flashes that can be connected
-- 
2.27.0

