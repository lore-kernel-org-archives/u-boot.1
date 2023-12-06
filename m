Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1E7C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07F987737;
	Wed,  6 Dec 2023 10:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aAYDr5Sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7584E87736; Wed,  6 Dec 2023 10:32:33 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA41876F4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9Hb9Q5LLkbiRwPlLgSAa31cKoKRboG138B7+xdGINUw4k7Iz2kP621sOQoUxYaMWxI39l3+zZywYiM82yb5jqEq4T+EzI0qr/cQjFXSOpxXtmFXjSl2VOc0zRAveqHuFHRRQ16OTrYu/G/rttKlS2/CqnpCqfJYZwwpwAu1xMplPM7SXIhj3hJ6ZLRu5+MSJYRy+FWapEVsoyYYacvzHXBPY6XPmlynoqOBg3bLXtmhwXirSJKWHv6asiK7+5uiyNeofZluPwY1TKJftFC3h/2pwmhPLGwM3r6jhY4T/sfPcC0tACFRdM+l/B8OH1rHJbSb4QVfRUFz875d4ACcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naXvD4xYEVWBAvpwru5R2DFlL4rkkKOiEHMTWrRdhlA=;
 b=NFrfr7/8wdD1TaHTPhIOIbgf2maYIbJKOj5OfWGfJQpSemlcC4zp9jLfzv2ubqkYMJijMxawgDrCfcVi3dED8yk8oV1BtZk1gcFYbvIb6axKuKx7lT0SpPWPEpB5nZysyV4DCmwW4ATnyh3k5vGDn5/gwmbWjPb92mPWU8qMP1KxjzTBu8zWxPUrAt3avL03p4Dx3GgTo9ddXXd/RNKxgmuvMAIQWD2FcK8EbFimY47nON7F3WujM1EC4O5Z8k5+7DCVgw86xjyEZQGBEEPyx/vm8YKks+byxlflkMlQiUZSsdbpRfdySxsS93lxJiYaF0/5u4ej2Nr72Ue9YmfqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naXvD4xYEVWBAvpwru5R2DFlL4rkkKOiEHMTWrRdhlA=;
 b=aAYDr5SniC7fhfsLRQqva02J3fUJXNCljidmcE9xmMuRNHmGK7y5BQrX7szUafCuwBpiXMKA6GQImC0Sjn4ahsMyYBMAZfOKL+b7CsJ5lSjgcHW3MolMwo0dPsODElVymqt+6/Imi/EPfMcPgyPDE1KER/maOARrae1WOYvUrhg=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:32:27 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::2a) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:26 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:23 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@xilinx.com>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 11/30] mtd: spi-nor: Send write disable cmd after every
 write enable
Date: Wed, 6 Dec 2023 15:01:22 +0530
Message-ID: <b84827db59bbbcb49ebe5d488f029486221e2130.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c04af0-6ed2-475d-2d89-08dbf63e431a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTmMiM3X2ol4X8X2IdetTNNFSdhaxVlHVly//hPVx1FZ/SSGQaUZbXHtujUdgEG0qm50aga+mZ77/DGImw18A5TI86VedioaP2pC2CSHaf2o+6EcWkgYJzP+q6xIbNGnD5SMywrYYOKitde3zDzBJXS3S3Qp+tTsP5NANbVpuZ6R2VTGVLq30oXxDqaqR/DTEYaF3d3Ar8cLktPs2ZnPGA4f5gg/cTn92ZDAsMd4nnCCwzsclJUS3JyNEI22ZWP0C/ApMyL+T1LTe3n0qTyJUrtFkExfibCrVUEDdktK/qjL0NtlY1cvLVHfwXYUhV0KwXBpAd2ch/enoZk2pBFbvA61E+Scaojkru9uyR9ZQ+JnY9uFiijk5o4auSuKlX9SXKzRsf6o/RjF5pryYjRzWMZ3vxyDs6x7JAP/VvWI6hYgX57t4C3LH1xQQwCLrQsHcccPK0z4oXy3m6bZl0E9fJfPEYu9DiWKHwa0Rj2cE+l5IS2Bxnibp6XcK2WHX23lIcOZAS6Y49oUSHKysdSKQ/Fr380nLkDulhKFKe5iSWwk5q37OAH0c6OjD+qFBhH4Yy1ez9F+QtkZO8UAIQ83t6HhZIT2KKxHMbcdOEDvLxBQAy6+5z/K7opZ1P7sFyq9WsXOxezwG9Oj5sJA/klrHMz206TocQLqy81ZuvasybR7GFM3dFsErQmT8J4C9kKs2OUxYWRL0VUf5VznWMRScVaRqhpPw/tKuLYcq81TuI9Rs201bND0sMLve9euHJknkKSAHCDBKQWYZOQuni6vwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(70206006)(336012)(6916009)(70586007)(54906003)(316002)(40460700003)(4326008)(86362001)(8936002)(36756003)(8676002)(81166007)(478600001)(356005)(2906002)(2616005)(83380400001)(26005)(47076005)(41300700001)(426003)(36860700001)(82740400003)(5660300002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:27.6157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c04af0-6ed2-475d-2d89-08dbf63e431a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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

