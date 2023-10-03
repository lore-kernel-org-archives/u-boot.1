Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5D0E776F4
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 03:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202EE87165;
	Tue,  3 Oct 2023 05:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nUs6qNrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3725D87156; Tue,  3 Oct 2023 05:17:45 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB5587165
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 05:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yupm703yFfZO1Wpc27nd87yt7H5DF9ePaLpaGa8BSm7UDe0zr9lfsMBDRVsQWOXf25EUQ7ywBVPL1ciNI3bvg8g0vicYov3RZ8W9QuHKdOOnIaUFZoQo/TW9Ry78/a8Ubwi66ju8O7O8TCoidil/KBCnzaQ/lSYh7UHj8W6nzD1//qTN8Xj6ay76hGyEyPcciKLMn2ry+e7dzwtH95PcLoOXp+Y/Bnr0DC4B2OZvemoBE7/7v9z2Jxpo/1VxBMGwkdtew3EdNy/n1ipFFMTTaWgqgkb3WIIv9kxe/7y1fZ4WhobGrwZTjCHg/Ui6DICIew1lm9Npq5NzIRSQpuf0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHN7wy6FWPtCY7hEuaMM3l4HerGNBHdEB20IZYrwjQs=;
 b=IvHH1fhFMc1WnyTGbKf6ddXmimKgVQPD0gYuoE7c7kNoK5uto6YrAKKzuuU5epXKHuPOIvGy8oYvcA2FSsKlJZDpLKoGHRz4WP0PwRQtvr8VatE6N3C8dlGMGY9DunAHVcaQ5epN710PQR0bXSC7piXY+e5sstwPzQKHeDiMpCQOCxMFDFbAWSlpHTVjsWjAiGNmwX2OqsPgNx72JtnVUMsE+VaYAHdzYIl3ocxeXpw2G3R0phpYAsmIPBoFktAdvhCy2VlhCXQJhYzHU998Rn4lxLm4L9uUj501FBOp45PefgiR/AHiQ/VdFBV6W8U2ur67sTtYqxLFA3njKEvWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHN7wy6FWPtCY7hEuaMM3l4HerGNBHdEB20IZYrwjQs=;
 b=nUs6qNrMiIXT1yCrLtqzpZBjTxWp0dCYF7skxVkF3SiREyZvgeRyzDAHrBhAS1tp3jzTfMaGo8atifRfMPd4XoYIPAyJ/psX2CLmAM1BlOvHwfzclbzjjQ4eoUcvjTrXUme+tycftzq+JQ/fBNXzQFOMO61vvEvm0to8YvsgyXE=
Received: from BL1PR13CA0117.namprd13.prod.outlook.com (2603:10b6:208:2b9::32)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 3 Oct
 2023 03:17:38 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::3) by BL1PR13CA0117.outlook.office365.com
 (2603:10b6:208:2b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.23 via Frontend
 Transport; Tue, 3 Oct 2023 03:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:17:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 20:17:30 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 22:17:29 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: Add spi flash lock config option
Date: Tue, 3 Oct 2023 08:47:13 +0530
Message-ID: <20231003031715.5343-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
References: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 44750911-c4ed-4d6c-adbe-08dbc3bf4b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyQoWbn1Cj9EC2KlKzdQcAPA56mUOs4iDUwx8b24HacDxc1GBFp7wBedoYHq/nXgfo4WF5oXedHn6VzlDDz0c5cesfaKzHYtHZV4rqJOBSX4FCHV701OfyOouD5wXtUtwDyVS4kUhYenPrf4xTEPqusCqPjtw9joZLNp4X4Oxe6x2OPZkR147N/epOVs7JB+nFA8eOWdil5Ojh3PHw2qGxQRLLENpwOxIoa7sGjxI0dnMd6qDGhO5jrtanLz1GiTBnAk6Hr8gv6MLuCzlwbsfXw4k4CIEp76GvBNg/QQJhvLHsBiE9h/Y4Yfjll3VH5+cReCRmjMHn+L1fnIxr9xMbesMmeCsfdOg/uhfTGd0RX1bKRLoWIc+xIfp1HrJOQGX6KMpkvw4NNXSW07bTSuSYtOtb3myZTXqZHHs9B1EMaurA9bEdvySi74qsCLegmIQT4ZU9AB5mETlTS2BYhFFQLoxId2QKimBGMI5JGLR4Pl+9FoABzvM7HBnANlMLeQWAlUZlBcFcPdUsfrcyE8+j7H7pqrrE63XCMDTsU9AclTBmbbA4ci419qubGChb+ACtR4S9cgQnNWp9xF/1dPA6sNK9uKo4Pr8ICr2Nm+kP11AGEupMtyRmw56qaCDJWylrBWLP8DTS32YSEjc/15QQpzqlG5PKd0DQlxa8C6i4ieRb4qWuHilIwzthB8/z52CySLnmJGNOiXn9bYFEgCggZyTEOy5lqNaD/dkAJHURxT61zQVrrxoY/9YfFMLRKEENaugAqOyPtrA2WzAr5tbqUeanH+/pAEgKfneGRuR+aZ74JCogmrbEM2r89SosO/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(4326008)(41300700001)(8936002)(8676002)(316002)(70586007)(70206006)(54906003)(6916009)(478600001)(36756003)(6666004)(26005)(1076003)(107886003)(2616005)(83380400001)(426003)(336012)(40460700003)(47076005)(36860700001)(356005)(81166007)(82740400003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:17:37.6072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44750911-c4ed-4d6c-adbe-08dbc3bf4b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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

Provide an explicit configuration option to disable default "lock"
of any flash chip which supports locking. By disabling the lock
config will save some amount of memory and also don't expose the
lock functionality to the users i.e., via sf protect command.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/sf.c                       | 4 +++-
 drivers/mtd/spi/Kconfig        | 7 +++++++
 drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index 55bef2f769..fa0be4248c 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -604,7 +604,7 @@ static int do_spi_flash(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = do_spi_flash_read_write(argc, argv);
 	else if (strcmp(cmd, "erase") == 0)
 		ret = do_spi_flash_erase(argc, argv);
-	else if (strcmp(cmd, "protect") == 0)
+	else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "protect") == 0)
 		ret = do_spi_protect(argc, argv);
 	else if (IS_ENABLED(CONFIG_CMD_SF_TEST) && !strcmp(cmd, "test"))
 		ret = do_spi_flash_test(argc, argv);
@@ -630,8 +630,10 @@ static const char long_help[] =
 	"sf update addr offset|partition len	- erase and write `len' bytes from memory\n"
 	"					  at `addr' to flash at `offset'\n"
 	"					  or to start of mtd `partition'\n"
+#ifdef CONFIG_SPI_FLASH_LOCK
 	"sf protect lock/unlock sector len	- protect/unprotect 'len' bytes starting\n"
 	"					  at address 'sector'"
+#endif
 #ifdef CONFIG_CMD_SF_TEST
 	"\nsf test offset len		- run a very basic destructive test"
 #endif
diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index a9617c6c58..476d848321 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -134,6 +134,13 @@ config SPI_FLASH_BAR
 	  Bank/Extended address registers are used to access the flash
 	  which has size > 16MiB in 3-byte addressing.
 
+config SPI_FLASH_LOCK
+	bool "Enable the Locking feature"
+	default y
+	help
+	 Enable the SPI flash lock support. By default this is set to y.
+	 If you intend not to use the lock support you should say n here.
+
 config SPI_FLASH_UNLOCK_ALL
 	bool "Unlock the entire SPI flash on u-boot startup"
 	default y
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6093277f17..9c51f2b1b0 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1099,6 +1099,7 @@ static int spansion_erase_non_uniform(struct spi_nor *nor, u32 addr,
 }
 #endif
 
+#if defined(CONFIG_SPI_FLASH_LOCK)
 #if defined(CONFIG_SPI_FLASH_STMICRO) || defined(CONFIG_SPI_FLASH_SST)
 /* Write status register and ensure bits in mask match written values */
 static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
@@ -1386,6 +1387,7 @@ static int stm_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return stm_is_unlocked_sr(nor, ofs, len, status);
 }
 #endif /* CONFIG_SPI_FLASH_STMICRO */
+#endif
 
 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
@@ -1461,6 +1463,7 @@ read_err:
 	return ret;
 }
 
+#if defined(CONFIG_SPI_FLASH_LOCK)
 #ifdef CONFIG_SPI_FLASH_SST
 /*
  * sst26 flash series has its own block protection implementation:
@@ -1729,6 +1732,8 @@ sst_write_err:
 	return ret;
 }
 #endif
+#endif
+
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -4103,6 +4108,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	mtd->_read = spi_nor_read;
 	mtd->_write = spi_nor_write;
 
+#if defined(CONFIG_SPI_FLASH_LOCK)
 #if defined(CONFIG_SPI_FLASH_STMICRO) || defined(CONFIG_SPI_FLASH_SST)
 	/* NOR protection support for STmicro/Micron chips and similar */
 	if (JEDEC_MFR(info) == SNOR_MFR_ST ||
@@ -4126,7 +4132,7 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->flash_is_unlocked = sst26_is_unlocked;
 	}
 #endif
-
+#endif
 	if (info->flags & USE_FSR)
 		nor->flags |= SNOR_F_USE_FSR;
 	if (info->flags & SPI_NOR_HAS_TB)
-- 
2.17.1

