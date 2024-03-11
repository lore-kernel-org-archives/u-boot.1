Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1DDC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5740387F4F;
	Mon, 11 Mar 2024 18:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ueewX3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF0187F43; Mon, 11 Mar 2024 18:23:22 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EB587E6F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djTQRDmKuMu60aeY/WEu8sVu9jVsWqOLaOQLQw6nRFPlyM8VU382fG6W07YPzx2GI1QdhAnBNqxSkeeXQ25Z9YWNNp+9NdVm0RfUajruyK37wrgXC2VuxGGOQO5qrZMJSK0u6FvyttdQ7tjkEBlonvvJOteDH2B3axK6vjJr6tjpaIo2m2DG/SerYyqwUkyGwyp+D6xNtELvNTikrpt38kQhd2OPIBY1DWMmBYnXYqQCgv8rj+qcxtL9eyKZMAStGnhWpBqEckHQchLbS2wLRWFUvnBBhpN+Dn2dZ3GJBDF/VwwC6NaFVbGnGNJv+6PP/oGZr6DQLhR/GvrAqms8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdQMh9tesZoBZJAZ44e5653RMvQcz0lfyLLDYyMhvxQ=;
 b=Ci3jgL+bhH2w7wD03DG51gS9wYMykeNUSNhjyAbUggSFjRUeuxZiMnhgOPZ/1EaLGJaAt3cNXv5h+LjII/IyCS27sDejMBDyNmP/xBxUK5p9G8mgv4eoJ6h6YHiMEE1nI1waA86dCx6Ahaie7laaXyFx0y0mTZT48SBZ+B/Y/Iw6EMgvciV665hMuJHkMNKPi2WNu5n/47PmYp1e2pMu5nWGCiYKeALAucgCPtzJZVdoyI23oMFVjkTcOWUrNajMfdYuRdUXsOSgqnutinU1YM3tHr/OEaOuTm+bILRvmLUFuOmVZ2GdUsF7tb3hIIL1WBB7XDOtDMXVVttPZo3k0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdQMh9tesZoBZJAZ44e5653RMvQcz0lfyLLDYyMhvxQ=;
 b=4ueewX3dyjtpLbU/G3oeo16uqGlE7NjxgE6VVHN/aED1HZZSTx5hSRGzGwogTXc/fiF1f71zLZOJx+SqL0cgxE7AYsbUXIneDGiFO8MHZW1zVnALUkjC92kw8BpAKTBvYrQKbOZQi9fcGhLSgduQwD26RzVlT7n9+tP7YOU6fsM=
Received: from DM6PR07CA0103.namprd07.prod.outlook.com (2603:10b6:5:330::35)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:17 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::46) by DM6PR07CA0103.outlook.office365.com
 (2603:10b6:5:330::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:16 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:14 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 07/19] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Date: Mon, 11 Mar 2024 22:52:37 +0530
Message-ID: <0fec67801545a91ff9ee7238986a7ec51b730ced.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 102091d5-74d1-4250-d2df-08dc41eff0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFBpbPjJShYTISmsGiaGQU+bxg7PGhFCMDb6z6SOB+/cNXmXnLsxhoveq1hUc3DX1sBg5kU97PaX8FhZqBI3KBvoZ0K5t741tt6b17A1WPUWYm9tGhHR8lgiKo+HlBB2Ju6RwhqqZ8Vfc0eLfv+1Crn4wC8QsOsYOFvHao+fNnxZQfz32dRADP/J8NpbqR7WpdWEkrb5w0+DhZVESMCvmZMDsvpV+RQU7nlbojamFWHOWjpX9c7uhvpsn3xmGs+dln7ESDMNTCYtG69vjak1tS+EE34HS/lDjcGGyKvfAIXunP8qjCW4h/ZwdqYdxiSJoFXdbFSnPJ09pTm7HpCsg30bmg+facrslSbgNjZsxDk0XTTOUHG/LS80zbJKWffYDY89razyyhpoSsVYuSIWnHUWXRWagMV/4bhy6IWT7/rJ1ZLwgAGvWDF0shQwniKU1dahtB++xwKYm6OfEG8G9kGvLHkZyKx/7WxuMRaM/wyGYzUyo64GuP3GWw0QywjGrfo6U6/VsghSHQPMfSDdj4HVhbUBEot61JmEwXTOhiRk3MIKzS5H30flb66a++6c+vogYfd++SGPUSe0duuyhbb2UQ+Jnl1oH+gfqcIWv8smOxIId2YcaOAbJ9on72DrajDhmvrzavtTYIxkgkAT9xKxGad0E/fJuCUq0aFdYrDryMwyhTft+3Dy1trCbG8qJVK1arNAvLbkqm0acpdmL5Ist9KfBSlOICc83Su7oXqrk3Cg8aTOOnjkPBSsu9iP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:17.0161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102091d5-74d1-4250-d2df-08dc41eff0b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

Enable mt35xu512aba_fixups for all mt35 series flashes to work
in DTR mode, and return after nor->fixups is updated, otherwise
it will get overwritten with macronix_octal_fixups.
This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.

Additionally, a new flag, "SPI_XFER_SET_DDR," has been introduced
to instruct the Ospi controller driver to switch to DDR mode.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Co-developed-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
 drivers/spi/cadence_qspi.c     | 2 +-
 include/spi.h                  | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 5895b5de09..e8640cbf07 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3975,6 +3975,7 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	nor->spi->flags |= SPI_XFER_SET_DDR;
 	*buf = SPINOR_MT_OCT_DTR;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
@@ -4302,8 +4303,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g")) {
 		nor->fixups = &mt35xu512aba_fixups;
+		return;
+	}
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index dd6aef9ab5..d312bafd90 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -702,7 +702,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		break;
 	}
 
-	if (op->cmd.dtr)
+	if ((spi->flags & SPI_XFER_SET_DDR) && op->cmd.dtr)
 		err = cadence_spi_setup_ddrmode(spi, op);
 
 	return err;
diff --git a/include/spi.h b/include/spi.h
index ab51c8428b..ade30fab73 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -172,6 +172,7 @@ struct spi_slave {
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
+#define SPI_XFER_SET_DDR	BIT(6)
 	/*
 	 * Flag indicating that the spi-controller has multi chip select
 	 * capability and can assert/de-assert more than one chip select
-- 
2.27.0

