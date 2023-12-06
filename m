Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EF9C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83468876D0;
	Wed,  6 Dec 2023 06:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/eSOECV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0CE876D0; Wed,  6 Dec 2023 06:34:15 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E46876E2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs8zeen3anim96Oce2ggNXHZ+ON7NzePgrel+60Us6qaR8Qai4NN4CbpeD36dxQxvon4Z95BCxXdl7g8UYWm2HS1O2EKlXRZdyZmUuCw9YOvPJiNZ0Hg2kMSjhIOXv2VafqqlctvL6jrmWsZ4dqfdPB+oZJfnuS+3e9ofVEt0ZMUpHIu35KjJPK0SwqTpPTTjy+e5IVxVb9YOV0aWfqYIurVY12HRY3Dx4llNAg0C2XfP4P2OejMpi61uK+NnNRuHTs/O2HTAOtbrdF3PxUOn7vTfd0A5TwAdVzvOYuhV6kxliDhh7qPhlSmuk41/4OswbFTrksA6NqHmS2KRixElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naXvD4xYEVWBAvpwru5R2DFlL4rkkKOiEHMTWrRdhlA=;
 b=PsuI4RQpB5kraA4tzYory/VyWVzr7vVNHvhcOvj/lMnXXd4r16kepPon7UHSERleSAOCiZBVlGuqMZPGH001MPIXTS5qH2ZEq+CyYwR9mSlIhcaiQTNJWDVsSY+1BgdWurpkPa7GHWMKkFB2GEFvPCZUDw9FE0d1K9gOT7ZcSTJ1usBcdLkeiX+NHe7wjb3kil3kEg+6kNKOzahViS0gp5+/xMtUfSriNJkY9wCWzhuI4movGxW4/pwJeCfg65MFaWkXTZFmbOgoNIguJ1g+MD5YeNRuneJB49wVMJtr2PbXE+KSse69Yx7bFbovGflT0Y0XoXQgm66eBTsk2OY/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naXvD4xYEVWBAvpwru5R2DFlL4rkkKOiEHMTWrRdhlA=;
 b=n/eSOECVR81R0+95pQr2DHQZh4K5JslCY0br9h95KnLsj+G+QCFgaQB/15o1yhXBoKKipOs8p9m8B6a5dviLewi4sxnczmdkXIcVQr/fx0vz011DFxsu5QgKFnf9TTMekfbbmg1mcXFYZGkmQND82Flge1IrWEZ0dDSLyM2FB98=
Received: from SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::19)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:09 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::18) by SA1P222CA0125.outlook.office365.com
 (2603:10b6:806:3c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:05 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:03 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@xilinx.com>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 11/30] mtd: spi-nor: Send write disable cmd after every write
 enable
Date: Wed, 6 Dec 2023 11:03:45 +0530
Message-ID: <20231206053353.3745918-2-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a802a9-5f8d-4979-42d5-08dbf61cf885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omdjtyztQEtYUAy8DW900pB1bfn+Hd2u8HjbA/m7IZHlf/7eNZ1Q2jFABEF9bYTe2VXuDkWqMdbBuZgriwkos7f1Ry1VzzjI54JF/oVG0Z69KZo7rmZz/BmlAVgd5sOdgDpZR43Kqx2RIe6NDdjzccNAMbB9gNbfhexlgRA799jYzobXLaclLhKMN0aZCbKldJWyeEwPUbD/9GvaBuValDBLJOw2o9W9k5R0mC5KPykYOLoCB4RvvenwymyONx4ZscuPgJJaDeaGyS8AFtE+ekmZHqfnDKbdeZz+T1B4nx/NUjsCYIotsN225U9J79vwaRTP87pFD8cXHMTquh78hl2uksGQkkoQpkuDTEAGIU4K1mLF1zUyzroPO4IgeYAqp+BIM5xdMD2+nx0OnuFeKePyOKmCdExCTpeuHfPvhqtKQTpTOCyCYHRQzYBMS2a8gTWx6NOr9mqQJ4ygTZPWhtYTVRzcnGBoquugfUgULqc1xnOHbm405KVkx4gpnoKWAm/tyxQwWik1VKDz+/MmbtgnNMGXghAeD8x7LGvBED2b+bVbrVIDHxBmscuPy39JuEGOc21KlDpI+fcqHqDDnNeCU8SPFus1Io8/qoEL/VUXY39xSMpeK2OW/5/ETNLgsgQcEKKMt3o3ROmIZgJfrBCNqOlWBIkEf6PyR5+KSv5yMrjOYf3ltiVLMa316tO7+zhU+F4itJasVHVrsCpA4bzXgpk+dbOBWH1ho49FVGG8SQxbM9KNHi//q4HtbPFTgBrOKOrO8ycU5fla9tPeHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(5660300002)(2906002)(41300700001)(103116003)(40460700003)(86362001)(47076005)(356005)(81166007)(2616005)(36860700001)(1076003)(6666004)(83380400001)(426003)(336012)(40480700001)(478600001)(82740400003)(26005)(4326008)(8936002)(316002)(8676002)(6916009)(54906003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:09.1588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a802a9-5f8d-4979-42d5-08dbf61cf885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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

From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>

Write enable(06h) command will be sent to a flash device to
set the write enable latch bit before every program, erase,
write command. After that write disable command (04h) needs
to be sent to clear the write enable latch.

This write_disable() is missing at the majority of the places
in the driver, add it to clear write enable latch.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Acked-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/mtd/spi/spi-nor-core.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 454ae6cd4e..d790116994 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -873,6 +873,7 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor)
 static int clean_bar(struct spi_nor *nor)
 {
 	u8 cmd, bank_sel = 0;
+	int ret;
 
 	if (nor->bank_curr == 0)
 		return 0;
@@ -880,7 +881,11 @@ static int clean_bar(struct spi_nor *nor)
 	nor->bank_curr = 0;
 	write_enable(nor);
 
-	return nor->write_reg(nor, cmd, &bank_sel, 1);
+	ret = nor->write_reg(nor, cmd, &bank_sel, 1);
+	if (ret)
+		return ret;
+
+	return write_disable(nor);
 }
 
 static int write_bar(struct spi_nor *nor, u32 offset)
@@ -1070,11 +1075,15 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 				nor->spi->flags &= ~SPI_XFER_U_PAGE;
 			}
 		}
+		if (nor->addr_width == 3) {
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
-		if (ret < 0)
-			goto erase_err;
+		/* Update Extended Address Register */
+			ret = write_bar(nor, addr);
+			if (ret < 0)
+				goto erase_err;
 #endif
+		}
+
 		ret = write_enable(nor);
 		if (ret < 0)
 			goto erase_err;
@@ -1195,6 +1204,10 @@ static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
 	if (ret)
 		return ret;
 
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
 	ret = read_sr(nor);
 	if (ret < 0)
 		return ret;
@@ -1758,13 +1771,18 @@ static int sst26_lock_ctl(struct spi_nor *nor, loff_t ofs, uint64_t len, enum lo
 	if (ctl == SST26_CTL_CHECK)
 		return 0;
 
+	/* Write latch enable before write operation */
+	ret = write_enable(nor);
+	if (ret)
+		return ret;
+
 	ret = nor->write_reg(nor, SPINOR_OP_WRITE_BPR, bpr_buff, bpr_size);
 	if (ret < 0) {
 		dev_err(nor->dev, "fail to write block-protection register\n");
 		return ret;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 
 static int sst26_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
@@ -2138,7 +2156,7 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 		return ret;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 
 /**
@@ -4248,6 +4266,7 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor)
 
 static int spi_nor_init(struct spi_nor *nor)
 {
+	u8 sr2;
 	int err;
 
 	if (nor->flags & SNOR_F_HAS_PARALLEL)
@@ -4271,6 +4290,22 @@ static int spi_nor_init(struct spi_nor *nor)
 		write_enable(nor);
 		write_sr(nor, 0);
 		spi_nor_wait_till_ready(nor);
+
+		if (JEDEC_MFR(nor->info) == SNOR_MFR_WINBOND) {
+			write_enable(nor);
+			sr2 = 0;
+			err = nor->write_reg(nor,
+					     SPINOR_OP_WIN_WRSR2, &sr2, 1);
+			if (err < 0) {
+				dev_dbg(nor->dev,
+					"error while writing SR-2 register\n");
+				return -EINVAL;
+			}
+			spi_nor_wait_till_ready(nor);
+		}
+		err = write_disable(nor);
+		if (err)
+			return err;
 	}
 
 	if (nor->quad_enable) {
-- 
2.27.0

