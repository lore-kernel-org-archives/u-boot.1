Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1272ECE7AF9
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 03:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7E586B95;
	Thu, 28 Sep 2023 05:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T2uxgKbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6DAF86E15; Thu, 28 Sep 2023 05:50:03 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8256786A24
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXwOTEG2E5VjEA1d4U1zU6r5aFg/D0H+9namS/0K/ai6iWv5QtokNQ1z4kz8++vrCrSrygrcfTjIVoFzGOg+cAZQLJsXtf+illmQ3JoWmvIgIqn8dNGDEgwWOt/c7/lLGpg5568gYAWYv48jwoBnK+C/EWOyQVflaBDsKElCPgHVyI0mqMSblfoltAt1vQ2l1U3jO4FI6jQ+N8Cv0pvUs0+9c1Dl4unnF6wgfj/RHbx5DGF+cUligvouDs/LhAiVuZ4xin39OylD4aZF0fRmiANTOXyXepHNin51vzWioRcRFCH7dHXRSnNQrDc88dKQd21VlwugrZmKy5ap1/D43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQVQ9J3UKk3AR/BNE3EpGEpwg22JRfoqSvd2yAcnH6Q=;
 b=Nf5L3KULeov0X5TTYQ+bRq07ZiWLjpPXTANu4qJKJwW5nfkTzBsdssBFlm85T/RHSSzh18VeoK0E7qpFPb8eT40LI+p9fddN5QO7R8qyXBcshIOGmBo7U6XPWtEU+PM8IBKnBS5JLSZHlML9P8Z3/dWOML8VzyPXlJMc197ahsXrhnaiAMyeQml1phmrm8u2NxRHPZHn0DtozuUemUnyUatuyfn38/zU2zaTy/a5y2so/KZ0UkkXR67OBRqfx6i5C9dTYQ83m/UShPaWDLMCZsqOjqi3Ym+RXVPSCQBtwMZ1VDgWMAAB0JnUwUFP0pyDyOQuH5NdRTIMuM8kNsjSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQVQ9J3UKk3AR/BNE3EpGEpwg22JRfoqSvd2yAcnH6Q=;
 b=T2uxgKbMmjg1NBj3Us+MDcw5NcuS01FAyjIVOK9zAr59mZsa354igjsNKQk4yHkuZrDTXJh4boVhrC3bqGX60ZTduoa7RQRHFvV2bzDnmv1shguSFEREj72mSXYHCd73US7N/I5yZUhBFgFYhlAEZ8kqlQ6lYi6w9HMgiEsBKnA=
Received: from SA1PR05CA0002.namprd05.prod.outlook.com (2603:10b6:806:2d2::8)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 28 Sep
 2023 03:49:57 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::fa) by SA1PR05CA0002.outlook.office365.com
 (2603:10b6:806:2d2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.12 via Frontend
 Transport; Thu, 28 Sep 2023 03:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Thu, 28 Sep 2023 03:49:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 22:49:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 20:49:55 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 22:49:53 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH 1/3] mtd: spi-nor: Add spi flash lock config option
Date: Thu, 28 Sep 2023 09:19:38 +0530
Message-ID: <20230928034940.2220-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230928034940.2220-1-venkatesh.abbarapu@amd.com>
References: <20230928034940.2220-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5d0f74-d1c2-4975-6a2a-08dbbfd5fb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ua5yQghf+rhFO1R/tQ5F45VgJww+5a7B+/5A6C1xxwJ5oFZubTw7tip/ejldn/yW/qP8A2Ke7IRhWDm1cTZEByIqfSMshhHLjcpgIUHVOyEPc7YIuTZ6PQhY41aQLW+NMsv4LyMgNaVf4QWJSNgMM1LvDPkoALvp4tOioLW4U27zOlGcCTTq2uJU1wC8uNbRtrLAARRb2Z9pJwreYmyLWAywpVvO4c4VrAlNT/c9f+fO/C3BBqC4sY/rFHGa5Q7VFnfxY3zqbnEiuHH0iAVpYNVdcvmlRx4bO/1yT2I6ZDOX893I//2YaNfYJ5JLRzoPor678V5O6jl6XSDdk8Cuh3WCg+0m39YZqr5Nbu5Ag1OEvL20PvRMQAqe25Xnl31m1uVfRXy+h6H5T+2IxYqkluziF0G+qCEZUrD4GmYIDl05CortXHnl7oDlOVnKnVq9noF1cbTeCiSdCK/QFLbJI862AxJ8fsLHM4sOcpEreLaXR1IJ09zcTm1/ANIAOetUrfDh9x25zp87jHSnGIRd+MBwFaF51zYUm7RLgz5DoFzEKibfsYARdQIZOEkH82zzhsOArlRqlUPHiHpwWnPSGGldhrzzvudxWcmfkwb6XHJdbi5FNPHd+iHYGN2CzMkC+J61rH2MGYdG/U2THT/fU6tD+9XMvo1xdRqU+e1urVFPLre80JRry7usQN6M4Q3EuSiX4YAENQ79wMRDVqIWyX0ROePF4tttgc3AiI5oxk77SjWVhKwjr202xPASyuHQ4lcto1xQvUJ8g1Bt7SipIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(2616005)(36860700001)(40460700003)(2906002)(47076005)(36756003)(86362001)(82740400003)(6666004)(40480700001)(81166007)(6916009)(4326008)(356005)(54906003)(41300700001)(1076003)(8936002)(478600001)(70206006)(83380400001)(26005)(316002)(426003)(336012)(70586007)(8676002)(107886003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:49:56.1673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5d0f74-d1c2-4975-6a2a-08dbbfd5fb02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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
of any flash chip which supports locking.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/Kconfig        | 7 +++++++
 drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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

