Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87153C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEA6876D2;
	Wed,  6 Dec 2023 06:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d9kw8DJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8930B876DD; Wed,  6 Dec 2023 06:34:10 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E03F876D0
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgTmWQSvyB5kRfSp7+fHOmkBK4DLZijda6O1sIlcH16uSlgzQQeRZzmb1jz8H80l+1jYxaDlV6o4k/Zdv+lhsdZBru1qM7ftajEVwvsCKZ7YAPnF7jMahnde+uTvYPv8p8IqFf7uDIhD8rcxZXRaAbu16hmWmcgF1FEn3KZjBBjkbRzgzIZWn1HN1yZ9spORMTOqIzaUl3nYBIinZY8I6DQfUjehSO3HDfSvgmMDM9EXf3WDGcqqCWiiKK1e7MsabLKz6v2+tmV9rfnTntA/AWJkkf76aQDNSOC41Ga7lltmWqBhYzcUuyf8PbVGLhbsuF/7v1p0dCPpUul0dfskgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0To8FOLfmZ6HSpwWfS6IxGRqt7AdfIWbOOTiZ67/Jco=;
 b=nWUsm5rjSVzixeV6v+FUklEmN/5BwEKAAzFDriyU1+tO4bwDlnpD6C6r89KTz2Ihu1VQbbZNxVDCxpnf7hqerITsyxrew2GiUwQW2ukCFRWt8RgJnPiKxq+SnXfUcoD3gv7HH2//R0RY1AiWBdO2naLjWHeE34C7ykipLRx1j0WfOkblNAQj0vQHNxbuIvd72frb8MlByREryTzyHhgYwPqpLHjvcIEkNLmP7lyaDXMikjRFVcK9QebI2INb08sedD7lm22Vkac92kClca+HcGQL8MRBJfDd+n7l/GYXx+h4ZD9qBOAu0CB4u9omYhnp9gidgrCQobq1z23EqO5Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0To8FOLfmZ6HSpwWfS6IxGRqt7AdfIWbOOTiZ67/Jco=;
 b=d9kw8DJJ5io9YUureQe5j+Y6IMzbbPeMpWImdP0Hfloauisot/WjF+zDuO/KxGDGVv2AG8Ctm0m2cA5ykLPWzA+i5j5nY/bQ1M1NIOXvFt2l2UD7uMt+FPLNUZAiiQBUFWK+apMk1nTPTva8Tx7E2WC8y2PoRtOA1YA8kW5cbNE=
Received: from BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:03 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::4) by BLAPR03CA0072.outlook.office365.com
 (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 21:34:02 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:00 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH 10/30] mtd: spi-nor: program quad enable bit for winbond
 flashes
Date: Wed, 6 Dec 2023 11:03:44 +0530
Message-ID: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 59256add-5fde-4aa9-92e3-08dbf61cf50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7+z5rqpvoRgKOlQ96hohxTx4rC8jb7yihLgy4O/v4rgiwBEs1DqohmSDvb4AI6Qt29fJ/5TVKplxb8Ea+ttkjxb8pD9Nwu+8+/ZBMuWG1kZ1UXSdBn+z+bUxZ5bO/R7Ii0B5IrjX7xAPDB+/H0dMS1Lho7NBCK70TbLocwujeWgB9kGsudmvX3PKbrPFUkIYx4ZyDe3PwtSNSYTBWtpltgdN+DwcQuJxK3I8/Xi2yKFBEz5Fzce5H/r+pEGwLXC3xmQAfhjQlcviZZrD8z2WQsIk9H1XIhfoeHcgE4r6lNzZnrfJrhmuQBM8sF/h5gb1/3yZlFVabTl9rd7KWVM4n3Qg7F9gh9JJmJ6ir98J51UPmughv4AipZY7chktO/g636uuJtky//CF5gMbiO1l15wwexPTCRHv0TY5RADXdJAU9Xhjd5L5Hdel6p3U2SHIugMh39bRVQLDJtmsaM8Uidy1J1ixTJpZczNwUokEps28kKocRWioYu1x3W63d2JJoDHhjzLhUho+MLUixUoV7IJM/RQst5EtSNZJG2toFlFjc04Sy4RKsMCXHU8sSvDSI9qVEfDhS8ry0xbHR3iqwZENSPnpge9/+v1IevqxOpEMKKpmQtFw4r8fODCZgFJTmM55AF66n4G0LZFEGlUGcSzfdrWe+4kVY5n32X/gMU+RfX9iI7q3TGwmzzJVVIDn4jPdrj6/woLP8irkheXM/5csOWIZX5b2ZAIxeci/MfgGQ8IFTQxdd+D9yZErN7JmvanjqkfqLTdgaWaKuUdKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(478600001)(26005)(5660300002)(36860700001)(6666004)(54906003)(316002)(336012)(70586007)(40480700001)(2616005)(6916009)(70206006)(8936002)(41300700001)(426003)(2906002)(36756003)(86362001)(103116003)(356005)(47076005)(40460700003)(4326008)(8676002)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:03.3387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59256add-5fde-4aa9-92e3-08dbf61cf50f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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

