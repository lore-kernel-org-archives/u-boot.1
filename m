Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF45CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 03:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE418721D;
	Fri, 20 Oct 2023 05:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFn9A2aS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B0387207; Fri, 20 Oct 2023 05:18:58 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85FF987205
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVFOFjlT53uSb4/YyuwGOvHxUVwTYp/PQylFyoLo7Az96wrkZuJtv93JXfvOpEkIPrtJrr0epbIx0mXpWfG1VK4sA9iRfwTWH25OjOfVw9joerE4RdBr0Mj5H+KwWrod5QqSWKQL8KKcx51rhoN20oSxoB90CD85WgDvYcxjLYzkoWQZcrZjbcA+dfc1l9CQuWpQJMocJcaJZpzJ8fEBm1GS+HK7Q3KfxQiRUMup6QnIE7LUsTnZz9iqelLV4hwl9yd1UXy+oTQbPfjAlZmwPJmJ7cmxY7Camx8TUcYDvUsF8AdfbEMM+YqwHj/VukwHU5M05LEtJaOilseK38Vqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjh3dYwpPXkUiUDxiCq31gZNLiRGlWTUgUVcFDnmDJs=;
 b=VwHfl54bbtDap2rluuiww8YPX6PYEqM+TEMl1vCKeiRsgqRU3UYzJmeqPhaZ8VHz2tKVd4QXpfInhOXQczo1sxYtBYRoMIaeMc/Zcbm8uv4ozAim+z53ZIGeyBCBFQqY8ovn425kcaQzkGD2zw+c/MjNZb1JYdE6n96yIhhGgworpDcgSDugdcXKAOhJQuJ7IUd7unv2dO0EKYOgMg7aKUSPLF1gsSMbFOf3xZFFY0df5REiJgchL7yh+TJMtx5eK0ng8+NtBYJHeA2PXoYG/Ab6MFuec6bXBO/AYB9jX5tHC59Y595O6vxwOwxLvTB2IjAH8xsVQvP8KCttsl/5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjh3dYwpPXkUiUDxiCq31gZNLiRGlWTUgUVcFDnmDJs=;
 b=wFn9A2aSVdkonwRgea0caKqtVF1vxJ4YUXa5gpVwkEtUfH5xv1w1Gcrt16/ZYx0ISHfePtRN9lpC2uydWwbnJ35a+VOq2yjt3NKR3GmtG8NbOsJI8vJ1R9N/bD21CTun9g47J4gZC2UIUC51AteSM6OQAC4H0IiLpp0+GBliydo=
Received: from CY8PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:44::28)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Fri, 20 Oct
 2023 03:18:51 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::3e) by CY8PR19CA0019.outlook.office365.com
 (2603:10b6:930:44::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 03:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 03:18:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 22:18:49 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 22:18:47 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v3 2/6] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Fri, 20 Oct 2023 08:48:13 +0530
Message-ID: <20231020031817.267959-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
References: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4aefd6-3cee-485e-801d-08dbd11b47ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j38b/EbTTEdgRYf7i4H0Ek+UbCzbdhimLRbFyqkZR7WXpuwuAMOZhr1e+69CPtoYRxmZRfvmjLmTTjbc6UHXemVPVMi5BCiFcvmbnnipDe5Oqpd3sYpS5li1s/CNQ/+sUSShhts3GAr+pATUpg24b+rb/vUITwhMJ2hxEya8fS7itLo9jGQEY25kli6g93+vz2Zqeb67l3Qci1+BgIIClI3FVuHbSHO7U0W2J9d+nfrsYoO5YbEJJkqfEoLqeb+GmfcIYV356xMJhON0R7cdroJ+V8eibL+dZjlLNMWM4dPepgIEFz6K7HCc1ePGfEfmL6J6Ewo3fOyFieDOZezdIkcmf6YhqYRkKytLbA70M6NJym9lzD72RQg8G7oS4xaFkNeQYCBQtM+NRyKLHFkPH3aKrhZof1GlRoo6Pv/4a87QzCkSbiS/1oZPysmKsRfj8C0SErVDHgruvnMyGUDzKvylAlVpY2ggLZsxBehECVIHrZfqvxFpboL9Q5zFjjOY6EVygkSUXGVuJrVJCc0D2UDPCe0VY4Uxw3oFL81PqTd+p5aZGmcU5+G5gn45ZAV8Ui6Q0aOmNZxiCsKEGztJOcbV6mF8cBMx0YtPKyS1n8ovKW0rccixaRCpPs2w89QOjBIOJWGycES/mTo045SOALR0p+peBukHunKklNCSnsYiqszgT7+a4kEO2/3CQkvC5fvt3/cm6f3NvpG4MSu6EpG7kW8Tr/jcgHCbpOQDTHQAkMvKqV2GdPawJ4PWWt8nuvYdaaZ6LlJK2feoqkbMTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40480700001)(36860700001)(40460700003)(41300700001)(26005)(426003)(2616005)(2906002)(1076003)(36756003)(4326008)(8676002)(8936002)(86362001)(336012)(47076005)(82740400003)(356005)(81166007)(83380400001)(6666004)(5660300002)(6916009)(316002)(478600001)(70206006)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:18:50.0738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4aefd6-3cee-485e-801d-08dbd11b47ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

Add support for parallel memories flash configuration in read status
register and read flag status register functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index b2e5494e78..373979d19b 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -438,8 +438,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 }
 
 /*
- * Read the status register, returning its value in the location
- * Return the status register value.
+ * Return the status register value. If the chip is parallel, then the
+ * read will be striped, so we should read 2 bytes to get the sr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_sr(struct spi_nor *nor)
@@ -471,18 +472,29 @@ static int read_sr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading SR\n", (int)ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] |= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
- * Read the flag status register, returning its value in the location
- * Return the status register value.
+ * Return the flag status register value. If the chip is parallel, then
+ * the read will be striped, so we should read 2 bytes to get the fsr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_fsr(struct spi_nor *nor)
@@ -514,13 +526,23 @@ static int read_fsr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading FSR\n", ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] &= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading FSR\n", ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
-- 
2.25.1

