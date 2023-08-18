Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D3CC05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399B886C8C;
	Fri, 18 Aug 2023 06:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpLlyIyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0449786C89; Fri, 18 Aug 2023 06:22:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8535486C98
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ashok.reddy.soma@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtO+L6sie2lr5cS6iWsHTausBIXTGDKdY2lD3PY/2+0TtuslHaUCJaNq7tM303QrNpsQWhgyKYKRwu6C+LiGk7yXxiASJ60FLAkEcbcE/X/wdW/er1lghMk6fGc1Xc9rCO0ZDstvSAPw57pEjVuH4JI8Of1T3wWIXWAmmWbiFhRPgKXrngTIE3xvzmmdbd0EPNULS+feH4qva1FfGqbvEZWJ5K3/w0oMdqGUSbVU2aEI+Fu6CUr79MSF4RzbGMlO+knrA/Xojwng6fB3F6bolqZZEvppzysrncB9H6oa/Ue9cIIehFKGovOS7Gfun2YVHDSfbCx6+74okg16xJhOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9VZldeWgQ6f92UDc3cF5IJjOH4fIrPtot/rpxDAqUM=;
 b=UAfBkfGpxHnVuw7gCtXC2c1wVyuyCW3eXYwuYAyHZM8dnKKnMw6jrKXX2hZRrxjrlxBtDhGyuHZF3NSnKyt++97kFer3WUkBrz8r+XrR/j7t8ynHfepUWgvJsDDw5D2nBVI0jRR1Tz6SpnUX9o33Ci2HufXJw0P1Qv+qwR+hdQu9E+RSCpB+ZLM1k9qtffXBvRjfJQEP9b9YkCAdDz8vgELFq07YI7H2Dr2XaN7DiMURIdi/2KKVopaACjogUezGztbD/t5AmYli4NH+E5ObFbfm+wN03TE8cIC+Xe2s+Po6lyvjYxBKuViJDfFwC0T67mXEgIqn1o1w9lXtx49VEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9VZldeWgQ6f92UDc3cF5IJjOH4fIrPtot/rpxDAqUM=;
 b=wpLlyIyYcdkhofvqw+53WEs381YB2j1k1Qpd0vec/MiANMbGtxkeFToed00toIJo0m3ybai76kCmweI4PBaMH5A/F8JmHgcc4mW28S1ov0Zn443h/bTWe7p/MKIC98eyQwd2BYFSPB2yvfGXiLJF6k4uLCjcaeRpBrC+EfnrLr4=
Received: from SA9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:20::15)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 04:21:58 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::b7) by SA9PR03CA0010.outlook.office365.com
 (2603:10b6:806:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 04:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 04:21:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:21:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:21:57 -0500
Received: from xhdashokred41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 23:21:55 -0500
From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <sjg@chromium.org>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 4/7] mtd: spi-nor: Add parallel and stacked memories support
 in read_bar and write_bar
Date: Thu, 17 Aug 2023 22:21:16 -0600
Message-ID: <20230818042119.25722-5-ashok.reddy.soma@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3597f12c-b983-4a95-e6ae-08db9fa2a9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct7Z1Zzg0c1sQ/kHu2nABPPZnkMEAa0vPMonKlgL4rMDmGo+sAY59ZFgW4pDfuKgqBn0TS8t7kcomhGEL6YrHC7O+7ZxKUbc+lCFbvC3Se+G5FA4M8X6jC2F6FLNOtF6ONeVKkbA7x0CYTO/R1YWVhUQ3dCP/E+cyKbrvIV1Em9kSCFWoyM/GXYPldnBUAZhZaAJ2WfHvM1OZfeihhXSXoIHg7jNpjenL7+CwT4A14krM3o0GZL8+siU9QGCUIq6SqoUI5ErFHXFqrEsZFUUEJS0EMFRSoPffGS1HOnoK3RjmMjg4P4oCXrP+0HrS02h2+myCjiIJ7Wybqv4SNNkl9D5ZOAcG11Ix7rUoCJzfMmxW39fCuhmk7PjQHzos2v0pc5reWEf1qRuvs5dGvPe1fw5jNLncJWZthcMgtNhCcAAUHEYY4uinrByzMHr+BGj8c8FnrUBoKoTaztJkH8oIbpkgCSllilNHJ30NNLJeAJBGEuQTfCLZFjpaXfRnVhQyV4XZQHaxZYQwNqjQ7XJW3tDVh7cPrwJryUok4gYhDh3iCerRlooScZBpKxSaWE5BMjVXoAYXSd8PC+fS5O9cdGFlU66hfsMpbolZ4UZc4vdJkgixB/B5rm3OJZVOqyK+DPRxhaGvFwmgTLabJfHMBlU0zlJAsxLJqxmFt4rDvnBRCQg1THnD4r+ZDqZCu6hKv8/3sSeanx0ljKXT0YXbF5XB2FSFZo1SbJbHiRTWRUa7v9cuN+6nmZ3+arYcvs44e6rcG5VtALFf+PHA/0Mag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(26005)(86362001)(336012)(40480700001)(478600001)(426003)(6666004)(103116003)(2616005)(1076003)(36756003)(5660300002)(36860700001)(41300700001)(70586007)(82740400003)(356005)(54906003)(70206006)(81166007)(316002)(6916009)(4326008)(8936002)(8676002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:21:58.4703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3597f12c-b983-4a95-e6ae-08db9fa2a9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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

Add support for parallel memories and stacked memories configuration
in read_bar and write_bar functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---

 drivers/mtd/spi/spi-nor-core.c | 55 +++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index e733b180de..4d15a90c8f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -884,12 +884,32 @@ static int clean_bar(struct spi_nor *nor)
 
 static int write_bar(struct spi_nor *nor, u32 offset)
 {
-	u8 cmd, bank_sel;
+	u8 cmd, bank_sel, upage_curr;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	/* Wait until previous write command is finished */
+	if (spi_nor_wait_till_ready(nor))
+		return 1;
+
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED) &&
+	    mtd->size <= SZ_32M)
+		return 0;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
+
+	offset = offset % (u32)mtd->size;
+	bank_sel = offset >> 24;
 
-	bank_sel = offset / SZ_16M;
-	if (bank_sel == nor->bank_curr)
-		goto bar_end;
+	upage_curr = nor->spi->flags & SPI_XFER_U_PAGE;
+
+	if (!(nor->flags & SNOR_F_HAS_STACKED) && bank_sel == nor->bank_curr)
+		return 0;
+	else if (upage_curr == nor->upage_prev && bank_sel == nor->bank_curr)
+		return 0;
+	else
+		nor->upage_prev = upage_curr;
 
 	cmd = nor->bank_write_cmd;
 	write_enable(nor);
@@ -899,15 +919,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
 		return ret;
 	}
 
-bar_end:
 	nor->bank_curr = bank_sel;
-	return nor->bank_curr;
+
+	return write_disable(nor);
 }
 
 static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 {
 	u8 curr_bank = 0;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
 
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_SPANSION:
@@ -919,15 +943,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 		nor->bank_write_cmd = SPINOR_OP_WREAR;
 	}
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	ret = nor->read_reg(nor, nor->bank_read_cmd,
-				    &curr_bank, 1);
+			    &curr_bank, 1);
 	if (ret) {
 		debug("SF: fail to read bank addr register\n");
 		return ret;
 	}
 	nor->bank_curr = curr_bank;
 
-	return 0;
+	// Make sure both chips use the same BAR
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		write_enable(nor);
+		ret = nor->write_reg(nor, nor->bank_write_cmd, &curr_bank, 1);
+		if (ret)
+			return ret;
+
+		ret = write_disable(nor);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 #endif
 
-- 
2.17.1

